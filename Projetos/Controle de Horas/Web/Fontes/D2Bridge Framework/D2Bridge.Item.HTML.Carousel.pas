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

unit D2Bridge.Item.HTML.Carousel;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.StrUtils,
  Prism.Interfaces,
  D2Bridge.Item, D2Bridge.BaseClass, D2Bridge.Item.VCLObj, D2Bridge.Interfaces,
  Data.DB;

type
  TD2BridgeItemHTMLCarousel = class(TD2BridgeItem, ID2BridgeItemHTMLCarousel)
   //events
   procedure BeginReader;
   procedure EndReader;
  private
   FD2BridgeItem: TD2BridgeItem;
{$IFNDEF FMX}
   procedure SetDataSource(const Value: TDataSource);
   function GetDataSource: TDataSource;
   procedure SetDataFieldImagePath(AValue: String);
   function GetDataFieldImagePath: String;
{$ENDIF}
   function GetAutoSlide: boolean;
   procedure SetAutoSlide(Value: boolean);
   function GetInterval: integer;
   procedure SetInterval(Value: integer);
   function GetShowButtons: boolean;
   procedure SetShowButtons(Value: boolean);
   function GetShowIndicator: boolean;
   procedure SetShowIndicator(Value: boolean);
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;

   function PrismCarousel: IPrismCarousel;
   function Control: IPrismCarousel;

   function ImageFiles: TList<string>;

   procedure PreProcess;
   procedure Render;
   procedure RenderHTML;

   property BaseClass;

   property AutoSlide: boolean read GetAutoSlide write SetAutoSlide;
   property ShowButtons: boolean read GetShowButtons write SetShowButtons;
   property ShowIndicator: boolean read GetShowIndicator write SetShowIndicator;
   property Interval: integer read GetInterval write SetInterval;
{$IFNDEF FMX}
   property DataSource: TDataSource read GetDataSource write SetDataSource;
   property DataFieldImagePath: String read GetDataFieldImagePath write SetDataFieldImagePath;
{$ENDIF}
  end;

implementation

uses
  Prism.Carousel, Prism.Forms, D2Bridge.Util;

{ TD2BridgeItemHTMLCarousel }

function TD2BridgeItemHTMLCarousel.Control: IPrismCarousel;
begin
 result:= PrismCarousel;
end;

constructor TD2BridgeItemHTMLCarousel.Create(AOwner: TD2BridgeClass);
begin
 FD2BridgeItem:= Inherited Create(AOwner);

 PrismControl := TPrismCarousel.Create(nil);
 PrismControl.Name:= ITemID;
 AOwner.PrismControlToRegister.Add(PrismControl);

 FD2BridgeItem.OnBeginReader:= BeginReader;
 FD2BridgeItem.OnEndReader:= EndReader;
end;

destructor TD2BridgeItemHTMLCarousel.Destroy;
begin
 if Assigned(PrismControl) then
 begin
  TPrismCarousel(PrismControl).Destroy;
 end;

 inherited;
end;


procedure TD2BridgeItemHTMLCarousel.BeginReader;
begin
 TPrismForm(BaseClass.Form).AddControl(PrismControl);
end;

procedure TD2BridgeItemHTMLCarousel.EndReader;
begin

end;

function TD2BridgeItemHTMLCarousel.GetAutoSlide: boolean;
begin
 result:= PrismCarousel.AutoSlide;
end;

{$IFNDEF FMX}
function TD2BridgeItemHTMLCarousel.GetDataFieldImagePath: String;
begin
 result:= PrismCarousel.DataFieldImagePath;
end;

function TD2BridgeItemHTMLCarousel.GetDataSource: TDataSource;
begin
 result:= PrismCarousel.DataSource;
end;
{$ENDIF}

function TD2BridgeItemHTMLCarousel.GetInterval: integer;
begin
 result:= PrismCarousel.Interval;
end;

function TD2BridgeItemHTMLCarousel.GetShowButtons: boolean;
begin
 result:= PrismCarousel.ShowButtons;
end;

function TD2BridgeItemHTMLCarousel.GetShowIndicator: boolean;
begin
 result:= PrismCarousel.ShowIndicator;
end;

function TD2BridgeItemHTMLCarousel.ImageFiles: TList<string>;
begin
 result:= PrismCarousel.ImageFiles;
end;

procedure TD2BridgeItemHTMLCarousel.PreProcess;
begin

end;

function TD2BridgeItemHTMLCarousel.PrismCarousel: IPrismCarousel;
begin
 result:= GetPrismControl as IPrismCarousel;
end;

procedure TD2BridgeItemHTMLCarousel.Render;
var
 I: integer;
begin
 BaseClass.HTML.Render.Body.Add('{%'+TrataHTMLTag(ItemPrefixID+' class="d2bridgecarousel carousel slide '+Trim(CSSClasses)+'" style="'+GetHTMLStyle+'" '+ GetHTMLExtras) + '%}');
end;

procedure TD2BridgeItemHTMLCarousel.RenderHTML;
begin

end;


procedure TD2BridgeItemHTMLCarousel.SetAutoSlide(Value: boolean);
begin
 PrismCarousel.AutoSlide:= Value;
end;

{$IFNDEF FMX}
procedure TD2BridgeItemHTMLCarousel.SetDataFieldImagePath(AValue: String);
begin
 PrismCarousel.DataFieldImagePath:= AValue;
end;

procedure TD2BridgeItemHTMLCarousel.SetDataSource(const Value: TDataSource);
begin
 PrismCarousel.DataSource:= Value;
end;
{$ENDIF}

procedure TD2BridgeItemHTMLCarousel.SetInterval(Value: integer);
begin
 PrismCarousel.Interval:= Value;
end;

procedure TD2BridgeItemHTMLCarousel.SetShowButtons(Value: boolean);
begin
 PrismCarousel.ShowButtons:= Value;
end;

procedure TD2BridgeItemHTMLCarousel.SetShowIndicator(Value: boolean);
begin
 PrismCarousel.ShowIndicator:= Value;
end;

end.
