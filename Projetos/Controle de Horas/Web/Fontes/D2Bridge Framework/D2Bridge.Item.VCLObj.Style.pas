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

unit D2Bridge.Item.VCLObj.Style;

interface

Uses
  System.Classes, System.UITypes,
  D2Bridge.Interfaces
{$IFDEF FMX}
  , FMX.Graphics, FMX.Types
{$ELSE}
  , Vcl.Forms, Vcl.Graphics
{$ENDIF}
 ;


type
 TD2BridgeItemVCLObjStyle = class(TInterfacedPersistent, ID2BridgeItemVCLObjStyle)
 private
  FFontSize: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF};
  FAlignment: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF};
  FFontColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  FColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  FFontStyles: TFontStyles;
  function GetFontSize: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF};
  procedure SetFontSize(Value: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF});
  function GetFontColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetFontColor(Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
  function GetAlignment: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF};
  procedure SetAlignment(Value: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF});
  function GetFontStyles: TFontStyles;
  procedure SetFontStyles(Value: TFontStyles);
  function GetColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
  procedure SetColor(Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
 public
  constructor Create;

  property FontSize: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF} read GetFontSize write SetFontSize;
  property FontStyles: TFontStyles read GetFontStyles write SetFontStyles;
  property FontColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetFontColor write SetFontColor;
  property Color: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF} read GetColor write SetColor;
  property Alignment: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF} read GetAlignment write SetAlignment;
 end;

const
 taNone: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF} = {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF}($FF);

 DefaultFontSize  = {$IFNDEF FMX}{$IF CompilerVersion >= 34.0}9{$ELSE}8{$ENDIF}{$ELSE}12.0{$ENDIF};
 DefaultFontColor = {$IFNDEF FMX}TColors.SysWindowText{$ELSE}TAlphaColors.Black{$ENDIF};
 DefaultAlignment = {$IFNDEF FMX}taLeftJustify{$ELSE}TTextAlign.Leading{$ENDIF};
 AlignmentLeft    = {$IFNDEF FMX}taLeftJustify{$ELSE}TTextAlign.Leading{$ENDIF};
 AlignmentCenter  = {$IFNDEF FMX}taCenter{$ELSE}TTextAlign.Center{$ENDIF};
 AlignmentRight   = {$IFNDEF FMX}taRightJustify{$ELSE}TTextAlign.Trailing{$ENDIF};

implementation

{ TD2BridgeItemVCLObjStyle }

constructor TD2BridgeItemVCLObjStyle.Create;
begin
 FAlignment:= taNone;
 FFontSize:=  DefaultFontSize;
 FFontColor:= TColors.SysNone;
 FColor:=     TColors.SysNone;
end;

function TD2BridgeItemVCLObjStyle.GetAlignment: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF};
begin
 Result:= FAlignment;
end;

function TD2BridgeItemVCLObjStyle.GetColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
begin
 result:= FColor;
end;

function TD2BridgeItemVCLObjStyle.GetFontColor: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
begin
 Result:= FFontColor;
end;

function TD2BridgeItemVCLObjStyle.GetFontSize: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF};
begin
 Result:= FFontSize;
end;

function TD2BridgeItemVCLObjStyle.GetFontStyles: TFontStyles;
begin
 Result:= FFontStyles;
end;

procedure TD2BridgeItemVCLObjStyle.SetAlignment(Value: {$IFNDEF FMX}TAlignment{$ELSE}TTextAlign{$ENDIF});
begin
 FAlignment:= Value;
end;

procedure TD2BridgeItemVCLObjStyle.SetColor(Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
begin
 FColor:= Value;
end;

procedure TD2BridgeItemVCLObjStyle.SetFontColor(Value: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF});
begin
 FFontColor:= value;
end;

procedure TD2BridgeItemVCLObjStyle.SetFontSize(Value: {$IFNDEF FMX}Integer{$ELSE}Single{$ENDIF});
begin
 FFontSize:= value;
end;

procedure TD2BridgeItemVCLObjStyle.SetFontStyles(Value: TFontStyles);
begin
 FFontStyles:= Value;
end;

end.
