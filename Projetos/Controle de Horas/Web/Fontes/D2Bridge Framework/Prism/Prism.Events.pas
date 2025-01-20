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

unit Prism.Events;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Rtti,
  Prism.Interfaces, Prism.Types, DateUtils;

type
 TPrismDefaultEvent = procedure(Sender: TObject; EventParams: TStringList) of object;
 TProcessHTMLNotify = procedure(Sender: TObject; var AHTMLText: string) of object;
 TEventProcType = Prism.Types.TEventProcType;


type
 TPrismControlEvent = class(TInterfacedPersistent, IPrismControlEvent)
  private
   FEventID: String;
   FNotifyEvent: TNotifyEvent;
   FGetStrEvent: TPrismGetStrEvent;
   FEventType: TPrismEventType;
   FPrismControl: IPrismControl;
   FAutoPublishedEvent: Boolean;
   FOnEventProc: TOnEventProc;
   FLastCallEvent: TDateTime;
   FExecuting: Boolean;
   const MinCallBetweenEventMS = 300;
   function GetEventType: TPrismEventType;
   function GetEventID: String;
   function GetPrismControl: IPrismControl;
   procedure SetAutoPublishedEvent(AAutoPublished: Boolean);
   function GetAutoPublishedEvent: Boolean;
  public
   constructor Create(AOwner: IPrismControl; AEventType: TPrismEventType);
   destructor Destroy; override;

   procedure SetOnEvent(AOnEvent: TNotifyEvent); overload;
   procedure SetOnEvent(AOnEvent: TPrismGetStrEvent); overload;
   procedure SetOnEvent(AOnEventProc: TOnEventProc); overload;
   procedure CallEvent(Parameters: TStrings);
   function CallEventResponse(Parameters: TStrings): string;
   function EventJS(EventProc: TEventProcType = ExecEventProc; Parameters: String = ''; LockCLient: Boolean = false): string; overload;
   function EventJS(ASession: IPrismSession; FormUUID: string; EventProc: TEventProcType = ExecEventProc; Parameters: String = ''; LockCLient: Boolean = false): string; overload;

   function EventTypeName: string;

   property AutoPublishedEvent: Boolean read GetAutoPublishedEvent write SetAutoPublishedEvent;
   property EventType: TPrismEventType read GetEventType;
   property EventID: string read GetEventID;
   property PrismControl: IPrismControl read GetPrismControl;
 end;


type
 TPrismControlEvents = class(TInterfacedPersistent, IPrismControlEvents)
  private
   FEvents: TList<IPrismControlEvent>;
   FIPrismControl: IPrismControl;
  public
   constructor Create(AOwner: IPrismControl);
   destructor Destroy; override;

   procedure Add(AEvent: IPrismControlEvent); overload;
   procedure Add(AEventType: TPrismEventType; AEvent: TNotifyEvent); overload;
   procedure Add(AEventType: TPrismEventType; AOnEventProc: TOnEventProc); overload;
   procedure Add(AEventType: TPrismEventType; AOnEventProc: TOnEventProc; AAutoPublishedEvent: Boolean); overload;

   procedure Delete(AIndex: Integer);
   function Count: integer;
   function Item(AIndex: Integer): IPrismControlEvent; overload;
   function Item(AEventType: TPrismEventType): IPrismControlEvent; overload;
 end;


implementation

uses
  Prism.Util, Prism.Forms.Controls, Prism.Forms;

{ TPrismControlEvents }

procedure TPrismControlEvents.Add(AEvent: IPrismControlEvent);
begin
 if not Assigned(Item(AEvent.EventType)) then
 FEvents.Add(AEvent);
end;

procedure TPrismControlEvents.Add(AEventType: TPrismEventType;
  AEvent: TNotifyEvent);
var
 Event: TPrismControlEvent;
begin
 if not Assigned(Item(AEventType)) then
 begin
  Event:= TPrismControlEvent.Create(FIPrismControl, AEventType);
  Event.SetOnEvent(AEvent);
  Add(Event);
 end;
end;

procedure TPrismControlEvents.Add(AEventType: TPrismEventType;
  AOnEventProc: TOnEventProc);
var
 Event: TPrismControlEvent;
begin
 if not Assigned(Item(AEventType)) then
 begin
  Event:= TPrismControlEvent.Create(FIPrismControl, AEventType);
  Event.SetOnEvent(AOnEventProc);
  Add(Event);
 end;
end;

procedure TPrismControlEvents.Add(AEventType: TPrismEventType;
  AOnEventProc: TOnEventProc; AAutoPublishedEvent: Boolean);
var
 Event: TPrismControlEvent;
begin
 if not Assigned(Item(AEventType)) then
 begin
  Event:= TPrismControlEvent.Create(FIPrismControl, AEventType);
  Event.SetOnEvent(AOnEventProc);
  Event.AutoPublishedEvent:= AAutoPublishedEvent;
  Add(Event);
 end;
end;

function TPrismControlEvents.Count: integer;
begin
 Result:= FEvents.Count;
end;

constructor TPrismControlEvents.Create(AOwner: IPrismControl);
begin
 FIPrismControl:= AOwner;

 FEvents:= TList<IPrismControlEvent>.Create;
end;

procedure TPrismControlEvents.Delete(AIndex: Integer);
begin
 FEvents.Delete(AIndex);
end;

destructor TPrismControlEvents.Destroy;
var
 vIPrismControlEvent: IPrismControlEvent;
begin
 for vIPrismControlEvent in FEvents do
 try
  TPrismControlEvent(vIPrismControlEvent).Destroy;
 except
 end;

 FEvents.Clear;
 FEvents.Free;
 inherited;
end;

function TPrismControlEvents.Item(AEventType: TPrismEventType): IPrismControlEvent;
var I: integer;
begin
 for I := 0 to FEvents.Count-1 do
 if FEvents[I].EventType = AEventType then
 begin
  Result:= FEvents[I];
  break;
 end;
end;

function TPrismControlEvents.Item(AIndex: Integer): IPrismControlEvent;
begin
 Result:= FEvents.Items[AIndex];
end;


{ TPrismControlEvent }

procedure TPrismControlEvent.CallEvent(Parameters: TStrings);
begin
 if Assigned(FNotifyEvent) and Assigned(FPrismControl.VCLComponent) then
 begin
  if (MilliSecondsBetween(FLastCallEvent, now) >= MinCallBetweenEventMS) and (not FExecuting) then
  begin
   FLastCallEvent:= now;
   FExecuting:= true;
   try
    FNotifyEvent(FPrismControl.VCLComponent)
   finally
    FExecuting:= false;
   end;
  end;
 end else
 begin
  if Assigned(FOnEventProc) then
  begin
   if (MilliSecondsBetween(FLastCallEvent, now) >= MinCallBetweenEventMS) and (not FExecuting) then
   begin
    FLastCallEvent:= now;
    FExecuting:= true;
    try
     FOnEventProc(Parameters);
    finally
     FExecuting:= false;
    end;
   end;
  end else
   if (MilliSecondsBetween(FLastCallEvent, now) >= MinCallBetweenEventMS) and (not FExecuting) then
   begin
    FLastCallEvent:= now;
    try
     FExecuting:= true;
     FPrismControl.ProcessEvent(self, Parameters);
    finally
     FExecuting:= false;
    end;
   end;

  if Assigned(FPrismControl) and Assigned(FPrismControl.Form) and Assigned(FPrismControl.Session) and (not FPrismControl.Session.Closing) then
   begin
    TPrismForm(FPrismControl.Form).DoEventD2Bridge(FPrismControl as TPrismControl, EventType, Parameters);
   end;
 end;
end;

function TPrismControlEvent.CallEventResponse(Parameters: TStrings): string;
begin
 if Assigned(FGetStrEvent) then
 begin
  if (MilliSecondsBetween(FLastCallEvent, now) >= MinCallBetweenEventMS) and (not FExecuting) then
  begin
   FLastCallEvent:= now;
   try
    FExecuting:= true;
    Result:= FGetStrEvent;
   finally
    FExecuting:= false;
   end;
  end;
 end;

end;

constructor TPrismControlEvent.Create(AOwner: IPrismControl; AEventType: TPrismEventType);
begin
 FEventType := AEventType;
 FPrismControl := AOwner;

 FLastCallEvent:= now;
 FExecuting:= false;

 if AEventType in [EventOnClick, EventOnDblClick, EventOnChange, EventOnPrismControlEvent] then
  FAutoPublishedEvent:= true
 else
  FAutoPublishedEvent:= false;

 FEventID:= GenerateRandomString(19);
end;

destructor TPrismControlEvent.Destroy;
begin
 FOnEventProc:= nil;

 inherited;
end;

function TPrismControlEvent.EventJS(EventProc: TEventProcType = ExecEventProc; Parameters: String = ''; LockCLient: Boolean = false): string;
begin
 Result:= EventJS(PrismControl.Session, PrismControl.Form.FormUUID, EventProc, Parameters, LockCLient);
end;

function TPrismControlEvent.EventJS(ASession: IPrismSession; FormUUID: string; EventProc: TEventProcType; Parameters: String; LockCLient: Boolean): string;
var
 vEventProc : string;
begin
 Result:= '';

 if Parameters = '' then
  Parameters:= QuotedStr(Parameters);

 if ExecEventProc = EventProc then
  vEventProc:= 'ExecEvent'
 else
  vEventProc:= 'GetFromEventProc';

 Result:= Result + 'PrismServer().'+vEventProc + '(''' + ASession.UUID + ''', '''+ ASession.Token +''', '''+ FormUUID +''', ''' + PrismControl.Name + ''', ''' + EventID + ''', ' + Parameters + ', '''+ BoolToStr(LockCLient, true) +''');' ;

end;

function TPrismControlEvent.EventTypeName: string;
begin
 Result:= EventTypeToName(FEventType);
end;

function TPrismControlEvent.GetAutoPublishedEvent: Boolean;
begin
 result:= FAutoPublishedEvent;
end;

function TPrismControlEvent.GetEventID: String;
begin
 Result:= FEventID;
end;

function TPrismControlEvent.GetEventType: TPrismEventType;
begin
 Result:= FEventType;
end;


function TPrismControlEvent.GetPrismControl: IPrismControl;
begin
 Result:= FPrismControl;
end;

procedure TPrismControlEvent.SetAutoPublishedEvent(AAutoPublished: Boolean);
begin
 FAutoPublishedEvent:= AAutoPublished;
end;

procedure TPrismControlEvent.SetOnEvent(AOnEventProc: TOnEventProc);
begin
 FOnEventProc:= AOnEventProc;
end;

procedure TPrismControlEvent.SetOnEvent(AOnEvent: TPrismGetStrEvent);
begin
 FGetStrEvent:= AOnEvent;
end;

procedure TPrismControlEvent.SetOnEvent(AOnEvent: TNotifyEvent);
begin
 FNotifyEvent:= AOnEvent;
end;

end.
