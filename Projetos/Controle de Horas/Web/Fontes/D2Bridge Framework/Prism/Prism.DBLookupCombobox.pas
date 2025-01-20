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

unit Prism.DBLookupCombobox;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.JSON, System.SysUtils, Data.DB,
  Vcl.DBCtrls, System.Generics.Collections,
  Prism.Interfaces, Prism.Forms.Controls, Prism.Types;

type
 TPrismDBLookupCombobox = class(TPrismControl, IPrismDBLookupCombobox)
  strict private
   type
     TPrismDBLookupComboboxDataLink = class(TFieldDataLink)
     private
       FPrismDBLookupCombobox: TPrismDBLookupCombobox;
       FDataActive: Boolean;
     protected
       procedure ActiveChanged; override;
     public
       constructor Create(APrismDBLookupCombobox: TPrismDBLookupCombobox);
       procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
     end;

     TPrismDBLookupComboboxListDataLink = class(TFieldDataLink)
     private
       FPrismDBLookupCombobox: TPrismDBLookupCombobox;
       FDataActive: Boolean;
       FKeyFieldName: String;
     protected
       procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
       procedure ActiveChanged; override;
     public
       constructor Create(APrismDBLookupCombobox: TPrismDBLookupCombobox);

       property KeyFieldName: string read FKeyFieldName write FKeyFieldName;
     end;
  private
   FProcSetText: TOnSetValue;
   FProcGetText: TOnGetValue;
   FRefreshData: Boolean;
   FRefreshListData: Boolean;
   FDataLink: TPrismDBLookupComboboxDataLink;
   FListDataLink: TPrismDBLookupComboboxListDataLink;
   FStoredSelectedItem: String;
   FMaxRecords: Integer;
   FListData: TDictionary<String,String>;
   FListKeys: TList<string>;
   procedure UpdateData; override;
   procedure UpdateListData;
   procedure SetDataSource(const Value: TDataSource);
   function GetDataSource: TDataSource;
   procedure SetDataField(AValue: String);
   function GetDataField: String;
   procedure SetListDataSource(const Value: TDataSource);
   function GetListDataSource: TDataSource;
   function GetListDataField: string;
   Procedure SetListDataField(AFieldName: string);
   function GetKeyDataField: string;
   Procedure SetKeyDataField(AFieldName: string);
   function GetMaxRecords: integer;
   Procedure SetMaxRecords(AMaxRecords: Integer);
   procedure SetSelectedItem(AText: String);
   function GetSelectedItem: String;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function GetReadOnly: Boolean; override;
   function IsDBLookupCombobox: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   property DataSource: TDataSource read GetDataSource write SetDataSource;
   property DataField: String read GetDataField write SetDataField;
   property ListDataSource: TDataSource read GetListDataSource write SetListDataSource;
   property ListDataField: String read GetListDataField write SetListDataField;
   property KeyDataField: String read GetKeyDataField write SetKeyDataField;
   property SelectedItem: String read GetSelectedItem write SetSelectedItem;
   property ProcSetText: TOnSetValue read FProcSetText write FProcSetText;
   property ProcGetText: TOnGetValue read FProcGetText write FProcGetText;
   property MaxRecords: Integer read GetMaxRecords write SetMaxRecords;
 end;


implementation

uses
  Prism.Util, System.Variants, System.StrUtils;

{ TPrismDBLookupCombobox }

constructor TPrismDBLookupCombobox.Create(AOwner: TComponent);
begin
 inherited;

 FRefreshData:= false;
 FRefreshListData:= false;
 FDataLink:= TPrismDBLookupComboboxDataLink.Create(Self);
 FListDataLink:= TPrismDBLookupComboboxListDataLink.Create(Self);
 FListData:= TDictionary<String,String>.Create;
 FListKeys:= TList<string>.Create;

 FMaxRecords:= 1000;
end;

destructor TPrismDBLookupCombobox.Destroy;
begin
 FreeAndNil(FDataLink);
 FreeAndNil(FListDataLink);
 FreeAndNil(FListData);
 FreeAndNil(FListKeys);

 inherited;
end;

function TPrismDBLookupCombobox.GetDataField: String;
begin
 Result:= FDataLink.FieldName;
end;

function TPrismDBLookupCombobox.GetDataSource: TDataSource;
begin
 Result:= FDataLink.DataSource;
end;

function TPrismDBLookupCombobox.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismDBLookupCombobox.GetKeyDataField: string;
begin
 Result:= FListDataLink.KeyFieldName;
end;

function TPrismDBLookupCombobox.GetListDataField: string;
begin
 Result:= FListDataLink.FieldName;
end;

function TPrismDBLookupCombobox.GetListDataSource: TDataSource;
begin
 Result:= FListDataLink.DataSource;
end;


function TPrismDBLookupCombobox.GetMaxRecords: integer;
begin
 Result:= FMaxRecords;
end;

function TPrismDBLookupCombobox.GetReadOnly: Boolean;
var
 vResultCanEditing: boolean;
begin
 result:= Inherited;

 if (not Result) and Assigned(FDataLink.DataSource) then
 begin
  vResultCanEditing:= false;

  if Assigned(FDataLink.DataSet) then
   if FDataLink.Active then
    if (FDataLink.Editing) or (FDataLink.DataSource.AutoEdit) then
     vResultCanEditing:= true;

  Result:= not vResultCanEditing;
 end;
end;

function TPrismDBLookupCombobox.GetSelectedItem: String;
var
 vResult: Variant;
begin
 if Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field) then
 begin
  if (FDataLink.DataSet.Active) then
   Result:= FDataLink.Field.AsString
  else
   Result:= ''
 end else
 if Assigned(FProcGetText) then
 begin
  vResult:= FProcGetText;
  if not VarIsNull(vResult) then
  Result:= vResult
 end
 else
 if not Assigned(FDataLink.DataSource) and Assigned(FListDataLink.DataSource) and Assigned(FListDataLink.DataSource.DataSet) and (FListDataLink.DataSet.Active) then
  Result:= FStoredSelectedItem
 else
  Result:= '';
end;

procedure TPrismDBLookupCombobox.Initialize;
begin
 inherited;

 FStoredSelectedItem:= GetSelectedItem;
end;

function TPrismDBLookupCombobox.IsDBLookupCombobox: Boolean;
begin
 result:= true;
end;

procedure TPrismDBLookupCombobox.ProcessComponentState(
  const ComponentStateInfo: TJSONObject);
var
 SelectValue: String;
begin
 inherited;

 if (ComponentStateInfo.GetValue('selectedvalue') <> nil) then
 begin
  SelectValue:= ComponentStateInfo.GetValue('selectedvalue').Value;

  SelectedItem:= SelectValue;
 end;
end;

procedure TPrismDBLookupCombobox.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismDBLookupCombobox.ProcessHTML;
var
 I, Pos, vQtdRec: Integer;
 vExistItem: Boolean;
 vKeyFieldValue, vFieldValue: string;
begin
 inherited;

 try
  HTMLControl := '<select ';
  HTMLControl := HTMLControl + ' ' + HTMLCore + ' aria-label="' + ifThen(Placeholder = '', Form.Session.LangNav.Combobox.Select, Placeholder) + '" ';
  HTMLControl := HTMLControl + '>';

  if Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then
  begin
   if SelectedItem = '' then
   HTMLControl := HTMLControl + '<option hidden disabled selected value>' + ifThen(Placeholder = '', Form.Session.LangNav.Combobox.Select, Placeholder) + '</option>';
  end;

  //Itens
  //if Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then
  if Assigned(FListDataLink.DataSource) and
     Assigned(FListDataLink.DataSet) and
     (FListDataLink.DataSet.Active) and
     Assigned(FListDataLink.Field) and
     (FRefreshListData) and
     (FListDataLink.KeyFieldName <> '') then
  begin
   try
    FRefreshListData:= false;
    FListData.Clear;
    FListKeys.Clear;
    Pos:= FListDataLink.DataSet.RecNo;
    FListDataLink.DataSet.DisableControls;

    vQtdRec:= 0;
    vExistItem:= false;
    FListDataLink.DataSet.First;
    repeat
    begin
     vKeyFieldValue:= FListDataLink.DataSet.FieldByName(FListDataLink.KeyFieldName).AsString;

     if vKeyFieldValue <> '' then
      if (not FListKeys.Contains(vKeyFieldValue)) and (not FListData.ContainsKey(vKeyFieldValue)) then
      begin
       FListKeys.Add(vKeyFieldValue);
       FListData.Add(vKeyFieldValue, FListDataLink.Field.AsString);
      end;

     FListDataLink.DataSet.next;

     Inc(vQtdRec);
    end until (vQtdRec >= FMaxRecords) or FListDataLink.DataSet.Eof;
   except
    on E: Exception do
    begin
     try
      Session.DoException(self as TObject, E, 'TPrismDBLookupCombobox.ProcessHTML');
     except
     end;
     Exit;
    end;
   end;

   FListDataLink.DataSet.RecNo:= Pos;
   FListDataLink.DataSet.EnableControls;
  end;


  if FListData.Count > 0 then
  begin
   try
    for I := 0 to Pred(FListKeys.Count) do
    begin
     vKeyFieldValue:= FListKeys[I];
     vFieldValue:= FListData.Items[vKeyFieldValue];

     if SameText(vKeyFieldValue, FStoredSelectedItem) then
     begin
      HTMLControl := HTMLControl + '<option selected value="'+ vKeyFieldValue + '">' + vFieldValue + '</option>';
      vExistItem:= true;
     end else
      HTMLControl := HTMLControl + '<option value="'+ vKeyFieldValue + '">' + vFieldValue + '</option>';
    end;
   except
    on E: Exception do
    begin
     try
      Session.DoException(self as TObject, E, 'TPrismDBLookupCombobox.ProcessHTML');
     except
     end;
     Exit;
    end;
   end;
  end;


  if not (Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active)) then
  if (not vExistItem) then
  HTMLControl := HTMLControl + '<option hidden disabled selected value>' + Form.Session.LangNav.Combobox.Select + '</option>';

  HTMLControl := HTMLControl + '</select>';
 except
  on E: Exception do
  begin
   try
    Session.DoException(self as TObject, E, 'TPrismDBLookupCombobox.ProcessHTML');
   except
   end;
   Exit;
  end;
 end;

end;

procedure TPrismDBLookupCombobox.SetDataField(AValue: String);
begin
 FDataLink.FieldName:= AValue;
end;

procedure TPrismDBLookupCombobox.SetDataSource(const Value: TDataSource);
begin
 if FDataLink.DataSource <> Value then
 begin
  if Assigned(FDataLink.DataSource) then
   FDataLink.DataSource.RemoveFreeNotification(Self);

  try
   if Assigned(Value) then
    FDataLink.DataSource := Value
   else
    FDataLink.DataSource:= nil;
  except

  end;


//  if Assigned(FDataLink.DataSource) then
//    FDataLink.DataSource.FreeNotification(Self);
 end;

end;

procedure TPrismDBLookupCombobox.SetKeyDataField(AFieldName: string);
begin
 FListDataLink.KeyFieldName:= AFieldName;
end;

procedure TPrismDBLookupCombobox.SetListDataField(AFieldName: string);
begin
 FListDataLink.FieldName:= AFieldName;
end;

procedure TPrismDBLookupCombobox.SetListDataSource(const Value: TDataSource);
begin
 if FListDataLink.DataSource <> Value then
 begin
  if Assigned(FListDataLink.DataSource) then
   FListDataLink.DataSource.RemoveFreeNotification(Self);

  try
   if Assigned(Value) then
    FListDataLink.DataSource := Value
   else
    FListDataLink.DataSource:= nil;
  except

  end;

//  if Assigned(FListDataLink.DataSource) then
//    FListDataLink.DataSource.FreeNotification(Self);
 end;

end;


procedure TPrismDBLookupCombobox.SetMaxRecords(AMaxRecords: Integer);
begin
 FMaxRecords:= AMaxRecords;
end;

procedure TPrismDBLookupCombobox.SetSelectedItem(AText: String);
begin
 if Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) and Assigned(FListDataLink.Field) then
 begin
  if (Form.ComponentsUpdating) and (not FDataLink.Editing) and (AText <> FStoredSelectedItem) then
  FDataLink.DataSet.Edit;

  if (FDataLink.Editing) then
  begin
   FDataLink.Field.AsString:= AText;
  end;
 end else
 if Assigned(FProcSetText) then
  FProcSetText(AText);

 if FStoredSelectedItem <> AText then
  if Assigned(Events.Item(EventOnSelect)) then
   Session.ExecThread(false,
    procedure
    begin
     Events.Item(EventOnSelect).CallEvent(nil);
    end
   );

 FStoredSelectedItem:= AText;
end;

procedure TPrismDBLookupCombobox.UpdateData;
begin
 if (Form.FormPageState = PageStateLoaded) and (not Form.ComponentsUpdating) then
 FRefreshData:= true
end;


procedure TPrismDBLookupCombobox.UpdateListData;
begin
 FRefreshListData:= true;
 FListData.Clear;
 FListKeys.Clear;
end;

procedure TPrismDBLookupCombobox.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewSelectedItem: string;
begin
 if (FRefreshData) or (FRefreshListData) or (AForceUpdate) then
 begin
  try
   try
    if AForceUpdate then
     FRefreshListData:= true;

    RefreshHTMLControl;
    ProcessHTML;
    //ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").outerHTML = '+ FormatValueHTML(HTMLControl) +';');
    ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").outerHTML = '+ FormatValueHTML(HTMLControl) +';');
   except
   end;
  finally
   FRefreshData:= false;
   FRefreshListData:= false;
  end;
 end;


 NewSelectedItem:= SelectedItem;
 if (FStoredSelectedItem <> NewSelectedItem) then
 begin
  FStoredSelectedItem := NewSelectedItem;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").value = '+ FormatValueHTML(NewSelectedItem) +';');
 end;

 //Se faz necessário o inherited aqui embaixo para que o combobox receba atualização de visibilidade apos a tabela abrir
 inherited;
end;

{ TPrismDBLookupCombobox.TPrismDBLookupComboboxDataLink }

procedure TPrismDBLookupCombobox.TPrismDBLookupComboboxDataLink.ActiveChanged;
begin
 inherited;

 FDataActive := Active;
end;

constructor TPrismDBLookupCombobox.TPrismDBLookupComboboxDataLink.Create(APrismDBLookupCombobox: TPrismDBLookupCombobox);
begin
 inherited Create;

 FPrismDBLookupCombobox:= APrismDBLookupCombobox;
 FDataActive:= false;
end;

procedure TPrismDBLookupCombobox.TPrismDBLookupComboboxDataLink.DataEvent(Event: TDataEvent;
  Info: NativeInt);
var
 vDataField: String;
begin
 inherited;


 if Event in [deUpdateState] then
 if ((Event in [deUpdateState]) and FDataActive <> DataSet.Active) then
 begin
  FPrismDBLookupCombobox.UpdateData;
 end;

 if FDataActive <> DataSet.Active then
 if Active and (FPrismDBLookupCombobox.DataField <> '') then
 begin
  vDataField:= FPrismDBLookupCombobox.DataField;
  FieldName:= '';
  FPrismDBLookupCombobox.DataField:= vDataField;
 end;


 FDataActive := DataSet.Active;

 if Event in [deFocusControl] then
 begin
  FPrismDBLookupCombobox.SetFocus;
  Control:= FPrismDBLookupCombobox.VCLComponent;
  Exit;
 end;
end;

{ TPrismDBLookupCombobox.TPrismDBLookupComboboxListDataLink }

procedure TPrismDBLookupCombobox.TPrismDBLookupComboboxListDataLink.ActiveChanged;
var vDataField: string;
begin
 inherited;

 FDataActive := DataSet.Active;

 if FDataActive then
 begin
  //FRecordCount:= Dataset.RecordCount;
  //FFiltred:= DataSet.Filtered;
 end else
 begin
  //FRecordCount:= -1;
 end;

 if FDataActive and (not Assigned(Field)) and (FPrismDBLookupCombobox.ListDataField <> '') then
 begin
  vDataField:= FPrismDBLookupCombobox.ListDataField;
  FieldName:= '';
  FPrismDBLookupCombobox.ListDataField:= vDataField;
 end;


 FPrismDBLookupCombobox.UpdateListData;
end;

constructor TPrismDBLookupCombobox.TPrismDBLookupComboboxListDataLink.Create(
  APrismDBLookupCombobox: TPrismDBLookupCombobox);
begin
 inherited Create;

 FPrismDBLookupCombobox:= APrismDBLookupCombobox;
 FDataActive:= false;
end;

procedure TPrismDBLookupCombobox.TPrismDBLookupComboboxListDataLink.DataEvent(
  Event: TDataEvent; Info: NativeInt);
begin
 inherited;

// if Event in [deUpdateRecord, deUpdateState] then
// if (Event in [deUpdateRecord]) or
//    ((Event in [deUpdateState]) and FDataActive <> DataSet.Active) then

// if ((Event in [deUpdateState]) and FDataActive <> DataSet.Active) then
// begin
//  FPrismDBLookupCombobox.UpdateListData;
// end;
//
// FDataActive := DataSet.Active;

end;
{$ELSE}
implementation
{$ENDIF}

end.
