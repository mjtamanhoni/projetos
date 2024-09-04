unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Edit,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  uPrincipal,
  uDm.Global;

type
  TfrmLogin = class(TForm)
    rctFooter: TRectangle;
    ShadowEffect2: TShadowEffect;
    Rectangle1: TRectangle;
    lbVersaoPrincipal: TLabel;
    rctHeader: TRectangle;
    ShadowEffect1: TShadowEffect;
    imgLog: TImage;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    lytTitulo: TLayout;
    lytDetail: TLayout;
    lytLogin: TLayout;
    StyleBook_Principal: TStyleBook;
    lbPIN: TLabel;
    edPIN: TEdit;
    OpenDialog: TOpenDialog;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edPINChangeTracking(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FDm_Global :TDM_Global;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.edPINChangeTracking(Sender: TObject);
begin
  try
    try
      if Length(edPin.Text) = 4 then
      begin
        if FDm_Global.Valida_Pin(edPin.Text) then
        begin
          if NOT Assigned(frmPrincipal) then
            Application.CreateForm(TfrmPrincipal,frmPrincipal);
          frmPrincipal.FUser_PIN := edPIN.Text;
          Application.MainForm := frmPrincipal;
          frmPrincipal.Show;
          Close;
        end
        else
          raise Exception.Create('PIN Inválido');
      end;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'Ok');
    end;
  finally
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);

  Action := TCloseAction.caFree;
  frmLogin := Nil;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmLogin);
  FDm_Global := TDM_Global.Create(Nil);
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  if edPIN.CanFocus then
    edPIN.SetFocus;
end;

procedure TfrmLogin.imgFecharClick(Sender: TObject);
begin
  Close;
end;

end.
