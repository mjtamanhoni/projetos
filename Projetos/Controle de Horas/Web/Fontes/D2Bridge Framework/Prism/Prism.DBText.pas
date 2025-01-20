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

unit Prism.DBText;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.JSON, System.SysUtils, Data.DB,
  Vcl.DBCtrls,
  Prism.Interfaces, Prism.Forms.Controls, Prism.Types, Prism.DataWare.Field;

type
 TPrismDBText = class(TPrismControl, IPrismDBText)
  private
   FRefreshData: Boolean;
   FStoredText: string;
   FDataType: TPrismFieldType;
   FDataWareField: TPrismDataWareField;
   procedure UpdateData; override;
   procedure SetDataType(Value: TPrismFieldType);
   function GetDataType: TPrismFieldType;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsDBText: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   function DataWare: TPrismDataWareField;

   property DataType: TPrismFieldType read GetDataType write SetDataType;
 end;


implementation

uses
  Prism.Util;

{ TPrismDBText }

constructor TPrismDBText.Create(AOwner: TComponent);
begin
 inherited;

 FDataType:= PrismFieldTypeAuto;
 FRefreshData:= false;
 FDataWareField:= TPrismDataWareField.Create(Self);
 FDataWareField.UseHTMLFormatSettings:= true;
end;

function TPrismDBText.DataWare: TPrismDataWareField;
begin
 result:= FDataWareField;
end;

destructor TPrismDBText.Destroy;
begin
 FreeAndNil(FDataWareField);

 inherited;
end;

function TPrismDBText.GetDataType: TPrismFieldType;
begin
 result:= FDataType;
end;

function TPrismDBText.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

procedure TPrismDBText.Initialize;
begin
 inherited;

 FStoredText:= FDataWareField.FieldText;
end;

function TPrismDBText.IsDBText: Boolean;
begin
 Result:= true;
end;

procedure TPrismDBText.ProcessComponentState(
  const ComponentStateInfo: TJSONObject);
begin
 inherited;

end;

procedure TPrismDBText.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismDBText.ProcessHTML;
begin
 inherited;

 HTMLControl := '<span';
 HTMLControl := HTMLControl + ' ' + HTMLCore;
 HTMLControl := HTMLControl + '>';
 HTMLControl := HTMLControl + FormatTextHTML(FDataWareField.ValueHTMLElement);  //FStoredText;
 HTMLControl := HTMLControl + '</span>';
end;


procedure TPrismDBText.SetDataType(Value: TPrismFieldType);
begin
 FDataType:= Value;
end;

procedure TPrismDBText.UpdateData;
begin
 if (Form.FormPageState = PageStateLoaded) and (not Form.ComponentsUpdating) then
 FRefreshData:= true;
end;

procedure TPrismDBText.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewText: string;
begin
 inherited;

 NewText:= FDataWareField.FieldText;
 if (FStoredText <> NewText) or (AForceUpdate) then
 begin
  FStoredText:= NewText;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").value = "'+ FDataWareField.ValueHTMLElement +'";');
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").textContent = "'+ FDataWareField.ValueHTMLElement +'";');
 end;

end;

{$ELSE}
implementation
{$ENDIF}

end.
