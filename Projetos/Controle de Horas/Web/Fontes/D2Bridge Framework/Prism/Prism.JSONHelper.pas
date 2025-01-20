{
baseado em JSON Writers de Landerson Gomes
https://github.com/landersongomes/exemplos/blob/master/ClassHelperTDataset/ULGTDataSetHelper.pas
referencia
http://docwiki.embarcadero.com/RADStudio/Sydney/en/Readers_and_Writers_JSON_Framework
}

{$I ..\D2Bridge.inc}

unit Prism.JSONHelper;


interface


uses
  System.Classes, System.SysUtils, System.JSON, System.NetEncoding, REST.Json,
{$IFDEF FMX}
  FMX.Grid,
{$ELSE}
  Vcl.Grids,
{$ENDIF}
  Data.DB;


  type
    TJSONHelper = class Helper for TJSONObject
    public
     function GetValue(aKey: string; aCaseInsensitive: boolean = true): TJSONValue; overload;
   end;


  Type
    TDataSetHelper = class Helper for TDataSet
    public
      function DataSetToJSON: TJSonArray; overload;
      function DataSetToJSON(AColumns: TJSONArray; MaxRecords: Integer; AFormatSettings: TFormatSettings; IncludeRecNOCol: boolean = false): TJSonArray; overload;
      function DataSetToJSON(AColumns: TJSONArray; MaxRecords: Integer; IncludeRecNOCol: boolean = false): TJSonArray; overload;
      procedure SaveToJSON(aFileName : string);
    end;

    TStringGridHelper = class helper for TStringGrid
    public
      function StringGridToJson: TJSonArray; overload;
      function StringGridToJson(AColumns: TJSONArray; MaxRecords: Integer; AFormatSettings: TFormatSettings; IncludeRecNOCol: boolean = false): TJSonArray; overload;
      function StringGridToJson(AColumns: TJSONArray; MaxRecords: Integer; IncludeRecNOCol: boolean = false): TJSonArray; overload;
      procedure SaveToJSON(aFileName: string);
    end;

implementation

uses
  System.JSON.Writers, System.JSON.Types, Prism.Util;

{ TDataSetHelper }


function TDataSetHelper.DataSetToJSON(AColumns: TJSONArray; MaxRecords: integer; IncludeRecNOCol: boolean = false): TJSonArray;
begin

end;


function TDataSetHelper.DataSetToJSON: TJSonArray;
var
  lCols : integer;
  lStreamIn: TStream;
  lStreamOut : TStringStream;
  lStringWriter : TStringWriter;
  lJSONWriter : TJsonTextWriter;
begin
  lStringWriter := TStringWriter.Create;
  lJSONWriter := TJsonTextWriter.Create(lStringWriter);
  lJSONWriter.Formatting := TJsonFormatting.Indented;
  try
    Self.First;
    lJSONWriter.WriteStartArray;
    while not Self.Eof do
      begin
        lJSONWriter.WriteStartObject;
        for lCols := 0 to Pred(FieldCount) do
          begin
            lJSONWriter.WritePropertyName(Self.Fields[lCols].FieldName);
            if Self.Fields[lCols].IsNull then
              lJSONWriter.WriteNull
            else
              case Fields[lCols].DataType of
                ftBlob:
                  begin
                    lStreamIn := CreateBlobStream(Fields[lCols], bmRead);
                    lStreamOut := TStringStream.Create;
                    TNetEncoding.Base64.Encode(lStreamIn, lStreamOut);
                    lStreamOut.Position := 0;
                    lJSONWriter.WritePropertyName(Self.Fields[lCols].FieldName);
                    lJSONWriter.WriteValue(lStreamOut.DataString);
                  end;
                ftBoolean:
                  lJSONWriter.WriteValue(Fields[lCols].AsBoolean);
                // númericos
                ftFloat, ftExtended, ftFMTBcd, ftBCD:
                begin
                  lJSONWriter.WriteValue(Fields[lCols].AsFloat);
                end;
                ftCurrency:
                  lJSONWriter.WriteValue(Fields[lCols].AsCurrency);
                ftSmallint, ftShortint, ftWord, ftInteger, ftAutoInc,
                ftLargeint, ftLongWord:
                  lJSONWriter.WriteValue(Int64(Fields[lCols].Value));
                //string
                ftString, ftFmtMemo, ftMemo, ftWideString, ftWideMemo, ftUnknown :
                  lJSONWriter.WriteValue(Trim(Fields[lCols].Value));
                // DateTime
                ftDateTime:
                  begin
//                          var lFS : TFormatSettings;
//                          lFS := TFormatSettings.Create('pt-BR');
//                          lFS.ShortDateFormat := 'mm/dd/yyyy';
                    lJSONWriter.WriteValue(FormatDatetime('DD/MM/YYYY hh:nn:ss', Self.Fields[lCols].AsDateTime));
                  end;
                ftDate:
                  lJSONWriter.WriteValue(FormatDatetime('DD/MM/YYYY', Self.fields[lcols].AsDateTime));
                ftTime, ftTimeStamp:
                  lJSONWriter.WriteValue(FormatDatetime('hh:hh:ss', Self.Fields[lCols].AsDateTime));

                ftBytes:
                  lJSONWriter.WriteValue(Self.Fields[lCols].AsBytes);
              end;
          end;
        lJSONWriter.WriteEndObject;
        Self.Next;
      end;
    lJSONWriter.WriteEndArray;

    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lStringWriter.ToString), 0) as TJSONArray;
  finally
    lJSONWriter.Free;
    lStringWriter.Free;
  end;
end;

function TDataSetHelper.DataSetToJSON(AColumns: TJSONArray; MaxRecords: Integer; AFormatSettings: TFormatSettings; IncludeRecNOCol: boolean): TJSonArray;
var
  lCols, lColsArray, I : integer;
  lColName: string;
  lStreamIn: TStream;
  lStreamOut : TStringStream;
  lStringWriter : TStringWriter;
  lJSONWriter : TJsonTextWriter;
  FieldExist: Boolean;
  lCountRecordsExported: integer;
  lformatoffloat, lformatofcurrency: string;
begin
  lCountRecordsExported:= 0;
  lformatoffloat:= FormatOfFloat(AFormatSettings);
  lformatofcurrency:= FormatOfCurrency(AFormatSettings);
  lStringWriter := TStringWriter.Create;
  lJSONWriter := TJsonTextWriter.Create(lStringWriter);
  lJSONWriter.Formatting := TJsonFormatting.Indented;
  try
    //Self.First;
    lJSONWriter.WriteStartArray;

    try
      while ((not Self.Eof) or ((Self.Eof) and (MaxRecords = 1))) and
            ((MaxRecords <= 0) or ((MaxRecords > 0) and (MaxRecords > lCountRecordsExported))) do
      begin
        Inc(lCountRecordsExported);

        lJSONWriter.WriteStartObject;
          for lColsArray:= 0 to Pred(AColumns.Count) do
          begin
              lColName:= AColumns.Items[lColsArray].Value;

              lJSONWriter.WritePropertyName(lColName);

              FieldExist:= false;
              for I := 0 to Pred(FieldCount) do
              if SameText(lColName, Self.Fields[I].FieldName) then
              begin
               FieldExist:= true;
               lCols:= I;
               break;
              end;

              if not FieldExist then
                  lJSONWriter.WriteNull
              else
              begin
                //lJSONWriter.WritePropertyName(Self.Fields[lCols].FieldName);
                if Self.Fields[lCols].IsNull then
                  lJSONWriter.WriteNull
                else
                  case Fields[lCols].DataType of
                    ftBlob:
                      begin
                        lStreamIn := CreateBlobStream(Fields[lCols], bmRead);
                        lStreamOut := TStringStream.Create;
                        TNetEncoding.Base64.Encode(lStreamIn, lStreamOut);
                        lStreamOut.Position := 0;
                        lJSONWriter.WritePropertyName(Self.Fields[lCols].FieldName);
                        lJSONWriter.WriteValue(lStreamOut.DataString);
                      end;
                    ftBoolean:
                      lJSONWriter.WriteValue(Fields[lCols].AsBoolean);
                    // númericos
                    ftFloat, ftExtended, ftFMTBcd, ftBCD:
                    begin
                      //lJSONWriter.WriteValue(Fields[lCols].AsFloat);
                      if (Fields[lCols] as TNumericField).DisplayFormat <> '' then
                       lJSONWriter.WriteValue(FormatFloat((Fields[lCols] as TNumericField).DisplayFormat, Self.fields[lcols].AsFloat, AFormatSettings))
                      else
                       lJSONWriter.WriteValue(FormatFloat(lformatoffloat, Self.fields[lcols].AsFloat, AFormatSettings))
                    end;
                    ftCurrency:
                    begin
                      if (Fields[lCols] as TNumericField).DisplayFormat <> '' then
                       lJSONWriter.WriteValue(FormatFloat((Fields[lCols] as TNumericField).DisplayFormat, Self.fields[lcols].AsCurrency, AFormatSettings))
                      else
                       lJSONWriter.WriteValue(FormatFloat(lformatofcurrency, Self.fields[lcols].AsCurrency, AFormatSettings))
                    end;
                    ftSmallint, ftShortint, ftWord, ftInteger, ftAutoInc,
                    ftLargeint, ftLongWord:
                      lJSONWriter.WriteValue(Int64(Fields[lCols].Value));
                    //string
                    ftString, ftFmtMemo, ftMemo, ftWideString, ftWideMemo, ftUnknown :
                      lJSONWriter.WriteValue(Trim(Fields[lCols].Value));
                    // DateTime
                    ftDateTime:
                      begin
                       if (Fields[lCols] as TDateTimeField).DisplayFormat <> '' then
                        lJSONWriter.WriteValue(FormatDatetime((Fields[lCols] as TDateTimeField).DisplayFormat, Self.Fields[lCols].AsDateTime))
                       else
                        lJSONWriter.WriteValue(FormatDatetime(AFormatSettings.ShortDateFormat + ' ' + AFormatSettings.ShortTimeFormat , Self.Fields[lCols].AsDateTime)); //'DD/MM/YYYY hh:nn:ss'
                      end;
                    ftDate:
                      begin
                       if (Fields[lCols] as TDateTimeField).DisplayFormat <> '' then
                        lJSONWriter.WriteValue(FormatDatetime((Fields[lCols] as TDateTimeField).DisplayFormat, Self.Fields[lCols].AsDateTime))
                       else
                        lJSONWriter.WriteValue(FormatDatetime(AFormatSettings.ShortDateFormat, Self.fields[lcols].AsDateTime));
                      end;
                    ftTime:
                      lJSONWriter.WriteValue(FormatDatetime(AFormatSettings.ShortTimeFormat, Self.Fields[lCols].AsDateTime));
                    ftTimeStamp:
                      begin
                       if (Fields[lCols] as TSQLTimeStampField).DisplayFormat <> '' then
                        lJSONWriter.WriteValue(FormatDatetime((Fields[lCols] as TSQLTimeStampField).DisplayFormat, Self.Fields[lCols].AsDateTime))
                       else
                        lJSONWriter.WriteValue(FormatDatetime(AFormatSettings.ShortDateFormat + ' ' + AFormatSettings.ShortTimeFormat, Self.Fields[lCols].AsDateTime)); //'DD/MM/YYYY hh:nn:ss'
                      end;


                    ftBytes:
                      lJSONWriter.WriteValue(Self.Fields[lCols].AsBytes);
                  end;
              end;
          end;

        if IncludeRecNOCol then
        begin
         lJSONWriter.WritePropertyName('PrismRecNo');
         lJSONWriter.WriteValue(RecNo);
        end;

        lJSONWriter.WriteEndObject;
        if MaxRecords > 1 then
         Self.Next;
      end;

      lJSONWriter.WriteEndArray;
    except

    end;

    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lStringWriter.ToString), 0) as TJSONArray;
  finally
    lJSONWriter.Free;
    lStringWriter.Free;
  end;
end;

procedure TDataSetHelper.SaveToJSON(aFileName: string);
var
  S: TStringList;
begin
  S:= TStringList.Create;
  S.Clear;
  S.Add(DataSetToJSON.ToString());
  S.SaveToFile(aFileName);

  S.Free;
end;

{ TJSONHelper }

function TJSONHelper.GetValue(aKey: string; aCaseInsensitive: boolean): TJSONValue;
var
 I: Integer;
begin
 result:= nil;

 if aCaseInsensitive then
 begin
  for I := 0 to Pred(Count) do
  begin
    if SameText(Pairs[I].JsonString.Value, aKey) then
    begin
      Result := Pairs[I].JsonValue;
      break;
    end;
  end;
 end else
  result:= Self.GetValue(aKey);
end;

{ TStringGridHelper }

function TStringGridHelper.StringGridToJson(AColumns: TJSONArray; MaxRecords: Integer; IncludeRecNOCol: boolean): TJSonArray;
begin

end;

function TStringGridHelper.StringGridToJson: TJSonArray;
var
  lCols : integer;
  lStreamIn: TStream;
  lStreamOut : TStringStream;
  lStringWriter : TStringWriter;
  lJSONWriter : TJsonTextWriter;
  nRowCount, nColCount, nRegistro: integer;
begin
  lStringWriter := TStringWriter.Create;
  lJSONWriter := TJsonTextWriter.Create(lStringWriter);
  lJSONWriter.Formatting := TJsonFormatting.Indented;

  try
    nRowCount:= Self.RowCount;
    nColCount:= Self.{$IFNDEF FMX}ColCount{$ELSE}ColumnCount{$ENDIF};

    lJSONWriter.WriteStartArray;

    for nRegistro:= {$IFNDEF FMX}1{$ELSE}0{$ENDIF} to Pred(nRowCount) do
    begin
      lJSONWriter.WriteStartObject;

      for lCols := 0 to Pred(nColCount) do
      begin
        lJSONWriter.WritePropertyName({$IFNDEF FMX}Self.Cells[lCols, 0]{$ELSE}Self.Columns[lCols].Header{$ENDIF});
        lJSONWriter.WriteValue(Trim(Self.Cells[lCols, nRegistro]));
      end;

      lJSONWriter.WriteEndObject;
    end;

    lJSONWriter.WriteEndArray;

    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lStringWriter.ToString), 0) as TJSONArray;
  finally
    lJSONWriter.Free;
    lStringWriter.Free;
  end;
end;

procedure TStringGridHelper.SaveToJSON(aFileName: string);
var
  S: TStringList;
begin
  S:= TStringList.Create;
  S.Clear;
  S.Add(StringGridToJson.ToString());
  S.SaveToFile(aFileName);

  S.Free;
end;

function TStringGridHelper.StringGridToJson(AColumns: TJSONArray; MaxRecords: Integer; AFormatSettings: TFormatSettings; IncludeRecNOCol: boolean): TJSonArray;
var
  lCols, lColsArray, I : integer;
  lColName: string;
  lStreamIn: TStream;
  lStreamOut : TStringStream;
  lStringWriter : TStringWriter;
  lJSONWriter : TJsonTextWriter;
  FieldExist: Boolean;
  lCountRecordsExported: integer;
  nRowCount, nColCount, nRegistro: integer;
begin
  lCountRecordsExported:= 0;
  lStringWriter := TStringWriter.Create;
  lJSONWriter := TJsonTextWriter.Create(lStringWriter);
  lJSONWriter.Formatting := TJsonFormatting.Indented;

  try
    //Self.First;
    lJSONWriter.WriteStartArray;

    try
      nRowCount:= Self.RowCount;
      nColCount:= Self.{$IFNDEF FMX}ColCount{$ELSE}ColumnCount{$ENDIF};

      if (MaxRecords > 0) and ((nRowCount {$IFNDEF FMX} - 1{$ENDIF}) > MaxRecords) then
        nRowCount:= MaxRecords {$IFNDEF FMX} + 1{$ENDIF};

      for nRegistro:= {$IFNDEF FMX}1{$ELSE}0{$ENDIF} to Pred(nRowCount) do
      begin
        if lCountRecordsExported > MaxRecords then
          Break;

        Inc(lCountRecordsExported);

        lJSONWriter.WriteStartObject;
        for lColsArray:= 0 to Pred(AColumns.Count) do
        begin
          lColName:= AColumns.Items[lColsArray].Value;

          lJSONWriter.WritePropertyName(lColName);

          FieldExist:= false;
          for I := 0 to Pred(nColCount) do
          if SameText(lColName, {$IFNDEF FMX}Self.Cells[I, 0]{$ELSE}Self.Columns[I].Header{$ENDIF}) then
          begin
            FieldExist:= true;
            lCols:= I;
            break;
          end;

          if not FieldExist then
            lJSONWriter.WriteNull
          else
            lJSONWriter.WriteValue(Trim(Self.Cells[lCols, nRegistro]));
        end;

        if IncludeRecNOCol then
        begin
         lJSONWriter.WritePropertyName('PrismRecNo');
         lJSONWriter.WriteValue(nRegistro);
        end;

        lJSONWriter.WriteEndObject;
      end;

      lJSONWriter.WriteEndArray;
    except

    end;

    Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lStringWriter.ToString), 0) as TJSONArray;
  finally
    lJSONWriter.Free;
    lStringWriter.Free;
  end;
end;

end.


