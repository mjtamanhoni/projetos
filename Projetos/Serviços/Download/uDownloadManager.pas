unit uDownloadManager;

interface

uses
  System.SysUtils, System.Classes, IniFiles,
  uDownloadCore, uDownloadGoogleDrive, uDownloadMediaFire, uDownloadOneDrive;

type
  TDownloadManager = class
  private
    FGoogleDriveDownloader: TGoogleDriveDownloader;
    FMediaFireDownloader: TMediaFireDownloader;
    FOneDriveDownloader: TOneDriveDownloader;
    FDefaultDownloader: TDownloadBase;
    FLogPath: string;
  public
    constructor Create(const LogPath: string);
    destructor Destroy; override;
    function BaixarArquivo(const URL, Destino: string): Boolean;
    function ProcessarArquivoINI(const IniPath: string): Boolean;
  end;

implementation

constructor TDownloadManager.Create(const LogPath: string);
begin
  inherited Create;
  FLogPath := LogPath;
  FGoogleDriveDownloader := TGoogleDriveDownloader.Create;
  FMediaFireDownloader := TMediaFireDownloader.Create;
  FOneDriveDownloader := TOneDriveDownloader.Create;
  FDefaultDownloader := TDownloadBase.Create;
end;

destructor TDownloadManager.Destroy;
begin
  FGoogleDriveDownloader.Free;
  FMediaFireDownloader.Free;
  FOneDriveDownloader.Free;
  FDefaultDownloader.Free;
  inherited;
end;

function TDownloadManager.BaixarArquivo(const URL, Destino: string): Boolean;
begin
  Result := False;
  
  // Verificar qual downloader usar com base na URL
  if FGoogleDriveDownloader.IsGoogleDriveURL(URL) then
    Result := FGoogleDriveDownloader.BaixarArquivo(URL, Destino, FLogPath)
  else if FMediaFireDownloader.IsMediaFireURL(URL) then
    Result := FMediaFireDownloader.BaixarArquivo(URL, Destino, FLogPath)
  else if FOneDriveDownloader.IsOneDriveURL(URL) then
    Result := FOneDriveDownloader.BaixarArquivo(URL, Destino, FLogPath)
  else
    Result := FDefaultDownloader.BaixarArquivo(URL, Destino, FLogPath);
end;

function TDownloadManager.ProcessarArquivoINI(const IniPath: string): Boolean;
var
  INI: TIniFile;
  URL, Destino: string;
begin
  Result := False;
  
  if not FileExists(IniPath) then
    Exit;
    
  try
    INI := TIniFile.Create(IniPath);
    try
      URL := INI.ReadString('Download', 'URL', '');
      Destino := INI.ReadString('Download', 'Destino', '');

      if (URL <> '') and (Destino <> '') then
      begin
        Result := BaixarArquivo(URL, Destino);
        if Result then
          DeleteFile(IniPath);
      end;
    finally
      INI.Free;
    end;
  except
    Result := False;
  end;
end;

end.