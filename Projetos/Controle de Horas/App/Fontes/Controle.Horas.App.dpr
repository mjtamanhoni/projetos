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
  uFuncoes in '..\..\DeskTop\Fontes\Funcoes\uFuncoes.pas',
  uCad.Cliente in 'uCad.Cliente.pas' {frmCad_Cliente},
  uCad.Conta in 'uCad.Conta.pas' {frmCad_Contas},
  uFrame.Conta in 'Frame\uFrame.Conta.pas' {Frame_Conta: TFrame},
  uCad.CondicaoPagto in 'uCad.CondicaoPagto.pas' {frmCad_CondicaoPagto},
  uFrame.CondicaoPagto in 'Frame\uFrame.CondicaoPagto.pas' {Frame_CondicaoPagto: TFrame},
  uCad.FormaPagto in 'uCad.FormaPagto.pas' {frmCad_FormaPagto},
  uFrame.FormaPagto in 'Frame\uFrame.FormaPagto.pas' {Frame_FormaPagto: TFrame},
  uFrame.CondFormaPagto in 'Frame\uFrame.CondFormaPagto.pas' {Frame_CondFormaPagto: TFrame},
  uFrame.SPData in 'Frame\uFrame.SPData.pas' {Frame_SP_Data: TFrame},
  uFrame.SPDados in 'Frame\uFrame.SPDados.pas' {Frame_SP_Dados: TFrame},
  uFrame.SPTotais in 'Frame\uFrame.SPTotais.pas' {Frame_SPTotal: TFrame},
  uMov.Financeiro in 'uMov.Financeiro.pas' {frmMov_Financeiro},
  uFrame.LancFinanceiro in 'Frame\uFrame.LancFinanceiro.pas' {Frame_LancFinanceiro: TFrame},
  uFrame.LancFinanceiro_H in 'Frame\uFrame.LancFinanceiro_H.pas' {Frame_LancFinanceiro_H: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
