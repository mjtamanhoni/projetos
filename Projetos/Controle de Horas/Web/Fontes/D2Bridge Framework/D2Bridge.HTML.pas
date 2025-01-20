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

unit D2Bridge.HTML;

interface

uses
  System.Classes, System.Generics.Collections;

type
 TD2BridgeGenericHTMLControl = record
  Name: string;
  NamePrefix: string;
  HTMLText: string;
 end;

type
 TD2BridgeHTMLControlsEvent = procedure(AName: String; ANamePrefix: String; HTMLText: String) of Object;

 TD2BridgeHTML = class
  strict private
   type
    HTMLRender = class
     private
      FD2BridgeHTML: TD2BridgeHTML;
      FOnAddHTMLControls: TD2BridgeHTMLControlsEvent;
      FTitle: string;
      FMeta: TStringList;
      FHeaders: TStringList;
      FStyles: TStringList;
      FScript: TStringList;
      FBody: TStringList;
      FBodyCSS: string;
      FBodyStyle: string;
      FBodyExtras: string;
      FHTMLControls: TDictionary<string, TD2BridgeGenericHTMLControl>;
        FBackGroundColor: string;
      function MakeHTML: TStringList;
     public
       constructor Create(AD2BridgeHTML: TD2BridgeHTML);
       destructor Destroy; override;

       procedure Clear;

       procedure AddHTMLControls(AName: String; ANamePrefix: String; HTMLText: String);
       function GetHTMLControls(AName: String): TD2BridgeGenericHTMLControl; overload;
       function GetHTMLControls(Index: Integer): TD2BridgeGenericHTMLControl; overload;
       function GetHTMLControlsName(Index: Integer): string;
       function CountHTMLControls: Integer;
       function HTMLControls: TDictionary<string, TD2BridgeGenericHTMLControl>;
       procedure RemoveHTMLControlToBody(AName: String);
       function idDIVContent: string;
       function idDIVContainer: string;

       property HTMLText: TStringList read MakeHTML;
       property Title: string read FTitle write FTitle;
       property Meta: TStringList read FMeta write FMeta;
       property Headers: TStringList read FHeaders write FHeaders;
       property Styles: TStringList read FStyles write FStyles;
       property Body: TStringList read FBody write FBody;
       property BodyCSS: string read FBodyCSS write FBodyCSS;
       property BodyStyle: string read FBodyStyle write FBodyStyle;
       property BackGroundColor: string read FBackGroundColor write FBackGroundColor;
       property BodyExtras: string read FBodyExtras write FBodyExtras;
       property Script: TStringList read FScript write FScript;

       property OnAddHTMLControls: TD2BridgeHTMLControlsEvent read FOnAddHTMLControls write FOnAddHTMLControls;
    end;
   type
    HTMLOptions = class
     private
      FHTMLTags: Boolean;
      FIncluseBootStrap: Boolean;
      FIncludeCharSet: Boolean;
      FIncludeViewPort: Boolean;
      FIncludeDIVContainer: Boolean;
      FValidateAllControls: Boolean;
     public
      Property IncluseHTMLTags: Boolean read FHTMLTags write FHTMLTags default false;
      Property IncluseBootStrap: Boolean read FIncluseBootStrap write FIncluseBootStrap default false;
      Property IncludeCharSet: Boolean read FIncludeCharSet write FIncludeCharSet default false;
      Property IncludeViewPort: Boolean read FIncludeViewPort write FIncludeViewPort default false;
      Property IncludeDIVContainer: Boolean read FIncludeDIVContainer write FIncludeDIVContainer default false;
      property ValidateAllControls: Boolean read FValidateAllControls write FValidateAllControls default false;
    end;
  private
   FD2BridgeBaseClass: TObject;
   FOptions: HTMLOptions;
   FRender: HTMLRender;
   FStyleSheet: TStringList;
   FScript: TStringList;
  public
   constructor Create(AD2BridgeBaseClass: TObject);
   destructor Destroy; override;

   property StyleSheets: TStringList read FStyleSheet;
   property Scripts: TStringList read FScript;

   property Options: HTMLOptions read FOptions;
   property Render: HTMLRender read FRender;

 end;

const
 BackGroundColorDefault = '#f0f0f0';

implementation

uses
  System.SysUtils,
  D2Bridge.Manager, D2Bridge.BaseClass;

{ TD2BridgeHTML }

constructor TD2BridgeHTML.Create(AD2BridgeBaseClass: TObject);
begin
 FD2BridgeBaseClass:= AD2BridgeBaseClass;
 FOptions:= HTMLOptions.Create;
 FRender:= HTMLRender.Create(Self);
 FStyleSheet:= TStringList.Create;
 FScript:= TStringList.Create;
end;

destructor TD2BridgeHTML.Destroy;
begin
 FreeAndNil(FOptions);
 FreeAndNil(FRender);
 FreeAndNil(FStyleSheet);
 FreeAndNil(FScript);

 inherited;
end;



{ TD2BridgeHTML.HTMLRender }

procedure TD2BridgeHTML.HTMLRender.AddHTMLControls(AName, ANamePrefix,
  HTMLText: String);
var
 vGenericHTML: TD2BridgeGenericHTMLControl;
begin
 vGenericHTML:= Default(TD2BridgeGenericHTMLControl);
 vGenericHTML.Name:= AName;
 vGenericHTML.NamePrefix:= ANamePrefix;
 vGenericHTML.HTMLText:= HTMLText;

 FHTMLControls.Add(AName, vGenericHTML);

 if Assigned(OnAddHTMLControls) then
 begin
  OnAddHTMLControls(AName, ANamePrefix, HTMLText);
 end;

end;

procedure TD2BridgeHTML.HTMLRender.Clear;
begin
 FMeta.Clear;
// FHTMLText.Clear;
 FHeaders.Clear;
 FStyles.Clear;
 FScript.Clear;
 FBody.Clear;
 FHTMLControls.Clear;
end;

function TD2BridgeHTML.HTMLRender.CountHTMLControls: Integer;
begin
 Result:= FHTMLControls.Count;
end;

constructor TD2BridgeHTML.HTMLRender.Create(AD2BridgeHTML: TD2BridgeHTML);
begin
 FD2BridgeHTML:= AD2BridgeHTML;
 FMeta:= TStringList.Create;
// FHTMLText:= TStringList.Create;
 FHeaders:= TStringList.Create;
 FStyles:= TStringList.Create;
 FScript:= TStringList.Create;
 FBody:= TStringList.Create;
 FHTMLControls:= TDictionary<string, TD2BridgeGenericHTMLControl>.create;
end;

destructor TD2BridgeHTML.HTMLRender.Destroy;
begin
 FreeAndNil(FMeta);
// FreeAndNil(FHTMLText);
 FreeAndNil(FHeaders);
 FreeAndNil(FStyles);
 FreeAndNil(FScript);
 FreeAndNil(FBody);
 FHTMLControls.Clear;
 FreeAndNil(FHTMLControls);

 inherited;
end;

function TD2BridgeHTML.HTMLRender.GetHTMLControls(AName: String): TD2BridgeGenericHTMLControl;
begin
 FHTMLControls.TryGetValue(AName, Result);
end;

function TD2BridgeHTML.HTMLRender.GetHTMLControls(Index: Integer): TD2BridgeGenericHTMLControl;
begin
 Result:= FHTMLControls.Values.ToArray[Index];
end;

function TD2BridgeHTML.HTMLRender.GetHTMLControlsName(Index: Integer): string;
begin
 Result:= FHTMLControls.Keys.ToArray[Index];
end;

function TD2BridgeHTML.HTMLRender.HTMLControls: TDictionary<string, TD2BridgeGenericHTMLControl>;
begin
 result:= FHTMLControls;
end;

function TD2BridgeHTML.HTMLRender.idDIVContainer: string;
begin
 result:= 'form'+TD2BridgeClass(FD2BridgeHTML.FD2BridgeBaseClass).FormUUID+'container';
end;

function TD2BridgeHTML.HTMLRender.idDIVContent: string;
begin
 result:= 'form'+TD2BridgeClass(FD2BridgeHTML.FD2BridgeBaseClass).FormUUID;
end;

function TD2BridgeHTML.HTMLRender.MakeHTML: TStringList;
var _Title: String;
    vBackGroundColor: string;
begin
 Result:= TStringList.Create;

 _Title:= Title;
 if _Title = '' then
  if D2BridgeManager.ServerController.APPName <> '' then
   _Title:= D2BridgeManager.ServerController.APPName
  else
  _Title:= 'D2Bridge Framework - Delphi WEB';

 if FD2BridgeHTML.Options.IncluseHTMLTags then
  Result.Add('<!DOCTYPE html>');
 if FD2BridgeHTML.Options.IncluseHTMLTags then
 begin
  if Pos('ar-', TD2BridgeClass(FD2BridgeHTML.FD2BridgeBaseClass).LangNav.Language.HTMLLang) > 0 then
   Result.add('<html lang="' + TD2BridgeClass(FD2BridgeHTML.FD2BridgeBaseClass).LangCode + '" dir="rtl">')
  else
   Result.add('<html lang="' + TD2BridgeClass(FD2BridgeHTML.FD2BridgeBaseClass).LangNav.Language.HTMLLang + '">');
 end;

 {$REGION 'HEAD'}
 if FD2BridgeHTML.Options.IncluseHTMLTags then
 begin
  Result.add('<head>');
    Result.add('<title>'+_Title+'</title>');
    if FD2BridgeHTML.Options.IncludeCharSet then
    begin
     Result.add('<meta charset="utf-8"/>');
     Result.add('<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>');
    end;
    if FD2BridgeHTML.Options.IncludeViewPort then
     Result.add('<meta name="viewport" content="width=device-width, initial-scale=1"/>');
    Result.AddStrings(Meta);
    //Result.add('<link rel="stylesheet" type="text/css" href="css/style.css"/>');
    //Result.add('<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>');
//    Result.add('<link href="assets/css/feather.css" rel="stylesheet" type="text/css">');
    //Result.add('<link href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css" rel="stylesheet" type="text/css"/>');
    //Result.add('<link rel="stylesheet" type="text/css" href="css/ui.jqgrid-bootstrap5.css"/>');
    if FD2BridgeHTML.Options.IncluseBootStrap then
    Result.add('<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>');
    //Result.add('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">');
    //Result.add('<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> ');
    //Result.add('<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>');
    //if FD2BridgeHTML.Options.IncludeJQuery then
    // Result.add('<script src="js/jquery-3.6.4.min.js"></script>');
    //Result.add('<script src="js/jquery.jqgrid.min.js"></script>');
    //Custom Style Sheet
    Result.Add(FD2BridgeHTML.FStyleSheet.Text);
    Result.AddStrings(Headers);
    Result.AddStrings(Styles);
  Result.add('</head>');
 end;
 {$ENDREGION}

 {$REGION 'BODY'}
  if FD2BridgeHTML.Options.IncluseHTMLTags then
  begin
   vBackGroundColor := '';
   if (FBackGroundColor = '') and (pos('background-color', FBodyStyle) <= 0) then
    vBackGroundColor := 'background-color: '+BackGroundColorDefault+';';

   Result.add('<body class="d2bridgebody ' + FBodyCSS + '" ' + FBodyExtras + ' style="'+ Trim(FBodyStyle + ' ' + vBackGroundColor) + '">');

   if FD2BridgeHTML.Options.ValidateAllControls then
    Result.add('<div class="d2bridgecontent was-validated" id="' + idDIVContent + '">')
   else
    Result.add('<div class="d2bridgecontent" id="' + idDIVContent + '">');
  end;
  if FD2BridgeHTML.Options.IncludeDIVContainer then
  Result.add('<div class="d2bridgecontainer container-fluid" id="' + idDIVContainer + '">');
  Result.AddStrings(Body);
  if FD2BridgeHTML.Options.IncludeDIVContainer then
  Result.add('</div>');
  if FD2BridgeHTML.Options.FIncluseBootStrap then
  begin
   Result.Add('<script src="js/bootstrap.bundle.min.js"></script>');
  end;
  //Result.add('<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>');

  //Custom Scripts
  Result.Add(FD2BridgeHTML.FScript.Text);

  if FD2BridgeHTML.Options.IncluseHTMLTags then
  begin
   Result.add('</body>');
   Result.add('</div>');
  end;
 {$ENDREGION}

 if FD2BridgeHTML.Options.IncluseHTMLTags then
  Result.add('</html>');
end;

procedure TD2BridgeHTML.HTMLRender.RemoveHTMLControlToBody(AName: String);
var
 vPosInit, vPosEnd: Integer;
begin
 vPosInit:= AnsiPos('{%'+AnsiUpperCase(AName), AnsiUpperCase(Body.Text));

 if vPosInit > 0 then
 begin
  vPosEnd:= AnsiPos('%}', Copy(Body.Text, vPosInit + Length(AName) + 3));

  if vPosEnd > 0 then
  begin
   vPosEnd:= vPosEnd + vPosInit + Length(AName) + 3;
   Body.Text:= Copy(Body.Text, 1, vPosInit - 1) + Copy(Body.Text, vPosEnd + 2);
  end;
 end;
end;

end.
