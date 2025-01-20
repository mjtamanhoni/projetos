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

unit Prism.CSS.Bootstrap.Button;

interface

uses
  System.Classes,
  Prism.Interfaces, Prism.Font.Awesome;


type
 TCSSButtonType = class;
 TCSSButonHeigth = class;
 TCSSButonWidth = class;


 {$REGION 'Button'}
  TButtonModel = class(TInterfacedPersistent, IButtonModel)
   private
    FCaption: string;
    FHint: string;
    FIdentity: string;
    FCSSButtonType: String;
    FCSSButtonIcon: string;
    FCSSButtonWidth: string;
    FCSSButtonHeigth: string;
    Function GetCSSButtonType: string;
    Procedure SetCSSButtonType(AValue: string);
    function GetCSSButtonHeigth: string;
    function GetCSSButtonIcon: string;
    function GetCSSButtonWidth: string;
    procedure SetCSSButtonHeigth(const Value: string);
    procedure SetCSSButtonIcon(const Value: string);
    procedure SetCSSButtonWidth(const Value: string);
    Function GetCaption: string;
    Procedure SetCaption(AValue: string);
    Function GetIdentity: string;
    Procedure SetIdentity(AValue: string);
    Function GetHint: string;
    Procedure SetHint(AValue: string);
   public
    property Caption: string read GetCaption write SetCaption;
    property Hint: string read GetHint write SetHint;
    property Identity: string read GetIdentity write SetIdentity;
    property CSSButtonType: String read GetCSSButtonType write SetCSSButtonType;
    property CSSButtonIcon: string read GetCSSButtonIcon write SetCSSButtonIcon;
    property CSSButtonWidth: string read GetCSSButtonWidth write SetCSSButtonWidth;
    property CSSButtonHeigth: string read GetCSSButtonHeigth write SetCSSButtonHeigth;
  end;



  TButtonModelClass = class
   private
    class Procedure SetDefaults(var AButtonModel: IButtonModel);
   public
    class var
     CSSButtonType: TCSSButtonType;
     CSSButonHeigth: TCSSButonHeigth;
     CSSButonWidth: TCSSButonWidth;
     CSSButtonIcon: TCSSFontAwesome;
    class Function Save: IButtonModel;
    class Function Edit: IButtonModel;
    class Function Delete: IButtonModel;
    class Function Cancel: IButtonModel;
    class Function Close: IButtonModel;
    class Function Search: IButtonModel;
    class Function Open: IButtonModel;
    class Function Select: IButtonModel;
    class Function Add: IButtonModel;
    class Function Options: IButtonModel;
    class Function Config: IButtonModel;
    class Function Menu: IButtonModel;
    class Function Refresh: IButtonModel;
    class Function Cut: IButtonModel;
    class Function Copy: IButtonModel;
    class Function Share: IButtonModel;
    class Function Power: IButtonModel;
    class Function Print: IButtonModel;
    class Function View: IButtonModel;
    class Function Upload: IButtonModel;
    class Function Download: IButtonModel;
  end;



//  TButtonModelClass = record
//   CSSButtonType: string;
//   CSSButtonIcon: string;
//   CSSButtonHeigth: string;
//   CSSButtonWidth: string;
//  end;
 {$ENDREGION}

 {$REGION 'Button Type'}
 TCSSButtonType = class
  private
    {$REGION 'Default'}
    type
     TCSSClassButtonTypeDefault = class
     const
      default = 'btn btn-default';
      primary = 'btn btn-primary';
      secondary = 'btn btn-secondary';
      success = 'btn btn-success';
      info = 'btn btn-info';
      warning = 'btn btn-warning';
      danger = 'btn btn-danger';
      link = 'btn btn-light btn-link';
    end;
    {$ENDREGION}

    {$REGION 'Pill'}
    type
     TCSSClassButtonTypePill = class
     const
      default = 'btn btn-default btn-pill';
      primary = 'btn btn-primary btn-pill';
      secondary = 'btn btn-secondary btn-pill';
      success = 'btn btn-success btn-pill';
      info = 'btn btn-info btn-pill';
      warning = 'btn btn-warning btn-pill';
      danger = 'btn btn-danger btn-pill';
    end;
    {$ENDREGION}

    {$REGION 'Outline'}
    type
     TCSSClassButtonTypeOutline = class
     const
      default = 'btn btn-outline-default';
      primary = 'btn btn-outline-primary';
      secondary = 'btn btn-outline-secondary';
      success = 'btn btn-outline-success';
      info = 'btn btn-outline-info';
      warning = 'btn btn-outline-warning';
      danger = 'btn btn-outline-danger';
    end;
    {$ENDREGION}

    {$REGION 'Ligth'}
    type
     TCSSClassButtonTypeLight = class
     const
      default = 'btn btn-default-light';
      primary = 'btn btn-primary-light';
      secondary = 'btn btn-secondary-light';
      success = 'btn btn-success-light';
      info = 'btn btn-info-light';
      warning = 'btn btn-warning-light';
      danger = 'btn btn-danger-light';
    end;
    {$ENDREGION}

    {$REGION 'Color'}
    type
     TCSSClassButtonTypeColor = class
      const
       blue = 'btn-blue';
       cian = 'btn-azure';
       indigo = 'btn-indigo';
       purple = 'btn-purple';
       pink = 'btn-pink';
       red = 'btn-red';
       orange = 'btn-orange';
       yellow = 'btn-yellow';
       lime = 'btn-lime';
       green = 'btn-green';
       tiffany = 'btn-teal';
       gray = 'btn-gray';
       dark = 'btn-gray-dark';
     end;
    {$ENDREGION}
  public
   class
   var
    Default: TCSSClassButtonTypeDefault;
    Pill: TCSSClassButtonTypePill;
    Outline: TCSSClassButtonTypeOutline;
    Light: TCSSClassButtonTypeLight;
    Color: TCSSClassButtonTypeColor;
  end;
 {$ENDREGION}


 {$REGION 'Heigth'}
 TCSSButonHeigth = class
 const
  small = 'btn-sm';
  large = 'btn-lg';
 end;
 {$ENDREGION}

 {$REGION 'Width'}
  TCSSButonWidth = class
  const
   softlarger = 'w-sx';
   large = 'w-sm';
   verylarge = 'w-md';
   extralarge = 'w-lg';
  end;
 {$ENDREGION}


implementation

uses
  D2Bridge.Instance;


{ TButtonModelClass }

class function TButtonModelClass.Add: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.success;
 Result.CSSButtonIcon:= TCSSFontAwesome.add;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionAdd;
 Result.Identity:= 'add';
end;

class function TButtonModelClass.Cancel: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.warning;
 Result.CSSButtonIcon:= TCSSFontAwesome.delete;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionCancel;
 Result.Identity:= 'cancel';
end;

class function TButtonModelClass.Close: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.warning;
 Result.CSSButtonIcon:= TCSSFontAwesome.close;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionClose;
 Result.Identity:= 'close';
end;

class function TButtonModelClass.Config: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.config;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionConfig;
 Result.Identity:= 'config';
end;

class function TButtonModelClass.Copy: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.copy;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionCopy;
 Result.Identity:= 'copy';
end;

class function TButtonModelClass.Cut: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.cut;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionCut;
 Result.Identity:= 'cut';
end;

class function TButtonModelClass.Delete: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.danger;
 Result.CSSButtonIcon:= TCSSFontAwesome.delete;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionDelete;
 Result.Identity:= 'delete';
end;

class function TButtonModelClass.Download: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.download;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionDownload;
 Result.Identity:= 'download';
end;

class function TButtonModelClass.Edit: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.edit;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionEdit;
 Result.Identity:= 'edit';
end;

class function TButtonModelClass.Menu: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.info;
 Result.CSSButtonIcon:= TCSSFontAwesome.menu;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionMenu;
 Result.Identity:= 'menu';
end;

class function TButtonModelClass.Open: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.open;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionOpen;
 Result.Identity:= 'open';
end;

class function TButtonModelClass.Options: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.options;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionOptions;
 Result.Identity:= 'options';
end;

class function TButtonModelClass.Power: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.danger;
 Result.CSSButtonIcon:= TCSSFontAwesome.power;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionPower;
 Result.Identity:= 'power';
end;

class function TButtonModelClass.Print: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.info;
 Result.CSSButtonIcon:= TCSSFontAwesome.print;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionPrint;
 Result.Identity:= 'print';
end;

class function TButtonModelClass.Refresh: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.refresh;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionRefresh;
 Result.Identity:= 'refresh';
end;

class function TButtonModelClass.Save: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.success;
 Result.CSSButtonIcon:= TCSSFontAwesome.save;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionSave;
 Result.Identity:= 'save';
end;

class function TButtonModelClass.Search: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.search;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionSearch;
 Result.Identity:= 'search';
end;

class function TButtonModelClass.Select: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.success;
 Result.CSSButtonIcon:= TCSSFontAwesome.select;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionSelect;
 Result.Identity:= 'select';
end;

class procedure TButtonModelClass.SetDefaults(var AButtonModel: IButtonModel);
begin
 AButtonModel:= TButtonModel.Create;
end;

class function TButtonModelClass.Share: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.share;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionShare;
 Result.Identity:= 'share';
end;

class function TButtonModelClass.Upload: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.primary;
 Result.CSSButtonIcon:= TCSSFontAwesome.upload;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionUpload;
 Result.Identity:= 'upload';
end;

class function TButtonModelClass.View: IButtonModel;
begin
 SetDefaults(Result);

 Result.CSSButtonType:= TCSSButtonType.Default.info;
 Result.CSSButtonIcon:= TCSSFontAwesome.view;
 Result.Caption:= D2BridgeInstance.PrismSession.LangNav.Button.CaptionView;
 Result.Identity:= 'view';
end;

{ TButtonModel }

function TButtonModel.GetCaption: string;
begin
 result:= FCaption;
end;

function TButtonModel.GetCSSButtonHeigth: string;
begin
 Result:= FCSSButtonHeigth;
end;

function TButtonModel.GetCSSButtonIcon: string;
begin
 Result:= FCSSButtonIcon;
end;

function TButtonModel.GetCSSButtonType: string;
begin
 Result:= FCSSButtonType;
end;

function TButtonModel.GetCSSButtonWidth: string;
begin
 Result:= FCSSButtonWidth;
end;

function TButtonModel.GetHint: string;
begin
 Result:= FHint;
end;

function TButtonModel.GetIdentity: string;
begin
 Result:= FIdentity;
end;

procedure TButtonModel.SetCaption(AValue: string);
begin
 FCaption:= AValue;
end;

procedure TButtonModel.SetCSSButtonHeigth(const Value: string);
begin
 FCSSButtonHeigth:= Value;
end;

procedure TButtonModel.SetCSSButtonIcon(const Value: string);
begin
 FCSSButtonIcon:= Value;
end;

procedure TButtonModel.SetCSSButtonType(AValue: string);
begin
 FCSSButtonType:= AValue;
end;

procedure TButtonModel.SetCSSButtonWidth(const Value: string);
begin
 FCSSButtonWidth:= Value;
end;

procedure TButtonModel.SetHint(AValue: string);
begin
 FHint:= AValue;
end;

procedure TButtonModel.SetIdentity(AValue: string);
begin
 FIdentity:= AValue;
end;

end.
