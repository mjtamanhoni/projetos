program Servico_Emissor;
{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, SvcMgr, uServico_Emis,
uApiController; // Unit1 é a unit do serviço

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMeuServico, MeuServico);
  Application.Run;
end.

