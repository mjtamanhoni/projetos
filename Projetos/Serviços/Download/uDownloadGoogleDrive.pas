unit uDownloadGoogleDrive;

interface

uses
  System.SysUtils, System.Classes, IdHTTP, IdSSLOpenSSL, IdCookie, IdCookieManager,
  uDownloadCore;

type
  TGoogleDriveDownloader = class(TDownloadBase)
  public
    function IsGoogleDriveURL(const URL: string): Boolean;
    function BaixarArquivo(const URL, Destino, LogPath: string): Boolean; override;
  end;

implementation

function TGoogleDriveDownloader.IsGoogleDriveURL(const URL: string): Boolean;
begin
  Result := (Pos('drive.google.com', URL) > 0) or (Pos('docs.google.com', URL) > 0);
end;

function TGoogleDriveDownloader.BaixarArquivo(const URL, Destino, LogPath: string): Boolean;
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FS: TFileStream;
  Msg, FileID, ResponseText, DownloadURL: string;
  CookieManager: TIdCookieManager;
  Response: TStringStream;
  StartPos, EndPos: Integer;
  ConfirmPos: Integer;
  ConfirmToken: string;
begin
  Result := False;
  GravarLog(Format('[%s] Iniciando download do Google Drive: %s', [DateTimeToStr(Now), URL]), LogPath);
  
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  CookieManager := TIdCookieManager.Create(nil);
  Response := TStringStream.Create('', TEncoding.UTF8);
  
  try
    // Extrair o ID do arquivo da URL
    FileID := '';
    StartPos := Pos('id=', URL);
    if StartPos > 0 then
    begin
      StartPos := StartPos + 3;
      EndPos := Pos('&', Copy(URL, StartPos, Length(URL)));
      if EndPos = 0 then
        EndPos := Length(URL) + 1 - StartPos;
      FileID := Copy(URL, StartPos, EndPos - 1);
    end;
    
    // Se não encontrou pelo formato id=, tentar outro formato comum
    if FileID = '' then
    begin
      StartPos := Pos('/d/', URL);
      if StartPos > 0 then
      begin
        StartPos := StartPos + 3;
        EndPos := Pos('/', Copy(URL, StartPos, Length(URL)));
        if EndPos = 0 then
          EndPos := Length(URL) + 1 - StartPos;
        FileID := Copy(URL, StartPos, EndPos - 1);
      end;
    end;
    
    // Se ainda não encontrou, tentar outro formato
    if FileID = '' then
    begin
      StartPos := Pos('/file/d/', URL);
      if StartPos > 0 then
      begin
        StartPos := StartPos + 8;
        EndPos := Pos('/', Copy(URL, StartPos, Length(URL)));
        if EndPos = 0 then
          EndPos := Length(URL) + 1 - StartPos;
        FileID := Copy(URL, StartPos, EndPos - 1);
      end;
    end;
    
    if FileID = '' then
    begin
      Msg := Format('[%s] ERRO: Não foi possível extrair o ID do arquivo da URL: %s', [DateTimeToStr(Now), URL]);
      GravarLog(Msg, LogPath);
      Result := False;
      Exit;
    end;
    
    GravarLog(Format('[%s] ID do arquivo extraído: %s', [DateTimeToStr(Now), FileID]), LogPath);
    
    // Configurar HTTP
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;
    HTTP.AllowCookies := True;
    HTTP.CookieManager := CookieManager;
    HTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmClient;
    
    // Primeiro acesso para obter cookies e token de confirmação
    DownloadURL := 'https://drive.google.com/uc?export=download&id=' + FileID;
    GravarLog(Format('[%s] Acessando URL inicial: %s', [DateTimeToStr(Now), DownloadURL]), LogPath);
    
    HTTP.Get(DownloadURL, Response);
    ResponseText := Response.DataString;
    
    // Verificar se é necessário confirmar o download (arquivo grande)
    ConfirmToken := '';
    ConfirmPos := Pos('confirm=', ResponseText);
    if ConfirmPos > 0 then
    begin
      // Extrair o token de confirmação
      StartPos := ConfirmPos + 8; // tamanho de 'confirm='
      EndPos := Pos('&', Copy(ResponseText, StartPos, 100));
      if EndPos = 0 then
        EndPos := Pos('"', Copy(ResponseText, StartPos, 100));
      if EndPos = 0 then
        EndPos := 100;
      
      ConfirmToken := Copy(ResponseText, StartPos, EndPos - 1);
      GravarLog(Format('[%s] Token de confirmação encontrado: %s', [DateTimeToStr(Now), ConfirmToken]), LogPath);
      
      // Limpar o stream para reutilização
      Response.Clear;
      
      // URL com token de confirmação
      DownloadURL := 'https://drive.google.com/uc?export=download&confirm=' + ConfirmToken + '&id=' + FileID;
    end;
    
    GravarLog(Format('[%s] URL final de download: %s', [DateTimeToStr(Now), DownloadURL]), LogPath);
    
    // Criar o arquivo de destino
    try
      ForceDirectories(ExtractFilePath(Destino));
      FS := TFileStream.Create(Destino, fmCreate);
      try
        // Download com a URL correta
        HTTP.Get(DownloadURL, FS);
        Msg := Format('[%s] Download concluído: %s → %s', [DateTimeToStr(Now), URL, Destino]);
        GravarLog(Msg, LogPath);
        Result := True;
      finally
        FS.Free;
      end;
    except
      on E: Exception do
      begin
        Msg := Format('[%s] ERRO ao criar arquivo de destino: %s | %s', [DateTimeToStr(Now), Destino, E.Message]);
        GravarLog(Msg, LogPath);
        Result := False;
      end;
    end;
  except
    on E: Exception do
    begin
      Msg := Format('[%s] ERRO: %s → %s | %s', [DateTimeToStr(Now), URL, Destino, E.Message]);
      GravarLog(Msg, LogPath);
      Result := False;
    end;
  end;
  
  // Liberar recursos
  Response.Free;
  CookieManager.Free;
  SSL.Free;
  HTTP.Free;
end;

end.