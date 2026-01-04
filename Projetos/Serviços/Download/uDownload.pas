unit uDownload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.SvcMgr, Vcl.Dialogs, IniFiles, IdHTTP, IdSSLOpenSSL, IdCookie, IdCookieManager,
  uDownloadManager; // ADICIONADO: referência ao gerenciador de downloads
  uDownloadCore, uDownloadGoogleDrive, uDownloadMediaFire, uDownloadOneDrive;

type
  TThreadMonitorComandos = class(TThread)
  private
    FStopEvent: TEvent;

    FGoogleDriveDownloader: TGoogleDriveDownloader;
    FMediaFireDownloader: TMediaFireDownloader;
    FOneDriveDownloader: TOneDriveDownloader;
    FDefaultDownloader: TDownloadBase;
    FLogPath: string;

    procedure AtualizarStatus(const Msg: string);
    function ValidarCampos: Boolean;
    function BaixarArquivo(Downloader: TDownloadBase; const URL, Destino, LogPath: string): Boolean;

    function BaixarArquivoComLog(const URL, Destino, LogPath: string): Boolean;
    function BaixarArquivoGoogleDrive(const URL, Destino, LogPath: string): Boolean;
    function BaixarArquivoMediaFire(const URL, Destino, LogPath: string): Boolean;
    function IsGoogleDriveURL(const URL: string): Boolean;
    function IsMediaFireURL(const URL: string): Boolean;
    procedure GravarLog(const Msg, LogPath: string);
    FDownloadManager: TDownloadManager; // ADICIONADO: manter instância do gerenciador
  protected
    procedure Execute; override;
    procedure MonitorarComandos;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TAdaptaDownload = class(TService)
    procedure ServiceExecute(Sender: TService);
  private
    FMonitorThread: TThreadMonitorComandos; // ADICIONADO: referência persistente da thread
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  AdaptaDownload: TAdaptaDownload;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  AdaptaDownload.Controller(CtrlCode);
end;

function TAdaptaDownload.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

{ TThreadMonitorComandos }
procedure TThreadMonitorComandos.AtualizarStatus(const Msg: string);
begin
  //Gravar informações no log...
end;

function TThreadMonitorComandos.BaixarArquivo(Downloader: TDownloadBase; const URL, Destino, LogPath: string): Boolean;
begin
  try
    if Trim(URL) = '' then
      raise Exception.Create('URL não informada');
    if Trim(Destino) = '' then
      raise Exception.Create('Pasta destino não informada');
    if Trim(LogPath) = '' then
      raise Exception.Create('Pasta log não informada');

    Downloader.LogArquivo('Iniciando download: '+ URL + ' ' + Destino + sLineBreak + 'Log: ' + LogPath, LogPath);

    // Garantir que o diretório de destino existe
    ForceDirectories(ExtractFilePath(Destino));

    Downloader.LogArquivo('Baixando arquivo...', LogPath);
    Result := Downloader.BaixarArquivo(URL, Destino, LogPath);

    if Result then
    begin
      Downloader.LogArquivo('Download concluído com sucesso!', LogPath);
    end
    else
    begin
      Downloader.LogArquivo('Falha no download. Verifique o log.', LogPath);
    end;
  except
    on E: Exception do
    begin
      Downloader.LogArquivo('Erro: ' + E.Message, LogPath);
      Result := False;
    end;
  end;
end;

function TThreadMonitorComandos.BaixarArquivoComLog(const URL, Destino, LogPath: string): Boolean;
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FS: TFileStream;
  Log: TStringList;
  Msg: string;
begin
  Result := False;
  Log := TStringList.Create;
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmClient;

    try
      FS := TFileStream.Create(Destino, fmCreate);
      try
        HTTP.Get(URL, FS);
        Msg := Format('[%s] Download concluído: %s → %s', [DateTimeToStr(Now), URL, Destino]);
        Result := True;
      finally
        FS.Free;
      end;
    except
      on E: Exception do
        Msg := Format('[%s] ERRO: %s → %s | %s', [DateTimeToStr(Now), URL, Destino, E.Message]);
    end;
  finally
    if FileExists(LogPath) then
      Log.LoadFromFile(LogPath);
    Log.Add(Msg);
    Log.SaveToFile(LogPath);

    SSL.Free;
    HTTP.Free;
    Log.Free;
  end;
end;

procedure TThreadMonitorComandos.GravarLog(const Msg, LogPath: string);
var
  Log: TStringList;
  LogDir: string;
begin
  // ... existing code ...
  try
    // Garantir que o diretório de log existe
    LogDir := ExtractFilePath(LogPath);
    if not DirectoryExists(LogDir) then
      ForceDirectories(LogDir);
      
    Log := TStringList.Create;
    try
      if FileExists(LogPath) then
        Log.LoadFromFile(LogPath);
      Log.Add(Msg);
      Log.SaveToFile(LogPath, TEncoding.UTF8); // FORÇAR UTF-8
    finally
      Log.Free;
    end;
  except
    on E: Exception do
    begin
      // Tentar gravar em um local alternativo se falhar
      try
        Log := TStringList.Create;
        try
          Log.Add(Format('[%s] ERRO AO GRAVAR LOG: %s | %s', [DateTimeToStr(Now), Msg, E.Message]));
          Log.SaveToFile('C:\Windows\Temp\adapta_download_error.log', TEncoding.UTF8); // FORÇAR UTF-8 no backup
        finally
          Log.Free;
        end;
      except
        // Ignorar erros de log de backup
      end;
    end;
  end;
end;

constructor TThreadMonitorComandos.Create;
begin
  inherited Create(False); // inicia automaticamente
  FreeOnTerminate := False; // ALTERADO: manter controle da thread, não liberar automaticamente
  FDownloadManager := TDownloadManager.Create('C:\cone\Adapta\ARQ\log_download.txt');
end;

procedure TThreadMonitorComandos.Execute;
begin
  inherited;
  try
    while not Terminated do
    begin
      MonitorarComandos;

      if FStopEvent.WaitFor(5000) = wrSignaled then
        Break;
    end;
  finally
  end;

end;

procedure TThreadMonitorComandos.MonitorarComandos;
var
  CmdPath: string;
begin
  // Primeiro tenta na pasta C:
  CmdPath := 'C:\cone\Adapta\cfg\Download.ini';
  if not FileExists(CmdPath) then
  begin
    // Se não existir, tenta na pasta E:
    CmdPath := 'E:\Cone\Adapta\cfg\Download.ini';
  end;

  // Se ainda assim não existe, apenas retorna (thread continua viva e checa novamente no próximo ciclo)
  if not FileExists(CmdPath) then
  begin
    GravarLog(Format('[%s] Download.ini não encontrado em C: ou E:. Aguardando...', [DateTimeToStr(Now)]),
              'C:\cone\Adapta\ARQ\log_download.txt');
    Exit;
  end;

  // Processar o arquivo INI se existir
  FDownloadManager.ProcessarArquivoINI(CmdPath);
end;

procedure TAdaptaDownload.ServiceExecute(Sender: TService);
begin
  // Criar a thread monitor e manter referência no serviço
  if FMonitorThread = nil then
    FMonitorThread := TThreadMonitorComandos.Create;

  // Loop principal do serviço
  while not Terminated do
  begin
    ServiceThread.ProcessRequests(True);
    Sleep(1000);
    // Se por algum motivo a thread terminou, recria
    if (FMonitorThread <> nil) and (FMonitorThread.Finished) then
    begin
      FMonitorThread.Free;
      FMonitorThread := TThreadMonitorComandos.Create;
    end;
  end;

  // Quando o serviço for terminado, encerrar a thread
  if FMonitorThread <> nil then
  begin
    FMonitorThread.Terminate;
    FMonitorThread.WaitFor;
    FMonitorThread.Free;
    FMonitorThread := nil;
  end;
end;

end.
