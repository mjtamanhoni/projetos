unit Prism.BaseClass.Timer;

interface

uses
 System.Classes, System.Threading, System.SysUtils,
 Prism.Interfaces;


type
 TPrismTimer = class(TThread)
  private
    FInterval: Integer;
    FOnTimer: TThreadProcedure;
    FTerminated: Boolean;
    FPaused: Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(Interval: Integer; OnTimer: TThreadProcedure);
    destructor Destroy; override;
    procedure Pause;
    procedure Resume;
    procedure Terminate;
    property Terminated: Boolean read FTerminated;
  end;

implementation


{ TPrismTimer }

constructor TPrismTimer.Create(Interval: Integer; OnTimer: TThreadProcedure);
begin
 FPaused:= true;

 inherited Create(False);
 Priority:= tpIdle;
 FInterval := Interval;
 FOnTimer := OnTimer;
end;

destructor TPrismTimer.Destroy;
begin
  FPaused:= true;
  Terminate;
  FOnTimer:= nil;

  inherited;
end;

procedure TPrismTimer.Execute;
begin
 while (not FTerminated) do
 begin
  if (not FPaused) and (not FTerminated) then
  begin
   if Assigned(FOnTimer) then
   begin
    try
     FOnTimer();
    except
    end;
   end;
  end;

  Sleep(FInterval);
 end;
end;

procedure TPrismTimer.Pause;
begin
 FPaused := True;
end;

procedure TPrismTimer.Resume;
begin
 FPaused := False;
end;

procedure TPrismTimer.Terminate;
begin
 FTerminated := True;
end;

end.
