program Controle_Horas.Servidor;

uses
  System.StartUpCopy,
  FMX.Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  uRota.Auth in '..\..\..\Global\Rotas\uRota.Auth.pas',
  uDm.Servidor in 'uDm.Servidor.pas' {DM_Servidor: TDataModule},
  uConfig in 'uConfig.pas' {frmConfiguracoes},
  uFancyDialog in '..\..\..\Classes\99 Coders\Versao 11\uFancyDialog.pas',
  uLoading in '..\..\..\Classes\99 Coders\Versao 11\uLoading.pas',
  uEstrutura.Gerar in '..\..\..\Global\uEstrutura.Gerar.pas' {frmCriarEstrutura},
  uModel.CLIENTE in 'Modelo de Dados\uModel.CLIENTE.pas',
  uModel.CLIENTE_TABELA in 'Modelo de Dados\uModel.CLIENTE_TABELA.pas',
  uModel.HISTORICO in 'Modelo de Dados\uModel.HISTORICO.pas',
  uModel.PRESTADOR_SERVICO in 'Modelo de Dados\uModel.PRESTADOR_SERVICO.pas',
  uModel.SERVICOS_PRESTADOS in 'Modelo de Dados\uModel.SERVICOS_PRESTADOS.pas',
  uModel.TABELA_PRECO in 'Modelo de Dados\uModel.TABELA_PRECO.pas',
  uModel.USUARIO in 'Modelo de Dados\uModel.USUARIO.pas',
  uRota.CLIENTE in 'Rotas\uRota.CLIENTE.pas',
  uRota.CLIENTE_TABELA in 'Rotas\uRota.CLIENTE_TABELA.pas',
  uRota.HISTORICO in 'Rotas\uRota.HISTORICO.pas',
  uRota.PRESTADOR_SERVICO in 'Rotas\uRota.PRESTADOR_SERVICO.pas',
  uRota.SERVICOS_PRESTADOS in 'Rotas\uRota.SERVICOS_PRESTADOS.pas',
  uRota.TABELA_PRECO in 'Rotas\uRota.TABELA_PRECO.pas',
  uRota.USUARIO in 'Rotas\uRota.USUARIO.pas',
  uFuncoes in '..\..\..\Global\uFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
