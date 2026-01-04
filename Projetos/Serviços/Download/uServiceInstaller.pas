unit uServiceInstaller;

interface

uses
  System.SysUtils, Winapi.Windows, Winapi.WinSvc;

type
  TServiceInstaller = class
  private
    FServiceName: string;
    FDisplayName: string;
    FExePath: string;
    function OpenSCManagerHandle: SC_HANDLE;
    function OpenServiceHandle(DesiredAccess: DWORD): SC_HANDLE;
    function QueryStatus(out Status: SERVICE_STATUS_PROCESS): Boolean;
  public
    constructor Create(const ServiceName, DisplayName, ExePath: string);
    property ServiceName: string read FServiceName write FServiceName;
    property DisplayName: string read FDisplayName write FDisplayName;
    property ExePath: string read FExePath write FExePath;

    function Exists: Boolean;
    function IsRunning: Boolean;
    function Stop(ForceStop: Boolean; TimeoutMS: Cardinal = 30000): Boolean;
    function Uninstall: Boolean;
    function Install(AutoStart: Boolean = True): Boolean;
    function Start(TimeoutMS: Cardinal = 30000): Boolean;
    function ReinstallAndStart(TimeoutMS: Cardinal = 30000): Boolean;
  end;

implementation

// Import explícito para evitar ambiguidade com outras StartService
function AdvStartService(hService: SC_HANDLE; dwNumServiceArgs: DWORD; lpServiceArgVectors: PPWideChar): BOOL; stdcall;
  external 'advapi32.dll' name 'StartServiceW';

const
  ACCESS_DELETE = $00010000;

function TServiceInstaller.OpenSCManagerHandle: SC_HANDLE;
begin
  Result := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
end;

function TServiceInstaller.OpenServiceHandle(DesiredAccess: DWORD): SC_HANDLE;
var
  scm: SC_HANDLE;
begin
  Result := 0;
  scm := OpenSCManagerHandle;
  if scm = 0 then Exit;
  try
    Result := OpenService(scm, PChar(FServiceName), DesiredAccess);
  finally
    if scm <> 0 then
      CloseServiceHandle(scm);
  end;
end;

function TServiceInstaller.QueryStatus(out Status: SERVICE_STATUS_PROCESS): Boolean;
var
  scm, svc: SC_HANDLE;
  Needed: DWORD;
begin
  Result := False;
  FillChar(Status, SizeOf(Status), 0);
  scm := OpenSCManagerHandle;
  if scm = 0 then Exit;
  try
    svc := OpenService(scm, PChar(FServiceName), SERVICE_QUERY_STATUS);
    if svc = 0 then Exit;
    try
      Result := QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, @Status, SizeOf(Status), Needed);
    finally
      CloseServiceHandle(svc);
    end;
  finally
    CloseServiceHandle(scm);
  end;
end;

constructor TServiceInstaller.Create(const ServiceName, DisplayName, ExePath: string);
begin
  FServiceName := ServiceName;
  FDisplayName := DisplayName;
  FExePath := ExePath;
end;

function TServiceInstaller.Exists: Boolean;
var
  scm, svc: SC_HANDLE;
begin
  Result := False;
  scm := OpenSCManagerHandle;
  if scm = 0 then Exit;
  try
    svc := OpenService(scm, PChar(FServiceName), SERVICE_QUERY_STATUS);
    if svc <> 0 then
    begin
      Result := True;
      CloseServiceHandle(svc);
    end;
  finally
    CloseServiceHandle(scm);
  end;
end;

function TServiceInstaller.IsRunning: Boolean;
var
  St: SERVICE_STATUS_PROCESS;
begin
  Result := QueryStatus(St) and (St.dwCurrentState = SERVICE_RUNNING);
end;

function TServiceInstaller.Stop(ForceStop: Boolean; TimeoutMS: Cardinal): Boolean;
var
  scm, svc: SC_HANDLE;
  StProc: SERVICE_STATUS_PROCESS;
  StStop: TServiceStatus;
  StartTick: Cardinal;
  Needed: DWORD;
  Proc: THandle;
begin
  Result := False;
  scm := OpenSCManagerHandle;
  if scm = 0 then Exit;
  try
    svc := OpenService(scm, PChar(FServiceName), SERVICE_STOP or SERVICE_QUERY_STATUS or SERVICE_ENUMERATE_DEPENDENTS);
    if svc = 0 then Exit;
    try
      FillChar(StStop, SizeOf(StStop), 0);
      ControlService(svc, SERVICE_CONTROL_STOP, StStop);

      StartTick := GetTickCount;
      repeat
        if not QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, @StProc, SizeOf(StProc), Needed) then Break;
        if StProc.dwCurrentState = SERVICE_STOPPED then
        begin
          Result := True;
          Break;
        end;
        Sleep(500);
      until (GetTickCount - StartTick) >= TimeoutMS;

      if (not Result) and ForceStop then
      begin
        if QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, @StProc, SizeOf(StProc), Needed) then
        begin
          if StProc.dwProcessId <> 0 then
          begin
            Proc := OpenProcess(PROCESS_TERMINATE, False, StProc.dwProcessId);
            if Proc <> 0 then
            begin
              try
                TerminateProcess(Proc, 1);
              finally
                CloseHandle(Proc);
              end;
              Sleep(1000);
              if QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, @StProc, SizeOf(StProc), Needed) and
                 (StProc.dwCurrentState = SERVICE_STOPPED) then
                Result := True;
            end;
          end;
        end;
      end;
    finally
      CloseServiceHandle(svc);
    end;
  finally
    CloseServiceHandle(scm);
  end;
end;

function TServiceInstaller.Uninstall: Boolean;
var
  scm, svc: SC_HANDLE;
begin
  Result := False;
  scm := OpenSCManagerHandle;
  if scm = 0 then Exit;
  try
    svc := OpenService(scm, PChar(FServiceName), ACCESS_DELETE or SERVICE_QUERY_STATUS);
    if svc = 0 then Exit;
    try
      Result := DeleteService(svc);
    finally
      CloseServiceHandle(svc);
    end;
  finally
    CloseServiceHandle(scm);
  end;
end;

function TServiceInstaller.Install(AutoStart: Boolean): Boolean;
var
  scm, svc: SC_HANDLE;
  StartType: DWORD;
begin
  Result := False;
  if FExePath = '' then Exit;
  if not FileExists(FExePath) then Exit;

  StartType := SERVICE_AUTO_START;
  if not AutoStart then
    StartType := SERVICE_DEMAND_START;

  scm := OpenSCManagerHandle;
  if scm = 0 then Exit;
  try
    svc := CreateService(
      scm,
      PChar(FServiceName),
      PChar(FDisplayName),
      SERVICE_ALL_ACCESS,
      SERVICE_WIN32_OWN_PROCESS,
      StartType,
      SERVICE_ERROR_NORMAL,
      PChar(FExePath),
      nil, nil, nil, nil, nil
    );
    if svc <> 0 then
    begin
      Result := True;
      CloseServiceHandle(svc);
    end
    else
    begin
      // Se já existir, considerar como instalado
      Result := Exists;
    end;
  finally
    CloseServiceHandle(scm);
  end;
end;

function TServiceInstaller.Start(TimeoutMS: Cardinal): Boolean;
var
  scm, svc: SC_HANDLE;
  St: SERVICE_STATUS_PROCESS;
  Needed: DWORD;
  StartTick: Cardinal;
begin
  Result := False;

  scm := OpenSCManagerHandle;
  if scm = 0 then Exit;
  try
    svc := OpenService(scm, PChar(FServiceName), SERVICE_START or SERVICE_QUERY_STATUS);
    if svc = 0 then Exit;
    try
      // já está rodando?
      if QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, @St, SizeOf(St), Needed) and
         (St.dwCurrentState = SERVICE_RUNNING) then
        Exit(True);

      // start explícito
      if not AdvStartService(svc, 0, nil) then
      begin
        // checa se ficou running mesmo assim
        if QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, @St, SizeOf(St), Needed) and
           (St.dwCurrentState = SERVICE_RUNNING) then
          Exit(True)
        else
          Exit(False);
      end;

      // aguarda até running
      StartTick := GetTickCount;
      repeat
        if not QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, @St, SizeOf(St), Needed) then Break;
        if St.dwCurrentState = SERVICE_RUNNING then
        begin
          Result := True;
          Break;
        end;
        Sleep(500);
      until (GetTickCount - StartTick) >= TimeoutMS;
    finally
      CloseServiceHandle(svc);
    end;
  finally
    CloseServiceHandle(scm);
  end;
end;

function TServiceInstaller.ReinstallAndStart(TimeoutMS: Cardinal): Boolean;
begin
  Result := False;

  if Exists then
  begin
    if IsRunning then
      if not Stop(True, TimeoutMS) then
        Exit(False);

    if not Uninstall then
      Exit(False);
  end;

  if not Install(True) then
    Exit(False);

  Result := Start(TimeoutMS);
end;

end.