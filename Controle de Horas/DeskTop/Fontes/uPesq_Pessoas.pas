unit uPesq_Pessoas;

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
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.dxGrid,
  FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.ListBox;

type
  TfrmPesq_Pessoas = class(TForm)
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctIncluir: TRectangle;
    imgIncluir: TImage;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    lytFiltro_Tipo: TLayout;
    rctFiltro_Tipo: TRectangle;
    lbFiltro_Tipo: TLabel;
    lytFiltro_Pessoa: TLayout;
    rctFiltro_Pessoa: TRectangle;
    edFiltro_Pessoa: TEdit;
    edFiltro_Pessoa_ID: TEdit;
    lytFiltro_Pessoa_Tit: TLabel;
    lytLista: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    edFiltro_Tipo: TComboBox;
    FDQRegistrosTIPO: TStringField;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosNOME: TStringField;
    FDQRegistrosPESSOA: TIntegerField;
    FDQRegistrosDOCUMENTO: TStringField;
    FDQRegistrosINSC_EST: TStringField;
    FDQRegistrosENDERECO: TStringField;
    FDQRegistrosCOMPLEMENTO: TStringField;
    FDQRegistrosNUMERO: TStringField;
    FDQRegistrosBAIRRO: TStringField;
    FDQRegistrosCIDADE: TStringField;
    FDQRegistrosUF: TStringField;
    FDQRegistrosTELEFONE: TStringField;
    FDQRegistrosCELULAR: TStringField;
    FDQRegistrosEMAIL: TStringField;
    FDQRegistrosID_TAB_PRECO: TIntegerField;
    dxfmGrid1RootLevel1TIPO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1NOME: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DOCUMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1INSC_EST: TdxfmGridColumn;
    dxfmGrid1RootLevel1ENDERECO: TdxfmGridColumn;
    dxfmGrid1RootLevel1COMPLEMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1NUMERO: TdxfmGridColumn;
    dxfmGrid1RootLevel1BAIRRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1CIDADE: TdxfmGridColumn;
    dxfmGrid1RootLevel1UF: TdxfmGridColumn;
    dxfmGrid1RootLevel1TELEFONE: TdxfmGridColumn;
    dxfmGrid1RootLevel1CELULAR: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMAIL: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_TAB_PRECO: TdxfmGridColumn;
    FDQRegistrosPESSOA_DESC: TStringField;
    dxfmGrid1RootLevel1PESSOA_DESC: TdxfmGridColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesq_Pessoas: TfrmPesq_Pessoas;

implementation

{$R *.fmx}

end.
