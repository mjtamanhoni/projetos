program Controle.Horas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  uFuncoes in '..\..\..\Global\Versao 12\uFuncoes.pas',
  uFancyDialog in '..\..\..\Classes\99 Coders\Versao 11\uFancyDialog.pas',
  uLoading in '..\..\..\Classes\99 Coders\Versao 11\uLoading.pas',
  uUsuario in 'uUsuario.pas' {frmUsuario},
  uCamera in '..\..\..\Global\uCamera.pas' {frmCamera},
  uActionSheet in '..\..\..\Classes\99 Coders\Versao 11\uActionSheet.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
