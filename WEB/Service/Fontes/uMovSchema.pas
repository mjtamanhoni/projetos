unit uMovSchema;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.Stan.Error,
  System.Generics.Collections;

type
  // Classe base para todas as tabelas do esquema MOV
  TMovBaseTable = class
  private
    FConexao: TFDConnection;
    FTableName: string;
    FSchemaName: string;
  protected
    function GetMetadata: TStringList; virtual;
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; virtual;
    function BuildWhereClause(const AFilters: TDictionary<string, Variant>): string;
    function ExecuteQuery(const ASQL: string; const AParams: TDictionary<string, Variant> = nil): TFDQuery;
  public
    constructor Create(AConexao: TFDConnection); virtual;
    destructor Destroy; override;
    
    // Métodos CRUD genéricos
    function Select(const AFilters: TDictionary<string, Variant> = nil; const AOrderBy: string = ''): TFDQuery;
    function Insert(const AFields: TDictionary<string, Variant>): Boolean;
    function Update(const AFields: TDictionary<string, Variant>; const AKeyValue: Variant): Boolean;
    function Delete(const AKeyValue: Variant): Boolean;
    
    // Métodos de estrutura
    procedure CreateTable; virtual; abstract;
    procedure AddField(const AFieldName, AFieldType: string; const ANotNull: Boolean = False);
    
    property TableName: string read FTableName;
    property SchemaName: string read FSchemaName;
  end;

  // Classe para tabela vendas
  TVendas = class(TMovBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

  // Classe para tabela compras
  TCompras = class(TMovBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

  // Classe para tabela movimentacao_financeira
  TMovimentacaoFinanceira = class(TMovBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

implementation

{ TMovBaseTable }

constructor TMovBaseTable.Create(AConexao: TFDConnection);
begin
  inherited Create;
  FConexao := AConexao;
  FSchemaName := 'mov';
end;

destructor TMovBaseTable.Destroy;
begin
  inherited Destroy;
end;

// Implementações similares às classes base dos outros esquemas...

{ TVendas }

constructor TVendas.Create(AConexao: TFDConnection);
begin
  inherited Create(AConexao);
  FTableName := 'vendas';
end;

function TVendas.GetNotNullFields: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('cliente_id');
  Result.Add('data_venda');
  Result.Add('valor_total');
end;

function TVendas.ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean;
var
  NotNullFields: TStringList;
  Field: string;
begin
  Result := True;
  NotNullFields := GetNotNullFields;
  try
    for Field in NotNullFields do
    begin
      if not AFields.ContainsKey(Field) or VarIsNull(AFields[Field]) or (VarToStr(AFields[Field]) = '') then
      begin
        Result := False;
        Break;
      end;
    end;
  finally
    NotNullFields.Free;
  end;
end;

procedure TVendas.CreateTable;
var
  SQL: string;
  qry: TFDQuery;
begin
  SQL := 
    'CREATE SCHEMA IF NOT EXISTS mov;' +
    'CREATE TABLE IF NOT EXISTS mov.vendas (' +
    '  id SERIAL PRIMARY KEY,' +
    '  cliente_id INTEGER NOT NULL,' +
    '  data_venda DATE NOT NULL,' +
    '  valor_total DECIMAL(15,2) NOT NULL,' +
    '  desconto DECIMAL(15,2) DEFAULT 0,' +
    '  observacoes TEXT,' +
    '  status VARCHAR(20) DEFAULT ''ATIVA'',' +
    '  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,' +
    '  FOREIGN KEY (cliente_id) REFERENCES cad.clientes(id)' +
    ')';
    
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConexao;
    qry.SQL.Text := SQL;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

// Implementações similares para TCompras e TMovimentacaoFinanceira...

end.