{
 +--------------------------------------------------------------------------+
  D2Bridge Framework Content

  Author: Talis Jonatas Gomes
  Email: talisjonatas@me.com

  This source code is provided 'as-is', without any express or implied
  warranty. In no event will the author be held liable for any damages
  arising from the use of this code.

  However, it is granted that this code may be used for any purpose,
  including commercial applications, but it may not be modified,
  distributed, or sublicensed without express written authorization from
  the author (Talis Jonatas Gomes). This includes creating derivative works
  or distributing the source code through any means.

  If you use this software in a product, an acknowledgment in the product
  documentation would be appreciated but is not required.

  God bless you
 +--------------------------------------------------------------------------+
}

{$I ..\D2Bridge.inc}

unit Prism.Session.Thread;

interface

uses
  System.Classes, System.SysUtils, System.SyncObjs, System.Threading,
{$IFDEF MSWINDOWS}
  WinApi.ActiveX, WinApi.Windows,
{$ENDIF}
{$IFDEF FMX}
  FMX.Forms,
{$ELSE}
  Vcl.Forms,
{$ENDIF}
  Prism.Interfaces, Prism.Session.Thread.Proc;

type
  TPrismThreadProc = reference to procedure;

type
 TPrismSessionThread = class(TThread)
  private
   FPrismSession: IPrismSession;
   FThreadID: Integer;
   FThreadLevel: Integer;
   FProc: TPrismSessionThreadProc;
   FRunning: Boolean;
   FStop: Boolean;
  private
   procedure ExecAnonymousThread(AProc: TPrismSessionThreadProc);
  protected
   procedure Execute; override;
   procedure DoTerminate; override;
  public
   constructor Create(APrismSession: IPrismSession; AThreadLevel: Integer);
   destructor Destroy; override;

   procedure Exec(AProc: TPrismSessionThreadProc);

   procedure Stop;

   property Running: Boolean read FRunning;
 end;

implementation

uses
  Prism.Session;

{ TPrismSessionThread }

constructor TPrismSessionThread.Create(APrismSession: IPrismSession; AThreadLevel: Integer);
begin
 inherited Create(false);

 FPrismSession:= APrismSession;
 //FThreadID := GetCurrentThreadID;
 FreeOnTerminate := false;
 FRunning:= false;
 FStop:= false;
 Priority:= tpIdle;

 FThreadLevel:= AThreadLevel;
end;


destructor TPrismSessionThread.Destroy;
begin
 FStop:= true;

 inherited;
end;

procedure TPrismSessionThread.DoTerminate;
begin
// if FPrismSession.ThreadIDs.Contains(FThreadID) then
// FPrismSession.ThreadIDs.Remove(FThreadID);
 FreeAndNil(FProc);
 FRunning:= false;
 CoUninitialize;

 inherited;
end;

procedure TPrismSessionThread.Exec(AProc: TPrismSessionThreadProc);
var
 ITaskLock: ITask;
begin
 FProc := AProc;
 FRunning:= true;

// Execute;

 if Assigned(FProc) and (FProc.Wait) then
 begin
  ITaskLock:=
   TTask.Run(
    procedure
    begin
     repeat
      sleep(1);
     until not FRunning;
    end
   );
  ITaskLock.Wait(INFINITE);
  ITaskLock:= nil;
 end;
end;

procedure TPrismSessionThread.ExecAnonymousThread(AProc: TPrismSessionThreadProc);
begin
 TThread.CreateAnonymousThread(
  procedure
  var
   vThreadID: integer;
  begin
   //CoInitializeEx(0, COINIT_MULTITHREADED);

   vThreadID := GetCurrentThreadID;

   if vThreadID <> MainThreadID then
    if not FPrismSession.ThreadIDs.Contains(vThreadID) then
     FPrismSession.ThreadIDs.Add(vThreadID);

   if IsDebuggerPresent then
    NameThreadForDebugging('Async Session '+FPrismSession.UUID+' #'+IntToStr(FThreadLevel));

   try
    try
     AProc.ProcExec;
    except
     on E: Exception do
      if Assigned(FPrismSession) and (not FPrismSession.Closing) and (not (csDestroying in TPrismSession(FPrismSession).ComponentState)) then
       FPrismSession.DoException(nil, E, 'Thread');
    end;
   finally
    try
     if (AProc.PrismSession <> nil) and (not AProc.PrismSession.Closing) and
        (not (csDestroying in TPrismSession(AProc.PrismSession).ComponentState)) then
      AProc.PrismSession.ThreadIDs.Remove(vThreadID);
     if Assigned(AProc) then
      AProc.Free;
    except
    end;
    //CoUninitialize;
   end;
  end
 ).Start;
end;

procedure TPrismSessionThread.Execute;
begin
 inherited;

 //CoInitializeEx(0, COINIT_MULTITHREADED);

 try
  if IsDebuggerPresent then
   NameThreadForDebugging('Session '+FPrismSession.UUID+' #'+IntToStr(FThreadLevel));

  try
   repeat
    sleep(1);

     FThreadID := GetCurrentThreadID;
     if FThreadID <> MainThreadID then
     if not FPrismSession.ThreadIDs.Contains(FThreadID) then
     FPrismSession.ThreadIDs.Add(FThreadID);


     try
      if (FProc <> nil) and Assigned(FProc) then
      with FProc do
      begin
  //     TThread.CreateAnonymousThread(
  //      procedure
  //      begin
  //       Proc();
  //      end
  //     ).Start;

       if Sincronize then
       Synchronize(self,
         procedure
         begin
          try
           ProcExec;
          except
           on E: Exception do
            FPrismSession.DoException(nil, E, 'Thread');
          end;
         end
       )
       else
       begin
        if Wait then
        begin
         try
          ProcExec;
         except
          on E: Exception do
          FPrismSession.DoException(nil, E, 'Thread');
         end;
        end else
        begin
         self.ExecAnonymousThread(TPrismSessionThreadProc.Create(FPrismSession, Proc, ProcVar1, ProcVar2, ProcVar3, ProcVar4));
        end;
       end;
      end;
     finally
     begin
      try
       if (FProc <> nil) and Assigned(FProc) then
       FreeAndNil(FProc);
       FRunning:= false;
      except
      end;
     end;
    end;

    try
     if Assigned(application) then
     application.ProcessMessages;
    except
    end;
   until FStop or Application.Terminated;
  except
  end;
 finally
  FStop:= false;
 end;

end;


procedure TPrismSessionThread.Stop;
begin
 FStop:= true;
end;

// TTask.Run(
//   procedure
//   begin
//    AProc;
//   end
// );




end.

