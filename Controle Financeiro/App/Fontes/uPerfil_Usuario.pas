unit uPerfil_Usuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uFuncoes,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
    uFormat,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl, FMX.Ani, FMX.Edit;

type
  TfrmPerfilUsuario = class(TForm)
    StyleBook_Principal: TStyleBook;
    lytHeader: TLayout;
    lytDetail: TLayout;
    rctLista_1: TRectangle;
    rctLista_2: TRectangle;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    Circle_Externo: TCircle;
    Circle_Foto: TCircle;
    Circle_Integerno: TCircle;
    imgConfirmar: TImage;
    imgCancelar: TImage;
    lytNome: TLayout;
    edNome: TEdit;
    lbNome: TLabel;
    faNome: TFloatAnimation;
    lytSenha: TLayout;
    edSenha: TEdit;
    lbSenha: TLabel;
    faSenha: TFloatAnimation;
    imgVerSenha: TImage;
    tcPrincipal: TTabControl;
    tiGuia_1: TTabItem;
    tiGuia_2: TTabItem;
    rctGuia_1: TRectangle;
    rctGuia_2: TRectangle;
    lytCelular: TLayout;
    edCelular: TEdit;
    lbCelular: TLabel;
    faCelular: TFloatAnimation;
    lytEmail: TLayout;
    edEmail: TEdit;
    lbEmail: TLabel;
    faEmail: TFloatAnimation;
    lytPin: TLayout;
    edPin: TEdit;
    lbPin: TLabel;
    faPin: TFloatAnimation;
    lytEtapa1_Acoes: TLayout;
    lytAnterior: TLayout;
    imgAnterior: TImage;
    lytProximo: TLayout;
    imgProximo: TImage;
    imgNVer: TImage;
    imgVer: TImage;
    procedure imgAnteriorClick(Sender: TObject);
    procedure imgConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgCancelarClick(Sender: TObject);
    procedure edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edLoginKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSenhaTyping(Sender: TObject);
    procedure edPinKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edPinTyping(Sender: TObject);
    procedure edCelularTyping(Sender: TObject);
    procedure edEmailTyping(Sender: TObject);
    procedure edNomeTyping(Sender: TObject);
    procedure edEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgVerSenhaClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    procedure Cancelar(Sender :TObject);
    procedure Confirmar(Sender: TOBject);
  public
    { Public declarations }
  end;

var
  frmPerfilUsuario: TfrmPerfilUsuario;

implementation

{$R *.fmx}

procedure TfrmPerfilUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
  {$ELSE}
    FMensagem.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmPerfilUsuario := Nil;
end;

procedure TfrmPerfilUsuario.FormCreate(Sender: TObject);
begin
  FMensagem := TFancyDialog.Create(frmPerfilUsuario);
  tcPrincipal.ActiveTab := tiGuia_1;
end;

procedure TfrmPerfilUsuario.imgAnteriorClick(Sender: TObject);
begin
  tcPrincipal.GotoVisibleTab(tcPrincipal.TabIndex + TImage(Sender).Tag);
end;

procedure TfrmPerfilUsuario.imgCancelarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações?','Sim',Cancelar,'Não');
end;

procedure TfrmPerfilUsuario.Cancelar(Sender :TObject);
begin
  Close;
end;

procedure TfrmPerfilUsuario.imgConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja salvar as alterações?','Sim',Confirmar,'Não');
end;

procedure TfrmPerfilUsuario.imgVerSenhaClick(Sender: TObject);
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

procedure TfrmPerfilUsuario.edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edEmail);
end;

procedure TfrmPerfilUsuario.edNomeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNome,lbNome,faNome,10,-20);
end;

procedure TfrmPerfilUsuario.Confirmar(Sender :TOBject);
begin
  Close;
end;

procedure TfrmPerfilUsuario.edCelularTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCelular,lbCelular,faCelular,10,-20);
  Formatar(edCelular,TFormato.Celular);
end;

procedure TfrmPerfilUsuario.edEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edSenha);
end;

procedure TfrmPerfilUsuario.edEmailTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail,lbEmail,faEmail,10,-20);
end;

procedure TfrmPerfilUsuario.edLoginKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edSenha);
end;

procedure TfrmPerfilUsuario.edPinKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCelular);
end;

procedure TfrmPerfilUsuario.edPinTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPin,lbPin,faPin,10,-20);
end;

procedure TfrmPerfilUsuario.edSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcPrincipal.GotoVisibleTab(tcPrincipal.TabIndex+1);
    TFuncoes.PularCampo(edPin);
  end;
end;

procedure TfrmPerfilUsuario.edSenhaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edSenha,lbSenha,faSenha,10,-20);
end;

end.
