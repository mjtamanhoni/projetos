program Controle_Horas.App;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uLogin in 'uLogin.pas' {frmLogin},
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
  uUsuario in 'uUsuario.pas' {frmUsuario},
  DM.ContHoras in 'DM.ContHoras.pas' {DM_ConrHoras: TDataModule},
  uModel.Usuario in 'Modelo de Dados\uModel.Usuario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
