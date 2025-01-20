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
    Natanael Ribeiro
    natan_ribeiro_ferreira@hotmail.com
 +--------------------------------------------------------------------------+
}

{$I ..\D2Bridge.inc}

unit D2Bridge.VCLObj.TcxImage;

interface

{$IFDEF DEVEXPRESS_AVAILABLE}
uses
  System.Classes,
  Vcl.ExtCtrls, Vcl.Graphics,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTcxImage = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function CSSClass: String;
   function VCLClass: TClass;
   procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;

implementation

uses
  Prism.Util, D2Bridge.Util, cxImage;


{ TVCLObjTcxImage }

constructor TVCLObjTcxImage.Create(AOwner: TD2BridgeItemVCLObj);
begin
  FD2BridgeItemVCLObj := AOwner;
end;

function TVCLObjTcxImage.CSSClass: String;
begin
  result := 'rounded float-left img-fluid';
end;

function TVCLObjTcxImage.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
  Result := FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image;
end;

function TVCLObjTcxImage.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
  result := FD2BridgeItemVCLObj;
end;

procedure TVCLObjTcxImage.ProcessEventClass;
begin

end;

procedure TVCLObjTcxImage.ProcessPropertyClass(NewObj: TObject);
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image.Picture := TcxImage(FD2BridgeItemVCLObj.Item).Picture;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Image.SetVisible:=
    procedure(AValue: Variant)
    begin
     TcxImage(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;
end;

function TVCLObjTcxImage.PropertyCopyList: TStringList;
begin
  Result := FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTcxImage.VCLClass: TClass;
begin
  Result:= TcxImage;
end;

procedure TVCLObjTcxImage.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;

initialization
 RegisterClass(TVCLObjTcxImage);
{$ELSE}
implementation
{$ENDIF}

end.
