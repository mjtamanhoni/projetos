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

unit Prism.Forms.Controls;

interface

uses
  System.Classes, System.SysUtils, System.Variants, System.JSON,
  Prism.Interfaces, Prism.Types,
  D2Bridge.Prism, D2Bridge.Lang.Interfaces, D2Bridge.Lang.Term, D2Bridge.Interfaces;


type
  TOnStateVisible = reference to procedure;

type
 TPrismControl = class(TComponent, IPrismControl)
  private
   FName: string;
   FHTMLControl: String;
   FHTMLCore: String;
   FUnformatedHTMLControl: String;
   FIPrismControlEvents: IPrismControlEvents;
   FVCLComponent: TComponent;
   FIsHidden: Boolean;
   FForm: IPrismForm;
   FStoredPlaceholder: String;
   FProcGetEnabled: TOnGetValue;
   FProcSetEnabled: TOnSetValue;
   FProcGetVisible: TOnGetValue;
   FProcSetVisible: TOnSetValue;
   FProcGetReadOnly: TOnGetValue;
   FProcSetReadOnly: TOnSetValue;
   FProcGetPlaceholder: TOnGetValue;
   FRefreshControl: Boolean;
   FTemplateControl: Boolean;
   FRequired: Boolean;
   FValidationGroup: Variant;
   FInitilized: Boolean;
   FIgnoreValueInInitialized: boolean;
   FD2BridgeItem: ID2BridgeItem;
   FPrismSession: IPrismSession;
   FUpdatable: Boolean;
   procedure SetName(AName: String); reintroduce;
   function GetName: String; reintroduce;
   function GetNamePrefix: String;
   function GetPlaceholder: String;
   function GetIsHidden: Boolean;
   procedure SetIsHidden(AIsHidden: Boolean);
   function GetValidationGroup: Variant;
   Procedure SetValidationGroup(AValidationGroup: Variant);
   procedure SetVCLComponent(AComponent: TComponent);
   function GetVCLComponent: TComponent;
   procedure SetForm(APrismForm: IPrismForm);
   function GetForm: IPrismForm;
   procedure SetHTMLControl(AHTMLControl: String);
   function GetHTMLControl: String;
   function GetUnformatedHTMLControl: String;
   function GetHTMLCore: string;
   procedure SetHTMLCore(AHTMLTag: String);
   function GetEvents: IPrismControlEvents;
   function GetTemplateControl: Boolean;
   procedure SetTemplateControl(AValue: Boolean);
   function GetD2BridgeItem: ID2BridgeItem;
   procedure SetD2BridgeItem(Value: ID2BridgeItem);
   function GetUpdatable: Boolean;
   procedure SetUpdatable(const Value: Boolean);
  protected
   FStoredEnabled: Boolean;
   FNewEnabled: Boolean;
   FStoredVisible: Boolean;
   FNewVisible: Boolean;
   FStoredReadOnly: Boolean;
   FNewReadOnly: Boolean;
   function RefreshControl: Boolean;
   procedure SetVisible(AVisible: Boolean); virtual;
   function GetVisible: Boolean; virtual;
   procedure SetEnabled(AEnabled: Boolean); virtual;
   function GetEnabled: Boolean; virtual;
   procedure SetReadOnly(AReadOnly: Boolean); virtual;
   function GetReadOnly: Boolean; virtual;
   function GetRequired: Boolean; virtual;
   procedure SetRequired(ARequired: Boolean); virtual;
   procedure ProcessEvent(Event: IPrismControlEvent; Parameters: TStrings); virtual;
   function ValidationGroupPassed: boolean; virtual;
   procedure FormatHTMLControl(AHTMLText: String); virtual;
   procedure RefreshHTMLControl;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); virtual;
   procedure UpdateData; virtual;
   procedure Refresh;
   function PrismOptions: IPrismOptions;
   procedure SetFocus;

   //**AS** PrismControls
   function AsButton: IPrismButton;
   function AsCheckBox: IPrismCheckBox;
   function AsCombobox: IPrismCombobox;
   function AsStringGrid: IPrismStringGrid;
   function AsMainMenu: IPrismMainMenu;
   function AsSideMenu: IPrismSideMenu;
   function AsKanban: IPrismKanban;

{$IFNDEF FMX}
   function AsDBGrid: IPrismDBGrid;
   function AsDBCheckBox: IPrismDBCheckBox;
   function AsDBCombobox: IPrismDBCombobox;
   function AsDBLookupCombobox: IPrismDBLookupCombobox;
   function AsDBEdit: IPrismDBEdit;
   function AsDBMemo: IPrismDBMemo;
   function AsDBText: IPrismDBText;
   function AsButtonedEdit: IPrismButtonedEdit;
   function AsCardDataModel: IPrismCardDataModel;
{$ENDIF}

   function AsEdit: IPrismEdit;
   function AsImage: IPrismImage;
   function AsHTMLElement: IPrismHTMLElement;
   function AsLink: IPrismLink;
   function AsQRCode: IPrismQRCode;
   function AsCarousel: IPrismCarousel;
   function AsMemo: IPrismMemo;
   function AsTabs: IPrismTabs;
   function AsControl: IPrismControl;
   function AsControlGeneric: IPrismControlGeneric;
   function AsCard: IPrismCard;
   function AsCardGridDataModel: IPrismCardGridDataModel;
   function AsCardModel: IPrismCardModel;

   //**IS** PrismControls
   function IsButton: Boolean; virtual;
   function IsCheckBox: Boolean; virtual;
   function IsCombobox: Boolean; virtual;
   function IsStringGrid: Boolean; virtual;

{$IFNDEF FMX}
   function IsDBGrid: Boolean; virtual;
   function IsDBCheckBox: Boolean; virtual;
   function IsDBCombobox: Boolean; virtual;
   function IsDBLookupCombobox: Boolean; virtual;
   function IsDBEdit: Boolean; virtual;
   function IsDBMemo: Boolean; virtual;
   function IsDBText: Boolean; virtual;
   function IsButtonedEdit: Boolean; virtual;
{$ENDIF}

   function IsEdit: Boolean; virtual;
   function IsLabel: Boolean; virtual;
   function IsImage: Boolean; virtual;
   function IsMemo: Boolean; virtual;
   function IsHTMLElement: Boolean; virtual;
   function IsLink: Boolean; virtual;
   function IsQRCode: Boolean; virtual;
   function IsCarousel: boolean; virtual;
   function IsTabs: boolean; virtual;
   function IsControl: Boolean; virtual;
   function IsControlGeneric: boolean; virtual;
   function IsCard: Boolean; virtual;
   function IsMainMenu: Boolean; virtual;
   function IsSideMenu: Boolean; virtual;
   function IsCardGridDataModel: boolean; virtual;
   function IsCardDataModel: boolean; virtual;
   function IsCardModel: boolean; virtual;
   function IsKanban: boolean; virtual;

   function NeedCheckValidation: Boolean; virtual;
   //function IsValidable: Boolean; virtual;

   function Lang: TD2BridgeTerm;
   function Session: IPrismSession;

   //Abstract
   procedure Initialize; virtual;
   function Initilized: boolean; virtual;
   function AlwaysInitialize: boolean; virtual;
   procedure ProcessHTML; virtual; abstract;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); virtual; abstract;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); virtual; abstract;
   function GetEnableComponentState: Boolean; virtual; abstract;

   //Events
   property ProcGetEnabled: TOnGetValue read FProcGetEnabled write FProcGetEnabled;
   property ProcSetEnabled: TOnSetValue read FProcSetEnabled write FProcSetEnabled;
   property ProcGetVisible: TOnGetValue read FProcGetVisible write FProcGetVisible;
   property ProcSetVisible: TOnSetValue read FProcSetVisible write FProcSetVisible;
   property ProcGetReadOnly: TOnGetValue read FProcGetReadOnly write FProcGetReadOnly;
   property ProcSetReadOnly: TOnSetValue read FProcSetReadOnly write FProcSetReadOnly;
   property ProcGetPlaceholder: TOnGetValue read FProcGetPlaceholder write FProcGetPlaceholder;

   //Property
   property Name: String read GetName write SetName;
   property NamePrefix: String read GetNamePrefix;
   property HTMLControl: String read GetHTMLControl write SetHTMLControl;
   property HTMLCore: String read GetHTMLCore write SetHTMLCore;
   property VCLComponent: TComponent read GetVCLComponent write SetVCLComponent;
   property TemplateControl: Boolean read GetTemplateControl write SetTemplateControl;
   property Events: IPrismControlEvents read GetEvents;
   property UnformatedHTMLControl: String read GetUnformatedHTMLControl;
   property Visible: Boolean read GetVisible write SetVisible;
   property Enabled: Boolean read GetEnabled write SetEnabled;
   property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
   property Placeholder: String read GetPlaceholder;
   property Required: Boolean read GetRequired write SetRequired;
   property ValidationGroup: Variant read GetValidationGroup write SetValidationGroup;
   property Hidden: Boolean read GetIsHidden write SetIsHidden;
   property Updatable: Boolean read GetUpdatable write SetUpdatable;
   property Form: IPrismForm read GetForm write SetForm;
   property D2BridgeItem: ID2BridgeItem read GetD2BridgeItem write SetD2BridgeItem;
 end;


implementation

uses
  Prism.Events, Prism.Util, Prism.Forms,
  Prism.Button, Prism.CheckBox, Prism.Combobox, Prism.Edit, Prism.Image, Prism.HTMLElement, Prism.Memo,
  Prism.StringGrid,
{$IFNDEF FMX}
  Prism.DBGrid, Prism.DBCheckBox, Prism.DBCombobox, Prism.DBEdit, Prism.DBMemo, Prism.DBText,
{$ENDIF}
  Prism.ControlGeneric, Prism.Link, Prism.Carousel, Prism.Session;


{ TPrismControl }

function TPrismControl.AlwaysInitialize: boolean;
begin
 result:= false;
end;

function TPrismControl.AsButton: IPrismButton;
begin
 result:= TPrismButton(self);
end;

function TPrismControl.AsCard: IPrismCard;
begin
 result := self as IPrismCard;
end;

{$IFNDEF FMX}
function TPrismControl.AsCardDataModel: IPrismCardDataModel;
begin
 result:= self as IPrismCardDataModel;
end;
{$ENDIF}

function TPrismControl.AsCardGridDataModel: IPrismCardGridDataModel;
begin
 result:= self as IPrismCardGridDataModel;
end;

function TPrismControl.AsCardModel: IPrismCardModel;
begin
 result:= self as IPrismCardModel;
end;

function TPrismControl.AsCarousel: IPrismCarousel;
begin
 result:= TPrismCarousel(self);
end;

function TPrismControl.AsCheckBox: IPrismCheckBox;
begin
 result:= TPrismCheckBox(self);
end;

function TPrismControl.AsCombobox: IPrismCombobox;
begin
 result:= TPrismCombobox(self);
end;

function TPrismControl.AsControl: IPrismControl;
begin
 result:= Self;
end;

function TPrismControl.AsControlGeneric: IPrismControlGeneric;
begin
 result:= self as IPrismControlGeneric;
end;

function TPrismControl.AsSideMenu: IPrismSideMenu;
begin
 result:= self as IPrismSideMenu;
end;

function TPrismControl.AsStringGrid: IPrismStringGrid;
begin
 result:= TPrismStringGrid(self);
end;

{$IFNDEF FMX}
function TPrismControl.AsDBCheckBox: IPrismDBCheckBox;
begin
 result:= TPrismDBCheckBox(self);
end;

function TPrismControl.AsDBCombobox: IPrismDBCombobox;
begin
 result:= TPrismDBCombobox(self);
end;

function TPrismControl.AsDBEdit: IPrismDBEdit;
begin
 result:= TPrismDBEdit(self);
end;

function TPrismControl.AsDBMemo: IPrismDBMemo;
begin
 result:= TPrismDBMemo(self);
end;

function TPrismControl.AsDBText: IPrismDBText;
begin
 result:= TPrismDBText(self);
end;

function TPrismControl.AsDBGrid: IPrismDBGrid;
begin
 result:= TPrismDBGrid(self);
end;

function TPrismControl.AsDBLookupCombobox: IPrismDBLookupCombobox;
begin
 result:= self as IPrismDBLookupCombobox;
end;

function TPrismControl.AsButtonedEdit: IPrismButtonedEdit;
begin
 result:= self as IPrismButtonedEdit;
end;
{$ENDIF}

function TPrismControl.AsEdit: IPrismEdit;
begin
 result:= TPrismEdit(self);
end;

function TPrismControl.AsHTMLElement: IPrismHTMLElement;
begin
 result:= TPrismHTMLElement(self);
end;

function TPrismControl.AsImage: IPrismImage;
begin
 result:= TPrismImage(self);
end;

function TPrismControl.AsKanban: IPrismKanban;
begin
 result:= Self as IPrismKanban;
end;

function TPrismControl.AsLink: IPrismLink;
begin
 result:= TPrismLink(self);
end;

function TPrismControl.AsMainMenu: IPrismMainMenu;
begin
 result:= self as IPrismMainMenu;
end;

function TPrismControl.AsMemo: IPrismMemo;
begin
 result:= TPrismMemo(self);
end;

function TPrismControl.AsQRCode: IPrismQRCode;
begin
 result:= self as IPrismQRCode;
end;

function TPrismControl.AsTabs: IPrismTabs;
begin
 result:= self as IPrismTabs;
end;

constructor TPrismControl.Create(AOwner: TComponent);
var
 vPrismForm: IPrismForm;
begin
  inherited;

  FHTMLControl:= '';
  FHTMLCore:= '';
  FUnformatedHTMLControl:= '';
  FStoredEnabled:= true;
  FStoredVisible:= true;
  FStoredReadOnly:= false;
  FRefreshControl:= false;
  FInitilized:= false;
  FTemplateControl:= false;
  FUpdatable:= true;

  FNewEnabled:= FStoredEnabled;
  FNewVisible:= FStoredVisible;
  FNewReadOnly:= FStoredReadOnly;

  FIgnoreValueInInitialized:= false;

  FIPrismControlEvents:= TPrismControlEvents.Create(self);

  if AOwner is TPrismSession then
   FPrismSession:= AOwner as TPrismSession;

  if Supports(AOwner, IPrismForm, vPrismForm) then
  begin
   vPrismForm.AddControl(self);
   FPrismSession:= vPrismForm.Session;
  end;
end;

destructor TPrismControl.Destroy;
begin
 if Assigned(FIPrismControlEvents) then
 begin
  TPrismControlEvents(FIPrismControlEvents).Destroy;
  FIPrismControlEvents:= nil;
 end;

 if Assigned(Self) then
 begin
  if Assigned(Form) and Assigned(Form.Controls) then
   Form.Controls.Remove(self);
 end;

 inherited;
end;

procedure TPrismControl.FormatHTMLControl(AHTMLText: String);
var
 PosInit, PosEnd: Integer;
 NameControlPosInit, NameControlPosEnd: Integer;
 vEnabled, vReadOnly, vVisible: boolean;
begin
 PosInit:= AnsiPos('{%'+ NamePrefix+' ', AHTMLText);
 if PosInit = 0 then
  PosInit:= AnsiPos('{%'+ NamePrefix+'%}', AHTMLText);
 PosEnd:= AnsiPos('%}', AHTMLText);

 NameControlPosInit:= PosInit+3;
 NameControlPosEnd:= NameControlPosInit + Length(NamePrefix);

 if (PosInit >= 1) and (PosEnd >= 1) then
 begin
  FUnformatedHTMLControl:= Copy(AHTMLText, PosInit, PosEnd+1);

  if (AnsiPos(' ID="'+AnsiUpperCase(NamePrefix)+'"', AnsiUpperCase(FUnformatedHTMLControl)) <= 0) then
  HTMLCore:= Copy(AHTMLText, NameControlPosEnd, PosEnd - NameControlPosEnd) + ' id="'+AnsiUpperCase(NamePrefix)+'" '
  else
  HTMLCore:= Copy(AHTMLText, NameControlPosEnd, PosEnd - NameControlPosEnd);

  //not Enabled
  vEnabled := Enabled;
  vReadOnly:= ReadOnly;
  vVisible:= Visible;

  if (not vEnabled) or vReadOnly then
  begin
   HTMLCore:= HTMLCore + 'disabled ';

   FStoredEnabled:= vEnabled;
   FStoredReadOnly:= vReadOnly;

   FIgnoreValueInInitialized:= true;
  end;

  //not Visible
  if not vVisible then
  begin
   HTMLCore:= HTMLAddItemFromClass(HTMLCore, 'invisible');

   FStoredVisible:= vVisible;

   FIgnoreValueInInitialized:= true;
  end;

//  //ReadOnly
//  if ReadOnly then
//  HTMLCore:= HTMLCore + 'disabled ';

  //Required
  if Required then
  HTMLCore:= HTMLCore + 'required ';

  //Validation Group
  if not VarIsEmpty(ValidationGroup) then
   HTMLCore:= HTMLCore + 'validationgroup="'+VarToStr(ValidationGroup)+'" ';

  //PlaceHolder
  if Placeholder <> '' then
   HTMLCore:= HTMLCore + 'placeholder="' + Placeholder + '" ';

  //Self.Initialize;

  //Call Event
  //TPrismForm(Form).D2BridgeForm.DoRenderPrismControl(self, FHTMLControl);

  //Self.ProcessHTML;
 end;
end;

function TPrismControl.GetD2BridgeItem: ID2BridgeItem;
begin
 Result:= FD2BridgeItem;
end;

function TPrismControl.GetEnabled: Boolean;
begin
 if Assigned(ProcGetEnabled) then
 Result:= ProcGetEnabled
 else
 Result:= FNewEnabled;
end;

function TPrismControl.GetEvents: IPrismControlEvents;
begin
 Result:= FIPrismControlEvents;
end;

function TPrismControl.GetForm: IPrismForm;
begin
 result:= FForm;
end;

function TPrismControl.GetPlaceholder: String;
begin
 if Assigned(ProcGetPlaceholder) then
  Result:= ProcGetPlaceholder
 else
  Result:= FStoredPlaceholder;
end;

function TPrismControl.GetHTMLControl: String;
begin
 Result:= FHTMLControl;
end;

function TPrismControl.GetHTMLCore: string;
begin
 Result:= FHTMLCore;
end;

function TPrismControl.GetIsHidden: Boolean;
begin
 Result:= FIsHidden;
end;

function TPrismControl.GetName: String;
begin
 Result:= FName;
end;

function TPrismControl.GetNamePrefix: String;
begin
 if (Form.ControlsPrefix <> '') and (FName <> '') then
  Result:= Form.ControlsPrefix+'_'+FName
 else
  Result:= FName;
end;

function TPrismControl.GetReadOnly: Boolean;
begin
 if Assigned(ProcGetReadOnly) then
  Result:= ProcGetReadOnly
 else
  Result:= FNewReadOnly;
end;

function TPrismControl.GetRequired: Boolean;
begin
 Result:= FRequired;
end;

function TPrismControl.GetTemplateControl: Boolean;
begin
 Result:= FTemplateControl;
end;

function TPrismControl.GetUnformatedHTMLControl: String;
begin
 Result:= FUnformatedHTMLControl;
end;


function TPrismControl.GetUpdatable: Boolean;
begin
 result:= FUpdatable;
end;

function TPrismControl.GetValidationGroup: Variant;
begin
 Result:= FValidationGroup;
end;

function TPrismControl.GetVCLComponent: TComponent;
begin
 Result:= FVCLComponent;
end;

function TPrismControl.GetVisible: Boolean;
begin
 if Assigned(ProcGetVisible) then
 Result:= ProcGetVisible
 else
 Result:= FNewVisible;
end;

procedure TPrismControl.Initialize;
begin
 if not FIgnoreValueInInitialized then
 begin
  FStoredEnabled:= Enabled;
  FStoredReadOnly:= ReadOnly;
  FStoredVisible:= Visible;
 end;

 FStoredPlaceholder:= Placeholder;

 //Call Event
 if not FInitilized or AlwaysInitialize then
  TPrismForm(Form).DoInitPrismControl(self);

 //FIgnoreValueInInitialized:= false;
 FInitilized:= true;
end;

function TPrismControl.Initilized: boolean;
begin
 result:= FInitilized;
end;

function TPrismControl.IsButton: Boolean;
begin
 result:= false;
end;

function TPrismControl.IsCard: Boolean;
begin
 result:= false;
end;

function TPrismControl.IsCardDataModel: boolean;
begin
 result:= false;
end;

function TPrismControl.IsCardGridDataModel: boolean;
begin
 result:= false;
end;

function TPrismControl.IsCardModel: boolean;
begin
 result:= false;
end;

function TPrismControl.IsCarousel: boolean;
begin
 result:= false;
end;

function TPrismControl.IsCheckBox: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsCombobox: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsControl: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsControlGeneric: boolean;
begin
 result:= false;
end;

function TPrismControl.IsSideMenu: Boolean;
begin
 result:= false;
end;

function TPrismControl.IsStringGrid: Boolean;
begin
 Result:= false;
end;

{$IFNDEF FMX}
function TPrismControl.IsDBCheckBox: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsDBCombobox: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsDBEdit: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsDBMemo: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsDBText: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsDBGrid: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsDBLookupCombobox: Boolean;
begin
 result:= false;
end;

function TPrismControl.IsButtonedEdit: Boolean;
begin
 Result:= false;
end;
{$ENDIF}

function TPrismControl.IsEdit: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsHTMLElement: Boolean;
begin
 result:= false;
end;

function TPrismControl.IsImage: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsKanban: boolean;
begin
 result:= false;
end;

function TPrismControl.IsLabel: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsLink: Boolean;
begin
 result:= false;
end;

function TPrismControl.IsMainMenu: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsMemo: Boolean;
begin
 Result:= false;
end;

function TPrismControl.IsQRCode: Boolean;
begin
 result:= false;
end;

function TPrismControl.IsTabs: boolean;
begin
 result:= false;
end;

function TPrismControl.Lang: TD2BridgeTerm;
begin
 Result:= FForm.Session.LangNav;
end;

function TPrismControl.NeedCheckValidation: Boolean;
begin
 Result:= False;
end;

function TPrismControl.PrismOptions: IPrismOptions;
begin
 Result:= Form.PrismOptions;
end;

procedure TPrismControl.ProcessEvent(Event: IPrismControlEvent;
  Parameters: TStrings);
begin

end;

procedure TPrismControl.Refresh;
begin
// inherited;

 FRefreshControl:= true;
end;

function TPrismControl.RefreshControl: Boolean;
begin
 Result:= FRefreshControl;
end;

procedure TPrismControl.RefreshHTMLControl;
begin
 FormatHTMLControl(UnformatedHTMLControl);
end;

function TPrismControl.Session: IPrismSession;
begin
 //result:= FForm.Session;
 result:= FPrismSession;
end;

procedure TPrismControl.SetD2BridgeItem(Value: ID2BridgeItem);
begin
 FD2BridgeItem:= Value;
end;

procedure TPrismControl.SetEnabled(AEnabled: Boolean);
begin
 if Assigned(ProcSetEnabled) then
 if FStoredEnabled <> AEnabled then
 begin
  ProcSetEnabled(AEnabled);
  FStoredEnabled:= AEnabled;
 end;

 FNewEnabled:= AEnabled;
end;

procedure TPrismControl.SetFocus;
begin
 if Visible and Enabled then
 begin
  Form.FocusedControl:= self;
  Form.Session.ExecJS
   (
     'if (document.querySelector("[id='+UpperCase(self.NamePrefix)+' i]") !== null) { ' +
     'document.querySelector("[id='+UpperCase(self.NamePrefix)+' i]").focus(); }',
     true
   )
 end;
end;

procedure TPrismControl.SetForm(APrismForm: IPrismForm);
begin
 FForm:= APrismForm;
 FPrismSession:= APrismForm.Session;
end;

procedure TPrismControl.SetHTMLControl(AHTMLControl: String);
begin
 FHTMLControl:= AHTMLControl;
end;

procedure TPrismControl.SetHTMLCore(AHTMLTag: String);
begin
 FHTMLCore:= AHTMLTag;
end;

procedure TPrismControl.SetIsHidden(AIsHidden: Boolean);
begin
 FIsHidden:= AIsHidden;
end;

procedure TPrismControl.SetName(AName: String);
begin
 FName:= AName;
end;


procedure TPrismControl.SetReadOnly(AReadOnly: Boolean);
begin
 if Assigned(ProcSetReadOnly) then
 if FStoredReadOnly <> AReadOnly then
 begin
  ProcSetReadOnly(AReadOnly);
  FStoredReadOnly:= AReadOnly;
 end;

 FNewReadOnly:= AReadOnly;
end;

procedure TPrismControl.SetRequired(ARequired: Boolean);
begin
 FRequired:= ARequired;
end;

procedure TPrismControl.SetTemplateControl(AValue: Boolean);
begin
 FTemplateControl := AValue;
end;

procedure TPrismControl.SetUpdatable(const Value: Boolean);
begin
 FUpdatable:= Value;
end;

procedure TPrismControl.SetValidationGroup(AValidationGroup: Variant);
begin
 FValidationGroup:= AValidationGroup;
end;

procedure TPrismControl.SetVCLComponent(AComponent: TComponent);
begin
 FVCLComponent:= AComponent;
 FVCLComponent.FreeNotification(self);
end;

procedure TPrismControl.SetVisible(AVisible: Boolean);
begin
 if Assigned(ProcSetVisible) then
 if FStoredVisible <> AVisible then
 begin
  ProcSetVisible(AVisible);
  FStoredVisible:= AVisible;
 end;

 FNewVisible:= AVisible;

 if FNewVisible then
  FHTMLCore:= HTMLRemoveItemFromClass(FHTMLCore, 'invisible')
 else
  FHTMLCore:= HTMLAddItemFromClass(FHTMLCore, 'invisible');
end;

procedure TPrismControl.UpdateData;
begin

end;

procedure TPrismControl.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewEnabled, NewVisible, NewReadOnly: Boolean;
 NewPlaceHolder: string;
begin
 {$REGION 'Enabled'}
  NewEnabled:= Enabled;
  if FStoredEnabled <> NewEnabled then
  begin
   //Enabled := NewEnabled;
   FStoredEnabled:= NewEnabled;

   if NewEnabled then
   begin
    ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").disabled = false;');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).removeClass("disabled");');
   end else
   begin
    ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").disabled = true;');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).addClass("disabled");');
   end;
  end;
 {$ENDREGION}

 {$REGION 'Visible'}
  NewVisible:= Visible;
  if FStoredVisible <> NewVisible then
  begin
   //Visible := NewVisible;
   FStoredVisible:= NewVisible;

   if NewVisible then
   begin
    //ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").classList.remove("invisible");');
    ScriptJS.Add('let _displayincontrol'+AnsiUpperCase(NamePrefix)+' = ($("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).css("display") === "none");');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).show();');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).removeClass("invisible");');
    ScriptJS.Add('if (_displayincontrol'+AnsiUpperCase(NamePrefix)+' === true) {');
    ScriptJS.Add('  $("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).css("display", "");');
    ScriptJS.Add('}');

    FHTMLCore:= HTMLRemoveItemFromClass(FHTMLCore, 'invisible');
   end else
   begin
    //ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").classList.add("invisible");');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).hide();');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).addClass("invisible");');
    FHTMLCore:= HTMLAddItemFromClass(FHTMLCore, 'invisible');
   end;
  end;
 {$ENDREGION}


 {$REGION 'ReadOnly'}
  NewReadOnly:= ReadOnly;
  if FStoredReadOnly <> NewReadOnly then
  begin
   //ReadOnly := NewReadOnly;
   FStoredReadOnly:= NewReadOnly;

   if NewReadOnly then
    ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").disabled = true;')
   else
   if NewEnabled then
    ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").disabled = false;')
  end;
 {$ENDREGION}


 {$REGION 'PlaceHolder'}
  NewPlaceHolder:= PlaceHolder;
  if FStoredPlaceHolder <> NewPlaceHolder then
  begin
   FStoredPlaceHolder:= NewPlaceHolder;

   ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").setAttribute("placeholder", "' + FStoredPlaceHolder + '");');
  end;
 {$ENDREGION}


 if FRefreshControl then
  TPrismForm(Form).D2BridgeForm.DoRenderPrismControl(self, FHTMLControl);

 FRefreshControl:= false;
end;

function TPrismControl.ValidationGroupPassed: boolean;
begin
 result:= true;
end;

end.
