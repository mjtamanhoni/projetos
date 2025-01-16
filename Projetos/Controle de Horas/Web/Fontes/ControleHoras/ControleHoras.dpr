program ControleHoras;

{$IFDEF D2BRIDGE}
 {$APPTYPE CONSOLE}
{$ENDIF}



uses
  Vcl.Forms,
  D2Bridge.Instance,
  D2Bridge.ServerControllerBase in 'C:\Instalacoes\D2Bridge\D2Bridge Framework\D2Bridge.ServerControllerBase.pas' {D2BridgeServerControllerBase: TDataModule},
  Prism.SessionBase in 'C:\Instalacoes\D2Bridge\D2Bridge Framework\Prism\Prism.SessionBase.pas' {PrismSessionBase: TPrismSessionBase},
  ControleHorasWebApp in 'ControleHorasWebApp.pas' {ControleHorasWebAppGlobal},
  ControleHoras_Session in 'ControleHoras_Session.pas' {ControleHorasSession},
  D2BridgeFormTemplate in 'D2BridgeFormTemplate.pas',
  Unit_Login in 'Unit_Login.pas',
  Unit_D2Bridge_Server_Console in 'Unit_D2Bridge_Server_Console.pas',
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uCad.Usuarios in 'uCad.Usuarios.pas' {frmCad_Usuarios},
  uCad.Usuarios.Add in 'uCad.Usuarios.Add.pas' {frmCad_Usuario_ADD},
  uFormat.VCL in '..\..\..\..\Classes\99 Coders\Versao 11\uFormat.VCL.pas',
  uConfiguracoes in 'uConfiguracoes.pas' {frmConfiguracoes},
  uCad.Empresa in 'uCad.Empresa.pas' {frmCad_Empresa},
  uCad.Empresa.Add in 'uCad.Empresa.Add.pas' {frmCad_Empresa_Add},
  uCad.PrestServico in 'uCad.PrestServico.pas' {frmCad_PrestServico},
  uCad.PrestServico.Add in 'uCad.PrestServico.Add.pas' {frmCad_PrestServico_Add},
  uCad.Cliente in 'uCad.Cliente.pas' {frmCad_Cliente},
  uCad.Cliente.Add in 'uCad.Cliente.Add.pas' {frmCad_Cliente_Add},
  uCad.Fornecedor in 'uCad.Fornecedor.pas' {frmCad_Fornecedor},
  uCad.Fornecedor.Add in 'uCad.Fornecedor.Add.pas' {frmCad_Fornecedor_Add},
  uCon.Fornecedor in 'uCon.Fornecedor.pas' {frmCon_Fornecedor},
  uCon.TabPreco in 'uCon.TabPreco.pas' {frmCon_TabPreco},
  uCad.TabPreco in 'uCad.TabPreco.pas' {frmCad_TabPreco},
  uCad.TabPreco.Add in 'uCad.TabPreco.Add.pas' {frmCad_TabPreco_Add},
  uCad.Conta in 'uCad.Conta.pas' {frmCad_Conta},
  uCad.Conta.Add in 'uCad.Conta.Add.pas' {frmCad_Conta_Add},
  uCad.CondPagto in 'uCad.CondPagto.pas' {frmCad_CondPagto},
  uCad.CondPagto.Add in 'uCad.CondPagto.Add.pas' {frmCad_CondPagto_Add},
  uCad.FormaPagto in 'uCad.FormaPagto.pas' {frmCad_FormaPagto},
  uCad.FormaPagto.Add in 'uCad.FormaPagto.Add.pas' {frmCad_FormaPagto_Add},
  uCad.Forma.Cond.Add in 'uCad.Forma.Cond.Add.pas' {frmFormaCond_Add},
  uCon.ServisoPrestados in 'uCon.ServisoPrestados.pas' {frmCon_ServicosPrestados},
  uCon.Cliente in 'uCon.Cliente.pas' {frmCon_Cliente},
  uFuncoes.Wnd in '..\..\..\..\Global\uFuncoes.Wnd.pas',
  uMov.ServicosPrestados in 'uMov.ServicosPrestados.pas' {frmMov_ServicosPrestados},
  uMov.ServicosPrestados.Add in 'uMov.ServicosPrestados.Add.pas' {frmMov_ServicosPrestados_Add};

{$R *.res}

{$IFNDEF D2BRIDGE}
var
  Unit_Login: TForm_Login;
{$ENDIF}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar:= False;
  {$IFNDEF D2BRIDGE}
  Application.CreateForm(TForm_Login, Unit_Login);
  D2BridgeInstance.AddInstace(Unit_Login);
  Application.Run;
  {$ELSE}
  TD2BridgeServerConsole.Run
  
  {$ENDIF}
end.
