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

unit D2Bridge.VCLObj.TRadioButton;


interface


uses
  System.Classes,
{$IFDEF FMX}
  FMX.StdCtrls,
{$ELSE}
  Vcl.StdCtrls, Vcl.Controls, Vcl.Forms, Vcl.Graphics,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTRadioButton = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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

{ VCLObjTRadioButton }


constructor TVCLObjTRadioButton.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTRadioButton.CSSClass: String;
begin
 result:= 'form-check-input';
end;

function TVCLObjTRadioButton.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox;
end;

function TVCLObjTRadioButton.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTRadioButton.ProcessEventClass;
begin
 if Assigned(TRadioButton(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TRadioButton(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TRadioButton(FD2BridgeItemVCLObj.Item).OnDblClick) then
 FrameworkItemClass.OnDblClick:=
    procedure(EventParams: TStrings)
    begin
     TRadioButton(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TRadioButton(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TRadioButton(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TRadioButton(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TRadioButton(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TRadioButton(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
      KeyChar:  Char;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
{$IFNDEF FMX}
     TRadioButton(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
{$ELSE}
     KeyChar:= Char(KeyPress);
     TRadioButton(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, KeyChar, []);
{$ENDIF}
    end;

{$IFNDEF FMX}
 if Assigned(TRadioButton(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TRadioButton(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
{$ENDIF}
end;

procedure TVCLObjTRadioButton.ProcessPropertyClass(NewObj: TObject);
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.OnGetText:=
    function: Variant
    begin
     Result:= TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF};
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.OnGetChecked:=
    function: Variant
    begin
     Result:= TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Checked{$ELSE}IsChecked{$ENDIF};
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.OnSetChecked:=
    procedure(AValue: Variant)
    begin
     if AValue = false then
     begin
      if not TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Checked{$ELSE}IsChecked{$ENDIF} then
       TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Checked{$ELSE}IsChecked{$ENDIF}:= true;
     end else
      TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Checked{$ELSE}IsChecked{$ENDIF}:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TRadioButton(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.CheckBox.SetVisible:=
    procedure(AValue: Variant)
    begin
     TRadioButton(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;
end;

function TVCLObjTRadioButton.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTRadioButton.VCLClass: TClass;
begin
 Result:= TRadioButton;
end;

procedure TVCLObjTRadioButton.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 //Font in Switch is not appropriate
 //if TRadioButton(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
 // VCLObjStyle.FontSize := TRadioButton(FD2BridgeItemVCLObj.Item).Font.Size;

 if TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Font.Color{$ELSE}FontColor{$ENDIF} <> DefaultFontColor then
  VCLObjStyle.FontColor := TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Font.Color{$ELSE}FontColor{$ENDIF};

{$IFNDEF FMX}
 if TRadioButton(FD2BridgeItemVCLObj.Item).Color <> clBtnFace then
  VCLObjStyle.Color := TRadioButton(FD2BridgeItemVCLObj.Item).Color;
{$ENDIF}

 if TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF} <> DefaultAlignment then
  VCLObjStyle.Alignment:= TRadioButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF};

 VCLObjStyle.FontStyles := TRadioButton(FD2BridgeItemVCLObj.Item).Font.Style;

end;

end.
