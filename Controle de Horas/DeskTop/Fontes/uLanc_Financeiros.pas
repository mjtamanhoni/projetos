unit uLanc_Financeiros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects,
  FMX.dxGrid, FMX.Layouts, FMX.Ani, FMX.ListBox, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization,
  FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmLanc_Financeiros = class(TForm)
    OpenDialog: TOpenDialog;
    DSRegistros: TDataSource;
    FDQRegistros: TFDQuery;
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
    rctPagamento: TRectangle;
    imPagamento: TImage;
    rctTot_Receber: TRectangle;
    lbTot_Receber_Tit: TLabel;
    lbTot_Receber: TLabel;
    rctTot_Pagar: TRectangle;
    lbTot_Pagar_Tit: TLabel;
    lbTot_Pagar: TLabel;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    lytFiltro_Periodo: TLayout;
    rctFiltro_Periodo: TRectangle;
    lbFiltro_Periodo_Tit: TLabel;
    lbFiltro_Data_A: TLabel;
    edFIltro_Dt_I: TEdit;
    edFIltro_Dt_F: TEdit;
    lytFiltro_Empresa: TLayout;
    rctFiltro_Empresa: TRectangle;
    lytFiltro_Empresa_Tit: TLabel;
    edFiltro_Empresa_ID: TEdit;
    imgFiltro_Empresa: TImage;
    edFiltro_Empresa: TEdit;
    lytFiltro_Status: TLayout;
    rctFiltro_Prestador: TRectangle;
    lytFiltro_Cliente: TLayout;
    rctFiltro_Cliente: TRectangle;
    edFiltro_Cliente: TEdit;
    edFiltro_Cliente_ID: TEdit;
    imgFiltro_Cliente: TImage;
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
    edDATA: TEdit;
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    lytRow_003: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA_Desc: TEdit;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_004: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO_Desc: TEdit;
    edID_PRESTADOR_SERVICO: TEdit;
    imgID_PRESTADOR_SERVICO: TImage;
    lytRow_005: TLayout;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE_Desc: TEdit;
    edID_CLIENTE: TEdit;
    imgID_CLIENTE: TImage;
    lytRow_006: TLayout;
    lbID_TABELA: TLabel;
    edID_TABELA_Desc: TEdit;
    edID_TABELA: TEdit;
    imgID_TABELA: TImage;
    edID_TABELA_Valor: TEdit;
    edID_TABELA_Tipo: TEdit;
    lytRow_007: TLayout;
    lbHR_INICIO: TLabel;
    edHR_INICIO: TEdit;
    edHR_FIM: TEdit;
    lbHR_FIM: TLabel;
    edHR_TOTAL: TEdit;
    lbHR_TOTAL: TLabel;
    lbVLR_HORA: TLabel;
    edVLR_HORA: TEdit;
    lytRow_008: TLayout;
    lbSUB_TOTAL: TLabel;
    edSUB_TOTAL: TEdit;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lbACRESCIMO: TLabel;
    edACRESCIMO: TEdit;
    lbTOTAL: TLabel;
    edTOTAL: TEdit;
    lytRow_009: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_010: TLayout;
    lbDT_PAGO: TLabel;
    edDT_PAGO: TEdit;
    lbVLR_PAGO: TLabel;
    edVLR_PAGO: TEdit;
    rctMenu_Tampa: TRectangle;
    rctMenu: TRectangle;
    lytMenu_Titulo: TLayout;
    lbMenu_Titulo: TLabel;
    imgMenuFechar: TImage;
    faMenu: TFloatAnimation;
    rctMenu_BaixarHoras: TRectangle;
    lbMenu_BaixarHoras: TLabel;
    rctFecharMes: TRectangle;
    lbFecharMes: TLabel;
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
    rctBH_Confirmar: TRectangle;
    imgBH_Confirmar: TImage;
    rctBH_Cancelar: TRectangle;
    imgBH_Cancelar: TImage;
    lytBH_Cliente: TLayout;
    edBH_Cliente: TEdit;
    imgBH_Cliente: TImage;
    lbBH_Cliente: TLabel;
    rctTot_Saldo: TRectangle;
    lbTot_Saldo_Tit: TLabel;
    lbTot_Saldo: TLabel;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosID_EMPRESA: TIntegerField;
    FDQRegistrosDT_EMISSAO: TDateField;
    FDQRegistrosID_CONTA: TIntegerField;
    FDQRegistrosID_PESSOA: TIntegerField;
    FDQRegistrosSTATUS: TIntegerField;
    FDQRegistrosDT_VENCIMENTO: TDateField;
    FDQRegistrosVALOR: TFMTBCDField;
    FDQRegistrosDT_PAGAMENTO: TDateField;
    FDQRegistrosDESCONTO: TFMTBCDField;
    FDQRegistrosJUROS: TFMTBCDField;
    FDQRegistrosVALOR_PAGO: TFMTBCDField;
    FDQRegistrosORIGEM_LANCAMENTO: TStringField;
    FDQRegistrosID_ORIGEM_LANCAMENTO: TIntegerField;
    FDQRegistrosID_USUARIO: TIntegerField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosOBSERVACAO: TStringField;
    FDQRegistrosEMPRESA: TStringField;
    FDQRegistrosCONTA: TStringField;
    FDQRegistrosTIPO_CONTA: TIntegerField;
    FDQRegistrosTIPO_CONTA_DESC: TStringField;
    FDQRegistrosPESSOA: TStringField;
    FDQRegistrosSTATUS_DESC: TStringField;
    FDQRegistrosUSUARIO: TStringField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_EMISSAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_VENCIMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1JUROS: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR_PAGO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ORIGEM_LANCAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_ORIGEM_LANCAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_USUARIO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1OBSERVACAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_CONTA_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1USUARIO: TdxfmGridColumn;
    imgFiltro_Aberto: TImage;
    imgChecked: TImage;
    imgUnChecked: TImage;
    lbFiltro_Aberto: TLabel;
    imgFiltro_Pago: TImage;
    lbFIltro_Pago: TLabel;
    lytFiltro_Cliente_Label: TLayout;
    rbCliente: TRadioButton;
    rbFornecedor: TRadioButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLanc_Financeiros: TfrmLanc_Financeiros;

implementation

{$R *.fmx}

end.
