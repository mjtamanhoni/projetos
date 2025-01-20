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

unit D2Bridge.Util;

interface

uses
  System.Rtti, System.Threading, System.Classes, System.NetEncoding, System.SysUtils,
  System.TypInfo, System.UITypes, System.Variants, System.Math
{$IFDEF MSWINDOWS}
  , Winapi.Windows
{$ENDIF}
{$IFDEF FMX}
  ,FMX.Controls, FMX.Forms, FMX.TabControl, FMX.Platform, FMX.Graphics
{$ELSE}
  ,Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.Graphics
{$ENDIF}
;


function ReadContentsFromStream(const AStream: TStream): string;
function TrataHTMLTag(HTML: String): String;
//function IsMethodImplemented(Instance: TObject; MethodName: String): Boolean;


Function GenerateRandomString(ASize: integer): string;
Function GenerateRandomNumber(ASize: integer): string;


Function GetVisibleRecursive(AControl: TObject): Boolean;
Function GetEnabledRecursive(AControl: TObject): Boolean;


function LangsByBrowser(ALangCommaText: string): TStrings; overload;
function FirstLangByBrowser(ALangCommaText: string): String; overload;


function GetElapsedTime(const StartTime: Cardinal): string;

function WidthPPI(AWidth: Integer): Integer; overload;
function WidthPPI(AWidth: Single): Integer; overload;

function Base64FromFile(AFile: string): string;
function Base64ImageFromFile(AFile: string): string;

function HexToTColor(Hex: string): {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
function ColorToHex(Color: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF}): string;
function LightenColor(Color: {$IFDEF FMX}TAlphaColor{$ELSE}TColor{$ENDIF}; Percent: Byte): {$IFDEF FMX}TAlphaColor{$ELSE}TColor{$ENDIF};

function ExtractHexValue(AHexValue: LongInt): integer;

procedure CSSButtonFontToIelement(var AOriginalCSSClasses, ANewCSSClasses, AFontClass, AIelement: string);


function VarToObject(Value: variant): TObject;
function ObjectToVar(Value: TObject): Variant;

implementation

uses
  D2Bridge.Forms;


function ReadContentsFromStream(const AStream: TStream): string;
var
  StreamReader: TStreamReader;
begin
 Result:= '';

 AStream.Position := 0;
 StreamReader := TStreamReader.Create(AStream, TEncoding.UTF8);
 try
   Result := StreamReader.ReadToEnd;
 finally
   StreamReader.Free;
 end;
end;

function TrataHTMLTag(HTML: String): String;
begin
 Result:= Trim(HTML);
 Result:= StringReplace(Result, '=""', '', [rfReplaceAll, rfIgnoreCase]);
end;


Function GenerateRandomString(ASize: integer): string;
var i: integer;
 r:string;
const
 Str = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
begin
 for i := 1 to ASize do
  r := r + Str[random(length(Str))+ 1];

 Result := r;
end;


Function GenerateRandomNumber(ASize: integer): string;
var i: integer;
 r:string;
const
 Str = '1234567890';
begin
 for i := 1 to ASize do
  r := r + Str[random(length(Str))+ 1];

 Result := r;
end;


Function GetVisibleRecursive(AControl: TObject): Boolean;
begin
 TControl(AControl).Repaint;
 Result := TControl(AControl).Visible;
 while (TControl(AControl).Parent <> nil)
   and (not (TControl(AControl).Parent is TForm))
   and (not (TControl(AControl).Parent is TD2BridgeForm))
   and (not (TControl(AControl).Parent is TCustomForm))
   and Result do
 begin
  AControl := TControl(AControl).Parent;
  if AControl.ClassType = {$IFDEF FMX}TTabItem{$ELSE}TTabSheet{$ENDIF} then
   Result := {$IFDEF FMX}TTabItem{$ELSE}TTabSheet{$ENDIF}(AControl).{$IFDEF FMX}Visible{$ELSE}TabVisible{$ENDIF}
{$IFDEF FMX}
  else if AControl.ClassType.ClassName = 'TTabItemContent' then
    //Ignora no FMX
{$ENDIF}
  else
   Result := TControl(AControl).Visible;
 end;
end;


Function GetEnabledRecursive(AControl: TObject): Boolean;
begin
 Result := TControl(AControl).Enabled;
 while (TControl(AControl).Parent <> nil)
   and (not (TControl(AControl).Parent is TForm))
   and (not (TControl(AControl).Parent is TD2BridgeForm))
   and Result do
 begin
  AControl := TControl(AControl).Parent;
  if AControl.ClassType = {$IFDEF FMX}TTabItem{$ELSE}TTabSheet{$ENDIF} then
   Result := {$IFDEF FMX}TTabItem{$ELSE}TTabSheet{$ENDIF}(AControl).Enabled
{$IFDEF FMX}
  else if AControl.ClassType.ClassName = 'TTabItemContent' then
    //Ignora no FMX
{$ENDIF}
  else
   Result := TControl(AControl).Enabled;
 end;
end;


function LangsByBrowser(ALangCommaText: string): TStrings; overload;
var
 I: integer;
begin
 Result:= TStringList.Create;

 Result.CommaText:= ALangCommaText;

 for I := Pred(Result.Count) downto 0 do
 begin
  if Pos('q=', Result.Strings[I]) > 0 then
  begin
   Result.Strings[I]:= Copy(Result.Strings[I], 0, Pos(';',Result.Strings[I])-1);
  end;
 end;

 if Result.Text = '' then
  Result.Text:= 'en-US';
end;


function FirstLangByBrowser(ALangCommaText: string): String; overload;
var
 vLangs: TStrings;
begin
 result:= '';

 vLangs:= LangsByBrowser(ALangCommaText);
 if vLangs.Count > 0 then
  result:= vLangs.Strings[0]
 else
  result:= 'en-US';

 vLangs.Free;
end;


function GetElapsedTime(const StartTime: Cardinal): string;
 var
  ElapsedTime: Cardinal;
  Seconds, Minutes, Hours, Days: Integer;
begin
  ElapsedTime := TThread.GetTickCount  - StartTime;

  Seconds := ElapsedTime div 1000;
  Minutes := Seconds div 60;
  Hours := Minutes div 60;
  Days := Hours div 24;

  if Days > 0 then
    Result := Format('%dd %dh %dm %ds', [Days, Hours mod 24, Minutes mod 60, Seconds mod 60])
  else if Hours > 0 then
    Result := Format('%dh %dm %ds', [Hours, Minutes mod 60, Seconds mod 60])
  else if Minutes > 0 then
    Result := Format('%dm %ds', [Minutes, Seconds mod 60])
  else
    Result := Format('%ds', [Seconds]);
end;

{$IFDEF FMX}
function get_screenscale: Single;
var
  ScreenService: IFMXScreenService;
begin
  Result:= 1;

  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenService)) then
    Result:= ScreenService.GetScreenScale;
end;
{$ENDIF}

function WidthPPI(AWidth: Integer): Integer;
var
  aDefault:              Integer;
  aDefaultPixelsPerInch: Integer;
  aPixelsPerInch:        Integer;
begin
{$IFDEF FMX}
  aDefault:=              1;
  aDefaultPixelsPerInch:= Trunc(get_screenscale);
  aPixelsPerInch:=        Trunc(get_screenscale);
{$ELSE}
  aDefault:=              96;
  {$IF CompilerVersion >= 34} // Delphi 10.4 Sydney or Upper
  aDefaultPixelsPerInch:= Screen.DefaultPixelsPerInch;
  {$ENDIF}
  aPixelsPerInch:=        Screen.PixelsPerInch;
{$ENDIF}

 {$IF CompilerVersion >= 34} // Delphi 10.4 Sydney or Upper
  Result:= MulDiv(AWidth, aDefaultPixelsPerInch, aPixelsPerInch);
 {$ELSE}
  Result:= MulDiv(AWidth, aDefault, aPixelsPerInch);
 {$ENDIF}
end;

function WidthPPI(AWidth: Single): Integer;
var
 nWidth: Integer;
begin
 nWidth:= Trunc(AWidth);

 Result:= WidthPPI(nWidth);
end;

function Base64FromFile(AFile: string): string;
var
  Output, Input: TStringStream;
begin
  try
    if FileExists(AFile) then
    begin
       try
        Input := TStringStream.Create;
        Output := TStringStream.Create;

        Input.LoadFromFile(AFile);

        Input.Position := 0;
        TNetEncoding.Base64.Encode(Input, Output);
        Output.Position := 0;

        Result := Output.DataString;
       finally
        Input.Free;
        Output.Free;
       end;
    end;
  except
  end;
end;


function Base64ImageFromFile(AFile: string): string;
begin
 result:= 'data:image/jpeg;base64, ' + Base64FromFile(AFile);
end;

function HexToTColor(Hex: string): {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF};
var
  nColor:  TColor;
  R, G, B: Byte;
begin
  if SameText(Hex, 'black') then
    nColor := TColors.Black
  else if SameText(Hex, 'white') then
    nColor := TColors.White
  // Adiciona suporte para todas as cores nomeadas disponíveis no CSS
  else if SameText(Hex, 'aqua') then
    nColor := $00FFFF
  else if SameText(Hex, 'aliceblue') then
    nColor := $F0F8FF
  else if SameText(Hex, 'antiquewhite') then
    nColor := $FAEBD7
  else if SameText(Hex, 'azure') then
    nColor := $F0FFFF
  else if SameText(Hex, 'beige') then
    nColor := $F5F5DC
  else if SameText(Hex, 'bisque') then
    nColor := $FFE4C4
  else if SameText(Hex, 'blanchedalmond') then
    nColor := $FFEBCD
  else if SameText(Hex, 'blueviolet') then
    nColor := $8A2BE2
  else if SameText(Hex, 'burlywood') then
    nColor := $DEB887
  else if SameText(Hex, 'cadetblue') then
    nColor := $5F9EA0
  else if SameText(Hex, 'chartreuse') then
    nColor := $7FFF00
  else if SameText(Hex, 'chocolate') then
    nColor := $D2691E
  else if SameText(Hex, 'coral') then
    nColor := $FF7F50
  else if SameText(Hex, 'cornflowerblue') then
    nColor := $6495ED
  else if SameText(Hex, 'cornsilk') then
    nColor := $FFF8DC
  else if SameText(Hex, 'crimson') then
    nColor := $DC143C
  else if SameText(Hex, 'cyan') then
    nColor := $00FFFF
  else if SameText(Hex, 'darkblue') then
    nColor := $00008B
  else if SameText(Hex, 'darkcyan') then
    nColor := $008B8B
  else if SameText(Hex, 'darkgoldenrod') then
    nColor := $B8860B
  else if SameText(Hex, 'darkgray') then
    nColor := $A9A9A9
  else if SameText(Hex, 'darkgreen') then
    nColor := $006400
  else if SameText(Hex, 'darkkhaki') then
    nColor := $BDB76B
  else if SameText(Hex, 'darkmagenta') then
    nColor := $8B008B
  else if SameText(Hex, 'darkolivegreen') then
    nColor := $556B2F
  else if SameText(Hex, 'darkorange') then
    nColor := $FF8C00
  else if SameText(Hex, 'darkorchid') then
    nColor := $9932CC
  else if SameText(Hex, 'darkred') then
    nColor := $8B0000
  else if SameText(Hex, 'darksalmon') then
    nColor := $E9967A
  else if SameText(Hex, 'darkseagreen') then
    nColor := $8FBC8F
  else if SameText(Hex, 'darkslateblue') then
    nColor := $483D8B
  else if SameText(Hex, 'darkslategray') then
    nColor := $2F4F4F
  else if SameText(Hex, 'darkturquoise') then
    nColor := $00CED1
  else if SameText(Hex, 'darkviolet') then
    nColor := $9400D3
  else if SameText(Hex, 'deeppink') then
    nColor := $FF1493
  else if SameText(Hex, 'deepskyblue') then
    nColor := $00BFFF
  else if SameText(Hex, 'dimgray') then
    nColor := $696969
  else if SameText(Hex, 'dodgerblue') then
    nColor := $1E90FF
  else if SameText(Hex, 'firebrick') then
    nColor := $B22222
  else if SameText(Hex, 'floralwhite') then
    nColor := $FFFAF0
  else if SameText(Hex, 'forestgreen') then
    nColor := $228B22
  else if SameText(Hex, 'gainsboro') then
    nColor := $DCDCDC
  else if SameText(Hex, 'ghostwhite') then
    nColor := $F8F8FF
  else if SameText(Hex, 'gold') then
    nColor := $FFD700
  else if SameText(Hex, 'goldenrod') then
    nColor := $DAA520
  else if SameText(Hex, 'gray') then
    nColor := $808080
  else if SameText(Hex, 'greenyellow') then
    nColor := $ADFF2F
  else if SameText(Hex, 'honeydew') then
    nColor := $F0FFF0
  else if SameText(Hex, 'hotpink') then
    nColor := $FF69B4
  else if SameText(Hex, 'indianred') then
    nColor := $CD5C5C
  else if SameText(Hex, 'indigo') then
    nColor := $4B0082
  else if SameText(Hex, 'ivory') then
    nColor := $FFFFF0
  else if SameText(Hex, 'khaki') then
    nColor := $F0E68C
  else if SameText(Hex, 'lavender') then
    nColor := $E6E6FA
  else if SameText(Hex, 'lavenderblush') then
    nColor := $FFF0F5
  else if SameText(Hex, 'lawngreen') then
    nColor := $7CFC00
  else if SameText(Hex, 'lemonchiffon') then
    nColor := $FFFACD
  else if SameText(Hex, 'lightblue') then
    nColor := $ADD8E6
  else if SameText(Hex, 'lightcoral') then
    nColor := $F08080
  else if SameText(Hex, 'lightcyan') then
    nColor := $E0FFFF
  else if SameText(Hex, 'lightgoldenrodyellow') then
    nColor := $FAFAD2
  else if SameText(Hex, 'lightgray') then
    nColor := $D3D3D3
  else if SameText(Hex, 'lightgreen') then
    nColor := $90EE90
  else if SameText(Hex, 'lightpink') then
    nColor := $FFB6C1
  else if SameText(Hex, 'lightsalmon') then
    nColor := $FFA07A
  else if SameText(Hex, 'lightseagreen') then
    nColor := $20B2AA
  else if SameText(Hex, 'lightskyblue') then
    nColor := $87CEFA
  else if SameText(Hex, 'lightslategray') then
    nColor := $778899
  else if SameText(Hex, 'lightsteelblue') then
    nColor := $B0C4DE
  else if SameText(Hex, 'lightyellow') then
    nColor := $FFFFE0
  else if SameText(Hex, 'limegreen') then
    nColor := $32CD32
  else if SameText(Hex, 'linen') then
    nColor := $FAF0E6
  else if SameText(Hex, 'magenta') then
    nColor := $FF00FF
  else if SameText(Hex, 'maroon') then
    nColor := $800000
  else if SameText(Hex, 'mediumaquamarine') then
    nColor := $66CDAA
  else if SameText(Hex, 'mediumblue') then
    nColor := $0000CD
  else if SameText(Hex, 'mediumorchid') then
    nColor := $BA55D3
  else if SameText(Hex, 'mediumpurple') then
    nColor := $9370DB
  else if SameText(Hex, 'mediumseagreen') then
    nColor := $3CB371
  else if SameText(Hex, 'mediumslateblue') then
    nColor := $7B68EE
  else if SameText(Hex, 'mediumspringgreen') then
    nColor := $00FA9A
  else if SameText(Hex, 'mediumturquoise') then
    nColor := $48D1CC
  else if SameText(Hex, 'mediumvioletred') then
    nColor := $C71585
  else if SameText(Hex, 'midnightblue') then
    nColor := $191970
  else if SameText(Hex, 'mintcream') then
    nColor := $F5FFFA
  else if SameText(Hex, 'mistyrose') then
    nColor := $FFE4E1
  else if SameText(Hex, 'moccasin') then
    nColor := $FFE4B5
  else if SameText(Hex, 'navajowhite') then
    nColor := $FFDEAD
  else if SameText(Hex, 'oldlace') then
    nColor := $FDF5E6
  else if SameText(Hex, 'olivedrab') then
    nColor := $6B8E23
  else if SameText(Hex, 'orangered') then
    nColor := $FF4500
  else if SameText(Hex, 'orchid') then
    nColor := $DA70D6
  else if SameText(Hex, 'palegoldenrod') then
    nColor := $EEE8AA
  else if SameText(Hex, 'palegreen') then
    nColor := $98FB98
  else if SameText(Hex, 'paleturquoise') then
    nColor := $AFEEEE
  else if SameText(Hex, 'palevioletred') then
    nColor := $DB7093
  else if SameText(Hex, 'papayawhip') then
    nColor := $FFEFD5
  else if SameText(Hex, 'peachpuff') then
    nColor := $FFDAB9
  else if SameText(Hex, 'peru') then
    nColor := $CD853F
  else if SameText(Hex, 'pink') then
    nColor := $FFC0CB
  else if SameText(Hex, 'plum') then
    nColor := $DDA0DD
  else if SameText(Hex, 'powderblue') then
    nColor := $B0E0E6
  else if SameText(Hex, 'purple') then
    nColor := $800080
  else if SameText(Hex, 'rebeccapurple') then
    nColor := $663399
  else if SameText(Hex, 'rosybrown') then
    nColor := $BC8F8F
  else if SameText(Hex, 'royalblue') then
    nColor := $4169E1
  else if SameText(Hex, 'saddlebrown') then
    nColor := $8B4513
  else if SameText(Hex, 'salmon') then
    nColor := $FA8072
  else if SameText(Hex, 'sandybrown') then
    nColor := $F4A460
  else if SameText(Hex, 'seagreen') then
    nColor := $2E8B57
  else if SameText(Hex, 'seashell') then
    nColor := $FFF5EE
  else if SameText(Hex, 'sienna') then
    nColor := $A0522D
  else if SameText(Hex, 'silver') then
    nColor := $C0C0C0
  else if SameText(Hex, 'skyblue') then
    nColor := $87CEEB
  else if SameText(Hex, 'slateblue') then
    nColor := $6A5ACD
  else if SameText(Hex, 'slategray') then
    nColor := $708090
  else if SameText(Hex, 'snow') then
    nColor := $FFFAFA
  else if SameText(Hex, 'springgreen') then
    nColor := $00FF7F
  else if SameText(Hex, 'steelblue') then
    nColor := $4682B4
  else if SameText(Hex, 'tan') then
    nColor := $D2B48C
  else if SameText(Hex, 'teal') then
    nColor := $008080
  else if SameText(Hex, 'thistle') then
    nColor := $D8BFD8
  else if SameText(Hex, 'tomato') then
    nColor := $FF6347
  else if SameText(Hex, 'turquoise') then
    nColor := $40E0D0
  else if SameText(Hex, 'violet') then
    nColor := $EE82EE
  else if SameText(Hex, 'wheat') then
    nColor := $F5DEB3
  else if SameText(Hex, 'whitesmoke') then
    nColor := $F5F5F5
  else if SameText(Hex, 'yellowgreen') then
    nColor := $9ACD32
  else
  begin
   // Remova o "#" do início do código Hex, se presente
   if Hex[1] = '#' then
    Delete(Hex, 1, 1);

   // Converta os valores Hex para RGB
   R := StrToInt('$' + Copy(Hex, 1, 2));
   G := StrToInt('$' + Copy(Hex, 3, 2));
   B := StrToInt('$' + Copy(Hex, 5, 2));

   // Retorne a cor em formato TColor
   nColor := RGB(R, G, B);
  end;

{$IFNDEF FMX}
  Result:= nColor;
{$ELSE}
  Result:= TAlphaColorRec.Alpha or TAlphaColor(nColor);
{$ENDIF}
end;

function ColorToHex(Color: {$IFNDEF FMX}TColor{$ELSE}TAlphaColor{$ENDIF}): string;
var
 vRGBColor: Longint;
begin
 try
{$IFNDEF FMX}
  vRGBColor:= ColorToRGB(Color);
{$ELSE}
  vRGBColor:= TAlphaColorRec.ColorToRGB(Color);
{$ENDIF}

  Result := '#' +
     { red value }
     IntToHex( GetRValue( vRGBColor ), 2 ) +
     { green value }
     IntToHex( GetGValue( vRGBColor ), 2 ) +
     { blue value }
     IntToHex( GetBValue( vRGBColor ), 2 );
 except
  Result := '#FFFFFF';
 end;
end;

function LightenColor(Color: {$IFDEF FMX}TAlphaColor{$ELSE}TColor{$ENDIF}; Percent: Byte): {$IFDEF FMX}TAlphaColor{$ELSE}TColor{$ENDIF};
var
  R, G, B: Byte;
  vRGBColor: Longint;
begin
  {$IFDEF FMX}
  vRGBColor := TAlphaColorRec.ColorToRGB(Color);
  {$ELSE}
  vRGBColor := ColorToRGB(Color);
  {$ENDIF}

  R := GetRValue(vRGBColor);
  G := GetGValue(vRGBColor);
  B := GetBValue(vRGBColor);

  R := Min(255, R + (R * Percent div 100));
  G := Min(255, G + (G * Percent div 100));
  B := Min(255, B + (B * Percent div 100));

  Result := RGB(R, G, B);
end;


function ExtractHexValue(AHexValue: LongInt): integer;
var
  HexStr: string;
begin
  HexStr := IntToHex(AHexValue, 8);

  HexStr := StringReplace(HexStr, '$', '', [rfReplaceAll]);

  Result := StrToInt(HexStr);
end;


procedure CSSButtonFontToIelement(var AOriginalCSSClasses, ANewCSSClasses, AFontClass, AIelement: string);
var
 OverrideIndex, OpenBracketIndex, CloseBracketIndex, HifenIndex, SpaceIndex: Integer;
 OverrideText, HTMLComponentOverride, OverridePosition, CSSClean: string;
begin
  AFontClass:= '';
  AIelement:= '';
  ANewCSSClasses:= AOriginalCSSClasses;

  OverrideIndex := AnsiPos('[override', AOriginalCSSClasses);
  if OverrideIndex > 0 then
  begin
    // Encontrar a posição do colchete de abertura "[" a partir da posição do trecho "[override..."
    OpenBracketIndex := AnsiPos('[', Copy(AOriginalCSSClasses, OverrideIndex, Length(AOriginalCSSClasses) - OverrideIndex + 1)) + OverrideIndex - 1;
    if OpenBracketIndex > 0 then
    begin
      // Encontrar a posição do colchete de fechamento "]" a partir da posição do colchete de abertura
      CloseBracketIndex := AnsiPos(']', Copy(AOriginalCSSClasses, OpenBracketIndex, Length(AOriginalCSSClasses) - OpenBracketIndex + 1)) + OpenBracketIndex - 1;
      if CloseBracketIndex > 0 then
      begin
        // Extrair o trecho entre os colchetes
        OverrideText := Copy(AOriginalCSSClasses, OpenBracketIndex + 1, CloseBracketIndex - OpenBracketIndex - 1);

        // Verificar se o trecho contém a palavra "override"
        HifenIndex := AnsiPos('-', OverrideText);
        if HifenIndex > 0 then
        begin
          // Encontrar a posição do próximo espaço em branco ou hífen após o hífen encontrado
          SpaceIndex := 0;
          for SpaceIndex := HifenIndex + 1 to Length(OverrideText) do
          begin
            if (OverrideText[SpaceIndex] = ' ') or (OverrideText[SpaceIndex] = '-') then
              Break;
          end;

          // Extrair a classe entre o hífen e o espaço em branco ou próximo hífen
          HTMLComponentOverride := Copy(OverrideText, HifenIndex + 1, SpaceIndex - HifenIndex - 1);

          if pos('-r-', Trim(Copy(OverrideText, SpaceIndex))) = 1 then
          begin
           OverridePosition:= 'right';
           OverrideText:= StringReplace(OverrideText, '-r-', '-', []);
          end else
          if pos('-t-', Trim(Copy(OverrideText, SpaceIndex))) = 1 then
          begin
           OverridePosition:= 'top';
           OverrideText:= StringReplace(OverrideText, '-t-', '-', []);
          end else
          if pos('-b-', Trim(Copy(OverrideText, SpaceIndex))) = 1 then
          begin
           OverridePosition:= 'bottom';
           OverrideText:= StringReplace(OverrideText, '-b-', '-', []);
          end else
           OverridePosition:= 'left';

          // Extrair o que vem após o item 2 até o final da string, removendo espaços em branco extras e hífen inicial
          AFontClass := Trim(Copy(OverrideText, SpaceIndex + 1));
        end;

        // Remover o trecho entre "[" e "]" e obter o restante da string
        CSSClean := Trim(StringReplace(AOriginalCSSClasses, '[' + OverrideText + ']', '', []));

        if CompareText(HTMLComponentOverride,'button') = 0 then
        begin
         AIelement:= '<i class="'+AFontClass+'"></i>';
        end;


        ANewCSSClasses:=
         Copy(AOriginalCSSClasses, 1, OpenBracketIndex-1) +
         Copy(AOriginalCSSClasses, CloseBracketIndex+1);
      end;
    end;
  end else
   AFontClass:= AOriginalCSSClasses;
end;




function VarToObject(Value: variant): TObject;
begin
  Result := TObject(TVarData(Value).VPointer)
end;

function ObjectToVar(Value: TObject): Variant;
begin
  TVarData(Result).VPointer := Value;
  TVarData(Result).VType := varString;
end;

end.
