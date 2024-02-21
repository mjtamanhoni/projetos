unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uFuncoes,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani, FMX.Edit, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Effects, FMX.Objects, FMX.TabControl, FMX.Layouts;

type
  TfrmLogin = class(TForm)
    StyleBook_Principal: TStyleBook;
    imgNVer: TImage;
    imgVer: TImage;
    lytPrincipal: TLayout;
    tcLogin: TTabControl;
    tiUserSenha: TTabItem;
    lytLog: TLayout;
    rctLog: TRectangle;
    ShadowEffect1: TShadowEffect;
    imgLog: TImage;
    lytFooter: TLayout;
    lbCadastrar: TLabel;
    lytLogin: TLayout;
    lytUser: TLayout;
    edEmail_User: TEdit;
    lbEmail_User: TLabel;
    faEmail: TFloatAnimation;
    lytSenha: TLayout;
    edSenha: TEdit;
    lbSenha: TLabel;
    faSenha: TFloatAnimation;
    imgVerSenha: TImage;
    lytUserSenha_Confir: TLayout;
    rctConfirmar: TRectangle;
    lbConfirmar: TLabel;
    rctCancelar: TRectangle;
    lbCancelar: TLabel;
    tiPIN: TTabItem;
    tiBio: TTabItem;
    procedure edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edEmail_UserTyping(Sender: TObject);
    procedure edSenhaTyping(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgVerSenhaClick(Sender: TObject);
    procedure lbCadastrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses
  uUsuario;

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

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  if edEmail_User.CanFocus then
    edEmail_User.SetFocus;
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
