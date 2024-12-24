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
    lbDT_VENCIMENTO: TLabel;
    lbDT_EMISSAO: TLabel;
    lbVALOR: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    lbDT_EMISSAO_Tit: TLabel;
    lbDT_VENCIMENTO_Tit: TLabel;
    lbVALOR_Tit: TLabel;
    lytRow_004: TLayout;
    GridPanelLayout2: TGridPanelLayout;
    lbDT_BAIXA_Tit: TLabel;
    lbVALOR_BAIXA_Tit: TLabel;
    lbDT_BAIXA: TLabel;
    lbVALOR_BAIXA: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
