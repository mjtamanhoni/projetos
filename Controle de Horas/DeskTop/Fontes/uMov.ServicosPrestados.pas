unit uMov.ServicosPrestados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uCad.TabPrecos;

type
  TfrmMov_ServicosPrestados = class(TForm)
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
