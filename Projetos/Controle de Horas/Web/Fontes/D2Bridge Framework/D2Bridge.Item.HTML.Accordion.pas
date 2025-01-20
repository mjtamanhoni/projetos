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

unit D2Bridge.Item.HTML.Accordion;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  Prism.Interfaces,
  D2Bridge.Item, D2Bridge.BaseClass, D2Bridge.Item.VCLObj, D2Bridge.ItemCommon, D2Bridge.Interfaces;

type
  TD2BridgeItemHTMLAccordion = class(TD2BridgeItem, ID2BridgeItemHTMLAccordion)
   //events
   procedure BeginReader;
   procedure EndReader;
  strict private
   type
    TD2BridgeItemHTMLAccordionItem = class(TInterfacedPersistent, ID2BridgeItemHTMLAccordionItem)
    private
     FD2BridgeItemHTMLAccordion: TD2BridgeItemHTMLAccordion;
     FD2BridgeItems : TD2BridgeItems;
     FTitle: String;
     function GetTitle: string;
     procedure SetTitle(ATitle: string);
    public
     constructor Create(D2BridgeItemHTMLAccordion: TD2BridgeItemHTMLAccordion);
     destructor Destroy; override;
     Function Items: ID2BridgeAddItems;
     property Title: string read GetTitle write SetTitle;
   end;

  private
   FD2BridgeItem: TD2BridgeItem;
   FAccordionItems: TList<ID2BridgeItemHTMLAccordionItem>;
   FColSize: String;
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;

   procedure PreProcess; override;
   procedure Render; override;
   procedure RenderHTML; override;

   //ID2BridgeItemHTMLAccordion
   function GetAccordionItems: TList<ID2BridgeItemHTMLAccordionItem>;
   procedure SetColSize(AColSize: string);
   function GetColSize: string;
   function AddAccordionItem: ID2BridgeItemHTMLAccordionItem; overload;
   function AddAccordionItem(ATitle: String): ID2BridgeItemHTMLAccordionItem; overload;
   procedure AddAccordionItem(Item: ID2BridgeItemHTMLAccordionItem); overload;

   property BaseClass;
   property AccordionItems: TList<ID2BridgeItemHTMLAccordionItem> read GetAccordionItems;
   property ColSize: string read GetColSize write SetColSize;
  end;

implementation

uses
  D2Bridge.Util, Prism.ControlGeneric;

{ TD2BridgeItemHTMLAccordion }

constructor TD2BridgeItemHTMLAccordion.Create(AOwner: TD2BridgeClass);
begin
 FD2BridgeItem:= Inherited Create(AOwner);

 FAccordionItems:= TList<ID2BridgeItemHTMLAccordionItem>.Create;

 FD2BridgeItem.OnBeginReader:= BeginReader;
 FD2BridgeItem.OnEndReader:= EndReader;

 PrismControl:= TPrismControlGeneric.Create(nil);
end;

destructor TD2BridgeItemHTMLAccordion.Destroy;
begin
 FreeAndNil(FAccordionItems);

 inherited;
end;


function TD2BridgeItemHTMLAccordion.GetAccordionItems: TList<ID2BridgeItemHTMLAccordionItem>;
begin
 Result:= FAccordionItems;
end;

function TD2BridgeItemHTMLAccordion.GetColSize: string;
begin
 Result:= FColSize;
end;

function TD2BridgeItemHTMLAccordion.AddAccordionItem: ID2BridgeItemHTMLAccordionItem;
begin
 Result:= TD2BridgeItemHTMLAccordionItem.Create(self);
 FAccordionItems.Add(Result);
end;

function TD2BridgeItemHTMLAccordion.AddAccordionItem(
  ATitle: String): ID2BridgeItemHTMLAccordionItem;
begin
 Result:= AddAccordionItem;
 Result.Title:= ATitle;
end;

procedure TD2BridgeItemHTMLAccordion.AddAccordionItem(
  Item: ID2BridgeItemHTMLAccordionItem);
begin
 FAccordionItems.Add(Item);
end;

procedure TD2BridgeItemHTMLAccordion.BeginReader;
begin
 with BaseClass.HTML.Render.Body do
 begin
  Add('<div class="d2bridgeaccordion '+ColSize+' mb-4" id="'+AnsiUpperCase(ItemPrefixID)+'">');
  Add('<div class="accordion">');
 end;
end;

procedure TD2BridgeItemHTMLAccordion.EndReader;
begin
 with BaseClass.HTML.Render.Body do
 begin
  Add('</div>');
  Add('</div>');
 end;
end;

procedure TD2BridgeItemHTMLAccordion.PreProcess;
begin

end;

procedure TD2BridgeItemHTMLAccordion.Render;
var
 I: Integer;
 StringRand: String;
begin
 if AccordionItems.Count > 0 then
 begin
  StringRand:= GenerateRandomString(4);

  for I := 0 to AccordionItems.Count -1 do
  begin
   with BaseClass.HTML.Render.Body do
   begin
    Add('<div class="accordion-item mt-2 mb-2">');
    Add('<h2 class="accordion-header" id="panelsStayOpen-heading'+StringRand+IntToStr(I)+'">');
    Add('<button class="accordion-button p-2 collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse'+StringRand+IntToStr(I)+'" aria-expanded="false" aria-controls="panelsStayOpen-collapse'+StringRand+IntToStr(I)+'">');
    Add(AccordionItems[I].Title);
    Add('</button>');
    Add('</h2>');
    Add('<div id="panelsStayOpen-collapse'+StringRand+IntToStr(I)+'" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-heading'+StringRand+IntToStr(I)+'">');
    Add('<div class="accordion-body">');
    //Processa Items
    Add('<div class="m-2">');
    BaseClass.RenderD2Bridge(AccordionItems[I].Items.Items);
    Add('</div>');
    Add('</div>');
    Add('</div>');
    Add('</div>');
   end;
  end;

 end;
end;

procedure TD2BridgeItemHTMLAccordion.RenderHTML;
begin

end;

procedure TD2BridgeItemHTMLAccordion.SetColSize(AColSize: string);
begin
 FColSize:= AColSize;
end;

{ TD2BridgeItemHTMLAccordion.TD2BridgeItemHTMLAccordionItem }

constructor TD2BridgeItemHTMLAccordion.TD2BridgeItemHTMLAccordionItem.Create(
  D2BridgeItemHTMLAccordion: TD2BridgeItemHTMLAccordion);
begin
 FD2BridgeItemHTMLAccordion:= D2BridgeItemHTMLAccordion;

 FD2BridgeItems:= TD2BridgeItems.Create(D2BridgeItemHTMLAccordion.BaseClass);
end;

destructor TD2BridgeItemHTMLAccordion.TD2BridgeItemHTMLAccordionItem.Destroy;
begin
  FreeAndNil(FD2BridgeItems);

  inherited;
end;

function TD2BridgeItemHTMLAccordion.TD2BridgeItemHTMLAccordionItem.GetTitle: string;
begin
 Result:= FTitle;
end;

function TD2BridgeItemHTMLAccordion.TD2BridgeItemHTMLAccordionItem.Items: ID2BridgeAddItems;
begin
 Result:= FD2BridgeItems;
end;

procedure TD2BridgeItemHTMLAccordion.TD2BridgeItemHTMLAccordionItem.SetTitle(
  ATitle: string);
begin
 FTitle:= ATitle;
end;

end.
