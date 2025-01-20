program Controle.Horas.WEB;

//{$APPTYPE CONSOLE}



uses
  Vcl.Forms,
  Prism.SessionBase in '..\D2Bridge Framework\Prism\Prism.SessionBase.pas' {PrismSessionBase: TDataModule},
  D2Bridge.ServerControllerBase in '..\D2Bridge Framework\D2Bridge.ServerControllerBase.pas' {D2BridgeServerControllerBase: TDataModule},
  D2BridgeFormTemplate in 'D2BridgeFormTemplate.pas',
  ServerController in 'ServerController.pas' {D2BridgeServerController: TDataModule},
  Unit_D2Bridge_Server in 'Unit_D2Bridge_Server.pas' {Form_D2Bridge_Server},
  UserSessionUnit in 'UserSessionUnit.pas' {PrismUserSession: TDataModule},
  uFormat.VCL in '..\..\..\..\Classes\99 Coders\Versao 11\uFormat.VCL.pas',
  uFormat_VCL in '..\..\..\..\Classes\99 Coders\Versao 11\uFormat_VCL.pas',
  uFuncoes.Wnd in '..\..\..\..\Global\uFuncoes.Wnd.pas',
  uDm.Global.Wnd in '..\..\..\DeskTop\Fontes\Data_Modules\uDm.Global.Wnd.pas' {DM_Global_Wnd: TDataModule},
  Unit_Login in 'Unit_Login.pas' {Form_Login};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:= True;
  Application.CreateForm(TForm_D2Bridge_Server, Form_D2Bridge_Server);
  Application.CreateForm(TD2BridgeServerControllerBase, D2BridgeServerControllerBase);
  Application.CreateForm(TD2BridgeServerController, D2BridgeServerController);
  Application.CreateForm(TForm_D2Bridge_Server, Form_D2Bridge_Server);
  Application.CreateForm(TDM_Global_Wnd, DM_Global_Wnd);
  Application.Run;
end.
