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

unit D2Bridge.ItemCommon.Add;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
{$IFDEF FMX}
  FMX.Menus, FMX.StdCtrls, FMX.Objects,
{$ELSE}
  Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.HTML.CSS, Data.DB;



type
  TItemAdd = class(TInterfacedPersistent, IItemAdd)
  strict private

  private
   FD2BridgeItems: ID2BridgeAddItems;
  public
   //Generic
   procedure D2BridgeItem(AD2BridgeItem: TObject);
   //Functions
   function VCLObj: ID2BridgeItemVCLObj; overload;
   function VCLObj(VCLItem: TObject; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj; overload;
   function VCLObj(VCLItem: TObject; APopupMenu: TPopupMenu; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj; overload;
   function VCLObj(VCLItem: TObject; AValidationGroup: Variant; ARequired: Boolean; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj; overload;
   function VCLObjHidden(VCLItem: TObject): ID2BridgeItemVCLObj;
   function Row(ACSSClass: String = ''; AItemID: string = ''; AHTMLinLine: Boolean = false; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLRow;
   function FormGroup(ATextLabel: String = ''; AColSize: string = 'col-auto'; AItemID: string = ''; AHTMLinLine: Boolean = false; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLFormGroup; overload;
{$IFNDEF FMX}
   procedure FormGroup(LabeledEdit: TLabeledEdit; AColSize: string = 'col-auto'; AItemID: string = ''; AHTMLinLine: Boolean = false; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''); overload;
{$ENDIF}
   function PanelGroup(ATitle: String = ''; AItemID: string = ''; AHTMLinLine: Boolean = false; AColSize: string = 'col'; ACSSClass: String = PanelColor.default; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLPanelGroup;
   function HTMLDIV(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Tabs(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLTabs;
   function Accordion(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLAccordion;
   function Popup(AName: String; ATitle: String = ''; AShowButtonClose: Boolean = true; ACSSClass: String = 'modal-lg'; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLPopup;
   function Nested(AFormNestedName: String): ID2BridgeItemNested; overload;
   function Nested(AD2BridgeForm: TObject): ID2BridgeItemNested; overload;
   function Upload(ACaption: string = 'Upload'; AAllowedFileTypes: string = '*'; AItemID: string = ''; AMaxFiles: integer = 12; AMaxFileSize: integer = 20; AInputVisible: Boolean = true; ACSSInput : string = 'form-control'; ACSSButtonUpload: string = 'btn btn-primary rounded-0'; ACSSButtonClear: string = 'btn btn-secondary rounded-0'; AFontICOUpload: String = 'fe-upload fa fa-upload me-2'; AFontICOClear: String = 'fe fe-x fa fa-x me-2'; AShowFinishMessage: Boolean = false; AMaxUploadSize: integer = 128): ID2BridgeItemHTMLInput;
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
   function QRCode(AText: string = ''; AItemID: string = ''; ASize: integer = 128; AColorCode: string = 'black'; AColorBackgroud: string = 'white'; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLQRCode; overload;
{$IFNDEF FMX}
   function QRCode(ADataSource: TDataSource; ADataField: string; AItemID: string = ''; ASize: integer = 128; AColorCode: string = 'black'; AColorBackgroud: string = 'white'; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLQRCode; overload;
{$ENDIF}
   function SideMenu(MainMenu: {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF}): ID2BridgeItemHTMLSideMenu;
   function MainMenu(MainMenu: {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF}): ID2BridgeItemHTMLMainMenu;
   function ImageFromURL(AURL: string; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLImage;
   function ImageFromLocal(PathFromImage: string; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLImage;
   function ImageFromTImage(ATImage: TImage; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLImage;
{$IFNDEF FMX}
   function ImageFromDB(ADataSource: TDataSource; ADataFieldImagePath: string; ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLDBImage;
{$ENDIF}
   function Kanban(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLKanban;
   //Col Size
   function Col(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function ColAuto(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col1(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
   function Col2(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
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

   constructor Create(D2BridgeItems: ID2BridgeAddItems);
   destructor Destroy; override;
 end;


implementation

uses
  D2Bridge.ItemCommon, D2Bridge.BaseClass, D2Bridge.Item, D2Bridge.Item.HTML.Row, D2Bridge.Item.HTML.FormGroup,
  D2Bridge.Forms,
  D2Bridge.Item.VCLObj, D2Bridge.Item.Nested, D2Bridge.Item.HTML.Card, D2Bridge.Item.HTML.Card.Group,
  D2Bridge.Item.HTML.Card.Grid, D2Bridge.Item.HTML.Card.Grid.DataModel,
  D2Bridge.Item.HTML.PanelGroup, D2Bridge.Item.HTML.Tabs,
  D2Bridge.Item.HTML.Accordion, D2Bridge.Item.HTML.Popup, D2Bridge.Item.HTML.Upload,
  D2Bridge.Item.HTMLelement, D2Bridge.Item.HTML.Link, D2Bridge.Item.HTML.Carousel, D2Bridge.Item.HTML.QRCode,
  D2Bridge.Item.HTML.MainMenu, D2Bridge.Item.HTML.SideMenu, D2Bridge.Item.HTML.Image, D2Bridge.Item.HTML.DBImage,
  D2Bridge.Item.HTML.Kanban;

{ TItemsAdd }

function TItemAdd.Accordion(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLAccordion;
begin
 Result := TD2BridgeItemHTMLAccordion.Create(TD2BridgeItems(FD2BridgeItems).BaseClass);
 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Accordion')
 else
  Result.ItemID:= AItemID;
 if ACSSClass <> '' then
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.Card(AHeaderTitle: string = ''; AColSize: string = ''; AText: string = '';  AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCard;
begin
 Result:= TD2BridgeItemHTMLCard.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Card')
 else
  Result.ItemID:= AItemID;
 //Result.Title:= ATitle;
 if AHeaderTitle <> '' then 
 Result.Header(AHeaderTitle);
 Result.Text:= AText;
 Result.ColSize:= AColSize;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.CardGrid(AEqualHeight: boolean; AItemID, AColSize, ACSSClass,
  AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLCardGrid;
begin
 Result:= TD2BridgeItemHTMLCardGrid.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('CardGrid')
 else
  Result.ItemID:= AItemID;
 Result.EqualHeight:= AEqualHeight;
 Result.ColSize:= AColSize;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);

end;

{$IFNDEF FMX}
function TItemAdd.CardGrid({$IFNDEF FMX}ADataSource: TDataSource;{$ELSE}ARecordCount: integer;{$ENDIF}
  AColSize: string; AEqualHeight: boolean; AItemID, ACSSClass, AHTMLExtras,
  AHTMLStyle: String): ID2BridgeItemHTMLCardGridDataModel;
begin
 Result:= TD2BridgeItemHTMLCardGridDataModel.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('CardGriddatamodel')
 else
  Result.ItemID:= AItemID;
 Result.EqualHeight:= AEqualHeight;
 Result.ColSize:= AColSize;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;
 Result.DataSource:= ADataSource;

 FD2BridgeItems.Add(Result);
end;
{$ENDIF}

function TItemAdd.CardGroup(AMarginCardsSize, AItemID, AColSize, ACSSClass,
  AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLCardGroup;
begin
 Result:= TD2BridgeItemHTMLCardGroup.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('CardGroup')
 else
  Result.ItemID:= AItemID;
 Result.MarginCardsSize:= AMarginCardsSize;
 Result.ColSize:= AColSize;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

{$IFNDEF FMX}
function TItemAdd.Carousel(ADataSource: TDataSource; ADataFieldImagePath,
  AItemID: string; AAutoSlide: boolean; AInterval: integer; AShowIndicator,
  AShowButtons: boolean; ACSSClass, AHTMLExtras,
  AHTMLStyle: String): ID2BridgeItemHTMLCarousel;
begin
 Result:= Carousel(nil, AItemID, AAutoSlide, AInterval, AShowIndicator, AShowButtons, ACSSClass, AHTMLExtras, AHTMLStyle);

 if Assigned(ADataSource) then
  Result.PrismCarousel.DataSource:= ADataSource;
 Result.PrismCarousel.DataFieldImagePath:= ADataFieldImagePath;
end;
{$ENDIF}

function TItemAdd.Carousel(AImageList: TStrings; AItemID: string;
  AAutoSlide: boolean; AInterval: integer; AShowIndicator,
  AShowButtons: boolean; ACSSClass, AHTMLExtras,
  AHTMLStyle: String): ID2BridgeItemHTMLCarousel;
begin
 Result:= TD2BridgeItemHTMLCarousel.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Carousel')
 else
  Result.ItemID:= AItemID;

 if Assigned(AImageList) then
  Result.PrismCarousel.ImageFiles.AddRange(AImageList.ToStringArray);
 Result.PrismCarousel.AutoSlide:= AAutoSlide;
 Result.PrismCarousel.Interval:= AInterval;
 Result.PrismCarousel.ShowIndicator:= AShowIndicator;
 Result.PrismCarousel.ShowButtons:= AShowButtons;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;


constructor TItemAdd.Create(D2BridgeItems: ID2BridgeAddItems);
begin
 FD2BridgeItems:= D2BridgeItems;
end;

procedure TItemAdd.D2BridgeItem(AD2BridgeItem: TObject);
var
 vD2BridgeItem: ID2BridgeItem;
begin
 if Supports(AD2BridgeItem, ID2BridgeItem, vD2BridgeItem) then
 begin
  if vD2BridgeItem.ItemID = '' then
   vD2BridgeItem.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('d2bridgeitem');
  FD2BridgeItems.Add(vD2BridgeItem);
 end;
end;

destructor TItemAdd.Destroy;
begin
 inherited;
end;


{$IFNDEF FMX}
procedure TItemAdd.FormGroup(LabeledEdit: TLabeledEdit; AColSize, AItemID: string; AHTMLinLine: Boolean; ACSSClass, AHTMLExtras, AHTMLStyle: String);
var
 vFormGroup: TD2BridgeItemHTMLFormGroup;
begin
 vFormGroup:= FormGroup(LabeledEdit.EditLabel.Caption, AColSize, AItemID, AHTMLinLine, ACSSClass, AHTMLExtras, AHTMLStyle) as TD2BridgeItemHTMLFormGroup;
 vFormGroup.AddVCLObj(LabeledEdit);
end;
{$ENDIF}


function TItemAdd.FormGroup(ATextLabel: String = ''; AColSize: string = 'col-auto'; AItemID: string = ''; AHTMLinLine: Boolean = false; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLFormGroup;
begin
 Result := TD2BridgeItemHTMLFormGroup.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 if AItemID = '' then
 Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('FormGroup')
 else
 Result.ItemID:= AItemID;
 Result.TextLabel:= ATextLabel;
 Result.ColSize1:= AColSize;
 Result.HTMLInLine:= AHTMLinLine;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;


function TItemAdd.HTMLDIV(ACSSClass: String = ''; AItemID: string = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''; AHTMLTag: String = 'div'): ID2BridgeItemHTMLRow;
begin
 Result := TD2BridgeItemHTMLRow.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('div')
 else
  Result.ItemID:= AItemID;

 Result.HTMLTagRow:= AHTMLTag;
 Result.CSSClasses:= trim('d2bridgediv ' + ACSSClass);
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.HTMLElement(ComponentHTMLElement: TComponent; AItemID: string = ''): ID2BridgeItemHTMLElement;
begin
 Result := TD2BridgeItemHTMLElement.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 if AItemID <> '' then
  Result.ItemID:= AItemID
 else
  Result.ItemID:= ComponentHTMLElement.Name;

 Result.ComponentHTMLElement:= ComponentHTMLElement;

 FD2BridgeItems.Add(Result);
end;

{$IFNDEF FMX}
function TItemAdd.ImageFromDB(ADataSource: TDataSource; ADataFieldImagePath,
  ACSSClass, AItemID, AHTMLExtras,
  AHTMLStyle: String): ID2BridgeItemHTMLDBImage;
begin
 Result := TD2BridgeItemHTMLDBImage.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= ((FD2BridgeItems as TD2BridgeItems).BaseClass as TD2BridgeClass).CreateItemID('img')
 else
  Result.ItemID:= AItemID;

 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 Result.DataSource:= ADataSource;
 Result.DataFieldImagePath:= ADataFieldImagePath;

 FD2BridgeItems.Add(Result);
end;
{$ENDIF}

function TItemAdd.ImageFromLocal(PathFromImage, ACSSClass, AItemID, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLImage;
begin
 Result := TD2BridgeItemHTMLImage.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= ((FD2BridgeItems as TD2BridgeItems).BaseClass as TD2BridgeClass).CreateItemID('img')
 else
  Result.ItemID:= AItemID;

 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 Result.ImageFromLocal(PathFromImage);

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.ImageFromTImage(ATImage: TImage; ACSSClass, AItemID, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLImage;
begin
 Result := TD2BridgeItemHTMLImage.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= ((FD2BridgeItems as TD2BridgeItems).BaseClass as TD2BridgeClass).CreateItemID('img')
 else
  Result.ItemID:= AItemID;

 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 Result.ImageFromTImage(ATImage);

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.ImageFromURL(AURL, ACSSClass, AItemID, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLImage;
begin
 Result := TD2BridgeItemHTMLImage.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= ((FD2BridgeItems as TD2BridgeItems).BaseClass as TD2BridgeClass).CreateItemID('img')
 else
  Result.ItemID:= AItemID;

 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 Result.ImageFromURL(AURL);

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.Kanban(AItemID, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLKanban;
begin
 Result := TD2BridgeItemHTMLKanban.Create(TD2BridgeItems(FD2BridgeItems).BaseClass);
 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('kanban')
 else
  Result.ItemID:= AItemID;
 if ACSSClass <> '' then
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

//ColSize
function TItemAdd.Col(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.Col + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.ColAuto(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colauto + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.ColFull(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colfull + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col1(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize1 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col2(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize2 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col3(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize3 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col4(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize4 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col5(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize5 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col6(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize6 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col7(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize7 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col8(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize8 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col9(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize9 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col10(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize10 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col11(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize11 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Col12(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag: String): ID2BridgeItemHTMLRow;
begin
 ACSSClass:= Trim(ACSSClass + ' ' + D2Bridge.HTML.CSS.Col.colsize12 + ' '+D2Bridge.HTML.CSS.Col.colinline);

 Result:= HTMLDIV(ACSSClass, AItemID, AHTMLExtras, AHTMLStyle, AHTMLTag);
end;

function TItemAdd.Link(ComponentHTMLElement: TComponent; Href: string; AOnClick: TNotifyEvent; OnClickCallBack, AHint, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLLink;
begin
 Result:= TD2BridgeItemHTMLLink.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if Assigned(ComponentHTMLElement) then
 begin
  Result.ItemID:= ComponentHTMLElement.Name;
  Result.PrismLink.LabelHTMLElement:= ComponentHTMLElement;
 end;

 if Result.ItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Link');

// if Href = '' then
//  Href:= '#';

 Result.PrismLink.href:= Href;
 Result.PrismLink.OnClick := AOnClick;
 Result.PrismLink.OnClickCallBack := OnClickCallBack;
 Result.PrismLink.Hint := AHint;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);

end;

function TItemAdd.LinkCallBack(AText, OnClickCallBack, AItemID, AHint, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLLink;
begin
 Result:= TD2BridgeItemHTMLLink.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

// if Href = '' then
//  Href:= '#';

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Link')
 else
  Result.ItemID:= AItemID;

 Result.PrismLink.Text:= AText;
// Result.PrismLink.href:= Href;
// Result.PrismLink.OnClick := AOnClick;
 Result.PrismLink.OnClickCallBack := OnClickCallBack;
 Result.PrismLink.Hint := AHint;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.Nested(AD2BridgeForm: TObject): ID2BridgeItemNested;
begin
 Result:= TD2BridgeItemNested.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Nested');
 Result.NestedFormName:= TD2BridgeForm(AD2BridgeForm).NestedName;

 FD2BridgeItems.Add(Result);
end;


function TItemAdd.HTMLElement(AHTMLElement: string; AItemID: string = ''): ID2BridgeItemHTMLElement;
begin
 Result := TD2BridgeItemHTMLElement.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('htmlelement')
 else
  Result.ItemID:= AItemID;

 Result.HTML:= AHTMLElement;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.Nested(AFormNestedName: String): ID2BridgeItemNested;
begin
 Result:= TD2BridgeItemNested.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Nested');
 Result.NestedFormName:= AFormNestedName;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.PanelGroup(ATitle: String = ''; AItemID: string = ''; AHTMLinLine: Boolean = false; AColSize: string = 'col'; ACSSClass: String = PanelColor.default; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLPanelGroup;
begin
 Result:= TD2BridgeItemHTMLPanelGroup.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('PanelGroup')
 else
  Result.ItemID:= AItemID;
 Result.Title:= ATitle;
 Result.ColSize:= AColSize;
 Result.HTMLInLine:= AHTMLinLine;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.Popup(AName: String; ATitle: String = ''; AShowButtonClose: Boolean = true; ACSSClass: String = 'modal-lg'; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLPopup;
begin
 Result := TD2BridgeItemHTMLPopup.Create(TD2BridgeItems(FD2BridgeItems).BaseClass);
 Result.ItemID:= AnsiUpperCase(AName);
 Result.Title:= ATitle;
 Result.ShowButtonClose:= AShowButtonClose;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);

 TD2BridgeItems(FD2BridgeItems).BaseClass.AddPopup(Result);
end;

{$IFNDEF FMX}
function TItemAdd.QRCode(ADataSource: TDataSource; ADataField,
  AItemID: string; ASize: integer; AColorCode, AColorBackgroud, ACSSClass,
  AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLQRCode;
begin
 Result:= QRCode;

 Result.PrismQRCode.DataSource:= ADataSource;
 Result.PrismQRCode.DataField:= ADataField;
end;
{$ENDIF}

function TItemAdd.QRCode(AText, AItemID: string; ASize: integer; AColorCode,
  AColorBackgroud, ACSSClass, AHTMLExtras,
  AHTMLStyle: String): ID2BridgeItemHTMLQRCode;
begin
 Result:= TD2BridgeItemHTMLQRCode.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('QRCode')
 else
  Result.ItemID:= AItemID;

 Result.PrismQRCode.Text:= AText;
 Result.PrismQRCode.ColorCode:= AColorCode;
 Result.PrismQRCode.ColorBackground:= AColorBackgroud;
 Result.PrismQRCode.Size:= ASize;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

//function TItemAdd.Row(AHTMLTag, ACSSClass: String): ID2BridgeItemHTMLRow;
//begin
// Result:= Row;
// Result.HTMLTagRow:= AHTMLTag;
// Result.CSS:= ACSS;
//end;

//function TItemAdd.PanelGroup: ID2BridgeItemHTMLPanelGroup;
//begin
// Result := TD2BridgeItemHTMLPanelGroup.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
//
// FD2BridgeItems.Add(Result);
//end;

function TItemAdd.Row(ACSSClass: String = ''; AItemID: string = ''; AHTMLinLine: Boolean = false; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLRow;
begin
 Result := TD2BridgeItemHTMLRow.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('row')
 else
  Result.ItemID:= AItemID;

 if Pos('row', ACSSClass) <= 0 then
  ACSSClass := Trim('row ' + ACSSClass);

 Result.HTMLTagRow:= 'div';
 Result.HTMLInLine:= AHTMLinLine;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.SideMenu(MainMenu: {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF}): ID2BridgeItemHTMLSideMenu;
begin
 Result := TD2BridgeItemHTMLSideMenu.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 Result.ItemID:= MainMenu.Name;

 Result.Options.VCLComponent:= MainMenu;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.Tabs(AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLTabs;
begin
 Result := TD2BridgeItemHTMLTabs.Create(TD2BridgeItems(FD2BridgeItems).BaseClass);
 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Tabs')
 else
  Result.ItemID:= AItemID;
 if ACSSClass <> '' then
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.Upload(ACaption: string = 'Upload'; AAllowedFileTypes: string = '*'; AItemID: string = ''; AMaxFiles: integer = 12; AMaxFileSize: integer = 20; AInputVisible: Boolean = true; ACSSInput : string = 'form-control'; ACSSButtonUpload: string = 'btn btn-primary rounded-0'; ACSSButtonClear: string = 'btn btn-secondary rounded-0'; AFontICOUpload: String = 'fe-upload fa fa-upload me-2'; AFontICOClear: String = 'fe fe-x fa fa-x me-2'; AShowFinishMessage: Boolean = false; AMaxUploadSize: integer = 128): ID2BridgeItemHTMLInput;
begin
 Result:= TD2BridgeItemHTMLUpload.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Upload')
 else
  Result.ItemID:= AItemID;
 Result.CaptionUpload:= ACaption;
 if AMaxFiles = 0 then
  Result.MaxFiles:= 12;
 Result.MaxFiles:= AMaxFiles;
 if AMaxFileSize = 0 then
  Result.MaxFileSize := 20;
 Result.MaxFileSize:= AMaxFileSize;
 if AMaxUploadSize = 0 then
  AMaxUploadSize:= 128;
 Result.MaxUploadSize:= AMaxUploadSize;
 Result.InputVisible:= AInputVisible;
 Result.CSSInput:= ACSSInput;
 Result.CSSButtonUpload:= ACSSButtonUpload;
 Result.CSSButtonClear:= ACSSButtonClear;
 Result.IconButtonUpload:= AFontICOUpload;
 Result.IconButtonClear:= AFontICOClear;

 if AAllowedFileTypes = '*' then
  Result.AllowedFileTypes.Text:= ''
 else
  Result.AllowedFileTypes.Text:= AAllowedFileTypes;

 Result.ShowFinishMessage:= AShowFinishMessage;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.VCLObj: ID2BridgeItemVCLObj;
var
 FItemID: string;
begin
 Result := TD2BridgeItemVCLObj.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('D2BridgeItemVCLObj');
 FD2BridgeItems.Add(Result);
end;

function TItemAdd.VCLObj(VCLItem: TObject; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj;
begin
 if not TD2BridgeItems(FD2BridgeItems).BaseClass.D2BridgeManager.SupportsVCLClass(VCLItem.ClassType) then
   Exit;

 Result:= VCLObj;
 Result.Item:= TComponent(VCLItem);
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= HTMLExtras;
 Result.HTMLStyle:= HTMLStyle;
end;

function TItemAdd.VCLObj(VCLItem: TObject; APopupMenu: TPopupMenu; ACSSClass, HTMLExtras, HTMLStyle: String): ID2BridgeItemVCLObj;
begin
 if not TD2BridgeItems(FD2BridgeItems).BaseClass.D2BridgeManager.SupportsVCLClass(VCLItem.ClassType) then
  Exit;

 Result:= VCLObj(VCLItem, ACSSClass, HTMLExtras, HTMLStyle);
 if Assigned(APopupMenu) then
 Result.PopupMenu:= APopupMenu;
end;

function TItemAdd.VCLObjHidden(VCLItem: TObject): ID2BridgeItemVCLObj;
begin
 if not TD2BridgeItems(FD2BridgeItems).BaseClass.D2BridgeManager.SupportsVCLClass(VCLItem.ClassType) then
  Exit;

 Result:= VCLObj;
 Result.Hidden:= true;
 Result.Item:= TComponent(VCLItem);
end;

function TItemAdd.VCLObj(VCLItem: TObject; AValidationGroup: Variant; ARequired: Boolean; ACSSClass: String = ''; HTMLExtras: String = ''; HTMLStyle: String = ''): ID2BridgeItemVCLObj;
begin
  if not TD2BridgeItems(FD2BridgeItems).BaseClass.D2BridgeManager.SupportsVCLClass(VCLItem.ClassType) then
  Exit;

 Result:= VCLObj(VCLItem, ACSSClass, HTMLExtras, HTMLStyle);
 Result.Required:= ARequired;
 Result.ValidationGroup:= AValidationGroup;
end;

function TItemAdd.Link(ComponentHTMLElement: TComponent; AOnClick: TNotifyEvent; Href, OnClickCallBack, AHint, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLLink;
begin
 Result:= Link(ComponentHTMLElement, Href, AOnClick, OnClickCallBack, AHint, ACSSClass, AHTMLExtras, AHTMLStyle);
end;

function TItemAdd.Link(AText, Href, AItemID, OnClickCallBack: string; AOnClick: TNotifyEvent; AHint, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLLink;
begin
 result:= Link(AText, AOnClick, AItemID, Href, OnClickCallBack, AHint, ACSSClass, AHTMLExtras, AHTMLStyle);
end;

function TItemAdd.Link(AText: string; AOnClick: TNotifyEvent; AItemID, Href, OnClickCallBack, AHint, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLLink;
begin
 Result:= TD2BridgeItemHTMLLink.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

// if Href = '' then
//  Href:= '#';

 if AItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Link')
 else
  Result.ItemID:= AItemID;

 Result.PrismLink.Text:= AText;
 Result.PrismLink.href:= Href;
 Result.PrismLink.OnClick := AOnClick;
 Result.PrismLink.OnClickCallBack := OnClickCallBack;
 Result.PrismLink.Hint := AHint;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.LinkCallBack(ComponentHTMLElement: TComponent; OnClickCallBack, AHint, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLLink;
begin
 Result:= TD2BridgeItemHTMLLink.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));

 if Assigned(ComponentHTMLElement) then
 begin
  Result.ItemID:= ComponentHTMLElement.Name;
  Result.PrismLink.LabelHTMLElement:= ComponentHTMLElement;
 end;

 if Result.ItemID = '' then
  Result.ItemID:= TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass).CreateItemID('Link');

// if Href = '' then
//  Href:= '#';

// Result.PrismLink.href:= Href;
// Result.PrismLink.OnClick := AOnClick;
 Result.PrismLink.OnClickCallBack := OnClickCallBack;
 Result.PrismLink.Hint := AHint;
 Result.CSSClasses:= ACSSClass;
 Result.HTMLExtras:= AHTMLExtras;
 Result.HTMLStyle:= AHTMLStyle;

 FD2BridgeItems.Add(Result);
end;

function TItemAdd.MainMenu(MainMenu: {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF}): ID2BridgeItemHTMLMainMenu;
begin
 Result := TD2BridgeItemHTMLMainMenu.Create(TD2BridgeClass(TD2BridgeItems(FD2BridgeItems).BaseClass));
 Result.ItemID:= MainMenu.Name;

 Result.Options.VCLComponent:= MainMenu;

 FD2BridgeItems.Add(Result);
end;

end.
