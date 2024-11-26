unit uFrame.Empresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.Controls.Presentation;

type
  TFrame_Empresa = class(TFrame)
    rctPrincipal: TRectangle;
    lytStatus: TLayout;
    lytInformacoes: TLayout;
    imgSincronizado: TImage;
    imgExcluído: TImage;
    imgMenu: TImage;
    lytRow_001: TLayout;
    lytRow_002: TLayout;
    lbNome: TLabel;
    lbDocumento: TLabel;
    lbCelular: TLabel;
    rctMenu: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
