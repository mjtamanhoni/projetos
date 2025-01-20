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

unit D2Bridge.VCLObj.TCheckBox;


interface


uses
  System.Classes,
{$IFDEF FMX}
  FMX.StdCtrls, FMX.Controls,
{$ELSE}
  Vcl.StdCtrls, Vcl.Controls, Vcl.Forms, Vcl.Graphics,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTCheckBox = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
  Prism.Util, D2Bridge.Util, D2Bridge.Item.VCLObj.Style;

{ VCLObjTCheckBox }


constructor TVCLObjTCheckBox.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTCheckBox.CSSClass: String;
begin
 result:= 'form-check-input';
end;

function TVCLObjTCheckBox.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox;
end;

function TVCLObjTCheckBox.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTCheckBox.ProcessEventClass;
begin
 if Assigned(TCheckBox(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     //TCheckBox(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCheckBox(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TCheckBox(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCheckBox(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TCheckBox(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TCheckBox(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
      KeyChar:  Char;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
{$IFNDEF FMX}
     TCheckBox(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
{$ELSE}
     KeyChar:= Char(KeyPress);
     TCheckBox(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, KeyChar, []);
{$ENDIF}
    end;

{$IFNDEF FMX}
 if Assigned(TCheckBox(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TCheckBox(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
{$ENDIF}
end;

procedure TVCLObjTCheckBox.ProcessPropertyClass(NewObj: TObject);
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.OnGetText:=
    function: Variant
    begin
     Result:= TCheckBox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF};
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.OnGetChecked:=
    function: Variant
    begin
     Result:= TCheckBox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Checked{$ELSE}IsChecked{$ENDIF};
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.OnSetChecked:=
    procedure(AValue: Variant)
    begin
     TCheckBox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Checked{$ELSE}IsChecked{$ENDIF}:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TCheckBox(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.SetVisible:=
    procedure(AValue: Variant)
    begin
     TCheckBox(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;
end;

function TVCLObjTCheckBox.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTCheckBox.VCLClass: TClass;
begin
 Result:= TCheckBox;
end;

procedure TVCLObjTCheckBox.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 //Font in Switch is not appropriate
 //if TCheckBox(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
 // VCLObjStyle.FontSize := TCheckBox(FD2BridgeItemVCLObj.Item).Font.Size;

 if TCheckBox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Font.Color{$ELSE}FontColor{$ENDIF} <> DefaultFontColor then
  VCLObjStyle.FontColor := TCheckBox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Font.Color{$ELSE}FontColor{$ENDIF};

{$IFNDEF FMX}
 if TCheckBox(FD2BridgeItemVCLObj.Item).Color <> clBtnFace then
  VCLObjStyle.Color := TCheckBox(FD2BridgeItemVCLObj.Item).Color;
{$ENDIF}

 if TCheckBox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF} <> DefaultAlignment then
  VCLObjStyle.Alignment:= TCheckBox(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF};

 VCLObjStyle.FontStyles := TCheckBox(FD2BridgeItemVCLObj.Item).Font.Style;
end;

end.
