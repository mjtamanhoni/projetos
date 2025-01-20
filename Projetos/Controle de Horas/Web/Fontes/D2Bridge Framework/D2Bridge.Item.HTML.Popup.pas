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

unit D2Bridge.Item.HTML.Popup;

interface

uses
  System.Classes, System.SysUtils, System.Variants, System.Generics.Collections,
  Prism.Interfaces,
  D2Bridge.Item, D2Bridge.BaseClass, D2Bridge.Item.VCLObj, D2Bridge.ItemCommon, D2Bridge.Interfaces;

type
  TD2BridgeItemHTMLPopup = class(TD2BridgeItem, ID2BridgeItemHTMLPopup)
   //events
  private
   FD2BridgeItems : TD2BridgeItems;
   FD2BridgeItem: TD2BridgeItem;
   FTitle: String;
   FShowButtonClose: Boolean;
   FCloseParam: Variant;
   procedure BeginReader;
   procedure EndReader;
   function GetTitle: string;
   procedure SetTitle(ATitle: string);
   function GetShowButtonClose: Boolean;
   procedure SetShowButtonClose(AValue: Boolean);
   function GetCloseParam: Variant;
   procedure SetCloseParam(const Value: Variant);
  public
   constructor Create(AOwner: TD2BridgeClass);
   destructor Destroy; override;

   procedure PreProcess; override;
   procedure Render; override;
   procedure RenderHTML; override;

   Function Items: ID2BridgeAddItems;

   property BaseClass;
   property ShowButtonClose: Boolean read GetShowButtonClose write SetShowButtonClose;
   property Title: string read GetTitle write SetTitle;

   property CloseParam: Variant read GetCloseParam write SetCloseParam;
  end;

implementation

uses
  D2Bridge.Render, D2Bridge.Forms, D2Bridge.Prism.Form, Prism.Session,
  System.Math, System.StrUtils;

{ TD2BridgeItemHTMLPopup }

constructor TD2BridgeItemHTMLPopup.Create(AOwner: TD2BridgeClass);
begin
 FD2BridgeItem:= Inherited Create(AOwner);

 FD2BridgeItems:= TD2BridgeItems.Create(BaseClass);

 FShowButtonClose:= true;

 FD2BridgeItem.OnBeginReader:= BeginReader;
 FD2BridgeItem.OnEndReader:= EndReader;
end;

destructor TD2BridgeItemHTMLPopup.Destroy;
begin
 FreeAndNil(FD2BridgeItems);

 FCloseParam:= Unassigned;

 inherited;
end;

function TD2BridgeItemHTMLPopup.GetCloseParam: Variant;
begin
 Result:= FCloseParam;
end;

function TD2BridgeItemHTMLPopup.GetShowButtonClose: Boolean;
begin
 Result:= FShowButtonClose;
end;

function TD2BridgeItemHTMLPopup.GetTitle: string;
begin
 Result:= FTitle;
end;

function TD2BridgeItemHTMLPopup.Items: ID2BridgeAddItems;
begin
 Result:= FD2BridgeItems;
end;

procedure TD2BridgeItemHTMLPopup.BeginReader;
begin
 with BaseClass.HTML.Render.Body do
 begin
  Add('<div class="d2bridgepopup modal fade" id="'+ ItemID +'" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel'+ ItemID +'" aria-hidden="true">');
  Add('  <div class="modal-dialog ' + CSSClasses + ' modal-dialog-centered">');
  Add('    <div class="modal-content">');
  Add('      <div class="d2bridgepopupheader modal-header" style="' + ifThen((not ShowButtonClose) and (Title = ''), 'display: none;') + '">');
  Add('        <h5 class="d2bridgepopuptitle modal-title" id="staticBackdropLabel'+ ItemID +'">' + Title + '</h5>');
  if ShowButtonClose then
  Add('        <button type="button" class="d2bridgepopupbtnclose btn-close" data-bs-dismiss="modal" aria-label="Close" id="'+ 'BUTTONCLOSE_'+ItemID +'"></button>')
  else
  Add('        <button type="button" class="d2bridgepopupbtnclose btn-close invisible" data-bs-dismiss="modal" aria-label="Close" id="'+ 'BUTTONCLOSE_'+ItemID +'" style="display: none;"></button>');
  Add('      </div>');
  Add('      <div class="d2bridgepopup-body modal-body p-3">');
 end;
end;

procedure TD2BridgeItemHTMLPopup.EndReader;
var
 vUUID, vToken, vFormUUID, vControlID: String;
 vPrismSession: TPrismSession;
begin
 with BaseClass.HTML.Render.Body do
 begin
  Add('      </div>');
//  Add('      <div class="modal-footer">');
//  Add('        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>');
//  Add('        <button type="button" class="btn btn-primary">Understood</button>');
//  Add('      </div>');
  Add('    </div>');
  Add('  </div>');
  Add('</div>');
 end;


 vPrismSession:= FD2BridgeItem.BaseClass.PrismSession;
 vUUID:= vPrismSession.UUID;
 vToken:= vPrismSession.Token;
// if Assigned(FD2BridgeItem.BaseClass.D2BridgeOwner) then
//  vFormUUID:= FD2BridgeItem.BaseClass.D2BridgeOwner.FormUUID
// else
 vFormUUID:= FD2BridgeItem.BaseClass.FormUUID;
 vControlID:= vFormUUID;


 with BaseClass.HTML.Render.Body do
 begin
  Add('<script>');
  Add('    let tempevent'+ItemID+' = document.getElementById('''+ItemID+''');');
  Add('    tempevent'+ItemID+'.addEventListener(''show.bs.modal'', function (event) {');
  Add('          setTimeout(function() {');
  Add('             document.activeElement.blur();');
  Add('             document.body.focus();');
  Add('          }, 1);');
  Add('          PrismServer().ExecEvent("'+vUUID+'", "'+vToken+'", "'+vFormUUID+'", "'+vFormUUID+'", "OnShowPopup", "popupname='+ItemID+'&PrismComponentsStatus=" + GetComponentsStates(PrismComponents), true);');
  Add('    });');
  Add('    tempevent'+ItemID+'.addEventListener(''hidden.bs.modal'', function (event) {');
  Add('          decd2bridgepopup(this);');
  Add('          PrismServer().ExecEvent("'+vUUID+'", "'+vToken+'", "'+vFormUUID+'", "'+vFormUUID+'", "OnClosePopup", "popupname='+ItemID+'&PrismComponentsStatus=" + GetComponentsStates(PrismComponents), true);');
  Add('    });');
  Add('</script>');
 end;
end;

procedure TD2BridgeItemHTMLPopup.PreProcess;
begin

end;

procedure TD2BridgeItemHTMLPopup.Render;
begin
 if Items.Items.Count > 0 then
 begin
  BaseClass.RenderD2Bridge(Items.Items);
 end;
end;

procedure TD2BridgeItemHTMLPopup.RenderHTML;
begin

end;

procedure TD2BridgeItemHTMLPopup.SetCloseParam(const Value: Variant);
begin
 FCloseParam:= Value;
end;

procedure TD2BridgeItemHTMLPopup.SetShowButtonClose(AValue: Boolean);
begin
 FShowButtonClose:= AValue;
end;

procedure TD2BridgeItemHTMLPopup.SetTitle(ATitle: string);
begin
 FTitle:= ATitle;
end;

end.
