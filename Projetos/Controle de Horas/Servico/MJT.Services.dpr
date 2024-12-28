program MJT.Services;

uses
  Vcl.SvcMgr,
  uMJT.Services in 'uMJT.Services.pas' {srvMJTamanhoni: TService},
  uDm.Global.Wnd in '..\DeskTop\Fontes\Data_Modules\uDm.Global.Wnd.pas' {DM_Global_Wnd: TDataModule},
  uModelo.Dados.Wnd in '..\Global\Modelo de Dados\uModelo.Dados.Wnd.pas',
  uRotas in 'Rotas\uRotas.pas',
  uRota.Auth in 'Rotas\uRota.Auth.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TsrvMJTamanhoni, srvMJTamanhoni);
  Application.CreateForm(TDM_Global_Wnd, DM_Global_Wnd);
  Application.Run;
end.
