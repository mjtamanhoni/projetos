unit uEmpresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, FMX.TabControl, FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmEmpresa = class(TForm)
    lytDetail: TLayout;
    tcCadastro: TTabControl;
    tiGuia_1: TTabItem;
    rctGuia_1: TRectangle;
    lytNome: TLayout;
    edNome: TEdit;
    lbNome: TLabel;
    faNome: TFloatAnimation;
    imgVerSenha: TImage;
    lytStatus: TLayout;
    edStatus: TEdit;
    lbStatus: TLabel;
    faStatus: TFloatAnimation;
    tiGuia_2: TTabItem;
    rctGuia_2: TRectangle;
    lytCelular: TLayout;
    edCelular: TEdit;
    lbCelular: TLabel;
    faCelular: TFloatAnimation;
    lytEtapa1_Acoes: TLayout;
    lytAnterior: TLayout;
    imgAnterior: TImage;
    lytProximo: TLayout;
    imgProximo: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    imgConfirmar: TImage;
    imgCancelar: TImage;
    StyleBook_Principal: TStyleBook;
    tcPrincipal: TTabControl;
    tiListagem: TTabItem;
    tiCadastro: TTabItem;
    lvRegistros: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmpresa: TfrmEmpresa;

implementation

{$R *.fmx}

end.
