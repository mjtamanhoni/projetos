unit uModel.Impressao;

interface

uses
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,

  DataSet.Serialize, DataSet.Serialize.Config,

  System.SysUtils, System.Classes,System.JSON;

//  function Campo_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela, ACampos: String): Boolean;
//  function Tabela_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela: String): Boolean;
//  function Procedure_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AProcedure: String): Boolean;
//  function Trigger_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATrigger: String): Boolean;
//  function Generator_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AGenerator: String): Boolean;
//  function Indice_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AIndice: String): Boolean;

type
  TImpressao = class
  private
    FConexao: TFDConnection;
    FID: Integer;
    procedure SetID(const Value: Integer);

  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery);
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery);
    procedure Inicia_Propriedades;
    function Listar(
      const AFDQ_Query:TFDQuery): TJSONArray;
    procedure Inserir(const AFDQ_Query:TFDQuery);
    procedure Atualizar(const AFDQ_Query:TFDQuery);
    procedure Excluir(const AFDQ_Query:TFDQuery;const AID:Integer=0);
    function Sequencial(const AFDQ_Query:TFDQuery):Integer;

    property ID :Integer read FID write SetID;
  end;

implementation

{ TImpressao }

procedure TImpressao.Atualizar(const AFDQ_Query: TFDQuery);
begin

end;

procedure TImpressao.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

constructor TImpressao.Create(AConnexao: TFDConnection);
begin
  FConexao := AConnexao;
end;

procedure TImpressao.Criar_Estrutura(const AFDScript: TFDScript;
  AFDQuery: TFDQuery);
begin

end;

destructor TImpressao.Destroy;
begin

  inherited;
end;

procedure TImpressao.Excluir(const AFDQ_Query: TFDQuery; const AID: Integer);
begin

end;

procedure TImpressao.Inicia_Propriedades;
begin

end;

procedure TImpressao.Inserir(const AFDQ_Query: TFDQuery);
begin

end;

function TImpressao.Listar(const AFDQ_Query: TFDQuery): TJSONArray;
begin

end;

function TImpressao.Sequencial(const AFDQ_Query: TFDQuery): Integer;
begin

end;

procedure TImpressao.SetID(const Value: Integer);
begin
  FID := Value;
end;

end.
