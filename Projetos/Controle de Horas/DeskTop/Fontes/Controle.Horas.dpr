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
  uCad.PrestServico in 'uCad.PrestServico.pas' {frmCad_PrestServico},
  uCad.Cliente in 'uCad.Cliente.pas' {frmCad_Cliente},
  uCad.TabPrecos in 'uCad.TabPrecos.pas' {frmCad_TabPrecos},
  uMov.ServicosPrestados in 'uMov.ServicosPrestados.pas' {frmMov_ServicosPrestados},
  uCad.Contas in 'uCad.Contas.pas' {frmCad_Contas},
  uCad.Empresa in 'uCad.Empresa.pas' {frmCad_Empresa},
  uCad.Fornecedor in 'uCad.Fornecedor.pas' {frmCad_Fornecedor},
  uFuncoes in 'Funcoes\uFuncoes.pas',
  uActionSheet in '..\..\..\Classes\99 Coders\Versao 11\uActionSheet.pas',
  uLanc_Financeiros in 'uLanc_Financeiros.pas' {frmLanc_Financeiros},
  uPesq_Pessoas in 'uPesq_Pessoas.pas' {frmPesq_Pessoas},
  uCad.FormaPagamento in 'uCad.FormaPagamento.pas' {frmFormaPagamento},
  uCad.CondicaoPagamento in 'uCad.CondicaoPagamento.pas' {frmCondicao_Pagamento},
  uPesq_FormaCond_Pagto in 'uPesq_FormaCond_Pagto.pas' {frmPesq_FormaCond_Pagto};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
