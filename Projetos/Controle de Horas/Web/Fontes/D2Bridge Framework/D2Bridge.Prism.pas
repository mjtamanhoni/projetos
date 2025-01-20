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

unit D2Bridge.Prism;

interface

uses
  System.Classes,
  D2Bridge.Interfaces, D2Bridge.BaseClass,
  Prism.Types, Prism.Interfaces;

//type
// TD2BridgeFrameworkTypeClass = class;

type
 TPrismEventType = Prism.Types.TPrismEventType;


type
 TD2BridgeFrameworkTypeClass = class of TD2BridgePrismFramework;

 TD2BridgePrismFramework = class(TInterfacedPersistent, ID2BridgeFrameworkType)
  private
    FBaseClass: TD2BridgeClass;
    //FPrism: TPrism;
    FFrameworkForm: ID2BridgeFrameworkForm;
    FTemplateMasterHTMLFile: string;
    FTemplatePageHTMLFile: string;
    FButton: ID2BridgeFrameworkItemButton;
    FEdit: ID2BridgeFrameworkItemEdit;
    FLabel: ID2BridgeFrameworkItemLabel;
    FCheckBox: ID2BridgeFrameworkItemCheckBox;
    FStringGrid: ID2BridgeFrameworkItemStringGrid;

{$IFNDEF FMX}
    FDBGrid: ID2BridgeFrameworkItemDBGrid;
    FDBCheckBox: ID2BridgeFrameworkItemDBCheckBox;
    FDBText: ID2BridgeFrameworkItemDBText;
    FDBEdit: ID2BridgeFrameworkItemDBEdit;
    FDBMemo: ID2BridgeFrameworkItemDBMemo;
    FDBCombobox: ID2BridgeFrameworkItemDBCombobox;
    FDBLookupCombobox: ID2BridgeFrameworkItemDBLookupCombobox;
    FButtonedEdit: ID2BridgeFrameworkItemButtonedEdit;
{$ENDIF}

    FCombobox: ID2BridgeFrameworkItemCombobox;
    FImage: ID2BridgeFrameworkItemImage;
    FMemo: ID2BridgeFrameworkItemMemo;

    FMainMenu: ID2BridgeFrameworkItemMainMenu;
    Function GetPrism: IPrismBaseClass;
  public
    constructor Create(ABaseClass: TObject);
    destructor Destroy; override;

    procedure CreateForm(AOwner: TComponent);

    function FormClass: TClass;
    function GetForm: TObject;
    function FormShowing: Boolean;
    procedure SetForm(Value: TObject);

    procedure SetTemplateMasterHTMLFile(AFileMasterTemplate: string);
    procedure SetTemplatePageHTMLFile(AFilePageTemplate: string);
    function GetTemplateMasterHTMLFile: string;
    function GetTemplatePageHTMLFile: string;

    procedure AddFormByClass(FormClass: TClass; AOwner: TComponent);

    procedure ShowLoader;
    procedure HideLoader;

    function Text: ID2BridgeFrameworkItemLabel;
    function Edit: ID2BridgeFrameworkItemEdit;
    function Button: ID2BridgeFrameworkItemButton;
    function CheckBox: ID2BridgeFrameworkItemCheckBox;
    function StringGrid: ID2BridgeFrameworkItemStringGrid;

{$IFNDEF FMX}
    function DBGrid: ID2BridgeFrameworkItemDBGrid;
    function DBCheckBox: ID2BridgeFrameworkItemDBCheckBox;
    function DBLookupCombobox: ID2BridgeFrameworkItemDBLookupCombobox;
    function DBEdit: ID2BridgeFrameworkItemDBEdit;
    function DBText: ID2BridgeFrameworkItemDBText;
    function DBCombobox: ID2BridgeFrameworkItemDBCombobox;
    function DBMemo: ID2BridgeFrameworkItemDBMemo;
    function ButtonedEdit: ID2BridgeFrameworkItemButtonedEdit;
{$ENDIF}

    function Combobox: ID2BridgeFrameworkItemCombobox;
    function Image: ID2BridgeFrameworkItemImage;
    function Memo: ID2BridgeFrameworkItemMemo;

    function MainMenu: ID2BridgeFrameworkItemMainMenu;

    function FrameworkForm: ID2BridgeFrameworkForm;

    //Event
    Procedure OnAddHTMLControls(AName: String; ANamePrefix: String; HTMLText: String);

    property Form: TObject read GetForm;
    property TemplateMasterHTMLFile: string read GetTemplateMasterHTMLFile write SetTemplateMasterHTMLFile;
    property TemplatePageHTMLFile: string read GetTemplatePageHTMLFile write SetTemplatePageHTMLFile;
    property BaseClass: TD2BridgeClass read FBaseClass;

    property Prism: IPrismBaseClass read GetPrism;
 end;


implementation

uses
  System.SysUtils, System.Rtti,
  D2Bridge.Prism.Form, D2Bridge.Manager, D2Bridge.Prism.Button, D2Bridge.Prism.Edit,
  Prism.Forms, D2Bridge.Prism.Combobox, D2Bridge.Prism.CheckBox, D2Bridge.Prism.Text,
  D2Bridge.Prism.StringGrid, D2Bridge.Prism.MainMenu,
{$IFNDEF FMX}
  D2Bridge.Prism.DBGrid, D2Bridge.Prism.DBCombobox, D2Bridge.Prism.DBLookupCombobox,
  D2Bridge.Prism.DBMemo, D2Bridge.Prism.DBEdit, D2Bridge.Prism.DBText, D2Bridge.Prism.DBCheckBox,
  D2Bridge.Prism.ButtonedEdit,
{$ENDIF}
  D2Bridge.Prism.Image, D2Bridge.Prism.Memo;

{ TD2BridgePrismFramework }

procedure TD2BridgePrismFramework.AddFormByClass(FormClass: TClass;
  AOwner: TComponent);
var
  RttiContext: TRttiContext;
  FormInstanceType: TRttiInstanceType;
  PrismAppFormObject: TObject;
begin
 if Supports(FormClass, ID2BridgeFrameworkForm) then
 begin
  RttiContext := TRttiContext.Create;
  try
    FormInstanceType := RttiContext.GetType(FormClass).AsInstance;
    PrismAppFormObject := FormInstanceType.GetMethod('Create').Invoke(FormInstanceType.MetaclassType, [AOwner, self]).AsObject;
    Supports(PrismAppFormObject, ID2BridgeFrameworkForm, FFrameworkForm);
    FFrameworkForm.SetBaseClass(BaseClass);
    if FTemplateMasterHTMLFile <> '' then
    TPrismForm(FFrameworkForm).TemplateMasterHTMLFile := FTemplateMasterHTMLFile;
    if FTemplatePageHTMLFile <> '' then
    TPrismForm(FFrameworkForm).TemplatePageHTMLFile := FTemplatePageHTMLFile;
  finally
    RttiContext.Free;
  end;
 end;

end;

function TD2BridgePrismFramework.Button: ID2BridgeFrameworkItemButton;
begin
 Result:= FButton;
end;

function TD2BridgePrismFramework.CheckBox: ID2BridgeFrameworkItemCheckBox;
begin
 Result:= FCheckBox;
end;

function TD2BridgePrismFramework.Combobox: ID2BridgeFrameworkItemCombobox;
begin
 Result:= FCombobox;
end;

constructor TD2BridgePrismFramework.Create(ABaseClass: TObject);
begin
 FBaseClass:= TD2BridgeClass(ABaseClass);
 FBaseClass.HTML.Render.OnAddHTMLControls:= OnAddHTMLControls;

 //FPrism:= TPrism.Create(TD2BridgeClass(ABaseClass).Owner);
 FLabel:= PrismLabel.Create(self);
 FButton:= PrismButton.Create(Self);
 FEdit:= PrismEdit.Create(Self);
 FCheckBox:= PrismCheckBox.Create(Self);
 FStringGrid:= PrismStringGrid.create(Self);
{$IFNDEF FMX}
 FDBCheckBox:= PrismDBCheckBox.Create(Self);
 FDBText:= PrismDBText.Create(Self);
 FDBEdit:= PrismDBEdit.Create(Self);
 FDBGrid:= PrismDBGrid.create(Self);
 FDBMemo:= PrismDBMemo.create(Self);
 FDBCombobox:= PrismDBCombobox.Create(Self);
 FDBLookupCombobox:= PrismDBLookupCombobox.Create(Self);
 FButtonedEdit:= PrismButtonedEdit.Create(Self);
{$ENDIF}
 FCombobox:= PrismCombobox.Create(Self);
 FImage := PrismImage.Create(Self);
 FMemo:= PrismMemo.Create(Self);
 FMainMenu:= PrismMainMenu.Create(Self);

 FTemplateMasterHTMLFile:= '';
 FTemplatePageHTMLFile:= '';
end;

procedure TD2BridgePrismFramework.CreateForm(AOwner: TComponent);
begin
 {$IFDEF D2BRIDGE}
  FFrameworkForm:= TD2BridgePrismForm.Create(AOwner, self);
 {$ELSE}

 {$ENDIF}

end;

function TD2BridgePrismFramework.StringGrid: ID2BridgeFrameworkItemStringGrid;
begin
 Result:= FStringGrid;
end;

{$IFNDEF FMX}
function TD2BridgePrismFramework.DBCheckBox: ID2BridgeFrameworkItemDBCheckBox;
begin
 Result:= FDBCheckBox;
end;

function TD2BridgePrismFramework.DBCombobox: ID2BridgeFrameworkItemDBCombobox;
begin
 Result:= FDBCombobox;
end;

function TD2BridgePrismFramework.DBEdit: ID2BridgeFrameworkItemDBEdit;
begin
 Result:= FDBEdit;
end;

function TD2BridgePrismFramework.DBGrid: ID2BridgeFrameworkItemDBGrid;
begin
 Result:= FDBGrid;
end;

function TD2BridgePrismFramework.DBLookupCombobox: ID2BridgeFrameworkItemDBLookupCombobox;
begin
 Result:= FDBLookupCombobox;
end;

function TD2BridgePrismFramework.DBMemo: ID2BridgeFrameworkItemDBMemo;
begin
 Result:= FDBMemo;
end;

function TD2BridgePrismFramework.DBText: ID2BridgeFrameworkItemDBText;
begin
 Result:= FDBText;
end;

function TD2BridgePrismFramework.ButtonedEdit: ID2BridgeFrameworkItemButtonedEdit;
begin
 Result:= FButtonedEdit;
end;
{$ENDIF}

destructor TD2BridgePrismFramework.Destroy;
begin
 FBaseClass.HTML.Render.OnAddHTMLControls:= nil;

 PrismLabel(FLabel).Destroy;
 FLabel:= nil;
 PrismButton(FButton).Destroy;
 FButton:= nil;
 PrismEdit(FEdit).Destroy;
 FEdit:= nil;
 PrismCheckBox(FCheckBox).Destroy;
 FCheckBox:= nil;
 PrismStringGrid(FStringGrid).Destroy;
 FStringGrid:= nil;
{$IFNDEF FMX}
 PrismDBCheckBox(FDBCheckBox).Destroy;
 FDBCheckBox:= nil;
 PrismDBEdit(FDBEdit).Destroy;
 FDBEdit:= nil;
 PrismDBGrid(FDBGrid).Destroy;
 FDBGrid:= nil;
 PrismDBMemo(FDBMemo).Destroy;
 FDBMemo:= nil;
 PrismDBCombobox(FDBCombobox).Destroy;
 FDBCombobox:= nil;
 PrismDBText(FDBText).Destroy;
 FDBText:= nil;
 PrismDBLookupCombobox(FDBLookupCombobox).Destroy;
 FDBLookupCombobox:= nil;
 PrismButtonedEdit(FButtonedEdit).Destroy;
 FButtonedEdit:= nil;
{$ENDIF}
 PrismCombobox(FCombobox).Destroy;
 FCombobox:= nil;
 PrismImage(FImage).Destroy;
 FImage:= nil;
 PrismMemo(FMemo).Destroy;
 FMemo:= nil;
 PrismMainMenu(FMainMenu).Destroy;
 FMainMenu:= nil;

 if Assigned(FFrameworkForm) then
 begin
  TD2BridgePrismForm(FFrameworkForm).Destroy;
  FFrameworkForm:= nil;
 end;

 inherited;
end;

function TD2BridgePrismFramework.Edit: ID2BridgeFrameworkItemEdit;
begin
 Result:= FEdit;
end;

function TD2BridgePrismFramework.FormClass: TClass;
begin
 Result:= TPrismForm;
end;

function TD2BridgePrismFramework.FormShowing: Boolean;
begin
 Result:= FBaseClass.PrismSession.D2BridgeBaseClassActive = FBaseClass;
end;

function TD2BridgePrismFramework.FrameworkForm: ID2BridgeFrameworkForm;
begin
 result:= FFrameworkForm;
end;

function TD2BridgePrismFramework.GetForm: TObject;
begin
 if Assigned(FFrameworkForm) then
 Result:= FFrameworkForm as TPrismForm
 else
  Result:= nil;
end;

Function TD2BridgePrismFramework.GetPrism: IPrismBaseClass;
begin
 Result:= BaseClass.D2BridgeManager.Prism;
end;

function TD2BridgePrismFramework.GetTemplateMasterHTMLFile: string;
begin
 Result:= FTemplateMasterHTMLFile;
end;

function TD2BridgePrismFramework.GetTemplatePageHTMLFile: string;
begin
 Result:= FTemplatePageHTMLFile;
end;

procedure TD2BridgePrismFramework.HideLoader;
begin

end;

function TD2BridgePrismFramework.Image: ID2BridgeFrameworkItemImage;
begin
 Result := FImage;
end;

function TD2BridgePrismFramework.MainMenu: ID2BridgeFrameworkItemMainMenu;
begin
 Result:= FMainMenu;
end;

function TD2BridgePrismFramework.Memo: ID2BridgeFrameworkItemMemo;
begin
 Result:= FMemo;
end;

procedure TD2BridgePrismFramework.OnAddHTMLControls(AName, ANamePrefix, HTMLText: String);
var
 I: Integer;
begin
 for I:= 0 to TPrismForm(Form).Controls.Count-1 do
 begin
  if SameText(TPrismForm(Form).Controls[I].Name, AName) and SameText(TPrismForm(Form).Controls[I].NamePrefix, ANamePrefix) then
  begin
   TPrismForm(Form).Controls[I].FormatHTMLControl(HTMLText);
   break;
  end;
 end;
end;

procedure TD2BridgePrismFramework.SetForm(Value: TObject);
begin
 Supports(Value, ID2BridgeFrameworkForm, FFrameworkForm);
 FFrameworkForm.SetBaseClass(BaseClass);
end;

procedure TD2BridgePrismFramework.SetTemplateMasterHTMLFile(
  AFileMasterTemplate: string);
begin
 FTemplateMasterHTMLFile:= AFileMasterTemplate;
end;

procedure TD2BridgePrismFramework.SetTemplatePageHTMLFile(
  AFilePageTemplate: string);
begin
 FTemplatePageHTMLFile:= AFilePageTemplate;
end;

procedure TD2BridgePrismFramework.ShowLoader;
begin

end;

function TD2BridgePrismFramework.Text: ID2BridgeFrameworkItemLabel;
begin
 Result:= FLabel;
end;

end.
