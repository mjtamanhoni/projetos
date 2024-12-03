unit uFrame.FormaPagto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Layouts, FMX.Objects;

type
  TFrame_FormaPagto = class(TFrame)
    rctMenu: TRectangle;
    imgMenu: TImage;
    rctPrincipal: TRectangle;
    lytStatus: TLayout;
    imgSincronizado: TImage;
    imgExclu�do: TImage;
    lytInformacoes: TLayout;
    lytRow_001: TLayout;
    lbDescricao: TLabel;
    lytRow_002: TLayout;
    lbClassificacao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.