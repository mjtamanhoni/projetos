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

unit D2Bridge.VCLObj.TDBCheckBox;


interface

{$IFNDEF FMX}
uses
  System.Classes,
  Vcl.DBCtrls, Vcl.Forms, Vcl.Graphics,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTDBCheckBox = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
  Vcl.StdCtrls, Vcl.Controls,
  Prism.Util, D2Bridge.Util, D2Bridge.Item.VCLObj.Style;

{ VCLObjTDBCheckBox }


constructor TVCLObjTDBCheckBox.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTDBCheckBox.CSSClass: String;
begin
 result:= 'form-check-input';
end;

function TVCLObjTDBCheckBox.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox;
end;

function TVCLObjTDBCheckBox.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTDBCheckBox.ProcessEventClass;
begin
 if Assigned(TDBCheckBox(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TDBCheckBox(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCheckBox(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TDBCheckBox(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCheckBox(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TDBCheckBox(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBCheckBox(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TDBCheckBox(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TDBCheckBox(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TDBCheckBox(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;

end;

procedure TVCLObjTDBCheckBox.ProcessPropertyClass(NewObj: TObject);
begin
 if Assigned(TDBCheckBox(FD2BridgeItemVCLObj.Item).DataSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.Dataware.DataSource:= TDBCheckBox(FD2BridgeItemVCLObj.Item).DataSource;

 if TDBCheckBox(FD2BridgeItemVCLObj.Item).DataField <> '' then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.Dataware.DataField:= TDBCheckBox(FD2BridgeItemVCLObj.Item).DataField;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.ValueChecked:= TDBCheckBox(FD2BridgeItemVCLObj.Item).ValueChecked;
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.ValueUnchecked:= TDBCheckBox(FD2BridgeItemVCLObj.Item).ValueUnchecked;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.OnGetText:=
    function: Variant
    begin
     Result:= TDBCheckBox(FD2BridgeItemVCLObj.Item).Caption;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TDBCheckBox(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.SetVisible:=
    procedure(AValue: Variant)
    begin
     TDBCheckBox(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.GetReadOnly:=
    function: Variant
    begin
     Result:= TDBCheckBox(FD2BridgeItemVCLObj.Item).ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBCheckBox.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TDBCheckBox(FD2BridgeItemVCLObj.Item).ReadOnly:= AValue;
    end;
end;

function TVCLObjTDBCheckBox.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTDBCheckBox.VCLClass: TClass;
begin
 Result:= TDBCheckBox;
end;

procedure TVCLObjTDBCheckBox.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TDBCheckBox(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TDBCheckBox(FD2BridgeItemVCLObj.Item).Font.Size;

 if TDBCheckBox(FD2BridgeItemVCLObj.Item).Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TDBCheckBox(FD2BridgeItemVCLObj.Item).Font.Color;

 if TDBCheckBox(FD2BridgeItemVCLObj.Item).Color <> clBtnFace then
  VCLObjStyle.Color := TDBCheckBox(FD2BridgeItemVCLObj.Item).Color;

 if TDBCheckBox(FD2BridgeItemVCLObj.Item).Alignment <> DefaultAlignment then
  VCLObjStyle.Alignment:= TDBCheckBox(FD2BridgeItemVCLObj.Item).Alignment;

 VCLObjStyle.FontStyles := TDBCheckBox(FD2BridgeItemVCLObj.Item).Font.Style;

end;

{$ELSE}
implementation
{$ENDIF}

end.
