program Controle_Horas;

uses
  System.StartUpCopy,
  FMX.Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  uRota.Auth in '..\..\..\Global\Rotas\uRota.Auth.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
