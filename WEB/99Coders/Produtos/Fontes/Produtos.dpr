program Produtos;

{$IFDEF D2BRIDGE}
 //{$APPTYPE CONSOLE}
{$ENDIF}



uses
  Vcl.Forms,
  D2Bridge.Instance,
  D2Bridge.ServerControllerBase in '..\..\D2Bridge Framework\D2Bridge.ServerControllerBase.pas' {D2BridgeServerControllerBase: TDataModule},
  Prism.SessionBase in '..\..\D2Bridge Framework\Prism\Prism.SessionBase.pas' {PrismSessionBase: TPrismSessionBase},
  ProdutosWebApp in 'ProdutosWebApp.pas' {ProdutosWebAppGlobal},
  Produtos_Session in 'Produtos_Session.pas' {ProdutosSession},
  D2BridgeFormTemplate in 'D2BridgeFormTemplate.pas',
  Unit_D2Bridge_Server in 'Unit_D2Bridge_Server.pas' {Form_D2Bridge_Server},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal};

{$R *.res}

{$IFNDEF D2BRIDGE}
var
  uPrincipal: TForm1;
{$ENDIF}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar:= True;
  {$IFNDEF D2BRIDGE}
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    D2BridgeInstance.AddInstace(uPrincipal);
    Application.Run;
  {$ELSE}
  Application.CreateForm(TForm_D2Bridge_Server, Form_D2Bridge_Server);
  Application.Run;
  {$ENDIF}
end.
