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

unit D2Bridge.Item.HTML.QRCode;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  Prism.Interfaces,
  D2Bridge.Item, D2Bridge.BaseClass, D2Bridge.Item.VCLObj, D2Bridge.Interfaces
  {$IFDEF FMX}

  {$ELSE}

  {$ENDIF}
  ;

type
  TD2BridgeItemHTMLQRCode = class(TD2BridgeItem, ID2BridgeItemHTMLQRCode)
   //events
   procedure BeginReader;
   procedure EndReader;
  private
   FD2BridgeItem: TD2BridgeItem;
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;

   function PrismQRCode: IPrismQRCode;

   procedure PreProcess;
   procedure Render;
   procedure RenderHTML;

   property BaseClass;
  end;

implementation

uses
  Prism.QRCode, Prism.Forms, D2Bridge.Util;

{ TD2BridgeItemHTMLQRCode }

constructor TD2BridgeItemHTMLQRCode.Create(AOwner: TD2BridgeClass);
begin
 FD2BridgeItem:= Inherited Create(AOwner);

 PrismControl := TPrismQRCode.Create(nil);
 PrismControl.Name:= ITemID;

 FD2BridgeItem.OnBeginReader:= BeginReader;
 FD2BridgeItem.OnEndReader:= EndReader;

end;

destructor TD2BridgeItemHTMLQRCode.Destroy;
begin
 if Assigned(PrismControl) then
 begin
  TPrismQRCode(PrismControl).Destroy;
 end;

 inherited;
end;


procedure TD2BridgeItemHTMLQRCode.BeginReader;
begin
 TPrismForm(BaseClass.Form).AddControl(PrismControl);
end;

procedure TD2BridgeItemHTMLQRCode.EndReader;
begin

end;

procedure TD2BridgeItemHTMLQRCode.PreProcess;
begin

end;

function TD2BridgeItemHTMLQRCode.PrismQRCode: IPrismQRCode;
begin
 result:= GetPrismControl as IPrismQRCode;
end;

procedure TD2BridgeItemHTMLQRCode.Render;
begin
 BaseClass.HTML.Render.Body.Add('{%'+TrataHTMLTag(ItemPrefixID+' class="d2bridgeqrcode img-fluid '+Trim(CSSClasses)+'" style="'+GetHTMLStyle+'"')+'%}');
end;

procedure TD2BridgeItemHTMLQRCode.RenderHTML;
begin

end;


end.
