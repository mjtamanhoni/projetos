{$I D2Bridge.inc}

unit D2Bridge.Lang.Util;

interface

uses
  System.Classes, System.SysUtils, System.TypInfo,
  D2Bridge.Types;


 function LanguageName(D2BridgeLang: TD2BridgeLang): string;
 function LanguageCode(D2BridgeLang: TD2BridgeLang): string;
 function D2BridgeLangbyLanguageName(ALanguage: string): TD2BridgeLang;
 function AllLanguages: TD2BridgeLangs;

implementation


function LanguageName(D2BridgeLang: TD2BridgeLang): string;
begin
  Result := GetEnumName(TypeInfo(TD2BridgeLang), Ord(D2BridgeLang));
end;


function LanguageCode(D2BridgeLang: TD2BridgeLang): string;
begin
 case D2BridgeLang of
    English: Result := 'en-US';
    Portuguese: Result := 'pt-BR';
    Spanish: Result := 'es-ES';
    Arabic: Result := 'ar-SA';
    Italian: Result := 'it-IT';
    French: Result := 'fr-FR';
    German: Result := 'de-DE';
    Japanese: Result := 'ja-JP';
    Russian: Result := 'ru-RU';
    Chinese: Result := 'zh-CN';
    Czech: Result := 'cs-CZ';
    Turkish: Result := 'tr-TR';
    Korean: Result := 'ko-KR';
  else
    Result := '';
  end;
end;


function D2BridgeLangbyLanguageName(ALanguage: string): TD2BridgeLang;
var
  LangEnum: TD2BridgeLang;
begin
  ALanguage := LowerCase(ALanguage);

  for LangEnum := Low(TD2BridgeLang) to High(TD2BridgeLang) do
  begin
    if LowerCase(LanguageName(LangEnum)) = ALanguage then
    begin
      Result := LangEnum;
      Exit;
    end;
  end;

  Result := English; // Default to English if no match is found
end;


function AllLanguages: TD2BridgeLangs;
var
  Lang: TD2BridgeLang;
begin
  Result := [];
  for Lang := Low(TD2BridgeLang) to High(TD2BridgeLang) do
  begin
    Include(Result, Lang);
  end;
end;


end.
