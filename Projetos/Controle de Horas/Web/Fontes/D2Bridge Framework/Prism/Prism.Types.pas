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

unit Prism.Types;

interface

uses
  System.Classes, System.TypInfo, System.Rtti
{$IFDEF FMX}
  , FMX.Graphics
{$ENDIF}
  ;

type
 TPrismEventType = (EventNone = 0, EventOnClick, EventOnDblClick, EventOnSelectAll, EventOnUnselectAll, EventOnLoadJSON, EventOnSelect, EventOnCellClick,
                    EventOnCheckChange, EventOnCheck, EventOnUncheck, EventOnEnter, EventOnExit, EventOnChange, EventOnKeyDown, EventOnKeyUp,
                    EventOnKeyPress, EventOnButtonClick,
                    EventOnFocused, EventOnCellPost, EventOnCellButtonClick,
                    EventOnItemClick,
                    EventOnShowPopup, EventOnClosePopup,
                    EventOnLeftClick, EventOnRightClick,
                    EventOnDragStart, EventOnDragEnd,
                    EventOnPrismControlEvent);

 TWebMethod = (wmtGET, wmtPOST, wmtHEAD);

{$IFDEF FMX}
type
  TPicture = TBitmap;

  TJPEGImage = TBitmap;
{$ENDIF}

type
  TOnEventProc = reference to procedure(EventParams: TStrings);
  TOnSetValue = reference to procedure(AValue: Variant);
  TOnGetValue = reference to function: Variant;
  TOnGetStrings = reference to function: TStrings;
  TCallBackEvent = reference to function(EventParams: TStrings): string;

type
  TPrismGetEvent = function: Variant of object;
  TPrismGetStrEvent = function: String of object;
  TOnTagHTML = procedure(const TagString: string; var ReplaceTag: string) of object;
  TOnPopup = reference to function(APopupName: String): string;
  TOnUpload = procedure(AFiles: TStrings; Sender: TObject) of object;

type
 TPrismAlignment =
   (PrismAlignNone = 0,
   PrismAlignLeft,
   PrismAlignRight,
   PrismAlignCenter,
   PrismAlignJustified);

type
 TPrismPosition =
   (PrismPositionLeft = 0,
   PrismPositionRight,
   PrismPositionTop,
   PrismPositionBottom);

type
 TPrismPageState =
   (PageStateUnloaded = 0,
    PageStateLoading,
    PageStateLoaded);

 type
  TEventProcType =
    (ExecEventProc = 0,
     GetFromEventProc);

 type
  TPrismFieldType =
   (PrismFieldTypeAuto = 0,
    PrismFieldTypeString,
    PrismFieldTypePassword,
    PrismFieldTypeInteger,
    PrismFieldTypeNumber,
    PrismFieldTypeDate,
    PrismFieldTypeDateTime,
    PrismFieldTypeTime);

 type
  TPrismFieldModel =
   (PrismFieldModelNone = 0,
    PrismFieldModelField,
    PrismFieldModelCombobox,
    PrismFieldModelCheckbox,
    PrismFieldModelLookup,
    PrismFieldModelButton,
    PrismFieldModelHTML);

 type
  TCheckBoxType =
   (CBSwitchType);


 type
  TWebSocketMessageType =
    (wsNone = 0,
     wsMsgCallBack,
     wsMsgFunction,
     wsMsgProcedure,
     wsMsgText,
     wsMsgHeartbeat);

  type
   TSessionConnectionStatus =
    (scsNone = 0,
     scsNewSession,
     scsCloseSession,
     scsActiveSession,
     scsClosingSession,
     scsExpireSession,
     scsStabilizedConnectioSession,
     scsLostConnectioSession,
     scsReconnectedSession,
     scsIdleSession,
     scsActivitySession,
     scsDestroySession);
   TSessionChangeType =  TSessionConnectionStatus;

 type
  TextMaskModel =
    (TextMaskModelCNPJ = 0,
     TextMaskModelCPF);

 type
  TSecurityEvent =
    (secBlockBlackList = 0,
     secDelistIPBlackList,
     secNotDelistIPBlackList,
     secBlockUserAgent,
     secBlockIPLimitConn,
     secBlockIPLimitSession);


type
 TSecuritEventInfo = record
  IP: string;
  IsIPV6: boolean;
  UserAgent: string;
  Event: TSecurityEvent;
 end;



function EventJSName(PrismEventType: TPrismEventType): string;


//Enum
function EnumToString(EnumType: PTypeInfo; Value: Integer): string;

function StringToEnum(EnumType: PTypeInfo; const Str: string): Integer;

function EventTypeToName(AEventType: TPrismEventType): string;

implementation


function EventJSName(PrismEventType: TPrismEventType): string;
begin
 if PrismEventType = EventOnClick then
  result:= 'click'
 else
 if PrismEventType = EventOnDblClick then
  result:= 'dblclick'
 else
 if PrismEventType = EventOnKeyDown then
  result:= 'keydown'
 else
 if PrismEventType = EventOnKeyUp then
  result:= 'keyup'
 else
 if PrismEventType = EventOnKeyPress then
  result:= 'keypress'
 else
 if PrismEventType = EventOnChange then
  result:= 'input'
 else
 if PrismEventType = EventOnCheckChange then
  result:= 'change'
 else
 if PrismEventType = EventOnSelect then
  result:= 'input'
end;


function EnumToString(EnumType: PTypeInfo; Value: Integer): string;
begin
  Result := GetEnumName(EnumType, Value);
  //Uses EnumToString(TypeInfo(TPrismEventType), Ord(APrismForm.Controls[I].Events.Item(Z).EventType))
end;

function StringToEnum(EnumType: PTypeInfo; const Str: string): Integer;
begin
  Result := GetEnumValue(EnumType, Str);
end;


function EventTypeToName(AEventType: TPrismEventType): string;
begin
 Result:= TRttiEnumerationType.GetName(AEventType);

 if Pos('Event', Result) = 1 then
  Result:= Copy(Result, 6);
end;

end.
