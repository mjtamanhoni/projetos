program Gestao_Financeira;

{$IFDEF D2BRIDGE}
 //{$APPTYPE CONSOLE}
{$ENDIF}



uses
  Vcl.Forms,
  D2Bridge.Instance,
  D2Bridge.ServerControllerBase in '..\..\..\..\Frameworks\D2Bridge\D2Bridge Framework\D2Bridge.ServerControllerBase.pas' {D2BridgeServerControllerBase: TDataModule},
  Prism.SessionBase in '..\..\..\..\Frameworks\D2Bridge\D2Bridge Framework\Prism\Prism.SessionBase.pas' {PrismSessionBase: TPrismSessionBase},
  Gestao_FinanceiraWebApp in 'Gestao_FinanceiraWebApp.pas' {Gestao_FinanceiraWebAppGlobal},
  Gestao_Financeira_Session in 'Gestao_Financeira_Session.pas' {Gestao_FinanceiraSession},
  D2BridgeFormTemplate in 'D2BridgeFormTemplate.pas',
  Unit_Login in 'Unit_Login.pas' {Form_Login},
  Unit_D2Bridge_Server in 'Unit_D2Bridge_Server.pas' {Form_D2Bridge_Server},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uFuncoes.Gerais in '..\..\..\Global\uFuncoes.Gerais.pas',
  uCalculadoraExpressao in '..\..\..\Global\uCalculadoraExpressao.pas',
  uValidacaoDocumentos in '..\..\..\Global\uValidacaoDocumentos.pas',
  uProjetos in 'uProjetos.pas' {frmProjetos},
  uProjetos.Cad in 'uProjetos.Cad.pas' {frmProjetos_Cad},
  uProjetos.Loc in 'uProjetos.Loc.pas' {frmProjetos_Loc},
  uTIpoFormulario in 'uTIpoFormulario.pas' {frmTipoFormulario},
  uTIpoFormulario.Cad in 'uTIpoFormulario.Cad.pas' {frmTipoFormulario_Cad},
  uTIpoFormulario.Loc in 'uTIpoFormulario.Loc.pas' {frmTipoFormulario_Loc},
  uForm_Projeto in 'uForm_Projeto.pas' {frmForm_Projeto},
  uForm_Projeto.Cad in 'uForm_Projeto.Cad.pas' {frmForm_Projeto_Cad},
  uForm_Projeto.Loc in 'uForm_Projeto.Loc.pas' {frmForm_Projeto_Loc},
  uNavegacaoEnter in '..\..\..\Global\uNavegacaoEnter.pas',
  uUsuarios in 'uUsuarios.pas' {frmUsuarios},
  uUsuarios.Cad in 'uUsuarios.Cad.pas' {frmUsuarios_Cad},
  uUsuarios.Loc in 'uUsuarios.Loc.pas' {frmUsuarios_Loc},
  uEmpresa in 'uEmpresa.pas' {frmEmpresa},
  uEmpresa.Cad in 'uEmpresa.Cad.pas' {frmEmpresa_Cad},
  uEmpresa.Loc in 'uEmpresa.Loc.pas' {frmEmpresa_Loc},
  uRegioes in 'uRegioes.pas' {frmRegioes},
  uRegioes.Cad in 'uRegioes.Cad.pas' {frmRegioes_Cad},
  uRegioes.Loc in 'uRegioes.Loc.pas' {frmRegioes_Loc},
  uUnidadeFederativa in 'uUnidadeFederativa.pas' {frmUnidadeFederativa},
  uUnidadeFederativa.Cad in 'uUnidadeFederativa.Cad.pas' {frmUnidadeFederativa_Cad},
  uUnidadeFederativa.Loc in 'uUnidadeFederativa.Loc.pas' {frmUnidadeFederativa_Loc},
  uMunicipios in 'uMunicipios.pas' {frmMunicipios},
  uMunicipios.Cad in 'uMunicipios.Cad.pas' {frmMunicipios_Cad},
  uMunicipios.Loc in 'uMunicipios.Loc.pas' {frmMunicipios_Loc},
  uUsuarios.Permissoes in 'uUsuarios.Permissoes.pas' {Form1},
  uUsuarios.Empresa in 'uUsuarios.Empresa.pas' {Form2};

{$R *.res}

{$IFNDEF D2BRIDGE}
var
  Unit_Login: TForm_Login;
{$ENDIF}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar:= True;
  {$IFNDEF D2BRIDGE}
  Application.CreateForm(TForm_Login, Unit_Login);
  D2BridgeInstance.AddInstace(Unit_Login);
  Application.Run;
  {$ELSE}
  Application.CreateForm(TForm_D2Bridge_Server, Form_D2Bridge_Server);
  Application.Run;
  {$ENDIF}
end.
