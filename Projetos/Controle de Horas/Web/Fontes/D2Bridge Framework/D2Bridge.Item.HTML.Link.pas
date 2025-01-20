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

unit D2Bridge.Item.HTML.Link;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
{$IFDEF FMX}
  FMX.StdCtrls, FMX.Edit, FMX.Memo, FMX.Types,
{$ELSE}
  Vcl.StdCtrls, Vcl.DBCtrls,
{$ENDIF}
{$IFDEF DEVEXPRESS_AVAILABLE}
  cxTextEdit, cxMemo, cxLabel, cxDBEdit, cxDBLabel,
{$ENDIF}
  Prism.Interfaces, D2Bridge.ItemCommon,
  D2Bridge.Item, D2Bridge.BaseClass, D2Bridge.Item.VCLObj, D2Bridge.Interfaces;

type
  TD2BridgeItemHTMLLink = class(TD2BridgeItem, ID2BridgeItemHTMLLink)
   //events
   procedure BeginReader;
   procedure EndReader;
  private
   FD2BridgeItem: TD2BridgeItem;
   FD2BridgeItems : TD2BridgeItems;
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;

   Function Items: ID2BridgeAddItems;
   function PrismLink: IPrismLink;

   procedure PreProcess;
   procedure Render;
   procedure RenderHTML;

   property BaseClass;
  end;

implementation

uses
  Prism.Link, D2Bridge.Util, Prism.Forms,
  D2Bridge.Item.VCLObj.Style, D2Bridge.HTML.CSS;

{ TD2BridgeItemHTMLLink }

constructor TD2BridgeItemHTMLLink.Create(AOwner: TD2BridgeClass);
begin
 FD2BridgeItem:= Inherited Create(AOwner);

 FD2BridgeItems:= TD2BridgeItems.Create(AOwner);

 PrismControl := TPrismLink.Create(nil);
 PrismControl.Name:= ITemID;

 FD2BridgeItem.OnBeginReader:= BeginReader;
 FD2BridgeItem.OnEndReader:= EndReader;
end;

destructor TD2BridgeItemHTMLLink.Destroy;
begin
 if Assigned(PrismControl) then
 begin
  TPrismLink(PrismControl).Destroy;
 end;

 FreeAndNil(FD2BridgeItems);

 inherited;
end;


procedure TD2BridgeItemHTMLLink.BeginReader;
begin
 TPrismForm(BaseClass.Form).AddControl(PrismControl);
end;

procedure TD2BridgeItemHTMLLink.EndReader;
begin

end;

function TD2BridgeItemHTMLLink.Items: ID2BridgeAddItems;
begin
 result:= FD2BridgeItems;
end;

procedure TD2BridgeItemHTMLLink.PreProcess;
begin

end;

function TD2BridgeItemHTMLLink.PrismLink: IPrismLink;
begin
 result:= GetPrismControl as IPrismLink;
end;

procedure TD2BridgeItemHTMLLink.Render;
var
 HTMLText: String;
 vClickCallBack: string;
 vText: string;
 vhref: string;
 vHint: string;
 vAlignment: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF};
begin
 vText:= PrismLink.Text;
 vhref:= PrismLink.href;
 vHint:= PrismLink.Hint;
 vClickCallBack:= PrismLink.OnClickCallBack;

 {$REGION 'Alignment'}
 if Assigned(PrismLink.LabelHTMLElement) then
  if BaseClass.VCLStyles then
  begin
   if (PrismLink.LabelHTMLElement is TLabel) //Label's
 {$IFDEF DEVEXPRESS_AVAILABLE}
    or (PrismLink.LabelHTMLElement is TcxLabel)
    or (PrismLink.LabelHTMLElement is TcxDBLabel)
 {$ENDIF}
 {$IFNDEF FMX} or (PrismLink.LabelHTMLElement is TDBText){$ENDIF} then
    vAlignment:= TLabel(PrismLink.LabelHTMLElement).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF}
   else
   if (PrismLink.LabelHTMLElement is TEdit) //Edit's
 {$IFDEF DEVEXPRESS_AVAILABLE}
    or (PrismLink.LabelHTMLElement is TcxTextEdit)
    or (PrismLink.LabelHTMLElement is TcxDBTextEdit)
 {$ENDIF}
 {$IFNDEF FMX} or (PrismLink.LabelHTMLElement is TDBEdit){$ENDIF} then
    vAlignment:= TEdit(PrismLink.LabelHTMLElement).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF}
   else
   if (PrismLink.LabelHTMLElement is TMemo) //Memo's
 {$IFDEF DEVEXPRESS_AVAILABLE}
    or (PrismLink.LabelHTMLElement is TcxMemo)
    or (PrismLink.LabelHTMLElement is TcxDBMemo)
 {$ENDIF}
 {$IFNDEF FMX} or (PrismLink.LabelHTMLElement is TDBMemo){$ENDIF} then
    vAlignment:= TMemo(PrismLink.LabelHTMLElement).{$IFNDEF FMX}Alignment{$ELSE}TextSettings.HorzAlign{$ENDIF};


   if vAlignment <> D2Bridge.Item.VCLObj.Style.taNone then
   begin
    if vAlignment = AlignmentLeft then
     CSSClasses:= CSSClasses + ' ' + TCSSClassText.Align.left;

    if vAlignment = AlignmentRight then
     CSSClasses:= CSSClasses + ' ' + TCSSClassText.Align.right;

    if vAlignment = AlignmentCenter then
     CSSClasses:= CSSClasses + ' ' + TCSSClassText.Align.center;
   end;
  end;
 {$ENDREGION}


 if vClickCallBack <> '' then
 begin
  if Pos('{{', vClickCallBack) <= 0 then
  begin
   if Pos('CallBack=', vClickCallBack) <= 0 then
    vClickCallBack:= 'CallBack=' + vClickCallBack;

   vClickCallBack:= '{{' + vClickCallBack + '}}';
  end;
 end else
 if (vhref = '') or
    (vhref = '#') then
  vClickCallBack:= TRIM('return false;');

 if vClickCallBack <> '' then
 begin
  HTMLText:=
    '<a '+
    TrataHTMLTag('class="d2bridgelink '+Trim(CSSClasses)+'" style="'+HTMLStyle+'" '+HTMLExtras)+
    ' id="'+AnsiUpperCase(ItemPrefixID)+'"'+
    ' href="'+ vhref + '"'+
    ' title="'+ vHint + '"'+
    ' onclick="' + PrismLink.Form.ProcessAllTagHTML(vClickCallBack) + '"' +
    '>';
 end else
 begin
  HTMLText:=
      '<a '+
      TrataHTMLTag('class="d2bridgelink '+Trim(CSSClasses)+'" style="'+HTMLStyle+'" '+HTMLExtras)+
      ' id="'+AnsiUpperCase(ItemPrefixID)+'"'+
      ' href="'+ vhref + '"'+
      ' title="'+ vHint + '"'+
      '>';
 end;

 if (vText = '') and (Items.Items.Count > 0) then
 begin
  HTMLText:= HTMLText +
   '<span id="'+AnsiUpperCase(ItemPrefixID)+'text" class="link-primary d2bridgelinktext">'+vText+'</span>';
 end else
  HTMLText:= HTMLText +
   '<span id="'+AnsiUpperCase(ItemPrefixID)+'text" class="link-primary form-control-plaintext d2bridgelinktext">'+vText+'</span>';

 BaseClass.HTML.Render.Body.Add(HTMLText);

 if Items.Items.Count > 0 then
 begin
  BaseClass.RenderD2Bridge(Items.Items);
 end;

 BaseClass.HTML.Render.Body.Add('</a>');


 TPrismLink(PrismLink).FStoredText:= vText;
 TPrismLink(PrismLink).FStoredhref:= vhref;
 TPrismLink(PrismLink).FStoredHint:= vHint;
 TPrismLink(PrismLink).FStoredOnClickCallBack:= vClickCallBack;

// HTMLControl := '<a class="d2bridgelink" id="' + AnsiUpperCase(NamePrefix) + '" href="'+ Fhref +'" title="'+ FHint +'" onclick="' + Form.ProcessAllTagHTML(FOnClickCallBack) + '">' + Form.ProcessAllTagHTML(FText) + '</a>';
end;

procedure TD2BridgeItemHTMLLink.RenderHTML;
begin

end;


end.
