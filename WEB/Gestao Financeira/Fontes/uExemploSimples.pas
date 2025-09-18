unit uExemploSimples;

{
  Exemplo simples de uso da navegação com Enter
  Demonstra diferentes formas de implementar a funcionalidade
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uNavegacaoEnter;

type
  // Exemplo 1: Uso básico com helper
  TFormExemploBasico = class(TForm)
    lblNome: TLabel;
    edtNome: TEdit;
    lblIdade: TLabel;
    edtIdade: TEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    btnOK: TButton;
    btnCancelar: TButton;
    procedure FormCreate(Sender: TObject);
  end;

  // Exemplo 2: Uso com configuração personalizada
  TFormExemploPersonalizado = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    edtCampo1: TEdit;
    edtCampo2: TEdit;
    edtCampo3: TEdit;
    edtCampo4: TEdit;
    edtCampo5: TEdit;
    memoTexto: TMemo;
    chkOpcao: TCheckBox;
    btnProcessar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

  // Exemplo 3: Uso com classe direta
  TFormExemploDireto = class(TForm)
    gbDados: TGroupBox;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    edtConfirmaSenha: TEdit;
    btnLogin: TButton;
    btnSair: TButton;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblConfirmaSenha: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FNavegacao: TNavegacaoEnter;
  end;

var
  FormExemploBasico: TFormExemploBasico;
  FormExemploPersonalizado: TFormExemploPersonalizado;
  FormExemploDireto: TFormExemploDireto;

implementation

{$R *.dfm}

{ TFormExemploBasico }

procedure TFormExemploBasico.FormCreate(Sender: TObject);
begin
  Caption := 'Exemplo Básico - Navegação com Enter';
  
  // Forma mais simples: usar o helper
  Self.AtivarNavegacaoEnter;
  
  // Opcional: adicionar exceções
  Self.AdicionarExcecaoNavegacao(btnCancelar);
end;

{ TFormExemploPersonalizado }

procedure TFormExemploPersonalizado.FormCreate(Sender: TObject);
var
  Config: TNavegacaoConfig;
begin
  Caption := 'Exemplo Personalizado - Navegação com Enter';
  
  // Configuração personalizada
  Config := TNavegacaoConfig.Default;
  Config.AtivarSom := True;              // Som ao navegar
  Config.NavegacaoCircular := False;     // Não voltar ao início
  Config.IgnorarReadOnly := True;        // Pular campos ReadOnly
  
  // Ativar com configuração personalizada
  Self.AtivarNavegacaoEnter(Config);
  
  // Memo não deve usar Enter para navegação
  Self.AdicionarExcecaoNavegacao(memoTexto);
end;

procedure TFormExemploPersonalizado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Opcional: desativar explicitamente (é feito automaticamente)
  Self.DesativarNavegacaoEnter;
end;

{ TFormExemploDireto }

procedure TFormExemploDireto.FormCreate(Sender: TObject);
var
  Config: TNavegacaoConfig;
begin
  Caption := 'Exemplo Direto - Navegação com Enter';
  
  // Usar a classe diretamente (mais controle)
  Config := TNavegacaoConfig.Default;
  Config.AtivarSom := False;
  Config.NavegacaoCircular := True;
  
  FNavegacao := TNavegacaoEnter.Create(Self);
  FNavegacao.Config := Config;
  
  // Adicionar exceções
  FNavegacao.AdicionarExcecao(btnSair);
  FNavegacao.AdicionarExcecao(edtSenha); // Exemplo: senha não navega automaticamente
end;

procedure TFormExemploDireto.FormDestroy(Sender: TObject);
begin
  // Limpar instância manual
  FNavegacao.Free;
  inherited;
end;

end.