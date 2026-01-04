unit uFbExclusiveDDL;

interface

uses
  Windows, SysUtils;

type
  TExecuteProc = procedure of object;

function FbShutdownDatabase(const GfixPath, DbPath, User, Pass: string; ForceSeconds: Integer): Boolean;
function FbBringOnline(const GfixPath, DbPath, User, Pass: string): Boolean;
function FbExclusiveDDL(const GfixPath, DbPath, User, Pass: string; ForceSeconds: Integer; ExecuteChanges: TExecuteProc): Boolean;
function FbTryDDLWithRetry(ExecuteChanges: TExecuteProc; TimeoutMs, RetryMs: Integer): Boolean;

implementation

function RunProcessAndWait(const CmdLine: string): Boolean;
var
  SI: TStartupInfo;
  PI: TProcessInformation;
  ExitCode: DWORD;
  Cmd: string;
begin
  ZeroMemory(@SI, SizeOf(SI));
  SI.cb := SizeOf(SI);
  SI.dwFlags := STARTF_USESHOWWINDOW;
  SI.wShowWindow := SW_HIDE;
  ZeroMemory(@PI, SizeOf(PI));
  Cmd := CmdLine;
  Result := CreateProcess(nil, PChar(Cmd), nil, nil, False, 0, nil, nil, SI, PI);
  if Result then
  begin
    WaitForSingleObject(PI.hProcess, INFINITE);
    GetExitCodeProcess(PI.hProcess, ExitCode);
    Result := ExitCode = 0;
    CloseHandle(PI.hThread);
    CloseHandle(PI.hProcess);
  end;
end;

function Quote(const S: string): string;
begin
  Result := '"' + S + '"';
end;

function FbShutdownDatabase(const GfixPath, DbPath, User, Pass: string; ForceSeconds: Integer): Boolean;
var
  Cmd: string;
begin
  Cmd := Quote(GfixPath) + ' -user ' + User + ' -password ' + Pass + ' -shut -force ' + IntToStr(ForceSeconds) + ' ' + Quote(DbPath);
  Result := RunProcessAndWait(Cmd);
end;

function FbBringOnline(const GfixPath, DbPath, User, Pass: string): Boolean;
var
  Cmd: string;
begin
  Cmd := Quote(GfixPath) + ' -user ' + User + ' -password ' + Pass + ' -online ' + Quote(DbPath);
  Result := RunProcessAndWait(Cmd);
end;

function FbExclusiveDDL(const GfixPath, DbPath, User, Pass: string; ForceSeconds: Integer; ExecuteChanges: TExecuteProc): Boolean;
begin
  Result := False;
  if not FbShutdownDatabase(GfixPath, DbPath, User, Pass, ForceSeconds) then Exit;
  try
    if Assigned(ExecuteChanges) then ExecuteChanges;
    Result := True;
  finally
    FbBringOnline(GfixPath, DbPath, User, Pass);
  end;
end;

function FbTryDDLWithRetry(ExecuteChanges: TExecuteProc; TimeoutMs, RetryMs: Integer): Boolean;
var
  StartTick: DWORD;
begin
  Result := False;
  StartTick := GetTickCount;
  while True do
  begin
    try
      if Assigned(ExecuteChanges) then ExecuteChanges;
      Result := True;
      Exit;
    except
      on E: Exception do
      begin
        if (Pos('in use', LowerCase(E.Message)) = 0) and (Pos('em uso', LowerCase(E.Message)) = 0) then
          raise;
        if GetTickCount - StartTick >= DWORD(TimeoutMs) then Exit;
        Sleep(RetryMs);
      end;
    end;
  end;
end;

end.
