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

unit Prism.Session.Thread.Proc;

interface

uses
  System.Classes, System.SysUtils, System.SyncObjs, System.Threading, System.Rtti,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  Prism.Interfaces;

type
 TPrismSessionThreadProc = class
  private
   FPrismSession: IPrismSession;
   FSincronize: Boolean;
   FWait: Boolean;
   FProcVar1, FProcVar2, FProcVar3, FProcVar4: TValue;
   FProc: TProc<TValue,TValue,TValue,TValue>;
  public
   constructor Create(APrismSession: IPrismSession; AProc: TProc<TValue,TValue,TValue,TValue>; AVar1, AVar2, AVar3, AVar4: TValue; AWait: Boolean = false; ASincronize: Boolean = false);

   procedure ProcExec;

   function PrismSession: IPrismSession;

   procedure ExecAnonymousThread(AAutoDestroy: Boolean = true); overload;

   property Proc: TProc<TValue,TValue,TValue,TValue> read FProc;
   property ProcVar1: TValue read FProcVar1 write FProcVar1;
   property ProcVar2: TValue read FProcVar2 write FProcVar2;
   property ProcVar3: TValue read FProcVar3 write FProcVar3;
   property ProcVar4: TValue read FProcVar4 write FProcVar4;
   property Wait: Boolean read FWait;
   property Sincronize: Boolean read FSincronize;
 end;


implementation

{ TPrismSessionThreadProc }

constructor TPrismSessionThreadProc.Create(APrismSession: IPrismSession; AProc: TProc<TValue,TValue,TValue,TValue>; AVar1, AVar2, AVar3, AVar4: TValue; AWait: Boolean = false; ASincronize: Boolean = false);
begin
 FSincronize:= ASincronize;
 FWait:= AWait;
 FProc:= AProc;
 FProcVar1:= AVar1;
 FProcVar2:= AVar2;
 FProcVar3:= AVar3;
 FProcVar4:= AVar4;
end;

procedure TPrismSessionThreadProc.ExecAnonymousThread(AAutoDestroy: Boolean = true);
begin
 TThread.CreateAnonymousThread(
  procedure
  begin
   try
    ProcExec;
    if AAutoDestroy then
     Self.Destroy;
   except
   end;
  end
 ).Start;
end;

function TPrismSessionThreadProc.PrismSession: IPrismSession;
begin
 result:= FPrismSession;
end;

procedure TPrismSessionThreadProc.ProcExec;
begin
 try
  FProc(FProcVar1, FProcVar2, FProcVar3, FProcVar4);
 except on E: Exception do
{$IFDEF MSWINDOWS}
  if IsDebuggerPresent then
   raise Exception.Create(E.Message);
{$ENDIF}
 end;
end;

end.
