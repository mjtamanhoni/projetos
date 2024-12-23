unit uFrame.SPDados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TFrame_SP_Dados = class(TFrame)
    lbHR_INICIO: TLabel;
    lbTOTAL: TLabel;
    lbIgualValor: TLabel;
    lbVLR_HORA: TLabel;
    lbHR_TOTAL: TLabel;
    lbHR_FIM: TLabel;
    lbA: TLabel;
    rctMenu: TRectangle;
    imgMenu: TImage;
    rctPrincipal: TRectangle;
    lytStatus: TLayout;
    imgSincronizado: TImage;
    imgExcluído: TImage;
    lytInformacoes: TLayout;
    lytRow_001: TLayout;
    lbConta: TLabel;
    lytRow_002: TLayout;
    lbCliente: TLabel;
    lytRow_003: TLayout;
    lytRow_004: TLayout;
    lbVlr_Hora_TIT: TLabel;
    lbId: TLabel;
    lbFim_Tit: TLabel;
    lbTotalRec: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
