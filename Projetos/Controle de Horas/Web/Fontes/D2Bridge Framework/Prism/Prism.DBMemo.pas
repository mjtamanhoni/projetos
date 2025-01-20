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

unit Prism.DBMemo;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.JSON, System.SysUtils, Data.DB,
  Vcl.DBCtrls,
  Prism.Interfaces, Prism.Forms.Controls, Prism.Types, Prism.DataWare.Field;

type
 TPrismDBMemo = class(TPrismControl, IPrismDBMemo)
  private
   FDataWareField: TPrismDataWareField;
   FRefreshData: Boolean;
   FStoredText: String;
   FRows: Integer;
   procedure UpdateData; override;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsDBMemo: Boolean; override;
   function GetReadOnly: Boolean; override;
   procedure SetRows(ARows: Integer);
   function GetRows: Integer;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   function DataWare: TPrismDataWareField;
 end;


implementation

uses
  Prism.Util;

{ TPrismDBMemo }

constructor TPrismDBMemo.Create(AOwner: TComponent);
begin
 inherited;

 FRefreshData:= false;
 FDataWareField:= TPrismDataWareField.Create(Self);
 FDataWareField.UseHTMLFormatSettings:= false;
 FRows  := 3;
end;

function TPrismDBMemo.DataWare: TPrismDataWareField;
begin
 result:= FDataWareField;
end;

destructor TPrismDBMemo.Destroy;
begin
 FreeAndNil(FDataWareField);

 inherited;
end;

function TPrismDBMemo.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismDBMemo.GetReadOnly: Boolean;
begin
 result:= Inherited;

 if not result then
  result:= FDataWareField.ReadOnly;
end;

function TPrismDBMemo.GetRows: Integer;
begin
  Result := FRows;
end;

procedure TPrismDBMemo.Initialize;
begin
 inherited;

 FStoredText:= DataWare.FieldText;
end;

function TPrismDBMemo.IsDBMemo: Boolean;
begin
 Result:= true;
end;

procedure TPrismDBMemo.ProcessComponentState(const ComponentStateInfo: TJSONObject);
var
 vText: string;
begin
 inherited;

 if (ComponentStateInfo.GetValue('text') <> nil) then
 begin
  vText:= ComponentStateInfo.GetValue('text').Value;

  if vText <> FStoredText then
  begin
   DataWare.FieldValue:= vText;

   FStoredText:= DataWare.FieldText;
  end;
 end;
end;

procedure TPrismDBMemo.ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings);
begin
 inherited;

end;

procedure TPrismDBMemo.ProcessHTML;
begin
 inherited;

 HTMLControl := '<textarea ';
 HTMLControl := HTMLControl + ' ' + HTMLCore;
 HTMLControl := HTMLControl + Format(' rows="%d"', [FRows]);
 HTMLControl := HTMLControl + '>';
 HTMLControl := HTMLControl + DataWare.FieldText;
 HTMLControl := HTMLControl + '</textarea>';
end;

procedure TPrismDBMemo.SetRows(ARows: Integer);
begin
 FRows := ARows;
end;

procedure TPrismDBMemo.UpdateData;
begin
 if (Form.FormPageState = PageStateLoaded) and (not Form.ComponentsUpdating) then
 FRefreshData:= true;
end;

procedure TPrismDBMemo.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewText: string;
begin
 inherited;

 NewText:= DataWare.FieldText;
 if (FStoredText <> NewText) or (AForceUpdate) then
 begin
  FStoredText := NewText;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").value = '+ FormatValueHTML(FStoredText) +';');
 end;

end;

{$ELSE}
implementation
{$ENDIF}

end.
