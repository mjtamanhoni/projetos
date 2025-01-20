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

unit D2Bridge.VCLObj.TcxDBLabel;


interface

{$IFDEF DEVEXPRESS_AVAILABLE}
uses
  System.Classes,
  Vcl.DBCtrls,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTcxDBLabel = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
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
  Prism.Util, D2Bridge.Util, cxDBLabel, Vcl.Graphics, Vcl.Forms, D2Bridge.Item.VCLObj.Style;

{ TVCLObjTcxDBLabel }

constructor TVCLObjTcxDBLabel.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTcxDBLabel.CSSClass: String;
begin
 result:= 'form-control-plaintext';
end;

function TVCLObjTcxDBLabel.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBText;
end;

function TVCLObjTcxDBLabel.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTcxDBLabel.ProcessEventClass;
begin
 if Assigned(TcxDBLabel(FD2BridgeItemVCLObj.Item).OnClick) then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     TcxDBLabel(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;
end;

procedure TVCLObjTcxDBLabel.ProcessPropertyClass(NewObj: TObject);
begin
 if Assigned(TcxDBLabel(FD2BridgeItemVCLObj.Item).DataBinding.DataSource) then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBText.Dataware.DataSource:= TcxDBLabel(FD2BridgeItemVCLObj.Item).DataBinding.DataSource;

 if TcxDBLabel(FD2BridgeItemVCLObj.Item).DataBinding.DataField <> '' then
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBText.Dataware.DataField:= TcxDBLabel(FD2BridgeItemVCLObj.Item).DataBinding.DataField;

end;

function TVCLObjTcxDBLabel.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTcxDBLabel.VCLClass: TClass;
begin
 Result:= TcxDBLabel;
end;

procedure TVCLObjTcxDBLabel.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin
 if TcxDBLabel(FD2BridgeItemVCLObj.Item).Style.Font.Size <> DefaultFontSize then
  VCLObjStyle.FontSize := TcxDBLabel(FD2BridgeItemVCLObj.Item).Style.Font.Size;

 if TcxDBLabel(FD2BridgeItemVCLObj.Item).Style.Font.Color <> DefaultFontColor then
  VCLObjStyle.FontColor := TcxDBLabel(FD2BridgeItemVCLObj.Item).Style.Font.Color;

 if (not TcxDBLabel(FD2BridgeItemVCLObj.Item).Transparent) and (TcxDBLabel(FD2BridgeItemVCLObj.Item).Style.Color <> clBtnFace) then
  VCLObjStyle.Color := TcxDBLabel(FD2BridgeItemVCLObj.Item).Style.Color;

 if TcxDBLabel(FD2BridgeItemVCLObj.Item).Properties.Alignment.Horz <> DefaultAlignment then
  VCLObjStyle.Alignment:= TcxDBLabel(FD2BridgeItemVCLObj.Item).Properties.Alignment.Horz;

 VCLObjStyle.FontStyles := TcxDBLabel(FD2BridgeItemVCLObj.Item).Style.Font.Style;
end;

{$ELSE}
implementation
{$ENDIF}

end.
