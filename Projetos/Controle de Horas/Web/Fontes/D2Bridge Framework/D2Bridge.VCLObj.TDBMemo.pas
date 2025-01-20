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

unit D2Bridge.VCLObj.TDBMemo;

interface

{$IFNDEF FMX}
uses
  System.Classes,
  Vcl.DBCtrls, Vcl.Forms, Vcl.Graphics,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTDBMemo = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
  Prism.Util, D2Bridge.Util, D2Bridge.Item.VCLObj.Style;

{ TVCLObjTDBMemo }

constructor TVCLObjTDBMemo.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTDBMemo.CSSClass: String;
begin
 result:= 'form-control';
end;

function TVCLObjTDBMemo.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo;
end;

function TVCLObjTDBMemo.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTDBMemo.ProcessEventClass;
begin
 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnDblClick) then
 FrameworkItemClass.OnDblClick:=
    procedure(EventParams: TStrings)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnChange) then
 FrameworkItemClass.OnChange:=
    procedure(EventParams: TStrings)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).OnChange(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnKeyUp) then
 FrameworkItemClass.OnKeyUp:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TDBMemo(FD2BridgeItemVCLObj.Item).OnKeyUp(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TDBMemo(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TDBMemo(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
end;

procedure TVCLObjTDBMemo.ProcessPropertyClass(NewObj: TObject);
begin
 if Assigned(TDBMemo(FD2BridgeItemVCLObj.Item).DataSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.Dataware.DataSource:= TDBMemo(FD2BridgeItemVCLObj.Item).DataSource;

 if TDBMemo(FD2BridgeItemVCLObj.Item).DataField <> '' then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.Dataware.DataField:= TDBMemo(FD2BridgeItemVCLObj.Item).DataField;

 //Need to fix error in Nested
 TDBMemo(FD2BridgeItemVCLObj.Item).DataSource:= nil;
 TDBMemo(FD2BridgeItemVCLObj.Item).DataField:= '';

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.SetVisible:=
    procedure(AValue: Variant)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.GetReadOnly:=
    function: Variant
    begin
     Result:= TDBMemo(FD2BridgeItemVCLObj.Item).ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TDBMemo(FD2BridgeItemVCLObj.Item).ReadOnly:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBMemo.GetPlaceholder:=
    function: Variant
    begin
     if TDBMemo(FD2BridgeItemVCLObj.Item).TextHint <> '' then
      Result:= TDBMemo(FD2BridgeItemVCLObj.Item).TextHint
     else
     if TDBMemo(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TDBMemo(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;

// FrameworkItemClass.ProcessPropertyByName(FD2BridgeItemVCLObj.Item, NewObj, 'ReadOnly', TDBMemo(FD2BridgeItemVCLObj.Item).ReadOnly);
end;

function TVCLObjTDBMemo.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTDBMemo.VCLClass: TClass;
begin
 Result:= TDBMemo;
end;
procedure TVCLObjTDBMemo.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TDBMemo(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TDBMemo(FD2BridgeItemVCLObj.Item).Font.Size;

 if TDBMemo(FD2BridgeItemVCLObj.Item).Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TDBMemo(FD2BridgeItemVCLObj.Item).Font.Color;

 if TDBMemo(FD2BridgeItemVCLObj.Item).Color <> clWindow then
  VCLObjStyle.Color := TDBMemo(FD2BridgeItemVCLObj.Item).Color;

 if TDBMemo(FD2BridgeItemVCLObj.Item).Alignment <> DefaultAlignment then
  VCLObjStyle.Alignment:= TDBMemo(FD2BridgeItemVCLObj.Item).Alignment;

 VCLObjStyle.FontStyles := TDBMemo(FD2BridgeItemVCLObj.Item).Font.Style;
end;

{$ELSE}
implementation
{$ENDIF}

end.
