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

unit D2Bridge.Item.VCLObj;


interface

//{$M+}

uses
  System.Classes, System.UITypes,
{$IFDEF FMX}
  FMX.Menus, FMX.StdCtrls, FMX.Graphics,
{$ELSE}
  Vcl.Menus, Vcl.StdCtrls, Vcl.Forms, Vcl.Graphics,
{$ENDIF}
  Prism.Interfaces, Prism.Types,
  D2Bridge.BaseClass, D2Bridge.Item, D2bridge.Interfaces;


type
 TD2BridgeItemVCLObj = class(TD2BridgeItem, ID2BridgeItemVCLObj)
  private
   FItem: TComponent;
   FPopupMenu: TPopupMenu;
   FIsHidden: Boolean;
   FBridgeVCLObj: ID2BridgeVCLObj;
   FRequired: Boolean;
   FValidationGroup: Variant;
   FButtonIcon: string;
   FButtonIconPosition: TPrismPosition;
   FPopupHTML: TStrings;
   FVCLObjStyle: ID2BridgeItemVCLObjStyle;
   function GetIsHidden: Boolean;
   procedure SetIsHidden(AIsHidden: Boolean);
   function BridgeVCLObjClass(VCLObjClass: TClass): ID2BridgeVCLObj;
   function GetHTMLStyle: string; override;
   function GetItem: TComponent;
   procedure SetItem(AItemVCLObj: TComponent);
   procedure RenderPopupMenu;
   function GetRequired: Boolean;
   procedure SetRequired(ARequired: Boolean);
   function GetValidationGroup: Variant;
   Procedure SetValidationGroup(AValidationGroup: Variant);
   procedure ProcessVCLStyles;
   //RegisterVCLObjec Class
   class Procedure RegisterVCLObjClass;
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;

   procedure PreProcess; override;
   procedure Render; override;
   procedure RenderHTML; override;

   function DefaultPropertyCopyList: TStringList;

   function GetPopupMenu: TPopupMenu;
   procedure SetPopupMenu(APopupMenu: TPopupMenu);

   property Required: Boolean read GetRequired write SetRequired;
   property ValidationGroup: Variant read GetValidationGroup write SetValidationGroup;
   property Item: TComponent read GetItem write SetItem;
   property Hidden: Boolean read GetIsHidden write SetIsHidden;
   property PopupMenu: TPopupMenu read GetPopupMenu write SetPopupMenu;
   property BridgeVCLObj: ID2BridgeVCLObj read FBridgeVCLObj;
   property BaseClass;
 end;


type
 ID2BridgeItemVCLObjCore = Interface
  ['{9DCD331A-5A09-48E9-B2DC-FB1D8F7F3B9C}']
  function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  property D2BridgeItemVCLObj: TD2BridgeItemVCLObj read GetD2BridgeItemVCLObj;
 End;

{$IFDEF FMX}
 TMenuItemEx = class helper for TMenuItem
 public
   procedure ClickEx;
 end;
{$ENDIF}


Const
 CSS_Default = 'form-control';

implementation

uses
  System.Rtti, System.TypInfo, System.SysUtils, System.StrUtils, System.RegularExpressions,
  D2Bridge.Util, D2Bridge.VCLObj.Override, D2Bridge.HTML.CSS, D2Bridge.Prism, D2Bridge.Item.VCLObj.Style,
  Prism.Forms, Prism.Forms.Controls, Prism.Session, Prism.CallBack,
{$IFDEF FMX}
  FMX.Controls,
{$ELSE}
  Vcl.Controls,
{$ENDIF}


{$IFDEF RXLIB_AVAILABLE}
  D2Bridge.VCLObj.TRxDBCalcEdit, D2Bridge.VCLObj.TRxLookupEdit, D2Bridge.VCLObj.TDBDateEdit, D2Bridge.VCLObj.TCurrencyEdit,
  D2Bridge.VCLObj.TDateEdit,
{$ENDIF}

{$IFDEF SMCOMPONENTS_AVAILABLE}
  D2Bridge.VCLObj.TSMDBGrid,
{$ENDIF}

{$IFDEF DEVEXPRESS_AVAILABLE}
  D2Bridge.VCLObj.TcxTextEdit, D2Bridge.VCLObj.TcxComboBox, D2Bridge.VCLObj.TcxCheckBox,
  D2Bridge.VCLObj.TcxMemo, D2Bridge.VCLObj.TcxLabel, D2Bridge.VCLObj.TcxImage, D2Bridge.VCLObj.TcxDateEdit,
  D2Bridge.VCLObj.TcxDBCheckBox, D2Bridge.VCLObj.TcxDBComboBox, D2Bridge.VCLObj.TcxDBTextEdit,
  D2Bridge.VCLObj.TcxDBLookupComboBox, D2Bridge.VCLObj.TcxDBMemo, D2Bridge.VCLObj.TcxDBLabel,
  D2Bridge.VCLObj.TcxRadioButton, D2Bridge.VCLObj.TcxGridDBTableView, D2Bridge.VCLObj.TcxDBDateEdit,
  D2Bridge.VCLObj.TcxButtonEdit,
{$ENDIF}

{$IFDEF JVCL_AVAILABLE}
  D2Bridge.VCLObj.TJvDatePickerEdit, D2Bridge.VCLObj.TJvDbGrid, D2Bridge.VCLObj.TJvDBLookupCombo,
  D2Bridge.VCLObj.TJvDBUltimGrid, D2Bridge.VCLObj.TJvValidateEdit, D2Bridge.VCLObj.TJvDBDateEdit, D2Bridge.VCLObj.TJvCalcEdit,
  D2Bridge.VCLObj.TJvDBCombobox,
{$ENDIF}

{$IFDEF INFOPOWER_AVAILABLE}
  D2Bridge.VCLObj.TwwDBGrid, D2Bridge.VCLObj.TwwDBEdit, D2Bridge.VCLObj.TwwButton, D2Bridge.VCLObj.TwwDBComboBox,
  D2Bridge.VCLObj.TwwDBLookupCombo, D2Bridge.VCLObj.TwwDBComboDlg, D2Bridge.VCLObj.TwwDBLookupComboDlg,
  D2Bridge.VCLObj.TwwDBRichEdit, D2Bridge.VCLObj.TwwDBDateTimePicker, D2Bridge.VCLObj.TwwCheckBox,
  D2Bridge.VCLObj.TwwRadioButton, D2Bridge.VCLObj.TwwIncrementalSearch, D2Bridge.VCLObj.TwwDBSpinEdit,
{$ENDIF}

{$IFDEF FMX}
  D2Bridge.FMXObj.TComboEdit, D2Bridge.FMXObj.TDateEdit, D2Bridge.FMXObj.TMenuBar,
{$ENDIF}

{$IFNDEF FMX}
  D2Bridge.VCLObj.TDateTimePicker, D2Bridge.VCLObj.TDBGrid, D2Bridge.VCLObj.TDBText, D2Bridge.VCLObj.TDBMemo,
  D2Bridge.VCLObj.TDBLookupCombobox, D2Bridge.VCLObj.TDBEdit, D2Bridge.VCLObj.TDBCombobox,
  D2Bridge.VCLObj.TDBCheckBox, D2Bridge.VCLObj.TMaskEdit, D2Bridge.VCLObj.TButtonedEdit,
  D2Bridge.VCLObj.TMainMenu,
{$ENDIF}
  D2Bridge.VCLObj.TLabel, D2Bridge.VCLObj.TEdit, D2Bridge.VCLObj.TButton, D2Bridge.VCLObj.TSpeedButton,
  D2Bridge.VCLObj.TImage, D2Bridge.VCLObj.TMemo, D2Bridge.VCLObj.TStringGrid,
  D2Bridge.VCLObj.TCombobox, D2Bridge.VCLObj.TCheckBox, D2Bridge.VCLObj.TRadioButton;




{ TD2BridgeItemVCLObj }


function TD2BridgeItemVCLObj.BridgeVCLObjClass(VCLObjClass: TClass): ID2BridgeVCLObj;
var
  BridgeInstance: ID2BridgeVCLObj;
  BridgeInstanceObj: TObject;
  InterfaceTypeInfo: PTypeInfo;
  InterfaceGUID: TGUID;
  Context: TRttiContext;
  RttiType: TRttiType;
  RttiInterface: TRttiInterfaceType;
  Method: TRttiMethod;
  Instance: TObject;
begin
  // Obtenha o TypeInfo da interface
  InterfaceTypeInfo := TypeInfo(ID2BridgeVCLObj);

  // Obtenha o GUID da interface
  InterfaceGUID := GetTypeData(InterfaceTypeInfo).Guid;

  // Obtenha o contexto RTTI
  Context := TRttiContext.Create;


  try
    // Itere sobre todas as classes carregadas no tempo de execução
    for RttiType in Context.GetTypes do
    begin
      // Verifique se o tipo é uma classe
      if RttiType is TRttiInstanceType then
      begin
        // Verifique se a classe implementa a interface desejada
        for RttiInterface in TRttiInstanceType(RttiType).GetImplementedInterfaces do
        begin
          if RttiInterface.GUID = InterfaceGUID then
          begin
            if SameText(TRttiInstanceType(RttiType).MetaclassType.ClassName, 'TVCLObj'+OverrideVCL(VCLObjClass).ClassName) then
            begin
             // Crie uma instância da classe
             Instance := TRttiInstanceType(RttiType).GetMethod('Create').Invoke(TRttiInstanceType(RttiType).MetaclassType, [self]).AsObject;

             if Supports(Instance, InterfaceGUID, BridgeInstance) then
             begin
               // Chame o método VCLClass
               if OverrideVCL(VCLObjClass) = BridgeInstance.VCLClass then
               begin
                Result := BridgeInstance;//Instance.ClassType;

                Exit;
                Break;
               end;
             end;
            end;

            Break;
          end;
        end;
      end;
    end;
  finally
    Context.Free;
  end;
end;


constructor TD2BridgeItemVCLObj.Create(AOwner: TD2BridgeClass);
begin
 Inherited Create(AOwner);

 FButtonIconPosition:= PrismPositionLeft;
 FIsHidden:= false;
 FRequired:= false;
 FPopupHTML:= TStringList.Create;
 FVCLObjStyle:= TD2BridgeItemVCLObjStyle.Create;
end;



function TD2BridgeItemVCLObj.DefaultPropertyCopyList: TStringList;
begin
 Result:= TStringList.Create;
 Result.Add('Left');
 Result.Add('Top');
 Result.Add('Width');
 Result.Add('Heigth');
 Result.Add('Parent');
 Result.Add('Caption');
 Result.Add('Color');
 Result.Add('Enabled');
 Result.Add('Visible');
end;


destructor TD2BridgeItemVCLObj.Destroy;
//var
// vVCLObj: TObject;
begin
// if Assigned(FBridgeVCLObj) then
// if Supports(FBridgeVCLObj, ID2BridgeVCLObj, vVCLObj) then
//  vVCLObj.Destroy;

 FreeAndNil(FPopupHTML);

 TD2BridgeItemVCLObjStyle(FVCLObjStyle).Free;

 inherited;
end;

function TD2BridgeItemVCLObj.GetHTMLStyle: string;
begin
 result:= Inherited;

 if SameText(OverrideVCL(Item.ClassType).ClassName, 'TLabel')
 {$IFDEF DEVEXPRESS_AVAILABLE}
   or SameText(OverrideVCL(Item.ClassType).ClassName, 'TcxLabel')
   or SameText(OverrideVCL(Item.ClassType).ClassName, 'TcxDBLabel')
 {$ENDIF}
   or SameText(OverrideVCL(Item.ClassType).ClassName, 'TDBText') then
 begin
  if Pos('white-space: pre-line;', result) <= 0 then
  begin
   if result <> '' then
    Result:= Result + ' ';
   Result:= Result + 'white-space: pre-line;';
  end;
 end;
end;

function TD2BridgeItemVCLObj.GetIsHidden: Boolean;
begin
 Result:= FIsHidden;
end;

function TD2BridgeItemVCLObj.GetItem: TComponent;
begin
 result:= FItem;
end;


function TD2BridgeItemVCLObj.GetPopupMenu: TPopupMenu;
begin
 Result:= FPopupMenu;
end;

function TD2BridgeItemVCLObj.GetRequired: Boolean;
begin
 Result:= FRequired;
end;

function TD2BridgeItemVCLObj.GetValidationGroup: Variant;
begin
 Result:= FValidationGroup;
end;

procedure TD2BridgeItemVCLObj.PreProcess;
begin
// if (Assigned(Item)) and Supports(BridgeVCLObj.FrameworkItemClass, ID2BridgeFrameworkItemButton) then
// begin
//  TButton(Item).{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF}:= StringReplace(TButton(Item).{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF}, '&', '', [rfReplaceAll, rfIgnoreCase]);
// end;

 if (Assigned(Item)) and (BridgeVCLObj is TVCLObjTButton) then
 begin
  try
   if not Assigned(FPopupMenu) then
   begin
{$IFNDEF FMX}
    if Assigned(TButton(Item).DropDownMenu) then
     FPopupMenu:= TButton(Item).DropDownMenu
    else
{$ENDIF}
    if Assigned(TButton(Item).PopupMenu) then
     FPopupMenu:= TButton(Item).PopupMenu{$IFDEF FMX}.PopupComponent as TPopupMenu{$ENDIF};
   end;
  except
  end;
 end;

end;

procedure TD2BridgeItemVCLObj.ProcessVCLStyles;
var
 vFontSize: Double;
begin
 if BaseClass.VCLStyles then
 begin
  {$REGION 'Font Size'}
   if FVCLObjStyle.FontSize <> DefaultFontSize then
   begin
    if (TRIM(CSSClasses) = '') or
       (TRIM(CSSClasses) = 'd2bridgeformgroupcontrol') or
       ((not Pos('fs-', CSSClasses) = 1) and
        (not Pos(' fs-', CSSClasses) >= 1)) then
    begin
     vFontSize:= FVCLObjStyle.FontSize / DefaultFontSize; //11.5 is exactally size

     if HTMLStyle <> '' then
      HTMLStyle := HTMLStyle + ' ';
     HTMLStyle := HTMLStyle + 'font-size: '+ StringReplace(FloatToStr(vFontSize), ',', '.', []) +'rem;';
    end;
   end;
  {$ENDREGION}

  {$REGION 'Font Style'}
   if TFontStyle.fsBold in FVCLObjStyle.FontStyles then
    CSSClasses:= CSSClasses + ' ' + TCSSClassText.Style.bold;

   if TFontStyle.fsItalic in FVCLObjStyle.FontStyles then
    CSSClasses:= CSSClasses + ' ' + TCSSClassText.Style.italic;

   if TFontStyle.fsUnderline in FVCLObjStyle.FontStyles then
    CSSClasses:= CSSClasses + ' ' + TCSSClassText.Style.Underline;

   if TFontStyle.fsStrikeOut in FVCLObjStyle.FontStyles then
    CSSClasses:= CSSClasses + ' ' + TCSSClassText.Style.StrikeOut;
  {$ENDREGION}

  {$REGION 'Font Color'}
   if FVCLObjStyle.FontColor <> TColors.SysNone then
   begin
    if HTMLStyle <> '' then
     HTMLStyle := HTMLStyle + ' ';
    HTMLStyle := HTMLStyle + 'color: '+ D2Bridge.Util.ColorToHex(FVCLObjStyle.FontColor) + ';';
   end;
  {$ENDREGION}

  {$REGION 'Alignment'}
   if FVCLObjStyle.Alignment <> taNone then
   begin
    if FVCLObjStyle.Alignment = AlignmentLeft then
     CSSClasses:= CSSClasses + ' ' + TCSSClassText.Align.left;

    if FVCLObjStyle.Alignment = AlignmentRight then
     CSSClasses:= CSSClasses + ' ' + TCSSClassText.Align.right;

    if FVCLObjStyle.Alignment = AlignmentCenter then
     CSSClasses:= CSSClasses + ' ' + TCSSClassText.Align.center;
   end;
  {$ENDREGION}

  {$REGION 'Color'}
   if FVCLObjStyle.Color <> TColors.SysNone then
   begin
    if HTMLStyle <> '' then
     HTMLStyle := HTMLStyle + ' ';
    HTMLStyle := HTMLStyle + 'background-color: '+ D2Bridge.Util.ColorToHex(FVCLObjStyle.Color) + ';';
   end;
  {$ENDREGION}
 end;
end;

class procedure TD2BridgeItemVCLObj.RegisterVCLObjClass;
begin
 RegisterClass(TVCLObjTLabel);
 RegisterClass(TVCLObjTEdit);
 RegisterClass(TVCLObjTButton);
 RegisterClass(TVCLObjTSpeedButton);
 RegisterClass(TVCLObjTCombobox);
 RegisterClass(TVCLObjTCheckBox);
 RegisterClass(TVCLObjTRadioButton);
 RegisterClass(TVCLObjTImage);
 RegisterClass(TVCLObjTMemo);
 RegisterClass(TVCLObjTStringGrid);
{$IFNDEF FMX}
 RegisterClass(TVCLObjTDateTimePicker);
 RegisterClass(TVCLObjTDBGrid);
 RegisterClass(TVCLObjTDBText);
 RegisterClass(TVCLObjTDBMemo);
 RegisterClass(TVCLObjTDBLookupCombobox);
 RegisterClass(TVCLObjTDBEdit);
 RegisterClass(TVCLObjTDBCombobox);
 RegisterClass(TVCLObjTDBCheckBox);
 RegisterClass(TVCLObjTMaskEdit);
 RegisterClass(TVCLObjTButtonedEdit);
 RegisterClass(TVCLObjTMainMenu);
{$ELSE}
 RegisterClass(TFMXObjTComboEdit);
 RegisterClass(TFMXObjTDateEdit);
 RegisterClass(TVCLObjTMenuBar);
{$ENDIF}
{$IFDEF RXLIB_AVAILABLE}
 RegisterClass(TVCLObjTDBDateEdit);
 RegisterClass(TVCLObjTRxDBCalcEdit);
 RegisterClass(TVCLObjTRxLookupEdit);
 RegisterClass(TVCLObjTCurrencyEdit);
 RegisterClass(TVCLObjTDateEdit);
{$ENDIF}
{$IFDEF SMCOMPONENTS_AVAILABLE}
 RegisterClass(TVCLObjTSMDBGrid);
{$ENDIF}
{$IFDEF DEVEXPRESS_AVAILABLE}
 RegisterClass(TVCLObjTcxTextEdit);
 RegisterClass(TVCLObjTcxComboBox);
 RegisterClass(TVCLObjTcxCheckBox);
 RegisterClass(TVCLObjTcxMemo);
 RegisterClass(TVCLObjTcxLabel);
 RegisterClass(TVCLObjTcxImage);
 RegisterClass(TVCLObjTcxDateEdit);
 RegisterClass(TVCLObjTcxRadioButton);
 RegisterClass(TVCLObjTcxDBCheckBox);
 RegisterClass(TVCLObjTcxDBComboBox);
 RegisterClass(TVCLObjTcxDBTextEdit);
 RegisterClass(TVCLObjTcxGridDBTableView);
 RegisterClass(TVCLObjTcxDBLookupComboBox);
 RegisterClass(TVCLObjTcxDBMemo);
 RegisterClass(TVCLObjTcxDBLabel);
 RegisterClass(TVCLObjTcxDBDateEdit);
 RegisterClass(TVCLObjTcxButtonEdit);
{$ENDIF}
{$IFDEF JVCL_AVAILABLE}
 RegisterClass(TVCLObjTJvValidateEdit);
 RegisterClass(TVCLObjTJvDBUltimGrid);
 RegisterClass(TVCLObjTJvDBLookupCombo);
 RegisterClass(TVCLObjTJvDbGrid);
 RegisterClass(TVCLObjTJvDatePickerEdit);
 RegisterClass(TVCLObjTJvDBDateEdit);
 RegisterClass(TVCLObjTJvCalcEdit);
 RegisterClass(TVCLObjTJvDBCombobox);
{$ENDIF}
{$IFDEF INFOPOWER_AVAILABLE}
 RegisterClass(TVCLObjTwwDBGrid);
 RegisterClass(TVCLObjTwwDBEdit);
 RegisterClass(TVCLObjTwwButton);
 RegisterClass(TVCLObjTwwDBComboBox);
 RegisterClass(TVCLObjTwwDBLookupCombo);
 RegisterClass(TVCLObjTwwDBComboDlg);
 RegisterClass(TVCLObjTwwDBLookupComboDlg);
 RegisterClass(TVCLObjTwwDBRichEdit);
 RegisterClass(TVCLObjTwwDBDateTimePicker);
 RegisterClass(TVCLObjTwwCheckBox);
 RegisterClass(TVCLObjTwwRadioButton);
 RegisterClass(TVCLObjTwwIncrementalSearch);
 RegisterClass(TVCLObjTwwDBSpinEdit);
{$ENDIF}
end;

procedure TD2BridgeItemVCLObj.Render;
var
  VCLClass, NewClass: TClass;
  RttiVCLClass, RttiNewClass: TRttiType;
  NewComponent: TComponent;
  Context: TRttiContext;
  ComponentProperty, ComponentPropertyNew: TRttiProperty;
  NomePropriedades: TStringList;
  AuxCompView, AuxCompHide: TComponent;
  isD2BridgeIWFramework, isD2BridgePrismFramework: Boolean;
begin
 inherited;

 if (not Renderized) and Assigned(Item) then
 begin
  isD2BridgeIWFramework:= false;//BaseClass.FrameworkExportType is TD2BridgeIWFramework;
  isD2BridgePrismFramework:= BaseClass.FrameworkExportType is TD2BridgePrismFramework;

  //  VCLObj.GetInterface(ID2BridgeVCLObj, BridgeVCLObj);
  VCLClass:= BridgeVCLObj.VCLClass;

  BridgeVCLObj.FrameworkItemClass.Clear;
  NewClass:= BridgeVCLObj.FrameworkItemClass.FrameworkClass;

  // Obtém os tipos RTTI dos componentes original
  RttiVCLClass := Context.GetType(VCLClass);

  //Fix Name of Componente
  if Item.Name = '' then
   Item.Name := ItemID;

  //Create NewComponent
  if isD2BridgeIWFramework then
  NewComponent := TComponentClass(NewClass).Create(Item.Owner)
  else
  if isD2BridgePrismFramework then
  begin
   NewComponent := TComponentClass(NewClass).Create(TComponent(BaseClass.Form));
   TPrismControl(NewComponent).VCLComponent:= Item;
   TPrismControl(NewComponent).Hidden:= Hidden;
   TPrismControl(NewComponent).Required:= Required;
   TPrismControl(NewComponent).ValidationGroup:= ValidationGroup;
   PrismControl:= NewComponent as IPrismControl;
   PrismControl.Name:= Item.Name;
   TPrismControl(PrismControl).D2BridgeItem:= self;
  end;

  //Obtém os tipos RTTI dos componentes novo
  RttiNewClass := Context.GetType(NewClass);

  //Load Properties to Copy
  NomePropriedades:= BridgeVCLObj.PropertyCopyList;


  for ComponentProperty in RttiVCLClass.GetProperties do
  begin
   try
    if NomePropriedades.IndexOf(ComponentProperty.Name) >= 0  then
    if Assigned(RttiNewClass.GetProperty(ComponentProperty.Name)) then
    if (RttiNewClass.GetProperty(ComponentProperty.Name).IsWritable) then
    begin
     for ComponentPropertyNew in RttiNewClass.GetProperties do
     if not SameText(ComponentProperty.Name, 'Name')  then
     if (SameText(ComponentProperty.Name, ComponentPropertyNew.Name)) and (ComponentProperty.PropertyType = ComponentPropertyNew.PropertyType) then
     ComponentPropertyNew.SetValue(NewComponent, ComponentProperty.GetValue(Item));
    end;
   Except
   end;
  end;

  //Process Class
  BridgeVCLObj.ProcessPropertyClass(NewComponent);
  BridgeVCLObj.FrameworkItemClass.ProcessPropertyClass(Item, NewComponent);

  if isD2BridgeIWFramework then
  Item.Name:= Item.Name + '_XOLDX';
  NewComponent.Name:= ItemID;

  //Process Events
  BridgeVCLObj.ProcessEventClass;
  BridgeVCLObj.FrameworkItemClass.ProcessEventClass(Item, NewComponent);

  //Button ICon
  if (FButtonIcon <> '') then
   if PrismControl.IsButton then
    begin
     if PrismControl.AsButton.Caption = '' then
     begin
      FButtonIcon := StringReplace(FButtonIcon, ' me-2', '', []);
      FButtonIcon := StringReplace(FButtonIcon, ' ms-2', '', []);
     end;

     if FButtonIconPosition = PrismPositionLeft then
      PrismControl.AsButton.Caption:= FButtonIcon + ' ' + PrismControl.AsButton.Caption
     else
     if FButtonIconPosition = PrismPositionRight then
      PrismControl.AsButton.Caption:= PrismControl.AsButton.Caption + ' ' +FButtonIcon;
    end;

  //PopupMenu
  if (FPopupHTML.Text <> '') then
   if PrismControl.IsButton then
    PrismControl.AsButton.PopupHTML:= FPopupHTML.Text;

  try
   if isD2BridgeIWFramework then
   {$IFNDEF FMX}TWinControl{$ELSE}TControl{$ENDIF}(NewComponent).Parent:= {$IFNDEF FMX}TWinControl{$ELSE}TControl{$ENDIF}(BaseClass.Form)
   else
   if isD2BridgePrismFramework then
   begin
    //TPrismControl(NewComponent).Initialize;
   end;
  except
  end;


  try
   //if not Supports(FBridgeVCLObj.FrameworkItemClass, ID2BridgeFrameworkItemDBMemo) then
   if isD2BridgeIWFramework then
   Item.Owner.RemoveComponent(Item);
  finally

  end;



  // Remove o componente original e adiciona a nova instância no lugar
  //FreeAndNil(BridgeVCLObj);

  NomePropriedades.Free;

//  Renderized:= true;
 end else
 begin
  //Refresh Popup
  try
   if Assigned(PopupMenu) then
   begin
    RenderPopupMenu;

    //PopupMenu
    if (FPopupHTML.Text <> '') then
     if PrismControl.IsButton then
      PrismControl.AsButton.PopupHTML:= FPopupHTML.Text;
   end;
  except
  end;

  //Refresh MainMenu
  try
   if Assigned(Item) then
    if Item is {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF} then
    begin
     if BridgeVCLObj is {$IFNDEF FMX}TVCLObjTMainMenu{$ELSE}TVCLObjTMenuBar{$ENDIF} then
      (BridgeVCLObj as {$IFNDEF FMX}TVCLObjTMainMenu{$ELSE}TVCLObjTMenuBar{$ENDIF}).BuildMenuItems(Item as {$IFNDEF FMX}TMainMenu{$ELSE}TMenuBar{$ENDIF}, PrismControl as IPrismMainMenu);
    end;
  except
  end;
 end;
end;


procedure TD2BridgeItemVCLObj.RenderHTML;
var
 BridgeVCLObj: ID2BridgeVCLObj;
 CSSHTMLComponentByVCLClass: string;
 OverrideText, HTMLComponentOverride, OverrideAditional, CSSClean: string;
 TagClassDropDown, DropDownHTMLExtras: String;
 OpenBracketIndex, CloseBracketIndex, OverrideIndex, HifenIndex, SpaceIndex: Integer;
begin
 TagClassDropDown:= '';
 DropDownHTMLExtras:= '';

 BridgeVCLObj:= FBridgeVCLObj;

 if Assigned(Item) and BaseClass.VCLStyles then
 begin
  BridgeVCLObj.VCLStyle(FVCLObjStyle);

  ProcessVCLStyles;
 end;

 if BridgeVCLObj = nil then
 raise Exception.Create('Class Type '+Item.ClassType.ClassName+' not supported to D2Bridge Framework yet'+#13+'Error X001-3');

 CSSHTMLComponentByVCLClass:= BridgeVCLObj.CSSClass;

 if Assigned(Item) and Supports(BridgeVCLObj.FrameworkItemClass, ID2BridgeFrameworkItemButton) then
 if Assigned(PopupMenu) then
 begin
  //BaseClass.HTML.Render.Body.Add('<div class="dropdown">');
  TagClassDropDown:= ' dropdown-toggle';
  DropDownHTMLExtras:= ' data-bs-toggle="dropdown" aria-expanded="false"';
 end;



  // Encontrar a posição do trecho "[override..."
  OverrideIndex := AnsiPos('[override', CSSClasses);
  if OverrideIndex > 0 then
  begin
    // Encontrar a posição do colchete de abertura "[" a partir da posição do trecho "[override..."
    OpenBracketIndex := AnsiPos('[', Copy(CSSClasses, OverrideIndex, Length(CSSClasses) - OverrideIndex + 1)) + OverrideIndex - 1;
    if OpenBracketIndex > 0 then
    begin
      // Encontrar a posição do colchete de fechamento "]" a partir da posição do colchete de abertura
      CloseBracketIndex := AnsiPos(']', Copy(CSSClasses, OpenBracketIndex, Length(CSSClasses) - OpenBracketIndex + 1)) + OpenBracketIndex - 1;
      if CloseBracketIndex > 0 then
      begin
        // Extrair o trecho entre os colchetes
        OverrideText := Copy(CSSClasses, OpenBracketIndex + 1, CloseBracketIndex - OpenBracketIndex - 1);

        // Verificar se o trecho contém a palavra "override"
        HifenIndex := AnsiPos('-', OverrideText);
        if HifenIndex > 0 then
        begin
          // Encontrar a posição do próximo espaço em branco ou hífen após o hífen encontrado
          SpaceIndex := 0;
          for SpaceIndex := HifenIndex + 1 to Length(OverrideText) do
          begin
            if (OverrideText[SpaceIndex] = ' ') or (OverrideText[SpaceIndex] = '-') then
              Break;
          end;

          // Extrair a classe entre o hífen e o espaço em branco ou próximo hífen
          HTMLComponentOverride := Copy(OverrideText, HifenIndex + 1, SpaceIndex - HifenIndex - 1);

          if pos('-r-', Trim(Copy(OverrideText, SpaceIndex))) = 1 then
          begin
           FButtonIconPosition:= PrismPositionRight;
           OverrideText:= StringReplace(OverrideText, '-r-', '-', []);
           CSSClasses:= StringReplace(CSSClasses, '[override-button-r-', '[override-button-', []);
          end else
          if pos('-t-', Trim(Copy(OverrideText, SpaceIndex))) = 1 then
          begin
           FButtonIconPosition:= PrismPositionTop;
           OverrideText:= StringReplace(OverrideText, '-t-', '-', []);
           CSSClasses:= StringReplace(CSSClasses, '[override-button-t-', '[override-button-', []);
          end else
          if pos('-b-', Trim(Copy(OverrideText, SpaceIndex))) = 1 then
          begin
           FButtonIconPosition:= PrismPositionBottom;
           OverrideText:= StringReplace(OverrideText, '-b-', '-', []);
           CSSClasses:= StringReplace(CSSClasses, '[override-button-b-', '[override-button-', []);
          end else
           FButtonIconPosition:= PrismPositionLeft;

          // Extrair o que vem após o item 2 até o final da string, removendo espaços em branco extras e hífen inicial
          OverrideAditional := Trim(Copy(OverrideText, SpaceIndex + 1));
        end;

        // Remover o trecho entre "[" e "]" e obter o restante da string
        CSSClean := Trim(StringReplace(CSSClasses, '[' + OverrideText + ']', '', []));

        if CompareText(HTMLComponentOverride,'button') = 0 then
        begin
         FButtonIcon:= '<i class="'+OverrideAditional+'"></i>';
         BaseClass.HTML.Render.Body.Add('{%'+TrataHTMLTag(ItemPrefixID+' class="'+Trim(CSSHTMLComponentByVCLClass+' '+CSSClean + TagClassDropDown)+'" style="'+GetHTMLStyle+'" '+ GetHTMLExtras + DropDownHTMLExtras ) +'%}');
         //BaseClass.HTML.Render.Body.Add('<button type="button" class="'+Trim(CSSHTMLComponentByVCLClass+' '+CSSClean + TagClassDropDown)+'" id="'+AnsiUpperCase(ItemPrefixID)+'" '+DropDownHTMLExtras+'><i class="'+OverrideAditional+'"></i>'+TButton(Item).{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF}+'</button>');
         //var HTMLOveride := '{%'+TrataHTMLTag(ItemPrefixID+' type="button" class="'+Trim(CSSHTMLComponentByVCLClass+' '+CSSClean + TagClassDropDown)+'" id="'+AnsiUpperCase(ItemPrefixID)+'" '+DropDownHTMLExtras+'><i class="'+OverrideAditional+'"></i') + '%}';

         if Assigned(PopupMenu) then
         RenderPopupMenu;
        end;

      end;
    end;
  end else
  begin
   if (Assigned(Item)) and Supports(BridgeVCLObj.FrameworkItemClass, ID2BridgeFrameworkItemButton) then
   if (Pos('btn-', CSSClasses) <= 0) then
    begin
     if CSSClasses <> '' then
      CSSClasses := CSSClasses + ' ';
     CSSClasses := CSSClasses + BaseClass.CSSClass.Button.TypeButton.Default.primary;
    end;


   //Default TAG
   BaseClass.HTML.Render.Body.Add('{%'+TrataHTMLTag(ItemPrefixID+' class="'+Trim(CSSHTMLComponentByVCLClass+' '+CSSClasses+ TagClassDropDown)+'" style="'+GetHTMLStyle+'" '+ GetHTMLExtras + DropDownHTMLExtras ) +'%}');


   if (Assigned(Item)) and Supports(BridgeVCLObj.FrameworkItemClass, ID2BridgeFrameworkItemButton) then
   if Assigned(PopupMenu) then
   RenderPopupMenu;

  end;


// if (Assigned(Item)) and Supports(BridgeVCLObj.FrameworkItemClass, ID2BridgeFrameworkItemButton) then
// if Assigned(PopupMenu) then
// BaseClass.HTML.Render.Body.Add('</div>');


 BridgeVCLObj:= nil;
end;

procedure TD2BridgeItemVCLObj.RenderPopupMenu;
var
 I, J: Integer;
 Session: TPrismSession;
begin
 if Assigned(PopupMenu) then
 begin
  Session:= BaseClass.PrismSession;

  if (not Renderized) and Assigned(Item) then
   BaseClass.CallBacks.Register('CallBackEventPopup'+PopupMenu.Name,
     function(EventParams: TStrings): String
     var
      xI, xJ: Integer;
     begin
      for xI := 0 to PopupMenu.{$IFNDEF FMX}Items.Count{$ELSE}ItemsCount{$ENDIF}-1 do
      begin
       if PopupMenu.Items[xI].Name = EventParams.Strings[0] then
       begin
        if (PopupMenu.Items[xI].Enabled) and (PopupMenu.Items[xI].Visible) then
         PopupMenu.Items[xI].{$IFNDEF FMX}Click{$ELSE}ClickEx{$ENDIF};
        break;

        for xJ := 0 to PopupMenu.Items[xI].{$IFNDEF FMX}Count{$ELSE}ItemsCount{$ENDIF}-1 do
        if PopupMenu.Items[xI].Items[xJ].Name = EventParams.Strings[0] then
        begin
         if (PopupMenu.Items[xI].Items[xJ].Enabled) and (PopupMenu.Items[xI].Items[xJ].Visible) then
          PopupMenu.Items[xI].Items[xJ].{$IFNDEF FMX}Click{$ELSE}ClickEx{$ENDIF};
         break;
        end;
       end;
      end;
     end
   );

  FPopupHTML.Clear;
  FPopupHTML.Add('<ul class="dropdown-menu" aria-labelledby="dropdownMenu'+ItemPrefixID+'">');
  for I := 0 to PopupMenu.{$IFNDEF FMX}Items.Count{$ELSE}ItemsCount{$ENDIF}-1 do
  begin
   if (PopupMenu.Items[I].Visible)
   and (PopupMenu.Items[I].{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF} <> '-')
   and (PopupMenu.Items[I].{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF} <> '') then
   begin
    if PopupMenu.Items[I].{$IFNDEF FMX}Count{$ELSE}ItemsCount{$ENDIF} > 0 then
    begin
     for J := 0 to PopupMenu.Items[I].{$IFNDEF FMX}Count{$ELSE}ItemsCount{$ENDIF}-1 do
     if (PopupMenu.Items[I].Items[J].Visible)
     and (PopupMenu.Items[I].Items[J].{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF} <> '-')
     and (PopupMenu.Items[I].Items[J].{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF} <> '') then
     begin
      FPopupHTML.Add('<li><a class="d2bridgedowndownitem dropdown-item cursor-pointer" onclick="'+Session.CallBacks.CallBackJS('CallBackEventPopup'+PopupMenu.Name, true, BaseClass.FrameworkForm.FormUUID, QuotedStr(PopupMenu.Items[I].Items[J].Name), true)+'">'+ PopupMenu.Items[I].{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF}+'->'+ PopupMenu.Items[I].Items[J].{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF} +'</a></li>');
     end;
    end else
    begin
     FPopupHTML.Add('<li><a class="d2bridgedowndownitem dropdown-item cursor-pointer" onclick="'+Session.CallBacks.CallBackJS('CallBackEventPopup'+PopupMenu.Name, true, BaseClass.FrameworkForm.FormUUID, QuotedStr(PopupMenu.Items[I].Name), true)+'">'+ PopupMenu.Items[I].{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF} +'</a></li>');
    end;
   end;
  end;
  FPopupHTML.Add('</ul>');
 end;
end;

procedure TD2BridgeItemVCLObj.SetIsHidden(AIsHidden: Boolean);
begin
 FIsHidden:= AIsHidden;
end;

procedure TD2BridgeItemVCLObj.SetItem(AItemVCLObj: TComponent);
begin
 FItem:= AItemVCLObj;

 FBridgeVCLObj:= BridgeVCLObjClass(FItem.ClassType);

// if Supports(FBridgeVCLObj.FrameworkItemClass, ID2BridgeFrameworkItemDBMemo) then
// FItemIDHTML := '_D2B'+FItem.Name
// else
 if FItem.Name <> '' then
  ItemID := FItem.Name
 else
 begin
  ItemID := BaseClass.CreateItemID('D2BridgeItemVCLObj');
 end;

end;

procedure TD2BridgeItemVCLObj.SetPopupMenu(APopupMenu: TPopupMenu);
begin
 FPopupMenu:= APopupMenu;
end;

procedure TD2BridgeItemVCLObj.SetRequired(ARequired: Boolean);
begin
 FRequired:= ARequired;
end;

procedure TD2BridgeItemVCLObj.SetValidationGroup(AValidationGroup: Variant);
begin
 FValidationGroup:= AValidationGroup;
end;

{$IFDEF FMX}
{ TMenuItemEx }

procedure TMenuItemEx.ClickEx;
begin
  inherited Click;
end;
{$ENDIF}

initialization
 TD2BridgeItemVCLObj.RegisterVCLObjClass;

end.

