unit uDeskTop.CadFornecedor;

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

  uDeskTop.Principal,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.ListView, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, FMX.TabControl, FMX.Layouts, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Effects;

type
  TStatusTable = (stList,stInsert,stUpdate,stDelete);
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;

  TfrmFornecedor = class(TForm)
    FDMem_Registros: TFDMemTable;
    FDMem_RegistrosID: TIntegerField;
    FDMem_RegistrosRAZAO_SOCIAL: TStringField;
    FDMem_RegistrosNOME_FANTASIA: TStringField;
    FDMem_RegistrosSTATUS: TIntegerField;
    FDMem_RegistrosTIPO_PESSOA: TStringField;
    FDMem_RegistrosDOCUMENTO: TStringField;
    FDMem_RegistrosINSCRICAO_ESTADUAL: TStringField;
    FDMem_RegistrosINSCRICAO_MUNICIPAL: TStringField;
    FDMem_RegistrosID_USUARIO: TIntegerField;
    FDMem_RegistrosDT_CADASTRO: TDateField;
    FDMem_RegistrosHR_CADASTRO: TTimeField;
    imgCancel: TImage;
    imgDelete: TImage;
    imgExpandir: TImage;
    imgNovo: TImage;
    imgNVer: TImage;
    imgRetrair: TImage;
    imgSalvar: TImage;
    imgVer: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiFiltro: TTabItem;
    lytLista: TLayout;
    rctFiltro: TRectangle;
    lytPesq_Filtro: TLayout;
    edPesquisar: TEdit;
    lbPesquisar: TLabel;
    FloatAnimation_Pesq: TFloatAnimation;
    imgPesquisar: TImage;
    rctLista: TRectangle;
    lvLista: TListView;
    tiCadastro: TTabItem;
    rctCadastro: TRectangle;
    lytDetail_Espacos: TLayout;
    lytRow_001: TLayout;
    edRazaoSocial: TEdit;
    lbRazaoSocial: TLabel;
    FloatAnimation_RazaoSocial: TFloatAnimation;
    edStatus: TEdit;
    lbStatus: TLabel;
    FloatAnimation_Status: TFloatAnimation;
    imgStatus: TImage;
    edTipo: TEdit;
    lbTipo: TLabel;
    FloatAnimation_Tipo: TFloatAnimation;
    imgTipo: TImage;
    lytRow_002: TLayout;
    edNomeFantasia: TEdit;
    lbNomeFantasia: TLabel;
    FloatAnimation_NomeFantasia: TFloatAnimation;
    lytRow_003: TLayout;
    edDocumento: TEdit;
    lbDocumento: TLabel;
    FloatAnimation_Documento: TFloatAnimation;
    edInscEstadual: TEdit;
    lbInscEstadual: TLabel;
    FloatAnimation_InscEstadual: TFloatAnimation;
    edInsMunicipal: TEdit;
    lbInscMunicipal: TLabel;
    FloatAnimation_InscMunicipal: TFloatAnimation;
    rctStatus: TRectangle;
    rctStatus_Ativo: TRectangle;
    lbStatus_Ativo: TLabel;
    rctStatus_Inativo: TRectangle;
    lbStatus_Inativo: TLabel;
    FloatAnimation_SelStatus: TFloatAnimation;
    rctTipo: TRectangle;
    rctTipo_Juridico: TRectangle;
    lbTipo_Juridico: TLabel;
    rctTipo_Fisico: TRectangle;
    lbTipo_Fisico: TLabel;
    FloatAnimation_SelTipo: TFloatAnimation;
    lytRow_000: TLayout;
    lbId_Titulo: TLabel;
    lbId: TLabel;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    rctConfirmar: TRectangle;
    Circle_Novo: TCircle;
    imgConfirmar: TImage;
    rctCancelar: TRectangle;
    Circle_Cancelar: TCircle;
    imgCancelar: TImage;
    rctEditar: TRectangle;
    Circle_Editar: TCircle;
    imgEditar: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytMenu: TLayout;
    rctMenu_Principal: TRectangle;
    imgMenu: TImage;
    lytFechar: TLayout;
    rctFechar: TRectangle;
    imgFechar: TImage;
    lytNavegarPages: TLayout;
    lytExclui_Adicionais: TLayout;
    rctExclui_Adicionais: TRectangle;
    CircleExclui_Adicionais: TCircle;
    imgExclui_Adicionais: TImage;
    lytEdita_Adicionais: TLayout;
    rctEdita_Adicionais: TRectangle;
    Circle_Edita_Adicionais: TCircle;
    imgEdita_Adicionais: TImage;
    lytNovo_Adicionais: TLayout;
    rctNovo_Adicionais: TRectangle;
    CircleNovo_Adicionais: TCircle;
    imgNovo_Adicionais: TImage;
    lytAdicionais: TLayout;
    rctAdicionais: TRectangle;
    tcAdicionais: TTabControl;
    tiEndereco: TTabItem;
    lytEndereco: TLayout;
    rctEndereco: TRectangle;
    lvEnderecos: TListView;
    tiTelefone: TTabItem;
    lytTelefone: TLayout;
    rctTelefone: TRectangle;
    lvTelefone: TListView;
    tiEmail: TTabItem;
    lytEmail: TLayout;
    rctEmail: TRectangle;
    lvEmail: TListView;
    lytAdicionais_Nav: TLayout;
    lytNavegarPages_Buttons: TLayout;
    imgEndereco: TImage;
    imgTelefone: TImage;
    imgEmail: TImage;
    rctTampa_Email: TRectangle;
    lytCadEmail: TLayout;
    rctCadEmail: TRectangle;
    ShadowEffect4: TShadowEffect;
    lytCadEmail_Footer: TLayout;
    lytCadEmail_Buttons: TLayout;
    rctCadEmail_Confirmar: TRectangle;
    lbCadEmail_Confirmar: TLabel;
    rctCadEmail_Cancelar: TRectangle;
    lbCadEmail_Cancelar: TLabel;
    lytCadEmail_Detail: TLayout;
    lytCadEmail_Row001: TLayout;
    edEmail: TEdit;
    lbEmail: TLabel;
    faEmail: TFloatAnimation;
    lytCadEmail_Row002: TLayout;
    edEmail_Responsavel: TEdit;
    lbEmail_Responsavel: TLabel;
    faEmail_Responsavel: TFloatAnimation;
    lytEmail_Setor: TLayout;
    edEmail_Setor: TEdit;
    lbEmail_Setor: TLabel;
    faEmail_Setor: TFloatAnimation;
    imgEmail_Setor: TImage;
    rctTampa_Endereco: TRectangle;
    lytCadEndereco: TLayout;
    rctCadEndereco: TRectangle;
    ShadowEffect1: TShadowEffect;
    lytCadEndereco_Footer: TLayout;
    lytCadEndereco_Buttons: TLayout;
    rctCadEndereco_Confirmar: TRectangle;
    lbCadEndereco_Confirmar: TLabel;
    rctCadEndereco_Cancelar: TRectangle;
    lbCadEndereco_Cancelar: TLabel;
    lytCadEndereco_Detail: TLayout;
    lytCadEnd_Row001: TLayout;
    edCadEnd_Cep: TEdit;
    lbCadEnd_Cep: TLabel;
    faCadEnd_Cep: TFloatAnimation;
    imgCadEnd_Cep: TImage;
    edCadEnd_Logradouro: TEdit;
    lbCadEnd_Logradouro: TLabel;
    faCadEnd_Logradouro: TFloatAnimation;
    edCadEnd_Nr: TEdit;
    lbCadEdn_Nr: TLabel;
    faCadEnd_Nr: TFloatAnimation;
    lytCadEnd_Row002: TLayout;
    edCadEnd_Complemento: TEdit;
    lbCadEnd_Complemento: TLabel;
    faCadEnd_Complemento: TFloatAnimation;
    lytCadEnd_Row003: TLayout;
    edCadEnd_Bairro: TEdit;
    lbCadEnd_Bairro: TLabel;
    faCadEnd_Bairro: TFloatAnimation;
    edCadEnd_Municipio: TEdit;
    lbCadEnd_Municipio: TLabel;
    faCadEnd_Municipio: TFloatAnimation;
    imgCadEnd_Municipio: TImage;
    edCadEnd_UF: TEdit;
    lbCadEnd_UF: TLabel;
    faCadEnd_UF: TFloatAnimation;
    imgCadEnd_UF: TImage;
    lytCadEnd_Row004: TLayout;
    edCadEnd_Regiao: TEdit;
    lbCadEnd_Regiao: TLabel;
    faCadEnd_Regiao: TFloatAnimation;
    imgCadEnd_Regiao: TImage;
    edCadEnd_Pais: TEdit;
    lbCadEnd_Pais: TLabel;
    faCadEnd_Pais: TFloatAnimation;
    imgCadEnd_Pais: TImage;
    rctTampa_Telefone: TRectangle;
    lytCad_Telefone: TLayout;
    rctCad_Telefone: TRectangle;
    ShadowEffect2: TShadowEffect;
    lytCadTelefone_Footer: TLayout;
    lytCadTel_Buttons: TLayout;
    rctCadTel_Confirmar: TRectangle;
    lbCadTel_Cnacelar: TLabel;
    rctCadTel_Cancelar: TRectangle;
    lbCadTel_Confirmar: TLabel;
    lytCadTelefone_Detail: TLayout;
    lytCadTelefone_Row001: TLayout;
    edCadTel_Tipo: TEdit;
    lbCadTel_Tipo: TLabel;
    faCadTel_Tipo: TFloatAnimation;
    imgCadTel_Tipo: TImage;
    edCadTel_Numero: TEdit;
    lbCadTel_Numero: TLabel;
    faCadTel_Numero: TFloatAnimation;
    rctCadTel_ListaTipo: TRectangle;
    rctCadTel_Tipo_Comercial: TRectangle;
    lbCadTel_Tipo_Comercial: TLabel;
    rctCadTel_Tipo_Celular: TRectangle;
    lbCadTel_Tipo_Celular: TLabel;
    faCadTel_ListaTipo: TFloatAnimation;
    rctCadTel_Tipo_Residencial: TRectangle;
    lbCadTel_Tipo_Residencial: TLabel;
    FDMem_Endereco: TFDMemTable;
    FDMem_EnderecoID_EMPRESA: TIntegerField;
    FDMem_EnderecoID: TIntegerField;
    FDMem_EnderecoCEP: TStringField;
    FDMem_EnderecoLOGRADOURO: TStringField;
    FDMem_EnderecoNUMERO: TStringField;
    FDMem_EnderecoCOMPLEMENTO: TStringField;
    FDMem_EnderecoBAIRRO: TStringField;
    FDMem_EnderecoIBGE: TIntegerField;
    FDMem_EnderecoMUNICIPIO: TStringField;
    FDMem_EnderecoSIGLA_UF: TStringField;
    FDMem_EnderecoUF: TStringField;
    FDMem_EnderecoREGIAO: TStringField;
    FDMem_EnderecoCODIGO_PAIS: TIntegerField;
    FDMem_EnderecoPAIS: TStringField;
    FDMem_EnderecoID_USUARIO: TIntegerField;
    FDMem_EnderecoDT_CADASTRO: TDateField;
    FDMem_EnderecoHR_CADASTRO: TTimeField;
    FDMem_Email: TFDMemTable;
    FDMem_EmailID_EMPRESA: TIntegerField;
    FDMem_EmailID: TIntegerField;
    FDMem_EmailRESPONSAVEL: TStringField;
    FDMem_EmailID_SETOR: TIntegerField;
    FDMem_EmailDESC_SETOR: TStringField;
    FDMem_EmailEMAIL: TStringField;
    FDMem_EmailID_USUARIO: TIntegerField;
    FDMem_EmailDT_CADASTRO: TDateField;
    FDMem_EmailHF_CADASTRO: TTimeField;
    FDMem_Telefone: TFDMemTable;
    FDMem_TelefoneID_EMPRESA: TIntegerField;
    FDMem_TelefoneID: TIntegerField;
    FDMem_TelefoneTIPO: TIntegerField;
    FDMem_TelefoneNUMERO: TStringField;
    FDMem_TelefoneID_USUARIO: TIntegerField;
    FDMem_TelefoneDT_CADASTRO: TDateField;
    FDMem_TelefoneHR_CADASTRO: TTimeField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctFecharClick(Sender: TObject);
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPesquisarTyping(Sender: TObject);
    procedure lvListaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvListaPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctConfirmarClick(Sender: TObject);
    procedure rctEditarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edRazaoSocialKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edRazaoSocialTyping(Sender: TObject);
    procedure edStatusKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edStatusTyping(Sender: TObject);
    procedure edTipoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edTipoTyping(Sender: TObject);
    procedure edNomeFantasiaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edNomeFantasiaTyping(Sender: TObject);
    procedure edDocumentoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edDocumentoTyping(Sender: TObject);
    procedure edInscEstadualKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edInscEstadualTyping(Sender: TObject);
    procedure edInsMunicipalTyping(Sender: TObject);
    procedure edStatusClick(Sender: TObject);
    procedure edStatusChange(Sender: TObject);
    procedure edTipoChange(Sender: TObject);
    procedure edTipoClick(Sender: TObject);
    procedure rctStatus_AtivoClick(Sender: TObject);
    procedure rctStatus_InativoClick(Sender: TObject);
    procedure rctTipo_FisicoClick(Sender: TObject);
    procedure rctTipo_JuridicoClick(Sender: TObject);
    procedure imgEnderecoClick(Sender: TObject);
  private
    FProcessando: String;
    FProcessandoEnd: String;
    FProcessandoTel: String;
    FProcessandoEmail: String;

    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    lEnder_Ini :String;
    FFechar_Sistema :Boolean;
    FId_Selecionado :Integer;
    FNome_Selecionado :String;
    FStatusTable: TStatusTable;

    {$Region 'Complementos'}
      FEndereco_Id :Integer;
      FTelefone_ID :Integer;
      FEmail_ID :Integer;
      FStatusTable_End: TStatusTable;
      FStatusTable_Tel: TStatusTable;
      FStatusTable_Email: TStatusTable;
    {$EndRegion 'Complementos'}

    procedure Abortar_Fechamento(Sender: TOBject);
    procedure Confirmar_Fechamento(Sender :TObject);

    procedure SelStatus;
    procedure ThreadEnd_Status(Sender: TOBject);

    procedure SelTipo;
    procedure ThreadEnd_Tipo(Sender: TOBject);
    procedure SelecionaTipo(Sender:TObject; AEdit:TEdit;ALabel:TLabel);

    {$Region 'Empresa'}
      procedure Listar_Dados(
        const APagina: Integer;
        const ABusca: String;
        const AInd_Clear: Boolean);
      procedure AddItens_LV(
        const ACodigo:Integer;
        const ANome:String);
      procedure ThreadEnd_Lista(Sender: TOBject);
      procedure Salvar_Alteracoes(Sender :TOBject);
      procedure ThreadEnd_SalvarRegistro(Sender: TOBject);
      procedure Cancelar_Alteracoes(Sender :TOBject);
      procedure Novo_Registro(Sender: TOBject);
      procedure Deletar_Registro(Sender: TOBject);
      procedure ThreadEnd_DeletarRegistro(Sender: TOBject);
      procedure EditarRegistro(Sender: TOBject);
      procedure EditandoRegistro(const AId: Integer);
      procedure ThreadEnd_Edit(Sender: TOBject);
    {$EndRegion 'Empresa'}

    procedure Configura_Botoes(ABotao: Integer);
    procedure Incia_Campos;
    procedure Exibe_Labels;

    {$Region 'Endereço'}
      procedure NovoEndereco(Sender: TOBject);
      procedure CancelaEndereco(Sender: TObject);
      procedure SalvarEndereco(Sender: TObject);
      procedure ThreadEnd_SalvarEndereco(Sender: TObject);
      procedure ThreadEnd_BuscaCep(Sender: TObject);
      procedure Listar_Endereco(
        const APagina:Integer;
        const AEmpresa:Integer;
        const AInd_Clear:Boolean;
        const AId_Endereco:Integer=0);
      procedure AddEndItens_LV(
        const AIdEmpresa :Integer;
        const AId :Integer;
        const APais_Nome: String;
        const ARegiao_Nome :String;
        const AIbge :String;
        const AMunicipio :String;
        const ANr :String;
        const AUf_Sigla :String;
        const ABairro :String;
        const ACep :String;
        const ALogradouro :String;
        const AComplemento: String);
      procedure ThreadEnd_ListaEnd(Sender: TObject);
      procedure Seleciona_Municipio(Aid: Integer; ANome: String; AIbge:String);
      procedure Seleciona_UF(AId: Integer; ASiglaUF, ANome: String);
      procedure Seleciona_Regiao(Aid: Integer; ANome: String);
      procedure Seleciona_Pais(Aid: Integer; ANome: String);
      procedure Excluir_Endereco(Sender: TObject);
      procedure Editar_Endereco(Sender: TObject);
      procedure Limpar_Endereco;
      procedure ThreadEnd_DeletarEndereco(Sender: TOBject);
      procedure ThreadEnd_EditaEndereco(Sender: TOBject);
      procedure Exibir_Labels_Endereco;
    {$EndRegion 'Endereço'}

    {$Region 'Email'}
      procedure NovoEmail(Sender: TOBject);
      procedure Limpar_Email;
      procedure SalvarEmail(Sender: TObject);
      procedure SalvarAlteracao_Email;
      procedure ThreadEnd_SalvarEmail(Sender: TOBject);
      procedure CancelaEmail(Sender: TOBject);
      procedure Excluir_Email(Sender: TObject);
      procedure ThreadEnd_ExcluirEmail(Sender: TOBject);
      procedure Editar_Email(Sender: TObject);
      procedure ThreadEnd_EditaEmail(Sender: TOBject);
      procedure ListarEmail(
        const APagina:Integer;
        const AEmpresa:Integer;
        const AInd_Clear:Boolean;
        const AId_Telefone:Integer=0);
      procedure AddEmailItens_LV(
        const AIdEmpresa :Integer;
        const AId :Integer;
        const AEmail: String;
        const AResponsavel: String;
        const ASetorID :Integer;
        const ASetor :String);
      procedure ThreadEnd_ListaEmail(Sender: TObject);
      procedure Exibir_Labels_Email;
    {$EndRegion 'Email'}

    {$Region 'Telefone'}
      procedure NovoTelefone(Sender: TOBject);
      procedure SalvarTelefone(Sender: TOBject);
      procedure ThreadEnd_SalvarTelefone(Sender: TOBject);
      procedure CancelaTelefone(Sender: TOBject);
      procedure Excluir_Telefone(Sender: TOBject);
      procedure ThreadEnd_DeletarTelefone(Sender: TObject);
      procedure Editar_Telefone(Sender: TObject);
      procedure ThreadEnd_EditaTelefone(Sender: TObject);
      procedure Limpar_Telefone;
      procedure ListarTelefone(
        const APagina:Integer;
        const AEmpresa:Integer;
        const AInd_Clear:Boolean;
        const AId_Telefone:Integer=0);
      procedure AddTelItens_LV(
        const AIdEmpresa :Integer;
        const AId :Integer;
        const ATipo: Integer;
        const ATipoDesc: String;
        const ATelefone :String);
      procedure ThreadEnd_ListaTel(Sender: TObject);
      procedure Exibir_Labels_Telefone;
      procedure SalvarAlteracao_Telefone;
    {$EndRegion 'Telefone'}

  public
    ExecuteOnClose :TExecuteOnClose;
    RetornaRegistro :Boolean;
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

{$R *.fmx}

procedure TfrmFornecedor.Abortar_Fechamento(Sender: TOBject);
begin
  Abort;
end;

procedure TfrmFornecedor.AddEmailItens_LV(const AIdEmpresa, AId: Integer;
  const AEmail, AResponsavel: String; const ASetorID: Integer;
  const ASetor: String);
begin

end;

procedure TfrmFornecedor.AddEndItens_LV(const AIdEmpresa, AId: Integer;
  const APais_Nome, ARegiao_Nome, AIbge, AMunicipio, ANr, AUf_Sigla, ABairro,
  ACep, ALogradouro, AComplemento: String);
begin

end;

procedure TfrmFornecedor.AddItens_LV(const ACodigo: Integer;
  const ANome: String);
begin
  with lvLista.Items.Add do
  begin
    Tag := ACodigo;
    TagString := ANome;
    TListItemText(Objects.FindDrawable('edNome')).TagString := ACodigo.ToString;
    TListItemText(Objects.FindDrawable('edNome')).Text := ANome;
  end;
end;

procedure TfrmFornecedor.AddTelItens_LV(const AIdEmpresa, AId, ATipo: Integer;
  const ATipoDesc, ATelefone: String);
begin

end;

procedure TfrmFornecedor.CancelaEmail(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.CancelaEndereco(Sender: TObject);
begin
  rctTampa_Endereco.Visible := False;
end;

procedure TfrmFornecedor.Cancelar_Alteracoes(Sender: TOBject);
begin
  Configura_Botoes(2);
end;

procedure TfrmFornecedor.CancelaTelefone(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.Configura_Botoes(ABotao: Integer);
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

procedure TfrmFornecedor.Confirmar_Fechamento(Sender: TObject);
begin
  if RetornaRegistro then
    ExecuteOnClose(FId_Selecionado,FNome_Selecionado);

  FFechar_Sistema := True;
  Close;
end;

procedure TfrmFornecedor.Deletar_Registro(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.Fornecedor_Excluir(FId_Selecionado);
    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(3);
    end);
  end);

  t.OnTerminate := ThreadEnd_DeletarRegistro;
  t.Start;
end;

procedure TfrmFornecedor.edDocumentoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edInscEstadual);
end;

procedure TfrmFornecedor.edDocumentoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edDocumento,lbDocumento,FloatAnimation_Documento,10,-20);
  if edTipo.TagString = 'F' then
    Formatar(edDocumento, TFormato.CPF)
  else
    Formatar(edDocumento, TFormato.CNPJ);
end;

procedure TfrmFornecedor.edInscEstadualKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edInsMunicipal);
end;

procedure TfrmFornecedor.edInscEstadualTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edInscEstadual,lbInscEstadual,FloatAnimation_InscEstadual,10,-20);
  Formatar(edInscEstadual, TFormato.InscricaoEstadual,'ES');
end;

procedure TfrmFornecedor.edInsMunicipalTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edInsMunicipal,lbInscMunicipal,FloatAnimation_InscMunicipal,10,-20);
end;

procedure TfrmFornecedor.EditandoRegistro(const AId: Integer);
var
  t :TThread;
begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
    lDt_Cadastro :TDate;
    lHr_Cadastro :TTime;
  begin
      jsonArray := Dm_DeskTop.Fornecedor_Lista(
        0
        ,AId
        ,''
        ,'');

      TThread.Synchronize(nil,
      procedure
      begin
        edRazaoSocial.Tag := jsonArray.Get(x).GetValue<Integer>('id',0);
        edRazaoSocial.Text := jsonArray.Get(x).GetValue<String>('razaoSocial','');
        lbId.Text := FormatFloat('#,##0',edRazaoSocial.Tag);
        edNomeFantasia.Text := jsonArray.Get(x).GetValue<String>('nomeFantasia','');
        edStatus.Tag := jsonArray.Get(x).GetValue<Integer>('status',0);
        case edStatus.Tag of
          0:edStatus.Text := 'INATIVO';
          1:edStatus.Text := 'ATIVO';
        end;
        edTipo.TagString := jsonArray.Get(x).GetValue<String>('tipoPessoa','J');
        if edTipo.TagString = 'J' then
        begin
          edTipo.Text := 'JURÍDICO';
          edTipo.Tag := 0;
        end
        else
        begin
          edTipo.Text := 'FÍSICO';
          edTipo.Tag := 1;
        end;
        edDocumento.Text := jsonArray.Get(x).GetValue<String>('documento','');
        edInscEstadual.Text := jsonArray.Get(x).GetValue<String>('inscricaoEstadual','');
        edInsMunicipal.Text := jsonArray.Get(x).GetValue<String>('inscricaoMunicipal','');
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

procedure TfrmFornecedor.EditarRegistro(Sender: TOBject);
begin
  EditandoRegistro(FId_Selecionado);
end;

procedure TfrmFornecedor.Editar_Email(Sender: TObject);
begin

end;

procedure TfrmFornecedor.Editar_Endereco(Sender: TObject);
begin

end;

procedure TfrmFornecedor.Editar_Telefone(Sender: TObject);
begin

end;

procedure TfrmFornecedor.edNomeFantasiaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edDocumento);
end;

procedure TfrmFornecedor.edNomeFantasiaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNomeFantasia,lbNomeFantasia,FloatAnimation_NomeFantasia,10,-20);
end;

procedure TfrmFornecedor.edPesquisarKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmFornecedor.edPesquisarTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPesquisar,lbPesquisar,FloatAnimation_Pesq,10,-20);
end;

procedure TfrmFornecedor.edRazaoSocialKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edStatus);
end;

procedure TfrmFornecedor.edRazaoSocialTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edRazaoSocial,lbRazaoSocial,FloatAnimation_RazaoSocial,10,-20);
end;

procedure TfrmFornecedor.edStatusChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmFornecedor.edStatusClick(Sender: TObject);
begin
  SelStatus;
end;

procedure TfrmFornecedor.edStatusKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edTipo);
end;

procedure TfrmFornecedor.edStatusTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmFornecedor.edTipoChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
end;

procedure TfrmFornecedor.edTipoClick(Sender: TObject);
begin
  SelTipo;
end;

procedure TfrmFornecedor.edTipoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edNomeFantasia);
end;

procedure TfrmFornecedor.edTipoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
end;

procedure TfrmFornecedor.Excluir_Email(Sender: TObject);
begin

end;

procedure TfrmFornecedor.Excluir_Endereco(Sender: TObject);
begin

end;

procedure TfrmFornecedor.Excluir_Telefone(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.Exibe_Labels;
begin
  TFuncoes.ExibeLabel(edRazaoSocial,lbRazaoSocial,FloatAnimation_RazaoSocial,10,-20);
  TFuncoes.ExibeLabel(edNomeFantasia,lbNomeFantasia,FloatAnimation_NomeFantasia,10,-20);
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
  TFuncoes.ExibeLabel(edDocumento,lbDocumento,FloatAnimation_Documento,10,-20);
  TFuncoes.ExibeLabel(edInscEstadual,lbInscEstadual,FloatAnimation_InscEstadual,10,-20);
  TFuncoes.ExibeLabel(edInsMunicipal,lbInscMunicipal,FloatAnimation_InscMunicipal,10,-20);
end;

procedure TfrmFornecedor.Exibir_Labels_Email;
begin

end;

procedure TfrmFornecedor.Exibir_Labels_Endereco;
begin

end;

procedure TfrmFornecedor.Exibir_Labels_Telefone;
begin

end;

procedure TfrmFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmFornecedor := Nil;
  FId_Selecionado := 0;
  FNome_Selecionado := '';
end;

procedure TfrmFornecedor.FormCreate(Sender: TObject);
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

  FMensagem := TFancyDialog.Create(frmFornecedor);

  FStatusTable := TStatusTable.stList;

  FId_Selecionado := 0;
  FNome_Selecionado := '';
  tcPrincipal.ActiveTab := tiFiltro;
  tcAdicionais.ActiveTab := tiEndereco;

end;

procedure TfrmFornecedor.imgEnderecoClick(Sender: TObject);
begin
  imgEndereco.Opacity := 0.5;
  imgTelefone.Opacity := 0.5;
  imgEmail.Opacity := 0.5;
  case TImage(Sender).Tag of
    0:begin
      //Endereço...
      TImage(Sender).Opacity := 1;
    end;
    1:begin
      //Telefone
      TImage(Sender).Opacity := 1;
    end;
    2:begin
      //Email...
      TImage(Sender).Opacity := 1;
    end;
  end;

  tcAdicionais.GotoVisibleTab(TImage(Sender).Tag);
end;

procedure TfrmFornecedor.Incia_Campos;
begin
  edRazaoSocial.Tag := 0;
  edRazaoSocial.Text := '';
  edNomeFantasia.Text := '';
  edStatus.Tag := 0;
  edStatus.Text := '';
  edTipo.Tag := 0;
  edTipo.Text := '';
  edDocumento.Text := '';
  edInscEstadual.Text := '';
  edInsMunicipal.Text := '';
  lbId.Tag := 0;
  lbId.Text := '0';

  Exibe_Labels;
end;

procedure TfrmFornecedor.Limpar_Email;
begin

end;

procedure TfrmFornecedor.Limpar_Endereco;
begin

end;

procedure TfrmFornecedor.Limpar_Telefone;
begin

end;

procedure TfrmFornecedor.ListarEmail(const APagina, AEmpresa: Integer;
  const AInd_Clear: Boolean; const AId_Telefone: Integer);
begin

end;

procedure TfrmFornecedor.ListarTelefone(const APagina, AEmpresa: Integer;
  const AInd_Clear: Boolean; const AId_Telefone: Integer);
begin

end;

procedure TfrmFornecedor.Listar_Dados(const APagina: Integer;
  const ABusca: String; const AInd_Clear: Boolean);
var
  t :TThread;
  lNome :String;
  lCodigo :Integer;

begin
  if FProcessando = 'processando' then
      exit;
  FProcessando := 'processando';

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
      lNome := UpperCase(ABusca)
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

      jsonArray := Dm_DeskTop.Fornecedor_Lista(
        lvLista.Tag
        ,lCodigo
        ,''
        ,lNome);

      for x := 0 to jsonArray.Size -1 do
      begin
        TThread.Synchronize(nil,
        procedure
        begin
            AddItens_LV(
              jsonArray.Get(x).GetValue<Integer>('id')
              ,jsonArray.Get(x).GetValue<String>('razaoSocial')
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
      //lvLista.TagString := '';
      FProcessando := '';

      //Força a chamada do evento onUpdateObjects da listview...
      lvLista.Margins.Bottom := 6;
      lvLista.Margins.Bottom := 5;
      //---------------------------------------------
  end);

  t.OnTerminate := ThreadEnd_Lista;
  t.Start;
end;

procedure TfrmFornecedor.Listar_Endereco(const APagina, AEmpresa: Integer;
  const AInd_Clear: Boolean; const AId_Endereco: Integer);
begin

end;

procedure TfrmFornecedor.lvListaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FId_Selecionado := Aitem.Tag;
  FNome_Selecionado := AItem.TagString;
end;

procedure TfrmFornecedor.lvListaPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvLista.Items.Count >= 0) and (lvLista.Tag >= 0) then
  begin
    if lvLista.GetItemRect(lvLista.Items.Count - 3).Bottom <= lvLista.Height then
      Listar_Dados(lvLista.Tag,edPesquisar.Text,False)
  end;
end;

procedure TfrmFornecedor.NovoEmail(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.NovoEndereco(Sender: TOBject);
begin
  Limpar_Endereco;

  FStatusTable_End := TStatusTable.stInsert;
  rctTampa_Endereco.Align := TAlignLayout.Contents;
  rctTampa_Endereco.Visible := True;
  edCadEnd_Logradouro.Tag := 0;
end;

procedure TfrmFornecedor.NovoTelefone(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.Novo_Registro(Sender: TOBject);
begin
  Configura_Botoes(0);
end;

procedure TfrmFornecedor.rctCancelarClick(Sender: TObject);
begin
  case rctCancelar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Excluir','Deseja excluir o registro?','SIM',Deletar_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Cancelar','Deseja cancelar as alterações?','SIM',Cancelar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmFornecedor.rctConfirmarClick(Sender: TObject);
begin
  case rctConfirmar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Novo','Deseja adicionar um novo registro?','SIM',Novo_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Salvar','Deseja salvar as alterações?','SIM',Salvar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmFornecedor.rctEditarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o registro selecionado?','SIM',EditarRegistro,'NÃO');
end;

procedure TfrmFornecedor.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Fechar formulário?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

procedure TfrmFornecedor.rctStatus_AtivoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Ativo.Tag;
  edStatus.Text := lbStatus_Ativo.Text;
  SelStatus;
end;

procedure TfrmFornecedor.rctStatus_InativoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Ativo.Tag;
  edStatus.Text := lbStatus_Ativo.Text;
  SelStatus;
end;

procedure TfrmFornecedor.rctTipo_FisicoClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Fisico);
end;

procedure TfrmFornecedor.rctTipo_JuridicoClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Juridico);
end;

procedure TfrmFornecedor.SalvarAlteracao_Email;
begin

end;

procedure TfrmFornecedor.SalvarAlteracao_Telefone;
begin

end;

procedure TfrmFornecedor.SalvarEmail(Sender: TObject);
begin

end;

procedure TfrmFornecedor.SalvarEndereco(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmFornecedor,'Salvando endereço');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    FDMem_Endereco.Active := False;
    FDMem_Endereco.Active := True;
    FDMem_Endereco.Insert;
    FDMem_EnderecoID_EMPRESA.AsInteger := lbId.Tag;
    FDMem_EnderecoID.AsInteger := rctCadEndereco.Tag;// edCadEnd_Logradouro.Tag;
    FDMem_EnderecoCEP.AsString := edCadEnd_Cep.Text;
    FDMem_EnderecoLOGRADOURO.AsString := edCadEnd_Logradouro.Text;
    FDMem_EnderecoNUMERO.AsString := edCadEnd_Nr.Text;
    FDMem_EnderecoCOMPLEMENTO.AsString := edCadEnd_Complemento.Text;
    FDMem_EnderecoBAIRRO.AsString := edCadEnd_Bairro.Text;
    FDMem_EnderecoIBGE.AsInteger := edCadEnd_Municipio.TagString.ToInteger;
    FDMem_EnderecoMUNICIPIO.AsString := edCadEnd_Municipio.Text;
    FDMem_EnderecoSIGLA_UF.AsString := edCadEnd_UF.TagString;
    FDMem_EnderecoUF.AsString := edCadEnd_UF.Text;
    FDMem_EnderecoREGIAO.AsString := edCadEnd_Regiao.Text;
    FDMem_EnderecoCODIGO_PAIS.AsInteger := edCadEnd_Pais.Tag;
    FDMem_EnderecoPAIS.AsString := edCadEnd_Pais.Text;
    FDMem_EnderecoID_USUARIO.AsInteger := Dm_DeskTop.FDMem_UsuariosID.AsInteger;
    FDMem_EnderecoDT_CADASTRO.AsDateTime := Date;
    FDMem_EnderecoHR_CADASTRO.AsDateTime := Time;
    FDMem_Endereco.Post;

    if FStatusTable_End = stInsert then
    begin
      if not Dm_DeskTop.EmpresaEnd_Cadastro(FDMem_Endereco.ToJSONArray,0) then
        raise Exception.Create('Erro ao salvar as alterações');
    end
    else if FStatusTable_End = stUpdate then
    begin
      if not Dm_DeskTop.EmpresaEnd_Cadastro(FDMem_Endereco.ToJSONArray,1) then
        raise Exception.Create('Erro ao salvar as alterações');
    end;

    FStatusTable_End := TStatusTable.stList;

  end);

  t.OnTerminate := ThreadEnd_SalvarEndereco;
  t.Start;
end;

procedure TfrmFornecedor.SalvarTelefone(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.Salvar_Alteracoes(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    if Trim(edRazaoSocial.Text) = '' then
      raise Exception.Create('Razão Social obrigatória');
    if edStatus.Tag = -1 then
      raise Exception.Create('Status obrigtório');
    if edTipo.TagString = '' then
      raise Exception.Create('Tipo obrigtório');

    FDMem_Registros.Active := False;
    FDMem_Registros.Active := True;
    FDMem_Registros.Insert;
      if FStatusTable = stInsert then
        FDMem_RegistrosID.AsInteger := 0
      else if FStatusTable = stUpdate then
        FDMem_RegistrosID.AsInteger := edRazaoSocial.Tag;

      FDMem_RegistrosRAZAO_SOCIAL.AsString := edRazaoSocial.Text;
      FDMem_RegistrosNOME_FANTASIA.AsString := edNomeFantasia.Text;
      FDMem_RegistrosSTATUS.AsInteger := edStatus.Tag;
      FDMem_RegistrosTIPO_PESSOA.AsString := edTipo.TagString;
      FDMem_RegistrosDOCUMENTO.AsString := edDocumento.Text;
      FDMem_RegistrosINSCRICAO_ESTADUAL.AsString := edInscEstadual.Text;
      FDMem_RegistrosINSCRICAO_MUNICIPAL.AsString := edInsMunicipal.Text;
      FDMem_RegistrosID_USUARIO.AsInteger := Dm_DeskTop.FDMem_UsuariosID.AsInteger;
      FDMem_RegistrosDT_CADASTRO.AsString := DateToStr(Date);
      FDMem_RegistrosHR_CADASTRO.AsString := TimeToStr(Time);
    FDMem_Registros.Post;

    if FStatusTable = stInsert then
    begin
      if not Dm_DeskTop.Fornecedor_Cadastro(FDMem_Registros.ToJSONArray,0) then
        raise Exception.Create('Erro ao salvar as alterações');
    end
    else if FStatusTable = stUpdate then
    begin
      if not Dm_DeskTop.Fornecedor_Cadastro(FDMem_Registros.ToJSONArray,1) then
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

procedure TfrmFornecedor.SelecionaTipo(Sender: TObject; AEdit: TEdit;
  ALabel: TLabel);
begin
  AEdit.Tag := TRectangle(Sender).Tag;
  case AEdit.Tag of
    0:AEdit.TagString := 'J';
    1:AEdit.TagString := 'F';
  end;
  AEdit.Text := ALabel.Text;
  SelTipo;
end;

procedure TfrmFornecedor.Seleciona_Municipio(Aid: Integer; ANome,
  AIbge: String);
begin

end;

procedure TfrmFornecedor.Seleciona_Pais(Aid: Integer; ANome: String);
begin

end;

procedure TfrmFornecedor.Seleciona_Regiao(Aid: Integer; ANome: String);
begin

end;

procedure TfrmFornecedor.Seleciona_UF(AId: Integer; ASiglaUF, ANome: String);
begin

end;

procedure TfrmFornecedor.SelStatus;
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

procedure TfrmFornecedor.SelTipo;
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    rctTipo.Position.X := edTipo.Position.X;
    rctTipo.Position.Y := (lytRow_001.Position.Y + lytRow_001.Height);
    rctTipo.Width := edTipo.Width;
    rctTipo.Height := 60;
    if not rctTipo.Visible then
    begin
      FloatAnimation_SelTipo.StartValue := 0;
      FloatAnimation_SelTipo.StopValue := 60;
      imgTipo.Bitmap := imgRetrair.Bitmap;
    end
    else
    begin
      FloatAnimation_SelTipo.StartValue := 60;
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

procedure TfrmFornecedor.ThreadEnd_BuscaCep(Sender: TObject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_DeletarEndereco(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_DeletarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmFornecedor.ThreadEnd_DeletarTelefone(Sender: TObject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_Edit(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'','Erro editar um registro: ' + Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Configura_Botoes(4);
    Exibe_Labels;
  end;
end;

procedure TfrmFornecedor.ThreadEnd_EditaEmail(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_EditaEndereco(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_EditaTelefone(Sender: TObject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_ExcluirEmail(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_Lista(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga dos Fornecedores: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmFornecedor.ThreadEnd_ListaEmail(Sender: TObject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_ListaEnd(Sender: TObject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_ListaTel(Sender: TObject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_SalvarEmail(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_SalvarEndereco(Sender: TObject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_SalvarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmFornecedor.ThreadEnd_SalvarTelefone(Sender: TOBject);
begin

end;

procedure TfrmFornecedor.ThreadEnd_Status(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmFornecedor.ThreadEnd_Tipo(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

end.
