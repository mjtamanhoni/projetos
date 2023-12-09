unit uDeskTop.CadUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.JSON,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
    uFormat,
  {$EndRegion '99 Coders'}

  {$Region 'Horse'}
    Horse,
    Horse.Jhonson,
    Horse.BasicAuthentication,
    Horse.CORS,
    DataSet.Serialize.Config,
  {$EndRegion 'Horse'}

  IniFiles,
  uFuncoes,

  uDm_DeskTop,
  DataSet.Serialize,
  RESTRequest4D,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView,
  uDeskTop.Principal, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.FMTBcd, Data.Bind.Components, Data.Bind.DBScope, Data.SqlExpr;

type
  TStatusTable = (stList,stInsert,stUpdate,stDelete);

type
  TfrmCadUsuario = class(TForm)
    lytDetail: TLayout;
    lytDetail_Espacos: TLayout;
    edNome: TEdit;
    lbNome: TLabel;
    FloatAnimation_Nome: TFloatAnimation;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    rctConfirmar: TRectangle;
    rctCancelar: TRectangle;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytMenu: TLayout;
    rctMenu_Principal: TRectangle;
    imgMenu: TImage;
    lytFechar: TLayout;
    rctFechar: TRectangle;
    imgFechar: TImage;
    lytRow_001: TLayout;
    edStatus: TEdit;
    lbStatus: TLabel;
    FloatAnimation_Status: TFloatAnimation;
    rctStatus: TRectangle;
    rctStatus_Ativo: TRectangle;
    lbStatus_Ativo: TLabel;
    rctStatus_Inativo: TRectangle;
    lbStatus_Inativo: TLabel;
    FloatAnimation_SelStatus: TFloatAnimation;
    edTipo: TEdit;
    lbTipo: TLabel;
    FloatAnimation_Tipo: TFloatAnimation;
    rctTipo: TRectangle;
    rctTipo_Funcionario: TRectangle;
    lbTipo_Funcionario: TLabel;
    rctTipo_Fornecedor: TRectangle;
    lbTipo_Fornecedor: TLabel;
    FloatAnimation_SelTipo: TFloatAnimation;
    rctTipo_Cliente: TRectangle;
    lbTipo_Cliente: TLabel;
    lytRow_002: TLayout;
    edLogin: TEdit;
    lbLogin: TLabel;
    FloatAnimation_Login: TFloatAnimation;
    edSenha: TEdit;
    lbSenha: TLabel;
    FloatAnimation_Senha: TFloatAnimation;
    edPin: TEdit;
    lbPin: TLabel;
    FloatAnimation_Pin: TFloatAnimation;
    imgMostrar: TImage;
    imgNVer: TImage;
    imgVer: TImage;
    lytRow_003: TLayout;
    edEmail: TEdit;
    lbEmail: TLabel;
    FloatAnimation_Email: TFloatAnimation;
    edCelular: TEdit;
    lbCelular: TLabel;
    FloatAnimation_Celular: TFloatAnimation;
    edClassificacao: TEdit;
    lbClassificacao: TLabel;
    FloatAnimation_Class: TFloatAnimation;
    rctClassificacao: TRectangle;
    rctClass_Administrador: TRectangle;
    lbClass_Administrador: TLabel;
    rctClass_Gerente: TRectangle;
    lbClass_Gerente: TLabel;
    FloatAnimation_Classificacao: TFloatAnimation;
    rctClass_Caixa: TRectangle;
    lbClass_Caixa: TLabel;
    rctClass_Consumidor: TRectangle;
    lbClass_Consumidor: TLabel;
    rctClass_Entregador: TRectangle;
    lbClass_Entregador: TLabel;
    rctClass_Vendedor: TRectangle;
    lbClass_Vendedor: TLabel;
    lytRow_004: TLayout;
    edLogradouro: TEdit;
    lbLogradouro: TLabel;
    FloatAnimation_Logradouro: TFloatAnimation;
    edNumero: TEdit;
    lbNumero: TLabel;
    FloatAnimation_Numero: TFloatAnimation;
    lytRow_005: TLayout;
    edComplemento: TEdit;
    lbComplemento: TLabel;
    FloatAnimation_Complemento: TFloatAnimation;
    lytRow_006: TLayout;
    edBairro: TEdit;
    lbBairro: TLabel;
    FloatAnimation_Bairro: TFloatAnimation;
    edMunicipio: TEdit;
    lbMunicipio: TLabel;
    FloatAnimation_Municipio: TFloatAnimation;
    edUF: TEdit;
    lbUf: TLabel;
    FloatAnimation_UF: TFloatAnimation;
    imgUF_Pesq: TImage;
    imgMunicipio_Pesq: TImage;
    imgStatus: TImage;
    imgTipo: TImage;
    imgClassificacao: TImage;
    imgExpandir: TImage;
    imgRetrair: TImage;
    tcPrincipal: TTabControl;
    tiFiltro: TTabItem;
    tiCadastro: TTabItem;
    rctCadastro: TRectangle;
    rctFiltro: TRectangle;
    lytPesq_Filtro: TLayout;
    edPesquisar: TEdit;
    lbPesquisar: TLabel;
    FloatAnimation_Pesq: TFloatAnimation;
    imgPesquisar: TImage;
    lytLista: TLayout;
    lvLista: TListView;
    StyleBook_Principal: TStyleBook;
    FDMem_Usuarios: TFDMemTable;
    FDMem_UsuariosID: TIntegerField;
    FDMem_UsuariosNOME: TStringField;
    FDMem_UsuariosSTATUS: TIntegerField;
    FDMem_UsuariosTIPO: TIntegerField;
    FDMem_UsuariosLOGIN: TStringField;
    FDMem_UsuariosSENHA: TStringField;
    FDMem_UsuariosTOKEN: TStringField;
    FDMem_UsuariosEMAIL: TStringField;
    FDMem_UsuariosCELULAR: TStringField;
    FDMem_UsuariosCLASSIFICACAO: TIntegerField;
    FDMem_UsuariosLOGRADOURO: TStringField;
    FDMem_UsuariosNUMERO: TIntegerField;
    FDMem_UsuariosCOMPLEMENTO: TStringField;
    FDMem_UsuariosBAIRRO: TStringField;
    FDMem_UsuariosIBGE: TIntegerField;
    FDMem_UsuariosMUNICIPIO: TStringField;
    FDMem_UsuariosUF_SIGLA: TStringField;
    FDMem_UsuariosUF: TStringField;
    FDMem_UsuariosFOTO: TBlobField;
    FDMem_UsuariosID_FUNCIONARIO: TIntegerField;
    FDMem_UsuariosPUSH_NOTIFICATION: TStringField;
    FDMem_UsuariosORIGEM_TIPO: TIntegerField;
    FDMem_UsuariosORIGEM_DESCRICAO: TStringField;
    FDMem_UsuariosORIGEM_CODIGO: TIntegerField;
    FDMem_UsuariosPIN: TStringField;
    FDMem_UsuariosDT_CADASTRO: TStringField;
    FDMem_UsuariosHR_CADASTRO: TStringField;
    imgNovo: TImage;
    imgSalvar: TImage;
    imgCancel: TImage;
    imgDelete: TImage;
    rctLista: TRectangle;
    rctEditar: TRectangle;
    imgEditar: TImage;
    Circle_Editar: TCircle;
    Circle_Novo: TCircle;
    imgConfirmar: TImage;
    Circle_Cancelar: TCircle;
    imgCancelar: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctFecharClick(Sender: TObject);
    procedure edNomeTyping(Sender: TObject);
    procedure edStatusTyping(Sender: TObject);
    procedure edStatusClick(Sender: TObject);
    procedure rctStatus_AtivoClick(Sender: TObject);
    procedure rctStatus_InativoClick(Sender: TObject);
    procedure edStatusChange(Sender: TObject);
    procedure edTipoClick(Sender: TObject);
    procedure edTipoChange(Sender: TObject);
    procedure rctTipo_ClienteClick(Sender: TObject);
    procedure rctTipo_FornecedorClick(Sender: TObject);
    procedure rctTipo_FuncionarioClick(Sender: TObject);
    procedure edLoginTyping(Sender: TObject);
    procedure edSenhaTyping(Sender: TObject);
    procedure edPinTyping(Sender: TObject);
    procedure imgMostrarClick(Sender: TObject);
    procedure edEmailTyping(Sender: TObject);
    procedure edCelularTyping(Sender: TObject);
    procedure edClassificacaoTyping(Sender: TObject);
    procedure edClassificacaoChange(Sender: TObject);
    procedure edClassificacaoClick(Sender: TObject);
    procedure rctClass_AdministradorClick(Sender: TObject);
    procedure rctClass_CaixaClick(Sender: TObject);
    procedure rctClass_ConsumidorClick(Sender: TObject);
    procedure rctClass_EntregadorClick(Sender: TObject);
    procedure rctClass_GerenteClick(Sender: TObject);
    procedure rctClass_VendedorClick(Sender: TObject);
    procedure edLogradouroTyping(Sender: TObject);
    procedure edNumeroTyping(Sender: TObject);
    procedure edComplementoTyping(Sender: TObject);
    procedure edBairroTyping(Sender: TObject);
    procedure edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edStatusKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edTipoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edLoginKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edPinKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edCelularKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edClassificacaoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edLogradouroKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edNumeroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edComplementoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edBairroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure rctConfirmarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure lvListaPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lvListaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure rctEditarClick(Sender: TObject);
    procedure edPesquisarTyping(Sender: TObject);
  private
    FGuia_Inicial: Integer;
    FProcessando: String;

    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    lEnder_Ini :String;
    FFechar_Sistema :Boolean;
    FId_Selecionado :Integer;
    FStatusTable: TStatusTable;

    procedure Abortar_Fechamento(Sender: TOBject);
    procedure Confirmar_Fechamento(Sender :TObject);
    procedure ThreadEnd_Status(Sender: TOBject);
    procedure SelStatus;
    procedure SelTipo;
    procedure ThreadEnd_Tipo(Sender: TOBject);
    procedure SelecionaTipo(Sender:TObject; AEdit:TEdit;ALabel:TLabel);
    procedure SelClassificacao;
    procedure ThreadEnd_Classificacao(Sender: TOBject);
    procedure SelecionaClass(Sender: TObject; AEdit: TEdit; ALabel: TLabel);

    {$Region 'Listar dados'}
      procedure Listar_Dados(
        const APagina:Integer;
        const ABusca:String;
        const AInd_Clear:Boolean);
      procedure AddItens_LV(
        const ACodigo:Integer;
        const ANome:String);
      procedure ThreadEnd_Lista(Sender: TOBject);
    {$EndRegion 'Listar dados'}

    procedure SetGuia_Inicial(const Value: Integer);
    procedure Salvar_Alteracoes(Sender :TOBject);
    procedure Cancelar_Alteracoes(Sender :TOBject);
    procedure Novo_Registro(Sender: TOBject);
    procedure Deletar_Registro(Sender: TOBject);
    procedure SetProcessando(const Value: String);
    procedure EditandoRegistro(const AId: Integer);
    procedure ThreadEnd_Edit(Sender: TOBject);
    procedure Configura_Botoes(ABotao: Integer);
    procedure EditarRegistro(Sender: TOBject);
    procedure Incia_Campos;
    procedure Exibe_Labels;
    procedure ThreadEnd_SalvarRegistro(Sender: TOBject);
    procedure ThreadEnd_DeletarRegistro(Sender: TOBject);
  public
    property Guia_Inicial :Integer read FGuia_Inicial write SetGuia_Inicial;
    property Processando :String read FProcessando write SetProcessando;
  end;

var
  frmCadUsuario: TfrmCadUsuario;

implementation

{$R *.fmx}

procedure TfrmCadUsuario.Abortar_Fechamento(Sender: TOBject);
begin
  Abort;
end;

procedure TfrmCadUsuario.Confirmar_Fechamento(Sender: TObject);
begin
  FFechar_Sistema := True;
  Close;
end;

procedure TfrmCadUsuario.edTipoChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
end;

procedure TfrmCadUsuario.edTipoClick(Sender: TObject);
begin
  SelTipo;
end;

procedure TfrmCadUsuario.edTipoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edLogin);
end;

procedure TfrmCadUsuario.edUFKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edMunicipio);
end;

procedure TfrmCadUsuario.SelTipo;
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    rctTipo.Position.X := edTipo.Position.X;
    rctTipo.Position.Y := (lytRow_001.Position.Y + lytRow_001.Height);
    rctTipo.Width := edTipo.Width;
    rctTipo.Height := 90;
    if not rctTipo.Visible then
    begin
      FloatAnimation_SelTipo.StartValue := 0;
      FloatAnimation_SelTipo.StopValue := 90;
      imgTipo.Bitmap := imgRetrair.Bitmap;
    end
    else
    begin
      FloatAnimation_SelTipo.StartValue := 90;
      FloatAnimation_SelTipo.StopValue := 0;
      imgTipo.Bitmap := imgExpandir.Bitmap;
    end;
    TThread.Synchronize(nil, procedure
    begin
      if not rctTipo.Visible then
      begin
        rctTipo.Visible := (not rctTipo.Visible);
        FloatAnimation_SelTipo.Start;
      end
      else
      begin
        FloatAnimation_SelTipo.Start;
        rctTipo.Visible := (not rctTipo.Visible);
      end;
    end);
  end);

  t.OnTerminate := ThreadEnd_Tipo;
  t.Start;
end;

procedure TfrmCadUsuario.SetGuia_Inicial(const Value: Integer);
begin
  FGuia_Inicial := Value;
end;

procedure TfrmCadUsuario.SetProcessando(const Value: String);
begin
  FProcessando := Value;
end;

procedure TfrmCadUsuario.ThreadEnd_Tipo(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmCadUsuario.edBairroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edUF);
end;

procedure TfrmCadUsuario.edBairroTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edBairro,lbBairro,FloatAnimation_Bairro,10,-20);
end;

procedure TfrmCadUsuario.edCelularKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edClassificacao);
end;

procedure TfrmCadUsuario.edCelularTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCelular,lbCelular,FloatAnimation_Celular,10,-20);
  Formatar(edCelular, TFormato.Celular);
end;

procedure TfrmCadUsuario.edClassificacaoChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edClassificacao,lbClassificacao,FloatAnimation_Class,10,-20);
end;

procedure TfrmCadUsuario.edClassificacaoClick(Sender: TObject);
begin
  SelClassificacao;
end;

procedure TfrmCadUsuario.edClassificacaoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edLogradouro);
end;

procedure TfrmCadUsuario.SelClassificacao;
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    rctClassificacao.Position.X := edClassificacao.Position.X;
    rctClassificacao.Position.Y := (lytRow_003.Position.Y + lytRow_003.Height);
    rctClassificacao.Width := edClassificacao.Width;
    rctClassificacao.Height := 180;
    if not rctClassificacao.Visible then
    begin
      FloatAnimation_Classificacao.StartValue := 0;
      FloatAnimation_Classificacao.StopValue := 180;
      imgClassificacao.Bitmap := imgRetrair.Bitmap;
    end
    else
    begin
      FloatAnimation_Classificacao.StartValue := 180;
      FloatAnimation_Classificacao.StopValue := 0;
      imgClassificacao.Bitmap := imgExpandir.Bitmap;
    end;
    TThread.Synchronize(nil, procedure
    begin
      if not rctClassificacao.Visible then
      begin
        rctClassificacao.Visible := (not rctClassificacao.Visible);
        FloatAnimation_Classificacao.Start;
      end
      else
      begin
        FloatAnimation_Classificacao.Start;
        rctClassificacao.Visible := (not rctClassificacao.Visible);
      end;
    end);
  end);

  t.OnTerminate := ThreadEnd_Classificacao;
  t.Start;
end;

procedure TfrmCadUsuario.ThreadEnd_Classificacao(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmCadUsuario.edClassificacaoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edClassificacao,lbClassificacao,FloatAnimation_Class,10,-20);
end;

procedure TfrmCadUsuario.edComplementoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edBairro);
end;

procedure TfrmCadUsuario.edComplementoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edComplemento,lbComplemento,FloatAnimation_Complemento,10,-20);
end;

procedure TfrmCadUsuario.edEmailKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCelular);
end;

procedure TfrmCadUsuario.edEmailTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail,lbEmail,FloatAnimation_Email,10,-20);
end;

procedure TfrmCadUsuario.edLoginKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edSenha);
end;

procedure TfrmCadUsuario.edLoginTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edLogin,lbLogin,FloatAnimation_Login,10,-20);
end;

procedure TfrmCadUsuario.edLogradouroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edNumero);
end;

procedure TfrmCadUsuario.edLogradouroTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edLogradouro,lbLogradouro,FloatAnimation_Logradouro,10,-20);
end;

procedure TfrmCadUsuario.edNomeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edStatus);
end;

procedure TfrmCadUsuario.edNomeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNome,lbNome,FloatAnimation_Nome,10,-20);
end;

procedure TfrmCadUsuario.edNumeroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edComplemento);
end;

procedure TfrmCadUsuario.edNumeroTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNumero,lbNumero,FloatAnimation_Numero,10,-20);
end;

procedure TfrmCadUsuario.edPesquisarKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Processando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmCadUsuario.edPesquisarTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPesquisar,lbPesquisar,FloatAnimation_Pesq,10,-20);
end;

procedure TfrmCadUsuario.edPinKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edEmail);
end;

procedure TfrmCadUsuario.edPinTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPin,lbPin,FloatAnimation_Pin,10,-20);
end;

procedure TfrmCadUsuario.edSenhaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edPin);
end;

procedure TfrmCadUsuario.edSenhaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edSenha,lbSenha,FloatAnimation_Senha,10,-20);
end;

procedure TfrmCadUsuario.edStatusChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmCadUsuario.edStatusClick(Sender: TObject);
begin
  SelStatus;
end;

procedure TfrmCadUsuario.edStatusKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edTipo);
end;

procedure TfrmCadUsuario.SelStatus;
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    rctStatus.Position.X := edStatus.Position.X;
    rctStatus.Position.Y := (lytRow_001.Position.Y + lytRow_001.Height);
    rctStatus.Width := edStatus.Width;
    rctStatus.Height := 60;
    if not rctStatus.Visible then
    begin
      FloatAnimation_SelStatus.StartValue := 0;
      FloatAnimation_SelStatus.StopValue := 60;
      imgStatus.Bitmap := imgRetrair.Bitmap;
    end
    else
    begin
      FloatAnimation_SelStatus.StartValue := 60;
      FloatAnimation_SelStatus.StopValue := 0;
      imgStatus.Bitmap := imgExpandir.Bitmap;
    end;
    TThread.Synchronize(nil, procedure
    begin
      if not rctStatus.Visible then
      begin
        rctStatus.Visible := (not rctStatus.Visible);
        FloatAnimation_SelStatus.Start;
      end
      else
      begin
        FloatAnimation_SelStatus.Start;
        rctStatus.Visible := (not rctStatus.Visible);
      end;
    end);
  end);

  t.OnTerminate := ThreadEnd_Status;
  t.Start;
end;

procedure TfrmCadUsuario.ThreadEnd_Status(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmCadUsuario.edStatusTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmCadUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FFechar_Sistema then
    Abortar_Fechamento(Sender);

  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FIniFile);
  {$ELSE}
    FMensagem.DisposeOf;
    FIniFile.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.CaFree;
  frmCadUsuario := Nil;
  FId_Selecionado := 0;

end;

procedure TfrmCadUsuario.FormCreate(Sender: TObject);
begin
  FFechar_Sistema := False;
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_DESKTOP.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_DESKTOP.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  FMensagem := TFancyDialog.Create(frmCadUsuario);

  Guia_Inicial := 0;

  FStatusTable := TStatusTable.stList;
end;

procedure TfrmCadUsuario.FormShow(Sender: TObject);
begin
  Listar_Dados(0,edPesquisar.Text,True);

  tcPrincipal.TabIndex := FGuia_Inicial;
end;

procedure TfrmCadUsuario.Salvar_Alteracoes(Sender :TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    if Trim(edNome.Text) = '' then
      raise Exception.Create('Nome obrigatório');
    if edStatus.Tag = -1 then
      raise Exception.Create('Status obrigatório');
    if edTipo.Tag = -1 then
      raise Exception.Create('Tipo obrigatório');
    if Trim(edLogin.Text) = '' then
      raise Exception.Create('Login obrigatório');
    if Trim(edSenha.Text) = '' then
      raise Exception.Create('Senha obrigatória');
    if Trim(edPin.Text) = '' then
      raise Exception.Create('PIN obrigatório');
    if Trim(edEmail.Text) = '' then
      raise Exception.Create('Email obrigatório');
    if edClassificacao.Tag = -1 then
      raise Exception.Create('Classificação obrigatória');

    FDMem_Usuarios.Active := False;
    FDMem_Usuarios.Active := True;
    FDMem_Usuarios.Insert;
      if FStatusTable = stInsert then
        FDMem_UsuariosID.AsInteger := 0
      else if FStatusTable = stUpdate then
        FDMem_UsuariosID.AsInteger := edNome.Tag;

      FDMem_UsuariosNOME.AsString := edNome.Text;
      FDMem_UsuariosSTATUS.AsInteger := edStatus.Tag;
      FDMem_UsuariosTIPO.AsInteger := edTipo.Tag;
      FDMem_UsuariosLOGIN.AsString := edLogin.Text;
      FDMem_UsuariosSENHA.AsString := edSenha.Text;
      FDMem_UsuariosPIN.AsString := edPin.Text;
      FDMem_UsuariosTOKEN.AsString := '';
      FDMem_UsuariosEMAIL.AsString := edEmail.Text;
      FDMem_UsuariosCELULAR.AsString := edCelular.Text;
      FDMem_UsuariosCLASSIFICACAO.AsInteger := edClassificacao.Tag;
      FDMem_UsuariosLOGRADOURO.AsString := edLogradouro.Text;
      FDMem_UsuariosNUMERO.AsInteger := StrToIntDef(edNumero.Text,0);
      FDMem_UsuariosCOMPLEMENTO.AsString := edComplemento.Text;
      FDMem_UsuariosBAIRRO.AsString := edBairro.Text;
      FDMem_UsuariosIBGE.AsInteger := edMunicipio.Tag;
      FDMem_UsuariosMUNICIPIO.AsString := edMunicipio.Text;
      FDMem_UsuariosUF_SIGLA.AsString := edUF.TagString;
      FDMem_UsuariosUF.AsString := edUF.Text;
      FDMem_UsuariosFOTO.AsString := '';
      FDMem_UsuariosID_FUNCIONARIO.AsInteger := 0;
      FDMem_UsuariosPUSH_NOTIFICATION.AsString := '';
      FDMem_UsuariosORIGEM_TIPO.AsInteger := 0;//EndPoint...
      FDMem_UsuariosORIGEM_DESCRICAO.AsString := 'END POINT';
      FDMem_UsuariosORIGEM_CODIGO.AsInteger := 0;
      FDMem_UsuariosDT_CADASTRO.AsString := DateToStr(Date);
      FDMem_UsuariosHR_CADASTRO.AsString := TimeToStr(Time);
    FDMem_Usuarios.Post;

    if FStatusTable = stInsert then
    begin
      if not Dm_DeskTop.Usuario_Cadastro(FDMem_Usuarios.ToJSONArray,0) then
        raise Exception.Create('Erro ao salvar as alterações');
    end
    else if FStatusTable = stUpdate then
    begin
      if not Dm_DeskTop.Usuario_Cadastro(FDMem_Usuarios.ToJSONArray,1) then
        raise Exception.Create('Erro ao salvar as alterações');
    end;

    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(1);
    end);
  end);

  t.OnTerminate := ThreadEnd_SalvarRegistro;
  t.Start;

end;

procedure TfrmCadUsuario.ThreadEnd_SalvarRegistro(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Processando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmCadUsuario.imgMostrarClick(Sender: TObject);
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

procedure TfrmCadUsuario.Incia_Campos;
begin
  edNome.Tag := 0;
  edNome.Text := '';
  edStatus.Tag := -1;
  edStatus.Text := '';
  edTipo.Tag := -1;
  edTipo.Text := '';
  edLogin.Text := '';
  edSenha.Text := '';
  edPin.Text := '';
  edEmail.Text := '';
  edCelular.Text := '';
  edClassificacao.Tag := -1;
  edClassificacao.Text := '';
  edLogradouro.Text := '';
  edNumero.Text := '';
  edComplemento.Text := '';
  edBairro.Text := '';
  edUF.Text := '';
  edMunicipio.Text := '';

  Exibe_Labels;
end;

procedure TfrmCadUsuario.Listar_Dados(
        const APagina:Integer;
        const ABusca:String;
        const AInd_Clear:Boolean);
var
  t :TThread;
  lNome :String;
  lCodigo :Integer;

begin
  //Em processamento...
  if FProcessando = 'processando' then
      exit;
  Processando := 'processando';

  if AInd_Clear then
  begin
      lvLista.ScrollTo(0);
      lvLista.Tag := 0;
      lvLista.Items.Clear;
  end;

  lNome := '';
  lCodigo := 0;
  if edPesquisar.Text <> '' then
  begin
    if TFuncoes.Possui_Letras(ABusca) then
      lNome := UpperCase(edPesquisar.Text)
    else
      lCodigo := StrToIntDef(ABusca,0);
  end;

  lvLista.BeginUpdate;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
  begin
    if lvLista.Tag >= 0 then
      lvLista.Tag := (lvLista.Tag + 1);

      jsonArray := Dm_DeskTop.Usuario_Lista(
        lvLista.Tag
        ,lCodigo
        ,lNome
        ,''
        ,'');

      for x := 0 to jsonArray.Size -1 do
      begin
        TThread.Synchronize(nil,
        procedure
        begin
            AddItens_LV(
              jsonArray.Get(x).GetValue<Integer>('id'),
              jsonArray.Get(x).GetValue<String>('nome')
            );
        end);
      end;

      if jsonArray.Size = 0 then
        lvLista.Tag := -1;

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}


      TThread.Synchronize(nil, procedure
      begin
          lvLista.EndUpdate;
      end);
      Processando := '';

      //Força a chamada do evento onUpdateObjects da listview...
      lvLista.Margins.Bottom := 6;
      lvLista.Margins.Bottom := 5;
      //---------------------------------------------
  end);

  t.OnTerminate := ThreadEnd_Lista;
  t.Start;
end;

procedure TfrmCadUsuario.lvListaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FId_Selecionado := Aitem.Tag;
end;

procedure TfrmCadUsuario.lvListaPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvLista.Items.Count > 0) and (lvLista.Tag >= 0) then
  begin
    if lvLista.GetItemRect(lvLista.Items.Count - 3).Bottom <= lvLista.Height then
      Listar_Dados(lvLista.Tag,edPesquisar.Text,False)
  end;
end;

procedure TfrmCadUsuario.ThreadEnd_Lista(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga dos Usuários: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmCadUsuario.AddItens_LV(
        const ACodigo:Integer;
        const ANome:String);
begin
  with lvLista.Items.Add do
  begin
      Tag := ACodigo;
      TListItemText(Objects.FindDrawable('edNome')).TagString := ACodigo.ToString;
      TListItemText(Objects.FindDrawable('edNome')).Text := ANome;
  end;
end;

procedure TfrmCadUsuario.rctCancelarClick(Sender: TObject);
begin
  case rctCancelar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Excluir','Deseja excluir o registro?','SIM',Deletar_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Cancelar','Deseja cancelar as alterações?','SIM',Cancelar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmCadUsuario.Deletar_Registro(Sender :TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.Usuario_Excluir(FId_Selecionado);
    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(3);
    end);
  end);

  t.OnTerminate := ThreadEnd_DeletarRegistro;
  t.Start;
end;

procedure TfrmCadUsuario.ThreadEnd_DeletarRegistro(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Processando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmCadUsuario.Cancelar_Alteracoes(Sender :TOBject);
begin
  Configura_Botoes(2);
end;

procedure TfrmCadUsuario.rctClass_AdministradorClick(Sender: TObject);
begin
  SelecionaClass(Sender,edClassificacao,lbClass_Administrador);
end;

procedure TfrmCadUsuario.rctClass_CaixaClick(Sender: TObject);
begin
  SelecionaClass(Sender,edClassificacao,lbClass_Caixa);
end;

procedure TfrmCadUsuario.rctClass_ConsumidorClick(Sender: TObject);
begin
  SelecionaClass(Sender,edClassificacao,lbClass_Consumidor);
end;

procedure TfrmCadUsuario.rctClass_EntregadorClick(Sender: TObject);
begin
  SelecionaClass(Sender,edClassificacao,lbClass_Entregador);
end;

procedure TfrmCadUsuario.rctClass_GerenteClick(Sender: TObject);
begin
  SelecionaClass(Sender,edClassificacao,lbClass_Gerente);
end;

procedure TfrmCadUsuario.rctClass_VendedorClick(Sender: TObject);
begin
  SelecionaClass(Sender,edClassificacao,lbClass_Vendedor);
end;

procedure TfrmCadUsuario.rctConfirmarClick(Sender: TObject);
begin
  case rctConfirmar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Novo','Deseja adicionar um novo registro?','SIM',Novo_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Salvar','Deseja salvar as alterações?','SIM',Salvar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmCadUsuario.rctEditarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o registro selecionado?','SIM',EditarRegistro,'NÃO');
end;

procedure TfrmCadUsuario.EditarRegistro(Sender :TOBject);
begin
  EditandoRegistro(FId_Selecionado);
end;

procedure TfrmCadUsuario.EditandoRegistro(const AId:Integer);
var
  t :TThread;
  lNome :String;
  lCodigo :Integer;

begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
    lToken :String;
    lFoto :String;
    lId_Funcionario :Integer;
    lPush_Notification :String;
    lOrigem_Tipo :Integer;
    lOrigem_Descricao :String;
    lOrigem_Codigo :Integer;
    lDt_Cadastro :TDate;
    lHr_Cadastro :TTime;
  begin
      jsonArray := Dm_DeskTop.Usuario_Lista(
        0
        ,AId
        ,''
        ,''
        ,'');

      TThread.Synchronize(nil,
      procedure
      begin
        edNome.Tag := jsonArray.Get(x).GetValue<Integer>('id',0);
        edNome.Text := jsonArray.Get(x).GetValue<String>('nome','');
        edStatus.Tag := jsonArray.Get(x).GetValue<Integer>('status',1);
        case edStatus.Tag of
          0:edStatus.Text := 'INATIVO';
          1:edStatus.Text := 'ATIVO';
        end;
        edTipo.Tag := jsonArray.Get(x).GetValue<Integer>('tipo',1);
        case edTipo.Tag of
          0:edTipo.Text := 'FUNCIONÁRIO';
          1:edTipo.Text := 'FORNECEDOR';
          2:edTipo.Text := 'CLIENTE';
        end;
        edLogin.Text := jsonArray.Get(x).GetValue<String>('login','');
        edSenha.Text := jsonArray.Get(x).GetValue<String>('senha','');
        lToken := jsonArray.Get(x).GetValue<String>('token','');
        edPin.Text := jsonArray.Get(x).GetValue<String>('pin','');
        edEmail.Text := jsonArray.Get(x).GetValue<String>('email','');
        edCelular.Text := jsonArray.Get(x).GetValue<String>('celular','');
        edClassificacao.Tag := jsonArray.Get(x).GetValue<Integer>('classificacao',1);
        case edClassificacao.Tag of
          0:edClassificacao.Text := 'ADMINISTRADOR';
          1:edClassificacao.Text := 'GERENTE';
          2:edClassificacao.Text := 'CAIXA';
          3:edClassificacao.Text := 'VENDEDOR';
          4:edClassificacao.Text := 'ENTREGADOR';
          5:edClassificacao.Text := 'CONSUMIDOR';
        end;
        edLogradouro.Text := jsonArray.Get(x).GetValue<String>('logradouro','');
        edNumero.Text := jsonArray.Get(x).GetValue<Integer>('numero',0).ToString;
        edComplemento.Text := jsonArray.Get(x).GetValue<String>('complemento','');
        edBairro.Text := jsonArray.Get(x).GetValue<String>('bairro','');
        edMunicipio.Tag := jsonArray.Get(x).GetValue<Integer>('ibge',0);
        edMunicipio.Text := jsonArray.Get(x).GetValue<String>('municipio','');
        edUF.TagString := jsonArray.Get(x).GetValue<String>('uf_sigla','');
        edUF.Text := jsonArray.Get(x).GetValue<String>('uf','');
        lFoto := jsonArray.Get(x).GetValue<String>('foto','');
        lId_Funcionario := jsonArray.Get(x).GetValue<Integer>('id_funcionario',0);
        lPush_Notification := jsonArray.Get(x).GetValue<String>('push_notification','');
        lOrigem_Tipo := jsonArray.Get(x).GetValue<Integer>('origem_tipo',0);
        lOrigem_Descricao := jsonArray.Get(x).GetValue<String>('origem_descricao','');
        lOrigem_Codigo := jsonArray.Get(x).GetValue<Integer>('origem_codigo',0);
        lDt_Cadastro := StrToDate(jsonArray.Get(x).GetValue<String>('dt_cadastro',DateToStr(Date)));
        lHr_Cadastro := StrToTime(jsonArray.Get(x).GetValue<String>('hr_cadastro',TimeToStr(Time)));
      end);

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}

  end);

  t.OnTerminate := ThreadEnd_Edit;
  t.Start;
end;

procedure TfrmCadUsuario.ThreadEnd_Edit(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'','Erro editar um registro: ' + Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Configura_Botoes(4);
    Exibe_Labels;
    //tcPrincipal.GotoVisibleTab(1);
  end;
end;

procedure TfrmCadUsuario.Exibe_Labels;
begin
  TFuncoes.ExibeLabel(edNome,lbNome,FloatAnimation_Nome,10,-20);
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
  TFuncoes.ExibeLabel(edLogin,lbLogin,FloatAnimation_Login,10,-20);
  TFuncoes.ExibeLabel(edSenha,lbSenha,FloatAnimation_Senha,10,-20);
  TFuncoes.ExibeLabel(edPin,lbPin,FloatAnimation_Pin,10,-20);
  TFuncoes.ExibeLabel(edEmail,lbEmail,FloatAnimation_Email,10,-20);
  TFuncoes.ExibeLabel(edCelular,lbCelular,FloatAnimation_Celular,10,-20);
  TFuncoes.ExibeLabel(edClassificacao,lbClassificacao,FloatAnimation_Class,10,-20);
  TFuncoes.ExibeLabel(edLogradouro,lbLogradouro,FloatAnimation_Logradouro,10,-20);
  TFuncoes.ExibeLabel(edNumero,lbNumero,FloatAnimation_Numero,10,-20);
  TFuncoes.ExibeLabel(edNome,lbNome,FloatAnimation_Nome,10,-20);
  TFuncoes.ExibeLabel(edComplemento,lbComplemento,FloatAnimation_Complemento,10,-20);
  TFuncoes.ExibeLabel(edBairro,lbBairro,FloatAnimation_Bairro,10,-20);
  TFuncoes.ExibeLabel(edUF,lbUf,FloatAnimation_UF,10,-20);
  TFuncoes.ExibeLabel(edMunicipio,lbMunicipio,FloatAnimation_Municipio,10,-20);
end;

procedure TfrmCadUsuario.Novo_Registro(Sender:TOBject);
begin
  Configura_Botoes(0);
end;

procedure TfrmCadUsuario.Configura_Botoes(ABotao:Integer);
begin
  case ABotao of
    0:begin
      //Novo...
      Incia_Campos;
      rctConfirmar.Tag := 1;
      rctCancelar.Tag := 1;
      rctEditar.Enabled := False;
      imgCancelar.Bitmap := imgCancel.Bitmap;
      imgConfirmar.Bitmap := imgSalvar.Bitmap;
      FStatusTable := TStatusTable.stInsert;
      tcPrincipal.GotoVisibleTab(1);
    end;
    1:begin
      //Salvar...
      rctConfirmar.Tag := 0;
      rctCancelar.Tag := 0;
      rctEditar.Enabled := True;
      imgCancelar.Bitmap := imgDelete.Bitmap;
      imgConfirmar.Bitmap := imgNovo.Bitmap;
      FStatusTable := TStatusTable.stList;
      Incia_Campos;
      tcPrincipal.GotoVisibleTab(0);
    end;
    2:begin
      //Cancelar...
      rctConfirmar.Tag := 0;
      rctCancelar.Tag := 0;
      rctEditar.Enabled := True;
      imgCancelar.Bitmap := imgDelete.Bitmap;
      imgConfirmar.Bitmap := imgNovo.Bitmap;
      FStatusTable := TStatusTable.stList;
      Incia_Campos;
      tcPrincipal.GotoVisibleTab(0);
    end;
    3:begin
      //Excluir...
      rctConfirmar.Tag := 0;
      rctCancelar.Tag := 0;
      tcPrincipal.GotoVisibleTab(0);
      rctEditar.Enabled := True;
      imgCancelar.Bitmap := imgDelete.Bitmap;
      imgConfirmar.Bitmap := imgNovo.Bitmap;
      Listar_Dados(0,edPesquisar.Text,True);
      FStatusTable := TStatusTable.stList;
    end;
    4:begin
      //Editar...
      rctConfirmar.Tag := 1;
      rctCancelar.Tag := 1;
      rctEditar.Enabled := False;
      imgCancelar.Bitmap := imgCancel.Bitmap;
      imgConfirmar.Bitmap := imgSalvar.Bitmap;
      FStatusTable := TStatusTable.stUpdate;
      tcPrincipal.GotoVisibleTab(1);
    end;
  end;
end;

procedure TfrmCadUsuario.SelecionaClass(Sender:TObject; AEdit:TEdit;ALabel:TLabel);
begin
  AEdit.Tag := TRectangle(Sender).Tag;
  AEdit.Text := ALabel.Text;
  SelClassificacao;
end;

procedure TfrmCadUsuario.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja fechar as Configurações?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

procedure TfrmCadUsuario.rctStatus_AtivoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Ativo.Tag;
  edStatus.Text := lbStatus_Ativo.Text;
  SelStatus;
end;

procedure TfrmCadUsuario.rctStatus_InativoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Inativo.Tag;
  edStatus.Text := lbStatus_Inativo.Text;
  SelStatus;
end;

procedure TfrmCadUsuario.rctTipo_ClienteClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Cliente);
end;

procedure TfrmCadUsuario.rctTipo_FornecedorClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Fornecedor);
end;

procedure TfrmCadUsuario.rctTipo_FuncionarioClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Funcionario);
end;

procedure TfrmCadUsuario.SelecionaTipo(Sender:TObject; AEdit:TEdit;ALabel:TLabel);
begin
  AEdit.Tag := TRectangle(Sender).Tag;
  AEdit.Text := ALabel.Text;
  SelTipo;
end;

end.
