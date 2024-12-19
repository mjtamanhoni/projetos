unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Effects, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  uPrincipal;

type
  TfrmLogin = class(TForm)
    lytDetail: TLayout;
    lytLogin: TLayout;
    edPIN: TEdit;
    OpenDialog: TOpenDialog;
    rctFooter: TRectangle;
    ShadowEffect2: TShadowEffect;
    rctVersao: TRectangle;
    lbVersaoPrincipal: TLabel;
    rctHeader: TRectangle;
    ShadowEffect1: TShadowEffect;
    lytTitulo: TLayout;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    imgLog: TImage;
    StyleBook_Principal: TStyleBook;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edPINChangeTracking(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
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
        //if FDm_Global.Valida_Pin(edPin.Text) then
        //begin
          if NOT Assigned(frmPrincipal) then
            Application.CreateForm(TfrmPrincipal,frmPrincipal);
          frmPrincipal.FUser_PIN := edPIN.Text;
          frmPrincipal.FUser_Id := 1; //Pegar o Código do Login...
          Application.MainForm := frmPrincipal;
          frmPrincipal.Show;
          Close;
        //end
        //else
        //  raise Exception.Create('PIN Inválido');
      end;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'Ok');
    end;
  finally
  end;

end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
  {$ELSE}
    FFancyDialog.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmLogin := Nil;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmLogin);
end;

procedure TfrmLogin.imgFecharClick(Sender: TObject);
begin
  Close;
end;

end.
