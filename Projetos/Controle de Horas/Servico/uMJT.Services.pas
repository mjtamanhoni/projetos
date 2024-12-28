unit uMJT.Services;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,

  uRotas,

  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

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
begin


  //Criar rotina para pegar o Token de acordo com o código do usuário passado.
  //Criar rotina para gravar um log no computador dos processos realizados pelo serviço.


  uRotas.RegistrarRotas;
end;

end.
