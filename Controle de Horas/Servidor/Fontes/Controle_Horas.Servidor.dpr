program Controle_Horas.Servidor;

uses
  System.StartUpCopy,
  FMX.Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  uRota.Auth in '..\..\..\Global\Rotas\uRota.Auth.pas',
  uDm.Servidor in 'uDm.Servidor.pas' {DM_Servidor: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
