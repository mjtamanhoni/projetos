unit uMov.ServicosPrestados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uPrincipal,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.TabControl, FMX.Layouts;

type
  TfrmMov_ServicosPrestados = class(TForm)
    imgCancelar: TImage;
    imgChecked: TImage;
    imgExcluir: TImage;
    imgNovo: TImage;
    imgSalvar: TImage;
    imgUnChecked: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytLista: TLayout;
    tiCampos: TTabItem;
    lytCampos: TLayout;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    imgAcao_02: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMov_ServicosPrestados: TfrmMov_ServicosPrestados;

implementation

{$R *.fmx}

end.
