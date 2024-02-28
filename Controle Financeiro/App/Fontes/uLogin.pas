unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uFuncoes,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.Ani, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Effects;

type
  TfrmLogin = class(TForm)
    lytBarraLateral: TLayout;
    rctBarraLateral: TRectangle;
    rctBarraLateral_Direita: TRectangle;
    Circle_Logo_Externo: TCircle;
    Circle_Logo_Interno: TCircle;
    imgLogo: TImage;
    StyleBook_Principal: TStyleBook;
    edEmail_User: TEdit;
    lbEmail_User: TLabel;
    faEmail: TFloatAnimation;
    edSenha: TEdit;
    lbSenha: TLabel;
    faSenha: TFloatAnimation;
    imgVerSenha: TImage;
    lytAcessar: TLayout;
    rctAcessar: TRectangle;
    lbAcessar: TLabel;
    imgFechar: TImage;
    lbCadastrar: TLabel;
    imgNVer: TImage;
    imgVer: TImage;
    GlowEffect1: TGlowEffect;
    GlowEffect2: TGlowEffect;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEmail_UserTyping(Sender: TObject);
    procedure edSenhaTyping(Sender: TObject);
    procedure imgVerSenhaClick(Sender: TObject);
    procedure lbCadastrarClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses
  uPerfil_Usuario;

procedure TfrmLogin.edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edSenha);
end;

procedure TfrmLogin.edEmail_UserTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail_User,lbEmail_User,faEmail,10,-20);
end;

procedure TfrmLogin.edSenhaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edSenha,lbSenha,faSenha,10,-20);
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmLogin := Nil;
end;

procedure TfrmLogin.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.imgVerSenhaClick(Sender: TObject);
begin
  case imgVerSenha.Tag of
    0:begin
      imgVerSenha.Bitmap := imgNVer.Bitmap;
      edSenha.Password := False;
      imgVerSenha.Tag := 1;
    end;
    1:begin
      imgVerSenha.Bitmap := imgVer.Bitmap;
      edSenha.Password := True;
      imgVerSenha.Tag := 0;
    end;
  end;
end;

procedure TfrmLogin.lbCadastrarClick(Sender: TObject);
begin
  if not Assigned(frmPerfilUsuario) then
    Application.CreateForm(TfrmPerfilUsuario,frmPerfilUsuario);
  frmPerfilUsuario.Show;
end;

end.


{
#FFEFEDE9 - Fundo dos Formulários
#FF363428 - Fundo Verde Escuro
#FFA1B24E - Fundo Verde Claro
}