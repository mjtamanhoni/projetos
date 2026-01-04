unit uAPI_Servico;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DaemonApp;

type
  TDaemon1 = class(TDaemon)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleStart(Sender: TDaemon; var OK: Boolean);
    procedure DataModuleStop(Sender: TDaemon; var OK: Boolean);
  private
    FLogFile: string;
    FRunning: Boolean;
    FThread: TThread;
  private
    procedure Log(const Msg: string);
    procedure ExecuteThread;
  public
  end;

var
  Daemon1: TDaemon1;

implementation

{$R *.lfm}

type
  TServiceThread = class(TThread)
  private
    FOwner: TDaemon1;
  protected
    procedure Execute; override;
  public
    constructor Create(AOwner: TDaemon1);
  end;

constructor TServiceThread.Create(AOwner: TDaemon1);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FOwner := AOwner;
end;

procedure TServiceThread.Execute;
begin
  while not Terminated do
  begin
    if Assigned(FOwner) then
      FOwner.Log('Serviço rodando...');
    Sleep(10000); // 10 segundos
  end;
end;

procedure TDaemon1.DataModuleCreate(Sender: TObject);
begin
  FLogFile := ExtractFilePath(ParamStr(0)) + 'servico_log.txt';
  Log('Serviço criado');
end;

procedure TDaemon1.DataModuleDestroy(Sender: TObject);
begin
  Log('Serviço destruído');
end;

procedure TDaemon1.DataModuleStart(Sender: TDaemon; var OK: Boolean);
begin
  Log('Serviço iniciado');
  FRunning := True;
  FThread := TServiceThread.Create(Self);
  OK := True;
end;

procedure TDaemon1.DataModuleStop(Sender: TDaemon; var OK: Boolean);
begin
  Log('Solicitação de parada');
  FRunning := False;
  if Assigned(FThread) then
  begin
    FThread.Terminate;
    FThread.WaitFor;
  end;
  Log('Serviço parado');
  OK := True;
end;

procedure TDaemon1.Log(const Msg: string);
var
  F: TextFile;
begin
  AssignFile(F, FLogFile);
  if FileExists(FLogFile) then
    Append(F)
  else
    Rewrite(F);
  WriteLn(F, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ' - ' + Msg);
  CloseFile(F);
end;

procedure RegisterDaemon;
begin
  RegisterDaemonClass(TDaemon1);
end;

initialization
  RegisterDaemon;

end.
