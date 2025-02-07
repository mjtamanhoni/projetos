program FinanceiroWeb;

{$IFDEF D2BRIDGE}
 //{$APPTYPE CONSOLE}
{$ENDIF}



uses
  Vcl.Forms,
  System.SysUtils,
  D2Bridge.Instance,
  D2Bridge.ServerControllerBase in 'C:\Instalacoes\D2Bridge\D2Bridge Framework\D2Bridge.ServerControllerBase.pas' {D2BridgeServerControllerBase: TDataModule},
  Prism.SessionBase in 'C:\Instalacoes\D2Bridge\D2Bridge Framework\Prism\Prism.SessionBase.pas' {PrismSessionBase: TPrismSessionBase},
  FinanceiroWebWebApp in 'FinanceiroWebWebApp.pas' {FinanceiroWebWebAppGlobal},
  FinanceiroWeb_Session in 'FinanceiroWeb_Session.pas' {FinanceiroWebSession},
  D2BridgeFormTemplate in 'D2BridgeFormTemplate.pas',
  Unit_Login in 'Unit_Login.pas',
  Unit_D2Bridge_Server in 'Unit_D2Bridge_Server.pas',
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uConfiguracoes in 'uConfiguracoes.pas' {frmConfiguracoes},
  uCad.Usuarios.Add in 'uCad.Usuarios.Add.pas' {frmCad_Usuario_ADD},
  uCad.Usuarios in 'uCad.Usuarios.pas' {frmCad_Usuarios},
  uCad.Empresa.Add in 'uCad.Empresa.Add.pas' {frmCad_Empresa_Add},
  uCad.Empresa in 'uCad.Empresa.pas' {frmCad_Empresa},
  uCad.PrestServico.Add in 'uCad.PrestServico.Add.pas' {frmCad_PrestServico_Add},
  uCad.PrestServico in 'uCad.PrestServico.pas' {frmCad_PrestServico},
  uCad.Cliente.Add in 'uCad.Cliente.Add.pas' {frmCad_Cliente_Add},
  uCad.Cliente in 'uCad.Cliente.pas' {frmCad_Cliente},
  uCad.Fornecedor.Add in 'uCad.Fornecedor.Add.pas' {frmCad_Fornecedor_Add},
  uCad.Fornecedor in 'uCad.Fornecedor.pas' {frmCad_Fornecedor},
  uCad.TabPreco.Add in 'uCad.TabPreco.Add.pas' {frmCad_TabPreco_Add},
  uCad.TabPreco in 'uCad.TabPreco.pas' {frmCad_TabPreco},
  uCon.Cliente in 'uCon.Cliente.pas' {frmCon_Cliente},
  uCon.Fornecedor in 'uCon.Fornecedor.pas' {frmCon_Fornecedor},
  uCon.TabPreco in 'uCon.TabPreco.pas' {frmCon_TabPreco},
  uCad.Conta in 'uCad.Conta.pas' {frmCad_Conta},
  uCad.Conta.Add in 'uCad.Conta.Add.pas' {frmCad_Conta_Add},
  uCad.CondPagto.Add in 'uCad.CondPagto.Add.pas' {frmCad_CondPagto_Add},
  uCad.CondPagto in 'uCad.CondPagto.pas' {frmCad_CondPagto},
  uCad.FormaPagto.Add in 'uCad.FormaPagto.Add.pas' {frmCad_FormaPagto_Add},
  uCad.FormaPagto in 'uCad.FormaPagto.pas' {frmCad_FormaPagto},
  uDemo.ServicosPrestados in 'uDemo.ServicosPrestados.pas' {frmDemo_ServicosPrestados},
  uMov.ServPrestados in 'uMov.ServPrestados.pas' {frmMov_ServPrestados},
  uMov.ServPrestados.Add in 'uMov.ServPrestados.Add.pas' {frmMov_ServPrestados_Add},
  uCon.Empresa in 'uCon.Empresa.pas' {frmCon_Empresa},
  uCon.PrestServicos in 'uCon.PrestServicos.pas' {frmCon_PrestServicos},
  uCon.Contas in 'uCon.Contas.pas' {frmCon_Contas},
  uFuncoes.Wnd in '..\..\..\..\Global\uFuncoes.Wnd.pas';

{$R *.res}

{$IFNDEF D2BRIDGE}
var
  Unit_Login: TForm_Login;
{$ENDIF}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar:= True;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.ThousandSeparator := '.';
  FormatSettings.DecimalSeparator := ',';
  Application.MainFormOnTaskBar := False;
  {$IFNDEF D2BRIDGE}
  Application.CreateForm(TForm_Login, Unit_Login);
  D2BridgeInstance.AddInstace(Unit_Login);
  Application.Run;
  {$ELSE}
  Application.CreateForm(TForm_D2Bridge_Server, Form_D2Bridge_Server);
  Application.Run;
  {$ENDIF}
end.
