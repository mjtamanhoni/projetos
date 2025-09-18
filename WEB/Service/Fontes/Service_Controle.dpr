program Service_Controle;

uses
  Vcl.SvcMgr,
  uService in 'uService.pas' {MJT_Controle: TService},
  uDM in 'uDM.pas' {DM: TDataModule},
  uFuncoes.Gerais in '..\..\..\Global\uFuncoes.Gerais.pas',
  uRota.Publica in 'Rotas\uRota.Publica.pas',
  uRota.Cadastro in 'Rotas\uRota.Cadastro.pas',
  uRota.Movimento in 'Rotas\uRota.Movimento.pas',
  uModel.Publico in 'Modelo_Dados\uModel.Publico.pas',
  uModel.Cadastro in 'Modelo_Dados\uModel.Cadastro.pas',
  uModel.Movimento in 'Modelo_Dados\uModel.Movimento.pas',
  uRota.Auth in '..\..\..\Global\uRota.Auth.pas';

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
  Application.CreateForm(TMJT_Controle, MJT_Controle);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
