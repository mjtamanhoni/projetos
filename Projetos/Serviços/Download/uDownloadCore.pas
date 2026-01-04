unit uDownloadCore;

interface

uses
  System.SysUtils, System.Classes, IniFiles, IdHTTP, IdSSLOpenSSL, IdCookie, IdCookieManager;

type
  TDownloadBase = class
  protected
    function GravarLog(const Msg, LogPath: string): Boolean;
  public
    function BaixarArquivo(const URL, Destino, LogPath: string): Boolean; virtual;
  end;

implementation

function TDownloadBase.GravarLog(const Msg, LogPath: string): Boolean;
var
  Log: TStringList;
  LogDir: string;
begin
  Result := False;
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
      Log.SaveToFile(LogPath);
      Result := True;
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
          Log.SaveToFile('C:\Windows\Temp\adapta_download_error.log');
        finally
          Log.Free;
        end;
      except
        // Ignorar erros de log de backup
      end;
    end;
  end;
end;

function TDownloadBase.BaixarArquivo(const URL, Destino, LogPath: string): Boolean;
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FS: TFileStream;
  Msg: string;
begin
  Result := False;
  GravarLog(Format('[%s] Iniciando download padrão: %s', [DateTimeToStr(Now), URL]), LogPath);
  
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmClient;

    try
      // Garantir que o diretório de destino existe
      ForceDirectories(ExtractFilePath(Destino));

      // Se o arquivo já existe, tentar deletar para garantir substituição
      if FileExists(Destino) then
      begin
        try
          DeleteFile(Destino);
          GravarLog(Format('[%s] Arquivo existente removido para substituição: %s', [DateTimeToStr(Now), Destino]), LogPath);
        except
          on E: Exception do
          begin
            GravarLog(Format('[%s] ERRO ao remover arquivo existente: %s | %s', [DateTimeToStr(Now), Destino, E.Message]), LogPath);
            // seguir com fmCreate pode falhar se o arquivo estiver bloqueado
          end;
        end;
      end;

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
    GravarLog(Msg, LogPath);
    SSL.Free;
    HTTP.Free;
  end;
end;

end.