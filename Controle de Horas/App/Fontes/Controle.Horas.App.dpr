program Controle.Horas.App;

uses
  System.StartUpCopy,
  FMX.Forms,
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
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uCad.Usuario in 'uCad.Usuario.pas' {frmCad_Usuario},
  uMov.ServicosPrestados in 'uMov.ServicosPrestados.pas' {frmMov_ServicosPrestados},
  uDM.Global in 'DataModulo\uDM.Global.pas' {DM_Global: TDataModule},
  uModelo.Dados in 'Units\uModelo.Dados.pas',
  uCad.Empresa in 'uCad.Empresa.pas' {frmCad_Empresa},
  uACBr in '..\..\Global\uACBr.pas',
  uFrame.Empresa in 'Frame\uFrame.Empresa.pas' {Frame_Empresa: TFrame},
  uFrame.PrestServico in 'Frame\uFrame.PrestServico.pas' {Frame_PrestServico: TFrame},
  uCad.PrestadorServicos in 'uCad.PrestadorServicos.pas' {frmCad_PrestadorServicos},
  uFrame.Usuario in 'Frame\uFrame.Usuario.pas' {Frame_Usuario: TFrame},
  uCad.Fornecedor in 'uCad.Fornecedor.pas' {frmCad_Fornecedor},
  uCad.TabelaPreco in 'uCad.TabelaPreco.pas' {frmCad_TabelaPreco},
  uFrame.TabelaPreco in 'Frame\uFrame.TabelaPreco.pas' {Frame_TabelaPreco: TFrame},
  uFuncoes in '..\..\DeskTop\Fontes\Funcoes\uFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
