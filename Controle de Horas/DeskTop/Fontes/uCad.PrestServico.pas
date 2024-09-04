unit uCad.PrestServico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.StdCtrls,
  FMX.dxGrid, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  TfrmCad_PrestServico = class(TForm)
    FDQRegistros: TFDQuery;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosNOME: TStringField;
    FDQRegistrosLOGIN: TStringField;
    FDQRegistrosSENHA: TStringField;
    FDQRegistrosPIN: TStringField;
    FDQRegistrosCELULAR: TStringField;
    FDQRegistrosEMAIL: TStringField;
    FDQRegistrosFOTO: TMemoField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosSINCRONIZADO: TIntegerField;
    DSRegistros: TDataSource;
    OpenDialog: TOpenDialog;
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
    edPesquisar: TEdit;
    imgPesquisar: TImage;
    Layout2: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    dxfmGrid1RootLevel1Column1: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column2: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column3: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column4: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column5: TdxfmGridColumn;
    tiCadastro: TTabItem;
    lytConfig: TLayout;
    lytBDF_Row001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytBDF_Row002: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytBDF_Row004: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_PrestServico: TfrmCad_PrestServico;

implementation

{$R *.fmx}

end.
