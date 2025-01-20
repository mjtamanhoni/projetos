{$I D2Bridge.inc}

unit D2Bridge.Lang.Core.BaseClass;

interface

uses
  System.Classes, System.SysUtils, System.Rtti, System.JSON,
  D2Bridge.Types, D2Bridge.Lang.Interfaces, D2Bridge.Lang.Term.BaseClass, D2Bridge.Lang.BaseClass,
  D2Bridge.Lang.Core.JSON;


type
 TD2BridgeLang = D2Bridge.Types.TD2BridgeLang;


type
 TD2BridgeLangClass = class of TD2BridgeLangCoreBaseClass;

 TD2BridgeLangCoreBaseClass = class(TInterfacedPersistent, ID2BridgeLangCoreBaseClass)
  private
   FD2BridgeTermClass: TD2BridgeTermClass;
   FJSONDefaultLang: TJSONObject;
   FLogMissing: TStrings;

   FPortuguese: ID2BridgeLang;
   FEnglish: ID2BridgeLang;
   FSpanish: ID2BridgeLang;
   FArabic: ID2BridgeLang;
   FItalian: ID2BridgeLang;
   FFrench: ID2BridgeLang;
   FGerman: ID2BridgeLang;
   FJapanese: ID2BridgeLang;
   FRussian: ID2BridgeLang;
   FChinese: ID2BridgeLang;
   FCzech: ID2BridgeLang;
   FTurkish: ID2BridgeLang;
   FKorean: ID2BridgeLang;

   FLanguages: TD2BridgeLangs;
   FPathExportJSON: string;
   FPathJSON: string;
   FResourcePrefix: string;
   FExportJSON: boolean;
   FEmbedJSON: boolean;
   function GetPortuguese: ID2BridgeLang;
   procedure SetPortuguese(Avalue: ID2BridgeLang);
   function GetEnglish: ID2BridgeLang;
   procedure SetEnglish(AValue: ID2BridgeLang);
   function GetSpanish: ID2BridgeLang;
   procedure SetSpanish(AValue: ID2BridgeLang);
   function GetArabic: ID2BridgeLang;
   procedure SetArabic(AValue: ID2BridgeLang);
   function GetItalian: ID2BridgeLang;
   function GetFrench: ID2BridgeLang;
   function GetGerman: ID2BridgeLang;
   function GetJapanese: ID2BridgeLang;
   function GetRussian: ID2BridgeLang;
   function GetChinese: ID2BridgeLang;
   function GetKorean: ID2BridgeLang;
   function GetTurkish: ID2BridgeLang;
   procedure SetKorean(const Value: ID2BridgeLang);
   procedure SetTurkish(const Value: ID2BridgeLang);
   procedure SetItalian(AValue: ID2BridgeLang);
   procedure SetFrench(AValue: ID2BridgeLang);
   procedure SetGerman(AValue: ID2BridgeLang);
   procedure SetJapanese(AValue: ID2BridgeLang);
   procedure SetRussian(AValue: ID2BridgeLang);
   procedure SetChinese(AValue: ID2BridgeLang);
   function GetCzech: ID2BridgeLang;
   procedure SetCzech(Avalue: ID2BridgeLang);
   function GetLanguages: TD2BridgeLangs;
   procedure SetLanguages(SetOfLanguages: TD2BridgeLangs);
   function GetPathJSON: string;
   procedure SetPathJSON(Value: string);
   function GetPathExportJSON: string;
   procedure SetPathExportJSON(Value: string);
   function GetResourcePrefix: string;
   procedure SetResourcePrefix(Value: string);
   function GetExportJSON: boolean;
   procedure SetExportJSON(Value: boolean);
   function GetEmbedJSON: boolean;
   procedure SetEmbedJSON(Value: boolean);

   function D2BridgeLangByTD2BridgeLang(ALang: TD2BridgeLang): ID2BridgeLang;
  public
   constructor Create(ATranslateClass: TD2BridgeTermClass); virtual;
   destructor Destroy; override;

   function LangByTD2BridgeLang(ALang: TD2BridgeLang): ID2BridgeTerm;
   function LangByHTMLLang(ALang: string): ID2BridgeTerm;
   function LangByBrowser(ALangCommaText: string): ID2BridgeTerm;

   procedure CreateJSONDefaultLang;
   Function JSONDefaultLang: TJSONObject;
   procedure IncludeLogMissing(AContext: string; ATerm: string; AInformation: string = '');

   property Portuguese: ID2BridgeLang read GetPortuguese write SetPortuguese;
   property English: ID2BridgeLang read GetEnglish write SetEnglish;
   property Spanish: ID2BridgeLang read GetSpanish write SetSpanish;
   property Arabic: ID2BridgeLang read GetArabic write SetArabic;
   property Italian: ID2BridgeLang read GetItalian write SetItalian;
   property French: ID2BridgeLang read GetFrench write SetFrench;
   property German: ID2BridgeLang read GetGerman write SetGerman;
   property Japanese: ID2BridgeLang read GetJapanese write SetJapanese;
   property Russian: ID2BridgeLang read GetRussian write SetRussian;
   property Chinese: ID2BridgeLang read GetChinese write SetChinese;
   property Czech: ID2BridgeLang read GetCzech write SetCzech;
   property Turkish: ID2BridgeLang read GetTurkish write SetTurkish;
   property Korean: ID2BridgeLang read GetKorean write SetKorean;

   property Languages: TD2BridgeLangs read GetLanguages write SetLanguages;

   property PathExportJSON: string read GetPathExportJSON write SetPathExportJSON;
   property PathJSON: string read GetPathJSON write SetPathJSON;
   property ResourcePrefix: string read GetResourcePrefix write SetResourcePrefix;
   property ExportJSON: boolean read GetExportJSON write SetExportJSON;
   property EmbedJSON: boolean read GetEmbedJSON write SetEmbedJSON;
 end;



implementation

uses
  System.IOUtils,
  D2Bridge.Lang.Portuguese, D2Bridge.Lang.English, D2Bridge.Lang.Spanish, D2Bridge.Lang.Arabic,
  D2Bridge.Lang.Italian, D2Bridge.Lang.French, D2Bridge.Lang.German, D2Bridge.Lang.Japanese,
  D2Bridge.Lang.Russian, D2Bridge.Lang.Chinese, D2Bridge.Lang.Czech, D2Bridge.Lang.Turkish,
  D2Bridge.Lang.Korean;


{ TD2BridgeLangCoreBaseClass }

constructor TD2BridgeLangCoreBaseClass.Create(ATranslateClass: TD2BridgeTermClass);
begin
 FD2BridgeTermClass:= ATranslateClass;
 FPathJSON:= 'lang\';
 FPathExportJSON:= 'LangExport\';
 FResourcePrefix:= 'D2Bridge_Lang_';
 FExportJSON:= true;
 FEmbedJSON:= true;

 FLogMissing:= TStringList.Create;
 FLogMissing.Add('D2Bridge Framework');
 FLogMissing.Add('https://www.d2bridge.com.br');
 FLogMissing.Add('by Talis Jonatas Gomes');
 FLogMissing.Add('Date '+DateTimeToStr(Now));
 FLogMissing.Add('');
 FLogMissing.Add('Context and Term Missing');

 try
  //Delete old file
  if DirectoryExists(PathExportJSON) then
   if FileExists(PathExportJSON + 'LogLangMissing.txt') then
    DeleteFile(PathExportJSON + 'LogLangMissing.txt');
 except

 end;
end;

procedure TD2BridgeLangCoreBaseClass.CreateJSONDefaultLang;
var
 RttiContext: TRttiContext;
 D2BridgeTermType: TRttiInstanceType;
 D2BridgeTermObject: TObject;
begin
 if Supports(FD2BridgeTermClass, ID2BridgeTerm) then
 begin
  RttiContext := TRttiContext.Create;
  try
   D2BridgeTermType := RttiContext.GetType(FD2BridgeTermClass).AsInstance;
   D2BridgeTermObject := D2BridgeTermType.GetMethod('Create').Invoke(D2BridgeTermType.MetaclassType, [nil]).AsObject;

  finally
   RttiContext.Free;
  end;
 end;

 try
  GenerateJSON(D2BridgeTermObject, FJSONDefaultLang);
 finally
  D2BridgeTermObject.Destroy;
 end;

end;

function TD2BridgeLangCoreBaseClass.D2BridgeLangByTD2BridgeLang(
  ALang: TD2BridgeLang): ID2BridgeLang;
begin
 case ALang of
  TD2BridgeLang.Portuguese :
    Result:= Portuguese;
  TD2BridgeLang.English :
    Result:= English;
  TD2BridgeLang.Spanish :
    Result:= Spanish;
  TD2BridgeLang.Arabic :
    Result:= Arabic;
  TD2BridgeLang.Italian :
    Result:= Italian;
  TD2BridgeLang.French :
    Result:= French;
  TD2BridgeLang.German :
    Result:= German;
  TD2BridgeLang.Japanese :
    Result:= Japanese;
  TD2BridgeLang.Russian :
    Result:= Russian;
  TD2BridgeLang.Chinese :
    Result:= Chinese;
  TD2BridgeLang.Czech :
    Result:= Czech;
  TD2BridgeLang.Turkish :
    Result:= Turkish;
  TD2BridgeLang.Korean :
    Result:= Korean;
 end;
end;

destructor TD2BridgeLangCoreBaseClass.Destroy;
begin
 FreeAndNil(FLogMissing);

 inherited;
end;

function TD2BridgeLangCoreBaseClass.GetArabic: ID2BridgeLang;
begin
 Result:= FArabic;
end;

function TD2BridgeLangCoreBaseClass.GetChinese: ID2BridgeLang;
begin
 Result:= FChinese;
end;

function TD2BridgeLangCoreBaseClass.GetCzech: ID2BridgeLang;
begin
 result:= FCzech;
end;

function TD2BridgeLangCoreBaseClass.GetEmbedJSON: boolean;
begin
 Result:= FEmbedJSON;
end;

function TD2BridgeLangCoreBaseClass.GetEnglish: ID2BridgeLang;
begin
 Result:= FEnglish;
end;

function TD2BridgeLangCoreBaseClass.GetExportJSON: boolean;
begin
 result:= FExportJSON;
end;

function TD2BridgeLangCoreBaseClass.GetFrench: ID2BridgeLang;
begin
 Result:= FFrench;
end;

function TD2BridgeLangCoreBaseClass.GetGerman: ID2BridgeLang;
begin
 Result:= FGerman;
end;

function TD2BridgeLangCoreBaseClass.GetItalian: ID2BridgeLang;
begin
 Result:= FItalian;
end;

function TD2BridgeLangCoreBaseClass.GetJapanese: ID2BridgeLang;
begin
 Result:= FJapanese;
end;

function TD2BridgeLangCoreBaseClass.GetKorean: ID2BridgeLang;
begin
 result:= FKorean;
end;

function TD2BridgeLangCoreBaseClass.GetLanguages: TD2BridgeLangs;
begin
 Result:= FLanguages;
end;

function TD2BridgeLangCoreBaseClass.GetPathExportJSON: string;
begin
 Result:= FPathExportJSON;
end;

function TD2BridgeLangCoreBaseClass.GetPathJSON: string;
begin
 result:= FPathJSON;
end;

function TD2BridgeLangCoreBaseClass.GetPortuguese: ID2BridgeLang;
begin
 Result:= FPortuguese;
end;

function TD2BridgeLangCoreBaseClass.GetResourcePrefix: string;
begin
 Result:= FResourcePrefix;
end;

function TD2BridgeLangCoreBaseClass.GetRussian: ID2BridgeLang;
begin
 Result:= FRussian;
end;

function TD2BridgeLangCoreBaseClass.GetSpanish: ID2BridgeLang;
begin
 Result:= FSpanish;
end;

function TD2BridgeLangCoreBaseClass.GetTurkish: ID2BridgeLang;
begin
 result:= FTurkish;
end;

procedure TD2BridgeLangCoreBaseClass.IncludeLogMissing(AContext: string; ATerm: string; AInformation: string = '');
var
 vLogLine: string;
begin
 vLogLine:= '[Context: '+AContext+'] '+'[Term: '+ATerm+']  '+AInformation;

 if AnsiPos(vLogLine, FLogMissing.Text) <= 0 then
 begin
  FLogMissing.Add(vLogLine);

  try
   if not DirectoryExists(PathExportJSON) then
    TDirectory.CreateDirectory(PathExportJSON);

   ForceDirectories('\'+PathExportJSON);

   if DirectoryExists(PathExportJSON) then
    FLogMissing.SaveToFile(PathExportJSON + 'LogLangMissing.txt');
  except

  end;
 end;
end;


function TD2BridgeLangCoreBaseClass.JSONDefaultLang: TJSONObject;
begin
 Result:= FJSONDefaultLang;
end;

function TD2BridgeLangCoreBaseClass.LangByBrowser(ALangCommaText: string): ID2BridgeTerm;
var
 vLangs: TStrings;
 I: Integer;
begin
 vLangs:= TStringList.Create;

 try
  try
   vLangs.CommaText:= ALangCommaText;

   for I := Pred(vLangs.Count) downto 0 do
   begin
    if Pos('q=', vLangs.Strings[I]) > 0 then
    begin
     vLangs.Strings[I]:= Copy(vLangs.Strings[I], 0, Pos(';',vLangs.Strings[I])-1);
    end;
   end;


   for I := 0 to Pred(vLangs.Count) do
   if Assigned(LangByHTMLLang(vLangs.Strings[I])) then
   begin
    Result:= LangByHTMLLang(vLangs.Strings[I]);
    Break;
   end;

   if not Assigned(Result) then
    Result:= LangByTD2BridgeLang(TD2BridgeLang.English);

  except

  end;
 finally
  vLangs.Free;
 end;
end;


function TD2BridgeLangCoreBaseClass.LangByHTMLLang(
  ALang: string): ID2BridgeTerm;
var
 vLang: TD2BridgeLang;
 vD2BridgeTerm: ID2BridgeTerm;
begin
 for vLang := Low(TD2BridgeLang) to High(TD2BridgeLang) do
 begin
  vD2BridgeTerm:= LangByTD2BridgeLang(vLang);

  if Assigned(vD2BridgeTerm) then
  begin
   if SameText(vD2BridgeTerm.Language.HTMLLang, ALang)  then
   begin
    result:= vD2BridgeTerm;
    break;
   end else
   if SameText(vD2BridgeTerm.Language.HTMLLangGeneric, ALang)  then
   begin
    result:= vD2BridgeTerm;
    break;
   end;
  end;
 end;
end;

function TD2BridgeLangCoreBaseClass.LangByTD2BridgeLang(
  ALang: TD2BridgeLang): ID2BridgeTerm;
var
 vD2BridgeLang: ID2BridgeLang;
begin
 vD2BridgeLang:= D2BridgeLangByTD2BridgeLang(ALang);

 if Assigned(vD2BridgeLang) then
  Result:= D2BridgeLangByTD2BridgeLang(ALang).D2BridgeTerm;
end;


procedure TD2BridgeLangCoreBaseClass.SetArabic(AValue: ID2BridgeLang);
begin
 FArabic:= Avalue;

 Include(FLanguages, TD2BridgeLang.Arabic);
end;

procedure TD2BridgeLangCoreBaseClass.SetChinese(AValue: ID2BridgeLang);
begin
 FChinese:= AValue;

 Include(FLanguages, TD2BridgeLang.Chinese);
end;

procedure TD2BridgeLangCoreBaseClass.SetCzech(Avalue: ID2BridgeLang);
begin
 FCzech:= AValue;

 Include(FLanguages, TD2BridgeLang.Czech);
end;

procedure TD2BridgeLangCoreBaseClass.SetEmbedJSON(Value: boolean);
begin
 FEmbedJSON:= Value;
end;

procedure TD2BridgeLangCoreBaseClass.SetEnglish(AValue: ID2BridgeLang);
begin
 FEnglish:= AValue;

 Include(FLanguages, TD2BridgeLang.English);
end;

procedure TD2BridgeLangCoreBaseClass.SetExportJSON(Value: boolean);
begin
 FExportJSON:= Value;
end;

procedure TD2BridgeLangCoreBaseClass.SetFrench(AValue: ID2BridgeLang);
begin
 FFrench:= AValue;

 Include(FLanguages, TD2BridgeLang.French);
end;

procedure TD2BridgeLangCoreBaseClass.SetGerman(AValue: ID2BridgeLang);
begin
 FGerman:= AValue;

 Include(FLanguages, TD2BridgeLang.German);
end;

procedure TD2BridgeLangCoreBaseClass.SetItalian(AValue: ID2BridgeLang);
begin
 FItalian:= AValue;

 Include(FLanguages, TD2BridgeLang.Italian);
end;

procedure TD2BridgeLangCoreBaseClass.SetJapanese(AValue: ID2BridgeLang);
begin
 FJapanese:= AValue;

 Include(FLanguages, TD2BridgeLang.Japanese);
end;

procedure TD2BridgeLangCoreBaseClass.SetKorean(const Value: ID2BridgeLang);
begin
 FKorean:= Value;
end;

procedure TD2BridgeLangCoreBaseClass.SetLanguages(
  SetOfLanguages: TD2BridgeLangs);
var
 vLang: TD2BridgeLang;
 vD2BridgeLang: ID2BridgeLang;
begin
 if (not Assigned(FJSONDefaultLang)) or (FJSONDefaultLang.Count <= 0) then
  CreateJSONDefaultLang;

 FLanguages:= SetOfLanguages;

 for vLang := Low(TD2BridgeLang) to High(TD2BridgeLang) do
  if vLang in FLanguages then
  begin
   vD2BridgeLang:= D2BridgeLangByTD2BridgeLang(vLang);

   if Not Assigned(vD2BridgeLang) then
   begin
    case vLang of
     TD2BridgeLang.Portuguese :
       FPortuguese := TD2BridgeLangPortuguese.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.English :
       FEnglish := TD2BridgeLangEnglish.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Spanish :
       FSpanish := TD2BridgeLangSpanish.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Arabic :
       FArabic := TD2BridgeLangArabic.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Italian :
       FItalian:= TD2BridgeLangItalian.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.French :
       FFrench:= TD2BridgeLangFrench.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.German :
       FGerman:= TD2BridgeLangGerman.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Japanese :
       FJapanese:= TD2BridgeLangJapanese.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Russian :
       FRussian:= TD2BridgeLangRussian.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Chinese :
       FChinese:= TD2BridgeLangChinese.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Czech :
       FCzech:= TD2BridgeLangCzech.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Turkish :
       FCzech:= TD2BridgeLangTurkish.Create(self, FD2BridgeTermClass);
     TD2BridgeLang.Korean :
       FCzech:= TD2BridgeLangKorean.Create(self, FD2BridgeTermClass);
    end;
   end;
 end;
end;

procedure TD2BridgeLangCoreBaseClass.SetPathExportJSON(Value: string);
begin
 FPathExportJSON:= Value;
end;

procedure TD2BridgeLangCoreBaseClass.SetPathJSON(Value: string);
begin
 FPathJSON:= Value;
end;

procedure TD2BridgeLangCoreBaseClass.SetPortuguese(Avalue: ID2BridgeLang);
begin
 FPortuguese:= AValue;

 Include(FLanguages, TD2BridgeLang.Portuguese);
end;

procedure TD2BridgeLangCoreBaseClass.SetResourcePrefix(Value: string);
begin
 FResourcePrefix:= Value;
end;

procedure TD2BridgeLangCoreBaseClass.SetRussian(AValue: ID2BridgeLang);
begin
 FRussian:= AValue;

 Include(FLanguages, TD2BridgeLang.Russian);
end;

procedure TD2BridgeLangCoreBaseClass.SetSpanish(AValue: ID2BridgeLang);
begin
 FSpanish:= AValue;

 Include(FLanguages, TD2BridgeLang.Spanish);
end;

procedure TD2BridgeLangCoreBaseClass.SetTurkish(const Value: ID2BridgeLang);
begin
 FTurkish:= Value;
end;

end.
