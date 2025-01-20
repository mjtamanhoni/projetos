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

unit D2Bridge.VCLObj.TDBLookupCombobox;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.SysUtils, Vcl.Forms, Vcl.Graphics,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTDBLookupCombobox = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function CSSClass: String;
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;

implementation

uses
  Vcl.DBCtrls,
  Prism.Util, D2Bridge.Util, D2Bridge.Item.VCLObj.Style;

{ TVCLObjTLookupCombobox }

constructor TVCLObjTDBLookupCombobox.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTDBLookupCombobox.CSSClass: String;
begin
 result:= 'form-select';
end;

function TVCLObjTDBLookupCombobox.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox;
end;

function TVCLObjTDBLookupCombobox.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTDBLookupCombobox.ProcessEventClass;
begin
 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;

 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnCloseUp) then
 FrameworkItemClass.OnSelect:=
    procedure(EventParams: TStrings)
    begin
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).OnCloseUp(FD2BridgeItemVCLObj.Item);
    end;
end;

procedure TVCLObjTDBLookupCombobox.ProcessPropertyClass(NewObj: TObject);
begin
 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).DataSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.DataSource.DataSource:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).DataSource;

 if (TDBLookupCombobox(FD2BridgeItemVCLObj.Item).DataField <> '') then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.DataSource.DataField:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).DataField;

 if Assigned(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ListSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.ListSource:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ListSource;

 if (TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ListField <> '') then
 if AnsiPos(';', TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ListField) > 0 then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.ListField:= Copy(TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ListField, 0, AnsiPos(';', TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ListField) -1)
 else
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.ListField:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ListField;

 if (TDBLookupCombobox(FD2BridgeItemVCLObj.Item).KeyField <> '') then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.KeyField:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).KeyField;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.OnGetText:=
    function: Variant
    begin
     Result:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).KeyValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.OnSetText:=
    procedure(AValue: Variant)
    begin
     if AValue <> '' then
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).KeyValue:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.SetVisible:=
    procedure(AValue: Variant)
    begin
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetReadOnly:=
    function: Variant
    begin
     Result:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ReadOnly:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetPlaceholder:=
    function: Variant
    begin
     if TDBLookupCombobox(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;

end;

function TVCLObjTDBLookupCombobox.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
 if Result.IndexOf('Text') > 0 then
 Result.Delete(Result.IndexOf('Text'));
end;

function TVCLObjTDBLookupCombobox.VCLClass: TClass;
begin
 Result:= TDBLookupComboBox;
end;

procedure TVCLObjTDBLookupCombobox.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Font.Size;

 if TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Font.Color;

 if TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Color <> clWindow then
  VCLObjStyle.Color := TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Color;

 VCLObjStyle.FontStyles := TDBLookupCombobox(FD2BridgeItemVCLObj.Item).Font.Style;
end;

{$ELSE}
implementation
{$ENDIF}

end.
