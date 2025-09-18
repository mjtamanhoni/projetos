unit uTelasProjetos.Cad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.Client;

type
  TfrmTelasProjetosCad = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlCenter: TPanel;
    
    // Campos baseados na estrutura da tabela (ajustar conforme necessário)
    lblId: TLabel;
    edtId: TEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    lblDescricao: TLabel;
    memoDescricao: TMemo;
    
    btnSalvar: TButton;
    btnCancelar: TButton;
    
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FID: Integer;
    procedure CarregarRegistro;
    procedure LimparCampos;
    function ValidarCampos: Boolean;
    procedure SalvarRegistro;
  public
    class function Executar(const AID: Integer): Boolean;
  end;

implementation

uses
  uDM;

{$R *.dfm}

class function TfrmTelasProjetosCad.Executar(const AID: Integer): Boolean;
var
  frm: TfrmTelasProjetosCad;
begin
  frm := TfrmTelasProjetosCad.Create(nil);
  try
    frm.FID := AID;
    if AID > 0 then
      frm.CarregarRegistro
    else
      frm.LimparCampos;
      
    Result := frm.ShowModal = mrOk;
  finally
    frm.Free;
  end;
end;

procedure TfrmTelasProjetosCad.FormCreate(Sender: TObject);
begin
  // Configurações iniciais do formulário
end;

procedure TfrmTelasProjetosCad.CarregarRegistro;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := DM.Connection;
    qry.SQL.Text := 'SELECT * FROM public.telas_projetos WHERE id = :id';
    qry.ParamByName('id').AsInteger := FID;
    qry.Open;
    
    if not qry.IsEmpty then
    begin
      edtId.Text := qry.FieldByName('id').AsString;
      edtNome.Text := qry.FieldByName('nome').AsString; // Ajustar campo
      memoDescricao.Text := qry.FieldByName('descricao').AsString; // Ajustar campo
      // Carregar outros campos conforme estrutura da tabela
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmTelasProjetosCad.LimparCampos;
begin
  edtId.Clear;
  edtNome.Clear;
  memoDescricao.Clear;
  // Limpar outros campos
end;

function TfrmTelasProjetosCad.ValidarCampos: Boolean;
begin
  Result := True;
  
  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Nome é obrigatório!');
    edtNome.SetFocus;
    Result := False;
    Exit;
  end;
  
  // Adicionar outras validações conforme necessário
end;

procedure TfrmTelasProjetosCad.SalvarRegistro;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := DM.Connection;
    
    if FID = 0 then // Novo registro
    begin
      qry.SQL.Text := 'INSERT INTO public.telas_projetos (nome, descricao) VALUES (:nome, :descricao)';
    end
    else // Edição
    begin
      qry.SQL.Text := 'UPDATE public.telas_projetos SET nome = :nome, descricao = :descricao WHERE id = :id';
      qry.ParamByName('id').AsInteger := FID;
    end;
    
    qry.ParamByName('nome').AsString := edtNome.Text;
    qry.ParamByName('descricao').AsString := memoDescricao.Text;
    // Adicionar outros parâmetros conforme estrutura da tabela
    
    qry.ExecSQL;
    
    ShowMessage('Registro salvo com sucesso!');
    ModalResult := mrOk;
  finally
    qry.Free;
  end;
end;

procedure TfrmTelasProjetosCad.btnSalvarClick(Sender: TObject);
begin
  if ValidarCampos then
    SalvarRegistro;
end;

procedure TfrmTelasProjetosCad.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.