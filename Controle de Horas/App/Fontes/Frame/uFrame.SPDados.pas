unit uFrame.SPDados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  FMX.Controls.Presentation;

type
  TFrame_SP_Dados = class(TFrame)
    rctPrincipal: TRectangle;
    lbHR_INICIO: TLabel;
    lbTOTAL: TLabel;
    lbIgualValor: TLabel;
    lbVLR_HORA: TLabel;
    lbMultiplicador: TLabel;
    lbHR_TOTAL: TLabel;
    lbIgual: TLabel;
    lbHR_FIM: TLabel;
    lbA: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
