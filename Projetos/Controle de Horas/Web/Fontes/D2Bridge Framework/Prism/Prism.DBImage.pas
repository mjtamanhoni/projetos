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

unit Prism.DBImage;

interface

{$IFNDEF FMX}
uses
  System.Classes, System.JSON, System.SysUtils, Data.DB,
  Prism.Interfaces, Prism.Forms.Controls, Prism.Types, Prism.DataWare.Field;

type
 TPrismDBImage = class(TPrismControl, IPrismDBImage)
  private
   FRefreshData: Boolean;
   FStoredText: string;
   FDataWareField: TPrismDataWareField;
   procedure UpdateData; override;
   function ConvertLocalToBase64(AImageLocal: string): string;
   function ImageToSrc: string;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   function DataWare: TPrismDataWareField;
 end;


implementation

uses
  Prism.Util, System.NetEncoding;

{ TPrismDBImage }

function TPrismDBImage.ConvertLocalToBase64(AImageLocal: string): string;
var
  FileStream: TFileStream;
  Output: TStringStream;
begin
 try
  Result := '';
  if not FileExists(AImageLocal) then
    Exit;

  FileStream := TFileStream.Create(AImageLocal, fmOpenRead or fmShareDenyWrite);
  Output := TStringStream.Create;
  try
    TNetEncoding.Base64.Encode(FileStream, Output);
    Output.Position := 0;
    Result := 'data:image/jpeg;base64, '+Output.DataString;
  finally
    FileStream.Free;
    Output.Free;
  end;
 except
 end;
end;

constructor TPrismDBImage.Create(AOwner: TComponent);
begin
 inherited;

 FRefreshData:= false;
 FDataWareField:= TPrismDataWareField.Create(Self);
end;

function TPrismDBImage.DataWare: TPrismDataWareField;
begin
 result:= FDataWareField;
end;

destructor TPrismDBImage.Destroy;
begin
 FreeAndNil(FDataWareField);

 inherited;
end;

function TPrismDBImage.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismDBImage.ImageToSrc: string;
var
 vImagePath: string;
begin
 result:= '';

 vImagePath:= FStoredText;

 if vImagePath <> '' then
 begin
  if (pos('http://', vImagePath) > 0) or (pos('https://', vImagePath) > 0) then
  begin
   result:= vImagePath;
  end else
   result:= ConvertLocalToBase64(vImagePath);
 end;
end;

procedure TPrismDBImage.Initialize;
begin
 inherited;

 FStoredText:= FDataWareField.FieldText;
end;

procedure TPrismDBImage.ProcessComponentState(
  const ComponentStateInfo: TJSONObject);
begin
 inherited;

end;

procedure TPrismDBImage.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismDBImage.ProcessHTML;
begin
 inherited;

// BaseClass.HTML.Render.Body.Add('<img class="'+ CSSClasses +'" src="'+ FImage.ImageToSrc +'" style="'+HTMLStyle+'" '+HTMLExtras+'/>');

// NewText:= FDataWareField.FieldText;

 HTMLControl := '<img';
 HTMLControl := HTMLControl + ' ' + HTMLCore;
 HTMLControl := HTMLControl + ' ' + 'src="'+ ImageToSrc +'"';
 HTMLControl := HTMLControl + '/>';
end;


procedure TPrismDBImage.UpdateData;
begin
 if (Form.FormPageState = PageStateLoaded) and (not Form.ComponentsUpdating) then
 FRefreshData:= true;
end;

procedure TPrismDBImage.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewText: string;
begin
 inherited;

 NewText:= FDataWareField.FieldText;
 if ( FStoredText <> NewText) or (AForceUpdate) then
 begin
  FStoredText:= NewText;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").src = `'+ ImageToSrc +'`;')
 end;
end;

{$ELSE}
implementation
{$ENDIF}

end.
