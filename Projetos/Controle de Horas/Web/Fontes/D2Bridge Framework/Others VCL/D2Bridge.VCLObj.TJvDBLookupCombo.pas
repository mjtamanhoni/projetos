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
  Thanks for contribution to this Unit to:
    Daniel Hondo Tedesque
    Email: daniel@uniontech.eti.br
 +--------------------------------------------------------------------------+
}

{$I ..\D2Bridge.inc}

unit D2Bridge.VCLObj.TJvDBLookupCombo;

interface

{$IFDEF JVCL_AVAILABLE}
uses
  System.Classes, System.SysUtils, Vcl.Forms, Vcl.Graphics, JvDBLookup,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTJvDBLookupCombo = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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

{ TVCLObjTJvDBLookupCombo }

constructor TVCLObjTJvDBLookupCombo.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTJvDBLookupCombo.CSSClass: String;
begin
 result:= 'form-select';
end;

function TVCLObjTJvDBLookupCombo.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox;
end;

function TVCLObjTJvDBLookupCombo.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTJvDBLookupCombo.ProcessEventClass;
begin
 if Assigned(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
    end;

 if Assigned(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
end;

procedure TVCLObjTJvDBLookupCombo.ProcessPropertyClass(NewObj: TObject);
begin
 if Assigned(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).DataSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.DataSource.DataSource:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).DataSource;

 if (TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).DataField <> '') then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.DataSource.DataField:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).DataField;

 if Assigned(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.ListSource:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupSource;

 if (TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupDisplay <> '') then
 if AnsiPos(';', TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupDisplay) > 0 then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.ListField:= Copy(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupDisplay, AnsiPos(';', TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupDisplay) + 1, Length(TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupDisplay) - AnsiPos(';', TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupDisplay))
 else
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.ListField:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupDisplay;

 if (TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupField <> '') then
  FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.Dataware.ListSource.KeyField:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).LookupField;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.OnGetText:=
    function: Variant
    begin
     Result:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).KeyValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.OnSetText:=
    procedure(AValue: Variant)
    begin
     if AValue <> '' then
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).KeyValue:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.SetVisible:=
    procedure(AValue: Variant)
    begin
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetReadOnly:=
    function: Variant
    begin
     Result:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).ReadOnly;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.SetReadOnly:=
    procedure(AValue: Variant)
    begin
     TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).ReadOnly:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBLookupCombobox.GetPlaceholder:=
    function: Variant
    begin
     if TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).ShowHint then
      Result:= TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Hint
     else
      Result:= '';
    end;

end;

function TVCLObjTJvDBLookupCombo.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
 if Result.IndexOf('Text') > 0 then
 Result.Delete(Result.IndexOf('Text'));
end;

function TVCLObjTJvDBLookupCombo.VCLClass: TClass;
begin
 Result:= TJvDBLookupCombo;
end;

procedure TVCLObjTJvDBLookupCombo.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Font.Size <> Application.DefaultFont.Size then
  VCLObjStyle.FontSize := TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Font.Size;

 if (TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Font.Color <> clWindowText) then
  VCLObjStyle.FontColor := TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Font.Color;

 if (TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Color <> clWindow) then
  VCLObjStyle.Color := TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Color;

 VCLObjStyle.FontStyles := TJvDBLookupCombo(FD2BridgeItemVCLObj.Item).Font.Style;
end;

{$ELSE}
implementation
{$ENDIF}

end.
