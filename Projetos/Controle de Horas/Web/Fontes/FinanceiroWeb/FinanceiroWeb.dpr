program FinanceiroWeb;

{$IFDEF D2BRIDGE}
 //{$APPTYPE CONSOLE}
{$ENDIF}



uses
  Vcl.Forms,
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
  uCad.Usuarios in 'uCad.Usuarios.pas' {frmCad_Usuarios};

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
