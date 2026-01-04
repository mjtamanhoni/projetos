unit uDownloadMediaFire;

interface

uses
  System.SysUtils, System.Classes, IdHTTP, IdSSLOpenSSL, IdCookie, IdCookieManager,
  uDownloadCore;

type
  TMediaFireDownloader = class(TDownloadBase)
  public
    function IsMediaFireURL(const URL: string): Boolean;
    function BaixarArquivo(const URL, Destino, LogPath: string): Boolean; override;
  end;

implementation

function TMediaFireDownloader.IsMediaFireURL(const URL: string): Boolean;
begin
  Result := (Pos('mediafire.com', URL) > 0);
end;

function TMediaFireDownloader.BaixarArquivo(const URL, Destino, LogPath: string): Boolean;
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FS: TFileStream;
  Msg, ResponseText, DirectDownloadURL, DebugHtmlPath: string;
  Response: TStringStream;
  StartPos, EndPos, SearchPos: Integer;
  DownloadButtonPos: Integer;
begin
  Result := False;
  GravarLog(Format('[%s] Iniciando download do MediaFire: %s', [DateTimeToStr(Now), URL]), LogPath);
  
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Response := TStringStream.Create('', TEncoding.UTF8);
  
  try
    // Configurar HTTP
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;
    HTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmClient;
    
    // Obter a página do MediaFire para extrair o link direto de download
    GravarLog(Format('[%s] Acessando página do MediaFire: %s', [DateTimeToStr(Now), URL]), LogPath);
    HTTP.Get(URL, Response);
    ResponseText := Response.DataString;
    
    // Salvar o HTML para debug
    DebugHtmlPath := ChangeFileExt(LogPath, '.html');
    try
      ForceDirectories(ExtractFilePath(DebugHtmlPath));
      with TStringList.Create do
      try
        Text := ResponseText;
        SaveToFile(DebugHtmlPath);
        GravarLog(Format('[%s] HTML salvo para debug em: %s', [DateTimeToStr(Now), DebugHtmlPath]), LogPath);
      finally
        Free;
      end;
    except
      on E: Exception do
        GravarLog(Format('[%s] ERRO ao salvar HTML para debug: %s', [DateTimeToStr(Now), E.Message]), LogPath);
    end;
    
    // Método 1 - procurar por "download_link"
    DirectDownloadURL := '';
    StartPos := Pos('download_link', ResponseText);
    if StartPos > 0 then
    begin
      GravarLog('[Método 1] Encontrou "download_link" na posição ' + IntToStr(StartPos), LogPath);
      SearchPos := StartPos;
      StartPos := Pos('href="', Copy(ResponseText, SearchPos, 500));
      if StartPos > 0 then
      begin
        StartPos := SearchPos + StartPos + 5; // ajuste para posição absoluta + tamanho de 'href="'
        EndPos := Pos('"', Copy(ResponseText, StartPos, 500));
        if EndPos > 0 then
        begin
          DirectDownloadURL := Copy(ResponseText, StartPos, EndPos - 1);
          GravarLog('[Método 1] URL encontrada: ' + DirectDownloadURL, LogPath);
        end;
      end;
    end;
    
    // Método 2 - procurar por "download_button"
    if DirectDownloadURL = '' then
    begin
      DownloadButtonPos := Pos('download_button', ResponseText);
      if DownloadButtonPos > 0 then
      begin
        GravarLog('[Método 2] Encontrou "download_button" na posição ' + IntToStr(DownloadButtonPos), LogPath);
        SearchPos := DownloadButtonPos;
        StartPos := Pos('href="', Copy(ResponseText, SearchPos, 500));
        if StartPos > 0 then
        begin
          StartPos := SearchPos + StartPos + 5; // ajuste para posição absoluta
          EndPos := Pos('"', Copy(ResponseText, StartPos, 500));
          if EndPos > 0 then
          begin
            DirectDownloadURL := Copy(ResponseText, StartPos, EndPos - 1);
            GravarLog('[Método 2] URL encontrada: ' + DirectDownloadURL, LogPath);
          end;
        end;
      end;
    end;
    
    // Método 3 - procurar por "downloadButton"
    if DirectDownloadURL = '' then
    begin
      DownloadButtonPos := Pos('downloadButton', ResponseText);
      if DownloadButtonPos > 0 then
      begin
        GravarLog('[Método 3] Encontrou "downloadButton" na posição ' + IntToStr(DownloadButtonPos), LogPath);
        SearchPos := DownloadButtonPos;
        StartPos := Pos('href="', Copy(ResponseText, SearchPos, 500));
        if StartPos > 0 then
        begin
          StartPos := SearchPos + StartPos + 5; // ajuste para posição absoluta
          EndPos := Pos('"', Copy(ResponseText, StartPos, 500));
          if EndPos > 0 then
          begin
            DirectDownloadURL := Copy(ResponseText, StartPos, EndPos - 1);
            GravarLog('[Método 3] URL encontrada: ' + DirectDownloadURL, LogPath);
          end;
        end;
      end;
    end;
    
    // Método 4 - procurar por "input" com valor de URL
    if DirectDownloadURL = '' then
    begin
      GravarLog('[Método 4] Procurando por tags input com URLs', LogPath);
      StartPos := Pos('<input', ResponseText);
      while (StartPos > 0) and (DirectDownloadURL = '') do
      begin
        SearchPos := StartPos;
        EndPos := Pos('>', Copy(ResponseText, SearchPos, 500));
        if EndPos > 0 then
        begin
          // Verificar se este input contém um valor que parece uma URL
          var InputTag := Copy(ResponseText, SearchPos, EndPos);
          if (Pos('value="http', InputTag) > 0) then
          begin
            StartPos := Pos('value="', InputTag);
            if StartPos > 0 then
            begin
              StartPos := StartPos + 7; // tamanho de 'value="'
              EndPos := Pos('"', Copy(InputTag, StartPos, Length(InputTag)));
              if EndPos > 0 then
              begin
                var PotentialURL := Copy(InputTag, StartPos, EndPos - 1);
                if (Pos('http', PotentialURL) = 1) then
                begin
                  DirectDownloadURL := PotentialURL;
                  GravarLog('[Método 4] URL encontrada em input: ' + DirectDownloadURL, LogPath);
                end;
              end;
            end;
          end;
        end;
        
        // Procurar próximo input
        StartPos := Pos('<input', Copy(ResponseText, SearchPos + 1, Length(ResponseText)));
        if StartPos > 0 then
          StartPos := SearchPos + StartPos;
      end;
    end;
    
    // Método 5 - procurar por qualquer link que contenha "download"
    if DirectDownloadURL = '' then
    begin
      GravarLog('[Método 5] Procurando por links com "download"', LogPath);
      StartPos := 1;
      while StartPos > 0 do
      begin
        StartPos := Pos('href="', Copy(ResponseText, StartPos, Length(ResponseText)));
        if StartPos > 0 then
        begin
          var FullStartPos := StartPos;
          StartPos := StartPos + 6; // tamanho de 'href="'
          EndPos := Pos('"', Copy(ResponseText, StartPos, 500));
          if EndPos > 0 then
          begin
            var LinkURL := Copy(ResponseText, StartPos, EndPos - 1);
            if (Pos('download', LinkURL) > 0) or (Pos('dl=', LinkURL) > 0) then
            begin
              DirectDownloadURL := LinkURL;
              GravarLog('[Método 5] URL de download encontrada: ' + DirectDownloadURL, LogPath);
              Break;
            end;
          end;
          StartPos := FullStartPos + 1;
        end;
      end;
    end;
    
    if DirectDownloadURL = '' then
    begin
      Msg := Format('[%s] ERRO: Não foi possível extrair o link direto de download do MediaFire: %s', [DateTimeToStr(Now), URL]);
      GravarLog(Msg, LogPath);
      Result := False;
      Exit;
    end;
    
    GravarLog(Format('[%s] Link direto encontrado: %s', [DateTimeToStr(Now), DirectDownloadURL]), LogPath);
    
    // Se o link não começar com http, adicionar o domínio
    if (Pos('http://', DirectDownloadURL) = 0) and (Pos('https://', DirectDownloadURL) = 0) then
      DirectDownloadURL := 'https://www.mediafire.com' + DirectDownloadURL;
    
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