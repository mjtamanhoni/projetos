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

unit D2Bridge.VCLObj.TSpeedButton;

interface

uses
  System.Classes,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTSpeedButton = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function CSSClass: String;
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;

implementation

uses
{$IFDEF FMX}
  FMX.StdCtrls,
{$ELSE}
  Vcl.StdCtrls, Vcl.Buttons,
{$ENDIF}
  D2Bridge.Util,
  Prism.Util;

{ TVCLObjTSpeedButton }

constructor TVCLObjTSpeedButton.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTSpeedButton.CSSClass: String;
begin
 Result:= 'btn';
end;

function TVCLObjTSpeedButton.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button;
end;

function TVCLObjTSpeedButton.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTSpeedButton.ProcessEventClass;
begin
if Assigned(TSpeedButton(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TSpeedButton(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TSpeedButton(FD2BridgeItemVCLObj.Item).OnDblClick) then
 FrameworkItemClass.OnDblClick:=
    procedure(EventParams: TStrings)
    begin
     TSpeedButton(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
    end;
end;

procedure TVCLObjTSpeedButton.ProcessPropertyClass(NewObj: TObject);
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.Caption:= TSpeedButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF};

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TSpeedButton(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.SetVisible:=
    procedure(AValue: Variant)
    begin
     TSpeedButton(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;
end;

function TVCLObjTSpeedButton.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTSpeedButton.VCLClass: TClass;
begin
 Result:= TSpeedButton;
end;


procedure TVCLObjTSpeedButton.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;

end.
