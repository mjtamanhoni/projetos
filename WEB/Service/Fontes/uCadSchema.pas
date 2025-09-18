unit uCadSchema;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.Stan.Error,
  System.Generics.Collections;

type
  // Classe base para todas as tabelas do esquema CAD
  TCadBaseTable = class
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

  // Classe para tabela clientes
  TClientes = class(TCadBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

  // Classe para tabela fornecedores
  TFornecedores = class(TCadBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

  // Classe para tabela produtos
  TProdutos = class(TCadBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

implementation

{ TCadBaseTable }

constructor TCadBaseTable.Create(AConexao: TFDConnection);
begin
  inherited Create;
  FConexao := AConexao;
  FSchemaName := 'cad';
end;

destructor TCadBaseTable.Destroy;
begin
  inherited Destroy;
end;

// Implementações similares à classe base do esquema public...
// (Copiando os mesmos métodos com FSchemaName := 'cad')

function TCadBaseTable.GetMetadata: TStringList;
var
  qry: TFDQuery;
begin
  Result := TStringList.Create;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConexao;
    qry.SQL.Text := 
      'SELECT column_name, data_type, is_nullable, column_default ' +
      'FROM information_schema.columns ' +
      'WHERE table_schema = :schema AND table_name = :table ' +
      'ORDER BY ordinal_position';
    qry.ParamByName('schema').AsString := FSchemaName;
    qry.ParamByName('table').AsString := FTableName;
    qry.Open;
    
    while not qry.Eof do
    begin
      Result.Add(Format('%s|%s|%s|%s', [
        qry.FieldByName('column_name').AsString,
        qry.FieldByName('data_type').AsString,
        qry.FieldByName('is_nullable').AsString,
        qry.FieldByName('column_default').AsString
      ]));
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

// ... (implementar outros métodos similares ao esquema public)

{ TClientes }

constructor TClientes.Create(AConexao: TFDConnection);
begin
  inherited Create(AConexao);
  FTableName := 'clientes';
end;

function TClientes.GetNotNullFields: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('nome');
  Result.Add('cpf_cnpj');
end;

function TClientes.ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean;
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

procedure TClientes.CreateTable;
var
  SQL: string;
  qry: TFDQuery;
begin
  SQL := 
    'CREATE SCHEMA IF NOT EXISTS cad;' +
    'CREATE TABLE IF NOT EXISTS cad.clientes (' +
    '  id SERIAL PRIMARY KEY,' +
    '  nome VARCHAR(100) NOT NULL,' +
    '  cpf_cnpj VARCHAR(20) NOT NULL UNIQUE,' +
    '  email VARCHAR(150),' +
    '  telefone VARCHAR(20),' +
    '  endereco TEXT,' +
    '  ativo BOOLEAN DEFAULT TRUE,' +
    '  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP' +
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

// Implementações similares para TFornecedores e TProdutos...

end.