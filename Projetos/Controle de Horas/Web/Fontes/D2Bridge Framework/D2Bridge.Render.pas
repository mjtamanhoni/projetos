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

{$I D2Bridge.inc}

unit D2Bridge.Render;

interface

uses
  System.Classes, System.Generics.Collections,
  D2Bridge.Interfaces;


type
 TD2BridgeRender = class
 private
  BaseClass: TObject;
 public
  //procedure RenderD2Bridge(Itens: TList<TD2BridgeItem>); //overload;
  procedure RenderD2Bridge(Itens: TList<ID2BridgeItem>); //overload;
  constructor Create(AOwner: TObject);
 end;



implementation

uses
  System.TypInfo, System.Rtti, System.StrUtils, System.SysUtils,
  D2Bridge.BaseClass, D2Bridge.Item.HTML.Row, D2Bridge.Item, Prism.Forms, Prism.ControlGeneric,
  System.RegularExpressions, D2Bridge.Forms;

{ TD2BridgeRender }


constructor TD2BridgeRender.Create(AOwner: TObject);
begin
 BaseClass:= AOwner;
end;



//procedure TD2BridgeRender.RenderD2Bridge(Itens: TList<TD2BridgeItem>);
//var
// D2BridgeItem: ID2BridgeItem;
//begin
// for var I := 0 to Itens.Count -1 do
// begin
//  //Itens[i].Render;
//  Itens[i].GetInterface(ID2BridgeItem, D2BridgeItem);
//
//  if Assigned(Itens[i].OnBeginReader) then
//  begin
//   Itens[i].OnBeginReader;
//  end;
//
//  D2BridgeItem.PreProcess;
//  D2BridgeItem.RenderHTML;
//  D2BridgeItem.Render;
//
//  if Assigned(Itens[i].OnEndReader) then
//  begin
//   Itens[i].OnEndReader;
//  end;
//
// end;
//
//end;



procedure TD2BridgeRender.RenderD2Bridge(Itens: TList<ID2BridgeItem>);
var
 HTMLLineInit, HTMLLineEnd: Integer;
 HTMLControlText: TStringList;
 Regex: TRegEx;
 Match: TMatch;
 I, X: Integer;
begin
 Regex := TRegEx.Create('display\s*:\s*none;?', [roIgnoreCase, roMultiLine]);

 for I := 0 to Itens.Count -1 do
 begin
  HTMLLineInit:= TD2BridgeClass(BaseClass).HTML.Render.Body.Count;

  if (Assigned(Itens[I].PrismControl)) then
  begin
   TD2BridgeForm(TD2BridgeClass(BaseClass).FormAOwner).DoBeginRenderPrismControl(TPrismControl(Itens[I].PrismControl));

   {$REGION 'Visible'}
    Match := Regex.Match(Itens[I].HTMLStyle);

    if (Itens[I].PrismControl.Visible) and (Match.Success) then
    begin
     Itens[I].HTMLStyle:= StringReplace(Itens[I].HTMLStyle, Match.Value, '', [rfReplaceAll]);
    end else
    if (not Itens[I].PrismControl.Visible) and (not Match.Success) then
    begin
     Itens[I].HTMLStyle:= Trim(Itens[I].HTMLStyle + ' display: none;');
    end;
   {$ENDREGION}
  end;


  Itens[I].DoBeginReader;
  Itens[I].PreProcess;
  Itens[I].RenderHTML;
  Itens[I].Render;
  Itens[I].DoEndReader;

  Itens[I].Renderized:= true;

  HTMLLineEnd:= TD2BridgeClass(BaseClass).HTML.Render.Body.Count;

  if HTMLLineEnd > HTMLLineInit then
  begin
   HTMLControlText:= TStringList.Create;

   try
    HTMLControlText.LineBreak:= '';
    for X := HTMLLineInit to HTMLLineEnd-1 do
    HTMLControlText.Add(TD2BridgeClass(BaseClass).HTML.Render.Body.Strings[X]);

    TD2BridgeClass(BaseClass).HTML.Render.AddHTMLControls(Itens[I].ItemID, Itens[I].ItemPrefixID, HTMLControlText.Text);
   except
   end;

//   if Assigned(Itens[I].PrismControl) and Itens[I].PrismControl.IsControl then
//    Itens[I].PrismControl.FormatHTMLControl(HTMLControlText.Text);

   if Assigned(Itens[I].Owner) then
   begin
    {$IF CompilerVersion >= 34} // Delphi 10.4 Sydney or Upper
     Itens[I].Owner.HTMLItems.AddPair(Itens[I].ItemID, HTMLControlText.Text);
    {$ELSE}
     Itens[I].Owner.HTMLItems.Add(Itens[I].ItemID + Itens[I].Owner.HTMLItems.NameValueSeparator + HTMLControlText.Text);
    {$ENDIF}
   end;

   HTMLControlText.Free;

   if (Supports(Itens[I], ID2BridgeItemVCLObj)) and
      (((Itens[I] as ID2BridgeItemVCLObj).Hidden) or (Assigned(Itens[I].Owner))) then
    for X := HTMLLineInit to HTMLLineEnd-1 do
    begin
     TD2BridgeClass(BaseClass).HTML.Render.Body.Delete(HTMLLineInit);
    end;
  end;

 end;

end;

end.

