unit uMov.ServicosPrestados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uFuncoes,

  uCad.TabPrecos, FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox, FMX.dxGrid, FMX.dxControlUtils, FMX.dxControls,
  FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, FMX.Ani, FMX.Calendar, FMX.frxClass, FMX.frxDBSet, FMX.frxDesgn;

type
  TTab_Status = (dsInsert,dsEdit);

  TfrmMov_ServicosPrestados = class(TForm)
    OpenDialog: TOpenDialog;
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    imgEsconteSenha: TImage;
    imgExibeSenha: TImage;
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctIncluir: TRectangle;
    imgIncluir: TImage;
    rctEditar: TRectangle;
    imgEditar: TImage;
    rctSalvar: TRectangle;
    imgSalvar: TImage;
    rctCancelar: TRectangle;
    imgCancelar: TImage;
    rctExcluir: TRectangle;
    imgExcluir: TImage;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    lytLista: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    tiCadastro: TTabItem;
    lytCadastro: TLayout;
    lytRow_001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbSTATUS: TLabel;
    edSTATUS: TComboBox;
    lbDATA: TLabel;
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosDESCRICAO: TStringField;
    FDQRegistrosSTATUS: TIntegerField;
    FDQRegistrosID_EMPRESA: TIntegerField;
    FDQRegistrosID_PRESTADOR_SERVICO: TIntegerField;
    FDQRegistrosID_CLIENTE: TIntegerField;
    FDQRegistrosID_TABELA: TIntegerField;
    FDQRegistrosDATA: TDateField;
    FDQRegistrosHR_INICIO: TTimeField;
    FDQRegistrosHR_FIM: TTimeField;
    FDQRegistrosVLR_HORA: TFMTBCDField;
    FDQRegistrosSUB_TOTAL: TFMTBCDField;
    FDQRegistrosDESCONTO: TFMTBCDField;
    FDQRegistrosDESCONTO_MOTIVO: TStringField;
    FDQRegistrosACRESCIMO: TFMTBCDField;
    FDQRegistrosACRESCIMO_MOTIVO: TStringField;
    FDQRegistrosTOTAL: TFMTBCDField;
    FDQRegistrosOBSERVACAO: TStringField;
    FDQRegistrosDT_PAGO: TDateField;
    FDQRegistrosVLR_PAGO: TFMTBCDField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosID_USUARIO: TIntegerField;
    FDQRegistrosSTATUS_DESC: TStringField;
    FDQRegistrosEMPRESA: TStringField;
    FDQRegistrosPRESTAOR_SERVICO: TStringField;
    FDQRegistrosCLIENTE: TStringField;
    FDQRegistrosTABELA: TStringField;
    FDQRegistrosTABELA_TIPO: TStringField;
    FDQRegistrosVALOR: TFMTBCDField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCRICAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_PRESTADOR_SERVICO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_CLIENTE: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_TABELA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DATA: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_INICIO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_FIM: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_TOTAL: TdxfmGridColumn;
    dxfmGrid1RootLevel1VLR_HORA: TdxfmGridColumn;
    dxfmGrid1RootLevel1SUB_TOTAL: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO_MOTIVO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ACRESCIMO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ACRESCIMO_MOTIVO: TdxfmGridColumn;
    dxfmGrid1RootLevel1TOTAL: TdxfmGridColumn;
    dxfmGrid1RootLevel1OBSERVACAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_PAGO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VLR_PAGO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_USUARIO: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1PRESTAOR_SERVICO: TdxfmGridColumn;
    dxfmGrid1RootLevel1CLIENTE: TdxfmGridColumn;
    dxfmGrid1RootLevel1TABELA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TABELA_TIPO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
    edDATA: TEdit;
    lytRow_003: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA_Desc: TEdit;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_005: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO_Desc: TEdit;
    edID_PRESTADOR_SERVICO: TEdit;
    imgID_PRESTADOR_SERVICO: TImage;
    lytRow_006: TLayout;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE_Desc: TEdit;
    edID_CLIENTE: TEdit;
    imgID_CLIENTE: TImage;
    lytRow_007: TLayout;
    lbID_TABELA: TLabel;
    edID_TABELA_Desc: TEdit;
    edID_TABELA: TEdit;
    imgID_TABELA: TImage;
    edID_TABELA_Valor: TEdit;
    edID_TABELA_Tipo: TEdit;
    lytRow_008: TLayout;
    lbHR_INICIO: TLabel;
    edHR_INICIO: TEdit;
    edHR_FIM: TEdit;
    lbHR_FIM: TLabel;
    edHR_TOTAL: TEdit;
    lbHR_TOTAL: TLabel;
    lbVLR_HORA: TLabel;
    edVLR_HORA: TEdit;
    lytRow_009: TLayout;
    lbSUB_TOTAL: TLabel;
    edSUB_TOTAL: TEdit;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lbACRESCIMO: TLabel;
    edACRESCIMO: TEdit;
    lbTOTAL: TLabel;
    edTOTAL: TEdit;
    lytRow_010: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_011: TLayout;
    lbDT_PAGO: TLabel;
    edDT_PAGO: TEdit;
    lbVLR_PAGO: TLabel;
    edVLR_PAGO: TEdit;
    rctPagamento: TRectangle;
    imPagamento: TImage;
    rctTotais_Receber: TRectangle;
    lbTotal_Receber_Hora_Tit: TLabel;
    lbTotal_Receber_Hora: TLabel;
    lbTotal_Recebido_Tit: TLabel;
    lbTotal_Recebido_Hora: TLabel;
    lytFiltro_Periodo: TLayout;
    lytFiltro_Empresa: TLayout;
    lytFiltro_Prestador: TLayout;
    lytFiltro_Cliente: TLayout;
    lbFiltro_Periodo_Tit: TLabel;
    lytFiltro_Cliente_Tit: TLabel;
    lytFiltro_Empresa_Tit: TLabel;
    lytFiltro_Prestador_Filtro: TLabel;
    lbFiltro_Data_A: TLabel;
    edFiltro_Empresa_ID: TEdit;
    imgFiltro_Empresa: TImage;
    edFiltro_Empresa: TEdit;
    edFiltro_Cliente_ID: TEdit;
    imgFiltro_Cliente: TImage;
    edFiltro_Cliente: TEdit;
    edFiltro_Prestador_ID: TEdit;
    imgFiltro_Prestador: TImage;
    edFiltro_Prestador: TEdit;
    rctFiltro_Periodo: TRectangle;
    rctFiltro_Cliente: TRectangle;
    rctFiltro_Empresa: TRectangle;
    rctFiltro_Prestador: TRectangle;
    edFIltro_Dt_I: TEdit;
    edFIltro_Dt_F: TEdit;
    rctMenu_Tampa: TRectangle;
    rctMenu: TRectangle;
    lytMenu_Titulo: TLayout;
    lbMenu_Titulo: TLabel;
    rctMenu_BaixarHoras: TRectangle;
    lbMenu_BaixarHoras: TLabel;
    imgMenuFechar: TImage;
    faMenu: TFloatAnimation;
    rctFecharMes: TRectangle;
    lbFecharMes: TLabel;
    FDQRegistrosHR_TOTAL: TStringField;
    rctMenuBaixar_Horas: TRectangle;
    rctBH_Detail: TRectangle;
    ShadowEffect1: TShadowEffect;
    rctBH_Header: TRectangle;
    lbBH_Titulo: TLabel;
    lytBH_ValorPago: TLayout;
    edBH_ValorPago: TEdit;
    lytBH_Data: TLayout;
    edBH_Data: TEdit;
    lytBH_TotalHoras: TLayout;
    lbBH_TotalHoras: TLabel;
    lytBH_Footer: TLayout;
    gplBH_Footer: TGridPanelLayout;
    rctBH_Cancelar: TRectangle;
    imgBH_Cancelar: TImage;
    rctBH_Confirmar: TRectangle;
    imgBH_Confirmar: TImage;
    lytBH_Cliente: TLayout;
    edBH_Cliente: TEdit;
    lbBH_Cliente: TLabel;
    imgBH_Cliente: TImage;
    rctCalendario_Tampa: TRectangle;
    rctCalendario: TRectangle;
    ShadowEffect2: TShadowEffect;
    lytCalendario_Header: TLayout;
    rctCalendario_Header: TRectangle;
    lbCalendario_Titulo: TLabel;
    imgCalendario_Cancelar: TImage;
    lytCalendario_Detail: TLayout;
    rctCalendario_Detail: TRectangle;
    Calendar: TCalendar;
    lytCalendario_Footer: TLayout;
    rctCalendario_Footer: TRectangle;
    imgFIltro_Dt_I: TImage;
    Image1: TImage;
    rctMenu_FecharMes_Tampa: TRectangle;
    rctMenu_FecharMes: TRectangle;
    ShadowEffect5: TShadowEffect;
    rctMenu_FecharMes_Header: TRectangle;
    lbMenu_FecharMes_Titulo: TLabel;
    lytMenu_FecharMes_Data: TLayout;
    edMenu_FecharMes_Data: TEdit;
    lytMenu_FecharMes_HorasBase: TLayout;
    lbMenu_FecharMes_HorasBase: TLabel;
    lytMenu_FecharMes_Footer: TLayout;
    gplMenu_FecharMes: TGridPanelLayout;
    rctMenu_FecharMes_Confirm: TRectangle;
    imgMenu_FecharMes_Confirm: TImage;
    rctMenu_FecharMes_Cancel: TRectangle;
    imgMenu_FecharMes_Cancel: TImage;
    lytMenu_FecharMes_Cliente: TLayout;
    edMenu_FecharMes_Cliente: TEdit;
    imgMenu_FecharMes_Cliente: TImage;
    lbMenu_FecharMes_Cliente: TLabel;
    lbMenu_FecharMes_Data: TLabel;
    lytMenu_FecharMes_DtLanc: TLayout;
    edMenu_FecharMes_DtLanc: TEdit;
    lbMenu_FecharMes_DtLanc: TLabel;
    frxReport: TfrxReport;
    frxDBD_Registros: TfrxDBDataset;
    rctPrinter: TRectangle;
    imgPrinter: TImage;
    rctImprimir_Tampa: TRectangle;
    rctImprimir: TRectangle;
    ShadowEffect6: TShadowEffect;
    rctImp_Header: TRectangle;
    lbImp_Titulo: TLabel;
    lytImp_NomeRel: TLayout;
    lbImp_NomeRel: TLabel;
    lytImp_Opcoes: TLayout;
    gplImpressao: TGridPanelLayout;
    rctImp_Imprimir: TRectangle;
    imgImp_Imprimir: TImage;
    rctImp_Visualizar: TRectangle;
    imgImp_Visualizar: TImage;
    lytImp_Relacao: TLayout;
    lbImp_Relacao: TLabel;
    cmbImp_Relacao: TComboBox;
    rctImp_Editar: TRectangle;
    imgImp_Editar: TImage;
    imgImp_Fechar: TImage;
    rctTotais: TRectangle;
    rctTotalValores: TRectangle;
    lbTotal_Receber_Valor_Tit: TLabel;
    lbTotal_Receber_Valor: TLabel;
    lytTotalReceber_Tit: TLayout;
    lbTotalReceber_Titulo: TLabel;
    lytTotal_Recebido_Tit: TLayout;
    lbTotal_Recebido_Titutlo: TLabel;
    lbTotal_Recebido_Valor_Tit: TLabel;
    lbTotal_Recebido_Valor: TLabel;
    FDQRegistrosID_CONTA: TIntegerField;
    FDQRegistrosCONTA: TStringField;
    FDQRegistrosTIPO: TIntegerField;
    FDQRegistrosTIPO_CONTA: TStringField;
    dxfmGrid1RootLevel1ID_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_CONTA: TdxfmGridColumn;
    lytRow_004: TLayout;
    lbID_CONTA: TLabel;
    edID_CONTA_Desc: TEdit;
    edID_CONTA: TEdit;
    imgID_CONTA: TImage;
    edConta_Tipo: TEdit;
    lytFiltro_TipoConta: TLayout;
    rctFiltro_TipoCompra: TRectangle;
    imgFiltro_Credito: TImage;
    lbFiltro_Credito: TLabel;
    imgFiltro_Debito: TImage;
    lbFiltro_Debito: TLabel;
    lbFiltro_TipoConta: TLabel;
    imgChecked: TImage;
    imgUnChecked: TImage;
    GridPanelLayout1: TGridPanelLayout;
    rctTotalSaldo: TRectangle;
    lbTotalSaldo_Hora_Tit: TLabel;
    lbTotalSaldo_Hora: TLabel;
    lytTotalSaldo: TLayout;
    lbTotalSaldo_Tit: TLabel;
    lbTotalSaldo_Valor: TLabel;
    lbTotalSaldo_Valor_Tit: TLabel;
    FDQRegistrosSEGUNDOS: TLargeintField;
    rctTotais_Creditos_Tit: TRectangle;
    rctTotal_Recebido_Tit: TRectangle;
    rctTotalSaldo_Tit: TRectangle;
    frxDBD_Relaorio: TfrxDBDataset;
    procedure edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_PRESTADOR_SERVICOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edID_CLIENTEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_TABELAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edHR_INICIOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edHR_FIMKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSUB_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edACRESCIMOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edOBSERVACAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDATATyping(Sender: TObject);
    procedure edHR_INICIOTyping(Sender: TObject);
    procedure edHR_FIMTyping(Sender: TObject);
    procedure edSUB_TOTALTyping(Sender: TObject);
    procedure edDESCONTOTyping(Sender: TObject);
    procedure edACRESCIMOTyping(Sender: TObject);
    procedure imgID_EMPRESAClick(Sender: TObject);
    procedure imgID_PRESTADOR_SERVICOClick(Sender: TObject);
    procedure imgID_CLIENTEClick(Sender: TObject);
    procedure imgID_TABELAClick(Sender: TObject);
    procedure edHR_INICIOChange(Sender: TObject);
    procedure edSUB_TOTALChange(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure edID_TABELAChangeTracking(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edID_CLIENTEExit(Sender: TObject);
    procedure edID_EMPRESAExit(Sender: TObject);
    procedure edID_PRESTADOR_SERVICOExit(Sender: TObject);
    procedure edID_TABELAExit(Sender: TObject);
    procedure imgFiltro_EmpresaClick(Sender: TObject);
    procedure imgFiltro_PrestadorClick(Sender: TObject);
    procedure imgFiltro_ClienteClick(Sender: TObject);
    procedure edFIltro_Dt_ITyping(Sender: TObject);
    procedure edFIltro_Dt_FTyping(Sender: TObject);
    procedure edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFiltro_Prestador_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgMenuFecharClick(Sender: TObject);
    procedure rctMenu_BaixarHorasClick(Sender: TObject);
    procedure edHR_TOTALTyping(Sender: TObject);
    procedure edHR_TOTALChange(Sender: TObject);
    procedure edHR_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure rctBH_CancelarClick(Sender: TObject);
    procedure imgBH_ClienteClick(Sender: TObject);
    procedure edBH_ClienteExit(Sender: TObject);
    procedure edBH_ValorPagoChange(Sender: TObject);
    procedure edBH_ValorPagoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBH_ValorPagoTyping(Sender: TObject);
    procedure edBH_DataTyping(Sender: TObject);
    procedure imgFIltro_Dt_IClick(Sender: TObject);
    procedure CalendarDateSelected(Sender: TObject);
    procedure imgCalendario_CancelarClick(Sender: TObject);
    procedure edMenu_FecharMes_ClienteExit(Sender: TObject);
    procedure edMenu_FecharMes_ClienteKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgMenu_FecharMes_ClienteClick(Sender: TObject);
    procedure rctMenu_FecharMes_CancelClick(Sender: TObject);
    procedure edBH_ClienteKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edMenu_FecharMes_DataTyping(Sender: TObject);
    procedure edMenu_FecharMes_DataKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edMenu_FecharMes_DtLancTyping(Sender: TObject);
    procedure imgImp_FecharClick(Sender: TObject);
    procedure cmbImp_RelacaoChange(Sender: TObject);
    procedure rctImp_EditarClick(Sender: TObject);
    procedure edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgID_CONTAClick(Sender: TObject);
    procedure edID_CONTAExit(Sender: TObject);
    procedure imgFiltro_CreditoClick(Sender: TObject);
    procedure imgFiltro_DebitoClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;

    FDm_Global :TDM_Global;
    FDM_Cliente :TDM_Cliente;

    FTab_Status :TTab_Status;
    FPesquisa: Boolean;
    FCliRetorno :Integer;
    FHorasCalculadas :String;
    FDataRetorno :Integer;
    FHoraBase :String;

    FConta_HorasTrabalhadas :Integer;
    FConta_HorasPagas :Integer;
    FConta_HorasExcedidas :Integer;
    FConta_HorasRecebidas :Integer;
    FFormaPagto_Id :Integer;
    FCondPagto_Id :Integer;

    procedure Sel_Empresa(Aid: Integer; ANome: String);
    procedure Sel_Empresa_Filtro(Aid: Integer; ANome: String);
    procedure Sel_PrestServicos(Aid: Integer; ANome: String);
    procedure Sel_PrestServicos_Filtro(Aid: Integer; ANome: String);
    procedure Sel_Cliente(Aid: Integer; ANome: String);
    procedure Sel_Cliente_Filtro(Aid: Integer; ANome: String);
    procedure Sel_TabPrecos(Aid: Integer; ADescricao: String; ATipo: Integer; AValor: Double);

    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Selecionar_Registros;
    procedure Configura_Botoes;
    procedure Limpar_Campos;
    procedure SetPesquisa(const Value: Boolean);
    procedure TThreadEnd_CalcHora(Sender: TObject);
    procedure TThreadEnd_CalculaValor(Sender: TOBject);
    procedure Menu(Sender: TOBject);
    procedure Lancar_ContasReceber(
      AId:Integer;
      AID_EMPRESA:Integer;
      ADT_EMISSAO:TDate;
      AID_PESSOA:Integer;
      AID_CONTA:Integer;
      AData:TDate;
      AVALOR:Double;
      AID_ORIGEM_LANCAMENTO:Integer;
      AOBSERVACAO:String;
      AContaPaga:Boolean=False);
    procedure TThreadEnd_Menu(Sender: TObject);
    procedure BaixarHoras(Sender: TOBject);
    procedure FecharMes(Sender: TOBject);
    procedure CancelaPagamento(Sender: TObject);
    procedure ConfirmaPagamento(Sender: TObject);
    procedure CalcularHoras;
    procedure TThredEnd_CalcularHoras(Sender: TOBject);
    procedure TThreadEnd_ConfirmaPagamento(Sender: TOBject);
    procedure Nome_Empresa;
    procedure Nome_Prestador;
    procedure Nome_Cliente;
    procedure Baixar_Horas(AId:Integer;AData:TDate;AValor:Double);
    procedure Baixar_Lanc_Financeiro(AId:Integer;AData:TDate;AValor:Double);
    procedure Gerar_Novo_Lancamento(
      AHoras:String;
      AData:TDate;
      AIDConta:Integer;
      FSegundos:Integer;
      AValor:Double;
      AContaPaga:Boolean=False);
    procedure CancelaFechamento(Sender: TOBject);
    procedure ConfirmaFechamento(Sender: TOBject);
    procedure TThreadEnd_ConfirmaFechamento(Sender: TOBject);
    procedure Imprimir_Relatorios;
    procedure TThreadEnd_Selecionar_Registros(Sender: TOBject);
    procedure Sel_Conta(Aid: Integer; ADescricao: String; ATipo: Integer);
  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmMov_ServicosPrestados: TfrmMov_ServicosPrestados;

implementation

{$R *.fmx}

uses
  uCad.Empresa
  ,uCad.PrestServico
  ,uCad.Contas
  ,uCad.Cliente;

procedure TfrmMov_ServicosPrestados.Cancelar;
begin
  try
    try
      tcPrincipal.GotoVisibleTab(0);
    except on E: Exception do
      raise Exception.Create('Cancelar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmMov_ServicosPrestados.cmbImp_RelacaoChange(Sender: TObject);
begin
  case cmbImp_Relacao.ItemIndex of
    0:lbImp_NomeRel.Text := 'Horas_Trabalhadas.fr3';
  end;
end;

procedure TfrmMov_ServicosPrestados.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmMov_ServicosPrestados.edACRESCIMOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBH_ValorPago.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edACRESCIMOTyping(Sender: TObject);
begin
  Formatar(edACRESCIMO,Money);
end;

procedure TfrmMov_ServicosPrestados.edBH_ClienteExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      if Trim(edBH_Cliente.Text) = '' then
        Exit;

      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_Cliente(edBH_Cliente.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        lbBH_Cliente.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edBH_ClienteKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBH_ValorPago.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edBH_DataTyping(Sender: TObject);
begin
  Formatar(edBH_Data,Dt);
end;

procedure TfrmMov_ServicosPrestados.edBH_ValorPagoChange(Sender: TObject);
begin
  edBH_ValorPago.TagFloat := 0;
  edBH_ValorPago.TagFloat := (StrToFloatDef(TFuncoes.ApenasNumeros(edBH_ValorPago.Text),0) / 100);
  CalcularHoras;
end;

procedure TfrmMov_ServicosPrestados.edBH_ValorPagoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBH_Data.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edBH_ValorPagoTyping(Sender: TObject);
begin
  Formatar(edBH_ValorPago,Money);
end;

procedure TfrmMov_ServicosPrestados.edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCRICAO.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edDATATyping(Sender: TObject);
begin
  Formatar(edDATA,Dt);
end;

procedure TfrmMov_ServicosPrestados.edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edACRESCIMO.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edDESCONTOTyping(Sender: TObject);
begin
  Formatar(edDESCONTO,Money);
end;

procedure TfrmMov_ServicosPrestados.edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_EMPRESA.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Nome_Cliente;
    Selecionar_Registros;
    edFIltro_Dt_I.SetFocus;
  end;
end;

procedure TfrmMov_ServicosPrestados.Nome_Cliente;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edFiltro_Cliente_ID.Text) = '' then
        Exit;

      FDm_Global.Listar_Cliente(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Cliente.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
    Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Nome_Empresa;
    Selecionar_Registros;
    edFiltro_Prestador_ID.SetFocus;
  end;
end;

procedure TfrmMov_ServicosPrestados.Nome_Empresa;
var
  FQuery :TFDQuery;
begin
  try
    try

      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if edFiltro_Empresa_ID.Text = '' then
        Exit;

      FDm_Global.Listar_Empresa(edFiltro_Empresa_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Empresa.Text := FQuery.FieldByName('NOME').AsString;


    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
    Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Prestador_IDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Nome_Prestador;
    Selecionar_Registros;
    edFiltro_Cliente_ID.SetFocus;
  end;
end;

procedure TfrmMov_ServicosPrestados.Nome_Prestador;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edFiltro_Prestador_ID.Text) = '' then
        Exit;

      FDm_Global.Listar_PrestadorServico(edFiltro_Prestador_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Prestador.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
    Selecionar_Registros;
  end;

end;

procedure TfrmMov_ServicosPrestados.edHR_FIMKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    edHR_TOTAL.ReadOnly := True;
    if ((Trim(edHR_INICIO.Text) = '') and (Trim(edHR_FIM.Text) = '')) then
    begin
      edHR_TOTAL.SetFocus;
      edHR_TOTAL.ReadOnly := False;
    end
    else
      edSUB_TOTAL.SetFocus;
  end;

end;

procedure TfrmMov_ServicosPrestados.edHR_FIMTyping(Sender: TObject);
begin
  Formatar(edHR_FIM,Hr);
end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOChange(Sender: TObject);
var
  t :TThread;

begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FHora :TDateTime;
    FHoraI_Valida :Boolean;
    FHoraF_Valida :Boolean;
    FHora_Resultado :TTime;
    FTotal_Receber :Double;
  begin

    FTotal_Receber := 0;

    FHoraI_Valida := TryStrToTime(edHR_INICIO.Text,FHora);
    FHoraF_Valida := TryStrToTime(edHR_FIM.Text,FHora);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      if ((FHoraI_Valida) and (FHoraF_Valida)) then
      begin
        FHora_Resultado := (StrToTimeDef(edHR_FIM.Text,Time) - StrToTimeDef(edHR_INICIO.Text,Time));
        edHR_TOTAL.Text := TimeToStr(FHora_Resultado);
        FTotal_Receber := ((FHora_Resultado * 24) * edVLR_HORA.TagFloat);
        edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00',FTotal_Receber);
        edSUB_TOTAL.TagFloat := FTotal_Receber;
        edSUB_TOTALChange(Sender);
      end;
    end);
  end);

  t.OnTerminate := TThreadEnd_CalcHora;
  t.Start;

end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_CalcHora(Sender :TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Calculando horas. ' + Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edHR_FIM.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOTyping(Sender: TObject);
begin
  Formatar(edHR_INICIO,Hr);
end;

procedure TfrmMov_ServicosPrestados.edHR_TOTALChange(Sender: TObject);
var
  FHora_Resultado :TDateTime;
  FTotal_Receber :Double;
  FHora, FMinuto, FSegundo :Integer;
  FVlr_Hr, FVlr_Mn, FVlr_Sg :Double;

begin
  if ((Trim(edHR_INICIO.Text) = '') and (Trim(edHR_FIM.Text) = '')) then
  begin
    FHora := 0;
    FMinuto := 0;
    FSegundo := 0;
    FVlr_Hr := 0;
    FVlr_Mn := 0;
    FVlr_Sg := 0;

    FHora := StrToIntDef(Copy(edHR_TOTAL.Text,1,3),0);
    FMinuto := StrToIntDef(Copy(edHR_TOTAL.Text,5,2),0);
    FSegundo := StrToIntDef(Copy(edHR_TOTAL.Text,8,2),0);

    FVlr_Hr := (FHora * edVLR_HORA.TagFloat);
    FVlr_Mn := (FMinuto * (edVLR_HORA.TagFloat / 60));
    FVlr_Sg := (FSegundo * (edVLR_HORA.TagFloat / 3600));;

    FTotal_Receber := (FVlr_Hr + FVlr_Mn + FVlr_Sg);
    edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00',FTotal_Receber);
    edSUB_TOTAL.TagFloat := FTotal_Receber;
    edSUB_TOTALChange(Sender);
  end;
end;

procedure TfrmMov_ServicosPrestados.edHR_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edSUB_TOTAL.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edHR_TOTALTyping(Sender: TObject);
begin
  if ((Trim(edHR_INICIO.Text) = '') and (Trim(edHR_FIM.Text) = '')) then
    Formatar(edHR_TOTAL,Tempo);
end;

procedure TfrmMov_ServicosPrestados.edID_CLIENTEExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_Cliente(edID_CLIENTE.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_CLIENTE_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_CLIENTEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_TABELA.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edID_CONTAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edID_CONTA.Text) = '' then
        Exit;

      FDm_Global.Listar_Contas(edID_CONTA.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
      begin
        edID_CONTA_Desc.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edConta_Tipo.Tag := FQuery.FieldByName('TIPO').AsInteger;
        case FQuery.FieldByName('TIPO').AsInteger of
          0:edConta_Tipo.Text := 'RECEBER';
          1:edConta_Tipo.Text := 'PAGAR';
        end;
      end;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_PRESTADOR_SERVICO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edID_EMPRESAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edID_EMPRESA.Text) = '' then
        Exit;

      FDm_Global.Listar_Empresa(edID_EMPRESA.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_EMPRESA_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CONTA.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edID_PRESTADOR_SERVICOExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_PrestadorServico(edID_PRESTADOR_SERVICO.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_PRESTADOR_SERVICO_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_PRESTADOR_SERVICOKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CLIENTE.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edID_TABELAChangeTracking(Sender: TObject);
var
  FSub_Total :Double;
  FDesconto :Double;
  FAcrescimo :Double;
  FTotal :Double;

begin
  FSub_Total := 0;
  FDesconto := 0;
  FAcrescimo := 0;
  FTotal := 0;

  FSub_Total := StrToFloatDef(edSUB_TOTAL.Text,0);
  FDesconto := StrToFloatDef(edDESCONTO.Text,0);
  FAcrescimo := StrToFloatDef(edACRESCIMO.Text,0);
  FTotal := ((FSub_Total + FAcrescimo) - FDesconto);

  edTOTAL.Text := FormatFloat('R$ #,##0.00',FTotal);
  edTOTAL.TagFloat := FTotal;
end;

procedure TfrmMov_ServicosPrestados.edID_TABELAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_TabelaPrecos(edID_TABELA.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
      begin
        edID_TABELA_Desc.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edID_TABELA_Valor.Text := FormatFloat('R$ #,##0.00',FQuery.FieldByName('VALOR').AsFloat);
        edID_TABELA_Valor.TagFloat := FQuery.FieldByName('VALOR').AsFloat;
        edID_TABELA_Tipo.Text := FQuery.FieldByName('TABELA_TIPO').AsString;
        edVLR_HORA.Text := FormatFloat('R$ #,##0.00',FQuery.FieldByName('VALOR').AsFloat);
        edVLR_HORA.TagFloat := FQuery.FieldByName('VALOR').AsFloat;
      end;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_TABELAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edHR_INICIO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Selecionar_Registros;
    edFiltro_Empresa_ID.SetFocus;
  end;
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_FTyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_F,Dt);
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Selecionar_Registros;
    edFIltro_Dt_F.SetFocus;
  end;
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_ITyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_I,Dt);
end;

procedure TfrmMov_ServicosPrestados.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edDESCRICAO.Text := FDQRegistros.FieldByName('DESCRICAO').AsString;
      edSTATUS.ItemIndex := FDQRegistros.FieldByName('STATUS').AsInteger;
      edID_EMPRESA.Text := FDQRegistros.FieldByName('ID_EMPRESA').AsString;
      edID_EMPRESA_Desc.Text := FDQRegistros.FieldByName('EMPRESA').AsString;
      edID_PRESTADOR_SERVICO.Text := FDQRegistros.FieldByName('ID_PRESTADOR_SERVICO').AsString;
      edID_PRESTADOR_SERVICO_Desc.Text := FDQRegistros.FieldByName('PRESTAOR_SERVICO').AsString;
      edID_CLIENTE.Text := FDQRegistros.FieldByName('ID_CLIENTE').AsString;
      edID_CLIENTE_Desc.Text := FDQRegistros.FieldByName('CLIENTE').AsString;
      edID_TABELA.Text := FDQRegistros.FieldByName('ID_TABELA').AsString;
      edID_TABELA_Desc.Text := FDQRegistros.FieldByName('TABELA').AsString;
      edID_TABELA_Tipo.Text := FDQRegistros.FieldByName('TABELA_TIPO').AsString;
      edID_TABELA_Valor.Text := FormatFloat('R$ #,##0.00',FDQRegistros.FieldByName('VALOR').AsFloat);
      edID_TABELA_Valor.TagFloat := FDQRegistros.FieldByName('VALOR').AsFloat;
      edDATA.Text := FDQRegistros.FieldByName('DATA').AsString;
      edHR_INICIO.Text := FDQRegistros.FieldByName('HR_INICIO').AsString;
      edHR_FIM.Text := FDQRegistros.FieldByName('HR_FIM').AsString;
      edHR_TOTAL.Text := FDQRegistros.FieldByName('HR_TOTAL').AsString;
      edVLR_HORA.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VLR_HORA').AsFloat);
      edVLR_HORA.TagFloat := FDQRegistros.FieldByName('VLR_HORA').AsFloat;
      edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('SUB_TOTAL').AsFloat);
      edSUB_TOTAL.TagFloat := FDQRegistros.FieldByName('SUB_TOTAL').AsFloat;
      edDESCONTO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('DESCONTO').AsFloat);
      edDESCONTO.TagFloat := FDQRegistros.FieldByName('DESCONTO').AsFloat;
      edACRESCIMO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('ACRESCIMO').AsFloat);
      edACRESCIMO.TagFloat := FDQRegistros.FieldByName('ACRESCIMO').AsFloat;
      edTOTAL.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('TOTAL').AsFloat);
      edTOTAL.TagFloat := FDQRegistros.FieldByName('TOTAL').AsFloat;
      edOBSERVACAO.Text := FDQRegistros.FieldByName('OBSERVACAO').AsString;
      edDT_PAGO.Text := FDQRegistros.FieldByName('DT_PAGO').AsString;
      edVLR_PAGO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VLR_PAGO').AsFloat);
      edVLR_PAGO.TagFloat := FDQRegistros.FieldByName('VLR_PAGO').AsFloat;
      edID_CONTA.Text := FDQRegistros.FieldByName('ID_CONTA').AsString;
      edID_CONTA_Desc.Text := FDQRegistros.FieldByName('CONTA').AsString;
      edConta_Tipo.Text := FDQRegistros.FieldByName('TIPO_CONTA').AsString;

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edDATA.CanFocus then
        edDATA.SetFocus;
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmMov_ServicosPrestados.edMenu_FecharMes_ClienteExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      if Trim(edMenu_FecharMes_Cliente.Text) = '' then
        Exit;

      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_Cliente(edMenu_FecharMes_Cliente.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        lbMenu_FecharMes_Cliente.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edMenu_FecharMes_ClienteKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edMenu_FecharMes_Data.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edMenu_FecharMes_DataKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edMenu_FecharMes_DtLanc.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edMenu_FecharMes_DataTyping(Sender: TObject);
begin
  Formatar(edMenu_FecharMes_Data,Dt);
end;

procedure TfrmMov_ServicosPrestados.edMenu_FecharMes_DtLancTyping(Sender: TObject);
begin
  Formatar(edMenu_FecharMes_DtLanc,Dt);
end;

procedure TfrmMov_ServicosPrestados.edOBSERVACAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edOBSERVACAO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALChange(Sender: TObject);
var
  t :TThread;

begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FSub_Total :Double;
    FDesconto :Double;
    FAcrescimo :Double;
    FTotal :Double;
  begin
    FSub_Total := 0;
    FDesconto := 0;
    FAcrescimo := 0;
    FTotal := 0;

    edDESCONTO.TagFloat := StrToFloatDef(Trim(StringReplace(edDESCONTO.Text,'R$','',[rfReplaceAll])),0);
    edACRESCIMO.TagFloat := StrToFloatDef(Trim(StringReplace(edACRESCIMO.Text,'R$','',[rfReplaceAll])),0);

    FSub_Total := edSUB_TOTAL.TagFloat;
    FDesconto := edDESCONTO.TagFloat;
    FAcrescimo := edACRESCIMO.TagFloat;
    FTotal := ((FSub_Total + FAcrescimo) - FDesconto);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      edTOTAL.Text := FormatFloat('R$ #,##0.00',FTotal);
      edTOTAL.TagFloat := FTotal;
    end);

  end);

  t.OnTerminate := TThreadEnd_CalculaValor;
  t.Start;

end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_CalculaValor(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Calculando valores. ' + Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCONTO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALTyping(Sender: TObject);
begin
  Formatar(edSUB_TOTAL,Money);
end;

procedure TfrmMov_ServicosPrestados.Excluir(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      FDm_Global.FDC_Firebird.StartTransaction;

      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Excluído');

      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('DELETE FROM LANCAMENTOS ');
      FQuery.Sql.Add('WHERE ORIGEM_LANCAMENTO = :ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  AND ID_ORIGEM_LANCAMENTO = :ID_ORIGEM_LANCAMENTO; ');
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'SERVICOS_PRESTADOS';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM SERVICOS_PRESTADOS WHERE ID = :ID');
      FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

      FDm_Global.FDC_Firebird.Commit;

    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Excluir: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);
  FreeAndNil(FDM_Cliente);


  Action := TCloseAction.caFree;
  frmMov_ServicosPrestados := Nil;
end;

procedure TfrmMov_ServicosPrestados.FormCreate(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    FDm_Global := TDM_Global.Create(Nil);
    FDM_Cliente := TDM_Cliente.Create(FDm_Global.FDC_Firebird);

    FDQRegistros.Connection := FDm_Global.FDC_Firebird;

    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_Firebird;

    with TFuncoes.Datas(Date) do
    begin
      edFIltro_Dt_I.Text := DateToStr(PrimeiroDia);
      edFIltro_Dt_F.Text := DateToStr(UltimoDia);
    end;
    if frmPrincipal.FUser_Empresa > 0 then
    begin
      edFiltro_Empresa_ID.Text := IntToStr(frmPrincipal.FUser_Empresa);
      FDm_Global.Listar_Empresa(frmPrincipal.FUser_Empresa,'',FQuery);
      if not FQuery.IsEmpty then
        edFiltro_Empresa.Text := FQuery.FieldByName('NOME').AsString;
    end;
    if frmPrincipal.FUser_Prestador > 0 then
    begin
      edFiltro_Prestador_ID.Text := IntToStr(frmPrincipal.FUser_Prestador);
      FDm_Global.Listar_PrestadorServico(frmPrincipal.FUser_Prestador,'',FQuery);
      if not FQuery.IsEmpty then
        edFiltro_Prestador.Text := FQuery.FieldByName('NOME').AsString;
    end;

    FFancyDialog := TFancyDialog.Create(frmMov_ServicosPrestados);
    FEnder := '';
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
    FIniFile := TIniFile.Create(FEnder);

    tcPrincipal.ActiveTab := tiLista;

    lytFormulario.Align := TAlignLayout.Center;

    FHoraBase := '';
    FHoraBase := FIniFile.ReadString('FINANCEIRO','TOTAL.HORAS','');

    Selecionar_Registros;
    Configura_Botoes;

    FConta_HorasTrabalhadas := 0;
    FConta_HorasPagas := 0;
    FConta_HorasExcedidas := 0;
    FFormaPagto_Id := 0;
    FCondPagto_Id := 0;
    FConta_HorasTrabalhadas := StrToInt(FIniFile.ReadString('PLANO_CONTAS.LANC','APONT.HORAS','0'));
    FConta_HorasPagas := StrToInt(FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.PAGAS','0'));
    FConta_HorasExcedidas := StrToInt(FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.EXCED','0'));
    FConta_HorasRecebidas := StrToInt(FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.RECEBIDAS','0'));
    FFormaPagto_Id := StrToInt(FIniFile.ReadString('FORMA.COND.LANC','FORMA.ID','0'));
    FCondPagto_Id := StrToInt(FIniFile.ReadString('FORMA.COND.LANC','COND.ID','0'));

    rctMenu.Width := 0;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.imgBH_ClienteClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Cliente) then
    Application.CreateForm(TfrmCad_Cliente, frmCad_Cliente);

  FCliRetorno := 1;
  frmCad_Cliente.Pesquisa := True;
  frmCad_Cliente.ExecuteOnClose := Sel_Cliente;
  frmCad_Cliente.Height := frmPrincipal.Height;
  frmCad_Cliente.Width := frmPrincipal.Width;

  frmCad_Cliente.Show;
end;

procedure TfrmMov_ServicosPrestados.imgCalendario_CancelarClick(Sender: TObject);
begin
  rctCalendario_Tampa.Visible := False;
end;

procedure TfrmMov_ServicosPrestados.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMov_ServicosPrestados.imgFiltro_CreditoClick(Sender: TObject);
begin
  case imgFiltro_Credito.Tag of
    0:begin
      imgFiltro_Credito.Tag := 1;
      imgFiltro_Credito.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Credito.Tag := 0;
      imgFiltro_Credito.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.imgFiltro_DebitoClick(Sender: TObject);
begin
  case imgFiltro_Debito.Tag of
    0:begin
      imgFiltro_Debito.Tag := 1;
      imgFiltro_Debito.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Debito.Tag := 0;
      imgFiltro_Debito.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;

end;

procedure TfrmMov_ServicosPrestados.imgFiltro_ClienteClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Cliente) then
    Application.CreateForm(TfrmCad_Cliente, frmCad_Cliente);

  frmCad_Cliente.Pesquisa := True;
  frmCad_Cliente.ExecuteOnClose := Sel_Cliente_Filtro;
  frmCad_Cliente.Height := frmPrincipal.Height;
  frmCad_Cliente.Width := frmPrincipal.Width;

  frmCad_Cliente.Show;

end;

procedure TfrmMov_ServicosPrestados.imgFIltro_Dt_IClick(Sender: TObject);
begin
  rctCalendario_Tampa.Align := TAlignLayout.Contents;
  FDataRetorno := TImage(Sender).Tag;
  Calendar.Date := Date;
  rctCalendario_Tampa.Visible := True;
end;

procedure TfrmMov_ServicosPrestados.imgFiltro_EmpresaClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa_Filtro;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmMov_ServicosPrestados.imgFiltro_PrestadorClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_PrestServico) then
    Application.CreateForm(TfrmCad_PrestServico, frmCad_PrestServico);

  frmCad_PrestServico.Pesquisa := True;
  frmCad_PrestServico.ExecuteOnClose := Sel_PrestServicos_Filtro;
  frmCad_PrestServico.Height := frmPrincipal.Height;
  frmCad_PrestServico.Width := frmPrincipal.Width;

  frmCad_PrestServico.Show;

end;

procedure TfrmMov_ServicosPrestados.imgID_CLIENTEClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Cliente) then
    Application.CreateForm(TfrmCad_Cliente, frmCad_Cliente);

  FCliRetorno := 0;
  frmCad_Cliente.Pesquisa := True;
  frmCad_Cliente.ExecuteOnClose := Sel_Cliente;
  frmCad_Cliente.Height := frmPrincipal.Height;
  frmCad_Cliente.Width := frmPrincipal.Width;

  frmCad_Cliente.Show;
end;

procedure TfrmMov_ServicosPrestados.imgID_CONTAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas, frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_Conta;
  frmCad_Contas.Height := frmPrincipal.Height;
  frmCad_Contas.Width := frmPrincipal.Width;

  frmCad_Contas.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_Conta(Aid:Integer; ADescricao:String; ATipo:Integer);
begin
  edID_CONTA.Text := Aid.ToString;
  edID_CONTA_Desc.Text := ADescricao;
  edConta_Tipo.Tag := ATipo;

  case ATipo of
    0:edConta_Tipo.Text := 'RECEBER';
    1:edConta_Tipo.Text := 'PAGAR';
  end;

  if edID_CONTA.CanFocus then
    edID_CONTA.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_Cliente(Aid:Integer; ANome:String);
begin
  case FCliRetorno of
    0:begin
      edID_CLIENTE.Text := AId.ToString;
      edID_CLIENTE_Desc.Text := ANome;
      if edID_TABELA.CanFocus then
        edID_TABELA.SetFocus;
    end;
    1:begin
      edBH_Cliente.Text := AId.ToString;
      lbBH_Cliente.Text := ANome;
      if edBH_ValorPago.CanFocus then
        edBH_ValorPago.SetFocus;
    end;
    2:begin
      edMenu_FecharMes_Cliente.Text := AId.ToString;
      lbMenu_FecharMes_Cliente.Text := ANome;
      if edMenu_FecharMes_Data.CanFocus then
        edMenu_FecharMes_Data.SetFocus;
    end;
  end;
end;

procedure TfrmMov_ServicosPrestados.Sel_Cliente_Filtro(Aid: Integer; ANome: String);
begin
  edFiltro_Cliente_ID.Text := AId.ToString;
  edFiltro_Cliente.Text := ANome;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.imgID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;

end;

procedure TfrmMov_ServicosPrestados.imgID_PRESTADOR_SERVICOClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_PrestServico) then
    Application.CreateForm(TfrmCad_PrestServico, frmCad_PrestServico);

  frmCad_PrestServico.Pesquisa := True;
  frmCad_PrestServico.ExecuteOnClose := Sel_PrestServicos;
  frmCad_PrestServico.Height := frmPrincipal.Height;
  frmCad_PrestServico.Width := frmPrincipal.Width;

  frmCad_PrestServico.Show;
end;

procedure TfrmMov_ServicosPrestados.imgID_TABELAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_TabPrecos) then
    Application.CreateForm(TfrmCad_TabPrecos, frmCad_TabPrecos);

  frmCad_TabPrecos.Pesquisa := True;
  frmCad_TabPrecos.ExecuteOnClose := Sel_TabPrecos;
  frmCad_TabPrecos.Height := frmPrincipal.Height;
  frmCad_TabPrecos.Width := frmPrincipal.Width;

  frmCad_TabPrecos.Show;
end;

procedure TfrmMov_ServicosPrestados.imgImp_FecharClick(Sender: TObject);
begin
  rctImprimir_Tampa.Visible := False;
end;

procedure TfrmMov_ServicosPrestados.imgMenuFecharClick(Sender: TObject);
begin
  rctMenu_Tampa.Visible := False;
end;

procedure TfrmMov_ServicosPrestados.imgMenu_FecharMes_ClienteClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Cliente) then
    Application.CreateForm(TfrmCad_Cliente, frmCad_Cliente);

  FCliRetorno := 2;
  frmCad_Cliente.Pesquisa := True;
  frmCad_Cliente.ExecuteOnClose := Sel_Cliente;
  frmCad_Cliente.Height := frmPrincipal.Height;
  frmCad_Cliente.Width := frmPrincipal.Width;

  frmCad_Cliente.Show;

end;

procedure TfrmMov_ServicosPrestados.Sel_TabPrecos(Aid:Integer; ADescricao:String; ATipo:Integer; AValor:Double);
begin
  edID_TABELA.Text := Aid.ToString;
  edID_TABELA_Desc.Text := ADescricao;
  case ATipo of
    0:edID_TABELA_Tipo.Text := 'HORA';
    1:edID_TABELA_Tipo.Text := 'FIXO';
  end;
  edID_TABELA_Valor.Text := FormatFloat('R$ #,##0.00',AValor);
  edVLR_HORA.Text := FormatFloat('R$ #,##0.00',AValor);
  edVLR_HORA.TagFloat := AValor;

  if edHR_INICIO.CanFocus then
    edHR_INICIO.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_PrestServicos(Aid:Integer; ANome:String);
begin
  edID_PRESTADOR_SERVICO.Text := Aid.ToString;
  edID_PRESTADOR_SERVICO_Desc.Text := ANome;

  if edID_CLIENTE.CanFocus then
    edID_CLIENTE.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_PrestServicos_Filtro(Aid: Integer; ANome: String);
begin
  edFiltro_Prestador_ID.Text := Aid.ToString;
  edFiltro_Prestador.Text := ANome;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;
      Limpar_Campos;

      edDATA.Text := DateToStr(Date);
      edSTATUS.ItemIndex := 0;

      tcPrincipal.GotoVisibleTab(1);
      if edDATA.CanFocus then
        edDATA.SetFocus;

      edID_CONTA.Text := FConta_HorasTrabalhadas.ToString;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmMov_ServicosPrestados.Limpar_Campos;
begin
  edID.Text := '';
  edDATA.Text := '';
  edSTATUS.ItemIndex := -1;
  edDESCRICAO.Text := '';
  edID_EMPRESA.Text := '';
  edID_EMPRESA_Desc.Text := '';
  edID_PRESTADOR_SERVICO.Text := '';
  edID_PRESTADOR_SERVICO_Desc.Text := '';
  edID_CLIENTE.Text := '';
  edID_CLIENTE_Desc.Text := '';
  edID_TABELA.Text := '';
  edID_TABELA_Desc.Text := '';
  edID_TABELA_Tipo.Text := '';
  edID_TABELA_Valor.Text := '';
  edID_CONTA.Text := '';
  edID_CONTA_Desc.Text := '';
  edConta_Tipo.Text := '';
  edHR_INICIO.Text := '';
  edHR_FIM.Text := '';
  edHR_TOTAL.Text := '';
  edVLR_HORA.Text := '';
  edVLR_HORA.TagFloat := 0;
  edSUB_TOTAL.Text := '';
  edSUB_TOTAL.TagFloat := 0;
  edDESCONTO.Text := '';
  edDESCONTO.TagFloat := 0;
  edACRESCIMO.Text := '';
  edACRESCIMO.TagFloat := 0;
  edTOTAL.Text := '';
  edTOTAL.TagFloat := 0;
  edOBSERVACAO.Text := '';
  edDT_PAGO.Text := '';
  edVLR_PAGO.Text := '';
  edVLR_PAGO.TagFloat := 0;
end;

procedure TfrmMov_ServicosPrestados.rctBH_CancelarClick(Sender: TObject);
begin
  case TRectangle(Sender).Tag of
    0:CancelaPagamento(Sender);
    1:FFancyDialog.Show(TIconDialog.Question,'Pagamento','Confirma o Pagamento?','Sim',ConfirmaPagamento,'Não');
  end;
end;

procedure TfrmMov_ServicosPrestados.CancelaPagamento(Sender: TObject);
begin
  rctMenuBaixar_Horas.Visible := False;
end;

procedure TfrmMov_ServicosPrestados.CalcularHoras;
var
  t :TThread;

begin
  t := TThread.CreateAnonymousThread(
  procedure
  var
    FValorRecebido, FTaxaHoraria, FHorasTrabalhadas: Double;
    FHoras, FMinutos, FSegundos: Integer;
    FDQSelect :TFDQuery;
  begin
    FValorRecebido := 0;
    FTaxaHoraria := 0;
    FHorasTrabalhadas := 0;
    FHoras := 0;
    FMinutos := 0;
    FSegundos := 0;

    if edBH_ValorPago.TagFloat = 0 then
      raise Exception.Create('Favor informar o valor do pagamento');
    if Trim(edBH_Cliente.Text) = '' then
      raise Exception.Create('Favor informar o cliente');

    {$Region 'Calculando a quantidade de horas pagas'}
      FDQSelect := TFDQuery.Create(Nil);
      FDQSelect.Connection := FDm_Global.FDC_Firebird;
      FDQSelect.Active := False;
      FDQSelect.Sql.Clear;
      FDQSelect.Sql.Add('SELECT ');
      FDQSelect.Sql.Add('  C.ID_TAB_PRECO ');
      FDQSelect.Sql.Add('  ,TP.TIPO ');
      FDQSelect.Sql.Add('  ,TP.VALOR ');
      FDQSelect.Sql.Add('FROM CLIENTE C ');
      FDQSelect.Sql.Add('  JOIN TABELA_PRECO TP ON TP.ID = C.ID_TAB_PRECO ');
      FDQSelect.Sql.Add('WHERE C.ID = ' + edBH_Cliente.Text);
      FDQSelect.Active := True;
      if not FDQSelect.IsEmpty then
        FTaxaHoraria := FDQSelect.FieldByName('VALOR').AsFloat;

      FValorRecebido := edBH_ValorPago.TagFloat;
      // Calcule as horas trabalhadas
      FHorasTrabalhadas := FValorRecebido / FTaxaHoraria;

      // Converta para HH:MM:SS
      FHoras := Trunc(FHorasTrabalhadas);
      FMinutos := Trunc(Frac(FHorasTrabalhadas) * 60);
      FSegundos := Trunc((Frac(FHorasTrabalhadas) * 60 - FMinutos) * 60);
    {$EndRegion 'Calculando a quantidade de horas pagas'}

    FHorasCalculadas := '';
    FHorasCalculadas := FHoras.ToString + ':' + FMinutos.ToString + ':' + FSegundos.ToString;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbBH_TotalHoras.Text := FHoras.ToString + ':' + FMinutos.ToString + ':' + FSegundos.ToString + 'hr pagas';
    end);
    FreeAndNil(FDQSelect);
  end);

  t.OnTerminate := TThredEnd_CalcularHoras;
  t.Start;

end;

procedure TfrmMov_ServicosPrestados.CalendarDateSelected(Sender: TObject);
begin
  case FDataRetorno of
    0:edFIltro_Dt_I.Text := DateToStr(Calendar.Date);
    1:edFIltro_Dt_F.Text := DateToStr(Calendar.Date);
  end;

  rctCalendario_Tampa.Visible := False;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.TThredEnd_CalcularHoras(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Total horas pagas. ' + Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmMov_ServicosPrestados.ConfirmaPagamento(Sender: TObject);
var
  t :TThread;
begin

  TLoading.Show(frmMov_ServicosPrestados,'Realizando pagamentos');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FHor, FHor_Paga :Integer;
    FMin, FMin_Pago :Integer;
    FSeg, FSeg_Pago :Integer;

    FSegundos, FSegundosPagos, FSegRestantes :Integer;
  begin
    //Rotina para baixar Horas, gerar saldo restante de horas, baixar lançamentos e gerar saldo restando no lançamento.
    if Trim(FHorasCalculadas) = '' then
      raise Exception.Create('Não há valor informado');
    if FDQRegistros.IsEmpty then
      raise Exception.Create('Não há registros a serem baixados');

    FHor_Paga := 0;
    FMin_Pago := 0;
    FSeg_Pago := 0;
    FSegundosPagos := 0;
    if Length(FHorasCalculadas) = 8 then
    begin
      FHor_Paga := StrToIntDef(Copy(FHorasCalculadas,1,2),0);
      FMin_Pago := StrToIntDef(Copy(FHorasCalculadas,4,2),0);
      FSeg_Pago := StrToIntDef(Copy(FHorasCalculadas,7,2),0);
    end
    else
    begin
      FHor_Paga := StrToIntDef(Copy(FHorasCalculadas,1,3),0);
      FMin_Pago := StrToIntDef(Copy(FHorasCalculadas,5,2),0);
      FSeg_Pago := StrToIntDef(Copy(FHorasCalculadas,8,2),0);
    end;

    FSegundosPagos := (FHor_Paga * 3600) + (FMin_Pago * 60) + FSeg_Pago;

    Gerar_Novo_Lancamento(
      TFuncoes.PreencheVariavel(FHor_Paga.ToString,'0','E',2) + ':' +
      TFuncoes.PreencheVariavel(FMin_Pago.ToString,'0','E',2) + ':' +
      TFuncoes.PreencheVariavel(FSeg_Pago.ToString,'0','E',2)
      ,StrToDateDef(edBH_Data.Text, FDQRegistrosDATA.AsDateTime)
      ,FConta_HorasPagas
      ,FSegundosPagos
      ,edBH_ValorPago.TagFloat
      ,True);
  end);

  t.OnTerminate := TThreadEnd_ConfirmaPagamento;
  t.Start;
end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_ConfirmaPagamento(Sender :TOBject);
begin
  FDQRegistros.EnableControls;
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Total horas pagas. ' + Exception(TThread(Sender).FatalException).Message)
  else
  begin
    rctMenuBaixar_Horas.Visible := False;
  end;

  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.Baixar_Horas(AId:Integer;AData:TDate;AValor:Double);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('UPDATE SERVICOS_PRESTADOS SET ');
      FQuery.Sql.Add('  STATUS = 1 ');
      FQuery.Sql.Add('  ,DT_PAGO = :DT_PAGO ');
      FQuery.Sql.Add('  ,VLR_PAGO = :VLR_PAGO ');
      FQuery.Sql.Add('WHERE ID = :ID; ');
      FQuery.ParamByName('DT_PAGO').AsDate := AData;
      FQuery.ParamByName('VLR_PAGO').AsFloat := AValor;
      FQuery.ParamByName('ID').AsInteger := AId;
      FQuery.ExecSQL;
    except on E: Exception do
      raise Exception.Create('Baixa de Horas ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.Baixar_Lanc_Financeiro(AId:Integer;AData:TDate;AValor:Double);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('UPDATE LANCAMENTOS SET ');
      FQuery.Sql.Add('  STATUS = 1 ');
      FQuery.Sql.Add('  ,DT_BAIXA = :DT_BAIXA ');
      FQuery.Sql.Add('  ,HR_BAIXA = :HR_BAIXA ');
      FQuery.Sql.Add('  ,ID_USUARIO_BAIXA = :ID_USUARIO_BAIXA ');
      FQuery.Sql.Add('  ,VALOR_BAIXA = :VALOR_BAIXA ');
      FQuery.Sql.Add('WHERE ORIGEM_LANCAMENTO = :ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  AND ID_ORIGEM_LANCAMENTO = :ID_ORIGEM_LANCAMENTO ');
      FQuery.ParamByName('DT_BAIXA').AsDate := AData;
      FQuery.ParamByName('HR_BAIXA').AsTime := Time;
      FQuery.ParamByName('VALOR_BAIXA').AsFloat := AValor;
      FQuery.ParamByName('ID_USUARIO_BAIXA').AsInteger := frmPrincipal.FUser_Id;
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'SERVICOS_PRESTADOS';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := AId;
      FQuery.ExecSQL;
    except on E: Exception do
      raise Exception.Create('Baixa de Lançamentos ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.Gerar_Novo_Lancamento(
  AHoras:String;
  AData:TDate;
  AIDConta:Integer;
  FSegundos:Integer;
  AValor:Double;
  AContaPaga:Boolean=False);
var
  FQuery :TFDQuery;
  FValor :Double;
  FId :Integer;
  FHoras :TTime;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      FHoras := 0;
      //FHoras := StrToTime(AHoras);

      FId := 0;
      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('SELECT GEN_ID(GEN_SERVICOS_PRESTADOS_ID,1) AS SEQ FROM RDB$DATABASE;');
      FQuery.Active := True;
      if not FQuery.IsEmpty then
        FId := FQuery.FieldByName('SEQ').AsInteger;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('INSERT INTO SERVICOS_PRESTADOS( ');
      FQuery.Sql.Add('  ID ');
      FQuery.Sql.Add('  ,DESCRICAO ');
      FQuery.Sql.Add('  ,STATUS ');
      FQuery.Sql.Add('  ,ID_EMPRESA ');
      FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,ID_CLIENTE ');
      FQuery.Sql.Add('  ,ID_TABELA ');
      FQuery.Sql.Add('  ,ID_CONTA ');
      FQuery.Sql.Add('  ,DATA ');
      FQuery.Sql.Add('  ,HR_INICIO ');
      FQuery.Sql.Add('  ,HR_FIM ');
      FQuery.Sql.Add('  ,HR_TOTAL ');
      FQuery.Sql.Add('  ,VLR_HORA ');
      FQuery.Sql.Add('  ,SUB_TOTAL ');
      FQuery.Sql.Add('  ,DESCONTO ');
      FQuery.Sql.Add('  ,DESCONTO_MOTIVO ');
      FQuery.Sql.Add('  ,ACRESCIMO ');
      FQuery.Sql.Add('  ,ACRESCIMO_MOTIVO ');
      FQuery.Sql.Add('  ,TOTAL ');
      FQuery.Sql.Add('  ,OBSERVACAO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,ID_USUARIO ');
      if AContaPaga then
      begin
        FQuery.Sql.Add('  ,DT_PAGO ');
        FQuery.Sql.Add('  ,VLR_PAGO ');
      end;
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :ID ');
      FQuery.Sql.Add('  ,:DESCRICAO ');
      FQuery.Sql.Add('  ,:STATUS ');
      FQuery.Sql.Add('  ,:ID_EMPRESA ');
      FQuery.Sql.Add('  ,:ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,:ID_CLIENTE ');
      FQuery.Sql.Add('  ,:ID_TABELA ');
      FQuery.Sql.Add('  ,:ID_CONTA ');
      FQuery.Sql.Add('  ,:DATA ');
      FQuery.Sql.Add('  ,:HR_INICIO ');
      FQuery.Sql.Add('  ,:HR_FIM ');
      FQuery.Sql.Add('  ,:HR_TOTAL ');
      FQuery.Sql.Add('  ,:VLR_HORA ');
      FQuery.Sql.Add('  ,:SUB_TOTAL ');
      FQuery.Sql.Add('  ,:DESCONTO ');
      FQuery.Sql.Add('  ,:DESCONTO_MOTIVO ');
      FQuery.Sql.Add('  ,:ACRESCIMO ');
      FQuery.Sql.Add('  ,:ACRESCIMO_MOTIVO ');
      FQuery.Sql.Add('  ,:TOTAL ');
      FQuery.Sql.Add('  ,:OBSERVACAO ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('  ,:ID_USUARIO ');
      if AContaPaga then
      begin
        FQuery.Sql.Add('  ,:DT_PAGO ');
        FQuery.Sql.Add('  ,:VLR_PAGO ');
      end;
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
      FQuery.ParamByName('ID').AsInteger := FId;
      FQuery.ParamByName('DESCRICAO').AsString := FDQRegistrosDESCRICAO.AsString;
      FQuery.ParamByName('STATUS').AsInteger := 0;
      FQuery.ParamByName('ID_EMPRESA').AsInteger := FDQRegistrosID_EMPRESA.AsInteger;
      FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := FDQRegistrosID_PRESTADOR_SERVICO.AsInteger;
      FQuery.ParamByName('ID_CLIENTE').AsInteger := FDQRegistrosID_CLIENTE.AsInteger;
      FQuery.ParamByName('ID_TABELA').AsInteger := FDQRegistrosID_TABELA.AsInteger;
      FQuery.ParamByName('ID_CONTA').AsInteger := AIDConta;
      FQuery.ParamByName('DATA').AsDate := AData;// FDQRegistrosDATA.AsDateTime;
      FQuery.ParamByName('HR_INICIO').DataType := ftTime;//AsTime := StrToTimeDef('00:00:00',Time);
      FQuery.ParamByName('HR_INICIO').Clear;//AsTime := StrToTimeDef('00:00:00',Time);
      FQuery.ParamByName('HR_FIM').DataType := ftTime;//AsTime := StrToTimeDef('00:00:00',Time);
      FQuery.ParamByName('HR_FIM').Clear;//AsTime := StrToTimeDef('00:00:00',Time);
      FQuery.ParamByName('HR_TOTAL').AsString := AHoras;
      FQuery.ParamByName('VLR_HORA').AsFloat := FDQRegistrosVLR_HORA.AsFloat;
      FQuery.ParamByName('SUB_TOTAL').AsFloat := AValor;//(FSegundos * (FDQRegistrosVLR_HORA.AsFloat/3600));
      FQuery.ParamByName('DESCONTO').AsFloat := 0;
      FQuery.ParamByName('DESCONTO_MOTIVO').AsString := '';
      FQuery.ParamByName('ACRESCIMO').AsFloat := 0;
      FQuery.ParamByName('ACRESCIMO_MOTIVO').AsString := '';
      FQuery.ParamByName('TOTAL').AsFloat := AValor;//(FSegundos * (FDQRegistrosVLR_HORA.AsFloat/3600));
      FQuery.ParamByName('OBSERVACAO').AsString := 'SALDO DE HORAS PAGAS DURANTE O PERÍODO';
      if AContaPaga then
      begin
        FQuery.ParamByName('DT_PAGO').AsDate := AData;
        FQuery.ParamByName('VLR_PAGO').AsFloat := AValor;
        FQuery.ParamByName('STATUS').AsInteger := 1;
      end;
      FQuery.ExecSQL;

      Lancar_ContasReceber(
        FId
        ,FDQRegistrosID_EMPRESA.AsInteger
        ,AData
        ,FDQRegistrosID_CLIENTE.AsInteger
        ,FConta_HorasRecebidas
        ,FDQRegistrosDATA.AsDateTime
        ,AValor//(FSegundos * (FDQRegistrosVLR_HORA.AsFloat/3600))
        ,FId
        ,'SALDO DE HORAS PAGAS DURANTE O PEÍODO'
        ,AContaPaga);

      FDm_Global.FDC_Firebird.Commit;

    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Salvar: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    //Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.rctCancelarClick(Sender: TObject);
begin
  try
    try
      case TRectangle(Sender).Tag of
        0:Incluir;
        1:Editar;
        2:Salvar;
        3:Cancelar;
        4:FFancyDialog.Show(TIconDialog.Question,'Excluir','Deseja Excluir o registro selecionado?','Sim',Excluir,'Não') ;
        5:Menu(Sender);
        6:Imprimir_Relatorios;
      end;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
    end;
  finally
    Configura_Botoes;
  end;
end;

procedure TfrmMov_ServicosPrestados.rctImp_EditarClick(Sender: TObject);
begin
  try
    frxReport.LoadFromFile(System.SysUtils.GetCurrentDir + '\Relatorios\Horas_Trabalhadas.fr3');

    if TRectangle(Sender).Tag = 2 then
    begin
      frxReport.DesignReport;
    end
    else
    begin
      FDQRegistros.DisableControls;

      {$Region 'Configurando filtros do relatório'}
        FDm_Global.FDMT_Relatorios.Active := False;
        FDm_Global.FDMT_Relatorios.Active := True;
        FDm_Global.FDMT_Relatorios.Insert;
        FDm_Global.FDMT_RelatoriosDATA_I.AsString := edFIltro_Dt_I.Text;
        FDm_Global.FDMT_RelatoriosDATA_F.AsString := edFIltro_Dt_F.Text;
        FDm_Global.FDMT_RelatoriosEMPRESA_I.AsString := edFiltro_Empresa_ID.Text + '-' + edFiltro_Empresa.Text;
        FDm_Global.FDMT_RelatoriosPRESTADOR_I.AsString := edFiltro_Prestador_ID.Text + '-' + edFiltro_Prestador.Text;
        FDm_Global.FDMT_RelatoriosCLIENTE_I.AsString := edFiltro_Cliente_ID.Text + '-' + edFiltro_Cliente.Text;
        FDm_Global.FDMT_Relatorios.Post;

        frxDBD_Relaorio.DataSet := FDm_Global.FDMT_Relatorios;
      {$EndRegion 'Configurando filtros do relatório'}

      if not FDQRegistros.IsEmpty then
      begin

        if frxReport.PrepareReport then
        begin
          case TRectangle(Sender).Tag of
            0:frxReport.Print;
            1:frxReport.ShowPreparedReport;
            //2:frxReport.DesignReport;
          end;
        end;
      end;
      FDQRegistros.First;
      FDQRegistros.EnableControls;
    end;
  except on E: Exception do
    FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
  end;
end;

procedure TfrmMov_ServicosPrestados.Imprimir_Relatorios;
begin
  rctImprimir_Tampa.Visible := True;
end;

procedure TfrmMov_ServicosPrestados.rctMenu_BaixarHorasClick(Sender: TObject);
begin
  case TRectangle(Sender).Tag of
    0:BaixarHoras(Sender);
    1:FecharMes(Sender);
  end;
  rctMenu_Tampa.Visible := False;
end;

procedure TfrmMov_ServicosPrestados.rctMenu_FecharMes_CancelClick(Sender: TObject);
begin
  case TRectangle(Sender).Tag of
    0:CancelaFechamento(Sender);
    1:FFancyDialog.Show(TIconDialog.Question,'Pagamento','Confirma o Pagamento?','Sim',ConfirmaFechamento,'Não');
  end;
end;

procedure TfrmMov_ServicosPrestados.CancelaFechamento(Sender :TOBject);
begin
  rctMenu_FecharMes_Tampa.Visible := False;
end;

procedure TfrmMov_ServicosPrestados.ConfirmaFechamento(Sender :TOBject);
var
  t :TThread;
begin
  TLoading.Show(frmMov_ServicosPrestados,'Fechando o período');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FHor, FHor_Base :Integer;
    FMin, FMin_Base :Integer;
    FSeg, FSeg_Base :Integer;

    FSegundos :Integer;
    FSegundosBase :Integer;
    FSegRestantes :Integer;

    FValor :Double;

    FData_Lancto :TDate;
  begin

    if Trim(edMenu_FecharMes_DtLanc.Text) = '' then
      raise Exception.Create('É necessário informar a data do novo lançamento');
    if Trim(edMenu_FecharMes_Data.Text) = '' then
      raise Exception.Create('É necessário informar a data da baixa');
    if Trim(edMenu_FecharMes_Cliente.Text) = '' then
      raise Exception.Create('É necessário informar a cliente');

    FHor_Base := 0;
    FMin_Base := 0;
    FSeg_Base := 0;
    if Length(FHoraBase) = 8 then
    begin
      FHor_Base := StrToIntDef(Copy(FHoraBase,1,2),0);
      FMin_Base := StrToIntDef(Copy(FHoraBase,4,2),0);
      FSeg_Base := StrToIntDef(Copy(FHoraBase,7,2),0);
    end
    else
    begin
      FHor_Base := StrToIntDef(Copy(FHoraBase,1,3),0);
      FMin_Base := StrToIntDef(Copy(FHoraBase,5,2),0);
      FSeg_Base := StrToIntDef(Copy(FHoraBase,8,2),0);
    end;

    FSeg_Base := (FHor_Base * 3600) + (FMin_Base * 60) + FSeg_Base;

    if not FDQRegistros.IsEmpty then
    begin
      FDQRegistros.DisableControls;
      FDQRegistros.First;

      FSegRestantes := 0;
      while not FDQRegistros.Eof do
      begin
        if FDQRegistrosSTATUS.AsInteger = 0 then
        begin
          if Length(FDQRegistrosHR_TOTAL.AsString) = 8 then
          begin
            FHor := StrToIntDef(Copy(FDQRegistrosHR_TOTAL.AsString,1,2),0);
            FMin := StrToIntDef(Copy(FDQRegistrosHR_TOTAL.AsString,4,2),0);
            FSeg := StrToIntDef(Copy(FDQRegistrosHR_TOTAL.AsString,7,2),0);
          end
          else
          begin
            FHor := StrToIntDef(Copy(FDQRegistrosHR_TOTAL.AsString,1,3),0);
            FMin := StrToIntDef(Copy(FDQRegistrosHR_TOTAL.AsString,5,2),0);
            FSeg := StrToIntDef(Copy(FDQRegistrosHR_TOTAL.AsString,8,2),0);
          end;

          FSegundos := (FHor * 3600) + (FMin * 60) + FSeg;

          if FSeg_Base >= FSegundos then
          begin
            Baixar_Horas(FDQRegistrosID.AsInteger,StrToDate(edMenu_FecharMes_Data.Text),FDQRegistrosTOTAL.AsFloat);
            Baixar_Lanc_Financeiro(FDQRegistrosID.AsInteger,StrToDate(edMenu_FecharMes_Data.Text),FDQRegistrosTOTAL.AsFloat);
            FSeg_Base := (FSeg_Base - FSegundos);
          end
          else
          begin
            Baixar_Horas(FDQRegistrosID.AsInteger,StrToDate(edMenu_FecharMes_Data.Text),FDQRegistrosTOTAL.AsFloat);
            Baixar_Lanc_Financeiro(FDQRegistrosID.AsInteger,StrToDate(edMenu_FecharMes_Data.Text),FDQRegistrosTOTAL.AsFloat);

            //Deve continuar baixando e acumulando as horas para lançar no próximo mês.

            if FSeg_Base < FSegundos then
            begin
              if FSegRestantes = 0 then
                FSegRestantes := (FSegundos-FSeg_Base)
              else
                FSegRestantes := (FSegRestantes + FSegundos);
            end;
          end;
        end;
        FDQRegistros.Next;
      end;

      FHor := 0;
      FMin := 0;
      FSeg := 0;
      FHor := (FSegRestantes div 3600);
      FMin := (FSegRestantes mod 3600) div 60;
      FSeg := FSegRestantes mod 60;

      FValor := 0;
      FValor := (FSegRestantes * (FDQRegistrosVLR_HORA.AsFloat/3600));

      //sTexto, sPreencher, sPosicao: String; iQtd: Integer)
      Gerar_Novo_Lancamento(
        TFuncoes.PreencheVariavel(FHor.ToString,'0','E',2) + ':' +
        TFuncoes.PreencheVariavel(FMin.ToString,'0','E',2) + ':' +
        TFuncoes.PreencheVariavel(FSeg.ToString,'0','E',2)
        ,StrToDate(edMenu_FecharMes_DtLanc.Text)
        ,FConta_HorasExcedidas
        ,FSegRestantes
        ,FValor);
    end;
  end);

  t.OnTerminate := TThreadEnd_ConfirmaFechamento;
  t.Start;

end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_ConfirmaFechamento(Sender :TOBject);
begin
  TLoading.Hide;
  FDQRegistros.EnableControls;
  rctMenu_FecharMes_Tampa.Visible := False;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'',Exception(TThread(Sender).FatalException).Message)

end;

procedure TfrmMov_ServicosPrestados.BaixarHoras(Sender :TOBject);
begin
  rctMenuBaixar_Horas.Visible := True;
  if edBH_Cliente.CanFocus then
    edBH_Cliente.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.FecharMes(Sender :TOBject);
begin
  rctMenu_FecharMes_Tampa.Visible := True;
  if edMenu_FecharMes_Cliente.CanFocus then
    edMenu_FecharMes_Cliente.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Menu(Sender :TOBject);
begin
  rctMenu.Width := 0;
  rctMenu_Tampa.Align := TAlignLayout.Contents;
  rctMenu_Tampa.Visible := True;
  faMenu.StartValue := 0;
  faMenu.StopValue := 240;
  faMenu.Start;
end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_Menu(Sender :TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Calculando horas. ' + Exception(TThread(Sender).FatalException).Message)
  else
    faMenu.Enabled := False;
end;

procedure TfrmMov_ServicosPrestados.Salvar;
var
  FQuery :TFDQuery;
  FId :Integer;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      FId := 0;
      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('SELECT GEN_ID(GEN_SERVICOS_PRESTADOS_ID,1) AS SEQ FROM RDB$DATABASE;');
      FQuery.Active := True;
      if not FQuery.IsEmpty then
        FId := FQuery.FieldByName('SEQ').AsInteger;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      case FTab_Status of
        dsInsert :begin
          FQuery.Sql.Add('INSERT INTO SERVICOS_PRESTADOS( ');
          FQuery.Sql.Add('  ID ');
          FQuery.Sql.Add('  ,DESCRICAO ');
          FQuery.Sql.Add('  ,STATUS ');
          FQuery.Sql.Add('  ,ID_EMPRESA ');
          FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO ');
          FQuery.Sql.Add('  ,ID_CLIENTE ');
          FQuery.Sql.Add('  ,ID_TABELA ');    //
          FQuery.Sql.Add('  ,ID_CONTA ');
          FQuery.Sql.Add('  ,DATA ');
          FQuery.Sql.Add('  ,HR_INICIO ');
          FQuery.Sql.Add('  ,HR_FIM ');
          FQuery.Sql.Add('  ,HR_TOTAL ');
          FQuery.Sql.Add('  ,VLR_HORA ');
          FQuery.Sql.Add('  ,SUB_TOTAL ');
          FQuery.Sql.Add('  ,DESCONTO ');
          FQuery.Sql.Add('  ,DESCONTO_MOTIVO ');
          FQuery.Sql.Add('  ,ACRESCIMO ');
          FQuery.Sql.Add('  ,ACRESCIMO_MOTIVO ');
          FQuery.Sql.Add('  ,TOTAL ');
          FQuery.Sql.Add('  ,OBSERVACAO ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add('  ,ID_USUARIO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :ID ');
          FQuery.Sql.Add('  ,:DESCRICAO ');
          FQuery.Sql.Add('  ,:STATUS ');
          FQuery.Sql.Add('  ,:ID_EMPRESA ');
          FQuery.Sql.Add('  ,:ID_PRESTADOR_SERVICO ');
          FQuery.Sql.Add('  ,:ID_CLIENTE ');
          FQuery.Sql.Add('  ,:ID_TABELA ');
          FQuery.Sql.Add('  ,:ID_CONTA ');
          FQuery.Sql.Add('  ,:DATA ');
          FQuery.Sql.Add('  ,:HR_INICIO ');
          FQuery.Sql.Add('  ,:HR_FIM ');
          FQuery.Sql.Add('  ,:HR_TOTAL ');
          FQuery.Sql.Add('  ,:VLR_HORA ');
          FQuery.Sql.Add('  ,:SUB_TOTAL ');
          FQuery.Sql.Add('  ,:DESCONTO ');
          FQuery.Sql.Add('  ,:DESCONTO_MOTIVO ');
          FQuery.Sql.Add('  ,:ACRESCIMO ');
          FQuery.Sql.Add('  ,:ACRESCIMO_MOTIVO ');
          FQuery.Sql.Add('  ,:TOTAL ');
          FQuery.Sql.Add('  ,:OBSERVACAO ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('  ,:ID_USUARIO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
          FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
          FQuery.ParamByName('ID').AsInteger := FId;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE SERVICOS_PRESTADOS SET ');
          FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
          FQuery.Sql.Add('  ,STATUS = :STATUS ');
          FQuery.Sql.Add('  ,ID_EMPRESA = :ID_EMPRESA ');
          FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO ');
          FQuery.Sql.Add('  ,ID_CLIENTE = :ID_CLIENTE ');
          FQuery.Sql.Add('  ,ID_TABELA = :ID_TABELA ');
          FQuery.Sql.Add('  ,ID_CONTA = :ID_CONTA ');
          FQuery.Sql.Add('  ,DATA = :DATA ');
          FQuery.Sql.Add('  ,HR_INICIO = :HR_INICIO ');
          FQuery.Sql.Add('  ,HR_FIM = :HR_FIM ');
          FQuery.Sql.Add('  ,HR_TOTAL = :HR_TOTAL ');
          FQuery.Sql.Add('  ,VLR_HORA = :VLR_HORA ');
          FQuery.Sql.Add('  ,SUB_TOTAL = :SUB_TOTAL ');
          FQuery.Sql.Add('  ,DESCONTO = :DESCONTO ');
          FQuery.Sql.Add('  ,DESCONTO_MOTIVO = :DESCONTO_MOTIVO ');
          FQuery.Sql.Add('  ,ACRESCIMO = :ACRESCIMO ');
          FQuery.Sql.Add('  ,ACRESCIMO_MOTIVO = :ACRESCIMO_MOTIVO ');
          FQuery.Sql.Add('  ,TOTAL = :TOTAL ');
          FQuery.Sql.Add('  ,OBSERVACAO = :OBSERVACAO ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := StrToIntDef(edID.Text,0);
          FId := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
      FQuery.ParamByName('STATUS').AsInteger := edSTATUS.ItemIndex;
      FQuery.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edID_EMPRESA.Text,0);
      FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := StrToIntDef(edID_PRESTADOR_SERVICO.Text,0);
      FQuery.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edID_CLIENTE.Text,0);
      FQuery.ParamByName('ID_TABELA').AsInteger := StrToIntDef(edID_TABELA.Text,0);
      FQuery.ParamByName('ID_CONTA').AsInteger := StrToIntDef(edID_CONTA.Text,0);
      FQuery.ParamByName('DATA').AsDate := StrToDateDef(edDATA.Text,Date);
      if Trim(edHR_INICIO.Text) <> '' then
        FQuery.ParamByName('HR_INICIO').AsTime := StrToTimeDef(edHR_INICIO.Text,Time)
      else
        FQuery.ParamByName('HR_INICIO').AsTime := StrToTimeDef('00:00:00',Time);
      if Trim(edHR_FIM.Text) <> '' then
        FQuery.ParamByName('HR_FIM').AsTime := StrToTimeDef(edHR_FIM.Text,Time)
      else
        FQuery.ParamByName('HR_FIM').AsTime := StrToTimeDef('00:00:00',Time);
      FQuery.ParamByName('HR_TOTAL').AsString := edHR_TOTAL.Text;
      FQuery.ParamByName('VLR_HORA').AsFloat := edVLR_HORA.TagFloat;
      FQuery.ParamByName('SUB_TOTAL').AsFloat := edSUB_TOTAL.TagFloat;
      FQuery.ParamByName('DESCONTO').AsFloat := edDESCONTO.TagFloat;
      FQuery.ParamByName('DESCONTO_MOTIVO').AsString := '';
      FQuery.ParamByName('ACRESCIMO').AsFloat := edACRESCIMO.TagFloat;
      FQuery.ParamByName('ACRESCIMO_MOTIVO').AsString := '';
      FQuery.ParamByName('TOTAL').AsFloat := edTOTAL.TagFloat;
      FQuery.ParamByName('OBSERVACAO').AsString := edOBSERVACAO.Text;
      FQuery.ExecSQL;

      Lancar_ContasReceber(
        FId
        ,StrToIntDef(edID_EMPRESA.Text,0)
        ,StrToDateDef(edDATA.Text,Date)
        ,StrToIntDef(edID_CLIENTE.Text,0)
        ,StrToIntDef(edID_CONTA.Text,0)
        ,StrToDateDef(edDATA.Text,Date)
        ,edTOTAL.TagFloat
        ,FId
        ,edOBSERVACAO.Text);

      FDm_Global.FDC_Firebird.Commit;

    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Salvar: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.Lancar_ContasReceber(
  AId:Integer;
  AID_EMPRESA:Integer;
  ADT_EMISSAO:TDate;
  AID_PESSOA:Integer;
  AID_CONTA:Integer;
  AData:TDate;
  AVALOR:Double;
  AID_ORIGEM_LANCAMENTO:Integer;
  AOBSERVACAO:String;
  AContaPaga:Boolean=False);
var
  FQuery :TFDQuery;
  FData :TDate;
begin
  try
    try
      FData := TFuncoes.Datas(AData).UltimoDia;
      FData := TFuncoes.Datas(FData,0,5).Data_Add_Dia;

      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if FTab_Status = dsEdit then
      begin
        FQuery.Active := False;
        FQuery.Sql.Clear;
        FQuery.Sql.Add('DELETE FROM LANCAMENTOS ');
        FQuery.Sql.Add('WHERE ORIGEM_LANCAMENTO = :ORIGEM_LANCAMENTO ');
        FQuery.Sql.Add('  AND ID_ORIGEM_LANCAMENTO = :ID_ORIGEM_LANCAMENTO; ');
        FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'SERVICOS_PRESTADOS';
        FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := AId;
        FQuery.ExecSQL;
      end;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('INSERT INTO LANCAMENTOS( ');
      FQuery.Sql.Add('  ID_EMPRESA ');
      FQuery.Sql.Add('  ,DT_EMISSAO ');
      FQuery.Sql.Add('  ,ID_CONTA ');
      FQuery.Sql.Add('  ,ID_PESSOA ');
      FQuery.Sql.Add('  ,STATUS ');
      FQuery.Sql.Add('  ,FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,VALOR ');
      FQuery.Sql.Add('  ,ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,ID_ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,ID_USUARIO ');
      FQuery.Sql.Add('  ,OBSERVACAO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      if AContaPaga then
      begin
        FQuery.Sql.Add('  ,DT_BAIXA ');
        FQuery.Sql.Add('  ,HR_BAIXA ');
        FQuery.Sql.Add('  ,ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,JUROS_BAIXA ');
        FQuery.Sql.Add('  ,VALOR_BAIXA ');
      end;
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :ID_EMPRESA ');
      FQuery.Sql.Add('  ,:DT_EMISSAO ');
      FQuery.Sql.Add('  ,:ID_CONTA ');
      FQuery.Sql.Add('  ,:ID_PESSOA ');
      FQuery.Sql.Add('  ,:FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,:COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,:STATUS ');
      FQuery.Sql.Add('  ,:DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,:VALOR ');
      FQuery.Sql.Add('  ,:ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,:ID_ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,:ID_USUARIO ');
      FQuery.Sql.Add('  ,:OBSERVACAO ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      if AContaPaga then
      begin
        FQuery.Sql.Add('  ,:DT_BAIXA ');
        FQuery.Sql.Add('  ,:HR_BAIXA ');
        FQuery.Sql.Add('  ,:ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,:DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,:JUROS_BAIXA ');
        FQuery.Sql.Add('  ,:VALOR_BAIXA ');
      end;
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('ID_EMPRESA').AsInteger := AID_EMPRESA;//StrToIntDef(edID_EMPRESA.Text,0);
      FQuery.ParamByName('DT_EMISSAO').AsDate := ADT_EMISSAO;//StrToDateDef(edDATA.Text,Date);
      FQuery.ParamByName('ID_CONTA').AsInteger := AID_CONTA;
      FQuery.ParamByName('ID_PESSOA').AsInteger := AID_PESSOA;
      FQuery.ParamByName('STATUS').AsInteger := 0;  //0-Aberto, 1-pago
      FQuery.ParamByName('FORMA_PAGTO_ID').AsInteger := FFormaPagto_Id;  //0-Aberto, 1-pago
      FQuery.ParamByName('COND_PAGTO_ID').AsInteger := FCondPagto_Id;  //0-Aberto, 1-pago
      FQuery.ParamByName('DT_VENCIMENTO').AsDate := FData; //Calcular
      FQuery.ParamByName('VALOR').AsFloat := AVALOR;//edTOTAL.TagFloat;
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'SERVICOS_PRESTADOS';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := AId;
      FQuery.ParamByName('OBSERVACAO').AsString := AOBSERVACAO;//edOBSERVACAO.Text;
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
      if AContaPaga then
      begin
        FQuery.ParamByName('DT_BAIXA').AsDate := ADT_EMISSAO;
        FQuery.ParamByName('HR_BAIXA').AsTime := Time;
        FQuery.ParamByName('ID_USUARIO_BAIXA').AsInteger := frmPrincipal.FUser_Id;
        FQuery.ParamByName('DESCONTO_BAIXA').AsFloat := 0;
        FQuery.ParamByName('JUROS_BAIXA').AsFloat := 0;
        FQuery.ParamByName('VALOR_BAIXA').AsFloat := AVALOR;
        FQuery.ParamByName('STATUS').AsInteger := 1;  //0-Aberto, 1-pago
      end;
      FQuery.ExecSQL;

      {$Region 'ORIGEM_LANCAMENTO'}
        {
          PROPRIA
          SERVICOS_PRESTADOS
        }
      {$EndRegion 'ORIGEM_LANCAMENTO'}

    except on E: Exception do
      raise Exception.Create('Contas a Receber: ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.Selecionar_Registros;
var
  FDQ_Total :TFDQuery;
  FSegundos_C,FHor_C,FMin_C,FSeg_C :Integer;
  FSegundos_D,FHor_D,FMin_D,FSeg_D :Integer;
  FSegundos,FHor,FMin,FSeg :Integer;
begin
  try
    try
      FDQ_Total := TFDQuery.Create(Nil);
      FDQ_Total.Connection := FDm_Global.FDC_Firebird;

      lbTotal_Receber_Hora.Text := '000:00:00';
      lbTotal_Receber_Valor.Text := 'R$ 0,00';
      lbTotal_Recebido_Hora.Text := '000:00:00';
      lbTotal_Recebido_Valor.Text := 'R$ 0,00';
      lbTotalSaldo_Hora.Text := '000:00:00';
      lbTotalSaldo_Valor.Text := 'R$ 0,00';

      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  SP.* ');
      FDQRegistros.SQL.Add('  ,CASE SP.STATUS ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''ABERTO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''PAGO'' ');
      FDQRegistros.SQL.Add('  END STATUS_DESC ');
      FDQRegistros.SQL.Add('  ,E.NOME AS EMPRESA ');
      FDQRegistros.SQL.Add('  ,PS.NOME AS PRESTAOR_SERVICO ');
      FDQRegistros.SQL.Add('  ,C.NOME AS CLIENTE ');
      FDQRegistros.SQL.Add('  ,CT.DESCRICAO AS CONTA ');
      FDQRegistros.SQL.Add('  ,CT.TIPO ');
      FDQRegistros.SQL.Add('  ,CASE CT.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''CRÉDITO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''DÉBITO'' ');
      FDQRegistros.SQL.Add('   END TIPO_CONTA ');
      FDQRegistros.SQL.Add('  ,TP.DESCRICAO AS TABELA ');
      FDQRegistros.SQL.Add('  ,CASE TP.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''HORAS'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''FIXO'' ');
      FDQRegistros.SQL.Add('  END TABELA_TIPO ');
      FDQRegistros.SQL.Add('  ,TP.VALOR ');
      FDQRegistros.SQL.Add('  ,((CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
      FDQRegistros.SQL.Add('    WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 3) ');
      FDQRegistros.SQL.Add('    WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 2) ');
      FDQRegistros.SQL.Add('   END AS INTEGER) * 3600) ');
      FDQRegistros.SQL.Add('   + (CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
      FDQRegistros.SQL.Add('    WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 5 FOR 2) ');
      FDQRegistros.SQL.Add('    WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 4 FOR 2) ');
      FDQRegistros.SQL.Add('   END AS INTEGER) * 60) ');
      FDQRegistros.SQL.Add('   + CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
      FDQRegistros.SQL.Add('    WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 8 FOR 2) ');
      FDQRegistros.SQL.Add('    WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 7 FOR 2) ');
      FDQRegistros.SQL.Add('   END AS INTEGER)) AS SEGUNDOS ');
      FDQRegistros.SQL.Add('FROM SERVICOS_PRESTADOS SP ');
      FDQRegistros.SQL.Add('  JOIN EMPRESA E ON E.ID = SP.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  JOIN PRESTADOR_SERVICO PS ON PS.ID = SP.ID_PRESTADOR_SERVICO ');
      FDQRegistros.SQL.Add('  JOIN CLIENTE C ON C.ID = SP.ID_CLIENTE ');
      FDQRegistros.SQL.Add('  JOIN TABELA_PRECO TP ON TP.ID = SP.ID_TABELA ');
      FDQRegistros.SQL.Add('	JOIN CONTA CT ON CT.ID = SP.ID_CONTA ');
      FDQRegistros.SQL.Add('WHERE NOT SP.ID IS NULL ');
      FDQRegistros.SQL.Add('  AND SP.DATA BETWEEN :DATA_I AND :DATA_F');
      if Trim(edFiltro_Empresa_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND SP.ID_EMPRESA = :ID_EMPRESA');
        FDQRegistros.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
      end;
      if Trim(edFiltro_Prestador_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND SP.ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO');
        FDQRegistros.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := StrToIntDef(edFiltro_Prestador_ID.Text,0);
      end;
      if Trim(edFiltro_Cliente_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND SP.ID_CLIENTE = :ID_CLIENTE');
        FDQRegistros.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
      end;
      if ((imgFiltro_Credito.Tag = 1) and (imgFiltro_Debito.Tag = 0)) then
        FDQRegistros.SQL.Add('  AND CT.TIPO = 0')
      else if ((imgFiltro_Credito.Tag = 0) and (imgFiltro_Debito.Tag = 1)) then
        FDQRegistros.SQL.Add('  AND CT.TIPO = 1');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  E.NOME ');
      FDQRegistros.SQL.Add('  ,PS.NOME ');
      FDQRegistros.SQL.Add('  ,C.NOME ');
      FDQRegistros.SQL.Add('  ,CT.DESCRICAO ');
      FDQRegistros.SQL.Add('  ,SP.DATA ');
      FDQRegistros.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
      FDQRegistros.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
      FDQRegistros.Active := True;

      {$Region 'Totalizando'}
        FDQ_Total.Active := False;
        FDQ_Total.Sql.Clear;
        FDQ_Total.Sql.Add('SELECT ');
        FDQ_Total.Sql.Add('  D.TIPO ');
        FDQ_Total.Sql.Add('  ,CASE D.TIPO ');
        FDQ_Total.Sql.Add('    WHEN 0 THEN ''CRÉDITO'' ');
        FDQ_Total.Sql.Add('    WHEN 1 THEN ''DÉBITO'' ');
        FDQ_Total.Sql.Add('  END TIPO_CONTA ');
        FDQ_Total.Sql.Add('  ,LPAD(DATEDIFF(HOUR,CAST(CURRENT_DATE AS TIMESTAMP),D.DH),3,''0'') || '':'' || ');
        FDQ_Total.Sql.Add('   LPAD(EXTRACT(MINUTE FROM D.DH),2,''0'') || '':'' || ');
        FDQ_Total.Sql.Add('   LPAD(CAST(EXTRACT(SECOND FROM D.DH) AS INTEGER),2,''0'') AS HORA');
        FDQ_Total.Sql.Add('  ,D.TOTAL ');
        FDQ_Total.Sql.Add('FROM ( ');
        FDQ_Total.Sql.Add('  SELECT ');
        FDQ_Total.Sql.Add('    C.TIPO ');
        FDQ_Total.Sql.Add('    ,DATEADD(HOUR,C.HORA,C.DM) AS DH ');
        FDQ_Total.Sql.Add('    ,C.TOTAL ');
        FDQ_Total.Sql.Add('  FROM ( ');
        FDQ_Total.Sql.Add('    SELECT ');
        FDQ_Total.Sql.Add('      B.TIPO ');
        FDQ_Total.Sql.Add('      ,B.HORA ');
        FDQ_Total.Sql.Add('      ,DATEADD(MINUTE,B.MINUTO,B.DS) DM ');
        FDQ_Total.Sql.Add('      ,B.TOTAL ');
        FDQ_Total.Sql.Add('    FROM ( ');
        FDQ_Total.Sql.Add('      SELECT ');
        FDQ_Total.Sql.Add('        A.TIPO ');
        FDQ_Total.Sql.Add('        ,A.HORA ');
        FDQ_Total.Sql.Add('        ,A.MINUTO ');
        FDQ_Total.Sql.Add('        ,DATEADD(SECOND, A.SEGUNDO, CAST(CURRENT_DATE AS TIMESTAMP)) AS DS ');
        FDQ_Total.Sql.Add('        ,A.TOTAL ');
        FDQ_Total.Sql.Add('      FROM ( ');
        FDQ_Total.Sql.Add('        SELECT ');
        FDQ_Total.Sql.Add('	      	 C.TIPO ');
        FDQ_Total.Sql.Add('	      	 ,SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
        FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 2) ');
        FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 3) ');
        FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS HORA ');
        FDQ_Total.Sql.Add('	      	 ,SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
        FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 4 FOR 2) ');
        FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 5 FOR 2) ');
        FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS MINUTO ');
        FDQ_Total.Sql.Add('	      	 ,SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
        FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 7 FOR 2) ');
        FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 8 FOR 2) ');
        FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS SEGUNDO ');
        FDQ_Total.Sql.Add('          ,SUM(SP.TOTAL) AS TOTAL ');
        FDQ_Total.Sql.Add('        FROM SERVICOS_PRESTADOS SP ');
				FDQ_Total.Sql.Add('          JOIN CONTA C ON C.ID = SP.ID_CONTA ');
        FDQ_Total.SQL.Add('        WHERE NOT SP.ID IS NULL ');
        FDQ_Total.SQL.Add('          AND SP.DATA BETWEEN :DATA_I AND :DATA_F ');
        if Trim(edFiltro_Empresa_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('          AND SP.ID_EMPRESA = :ID_EMPRESA');
          FDQ_Total.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
        end;
        if Trim(edFiltro_Prestador_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('          AND SP.ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO');
          FDQ_Total.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := StrToIntDef(edFiltro_Prestador_ID.Text,0);
        end;
        if Trim(edFiltro_Cliente_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('          AND SP.ID_CLIENTE = :ID_CLIENTE');
          FDQ_Total.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
        end;
        FDQ_Total.SQL.Add('  GROUP BY 1) A) B) C) D; ');
        FDQ_Total.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
        FDQ_Total.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
        FDQ_Total.Active := True;
        if not FDQ_Total.IsEmpty then
        begin
          FDQ_Total.First;

          while not FDQ_Total.Eof do
          begin
            case FDQ_Total.FieldByName('TIPO').AsInteger of
              0:begin
                //Créditos
                lbTotal_Receber_Hora.Text := FDQ_Total.FieldByName('HORA').AsString;
                lbTotal_Receber_Valor.Text := FormatFloat('R$ #,##0.00',FDQ_Total.FieldByName('TOTAL').AsFloat);
                lbTotal_Receber_Valor.TagFloat := FDQ_Total.FieldByName('TOTAL').AsFloat;
              end;
              1:begin
                //Débitos
                lbTotal_Recebido_Hora.Text := FDQ_Total.FieldByName('HORA').AsString;
                lbTotal_Recebido_Valor.Text := FormatFloat('R$ #,##0.00',FDQ_Total.FieldByName('TOTAL').AsFloat);
                lbTotal_Recebido_Valor.TagFloat := FDQ_Total.FieldByName('TOTAL').AsFloat;
              end;
            end;
            FDQ_Total.Next;
          end;
        end;

        {$Region 'Calculando Saldo'}
          lbTotalSaldo_Valor.TagFloat := (lbTotal_Receber_Valor.TagFloat - lbTotal_Recebido_Valor.TagFloat);
          lbTotalSaldo_Valor.Text := FormatFloat('R$ #,##0.00',lbTotalSaldo_Valor.TagFloat);

          FHor_C := 0;
          FMin_C := 0;
          FSeg_C := 0;
          FHor_D := 0;
          FMin_D := 0;
          FSeg_D := 0;
          FSegundos_C := 0;
          FSegundos_D := 0;
          FSegundos := 0;

          case Length(lbTotal_Receber_Hora.Text) of
            8:begin
              FHor_C := StrToIntDef(Copy(lbTotal_Receber_Hora.Text,1,2),0);
              FMin_C := StrToIntDef(Copy(lbTotal_Receber_Hora.Text,4,2),0);
              FSeg_C := StrToIntDef(Copy(lbTotal_Receber_Hora.Text,7,2),0);
            end;
            9:begin
              FHor_C := StrToIntDef(Copy(lbTotal_Receber_Hora.Text,1,3),0);
              FMin_C := StrToIntDef(Copy(lbTotal_Receber_Hora.Text,5,2),0);
              FSeg_C := StrToIntDef(Copy(lbTotal_Receber_Hora.Text,8,2),0);
            end;
          end;
          FSegundos_C := ((FHor_C * 3600) + (FMin_C * 60) + FSeg_C);

          case Length(lbTotal_Recebido_Hora.Text) of
            8:begin
              FHor_D := StrToIntDef(Copy(lbTotal_Recebido_Hora.Text,1,2),0);
              FMin_D := StrToIntDef(Copy(lbTotal_Recebido_Hora.Text,4,2),0);
              FSeg_D := StrToIntDef(Copy(lbTotal_Recebido_Hora.Text,7,2),0);
            end;
            9:begin
              FHor_D := StrToIntDef(Copy(lbTotal_Recebido_Hora.Text,1,3),0);
              FMin_D := StrToIntDef(Copy(lbTotal_Recebido_Hora.Text,5,2),0);
              FSeg_D := StrToIntDef(Copy(lbTotal_Recebido_Hora.Text,8,2),0);
            end;
          end;
          FSegundos_D := ((FHor_D * 3600) + (FMin_D * 60) + FSeg_D);
          FSegundos := (FSegundos_C - FSegundos_D);
          FHor := (FSegundos div 3600);
          FMin := ((FSegundos mod 3600) div 60);
          FSeg := (FSegundos mod 60);
          lbTotalSaldo_Hora.Text := Format('%.3d:%.2d:%.2d',[FHor,FMin,FSeg]);

        {$EndRegion 'Calculando Saldo'}

      {$EndRegion 'Totalizando'}
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
    end;
  finally
    FreeAndNil(FDQ_Total);
  end;

end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_Selecionar_Registros(Sender :TOBject);
begin
  TLoading.Hide;
  Configura_Botoes;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)

end;

procedure TfrmMov_ServicosPrestados.Sel_Empresa(Aid:Integer; ANome:String);
begin
  edID_EMPRESA.Text := AId.ToString;
  edID_EMPRESA_Desc.Text := ANome;

  if edID_PRESTADOR_SERVICO.CanFocus then
    edID_PRESTADOR_SERVICO.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_Empresa_Filtro(Aid: Integer; ANome: String);
begin
  edFiltro_Empresa_ID.Text := AId.ToString;
  edFiltro_Empresa.Text := ANome;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
