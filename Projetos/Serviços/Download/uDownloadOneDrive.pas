unit uDownloadOneDrive;

interface

uses
  System.SysUtils, System.Classes, IdHTTP, IdSSLOpenSSL, IdCookie, IdCookieManager,
  uDownloadCore;

type
  TOneDriveDownloader = class(TDownloadBase)
  public
    function IsOneDriveURL(const URL: string): Boolean;
    function BaixarArquivo(const URL, Destino, LogPath: string): Boolean; override;
  end;

implementation

function TOneDriveDownloader.IsOneDriveURL(const URL: string): Boolean;
begin
  Result := (Pos('onedrive.live.com', URL) > 0) or 
            (Pos('1drv.ms', URL) > 0) or
            (Pos('sharepoint.com', URL) > 0);
end;

function TOneDriveDownloader.BaixarArquivo(const URL, Destino, LogPath: string): Boolean;
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FS: TFileStream;
  Msg, ResponseText, DirectDownloadURL: string;
  Response: TStringStream;
  RedirectURL: string;
begin
  Result := False;
  GravarLog(Format('[%s] Iniciando download do OneDrive: %s', [DateTimeToStr(Now), URL]), LogPath);
  
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Response := TStringStream.Create('', TEncoding.UTF8);
  
  try
    // Configurar HTTP
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;
    HTTP.AllowCookies := True;
    HTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmClient;
    
    // Para links curtos do OneDrive (1drv.ms), precisamos seguir o redirecionamento
    if Pos('1drv.ms', URL) > 0 then
    begin
      GravarLog(Format('[%s] Detectado link curto do OneDrive, seguindo redirecionamento...', [DateTimeToStr(Now)]), LogPath);
      
      // Desabilitar redirecionamento automático para capturar a URL de redirecionamento
      HTTP.HandleRedirects := False;
      
      try
        HTTP.Head(URL);
      except
        // Ignorar exceção, pois esperamos um código 302 (redirecionamento)
      end;
      
      RedirectURL := HTTP.Response.Location;
      
      if RedirectURL <> '' then
      begin
        GravarLog(Format('[%s] URL após redirecionamento: %s', [DateTimeToStr(Now), RedirectURL]), LogPath);
        // Reativar redirecionamento automático
        HTTP.HandleRedirects := True;
      end
      else
      begin
        Msg := Format('[%s] ERRO: Não foi possível obter o redirecionamento do link curto: %s', [DateTimeToStr(Now), URL]);
        GravarLog(Msg, LogPath);
        Result := False;
        Exit;
      end;
    end
    else
    begin
      RedirectURL := URL;
    end;
    
    // Modificar a URL para obter o link direto de download
    // Para OneDrive pessoal, substituir "view.aspx" por "download.aspx"
    if Pos('view.aspx', RedirectURL) > 0 then
    begin
      DirectDownloadURL := StringReplace(RedirectURL, 'view.aspx', 'download.aspx', [rfReplaceAll]);
      GravarLog(Format('[%s] URL modificada para download direto: %s', [DateTimeToStr(Now), DirectDownloadURL]), LogPath);
    end
    // Para SharePoint/OneDrive for Business
    else if Pos('sharepoint.com', RedirectURL) > 0 then
    begin
      // Tentar obter a página e extrair o link de download
      HTTP.Get(RedirectURL, Response);
      ResponseText := Response.DataString;
      
      var DownloadPos := Pos('"download"', ResponseText);
      if DownloadPos > 0 then
      begin
        var UrlStartPos := PosEx('"url"', ResponseText, DownloadPos);
        if UrlStartPos > 0 then
        begin
          UrlStartPos := PosEx('"', ResponseText, UrlStartPos + 5) + 1;
          var UrlEndPos := PosEx('"', ResponseText, UrlStartPos);
          if UrlEndPos > UrlStartPos then
          begin
            DirectDownloadURL := Copy(ResponseText, UrlStartPos, UrlEndPos - UrlStartPos);
            // Decodificar caracteres de escape JSON
            DirectDownloadURL := StringReplace(DirectDownloadURL, '\/', '/', [rfReplaceAll]);
            GravarLog(Format('[%s] URL de download extraída: %s', [DateTimeToStr(Now), DirectDownloadURL]), LogPath);
          end;
        end;
      end;
      
      if DirectDownloadURL = '' then
      begin
        Msg := Format('[%s] ERRO: Não foi possível extrair o link direto de download do SharePoint: %s', [DateTimeToStr(Now), RedirectURL]);
        GravarLog(Msg, LogPath);
        Result := False;
        Exit;
      end;
    end
    else
    begin
      // Para outros formatos de URL do OneDrive, tentar adicionar parâmetro de download
      if Pos('?', RedirectURL) > 0 then
        DirectDownloadURL := RedirectURL + '&download=1'
      else
        DirectDownloadURL := RedirectURL + '?download=1';
        
      GravarLog(Format('[%s] URL com parâmetro de download: %s', [DateTimeToStr(Now), DirectDownloadURL]), LogPath);
    end;
    
    // Limpar o stream para reutilização
    Response.Clear;
    
    // Criar o arquivo de destino
    try
      ForceDirectories(ExtractFilePath(Destino));
      FS := TFileStream.Create(Destino, fmCreate);
      try
        // Download com a URL direta
        HTTP.Get(DirectDownloadURL, FS);
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
  SSL.Free;
  HTTP.Free;
end;

end.