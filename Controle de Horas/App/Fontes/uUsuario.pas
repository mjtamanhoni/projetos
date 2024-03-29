unit uUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
    u99Permissions,
    uFormat,
  {$EndRegion '99 Coders'}

  uFuncoes,
  DM.ContHoras,

  {$Region 'Modelo de dados'}
    uModel.Usuario,
  {$EndRegion 'Modelo de dados'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.TabControl, FMX.Ani, FMX.Edit, FMX.MediaLibrary, FMX.MediaLibrary.Actions, System.Actions,
  FMX.ActnList, FMX.StdActns,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmUsuario = class(TForm)
    lytHeader: TLayout;
    lytDetail: TLayout;
    rctHeader: TRectangle;
    lytFechar: TLayout;
    imgFechar: TImage;
    lbTitulo: TLabel;
    tcCadastro: TTabControl;
    tiEtapa1: TTabItem;
    tiEtapa2: TTabItem;
    rctEtapa1: TRectangle;
    rctEtapa2: TRectangle;
    lytEtapa1: TLayout;
    lytFoto: TLayout;
    Circle_Foto: TCircle;
    imgTirarFoto: TImage;
    lytNome: TLayout;
    StyleBook_Principal: TStyleBook;
    edNome: TEdit;
    lbNome: TLabel;
    faNome: TFloatAnimation;
    lytLogin: TLayout;
    edLogin: TEdit;
    lbLogin: TLabel;
    faLogin: TFloatAnimation;
    lytSenha: TLayout;
    edSenha: TEdit;
    lbSenha: TLabel;
    faSenha: TFloatAnimation;
    lytEtapa1_Acoes: TLayout;
    lytAnterior: TLayout;
    lytProximo: TLayout;
    imgProximo: TImage;
    imgAnterior: TImage;
    tiEtapa3: TTabItem;
    rctEtapa3: TRectangle;
    lytEtapa3: TLayout;
    lytEtapa3_Foto: TLayout;
    Circle_Etapa3_Foto: TCircle;
    StyleBook1: TStyleBook;
    lytEtapa3_Opcoes: TLayout;
    lytEtapa3_Buttons: TLayout;
    imgNovoFoto: TImage;
    imgFotoExistente: TImage;
    ActionList: TActionList;
    actLibrary: TTakePhotoFromLibraryAction;
    actCamera: TTakePhotoFromCameraAction;
    imgVerSenha: TImage;
    imgNVer: TImage;
    imgVer: TImage;
    lytConfirmar: TLayout;
    imgConfirmar: TImage;
    lytEtapa2: TLayout;
    lytPin: TLayout;
    edPin: TEdit;
    lbPin: TLabel;
    faPin: TFloatAnimation;
    lytCelular: TLayout;
    edCelular: TEdit;
    lbCelular: TLabel;
    faCelular: TFloatAnimation;
    lytEmail: TLayout;
    edEmail: TEdit;
    lbEmail: TLabel;
    faEmail: TFloatAnimation;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgAnteriorClick(Sender: TObject);
    procedure imgProximoClick(Sender: TObject);
    procedure imgTirarFotoClick(Sender: TObject);
    procedure imgNovoFotoClick(Sender: TObject);
    procedure imgFotoExistenteClick(Sender: TObject);
    procedure actLibraryDidFinishTaking(Image: TBitmap);
    procedure actCameraDidFinishTaking(Image: TBitmap);
    procedure edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edLoginKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edPinKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edCelularKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edNomeTyping(Sender: TObject);
    procedure edLoginTyping(Sender: TObject);
    procedure edSenhaTyping(Sender: TObject);
    procedure edPinTyping(Sender: TObject);
    procedure edCelularTyping(Sender: TObject);
    procedure edEmailTyping(Sender: TObject);
    procedure imgConfirmarClick(Sender: TObject);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  private
    FMensagem :TFancyDialog;
    FPermissao: T99Permissions;
    lDM :TDM_ConrHoras;
    lTUSUARIO :TUSUARIO;
    FID: Integer;
    lFDC_Insert :TFDQuery;

    procedure MudarTab(ATab: Integer);
    procedure TrataErroPermissao(Sender: TObject);
    procedure SalvarAlteracoes(Sender: TOBject);
    procedure CancelarAlteracoes(Sender: TOBject);
    procedure ThreadEnd_SalvarAlteracoes(Sender: TOBject);
    procedure SetID(const Value: Integer);
    procedure Sincronizar(Sender: TOBject);
    procedure ThreadEnd_Sincronizar(Sender: TOBject);
  public
    property ID :Integer read FID write SetID;
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.fmx}

procedure TfrmUsuario.actCameraDidFinishTaking(Image: TBitmap);
begin
  Circle_Etapa3_Foto.Fill.Bitmap.Bitmap := Image;
  //TabControl.GotoVisibleTab(2);
end;

procedure TfrmUsuario.actLibraryDidFinishTaking(Image: TBitmap);
begin
  Circle_Etapa3_Foto.Fill.Bitmap.Bitmap := Image;
  //TabControl.GotoVisibleTab(2);
end;

procedure TfrmUsuario.edCelularKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edEmail);
end;

procedure TfrmUsuario.edCelularTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCelular,lbCelular,faCelular,10,-20);
  Formatar(edCelular,TFormato.Celular);
end;

procedure TfrmUsuario.edEmailTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail,lbEmail,faEmail,10,-20);
end;

procedure TfrmUsuario.edLoginKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edSenha);
end;

procedure TfrmUsuario.edLoginTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edLogin,lbLogin,faLogin,10,-20);
end;

procedure TfrmUsuario.edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edLogin);
end;

procedure TfrmUsuario.edNomeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNome,lbNome,faNome,10,-20);
end;

procedure TfrmUsuario.edPinKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCelular);
end;

procedure TfrmUsuario.edPinTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPin,lbPin,faPin,10,-20);
end;

procedure TfrmUsuario.edSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcCadastro.GotoVisibleTab(tcCadastro.TabIndex+1);
    TFuncoes.PularCampo(edPin);
  end;
end;

procedure TfrmUsuario.edSenhaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edSenha,lbSenha,faSenha,10,-20);
end;

procedure TfrmUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FPermissao);
    FreeAndNil(lDM);
    FreeAndNil(lTUSUARIO);
    FreeAndNil(lFDC_Insert);
  {$ELSE}
    FMensagem.DisposeOf;
    FPermissao.DisposeOf;
    lDM.DisposeOf;
    lTUSUARIO.DisposeOf;
    lFDC_Insert.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmUsuario := Nil;
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  FMensagem := TFancyDialog.Create(frmUsuario);
  FPermissao := T99Permissions.Create;

  tcCadastro.ActiveTab := tiEtapa1;
  lytAnterior.Visible := False;

  ID := 0;
  lDM := TDM_ConrHoras.Create(Nil);
  lTUSUARIO := TUSUARIO.Create(lDM.FDC_Conexao);
  lFDC_Insert := TFDQuery.Create(Nil);
  lFDC_Insert.Connection := lDM.FDC_Conexao;

end;

procedure TfrmUsuario.imgAnteriorClick(Sender: TObject);
begin
  MudarTab(tcCadastro.TabIndex - 1);
end;

procedure TfrmUsuario.imgConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Salvar','Deseja salvar as altera��es realizadas?','SIM',SalvarAlteracoes,'N�O');
end;

procedure TfrmUsuario.SalvarAlteracoes(Sender :TOBject);
var
  t :TThread;
begin
  TLoading.Show(frmUsuario,'Salvando altera��es');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    lTUSUARIO.ID := FID;
    lTUSUARIO.NOME := edNome.Text;
    lTUSUARIO.LOGIN := edLogin.Text;
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
      //Atualizando um usu�rio j� cadastrado...
  end);

  t.OnTerminate := ThreadEnd_SalvarAlteracoes;
  t.Start;

end;

procedure TfrmUsuario.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TfrmUsuario.ThreadEnd_SalvarAlteracoes(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FMensagem.Show(TIconDialog.Question,'Aten��o','Deseja sincronizar o Usu�rio?','SIM',Sincronizar,'N�O');
    MudarTab(0);
  end;
end;

procedure TfrmUsuario.Sincronizar(Sender :TOBject);
var
  t :TThread;
begin
  TLoading.Show(frmUsuario,'Sincronizando usu�rio');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lFDC_Query :TFDQuery;
  begin
    lDM.Sinc_Usuario;
  end);

  t.OnTerminate := ThreadEnd_Sincronizar;
  t.Start;

end;

procedure TfrmUsuario.ThreadEnd_Sincronizar(Sender :TOBject);
var
  lFDC_Query :TFDQuery;
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Close;
end;

procedure TfrmUsuario.imgFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cancelar','Deseja cancelar as altera��es realizadas?','SIM',CancelarAlteracoes,'N�O')
end;

procedure TfrmUsuario.CancelarAlteracoes(Sender :TOBject);
begin
  Close;
end;

procedure TfrmUsuario.imgFotoExistenteClick(Sender: TObject);
begin
  FPermissao.PhotoLibrary(ActLibrary, TrataErroPermissao);
end;

procedure TfrmUsuario.imgNovoFotoClick(Sender: TObject);
begin
  FPermissao.Camera(ActCamera, TrataErroPermissao);
end;

procedure TfrmUsuario.imgProximoClick(Sender: TObject);
begin
  MudarTab(tcCadastro.TabIndex + 1);
end;

procedure TfrmUsuario.imgTirarFotoClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    FMensagem.Show(TIconDialog.Warning,'Aten��o','Fun��o n�o habilitada para Windows','OK');
  {$ELSE}
    MudarTab(2);
  {$ENDIF}
end;

procedure TfrmUsuario.MudarTab(ATab:Integer);
begin
  lytAnterior.Visible := (ATab > 0);
  lytProximo.Visible := (ATab < tcCadastro.TabCount-1);

  if ATab < 0 then
    Exit;
  if ATab > tcCadastro.TabCount then
    Exit;

  tcCadastro.GotoVisibleTab(ATab)
end;

procedure TfrmUsuario.TrataErroPermissao(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Error,'Aten��o','Voc� n�o possui permiss�o para esse recurso','OK');
end;

end.
