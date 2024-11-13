unit uLanc_Financeiros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

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


  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects,
  FMX.dxGrid, FMX.Layouts, FMX.Ani, FMX.ListBox, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization,
  FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Calendar, FMX.frxClass,
  FMX.frxDBSet;

type
  TTab_Status = (dsInsert,dsEdit);

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
    lytFiltro_TipoStatus: TLayout;
    rctFiltro_TipoStatus: TRectangle;
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
    lbID_EMPRESA: TLabel;
    edID_EMPRESA_Desc: TEdit;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_003: TLayout;
    lbID_CONTA: TLabel;
    edID_CONTA_Desc: TEdit;
    edID_CONTA: TEdit;
    imgID_CONTA: TImage;
    lytRow_004: TLayout;
    lbID_PESSOA: TLabel;
    edID_PESSOA_Desc: TEdit;
    edID_PESSOA: TEdit;
    imgID_PESSOA: TImage;
    lytRow_005: TLayout;
    lbVALOR: TLabel;
    edVALOR: TEdit;
    lytRow_007: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_006: TLayout;
    lbDT_PAGAMENTO: TLabel;
    edDT_PAGAMENTO: TEdit;
    lbVALOR_PAGO: TLabel;
    edVALOR_PAGO: TEdit;
    rctMenu_Tampa: TRectangle;
    rctMenu: TRectangle;
    lytMenu_Titulo: TLayout;
    lbMenu_Titulo: TLabel;
    imgMenuFechar: TImage;
    faMenu: TFloatAnimation;
    rctMenu_BaixarLancto: TRectangle;
    lbMenu_BaixarLancto: TLabel;
    rctFecharMes: TRectangle;
    lbFecharMes: TLabel;
    rctMenuBaixar_Lancto: TRectangle;
    rctBL_Detail: TRectangle;
    ShadowEffect1: TShadowEffect;
    rctBL_Header: TRectangle;
    lbBL_Titulo: TLabel;
    lytBL_ValorLancamento: TLayout;
    lytBL_Data: TLayout;
    edBL_Data: TEdit;
    lytBL_Footer: TLayout;
    gplBH_Footer: TGridPanelLayout;
    rctBH_Confirmar: TRectangle;
    imgBH_Confirmar: TImage;
    rctBH_Cancelar: TRectangle;
    imgBH_Cancelar: TImage;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_EMISSAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_VENCIMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
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
    lbFiltroPessoa: TLabel;
    cbFiltro_Tipo_Periodo: TComboBox;
    lbFiltro_Pago: TLabel;
    lbFiltro_TipoStatus: TLabel;
    lytFiltro_Tipo_DC: TLayout;
    rctFiltro_Tipo_DC: TRectangle;
    lbFIltro_Tipo_DC: TLabel;
    cbFiltro_Tipo_DC: TComboBox;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lbJUROS: TLabel;
    edJUROS: TEdit;
    lbDT_VENCIMENTO: TLabel;
    edDT_VENCIMENTO: TEdit;
    edConta_Tipo: TEdit;
    lbFORMA_CONDICAO_PAGAMENTO: TLabel;
    edFORMA_CONDICAO_PAGAMENTO: TEdit;
    imgFORMA_CONDICAO_PAGAMENTO: TImage;
    edID_FORMA_PAGAMENTO: TEdit;
    edCONDICAO_PAGAMENTO: TEdit;
    edID_CONDICAO_PAGAMENTO: TEdit;
    imgFIltro_Dt_I: TImage;
    imgFIltro_Dt_F: TImage;
    rctCalendario_Tampa: TRectangle;
    rctCalendario: TRectangle;
    ShadowEffect2: TShadowEffect;
    lytCalendario_Header: TLayout;
    lytCalendario_Detail: TLayout;
    Calendar: TCalendar;
    rctCalendario_Header: TRectangle;
    lbCalendario_Titulo: TLabel;
    imgCalendario_Cancelar: TImage;
    lytCalendario_Footer: TLayout;
    rctCalendario_Footer: TRectangle;
    rctCalendario_Detail: TRectangle;
    imgBL_Data: TImage;
    lbBL_Data: TLabel;
    lbBL_ValorLancamento_Tit: TLabel;
    lytBL_Desconto: TLayout;
    edBL_DescontoP: TEdit;
    lbBL_Desconto: TLabel;
    edBL_Desconto: TEdit;
    lbBL_ValorLancamento: TLabel;
    lytBL_Juros: TLayout;
    lbBL_Juros: TLabel;
    edBL_JurosP: TEdit;
    edBL_Juros: TEdit;
    lytBL_ValorBaixa: TLayout;
    lbBL_ValorBaixa: TLabel;
    edBL_ValorBaixa: TEdit;
    rctBL_Footer: TRectangle;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosID_EMPRESA: TIntegerField;
    FDQRegistrosDT_EMISSAO: TDateField;
    FDQRegistrosID_CONTA: TIntegerField;
    FDQRegistrosID_PESSOA: TIntegerField;
    FDQRegistrosSTATUS: TIntegerField;
    FDQRegistrosFORMA_PAGTO_ID: TIntegerField;
    FDQRegistrosCOND_PAGTO_ID: TIntegerField;
    FDQRegistrosDT_VENCIMENTO: TDateField;
    FDQRegistrosVALOR: TFMTBCDField;
    FDQRegistrosORIGEM_LANCAMENTO: TStringField;
    FDQRegistrosID_ORIGEM_LANCAMENTO: TIntegerField;
    FDQRegistrosDT_BAIXA: TDateField;
    FDQRegistrosHR_BAIXA: TTimeField;
    FDQRegistrosID_USUARIO_BAIXA: TIntegerField;
    FDQRegistrosDESCONTO_BAIXA: TFMTBCDField;
    FDQRegistrosJUROS_BAIXA: TFMTBCDField;
    FDQRegistrosVALOR_BAIXA: TFMTBCDField;
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
    rctPrinter: TRectangle;
    imgPrinter: TImage;
    frxReport: TfrxReport;
    frxDBD_Registros: TfrxDBDataset;
    dxfmGrid1RootLevel1FORMA_PAGTO_ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1COND_PAGTO_ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_BAIXA: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_BAIXA: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_USUARIO_BAIXA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO_BAIXA: TdxfmGridColumn;
    dxfmGrid1RootLevel1JUROS_BAIXA: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR_BAIXA: TdxfmGridColumn;
    rctTotais: TRectangle;
    gplTotais: TGridPanelLayout;
    rctTotais_Credito: TRectangle;
    lytTotais_Credito_Tit: TLayout;
    lbTotais_Credito_Tit: TLabel;
    rctTotal_Debito: TRectangle;
    lytTotal_Debito_Tit: TLayout;
    lbTotal_Debito_Tit: TLabel;
    rctTotal_Saldo: TRectangle;
    lytTotal_Saldo_Tit: TLayout;
    lbTotal_Saldo_Tit: TLabel;
    gplTotais_Credito: TGridPanelLayout;
    gplTotal_Debito: TGridPanelLayout;
    gplTotal_Saldo: TGridPanelLayout;
    lbTotais_Credito_A_Tit: TLabel;
    lbTotal_Debito_A_Tit: TLabel;
    lbTotais_Credito_P_Tit: TLabel;
    lbTotais_Credito_S_Tit: TLabel;
    lbTotais_Credito_A: TLabel;
    lbTotais_Credito_P: TLabel;
    lbTotais_Credito_S: TLabel;
    lbTotal_Debito_P_Tit: TLabel;
    lbTotal_Debito_S_Tit: TLabel;
    lbTotal_Debito_A: TLabel;
    lbTotal_Debito_P: TLabel;
    lbTotal_Debito_S: TLabel;
    rctTotais_Creditos_Tit: TRectangle;
    rctTotal_Debito_Tit: TRectangle;
    rctTotal_Saldo_Tit: TRectangle;
    rctImprimir_Tampa: TRectangle;
    rctImprimir: TRectangle;
    ShadowEffect6: TShadowEffect;
    rctImp_Header: TRectangle;
    lbImp_Titulo: TLabel;
    imgImp_Fechar: TImage;
    lytImp_NomeRel: TLayout;
    lbImp_NomeRel: TLabel;
    lytImp_Opcoes: TLayout;
    gplImpressao: TGridPanelLayout;
    rctImp_Imprimir: TRectangle;
    imgImp_Imprimir: TImage;
    rctImp_Visualizar: TRectangle;
    imgImp_Visualizar: TImage;
    rctImp_Editar: TRectangle;
    imgImp_Editar: TImage;
    lytImp_Relacao: TLayout;
    lbImp_Relacao: TLabel;
    cmbImp_Relacao: TComboBox;
    frxDBD_Relaorio: TfrxDBDataset;
    lbTotal_Saldo_A: TLabel;
    lbTotalSaldo_Saldo: TLabel;
    lbTotalSaldo_Saldo_Tit: TLabel;
    lbTotalSaldo_Total_Tit: TLabel;
    procedure imgFiltro_ClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edFiltro_Cliente_IDChange(Sender: TObject);
    procedure imgFiltro_AbertoClick(Sender: TObject);
    procedure imgFiltro_PagoClick(Sender: TObject);
    procedure imgFiltro_EmpresaClick(Sender: TObject);
    procedure cbFiltro_Tipo_DCChange(Sender: TObject);
    procedure cbFiltro_Tipo_PeriodoChange(Sender: TObject);
    procedure edFIltro_Dt_IChange(Sender: TObject);
    procedure edFIltro_Dt_FChange(Sender: TObject);
    procedure edFiltro_Empresa_IDChange(Sender: TObject);
    procedure edFIltro_Dt_ITyping(Sender: TObject);
    procedure edFIltro_Dt_FTyping(Sender: TObject);
    procedure cbFiltro_Tipo_DCKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure cbFiltro_Tipo_PeriodoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltro_Empresa_IDExit(Sender: TObject);
    procedure edFiltro_Cliente_IDExit(Sender: TObject);
    procedure edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure rctCancelarClick(Sender: TObject);
    procedure edDATATyping(Sender: TObject);
    procedure edDT_VENCIMENTOTyping(Sender: TObject);
    procedure edDT_PAGAMENTOTyping(Sender: TObject);
    procedure edVALORTyping(Sender: TObject);
    procedure edVALORChange(Sender: TObject);
    procedure edDESCONTOChange(Sender: TObject);
    procedure edJUROSChange(Sender: TObject);
    procedure imgID_EMPRESAClick(Sender: TObject);
    procedure edID_EMPRESAExit(Sender: TObject);
    procedure imgID_PESSOAClick(Sender: TObject);
    procedure imgID_CONTAClick(Sender: TObject);
    procedure edID_PESSOAExit(Sender: TObject);
    procedure edID_CONTAExit(Sender: TObject);
    procedure edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSTATUSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_PESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDT_VENCIMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDT_PAGAMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edJUROSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edVALOR_PAGOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTOTyping(Sender: TObject);
    procedure edJUROSTyping(Sender: TObject);
    procedure edVALOR_PAGOTyping(Sender: TObject);
    procedure edVALOR_PAGOChange(Sender: TObject);
    procedure edFORMA_CONDICAO_PAGAMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgFORMA_CONDICAO_PAGAMENTOClick(Sender: TObject);
    procedure imgFIltro_Dt_IClick(Sender: TObject);
    procedure imgCalendario_CancelarClick(Sender: TObject);
    procedure CalendarDateSelected(Sender: TObject);
    procedure imgMenuFecharClick(Sender: TObject);
    procedure rctFecharMesClick(Sender: TObject);
    procedure rctMenu_BaixarLanctoClick(Sender: TObject);
    procedure edBL_DataTyping(Sender: TObject);
    procedure edBL_DataKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBL_DescontoPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBL_DescontoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBL_JurosPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBL_JurosKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBL_DescontoPTyping(Sender: TObject);
    procedure edBL_JurosPTyping(Sender: TObject);
    procedure edBL_DescontoTyping(Sender: TObject);
    procedure edBL_JurosTyping(Sender: TObject);
    procedure edBL_ValorBaixaTyping(Sender: TObject);
    procedure rctBH_CancelarClick(Sender: TObject);
    procedure rctBH_ConfirmarClick(Sender: TObject);
    procedure edBL_DescontoPChange(Sender: TObject);
    procedure edBL_DescontoPEnter(Sender: TObject);
    procedure edBL_DescontoPExit(Sender: TObject);
    procedure edBL_DescontoEnter(Sender: TObject);
    procedure edBL_DescontoExit(Sender: TObject);
    procedure edBL_JurosPExit(Sender: TObject);
    procedure edBL_JurosPEnter(Sender: TObject);
    procedure edBL_JurosEnter(Sender: TObject);
    procedure edBL_JurosExit(Sender: TObject);
    procedure edBL_ValorBaixaExit(Sender: TObject);
    procedure edBL_ValorBaixaEnter(Sender: TObject);
    procedure edBL_DescontoChange(Sender: TObject);
    procedure edBL_JurosPChange(Sender: TObject);
    procedure edBL_JurosChange(Sender: TObject);
    procedure rctImp_EditarClick(Sender: TObject);
    procedure imgImp_FecharClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    FDataRetorno :Integer;

    FHabilita_Desc_P :Boolean;
    FHabilita_Desc_V :Boolean;
    FHabilita_Acre_P :Boolean;
    FHabilita_Acre_V :Boolean;
    FHabilita_Total :Boolean;

    procedure Sel_Pessoa(ATipo:String; Aid:Integer; ANome:String; ADocumento:String);
    procedure Sel_Empresa(Aid: Integer; ANome: String);
    procedure Sel_FormaCondicao(AId,AId_Forma,AId_Condicao:Integer; ADesc_Forma,ADesc_Condicao:String);
    procedure Configura_Botoes;
    procedure Selecionar_Registros;

    procedure Cancelar;
    procedure Editar(Sender :TObject);
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Menu(Sender: TOBject);
    procedure Sel_Conta(Aid: Integer; ADescricao: String; ATipo: Integer);
    procedure Limpar_Campos;
    procedure Editando_Lancamento(Sender :TOBject);
    procedure Baixar_Lancamento(Sender: TOBject);
    procedure TThreadEnd_Baixar_Lancamento(Sender: TOBject);
    procedure Calcula_Totais(ATag:Integer);
    procedure TThreadEnd_Calcula_Totais(Sender: TObject);
    procedure Imprimir_Relatorios;
  end;

var
  frmLanc_Financeiros: TfrmLanc_Financeiros;

implementation

{$R *.fmx}

uses
  uPesq_Pessoas
  ,uCad.Cliente
  ,uCad.Empresa
  ,uCad.Contas
  ,uPesq_FormaCond_Pagto;

procedure TfrmLanc_Financeiros.edBL_DataKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBL_DescontoP.SetFocus;
end;

procedure TfrmLanc_Financeiros.edBL_DataTyping(Sender: TObject);
begin
  Formatar(edBL_Data,Dt);
end;

procedure TfrmLanc_Financeiros.edBL_DescontoChange(Sender: TObject);
var
  t :TThread;
begin

  if not FHabilita_Desc_V then
    Exit;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FValor_Lanc :Double;
    FDesc_P :Double;
    FDesc_V :Double;
    FAcre_V :Double;
  begin
    FValor_Lanc := 0;
    FDesc_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FValor_Lanc := lbBL_ValorLancamento.TagFloat;

    FDesc_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FDesc_V := StrToFloatDef(Trim(StringReplace(edBL_Desconto.Text,'R$','',[rfReplaceAll])),0);
    FAcre_V := StrToFloatDef(Trim(StringReplace(edBL_Juros.Text,'R$','',[rfReplaceAll])),0);

    FDesc_P := ((FDesc_V * 100) / FValor_Lanc);
    edBL_DescontoP.TagFloat := FDesc_P;
    edBL_ValorBaixa.TagFloat := ((FValor_Lanc + FAcre_V) - FDesc_V);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      edBL_DescontoP.Text := FormatFloat('#,##0.00%', FDesc_P);
      edBL_ValorBaixa.Text := FormatFloat('R$ #,##0.00', edBL_ValorBaixa.TagFloat);
    end);
  end);

  t.OnTerminate := TThreadEnd_Calcula_Totais;
  t.Start;
end;

procedure TfrmLanc_Financeiros.edBL_DescontoEnter(Sender: TObject);
begin
  FHabilita_Desc_V := True;
end;

procedure TfrmLanc_Financeiros.edBL_DescontoExit(Sender: TObject);
begin
  FHabilita_Desc_V := False;
end;

procedure TfrmLanc_Financeiros.edBL_DescontoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBL_JurosP.SetFocus;

end;

procedure TfrmLanc_Financeiros.Calcula_Totais(ATag:Integer);
var
  t :TThread;
begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FValor_Lanc :Double;
    FDesc_P :Double;
    FDesc_V :Double;
    FAcre_P :Double;
    FAcre_V :Double;
    FTotal :Double;

  begin
    FValor_Lanc := 0;
    FDesc_P := 0;
    FDesc_V := 0;
    FAcre_P := 0;
    FAcre_V := 0;
    FTotal := 0;

    lbBL_ValorLancamento.TagFloat := StrToFloatDef(Trim(StringReplace(lbBL_ValorLancamento.Text,'R$','',[rfReplaceAll])),0);
    edBL_DescontoP.TagFloat := StrToFloatDef(Trim(StringReplace(edBL_DescontoP.Text,'%','',[rfReplaceAll])),0);
    edBL_Desconto.TagFloat := StrToFloatDef(Trim(StringReplace(edBL_Desconto.Text,'R$','',[rfReplaceAll])),0);
    edBL_JurosP.TagFloat := StrToFloatDef(Trim(StringReplace(edBL_JurosP.Text,'%','',[rfReplaceAll])),0);
    edBL_Juros.TagFloat := StrToFloatDef(Trim(StringReplace(edBL_Juros.Text,'R$','',[rfReplaceAll])),0);
    edBL_ValorBaixa.TagFloat := StrToFloatDef(Trim(StringReplace(edBL_ValorBaixa.Text,'R$','',[rfReplaceAll])),0);

    FValor_Lanc := lbBL_ValorLancamento.TagFloat;
    FDesc_P := edBL_DescontoP.TagFloat;
    FDesc_V := edBL_Desconto.TagFloat;
    FAcre_P := edBL_JurosP.TagFloat;
    FAcre_V := edBL_Juros.TagFloat;
    FTotal := edBL_ValorBaixa.TagFloat;

    if edBL_DescontoP.TagFloat = 0 then
      edBL_DescontoP.Text := '';
    if edBL_Desconto.TagFloat = 0 then
      edBL_Desconto.Text := '';
    if edBL_JurosP.TagFloat = 0 then
      edBL_JurosP.Text := '';
    if edBL_Juros.TagFloat = 0 then
      edBL_Juros.Text := '';


    case ATag of
      0:begin
        //Percentual de Desconto
        FDesc_V := (FValor_Lanc * (FDesc_P / 100));
        edBL_Desconto.TagFloat := FDesc_V;
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          edBL_Desconto.Text := FormatFloat('R$ #,##0.00', FDesc_V);
        end);
      end;
      1:begin
        //Valor do Desconto
        FDesc_P := ((FDesc_V * 100) / FValor_Lanc);
        edBL_DescontoP.TagFloat := FDesc_P;
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          edBL_DescontoP.Text := FormatFloat('#,##0.00%',FDesc_P);
        end);
      end;
      2:begin
        //Percentual do Acrescimo
        FAcre_V := (FValor_Lanc * (FAcre_P / 100));
        edBL_Juros.TagFloat := FAcre_V;
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          edBL_Juros.Text := FormatFloat('R$ #,##0.00', FAcre_V);
        end);
      end;
      3:begin
        //Valor do Acrescimo
        FAcre_P := ((FAcre_V * 100) / FValor_Lanc);
        edBL_JurosP.TagFloat := FAcre_P;
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          edBL_JurosP.Text := FormatFloat('#,##0.00%',FAcre_P);
        end);
      end;
      4:begin
        //Valor total
        if FTotal > FValor_Lanc then
        begin
          //Calcula acrescimo
          edBL_Juros.TagFloat := (FTotal - FValor_Lanc);
          TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            edBL_Juros.Text := FormatFloat('R$ #,##0.00', edBL_Juros.TagFloat);
          end);
          FAcre_P := ((edBL_Juros.TagFloat * 100) / FValor_Lanc);
          edBL_JurosP.TagFloat := FAcre_P;
          TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            edBL_JurosP.Text := FormatFloat('#,##0.00%',FAcre_P);
          end);
        end
        else if FTotal < FValor_Lanc then
        begin
          //Calcula desconto
          edBL_Desconto.TagFloat := (FValor_Lanc - FTotal);
          TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            edBL_Desconto.Text := FormatFloat('R$ #,##0.00', edBL_Desconto.TagFloat);
          end);
          FDesc_P := ((FDesc_V * 100) / edBL_Desconto.TagFloat);
          edBL_DescontoP.TagFloat := FDesc_P;
          TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            edBL_DescontoP.Text := FormatFloat('#,##0.00%',FDesc_P);
          end);
        end;
      end;
    end;
  end);

  t.OnTerminate := TThreadEnd_Calcula_Totais;
  t.Start;

end;

procedure TfrmLanc_Financeiros.TThreadEnd_Calcula_Totais(Sender :TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Calculo',Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmLanc_Financeiros.edBL_DescontoPChange(Sender: TObject);
var
  t :TThread;
begin

  if not FHabilita_Desc_P then
    Exit;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FValor_Lanc :Double;
    FDesc_P :Double;
    FDesc_V :Double;
    FAcre_V :Double;
  begin
    FValor_Lanc := 0;
    FDesc_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FValor_Lanc := lbBL_ValorLancamento.TagFloat;

    FDesc_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FDesc_P := StrToFloatDef(Trim(StringReplace(edBL_DescontoP.Text,'%','',[rfReplaceAll])),0);
    FAcre_V := StrToFloatDef(Trim(StringReplace(edBL_Juros.Text,'R$','',[rfReplaceAll])),0);

    FDesc_V := (FValor_Lanc * (FDesc_P / 100));
    edBL_Desconto.TagFloat := FDesc_V;
    edBL_ValorBaixa.TagFloat := ((FValor_Lanc + FAcre_V) - FDesc_V);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      edBL_Desconto.Text := FormatFloat('R$ #,##0.00', FDesc_V);
      edBL_ValorBaixa.Text := FormatFloat('R$ #,##0.00', edBL_ValorBaixa.TagFloat);
    end);
  end);

  t.OnTerminate := TThreadEnd_Calcula_Totais;
  t.Start;

end;


procedure TfrmLanc_Financeiros.edBL_DescontoPEnter(Sender: TObject);
begin
  FHabilita_Desc_P := True;
end;

procedure TfrmLanc_Financeiros.edBL_DescontoPExit(Sender: TObject);
begin
  FHabilita_Desc_P := False;
end;

procedure TfrmLanc_Financeiros.edBL_DescontoPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBL_Desconto.SetFocus;

end;

procedure TfrmLanc_Financeiros.edBL_DescontoPTyping(Sender: TObject);
begin
  Formatar(edBL_DescontoP,Percentual);
end;

procedure TfrmLanc_Financeiros.edBL_DescontoTyping(Sender: TObject);
begin
  Formatar(edBL_Desconto,Money);
end;

procedure TfrmLanc_Financeiros.edBL_JurosChange(Sender: TObject);
var
  t :TThread;
begin

  if not FHabilita_Acre_V then
    Exit;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FValor_Lanc :Double;
    FAcre_P :Double;
    FDesc_V :Double;
    FAcre_V :Double;
  begin
    FValor_Lanc := 0;
    FAcre_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FValor_Lanc := lbBL_ValorLancamento.TagFloat;

    FAcre_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FDesc_V := StrToFloatDef(Trim(StringReplace(edBL_Desconto.Text,'R$','',[rfReplaceAll])),0);
    FAcre_V := StrToFloatDef(Trim(StringReplace(edBL_Juros.Text,'R$','',[rfReplaceAll])),0);

    FAcre_P := ((FAcre_V * 100) / FValor_Lanc);
    edBL_JurosP.TagFloat := FAcre_P;
    edBL_ValorBaixa.TagFloat := ((FValor_Lanc + FAcre_V) - FDesc_V);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      edBL_JurosP.Text := FormatFloat('#,##0.00%', FAcre_P);
      edBL_ValorBaixa.Text := FormatFloat('R$ #,##0.00', edBL_ValorBaixa.TagFloat);
    end);
  end);

  t.OnTerminate := TThreadEnd_Calcula_Totais;
  t.Start;
end;

procedure TfrmLanc_Financeiros.edBL_JurosEnter(Sender: TObject);
begin
  FHabilita_Acre_V := True;
end;

procedure TfrmLanc_Financeiros.edBL_JurosExit(Sender: TObject);
begin
  FHabilita_Acre_V := False;
end;

procedure TfrmLanc_Financeiros.edBL_JurosKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBL_ValorBaixa.SetFocus;

end;

procedure TfrmLanc_Financeiros.edBL_JurosPChange(Sender: TObject);
var
  t :TThread;
begin

  if not FHabilita_Acre_P then
    Exit;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FValor_Lanc :Double;
    FAcre_P :Double;
    FDesc_V :Double;
    FAcre_V :Double;
  begin
    FValor_Lanc := 0;
    FAcre_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FValor_Lanc := lbBL_ValorLancamento.TagFloat;

    FAcre_P := 0;
    FDesc_V := 0;
    FAcre_V := 0;

    FAcre_P := StrToFloatDef(Trim(StringReplace(edBL_JurosP.Text,'%','',[rfReplaceAll])),0);
    FDesc_V := StrToFloatDef(Trim(StringReplace(edBL_Desconto.Text,'R$','',[rfReplaceAll])),0);

    FAcre_V := (FValor_Lanc * (FAcre_P / 100));
    edBL_Juros.TagFloat := FAcre_V;
    edBL_ValorBaixa.TagFloat := ((FValor_Lanc + FAcre_V) - FDesc_V);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      edBL_Juros.Text := FormatFloat('R$ #,##0.00', FAcre_V);
      edBL_ValorBaixa.Text := FormatFloat('R$ #,##0.00', edBL_ValorBaixa.TagFloat);
    end);
  end);

  t.OnTerminate := TThreadEnd_Calcula_Totais;
  t.Start;
end;

procedure TfrmLanc_Financeiros.edBL_JurosPEnter(Sender: TObject);
begin
  FHabilita_Acre_P := True;
end;

procedure TfrmLanc_Financeiros.edBL_JurosPExit(Sender: TObject);
begin
  FHabilita_Acre_P := False;
end;

procedure TfrmLanc_Financeiros.edBL_JurosPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBL_Juros.SetFocus;

end;

procedure TfrmLanc_Financeiros.edBL_JurosPTyping(Sender: TObject);
begin
  Formatar(edBL_JurosP,Percentual);
end;

procedure TfrmLanc_Financeiros.edBL_JurosTyping(Sender: TObject);
begin
  Formatar(edBL_Juros,Money);
end;

procedure TfrmLanc_Financeiros.edBL_ValorBaixaEnter(Sender: TObject);
begin
  FHabilita_Total := True;
end;

procedure TfrmLanc_Financeiros.edBL_ValorBaixaExit(Sender: TObject);
begin
  FHabilita_Total := False;
end;

procedure TfrmLanc_Financeiros.edBL_ValorBaixaTyping(Sender: TObject);
begin
  Formatar(edBL_ValorBaixa,Money);
end;

procedure TfrmLanc_Financeiros.edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_EMPRESA.SetFocus;
end;

procedure TfrmLanc_Financeiros.edDATATyping(Sender: TObject);
begin
  Formatar(edDATA,Dt);
end;

procedure TfrmLanc_Financeiros.edDESCONTOChange(Sender: TObject);
begin
  edDESCONTO.TagFloat := StrToFloatDef(Trim(StringReplace(StringReplace(edDESCONTO.Text,'R$','',[rfReplaceAll]),'.','',[rfReplaceAll])),0);
end;

procedure TfrmLanc_Financeiros.edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edJUROS.SetFocus;

end;

procedure TfrmLanc_Financeiros.edDESCONTOTyping(Sender: TObject);
begin
  Formatar(edDESCONTO,Money);
end;

procedure TfrmLanc_Financeiros.edDT_PAGAMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCONTO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edDT_PAGAMENTOTyping(Sender: TObject);
begin
  Formatar(edDT_PAGAMENTO,Dt);
end;

procedure TfrmLanc_Financeiros.edDT_VENCIMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR.SetFocus;

end;

procedure TfrmLanc_Financeiros.edDT_VENCIMENTOTyping(Sender: TObject);
begin
  Formatar(edDT_VENCIMENTO,Dt);
end;

procedure TfrmLanc_Financeiros.edFiltro_Cliente_IDChange(Sender: TObject);
begin
  if Trim(edFiltro_Cliente_ID.Text) = '' then
  begin
    edFiltro_Cliente.Text := '';
    lbFiltroPessoa.Tag := -1;
    lbFiltroPessoa.Text := 'Pessoa';
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFiltro_Cliente_IDExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      edFiltro_Cliente.Text := '';

      if Trim(edFiltro_Cliente_ID.Text) = '' then
        Exit;

      
      case cbFiltro_Tipo_DC.ItemIndex of
        1:FDm_Global.Listar_Cliente(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);
        2:FDm_Global.Listar_Fornecedor(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);
      end;

      if not FQuery.IsEmpty then
        edFiltro_Cliente.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    cbFiltro_Tipo_DC.SetFocus;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_FChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFiltro_Empresa_ID.SetFocus;

end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_FTyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_F,Dt);
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_IChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFIltro_Dt_F.SetFocus;

end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_ITyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_I,Dt);
end;

procedure TfrmLanc_Financeiros.edFiltro_Empresa_IDChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFiltro_Empresa_IDExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try

      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      edFiltro_Empresa.Text := '';           
      if Trim(edFiltro_Empresa_ID.Text) = '' then
        Exit;
              
      FDm_Global.Listar_Empresa(edFiltro_Empresa_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Empresa.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFiltro_Cliente_ID.SetFocus;

end;

procedure TfrmLanc_Financeiros.edFORMA_CONDICAO_PAGAMENTOKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edDT_VENCIMENTO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edID_CONTAExit(Sender: TObject);
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

procedure TfrmLanc_Financeiros.edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_PESSOA.SetFocus;

end;

procedure TfrmLanc_Financeiros.edID_EMPRESAExit(Sender: TObject);
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

procedure TfrmLanc_Financeiros.edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CONTA.SetFocus;

end;

procedure TfrmLanc_Financeiros.edID_PESSOAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      edID_PESSOA_Desc.Text := '';

      if Trim(edID_PESSOA.Text) = '' then
        Exit;


      case edConta_Tipo.Tag of
        1:FDm_Global.Listar_Cliente(edID_PESSOA.Text.ToInteger,'',FQuery);
        2:FDm_Global.Listar_Fornecedor(edID_PESSOA.Text.ToInteger,'',FQuery);
      end;

      if not FQuery.IsEmpty then
        edID_PESSOA_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edID_PESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFORMA_CONDICAO_PAGAMENTO.SetFocus;

end;

procedure TfrmLanc_Financeiros.Editar(Sender :TObject);
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      if FDQRegistros.FieldByName('ORIGEM_LANCAMENTO').AsString = 'PROPRIO' then
      begin
        FFancyDialog.Show(TIconDialog.Question,'Atenção','Não será possível EDITAR o registro, pois não é de lançamento PRÓPRIO','SIM',Editando_Lancamento,'NÃO');
      end
      else
        Editando_Lancamento(Sender);
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmLanc_Financeiros.edJUROSChange(Sender: TObject);
begin
  edJUROS.TagFloat := StrToFloatDef(Trim(StringReplace(StringReplace(edJUROS.Text,'R$','',[rfReplaceAll]),'.','',[rfReplaceAll])),0);
end;

procedure TfrmLanc_Financeiros.edJUROSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR_PAGO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edJUROSTyping(Sender: TObject);
begin
  Formatar(edJUROS,Money);
end;

procedure TfrmLanc_Financeiros.edSTATUSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_EMPRESA.SetFocus;

end;

procedure TfrmLanc_Financeiros.edVALORChange(Sender: TObject);
begin
  edVALOR.TagFloat := StrToFloatDef(Trim(StringReplace(StringReplace(edVALOR.Text,'R$','',[rfReplaceAll]),'.','',[rfReplaceAll])),0);
end;

procedure TfrmLanc_Financeiros.edVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDT_PAGAMENTO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edVALORTyping(Sender: TObject);
begin
  Formatar(edVALOR,Money)
end;

procedure TfrmLanc_Financeiros.edVALOR_PAGOChange(Sender: TObject);
begin
  edVALOR_PAGO.TagFloat := StrToFloatDef(Trim(StringReplace(StringReplace(edVALOR_PAGO.Text,'R$','',[rfReplaceAll]),'.','',[rfReplaceAll])),0);
end;

procedure TfrmLanc_Financeiros.edVALOR_PAGOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edOBSERVACAO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edVALOR_PAGOTyping(Sender: TObject);
begin
  Formatar(edVALOR_PAGO,Money);
end;

procedure TfrmLanc_Financeiros.Excluir(Sender: TObject);
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

      {$Region 'Verifica se o Lançamento pode ser excluído'}
        FQuery.Active := False;
        FQuery.SQL.Clear;
        FQuery.SQL.Add('SELECT * FROM LANCAMENTOS WHERE ID = :ID AND ORIGEM_LANCAMENTO <> ''PROPRIO'' ');
        FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
        FQuery.Active := True;
        if not FQuery.IsEmpty then
          raise Exception.Create('Lançamento não tem origem PRÓPRIO. Não erá possível excluir.');
      {$Region 'Verifica se o Lançamento pode ser excluído'}


      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM LANCAMENTOS WHERE ID = :ID AND ORIGEM_LANCAMENTO = ''PROPRIO'' ');
      FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

      //PROPRIO

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

procedure TfrmLanc_Financeiros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.CaFree;
  frmLanc_Financeiros := Nil;
end;

procedure TfrmLanc_Financeiros.FormCreate(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  lytFormulario.Align := TAlignLayout.Center;
  try
    FDm_Global := TDM_Global.Create(Nil);
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

    FFancyDialog := TFancyDialog.Create(frmLanc_Financeiros);
    FEnder := '';
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
    FIniFile := TIniFile.Create(FEnder);

    tcPrincipal.ActiveTab := tiLista;

    Selecionar_Registros;
    Configura_Botoes;

    rctMenu.Width := 0;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.Salvar;
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
      FQuery.Sql.Clear;
      case FTab_Status of
        dsInsert :begin
          FQuery.Active := False;
          FQuery.SQL.Clear;
          FQuery.SQL.Add('SELECT GEN_ID(GEN_LANCAMENTOS_ID,1) AS SEQ FROM RDB$DATABASE;');
          FQuery.Active := True;
          if not FQuery.IsEmpty then
            FId := FQuery.FieldByName('SEQ').AsInteger;

          FQuery.Active := False;
          FQuery.Sql.Clear;
          FQuery.Sql.Add('INSERT INTO LANCAMENTOS( ');
          FQuery.Sql.Add('  ID ');
          FQuery.Sql.Add('  ,ID_EMPRESA ');
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
          if Trim(edDT_PAGAMENTO.Text) <> '' then
          begin
            FQuery.Sql.Add('  ,DT_BAIXA ');
            FQuery.Sql.Add('  ,HR_BAIXA ');
            FQuery.Sql.Add('  ,ID_USUARIO_BAIXA ');
            FQuery.Sql.Add('  ,DESCONTO_BAIXA ');
            FQuery.Sql.Add('  ,JUROS_BAIXA ');
            FQuery.Sql.Add('  ,VALOR_BAIXA ');
          end;
          FQuery.Sql.Add('  ,ID_USUARIO ');
          FQuery.Sql.Add('  ,OBSERVACAO ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :ID ');
          FQuery.Sql.Add('  ,:ID_EMPRESA ');
          FQuery.Sql.Add('  ,:DT_EMISSAO ');
          FQuery.Sql.Add('  ,:ID_CONTA ');
          FQuery.Sql.Add('  ,:ID_PESSOA ');
          FQuery.Sql.Add('  ,:STATUS ');
          FQuery.Sql.Add('  ,:FORMA_PAGTO_ID ');
          FQuery.Sql.Add('  ,:COND_PAGTO_ID ');
          FQuery.Sql.Add('  ,:DT_VENCIMENTO ');
          FQuery.Sql.Add('  ,:VALOR ');
          FQuery.Sql.Add('  ,:ORIGEM_LANCAMENTO ');
          FQuery.Sql.Add('  ,:ID_ORIGEM_LANCAMENTO ');
          if Trim(edDT_PAGAMENTO.Text) <> '' then
          begin
            FQuery.Sql.Add('  ,:DT_BAIXA ');
            FQuery.Sql.Add('  ,:HR_BAIXA ');
            FQuery.Sql.Add('  ,:ID_USUARIO_BAIXA ');
            FQuery.Sql.Add('  ,:DESCONTO_BAIXA ');
            FQuery.Sql.Add('  ,:JUROS_BAIXA ');
            FQuery.Sql.Add('  ,:VALOR_BAIXA ');
          end;
          FQuery.Sql.Add('  ,:ID_USUARIO ');
          FQuery.Sql.Add('  ,:OBSERVACAO ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
          FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
          FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'PROPRIO';
          FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := FId;
        end;
        dsEdit :begin
          FId := StrToIntDef(edID.Text,0);
          FQuery.Sql.Add('UPDATE LANCAMENTOS SET ');
          FQuery.Sql.Add('  ID_EMPRESA = :ID_EMPRESA ');
          FQuery.Sql.Add('  ,DT_EMISSAO = :DT_EMISSAO ');
          FQuery.Sql.Add('  ,ID_CONTA = :ID_CONTA ');
          FQuery.Sql.Add('  ,ID_PESSOA = :ID_PESSOA ');
          FQuery.Sql.Add('  ,STATUS = :STATUS ');
          FQuery.Sql.Add('  ,FORMA_PAGTO_ID = :FORMA_PAGTO_ID ');
          FQuery.Sql.Add('  ,COND_PAGTO_ID = :COND_PAGTO_ID ');
          FQuery.Sql.Add('  ,DT_VENCIMENTO = :DT_VENCIMENTO ');
          FQuery.Sql.Add('  ,VALOR = :VALOR ');
          if Trim(edDT_PAGAMENTO.Text) <> '' then
          begin
            FQuery.Sql.Add('  ,DT_BAIXA = :DT_BAIXA ');
            FQuery.Sql.Add('  ,HR_BAIXA = :HR_BAIXA ');
            FQuery.Sql.Add('  ,ID_USUARIO_BAIXA = :ID_USUARIO_BAIXA ');
            FQuery.Sql.Add('  ,DESCONTO_BAIXA = :DESCONTO_BAIXA ');
            FQuery.Sql.Add('  ,JUROS_BAIXA = :JUROS_BAIXA ');
            FQuery.Sql.Add('  ,VALOR_BAIXA = :VALOR_BAIXA ');
          end;
          FQuery.Sql.Add('  ,OBSERVACAO = :OBSERVACAO ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := FId;
          FId := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edID_EMPRESA.Text,0);
      FQuery.ParamByName('DT_EMISSAO').AsDate := StrToDateDef(edDATA.Text,Date);
      FQuery.ParamByName('ID_CONTA').AsInteger := StrToIntDef(edID_CONTA.Text,0);
      FQuery.ParamByName('ID_PESSOA').AsInteger := StrToIntDef(edID_PESSOA.Text,0);
      FQuery.ParamByName('FORMA_PAGTO_ID').AsInteger := StrToIntDef(edFORMA_CONDICAO_PAGAMENTO.Text,0);
      FQuery.ParamByName('COND_PAGTO_ID').AsInteger := StrToIntDef(edID_CONDICAO_PAGAMENTO.Text,0);
      FQuery.ParamByName('DT_VENCIMENTO').AsDate := StrToDateDef(edDT_VENCIMENTO.Text,Date);
      FQuery.ParamByName('VALOR').AsFloat := edVALOR.TagFloat;
      FQuery.ParamByName('OBSERVACAO').AsString := edOBSERVACAO.Text;
      if Trim(edDT_PAGAMENTO.Text) <> '' then
      begin
        FQuery.ParamByName('DT_BAIXA').AsDate := StrToDateDef(edDT_PAGAMENTO.Text,Date);
        FQuery.ParamByName('HR_BAIXA').AsTime := Time;
        FQuery.ParamByName('ID_USUARIO_BAIXA').AsInteger := frmPrincipal.FUser_Id;
        FQuery.ParamByName('DESCONTO_BAIXA').AsFloat := edDESCONTO.TagFloat;
        FQuery.ParamByName('JUROS_BAIXA').AsFloat := edJUROS.TagFloat;
        FQuery.ParamByName('VALOR_BAIXA').AsFloat := edVALOR_PAGO.TagFloat;
        FQuery.ParamByName('STATUS').AsInteger := 1;  //0-Aberto, 1-pago
      end
      else
      begin
        FQuery.ParamByName('STATUS').AsInteger := 0;  //0-Aberto, 1-pago
      end;
      FQuery.ExecSQL;

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

procedure TfrmLanc_Financeiros.Selecionar_Registros;
var
  FDQ_Total :TFDQuery;
begin
  try
    try
      FDQ_Total := TFDQuery.Create(Nil);
      FDQ_Total.Connection := FDm_Global.FDC_Firebird;

      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  L.* ');
      FDQRegistros.SQL.Add('  ,E.NOME AS EMPRESA ');
      FDQRegistros.SQL.Add('  ,C.DESCRICAO AS CONTA ');
      FDQRegistros.SQL.Add('  ,C.TIPO AS TIPO_CONTA ');
      FDQRegistros.SQL.Add('  ,CASE C.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''CRÉDITO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''DÉBITO'' ');
      FDQRegistros.SQL.Add('  END TIPO_CONTA_DESC ');
      FDQRegistros.SQL.Add('  ,CASE C.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN CL.NOME ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN F.NOME ');
      FDQRegistros.SQL.Add('  END PESSOA ');
      FDQRegistros.SQL.Add('  ,CASE L.STATUS ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''ABERTO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''PAGO'' ');
      FDQRegistros.SQL.Add('  END STATUS_DESC ');
      FDQRegistros.SQL.Add('  ,U.NOME AS USUARIO ');
      FDQRegistros.SQL.Add('FROM LANCAMENTOS L ');
      FDQRegistros.SQL.Add('  JOIN EMPRESA E ON E.ID = L.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  JOIN CONTA C ON C.ID = L.ID_CONTA ');
      FDQRegistros.SQL.Add('  LEFT JOIN CLIENTE CL ON CL.ID = L.ID_PESSOA ');
      FDQRegistros.SQL.Add('  LEFT JOIN FORNECEDOR F ON F.ID = L.ID_PESSOA ');
      FDQRegistros.SQL.Add('  JOIN USUARIO U ON U.ID = L.ID_USUARIO ');
      FDQRegistros.SQL.Add('WHERE NOT L.ID IS NULL ');
      case cbFiltro_Tipo_Periodo.ItemIndex of
        0:FDQRegistros.SQL.Add('  AND L.DT_EMISSAO BETWEEN :DATA_I AND :DATA_F ');
        1:FDQRegistros.SQL.Add('  AND L.DT_VENCIMENTO BETWEEN :DATA_I AND :DATA_F ');
      end;
      if Trim(edFiltro_Empresa_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND L.ID_EMPRESA = :ID_EMPRESA');
        FDQRegistros.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
      end;
      if Trim(edFiltro_Cliente_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND L.ID_PESSOA = :ID_PESSOA');
        FDQRegistros.ParamByName('ID_PESSOA').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
      end;
      case cbFiltro_Tipo_DC.ItemIndex of
        1:FDQRegistros.SQL.Add('  AND C.TIPO = 0');
        2:FDQRegistros.SQL.Add('  AND C.TIPO = 1');
      end;
      if ((imgFiltro_Aberto.Tag = 1) and (imgFiltro_Pago.Tag = 0)) then
        FDQRegistros.SQL.Add('  AND L.STATUS = 0')
      else if ((imgFiltro_Aberto.Tag = 0) and (imgFiltro_Pago.Tag = 1)) then
        FDQRegistros.SQL.Add('  AND L.STATUS = 1');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  L.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  ,C.TIPO ');
      FDQRegistros.SQL.Add('  ,L.ID_CONTA ');
      case cbFiltro_Tipo_Periodo .ItemIndex of
        0:FDQRegistros.SQL.Add('  ,L.DT_EMISSAO; ');
        1:FDQRegistros.SQL.Add('  ,L.DT_VENCIMENTO; ');
      end;
      FDQRegistros.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
      FDQRegistros.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
      FDQRegistros.Active := True;


      {$Region 'Totalizando'}
        lbTotais_Credito_A.Text := 'R$ 0,00';
        lbTotais_Credito_P.Text := 'R$ 0,00';
        lbTotais_Credito_S.Text := 'R$ 0,00';
        lbTotal_Debito_A.Text := 'R$ 0,00';
        lbTotal_Debito_P.Text := 'R$ 0,00';
        lbTotal_Debito_S.Text := 'R$ 0,00';
        lbTotal_Saldo_A.Text := 'R$ 0,00';
        lbTotalSaldo_Saldo.Text := 'R$ 0,00';

        lbTotais_Credito_A.TagFloat := 0;
        lbTotais_Credito_P.TagFloat := 0;
        lbTotais_Credito_S.TagFloat := 0;
        lbTotal_Debito_A.TagFloat := 0;
        lbTotal_Debito_P.TagFloat := 0;
        lbTotal_Debito_S.TagFloat := 0;
        lbTotal_Saldo_A.TagFloat := 0;
        lbTotalSaldo_Saldo.TagFloat := 0;

        FDQ_Total.Active := False;
        FDQ_Total.Sql.Clear;
        FDQ_Total.Sql.Add('SELECT ');
        FDQ_Total.Sql.Add('  SUM(COALESCE(R.CREDITO,0)) AS CREDITO ');
        FDQ_Total.Sql.Add('  ,SUM(COALESCE(R.CREDITO_PAGO,0)) AS CREDITO_PAGO ');
        FDQ_Total.Sql.Add('  ,SUM(COALESCE(D.DEBITO,0)) AS DEBITO ');
        FDQ_Total.Sql.Add('  ,SUM(COALESCE(D.DEBITO_PAGO,0)) AS DEBITO_PAGO ');
        FDQ_Total.Sql.Add('FROM LANCAMENTOS L ');
        FDQ_Total.Sql.Add('  LEFT JOIN (SELECT ');
        FDQ_Total.Sql.Add('               L.ID ');
        FDQ_Total.Sql.Add('               ,L.VALOR AS CREDITO ');
        FDQ_Total.Sql.Add('               ,CASE WHEN L.STATUS = 1 THEN L.VALOR ELSE 0 END CREDITO_PAGO ');
        FDQ_Total.Sql.Add('             FROM LANCAMENTOS L ');
        FDQ_Total.Sql.Add('               JOIN CONTA C ON C.ID = L.ID_CONTA ');
        FDQ_Total.Sql.Add('             WHERE C.TIPO = 0) R ON R.ID = L.ID ');
        FDQ_Total.Sql.Add('  LEFT JOIN (SELECT ');
        FDQ_Total.Sql.Add('               L.ID ');
        FDQ_Total.Sql.Add('               ,L.VALOR AS DEBITO ');
        FDQ_Total.Sql.Add('               ,CASE WHEN L.STATUS = 1 THEN L.VALOR ELSE 0 END DEBITO_PAGO ');
        FDQ_Total.Sql.Add('             FROM LANCAMENTOS L ');
        FDQ_Total.Sql.Add('               JOIN CONTA C ON C.ID = L.ID_CONTA ');
        FDQ_Total.Sql.Add('             WHERE C.TIPO = 1) D ON D.ID = L.ID ');
        FDQ_Total.Sql.Add('WHERE NOT L.ID IS NULL ');
        case cbFiltro_Tipo_Periodo.ItemIndex of
          0:FDQ_Total.SQL.Add('  AND L.DT_EMISSAO BETWEEN :DATA_I AND :DATA_F ');
          1:FDQ_Total.SQL.Add('  AND L.DT_VENCIMENTO BETWEEN :DATA_I AND :DATA_F ');
        end;
        if Trim(edFiltro_Empresa_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('  AND L.ID_EMPRESA = :ID_EMPRESA');
          FDQ_Total.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
        end;
        if Trim(edFiltro_Cliente_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('  AND L.ID_PESSOA = :ID_PESSOA');
          FDQ_Total.ParamByName('ID_PESSOA').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
        end;
        case cbFiltro_Tipo_DC.ItemIndex of
          1:FDQ_Total.SQL.Add('  AND C.TIPO = 0');
          2:FDQ_Total.SQL.Add('  AND C.TIPO = 1');
        end;
        if ((imgFiltro_Aberto.Tag = 1) and (imgFiltro_Pago.Tag = 0)) then
          FDQ_Total.SQL.Add('  AND L.STATUS = 0')
        else if ((imgFiltro_Aberto.Tag = 0) and (imgFiltro_Pago.Tag = 1)) then
          FDQ_Total.SQL.Add('  AND L.STATUS = 1');
        FDQ_Total.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
        FDQ_Total.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
        FDQ_Total.Active := True;
        if not FDQ_Total.IsEmpty then
        begin
          //lbTot_Receber.Text := FormatFloat('R$ #,##0.00',FDQ_Total.FieldByName('RECEBER').AsFloat);
          lbTotais_Credito_A.Text := FormatFloat('R$ #,##0.00',FDQ_Total.FieldByName('CREDITO').AsFloat);
          lbTotais_Credito_A.TagFloat := FDQ_Total.FieldByName('CREDITO').AsFloat;
          lbTotais_Credito_P.Text := FormatFloat('R$ #,##0.00',FDQ_Total.FieldByName('CREDITO_PAGO').AsFloat);
          lbTotais_Credito_P.TagFloat := FDQ_Total.FieldByName('CREDITO_PAGO').AsFloat;
          lbTotais_Credito_S.Text := FormatFloat('R$ #,##0.00',(lbTotais_Credito_A.TagFloat - lbTotais_Credito_P.TagFloat));
          lbTotais_Credito_S.TagFloat := (lbTotais_Credito_A.TagFloat - lbTotais_Credito_P.TagFloat);

          lbTotal_Debito_A.Text := FormatFloat('R$ #,##0.00',FDQ_Total.FieldByName('DEBITO').AsFloat);
          lbTotal_Debito_A.TagFloat := FDQ_Total.FieldByName('DEBITO').AsFloat;
          lbTotal_Debito_P.Text := FormatFloat('R$ #,##0.00',FDQ_Total.FieldByName('DEBITO_PAGO').AsFloat);
          lbTotal_Debito_P.TagFloat := FDQ_Total.FieldByName('DEBITO_PAGO').AsFloat;
          lbTotal_Debito_S.Text := FormatFloat('R$ #,##0.00',lbTotal_Debito_A.TagFloat - lbTotal_Debito_P.TagFloat);
          lbTotal_Debito_S.TagFloat := (lbTotal_Debito_A.TagFloat - lbTotal_Debito_P.TagFloat);

          lbTotalSaldo_Saldo.Text := FormatFloat('R$ #,##0.00',(lbTotais_Credito_S.TagFloat - lbTotal_Debito_S.TagFloat));
          lbTotalSaldo_Saldo.TagFloat := (lbTotais_Credito_S.TagFloat - lbTotal_Debito_S.TagFloat);

          lbTotal_Saldo_A.Text := FormatFloat('R$ #,##0.00',(lbTotais_Credito_A.TagFloat - lbTotal_Debito_A.TagFloat));
          lbTotal_Saldo_A.TagFloat := (lbTotais_Credito_A.TagFloat - lbTotal_Debito_A.TagFloat);

        end;
      {$EndRegion 'Totalizando'}

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
    FreeAndNil(FDQ_Total);
  end;
end;

procedure TfrmLanc_Financeiros.CalendarDateSelected(Sender: TObject);
begin
  case FDataRetorno of
    0:edFIltro_Dt_I.Text := DateToStr(Calendar.Date);
    1:edFIltro_Dt_F.Text := DateToStr(Calendar.Date);
    2:edBL_Data.Text := DateToStr(Calendar.Date);
  end;

  rctCalendario_Tampa.Visible := False;

end;

procedure TfrmLanc_Financeiros.Cancelar;
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

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_DCChange(Sender: TObject);
begin
  edFiltro_Cliente_ID.Text := '';
  edFiltro_Cliente.Text := '';
  
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_DCKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    cbFiltro_Tipo_Periodo.SetFocus;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_PeriodoChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_PeriodoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFIltro_Dt_I.SetFocus;

end;

procedure TfrmLanc_Financeiros.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmLanc_Financeiros.imgCalendario_CancelarClick(Sender: TObject);
begin
  rctCalendario_Tampa.Visible := False;
end;

procedure TfrmLanc_Financeiros.imgFecharClick(Sender: TObject);
begin
  Close
end;

procedure TfrmLanc_Financeiros.imgFiltro_AbertoClick(Sender: TObject);
begin
  case imgFiltro_Aberto.Tag of
    0:begin
      imgFiltro_Aberto.Tag := 1;
      imgFiltro_Aberto.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Aberto.Tag := 0;
      imgFiltro_Aberto.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.imgFiltro_ClienteClick(Sender: TObject);
begin
  if NOT Assigned(frmPesq_Pessoas) then
    Application.CreateForm(TfrmPesq_Pessoas,frmPesq_Pessoas);

  frmPesq_Pessoas.TipoFiltro := cbFiltro_Tipo_DC.ItemIndex;

  frmPesq_Pessoas.ExecuteOnClose := Sel_Pessoa;
  frmPesq_Pessoas.Height := frmPrincipal.Height;
  frmPesq_Pessoas.Width := frmPrincipal.Width;

  frmPesq_Pessoas.Show;

end;

procedure TfrmLanc_Financeiros.imgFIltro_Dt_IClick(Sender: TObject);
begin
  rctCalendario_Tampa.Align := TAlignLayout.Contents;
  FDataRetorno := TImage(Sender).Tag;
  Calendar.Date := Date;
  rctCalendario_Tampa.Visible := True;
end;

procedure TfrmLanc_Financeiros.imgFiltro_EmpresaClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmLanc_Financeiros.Sel_Empresa(Aid: Integer; ANome: String);
begin
  edID_EMPRESA_Desc.Text := ANome;
  edID_EMPRESA.Text := Aid.ToString;

  if edID_EMPRESA.CanFocus then
    edID_EMPRESA.SetFocus;
end;

procedure TfrmLanc_Financeiros.Sel_FormaCondicao(AId, AId_Forma, AId_Condicao: Integer; ADesc_Forma, ADesc_Condicao: String);
begin
  edFORMA_CONDICAO_PAGAMENTO.Text := AId_Forma.ToString;
  edID_CONDICAO_PAGAMENTO.Text := AId_Condicao.ToString;
  edID_FORMA_PAGAMENTO.Text := ADesc_Forma;
  edCONDICAO_PAGAMENTO.Text := ADesc_Condicao;
end;

procedure TfrmLanc_Financeiros.imgFiltro_PagoClick(Sender: TObject);
begin
  case imgFiltro_Pago.Tag of
    0:begin
      imgFiltro_Pago.Tag := 1;
      imgFiltro_Pago.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Pago.Tag := 0;
      imgFiltro_Pago.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.imgFORMA_CONDICAO_PAGAMENTOClick(Sender: TObject);
begin
  if NOT Assigned(frmPesq_FormaCond_Pagto) then
    Application.CreateForm(TfrmPesq_FormaCond_Pagto,frmPesq_FormaCond_Pagto);

  frmPesq_FormaCond_Pagto.ExecuteOnClose := Sel_FormaCondicao;
  frmPesq_FormaCond_Pagto.Height := frmPrincipal.Height;
  frmPesq_FormaCond_Pagto.Width := frmPrincipal.Width;

  frmPesq_FormaCond_Pagto.Show;
end;

procedure TfrmLanc_Financeiros.imgID_CONTAClick(Sender: TObject);
begin
//Aid:Integer; ADescricao:String; ATipo:Integer
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas, frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_Conta;
  frmCad_Contas.Height := frmPrincipal.Height;
  frmCad_Contas.Width := frmPrincipal.Width;

  frmCad_Contas.Show;
end;

procedure TfrmLanc_Financeiros.Sel_Conta(Aid:Integer; ADescricao:String; ATipo:Integer);
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

procedure TfrmLanc_Financeiros.imgID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmLanc_Financeiros.imgID_PESSOAClick(Sender: TObject);
begin
  if NOT Assigned(frmPesq_Pessoas) then
    Application.CreateForm(TfrmPesq_Pessoas,frmPesq_Pessoas);

  frmPesq_Pessoas.TipoFiltro := (edConta_Tipo.Tag + 1);

  frmPesq_Pessoas.ExecuteOnClose := Sel_Pessoa;
  frmPesq_Pessoas.Height := frmPrincipal.Height;
  frmPesq_Pessoas.Width := frmPrincipal.Width;

  frmPesq_Pessoas.Show;
end;

procedure TfrmLanc_Financeiros.imgImp_FecharClick(Sender: TObject);
begin
  rctImprimir_Tampa.Visible := False;
end;

procedure TfrmLanc_Financeiros.imgMenuFecharClick(Sender: TObject);
begin
  rctMenu_Tampa.Visible := False;
end;

procedure TfrmLanc_Financeiros.Incluir;
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
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmLanc_Financeiros.Limpar_Campos;
begin
  edID.Text := '';
  edDATA.Text := '';
  edSTATUS.ItemIndex := -1;
  edID_EMPRESA.Text := '';
  edID_EMPRESA_Desc.Text := '';
  edID_CONTA.Text := '';
  edID_CONTA_Desc.Text := '';
  edConta_Tipo.Tag := -1;
  edConta_Tipo.Text := '';
  edID_PESSOA.Text := '';
  edID_PESSOA_Desc.Text := '';
  edDT_VENCIMENTO.Text := '';
  edVALOR.Text := '';
  edDT_PAGAMENTO.Text := '';
  edDESCONTO.Text := '';
  edJUROS.Text := '';
  edVALOR_PAGO.Text := '';
  edOBSERVACAO.Text := '';
end;

procedure TfrmLanc_Financeiros.Editando_Lancamento(Sender :TOBject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edDATA.Text := FDQRegistros.FieldByName('DT_EMISSAO').AsString;
      edSTATUS.ItemIndex := FDQRegistros.FieldByName('STATUS').AsInteger;
      edID_EMPRESA.Text := FDQRegistros.FieldByName('ID_EMPRESA').AsString;
      edID_CONTA.Text := FDQRegistros.FieldByName('ID_CONTA').AsString;
      edID_PESSOA.Text := FDQRegistros.FieldByName('ID_PESSOA').AsString;
      edFORMA_CONDICAO_PAGAMENTO.Text := FDQRegistros.FieldByName('FORMA_PAGTO_ID').AsString;
      edID_CONDICAO_PAGAMENTO.Text := FDQRegistros.FieldByName('COND_PAGTO_ID').AsString;

      FDm_Global.Listar_FormaPagto(StrToIntDef(edFORMA_CONDICAO_PAGAMENTO.Text,0),'',FQuery);
        edID_FORMA_PAGAMENTO.Text := FQuery.FieldByName('DESCRICAO').AsString;

      FDm_Global.Listar_FormaPagto(StrToIntDef(edID_CONDICAO_PAGAMENTO.Text,0),'',FQuery);
        edCONDICAO_PAGAMENTO.Text := FQuery.FieldByName('DESCRICAO').AsString;

      edDT_VENCIMENTO.Text := FDQRegistros.FieldByName('DT_VENCIMENTO').AsString;
      edVALOR.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VALOR').AsFloat);
      edVALOR.TagFloat := FDQRegistros.FieldByName('VALOR').AsFloat;
      edDT_PAGAMENTO.Text := FDQRegistros.FieldByName('DT_BAIXA').AsString;
      edDESCONTO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('DESCONTO_BAIXA').AsFloat);
      edDESCONTO.TagFloat := FDQRegistros.FieldByName('DESCONTO_BAIXA').AsFloat;
      edJUROS.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('JUROS_BAIXA').AsFloat);
      edJUROS.TagFloat := FDQRegistros.FieldByName('JUROS_BAIXA').AsFloat;
      edVALOR_PAGO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VALOR_BAIXA').AsFloat);
      edVALOR_PAGO.TagFloat := FDQRegistros.FieldByName('VALOR_BAIXA').AsFloat;
      edOBSERVACAO.Text := FDQRegistros.FieldByName('OBSERVACAO').AsString;
      FTab_Status := TTab_Status.dsEdit;
      tcPrincipal.GotoVisibleTab(1);
      if edDATA.CanFocus then
        edDATA.SetFocus;
    except on E: Exception do
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.Menu(Sender: TOBject);
begin
  rctMenu.Width := 0;
  rctMenu_Tampa.Align := TAlignLayout.Contents;
  rctMenu_Tampa.Visible := True;
  faMenu.StartValue := 0;
  faMenu.StopValue := 240;
  faMenu.Start;
end;

procedure TfrmLanc_Financeiros.rctBH_CancelarClick(Sender: TObject);
begin
  rctMenuBaixar_Lancto.Visible := False;
end;

procedure TfrmLanc_Financeiros.rctBH_ConfirmarClick(Sender: TObject);
begin
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Baixar o lançamento selecionado?','SIM',Baixar_Lancamento,'NÃO');
end;

procedure TfrmLanc_Financeiros.rctCancelarClick(Sender: TObject);
begin
  try
    try
      case TRectangle(Sender).Tag of
        0:Incluir;
        1:Editar(Sender);
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

procedure TfrmLanc_Financeiros.Imprimir_Relatorios;
begin
  rctImprimir_Tampa.Visible := True;
end;

procedure TfrmLanc_Financeiros.rctFecharMesClick(Sender: TObject);
begin
  case TRectangle(Sender).Tag of
    0:FFancyDialog.Show(TIconDialog.Question,'','Baixar lançamentos?','SIM',Baixar_Lancamento,'NÃO');
    //1:FFancyDialog.Show(TIconDialog.Question,'','Deseja fechar o mês atual?','SIM',FecharMes,'NÃO');
  end;
  rctMenu_Tampa.Visible := False;

end;

procedure TfrmLanc_Financeiros.rctImp_EditarClick(Sender: TObject);
begin
  try
    frxReport.LoadFromFile(System.SysUtils.GetCurrentDir + '\Relatorios\Lanc_Financeiros.fr3');

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
        FDm_Global.FDMT_RelatoriosTIPO_PERIODO.AsString := cbFiltro_Tipo_Periodo.Selected.Text;
        FDm_Global.FDMT_RelatoriosDATA_I.AsString := edFIltro_Dt_I.Text;
        FDm_Global.FDMT_RelatoriosDATA_F.AsString := edFIltro_Dt_F.Text;
        FDm_Global.FDMT_RelatoriosEMPRESA_I.AsString := edFiltro_Empresa_ID.Text + '-' + edFiltro_Empresa.Text;
        FDm_Global.FDMT_RelatoriosCLIENTE_I.AsString := edFiltro_Cliente_ID.Text + '-' + edFiltro_Cliente.Text;
        FDm_Global.FDMT_RelatoriosD_C.AsString := cbFiltro_Tipo_DC.Selected.Text;
        if ((imgFiltro_Aberto.Tag = 1) and (imgFiltro_Pago.Tag = 1)) then
          FDm_Global.FDMT_RelatoriosSTATUS.AsString := 'Crédito/Débito'
        else if ((imgFiltro_Aberto.Tag = 1) and (imgFiltro_Pago.Tag = 0)) then
          FDm_Global.FDMT_RelatoriosSTATUS.AsString := 'Crédito'
        else if ((imgFiltro_Aberto.Tag = 0) and (imgFiltro_Pago.Tag = 1)) then
          FDm_Global.FDMT_RelatoriosSTATUS.AsString := 'Débito'
        else
          FDm_Global.FDMT_RelatoriosSTATUS.AsString := 'Crédito/Débito';
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

procedure TfrmLanc_Financeiros.rctMenu_BaixarLanctoClick(Sender: TObject);
begin

  if FDQRegistrosORIGEM_LANCAMENTO.AsString = 'SERVICOS_PRESTADOS' then
  begin
    FFancyDialog.Show(TIconDialog.Warning,'Atenção','Lançamentos provenientes de Serviços Pretados, deverão serem baixados pela tela de origem do Lançamento.','OK');
    rctMenu_Tampa.Visible := False;
    Exit;
  end;

  lbBL_ValorLancamento.Text := FormatFloat('R$ #,##0.00', FDQRegistrosVALOR.AsFloat);
  lbBL_ValorLancamento.TagFloat := FDQRegistrosVALOR.AsFloat;
  edBL_ValorBaixa.Text := FormatFloat('R$ #,##0.00', FDQRegistrosVALOR.AsFloat);
  edBL_ValorBaixa.TagFloat := FDQRegistrosVALOR.AsFloat;

  rctMenuBaixar_Lancto.Visible := True;
  if edBL_Data.CanFocus then
    edBL_Data.SetFocus;

  rctMenu_Tampa.Visible := False;
end;

procedure TfrmLanc_Financeiros.Baixar_Lancamento(Sender:TOBject);
var
  t :TThread;
begin
  {Por enquanto vai baixar lançamento por lançamento, depois tera baixa por lote}

  TLoading.Show(frmLanc_Financeiros,'Baixando Lançamentos');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_Firebird;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE LANCAMENTOS SET ');
    FQuery.Sql.Add('  STATUS = :STATUS ');
    FQuery.Sql.Add('  ,DT_BAIXA = :DT_BAIXA ');
    FQuery.Sql.Add('  ,HR_BAIXA = :HR_BAIXA ');
    FQuery.Sql.Add('  ,ID_USUARIO_BAIXA = :ID_USUARIO_BAIXA ');
    FQuery.Sql.Add('  ,DESCONTO_BAIXA = :DESCONTO_BAIXA ');
    FQuery.Sql.Add('  ,JUROS_BAIXA = :JUROS_BAIXA ');
    FQuery.Sql.Add('  ,VALOR_BAIXA = :VALOR_BAIXA ');
    FQuery.Sql.Add('WHERE ID = :ID; ');
    FQuery.ParamByName('ID').AsInteger := FDQRegistrosID.AsInteger; //Baixado
    FQuery.ParamByName('STATUS').AsInteger := 1; //Baixado
    FQuery.ParamByName('DT_BAIXA').AsDate := StrToDateDef(edBL_Data.Text,Date);
    FQuery.ParamByName('HR_BAIXA').AsTime := Time;
    FQuery.ParamByName('ID_USUARIO_BAIXA').AsInteger := frmPrincipal.FUser_Id;
    FQuery.ParamByName('DESCONTO_BAIXA').AsFloat := edBL_Desconto.TagFloat;
    FQuery.ParamByName('JUROS_BAIXA').AsFloat := edBL_Juros.TagFloat;
    FQuery.ParamByName('VALOR_BAIXA').AsFloat := edBL_ValorBaixa.TagFloat;
    FQuery.ExecSQL;

    FreeAndNil(FQuery);
  end);

  t.OnTerminate := TThreadEnd_Baixar_Lancamento;
  t.Start;

end;

procedure TfrmLanc_Financeiros.TThreadEnd_Baixar_Lancamento(Sender :TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Baixa',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Selecionar_Registros;
    rctMenuBaixar_Lancto.Visible := False;
  end;
end;

procedure TfrmLanc_Financeiros.Sel_Pessoa(ATipo:String; Aid:Integer; ANome:String; ADocumento:String);
begin
  lbFiltroPessoa.Text := ATipo;
  if ATipo = 'Cliente' then
    lbFiltroPessoa.Tag := 0
  else if ATipo = 'Fornecedor' then
    lbFiltroPessoa.Tag := 1;

  edID_PESSOA.Text := Aid.ToString;
  edID_PESSOA_Desc.Text := ANome;

  if edID_PESSOA.CanFocus then
    edID_PESSOA.SetFocus;

end;

end.
