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

unit Prism.DBCheckBox;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.SysUtils, System.JSON, Data.DB,
  Vcl.DBCtrls, System.Rtti,
  Prism.Forms.Controls, Prism.Interfaces, Prism.Types;


type
 TCheckBoxType = Prism.Types.TCheckBoxType;


type
 TPrismDBCheckBox = class(TPrismControl, IPrismDBCheckBox)
  strict private
   type
     TPrismDBCheckBoxDataLink = class(TFieldDataLink)
     private
       FPrismDBCheckBox: TPrismDBCheckBox;
       FDataActive: Boolean;
     public
       constructor Create(APrismDBCheckBox: TPrismDBCheckBox);
       procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
     end;
  private
   FDataLink: TPrismDBCheckBoxDataLink;
   FRefreshData: Boolean;
   FStoredChecked: Boolean;
   FStoredText: String;
   FProcGetText: TOnGetValue;
   FCheckBoxType: TCheckBoxType;
   FValueChecked: String;
   FValueUnChecked: String;
   procedure SetCheckBoxType(ACheckBoxType: TCheckBoxType);
   function GetCheckBoxType: TCheckBoxType;
   function GetText: String;
   procedure SetDataSource(const Value: TDataSource);
   function GetDataSource: TDataSource;
   procedure SetDataField(AValue: String);
   function GetDataField: String;
   function GetValueChecked: String;
   procedure SetValueChecked(AValue: String);
   function GetValueUnChecked: String;
   procedure SetValueUnChecked(AValue: String);
   function GetChecked: Boolean;
   procedure SetChecked(AValue: Boolean);
   procedure UpdateData; override;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsDBCheckBox: Boolean; override;
   function NeedCheckValidation: Boolean; override;
   function GetReadOnly: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   property Text: String read GetText;
   property DataSource: TDataSource read GetDataSource write SetDataSource;
   property DataField: String read GetDataField write SetDataField;
   property ValueChecked: String read GetValueChecked write SetValueChecked;
   property ValueUnChecked: String read GetValueUnChecked write SetValueUnChecked;
   property Checked: Boolean read GetChecked write SetChecked;
   property CheckBoxType: TCheckBoxType read GetCheckBoxType write SetCheckBoxType;
   property ProcGetText: TOnGetValue read FProcGetText write FProcGetText;
 end;



implementation

uses
  Prism.Util;

{ TPrismButton }

constructor TPrismDBCheckBox.Create(AOwner: TComponent);
begin
 inherited;

 FRefreshData:= false;
 FDataLink:= TPrismDBCheckBoxDataLink.Create(Self);
 FCheckBoxType:= CBSwitchType;;
end;

destructor TPrismDBCheckBox.Destroy;
begin
 FreeAndNil(FDataLink);

 inherited;
end;

function TPrismDBCheckBox.GetCheckBoxType: TCheckBoxType;
begin
 Result:= FCheckBoxType;
end;

function TPrismDBCheckBox.GetChecked: Boolean;
begin
 if Assigned(FDataLink.Field) then
 begin
  if Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then
   Result:= SameText(FDataLink.Field.AsString, ValueChecked)
  else
   Result:= false;
 end else
 Result:= false;
end;

function TPrismDBCheckBox.GetDataField: String;
begin
 Result:= FDataLink.FieldName;
end;

function TPrismDBCheckBox.GetDataSource: TDataSource;
begin
 Result:= FDataLink.DataSource;
end;

function TPrismDBCheckBox.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismDBCheckBox.GetReadOnly: Boolean;
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

function TPrismDBCheckBox.GetText: String;
begin
 if Assigned(ProcGetText) then
  Result:= ProcGetText;
end;

function TPrismDBCheckBox.GetValueChecked: String;
begin
 Result:= FValueChecked;
end;

function TPrismDBCheckBox.GetValueUnChecked: String;
begin
 Result:= FValueUnChecked;
end;

procedure TPrismDBCheckBox.Initialize;
begin
 inherited;

 FStoredText:= Text;
 FStoredChecked:= Checked;
end;

function TPrismDBCheckBox.IsDBCheckBox: Boolean;
begin
 Result:= true;
end;

function TPrismDBCheckBox.NeedCheckValidation: Boolean;
begin
 result:= true;
end;

procedure TPrismDBCheckBox.ProcessComponentState(
  const ComponentStateInfo: TJSONObject);
var
 NewChecked: Boolean;
begin
 inherited;

 if (ComponentStateInfo.GetValue('checked') <> nil) then
 begin
  NewChecked:= SameText(ComponentStateInfo.GetValue('checked').Value, 'true');
  if FStoredChecked <> NewChecked then
  begin
   Form.Session.ExecThread(false,
    procedure(AAValue: TValue)
    begin
     Checked:= AAValue.AsBoolean;
    end,
    NewChecked
   );
  end;
 end;

end;

procedure TPrismDBCheckBox.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismDBCheckBox.ProcessHTML;
var
 vChecked: string;
begin
 inherited;

 if Checked then
 vChecked:= 'checked'
 else
 vChecked:= '';

 HTMLControl := '<div class="form-check form-switch">' + sLineBreak;
 HTMLControl := HTMLControl + '<input ' + HTMLCore +' type="checkbox" role="switch" '+ vChecked +'>' + sLineBreak;
 HTMLControl := HTMLControl + '<label class="form-check-label" for="' + AnsiUpperCase(NamePrefix) + '">' + Text + '</label>' + sLineBreak;
 HTMLControl := HTMLControl + '</div>';
end;


procedure TPrismDBCheckBox.SetCheckBoxType(ACheckBoxType: TCheckBoxType);
begin
 FCheckBoxType:= ACheckBoxType;
end;

procedure TPrismDBCheckBox.SetChecked(AValue: Boolean);
begin
 if Assigned(FDataLink.Field) then
 begin
  if Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then
  begin
   //if (Form.ComponentsUpdating) and (not FDataLink.Editing) and (AValue <> FStoredChecked) then
   if (not FDataLink.Editing) and (AValue <> FStoredChecked) then
    FDataLink.DataSet.Edit;

   if (FDataLink.Editing) then
   begin
    if AValue then
    FDataLink.Field.AsString:= ValueChecked
    else
    FDataLink.Field.AsString:= ValueUnChecked;
   end;
  end;

  FStoredChecked:= AValue;
 end;
end;

procedure TPrismDBCheckBox.SetDataField(AValue: String);
begin
 FDataLink.FieldName:= AValue;
end;

procedure TPrismDBCheckBox.SetDataSource(const Value: TDataSource);
begin
 if FDataLink.DataSource <> Value then
 begin
  if Assigned(FDataLink.DataSource) then
   FDataLink.DataSource.RemoveFreeNotification(Self);

  FDataLink.DataSource := Value;

  if Assigned(FDataLink.DataSource) then
    FDataLink.DataSource.FreeNotification(Self);
 end;

end;

procedure TPrismDBCheckBox.SetValueChecked(AValue: String);
begin
 FValueChecked:= AValue;
end;

procedure TPrismDBCheckBox.SetValueUnChecked(AValue: String);
begin
 FValueUnChecked:= AValue;
end;

procedure TPrismDBCheckBox.UpdateData;
begin
 if (Form.FormPageState = PageStateLoaded) and (not Form.ComponentsUpdating) then
 FRefreshData:= true;

end;

procedure TPrismDBCheckBox.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewChecked: Boolean;
 NewText: String;
begin
 inherited;

 NewText:= Text;
 if (FStoredText <> Text) or (AForceUpdate) then
 begin
  FStoredText := NewText;
  ScriptJS.Add('document.querySelector("label[for='+AnsiUpperCase(NamePrefix)+']").textContent  = "'+ Text +'";');
 end;

 NewChecked:= Checked;
 if (FStoredChecked <> NewChecked) or (AForceUpdate) then
 begin
  FStoredChecked := NewChecked;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").checked = '+ NewChecked.ToString(FStoredChecked, TUseBoolStrs.True).ToLower +';');
 end;
end;

{ TPrismDBCheckBox.TPrismDBCheckBoxDataLink }

constructor TPrismDBCheckBox.TPrismDBCheckBoxDataLink.Create(
  APrismDBCheckBox: TPrismDBCheckBox);
begin
 inherited Create;

 FPrismDBCheckBox:= APrismDBCheckBox;
 FDataActive:= false;
end;

procedure TPrismDBCheckBox.TPrismDBCheckBoxDataLink.DataEvent(Event: TDataEvent;
  Info: NativeInt);
begin
 inherited;

 if Event in [deUpdateState] then
 if ((Event in [deUpdateState]) and DataSet.Active and FDataActive <> DataSet.Active) then
 begin
  FPrismDBCheckBox.UpdateData;
 end;

 FDataActive := DataSet.Active;

 if Event in [deFocusControl] then
 begin
  FPrismDBCheckBox.SetFocus;
  Control:= FPrismDBCheckBox.VCLComponent;
  Exit;
 end;
end;
{$ELSE}
implementation
{$ENDIF}

end.
