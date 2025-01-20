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

unit Prism.Button;

interface

uses
  System.Classes, System.JSON,
  Prism, Prism.Interfaces, Prism.Events, Prism.Forms.Controls;


type
 TPrismButton = class(TPrismControl, IPrismButton)
  private
   FCaption: String;
   FPopupHTML: string;
   procedure SetPopupHTML(Value: String);
   function GetPopupHTML: String;
  protected
   procedure SetCaption(ACaption: String);
   function GetCaption: String;
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsButton: Boolean; override;
   function NeedCheckValidation: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;

  published
   property Caption: String read GetCaption write SetCaption;
   property PopupHTML: String read GetPopupHTML write SetPopupHTML;
 end;


implementation

uses
  Prism.Util, System.SysUtils;


{ TPrismButton }

constructor TPrismButton.Create(AOwner: TComponent);
begin
 inherited;

 FCaption:= '';
end;

function TPrismButton.GetCaption: String;
begin
 Result:= FCaption;
end;

function TPrismButton.GetEnableComponentState: Boolean;
begin
 Result:= false;
end;

function TPrismButton.GetPopupHTML: String;
begin
 result:= FPopupHTML;
end;

procedure TPrismButton.Initialize;
begin
  inherited;

end;

function TPrismButton.IsButton: Boolean;
begin
 result:= true;
end;

function TPrismButton.NeedCheckValidation: Boolean;
begin
 Result:= true;
end;

procedure TPrismButton.ProcessComponentState(
  const ComponentStateInfo: TJSONObject);
begin
  inherited;

end;

procedure TPrismButton.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismButton.ProcessHTML;
begin
 inherited;

 HTMLControl:= '';

 if FPopupHTML <> '' then
  HTMLControl:= '<div class="d2bridgedropdown dropdown" id="dropdown' + UpperCase(NamePrefix) + '" for="' + UpperCase(NamePrefix) + '">' + sLineBreak;

 HTMLControl:= HTMLControl + '<button '+ HTMLCore +'>' + StringReplace(Caption, '&', '', [rfReplaceAll]) + '</button>';
 if FPopupHTML <> '' then
  HTMLControl:= HTMLControl + sLineBreak;

 if FPopupHTML <> '' then
 begin
  HTMLControl:= HTMLControl + FPopupHTML;
  HTMLControl:= HTMLControl + '</div>';
 end;
end;


procedure TPrismButton.SetCaption(ACaption: String);
begin
 FCaption:= ACaption;
end;

procedure TPrismButton.SetPopupHTML(Value: String);
begin
 FPopupHTML:= Value;
end;

procedure TPrismButton.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
begin
 inherited;

end;

end.
