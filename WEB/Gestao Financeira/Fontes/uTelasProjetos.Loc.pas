unit uTelasProjetos.Loc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.Client;

type
  TfrmTelasProjetosLoc = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlCenter: TPanel;
    
    lblFiltro: TLabel;
    edtFiltro: TEdit;
    btnPesquisar: TButton;
    btnLimpar: TButton;
    
    dbgResultados: TDBGrid;
    
    btnSelecionar: TButton;
    btnCancelar: TButton;
    
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtFiltroKeyPress(Sender: TObject; var Key: Char);
  private
    procedure Pesquisar;
    procedure LimparPesquisa;
  public
    class function Executar: Integer;
  end;

implementation

uses
  uDM;

{$R *.dfm}

class function TfrmTelasProjetosLoc.Executar: Integer;
var
  frm: TfrmTelasProjetosLoc;
begin
  Result := 0;
  frm := TfrmTelasProjetosLoc.Create(nil);
  try
    if frm.ShowModal = mrOk then
    begin
      if Assigned(DM.qryTelasProjetos) and not DM.qryTelasProjetos.IsEmpty then
        Result := DM.qryTelasProjetos.FieldByName('id').AsInteger;
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmTelasProjetosLoc.FormCreate(Sender: TObject);
begin
  // Configurações iniciais
end;

procedure TfrmTelasProjetosLoc.Pesquisar;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := DM.Connection;
    qry.SQL.Text := 'SELECT * FROM public.telas_projetos WHERE nome ILIKE :filtro ORDER BY nome';
    qry.ParamByName('filtro').AsString := '%' + edtFiltro.Text + '%';
    qry.Open;
    
    // Conectar ao DBGrid
  finally
    qry.Free;
  end;
end;

procedure TfrmTelasProjetosLoc.LimparPesquisa;
begin
  edtFiltro.Clear;
  // Limpar grid
end;

procedure TfrmTelasProjetosLoc.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmTelasProjetosLoc.btnLimparClick(Sender: TObject);
begin
  LimparPesquisa;
end;

procedure TfrmTelasProjetosLoc.btnSelecionarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmTelasProjetosLoc.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmTelasProjetosLoc.edtFiltroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then // Enter
  begin
    Key := #0;
    Pesquisar;
  end;
end;

end.