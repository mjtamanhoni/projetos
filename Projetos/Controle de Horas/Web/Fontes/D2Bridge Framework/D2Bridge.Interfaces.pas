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

unit D2Bridge.Interfaces;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.JSON, System.UITypes,
  Data.DB,
{$IFDEF FMX}
  FMX.Menus, FMX.Objects, FMX.Graphics, FMX.Types, FMX.Grid,
{$ELSE}
  Vcl.Menus, Vcl.ExtCtrls, Vcl.Controls, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Graphics, Vcl.Grids,
{$ENDIF}
  D2Bridge.HTML.CSS, D2Bridge.Types, Prism.Types, D2Bridge.Lang.Core,
  Prism.Interfaces, D2Bridge.Image, D2Bridge.Image.Interfaces;

//{$M+}

{$IFDEF FMX}
type
  TPicture = Prism.Types.TPicture;

  TJPEGImage = Prism.Types.TJPEGImage;
{$ENDIF}

type
 TPrismEventType = Prism.Types.TPrismEventType;
 TOnEventProc = Prism.Types.TOnEventProc;
 TOnGetStrings = Prism.Types.TOnGetStrings;

type
 TOnSetValue = Prism.Types.TOnSetValue;
 TOnGetValue = Prism.Types.TOnGetValue;

type
 ID2BridgeItemHTMLRow = interface;
 ID2BridgeItemHTMLPanelGroup = interface;
 ID2BridgeItemVCLObj = interface;
 ID2BridgeItemHTMLFormGroup = interface;
 IItemAdd = interface;
 ID2BridgeAddItems = interface;
 ID2BridgeDataware = interface;
 ID2BridgeDatawareOnlyDataSource = interface;
 ID2BridgeDatawareDataSource = interface;
 ID2BridgeDatawareListSource = interface;
 ID2BridgeDatawareStringGrid = interface;
 ID2BridgeInstance = interface;
 ID2BridgeServerControllerBase = interface;
 ID2BridgeManager = interface;
 ID2BridgeAPIMail = interface;
 ID2BridgeItemVCLObjStyle = interface;
 ID2BridgeItem = interface;
 ID2BridgeAPIAuth = interface;
 ID2BridgeAPIEvolution = interface;
 ID2BridgeAPIStorage = interface;
// ID2BridgeAPIStorageAmazonS3 = interface;

{$IFNDEF FMX}
 ID2BridgeItemHTMLDBImage = interface;
{$ENDIF}


 ID2BridgeManagerOptions = interface
  ['{B957AA20-A4A0-4B0B-8834-CED8BD11EBED}']

 end;

 ID2BridgeInstance = interface
  ['{B3EE8C19-3199-4554-99BE-4304F1FAB4D2}']
  function GetPrismSession: IPrismSession;

  property PrismSession: IPrismSession read GetPrismSession;
 end;


 ID2BridgeServerControllerBase = interface
  ['{FD7806A1-4DC9-4061-BA5C-35B4F871A2F1}']
   function GetPort: Integer;
   procedure SetPort(const Value: Integer);
   function GetServerName: String;
   procedure SetServerName(const Value: String);
   procedure SetServerDescription(const Value: String);
   function GetServerDescription: String;
   function GetPrimaryFormClass: TD2BridgeFormClass;
   procedure SetPrimaryFormClass(const Value: TD2BridgeFormClass);
   function GetTemplateMasterHTMLFile: string;
   function GetTemplatePageHTMLFile: string;
   procedure SetTemplateMasterHTMLFile(const Value: string);
   procedure SetTemplatePageHTMLFile(const Value: string);
   function GetLanguages: TD2BridgeLangs;
   procedure SetLanguages(const Value: TD2BridgeLangs);
   procedure SetLanguage(const Value: TD2BridgeLang);
   function GetAPPName: string;
   procedure SetAPPName(const Value: string);
   function GetAPPDescription: string;
   procedure SetAPPDescription(const Value: string);

   function ServerUUID: string;
   function Started: boolean;
   procedure StartServer;
   procedure StopServer;
   procedure DoSessionChange(AChangeType: TSessionConnectionStatus; APrismSession: IPrismSession);
   function CloseSession(ASessionUUID: String): Boolean;
   procedure CloseAllSessions;
   function SendMessageToSession(ASessionUUID: String; AMessage: String): Boolean;
   procedure SendMessageToAllSession(AMessage: String);
   function ServerInfoConsole: TStrings;

   property Languages: TD2BridgeLangs read GetLanguages write SetLanguages;
   property Language: TD2BridgeLang write SetLanguage;
   property PrimaryFormClass: TD2BridgeFormClass read GetPrimaryFormClass write SetPrimaryFormClass;
   property TemplateMasterHTMLFile: string read GetTemplateMasterHTMLFile write SetTemplateMasterHTMLFile;
   property TemplatePageHTMLFile: string read GetTemplatePageHTMLFile write SetTemplatePageHTMLFile;
   property Port: Integer read GetPort write SetPort;
   property ServerName: String read GetServerName write SetServerName;
   property ServerDescription: String read GetServerDescription write SetServerDescription;
   property APPName: string read GetAPPName write SetAPPName;
   property APPDescription: string read GetAPPDescription write SetAPPDescription;
 end;


 ID2BridgeAPI = interface
  ['{A5A65407-ECA8-41B5-83C5-99D399CA1A8B}']
   function Mail: ID2BridgeAPIMail;
   function Auth: ID2BridgeAPIAuth;
   //function Evolution: ID2BridgeAPIEvolution;
   function Storage: ID2BridgeAPIStorage;

 end;


 ID2BridgeManager = interface
  ['{D5C96C1D-4DD8-401F-AE08-2E0EE3B0CDB2}']
   function GetPrism: IPrismBaseClass;
   procedure SetPrism(APrism: IPrismBaseClass);
   Function GetPrimaryFormClass: TD2BridgeFormClass;
   procedure SetPrimaryFormClass(AD2BridgeFormClass: TD2BridgeFormClass);
   function GetTemplateClassForm: TClass;
   procedure SetTemplateClassForm(const Value: TClass);
   procedure SetTemplateMasterHTMLFile(AFileMasterTemplate: string);
   procedure SetTemplatePageHTMLFile(AFilePageTemplate: string);
   function GetTemplateMasterHTMLFile: string;
   function GetTemplatePageHTMLFile: string;
   function GetOptions: ID2BridgeManagerOptions;
   function GetServerController: ID2BridgeServerControllerBase;
   Procedure SetGetServerController(AD2BridgeServerControllerBase: ID2BridgeServerControllerBase);
   function GetVersion: string;
   function SupportedVCLClasses: TList<TClass>;
   function SupportsVCLClass(AClass: TClass; ARaiseError: boolean = true): Boolean;
   function GetLanguages: TD2BridgeLangs;
   procedure SetLanguages(const Value: TD2BridgeLangs);

   function API: ID2BridgeAPI;
   function CSSClass: TCSSClass;

   property Languages: TD2BridgeLangs read GetLanguages write SetLanguages;
   property Prism: IPrismBaseClass read GetPrism write SetPrism;
   property PrimaryFormClass: TD2BridgeFormClass read GetPrimaryFormClass write SetPrimaryFormClass;
   property TemplateMasterHTMLFile: string read GetTemplateMasterHTMLFile write SetTemplateMasterHTMLFile;
   property TemplatePageHTMLFile: string read GetTemplatePageHTMLFile write SetTemplatePageHTMLFile;
   property TemplateClassForm : TClass read GetTemplateClassForm write SetTemplateClassForm;
   property ServerController: ID2BridgeServerControllerBase read GetServerController write SetGetServerController;
   property Options: ID2BridgeManagerOptions read GetOptions;
   property Version: string read GetVersion;
 end;


 ID2BridgeFrameworkForm = interface
  ['{9DE713A1-294C-493B-A59D-D8D5F3753A43}']
    procedure Hide;
    procedure Show;
    procedure Clear;
    //procedure Destroy;

    function GetBaseClass: TObject;
    procedure SetBaseClass(BaseClass: TObject);
    function GetFormUUID: string;

    Procedure AddNested(AD2BridgeForm: TObject);

    property BaseClass: TObject read GetBaseClass write SetBaseClass;
    property FormUUID: string read GetFormUUID;
 end;


 ID2BridgeFrameworkItem = interface
 ['{F94F50F8-8CC2-45B6-92E3-BA4C4D26B63F}']
  procedure Clear;
  function FrameworkClass: TClass;
  procedure ProcessPropertyClass(VCLObj, NewObj: TObject);
  procedure ProcessEventClass(VCLObj, NewObj: TObject);
  procedure ProcessPropertyByName(VCLObj, NewObj: TObject; PropertyName: string; PropertyValue: Variant);

  procedure SetOnClick(AProc: TOnEventProc);
  function GetOnClick: TOnEventProc;
  procedure SetOnDblClick(AProc: TOnEventProc);
  function GetOnDblClick: TOnEventProc;
  procedure SetOnEnter(AProc: TOnEventProc);
  function GetOnEnter: TOnEventProc;
  procedure SetOnExit(AProc: TOnEventProc);
  function GetOnExit: TOnEventProc;
  procedure SetOnChange(AProc: TOnEventProc);
  function GetOnChange: TOnEventProc;
  procedure SetOnKeyDown(AProc: TOnEventProc);
  function GetOnKeyDown: TOnEventProc;
  procedure SetOnKeyUp(AProc: TOnEventProc);
  function GetOnKeyUp: TOnEventProc;
  procedure SetOnKeyPress(AProc: TOnEventProc);
  function GetOnKeyPress: TOnEventProc;
  procedure SetOnSelectAll(AProc: TOnEventProc);
  function GetOnSelectAll: TOnEventProc;
  procedure SetOnUnSelectAll(AProc: TOnEventProc);
  function GetOnUnselectAll: TOnEventProc;
  procedure SetOnSelect(AProc: TOnEventProc);
  function GetOnSelect: TOnEventProc;
  procedure SetOnCheck(AProc: TOnEventProc);
  function GetOnCheck: TOnEventProc;
  procedure SetOnCheckChange(AProc: TOnEventProc);
  function GetOnCheckChange: TOnEventProc;
  procedure SetOnUnCheck(AProc: TOnEventProc);
  function GetOnUnCheck: TOnEventProc;

  procedure SetProcGetEnabled(AProc: TOnGetValue);
  function GetProcGetEnabled: TOnGetValue;
  procedure SetProcSetEnabled(AProc: TOnSetValue);
  function GetProcSetEnabled: TOnSetValue;
  procedure SetProcGetVisible(AProc: TOnGetValue);
  function GetProcGetVisible: TOnGetValue;
  procedure SetProcSetVisible(AProc: TOnSetValue);
  function GetProcSetVisible: TOnSetValue;
  procedure SetProcGetReadOnly(AProc: TOnGetValue);
  function GetProcGetReadOnly: TOnGetValue;
  procedure SetProcSetReadOnly(AProc: TOnSetValue);
  function GetProcSetReadOnly: TOnSetValue;
  procedure SetProcGetPlaceholder(AProc: TOnGetValue);
  function GetProcGetPlaceholder: TOnGetValue;

  property OnClick: TOnEventProc read GetOnClick write SetOnClick;
  property OnDblClick: TOnEventProc read GetOnDblClick write SetOnDblClick;
  property OnEnter: TOnEventProc read GetOnEnter write SetOnEnter;
  property OnExit: TOnEventProc read GetOnExit write SetOnExit;
  property OnChange: TOnEventProc read GetOnChange write SetOnChange;
  property OnKeyPress: TOnEventProc read GetOnKeyPress write SetOnKeyPress;
  property OnKeyDown: TOnEventProc read GetOnKeyDown write SetOnKeyDown;
  property OnKeyUp: TOnEventProc read GetOnKeyUp write SetOnKeyUp;
  property OnSelectAll: TOnEventProc read GetOnSelectAll write SetOnSelectAll;
  property OnUnselectAll: TOnEventProc read GetOnUnselectAll write SetOnUnselectAll;
  property OnSelect: TOnEventProc read GetOnSelect write SetOnSelect;
  property OnCheckChange: TOnEventProc read GetOnCheckChange write SetOnCheckChange;
  property OnCheck: TOnEventProc read GetOnCheck write SetOnCheck;
  property OnUnCheck: TOnEventProc read GetOnUnCheck write SetOnUnCheck;

  property GetEnabled: TOnGetValue read GetProcGetEnabled write SetProcGetEnabled;
  property SetEnabled: TOnSetValue read GetProcSetEnabled write SetProcSetEnabled;
  property GetVisible: TOnGetValue read GetProcGetVisible write SetProcGetVisible;
  property SetVisible: TOnSetValue read GetProcSetVisible write SetProcSetVisible;
  property GetReadOnly: TOnGetValue read GetProcGetReadOnly write SetProcGetReadOnly;
  property SetReadOnly: TOnSetValue read GetProcSetReadOnly write SetProcSetReadOnly;
  property GetPlaceholder: TOnGetValue read GetProcGetPlaceholder write SetProcGetPlaceholder;
end;


 ID2BridgeFrameworkItemEdit = interface(ID2BridgeFrameworkItem)
 ['{FCC52FDA-ABCC-4777-839E-FABC40B8D7CC}']
   procedure SetOnGetText(AOnGetText: TOnGetValue);
   function GetOnGetText: TOnGetValue;
   procedure SetOnSetText(AOnSetText: TOnSetValue);
   function GetOnSetText: TOnSetValue;
   procedure SetEditDataType(AEditType: TPrismFieldType);
   function GetEditDataType: TPrismFieldType;
   function GetCharCase: TEditCharCase;
   procedure SetCharCase(ACharCase: TEditCharCase);
   function GetMaxLength: integer;
   procedure SetMaxLength(const Value: integer);

   property DataType: TPrismFieldType read GetEditDataType write SetEditDataType;
   property MaxLength: integer read GetMaxLength write SetMaxLength;
   property CharCase: TEditCharCase read GetCharCase write SetCharCase;
   property OnGetText: TOnGetValue read GetOnGetText write SetOnGetText;
   property OnSetText: TOnSetValue read GetOnSetText write SetOnSetText;
 end;


 ID2BridgeFrameworkItemLabel = interface(ID2BridgeFrameworkItem)
 ['{EA001A44-848A-4807-B6C1-6E7FBC788C90}']
   procedure SetOnGetText(AOnGetText: TOnGetValue);
   function GetOnGetText: TOnGetValue;
   procedure SetDataType(Value: TPrismFieldType);
   function GetDataType: TPrismFieldType;

   property OnGetText: TOnGetValue read GetOnGetText write SetOnGetText;
   property DataType: TPrismFieldType read GetDataType write SetDataType;
 end;


 ID2BridgeFrameworkItemButton = interface(ID2BridgeFrameworkItem)
  ['{C965D221-EF80-4027-A04A-8BBB72FCA62C}']
   procedure SetCaption(ACaption: String);
   function GetCaption: String;

   property Caption: String read GetCaption write SetCaption;
 end;

 ID2BridgeFrameworkItemCombobox = interface(ID2BridgeFrameworkItem)
  ['{7423B611-7F66-4DDA-A954-B15E4CAA670E}']
//  Function Items(Sender: TObject): TStringList;
// Function GetItemIndex(Sender: TObject): integer;
// Procedure SetItemIndex(Sender: TObject; AItemIndexValue: Integer);
  procedure SetProcGetItems(AProc: TOnGetStrings);
  function GetProcGetItems: TOnGetStrings;
  procedure SetProcGetSelectedItem(AProc: TOnGetValue);
  function GetProcGetSelectedItem: TOnGetValue;
  procedure SetProcSetSelectedItem(AProc: TOnSetValue);
  function GetProcSetSelectedItem: TOnSetValue;

  property ProcGetSelectedItem: TOnGetValue read GetProcGetSelectedItem write SetProcGetSelectedItem;
  property ProcSetSelectedItem: TOnSetValue read GetProcSetSelectedItem write SetProcSetSelectedItem;
  property ProcGetItems: TOnGetStrings read GetProcGetItems write SetProcGetItems;
 end;

{$IFNDEF FMX}
 ID2BridgeFrameworkItemDBCombobox = interface(ID2BridgeFrameworkItem)
 ['{E85DD9F7-B370-4B01-BBAF-FF89435A8620}']
// Function Items(Sender: TObject): TStringList;
// Function GetItemIndex(Sender: TObject): integer;
// Procedure SetItemIndex(Sender: TObject; AItemIndexValue: Integer);
  procedure SetProcGetItems(AProc: TOnGetStrings);
  function GetProcGetItems: TOnGetStrings;

  function Dataware : ID2BridgeDatawareDataSource;

  property ProcGetItems: TOnGetStrings read GetProcGetItems write SetProcGetItems;
 end;
{$ENDIF}

 ID2BridgeFrameworkItemImage = interface(ID2BridgeFrameworkItem)
 ['{CC940A1E-0C52-4527-A6B7-2B3F7A094EB1}']
   procedure SetPicture(APicture: TPicture);
   function GetPicture: TPicture;

   property Picture: TPicture read GetPicture write SetPicture;
 end;


 ID2BridgeFrameworkItemMemo = interface(ID2BridgeFrameworkItem)
  ['{C8CFEC57-0F6B-4DD4-A088-379F696378A8}']
   procedure SetLines(ALines: TStrings);
   function GetLines: TStrings;

   procedure SetRows(ARows: Integer);
   function GetRows: Integer;

   property Lines: TStrings read GetLines write SetLines;
   property Rows: Integer read GetRows write SetRows;
 end;


 ID2BridgeFrameworkItemCheckBox = interface(ID2BridgeFrameworkItem)
 ['{87787E5E-6883-4BF4-9CB8-94C814DD9C00}']
   procedure SetOnGetText(AOnGetText: TOnGetValue);
   function GetOnGetText: TOnGetValue;
   procedure SetOnGetChecked(AOnGetValue: TOnGetValue);
   function GetOnGetChecked: TOnGetValue;
   procedure SetOnSetChecked(AOnSetValue: TOnSetValue);
   function GetOnSetChecked: TOnSetValue;

   procedure SetCheckBoxType(AEditType: TCheckBoxType);
   function GetCheckBoxType: TCheckBoxType;

   property OnGetText: TOnGetValue read GetOnGetText write SetOnGetText;
   property OnGetChecked: TOnGetValue read GetOnGetChecked write SetOnGetChecked;
   property OnSetChecked: TOnSetValue read GetOnSetChecked write SetOnSetChecked;
   property CheckBoxType: TCheckBoxType read GetCheckBoxType write SetCheckBoxType;
 end;


 ID2BridgeFrameworkItemGridColumn = interface
 ['{E0473982-BE9A-44A2-98F9-A058EC1FF2BD}']
   function GetDataField: string;
   Procedure SetDataField(AFieldName: String);
   function GetTitle: string;
   Procedure SetTitle(ATitle: String);
   function GetVisible: Boolean;
   Procedure SetVisible(AVisible: Boolean);
   function GetEditable: Boolean;
   Procedure SetEditable(AValue: Boolean);
   function GetWidth: Integer;
   Procedure SetWidth(AWidth: Integer);
   function GetAlignment: TD2BridgeColumnsAlignment;
   Procedure SetAlignment(AAlignment: TD2BridgeColumnsAlignment);
   function GetDataFieldType: TPrismFieldType;
   procedure SetDataFieldType(const Value: TPrismFieldType);

   function SelectItems: TJSONObject;

   property DataFieldType: TPrismFieldType read GetDataFieldType write SetDataFieldType;
   property Editable: Boolean read GetEditable write SetEditable;
   property DataField: String read GetDataField write SetDataField;
   property Title: String read GetTitle write SetTitle;
   property Visible: Boolean read GetVisible write SetVisible;
   property Width: Integer read GetWidth write SetWidth;
   property Alignment: TD2BridgeColumnsAlignment read GetAlignment write SetAlignment;
end;


 ID2BridgeFrameworkItemGridColumns = interface
 ['{E0473982-BE9A-44A2-98F9-A058EC1FF2BD}']
   Procedure Clear;
   function GetColumns: TList<ID2BridgeFrameworkItemGridColumn>;
   function Add: ID2BridgeFrameworkItemGridColumn; overload;
   procedure Add(AColumn: ID2BridgeFrameworkItemGridColumn); overload;
   property Items: TList<ID2BridgeFrameworkItemGridColumn> read GetColumns;
 end;


 ID2BridgeFrameworkItemStringGrid = interface(ID2BridgeFrameworkItem)
  ['{86CFCFC3-424E-4EF3-A2B2-E41BE6EAA692}']
  function GetMultiSelect: Boolean;
  Procedure SetMultiSelect(AMultiSelect: Boolean);
  function SelectedRowsID: TList<Integer>;
  procedure SetOnGetSelectedRow(AOnGetSelectedRow: TOnGetValue);
  function GetOnGetSelectedRow: TOnGetValue;
  procedure SetOnSetSelectedRow(AOnSetSelectedRow: TOnSetValue);
  function GetOnSetSelectedRow: TOnSetValue;
  function GetProcEditable: TOnGetValue;
  procedure SetProcEditable(const Value: TOnGetValue);

  function Dataware: ID2BridgeDatawareStringGrid;
  function Columns: ID2BridgeFrameworkItemGridColumns;

  property MultiSelect: Boolean read GetMultiSelect write SetMultiSelect;
  property OnGetSelectedRow: TOnGetValue read GetOnGetSelectedRow write SetOnGetSelectedRow;
  property OnSetSelectedRow: TOnSetValue read GetOnSetSelectedRow write SetOnSetSelectedRow;
  property GetEditable: TOnGetValue read GetProcEditable write SetProcEditable;
 end;



 ID2BridgeFrameworkItemMainMenu = interface(ID2BridgeFrameworkItem)
  ['{E417560F-F904-4D9F-9251-8E5FF8D53C0B}']
 end;


{$IFNDEF FMX}
 ID2BridgeFrameworkItemDBCheckBox = interface(ID2BridgeFrameworkItem)
 ['{309E5B14-E59E-46B3-817F-0C603D691574}']
   procedure SetOnGetText(AOnGetText: TOnGetValue);
   function GetOnGetText: TOnGetValue;
   function GetValueChecked: String;
   procedure SetValueChecked(AValue: String);
   function GetValueUnChecked: String;
   procedure SetValueUnChecked(AValue: String);

   procedure SetCheckBoxType(AEditType: TCheckBoxType);
   function GetCheckBoxType: TCheckBoxType;
   function Dataware : ID2BridgeDatawareDataSource;

   property OnGetText: TOnGetValue read GetOnGetText write SetOnGetText;
   property ValueChecked: String read GetValueChecked write SetValueChecked;
   property ValueUnChecked: String read GetValueUnChecked write SetValueUnChecked;
   property CheckBoxType: TCheckBoxType read GetCheckBoxType write SetCheckBoxType;
 end;

 ID2BridgeFrameworkItemDBGrid = interface(ID2BridgeFrameworkItem)
 ['{29B70339-F160-4872-BFBC-0613061EEF02}']
  function GetMultiSelect: Boolean;
  Procedure SetMultiSelect(AMultiSelect: Boolean);
  function SelectedRowsID: TList<Integer>;
  procedure SetOnGetSelectedRow(AOnGetSelectedRow: TOnGetValue);
  function GetOnGetSelectedRow: TOnGetValue;
  procedure SetOnSetSelectedRow(AOnSetSelectedRow: TOnSetValue);
  function GetOnSetSelectedRow: TOnSetValue;
  function GetProcEditable: TOnGetValue;
  procedure SetProcEditable(const Value: TOnGetValue);

  function Dataware : ID2BridgeDatawareOnlyDataSource;
  function Columns: ID2BridgeFrameworkItemGridColumns;

  property MultiSelect: Boolean read GetMultiSelect write SetMultiSelect;
  property OnGetSelectedRow: TOnGetValue read GetOnGetSelectedRow write SetOnGetSelectedRow;
  property OnSetSelectedRow: TOnSetValue read GetOnSetSelectedRow write SetOnSetSelectedRow;
  property GetEditable: TOnGetValue read GetProcEditable write SetProcEditable;
 end;

 ID2BridgeFrameworkItemDBEdit = interface(ID2BridgeFrameworkItem)
 ['{D96D2D9D-2B17-41F8-9764-97840BED63E3}']
  function GetEditDataType: TPrismFieldType;
  procedure SetEditDataType(const Value: TPrismFieldType);
  function GetCharCase: TEditCharCase;
  procedure SetCharCase(ACharCase: TEditCharCase);

  property CharCase: TEditCharCase read GetCharCase write SetCharCase;
  function Dataware : ID2BridgeDatawareDataSource;

  property DataType: TPrismFieldType read GetEditDataType write SetEditDataType;
 end;

 ID2BridgeFrameworkItemDBMemo = interface(ID2BridgeFrameworkItem)
 ['{D96D2D9D-2B17-41F8-9764-97840BED63E3}']
 function Dataware : ID2BridgeDatawareDataSource;
 end;

 ID2BridgeFrameworkItemDBText = interface(ID2BridgeFrameworkItem)
 ['{AEF4E687-251F-4655-8792-B4EB5B5EEA49}']
  procedure SetDataType(Value: TPrismFieldType);
  function GetDataType: TPrismFieldType;

  function Dataware : ID2BridgeDatawareDataSource;
  property DataType: TPrismFieldType read GetDataType write SetDataType;
 end;


 ID2BridgeFrameworkItemDBLookupCombobox = interface(ID2BridgeFrameworkItem)
 ['{AEF4E687-251F-4655-8792-B4EB5B5EEA49}']
   procedure SetOnGetText(AProc: TOnGetValue);
   function GetOnGetText: TOnGetValue;
   procedure SetOnSetText(AProc: TOnSetValue);
   function GetOnSetText: TOnSetValue;

   function Dataware : ID2BridgeDataware;
   property OnGetText: TOnGetValue read GetOnGetText write SetOnGetText;
   property OnSetText: TOnSetValue read GetOnSetText write SetOnSetText;
 end;


 ID2BridgeFrameworkItemButtonedEdit = interface(ID2BridgeFrameworkItemEdit)
  ['{31353A67-A1FF-4BF6-BD36-33EA1D2EFC65}']
   function GetButtonLeftVisible: boolean;
   function GetButtonLeftEnabled: boolean;
   procedure SetButtonLeftCSS(Value: String);
   function GetButtonLeftCSS: string;
   procedure SetButtonLeftText(Value: String);
   function GetButtonLeftText: string;

   function GetButtonRightVisible: boolean;
   function GetButtonRightEnabled: boolean;
   procedure SetButtonRightCSS(Value: String);
   function GetButtonRightCSS: string;
   procedure SetButtonRightText(Value: String);
   function GetButtonRightText: string;

   property ButtonLeftVisible: boolean read GetButtonLeftVisible;
   property ButtonLeftEnabled: boolean read GetButtonLeftEnabled;
   property ButtonLeftCSS: string read GetButtonLeftCSS write SetButtonLeftCSS;
   property ButtonLeftText: string read GetButtonLeftText write SetButtonLeftText;
   property ButtonRightVisible: boolean read GetButtonRightVisible;
   property ButtonRightEnabled: boolean read GetButtonRightEnabled;
   property ButtonRightCSS: string read GetButtonRightCSS write SetButtonRightCSS;
   property ButtonRightText: string read GetButtonRightText write SetButtonRightText;
 end;
 {$ENDIF}

 ID2BridgeFrameworkType = interface
 ['{CF5B1E9F-28A4-41CD-804D-13A188ACD89C}']
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
    function Image: ID2BridgeFrameworkItemImage;
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
    function Memo: ID2BridgeFrameworkItemMemo;

    function MainMenu: ID2BridgeFrameworkItemMainMenu;

    function FrameworkForm: ID2BridgeFrameworkForm;

    property Form: TObject read GetForm;
    property TemplateMasterHTMLFile: string read GetTemplateMasterHTMLFile write SetTemplateMasterHTMLFile;
    property TemplatePageHTMLFile: string read GetTemplatePageHTMLFile write SetTemplatePageHTMLFile;
 end;


 ID2BridgeHTMLTag = interface
  ['{9DE41FB0-64F7-4D2F-843A-FC07A1F6FF99}']
  function GetCSSClass: string;
  procedure SetCSSClass(Value: string);
  function GetHTMLExtras: string;
  procedure SetHTMLExtras(Value: string);
  function GetHTMLStyle: string;
  procedure SetHTMLStyle(Value: string);
  property CSSClasses: string read GetCSSClass write SetCSSClass;
  property HTMLExtras: string read GetHTMLExtras write SetHTMLExtras;
  property HTMLStyle: string read GetHTMLStyle write SetHTMLStyle;
 end;


 ID2BridgeItem = interface(ID2BridgeHTMLTag)
  ['{8E91085A-BF0B-467B-8148-A883CDEB1FDC}']
  //Render
  procedure DoBeginReader;
  procedure PreProcess;
  procedure Render;
  procedure RenderHTML;
  procedure DoEndReader;

  //function GetIsHidden: Boolean;
  //procedure SetIsHidden(AIsHidden: Boolean);
  function GetItemID: String;
  procedure SetItemID(AItemID: String);
  function GetItemPrefixID: String;
  function GetPrismControl: IPrismControl;
  procedure SetPrismControl(AValue: IPrismControl);
  procedure SetRenderized(Value: boolean);
  function GetRenderized: Boolean;
  function GetOwner: ID2BridgeItem;
  procedure SetOwner(Value: ID2BridgeItem);

  function HTMLItems: TStrings;

  //property Hidden: Boolean read GetIsHidden write SetIsHidden;
  property Renderized: boolean read GetRenderized Write SetRenderized;
  property ItemID: string read GetItemID write SetItemID;
  property ItemPrefixID: string read GetItemPrefixID;
  property PrismControl: IPrismControl read GetPrismControl write SetPrismControl;
  property Owner: ID2BridgeItem read GetOwner write SetOwner;
end;


// ID2BridgeItemWithItemsAdd = interface(ID2BridgeItem)
//  ['{0E17C2A3-1AD6-4E96-A479-CFC7D6044848}']
//  function GetItems: TList<ID2BridgeItem>;
//  function Add: IItemAdd; overload;
//  procedure Add(Item: ID2BridgeItem); overload;
//  property Items: TList<ID2BridgeItem> read GetItems;
//end;


 ID2BridgeItemHTMLMenuPanel = interface(ID2BridgeHTMLTag)
  ['{02C58BDB-F312-49DB-9FB1-1F1F3E57BD63}']
  function GetColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});

  function Items: ID2BridgeAddItems;

  property Color: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetColor write SetColor;
 end;


 ID2BridgeItemHTMLMainMenu = interface(ID2BridgeItem)
  ['{3154C369-BAC8-443E-B6DE-B4B59A88D4DC}']
  function GetTitle: string;
  procedure SetTitle(const Value: string);
  function GetColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  function GetDark: boolean;
  function GetMenuTextColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  function GetTitleColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  procedure SetDark(const Value: boolean);
  procedure SetMenuTextColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  procedure SetTitleColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  function GetTransparent: Boolean;
  procedure SetTransparent(const Value: Boolean);

  function PanelTop: ID2BridgeItemHTMLMenuPanel;
  function PanelBottom: ID2BridgeItemHTMLMenuPanel;
  function RightItems: ID2BridgeAddItems;
  function AccessoryItems: ID2BridgeAddItems;
  function Image: ID2BridgeImage;

  function Options: IPrismMainMenu;

  procedure MenuAlignLeft;
  procedure MenuAlignCenter;
  procedure MenuAlignRight;

  property Title: string read GetTitle write SetTitle;
  property Dark: boolean read GetDark write SetDark;
  property Color: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetColor write SetColor;
  property TitleColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetTitleColor write SetTitleColor;
  property MenuTextColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetMenuTextColor write SetMenuTextColor;
  property Transparent: Boolean read GetTransparent write SetTransparent;
 end;


 ID2BridgeItemHTMLPanelGroup = interface(ID2BridgeItem)
 ['{08688BA1-3547-43AC-A797-B1B6D984643D}']
  procedure SetColSize(AColSize: string);
  function GetColSize: string;
  function GetTitle: string;
  procedure SetTitle(ATitle: string);
  procedure SetInLine(Value: Boolean);
  function GetInLine: Boolean;
  Function Items: ID2BridgeAddItems;

  property ColSize: string read GetColSize write SetColSize;
  property Title: string read GetTitle write SetTitle;
  property HTMLInLine: Boolean read GetInLine write SetInLine;
 end;


 ID2BridgeItemHTMLCardImage = interface(ID2BridgeHTMLTag)
  ['{8D09D2C8-4D27-46DB-8837-E745F2EFE29A}']
  procedure SetColSize(AColSize: string);
  function GetColSize: string;
  procedure SetPosition(AImagePosition: TD2BridgeCardImagePosition);
  function GetPosition: TD2BridgeCardImagePosition;

  function Image: TD2BridgeImage;
  procedure ImageFromLocal(PathFromImage: string);
  procedure ImageFromURL(URLFromImage: string);
  procedure ImageFromTImage(ImageComponent: TImage);
{$IFNDEF FMX}
  function ImageDB: ID2BridgeItemHTMLDBImage;
{$ENDIF}
  function IsImageFromDB: boolean;

  property ColSize: string read GetColSize write SetColSize;
  property Position: TD2BridgeCardImagePosition read GetPosition write SetPosition;
 end;


 ID2BridgeItemHTMLCardHeader = interface(ID2BridgeHTMLTag)
  ['{10D06D0A-2F0A-448A-B466-37DA7447D1B1}']
  function GetText: string;
  procedure SetText(Value: string);

  Function Items: ID2BridgeAddItems;

  property Text: string read GetText write SetText;
 end;


 ID2BridgeItemHTMLCardFooter = interface(ID2BridgeHTMLTag)
  ['{E35DE1B2-5B76-4865-BB6C-6110524DC88D}']
  function GetText: string;
  procedure SetText(Value: string);

  Function Items: ID2BridgeAddItems;

  property Text: string read GetText write SetText;
 end;

 ID2BridgeItemHTMLCard = interface(ID2BridgeItem)
  ['{CE8A093B-5966-4A3B-B23E-FA7667A8CFDC}']
  procedure SetCSSClassesBody(AValue: string);
  function GetCSSClassesBody: string;
  procedure SetColSize(AColSize: string);
  function GetColSize: string;
  function GetTitle: string;
  procedure SetTitle(ATitle: string);
  function GetTitleHeader: string;
  procedure SetTitleHeader(Value: string);
  function GetSubTitle: string;
  procedure SetSubTitle(ASubTitle: string);
  function GetText: string;
  procedure SetText(Value: string);
  function GetExitProc: TProc;
  function GetOnExit: TNotifyEvent;
  procedure SetExitProc(const Value: TProc);
  procedure SetOnExit(const Value: TNotifyEvent);
  function GetCloseFormOnExit: Boolean;
  procedure SetCloseFormOnExit(const Value: Boolean);
  function GetRenderizable: Boolean;
  procedure SetRenderizable(const Value: Boolean);
  function GetColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  function GetTextColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetTextColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  function GetBorderColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetBorderColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  function GetBorderWidth: integer;
  procedure SetBorderWidth(const Value: integer);

  Function Items: ID2BridgeAddItems;
  Function BodyItems: ID2BridgeAddItems;
  function Header(AText: String = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardHeader;
  function Footer(AText: String = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardFooter;

  function Image(AImagePosition: TD2BridgeCardImagePosition = D2BridgeCardImagePositionTop; Image: TImage = nil; AColSize: string = ''): ID2BridgeItemHTMLCardImage; overload;
  function ImageICOFromLocal(LocalFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageICOFromURL(URLFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageICOFromTImage(Image: TImage = nil; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$IFNDEF FMX}
  function ImageICOFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AColSize: string = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$ENDIF}
  function ImageTOPFromLocal(LocalFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageTOPFromURL(URLFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageTOPFromTImage(Image: TImage = nil; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$IFNDEF FMX}
  function ImageTOPFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AColSize: string = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$ENDIF}
  function ImageBOTTOMFromLocal(LocalFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageBOTTOMFromURL(URLFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageBOTTOMFromTImage(Image: TImage = nil; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$IFNDEF FMX}
  function ImageBOTTOMFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AColSize: string = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$ENDIF}
  function ImageLEFTFromLocal(LocalFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageLEFTFromURL(URLFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageLEFTFromTImage(Image: TImage = nil; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$IFNDEF FMX}
  function ImageLEFTFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AColSize: string = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$ENDIF}
  function ImageRIGHTFromLocal(LocalFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageRIGHTFromURL(URLFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageRIGHTFromTImage(Image: TImage = nil; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$IFNDEF FMX}
  function ImageRIGHTFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AColSize: string = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$ENDIF}
  function ImageFULLFromLocal(LocalFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageFULLFromURL(URLFromImage: string = ''; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
  function ImageFULLFromTImage(Image: TImage = nil; AColSize: string = ''; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$IFNDEF FMX}
  function ImageFULLFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AColSize: string = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLCardImage;
{$ENDIF}

  property Color: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetColor write SetColor;
  property TextColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetTextColor write SetTextColor;
  property BorderColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetBorderColor write SetBorderColor;
  property BorderWidth: integer read GetBorderWidth write SetBorderWidth;
  property ColSize: string read GetColSize write SetColSize;
  property CSSClassesBody: string read GetCSSClassesBody write SetCSSClassesBody;
  property Title: string read GetTitle write SetTitle;
  property TitleHeader: string read GetTitleHeader write SetTitleHeader;
  property SubTitle: string read GetSubTitle write SetSubTitle;
  property Text: string read GetText write SetText;
  property Renderizable: boolean read GetRenderizable write SetRenderizable;

  property OnExit: TNotifyEvent read GetOnExit write SetOnExit;
  property ExitProc: TProc read GetExitProc write SetExitProc;
  property CloseFormOnExit: Boolean read GetCloseFormOnExit write SetCloseFormOnExit;
 end;


 ID2BridgeItemHTMLCardGroup = interface(ID2BridgeItem)
  ['{9048DA9C-CF75-4F9F-BAD1-E54739782062}']
  procedure SetColSize(AColSize: string);
  function GetColSize: string;
  procedure SetMarginCardsSize(AValue: string);
  function GetMarginCardsSize: string;

  function AddCard(ATitle: string = ''; AText: string = ''; AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCard; overload;

  property ColSize: string read GetColSize write SetColSize;
  property MarginCardsSize: string read GetMarginCardsSize write SetMarginCardsSize;
 end;


 ID2BridgeItemHTMLCardGrid = interface(ID2BridgeItem)
  ['{6981200A-A7E2-4D24-BA81-2D83B178193F}']
  procedure SetColSize(AColSize: string);
  function GetColSize: string;
  procedure SetCardGridSize(ACardGridSize: string);
  function GetCardGridSize: string;
  procedure SetEqualHeight(AValue: Boolean);
  function GetEqualHeight: Boolean;
  procedure SetSpace(AValue: String);
  function GetSpace: String;

  function AddCard(ATitle: string = ''; AText: string = ''; AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCard; overload;

  property ColSize: string read GetColSize write SetColSize;
  property RowColsSize: string read GetCardGridSize write SetCardGridSize;
  property CardGridSize: string read GetCardGridSize write SetCardGridSize;
  property EqualHeight: boolean read GetEqualHeight write SetEqualHeight;
  property Space: string read GetSpace write SetSpace;
 end;



{$IFNDEF FMX}
 ID2BridgeItemHTMLCardGridDataModel = interface(ID2BridgeItemHTMLCardGrid)
  ['{06C95C22-3808-47D9-B8A6-C6B1A0C33564}']
   procedure SetDataSource(const Value: TDataSource);
   function GetDataSource: TDataSource;

   function CardDataModel(ATitle: string = ''; AText: string = ''; AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCard; overload;

   property DataSource: TDataSource read GetDataSource write SetDataSource;
 end;
{$ENDIF}



 ID2BridgeItemHTMLTabItem = interface(ID2BridgeHTMLTag)
 ['{222C93EA-E56F-4B59-85BB-A44B9876E83A}']
  function GetTitle: string;
  procedure SetTitle(ATitle: string);

  Function Items: ID2BridgeAddItems;

  property Title: string read GetTitle write SetTitle;
 end;


 ID2BridgeItemHTMLTabs = interface(ID2BridgeItem)
 ['{222C93EA-E56F-4B59-85BB-A44B9876E83A}']
  function GetShowTabs: Boolean;
  procedure SetShowTabs(const Value: Boolean);
  function GetTabs: TList<ID2BridgeItemHTMLTabItem>;
  procedure SetColSize(AColSize: string);
  function GetColSize: string;
  function AddTab: ID2BridgeItemHTMLTabItem; overload;
  function AddTab(ATitle: String; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemHTMLTabItem; overload;
  procedure AddTab(Item: ID2BridgeItemHTMLTabItem); overload;
  function GetTabColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  function GetTabTextColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetTabColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  procedure SetTabTextColor(const Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});

  property Tabs: TList<ID2BridgeItemHTMLTabItem> read GetTabs;
  property ColSize: string read GetColSize write SetColSize;
  property ShowTabs: Boolean read GetShowTabs write SetShowTabs;
  property TabColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetTabColor write SetTabColor;
  property TabTextColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetTabTextColor write SetTabTextColor;
 end;


 ID2BridgeItemNested = interface(ID2BridgeItem)
 ['{222C93EA-E56F-4B59-85BB-A44B9876E83A}']
  function GetNestedFormName: String;
  procedure SetNestedFormName(AD2BridgeFormName: String);
  property NestedFormName: string read GetNestedFormName write SetNestedFormName;
 end;


 ID2BridgeItemHTMLAccordionItem = interface
  ['{7325C549-C21D-4C77-832C-7D1A59CBE3A2}']
  function GetTitle: string;
  procedure SetTitle(ATitle: string);
  Function Items: ID2BridgeAddItems;
  property Title: string read GetTitle write SetTitle;
 end;


 ID2BridgeItemHTMLAccordion = interface(ID2BridgeItem)
  ['{C507CC93-B6BA-480C-8B71-22DE8B6974B1}']
  function GetAccordionItems: TList<ID2BridgeItemHTMLAccordionItem>;
  procedure SetColSize(AColSize: string);
  function GetColSize: string;
  function AddAccordionItem: ID2BridgeItemHTMLAccordionItem; overload;
  function AddAccordionItem(ATitle: String): ID2BridgeItemHTMLAccordionItem; overload;
  procedure AddAccordionItem(Item: ID2BridgeItemHTMLAccordionItem); overload;
  property AccordionItems: TList<ID2BridgeItemHTMLAccordionItem> read GetAccordionItems;
  property ColSize: string read GetColSize write SetColSize;
 end;


 ID2BridgeItemHTMLPopup = interface(ID2BridgeItem)
 ['{892D59CD-0B4C-4494-B2EC-21E60F422155}']
  function GetTitle: string;
  procedure SetTitle(ATitle: string);
  function GetShowButtonClose: Boolean;
  procedure SetShowButtonClose(AValue: Boolean);
  Function Items: ID2BridgeAddItems;
  property Title: string read GetTitle write SetTitle;
  property ShowButtonClose: Boolean read GetShowButtonClose write SetShowButtonClose;
 end;


 ID2BridgeItemHTMLInput = interface(ID2BridgeItem)
 ['{C304CB86-F4FF-44C7-AD2B-A16D14857E47}']
  function GetCaptionUpload: string;
  procedure SetCaptionUpload(ACaption: string);
  function GetInputVisible: Boolean;
  procedure SetInputVisible(const Value: Boolean);
  procedure SetCSSInput(AValue: string);
  function GetCSSInput: String;
  procedure SetCSSButtonClear(AValue: string);
  function GetCSSButtonClear: String;
  procedure SetCSSButtonUpload(AValue: string);
  function GetCSSButtonUpload: String;
  procedure SetIconButtonUpload(AValue: string);
  function GetIconButtonUpload: String;
  procedure SetIconButtonClear(AValue: string);
  function GetIconButtonClear: String;
  function GetMaxFiles: integer;
  procedure SetMaxFiles(AValue: Integer);
  function GetMaxFileSize: integer;
  function GetMaxUploadSize: integer;
  procedure SetMaxFileSize(const Value: integer);
  procedure SetMaxUploadSize(const Value: integer);
  function GetShowFinishMessage: Boolean;
  procedure SetShowFinishMessage(const Value: Boolean);

  function AllowedFileTypes: TStrings;

  property MaxUploadSize: integer read GetMaxUploadSize write SetMaxUploadSize;
  property MaxFileSize: integer read GetMaxFileSize write SetMaxFileSize;
  property InputVisible: Boolean read GetInputVisible write SetInputVisible;
  property ShowFinishMessage: Boolean read GetShowFinishMessage write SetShowFinishMessage;
  property CaptionUpload: string read GetCaptionUpload write SetCaptionUpload;
  property MaxFiles: Integer read GetMaxFiles write SetMaxFiles;
  property CSSInput: string read GetCSSInput write SetCSSInput;
  property CSSButtonClear: string read GetCSSButtonClear write SetCSSButtonClear;
  property CSSButtonUpload: string read GetCSSButtonUpload write SetCSSButtonUpload;
  property IconButtonClear: string read GetIconButtonClear write SetIconButtonClear;
  property IconButtonUpload: string read GetIconButtonUpload write SetIconButtonUpload;
 end;


 ID2BridgeItemHTMLIms = interface(ID2BridgeItem)
  ['{33706553-54D8-409B-BE04-968C69AA0251}']
   function GetSrc: string;
   procedure SetSrc(Value: string);
   function GetAlt: string;
   procedure SetAlt(Value: string);

   property Src: string read GetSrc write SetSrc;
   property Alt: string read GetAlt write SetAlt;
 end;


// ID2BridgeItemHTMLButtonDropDown = interface(ID2BridgeItem)
//  ['{1C56A11B-307C-45AD-B80C-86A4160893D3}']
//  function GetAccordionItems: TList<ID2BridgeItemHTMLAccordionItem>;
//
//  procedure SetColSize(AColSize: string);
//  function GetColSize: string;
//
//  procedure SetCaption(ACaption: string);
//  function GetCaption: string;
//
//  procedure AddPopupMenu(APopupMenu :TPopupMenu);
//
//  function AddAccordionItem: ID2BridgeItemHTMLAccordionItem; overload;
//  function AddAccordionItem(ATitle: String): ID2BridgeItemHTMLAccordionItem; overload;
//  procedure AddAccordionItem(Item: ID2BridgeItemHTMLAccordionItem); overload;
//  property AccordionItems: TList<ID2BridgeItemHTMLAccordionItem> read GetAccordionItems;
//  property ColSize: string read GetColSize write SetColSize;
//  property Caption: string read GetCaption write SetCaption;
// end;

 ID2BridgeItemVCLObjStyle = interface
  ['{0B857CF0-EFE4-45FD-AEC5-3FEAA523998D}']
  function GetFontSize: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF};
  procedure SetFontSize(Value: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF});
  function GetFontColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetFontColor(Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  function GetAlignment: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF};
  procedure SetAlignment(Value: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF});
  function GetFontStyles: TFontStyles;
  procedure SetFontStyles(Value: TFontStyles);
  function GetColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetColor(Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});

  property FontSize: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF} read GetFontSize write SetFontSize;
  property FontStyles: TFontStyles read GetFontStyles write SetFontStyles;
  property FontColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetFontColor write SetFontColor;
  property Color: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetColor write SetColor;
  property Alignment: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF} read GetAlignment write SetAlignment;
 end;


 ID2BridgeItemVCLObj = interface(ID2BridgeItem)
  ['{CDBD41C0-C966-4906-90CB-DBB1C0645D65}']
  function GetItem: TComponent;
  procedure SetItem(AItemVCLObj: TComponent);
  function GetRequired: Boolean;
  procedure SetRequired(ARequired: Boolean);
  function GetValidationGroup: Variant;
  Procedure SetValidationGroup(AValidationGroup: Variant);
  function GetIsHidden: Boolean;
  procedure SetIsHidden(AIsHidden: Boolean);
  procedure ProcessVCLStyles;

  function GetPopupMenu: TPopupMenu;
  procedure SetPopupMenu(APopupMenu: TPopupMenu);

  property Item: TComponent read GetItem write SetItem;
  property Hidden: Boolean read GetIsHidden write SetIsHidden;
  property PopupMenu: TPopupMenu read GetPopupMenu write SetPopupMenu;
  property Required: Boolean read GetRequired write SetRequired;
  property ValidationGroup: Variant read GetValidationGroup write SetValidationGroup;
 end;


 ID2BridgeItemHTMLElement = interface(ID2BridgeItem)
  ['{DBCF8409-5ED6-48D5-A66F-A78DB3F7A8E3}']
   function GetHTML: string;
   procedure SetHTML(AHTML: string);
   function GetComponentHTMLElement: TComponent;
   procedure SetComponentHTMLElement(ALabel: TComponent);

   property HTML : string read GetHTML write SetHTML;
   property ComponentHTMLElement: TComponent read GetComponentHTMLElement write SetComponentHTMLElement;
 end;


 ID2BridgeItemHTMLFormGroup = interface(ID2BridgeItem)
 ['{E4FAE649-B656-46E6-8A3E-C884EFDAA3CA}']
  function Items: ID2BridgeAddItems;
  Procedure AddVCLObj(VCLItem: TObject; CSS: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''); overload;
  procedure AddVCLObjLink(VCLItem: TComponent; Href: string = '#'; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = '');
  procedure AddVCLObj(VCLItem: TObject; AValidationGroup: Variant; ARequired: Boolean; CSS: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''); overload;
  Procedure AddVCLObj(VCLItem: TObject; APopupMenu: TPopupMenu; CSS: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''); overload;
  Procedure AddVCLObjWithLabel(VCLItem: TObject; ATextLabel: string; CSS: String = ''; HTMLExtras: String = ''; HTMLStyle: String = '');
  Procedure AddLabelVCLObj(VCLItem: TObject; CSS: String = ''; HTMLExtras: String = ''; HTMLStyle: String = '');
  function GetTextLabel: string;
  procedure SetTextLabel(ATextLabel: string);
  procedure SetColSize1(AColSize: string);
  function GetColSize1: string;
  procedure SetColSize2(AColSize: string);
  function GetColSize2: string;
  procedure SetInLine(Value: Boolean);
  function GetInLine: Boolean;
  property TextLabel: string read GetTextLabel write SetTextLabel;
  property ColSize1: string read GetColSize1 write SetColSize1;
  property ColSize2: string read GetColSize2 write SetColSize2;
  property HTMLInLine: Boolean read GetInLine write SetInLine;
 end;


 ID2BridgeItemHTMLRow = interface(ID2BridgeItem)
  ['{6F545F55-A0F5-4E86-91DC-7C2A8DE8C331}']
  procedure SetInLine(Value: Boolean);
  function GetInLine: Boolean;
  procedure SetHTMLTagRow(ATagRow: String);
  function GetHTMLTagRow: String;
  function GetCloseElement: boolean;
  procedure SetCloseElement(const Value: boolean);
  Function Items: ID2BridgeAddItems;
  function Add: IItemAdd;
  property HTMLInLine: Boolean read GetInLine write SetInLine;
  property HTMLTagRow: String read GetHTMLTagRow write SetHTMLTagRow;
  property CloseElement: boolean read GetCloseElement write SetCloseElement;
 end;


 ID2BridgeItemHTMLLink = interface(ID2BridgeItem)
  ['{8E9E0D6E-2AF7-4B5E-8F95-B96D93E42661}']
   Function Items: ID2BridgeAddItems;

   function PrismLink: IPrismLink;
 end;


 ID2BridgeItemHTMLQRCode = interface(ID2BridgeItem)
  ['{E417560F-F904-4D9F-9251-8E5FF8D53C0B}']

   function PrismQRCode: IPrismQRCode;
 end;


 ID2BridgeItemHTMLCarousel = interface(ID2BridgeItem)
  ['{4D5299E8-6B66-4281-9093-3C31CAFF3035}']
{$IFNDEF FMX}
   procedure SetDataSource(const Value: TDataSource);
   function GetDataSource: TDataSource;
   procedure SetDataFieldImagePath(AValue: String);
   function GetDataFieldImagePath: String;
{$ENDIF}
   function GetAutoSlide: boolean;
   procedure SetAutoSlide(Value: boolean);
   function GetInterval: integer;
   procedure SetInterval(Value: integer);
   function GetShowButtons: boolean;
   procedure SetShowButtons(Value: boolean);
   function GetShowIndicator: boolean;
   procedure SetShowIndicator(Value: boolean);

   function ImageFiles: TList<string>;

   function PrismCarousel: IPrismCarousel;
   function Control: IPrismCarousel;

   property AutoSlide: boolean read GetAutoSlide write SetAutoSlide;
   property ShowButtons: boolean read GetShowButtons write SetShowButtons;
   property ShowIndicator: boolean read GetShowIndicator write SetShowIndicator;
   property Interval: integer read GetInterval write SetInterval;
{$IFNDEF FMX}
   property DataSource: TDataSource read GetDataSource write SetDataSource;
   property DataFieldImagePath: String read GetDataFieldImagePath write SetDataFieldImagePath;
{$ENDIF}
 end;


 ID2BridgeItemHTMLSideMenu = interface(ID2BridgeItem)
 ['{B71F9BD5-9832-4420-877F-75508EC3F7C5}']
   function Options: IPrismSideMenu;
 end;


 ID2BridgeItemHTMLImage = interface(ID2BridgeItem)
  ['{BE4C7132-C60F-487F-A4BA-ED4D622C7139}']
  procedure ImageFromLocal(PathFromImage: string);
  procedure ImageFromURL(URLFromImage: string);
  procedure ImageFromTImage(ImageComponent: TImage);
 end;



 ID2BridgeItemHTMLKanban = interface(ID2BridgeItem)
  ['{018A66DE-6F4E-40A4-998A-91315C590B7A}']
   function GetColSize: string;
   procedure SetColSize(const Value: string);
   function GetAddClickProc: TProc;
   function GetOnAddClick: TNotifyEvent;
   procedure SetAddClickProc(const Value: TProc);
   procedure SetOnAddClick(const Value: TNotifyEvent);

   function CardModel(ATitle: string = ''; AText: string = ''; AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCard; overload;

   property ColSize: string read GetColSize write SetColSize;
   property OnAddClick: TNotifyEvent read GetOnAddClick write SetOnAddClick;
   property AddClickProc: TProc read GetAddClickProc write SetAddClickProc;
 end;


{$IFNDEF FMX}
 ID2BridgeItemHTMLDBImage = interface(ID2BridgeItem)
  ['{D73229FE-FEA5-4397-832A-BFEFF9393AF3}']
   procedure SetDataSource(const Value: TDataSource);
   function GetDataSource: TDataSource;
   procedure SetDataFieldImagePath(AValue: String);
   function GetDataFieldImagePath: String;

   property DataSource: TDataSource read GetDataSource write SetDataSource;
   property DataFieldImagePath: String read GetDataFieldImagePath write SetDataFieldImagePath;
 end;
{$ENDIF}


 //ID2BridgeVCLObj<TD2BridgeItemVCLObj> = interface
 ID2BridgeVCLObj = interface
 ['{2B068602-DC6C-40BE-ABA8-AA22EA9B10C6}']
   function CSSClass: String;
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function FrameworkItemClass: ID2BridgeFrameworkItem;
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
 end;


 //ID2BridgeHTMLType<TD2BridgeHTMLType> = interface
 ID2BridgeHTMLType = interface
 ['{B029ADE6-74C5-4C8E-8DA3-2E372D103639}']
   //procedure RenderHTML;
 end;


 ID2BridgeDatawareOnlyDataSource = interface
 ['{B5C1B041-4AAD-4C70-87E9-2B4229A120A4}']
  procedure Clear;
  function GetDataSource: TDataSource;
  procedure SetDataSource(ADataSource: TDataSource);
  property DataSource: TDataSource read GetDataSource write SetDataSource;
 end;


 ID2BridgeDatawareDataSource = interface
 ['{E0723709-CDDE-4F9C-8B2F-61EC9D2F6B46}']
  procedure Clear;
  function GetDataSource: TDataSource;
  procedure SetDataSource(ADataSource: TDataSource);
  function GetDataField: string;
  Procedure SetDataField(AFieldName: string);
  property DataSource: TDataSource read GetDataSource write SetDataSource;
  property DataField: string read GetDataField write SetDataField;
 end;


 ID2BridgeDatawareListSource = interface
 ['{5291379C-BB75-48DF-B605-8C56DCB83250}']
  procedure Clear;
  function GetListField: string;
  Procedure SetListField(AFieldName: string);
  function GetKeyField: string;
  Procedure SetKeyField(AFieldName: string);
  function GetListSource: TDataSource;
  procedure SetListSource(ADataSource: TDataSource);
  property ListSource: TDataSource read GetListSource write SetListSource;
  property ListField: string read GetListField write SetListField;
  property KeyField: string read GetKeyField write SetKeyField;
 end;

 ID2BridgeDatawareStringGrid = interface
 ['{24AF7C02-43F7-41F1-B58F-E0F0023FE29A}']
  procedure Clear;
  function GetStringGrid: TStringGrid;
  procedure SetStringGrid(AStringGrid: TStringGrid);
  property StringGrid: TStringGrid read GetStringGrid write SetStringGrid;
 end;

 ID2BridgeDataware = interface
 ['{A24A23EF-581C-41D4-9BD4-BD401DFA5081}']
  procedure Clear;
  function DataSource: ID2BridgeDatawareDataSource;
  function ListSource: ID2BridgeDatawareListSource;
 end;


// ID2BridgeDataware = interface
//  ['{18D5FE82-9B56-488C-8548-FAB43E139F79}']
//  function GetDataSource: TDataSource;
//  procedure SetDataSource(ADataSource: TDataSource);
//  function GetListSource: TDataSource;
//  procedure SetListSource(ADataSource: TDataSource);
//  function GetDataField: string;
//  Procedure SetDataField(AFieldName: string);
//  function GetListField: string;
//  Procedure SetListField(AFieldName: string);
//  function GetKeyField: string;
//  Procedure SetKeyField(AFieldName: string);
//  property DataField: string read GetDataField write SetDataField;
//  property ListField: string read GetListField write SetListField;
//  property KeyField: string read GetKeyField write SetKeyField;
//  property DataSource: TDataSource read GetDataSource write SetDataSource;
//  property ListSource: TDataSource read GetDataSource write SetDataSource;
// end;


 //ID2BridgeHTMLType<TD2BridgeHTMLType> = interface


 IItemsAdd = interface
  ['{223A1800-3344-4CF3-B5E6-F034CC9E052B}']
  function GetItems: TList<ID2BridgeItem>;
  function Add: IItemAdd; overload;
  procedure Add(Item: ID2BridgeItem); overload;
  property Items: TList<ID2BridgeItem> read GetItems;
 end;

 ID2BridgeAddItems = interface(IItemsAdd)
  ['{D7FED597-F7AA-4B02-87E4-ABF4576BFD60}']

 end;

 IItemAdd = interface
  ['{808EDF23-DD25-4DC5-8FA4-2ECD595F2D62}']
   procedure D2BridgeItem(AD2BridgeItem: TObject);
   function VCLObj: ID2BridgeItemVCLObj; overload;
   function VCLObj(VCLItem: TObject; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj; overload;
   function VCLObj(VCLItem: TObject; APopupMenu: TPopupMenu; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj; overload;
   //function ValidatorLabel(VCLTLabel: TObject; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj; overload;
   //function ValidatorLabel(AInvalidText: string): ID2BridgeItemVCLObj; overload;
   //function Validation(AInvalidText: string);
   //function Validation(AInvalidText: string; AValidText: string; AUseToolTip: Boolean = false);
   function VCLObj(VCLItem: TObject; AValidationGroup: Variant; ARequired: Boolean = false; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj; overload;
   function VCLObjHidden(VCLItem: TObject): ID2BridgeItemVCLObj;
//   function FormGroup(ATextLabel: String = ''; AHTMLinLine: Boolean = false; AColSize: string = 'col-auto'; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLFormGroup; overload;
   function FormGroup(ATextLabel: String = ''; AColSize: string = 'col-auto'; AItemID: string = ''; AHTMLinLine: Boolean = false; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLFormGroup; overload;
   {$IFNDEF FMX}
   procedure FormGroup(LabelEdit: TLabeledEdit; AColSize: string = 'col-auto'; AItemID: string = ''; AHTMLinLine: Boolean = false; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''); overload;
   {$ENDIF}
   //function PanelGroup: ID2BridgeItemHTMLPanelGroup; overload;
   function PanelGroup(ATitle: String = ''; AItemID: string = ''; AHTMLinLine: Boolean = false; AColSize: string = 'col'; ACSSClass: String = PanelColor.default; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLPanelGroup;
//   function Row: ID2BridgeItemHTMLRow; overload;
   function Row(ACSSClass: String = ''; AItemID: string = ''; AHTMLinLine: Boolean = false; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLRow;
   function HTMLDIV(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
//   function Row(AHTMLTag: String; ACSSClass: string = ''): ID2BridgeItemHTMLRow; overload;
   function Tabs(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLTabs;
   function Accordion(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLAccordion;
   function Popup(AName: String; ATitle: String = ''; AShowButtonClose: Boolean = true; ACSSClass: String = 'modal-lg'; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLPopup;
   function Nested(AFormNestedName: String): ID2BridgeItemNested; overload;
   function Nested(AD2BridgeForm: TObject): ID2BridgeItemNested; overload;
   function Upload(ACaption: string = 'Upload'; AAllowedFileTypes: string = '*'; AItemID: string = ''; AMaxFiles: integer = 12; AMaxFileSize: integer = 20; AInputVisible: Boolean = true; ACSSClassInput : string = 'form-control'; ACSSClassButtonUpload: string = 'btn btn-primary rounded-0'; ACSSClassButtonClear: string = 'btn btn-secondary rounded-0'; AFontICOUpload: String = 'fe-upload fa fa-upload me-2'; AFontICOClear: String = 'fe fe-x fa fa-x me-2'; AShowFinishMessage: Boolean = false; AMaxUploadSize: integer = 20): ID2BridgeItemHTMLInput;
   function HTMLElement(AHTMLElement: string; AItemID: string = ''): ID2BridgeItemHTMLElement; overload;
   function HTMLElement(ComponentHTMLElement: TComponent; AItemID: string = ''): ID2BridgeItemHTMLElement; overload;
   function Card(AHeaderTitle: string = ''; AColSize: string = ''; AText: string = '';  AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCard;
   function CardGroup(AMarginCardsSize: string = 'mx-2'; AItemID: string = ''; AColSize: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCardGroup;
   function CardGrid(AEqualHeight: boolean = false; AItemID: string = ''; AColSize: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCardGrid; overload;
{$IFNDEF FMX}
   function CardGrid({$IFNDEF FMX}ADataSource: TDataSource;{$ELSE}ARecordCount: integer;{$ENDIF} AColSize: string = ''; AEqualHeight: boolean = true; AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCardGridDataModel; overload;
{$ENDIF}
   function Link(AText: string = ''; AOnClick : TNotifyEvent = nil; AItemID: string = ''; Href: string = ''; OnClickCallBack : string = ''; AHint: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLLink; overload;
   function Link(AText: string; Href: string; AItemID: string = ''; OnClickCallBack : string = ''; AOnClick : TNotifyEvent = nil; AHint: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLLink; overload;
   function LinkCallBack(AText: string; OnClickCallBack : string; AItemID: string = ''; AHint: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLLink; overload;
   function Link(ComponentHTMLElement: TComponent; Href: string = ''; AOnClick : TNotifyEvent = nil; OnClickCallBack : string = ''; AHint: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLLink; overload;
   function Link(ComponentHTMLElement: TComponent; AOnClick : TNotifyEvent; Href: string = ''; OnClickCallBack : string = ''; AHint: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLLink; overload;
   function LinkCallBack(ComponentHTMLElement: TComponent; OnClickCallBack : string; AHint: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLLink; overload;
   function Carousel(AImageList: TStrings = nil; AItemID: string = ''; AAutoSlide: boolean = true; AInterval: integer = 4000; AShowIndicator: boolean = true; AShowButtons: boolean = true; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCarousel; overload;
{$IFNDEF FMX}
   function Carousel(ADataSource: TDataSource; ADataFieldImagePath: string; AItemID: string = ''; AAutoSlide: boolean = true; AInterval: integer = 4000; AShowIndicator: boolean = true; AShowButtons: boolean = true; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCarousel; overload;
{$ENDIF}
   function QRCode(AText: string = ''; AItemID: string = ''; ASize: integer = 128; AColor: string = 'black'; ABackgroudColor: string = 'white'; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLQRCode; overload;
{$IFNDEF FMX}
   function QRCode(ADataSource: TDataSource; ADataField: string; AItemID: string = ''; ASize: integer = 128; AColor: string = 'black'; ABackgroudColor: string = 'white'; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLQRCode; overload;
{$ENDIF}
   function SideMenu(MainMenu: {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF}): ID2BridgeItemHTMLSideMenu;
   function MainMenu(MainMenu: {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF}): ID2BridgeItemHTMLMainMenu;
   function ImageFromURL(AURL: string; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLImage;
   function ImageFromLocal(APathFromImage: string; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLImage;
   function ImageFromTImage(ATImage: TImage; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLImage;
{$IFNDEF FMX}
   function ImageFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLDBImage;
{$ENDIF}
   function Kanban(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLKanban;
   //ColSize
   function Col(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function ColAuto(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col1(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col2(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow; overload;
   function Col3(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col4(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col5(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col6(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col7(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col8(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col9(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col10(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col11(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col12(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function ColFull(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
 end;



 ID2BridgeAPIMailConfig = interface
  ['{4C699717-71AA-45B1-917D-A2A1DE40E7B6}']
   function GetUseThread: boolean;
   procedure SetHost(const Value: string);
   procedure SetPassword(const Value: string);
   procedure SetPort(const Value: integer);
   procedure SetUserName(const Value: string);
   procedure SetUseSSL(const Value: boolean);
   procedure SetUseThread(const Value: boolean);
   procedure SetUseTLS(const Value: boolean);
   function GetHost: string;
   function GetPassword: string;
   function GetPort: integer;
   function GetUserName: string;
   function GetUseSSL: boolean;
   function GetUseTLS: boolean;

   property Host: string read GetHost write SetHost;
   property Port: integer read GetPort write SetPort;
   property UserName: string read GetUserName write SetUserName;
   property Password: string read GetPassword write SetPassword;
   property UseSSL: boolean read GetUseSSL write SetUseSSL;
   property UseTLS: boolean read GetUseTLS write SetUseTLS;
   property UseThread: boolean read GetUseThread write SetUseThread;
 end;

 ID2BridgeAPIMailAddress = interface
  ['{23F7B7EF-7C7B-4C13-948C-1E0837832FA6}']
    function GetMailAddress: string;
    function GetName: string;
    procedure SetMailAddress(const Value: string);
    procedure SetName(const Value: string);

   function IsValidMailAddress: boolean;

    property Name: string read GetName write SetName;
    property MailAddress: string read GetMailAddress write SetMailAddress;
 end;

 ID2BridgeAPIMailAdresses = interface
  ['{8EBC63A4-9A1B-41CB-AB78-A5FCA9F3B674}']
   Procedure Clear;
   function GetAdresses: TList<ID2BridgeAPIMailAddress>;
   function Add: ID2BridgeAPIMailAddress; overload;
   procedure Add(Address: ID2BridgeAPIMailAddress); overload;

   property Items: TList<ID2BridgeAPIMailAddress> read GetAdresses;
 end;

 ID2BridgeAPIMail = interface
  ['{A2D939BA-1EFC-484D-9CF6-523C4DEF10B5}']
   function getSubject: string;
   procedure SetSubject(const Value: string);
   function getConfig: ID2BridgeAPIMailConfig;
   procedure SetConfig(const Value: ID2BridgeAPIMailConfig);

   function SendMail: boolean;

   procedure Clear;

   function Adresses: ID2BridgeAPIMailAdresses;
   function From: ID2BridgeAPIMailAddress;
   function BodyText: TStrings;
   function BodyHTML: TStrings;
   function Attachment: TStrings;

   property Config: ID2BridgeAPIMailConfig read GetConfig write SetConfig;
   property Subject: string read getSubject write SetSubject;
 end;


 ID2BridgeAPIAuthGoogleResponse = interface
  ['{E2621060-9F1E-4572-82EE-E5C3D45974EA}']
   function ID: string;
   function Name: string;
   function Email: string;
   function URLPicture: string;
   function Success: boolean;
 end;


 ID2BridgeAPIAuthGoogleConfig = interface
  ['{7FEC2950-A062-4FF8-9DC4-7BB0CAFD6A5C}']
   function GetClientID: string;
   procedure SetClientID(const Value: string);
   function GetClientSecret: string;
   procedure SetClientSecret(const Value: string);
   property ClientID: string read GetClientID write SetClientID;
   property ClientSecret: string read GetClientSecret write SetClientSecret;
 end;

 ID2BridgeAPIAuthGoogle = interface
  ['{955AA059-B146-4239-ABE4-30EB9DBBC893}']
  function Config: ID2BridgeAPIAuthGoogleConfig;
  procedure Logout;
  function Login: ID2BridgeAPIAuthGoogleResponse;
 end;


  ID2BridgeAPIAuthMicrosoftResponse = interface
  ['{A5C7056E-4D5A-463D-9F30-A6B9F2706A9E}']
   function ID: string;
   function Name: string;
   function Email: string;
   function PictureBase64: string;
   function FirstName: string;
   function SurName: string;
   function MobilePhone: string;
   function PreferredLanguage:string;
   function JobTitle: string;
   function Success: boolean;
 end;

 ID2BridgeAPIAuthMicrosoftConfig = interface
 ['{B2125B34-0D63-4D65-A5CD-BDED3970E504}']
   function GetClientID: string;
   procedure SetClientID(const Value: string);
   function GetClientSecret: string;
   procedure SetClientSecret(const Value: string);

   property ClientID: string read GetClientID write SetClientID;
   property ClientSecret: string read GetClientSecret write SetClientSecret;
 end;


 ID2BridgeAPIAuthMicrosoft = interface
 ['{9BFF666E-F2F5-497A-A142-3A62A3279A6B}']

  function Config: ID2BridgeAPIAuthMicrosoftConfig;

  procedure Logout;
  function Login: ID2BridgeAPIAuthMicrosoftResponse;
 end;




 ID2BridgeAPIAuth = interface
  ['{2E72F16C-DF7B-4A7E-96BF-2A66C5A13912}']
  function Google: ID2BridgeAPIAuthGoogle;
  function Microsoft: ID2BridgeAPIAuthMicrosoft;
 end;



 ID2BridgeAPIStorageAmazonS3 = interface
 ['{E735B427-F7CB-4DF3-8E5F-EB56FA1A0BF3}']
  function GetAccountKey: string;
  procedure SetAccountKey(const Value: string);
  function GetAccountName: string;
  procedure SetAccountName(const Value: string);
  function GetStorageEndPoint: string;
  procedure SetStorageEndPoint(const Value: string);
  function GetBucket: string;
  procedure SetBucket(const Value: string);
  function GetFileStoragePath: string;
  procedure SetFileStoragePath(const Value: string);
  function GetFileName: string;
  procedure SetFileName(const Value: string);
  function GetContentType: string;
  procedure SetContentType(const Value: string);
  function GetFileStream: TStream;
  procedure SetFileStream(const Value: TStream);
  function GetError: String;
  procedure SetError(const Value: string);
  function GetURL_File: String;
  procedure SetURL_File(const Value: string);

  property AccountKey: string read GetAccountKey write SetAccountKey;
  property AccountName: string read GetAccountName write SetAccountName;
  property StorageEndPoint: string read GetStorageEndPoint write SetStorageEndPoint;
  property Bucket: string read GetBucket write SetBucket;
  property FileStoragePath: string read GetFileStoragePath write SetFileStoragePath;
  property FileName: string read GetFileName write SetFileName;
  property ContentType: string read GetContentType write SetContentType;
  property FileStream: TStream read GetFileStream write SetFileStream;
  property Error: string read GetError write SetError;
  property URL_File: string read GetURL_File write SetURL_File;

  function UploadFile:boolean;
 end;


 ID2BridgeAPIStorage = interface
 ['{B716A497-1E61-41C2-B476-C1109829B3C0}']
  function AmazonS3: ID2BridgeAPIStorageAmazonS3;
 end;



(*  ID2BridgeAPIEvolutionWhatsAppResponse = interface
  ['{3CC9785E-DF69-4341-9D9D-F3FCD997EEB6}']
   function ID: string;
   function Name: string;
   function Email: string;
   function PictureBase64: string;
   function FirstName: string;
   function SurName: string;
   function MobilePhone: string;
   function PreferredLanguage:string;
   function JobTitle: string;
   function Success: boolean;
 end;

  ID2BridgeAPIEvolutionWhatsAppMessageSendResponse = interface
['{02C2D843-E4E6-4CA7-B2F7-7AC49178B428}']
   function ID: string;
   function RemoteJid: string;
   function Status: string;
   function Json: string;
   function Success: boolean;
 end;     *)
//WhatsApp Contact
 ID2BridgeAPIEvolutionWhatsAppContact = interface
['{29CFBB59-23DC-4D5B-8114-13FCBF72D8DE}']
   function CheckIsWhatsapp: Boolean;
   function FetchProfilePictureUrl: Boolean;

   function GetName: string;
   procedure SetName(const Value: string);
   function GetRemoteJid: string;
   procedure SetRemoteJid(const Value: string);
   function GetNumberPhone: string;
   procedure SetNumberPhone(const Value: string);
   function GetPictureProfile: string;
   procedure SetPictureProfile(const Value: string);
   function GetError: string;
   procedure SetError(const Value: string);



   property Error: string read GetError write SetError;
   property Name: string read GetName write SetName;
   property NumberPhone: string read GetNumberPhone write SetNumberPhone;
   property RemoteJid: string read GetRemoteJid write SetRemoteJid;
   property PictureProfile: string read GetPictureProfile write SetPictureProfile;
  end;


  ID2BridgeAPIEvolutionWhatsAppMessage = interface
  ['{F5B22D9F-9465-4D95-8432-7E1D07E3A5DB}']
    function GetID: string;
    procedure SetID(const Value: string);
    function GetText: string;
    procedure SetText(const Value: string);
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    function GetError: string;
    procedure SetError(const Value: string);

    property ID: string read GetID write SetID;
    property Text: string read GetText write SetText;
    property FileName: string read GetFileName write SetFileName;
    property Error: string read GetError write SetError;
    function SendText: boolean;
    function SendTextAndFile: Boolean;
    function SendLocation(Name, Adress,latitude,longitude:string): boolean;
    function SendContactSingle(fullName, wuid, phoneNumber, organization, email, url: string): boolean;
  end;


  ID2BridgeAPIEvolutionWhatsAppInstance = interface
  ['{11C8CFA0-A1D5-461D-8014-D636A78B2173}']
   function CreateInstance: Boolean;
   function ConnectionState: Boolean;
   function Connect: Boolean;
   function Diconnect: Boolean;
   function Delete: Boolean;
   function GetName: string;
   procedure SetName(const Value: string);
   function GetmsgCall: string;
   procedure SetmsgCall(const Value: string);
   function GetKey: string;
   procedure SetKey(const Value: string);
   function GetNumber: string;
   procedure SetNumber(const Value: string);
   function GetID: string;
   procedure SetID(const Value: string);
   function GetState: string;
   procedure SetState(const Value: string);
   function GetPairingCode: string;
   procedure SetPairingCode(const Value: string);

   function GetQrCodeCode: string;
   procedure SetQrCodeCode(const Value: string);
   function GetQrCodeBase64: string;
   procedure SetQrCodeBase64(const Value: string);
   function GetError: string;
   procedure SetError(const Value: string);

   property Name: string read GetName write SetName;
   property msgCall: string read GetmsgCall write SetmsgCall;
   property Key: string read GetKey write SetKey;
   property Number: string read GetNumber write SetNumber;
   property ID: string read GetID write SetID;
   property State: string read GetState write SetState;
   property PairingCode: string read GetPairingCode write SetPairingCode;
   property QrCodeCode: string read GetQrCodeCode write SetQrCodeCode;
   property QrCodeBase64: string read GetQrCodeBase64 write SetQrCodeBase64;
   property Error: string read GetError write SetError;
  end;

  ID2BridgeAPIEvolutionWhatsAppServer = interface
  ['{F2D3197E-6C0F-48D3-BBE2-599A7B64BC0D}']
   function Verify: Boolean;

   function GetHost: string;
   procedure SetHost(const Value: string);
   function GetGlobalKey: string;
   procedure SetGlobalKey(const Value: string);
   function GetOnline: Boolean;
   procedure SetOnline(const Value: Boolean);
   function GetStatusCode: string;
   procedure SetStatusCode(const Value: string);
   function GetVersion: string;
   procedure SetVersion(const Value: string);
   function GetMessage: string;
   procedure SetMessage(const Value: string);
   function GetClientName: string;
   procedure SetClientName(const Value: string);
   function GetSwagger: string;
   procedure SetSwagger(const Value: string);
   function GetManager: string;
   procedure SetManager(const Value: string);
   function GetDocumentation: string;
   procedure SetDocumentation(const Value: string);

   property Host: string read GetHost write SetHost;
   property GlobalKey: string read GetGlobalKey write SetGlobalKey;
   property Online: Boolean read GetOnline write SetOnline;
   property StatusCode: string read GetStatusCode write SetStatusCode;
   property Message: string read GetMessage write SetMessage;
   property Version: string read GetVersion write SetVersion;
   property ClientName: string read GetClientName write SetClientName;
   property Swagger: String read GetSwagger write SetSwagger;
   property Manager: string read GetManager write SetManager;
   property Documentation: string read GetDocumentation write SetDocumentation;
  end;

 ID2BridgeAPIEvolutionWhatsApp = interface
 ['{2816B26B-5320-4EE0-BDD4-14518DF9A439}']
  function Server: ID2BridgeAPIEvolutionWhatsAppServer;
  function Instance: ID2BridgeAPIEvolutionWhatsAppInstance;
  function Contact: ID2BridgeAPIEvolutionWhatsAppContact;
  function Message: ID2BridgeAPIEvolutionWhatsAppMessage;
 end;


 ID2BridgeAPIEvolution = interface
['{B6C0D10A-1D18-433D-97A4-0FD25217239C}']
  function WhatsApp: ID2BridgeAPIEvolutionWhatsApp;
 end;


 ID2BridgeAPIQRCode = interface
  ['{EA38A602-3D80-4F1E-B7F5-3FE4A1431280}']
   function GetText: string;
   procedure SetText(const Value: string);
   function GetSize: integer;
   procedure SetSize(const Value: integer);
   function GetColorCode: string;
   procedure SetColorCode(const Value: string);
   function GetColorBackground: string;
   procedure SetColorBackground(const Value: string);

   function QRCodeBitmap: TBitmap;
   function QRCodeJPG: TJPEGImage;
   function QRCodeImage: TImage;
   function QRCodeBase64: String;

   property Text: string read GetText write SetText;
   property Size: integer read GetSize write SetSize;
   property ColorCode: string read GetColorCode write SetColorCode;
   property ColorBackground: string read GetColorBackground write SetColorBackground;
 end;


implementation


end.
