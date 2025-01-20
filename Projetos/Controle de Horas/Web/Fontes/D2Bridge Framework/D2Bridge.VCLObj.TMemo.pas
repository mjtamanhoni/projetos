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
  Thank for contribution to this Unit to:
    Edvanio Jancy
    edvanio@ideiasistemas.com.br
 +--------------------------------------------------------------------------+
}

{$I D2Bridge.inc}

unit D2Bridge.VCLObj.TMemo;

interface

uses
  System.Classes,
{$IFDEF FMX}
  FMX.Memo,
{$ELSE}
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics, Vcl.Forms,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass,
  Prism.Forms;

type
 TVCLObjTMemo = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
  Prism.Util, D2Bridge.Util, D2Bridge.Item.VCLObj.Style, Prism.Forms.Controls,
  D2Bridge.Forms, D2Bridge.Forms.Helper;

{ TVCLObjTMemo }

constructor TVCLObjTMemo.Create(AOwner: TD2BridgeItemVCLObj);
begin
  FD2BridgeItemVCLObj := AOwner;
end;

function TVCLObjTMemo.CSSClass: String;
begin
  Result := 'form-control';
end;

function TVCLObjTMemo.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
  Result := FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo;
end;

function TVCLObjTMemo.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
  Result := FD2BridgeItemVCLObj;
end;

procedure TVCLObjTMemo.ProcessEventClass;
begin
 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnDblClick) then
 FrameworkItemClass.OnDblClick:=
    procedure(EventParams: TStrings)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnChange) then
 FrameworkItemClass.OnChange:=
    procedure(EventParams: TStrings)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).OnChange(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnKeyUp) then
 FrameworkItemClass.OnKeyUp:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
      KeyChar:  Char;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
{$IFNDEF FMX}
     TMemo(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, []);
{$ELSE}
     KeyChar:= Char(KeyPress);
     TMemo(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, KeyChar, []);
{$ENDIF}
    end;

 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
      KeyChar:  Char;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
{$IFNDEF FMX}
     TMemo(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
{$ELSE}
     KeyChar:= Char(KeyPress);
     TMemo(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, KeyChar, []);
{$ENDIF}
    end;

{$IFNDEF FMX}
 if Assigned(TMemo(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TMemo(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
{$ENDIF}
end;

procedure TVCLObjTMemo.ProcessPropertyClass(NewObj: TObject);
var
 vD2BridgeForm: TD2BridgeForm;
 vItems: TStrings;
begin
 {$IFDEF D2BRIDGE}
 if NewObj is TPrismControl then
  if Assigned(TPrismControl(NewObj).Form) then
  begin
   vD2BridgeForm:= TPrismForm(TPrismControl(NewObj).Form).D2BridgeForm;
   vItems:= TStringList.Create;
   vItems.Text:= TMemo(FD2BridgeItemVCLObj.Item).Lines.Text;
   TMemo(FD2BridgeItemVCLObj.Item).Tag := NativeInt(vD2BridgeForm.D2BridgeFormComponentHelperItems.PropValues(NewObj));
   TD2BridgeFormComponentHelper(TMemo(FD2BridgeItemVCLObj.Item).Tag).Value['Lines']:= vItems;
   FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.Lines := vItems;
   TD2BridgeFormComponentHelper(TMemo(FD2BridgeItemVCLObj.Item).Tag).OnDestroy:=
    procedure
    var
     vvItems: TStrings;
    begin
     vvItems:= TD2BridgeFormComponentHelper(TMemo(FD2BridgeItemVCLObj.Item).Tag).Value['Items'].AsObject as TStrings;
     vvItems.Free;
    end;
  end;
 {$ENDIF}

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.SetVisible:=
    procedure(AValue: Variant)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetReadOnly:=
    function: Variant
    begin
     Result:= TMemo(FD2BridgeItemVCLObj.Item).ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TMemo(FD2BridgeItemVCLObj.Item).ReadOnly:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetPlaceholder:=
    function: Variant
    begin
{$IFNDEF FMX}
     if TMemo(FD2BridgeItemVCLObj.Item).TextHint <> '' then
      Result:= TMemo(FD2BridgeItemVCLObj.Item).TextHint
     else
{$ENDIF}
     if TMemo(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TMemo(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;

end;

function TVCLObjTMemo.PropertyCopyList: TStringList;
begin
  Result := FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTMemo.VCLClass: TClass;
begin
  Result := TMemo;
end;

procedure TVCLObjTMemo.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TMemo(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize:= TMemo(FD2BridgeItemVCLObj.Item).Font.Size;

 if TMemo(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Font.Color{$ELSE}FontColor{$ENDIF} <> DefaultFontColor then
  VCLObjStyle.FontColor:= TMemo(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Font.Color{$ELSE}FontColor{$ENDIF};

{$IFNDEF FMX}
 if TMemo(FD2BridgeItemVCLObj.Item).Color <> clWindow then
  VCLObjStyle.Color:= TMemo(FD2BridgeItemVCLObj.Item).Color;
{$ENDIF}

 if TMemo(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF} <> DefaultAlignment then
  VCLObjStyle.Alignment:= TMemo(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF};

 VCLObjStyle.FontStyles:= TMemo(FD2BridgeItemVCLObj.Item).Font.Style;
end;

initialization
 RegisterClass(TVCLObjTMemo);

end.
