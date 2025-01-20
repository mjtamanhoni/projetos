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
    Natanael Ribeiro
    natan_ribeiro_ferreira@hotmail.com
 +--------------------------------------------------------------------------+
}

{$I ..\D2Bridge.inc}

unit D2Bridge.VCLObj.TcxTextEdit;


interface

{$IFDEF DEVEXPRESS_AVAILABLE}
uses
  System.Classes,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass,
  Vcl.StdCtrls, Vcl.Controls, Vcl.Graphics, Vcl.Forms;


type
 TVCLObjTcxTextEdit = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
  Prism.Util, Prism.Types, D2Bridge.Util, cxTextEdit, D2Bridge.Item.VCLObj.Style;

{ TVCLObjTcxTextEdit }


constructor TVCLObjTcxTextEdit.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTcxTextEdit.CSSClass: String;
begin
 result:= 'form-control';
end;

function TVCLObjTcxTextEdit.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit;
end;

function TVCLObjTcxTextEdit.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTcxTextEdit.ProcessEventClass;
begin
 if Assigned(TcxTextEdit(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxTextEdit(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxTextEdit(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.OnChange) then
 FrameworkItemClass.OnChange:=
    procedure(EventParams: TStrings)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.OnChange(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxTextEdit(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TcxTextEdit(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TcxTextEdit(FD2BridgeItemVCLObj.Item).OnKeyUp) then
 FrameworkItemClass.OnKeyUp:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TcxTextEdit(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TcxTextEdit(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TcxTextEdit(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;

end;

procedure TVCLObjTcxTextEdit.ProcessPropertyClass(NewObj: TObject);
begin
 if TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.PasswordChar <> #0 then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.DataType:= PrismFieldTypePassword;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.CharCase:= TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.CharCase;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.SetVisible:=
    procedure(AValue: Variant)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetReadOnly:=
    function: Variant
    begin
     Result:= TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.ReadOnly:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetPlaceholder:=
    function: Variant
    begin
     if TcxTextEdit(FD2BridgeItemVCLObj.Item).TextHint <> '' then
      Result:= TcxTextEdit(FD2BridgeItemVCLObj.Item).TextHint
     else
     if TcxTextEdit(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TcxTextEdit(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.OnGetText:=
    function: Variant
    begin
     Result:= TcxTextEdit(FD2BridgeItemVCLObj.Item).Text;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.OnSetText:=
    procedure(AValue: Variant)
    begin
     TcxTextEdit(FD2BridgeItemVCLObj.Item).Text:= AValue;
    end;
end;

function TVCLObjTcxTextEdit.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTcxTextEdit.VCLClass: TClass;
begin
 Result:= TcxTextEdit;
end;

Procedure TVCLObjTcxTextEdit.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TcxTextEdit(FD2BridgeItemVCLObj.Item).Style.Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TcxTextEdit(FD2BridgeItemVCLObj.Item).Style.Font.Size;

 if TcxTextEdit(FD2BridgeItemVCLObj.Item).Style.Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TcxTextEdit(FD2BridgeItemVCLObj.Item).Style.Font.Color;

 if TcxTextEdit(FD2BridgeItemVCLObj.Item).Style.Color <> clWindow then
  VCLObjStyle.Color := TcxTextEdit(FD2BridgeItemVCLObj.Item).Style.Color;

 if TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.Alignment.Horz <> DefaultAlignment then
  VCLObjStyle.Alignment:= TcxTextEdit(FD2BridgeItemVCLObj.Item).Properties.Alignment.Horz;

 VCLObjStyle.FontStyles := TcxTextEdit(FD2BridgeItemVCLObj.Item).Style.Font.Style;
end;

{$ELSE}
implementation
{$ENDIF}

end.
