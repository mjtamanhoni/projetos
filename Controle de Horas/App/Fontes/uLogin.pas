unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uFuncoes,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.Layouts, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.Edit, FMX.Ani, FMX.StdCtrls;

type
  TfrmLogin = class(TForm)
    lytPrincipal: TLayout;
    tcLogin: TTabControl;
    tiUserSenha: TTabItem;
    tiPIN: TTabItem;
    tiBio: TTabItem;
    lytLog: TLayout;
    lytFooter: TLayout;
    lytLogin: TLayout;
    rctLog: TRectangle;
    ShadowEffect1: TShadowEffect;
    imgLog: TImage;
    lytUser: TLayout;
    lytSenha: TLayout;
    lytUserSenha_Confir: TLayout;
    StyleBook_Principal: TStyleBook;
    edEmail_User: TEdit;
    lbEmail_User: TLabel;
    faEmail: TFloatAnimation;
    edSenha: TEdit;
    lbSenha: TLabel;
    faSenha: TFloatAnimation;
    rctConfirmar: TRectangle;
    rctCancelar: TRectangle;
    lbCancelar: TLabel;
    lbConfirmar: TLabel;
    lbCadastrar: TLabel;
    imgVerSenha: TImage;
    imgVer: TImage;
    imgNVer: TImage;
    procedure edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edEmail_UserTyping(Sender: TObject);
    procedure edSenhaTyping(Sender: TObject);
    procedure imgVerSenhaClick(Sender: TObject);
    procedure lbCadastrarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FMensagem :TFancyDialog;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uUsuario;

procedure TfrmLogin.edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
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
  if not Assigned(frmUsuario) then
    Application.CreateForm(TfrmUsuario,frmUsuario);
  frmUsuario.Show;
end;

procedure TfrmLogin.rctCancelarClick(Sender: TObject);
begin
  Close;
end;

end.




{
CORES DO APP
  Verde Escuro: #FF363428
  Verde Claro: #FFA1B24E
  Componentes: #FFD9D7CA
}
