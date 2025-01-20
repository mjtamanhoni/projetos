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

unit D2Bridge.Lang.Spanish;

interface

Uses
 System.Classes,
 D2Bridge.Lang.Interfaces, D2Bridge.Types, D2Bridge.Lang.Term, D2Bridge.Lang.BaseClass, D2Bridge.Lang.Term.BaseClass;

type
 TD2BridgeLangSpanish = class(TD2BridgeLangBaseClass, ID2BridgeLang)
  private

  public
   constructor Create(AD2BridgeLangCoreBaseClass: ID2BridgeLangCoreBaseClass; D2BridgeTermClass: TD2BridgeTermClass);

   function D2BridgeLang: TD2BridgeLang;

   function HTMLLang: string;
   function LangName: string;

   Procedure DoConfigFormatSettings; virtual;
   procedure DoTranslate(const AContext: string; const ATerm: string; var ATranslated: string); overload; virtual;
   procedure DoTranslate(const ATerm: string; var ATranslated: string); overload; virtual;
 end;


implementation


{ TD2BridgeLangSpanish }

constructor TD2BridgeLangSpanish.Create(AD2BridgeLangCoreBaseClass: ID2BridgeLangCoreBaseClass; D2BridgeTermClass: TD2BridgeTermClass);
begin
 Inherited Create(AD2BridgeLangCoreBaseClass, D2BridgeTermClass, self);
end;

function TD2BridgeLangSpanish.D2BridgeLang: TD2BridgeLang;
begin
 Result:= TD2BridgeLang.Spanish;
end;

procedure TD2BridgeLangSpanish.DoConfigFormatSettings;
begin

end;

procedure TD2BridgeLangSpanish.DoTranslate(const ATerm: string; var ATranslated: string);
begin

end;

procedure TD2BridgeLangSpanish.DoTranslate(const AContext: string; const ATerm: string; var ATranslated: string);
begin

end;

function TD2BridgeLangSpanish.HTMLLang: string;
begin
 result:= 'es-ES';
end;

function TD2BridgeLangSpanish.LangName: string;
begin
 result:= 'Spanish';
end;


end.
