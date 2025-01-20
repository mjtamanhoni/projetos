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

unit D2Bridge.Item.HTML.Card.Group;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
{$IFDEF FMX}
{$ELSE}
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Graphics,
{$ENDIF}
  Prism.Interfaces,
  D2Bridge.ItemCommon, D2Bridge.Types, D2Bridge.Item, D2Bridge.BaseClass, D2Bridge.Item.VCLObj,
  D2Bridge.Interfaces;

type
  TD2BridgeItemHTMLCardGroup = class(TD2BridgeItem, ID2BridgeItemHTMLCardGroup)
   //events
   procedure BeginReader;
   procedure EndReader;
  private
   FD2BridgeItem: TD2BridgeItem;
   FD2BridgeItems : TD2BridgeItems;
   FColSize: string;
   FMarginCardsSize: string;
   procedure SetColSize(AColSize: string);
   function GetColSize: string;
   procedure SetMarginCardsSize(AValue: string);
   function GetMarginCardsSize: string;
   procedure OnGetCSSClassCads(const AD2BridgeItem: TD2BridgeItem; var Value: string);
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;

   procedure PreProcess;
   procedure Render;
   procedure RenderHTML;

   function AddCard(ATitle: string = ''; AText: string = ''; AItemID: string = ''; ACSSClass: String = ''; AHTMLExtras: String = ''; AHTMLStyle: String = ''): ID2BridgeItemHTMLCard; overload;

   property ColSize: string read GetColSize write SetColSize;
   property MarginCardsSize: string read GetMarginCardsSize write SetMarginCardsSize;
   property BaseClass;
  end;

implementation

uses
  D2Bridge.Item.HTML.Card;

{ TD2BridgeItemHTMLCardGroup }

constructor TD2BridgeItemHTMLCardGroup.Create(AOwner: TD2BridgeClass);
begin
 FD2BridgeItem:= Inherited Create(AOwner);

 FD2BridgeItems:= TD2BridgeItems.Create(AOwner);

 FD2BridgeItem.OnBeginReader:= BeginReader;
 FD2BridgeItem.OnEndReader:= EndReader;
end;

destructor TD2BridgeItemHTMLCardGroup.Destroy;
begin
 FreeAndNil(FD2BridgeItems);

 inherited;
end;


function TD2BridgeItemHTMLCardGroup.AddCard(ATitle, AText, AItemID, ACSSClass, AHTMLExtras, AHTMLStyle: String): ID2BridgeItemHTMLCard;
begin
 Result:= FD2BridgeItems.Add.Card(ATitle, '', AText, AItemID, ACSSClass, AHTMLExtras, AHTMLStyle);
 TD2BridgeItemHTMLCard(result).OnGetCSSClass:= OnGetCSSClassCads;
end;

procedure TD2BridgeItemHTMLCardGroup.BeginReader;
begin

end;

procedure TD2BridgeItemHTMLCardGroup.EndReader;
begin

end;

function TD2BridgeItemHTMLCardGroup.GetColSize: string;
begin
 Result:= FColSize;
end;

function TD2BridgeItemHTMLCardGroup.GetMarginCardsSize: string;
begin
 Result:= FMarginCardsSize;
end;

procedure TD2BridgeItemHTMLCardGroup.OnGetCSSClassCads(const AD2BridgeItem: TD2BridgeItem; var Value: string);
begin
 Value:= Value + FMarginCardsSize;
end;

procedure TD2BridgeItemHTMLCardGroup.PreProcess;
begin

end;

procedure TD2BridgeItemHTMLCardGroup.Render;
begin
 with BaseClass.HTML.Render.Body do
  Add('<div id="'+AnsiUpperCase(ItemPrefixID)+'" class="d2bridgecardgroup card-group ' + CSSClasses + ' '+ FColSize +'" style="'+ HtmlStyle +'" '+ HtmlExtras +'>');

 if FD2BridgeItems.Items.Count > 0 then
  BaseClass.RenderD2Bridge(FD2BridgeItems.Items);

 with BaseClass.HTML.Render.Body do
  Add('</div>');
end;

procedure TD2BridgeItemHTMLCardGroup.RenderHTML;
begin

end;


procedure TD2BridgeItemHTMLCardGroup.SetColSize(AColSize: string);
begin
 FColSize:= AColSize;
end;

procedure TD2BridgeItemHTMLCardGroup.SetMarginCardsSize(AValue: string);
begin
 FMarginCardsSize:= AValue;
end;

end.
