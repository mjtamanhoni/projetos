unit uPerfil_Usuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uFuncoes,
  uModel.Usuario,
  uDM_Global,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
    uFormat,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl, FMX.Ani, FMX.Edit,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;


type
  TfrmPerfilUsuario = class(TForm)
    StyleBook_Principal: TStyleBook;
    lytHeader: TLayout;
    lytDetail: TLayout;
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
    lTUSUARIO :TUSUARIO;
    lDM :TDM;
    FID: Integer;
    lFDC_Insert :TFDQuery;

    procedure Cancelar(Sender :TObject);
    procedure Confirmar(Sender: TOBject);
    procedure SetID(const Value: Integer);
    procedure ThreadEnd_Confirmar(Sender: TOBject);
    procedure Sincronizar(Sender: TOBject);
    procedure ThreadEnd_Sincronizar(Sender: TOBject);
  public
    property ID :Integer read FID write SetID;
  end;

var
  frmPerfilUsuario: TfrmPerfilUsuario;

implementation

{$R *.fmx}

procedure TfrmPerfilUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    //FreeAndNil(lDM);
    FreeAndNil(lTUSUARIO);
    FreeAndNil(lFDC_Insert);
  {$ELSE}
    FMensagem.DisposeOf;
    //lDM.DisposeOf;
    lTUSUARIO.DisposeOf;
    lFDC_Insert.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmPerfilUsuario := Nil;
end;

procedure TfrmPerfilUsuario.FormCreate(Sender: TObject);
begin
  tcPrincipal.ActiveTab := tiGuia_1;
  ID := 0;

  FMensagem := TFancyDialog.Create(frmPerfilUsuario);

  //lDM := TDM.Create(Nil);

  lTUSUARIO := TUSUARIO.Create(DM.FDC_Conexao);

  lFDC_Insert := TFDQuery.Create(Nil);

  lFDC_Insert.Connection := DM.FDC_Conexao;
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

procedure TfrmPerfilUsuario.SetID(const Value: Integer);
begin
  FID := Value;
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
var
  t :TThread;
begin
  TLoading.Show(frmPerfilUsuario,'Salvando alterações');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    lTUSUARIO.ID := FID;
    lTUSUARIO.NOME := edNome.Text;
    lTUSUARIO.LOGIN := edEmail.Text;
    lTUSUARIO.SENHA := edSenha.Text;
    lTUSUARIO.PIN := edPin.Text;
    lTUSUARIO.EMAIL := edEmail.Text;
    lTUSUARIO.CELULAR := edCelular.Text;
    lTUSUARIO.SINCRONIZADO := 0;
    lTUSUARIO.DT_CADASTRO := Date;
    lTUSUARIO.HR_CADASTRO := Time;
    if FID = 0 then
      FID := lTUSUARIO.Inserir(lFDC_Insert)
    else
      //Atualizando um usuário já cadastrado...
  end);

  t.OnTerminate := ThreadEnd_Confirmar;
  t.Start;
end;

procedure TfrmPerfilUsuario.ThreadEnd_Confirmar(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FMensagem.Show(TIconDialog.Question,'Atenção','Deseja sincronizar o Usuário?','SIM',Sincronizar,'NÃO');
    tcPrincipal.GotoVisibleTab(0);
  end;
end;

procedure TfrmPerfilUsuario.Sincronizar(Sender :TOBject);
var
  t :TThread;
begin
  TLoading.Show(frmPerfilUsuario,'Sincronizando usuário');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    DM.Sinc_Usuario;
  end);

  t.OnTerminate := ThreadEnd_Sincronizar;
  t.Start;
end;

procedure TfrmPerfilUsuario.ThreadEnd_Sincronizar(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
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
