unit uPublicSchema;

interface

uses
  System.SysUtils, System.Classes, System.Variants, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.Stan.Error,
  System.Generics.Collections;

type
  // Classe base para todas as tabelas do esquema PUBLIC
  TPublicBaseTable = class
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

  // Classe para tabela telas_projetos
  TTelasProjetos = class(TPublicBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

  // Classe para outras tabelas do esquema public
  TUsuarios = class(TPublicBaseTable)
  private
    function GetNotNullFields: TStringList;
  protected
    function ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean; override;
  public
    constructor Create(AConexao: TFDConnection); override;
    procedure CreateTable; override;
  end;

implementation

{ TPublicBaseTable }

constructor TPublicBaseTable.Create(AConexao: TFDConnection);
begin
  inherited Create;
  FConexao := AConexao;
  FSchemaName := 'public';
end;

destructor TPublicBaseTable.Destroy;
begin
  inherited Destroy;
end;

function TPublicBaseTable.GetMetadata: TStringList;
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

function TPublicBaseTable.ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean;
begin
  Result := True;
  // Implementação base - deve ser sobrescrita nas classes filhas
end;

function TPublicBaseTable.BuildWhereClause(const AFilters: TDictionary<string, Variant>): string;
var
  Key: string;
  WhereItems: TStringList;
begin
  Result := '';
  if (AFilters = nil) or (AFilters.Count = 0) then
    Exit;
    
  WhereItems := TStringList.Create;
  try
    for Key in AFilters.Keys do
      WhereItems.Add(Format('%s = :%s', [Key, Key]));
    
    if WhereItems.Count > 0 then
      Result := ' WHERE ' + string.Join(' AND ', WhereItems.ToStringArray);
  finally
    WhereItems.Free;
  end;
end;

function TPublicBaseTable.ExecuteQuery(const ASQL: string; const AParams: TDictionary<string, Variant>): TFDQuery;
var
  Key: string;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConexao;
  Result.SQL.Text := ASQL;
  
  if AParams <> nil then
  begin
    for Key in AParams.Keys do
      Result.ParamByName(Key).Value := AParams[Key];
  end;
end;

function TPublicBaseTable.Select(const AFilters: TDictionary<string, Variant>; const AOrderBy: string): TFDQuery;
var
  SQL: string;
begin
  SQL := Format('SELECT * FROM %s.%s', [FSchemaName, FTableName]);
  SQL := SQL + BuildWhereClause(AFilters);
  
  if AOrderBy <> '' then
    SQL := SQL + ' ORDER BY ' + AOrderBy;
    
  Result := ExecuteQuery(SQL, AFilters);
  Result.Open;
end;

function TPublicBaseTable.Insert(const AFields: TDictionary<string, Variant>): Boolean;
var
  SQL: string;
  Fields, Values: TStringList;
  Key: string;
  qry: TFDQuery;
begin
  Result := False;
  
  if not ValidateNotNullFields(AFields) then
    raise Exception.Create('Campos obrigatórios não preenchidos');
    
  Fields := TStringList.Create;
  Values := TStringList.Create;
  try
    for Key in AFields.Keys do
    begin
      Fields.Add(Key);
      Values.Add(':' + Key);
    end;
    
    SQL := Format('INSERT INTO %s.%s (%s) VALUES (%s)', [
      FSchemaName, FTableName,
      string.Join(', ', Fields.ToStringArray),
      string.Join(', ', Values.ToStringArray)
    ]);
    
    qry := ExecuteQuery(SQL, AFields);
    try
      qry.ExecSQL;
      Result := True;
    finally
      qry.Free;
    end;
  finally
    Fields.Free;
    Values.Free;
  end;
end;

function TPublicBaseTable.Update(const AFields: TDictionary<string, Variant>; const AKeyValue: Variant): Boolean;
var
  SQL: string;
  SetClause: TStringList;
  Key: string;
  qry: TFDQuery;
  Params: TDictionary<string, Variant>;
begin
  Result := False;
  
  SetClause := TStringList.Create;
  Params := TDictionary<string, Variant>.Create;
  try
    for Key in AFields.Keys do
    begin
      SetClause.Add(Format('%s = :%s', [Key, Key]));
      Params.Add(Key, AFields[Key]);
    end;
    
    Params.Add('key_value', AKeyValue);
    
    SQL := Format('UPDATE %s.%s SET %s WHERE id = :key_value', [
      FSchemaName, FTableName,
      string.Join(', ', SetClause.ToStringArray)
    ]);
    
    qry := ExecuteQuery(SQL, Params);
    try
      qry.ExecSQL;
      Result := qry.RowsAffected > 0;
    finally
      qry.Free;
    end;
  finally
    SetClause.Free;
    Params.Free;
  end;
end;

function TPublicBaseTable.Delete(const AKeyValue: Variant): Boolean;
var
  SQL: string;
  qry: TFDQuery;
  Params: TDictionary<string, Variant>;
begin
  Result := False;
  
  Params := TDictionary<string, Variant>.Create;
  try
    Params.Add('key_value', AKeyValue);
    
    SQL := Format('DELETE FROM %s.%s WHERE id = :key_value', [FSchemaName, FTableName]);
    
    qry := ExecuteQuery(SQL, Params);
    try
      qry.ExecSQL;
      Result := qry.RowsAffected > 0;
    finally
      qry.Free;
    end;
  finally
    Params.Free;
  end;
end;

procedure TPublicBaseTable.AddField(const AFieldName, AFieldType: string; const ANotNull: Boolean);
var
  SQL: string;
  qry: TFDQuery;
begin
  SQL := Format('ALTER TABLE %s.%s ADD COLUMN %s %s', [
    FSchemaName, FTableName, AFieldName, AFieldType
  ]);
  
  if ANotNull then
    SQL := SQL + ' NOT NULL';
    
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConexao;
    qry.SQL.Text := SQL;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

{ TTelasProjetos }

constructor TTelasProjetos.Create(AConexao: TFDConnection);
begin
  inherited Create(AConexao);
  FTableName := 'telas_projetos';
end;

function TTelasProjetos.GetNotNullFields: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('nome');
  // Adicione outros campos obrigatórios conforme necessário
end;

function TTelasProjetos.ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean;
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

procedure TTelasProjetos.CreateTable;
var
  SQL: string;
  qry: TFDQuery;
begin
  SQL := 
    'CREATE TABLE IF NOT EXISTS public.telas_projetos (' +
    '  id SERIAL PRIMARY KEY,' +
    '  nome VARCHAR(100) NOT NULL,' +
    '  descricao TEXT,' +
    '  ativo BOOLEAN DEFAULT TRUE,' +
    '  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,' +
    '  data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP' +
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

{ TUsuarios }

constructor TUsuarios.Create(AConexao: TFDConnection);
begin
  inherited Create(AConexao);
  FTableName := 'usuarios';
end;

function TUsuarios.GetNotNullFields: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('nome');
  Result.Add('email');
end;

function TUsuarios.ValidateNotNullFields(const AFields: TDictionary<string, Variant>): Boolean;
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

procedure TUsuarios.CreateTable;
var
  SQL: string;
  qry: TFDQuery;
begin
  SQL := 
    'CREATE TABLE IF NOT EXISTS public.usuarios (' +
    '  id SERIAL PRIMARY KEY,' +
    '  nome VARCHAR(100) NOT NULL,' +
    '  email VARCHAR(150) NOT NULL UNIQUE,' +
    '  senha VARCHAR(255) NOT NULL,' +
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

end.