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

unit D2Bridge.Item.HTML.Image;

interface

uses
  System.Classes, System.Generics.Collections,
  {$IFDEF FMX}
   FMX.Objects, FMX.Graphics,
  {$ELSE}
   Vcl.ExtCtrls, Vcl.Graphics,
  {$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Image, D2Bridge.Item, D2Bridge.BaseClass;

type
  TD2BridgeItemHTMLImage = class(TD2BridgeItem, ID2BridgeItemHTMLImage)
   //events
   procedure BeginReader;
   procedure EndReader;
  private
   FImage: TD2BridgeImage;
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;
   //Functions
   procedure PreProcess; override;
   procedure Render; override;
   procedure RenderHTML; override;

   procedure ImageFromLocal(PathFromImage: string);
   procedure ImageFromURL(URLFromImage: string);
   procedure ImageFromTImage(ImageComponent: TImage);

   function DefaultPropertyCopyList: TStringList;
   property BaseClass;
  end;


implementation

uses
  Prism.ControlGeneric;

{ TD2BridgeItemHTMLImage }

constructor TD2BridgeItemHTMLImage.Create(AOwner: TD2BridgeClass);
begin
 Inherited;

 FImage:= TD2BridgeImage.Create;

 OnBeginReader:= BeginReader;
 OnEndReader:= EndReader;

 PrismControl:= TPrismControlGeneric.Create(nil);
end;


function TD2BridgeItemHTMLImage.DefaultPropertyCopyList: TStringList;
begin

end;

destructor TD2BridgeItemHTMLImage.Destroy;
begin
 FImage.Destroy;
 FImage:= nil;

 if Assigned(PrismControl) then
 begin
  TPrismControlGeneric(PrismControl).Destroy;
 end;

 inherited;
end;

procedure TD2BridgeItemHTMLImage.BeginReader;
begin
end;

procedure TD2BridgeItemHTMLImage.EndReader;
begin
end;

procedure TD2BridgeItemHTMLImage.ImageFromLocal(PathFromImage: string);
begin
 FImage.Local:= PathFromImage;
end;

procedure TD2BridgeItemHTMLImage.ImageFromTImage(ImageComponent: TImage);
begin
 FImage.Image:= ImageComponent;
end;

procedure TD2BridgeItemHTMLImage.ImageFromURL(URLFromImage: string);
begin
 FImage.URL:= URLFromImage;
end;

procedure TD2BridgeItemHTMLImage.PreProcess;
begin

end;

procedure TD2BridgeItemHTMLImage.Render;
begin
end;

procedure TD2BridgeItemHTMLImage.RenderHTML;
begin
 BaseClass.HTML.Render.Body.Add('<img class="'+ CSSClasses +'" src="'+ FImage.ImageToSrc +'" style="'+HTMLStyle+'" '+HTMLExtras+'/>');
end;

end.

