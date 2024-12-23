unit uFrame.LancFinanceiro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layouts, FMX.Objects;

type
  TFrame_LancFinanceiro = class(TFrame)
    rctMenu: TRectangle;
    imgMenu: TImage;
    rctPrincipal: TRectangle;
    lytStatus: TLayout;
    imgSincronizado: TImage;
    imgExcluído: TImage;
    lbId: TLabel;
    lytInformacoes: TLayout;
    lytRow_001: TLayout;
    lbConta: TLabel;
    lytRow_002: TLayout;
    lbPessoa: TLabel;
    lytRow_003: TLayout;
    lbDt: TLabel;
    lbDtLancamento: TLabel;
    lbValor: TLabel;
    lytRow_004: TLayout;
    lbVLR_HORA: TLabel;
    lbTOTAL: TLabel;
    lbVlr_Hora_TIT: TLabel;
    lbTotalRec: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
