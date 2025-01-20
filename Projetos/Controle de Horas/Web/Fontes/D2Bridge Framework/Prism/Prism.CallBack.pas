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

unit Prism.CallBack;

interface

uses
  System.Classes, System.Generics.Collections, System.SysUtils,
  Prism.Interfaces, Prism.Types;


type
 TPrismCallBack = class(TInterfacedPersistent, IPrismCallBack)
  private
   FName: String;
   FCallBackEvent: TCallBackEvent;
   FID: String;
   FCallBackJS: String;
   FResponse: String;
   FPrismForm: IPrismForm;
   FParameters: string;
   procedure SetName(AName: String);
   function GetName: String;
   function GetCallBackEvent: TCallBackEvent;
   procedure SetCallBackEvent(AValue: TCallBackEvent);
   function GetCallBackID: String;
   function GetPrismForm: IPrismForm;
   procedure SetPrismForm(APrismForm: IPrismForm);
  public
   constructor Create(AName: String; AParameters: string; APrismForm: IPrismForm; ACallBackEventProc: TCallBackEvent);

   function Execute(EventParams: TStrings): string;
   function GetResponse: string;
   function DefaultParameters: string;

   property Name: String read GetName write SetName;
   property CallBackEvent: TCallBackEvent read GetCallBackEvent write SetCallBackEvent;
   property ID: String read GetCallBackID;
   property Response: String read GetResponse;
   property PrismForm: IPrismForm read GetPrismForm write SetPrismForm;
 end;


 TPrismCallBacks = class(TInterfacedPersistent, IPrismCallBacks)
  private
   FItems: TDictionary<string, IPrismCallBack>;
   FSession: IPrismSession;
   Function GetCallBacks: TDictionary<string, IPrismCallBack>;
  public
   constructor Create(APrismSession: IPrismSession);
   destructor Destroy; override;

   procedure Add(APrismCallBack: IPrismCallBack);
   Procedure Register(AName: String; APrismForm: IPrismForm; ACallBackEventProc: TCallBackEvent); overload;
   Procedure Register(AName: String; APrismForm: IPrismForm); overload;
   Procedure Register(AName: String; Parameters: String; APrismForm: IPrismForm); overload;
   procedure Register(ACallback: IPrismCallBack; APrismForm: IPrismForm); overload;
   procedure Unregister(AName: String);
   procedure UnRegisterAll(APrismForm: IPrismForm);
   function GetCallBack(AName: String; APrismForm: IPrismForm): IPrismCallBack; overload;
   function GetCallBack(AName, FormUUID: String): IPrismCallBack; overload;
   function Execute(AName, FormUUID: String; EventParams: TStrings): string;
   function CallBackJS(ACallBackName: String; AFormUUID: String = ''; Parameters: String = ''; LockClient: Boolean = false): string; overload;
   function CallBackJS(ACallBackName: String; AReturnFalse: Boolean = true; AFormUUID: String = ''; Parameters: String = ''; LockClient: Boolean = false): string; overload;
   function CallBackDirectJS(ACallBackName, AFormUUID: String; Parameters: String = ''; LockClient: Boolean = false): string; overload;
   function CallBackDirectJS(ACallBack: IPrismCallBack; AFormUUID: String; Parameters: String = ''; LockCLient: Boolean = false): string; overload;

   property Items: TDictionary<string, IPrismCallBack> read GetCallBacks;
 end;


 TPrismFormCallBacks = class(TInterfacedPersistent, IPrismFormCallBacks)
  private
   FPrismForm: IPrismForm;
   FFormUUID: string;
   FPrismSession: IPrismSession;
   FTempCallBacks: TDictionary<string, IPrismCallBack>;
  public
   constructor Create(AFormUUID: string; APrismForm: IPrismForm; APrismSession: IPrismSession);
   destructor Destroy; override;

   Procedure Register(AName: String; ACallBackEventProc: TCallBackEvent); overload;
   Procedure Register(AName: String; Parameters: String = ''); overload;
   function GetCallBack(AName: String): IPrismCallBack;
   procedure Unregister(AName: String);

   function CallBackJS(ACallBackName: String; Parameters: String = ''; LockClient: Boolean = false): string;

   function TempCallBacks: TDictionary<string, IPrismCallBack>;
   procedure ConsolideTempCallBacks(APrismFormToConsolide: IPrismForm);
 end;



implementation

uses
  Prism.Util,
  D2Bridge.Manager;

{ TPrismCallBack }


constructor TPrismCallBack.Create(AName: String; AParameters: string; APrismForm: IPrismForm; ACallBackEventProc: TCallBackEvent);
begin
 FName:= AName;
 FCallBackEvent:= ACallBackEventProc;
 FParameters:= AParameters;
 FPrismForm:= APrismForm;
 FID:= GenerateRandomString(18);
end;

function TPrismCallBack.Execute(EventParams: TStrings): string;
begin
 if Assigned(FCallBackEvent) then
  Result:= FCallBackEvent(EventParams)
 else
 if Assigned(FPrismForm) then
  FPrismForm.DoCallBack(FName, EventParams);

 FResponse:= Result;
end;

function TPrismCallBack.GetCallBackEvent: TCallBackEvent;
begin
 Result:= FCallBackEvent;
end;

function TPrismCallBack.GetCallBackID: String;
begin
 Result:= FID;
end;

function TPrismCallBack.GetName: String;
begin
 Result:= FName;
end;

function TPrismCallBack.GetPrismForm: IPrismForm;
begin
 Result:= FPrismForm;
end;

function TPrismCallBack.GetResponse: string;
begin
 Result:= FResponse;
end;

function TPrismCallBack.DefaultParameters: string;
begin
 Result:= FParameters;
end;

procedure TPrismCallBack.SetCallBackEvent(AValue: TCallBackEvent);
begin
 FCallBackEvent:= AValue;
end;

procedure TPrismCallBack.SetName(AName: String);
begin
 FName:= AName;
end;


procedure TPrismCallBack.SetPrismForm(APrismForm: IPrismForm);
begin
 FPrismForm:= APrismForm;
end;

{ TPrismCallBacks }



procedure TPrismCallBacks.Add(APrismCallBack: IPrismCallBack);
begin
 FItems.AddOrSetValue(APrismCallBack.ID, APrismCallBack);
end;


function TPrismCallBacks.CallBackDirectJS(ACallBackName, AFormUUID: String; Parameters: String = ''; LockClient: Boolean = false): string;
var
 vCallBack: IPrismCallBack;
begin
 Result:= '';

 vCallBack:= GetCallBack(ACallBackName, AFormUUID);

 Result:= CallBackDirectJS(vCallBack, AFormUUID, Parameters, LockClient);
end;


function TPrismCallBacks.CallBackDirectJS(ACallBack: IPrismCallBack; AFormUUID, Parameters: String; LockCLient: Boolean): string;
begin
 Result:= '';

 if Parameters <> '' then
 begin
  if (POS('''[',Parameters) = 1) and (POS(']''',Parameters) = (Length(Parameters)-1)) then
   Parameters:= Copy(Parameters, 3, Length(Parameters)-4);
 end;

 if Assigned(ACallBack) then
 if Parameters = '' then
  Parameters:= QuotedStr(ACallBack.DefaultParameters);

 if Parameters = '' then
  Parameters:= QuotedStr(Parameters);

 if Assigned(ACallBack) then
 begin
  Result:= Result + 'PrismServer().CallBack('''+FSession.UUID+''', '''+ FSession.Token +''', '''+ AFormUUID +''', ''' + ACallBack.ID + ''', ' + Parameters + ', '''+ BoolToStr(LockClient, true) +''');  return false;' ;
 end;

end;

function TPrismCallBacks.CallBackJS(ACallBackName, AFormUUID, Parameters: String; LockClient: Boolean): string;
begin
 result:= CallBackJS(ACallBackName, true, AFormUUID, Parameters, LockClient);
end;

function TPrismCallBacks.CallBackJS(ACallBackName: String; AReturnFalse: Boolean = true; AFormUUID: String = ''; Parameters: String = ''; LockClient: Boolean = false): string;
begin
 if AFormUUID = '' then
  AFormUUID:= FSession.ActiveForm.FormUUID;

 Result:= CallBackDirectJS(ACallBackName, AFormUUID, Parameters, LockClient);

 if not AReturnFalse then
  Result:= StringReplace(Result, ' return false;', '', []);
end;

constructor TPrismCallBacks.Create(APrismSession: IPrismSession);
begin
 FSession:= APrismSession;
 FItems:= TDictionary<string, IPrismCallBack>.Create;
end;

destructor TPrismCallBacks.Destroy;
var
 vIPrismCallBack: IPrismCallBack;
begin
 for vIPrismCallBack in FItems.Values do
  if Assigned(vIPrismCallBack) then
  begin
   TPrismCallBack(vIPrismCallBack).Destroy;
  end;
 FItems.Clear;
 FreeAndNil(FItems);

 inherited;
end;

function TPrismCallBacks.Execute(AName, FormUUID: String; EventParams: TStrings): string;
var
 vPrismCallBack: IPrismCallBack;
begin
 vPrismCallBack:= GetCallBack(AName, FormUUID);

 if Assigned(vPrismCallBack) then
 begin
  Result:= vPrismCallBack.Execute(EventParams);
 end;
end;

function TPrismCallBacks.GetCallBack(AName: String;
  APrismForm: IPrismForm): IPrismCallBack;
begin
 Result:= GetCallBack(AName, APrismForm.FormUUID);
end;

function TPrismCallBacks.GetCallBack(AName, FormUUID: String): IPrismCallBack;
var
 I: Integer;
begin
 for I := 0 to Pred(Items.Count) do
  if SameText(AName, Items.Values.ToArray[I].Name) and (FormUUID = Items.Values.ToArray[I].PrismForm.FormUUID) then
  begin
   Result:= Items.Values.ToArray[I];
   break;
  end;
end;

function TPrismCallBacks.GetCallBacks: TDictionary<string, IPrismCallBack>;
begin
 Result:= FItems;
end;

procedure TPrismCallBacks.Register(ACallback: IPrismCallBack; APrismForm: IPrismForm);
var
 APrismCallBack: TPrismCallBack;
begin
 APrismCallBack:= TPrismCallBack.Create(ACallback.Name, '', APrismForm, ACallback.CallBackEvent);
 APrismCallBack.FID:= ACallback.ID;
 FItems.AddOrSetValue(APrismCallBack.ID, APrismCallBack);
end;

procedure TPrismCallBacks.Register(AName: String; APrismForm: IPrismForm);
begin
 Register(AName, '', APrismForm);
end;

Procedure TPrismCallBacks.Register(AName: String; APrismForm: IPrismForm; ACallBackEventProc: TCallBackEvent);
var
 APrismCallBack: TPrismCallBack;
begin
 APrismCallBack := GetCallBack(AName, APrismForm) as TPrismCallBack;

 if not Assigned(APrismCallBack) then
  APrismCallBack:= TPrismCallBack.Create(AName, '', APrismForm, ACallBackEventProc)
 else
 if Assigned(ACallBackEventProc) then
  APrismCallBack.CallBackEvent:= ACallBackEventProc
 else
  APrismCallBack.CallBackEvent:= Nil;

 FItems.AddOrSetValue(APrismCallBack.ID, APrismCallBack);
end;

procedure TPrismCallBacks.Unregister(AName: String);
var
 vPrismCallBack: IPrismCallBack;
 vNames: TList<string>;
 I: Integer;
begin
 try
  vNames:= TList<string>.Create(FItems.Keys);

  for I := 0 to Pred(vNames.Count) do
  begin
   if FItems.ContainsKey(vNames[I]) then
   begin
    vPrismCallBack:= FItems[vNames[I]];
    if (vPrismCallBack.Name = AName) then
    begin
     FItems.Remove(vNames[I]);
     (vPrismCallBack as TPrismCallBack).Destroy;
     vPrismCallBack:= nil;
     break;
    end;
   end;
  end;

  vNames.Free;
 except
 end;

end;

procedure TPrismCallBacks.UnRegisterAll(APrismForm: IPrismForm);
var
 vPrismCallBack: IPrismCallBack;
 vNames: TList<string>;
 I: Integer;
begin
 try
   if Assigned(APrismForm) then
   begin
    vNames:= TList<string>.Create(FItems.Keys);

    for I := 0 to Pred(vNames.Count) do
    begin
     if FItems.ContainsKey(vNames[I]) then
     begin
      vPrismCallBack:= FItems[vNames[I]];
      if Assigned(vPrismCallBack.PrismForm) and
         (vPrismCallBack.PrismForm = APrismForm) then
      begin
       FItems.Remove(vNames[I]);
       (vPrismCallBack as TPrismCallBack).Destroy;
       vPrismCallBack:= nil;
      end;
     end;
    end;

    vNames.Free;
   end;
 except
 end;
end;

procedure TPrismCallBacks.Register(AName, Parameters: String;
  APrismForm: IPrismForm);
var
 APrismCallBack: TPrismCallBack;
begin
 APrismCallBack:= TPrismCallBack.Create(AName, Parameters, APrismForm, nil);
 FItems.AddOrSetValue(APrismCallBack.ID, APrismCallBack);
end;

{ TPrismFormCallBacks }

function TPrismFormCallBacks.CallBackJS(ACallBackName, Parameters: String;
  LockClient: Boolean): string;
begin
 if Assigned(FPrismForm) then
  result:= FPrismForm.Session.CallBacks.CallBackJS(ACallBackName, true, FPrismForm.FormUUID, Parameters, LockClient)
 else
 begin
  if FTempCallBacks.ContainsKey(ACallBackName) then
  begin
   result:= FPrismSession.CallBacks.CallBackDirectJS(FTempCallBacks[ACallBackName], FFormUUID, Parameters, LockClient);
  end;
 end;
end;

procedure TPrismFormCallBacks.ConsolideTempCallBacks(APrismFormToConsolide: IPrismForm);
var
 vIPrismCallBack: IPrismCallBack;
begin
 if Assigned(APrismFormToConsolide) then
 begin
  // Percorrendo o dicion�rio
  for vIPrismCallBack in FTempCallBacks.Values do
  begin
   FPrismSession.CallBacks.Register(vIPrismCallBack, APrismFormToConsolide);
//   if Assigned(vIPrismCallBack.CallBackEvent) then
//    APrismFormToConsolide.CallBacks.Register(vIPrismCallBack.Name, vIPrismCallBack.CallBackEvent)
//   else
//    APrismFormToConsolide.CallBacks.Register(vIPrismCallBack.Name, vIPrismCallBack.DefaultParameters);
  end;

  FTempCallBacks.Clear;
 end;
end;

constructor TPrismFormCallBacks.Create(AFormUUID: string; APrismForm: IPrismForm; APrismSession: IPrismSession);
begin
 FFormUUID:= AFormUUID;
 FPrismForm:= APrismForm;
 FPrismSession:= APrismSession;

 FTempCallBacks:= TDictionary<string, IPrismCallBack>.Create;
end;

procedure TPrismFormCallBacks.Register(AName: String;
  ACallBackEventProc: TCallBackEvent);
begin
 if Assigned(FPrismForm) then
  FPrismForm.Session.CallBacks.Register(AName, FPrismForm, ACallBackEventProc)
 else
  FTempCallBacks.Add(AName, TPrismCallBack.Create(AName, '', nil, ACallBackEventProc));
end;

destructor TPrismFormCallBacks.Destroy;
var
 vIPrismCallBack: IPrismCallBack;
begin
 for vIPrismCallBack in FTempCallBacks.Values do
  if Assigned(vIPrismCallBack) then
  begin
   TPrismCallBack(vIPrismCallBack).Destroy;
  end;
 FTempCallBacks.Clear;
 FreeAndNil(FTempCallBacks);

 inherited;
end;

function TPrismFormCallBacks.GetCallBack(AName: String): IPrismCallBack;
begin
 result:= FPrismForm.Session.CallBacks.GetCallBack(AName, FPrismForm);
end;

procedure TPrismFormCallBacks.Register(AName: String; Parameters: String = '');
begin
 if Assigned(FPrismForm) then
  FPrismForm.Session.CallBacks.Register(AName, Parameters, FPrismForm)
 else
  FTempCallBacks.Add(AName, TPrismCallBack.Create(AName, Parameters, nil, nil));
end;

function TPrismFormCallBacks.TempCallBacks: TDictionary<string, IPrismCallBack>;
begin
 Result:= FTempCallBacks;
end;

procedure TPrismFormCallBacks.Unregister(AName: String);
begin
 FPrismForm.Session.CallBacks.Unregister(AName);
end;

end.
