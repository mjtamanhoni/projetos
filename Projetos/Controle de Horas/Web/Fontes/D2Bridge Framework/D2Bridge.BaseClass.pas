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

{$I D2Bridge.inc}

unit D2Bridge.BaseClass;

interface

uses
  System.Classes, System.Generics.Collections, System.Threading, System.SysUtils,
{$IFDEF FMX}
  FMX.Forms,
{$ELSE}
  Vcl.Forms,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Types, D2Bridge.HTML, D2Bridge.HTML.CSS, D2Bridge.Render.HTMLType, D2Bridge.Util,
  D2Bridge.Lang.Interfaces, D2Bridge.Lang.Core, D2Bridge.Lang.Term, D2Bridge.Lang.APP.Term, D2Bridge.Lang.APP.Core,
  D2Bridge.Render, Prism.Session, Prism.Types,
  Prism.Interfaces, Prism.BaseClass.Sessions;

type
 TD2BridgeClass = class
 strict private
  type
   D2BridgeOptions = class
   private
    FEnableHTMLRender: Boolean;
   public
    constructor Create;
    property EnableHTMLRender: Boolean read FEnableHTMLRender write FEnableHTMLRender;
   end;
 private
  FAOwner: TComponent;
  //FRender: TD2BridgeRender;
  FToken: String;
  //FIWAppForm: TIWAppForm;
//  FHTMLText: TStringList;
  FRenderHTMLType: ID2BridgeHTMLType;//TD2BridgeHTMLType;
  FFrameworkExportType: ID2BridgeFrameworkType;
  FEnableControlsPrefix: Boolean;
  FOptions: D2BridgeOptions;
  FHTML: TD2BridgeHTML;
  FEnableLoader: Boolean;
  FPrismSession: TPrismSession;
  FControlIDs: TDictionary<string, integer>;
  FD2BridgeNested: TList<TD2BridgeClass>;
  FD2BridgePopups: TList<ID2BridgeItemHTMLPopup>;
  FD2BridgeOwner: TD2BridgeClass;
  FExportedControls: TDictionary<string,ID2BridgeItem>;
  FValidateAllControls: Boolean;
  FTempCallBacks: IPrismFormCallBacks;
  FVCLStyles: Boolean;
  FPrismControlToRegister: TList<IPrismControl>;
//  FD2BridgeItems: TD2BridgeItems;
  function GetBaseClass: TD2BridgeClass;
  function GetFrameworkForm: ID2BridgeFrameworkForm;
  function GetFormObject: TObject;
  function GetVersion: string;
  function GetRootDirectory: string;
  function GetEnableControlsPrefix: Boolean;
  procedure SetEnableControlsPrefix(const Value: Boolean);
 public
  var
   FormUUID: string;
   ControlsPrefix: string;
   FIsNested: boolean;
  Const
   PrefixAuxComponent = '_D2B';
  constructor Create(FormOwner: TComponent);
  destructor Destroy; override;

  function Lang: TD2BridgeTerm;
  function LangNav: TD2BridgeTerm;
  function LangAPPIsPresent: Boolean;
  function LangAPP: TD2BridgeAPPTerm;
  function Language: TD2BridgeLang;
  function LangName: string;
  function LangCode: string;

  function CreateItemID(AClassName: String): string;

  Procedure AddNested(AD2BridgeForm: TObject; ANestedName: string = '');
  function Nested(Index: Integer): TD2BridgeClass;
  function NestedCount: Integer;
  function isNestedContext: boolean;

  Procedure AddPopup(AD2BridgeItemHTMLPopup: ID2BridgeItemHTMLPopup);
  function Popup(Index: Integer): ID2BridgeItemHTMLPopup; overload;
  function Popup(AName: string): ID2BridgeItemHTMLPopup; overload;
  function PopupCount: Integer;

  function GetD2BridgeManager: ID2BridgeManager;
  procedure RenderD2Bridge(Itens: TList<ID2BridgeItem>); overload;
  procedure RenderD2Bridge(Itens: TList<ID2BridgeItem>; HTMLBody: TStrings); overload;
  procedure RenderD2Bridge(AD2BridgeItem: ID2BridgeItem); overload;

  function Prefix: String;

  function PrismControlFromVCLObj(VCLItem: TObject): IPrismControl;
  function PrismControlFromID(AItemID: String): IPrismControl;

  procedure Validation(VCLItem: TObject; AIsValid: Boolean; AMessage: String = '');
  procedure RemoveValidation(VCLItem: TObject);

  procedure UpdateD2BridgeControl(VCLItem: TObject);
  procedure UpdateD2BridgeAllControls;

  function Base64FromFile(AFile: string): string;
  function Base64ImageFromFile(AFile: string): string;

  function CallBackJS(ACallBackName: String; Parameters: String = ''; LockClient: Boolean = false): string; overload;
  Procedure RegisterCallBack(AName: String; ACallBackEventProc: TCallBackEvent);
  function CallBacks: IPrismFormCallBacks;
  function TempCallBacks: IPrismFormCallBacks;

  function PrismControlToRegister: TList<IPrismControl>;

  function API: ID2BridgeAPI;
  function CSSClass: TCSSClass;

  function Sessions: TPrismSessions;
 published
  //property IWAppForm : TIWAppForm read FIWAppForm write FIWAppForm;
  //property Form : ID2BridgeFrameworkForm read GetForm;
  property PrismSession: TPrismSession read FPrismSession write FPrismSession;
  property D2BridgeManager: ID2BridgeManager read GetD2BridgeManager;
  property FrameworkForm: ID2BridgeFrameworkForm read GetFrameworkForm;
  property Form: TObject read GetFormObject;
  property Owner : TComponent read FAOwner;
  property FormAOwner : TComponent read FAOwner;
  property ExportedControls: TDictionary<string,ID2BridgeItem> read FExportedControls write FExportedControls;
//  property HTMLText : TStringList read FHTMLText write FHTMLText;
  property RenderHTMLType : ID2BridgeHTMLType read FRenderHTMLType;
  property FrameworkExportType: ID2BridgeFrameworkType read FFrameworkExportType;
  property BaseClass: TD2BridgeClass read GetBaseClass;
  property Options: D2BridgeOptions read FOptions;
  property HTML: TD2BridgeHTML read FHTML;
  //property Render: TD2BridgeRender read Frender;
  property Token: String read FToken write FToken;
  property EnableLoader: Boolean read FEnableLoader write FEnableLoader;
  property ControlIDs: TDictionary<string, integer> read FControlIDs write FControlIDs;
  property EnableControlsPrefix: Boolean read GetEnableControlsPrefix write SetEnableControlsPrefix;
  property D2BridgeOwner: TD2BridgeClass read FD2BridgeOwner write FD2BridgeOwner;
  property RootDirectory: string read GetRootDirectory;
  property Version: string read GetVersion;
  property VCLStyles: boolean read FVCLStyles write FVCLStyles;
 end;

implementation


uses
  D2Bridge.Forms, D2Bridge.Manager, D2Bridge.Prism, D2Bridge.Prism.Form, Prism.CallBack, Prism.Util;
{$IFDEF D2BRIDGE}

{$ELSE}

{$ENDIF}


{ TD2BridgeClass }

procedure TD2BridgeClass.AddNested(AD2BridgeForm: TObject; ANestedName: string);
var
 AD2BridgeClassForm: TD2BridgeClass;
begin
{$IFDEF FMX}
  AD2BridgeClassForm:= TD2BridgeClass(TD2BridgeForm(AD2BridgeForm).D2Bridge);
{$ELSE}
  AD2BridgeClassForm:= TD2BridgeForm(AD2BridgeForm).D2Bridge;
{$ENDIF}

 if not FD2BridgeNested.Contains(AD2BridgeClassForm) then
 begin
  if ANestedName <> '' then
   TD2BridgeForm(AD2BridgeClassForm.FormAOwner).NestedName:= ANestedName
  else
   TD2BridgeForm(AD2BridgeClassForm.FormAOwner).NestedName:= TD2BridgeForm(AD2BridgeClassForm.FormAOwner).Name;

  AD2BridgeClassForm.D2BridgeOwner:= self;
  AD2BridgeClassForm.FIsNested:= true;

  AD2BridgeClassForm.EnableControlsPrefix:= true;
  TD2BridgeForm(AD2BridgeClassForm.FormAOwner).Clear;
  TD2BridgeForm(AD2BridgeClassForm.FormAOwner).Render;

  FD2BridgeNested.Add(AD2BridgeClassForm);

  if PrismSession.D2BridgeForms.Contains(AD2BridgeClassForm) then
  PrismSession.D2BridgeForms.Remove(AD2BridgeClassForm);
 end;
end;

procedure TD2BridgeClass.AddPopup(
  AD2BridgeItemHTMLPopup: ID2BridgeItemHTMLPopup);
begin
 FD2BridgePopups.Add(AD2BridgeItemHTMLPopup);
end;

function TD2BridgeClass.API: ID2BridgeAPI;
begin
 result:= D2BridgeManager.API;
end;

function TD2BridgeClass.Base64FromFile(AFile: string): string;
begin
 result:= D2Bridge.Util.Base64FromFile(AFile);
end;

function TD2BridgeClass.Base64ImageFromFile(AFile: string): string;
begin
 result:= D2Bridge.Util.Base64ImageFromFile(AFile);
end;

function TD2BridgeClass.CallBackJS(ACallBackName, Parameters: String;
  LockClient: Boolean): string;
begin
 Result:= PrismSession.CallBacks.CallBackJS(ACallBackName, true, '', Parameters, LockClient);
end;

function TD2BridgeClass.CallBacks: IPrismFormCallBacks;
var
 vPrismForm: IPrismForm;
begin
 if Supports(GetFormObject, IPrismForm, vPrismForm) then
  result:= vPrismForm.CallBacks
 else
 begin
  if not Assigned(FTempCallBacks) then
   FTempCallBacks:= TPrismFormCallBacks.Create(FormUUID, nil, PrismSession);

  Result:= FTempCallBacks;
 end;
end;

constructor TD2BridgeClass.Create(FormOwner: TComponent);
begin
 FAOwner:= FormOwner;

 FIsNested:= false;

 FEnableControlsPrefix:= false;

 FormUUID:= GenerateRandomString(14);
 ControlsPrefix:= GenerateRandomJustString(7);

 //FD2BridgeItems:= TD2BridgeItems.Create(self);
 FRenderHTMLType:= TD2BridgeHTMLBootStrap.create;
 FOptions:= D2BridgeOptions.Create;
 FHTML:= TD2BridgeHTML.create(self);
 FHTML.Options.ValidateAllControls:= D2BridgeManager.Prism.Options.ValidateAllControls;
 FVCLStyles:= D2BridgeManager.Prism.Options.VCLStyles;

 //FRender:= TD2BridgeRender.Create(BaseClass);
 FToken:= GenerateRandomString(16);
 FEnableLoader:= true;

 FControlIDs:= TDictionary<string, integer>.Create;

 FD2BridgeNested:= TList<TD2BridgeClass>.Create;
 FD2BridgePopups:= TList<ID2BridgeItemHTMLPopup>.Create;
 FPrismControlToRegister:= TList<IPrismControl>.Create;

 FExportedControls:= TDictionary<string,ID2BridgeItem>.Create;

 {$IFDEF D2BRIDGE}
  if TD2BridgeManager(D2BridgeManager).FrameworkExportTypeClass = TD2BridgePrismFramework then
  FFrameworkExportType:= TD2BridgePrismFramework.Create(self);

  FFrameworkExportType.TemplateMasterHTMLFile:= D2BridgeManager.TemplateMasterHTMLFile;
  FFrameworkExportType.TemplatePageHTMLFile:= D2BridgeManager.TemplatePageHTMLFile;
 {$ELSE}

 {$ENDIF}
end;

function TD2BridgeClass.CreateItemID(AClassName: String): string;
var
 I: Integer;
begin
 if AClassName = '' then
 AClassName:= 'D2BridgeControl';

 if ControlIDs.TryGetValue(AClassName, I) then
  Inc(I)
 else
  I:= 1;

 ControlIDs.AddOrSetValue(AClassName, I);

 Result:= AClassName + IntToStr(I);
end;

function TD2BridgeClass.CSSClass: TCSSClass;
begin
 Result:= D2BridgeManager.CSSClass;
end;

destructor TD2BridgeClass.Destroy;
begin
 if Assigned(FTempCallBacks) then
 begin
  TPrismFormCallBacks(FTempCallBacks).Destroy;
  FTempCallBacks:= nil;
 end;

 FreeAndNil(FOptions);

 if FRenderHTMLType is TD2BridgeHTMLBootStrap then
 begin
  TD2BridgeHTMLBootStrap(FRenderHTMLType).Destroy;
  FRenderHTMLType:= nil;
 end;


 if FFrameworkExportType is TD2BridgePrismFramework then
 begin
  if Assigned(FFrameworkExportType) then
   TD2BridgePrismFramework(FFrameworkExportType).Destroy;
  FFrameworkExportType:= nil;
 end;


 FPrismControlToRegister.Clear;
 FPrismControlToRegister.Destroy;

 FreeAndNil(FHTML);

 FControlIDs.Clear;
 FreeAndNil(FControlIDs);

 FD2BridgeNested.Clear;
 FreeAndNil(FD2BridgeNested);

 FD2BridgePopups.Clear;
 FreeAndNil(FD2BridgePopups);

// for vID2BridgeItem in FExportedControls.Values do
//  if Supports(vID2BridgeItem, ID2BridgeItem, vD2BridgeItem) then
//   if vD2BridgeItem <> nil then
//    FreeAndNil(vD2BridgeItem);
 try
 //FExportedControls.Clear;
 FreeAndNil(FExportedControls);
 except
 end;

 inherited;
end;

function TD2BridgeClass.GetBaseClass: TD2BridgeClass;
begin
 result:= self;
end;


function TD2BridgeClass.GetD2BridgeManager: ID2BridgeManager;
begin
 Result:= D2Bridge.Manager.D2BridgeManager;
end;

function TD2BridgeClass.GetEnableControlsPrefix: Boolean;
begin
 result:= FEnableControlsPrefix;
end;

function TD2BridgeClass.GetFormObject: TObject;
begin
 result:= nil;

 if Assigned(FrameworkExportType) then
  if Assigned(FrameworkExportType.Form) then
   Result:= FrameworkExportType.Form;
end;

function TD2BridgeClass.GetFrameworkForm: ID2BridgeFrameworkForm;
begin
 Result:= FrameworkExportType.FrameworkForm;
end;

function TD2BridgeClass.GetRootDirectory: string;
begin
 Result:= D2BridgeManager.Prism.Options.RootDirectory;
end;

function TD2BridgeClass.GetVersion: string;
begin
 Result:= D2BridgeManager.Version;
end;

function TD2BridgeClass.isNestedContext: boolean;
begin
  result:= FIsNested;
end;

function TD2BridgeClass.Lang: TD2BridgeTerm;
begin
 Result:= PrismSession.Lang;
end;

function TD2BridgeClass.LangAPP: TD2BridgeAPPTerm;
begin
 if LangAPPIsPresent then
 begin
  {$IFDEF D2BRIDGE}
   Result:= TD2BridgeAPPTerm(D2BridgeLangAPPCore.LangByTD2BridgeLang(Language));
  {$ELSE}
   Result:= TD2BridgeAPPTerm(D2BridgeLangAPPCore.LangByTD2BridgeLang(English));
  {$ENDIF}
 end;
end;

function TD2BridgeClass.LangAPPIsPresent: Boolean;
begin
 Result:= Assigned(D2BridgeLangAPPCore);
end;

function TD2BridgeClass.LangCode: string;
begin
 Result:= PrismSession.LangCode;
end;

function TD2BridgeClass.LangName: string;
begin
 Result:= PrismSession.LangName;
end;

function TD2BridgeClass.LangNav: TD2BridgeTerm;
begin
 Result:= PrismSession.LangNav;
end;

function TD2BridgeClass.Language: TD2BridgeLang;
begin
 Result:= PrismSession.Language;
end;

function TD2BridgeClass.Nested(Index: Integer): TD2BridgeClass;
begin
 Result:= FD2BridgeNested[Index];
end;

function TD2BridgeClass.NestedCount: Integer;
begin
 Result:= FD2BridgeNested.Count;
end;

function TD2BridgeClass.Popup(Index: Integer): ID2BridgeItemHTMLPopup;
begin
 Result:= FD2BridgePopups[Index];
end;

function TD2BridgeClass.Popup(AName: string): ID2BridgeItemHTMLPopup;
var
 vPopup: ID2BridgeItemHTMLPopup;
begin
 result:= nil;

 for vPopup in FD2BridgePopups do
  if SameText(vPopup.ItemID, AName)  then
  begin
   Result:= vPopup;
   break;
  end;
end;

function TD2BridgeClass.PopupCount: Integer;
begin
 Result:= FD2BridgePopups.Count;
end;

function TD2BridgeClass.Prefix: String;
begin
 Result:= ControlsPrefix; //TD2BridgePrismForm(FrameworkForm).ControlsPrefix;
end;

function TD2BridgeClass.PrismControlFromID(AItemID: String): IPrismControl;
var
 FPrismControl: IPrismControl;
 I: Integer;
begin
 FPrismControl:= nil;
 Result:= nil;

 try
  if Assigned(FrameworkForm) then
  begin
   for I := 0 to Pred(TD2BridgePrismForm(FrameworkForm).Controls.Count) do
   begin
    if SameText(TD2BridgePrismForm(FrameworkForm).Controls[I].Name, AItemID) then
    begin
     Result:= TD2BridgePrismForm(FrameworkForm).Controls.Items[I];

     break;
    end;
   end;
  end;
 except
 end;

end;

function TD2BridgeClass.PrismControlFromVCLObj(VCLItem: TObject): IPrismControl;
var
 FPrismControl: IPrismControl;
 I: Integer;
begin
 FPrismControl:= nil;
 Result:= nil;

 if Assigned(FrameworkForm) then
 begin
  for I := 0 to Pred(TD2BridgePrismForm(FrameworkForm).Controls.Count) do
  begin
   if (Assigned(TD2BridgePrismForm(FrameworkForm).Controls[I].VCLComponent)) and
      (TD2BridgePrismForm(FrameworkForm).Controls[I].VCLComponent = VCLItem) then
   begin
    Result:= TD2BridgePrismForm(FrameworkForm).Controls.Items[I];

    break;
   end;
  end;
 end;
end;

function TD2BridgeClass.PrismControlToRegister: TList<IPrismControl>;
begin
 result:= FPrismControlToRegister;
end;

procedure TD2BridgeClass.UpdateD2BridgeAllControls;
begin
 PrismSession.ExecJS('UpdateD2BridgeControls(PrismComponents)');
end;

procedure TD2BridgeClass.UpdateD2BridgeControl(VCLItem: TObject);
var
 vPrismControl: IPrismControl;
begin
 vPrismControl := PrismControlFromVCLObj(VCLItem);

 if Assigned(vPrismControl) then
 begin
  vPrismControl.Refresh;

  if Assigned(vPrismControl) then
  begin
   PrismSession.ExecJS('UpdateD2BridgeControls([PrismComponents.find(obj => obj.id === "' + AnsiUpperCase(vPrismControl.NamePrefix) + '")])');
  end;
 end;
end;

procedure TD2BridgeClass.RegisterCallBack(AName: String;
  ACallBackEventProc: TCallBackEvent);
begin
 CallBacks.Register(AName, ACallBackEventProc);
end;

procedure TD2BridgeClass.RemoveValidation(VCLItem: TObject);
var
 vPrismControl: IPrismControl;
begin
 vPrismControl := PrismControlFromVCLObj(VCLItem);

 if Assigned(vPrismControl) then
 begin
  PrismSession.ExecJS('removeValidationFeedback("'+ AnsiUpperCase(vPrismControl.NamePrefix) +'")');
 end;
end;

procedure TD2BridgeClass.RenderD2Bridge(Itens: TList<ID2BridgeItem>; HTMLBody: TStrings);
var
 vBegin, vEnd, I: integer;
begin
 vBegin:= TD2BridgeClass(BaseClass).HTML.Render.Body.Count;

 RenderD2Bridge(Itens);

 vEnd:= TD2BridgeClass(BaseClass).HTML.Render.Body.Count;

 if vBegin < vEnd then
 begin
  for I := vBegin to Pred(vEnd) do
   HTMLBody.Add(TD2BridgeClass(BaseClass).HTML.Render.Body.Strings[I]);

  for I := Pred(vEnd) downto vBegin do
   TD2BridgeClass(BaseClass).HTML.Render.Body.Delete(I)
 end;
end;

procedure TD2BridgeClass.RenderD2Bridge(AD2BridgeItem: ID2BridgeItem);
var
 FRender: TD2BridgeRender;
 vItens: TList<ID2BridgeItem>;
begin
 FRender:= TD2BridgeRender.Create(Self);
 vItens:= TList<ID2BridgeItem>.Create;
 vItens.Add(AD2BridgeItem);
 FRender.RenderD2Bridge(vItens);
 FreeAndNil(FRender);
 vItens.Clear;
 FreeAndNil(vItens);
end;

function TD2BridgeClass.Sessions: TPrismSessions;
begin
 result:= D2BridgeManager.Prism.Sessions as TPrismSessions;
end;

procedure TD2BridgeClass.SetEnableControlsPrefix(const Value: Boolean);
begin
 FEnableControlsPrefix:= Value;
end;

function TD2BridgeClass.TempCallBacks: IPrismFormCallBacks;
begin
 result:= FTempCallBacks;
end;

procedure TD2BridgeClass.RenderD2Bridge(Itens: TList<ID2BridgeItem>);
var
 FRender: TD2BridgeRender;
begin
 FRender:= TD2BridgeRender.Create(Self);
 FRender.RenderD2Bridge(Itens);
 FreeAndNil(FRender);
end;

procedure TD2BridgeClass.Validation(VCLItem: TObject; AIsValid: Boolean;
  AMessage: String);
var
 vPrismControl: IPrismControl;
begin
 vPrismControl := PrismControlFromVCLObj(VCLItem);

 if Assigned(vPrismControl) then
 begin
  PrismSession.ExecJS('insertValidationFeedback("'+ AnsiUpperCase(vPrismControl.NamePrefix) +'", ' + BoolToStr(AIsValid, True).ToLower + ', "' + AMessage + '")');
 end;
end;

{ TD2BridgeClass.D2BridgeOptions }

constructor TD2BridgeClass.D2BridgeOptions.Create;
begin
 FEnableHTMLRender:= true;
end;

end.
