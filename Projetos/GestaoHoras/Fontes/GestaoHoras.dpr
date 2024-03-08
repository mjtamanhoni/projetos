program GestaoHoras;

uses
  System.StartUpCopy,
  FMX.Forms,
  uInformacoes in 'uInformacoes.pas' {frmInformacoes},
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
  uFuncoes in '..\..\..\Global\uFuncoes.pas',
  uConfig in 'uConfig.pas' {frmConfig},
  uDM_Global in 'uDM_Global.pas' {DM: TDataModule},
  uLogin in 'uLogin.pas' {frmLogin},
  uPerfil_Usuario in 'uPerfil_Usuario.pas' {frmPerfilUsuario},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uModel.Apontamentos.Horas in 'Modelo de Dados\uModel.Apontamentos.Horas.pas',
  uModel.Cliente in 'Modelo de Dados\uModel.Cliente.pas',
  uModel.Empresa in 'Modelo de Dados\uModel.Empresa.pas',
  uModel.Projetos in 'Modelo de Dados\uModel.Projetos.pas',
  uModel.Tabela.Precos in 'Modelo de Dados\uModel.Tabela.Precos.pas',
  uModel.Usuario in 'Modelo de Dados\uModel.Usuario.pas',
  uEmpresa in 'uEmpresa.pas' {frmEmpresa};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmEmpresa, frmEmpresa);
  Application.Run;
end.
