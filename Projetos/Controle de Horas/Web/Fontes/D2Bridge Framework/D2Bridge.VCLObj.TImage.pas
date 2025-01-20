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
  Thank for contribution to this Unit to:
    Edvanio Jancy
    edvanio@ideiasistemas.com.br
 +--------------------------------------------------------------------------+
}

{$I D2Bridge.inc}

unit D2Bridge.VCLObj.TImage;

interface

uses
  System.Classes,
{$IFDEF FMX}
  FMX.Objects,
{$ELSE}
  Vcl.ExtCtrls, Vcl.Graphics,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTImage = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function CSSClass: String;
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;

implementation

uses
  Prism.Util, D2Bridge.Util;


{ TVCLObjTImage }

constructor TVCLObjTImage.Create(AOwner: TD2BridgeItemVCLObj);
begin
  FD2BridgeItemVCLObj := AOwner;
end;

function TVCLObjTImage.CSSClass: String;
begin
  result := 'rounded float-left img-fluid';
end;

function TVCLObjTImage.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
  Result := FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image;
end;

function TVCLObjTImage.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
  result := FD2BridgeItemVCLObj;
end;

procedure TVCLObjTImage.ProcessEventClass;
begin
 if Assigned(TImage(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TImage(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TImage(FD2BridgeItemVCLObj.Item).OnDblClick) then
 FrameworkItemClass.OnDblClick:=
    procedure(EventParams: TStrings)
    begin
     TImage(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
    end;
end;

procedure TVCLObjTImage.ProcessPropertyClass(NewObj: TObject);
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image.Picture := TImage(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Picture{$ELSE}Bitmap{$ENDIF};

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image.SetVisible:=
    procedure(AValue: Variant)
    begin
     TImage(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;
end;

function TVCLObjTImage.PropertyCopyList: TStringList;
begin
  Result := FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTImage.VCLClass: TClass;
begin
  Result:= TImage;
end;

procedure TVCLObjTImage.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;

initialization
 RegisterClass(TVCLObjTImage);

end.
