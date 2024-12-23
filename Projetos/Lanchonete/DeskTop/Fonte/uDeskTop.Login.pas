unit uDeskTop.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
  {$EndRegion}

  IniFiles,


  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.Ani, FMX.StdCtrls,
  FMX.TabControl,

  uDeskTop.Principal,
  uDeskTop.CadUsuario,
  uDm_DeskTop;

type
  TfrmLogin = class(TForm)
    lytHeader: TLayout;
    lytDetail: TLayout;
    lytFooter: TLayout;
    rctHeader: TRectangle;
    lytLogin_UserSenha: TLayout;
    StyleBook_Principal: TStyleBook;
    edLogin: TEdit;
    edSenha: TEdit;
    lbLogin: TLabel;
    lbSenha: TLabel;
    FloatAnimation_Senha: TFloatAnimation;
    FloatAnimation_Login: TFloatAnimation;
    rctFooter: TRectangle;
    lytSelecao: TLayout;
    tcPrincipal: TTabControl;
    tiUserSenha: TTabItem;
    tiPin: TTabItem;
    rctUserSenha: TRectangle;
    rctPin: TRectangle;
    lytPin: TLayout;
    edPin: TEdit;
    lbPin: TLabel;
    FloatAnimation_Pin: TFloatAnimation;
    imgUserSenha: TImage;
    imgPIN: TImage;
    rctSelUserSenha: TRectangle;
    rctSelPIN: TRectangle;
    lytUserSenha_Confirmar: TLayout;
    rctConfirmarUserSenha: TRectangle;
    lbConfirmarUserSenha: TLabel;
    imgMostrar: TImage;
    imgVer: TImage;
    imgNVer: TImage;
    Image1: TImage;
    lytTitulo: TLayout;
    lbTitulo: TLabel;
    lbSubTitulo: TLabel;
    imgFechar: TImage;
    procedure edSenhaTyping(Sender: TObject);
    procedure edLoginTyping(Sender: TObject);
    procedure edPinTyping(Sender: TObject);
    procedure rctSelPINClick(Sender: TObject);
    procedure imgMostrarClick(Sender: TObject);
    procedure rctConfirmarUserSenhaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edPinChangeTracking(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FUser_Localizados :Boolean;

    procedure MudarPin(Sender: TObject);
    procedure ThreadLogin_Terminate(Sender: TObject);
    procedure LoginEfetuado;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.edLoginTyping(Sender: TObject);
begin
  if (Trim(edLogin.Text) <> '') and (not lbLogin.Visible) then
  begin
    lbLogin.Visible := True;
    FloatAnimation_Login.StartValue := 10;
    FloatAnimation_Login.StopValue := -25;
    FloatAnimation_Login.Start;
  end
  else if (Trim(edLogin.Text) = '') then
  begin
    FloatAnimation_Login.StartValue := -25;
    FloatAnimation_Login.StopValue := 10;
    FloatAnimation_Login.Start;
    lbLogin.Visible := False;
  end;
end;

procedure TfrmLogin.edPinChangeTracking(Sender: TObject);
var
  t: TThread;
begin
  if Length(edPin.Text) = 4 then
  begin
      TLoading.Show(frmLogin, '');

      t := TThread.CreateAnonymousThread(procedure
      var
        lEmpresa :Integer;
      begin
        lEmpresa := 0;
        lEmpresa := FIniFile.ReadInteger('FILIAL','CODIGO',0);

        //Realizando login...
        FUser_Localizados := False;
        FUser_Localizados := Dm_DeskTop.LoginWeb(
          edPin.Text
          ,edLogin.Text
          ,edSenha.Text);
      end);

      t.OnTerminate := ThreadLogin_Terminate;
      t.Start;
  end;
end;

procedure TfrmLogin.ThreadLogin_Terminate(Sender:TObject);
begin
  TLoading.Hide;
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
      FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(sender).FatalException).Message,'OK')
    else
      LoginEfetuado;
  end;
end;

procedure TfrmLogin.LoginEfetuado;
begin
  if FUser_Localizados then
  begin
    if not Assigned(frmPrincipal) then
      Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    Application.MainForm := FrmPrincipal;
    FrmPrincipal.Show;
  end
  else
  begin
    if not Assigned(frmCadUsuario) then
      Application.CreateForm(TfrmCadUsuario, frmCadUsuario);
    Application.MainForm := frmCadUsuario;
    frmCadUsuario.Guia_Inicial := 1;
    frmCadUsuario.Show;
  end;
  FrmLogin.Close;
end;

procedure TfrmLogin.edPinTyping(Sender: TObject);
begin
  if (Trim(edPin.Text) <> '') and (not lbPin.Visible) then
  begin
    lbPin.Visible := True;
    FloatAnimation_Pin.StartValue := 10;
    FloatAnimation_Pin.StopValue := -25;
    FloatAnimation_Pin.Start;
  end
  else if (Trim(edPin.Text) = '') then
  begin
    FloatAnimation_Pin.StartValue := -25;
    FloatAnimation_Pin.StopValue := 10;
    FloatAnimation_Pin.Start;
    lbPin.Visible := False;
  end;
end;

procedure TfrmLogin.edSenhaTyping(Sender: TObject);
begin
  if (Trim(edSenha.Text) <> '') and (not lbSenha.Visible) then
  begin
    lbSenha.Visible := True;
    FloatAnimation_Senha.StartValue := 10;
    FloatAnimation_Senha.StopValue := -25;
    FloatAnimation_Senha.Start;
  end
  else if (Trim(edSenha.Text) = '') then
  begin
    FloatAnimation_Senha.StartValue := -25;
    FloatAnimation_Senha.StopValue := 10;
    FloatAnimation_Senha.Start;
    lbSenha.Visible := False;
  end;
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
var
  lEnder_Ini :String;
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_DESKTOP.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_DESKTOP.ini');
  {$ENDIF}

  FIniFile := TIniFile.Create(lEnder_Ini);
  FMensagem := TFancyDialog.Create(frmLogin);
end;

procedure TfrmLogin.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.imgMostrarClick(Sender: TObject);
begin
  case imgMostrar.Tag of
    0:begin
      imgMostrar.Bitmap := imgNVer.Bitmap;
      edSenha.Password := False;
      imgMostrar.Tag := 1;
    end;
    1:begin
      imgMostrar.Bitmap := imgVer.Bitmap;
      edSenha.Password := True;
      imgMostrar.Tag := 0;
    end;
  end;
end;

procedure TfrmLogin.rctConfirmarUserSenhaClick(Sender: TObject);
begin
  if Trim(edLogin.Text) = '' then
  begin
    FMensagem.Show(TIconDialog.Info,'Login','Usuário/Email não informado','Ok');
    if edLogin.CanFocus then
      edLogin.SetFocus;
    Exit;
  end;

  if Trim(edSenha.Text) = '' then
  begin
    FMensagem.Show(TIconDialog.Info,'Login','Senha não informada','Ok');
    if edSenha.CanFocus then
      edSenha.SetFocus;
    Exit;
  end;

  LoginEfetuado;

end;

procedure TfrmLogin.rctSelPINClick(Sender: TObject);
begin
  MudarPin(Sender);
end;

procedure TfrmLogin.MudarPin(Sender:TObject);
begin
  tcPrincipal.GotoVisibleTab(TRectangle(Sender).Tag)
end;

end.
