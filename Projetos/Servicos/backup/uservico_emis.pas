unit uServico_Emis;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SvcMgr;

type
  TMeuServico = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
  public
    function GetServiceController: TServiceController; override;
  end;

var
  MeuServico: TMeuServico;

implementation

function TMeuServico.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMeuServico.ServiceCreate(Sender: TObject);
begin
  // Código ao criar o serviço
end;

procedure TMeuServico.ServiceStart(Sender: TService; var Started: Boolean);
begin
  // Código ao iniciar o serviço
  LogMessage('Serviço iniciado!');
  Started := True;
end;

procedure TMeuServico.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  // Código ao parar o serviço
  LogMessage('Serviço parado!');
  Stopped := True;
end;

end.
