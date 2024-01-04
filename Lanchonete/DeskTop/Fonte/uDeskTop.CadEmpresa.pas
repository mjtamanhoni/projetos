unit uDeskTop.CadEmpresa;

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

  TfrmEmpresa = class(TForm)
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
    rctStatus: TRectangle;
    rctStatus_Ativo: TRectangle;
    lbStatus_Ativo: TLabel;
    rctStatus_Inativo: TRectangle;
    lbStatus_Inativo: TLabel;
    FloatAnimation_SelStatus: TFloatAnimation;
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
    rctTipo: TRectangle;
    rctTipo_Juridico: TRectangle;
    lbTipo_Juridico: TLabel;
    rctTipo_Fisico: TRectangle;
    lbTipo_Fisico: TLabel;
    FloatAnimation_SelTipo: TFloatAnimation;
    edInsMunicipal: TEdit;
    lbInscMunicipal: TLabel;
    FloatAnimation_InscMunicipal: TFloatAnimation;
    FDMem_Registros: TFDMemTable;
    FDMem_RegistrosID: TIntegerField;
    FDMem_RegistrosID_USUARIO: TIntegerField;
    FDMem_RegistrosDT_CADASTRO: TDateField;
    FDMem_RegistrosHR_CADASTRO: TTimeField;
    FDMem_RegistrosRAZAO_SOCIAL: TStringField;
    FDMem_RegistrosNOME_FANTASIA: TStringField;
    FDMem_RegistrosSTATUS: TIntegerField;
    FDMem_RegistrosTIPO_PESSOA: TStringField;
    FDMem_RegistrosDOCUMENTO: TStringField;
    FDMem_RegistrosINSCRICAO_ESTADUAL: TStringField;
    FDMem_RegistrosINSCRICAO_MUNICIPAL: TStringField;
    lytRow_000: TLayout;
    lbId_Titulo: TLabel;
    lbId: TLabel;
    tcAdicionais: TTabControl;
    tiEndereco: TTabItem;
    tiTelefone: TTabItem;
    tiEmail: TTabItem;
    lytEndereco: TLayout;
    lytEmail: TLayout;
    lytTelefone: TLayout;
    rctAdicionais: TRectangle;
    lytNavegarPages: TLayout;
    lytNavegarPages_Buttons: TLayout;
    imgEndereco: TImage;
    imgTelefone: TImage;
    imgEmail: TImage;
    rctEndereco: TRectangle;
    rctEmail: TRectangle;
    rctTelefone: TRectangle;
    lvEnderecos: TListView;
    lvTelefone: TListView;
    lvEmail: TListView;
    rctTampa_Endereco: TRectangle;
    lytCadEndereco: TLayout;
    rctCadEndereco: TRectangle;
    ShadowEffect1: TShadowEffect;
    lytCadEndereco_Footer: TLayout;
    lytCadEndereco_Detail: TLayout;
    lytCadEndereco_Buttons: TLayout;
    rctCadEndereco_Confirmar: TRectangle;
    lbCadEndereco_Confirmar: TLabel;
    rctCadEndereco_Cancelar: TRectangle;
    lbCadEndereco_Cancelar: TLabel;
    lytCadEnd_Row001: TLayout;
    edCadEnd_Cep: TEdit;
    lbCadEnd_Cep: TLabel;
    faCadEnd_Cep: TFloatAnimation;
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
    edCadEnd_UF: TEdit;
    lbCadEnd_UF: TLabel;
    faCadEnd_UF: TFloatAnimation;
    lytCadEnd_Row004: TLayout;
    edCadEnd_Regiao: TEdit;
    lbCadEnd_Regiao: TLabel;
    faCadEnd_Regiao: TFloatAnimation;
    edCadEnd_Pais: TEdit;
    lbCadEnd_Pais: TLabel;
    faCadEnd_Pais: TFloatAnimation;
    imgCadEnd_Cep: TImage;
    imgCadEnd_Municipio: TImage;
    imgCadEnd_UF: TImage;
    imgCadEnd_Regiao: TImage;
    imgCadEnd_Pais: TImage;
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
    imgEdit_Lista: TImage;
    imgDelete_Lista: TImage;
    ShadowEffect3: TShadowEffect;
    lytAdicionais: TLayout;
    lytAdicionais_Nav: TLayout;
    lytExclui_Adicionais: TLayout;
    lytEdita_Adicionais: TLayout;
    lytNovo_Adicionais: TLayout;
    rctNovo_Adicionais: TRectangle;
    rctExclui_Adicionais: TRectangle;
    rctEdita_Adicionais: TRectangle;
    Circle_Edita_Adicionais: TCircle;
    CircleExclui_Adicionais: TCircle;
    CircleNovo_Adicionais: TCircle;
    imgNovo_Adicionais: TImage;
    imgExclui_Adicionais: TImage;
    imgEdita_Adicionais: TImage;
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
    edCadTel_Numero: TEdit;
    lbCadTel_Numero: TLabel;
    faCadTel_Numero: TFloatAnimation;
    imgCadTel_Tipo: TImage;
    rctCadTel_ListaTipo: TRectangle;
    rctCadTel_Tipo_Comercial: TRectangle;
    lbCadTel_Tipo_Comercial: TLabel;
    rctCadTel_Tipo_Celular: TRectangle;
    lbCadTel_Tipo_Celular: TLabel;
    faCadTel_ListaTipo: TFloatAnimation;
    rctCadTel_Tipo_Residencial: TRectangle;
    lbCadTel_Tipo_Residencial: TLabel;
    FDMem_Telefone: TFDMemTable;
    FDMem_TelefoneID_EMPRESA: TIntegerField;
    FDMem_TelefoneID: TIntegerField;
    FDMem_TelefoneTIPO: TIntegerField;
    FDMem_TelefoneNUMERO: TStringField;
    FDMem_TelefoneID_USUARIO: TIntegerField;
    FDMem_TelefoneDT_CADASTRO: TDateField;
    FDMem_TelefoneHR_CADASTRO: TTimeField;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPesquisarTyping(Sender: TObject);
    procedure lvListaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvListaPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctFecharClick(Sender: TObject);
    procedure rctConfirmarClick(Sender: TObject);
    procedure rctEditarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edRazaoSocialKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edStatusKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edTipoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edNomeFantasiaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edDocumentoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edInscEstadualKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edRazaoSocialTyping(Sender: TObject);
    procedure edStatusTyping(Sender: TObject);
    procedure edTipoTyping(Sender: TObject);
    procedure edNomeFantasiaTyping(Sender: TObject);
    procedure edStatusClick(Sender: TObject);
    procedure edStatusChange(Sender: TObject);
    procedure edTipoChange(Sender: TObject);
    procedure edTipoClick(Sender: TObject);
    procedure rctStatus_AtivoClick(Sender: TObject);
    procedure rctStatus_InativoClick(Sender: TObject);
    procedure rctTipo_JuridicoClick(Sender: TObject);
    procedure rctTipo_FisicoClick(Sender: TObject);
    procedure edDocumentoTyping(Sender: TObject);
    procedure edInscEstadualTyping(Sender: TObject);
    procedure edInsMunicipalTyping(Sender: TObject);
    procedure imgEnderecoClick(Sender: TObject);
    procedure rctCadEndereco_ConfirmarClick(Sender: TObject);
    procedure rctCadEndereco_CancelarClick(Sender: TObject);
    procedure edCadEnd_CepKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_LogradouroKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_NrKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_ComplementoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_BairroKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_MunicipioKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_UFKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_RegiaoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadEnd_CepTyping(Sender: TObject);
    procedure edCadEnd_LogradouroTyping(Sender: TObject);
    procedure edCadEnd_NrTyping(Sender: TObject);
    procedure edCadEnd_ComplementoTyping(Sender: TObject);
    procedure edCadEnd_BairroTyping(Sender: TObject);
    procedure edCadEnd_MunicipioTyping(Sender: TObject);
    procedure edCadEnd_UFTyping(Sender: TObject);
    procedure edCadEnd_RegiaoTyping(Sender: TObject);
    procedure edCadEnd_PaisTyping(Sender: TObject);
    procedure edCadEnd_MunicipioClick(Sender: TObject);
    procedure edCadEnd_UFClick(Sender: TObject);
    procedure edCadEnd_RegiaoClick(Sender: TObject);
    procedure edCadEnd_PaisClick(Sender: TObject);
    procedure imgCadEnd_CepClick(Sender: TObject);
    procedure lvEnderecosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure rctNovo_AdicionaisClick(Sender: TObject);
    procedure rctExclui_AdicionaisClick(Sender: TObject);
    procedure rctEdita_AdicionaisClick(Sender: TObject);
    procedure edCadTel_NumeroTyping(Sender: TObject);
    procedure edCadTel_TipoChange(Sender: TObject);
    procedure edCadTel_TipoClick(Sender: TObject);
    procedure edCadTel_TipoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edCadTel_TipoTyping(Sender: TObject);
    procedure rctCadTel_Tipo_CelularClick(Sender: TObject);
    procedure rctCadTel_CancelarClick(Sender: TObject);
    procedure rctCadTel_ConfirmarClick(Sender: TObject);
    procedure lvTelefoneItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure edEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edEmail_ResponsavelKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edEmailTyping(Sender: TObject);
    procedure edEmail_ResponsavelTyping(Sender: TObject);
    procedure edEmail_SetorTyping(Sender: TObject);
    procedure edEmail_SetorClick(Sender: TObject);
    procedure rctCadEmail_ConfirmarClick(Sender: TObject);
    procedure rctCadEmail_CancelarClick(Sender: TObject);
    procedure lvEnderecosPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lvTelefonePaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure lvEmailPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
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
    FCod_Empresa :Integer;

    {$Region 'Complementos'}
      FEndereco_Id :Integer;
      FTelefone_ID :Integer;
      FEmail_ID :Integer;
      FStatusTable: TStatusTable;
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
      procedure Cancelar_Alteracoes(Sender :TOBject);
      procedure Novo_Registro(Sender: TOBject);
      procedure Deletar_Registro(Sender: TOBject);
      procedure EditarRegistro(Sender: TOBject);
      procedure EditandoRegistro(const AId: Integer);
      procedure ThreadEnd_Edit(Sender: TOBject);
      procedure ThreadEnd_SalvarRegistro(Sender: TOBject);
      procedure ThreadEnd_DeletarRegistro(Sender: TOBject);
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

    procedure Seleciona_Setor(AId: Integer; ANome: String);


  public
    ExecuteOnClose :TExecuteOnClose;
    RetornaRegistro :Boolean;
  end;

var
  frmEmpresa: TfrmEmpresa;

implementation

{$R *.fmx}

uses
  uDeskTop.CadMunicipios,
  uDeskTop.CadPaises,
  uDeskTop.CadRegioes,
  uDeskTop.CadUF,
  uDeskTop.CadSetor;

procedure TfrmEmpresa.Abortar_Fechamento(Sender: TOBject);
begin
  Abort;
end;

procedure TfrmEmpresa.AddItens_LV(
        const ACodigo:Integer;
        const ANome:String);
begin
  with lvLista.Items.Add do
  begin
    Tag := ACodigo;
    TagString := ANome;
    TListItemText(Objects.FindDrawable('edNome')).TagString := ACodigo.ToString;
    TListItemText(Objects.FindDrawable('edNome')).Text := ANome;
  end;
end;

procedure TfrmEmpresa.Cancelar_Alteracoes(Sender: TOBject);
begin
  Configura_Botoes(2);
end;

procedure TfrmEmpresa.Configura_Botoes(ABotao: Integer);
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

procedure TfrmEmpresa.Confirmar_Fechamento(Sender: TObject);
begin
  if RetornaRegistro then
    ExecuteOnClose(FId_Selecionado,FNome_Selecionado);

  FFechar_Sistema := True;
  Close;
end;

procedure TfrmEmpresa.Deletar_Registro(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.Empresa_Excluir(FId_Selecionado);
    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(3);
    end);
  end);

  t.OnTerminate := ThreadEnd_DeletarRegistro;
  t.Start;
end;

procedure TfrmEmpresa.edCadEnd_BairroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_Municipio);
end;

procedure TfrmEmpresa.edCadEnd_BairroTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Bairro,lbCadEnd_Bairro,faCadEnd_Bairro,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_CepKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_Logradouro);
end;

procedure TfrmEmpresa.edCadEnd_CepTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Cep,lbCadEnd_Cep,faCadEnd_Cep,10,-20);
  Formatar(edCadEnd_Cep,TFormato.CEP);
end;

procedure TfrmEmpresa.edCadEnd_ComplementoKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_Bairro);
end;

procedure TfrmEmpresa.edCadEnd_ComplementoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Complemento,lbCadEnd_Complemento,faCadEnd_Complemento,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_LogradouroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_Nr);
end;

procedure TfrmEmpresa.edCadEnd_LogradouroTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Logradouro,lbCadEnd_Logradouro,faCadEnd_Logradouro,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_MunicipioClick(Sender: TObject);
begin
  if not Assigned(frmMunicipios) then
    Application.CreateForm(TfrmMunicipios,frmMunicipios);
  frmMunicipios.RetornaRegistro := True;
  frmMunicipios.ExecuteOnClose := Seleciona_Municipio;
  frmMunicipios.Show;
end;

procedure TfrmEmpresa.Seleciona_Municipio(Aid:Integer; ANome:String; AIbge:String);
begin
  edCadEnd_Municipio.TagString := AIbge;
  edCadEnd_Municipio.Tag := Aid;
  edCadEnd_Municipio.Text := ANome;

  if Trim(edCadEnd_Municipio.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Municipio,lbCadEnd_Municipio,faCadEnd_Municipio,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_MunicipioKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_UF);
end;

procedure TfrmEmpresa.edCadEnd_MunicipioTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Municipio,lbCadEnd_Municipio,faCadEnd_Municipio,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_NrKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_Complemento);
end;

procedure TfrmEmpresa.edCadEnd_NrTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Nr,lbCadEdn_Nr,faCadEnd_Nr,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_PaisClick(Sender: TObject);
begin
  if not Assigned(frmCadPaises) then
    Application.CreateForm(TfrmCadPaises,frmCadPaises);
  frmCadPaises.RetornaRegistro := True;
  frmCadPaises.ExecuteOnClose := Seleciona_Pais;
  frmCadPaises.Show;
end;

procedure TfrmEmpresa.Seleciona_Pais(Aid:Integer; ANome:String);
begin
  edCadEnd_Pais.Tag := Aid;
  edCadEnd_Pais.Text := ANome;

  if Trim(edCadEnd_Pais.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Pais,lbCadEnd_Pais,faCadEnd_Pais,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_PaisTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Pais,lbCadEnd_Pais,faCadEnd_Pais,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_RegiaoClick(Sender: TObject);
begin
  if not Assigned(frmCad_Regioes) then
    Application.CreateForm(TfrmCad_Regioes,frmCad_Regioes);
  frmCad_Regioes.RetornaRegistro := True;
  frmCad_Regioes.ExecuteOnClose := Seleciona_Regiao;
  frmCad_Regioes.Show;
end;

procedure TfrmEmpresa.Seleciona_Regiao(Aid:Integer; ANome:String);
begin
  edCadEnd_Regiao.Tag := Aid;
  edCadEnd_Regiao.Text := ANome;

  if Trim(edCadEnd_Regiao.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Regiao,lbCadEnd_Regiao,faCadEnd_Regiao,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_RegiaoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_Pais);
end;

procedure TfrmEmpresa.edCadEnd_RegiaoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_Regiao,lbCadEnd_Regiao,faCadEnd_Regiao,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_UFClick(Sender: TObject);
begin
  if not Assigned(frmUnidadeFederativa) then
    Application.CreateForm(TfrmUnidadeFederativa,frmUnidadeFederativa);
  frmUnidadeFederativa.RetornaRegistro := True;
  frmUnidadeFederativa.ExecuteOnClose := Seleciona_UF;
  frmUnidadeFederativa.Show;
end;

procedure TfrmEmpresa.Seleciona_UF(AId:Integer; ASiglaUF:String; ANome:String);
begin
  edCadEnd_UF.Tag := AId;
  edCadEnd_UF.TagString := ASiglaUF;
  edCadEnd_UF.Text := ANome;

  if Trim(edCadEnd_UF.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_UF,lbCadEnd_UF,faCadEnd_UF,10,-20);
end;

procedure TfrmEmpresa.edCadEnd_UFKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadEnd_Regiao);
end;

procedure TfrmEmpresa.edCadEnd_UFTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadEnd_UF,lbCadEnd_UF,faCadEnd_UF,10,-20);
end;

procedure TfrmEmpresa.edCadTel_NumeroTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadTel_Numero,lbCadTel_Numero,faCadTel_Numero,10,-20);
  case edCadTel_Tipo.Tag of
    0:Formatar(edCadTel_Numero,TFormato.TelefoneFixo);
    1:Formatar(edCadTel_Numero,TFormato.Celular);
    2:Formatar(edCadTel_Numero,TFormato.TelefoneFixo);
  end;
end;

procedure TfrmEmpresa.edCadTel_TipoChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadTel_Tipo,lbCadTel_Tipo,faCadTel_Tipo,10,-20);
end;

procedure TfrmEmpresa.edCadTel_TipoClick(Sender: TObject);
begin
  TFuncoes.Seliciona_Combo_Desktop(
    rctCadTel_ListaTipo
    ,faCadTel_ListaTipo
    ,imgCadTel_Tipo
    ,imgRetrair
    ,imgExpandir
    ,edCadTel_Tipo
    ,lytCadTelefone_Row001
    ,90);
end;

procedure TfrmEmpresa.edCadTel_TipoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCadTel_Numero);
end;

procedure TfrmEmpresa.edCadTel_TipoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCadTel_Tipo,lbCadTel_Tipo,faCadTel_Tipo,10,-20);
end;

procedure TfrmEmpresa.edDocumentoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edInscEstadual);
end;

procedure TfrmEmpresa.edDocumentoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edDocumento,lbDocumento,FloatAnimation_Documento,10,-20);
  if edTipo.TagString = 'F' then
    Formatar(edDocumento, TFormato.CPF)
  else
    Formatar(edDocumento, TFormato.CNPJ);
end;

procedure TfrmEmpresa.edEmailKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edEmail_Responsavel);
end;

procedure TfrmEmpresa.edEmailTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail,lbEmail,faEmail,10,-20);
end;

procedure TfrmEmpresa.edEmail_ResponsavelKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edEmail_Setor);
end;

procedure TfrmEmpresa.edEmail_ResponsavelTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail_Responsavel,lbEmail_Responsavel,faEmail_Responsavel,10,-20);
end;

procedure TfrmEmpresa.edEmail_SetorClick(Sender: TObject);
begin
  if not Assigned(frmCadSetor) then
    Application.CreateForm(TfrmCadSetor,frmCadSetor);
  frmCadSetor.RetornaRegistro := True;
  frmCadSetor.ExecuteOnClose := Seleciona_Setor;
  frmCadSetor.Show;
end;

procedure TfrmEmpresa.Seleciona_Setor(AId:Integer; ANome:String);
begin
  edEmail_Setor.Tag := AId;
  edEmail_Setor.Text := ANome;
end;

procedure TfrmEmpresa.edEmail_SetorTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail_Setor,lbEmail_Setor,faEmail_Setor,10,-20);
end;

procedure TfrmEmpresa.edInscEstadualKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edInsMunicipal);
end;

procedure TfrmEmpresa.edInscEstadualTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edInscEstadual,lbInscEstadual,FloatAnimation_InscEstadual,10,-20);
  Formatar(edInscEstadual, TFormato.InscricaoEstadual,'ES');
end;

procedure TfrmEmpresa.edInsMunicipalTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edInsMunicipal,lbInscMunicipal,FloatAnimation_InscMunicipal,10,-20);
end;

procedure TfrmEmpresa.EditandoRegistro(const AId: Integer);
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
      jsonArray := Dm_DeskTop.Empresa_Lista(
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
        lbId.Tag := edRazaoSocial.Tag;
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

procedure TfrmEmpresa.ThreadEnd_Edit(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'','Erro editar um registro: ' + Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Configura_Botoes(4);
    Listar_Endereco(0,lbId.Tag,True);
    ListarTelefone(0,lbId.Tag,True);
    ListarEmail(0,lbId.Tag,True);
    Exibe_Labels;
    FProcessandoEnd := '';
  end;
end;

procedure TfrmEmpresa.EditarRegistro(Sender: TOBject);
begin
  EditandoRegistro(FId_Selecionado);
end;

procedure TfrmEmpresa.edNomeFantasiaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edDocumento);
end;

procedure TfrmEmpresa.edNomeFantasiaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNomeFantasia,lbNomeFantasia,FloatAnimation_NomeFantasia,10,-20);
end;

procedure TfrmEmpresa.edPesquisarKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmEmpresa.edPesquisarTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPesquisar,lbPesquisar,FloatAnimation_Pesq,10,-20);
end;

procedure TfrmEmpresa.edRazaoSocialKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edStatus);
end;

procedure TfrmEmpresa.edRazaoSocialTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edRazaoSocial,lbRazaoSocial,FloatAnimation_RazaoSocial,10,-20);
end;

procedure TfrmEmpresa.edStatusChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmEmpresa.edStatusClick(Sender: TObject);
begin
  SelStatus;
end;

procedure TfrmEmpresa.edStatusKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edTipo);
end;

procedure TfrmEmpresa.edStatusTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmEmpresa.edTipoChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
end;

procedure TfrmEmpresa.edTipoClick(Sender: TObject);
begin
  SelTipo;
end;

procedure TfrmEmpresa.edTipoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edNomeFantasia);
end;

procedure TfrmEmpresa.edTipoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
end;

procedure TfrmEmpresa.Exibe_Labels;
begin
  TFuncoes.ExibeLabel(edRazaoSocial,lbRazaoSocial,FloatAnimation_RazaoSocial,10,-20);
  TFuncoes.ExibeLabel(edNomeFantasia,lbNomeFantasia,FloatAnimation_NomeFantasia,10,-20);
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
  TFuncoes.ExibeLabel(edDocumento,lbDocumento,FloatAnimation_Documento,10,-20);
  TFuncoes.ExibeLabel(edInscEstadual,lbInscEstadual,FloatAnimation_InscEstadual,10,-20);
  TFuncoes.ExibeLabel(edInsMunicipal,lbInscMunicipal,FloatAnimation_InscMunicipal,10,-20);
end;

procedure TfrmEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmEmpresa := Nil;
  FId_Selecionado := 0;
  FNome_Selecionado := '';

  tcPrincipal.ActiveTab := tiFiltro;

end;

procedure TfrmEmpresa.FormCreate(Sender: TObject);
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
  //FCod_Empresa := 0;
  //FCod_Empresa := FIniFile.ReadInteger('','',0);

  FMensagem := TFancyDialog.Create(frmEmpresa);

  FStatusTable := TStatusTable.stList;

  FId_Selecionado := 0;
  FNome_Selecionado := '';

  tcPrincipal.ActiveTab := tiFiltro;
  tcAdicionais.ActiveTab := tiEndereco;

end;

procedure TfrmEmpresa.imgCadEnd_CepClick(Sender: TObject);
var
  t :TThread;
  lCep :String;

begin

  if Trim(edCadEnd_Cep.Text) = '' then
    raise Exception.Create('Obrigatório informar o CEP');

  TLoading.Show(frmEmpresa,'Buscanco Cep');

  lCep := TFuncoes.SomenteNumero(edCadEnd_Cep.Text);

  t := TThread.CreateAnonymousThread(
  procedure
  var
    jsonObject: TJSONObject;
  begin
      jsonObject := Dm_DeskTop.BuscaCep_Cep(lCep);

      TThread.Synchronize(nil,
      procedure
      begin
        edCadEnd_Logradouro.Text := jsonObject.GetValue<String>('logradouro');
        edCadEnd_Complemento.Text := jsonObject.GetValue<String>('complemento');
        edCadEnd_Bairro.Text := jsonObject.GetValue<String>('bairro');
        edCadEnd_Municipio.Text := jsonObject.GetValue<String>('localidade');
        edCadEnd_Municipio.TagString := jsonObject.GetValue<String>('ibge');
        edCadEnd_UF.TagString := jsonObject.GetValue<String>('uf');
        edCadEnd_UF.Text := TFuncoes.Unidade_Federativa(edCadEnd_UF.TagString);
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        if Trim(edCadEnd_Logradouro.Text) <> '' then
          TFuncoes.ExibeLabel(edCadEnd_Logradouro,lbCadEnd_Logradouro,faCadEnd_Logradouro,10,-20);
        if Trim(edCadEnd_Complemento.Text) <> '' then
          TFuncoes.ExibeLabel(edCadEnd_Complemento,lbCadEnd_Complemento,faCadEnd_Complemento,10,-20);
        if Trim(edCadEnd_Bairro.Text) <> '' then
          TFuncoes.ExibeLabel(edCadEnd_Bairro,lbCadEnd_Bairro,faCadEnd_Bairro,10,-20);
        if Trim(edCadEnd_Municipio.Text) <> '' then
          TFuncoes.ExibeLabel(edCadEnd_Municipio,lbCadEnd_Municipio,faCadEnd_Municipio,10,-20);
        if Trim(edCadEnd_UF.Text) <> '' then
          TFuncoes.ExibeLabel(edCadEnd_UF,lbCadEnd_UF,faCadEnd_UF,10,-20);
      end);

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonObject);
      {$ELSE}
        jsonObject.DisposeOf;
      {$ENDIF}
  end);

  t.OnTerminate := ThreadEnd_BuscaCep;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_BuscaCep(Sender :TObject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'','Erro ao buscar o Cep: ' + Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmEmpresa.imgEnderecoClick(Sender: TObject);
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

procedure TfrmEmpresa.Incia_Campos;
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

procedure TfrmEmpresa.ListarEmail(const APagina, AEmpresa: Integer;
  const AInd_Clear: Boolean; const AId_Telefone: Integer);
var
  t :TThread;
begin
  if FProcessandoEmail = 'processando' then
      exit;
  FProcessandoEmail := 'processando';

  if AInd_Clear then
  begin
    lvEmail.ScrollTo(0);
    lvEmail.Tag := 0;
    lvEmail.Items.Clear;
  end;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
  begin

    lvEmail.BeginUpdate;

    if lvEmail.Tag >= 0 then
      lvEmail.Tag := (lvEmail.Tag + 1);

      jsonArray := Dm_DeskTop.EmpresaEmail_Lista(
        lvEmail.Tag
        ,AEmpresa);

      for x := 0 to jsonArray.Size -1 do
      begin
        TThread.Synchronize(nil,
        procedure
        begin
          AddEmailItens_LV(
            jsonArray.Get(x).GetValue<Integer>('idEmpresa')
            ,jsonArray.Get(x).GetValue<Integer>('id')
            ,jsonArray.Get(x).GetValue<String>('email')
            ,jsonArray.Get(x).GetValue<String>('responsavel')
            ,jsonArray.Get(x).GetValue<Integer>('idSetor')
            ,jsonArray.Get(x).GetValue<String>('setor')
          );
        end);
      end;

      if jsonArray.Size = 0 then
        lvEmail.Tag := -1;

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}

      TThread.Synchronize(nil,
      procedure
      begin
        lvEmail.EndUpdate;
      end);

      //lvEmail.TagString := '';
      FProcessandoEmail := '';

      //Força a chamada do evento onUpdateObjects da listview...
      lvEmail.Margins.Bottom := 6;
      lvEmail.Margins.Bottom := 5;
      //---------------------------------------------
  end);

  t.OnTerminate := ThreadEnd_ListaEmail;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_ListaEmail(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga dos E-mails: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmEmpresa.ListarTelefone(
  const APagina:Integer;
  const AEmpresa:Integer;
  const AInd_Clear:Boolean;
  const AId_Telefone:Integer=0);
var
  t :TThread;
begin
  if FProcessandoTel = 'processando' then
      exit;
  FProcessandoTel := 'processando';

  if AInd_Clear then
  begin
    lvTelefone.ScrollTo(0);
    lvTelefone.Tag := 0;
    lvTelefone.Items.Clear;
  end;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
  begin

    lvTelefone.BeginUpdate;

    if lvTelefone.Tag >= 0 then
      lvTelefone.Tag := (lvTelefone.Tag + 1);

      jsonArray := Dm_DeskTop.EmpresaTel_Lista(
        lvTelefone.Tag
        ,AEmpresa);

      for x := 0 to jsonArray.Size -1 do
      begin
        TThread.Synchronize(nil,
        procedure
        begin
          AddTelItens_LV(
            jsonArray.Get(x).GetValue<Integer>('idEmpresa')
            ,jsonArray.Get(x).GetValue<Integer>('id')
            ,jsonArray.Get(x).GetValue<Integer>('tipo')
            ,jsonArray.Get(x).GetValue<String>('tipoDesc')
            ,jsonArray.Get(x).GetValue<String>('numero')
          );
        end);
      end;

      if jsonArray.Size = 0 then
        lvTelefone.Tag := -1;

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}

      TThread.Synchronize(nil,
      procedure
      begin
        lvTelefone.EndUpdate;
      end);

      //lvTelefone.TagString := '';
      FProcessandoTel := '';

      //Força a chamada do evento onUpdateObjects da listview...
      lvTelefone.Margins.Bottom := 6;
      lvTelefone.Margins.Bottom := 5;
      //---------------------------------------------
  end);

  t.OnTerminate := ThreadEnd_ListaEnd;
  t.Start;
end;

procedure TfrmEmpresa.AddTelItens_LV(
        const AIdEmpresa :Integer;
        const AId :Integer;
        const ATipo: Integer;
        const ATipoDesc: String;
        const ATelefone :String);
begin
  with lvTelefone.Items.Add do
  begin
    Tag := AId;
    TListItemText(Objects.FindDrawable('edTipo')).Text := ATipoDesc;
    TListItemText(Objects.FindDrawable('edTipo')).TagString := ATipo.ToString;
    TListItemText(Objects.FindDrawable('edTelefone')).Text := ATelefone;
  end;
end;

procedure TfrmEmpresa.ThreadEnd_ListaTel(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga dos Telefones: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmEmpresa.Listar_Dados(const APagina: Integer; const ABusca: String;
  const AInd_Clear: Boolean);
var
  t :TThread;
  lNome :String;
  lCodigo :Integer;

begin

  //TLoading.Show(frmEmpresa,'Listando dados');

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

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
  begin

    lvLista.BeginUpdate;

    if lvLista.Tag >= 0 then
      lvLista.Tag := (lvLista.Tag + 1);

      jsonArray := Dm_DeskTop.Empresa_Lista(
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

      TThread.Synchronize(nil,
      procedure
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

procedure TfrmEmpresa.Listar_Endereco(
  const APagina:Integer;
  const AEmpresa: Integer;
  const AInd_Clear: Boolean;
  const AId_Endereco:Integer=0);
var
  t :TThread;
begin
  if FProcessandoEnd = 'processando' then
      exit;
  FProcessandoEnd := 'processando';

  if AInd_Clear then
  begin
    lvEnderecos.ScrollTo(0);
    lvEnderecos.Tag := 0;
    lvEnderecos.Items.Clear;
  end;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
  begin

    lvEnderecos.BeginUpdate;

    if lvEnderecos.Tag >= 0 then
      lvEnderecos.Tag := (lvEnderecos.Tag + 1);

      jsonArray := Dm_DeskTop.EmpresaEnd_Lista(
        lvEnderecos.Tag
        ,AEmpresa);

      for x := 0 to jsonArray.Size -1 do
      begin
        TThread.Synchronize(nil,
        procedure
        begin
          AddEndItens_LV(
            jsonArray.Get(x).GetValue<Integer>('idEmpresa')
            ,jsonArray.Get(x).GetValue<Integer>('id')
            ,jsonArray.Get(x).GetValue<String>('pais')
            ,jsonArray.Get(x).GetValue<String>('regiao')
            ,jsonArray.Get(x).GetValue<String>('ibge')
            ,jsonArray.Get(x).GetValue<String>('municipio')
            ,jsonArray.Get(x).GetValue<String>('numero')
            ,jsonArray.Get(x).GetValue<String>('siglaUf')
            ,jsonArray.Get(x).GetValue<String>('bairro')
            ,jsonArray.Get(x).GetValue<String>('cep')
            ,jsonArray.Get(x).GetValue<String>('logradouro')
            ,jsonArray.Get(x).GetValue<String>('complemento')
          );
        end);
      end;

      if jsonArray.Size = 0 then
        lvEnderecos.Tag := -1;

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}

      TThread.Synchronize(nil,
      procedure
      begin
        lvEnderecos.EndUpdate;
      end);

      //lvEnderecos.TagString := '';
      FProcessandoEnd := '';

      //Força a chamada do evento onUpdateObjects da listview...
      lvEnderecos.Margins.Bottom := 6;
      lvEnderecos.Margins.Bottom := 5;
      //---------------------------------------------
  end);

  t.OnTerminate := ThreadEnd_ListaEnd;
  t.Start;
end;

procedure TfrmEmpresa.AddEmailItens_LV(
  const AIdEmpresa :Integer;
  const AId :Integer;
  const AEmail: String;
  const AResponsavel: String;
  const ASetorID :Integer;
  const ASetor :String);
begin
  with lvEmail.Items.Add do
  begin
    Tag := AId;
    TListItemText(Objects.FindDrawable('edEmail')).Text := AEmail;
    TListItemText(Objects.FindDrawable('edResponsavel')).Text := AResponsavel;
    TListItemText(Objects.FindDrawable('edSetor')).Text := ASetor;
    TListItemText(Objects.FindDrawable('edSetor')).TagString := ASetorID.ToString;
  end;
end;

procedure TfrmEmpresa.AddEndItens_LV(
  const AIdEmpresa :Integer;
  const AId :Integer;
  const APais_Nome :String;
  const ARegiao_Nome :String;
  const AIbge :String;
  const AMunicipio :String;
  const ANr :String;
  const AUf_Sigla :String;
  const ABairro :String;
  const ACep :String;
  const ALogradouro :String;
  const AComplemento :String);
begin
  with lvEnderecos.Items.Add do
  begin
    Tag := AId;
    TListItemText(Objects.FindDrawable('edPais')).Text := APais_Nome;
    TListItemText(Objects.FindDrawable('edRegiao')).Text := ARegiao_Nome;
    TListItemText(Objects.FindDrawable('edIbge')).Text := AIbge;
    TListItemText(Objects.FindDrawable('edMunicipio')).Text := AMunicipio;
    TListItemText(Objects.FindDrawable('edNr')).Text := ANr;
    TListItemText(Objects.FindDrawable('edUf')).Text := AUf_Sigla;
    TListItemText(Objects.FindDrawable('edBairro')).Text := ABairro;
    TListItemText(Objects.FindDrawable('edCep')).Text := ACep;
    TListItemText(Objects.FindDrawable('edLogradouro')).Text := ALogradouro;
    TListItemText(Objects.FindDrawable('edComplemento')).Text := AComplemento;
    //TListItemImage(Objects.FindDrawable('imgDelete')).Bitmap := imgDelete_Lista.Bitmap;
    //TListItemImage(Objects.FindDrawable('imgEdit')).Bitmap := imgEdit_Lista.Bitmap;
  end;
end;

procedure TfrmEmpresa.ThreadEnd_ListaEnd(Sender :TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga dos Endereços: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmEmpresa.ThreadEnd_Lista(Sender: TOBject);
begin
  //TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga das Empresas: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmEmpresa.lvEmailPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvEmail.Items.Count >= 0) and (lvEmail.Tag >= 0) then
  begin
    if lvEmail.GetItemRect(lvEmail.Items.Count - 3).Bottom <= lvEmail.Height then
      ListarEmail(lvEmail.Tag,lbId.Tag,False)
  end;
end;

procedure TfrmEmpresa.lvEnderecosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FEndereco_Id := AItem.Tag;
end;

procedure TfrmEmpresa.lvEnderecosPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvEnderecos.Items.Count >= 0) and (lvEnderecos.Tag >= 0) then
  begin
    if lvEnderecos.GetItemRect(lvEnderecos.Items.Count - 3).Bottom <= lvEnderecos.Height then
      Listar_Endereco(lvEnderecos.Tag,lbId.Tag,False)
  end;
end;

procedure TfrmEmpresa.lvListaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FId_Selecionado := Aitem.Tag;
  FNome_Selecionado := AItem.TagString;
end;

procedure TfrmEmpresa.lvListaPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvLista.Items.Count >= 0) and (lvLista.Tag >= 0) then
  begin
    if lvLista.GetItemRect(lvLista.Items.Count - 3).Bottom <= lvLista.Height then
      Listar_Dados(lvLista.Tag,edPesquisar.Text,False)
  end;
end;

procedure TfrmEmpresa.lvTelefoneItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FTelefone_ID := AItem.Tag;
end;

procedure TfrmEmpresa.lvTelefonePaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvTelefone.Items.Count >= 0) and (lvTelefone.Tag >= 0) then
  begin
    if lvTelefone.GetItemRect(lvTelefone.Items.Count - 3).Bottom <= lvTelefone.Height then
      ListarTelefone(lvTelefone.Tag,lbId.Tag,False)
  end;
end;

procedure TfrmEmpresa.Novo_Registro(Sender: TOBject);
begin
  lvEnderecos.ScrollTo(0);
  lvEnderecos.Tag := 0;
  lvEnderecos.Items.Clear;
  Configura_Botoes(0);
end;

procedure TfrmEmpresa.Limpar_Endereco;
begin
  edCadEnd_Cep.Text := '';
  edCadEnd_Logradouro.Text := '';
  edCadEnd_Complemento.Text := '';
  edCadEnd_Bairro.Text := '';
  edCadEnd_Municipio.Text := '';
  edCadEnd_Municipio.TagString := '';
  edCadEnd_Municipio.Tag := 0;
  edCadEnd_UF.TagString := '';
  edCadEnd_UF.Text := '';
  edCadEnd_UF.Tag := 0;
  edCadEnd_Nr.Text := '';
  edCadEnd_Regiao.Tag := 0;
  edCadEnd_Regiao.Text := '';
  edCadEnd_Pais.Tag := 0;
  edCadEnd_Pais.Text := '';
end;

procedure TfrmEmpresa.Limpar_Telefone;
begin
  edCadTel_Tipo.Tag := -1;
  edCadTel_Tipo.Text := '';
  edCadTel_Numero.Text := '';
end;

procedure TfrmEmpresa.rctCadEmail_CancelarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'E-mail','Cancela alterações','SIM',CancelaEmail,'NÂO');
end;

procedure TfrmEmpresa.CancelaEmail(Sender :TOBject);
begin
  rctTampa_Email.Visible := False;
end;

procedure TfrmEmpresa.rctCadEmail_ConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'E-mail','Salva alterações','SIM',SalvarEmail,'NÃO');
end;

procedure TfrmEmpresa.SalvarEmail(Sender :TObject);
var
  t :TThread;
begin
  TLoading.Show(frmEmpresa,'Salvando E-mail');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    SalvarAlteracao_Email;
  end);

  t.OnTerminate := ThreadEnd_SalvarEmail;
  t.Start;
end;

procedure TfrmEmpresa.SalvarAlteracao_Email;
begin
  FDMem_Email.Active := False;
  FDMem_Email.Active := True;
  FDMem_Email.Insert;
  FDMem_EmailID_EMPRESA.AsInteger := lbId.Tag;
  FDMem_EmailID.AsInteger := rctCad_Telefone.Tag;
  FDMem_EmailRESPONSAVEL.AsString := edEmail_Responsavel.Text;
  FDMem_EmailID_SETOR.AsInteger := edEmail_Setor.Tag;
  FDMem_EmailDESC_SETOR.AsString := edEmail_Setor.Text;
  FDMem_EmailEMAIL.Text := edEmail.Text;
  FDMem_EmailID_USUARIO.AsInteger := Dm_DeskTop.FDMem_UsuariosID.AsInteger;
  FDMem_EmailDT_CADASTRO.AsDateTime := Date;
  FDMem_EmailHF_CADASTRO.AsDateTime := Time;
  FDMem_Email.Post;

  if FStatusTable_Email = stInsert then
  begin
    if not Dm_DeskTop.EmpresaEmail_Cadastro(FDMem_Email.ToJSONArray,0) then
      raise Exception.Create('Erro ao salvar as alterações');
  end
  else if FStatusTable_Email = stUpdate then
  begin
    if not Dm_DeskTop.EmpresaEmail_Cadastro(FDMem_Email.ToJSONArray,1) then
      raise Exception.Create('Erro ao salvar as alterações');
  end;

  FStatusTable_Email := TStatusTable.stList;
end;

procedure TfrmEmpresa.ThreadEnd_SalvarEmail(Sender :TOBject);
begin
  TLoading.Hide;
  rctTampa_Email.Visible := False;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessandoEmail := '';
    ListarEmail(0,lbId.Tag,True,0);
  end;
end;

procedure TfrmEmpresa.rctCadEndereco_CancelarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Endereço','Cancela alterações','SIM',CancelaEndereco,'NÂO');
end;

procedure TfrmEmpresa.CancelaEndereco(Sender: TObject);
begin
  rctTampa_Endereco.Visible := False;
end;

procedure TfrmEmpresa.rctCadEndereco_ConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Endereço','Salva alterações','SIM',SalvarEndereco,'NÃO');
end;

procedure TfrmEmpresa.rctCadTel_CancelarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Telefone','Cancela alterações','SIM',CancelaTelefone,'NÂO');
end;

procedure TfrmEmpresa.rctCadTel_ConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Telefone','Salva alterações','SIM',SalvarTelefone,'NÃO');
end;

procedure TfrmEmpresa.SalvarTelefone(Sender :TOBject);
var
  t :TThread;
begin
  TLoading.Show(frmEmpresa,'Salvando telefone');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    SalvarAlteracao_Telefone;
  end);

  t.OnTerminate := ThreadEnd_SalvarTelefone;
  t.Start;
end;

procedure TfrmEmpresa.SalvarAlteracao_Telefone;
begin
  FDMem_Telefone.Active := False;
  FDMem_Telefone.Active := True;
  FDMem_Telefone.Insert;
  FDMem_TelefoneID_EMPRESA.AsInteger := lbId.Tag;
  FDMem_TelefoneID.AsInteger := rctCad_Telefone.Tag;
  FDMem_TelefoneTIPO.AsInteger := edCadTel_Tipo.Tag;
  FDMem_TelefoneNUMERO.AsString := edCadTel_Numero.Text;
  FDMem_TelefoneID_USUARIO.AsInteger := Dm_DeskTop.FDMem_UsuariosID.AsInteger;
  FDMem_TelefoneDT_CADASTRO.AsDateTime := Date;
  FDMem_TelefoneHR_CADASTRO.AsDateTime := Time;
  FDMem_Telefone.Post;

  if FStatusTable_Tel = stInsert then
  begin
    if not Dm_DeskTop.EmpresaTel_Cadastro(FDMem_Telefone.ToJSONArray,0) then
      raise Exception.Create('Erro ao salvar as alterações');
  end
  else if FStatusTable_Tel = stUpdate then
  begin
    if not Dm_DeskTop.EmpresaTel_Cadastro(FDMem_Telefone.ToJSONArray,1) then
      raise Exception.Create('Erro ao salvar as alterações');
  end;

  FStatusTable_Tel := TStatusTable.stList;

end;

procedure TfrmEmpresa.ThreadEnd_SalvarTelefone(Sender :TOBject);
begin
  TLoading.Hide;
  rctTampa_Telefone.Visible := False;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessandoTel := '';
    ListarTelefone(0,lbId.Tag,True,0);
  end;
end;

procedure TfrmEmpresa.CancelaTelefone(Sender :TOBject);
begin
  rctTampa_Telefone.Visible := False;
end;

procedure TfrmEmpresa.rctCadTel_Tipo_CelularClick(Sender: TObject);
begin
  edCadTel_Tipo.Tag := TRectangle(Sender).Tag;
  case TRectangle(Sender).Tag of
    0:edCadTel_Tipo.Text := lbCadTel_Tipo_Comercial.Text;
    1:edCadTel_Tipo.Text := lbCadTel_Tipo_Celular.Text;
    2:edCadTel_Tipo.Text := lbCadTel_Tipo_Residencial.Text;
  end;
  TFuncoes.Seliciona_Combo_Desktop(
    rctCadTel_ListaTipo
    ,faCadTel_ListaTipo
    ,imgCadTel_Tipo
    ,imgRetrair
    ,imgExpandir
    ,edCadTel_Tipo
    ,lytCadTelefone_Row001
    ,90);
end;

procedure TfrmEmpresa.SalvarEndereco(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmEmpresa,'Salvando endereço');

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

procedure TfrmEmpresa.ThreadEnd_SalvarEndereco(Sender: TObject);
begin
  TLoading.Hide;
  rctTampa_Endereco.Visible := False;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessandoEnd := '';
    Listar_Endereco(0,lbId.Tag,True);
    ListarTelefone(0,lbId.Tag,True);
  end;
end;

procedure TfrmEmpresa.rctCancelarClick(Sender: TObject);
begin
  case rctCancelar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Excluir','Deseja excluir o registro?','SIM',Deletar_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Cancelar','Deseja cancelar as alterações?','SIM',Cancelar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmEmpresa.rctConfirmarClick(Sender: TObject);
begin
  case rctConfirmar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Novo','Deseja adicionar um novo registro?','SIM',Novo_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Salvar','Deseja salvar as alterações?','SIM',Salvar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmEmpresa.rctEditarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o registro selecionado?','SIM',EditarRegistro,'NÃO');
end;

procedure TfrmEmpresa.rctEdita_AdicionaisClick(Sender: TObject);
begin
  case tcAdicionais.TabIndex of
    0:FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o endereço selecionado?','SIM',Editar_Endereco,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o endereço selecionado?','SIM',Editar_Telefone,'NÃO');
    2:FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o endereço selecionado?','SIM',Editar_Email,'NÃO');
  end;
end;

procedure TfrmEmpresa.Editar_Endereco(Sender :TObject);
var
  t :TThread;
begin
  Limpar_Endereco;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    x : integer;
    jsonArray: TJSONArray;
  begin
    jsonArray := Dm_DeskTop.EmpresaEnd_Lista(
      0
      ,FId_Selecionado
      ,FEndereco_Id);

    for x := 0 to jsonArray.Size -1 do
    begin

      TThread.Synchronize(nil,
      procedure
      begin
        FStatusTable_End := TStatusTable.stUpdate;
        rctTampa_Endereco.Align := TAlignLayout.Contents;
        rctTampa_Endereco.Visible := True;
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        rctCadEndereco.Tag := jsonArray.Get(x).GetValue<Integer>('id');
        edCadEnd_Cep.Text := jsonArray.Get(x).GetValue<String>('cep');
        edCadEnd_Logradouro.Text := jsonArray.Get(x).GetValue<String>('logradouro');
        edCadEnd_Complemento.Text := jsonArray.Get(x).GetValue<String>('complemento');
        edCadEnd_Bairro.Text := jsonArray.Get(x).GetValue<String>('bairro');
        edCadEnd_Municipio.Text := jsonArray.Get(x).GetValue<String>('municipio');
        edCadEnd_Municipio.TagString := jsonArray.Get(x).GetValue<String>('ibge');
        edCadEnd_UF.TagString := jsonArray.Get(x).GetValue<String>('siglaUf');
        edCadEnd_UF.Text := jsonArray.Get(x).GetValue<String>('uf');
        edCadEnd_Nr.Text := jsonArray.Get(x).GetValue<String>('numero');
        edCadEnd_Regiao.Text := jsonArray.Get(x).GetValue<String>('regiao');
        edCadEnd_Pais.Tag := jsonArray.Get(x).GetValue<Integer>('codigoPais');
        edCadEnd_Pais.Text := jsonArray.Get(x).GetValue<String>('pais');
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        Exibir_Labels_Endereco;
      end);

    end;
  end);

  t.OnTerminate := ThreadEnd_EditaEndereco;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_EditaEndereco(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Editar Endereço',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmEmpresa.Exibir_Labels_Endereco;
begin
  if Trim(edCadEnd_Cep.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Cep,lbCadEnd_Cep,faCadEnd_Cep,10,-20);
  if Trim(edCadEnd_Logradouro.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Logradouro,lbCadEnd_Logradouro,faCadEnd_Logradouro,10,-20);
  if Trim(edCadEnd_Nr.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Nr,lbCadEdn_Nr,faCadEnd_Nr,10,-20);
  if Trim(edCadEnd_Complemento.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Complemento,lbCadEnd_Complemento,faCadEnd_Complemento,10,-20);
  if Trim(edCadEnd_Bairro.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Bairro,lbCadEnd_Bairro,faCadEnd_Bairro,10,-20);
  if Trim(edCadEnd_Municipio.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Municipio,lbCadEnd_Municipio,faCadEnd_Municipio,10,-20);
  if Trim(edCadEnd_UF.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_UF,lbCadEnd_UF,faCadEnd_UF,10,-20);
  if Trim(edCadEnd_Regiao.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Regiao,lbCadEnd_Regiao,faCadEnd_Regiao,10,-20);
  if Trim(edCadEnd_Pais.Text) <> '' then
    TFuncoes.ExibeLabel(edCadEnd_Pais,lbCadEnd_Pais,faCadEnd_Pais,10,-20);
end;

procedure TfrmEmpresa.Exibir_Labels_Telefone;
begin
  if Trim(edCadTel_Tipo.Text) <> '' then
    TFuncoes.ExibeLabel(edCadTel_Tipo,lbCadTel_Tipo,faCadTel_Tipo,10,-20);
  if Trim(edCadTel_Numero.Text) <> '' then
    TFuncoes.ExibeLabel(edCadTel_Numero,lbCadTel_Numero,faCadTel_Numero,10,-20);
end;

procedure TfrmEmpresa.Editar_Telefone(Sender :TObject);
var
  t :TThread;
begin
  Limpar_Telefone;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    x : integer;
    jsonArray: TJSONArray;
  begin
    jsonArray := Dm_DeskTop.EmpresaTel_Lista(
      0
      ,FId_Selecionado
      ,FTelefone_ID);

    for x := 0 to jsonArray.Size -1 do
    begin

      TThread.Synchronize(nil,
      procedure
      begin
        FStatusTable_Tel := TStatusTable.stUpdate;
        rctTampa_Telefone.Align := TAlignLayout.Contents;
        rctTampa_Telefone.Visible := True;
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        rctCad_Telefone.Tag := jsonArray.Get(x).GetValue<Integer>('id');
        edCadTel_Tipo.Tag := jsonArray.Get(x).GetValue<Integer>('tipo');
        edCadTel_Tipo.Text := jsonArray.Get(x).GetValue<String>('tipoDesc');
        edCadTel_Numero.Text := jsonArray.Get(x).GetValue<String>('numero');
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        Exibir_Labels_Telefone;
      end);

    end;
  end);

  t.OnTerminate := ThreadEnd_EditaTelefone;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_EditaTelefone(Sender :TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Editar Telefone',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmEmpresa.Editar_Email(Sender :TObject);
var
  t :TThread;
begin
  Limpar_Email;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    x : integer;
    jsonArray: TJSONArray;
  begin
    jsonArray := Dm_DeskTop.EmpresaEmail_Lista(
      0
      ,FId_Selecionado
      ,FEmail_ID);

    for x := 0 to jsonArray.Size -1 do
    begin

      TThread.Synchronize(nil,
      procedure
      begin
        FStatusTable_Email := TStatusTable.stUpdate;
        rctTampa_Email.Align := TAlignLayout.Contents;
        rctTampa_Email.Visible := True;
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        rctCadEmail.Tag := jsonArray.Get(x).GetValue<Integer>('id');
        edEmail.Tag := jsonArray.Get(x).GetValue<Integer>('id');
        edEmail.Text := jsonArray.Get(x).GetValue<String>('email');
        edEmail_Responsavel.Text := jsonArray.Get(x).GetValue<String>('responsavel');
        edEmail_Setor.Tag := jsonArray.Get(x).GetValue<Integer>('idSetor');
        edEmail_Setor.Text := jsonArray.Get(x).GetValue<String>('setor');
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        Exibir_Labels_Telefone;
      end);

    end;
  end);

  t.OnTerminate := ThreadEnd_EditaEmail;
  t.Start;
end;

procedure TfrmEmpresa.Exibir_Labels_Email;
begin
  if Trim(edEmail.Text) <> '' then
    TFuncoes.ExibeLabel(edEmail,lbEmail,faEmail,10,-20);
  if Trim(edEmail_Responsavel.Text) <> '' then
    TFuncoes.ExibeLabel(edEmail_Responsavel,lbEmail_Responsavel,faEmail_Responsavel,10,-20);
  if Trim(edEmail_Setor.Text) <> '' then
    TFuncoes.ExibeLabel(edEmail_Setor,lbEmail_Setor,faEmail_Setor,10,-20);
end;

procedure TfrmEmpresa.ThreadEnd_EditaEmail(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Editar E-mail',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmEmpresa.rctExclui_AdicionaisClick(Sender: TObject);
begin
  case tcAdicionais.TabIndex of
    0:FMensagem.Show(TIconDialog.Question,'Delete','Deseja excluir o endereço selecionado?','SIM',Excluir_Endereco,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Delete','Deseja excluir o endereço selecionado?','SIM',Excluir_Telefone,'NÃO');
    2:FMensagem.Show(TIconDialog.Question,'Delete','Deseja excluir o endereço selecionado?','SIM',Excluir_Email,'NÃO');
  end;
end;

procedure TfrmEmpresa.Excluir_Endereco(Sender :TObject);
var
  t :TThread;
begin
  TLoading.Show(frmEmpresa,'Excluindo endereço');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.EmpresaEnd_Excluir(lbId.Tag,FEndereco_Id);
  end);

  t.OnTerminate := ThreadEnd_DeletarEndereco;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_DeletarEndereco(Sender :TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    //lvEnderecos.Tag := 0;
    FProcessandoEnd := '';
    Listar_Endereco(0,lbId.Tag,True);
    ListarTelefone(0,lbId.Tag,True);
  end;
end;

procedure TfrmEmpresa.Excluir_Telefone(Sender :TOBject);
var
  t :TThread;
begin
  TLoading.Show(frmEmpresa,'Excluindo telefone');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.EmpresaTEl_Excluir(lbId.Tag,FTelefone_ID);
  end);

  t.OnTerminate := ThreadEnd_DeletarTelefone;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_DeletarTelefone(Sender :TObject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessandoTel := '';
    ListarTelefone(0,lbId.Tag,True,0);
  end;
end;

procedure TfrmEmpresa.Excluir_Email(Sender :TObject);
var
  t :TThread;
begin
  TLoading.Show(frmEmpresa,'Excluindo E-mail');

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.EmpresaEmail_Excluir(lbId.Tag,FEmail_ID);
  end);

  t.OnTerminate := ThreadEnd_ExcluirEmail;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_ExcluirEmail(Sender :TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessandoEmail := '';
    ListarEmail(0,lbId.Tag,True,0);
  end;
end;

procedure TfrmEmpresa.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Fechar formulário?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

procedure TfrmEmpresa.rctNovo_AdicionaisClick(Sender: TObject);
begin
  case tcAdicionais.TabIndex of
    0:FMensagem.Show(TIconDialog.Question,'Endereço','Deseja incluir um novo Endereço?','SIM',NovoEndereco,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Telefone','Deseja incluir um novo Telefone?','SIM',NovoTelefone,'NÃO');
    2:FMensagem.Show(TIconDialog.Question,'E-mail','Deseja incluir um novo E-mail?','SIM',NovoEmail,'NÃO');
  end;
end;

procedure TfrmEmpresa.NovoEndereco(Sender: TOBject);
begin
  Limpar_Endereco;

  FStatusTable_End := TStatusTable.stInsert;
  rctTampa_Endereco.Align := TAlignLayout.Contents;
  rctTampa_Endereco.Visible := True;
  edCadEnd_Logradouro.Tag := 0;
end;

procedure TfrmEmpresa.NovoTelefone(Sender: TOBject);
begin
  Limpar_Telefone;

  FStatusTable_Tel := TStatusTable.stInsert;
  rctTampa_Telefone.Align := TAlignLayout.Contents;
  rctTampa_Telefone.Visible := True;
end;

procedure TfrmEmpresa.NovoEmail(Sender: TOBject);
begin
  Limpar_Email;

  FStatusTable_Email := TStatusTable.stInsert;
  rctTampa_Email.Align := TAlignLayout.Contents;
  rctTampa_Email.Visible := True;
end;

procedure TfrmEmpresa.Limpar_Email;
begin
  edEmail.Text := '';
  edEmail_Responsavel.Text := '';
  edEmail_Setor.Tag := -1;
  edEmail_Setor.Text := '';
end;

procedure TfrmEmpresa.rctStatus_AtivoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Ativo.Tag;
  edStatus.Text := lbStatus_Ativo.Text;
  SelStatus;
end;

procedure TfrmEmpresa.rctStatus_InativoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Ativo.Tag;
  edStatus.Text := lbStatus_Ativo.Text;
  SelStatus;
end;

procedure TfrmEmpresa.rctTipo_FisicoClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Fisico);
end;

procedure TfrmEmpresa.rctTipo_JuridicoClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Juridico);
end;

procedure TfrmEmpresa.Salvar_Alteracoes(Sender: TOBject);
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
      if not Dm_DeskTop.Empresa_Cadastro(FDMem_Registros.ToJSONArray,0) then
        raise Exception.Create('Erro ao salvar as alterações');
    end
    else if FStatusTable = stUpdate then
    begin
      if not Dm_DeskTop.Empresa_Cadastro(FDMem_Registros.ToJSONArray,1) then
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

procedure TfrmEmpresa.SelecionaTipo(Sender: TObject; AEdit: TEdit;
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

procedure TfrmEmpresa.SelStatus;
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

procedure TfrmEmpresa.SelTipo;
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

procedure TfrmEmpresa.ThreadEnd_DeletarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmEmpresa.ThreadEnd_SalvarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmEmpresa.ThreadEnd_Status(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmEmpresa.ThreadEnd_Tipo(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

end.
