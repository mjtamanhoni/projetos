unit uUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts;

type
  TfrmUsuario = class(TForm)
    lytHeader: TLayout;
    lytDetail: TLayout;
    Rectangle1: TRectangle;
    lytFechar: TLayout;
    imgFechar: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.fmx}

end.
