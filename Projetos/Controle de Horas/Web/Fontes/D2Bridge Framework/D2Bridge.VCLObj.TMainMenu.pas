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

unit D2Bridge.VCLObj.TMainMenu;


interface

{$IFNDEF FMX}
uses
  System.Classes, System.UITypes,
  VCL.Menus,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass,
  D2Bridge.Prism.Menu, Prism.Interfaces;


type
 TVCLObjTMainMenu = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   FD2BridgePrismMenu: TD2BridgePrismMenu;
  public
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   destructor Destroy; override;

   function CSSClass: String;
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;

   procedure BuildMenuItems(AMainMenu: TMainMenu; APrismMainMenu: IPrismMainMenu);
 end;


implementation

uses
  System.SysUtils,
  Prism.Util, D2Bridge.Util, D2Bridge.HTML.CSS, D2Bridge.Item.VCLObj.Style,
  Prism.MainMenu;

{ VCLObjTMainMenu }


procedure TVCLObjTMainMenu.BuildMenuItems(AMainMenu: TMainMenu;
  APrismMainMenu: IPrismMainMenu);
begin
  FD2BridgePrismMenu.BuildMenuItems(AMainMenu, APrismMainMenu);;
end;

constructor TVCLObjTMainMenu.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
 FD2BridgePrismMenu:= TD2BridgePrismMenu.Create;
end;

function TVCLObjTMainMenu.CSSClass: String;
begin
 result:= 'd2bridgemenu d2bridgemainmenu navbar navbar-expand-lg navbar-dark bg-dark';
end;

destructor TVCLObjTMainMenu.Destroy;
begin
 FreeAndNil(FD2BridgePrismMenu);

 inherited;
end;

function TVCLObjTMainMenu.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.MainMenu;
end;

function TVCLObjTMainMenu.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTMainMenu.ProcessEventClass;
begin

end;

procedure TVCLObjTMainMenu.ProcessPropertyClass(NewObj: TObject);
var
 vPrismMainMenu: TPrismMainMenu;
 vMainMenu: TMainMenu;
begin
 if NewObj is TPrismMainMenu then
 begin
  vPrismMainMenu:= NewObj as TPrismMainMenu;
  vMainMenu:= TMainMenu(FD2BridgeItemVCLObj.Item);

  BuildMenuItems(vMainMenu, vPrismMainMenu);

  vPrismMainMenu.OnMenuItemLinkClick:=
   procedure(EventParams: TStrings)
   begin
    if EventParams.Objects[0] is TMenuItem then
     if TMenuItem(EventParams.Objects[0]).Visible and TMenuItem(EventParams.Objects[0]).Enabled then
      if Assigned(TMenuItem(EventParams.Objects[0]).OnClick) then
       TMenuItem(EventParams.Objects[0]).OnClick(EventParams.Objects[0]);
   end;
 end;
end;

function TVCLObjTMainMenu.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTMainMenu.VCLClass: TClass;
begin
 Result:= TMainMenu;
end;

procedure TVCLObjTMainMenu.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;

{$ELSE}
implementation
{$ENDIF}

end.
