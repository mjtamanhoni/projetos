unit uConfig;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Effects, FMX.Edit,
  FMX.TabControl,

  IniFiles,

  unPrincipal, FMX.ListBox;

type
  TfrmConfiguracoes = class(TForm)
    lytPrincipal: TLayout;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    lytDetail: TLayout;
    lytVoltar: TLayout;
    rctVoltar: TRectangle;
    imgVoltar: TImage;
    lytCancelar: TLayout;
    rctCancelar: TRectangle;
    imgCancelar: TImage;
    lytConfirmar: TLayout;
    rctConfirmar: TRectangle;
    imgConfirmar: TImage;
    tcPrincipal: TTabControl;
    tiServidor: TTabItem;
    tiFirebird: TTabItem;
    rctServidor: TRectangle;
    lytServidor_Header: TLayout;
    rctServidor_Header: TRectangle;
    lbServidor_Title: TLabel;
    lytRow_01: TLayout;
    lytPort: TLayout;
    lbPort: TLabel;
    edPorta: TEdit;
    rctFirebird: TRectangle;
    lytFirebird_Header: TLayout;
    rctFirebird_Tit: TRectangle;
    lbFirebird_Tit: TLabel;
    lytBD_Row_001: TLayout;
    lytFirebird_Versao: TLayout;
    lbFirebird_Versao: TLabel;
    cbFirebird_Versao: TComboBox;
    lytFirebird_Servidor: TLayout;
    lbFirebird_Servidor: TLabel;
    edFirebird_Servidor: TEdit;
    lytFirebird_Porta: TLayout;
    lbFirebird_Porta: TLabel;
    edFirebird_Porta: TEdit;
    lytGuia_Servidor: TLayout;
    rctGuia_Servidor: TRectangle;
    imgGuia_Servidor: TImage;
    lytGuia_DataBase: TLayout;
    rctGuia_DataBase: TRectangle;
    imgGuia_DataBase: TImage;
    lytBD_Row_002: TLayout;
    lytFirebird_Banco: TLayout;
    lbFirebird_Banco: TLabel;
    edFirebird_Banco: TEdit;
    imgBanco_Pesq: TImage;
    lytBD_Row_003: TLayout;
    lytFirebird_User: TLayout;
    lbFirebird_User: TLabel;
    edFirebird_User: TEdit;
    lytFirebird_Senha: TLayout;
    lbFirebird_Senha: TLabel;
    edFirebird_Senha: TEdit;
    imgFirebird_Senha_View: TImage;
    imgExibir: TImage;
    imgEsconder: TImage;
    OpenDialog: TOpenDialog;
    lytBD_Row_004: TLayout;
    lytFirebird_Biblioteca: TLayout;
    lbFirebird_Biblioteca: TLabel;
    edFirebird_Biblioteca: TEdit;
    imgFirebird_Biblioteca: TImage;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    procedure rctCancelarClick(Sender: TObject);
    procedure rctConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctGuia_DataBaseClick(Sender: TObject);
    procedure imgFirebird_Senha_ViewClick(Sender: TObject);
    procedure imgBanco_PesqClick(Sender: TObject);
    procedure imgFirebird_BibliotecaClick(Sender: TObject);
    procedure cbFirebird_VersaoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edFirebird_ServidorKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edFirebird_PortaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edFirebird_BancoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edFirebird_UserKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edFirebird_SenhaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;

    procedure Cancelar(Sender: TObject);
    procedure Confirmar(Sender: TObject);
    procedure Gravar_BD_Firebird;
    procedure Gravar_Servidor;
    procedure Ler_Dados_Banco;
    procedure Ler_Dados_Servidor;
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.fmx}

procedure TfrmConfiguracoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
  {$ELSE}
    FMensagem.DisposeOf;
  {$ENDIF}
  Action := TCloseAction.caFree;
  frmConfiguracoes := Nil;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
var
  lEnder_Ini :String;
begin

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_HORAS_TRAB.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_HORAS_TRAB.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  FMensagem := TFancyDialog.Create(frmConfiguracoes);
  tcPrincipal.ActiveTab := tiServidor;
end;

procedure TfrmConfiguracoes.FormShow(Sender: TObject);
begin
  Ler_Dados_Banco;
  Ler_Dados_Servidor;
end;

procedure TfrmConfiguracoes.Ler_Dados_Banco;
begin
  cbFirebird_Versao.ItemIndex := FIniFile.ReadInteger('FIREBIRD','VERSAO',-1); //0-2.1, 1-3.0
  edFirebird_Servidor.Text := FIniFile.ReadString('FIREBIRD','SERVIDOR','');
  edFirebird_Porta.Text := FIniFile.ReadInteger('FIREBIRD','PORTA',0).ToString;
  edFirebird_Banco.Text := FIniFile.ReadString('FIREBIRD','BANCO','');
  edFirebird_User.Text := FIniFile.ReadString('FIREBIRD','USUARIO','');
  edFirebird_Senha.Text := FIniFile.ReadString('FIREBIRD','SENHA','');
  edFirebird_Biblioteca.Text := FIniFile.ReadString('FIREBIRD','BIBLIOTECA','');
end;

procedure TfrmConfiguracoes.Ler_Dados_Servidor;
begin
  edPorta.Text := FIniFile.ReadInteger('SERVER','PORTA',0).ToString;
end;

procedure TfrmConfiguracoes.imgBanco_PesqClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Banco de Dados (*.FDB) | *.FDB';
  OpenDialog.Title := 'Selecionar banco de dados Firebird';
  OpenDialog.InitialDir := FEnder;
  if OpenDialog.Execute then
    edFirebird_Banco.Text := OpenDialog.FileName;
end;

procedure TfrmConfiguracoes.imgFirebird_BibliotecaClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Biblioteca (*.DLL) | *.DLL';
  OpenDialog.Title := 'Selecionar biblioteca do Firebird';
  OpenDialog.InitialDir := '';
  if OpenDialog.Execute then
    edFirebird_Biblioteca.Text := OpenDialog.FileName;
end;

procedure TfrmConfiguracoes.imgFirebird_Senha_ViewClick(Sender: TObject);
begin
  case imgFirebird_Senha_View.Tag of
    0:begin
      edFirebird_Senha.Password := False;
      imgFirebird_Senha_View.Bitmap := imgEsconder.Bitmap;
      imgFirebird_Senha_View.Tag := 1;
    end;
    1:begin
      edFirebird_Senha.Password := True;
      imgFirebird_Senha_View.Bitmap := imgExibir.Bitmap;
      imgFirebird_Senha_View.Tag := 0;
    end;
  end;
end;

procedure TfrmConfiguracoes.rctCancelarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações?','Sim',Cancelar,'Não');
end;

procedure TfrmConfiguracoes.Cancelar(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguracoes.rctConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja confirmar as alterações?','Sim',Confirmar,'Não');
end;

procedure TfrmConfiguracoes.rctGuia_DataBaseClick(Sender: TObject);
begin
  rctGuia_Servidor.Opacity := 0.5;
  rctGuia_DataBase.Opacity := 0.5;
  tcPrincipal.GotoVisibleTab(TRectangle(Sender).Tag);
  TRectangle(Sender).Opacity := 1;

  case TRectangle(Sender).Tag of
    0:begin
      if edPorta.CanFocus then
        edPorta.SetFocus;
    end;
    1:begin
      if cbFirebird_Versao.CanFocus then
        cbFirebird_Versao.SetFocus;
    end;
  end;
end;

procedure TfrmConfiguracoes.cbFirebird_VersaoKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if edFirebird_Servidor.CanFocus then
      edFirebird_Servidor.SetFocus;
  end;
end;

procedure TfrmConfiguracoes.Confirmar(Sender: TObject);
begin
  Gravar_Servidor;
  Gravar_BD_Firebird;

  Close;
end;

procedure TfrmConfiguracoes.Gravar_Servidor;
begin
  FIniFile.WriteInteger('SERVER','PORTA',StrToIntDef(edPorta.Text,0));
end;

procedure TfrmConfiguracoes.Gravar_BD_Firebird;
begin
  FIniFile.WriteInteger('FIREBIRD','VERSAO',cbFirebird_Versao.ItemIndex); //0-2.1, 1-3.0
  FIniFile.WriteString('FIREBIRD','SERVIDOR',edFirebird_Servidor.Text);
  FIniFile.WriteInteger('FIREBIRD','PORTA',StrToIntDef(edFirebird_Porta.Text,0));
  FIniFile.WriteString('FIREBIRD','BANCO',edFirebird_Banco.Text);
  FIniFile.WriteString('FIREBIRD','USUARIO',edFirebird_User.Text);
  FIniFile.WriteString('FIREBIRD','SENHA',edFirebird_Senha.Text);
  FIniFile.WriteString('FIREBIRD','BIBLIOTECA',edFirebird_Biblioteca.Text);
end;

procedure TfrmConfiguracoes.edFirebird_BancoKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if edFirebird_User.CanFocus then
      edFirebird_User.SetFocus;
  end;
end;

procedure TfrmConfiguracoes.edFirebird_PortaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if edFirebird_Banco.CanFocus then
      edFirebird_Banco.SetFocus;
  end;
end;

procedure TfrmConfiguracoes.edFirebird_SenhaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if edFirebird_Biblioteca.CanFocus then
      edFirebird_Biblioteca.SetFocus;
  end;
end;

procedure TfrmConfiguracoes.edFirebird_ServidorKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if edFirebird_Porta.CanFocus then
      edFirebird_Porta.SetFocus;
  end;
end;

procedure TfrmConfiguracoes.edFirebird_UserKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if edFirebird_Senha.CanFocus then
      edFirebird_Senha.SetFocus;
  end;
end;

end.
