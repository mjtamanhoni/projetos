unit Prism.BaseClass.Sessions;

interface

Uses
 System.Classes, System.SysUtils, System.Generics.Collections, Winapi.Windows,
 Prism.Interfaces;

type
 TPrismSessions = class(TInterfacedPersistent, IPrismSessions)
  private
   FDictSessions: TDictionary<string, IPrismSession>;
   FDictInfoSessions: TDictionary<string, string>;
   FLock: TMultiReadExclusiveWriteSynchronizer;
   function GetSession(const AUUID: String): IPrismSession;
   function GetSessionsFromIdentity(const Identity: string): TList<IPrismSession>;
   function GetSessionsFromIdentityAndUser(const Identity, User: string): TList<IPrismSession>;
  public
   constructor Create;
   destructor Destroy; override;

   procedure Add(APrismSession: IPrismSession); overload;
   function Count: integer;
   function Delete(AUUID: string): Boolean;
   function Exist(AUUID: string): Boolean; overload;
   function Exist(AUUID, AToken: string): Boolean; overload;
   function FromThreadID(const AThreadID: Integer; AAlertErrorThreadID: Boolean = false): IPrismSession;
   function FromPushID(const APushID: string): IPrismSession;
   function Items: TList<IPrismSession>;

   procedure CloseAll;

{$IFDEF D2BRIDGE}
   procedure FreeMem;
{$ENDIF}

   property Item[const AUUID: string]: IPrismSession read GetSession;
   property SessionsFromIdentity[const Identity: string]: TList<IPrismSession> read GetSessionsFromIdentity;
   property SessionsFromIdentityAndUser[const Identity, User: string]: TList<IPrismSession> read GetSessionsFromIdentityAndUser;
 end;

implementation

{ TPrismSessions }

procedure TPrismSessions.Add(APrismSession: IPrismSession);
begin
 FLock.BeginWrite;
 try
  try
   FDictSessions.AddOrSetValue(APrismSession.UUID, APrismSession);
   FDictInfoSessions.AddOrSetValue(APrismSession.UUID, APrismSession.Token);
  except
  end;
 finally
   FLock.EndWrite;
 end;
end;

procedure TPrismSessions.CloseAll;
var
 vPrismSession: IPrismSession;
begin
 FLock.BeginWrite;
 try
  try
   for vPrismSession in FDictSessions.Values do
   begin
    try
     if Assigned(vPrismSession) then
      if not vPrismSession.Closing then
       vPrismSession.Close;
    except
    end;
   end;
  except
  end;
 finally
   FLock.EndWrite;
 end;
end;

function TPrismSessions.Count: integer;
begin
 FLock.BeginRead;
 try
  try
   result:= FDictSessions.Count;
  except
  end;
 finally
   FLock.EndRead;
 end;
end;

constructor TPrismSessions.Create;
begin
 FLock := TMultiReadExclusiveWriteSynchronizer.Create;
 FDictSessions:= TDictionary<string, IPrismSession>.Create;
 FDictInfoSessions:= TDictionary<string, string>.Create;
end;

function TPrismSessions.Delete(AUUID: string): Boolean;
begin
 FLock.BeginWrite;
 try
  try
   FDictSessions.Remove(AUUID);
   FDictInfoSessions.Remove(AUUID);

{$IFDEF D2BRIDGE}
   if FDictSessions.Count <= 0 then
    FreeMem;
{$ENDIF}
  except
  end;
 finally
   FLock.EndWrite;
 end;
end;

destructor TPrismSessions.Destroy;
begin
 FLock.Free;
 FDictSessions.Free;
 FDictInfoSessions.Free;

 inherited;
end;

function TPrismSessions.Exist(AUUID: string): Boolean;
var
 vPrismSession: IPrismSession;
begin
 FLock.BeginRead;
 try
  try
   if FDictSessions.ContainsKey(AUUID) then
   begin
    vPrismSession:= FDictSessions.Items[AUUID];
    if Assigned(vPrismSession) then
     if vPrismSession.Closing then
      result:= false
     else
      result:= true
   end;
  except
  end;
 finally
   FLock.EndRead;
 end;
end;

function TPrismSessions.Exist(AUUID, AToken: string): Boolean;
var
 vPrismSession: IPrismSession;
begin
 FLock.BeginRead;
 try
  try
   result:= false;
   if FDictInfoSessions.ContainsKey(AUUID) then
    if FDictInfoSessions.Items[AUUID] = AToken then
    begin
     vPrismSession:= FDictSessions.Items[AUUID];
     if vPrismSession.Closing then
      result:= false
    end;
  except
  end;
 finally
   FLock.EndRead;
 end;

end;

{$IFDEF D2BRIDGE}
procedure TPrismSessions.FreeMem;
var
  MainHandle : THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID) ;
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
    CloseHandle(MainHandle) ;
  except
  end;
//  Application.ProcessMessages;
end;
{$ENDIF}

function TPrismSessions.FromPushID(const APushID: string): IPrismSession;
var
 I, J: Integer;
 vPrismSession: IPrismSession;
begin
 FLock.BeginRead;

 try
  Result:= nil;

  try
    for I := 0 to Pred(FDictSessions.Count) do
    begin
     for vPrismSession in FDictSessions.Values do
     begin
      try
       if Assigned(vPrismSession) then
       begin
        if vPrismSession.PushID = APushID then
        begin
         Result:= vPrismSession;
         Break;
        end;
       end;
      except
      end;
     end;

     if Assigned(Result) then
     Break;
    end;
  except
  end;
 finally
  FLock.EndRead;
 end;

end;

function TPrismSessions.FromThreadID(const AThreadID: Integer; AAlertErrorThreadID: Boolean): IPrismSession;
var
 I, J: Integer;
 vPrismSession: IPrismSession;
begin
 FLock.BeginRead;

 try
  Result:= nil;

  try
   if AThreadID <> MainThreadID then
   begin
    for I := 0 to Pred(FDictSessions.Count) do
    begin
     for vPrismSession in FDictSessions.Values do
     begin
      try
       if Assigned(vPrismSession) then
       begin
        if vPrismSession.ThreadIDs.Contains(AThreadID) then
        begin
         Result:= vPrismSession;
         Break;
        end;
       end;
      except
      end;
     end;

     if Assigned(Result) then
     Break;
    end;
   end else
    if AAlertErrorThreadID then
     raise Exception.Create('Error in Thread becouse ID is Main Thread: Error 7001');

   if Result = nil then
   begin
    //Result:= Sessions.Items[Sessions.ToArray[0].Key];
    if AAlertErrorThreadID then
    raise Exception.Create('Error searching Session Thread, Session is nil: Error 7002');
   end;
  except
  end;
 finally
  FLock.EndRead;
 end;
end;

function TPrismSessions.GetSession(const AUUID: String): IPrismSession;
begin
 FLock.BeginRead;
 try
  try
   if FDictSessions.ContainsKey(AUUID) then
    result:= FDictSessions.Items[AUUID];
  except
  end;
 finally
   FLock.EndRead;
 end;
end;

function TPrismSessions.GetSessionsFromIdentity(const Identity: string): TList<IPrismSession>;
var
 vPrismSession: IPrismSession;
 I: integer;
begin
 FLock.BeginRead;
 try
  Result:= TList<IPrismSession>.Create;

  try
   for vPrismSession in FDictSessions.Values do
   begin
    try
     if Assigned(vPrismSession) then
      if not vPrismSession.Closing then
       if Assigned(vPrismSession.InfoConnection) then
        if SameText(vPrismSession.InfoConnection.Identity, Identity) then
         Result.Add(vPrismSession);
    except
    end;
   end;
  except
  end;
 finally
  FLock.EndRead;
 end;
end;

function TPrismSessions.GetSessionsFromIdentityAndUser(const Identity, User: string): TList<IPrismSession>;
var
 vPrismSession: IPrismSession;
 vPrismSessionList: TList<IPrismSession>;
 I: integer;
begin
 try
  Result:= TList<IPrismSession>.Create;
  vPrismSessionList:= SessionsFromIdentity[Identity];

  try
   FLock.BeginRead;

   for vPrismSession in vPrismSessionList do
   begin
    try
     if SameText(vPrismSession.InfoConnection.User, User) then
      Result.Add(vPrismSession);
    except
    end;
   end;
  except
  end;
 finally
  FLock.EndRead;
  FreeAndNil(vPrismSessionList);
 end;
end;

function TPrismSessions.Items: TList<IPrismSession>;
begin
 FLock.BeginRead;
 try
  try
   result:= TList<IPrismSession>.Create(FDictSessions.Values);
  except
  end;
 finally
   FLock.EndRead;
 end;

end;

end.
