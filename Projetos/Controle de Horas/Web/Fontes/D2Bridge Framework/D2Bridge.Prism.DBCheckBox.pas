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

unit D2Bridge.Prism.DBCheckBox;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.SysUtils,
  D2Bridge.Interfaces, D2Bridge.Prism, D2Bridge.Prism.Item, D2Bridge.FrameworkItem.DataWare,
  Prism.Types;


type
 TCheckBoxType = Prism.Types.TCheckBoxType;


type
 PrismDBCheckBox = class(TD2BridgePrismItem, ID2BridgeFrameworkItemDBCheckBox)
  private
   FProcGetText: TOnGetValue;
   FCheckBoxType: TCheckBoxType;
   FD2BridgeDatawareDataSource: TD2BridgeDatawareDataSource;
   FValueChecked: String;
   FValueUnChecked: String;
   procedure SetOnGetText(AProc: TOnGetValue);
   function GetOnGetText: TOnGetValue;
   function GetValueChecked: String;
   procedure SetValueChecked(AValue: String);
   function GetValueUnChecked: String;
   procedure SetValueUnChecked(AValue: String);
   procedure SetCheckBoxType(ACheckBoxType: TCheckBoxType);
   function GetCheckBoxType: TCheckBoxType;
  public
   constructor Create(AD2BridgePrismFramework: TD2BridgePrismFramework); override;
   destructor Destroy; override;

   procedure Clear; override;
   function FrameworkClass: TClass; override;
   procedure ProcessPropertyClass(VCLObj, NewObj: TObject); override;
   procedure ProcessEventClass(VCLObj, NewObj: TObject); override;
   procedure ProcessPropertyByName(VCLObj, NewObj: TObject; PropertyName: string; PropertyValue: Variant); override;

   function Dataware : ID2BridgeDatawareDataSource;

   property OnGetText: TOnGetValue read GetOnGetText write SetOnGetText;
   property ValueChecked: String read GetValueChecked write SetValueChecked;
   property ValueUnChecked: String read GetValueUnChecked write SetValueUnChecked;
   property CheckBoxType: TCheckBoxType read GetCheckBoxType write SetCheckBoxType;
  end;



implementation

uses
  Prism.DBCheckBox, Prism.Forms.Controls;


{ PrismDBCheckBox }


procedure PrismDBCheckBox.Clear;
begin
 inherited;

 FCheckBoxType:= CBSwitchType;
 Dataware.Clear;
 FProcGetText:= nil;
 ValueChecked:= '';
 ValueUnChecked:= '';
end;

constructor PrismDBCheckBox.Create(
  AD2BridgePrismFramework: TD2BridgePrismFramework);
begin
 inherited;

 FCheckBoxType:= CBSwitchType;

 FD2BridgeDatawareDataSource:= TD2BridgeDatawareDataSource.Create;
end;

function PrismDBCheckBox.Dataware: ID2BridgeDatawareDataSource;
begin
 Result:= FD2BridgeDatawareDataSource;
end;

destructor PrismDBCheckBox.Destroy;
begin
 FreeAndNil(FD2BridgeDatawareDataSource);

 inherited;
end;

function PrismDBCheckBox.FrameworkClass: TClass;
begin
 inherited;

 Result:= TPrismDBCheckBox;
end;

function PrismDBCheckBox.GetCheckBoxType: TCheckBoxType;
begin
 Result:= FCheckBoxType;
end;

function PrismDBCheckBox.GetOnGetText: TOnGetValue;
begin
 Result:= FProcGetText;
end;

function PrismDBCheckBox.GetValueChecked: String;
begin
 Result:= FValueChecked;
end;

function PrismDBCheckBox.GetValueUnChecked: String;
begin
 Result:= FValueUnChecked;
end;

procedure PrismDBCheckBox.ProcessEventClass(VCLObj, NewObj: TObject);
begin
 inherited;

end;

procedure PrismDBCheckBox.ProcessPropertyByName(VCLObj, NewObj: TObject;
  PropertyName: string; PropertyValue: Variant);
begin
 inherited;

end;

procedure PrismDBCheckBox.ProcessPropertyClass(VCLObj, NewObj: TObject);
begin
 inherited;

 if Assigned(Dataware.DataSource) then
 TPrismDBCheckBox(NewObj).DataSource:= Dataware.DataSource;

 if Dataware.DataField <> '' then
 TPrismDBCheckBox(NewObj).DataField:= Dataware.DataField;

 TPrismDBCheckBox(NewObj).CheckBoxType:= CheckBoxType;

 TPrismDBCheckBox(NewObj).ValueChecked:= ValueChecked;
 TPrismDBCheckBox(NewObj).ValueUnChecked:= ValueUnChecked;

 if Assigned(FProcGetText) then
 TPrismDBCheckBox(NewObj).ProcGetText:= FProcGetText;

 TPrismControl(NewObj).Events.Add(TPrismEventType.EventOnCheckChange, OnCheckChange, true);
end;


procedure PrismDBCheckBox.SetCheckBoxType(ACheckBoxType: TCheckBoxType);
begin
 FCheckBoxType:= ACheckBoxType;
end;

procedure PrismDBCheckBox.SetOnGetText(AProc: TOnGetValue);
begin
 FProcGetText:= AProc;
end;


procedure PrismDBCheckBox.SetValueChecked(AValue: String);
begin
 FValueChecked:= AValue;
end;

procedure PrismDBCheckBox.SetValueUnChecked(AValue: String);
begin
 FValueUnChecked:= AValue;
end;
{$ELSE}
implementation
{$ENDIF}

end.
