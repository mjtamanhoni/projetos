Program API_Servico;

Uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  CThreads,
{$ENDIF}{$ENDIF}
  DaemonApp, lazdaemonapp, uMapper, uAPI_Servico
  { add your units here };

begin
  Application.Initialize;
  Application.Run;
end.
