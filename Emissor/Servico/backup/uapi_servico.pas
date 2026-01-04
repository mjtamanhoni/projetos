unit uAPI_Servico;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DaemonApp;

type

  { TDaemon1 }

  TDaemon1 = class(TDaemon)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleStart(Sender: TDaemon; var OK: Boolean);
  private
    FLogFile: string;
    FRunning: Boolean;
    FThread: TThread;
    procedure Log(const Msg: string);
    procedure ExecuteThread;
  public

  end;

var
  Daemon1: TDaemon1;

implementation

procedure RegisterDaemon;
begin
  RegisterDaemonClass(TDaemon1)
end;

{$R *.lfm}

{ TDaemon1 }

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
  FThread := TThread.CreateAnonymousThread(@ExecuteThread);
  FThread.FreeOnTerminate := True;
  FThread.Start;
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

procedure TDaemon1.ExecuteThread;
begin
  while FRunning do
  begin
    Log('Serviço rodando - tick');
    Sleep(10000); // 10 segundos
  end;
end;


initialization
  RegisterDaemon;
end.

