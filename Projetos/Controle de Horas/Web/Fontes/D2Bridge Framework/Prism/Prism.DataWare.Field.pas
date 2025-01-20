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

unit Prism.DataWare.Field;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.SysUtils, Vcl.DBCtrls, Data.DB, System.Variants,
  Prism.Types, Prism.DataWare.Mapped;

type
 TPrismDataWareField = class(TFieldDataLink)
  private
   FPrismControl: TObject;
   FDataActive: Boolean;
   FDataType: TPrismFieldType;
   FFormatSettings: TFormatSettings;
   FUseHTMLFormatSettings: Boolean;
   FPrismDataWareMapped: TPrismDataWareMapped;
   procedure SetEditDataType(AEditType: TPrismFieldType);
   function GetEditDataType: TPrismFieldType;
   procedure FixPrismFieldType;
   procedure SetFieldValue(AValue: Variant);
   function GetFieldValue: Variant;
   procedure SetValueHTMLElement(AValue: string);
   function GetValueHTMLElement: string;
   procedure SetUseHTMLFormatSettings(Value: Boolean);
   procedure SetDataWareMapped(const Value: TPrismDataWareMapped);
   function GetDataWareMapped: TPrismDataWareMapped;
  protected
   procedure ActiveChanged; override;
   procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
  public
   constructor Create(APrismControlOwner: TObject);
   destructor Destroy; override;

   function FieldText: string;

   function ReadOnly: boolean;

   property UseHTMLFormatSettings: Boolean read FUseHTMLFormatSettings write SetUseHTMLFormatSettings;
   property ValueHTMLElement : string read GetValueHTMLElement write SetValueHTMLElement;
   property FieldValue: Variant read GetFieldValue write SetFieldValue;
   property DataType: TPrismFieldType read GetEditDataType write SetEditDataType;
   property DataWareMapped: TPrismDataWareMapped read GetDataWareMapped write SetDataWareMapped;
 end;

implementation

Uses
 Prism.Forms.Controls, System.DateUtils, Prism.BaseClass, Prism.Util,
  Prism.Forms;

{ TPrismDataWareField }

procedure TPrismDataWareField.ActiveChanged;
begin
 inherited;

 if Assigned(DataSet) then
  FDataActive := DataSet.Active;
end;


constructor TPrismDataWareField.Create(APrismControlOwner: TObject);
begin
 inherited Create;

 VisualControl:= false;

 FPrismControl:= APrismControlOwner;

 FDataType:= PrismFieldTypeAuto;

 FPrismDataWareMapped:= TPrismDataWareMapped.Create;
 FPrismDataWareMapped.Assign(PrismBaseClass.Options.DataWareMapped);

 if Assigned(DataSet) then
  FDataActive:= DataSet.Active
 else
  FDataActive:= false;

 FFormatSettings:= TPrismControl(APrismControlOwner).Session.FormatSettings;
end;

procedure TPrismDataWareField.DataEvent(Event: TDataEvent;
  Info: NativeInt);
var
 vDataField: string;
begin
 inherited;

 if Assigned(DataSet) then
 if Assigned(TPrismControl(FPrismControl).Form) then
 if (TPrismControl(FPrismControl).Form.ComponentsUpdating) then
 begin
  if Event in [deUpdateState] then
  if ((Event in [deUpdateState]) and DataSet.Active) then
  begin
   TPrismControl(FPrismControl).UpdateData;
  end;

  if Event in [deFocusControl] then
  begin
   TPrismControl(FPrismControl).SetFocus;
   if Assigned(TPrismControl(FPrismControl).VCLComponent) then
    Control:= TPrismControl(FPrismControl).VCLComponent;
   Exit;
  end;

  if Active and (FieldName <> '') and (not Assigned(Field)) then
  begin
   vDataField:= FieldName;
   FieldName:= '';
   FieldName:= vDataField;
  end;
 end;
end;

destructor TPrismDataWareField.Destroy;
begin
 FreeAndNil(FPrismDataWareMapped);

 inherited;
end;

function TPrismDataWareField.FieldText: string;
begin
 result:= VarToStrDef(FieldValue, '');
end;

procedure TPrismDataWareField.FixPrismFieldType;
begin
 if Assigned(DataSource) and Assigned(DataSet) then
 begin
  if Assigned(Field) then
  begin
   if FDataType = PrismFieldTypeAuto then
   begin
    if Field.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd, ftExtended] then
    begin
     FDataType:= FPrismDataWareMapped.MappedPrismField(PrismFieldTypeNumber);
    end else
    if Field.DataType in [ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint, ftLongWord, ftShortint, ftSingle] then
    begin
     FDataType:= FPrismDataWareMapped.MappedPrismField(PrismFieldTypeInteger);

     //TextMask:= TPrismTextMask.Integer;
    end else
    if Field.DataType in [ftDate] then
    begin
     FDataType:= FPrismDataWareMapped.MappedPrismField(PrismFieldTypeDate);
    end else
    if Field.DataType in [ftDateTime] then
    begin
     FDataType:= FPrismDataWareMapped.MappedPrismField(PrismFieldTypeDateTime);
    end else
    if Field.DataType in [ftTimeStamp, ftTime, ftTimeStampOffset] then
    begin
     FDataType:= FPrismDataWareMapped.MappedPrismField(PrismFieldTypeTime);
    end;
   end;
  end;
 end;
end;

function TPrismDataWareField.GetDataWareMapped: TPrismDataWareMapped;
begin
 Result:= FPrismDataWareMapped;
end;

function TPrismDataWareField.GetEditDataType: TPrismFieldType;
begin
 Result:= FDataType;
end;

function TPrismDataWareField.GetFieldValue: Variant;
begin
 FixPrismFieldType;

 if Assigned(Field) and Assigned(Field.DataSet) and Field.DataSet.Active and (not Field.IsNull) then
  Result:= Field.Value
 else
  Result:= '';
end;

function TPrismDataWareField.GetValueHTMLElement: string;
var
 vDateTime: TDateTime;
begin
 FixPrismFieldType;

 if Assigned(Field) and Assigned(Field.DataSet) and Field.DataSet.Active and (not Field.IsNull) then
 begin
  if (FDataType in [PrismFieldTypeDate]) or (Field.DataType in [ftDate]) then
  begin
   if (not FUseHTMLFormatSettings) and (Field is TDateTimeField) and ((Field as TDateTimeField).DisplayFormat <> '') then
   begin
    Result:= FormatDateTime((Field as TDateTimeField).DisplayFormat, Field.AsDateTime, FFormatSettings);

//    if (Result <> '') and (not TryStrToDate(Result, vDateTime, FFormatSettings)) and (FUseHTMLFormatSettings) then
//     FDataType:= PrismFieldTypeAuto;
   end else
   begin
    if (Field.AsString = '') or (Field.AsString = '0') or ((Field.DataType in [ftDate]) and (Field.AsDateTime = 0)) then
     Result:= ''
    else
    begin
     if (not (Field.DataType in [ftDate])) and (Field.DataType in [ftWideString]) then
      Result:= Field.AsString
     else
      Result:= DateToStr(Field.AsDateTime, FFormatSettings);
    end;
   end;
  end else
  if (FDataType in [PrismFieldTypeDateTime]) or (Field.DataType in [ftDateTime]) then
  begin
   if (not FUseHTMLFormatSettings) and (Field is TDateTimeField) and ((Field as TDateTimeField).DisplayFormat <> '') then
   begin
    Result:= FormatDateTime((Field as TDateTimeField).DisplayFormat, Field.AsDateTime, FFormatSettings);
//    if (Result <> '') and (not TryStrToDateTime(Result, vDateTime, FFormatSettings)) and (FUseHTMLFormatSettings) then
//     FDataType:= PrismFieldTypeAuto;
   end else
   begin
    if (Field.AsString = '') or (Field.AsString = '0') or (Field.AsDateTime = 0) then
     Result:= ''
    else
     if (not (Field.DataType in [ftDateTime])) and (Field.DataType in [ftWideString]) then
      Result:= Field.AsString
     else
      Result:= FormatDateTime(FFormatSettings.ShortDateFormat+ ' ' + FFormatSettings.ShortTimeFormat, Field.AsDateTime, FFormatSettings);
   end;

   if FUseHTMLFormatSettings then
    Result:= StringReplace(Result, ' ', 'T', []);
  end else
  if (FDataType in [PrismFieldTypeTime]) or (Field.DataType in [ftTime, ftTimeStamp]) then
  begin
   if (Field.AsString = '') or (Field.AsString = '00:00') or (Field.AsString = '00:00:00') or (Field.AsString = '0') then
    Result:= ''
   else
   begin
    if (not (Field.DataType in [ftTime, ftTimeStamp])) and (Field.DataType in [ftWideString]) then
    begin
     if TryStrToTime(Field.AsString, vDateTime, FFormatSettings) then
      Result:= FormatDateTime(FFormatSettings.ShortTimeFormat, vDateTime)
     else
      Result:= Field.AsString
    end else
     Result:= FormatDateTime(FFormatSettings.ShortTimeFormat, Field.AsDateTime);
   end;
  end else
  if (FDataType in [PrismFieldTypeNumber]) or (Field.DataType in [ftFloat, ftExtended, ftFMTBcd, ftBCD, ftCurrency]) then
  begin
   if (Field.DataType in [ftCurrency]) and
      ((not (Field is TNumericField)) or ((Field is TNumericField) and ((Field as TNumericField).DisplayFormat = ''))) then
   begin
    Result:= FormatCurr(FormatOfCurrency(FFormatSettings), Field.AsCurrency, FFormatSettings);
   end else
   if (Field is TNumericField) and ((Field as TNumericField).DisplayFormat <> '') then
   begin
    if (Field.AsString = '') or (Field.AsString = '0') then
     Result:= FormatFloat((Field as TNumericField).DisplayFormat, 0, FFormatSettings)
    else
     Result:= FormatFloat((Field as TNumericField).DisplayFormat, field.AsFloat, FFormatSettings);
   end else
   begin
    if (Field.AsString = '') or (Field.AsString = '0') then
     Result:= '0'
    else
      Result:= FloatToStr(Field.AsFloat, FFormatSettings);
   end;
  end else
   Result:= Field.AsString;
 end else
  Result:= '';
end;

function TPrismDataWareField.ReadOnly: boolean;
begin
 if Assigned(FPrismControl) and (TPrismControl(FPrismControl).Initilized) then
 begin
  Result:= true;

  try
   if Active then
    if CanModify then
     if (Editing) or (DataSource.AutoEdit) then
      result:= false;
  except
  end;
 end else
  Result:= False;
end;

procedure TPrismDataWareField.SetDataWareMapped(const Value: TPrismDataWareMapped);
begin
 FPrismDataWareMapped:= Value;
end;

procedure TPrismDataWareField.SetEditDataType(AEditType: TPrismFieldType);
begin
 FDataType:= AEditType;
end;

procedure TPrismDataWareField.SetFieldValue(AValue: Variant);
begin
 if Assigned(Field) and Assigned(Field.DataSet) and Field.DataSet.Active then
 begin
  if (not Editing) then
   if not Edit then
    exit;

  Field.Value := AValue;
 end;
end;

procedure TPrismDataWareField.SetUseHTMLFormatSettings(Value: Boolean);
begin
 if Value then
  FFormatSettings:= PrismBaseClass.Options.HTMLFormatSettings
 else
  FFormatSettings:= TPrismControl(FPrismControl).Session.FormatSettings;

 FUseHTMLFormatSettings:= Value;
end;

procedure TPrismDataWareField.SetValueHTMLElement(AValue: string);
var
 vDateTime: TDateTime;
 vFloat: Double;
begin
 if Assigned(Field) and Assigned(Field.DataSet) and Field.DataSet.Active then
 begin
  if (not Editing) then
   if not Edit then
    exit;

  if (FDataType in [PrismFieldTypeDate]) or (Field.DataType in [ftDate]) then
  begin
   if (AValue = '') or (AValue = '0') then
    Field.Clear
   else
   begin
    if (not (Field.DataType in [ftDate])) and (Field.DataType in [ftWideString]) then
     Field.AsString:= AValue
    else
    if TryStrToDate(AValue, vDateTime, FFormatSettings) then
     Field.AsDateTime:= TDate(vDateTime)
    else
    begin
     if (Field is TDateTimeField) and ((Field as TDateTimeField).DisplayFormat <> '') then
      AValue:= FixDateTimeByFormat(AValue, Field.AsDateTime, (Field as TDateTimeField).DisplayFormat, FFormatSettings.ShortDateFormat);
     if TryStrToDate(AValue, vDateTime, FFormatSettings) then
      Field.AsDateTime:= TDate(vDateTime)
    end;
   end;
  end else
  if (FDataType in [PrismFieldTypeDateTime]) or (Field.DataType in [ftDateTime]) then
  begin
   if (AValue = '') or (AValue = '0') then
    Field.Clear
   else
   begin
    if (not (Field.DataType in [ftDateTime])) and (Field.DataType in [ftWideString]) then
     Field.AsString:= AValue
    else
    if TryStrToDateTime(AValue, vDateTime, FFormatSettings) then
     Field.AsDateTime:= TDate(vDateTime)
    else
    begin
     if (Field is TDateTimeField) and ((Field as TDateTimeField).DisplayFormat <> '') then
      AValue:= FixDateTimeByFormat(AValue, Field.AsDateTime, (Field as TDateTimeField).DisplayFormat, FFormatSettings.ShortDateFormat+' '+FFormatSettings.ShortTimeFormat);
     if TryStrToDateTime(AValue, vDateTime, FFormatSettings) then
      Field.AsDateTime:= TDate(vDateTime)
    end;
   end;
  end else
  if (FDataType in [PrismFieldTypeTime]) or (Field.DataType in [ftTime, ftTimeStamp]) then
  begin
   if (AValue = '') or (AValue = '00:00') or (AValue = '00:00:00') or (AValue = '0') then
    Field.AsString:= '00:00:00'
   else
   begin
    if TryStrToTime(AValue, vDateTime, FFormatSettings) then
     Field.AsDateTime:= TDate(vDateTime)
   end;
  end else
  if (FDataType in [PrismFieldTypeNumber]) or (Field.DataType in [ftFloat, ftExtended, ftFMTBcd, ftBCD, ftCurrency]) then
  begin
   AValue:= FixFloat(AValue, FFormatSettings);
   if (AValue = '') then
    Field.Clear
   else
   begin
    if TryStrToFloat(AValue, vFloat, FFormatSettings) then
     Field.AsFloat := vFloat
   end;
  end else
   Field.AsString:= AValue;
 end;
end;


{$ELSE}
implementation
{$ENDIF}

end.
