unit uMov.ServicosPrestados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uCombobox,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uACBr,
  uFuncoes,

  {$Region 'Frames'}
    uFrame.CondicaoPagto,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(AId,ATipoIntervalo,AIntervalo,AParcelas:Integer; ANome:String) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmMov_ServicosPrestados = class(TForm)
    imgCancelar: TImage;
    imgChecked: TImage;
    imgEditar: TImage;
    imgEsconder: TImage;
    imgExcluir: TImage;
    imgExibir: TImage;
    imgNovo: TImage;
    imgSalvar: TImage;
    imgUnChecked: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytLista: TLayout;
    lbRegistros: TListBox;
    lytFiltro: TLayout;
    edFiltro: TEdit;
    imgLimpar: TImage;
    tiCampos: TTabItem;
    lytCampos: TLayout;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    tcCampos: TTabControl;
    tiCampos_001: TTabItem;
    lytCampos_001: TLayout;
    lytRow_C01_001: TLayout;
    lytID: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytSTATUS: TLayout;
    lbSTATUS: TLabel;
    edSTATUS: TEdit;
    imgSTATUS: TImage;
    lytRow_C01_002: TLayout;
    lytDESCRICAO: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    lytRow_Navegar_01: TLayout;
    imgAvancar_001: TImage;
    lytRow_C02_001: TLayout;
    lytID_EMPRESA: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_C02_002: TLayout;
    lytID_CONTA: TLayout;
    lbID_CONTA: TLabel;
    edID_CONTA: TEdit;
    imgID_CONTA: TImage;
    tiCampos_002: TTabItem;
    lytCampos_002: TLayout;
    lytRow_Navegar_02: TLayout;
    imgAvancar_002: TImage;
    imgRetornar_001: TImage;
    tiCampos_003: TTabItem;
    lytCampos_003: TLayout;
    lytRow_C03_001: TLayout;
    lytHR_INICIO: TLayout;
    lbHR_INICIO: TLabel;
    edHR_INICIO: TEdit;
    lytHR_TOTAL: TLayout;
    lbHR_TOTAL: TLabel;
    edHR_TOTAL: TEdit;
    lytRow_C03_002: TLayout;
    lytRow_Navegar_03: TLayout;
    imgRetornar_002: TImage;
    lytDATA: TLayout;
    lbDATA: TLabel;
    edDATA: TEdit;
    imgDATA: TImage;
    lytRow_C02_003: TLayout;
    lytID_PRESTADOR_SERVICO: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO: TEdit;
    imgID_PRESTADOR_SERVICO: TImage;
    lytRow_C02_004: TLayout;
    lytID_CLIENTE: TLayout;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE: TEdit;
    imgID_CLIENTE: TImage;
    lytRow_C02_005: TLayout;
    lytID_TABELA: TLayout;
    lbID_TABELA: TLabel;
    edID_TABELA: TEdit;
    imgID_TABELA: TImage;
    lytHR_FIM: TLayout;
    lbHR_FIM: TLabel;
    edHR_FIM: TEdit;
    lytDESCONTO: TLayout;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lytSUB_TOTAL: TLayout;
    lbSUB_TOTAL: TLabel;
    edSUB_TOTAL: TEdit;
    lytACRESCIMO: TLayout;
    lbACRESCIMO: TLabel;
    edACRESCIMO: TEdit;
    lytRow_C03_003: TLayout;
    lytTOTAL: TLayout;
    lbTOTAL: TLabel;
    edTOTAL: TEdit;
    lytRow_C03_004: TLayout;
    lytOBSERVACAO: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_C03_005: TLayout;
    lytVLR_PAGO: TLayout;
    lbVLR_PAGO: TLabel;
    lytDT_PAGO: TLayout;
    lbDT_PAGO: TLabel;
    edDT_PAGO: TEdit;
    imgDT_PAGO: TImage;
    edVLR_PAGO: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure imgAvancar_001Click(Sender: TObject);
    procedure imgRetornar_001Click(Sender: TObject);
    procedure imgAvancar_002Click(Sender: TObject);
    procedure imgRetornar_002Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMov_ServicosPrestados: TfrmMov_ServicosPrestados;

implementation

{$R *.fmx}

procedure TfrmMov_ServicosPrestados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.FormCreate(Sender: TObject);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.FormShow(Sender: TObject);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.imgAcao_01Click(Sender: TObject);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.imgAvancar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmMov_ServicosPrestados.imgAvancar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(2);
end;

procedure TfrmMov_ServicosPrestados.imgRetornar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(0);
end;

procedure TfrmMov_ServicosPrestados.imgRetornar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmMov_ServicosPrestados.imgVoltarClick(Sender: TObject);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.lbRegistrosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  //
end;

end.
