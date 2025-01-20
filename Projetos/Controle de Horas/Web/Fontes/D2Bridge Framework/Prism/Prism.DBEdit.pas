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

{$I ..\D2Bridge.inc}

unit Prism.DBEdit;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.JSON, System.SysUtils, System.UITypes, Data.DB, System.Variants,
  Vcl.DBCtrls,
  Prism.Interfaces, Prism.Forms.Controls, Prism.Types, Prism.DataWare.Field;

type
 TPrismDBEdit = class(TPrismControl, IPrismDBEdit)
  private
   FRefreshData: Boolean;
   FStoredFieldValue: Variant;
   FStoredTextHTMLElement: string;
   FStoredFieldValueMask: String;
   FStoredDataType: TPrismFieldType;
   FDataWareField: TPrismDataWareField;
   FCharCase: TEditCharCase;
   FTextMask: string;
   FStoredFieldAlignment: TAlignment;
   procedure UpdateData; override;
   function GetCharCase: TEditCharCase;
   procedure SetCharCase(ACharCase: TEditCharCase);
   procedure SetTextMask(AValue: string);
   function GetTextMask: string;
   procedure SetEditDataType(AEditType: TPrismFieldType);
   function GetEditDataType: TPrismFieldType;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsDBEdit: Boolean; override;
   function GetReadOnly: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   function DataWare: TPrismDataWareField;

   property CharCase: TEditCharCase read GetCharCase write SetCharCase;
   property TextMask: string read GetTextMask write SetTextMask;
   property DataType: TPrismFieldType read GetEditDataType write SetEditDataType;
 end;


implementation

uses
  System.DateUtils,
  Prism.Util, Prism.Text.Mask, Prism.BaseClass;

{ TPrismDBEdit }

constructor TPrismDBEdit.Create(AOwner: TComponent);
begin
 inherited;

 FRefreshData:= false;
 FDataWareField:= TPrismDataWareField.Create(Self);
 FDataWareField.UseHTMLFormatSettings:= true;
 FStoredTextHTMLElement:= '';
 FStoredFieldAlignment:= taLeftJustify;
end;

function TPrismDBEdit.DataWare: TPrismDataWareField;
begin
 result:= FDataWareField;
end;

destructor TPrismDBEdit.Destroy;
begin
 FreeAndNil(FDataWareField);
 inherited;
end;

function TPrismDBEdit.GetCharCase: TEditCharCase;
begin
 result:= FCharCase;
end;


function TPrismDBEdit.GetEditDataType: TPrismFieldType;
begin
 result:= FDataWareField.DataType;
end;

function TPrismDBEdit.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismDBEdit.GetReadOnly: Boolean;
begin
 result:= Inherited;

 if not result then
  result:= FDataWareField.ReadOnly;
end;

function TPrismDBEdit.GetTextMask: string;
begin
 Result:= FTextMask;
end;

procedure TPrismDBEdit.Initialize;
begin
 inherited;

 FStoredFieldValue:= DataWare.FieldValue;
 FStoredDataType:= DataWare.DataType;
 FStoredFieldValueMask:= TextMask;

 //Text Align
 try
  if Assigned(DataWare.DataSource) then
  if Assigned(DataWare.DataSet) then
  if DataWare.Active and Assigned(DataWare.Field) then
  begin
   if DataWare.Field.Alignment = taRightJustify then
   begin
    FStoredFieldAlignment:= DataWare.Field.Alignment;
    HTMLCore:= HTMLAddItemFromClass(HTMLCore, 'text-end');
    HTMLCore:= HTMLRemoveItemFromClass(HTMLCore, 'text-start');
    HTMLCore:= HTMLRemoveItemFromClass(HTMLCore, 'text-center');
   end else
   if DataWare.Field.Alignment = taCenter then
   begin
    FStoredFieldAlignment:= DataWare.Field.Alignment;
    HTMLCore:= HTMLAddItemFromClass(HTMLCore, 'text-center');
    HTMLCore:= HTMLRemoveItemFromClass(HTMLCore, 'text-start');
    HTMLCore:= HTMLRemoveItemFromClass(HTMLCore, 'text-end');
   end;
  end;
 except
 end;
end;

function TPrismDBEdit.IsDBEdit: Boolean;
begin
 Result:= true;
end;

procedure TPrismDBEdit.ProcessComponentState(const ComponentStateInfo: TJSONObject);
var
 vText: string;
begin
 inherited;

 if (ComponentStateInfo.GetValue('text') <> nil) then
 begin
  vText:= ComponentStateInfo.GetValue('text').Value;

  if vText <> FStoredTextHTMLElement then
  begin
   DataWare.ValueHTMLElement:= vText;
   FStoredFieldValue:= DataWare.FieldValue;
   FStoredTextHTMLElement:= vText;
  end;
 end;
end;

procedure TPrismDBEdit.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismDBEdit.ProcessHTML;
var
 vHTMLCore: string;
begin
 inherited;

 vHTMLCore:= HTMLCore;

 if CharCase = TEditCharCase.ecLowerCase then
  vHTMLCore:= HTMLAddItemFromClass(HTMLCore, 'text-lowercase')
 else
 if CharCase = TEditCharCase.ecUpperCase then
  vHTMLCore:= HTMLAddItemFromClass(HTMLCore, 'text-uppercase');


 HTMLControl := '<input';

 HTMLControl := HTMLControl + ' ' + vHTMLCore;

 HTMLControl := HTMLControl + ' lang="' + Form.Language+'" ';

 if TextMask <> '' then
  HTMLControl := HTMLControl + ' ' + 'data-inputmask="' + TextMask + '"';

 if DataType = PrismFieldTypeInteger then
  TextMask:= TPrismTextMask.Integer;

 HTMLControl := HTMLControl + ' ' + InputHTMLTypeByPrismFieldType(DataType) + ' ';

 FStoredTextHTMLElement:= DataWare.ValueHTMLElement;
 HTMLControl := HTMLControl + ' value="' + FormatTextHTML(FStoredTextHTMLElement) + '"';
 HTMLControl := HTMLControl + '/>';
end;

procedure TPrismDBEdit.SetCharCase(ACharCase: TEditCharCase);
begin
 FCharCase:= ACharCase;
end;


procedure TPrismDBEdit.SetEditDataType(AEditType: TPrismFieldType);
begin
 FDataWareField.DataType:= AEditType;
end;


procedure TPrismDBEdit.SetTextMask(AValue: string);
begin
 FTextMask:= TPrismTextMask.ProcessTextMask(AValue);

 FStoredFieldValueMask:= FTextMask;
end;


procedure TPrismDBEdit.UpdateData;
begin
 if (Form.FormPageState = PageStateLoaded) and (not Form.ComponentsUpdating) then
 FRefreshData:= true;
end;

procedure TPrismDBEdit.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewFieldValue: variant;
 NewTextMask: string;
 NewDataType: TPrismFieldType;
begin
 inherited;

 NewDataType:= DataWare.DataType;
 if (AForceUpdate) or (FStoredDataType <> NewDataType) then
 begin
  FStoredDataType:= DataWare.DataType;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").'+InputHTMLTypeByPrismFieldType(DataType)+';');
 end;

 NewFieldValue:= DataWare.FieldValue;
 if (AForceUpdate) or (VarToStr(FStoredFieldValue) <> VarToStr(NewFieldValue)) then
 begin
  FStoredTextHTMLElement:= DataWare.ValueHTMLElement;
  FStoredFieldValue:= NewFieldValue;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").value = '+ FormatValueHTML(FStoredTextHTMLElement) +';');

  //Align
  if Assigned(DataWare.Field) then
  if FStoredFieldAlignment <> DataWare.Field.Alignment then
  begin
   FStoredFieldAlignment := DataWare.Field.Alignment;

   if FStoredFieldAlignment = taRightJustify then
   begin
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).addClass("text-end");');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).removeClass("text-start");');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).removeClass("text-center");');
   end else
   if FStoredFieldAlignment = taCenter then
   begin
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).addClass("text-center");');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).removeClass("text-start");');
    ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).removeClass("text-end");');
   end;
  end;
 end;

 NewTextMask:= TextMask;
 if (AForceUpdate) or (FStoredFieldValueMask <> NewTextMask) then
 begin
  TextMask:= NewTextMask;

  ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).inputmask("remove");');
  if FStoredFieldValueMask <> '' then
  ScriptJS.Add('$("[id]").filter(function() {return this.id.toUpperCase() === "'+AnsiUpperCase(NamePrefix)+'";}).inputmask({' + FStoredFieldValueMask + '});');
 end;

end;


{$ELSE}
implementation
{$ENDIF}

end.
