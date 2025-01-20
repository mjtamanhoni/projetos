unit Prism.Session.Helper;

interface

Uses
 System.classes, System.SysUtils, System.UITypes, DateUtils,
 {$IFDEF FMX}
  FMX.Dialogs, FMX.Controls,
 {$ELSE}
  Vcl.Dialogs, Vcl.Controls,
 {$ENDIF}
 Prism.Session, Prism.Types;

type
 TPrismSessionStatusHelper = class helper for TPrismSession
  procedure DoDeActive;
  procedure DoRestore;
  procedure DoRecovering;
  procedure DoRecovered;
  procedure DoRenewUUID;
  procedure DoHeartBeat;
  procedure SetPrimaryForm(AD2BridgePrimaryForm: TObject);
  procedure SetConnectionStatus(AConnectionStatus: TSessionConnectionStatus);
  procedure SetReloading(AReloading: boolean);
  procedure SetDisconnect(ADisconnect: boolean);
  procedure SetIdle(AIdle: boolean);
  procedure SetIdleSeconds(ASeconds: integer);
  procedure ShowMessageSessionIdle;
 end;


implementation


{ TPrismSessionStatusHelper }

procedure TPrismSessionStatusHelper.DoDeActive;
begin
 SetActive(False);
end;

procedure TPrismSessionStatusHelper.DoHeartBeat;
begin
 FLastHeartBeat:= now;
end;

procedure TPrismSessionStatusHelper.DoRecovered;
begin
 SetRecovering(False);
end;

procedure TPrismSessionStatusHelper.DoRecovering;
begin
 SetRecovering(True);
end;

procedure TPrismSessionStatusHelper.DoRenewUUID;
begin
 RenewUUID;
end;

procedure TPrismSessionStatusHelper.DoRestore;
begin
 SetActive(True);
end;

procedure TPrismSessionStatusHelper.SetConnectionStatus(AConnectionStatus: TSessionConnectionStatus);
begin
 DoConnectionStatus(AConnectionStatus);
end;

procedure TPrismSessionStatusHelper.SetDisconnect(ADisconnect: boolean);
begin
 if ADisconnect then
  BeginDisconnect
 else
  EndDisconnect;
end;

procedure TPrismSessionStatusHelper.SetIdle(AIdle: boolean);
begin
 FIdle:= AIdle;
end;

procedure TPrismSessionStatusHelper.SetIdleSeconds(ASeconds: integer);
var
 vTempLastActivity: TDateTime;
begin
 vTempLastActivity:= IncSecond(Now, ASeconds * (-1));
 if vTempLastActivity > FLastActivity then
  FLastActivity:= vTempLastActivity;
end;

procedure TPrismSessionStatusHelper.SetPrimaryForm(AD2BridgePrimaryForm: TObject);
begin
 FD2BridgeFormPrimary:= AD2BridgePrimaryForm;
end;

procedure TPrismSessionStatusHelper.SetReloading(AReloading: boolean);
begin
 FReloading:= AReloading;
end;

procedure TPrismSessionStatusHelper.ShowMessageSessionIdle;
begin
 TThread.CreateAnonymousThread(
  procedure
  begin
   if Self.MessageDlg(Self.LangNav.Messages.SessionIdleTimeOut, TMsgDlgType.mtwarning, [TMsgDlgBtn.mbyes,TMsgDlgBtn.mbno], 0) = mrYes then
   begin
    if not (Closing) then
     Self.Close(true);
   end else
   begin
    SetIdleSeconds(0);
    SetIdle(false);
   end;
  end
 ).Start;

 Sleep(60000);

 if Idle and not (Closing) then
  Self.Close(false);
end;

end.
