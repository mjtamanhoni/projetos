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

unit D2Bridge.VCLObj.TCombobox;


interface


uses
  System.Classes, System.SysUtils,
{$IFDEF FMX}
  FMX.ListBox,
{$ELSE}
  Vcl.StdCtrls, Vcl.Forms, Vcl.Graphics,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass, D2Bridge.Forms;


type
 TVCLObjTCombobox = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function CSSClass: String;
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;


implementation

uses
 Prism.Util, D2Bridge.Util, D2Bridge.Item.VCLObj.Style,
 Prism.Forms, D2Bridge.Forms.Helper;

{ TVCLObjTCombobox }

constructor TVCLObjTCombobox.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTCombobox.CSSClass: String;
begin
 result:= 'form-select';
end;

function TVCLObjTCombobox.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox;
end;

function TVCLObjTCombobox.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTCombobox.ProcessEventClass;
begin
 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}OnSelect{$ELSE}OnChange{$ENDIF}) then
 FrameworkItemClass.OnSelect:=
    procedure(EventParams: TStrings)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}OnSelect{$ELSE}OnChange{$ENDIF}(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnDblClick) then
 FrameworkItemClass.OnDblClick:=
    procedure(EventParams: TStrings)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnChange) then
 FrameworkItemClass.OnChange:=
    procedure(EventParams: TStrings)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).OnChange(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
      KeyChar:  Char;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
{$IFNDEF FMX}
     TCombobox(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
{$ELSE}
     KeyChar:= Char(KeyPress);
     TCombobox(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, KeyChar, []);
{$ENDIF}
    end;

 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnKeyUp) then
 FrameworkItemClass.OnKeyUp:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
      KeyChar:  Char;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
{$IFNDEF FMX}
     TCombobox(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, []);
{$ELSE}
     KeyChar:= Char(KeyPress);
     TCombobox(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, KeyChar, []);
{$ENDIF}
    end;

{$IFNDEF FMX}
 if Assigned(TCombobox(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TCombobox(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
{$ENDIF}
end;

procedure TVCLObjTCombobox.ProcessPropertyClass(NewObj: TObject);
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
   vItems.Text:= TCombobox(FD2BridgeItemVCLObj.Item).Items.Text;
   vItemIndex:= TCombobox(FD2BridgeItemVCLObj.Item).ItemIndex;
   TCombobox(FD2BridgeItemVCLObj.Item).Tag := NativeInt(vD2BridgeForm.D2BridgeFormComponentHelperItems.PropValues(NewObj));
   TD2BridgeFormComponentHelper(TCombobox(FD2BridgeItemVCLObj.Item).Tag).Value['Items']:= vItems;
   TD2BridgeFormComponentHelper(TCombobox(FD2BridgeItemVCLObj.Item).Tag).Value['ItemIndex']:= vItemIndex;
   TD2BridgeFormComponentHelper(TCombobox(FD2BridgeItemVCLObj.Item).Tag).OnDestroy:=
    procedure
    var
     vvItems: TStrings;
    begin
     vvItems:= TD2BridgeFormComponentHelper(TCombobox(FD2BridgeItemVCLObj.Item).Tag).Value['Items'].AsObject as TStrings;
     vvItems.Free;
    end;
  end;
 {$ENDIF}

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.ProcGetItems :=
    function: TStrings
    begin
     Result:= TCombobox(FD2BridgeItemVCLObj.Item).Items;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.ProcGetSelectedItem :=
    function: Variant
    begin
     Result:= '';
     if (TCombobox(FD2BridgeItemVCLObj.Item).ItemIndex >= 0) and (TCombobox(FD2BridgeItemVCLObj.Item).Items.Count > 0) then
      Result:= TCombobox(FD2BridgeItemVCLObj.Item).Items[TCombobox(FD2BridgeItemVCLObj.Item).ItemIndex];
     //Result:= TCombobox(FD2BridgeItemVCLObj.Item).Text;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.ProcSetSelectedItem :=
    procedure(AValue: Variant)
    begin
{$IFNDEF FMX}
     if TCombobox(FD2BridgeItemVCLObj.Item).Items.IndexOf(AValue) < 0 then
      TCombobox(FD2BridgeItemVCLObj.Item).Text := AValue
     else
{$ENDIF}
      TCombobox(FD2BridgeItemVCLObj.Item).ItemIndex := TCombobox(FD2BridgeItemVCLObj.Item).Items.IndexOf(AValue);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.SetVisible:=
    procedure(AValue: Variant)
    begin
     TCombobox(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Combobox.GetPlaceholder:=
    function: Variant
    begin
{$IFNDEF FMX}
     if TCombobox(FD2BridgeItemVCLObj.Item).TextHint <> '' then
      Result:= TCombobox(FD2BridgeItemVCLObj.Item).TextHint
     else
{$ENDIF}
     if TCombobox(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TCombobox(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;
end;

function TVCLObjTCombobox.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTCombobox.VCLClass: TClass;
begin
 Result:= TComboBox;
end;

procedure TVCLObjTCombobox.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
{$IFNDEF FMX}
 if TCombobox(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize:= TCombobox(FD2BridgeItemVCLObj.Item).Font.Size;

 if TCombobox(FD2BridgeItemVCLObj.Item).Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor:= TCombobox(FD2BridgeItemVCLObj.Item).Font.Color;

 if TCombobox(FD2BridgeItemVCLObj.Item).Color <> clWindow then
  VCLObjStyle.Color:= TCombobox(FD2BridgeItemVCLObj.Item).Color;

 VCLObjStyle.FontStyles:= TCombobox(FD2BridgeItemVCLObj.Item).Font.Style;
{$ENDIF}
end;

end.
