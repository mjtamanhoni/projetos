unit uTelasProjetos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TfrmTelasProjetos = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    dbgTelasProjetos: TDBGrid;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnLocalizar: TButton;
    btnSair: TButton;
    
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    procedure CarregarDados;
    procedure ConfigurarGrid;
  public
    { Public declarations }
  end;

var
  frmTelasProjetos: TfrmTelasProjetos;

implementation

uses
  uTelasProjetos.Cad, uTelasProjetos.Loc, uDM; // Assumindo um DataModule

{$R *.dfm}

procedure TfrmTelasProjetos.FormCreate(Sender: TObject);
begin
  ConfigurarGrid;
  CarregarDados;
end;

procedure TfrmTelasProjetos.ConfigurarGrid;
begin
  // Configurar colunas do DBGrid baseado na estrutura da tabela
  // Você precisará ajustar conforme os campos da tabela telas_projetos
end;

procedure TfrmTelasProjetos.CarregarDados;
begin
  // Carregar dados da tabela public.telas_projetos
  if Assigned(DM) and Assigned(DM.qryTelasProjetos) then
  begin
    DM.qryTelasProjetos.Close;
    DM.qryTelasProjetos.SQL.Text := 'SELECT * FROM public.telas_projetos ORDER BY id';
    DM.qryTelasProjetos.Open;
  end;
end;

procedure TfrmTelasProjetos.btnNovoClick(Sender: TObject);
begin
  if TfrmTelasProjetosCad.Executar(0) then // 0 = novo registro
    CarregarDados;
end;

procedure TfrmTelasProjetos.btnEditarClick(Sender: TObject);
var
  ID: Integer;
begin
  if Assigned(DM.qryTelasProjetos) and not DM.qryTelasProjetos.IsEmpty then
  begin
    ID := DM.qryTelasProjetos.FieldByName('id').AsInteger;
    if TfrmTelasProjetosCad.Executar(ID) then
      CarregarDados;
  end;
end;

procedure TfrmTelasProjetos.btnExcluirClick(Sender: TObject);
begin
  if Assigned(DM.qryTelasProjetos) and not DM.qryTelasProjetos.IsEmpty then
  begin
    if MessageDlg('Confirma exclusão do registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // Implementar exclusão
      CarregarDados;
    end;
  end;
end;

procedure TfrmTelasProjetos.btnLocalizarClick(Sender: TObject);
begin
  TfrmTelasProjetosLoc.Executar;
end;

procedure TfrmTelasProjetos.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.