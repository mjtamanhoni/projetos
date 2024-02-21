unit uCamera;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,


  {$Region '99 Coders'}
    uLoading,
    uFancyDialog,
    uActionSheet,
  {$EndRegion '99 Coders'}

  {$IFDEF ANDROID}
    {$Region 'ZXing'}
      ZXing.ScanManager,
      ZXing.ReadResult,
      ZXing.BarcodeFormat,
    {$EndRegion 'ZXing'}
  {$ENDIF}


  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Filter.Effects, FMX.Objects, FMX.Layouts, FMX.Media;

type
  TExecuteOnClose = procedure(ACodBarras:String) of Object;

  TfrmCamera = class(TForm)
    CameraComponent: TCameraComponent;
    rctFundo: TRectangle;
    lytDetail: TLayout;
    lytImagem: TLayout;
    imgFoto: TImage;
    SepiaEffect1: TSepiaEffect;
    MonochromeEffect1: TMonochromeEffect;
    imgTirarFoto: TImage;
    imgInverte: TImage;
    imgMenu: TImage;
    imgQrCode: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytFechar: TLayout;
    imgFechar: TImage;
    lytConfirmar: TLayout;
    imgConfirmar: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    lbErro: TLabel;
    procedure CameraComponentSampleBufferReady(Sender: TObject; const ATime: TMediaTime);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgInverteClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure imgQrCodeClick(Sender: TObject);
    procedure imgTirarFotoClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
  private
    FCancelado: Boolean;
    FCodigoBarras: String;

    {$IFDEF ANDROID}
      FScanManager: TScanManager;
      FScanInProgress: Boolean;
      FFrameTake: Integer;
    {$ENDIF}

    FMenu :TActionSheet;
    FMenuQualidade :TActionSheet;
    FMenuTipo :TActionSheet;


    procedure TipoImagem(Sender: TObject);
    procedure Qualidade(Sender: TObject);
    procedure Qualidade_Alta(Sender: TObject);
    procedure Qualidade_Media(Sender: TOBject);
    procedure Qualidade_Baixa(Sender: TObject);
    procedure Cor_TonsCinza(Sender: TObject);
    procedure Cor_Envelhecido(Sender: TObject);
    procedure Cor_Normal(Sender: TObject);

    {$IFDEF ANDROID}
      procedure QualityCamera(AQuality: TVideoCaptureQuality);
      procedure ProcesssarImagem;
    {$ENDIF}


    procedure SetCancelado(const Value: Boolean);
    procedure SetCodigoBarras(const Value: String);
  public
    ExecuteOnClose :TExecuteOnClose;

    property Cancelado :Boolean read FCancelado write SetCancelado;
    property CodigoBarras :String read FCodigoBarras write SetCodigoBarras;
  end;

var
  frmCamera: TfrmCamera;

implementation

{$R *.fmx}

{ TfrmCamera }

procedure TfrmCamera.CameraComponentSampleBufferReady(Sender: TObject; const ATime: TMediaTime);
begin
  {$IFDEF ANDROID}
    ProcesssarImagem;
  {$ENDIF}
end;

{$IFDEF ANDROID}
procedure TfrmCamera.ProcesssarImagem;
var
  lBitmap: TBitmap;
  ReadResult: TReadResult;
begin

  lbErro.Visible := False;
  CameraComponent.SampleBufferToBitmap(imgFoto.Bitmap, true);

  if imgQrCode.Tag= 1 then
  begin
    if FScanInProgress then
      Exit;

    inc(FFrameTake);

    if (FFrameTake mod 4 <> 0) then
      Exit;

    lBitmap := TBitmap.Create;
    lBitmap.Assign(imgFoto.Bitmap);
    ReadResult := nil;

    try
      FScanInProgress := true;

      try
        ReadResult := FScanManager.Scan(lBitmap);

        if ReadResult <> nil then
        begin
          CameraComponent.Active := false;
          CodigoBarras := ReadResult.text;
          ExecuteOnClose(CodigoBarras);
          Close;
        end;
        lbErro.Text := '';
      except
        on Ex:exception do
        begin
          //lbErro.Visible := True;
          lbErro.Text := Ex.Message;
        end;
      end;
    finally
      lBitmap.DisposeOf;
      ReadResult.DisposeOf;
      FScanInProgress := false;
    end;
  end;
end;
{$ENDIF}

procedure TfrmCamera.Cor_Envelhecido(Sender: TObject);
begin
  SepiaEffect1.Enabled := Not SepiaEffect1.Enabled;
  FMenuTipo.HideMenu;
end;

procedure TfrmCamera.Cor_Normal(Sender: TObject);
begin
  MonochromeEffect1.Enabled := False;
  SepiaEffect1.Enabled := False;
  FMenuTipo.HideMenu;
end;

procedure TfrmCamera.Cor_TonsCinza(Sender: TObject);
begin
  MonochromeEffect1.Enabled := NOT MonochromeEffect1.Enabled;
  FMenuTipo.HideMenu;
end;

procedure TfrmCamera.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmCamera := Nil;
end;

procedure TfrmCamera.FormCreate(Sender: TObject);
begin
  {$IFDEF ANDROID}
  FScanManager := TScanManager.Create(TBarcodeFormat.Auto,Nil);
  {$ENDIF}

  {$Region 'Menu Principal'}
    FMenu := TActionSheet.Create(frmCamera);
    FMenu.CancelMenuText := 'Cancelar';
    FMenu.CancelFontSize := 15;
    FMenu.CancelFontColor := $FFD63422;
    FMenu.AddItem('','Tipo da Imagem',TipoImagem,$FFD63422,16);
    FMenu.AddItem('','Qualidade',Qualidade,$FFD63422,16);
  {$EndRegion 'Menu de Principal'}

  {$Region 'Menu Qualidade'}
    FMenuQualidade := TActionSheet.Create(frmCamera);
    FMenuQualidade.CancelMenuText := 'Cancelar';
    FMenuQualidade.CancelFontSize := 15;
    FMenuQualidade.CancelFontColor := $FFD63422;
    FMenuQualidade.AddItem('','Alta',Qualidade_Alta,$FFD63422,16);
    FMenuQualidade.AddItem('','Media',Qualidade_Media,$FFD63422,16);
    FMenuQualidade.AddItem('','Baixa',Qualidade_Baixa,$FFD63422,16);
  {$EndRegion 'Menu Qualidade'}

  {$Region 'Menu Tipo de Cor'}
    FMenuTipo := TActionSheet.Create(frmCamera);
    FMenuTipo.CancelMenuText := 'Cancelar';
    FMenuTipo.CancelFontSize := 15;
    FMenuTipo.CancelFontColor := $FFD63422;
    FMenuTipo.AddItem('','Tons de cinza',Cor_TonsCinza,$FFD63422,16);
    FMenuTipo.AddItem('','Envelhecido',Cor_Envelhecido,$FFD63422,16);
    FMenuTipo.AddItem('','Normal',Cor_Normal,$FFD63422,16);
  {$EndRegion 'Menu Tipo de Cor'}
end;

procedure TfrmCamera.FormDestroy(Sender: TObject);
begin
  {$IFDEF ANDROID}
  FScanManager.DisposeOf;
  {$ENDIF}
end;

procedure TfrmCamera.FormShow(Sender: TObject);
begin
  {$IFDEF ANDROID}
  FFrameTake := 0;
  CameraComponent.Active := False;
  CameraComponent.Kind := TCameraKind.BackCamera;
  CameraComponent.FocusMode := TFocusMode.ContinuousAutoFocus;
  CameraComponent.Quality := TVideoCaptureQuality.MediumQuality;
  CameraComponent.Active := True;
  {$ENDIF}
end;

procedure TfrmCamera.imgFecharClick(Sender: TObject);
begin
  Cancelado := True;
  CameraComponent.Active := False;
  Close;
end;

procedure TfrmCamera.imgInverteClick(Sender: TObject);
begin
  CameraComponent.Active := False;

  if CameraComponent.Kind = TCameraKind.FrontCamera then
    CameraComponent.Kind := TCameraKind.BackCamera
  else
    CameraComponent.Kind := TCameraKind.FrontCamera;

  CameraComponent.Active := True;
end;

procedure TfrmCamera.imgMenuClick(Sender: TObject);
begin
  FMenu.ShowMenu;
end;

procedure TfrmCamera.imgQrCodeClick(Sender: TObject);
begin
  if imgQrCode.Tag = 0 then
  begin
    imgQrCode.Tag := 1;
    imgQrCode.Opacity := 1;
  end
  else
  begin
    imgQrCode.Tag := 0;
    imgQrCode.Opacity := 0.5;
  end;
end;

procedure TfrmCamera.imgTirarFotoClick(Sender: TObject);
begin
  Cancelado := True;
  CameraComponent.SampleBufferToBitmap(imgFoto.Bitmap, True);
  CameraComponent.Active := False;
  Close;
end;

procedure TfrmCamera.Qualidade(Sender: TObject);
begin
  FMenu.HideMenu;
  FMenuQualidade.ShowMenu;
end;

procedure TfrmCamera.Qualidade_Alta(Sender: TObject);
begin
  {$IFDEF ANDROID}
  QualityCamera(TVideoCaptureQuality.HighQuality);
  {$ENDIF}
  FMenuQualidade.HideMenu;
end;

procedure TfrmCamera.Qualidade_Baixa(Sender: TObject);
begin
  {$IFDEF ANDROID}
  QualityCamera(TVideoCaptureQuality.LowQuality);
  {$ENDIF}
  FMenuQualidade.HideMenu;
end;

procedure TfrmCamera.Qualidade_Media(Sender: TOBject);
begin
  {$IFDEF ANDROID}
  QualityCamera(TVideoCaptureQuality.MediumQuality);
  {$ENDIF}
  FMenuQualidade.HideMenu;
end;

{$IFDEF ANDROID}
procedure TfrmCamera.QualityCamera(AQuality: TVideoCaptureQuality);
begin
  CameraComponent.Active := False;
  CameraComponent.Quality := AQuality;
  CameraComponent.Active := True;
end;
{$ENDIF}

procedure TfrmCamera.SetCancelado(const Value: Boolean);
begin
  FCancelado := Value;
end;

procedure TfrmCamera.SetCodigoBarras(const Value: String);
begin
  FCodigoBarras := Value;
end;

procedure TfrmCamera.TipoImagem(Sender: TObject);
begin
  FMenu.HideMenu;
  FMenuTipo.ShowMenu;
end;

end.
