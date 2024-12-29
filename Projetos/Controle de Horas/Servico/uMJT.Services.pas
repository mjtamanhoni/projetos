unit uMJT.Services;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.Math,
  System.JSON, System.DateUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, Vcl.ExtCtrls,

  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  Horse.CORS,
  Dataset.Serialize,
  RESTRequest4D,
  Dataset.Serialize.Config,

  uRotas;


type
  TsrvMJTamanhoni = class(TService)
    procedure ServiceExecute(Sender: TService);
  private

  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  srvMJTamanhoni: TsrvMJTamanhoni;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvMJTamanhoni.Controller(CtrlCode);
end;

function TsrvMJTamanhoni.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvMJTamanhoni.ServiceExecute(Sender: TService);
var
  FPorta:Integer;
begin

  //Criar rotina para pegar o Token de acordo com o código do usuário passado.
  //Criar rotina para gravar um log no computador dos processos realizados pelo serviço.

  THorse.Use(Jhonson());
  THorse.Use(CORS);

  uRotas.RegistrarRotas;

  FPorta := 0;
  FPorta := 3000;

  THorse.Listen(FPorta,procedure(Horse:THorse)
  begin

  end);

  while not Self.Terminated do
  begin
    ServiceThread.ProcessRequests(True);
  end;
end;

end.
