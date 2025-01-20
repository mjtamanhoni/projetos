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

unit Prism.CheckBox;

interface

uses
  System.Classes, System.SysUtils, System.JSON, System.Rtti,
  Prism.Forms.Controls, Prism.Interfaces, Prism.Types;


type
 TCheckBoxType = Prism.Types.TCheckBoxType;


type
 TPrismCheckBox = class(TPrismControl, IPrismCheckBox)
  private
   FStoredChecked: Boolean;
   FStoredText: String;
   FProcGetText: TOnGetValue;
   FProcGetChecked: TOnGetValue;
   FProcSetChecked: TOnSetValue;
   FCheckBoxType: TCheckBoxType;
   procedure SetCheckBoxType(ACheckBoxType: TCheckBoxType);
   function GetCheckBoxType: TCheckBoxType;
   function GetText: String;
   procedure SetChecked(AValue: Boolean);
   function GetChecked: Boolean;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsCheckBox: Boolean; override;
   function NeedCheckValidation: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;

   property Text: String read GetText;
   property Checked: Boolean read GetChecked write SetChecked;
   property CheckBoxType: TCheckBoxType read GetCheckBoxType write SetCheckBoxType;
   property ProcGetText: TOnGetValue read FProcGetText write FProcGetText;
   property ProcGetChecked: TOnGetValue read FProcGetChecked write FProcGetChecked;
   property ProcSetChecked: TOnSetValue read FProcSetChecked write FProcSetChecked;
 end;



implementation

uses
  Prism.Util;

{ TPrismButton }

constructor TPrismCheckBox.Create(AOwner: TComponent);
begin
 inherited;

 FCheckBoxType:= CBSwitchType;;
end;

function TPrismCheckBox.GetCheckBoxType: TCheckBoxType;
begin
 Result:= FCheckBoxType;
end;

function TPrismCheckBox.GetChecked: Boolean;
begin
 if Assigned(ProcGetChecked) then
  Result:= ProcGetChecked;
end;

function TPrismCheckBox.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismCheckBox.GetText: String;
begin
 if Assigned(ProcGetText) then
  Result:= ProcGetText;
end;

procedure TPrismCheckBox.Initialize;
begin
 inherited;

 FStoredText:= Text;
 FStoredChecked:= Checked;
end;

function TPrismCheckBox.IsCheckBox: Boolean;
begin
 Result:= true;
end;

function TPrismCheckBox.NeedCheckValidation: Boolean;
begin
 Result:= true;
end;

procedure TPrismCheckBox.ProcessComponentState(
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
   Checked:= NewChecked;
  end;
 end;
end;

procedure TPrismCheckBox.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismCheckBox.ProcessHTML;
var
 vChecked: string;
begin
 inherited;

 if Checked then
 vChecked:= 'checked'
 else
 vChecked:= '';

 HTMLControl := '<div class="d2bridgeswtich form-check form-switch">' + sLineBreak;
 HTMLControl := HTMLControl + '<input ' + HTMLCore +' type="checkbox" role="switch" '+ vChecked +'>' + sLineBreak;
 HTMLControl := HTMLControl + '<label class="form-check-label" for="' + AnsiUpperCase(NamePrefix) + '">' + Text + '</label>' + sLineBreak;
 HTMLControl := HTMLControl + '</div>';
end;


procedure TPrismCheckBox.SetCheckBoxType(ACheckBoxType: TCheckBoxType);
begin
 FCheckBoxType:= ACheckBoxType;
end;

procedure TPrismCheckBox.SetChecked(AValue: Boolean);
begin
 if Assigned(ProcSetChecked) then
 begin
  if FStoredChecked <> AValue then
   Form.Session.ExecThread(false,
    procedure(AAValue: TValue)
    begin
     ProcSetChecked(AAValue.AsBoolean);
     FStoredChecked:= AAValue.AsBoolean;
    end,
    AValue
   );
 end else
  FStoredChecked:= AValue;
end;

procedure TPrismCheckBox.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
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

end.
