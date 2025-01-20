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

unit D2Bridge.VCLObj.TcxMemo;

interface

{$IFDEF DEVEXPRESS_AVAILABLE}
uses
  System.Classes,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;

type
 TVCLObjTcxMemo = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
  Prism.Util, D2Bridge.Util, cxMemo, Vcl.Forms, D2Bridge.Item.VCLObj.Style;

{ TVCLObjTcxMemo }

constructor TVCLObjTcxMemo.Create(AOwner: TD2BridgeItemVCLObj);
begin
  FD2BridgeItemVCLObj := AOwner;
end;

function TVCLObjTcxMemo.CSSClass: String;
begin
  Result := 'form-control';
end;

function TVCLObjTcxMemo.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
  Result := FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo;
end;

function TVCLObjTcxMemo.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
  Result := FD2BridgeItemVCLObj;
end;

procedure TVCLObjTcxMemo.ProcessEventClass;
begin
 if Assigned(TcxMemo(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TcxMemo(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxMemo(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TcxMemo(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxMemo(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TcxMemo(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxMemo(FD2BridgeItemVCLObj.Item).Properties.OnChange) then
 FrameworkItemClass.OnChange:=
    procedure(EventParams: TStrings)
    begin
     TcxMemo(FD2BridgeItemVCLObj.Item).Properties.OnChange(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TcxMemo(FD2BridgeItemVCLObj.Item).OnKeyUp) then
 FrameworkItemClass.OnKeyUp:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TcxMemo(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TcxMemo(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TcxMemo(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TcxMemo(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TcxMemo(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
end;

procedure TVCLObjTcxMemo.ProcessPropertyClass(NewObj: TObject);
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.Lines := TcxMemo(FD2BridgeItemVCLObj.Item).Lines;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TcxMemo(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.SetVisible:=
    procedure(AValue: Variant)
    begin
     TcxMemo(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetReadOnly:=
    function: Variant
    begin
     Result:= TcxMemo(FD2BridgeItemVCLObj.Item).Properties.ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TcxMemo(FD2BridgeItemVCLObj.Item).Properties.ReadOnly:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Memo.GetPlaceholder:=
    function: Variant
    begin
     if TcxMemo(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TcxMemo(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;

end;

function TVCLObjTcxMemo.PropertyCopyList: TStringList;
begin
  Result := FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTcxMemo.VCLClass: TClass;
begin
  Result := TcxMemo;
end;

Procedure TVCLObjTcxMemo.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TcxMemo(FD2BridgeItemVCLObj.Item).Style.Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TcxMemo(FD2BridgeItemVCLObj.Item).Style.Font.Size;

 if TcxMemo(FD2BridgeItemVCLObj.Item).Style.Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TcxMemo(FD2BridgeItemVCLObj.Item).Style.Font.Color;

 if TcxMemo(FD2BridgeItemVCLObj.Item).Style.Color <> clWindow then
  VCLObjStyle.Color := TcxMemo(FD2BridgeItemVCLObj.Item).Style.Color;

 if TcxMemo(FD2BridgeItemVCLObj.Item).Properties.Alignment <> DefaultAlignment then
  VCLObjStyle.Alignment:= TcxMemo(FD2BridgeItemVCLObj.Item).Properties.Alignment;

 VCLObjStyle.FontStyles := TcxMemo(FD2BridgeItemVCLObj.Item).Style.Font.Style;
end;

initialization
 RegisterClass(TVCLObjTcxMemo);
{$ELSE}
implementation
{$ENDIF}

end.
