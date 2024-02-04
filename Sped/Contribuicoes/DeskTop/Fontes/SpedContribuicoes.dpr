program SpedContribuicoes;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDm in 'uDm.pas' {dmSpedContribuicoes: TDataModule},
  uActionSheet in '..\..\..\..\Classes\99 Coders\Versao 11\uActionSheet.pas',
  uCombobox in '..\..\..\..\Classes\99 Coders\Versao 11\uCombobox.pas',
  uFancyDialog in '..\..\..\..\Classes\99 Coders\Versao 11\uFancyDialog.pas',
  uFormat in '..\..\..\..\Classes\99 Coders\Versao 11\uFormat.pas',
  uLoading in '..\..\..\..\Classes\99 Coders\Versao 11\uLoading.pas',
  uRegistros in 'uRegistros.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
