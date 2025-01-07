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
  uConfiguracoes in 'uConfiguracoes.pas' {frmConfiguracoes};

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
