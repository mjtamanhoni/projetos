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

{$I ..\D2Bridge.inc}

unit Prism.Carousel;

interface

uses
  System.Classes, System.SysUtils, System.JSON, System.Generics.Collections, System.StrUtils,
  Prism.Forms.Controls, Prism.Interfaces, Prism.Types
{$IFDEF FMX}

{$ELSE}
  , Vcl.DBCtrls, Data.DB
{$ENDIF}
;


type
 TPrismCarousel = class(TPrismControl, IPrismCarousel)
{$IFNDEF FMX}
  strict private
   type
     TPrismCarouselDataLink = class(TFieldDataLink)
     private
       FPrismCarousel: TPrismCarousel;
       FDataActive: Boolean;
       FRecordCount: integer;
     public
       constructor Create(APrismCarousel: TPrismCarousel);
       procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
       procedure ActiveChanged; override;
     end;
{$ENDIF}
  private
   FAutoSlide: boolean;
   FInterval: integer;
   FShowButtons: boolean;
   FShowIndicator: boolean;
   FImageFiles: TList<string>;
{$IFNDEF FMX}
   FDataLink: TPrismCarouselDataLink;
{$ENDIF}
   FRefreshData: Boolean;
   FMaxRecords: integer;
   function GetAutoSlide: boolean;
   procedure SetAutoSlide(Value: boolean);
   function GetInterval: integer;
   procedure SetInterval(Value: integer);
   function GetShowButtons: boolean;
   procedure SetShowButtons(Value: boolean);
   function GetShowIndicator: boolean;
   procedure SetShowIndicator(Value: boolean);
{$IFNDEF FMX}
   procedure SetDataSource(const Value: TDataSource);
   function GetDataSource: TDataSource;
   procedure SetDataFieldImagePath(AValue: String);
   function GetDataFieldImagePath: String;
{$ENDIF}
   function GetMaxRecords: integer;
   Procedure SetMaxRecords(AMaxRecords: Integer);
   procedure UpdateData;
   function RenderCarouselHTMLContent: string;
   function QtyItems: integer;
   procedure PopuleImageFiles;
  protected
   procedure Initialize; override;
   procedure ProcessHTML; override;
   procedure UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean); override;
   procedure ProcessEventParameters(Event: IPrismControlEvent; Parameters: TStrings); override;
   procedure ProcessComponentState(const ComponentStateInfo: TJSONObject); override;
   function GetEnableComponentState: Boolean; override;
   function IsCarousel: Boolean; override;
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   function ImageFiles: TList<string>;

   property AutoSlide: boolean read GetAutoSlide write SetAutoSlide;
   property ShowButtons: boolean read GetShowButtons write SetShowButtons;
   property ShowIndicator: boolean read GetShowIndicator write SetShowIndicator;
   property Interval: integer read GetInterval write SetInterval;
{$IFNDEF FMX}
   property DataSource: TDataSource read GetDataSource write SetDataSource;
   property DataFieldImagePath: String read GetDataFieldImagePath write SetDataFieldImagePath;
{$ENDIF}
   property MaxRecords: Integer read GetMaxRecords write SetMaxRecords;
 end;



implementation

uses
  Prism.Util, D2Bridge.Util;


constructor TPrismCarousel.Create(AOwner: TComponent);
begin
 inherited;

 FImageFiles:= TList<string>.Create;
 FRefreshData:= false;
{$IFNDEF FMX}
 FDataLink:= TPrismCarouselDataLink.Create(Self);
{$ENDIF}
 FMaxRecords:= 25;
end;

destructor TPrismCarousel.Destroy;
begin
 FreeAndNil(FImageFiles);
{$IFNDEF FMX}
 FreeAndNil(FDataLink);
{$ENDIF}
 inherited;
end;

function TPrismCarousel.GetAutoSlide: boolean;
begin
 result:= FAutoSlide;
end;

{$IFNDEF FMX}
function TPrismCarousel.GetDataFieldImagePath: String;
begin
 Result:= FDataLink.FieldName;
end;

function TPrismCarousel.GetDataSource: TDataSource;
begin
 Result:= FDataLink.DataSource;
end;
{$ENDIF}

function TPrismCarousel.GetEnableComponentState: Boolean;
begin
 Result:= true;
end;

function TPrismCarousel.GetInterval: integer;
begin
 result:= FInterval;
end;

function TPrismCarousel.GetMaxRecords: integer;
begin
 result:= FMaxRecords;
end;

function TPrismCarousel.GetShowButtons: boolean;
begin
 result:= FShowButtons;
end;

function TPrismCarousel.GetShowIndicator: boolean;
begin
 result:= FShowIndicator;
end;

function TPrismCarousel.ImageFiles: TList<string>;
begin
 Result:= FImageFiles;
end;

procedure TPrismCarousel.Initialize;
begin
 inherited;
end;

function TPrismCarousel.IsCarousel: Boolean;
begin
 result:= true;
end;

procedure TPrismCarousel.PopuleImageFiles;
var
 vPos: integer;
begin
{$IFNDEF FMX}
  FImageFiles.Clear;

  if Assigned(FDataLink.DataSource) then
  if Assigned(FDataLink.DataSet) then
  if FDataLink.DataSet.Active then
  begin
   vPos:= FDataLink.DataSet.RecNo;
   FDataLink.DataSet.DisableControls;
   FDataLink.DataSet.First;

   try
    try
     repeat
      FImageFiles.Add(FDataLink.Field.AsString);
      FDataLink.DataSet.Next;
     until FDataLink.DataSet.Eof or (FImageFiles.Count = MaxRecords);
    except

    end;
   finally
    if Assigned(FDataLink.DataSource) then
    if Assigned(FDataLink.DataSet) then
    if FDataLink.DataSet.Active then
    begin
     FDataLink.DataSet.RecNo:= vPos;

     FDataLink.DataSet.EnableControls;
    end;
   end;
  end;
{$ENDIF}
end;

procedure TPrismCarousel.ProcessComponentState(const ComponentStateInfo: TJSONObject);
begin
 inherited;

end;

procedure TPrismCarousel.ProcessEventParameters(Event: IPrismControlEvent;
  Parameters: TStrings);
begin
  inherited;

end;

procedure TPrismCarousel.ProcessHTML;
begin
 inherited;

{$IFNDEF FMX}
 if Assigned(FDataLink.DataSource) and Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then
 begin
  PopuleImageFiles;
 end;
{$ENDIF}

 HTMLControl:= '<div '+HTMLCore;
 if AutoSlide then
  HTMLControl:= HTMLControl + ' data-bs-ride="carousel"';
 if Interval > 0 then
  HTMLControl:= HTMLControl + ' data-interval="' + IntToStr(Interval) + '"';

 HTMLControl:= HTMLControl + '>' + sLineBreak;

 HTMLControl:= HTMLControl + RenderCarouselHTMLContent + sLineBreak;

 HTMLControl:= HTMLControl + '</div>';
end;

function TPrismCarousel.QtyItems: integer;
begin
 result:= ImageFiles.Count;
end;

function TPrismCarousel.RenderCarouselHTMLContent: string;
var
 vHTMLContent: TStrings;
 I: integer;
begin
 vHTMLContent:= TStringList.Create;

 with vHTMLContent do
 begin
  if ShowIndicator and (QtyItems > 1) then
  begin
   Add('  <div id="'+AnsiUpperCase(NamePrefix)+'INDICATOR" class="d2bridgecarousel-indicators carousel-indicators">');
   for I := 0 to Pred(QtyItems) do
   begin
    Add('    <button type="button" data-bs-target="#'+AnsiUpperCase(NamePrefix)+'" data-bs-slide-to="' + IntToStr(I) + '" ' + ifThen(I = 0, 'class="active" ') +'aria-current="true" aria-label="Slide ' + IntToStr(I+1) + '"></button>');
   end;
   Add('  </div>');
  end;
  Add('  <div class="carousel-inner">');
  for I := 0 to Pred(QtyItems) do
  begin
   Add('    <div class="carousel-item ' + ifThen(I = 0, 'active') +'">');
   Add('      <img src="' + D2Bridge.Util.Base64ImageFromFile(ImageFiles[I]) + '" class="d2bridgecarousel-image d-block w-100" alt="">');
   Add('    </div>');
  end;
  Add('  </div>');
  if ShowButtons and (QtyItems > 1) then
  begin
   Add('  <button id="'+AnsiUpperCase(NamePrefix)+'BUTTONPREV" class="carousel-control-prev" type="button" data-bs-target="#'+AnsiUpperCase(NamePrefix)+'" data-bs-slide="prev">');
   Add('    <span class="carousel-control-prev-icon" aria-hidden="true"></span>');
   Add('    <span class="visually-hidden">Previous</span>');
   Add('  </button>');
   Add('  <button id="'+AnsiUpperCase(NamePrefix)+'BUTTONNEXT" class="carousel-control-next" type="button" data-bs-target="#'+AnsiUpperCase(NamePrefix)+'" data-bs-slide="next">');
   Add('    <span class="carousel-control-next-icon" aria-hidden="true"></span>');
   Add('    <span class="visually-hidden">Next</span>');
   Add('  </button>');
  end;
 end;

 result:= vHTMLContent.Text;

 vHTMLContent.Free;
end;

procedure TPrismCarousel.SetAutoSlide(Value: boolean);
begin
 FAutoSlide:= Value;
end;

{$IFNDEF FMX}
procedure TPrismCarousel.SetDataFieldImagePath(AValue: String);
begin
 FDataLink.FieldName:= AValue;
end;

procedure TPrismCarousel.SetDataSource(const Value: TDataSource);
begin
 if FDataLink.DataSource <> Value then
 begin
  if Assigned(FDataLink.DataSource) then
   FDataLink.DataSource.RemoveFreeNotification(Self);

  FDataLink.DataSource := Value;

  if Assigned(FDataLink.DataSource) then
    FDataLink.DataSource.FreeNotification(Self);
 end;
end;
{$ENDIF}

procedure TPrismCarousel.SetInterval(Value: integer);
begin
 FInterval:= Value;
end;

procedure TPrismCarousel.SetMaxRecords(AMaxRecords: Integer);
begin
 FMaxRecords:= AMaxRecords;
end;

procedure TPrismCarousel.SetShowButtons(Value: boolean);
begin
 FShowButtons:= Value;
end;

procedure TPrismCarousel.SetShowIndicator(Value: boolean);
begin
 FShowIndicator:= Value;
end;

procedure TPrismCarousel.UpdateData;
begin
 if (Assigned(Form)) and (Form.FormPageState = PageStateLoaded) and (not Form.ComponentsUpdating) then
 begin
  FRefreshData:= true;
 end;
end;

procedure TPrismCarousel.UpdateServerControls(var ScriptJS: TStrings; AForceUpdate: Boolean);
begin
 inherited;

 if (FRefreshData) or (AForceUpdate) then
 begin
  PopuleImageFiles;

  FRefreshData:= false;

  //ScriptJS.Add('document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]").innerHTML = '+ FormatValueHTML(RenderCarouselHTMLContent) +';');

  ScriptJS.Add('let temp'+AnsiUpperCase(NamePrefix)+' = document.querySelector("[id='+AnsiUpperCase(NamePrefix)+' i]");');
  ScriptJS.Add('temp'+AnsiUpperCase(NamePrefix)+'.innerHTML = ' + FormatValueHTML(RenderCarouselHTMLContent) +';');

  ScriptJS.Add('var carousel = new bootstrap.Carousel(temp'+AnsiUpperCase(NamePrefix)+');');
 end;
end;

{$IFNDEF FMX}
{ TPrismCarousel.TPrismCarouselDataLink }

procedure TPrismCarousel.TPrismCarouselDataLink.ActiveChanged;
begin
 inherited;

 if DataSet.Active then
 begin
  FRecordCount:= DataSet.RecordCount;

  if not FDataActive then
  begin
   FDataActive:= true;
   FPrismCarousel.UpdateData;
  end;
 end else
 begin
  FRecordCount:= -1;
  FDataActive:= false;
  FPrismCarousel.UpdateData;
 end;

end;

constructor TPrismCarousel.TPrismCarouselDataLink.Create(
  APrismCarousel: TPrismCarousel);
begin
 FPrismCarousel:= APrismCarousel;
 FDataActive:= false;
end;



procedure TPrismCarousel.TPrismCarouselDataLink.DataEvent(Event: TDataEvent;
  Info: NativeInt);
var
 vRecordCount: integer;
begin
 inherited;

 if FPrismCarousel.Form.FormPageState = PageStateLoaded then
 begin
  if (not FPrismCarousel.FRefreshData) and
     (Event in [deDataSetChange]) and
     (Dataset.State in [dsBrowse]) then
  begin
   vRecordCount:= DataSet.RecordCount;

   if (DataSet.RecordCount <> FRecordCount) then
   begin
    FRecordCount:= DataSet.RecordCount;
    FPrismCarousel.UpdateData;
   end;
  end;
 end;

end;
{$ENDIF}

end.
