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

unit Prism.Combobox;

interface

uses
  System.Classes, System.JSON, System.SysUtils,
  Prism.Forms.Controls, Prism.Interfaces, Prism.Types;


type
 TPrismCombobox = class(TPrismControl, IPrismCombobox)
  private
   FStoredSelectedItem: String;
   FStoredItems: TStrings;
   FProcGetItems: TOnGetStrings;
   FProcSetSelectedItem: TOnSetValue;
   FProcGetSelectedItem: TOnGetValue;
   procedure SetSelectedItem(AText: String);
   function GetSelectedItem: String;
   function GetItems: TStrings;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsCombobox: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   property Items: TStrings read GetItems;
   property SelectedItem: String read GetSelectedItem write SetSelectedItem;

   property ProcGetItems: TOnGetStrings read FProcGetItems write FProcGetItems;
   property ProcGetSelectedItem: TOnGetValue read FProcGetSelectedItem write FProcGetSelectedItem;
   property ProcSetSelectedItem: TOnSetValue read FProcSetSelectedItem write FProcSetSelectedItem;
 end;



implementation

uses
  Prism.Util, System.StrUtils;

{ TPrismButton }

constructor TPrismCombobox.Create(AOwner: TComponent);
begin
 inherited;
 FStoredItems:= TStringList.Create;
end;

destructor TPrismCombobox.Destroy;
begin
 FreeAndNil(FStoredItems);

 inherited;
end;

function TPrismCombobox.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismCombobox.GetItems: TStrings;
begin
 if Assigned(ProcGetItems) then
 begin
  Result:= ProcGetItems;
 end else
 Result:= FStoredItems;
end;

function TPrismCombobox.GetSelectedItem: String;
begin
 if Assigned(ProcGetSelectedItem) then
 Result:= ProcGetSelectedItem
 else
 Result:= FStoredSelectedItem;

end;

procedure TPrismCombobox.Initialize;
begin
 inherited;

 FStoredSelectedItem:= GetSelectedItem;
 FStoredItems.CommaText:= GetItems.CommaText;

end;

function TPrismCombobox.IsCombobox: Boolean;
begin
 result:= true;
end;

procedure TPrismCombobox.ProcessComponentState(
  const ComponentStateInfo: TJSONObject);
  var
 Selectindex: Integer;
begin
 inherited;

 if (ComponentStateInfo.GetValue('selecteditemindex') <> nil) then
 begin
  TryStrToInt(ComponentStateInfo.GetValue('selecteditemindex').Value, Selectindex);

  if (Selectindex >= 1) and (Selectindex <= Items.Count) then
   SelectedItem:= Items[Selectindex-1]
  else
   SelectedItem:= '';
 end;
end;

procedure TPrismCombobox.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismCombobox.ProcessHTML;
var
 I: Integer;
begin
 inherited;


 HTMLControl := '<select ';
 HTMLControl := HTMLControl + ' ' + HTMLCore + ' aria-label="' + ifThen(Placeholder = '', Form.Session.LangNav.Combobox.Select, Placeholder) + '" ';
 HTMLControl := HTMLControl + '>';
 if FStoredSelectedItem = '' then
 HTMLControl := HTMLControl + '<option hidden disabled selected value>' + ifThen(Placeholder = '', Form.Session.LangNav.Combobox.Select, Placeholder) + '</option>';

 //Itens
 for I := 0 to FStoredItems.Count-1 do
 if SameText(FStoredItems[I],FStoredSelectedItem) then
  HTMLControl := HTMLControl + '<option selected value="'+ IntToStr(I+1) + '">' + FStoredItems[I] + '</option>'
 else
  HTMLControl := HTMLControl + '<option value="'+ IntToStr(I+1) + '">' + FStoredItems[I] + '</option>';

 HTMLControl := HTMLControl + '</select>';
end;


procedure TPrismCombobox.SetSelectedItem(AText: String);
begin
 if Assigned(ProcSetSelectedItem) then
 if FStoredSelectedItem <> AText then
 ProcSetSelectedItem(AText);

 FStoredSelectedItem:= AText;
end;


procedure TPrismCombobox.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
var
 NewSelectedItem: string;
 NewItems: TStrings;
begin
 inherited;

 NewSelectedItem:= SelectedItem;
 if (FStoredSelectedItem <> NewSelectedItem) or (AForceUpdate) then
 begin
  FStoredSelectedItem := NewSelectedItem;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").value = '+ FormatValueHTML(IntToStr(Items.IndexOf(SelectedItem)+1)) +';');
 end;

 NewItems:= Items;
 if (FStoredItems.CommaText <> NewItems.CommaText) or (AForceUpdate) then
 begin
  FStoredItems.CommaText := NewItems.CommaText;
  ProcessHTML;
  ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").outerHTML = '+ FormatValueHTML(HTMLControl) +';');
 end;
end;

end.
