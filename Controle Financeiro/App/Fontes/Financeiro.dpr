program Financeiro;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  uFuncoes in '..\..\..\Global\uFuncoes.pas',
  Android.KeyguardManager in '..\..\..\Classes\99 Coders\Versao 11\Android.KeyguardManager.pas',
  Androidapi.JNI.PowerManager in '..\..\..\Classes\99 Coders\Versao 11\Androidapi.JNI.PowerManager.pas',
  DW.Androidapi.JNI.KeyguardManager in '..\..\..\Classes\99 Coders\Versao 11\DW.Androidapi.JNI.KeyguardManager.pas',
  u99Permissions in '..\..\..\Classes\99 Coders\Versao 11\u99Permissions.pas',
  uActionSheet in '..\..\..\Classes\99 Coders\Versao 11\uActionSheet.pas',
  uCombobox in '..\..\..\Classes\99 Coders\Versao 11\uCombobox.pas',
  uFancyDialog in '..\..\..\Classes\99 Coders\Versao 11\uFancyDialog.pas',
  uFormat in '..\..\..\Classes\99 Coders\Versao 11\uFormat.pas',
  uLoading in '..\..\..\Classes\99 Coders\Versao 11\uLoading.pas',
  uOpenViewUrl in '..\..\..\Classes\99 Coders\Versao 11\uOpenViewUrl.pas',
  uSuperChart in '..\..\..\Classes\99 Coders\Versao 11\uSuperChart.pas',
  uPerfil_Usuario in 'uPerfil_Usuario.pas' {frmPerfilUsuario},
  uModel.Usuario in 'Modelo de Dados\uModel.Usuario.pas',
  uDM_Global in 'uDM_Global.pas' {DM: TDataModule},
  uConfig in 'uConfig.pas' {frmConfig},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uModel.Empresa in 'Modelo de Dados\uModel.Empresa.pas',
  uModel.Cliente in 'Modelo de Dados\uModel.Cliente.pas',
  uModel.Tabela.Precos in 'Modelo de Dados\uModel.Tabela.Precos.pas',
  uModel.Projetos in 'Modelo de Dados\uModel.Projetos.pas',
  uModel.Apontamentos.Horas in 'Modelo de Dados\uModel.Apontamentos.Horas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
