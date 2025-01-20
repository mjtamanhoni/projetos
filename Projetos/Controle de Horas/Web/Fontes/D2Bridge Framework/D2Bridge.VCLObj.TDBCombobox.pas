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

unit D2Bridge.VCLObj.TDBCombobox;

interface

{$IFNDEF FMX}
uses
  System.Classes,
  Vcl.DBCtrls, Vcl.Forms, Vcl.Graphics,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTDBCombobox = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function CSSClass: String;
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;

implementation

uses
  Prism.Util, D2Bridge.Util, D2Bridge.Forms, D2Bridge.Item.VCLObj.Style,
  Prism.Forms, D2Bridge.Forms.Helper;

{ TVCLObjTDBCombobox }

constructor TVCLObjTDBCombobox.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTDBCombobox.CSSClass: String;
begin
 result:= 'form-select';
end;

function TVCLObjTDBCombobox.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox;
end;

function TVCLObjTDBCombobox.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTDBCombobox.ProcessEventClass;
begin
 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnDblClick) then
 FrameworkItemClass.OnDblClick:=
    procedure(EventParams: TStrings)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnChange) then
 FrameworkItemClass.OnChange:=
    procedure(EventParams: TStrings)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnChange(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnKeyUp) then
 FrameworkItemClass.OnKeyUp:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TDBCombobox(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
end;

procedure TVCLObjTDBCombobox.ProcessPropertyClass(NewObj: TObject);
var
 vD2BridgeForm: TD2BridgeForm;
 vItems: TStrings;
 vItemIndex: integer;
begin
 {$IFDEF D2BRIDGE}
 if NewObj is TPrismControl then
  if Assigned(TPrismControl(NewObj).Form) then
  begin
   vD2BridgeForm:= TPrismForm(TPrismControl(NewObj).Form).D2BridgeForm;
   vItems:= TStringList.Create;
   vItems.Text:= TDBCombobox(FD2BridgeItemVCLObj.Item).Items.Text;
   vItemIndex:= TDBCombobox(FD2BridgeItemVCLObj.Item).ItemIndex;
   TDBCombobox(FD2BridgeItemVCLObj.Item).Tag := NativeInt(vD2BridgeForm.D2BridgeFormComponentHelperItems.PropValues(NewObj));
   TD2BridgeFormComponentHelper(TDBCombobox(FD2BridgeItemVCLObj.Item).Tag).Value['Items']:= vItems;
   TD2BridgeFormComponentHelper(TDBCombobox(FD2BridgeItemVCLObj.Item).Tag).Value['ItemIndex']:= vItemIndex;
   TD2BridgeFormComponentHelper(TDBCombobox(FD2BridgeItemVCLObj.Item).Tag).OnDestroy:=
    procedure
    var
     vvItems: TStrings;
    begin
     vvItems:= TD2BridgeFormComponentHelper(TDBCombobox(FD2BridgeItemVCLObj.Item).Tag).Value['Items'].AsObject as TStrings;
     vvItems.Free;
    end;
  end;
 {$ENDIF}

 if Assigned(TDBCombobox(FD2BridgeItemVCLObj.Item).DataSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.Dataware.DataSource:= TDBCombobox(FD2BridgeItemVCLObj.Item).DataSource;

 if TDBCombobox(FD2BridgeItemVCLObj.Item).DataField <> '' then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.Dataware.DataField:= TDBCombobox(FD2BridgeItemVCLObj.Item).DataField;

 //Need to fix error in Nested
 TDBCombobox(FD2BridgeItemVCLObj.Item).DataSource:= nil;
 TDBCombobox(FD2BridgeItemVCLObj.Item).DataField:= '';

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.ProcGetItems :=
    function: TStrings
    begin
     Result:= TDBCombobox(FD2BridgeItemVCLObj.Item).Items;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.SetVisible:=
    procedure(AValue: Variant)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.GetReadOnly:=
    function: Variant
    begin
     Result:= TDBCombobox(FD2BridgeItemVCLObj.Item).ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TDBCombobox(FD2BridgeItemVCLObj.Item).ReadOnly:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.GetPlaceholder:=
    function: Variant
    begin
     if TDBCombobox(FD2BridgeItemVCLObj.Item).TextHint <> '' then
      Result:= TDBCombobox(FD2BridgeItemVCLObj.Item).TextHint
     else
     if TDBCombobox(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TDBCombobox(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;


// FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCombobox.Items(NewObj).Assign(TDBCombobox(FD2BridgeItemVCLObj.Item).Items);
end;

function TVCLObjTDBCombobox.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
 if Result.IndexOf('Text') >= 0 then
 Result.Delete(Result.IndexOf('Text'));
end;

function TVCLObjTDBCombobox.VCLClass: TClass;
begin
 Result:= TDBCombobox;
end;

procedure TVCLObjTDBCombobox.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TDBCombobox(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TDBCombobox(FD2BridgeItemVCLObj.Item).Font.Size;

 if TDBCombobox(FD2BridgeItemVCLObj.Item).Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TDBCombobox(FD2BridgeItemVCLObj.Item).Font.Color;

 if TDBCombobox(FD2BridgeItemVCLObj.Item).Color <> clWindow then
  VCLObjStyle.Color := TDBCombobox(FD2BridgeItemVCLObj.Item).Color;

 VCLObjStyle.FontStyles := TDBCombobox(FD2BridgeItemVCLObj.Item).Font.Style;
end;

{$ELSE}
implementation
{$ENDIF}

end.
