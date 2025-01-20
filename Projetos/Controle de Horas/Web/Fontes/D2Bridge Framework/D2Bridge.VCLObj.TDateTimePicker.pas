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

unit D2Bridge.VCLObj.TDateTimePicker;


interface

{$IFNDEF FMX}
uses
  System.Classes, System.SysUtils, Variants,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Forms, Vcl.Graphics,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTDateTimePicker = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
 Prism.Util, Prism.Types, D2Bridge.Util, D2Bridge.Item.VCLObj.Style;

{ VCLObjTDateTimePicker }


constructor TVCLObjTDateTimePicker.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTDateTimePicker.CSSClass: String;
begin
 result:= 'form-control';
end;

function TVCLObjTDateTimePicker.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit;
end;

function TVCLObjTDateTimePicker.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTDateTimePicker.ProcessEventClass;
begin
 if Assigned(TDateTimePicker(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TDateTimePicker(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDateTimePicker(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TDateTimePicker(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDateTimePicker(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TDateTimePicker(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDateTimePicker(FD2BridgeItemVCLObj.Item).OnChange) then
 FrameworkItemClass.OnChange:=
    procedure(EventParams: TStrings)
    begin
     TDateTimePicker(FD2BridgeItemVCLObj.Item).OnChange(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDateTimePicker(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TDateTimePicker(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TDateTimePicker(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TDateTimePicker(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;

end;

procedure TVCLObjTDateTimePicker.ProcessPropertyClass(NewObj: TObject);
begin
{$IF CompilerVersion >= 35} // Delphi 11 Alexandria or Upper
 if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkDateTime then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.DataType:= PrismFieldTypeDateTime
 else
{$ENDIF}
 if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkDate then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.DataType:= PrismFieldTypeDate
 else
 if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkTime then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.DataType:= PrismFieldTypeTime;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TDateTimePicker(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.SetVisible:=
    procedure(AValue: Variant)
    begin
     TDateTimePicker(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetReadOnly:=
    function: Variant
    begin
     Result:= not TDateTimePicker(FD2BridgeItemVCLObj.Item).Enabled;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TDateTimePicker(FD2BridgeItemVCLObj.Item).Enabled:= not AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.OnGetText:=
    function: Variant
    begin
     result:= '';
{$IF CompilerVersion >= 35} // Delphi 11 Alexandria or Upper
     if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkDateTime then
      Result:= DateTimeToStr(TDateTimePicker(FD2BridgeItemVCLObj.Item).DateTime)
     else
{$ENDIF}
     if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkDate then
      Result:= DateToStr(TDateTimePicker(FD2BridgeItemVCLObj.Item).Date)
     else
     if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkTime then
      Result:= TimeToStr(TDateTimePicker(FD2BridgeItemVCLObj.Item).Time)
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.OnSetText:=
    procedure(AValue: Variant)
    begin
     if VarToStr(AValue) = '' then
      AValue:= DateTimeToStr(0);

{$IF CompilerVersion >= 35} // Delphi 11 Alexandria or Upper
     if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkDateTime then
      TDateTimePicker(FD2BridgeItemVCLObj.Item).DateTime:= StrToDateTime(AValue)
     else
{$ENDIF}
     if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkDate then
      TDateTimePicker(FD2BridgeItemVCLObj.Item).Date:= StrToDate(AValue)
     else
     if TDateTimePicker(FD2BridgeItemVCLObj.Item).Kind = dtkTime then
      TDateTimePicker(FD2BridgeItemVCLObj.Item).Time:= StrToTime(AValue)
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Edit.GetPlaceholder:=
    function: Variant
    begin
     if TDateTimePicker(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TDateTimePicker(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;
end;

function TVCLObjTDateTimePicker.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTDateTimePicker.VCLClass: TClass;
begin
 Result:= TDateTimePicker;
end;

procedure TVCLObjTDateTimePicker.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TDateTimePicker(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TDateTimePicker(FD2BridgeItemVCLObj.Item).Font.Size;

 if TDateTimePicker(FD2BridgeItemVCLObj.Item).Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TDateTimePicker(FD2BridgeItemVCLObj.Item).Font.Color;

 if TDateTimePicker(FD2BridgeItemVCLObj.Item).Color <> clWindow then
  VCLObjStyle.Color := TDateTimePicker(FD2BridgeItemVCLObj.Item).Color;

 VCLObjStyle.FontStyles := TDateTimePicker(FD2BridgeItemVCLObj.Item).Font.Style;
end;
{$ELSE}
implementation
{$ENDIF}

end.
