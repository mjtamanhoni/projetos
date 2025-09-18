program TestNavegacaoEnter;

uses
  Vcl.Forms,
  uNavegacaoEnter in 'uNavegacaoEnter.pas',
  uExemploNavegacao in 'uExemploNavegacao.pas' {FormExemploNavegacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormExemploNavegacao, FormExemploNavegacao);
  Application.Run;
end.