unit uExemploNavegacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, Datasnap.DBClient, uNavegacaoEnter;

type
  TFormExemploNavegacao = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    gbDadosPessoais: TGroupBox;
    lblNome: TLabel;
    edtNome: TEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblTelefone: TLabel;
    edtTelefone: TMaskEdit;
    lblDataNascimento: TLabel;
    dtpDataNascimento: TDateTimePicker;
    gbEndereco: TGroupBox;
    lblCEP: TLabel;
    edtCEP: TMaskEdit;
    lblLogradouro: TLabel;
    edtLogradouro: TEdit;
    lblNumero: TLabel;
    edtNumero: TEdit;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblUF: TLabel;
    cmbUF: TComboBox;
    gbPreferencias: TGroupBox;
    chkReceberEmails: TCheckBox;
    chkReceberSMS: TCheckBox;
    rgTipoContato: TRadioGroup;
    lblObservacoes: TLabel;
    memoObservacoes: TMemo;
    pnlBotoes: TPanel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    btnLimpar: TButton;
    pnlConfiguracoes: TPanel;
    gbConfiguracoes: TGroupBox;
    chkNavegacaoCircular: TCheckBox;
    chkIgnorarReadOnly: TCheckBox;
    chkAtivarSom: TCheckBox;
    btnAplicarConfig: TButton;
    btnResetConfig: TButton;
    lblExcecoes: TLabel;
    lbExcecoes: TListBox;
    btnAdicionarExcecao: TButton;
    btnRemoverExcecao: TButton;
    lblInstrucoes: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAplicarConfigClick(Sender: TObject);
    procedure btnResetConfigClick(Sender: TObject);
    procedure btnAdicionarExcecaoClick(Sender: TObject);
    procedure btnRemoverExcecaoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
  private
    procedure ConfigurarFormulario;
    procedure PreencherUFs;
    procedure AtualizarListaExcecoes;
    procedure BuscarCEP(const CEP: string);
    procedure LimparCampos;
  public
    { Public declarations }
  end;

var
  FormExemploNavegacao: TFormExemploNavegacao;

implementation

{$R *.dfm}

procedure TFormExemploNavegacao.FormCreate(Sender: TObject);
begin
  ConfigurarFormulario;
  PreencherUFs;
  
  // Ativar navegação com Enter usando o helper
  Self.AtivarNavegacaoEnter;
  
  // Configurar alguns campos como exceção por padrão
  Self.AdicionarExcecaoNavegacao(memoObservacoes); // Memo precisa do Enter para quebra de linha
  Self.AdicionarExcecaoNavegacao(btnCancelar);     // Botão cancelar não deve ser navegado automaticamente
  
  AtualizarListaExcecoes;
end;

procedure TFormExemploNavegacao.FormDestroy(Sender: TObject);
begin
  // A navegação é automaticamente desativada quando o form é destruído
  Self.DesativarNavegacaoEnter;
end;

procedure TFormExemploNavegacao.ConfigurarFormulario;
begin
  Caption := 'Exemplo de Navegação com Enter - Delphi 11+';
  Position := poScreenCenter;
  Width := 800;
  Height := 700;
  
  // Configurar TabOrder para navegação lógica
  edtNome.TabOrder := 0;
  edtEmail.TabOrder := 1;
  edtTelefone.TabOrder := 2;
  dtpDataNascimento.TabOrder := 3;
  edtCEP.TabOrder := 4;
  edtLogradouro.TabOrder := 5;
  edtNumero.TabOrder := 6;
  edtComplemento.TabOrder := 7;
  edtBairro.TabOrder := 8;
  edtCidade.TabOrder := 9;
  cmbUF.TabOrder := 10;
  chkReceberEmails.TabOrder := 11;
  chkReceberSMS.TabOrder := 12;
  rgTipoContato.TabOrder := 13;
  memoObservacoes.TabOrder := 14;
  btnSalvar.TabOrder := 15;
  btnLimpar.TabOrder := 16;
  
  // Configurar máscaras
  edtTelefone.EditMask := '(99) 99999-9999;1;_';
  edtCEP.EditMask := '99999-999;1;_';
  
  // Configurar instruções
  lblInstrucoes.Caption := 
    'Instruções:' + #13#10 +
    '• Use ENTER para navegar entre os campos' + #13#10 +
    '• A navegação segue a ordem do TabOrder' + #13#10 +
    '• Campos ReadOnly e Disabled são ignorados' + #13#10 +
    '• Configure exceções na seção de configurações' + #13#10 +
    '• O Memo e botão Cancelar estão nas exceções por padrão';
end;

procedure TFormExemploNavegacao.PreencherUFs;
begin
  cmbUF.Items.Clear;
  cmbUF.Items.AddStrings([
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO',
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI',
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ]);
end;

procedure TFormExemploNavegacao.btnAplicarConfigClick(Sender: TObject);
var
  Config: TNavegacaoConfig;
begin
  // Criar configuração personalizada
  Config := TNavegacaoConfig.Default;
  Config.NavegacaoCircular := chkNavegacaoCircular.Checked;
  Config.IgnorarReadOnly := chkIgnorarReadOnly.Checked;
  Config.AtivarSom := chkAtivarSom.Checked;
  
  // Reativar com nova configuração
  Self.DesativarNavegacaoEnter;
  Self.AtivarNavegacaoEnter(Config);
  
  // Reaplicar exceções
  Self.AdicionarExcecaoNavegacao(memoObservacoes);
  Self.AdicionarExcecaoNavegacao(btnCancelar);
  
  ShowMessage('Configurações aplicadas com sucesso!');
end;

procedure TFormExemploNavegacao.btnResetConfigClick(Sender: TObject);
begin
  // Resetar checkboxes
  chkNavegacaoCircular.Checked := True;
  chkIgnorarReadOnly.Checked := True;
  chkAtivarSom.Checked := False;
  
  // Aplicar configuração padrão
  btnAplicarConfigClick(Sender);
end;

procedure TFormExemploNavegacao.btnAdicionarExcecaoClick(Sender: TObject);
var
  ControlName: string;
  Control: TControl;
  I: Integer;
begin
  ControlName := InputBox('Adicionar Exceção', 
    'Digite o nome do controle (ex: edtNome, btnSalvar):', '');
    
  if ControlName <> '' then
  begin
    Control := FindComponent(ControlName) as TControl;
    if Assigned(Control) then
    begin
      Self.AdicionarExcecaoNavegacao(Control);
      AtualizarListaExcecoes;
      ShowMessage('Controle "' + ControlName + '" adicionado às exceções.');
    end
    else
      ShowMessage('Controle "' + ControlName + '" não encontrado.');
  end;
end;

procedure TFormExemploNavegacao.btnRemoverExcecaoClick(Sender: TObject);
var
  Instance: TNavegacaoEnter;
  Control: TControl;
begin
  if lbExcecoes.ItemIndex >= 0 then
  begin
    Control := TControl(lbExcecoes.Items.Objects[lbExcecoes.ItemIndex]);
    Instance := TNavegacaoEnter.GetInstance(Self);
    if Assigned(Instance) then
    begin
      Instance.RemoverExcecao(Control);
      AtualizarListaExcecoes;
      ShowMessage('Exceção removida com sucesso.');
    end;
  end
  else
    ShowMessage('Selecione uma exceção para remover.');
end;

procedure TFormExemploNavegacao.AtualizarListaExcecoes;
var
  Instance: TNavegacaoEnter;
  I: Integer;
  Control: TControl;
begin
  lbExcecoes.Items.Clear;
  
  Instance := TNavegacaoEnter.GetInstance(Self);
  if Assigned(Instance) then
  begin
    for I := 0 to Instance.Excecoes.Count - 1 do
    begin
      Control := Instance.Excecoes[I];
      lbExcecoes.Items.AddObject(Control.Name + ' (' + Control.ClassName + ')', Control);
    end;
  end;
end;

procedure TFormExemploNavegacao.edtCEPExit(Sender: TObject);
begin
  if Length(Trim(edtCEP.Text)) = 9 then // 99999-999
    BuscarCEP(edtCEP.Text);
end;

procedure TFormExemploNavegacao.BuscarCEP(const CEP: string);
begin
  // Simulação de busca de CEP
  if CEP = '01310-100' then
  begin
    edtLogradouro.Text := 'Avenida Paulista';
    edtBairro.Text := 'Bela Vista';
    edtCidade.Text := 'São Paulo';
    cmbUF.Text := 'SP';
  end
  else if CEP = '20040-020' then
  begin
    edtLogradouro.Text := 'Rua da Assembleia';
    edtBairro.Text := 'Centro';
    edtCidade.Text := 'Rio de Janeiro';
    cmbUF.Text := 'RJ';
  end
  else
  begin
    // CEP não encontrado - limpar campos
    edtLogradouro.Text := '';
    edtBairro.Text := '';
    edtCidade.Text := '';
    cmbUF.Text := '';
  end;
end;

procedure TFormExemploNavegacao.btnSalvarClick(Sender: TObject);
var
  Dados: TStringList;
begin
  Dados := TStringList.Create;
  try
    Dados.Add('=== DADOS SALVOS ===');
    Dados.Add('Nome: ' + edtNome.Text);
    Dados.Add('Email: ' + edtEmail.Text);
    Dados.Add('Telefone: ' + edtTelefone.Text);
    Dados.Add('Data Nascimento: ' + DateToStr(dtpDataNascimento.Date));
    Dados.Add('CEP: ' + edtCEP.Text);
    Dados.Add('Logradouro: ' + edtLogradouro.Text);
    Dados.Add('Número: ' + edtNumero.Text);
    Dados.Add('Complemento: ' + edtComplemento.Text);
    Dados.Add('Bairro: ' + edtBairro.Text);
    Dados.Add('Cidade: ' + edtCidade.Text);
    Dados.Add('UF: ' + cmbUF.Text);
    Dados.Add('Receber Emails: ' + BoolToStr(chkReceberEmails.Checked, True));
    Dados.Add('Receber SMS: ' + BoolToStr(chkReceberSMS.Checked, True));
    Dados.Add('Tipo Contato: ' + IntToStr(rgTipoContato.ItemIndex));
    Dados.Add('Observações: ' + memoObservacoes.Text);
    
    ShowMessage(Dados.Text);
    
    // Após salvar, navegar para o próximo controle (btnLimpar)
    if btnLimpar.CanFocus then
      btnLimpar.SetFocus;
  finally
    Dados.Free;
  end;
end;

procedure TFormExemploNavegacao.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente cancelar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TFormExemploNavegacao.btnLimparClick(Sender: TObject);
begin
  if MessageDlg('Limpar todos os campos?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    LimparCampos;
end;

procedure TFormExemploNavegacao.LimparCampos;
begin
  edtNome.Clear;
  edtEmail.Clear;
  edtTelefone.Clear;
  dtpDataNascimento.Date := Now;
  edtCEP.Clear;
  edtLogradouro.Clear;
  edtNumero.Clear;
  edtComplemento.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  cmbUF.ItemIndex := -1;
  chkReceberEmails.Checked := False;
  chkReceberSMS.Checked := False;
  rgTipoContato.ItemIndex := -1;
  memoObservacoes.Clear;
  
  edtNome.SetFocus;
end;

end.