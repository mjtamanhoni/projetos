program Controle.Horas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDm.Global in 'Data_Modules\uDm.Global.pas' {DM_Global: TDataModule},
  uConfig in 'uConfig.pas' {frmConfig},
  uFancyDialog in '..\..\..\Classes\99 Coders\Versao 11\uFancyDialog.pas',
  uFormat in '..\..\..\Classes\99 Coders\Versao 11\uFormat.pas',
  uLoading in '..\..\..\Classes\99 Coders\Versao 11\uLoading.pas',
  uCad.Usuario in 'uCad.Usuario.pas' {frmCad_Usuario},
  uLogin in 'uLogin.pas' {frmLogin},
  uCad.PrestServico in 'uCad.PrestServico.pas' {frmCad_PrestServico};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
