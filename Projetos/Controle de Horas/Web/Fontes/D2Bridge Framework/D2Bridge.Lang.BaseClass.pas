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

unit D2Bridge.Lang.BaseClass;

interface

uses
  System.Classes, System.SysUtils, System.JSON, System.IOUtils, System.Rtti, System.TypInfo,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  D2Bridge.Lang.Interfaces, D2Bridge.Lang.Term.BaseClass, Prism.JSONHelper;

type
 TD2BridgeLangBaseClass = class(TInterfacedPersistent, ID2BridgeLangBaseClass)
  private
   FD2BridgeLangCoreBaseClass: ID2BridgeLangCoreBaseClass;
   FD2BridgeLang: ID2BridgeLang;
   FD2BridgeTerm: ID2BridgeTerm;
   FJSONResourceLang: TJSONObject;
   FJSONLang: TJSONObject;
   FFormatSettings: TFormatSettings;
   procedure LoadJSONfromResource;
   procedure ProcessJSONLang;
   procedure PopuleFieldTerms;
  public
   constructor Create(AD2BridgeLangCoreBaseClass: ID2BridgeLangCoreBaseClass; AD2BridgeTermClass: TD2BridgeTermClass; AD2BridgeLang: ID2BridgeLang);
   destructor Destroy; override;

   function Translate(ATerm: string): string; overload; virtual;
  published
   function FormatSettings: TFormatSettings;

   function IsRTL: Boolean; virtual;
   function HTMLLangGeneric: string;

   function D2BridgeTerm: ID2BridgeTerm;
   function Translate(AContext: string; ATerm: string): string; overload; virtual;
 end;

implementation

Uses
 D2Bridge.Manager;

{ TD2BridgeLangBaseClass }

constructor TD2BridgeLangBaseClass.Create(AD2BridgeLangCoreBaseClass: ID2BridgeLangCoreBaseClass; AD2BridgeTermClass: TD2BridgeTermClass; AD2BridgeLang: ID2BridgeLang);
var
 RttiContext: TRttiContext;
 D2BridgeTermType: TRttiInstanceType;
 D2BridgeTermObject: TObject;
begin
 FD2BridgeLangCoreBaseClass:= AD2BridgeLangCoreBaseClass;

 if Supports(AD2BridgeTermClass, ID2BridgeTerm) then
 begin
  RttiContext := TRttiContext.Create;
  try
   D2BridgeTermType := RttiContext.GetType(AD2BridgeTermClass).AsInstance;
   D2BridgeTermObject := D2BridgeTermType.GetMethod('Create').Invoke(D2BridgeTermType.MetaclassType, [TObject(AD2BridgeLang)]).AsObject;
   Supports(D2BridgeTermObject, ID2BridgeTerm, FD2BridgeTerm);
  finally
   RttiContext.Free;
  end;
 end;

 FD2BridgeLang:= AD2BridgeLang;

 FFormatSettings:= TFormatSettings.Create(FD2BridgeLang.HTMLLang);
 FD2BridgeLang.DoConfigFormatSettings;

 LoadJSONfromResource;

 if FD2BridgeLangCoreBaseClass.ExportJSON and IsDebuggerPresent then
 begin
  FJSONLang:= TJSONObject.ParseJSONValue(FD2BridgeLangCoreBaseClass.JSONDefaultLang.ToJSON) as TJSONObject;
  ProcessJSONLang;
 end else
 begin

 end;

 PopuleFieldTerms;
end;

function TD2BridgeLangBaseClass.D2BridgeTerm: ID2BridgeTerm;
begin
 Result:= FD2BridgeTerm;
end;

destructor TD2BridgeLangBaseClass.Destroy;
begin

  inherited;
end;

function TD2BridgeLangBaseClass.FormatSettings: TFormatSettings;
begin
 Result:= FFormatSettings;
end;

function TD2BridgeLangBaseClass.HTMLLangGeneric: string;
begin
 result:= Copy(FD2BridgeLang.HTMLLang,1,2);
end;

function TD2BridgeLangBaseClass.IsRTL: Boolean;
begin
 result:= false;
end;

procedure TD2BridgeLangBaseClass.LoadJSONfromResource;
var
 ResInfo: HRSRC;
 ResStream: TResourceStream;
 JSONContent: TStringStream;
 JSONResouceName: String;
 sFile: TStringStream;
begin
 try
  {$REGION 'Embed JSON (Resource)'}
   if FD2BridgeLangCoreBaseClass.EmbedJSON then
   begin
    try
     JSONResouceName:= FD2BridgeLangCoreBaseClass.ResourcePrefix + StringReplace(FD2BridgeLang.HTMLLang, '-', '_', [rfReplaceAll]);
     ResInfo := FindResource(HInstance, PWideChar(JSONResouceName), RT_RCDATA);

     if ResInfo <> 0 then
     begin
      ResStream := TResourceStream.Create(HInstance, JSONResouceName, RT_RCDATA);

      JSONContent := TStringStream.Create('', TEncoding.UTF8);

      try
       JSONContent.CopyFrom(ResStream, ResStream.Size);

       JSONContent.Position := 0;

       FJSONResourceLang := TJSONObject.ParseJSONValue(JSONContent.DataString) as TJSONObject;
      finally
       JSONContent.Free;
      end;
     end else
      FJSONResourceLang:= FD2BridgeLangCoreBaseClass.JSONDefaultLang;
    finally
     ResStream.Free;
    end;
   end;
  {$ENDREGION}

  {$REGION 'Load JSON from File PATH'}
   if not FD2BridgeLangCoreBaseClass.EmbedJSON then
   begin
    if FileExists(FD2BridgeLangCoreBaseClass.PathJSON + FD2BridgeLang.HTMLLang + '.json') then
    begin
     sFile:= TStringStream.Create('', TEncoding.UTF8);
     sFile.LoadFromFile(FD2BridgeLangCoreBaseClass.PathJSON + FD2BridgeLang.HTMLLang + '.json');

     FJSONResourceLang := TJSONObject.ParseJSONValue(sFile.DataString) as TJSONObject;

     sFile.Clear;
     sFile.Free;
    end else
     FJSONResourceLang:= FD2BridgeLangCoreBaseClass.JSONDefaultLang;
   end;
  {$ENDREGION}
 except
  FJSONResourceLang := TJSONObject.Create;
 end;

end;

procedure TD2BridgeLangBaseClass.PopuleFieldTerms;
var
  Ctx: TRttiContext;
  Typ, TypContext: TRttiType;
  Meth: TRttiMethod;
  Field, FieldContext: TRttiField;
  ReturnValue: TValue;
  vTranslateResult: string;
begin
  try
    Ctx := TRttiContext.Create;

    try
      Typ := Ctx.GetType((FD2BridgeTerm as TD2BridgeTermClass).ClassType);

      for Field in Typ.GetDeclaredFields do
      begin
        if Field.Visibility = mvPublic then
        begin
         if Field.FieldType.TypeKind in [tkUString, tkWString, tkLString] then
         begin
          vTranslateResult:= FD2BridgeLang.Translate(Field.Name);
          if vTranslateResult = '' then
           vTranslateResult:= '{{_'+Field.Name+'_}}';

          Field.SetValue(TObject(FD2BridgeTerm), vTranslateResult);
         end else
         if Supports(Field.FieldType.AsInstance.MetaclassType, ID2BridgeTermItem) then
         begin
          ReturnValue:= Field.GetValue(TObject(FD2BridgeTerm));

          TypContext:= Ctx.GetType((ReturnValue.AsInterface as TObject).ClassType);

          for FieldContext in TypContext.GetDeclaredFields do
          begin
            if FieldContext.Visibility = mvPublic then
            begin
             if FieldContext.FieldType.TypeKind in [tkUString, tkWString, tkLString] then
             begin
              vTranslateResult:= FD2BridgeLang.Translate(Field.Name, FieldContext.Name);
              if vTranslateResult = '' then
               if Field.Name <> '' then
                vTranslateResult:= '{{_'+Field.Name+'.'+FieldContext.Name+'_}}'
               else
                vTranslateResult:= '{{_'+FieldContext.Name+'_}}';

              FieldContext.SetValue((ReturnValue.AsInterface as TObject), vTranslateResult);
             end;
            end;
          end;
         end;
        end;
      end;
    except

    end;
  except

  end;


end;

procedure TD2BridgeLangBaseClass.ProcessJSONLang;
var
 I, J: integer;
 vKey: string;
 vTranslatedText: string;
 vContext: string;
 vJSONLangContext, vJSONResourceLang: TJSONObject;
begin
 for I := 0 to Pred(FJSONLang.Count) do
 begin
  if FJSONLang.Pairs[I].JsonValue is TJSONObject then //Context
  begin
   vContext:= FJSONLang.Pairs[I].JsonString.Value;
   vJSONLangContext:= (FJSONLang.Pairs[I].JsonValue as TJSONObject);
   vJSONResourceLang:= (FJSONResourceLang.GetValue(vContext) as TJSONObject);
   if Assigned(vJSONResourceLang)  then
   for J := 0 to Pred(vJSONLangContext.Count) do
   begin
    vKey:= vJSONLangContext.Pairs[J].JsonString.Value;
    vJSONLangContext.Pairs[J].JsonValue := vJSONResourceLang.GetValue(vKey);
   end;
  end else
  begin
   vKey:= FJSONLang.Pairs[I].JsonString.Value;
   FJSONLang.Pairs[I].JsonValue:= FJSONResourceLang.GetValue(vKey);
  end;
 end;

 if not DirectoryExists(FD2BridgeLangCoreBaseClass.PathExportJSON) then
  TDirectory.CreateDirectory(FD2BridgeLangCoreBaseClass.PathExportJSON);

 if DirectoryExists(FD2BridgeLangCoreBaseClass.PathExportJSON) then
  TFile.WriteAllText(FD2BridgeLangCoreBaseClass.PathExportJSON+FD2BridgeLang.HTMLLang+'.json', FJSONLang.ToString, TEncoding.UTF8);
end;

function TD2BridgeLangBaseClass.Translate(ATerm: string): string;
begin
 result:= Translate(TD2BridgeTermBaseClass(FD2BridgeTerm).Context, ATerm);
end;

function TD2BridgeLangBaseClass.Translate(AContext, ATerm: string): string;
var
 vFJSONResourceLangContext: TJSONObject;
 vJSONExistTerm: boolean;
begin
 Result:= '';

 FD2BridgeLang.DoTranslate(AContext, ATerm, Result);

 if Result = '' then
  FD2BridgeLang.DoTranslate(ATerm, Result);

 if Result = '' then
 begin
  if AContext = '' then

  vJSONExistTerm:= false;

  if AContext <> '' then
  begin
   vFJSONResourceLangContext:= FJSONResourceLang.GetValue(AContext) as TJSONObject;
   if Assigned(vFJSONResourceLangContext) then
    if Assigned(vFJSONResourceLangContext.GetValue(ATerm)) then
    begin
     vJSONExistTerm:= true;
     Result:= vFJSONResourceLangContext.GetValue(ATerm).Value;
    end;
  end else
   if FJSONResourceLang.GetValue(ATerm) <> nil then
    if Assigned(FJSONResourceLang.GetValue(ATerm)) then
    begin
     vJSONExistTerm:= true;
     Result:= FJSONResourceLang.GetValue(ATerm).Value;
    end;

  if not vJSONExistTerm then
   FD2BridgeLangCoreBaseClass.IncludeLogMissing(AContext, ATerm);
 end;


end;

end.
