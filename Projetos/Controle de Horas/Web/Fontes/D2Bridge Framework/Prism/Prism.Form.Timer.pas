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

unit Prism.Form.Timer;

interface

uses
  System.Classes, System.SysUtils, System.SyncObjs,
  Prism.Interfaces;

type
  TPrismFormTimer = class(TThread)
  private
    FInterval: Integer;
    FOnTimer: TThreadProcedure;
    //FPauseEvent: TEvent;
    FTerminated: Boolean;
    FPaused: Boolean;
    FPrismForm: IPrismForm;
  protected
    procedure Execute; override;
  public
    constructor Create(APrismForm: IPrismForm; Interval: Integer; OnTimer: TThreadProcedure);
    destructor Destroy; override;
    procedure Pause;
    procedure Resume;
    procedure Terminate;
    property Terminated: Boolean read FTerminated;
  end;

implementation

uses
{$IFDEF FMX}
  FMX.Forms,
{$ELSE}
  Vcl.Forms,
{$ENDIF}
  Prism.Forms;

{ TPrismFormTimer }

constructor TPrismFormTimer.Create(APrismForm: IPrismForm; Interval: Integer; OnTimer: TThreadProcedure);
begin
  FPrismForm:= APrismForm;
  FPaused:= true;

  inherited Create(False);
  Priority:= tpIdle;
  FInterval := Interval;
  FOnTimer := OnTimer;
  //FPauseEvent := TEvent.Create(nil, True, True, '');
end;

destructor TPrismFormTimer.Destroy;
begin
  FPaused:= true;
  Terminate;
  //FPauseEvent.Free;
  FOnTimer:= nil;
  inherited;
end;

procedure TPrismFormTimer.Pause;
begin
  FPaused := True;
end;

procedure TPrismFormTimer.Resume;
begin
  FPaused := False;
  //FPauseEvent.SetEvent;
end;

procedure TPrismFormTimer.Terminate;
begin
  FTerminated := True;
  //FPauseEvent.SetEvent;
end;

procedure TPrismFormTimer.Execute;
begin
 if Assigned(FPrismForm) then
  while (not FTerminated) and (not (csDestroying in TPrismForm(FPrismForm).ComponentState)) and (not FPrismForm.Session.Closing) do
  begin
    //Yield;

    if (not FPaused) and (not FTerminated) then
    begin
      if Assigned(FOnTimer) then
      begin
       try
        //Synchronize(CurrentThread, FOnTimer);
        //TThread.Synchronize(nil, FOnTimer);
        FOnTimer();
       except
       end;
      end;
    end;

    Sleep(FInterval);
//    Application.ProcessMessages;
//    if not FTerminated then
//    Sleep(FInterval);
//    if not FTerminated then
//    if Assigned(self) then
//    FPauseEvent.WaitFor(INFINITE); // Pauses execution if paused
  end;
end;

end.
