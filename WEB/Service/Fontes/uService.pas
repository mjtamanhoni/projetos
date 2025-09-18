unit uService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.Math,
  System.JSON, System.DateUtils, System.SyncObjs,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, Vcl.ExtCtrls,

  IniFiles,
  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Horse.CORS,
  Dataset.Serialize,
  RESTRequest4D,
  Dataset.Serialize.Config,
  uDM,
  uFuncoes.Gerais,

  uRota.Auth, uRota.Publica, uRota.Cadastro, uRota.Movimento,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TManutencaoThread = class(TThread)
  private
    FStopEvent: TEvent;

    procedure RealizarManutencaoClientes;
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

  TMJT_Controle = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean); // <-- aqui!

  private
    // Seus membros privados

  public
    function GetServiceController: TServiceController; override;

  published
    property OnStart;
    property OnExecute;
  end;
var
  MJT_Controle: TMJT_Controle;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MJT_Controle.Controller(CtrlCode);
end;

function TMJT_Controle.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMJT_Controle.ServiceExecute(Sender: TService);
var
  FIniFile :TIniFile;
  FileName, LogPath: string;
  FPorta:Integer;
  ManutencaoThread: TManutencaoThread;

begin
  try
    try
      FileName := ParamStr(0);
      LogPath := ExtractFilePath(FileName);
      FIniFile := TIniFile.Create(LogPath + 'MJT_Systems.ini');

      THorse.Use(Jhonson());
      THorse.Use(CORS);

      uRota.Publica.RegistrarRotas;
      //uRota.Cadastro.RegistrarRotas;
      //uRota.Movimento.RegistrarRotas;

      FPorta := 0;
      FPorta := FIniFile.ReadInteger('SERVER','PORTA',3106);

      THorse.Listen(FPorta,procedure(Horse:THorse)
      begin

      end);

      // Inicia a thread de manutenção
      {
      ManutencaoThread := TManutencaoThread.Create;
      }

      while not Self.Terminated do
      begin
        ServiceThread.ProcessRequests(True);
      end;

      // Finaliza a thread ao encerrar o serviço
      {
      ManutencaoThread.Terminate;
      ManutencaoThread.FStopEvent.SetEvent;
      ManutencaoThread.WaitFor;
      ManutencaoThread.Free;
      }

    except on E: Exception do
      TFuncoes.Salvar_Log(LogPath, C_NOME_LOG, 'Erro ao executar o Serviço:' + sLineBreak + E.Message,C_LINHA_ERRO);
    end;
  finally
  end;

end;

procedure TMJT_Controle.ServiceStart(Sender: TService; var Started: Boolean);
var
  VersionInfoSize, Handle: DWORD;
  VersionInfo: Pointer;
  FixedFileInfo: PVSFixedFileInfo;
  FileVersion: string;
  FileName, LogPath: string;
  FString: TStringList;
begin
  try
    // Caminho do executável
    FileName := ParamStr(0);

    // Recuperar versão
    VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Handle);
    if VersionInfoSize > 0 then
    begin
      GetMem(VersionInfo, VersionInfoSize);
      try
        if GetFileVersionInfo(PChar(FileName), Handle, VersionInfoSize, VersionInfo) then
        begin
          VerQueryValue(VersionInfo, '\', Pointer(FixedFileInfo), VersionInfoSize);
          FileVersion := Format('%d.%d.%d.%d',
            [HiWord(FixedFileInfo^.dwFileVersionMS),
             LoWord(FixedFileInfo^.dwFileVersionMS),
             HiWord(FixedFileInfo^.dwFileVersionLS),
             LoWord(FixedFileInfo^.dwFileVersionLS)]);
        end;
      finally
        FreeMem(VersionInfo);
      end;
    end;

    // Criar log na pasta Params[0]
    //LogPath := IncludeTrailingPathDelimiter(FileName) + 'LOG.LOG';
    LogPath := ExtractFilePath(FileName);

    FString := TStringList.Create;
    try
      FString.Add('');
      FString.Add('-------------------------------------------------------------------------------------------------------------');
      FString.Add('SERVIÇO MJT-SYSTEMS');
      FString.Add('Serviço iniciado.');
      FString.Add('Versão: ' + FileVersion);
      FString.Add('Data/Hora: ' + DateTimeToStr(Now));
      FString.Add('-------------------------------------------------------------------------------------------------------------');
      FString.Add('');
      TFuncoes.Salvar_Log(LogPath, C_NOME_LOG, FString.Text,0);
    finally
      FString.Free;
    end;

    Started := True;


  except
    on E: Exception do
      TFuncoes.Salvar_Log(LogPath, C_NOME_LOG, 'Erro ao iniciar o Serviço: ' + sLineBreak + E.Message,0);
  end;
end;

{ TManutencaoThread }

constructor TManutencaoThread.Create;
begin

end;

procedure TManutencaoThread.Execute;
begin
  inherited;

end;

procedure TManutencaoThread.RealizarManutencaoClientes;
begin

end;

end.
