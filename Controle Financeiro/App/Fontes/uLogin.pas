unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.IOUtils,

  uFuncoes,
  IniFiles,
  uDM_Global,

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
    rctInformacoes: TRectangle;
    lytEmail: TLayout;
    lytSenha: TLayout;
    lytAcessarSist: TLayout;
    lytCadastrar: TLayout;
    imgConfig: TImage;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEmail_UserTyping(Sender: TObject);
    procedure edSenhaTyping(Sender: TObject);
    procedure imgVerSenhaClick(Sender: TObject);
    procedure lbCadastrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgConfigClick(Sender: TObject);
    procedure rctAcessarClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    procedure Config_URL(Sender: TOBject);
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation
{$R *.fmx}

uses
  uPerfil_Usuario,
  uConfig;

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
  {$IFDEF MSWINDOWS}
    FreeAndNil(FIniFile);
    FreeAndNil(FMensagem);
  {$ELSE}
    FIniFile.DisposeOf;
    FMensagem.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmLogin := Nil;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FMensagem := TFancyDialog.Create(frmLogin);
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\FINANCEIRO.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'FINANCEIRO.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  edEmail_User.Text := FIniFile.ReadString('LOGIN','EMAIL','');
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  lHost :String;
begin
  lHost := '';
  lHost := FIniFile.ReadString('SERVER','BASE_URL','');

  if edEmail_User.CanFocus then
    edEmail_User.SetFocus;

  if lHost = '' then
    FMensagem.Show(TIconDialog.Question,'Atenção','Não há URL de conexão com o Servidor configurada. Deseja configurar agora?','Sim',Config_URL,'Não');
end;

procedure TfrmLogin.Config_URL(Sender :TOBject);
begin
  if not Assigned(frmConfig) then
    Application.CreateForm(TfrmConfig,frmConfig);
  frmConfig.Show;
end;

procedure TfrmLogin.imgConfigClick(Sender: TObject);
begin
  if not Assigned(frmConfig) then
    Application.CreateForm(TfrmConfig,frmConfig);
  frmConfig.Show;
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

procedure TfrmLogin.rctAcessarClick(Sender: TObject);
begin
  try
    if Trim(edEmail_User.Text) = '' then
      raise Exception.Create('E-mail é obrigatório');
    if Trim(edEmail_User.Text) = '' then
      raise Exception.Create('Senha é obrigatória');

    if DM.Realizar_Login(edEmail_User.Text,edSenha.Text) then
    begin
      FMensagem.Show(TIconDialog.Success,'Atenção','Login Realizado','Ok');
      FIniFile.WriteString('LOGIN','EMAIL',edEmail_User.Text);
    end;
  except on E: Exception do
    FMensagem.Show(TIconDialog.Error,'Erro',E.Message,'Ok');
  end;
end;

end.


{
#FFEFEDE9 - Fundo dos Formulários
#FF363428 - Fundo Verde Escuro
#FFA1B24E - Fundo Verde Claro
}