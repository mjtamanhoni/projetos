unit uFrame.CondicaoPagto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layouts, FMX.Objects;

type
  TFrame_CondicaoPagto = class(TFrame)
    rctMenu: TRectangle;
    imgMenu: TImage;
    rctPrincipal: TRectangle;
    lytStatus: TLayout;
    imgSincronizado: TImage;
    imgExcluído: TImage;
    lytInformacoes: TLayout;
    lytRow_001: TLayout;
    lbDescricao: TLabel;
    lytRow_002: TLayout;
    lbParcelas: TLabel;
    lbTipoIntervalo: TLabel;
    lbIntervalo: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
