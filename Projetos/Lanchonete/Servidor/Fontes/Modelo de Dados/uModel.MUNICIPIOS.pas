unit uModel.MUNICIPIOS;
 
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
 
  function Campo_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela, ACampos: String): Boolean; 
  function Tabela_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela: String): Boolean; 
  function Procedure_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AProcedure: String): Boolean; 
  function Trigger_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATrigger: String): Boolean; 
  function Generator_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AGenerator: String): Boolean; 
  function Indice_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AIndice: String): Boolean; 

const
  C_Paginas = 30;

type 
  TMUNICIPIOS = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer;
    FPaginas :Integer;

    FID :Integer;
    FIBGE :Integer;
    FNOME :String;
    FSIGLA_UF :String;
 
    procedure SetID( const Value:Integer);
    procedure SetIBGE( const Value:Integer);
    procedure SetNOME( const Value:String);
    procedure SetSIGLA_UF( const Value:String);
 
  public 
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override; 
 
    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery); 
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery); 
    procedure Inicia_Propriedades; 
    procedure Inserir(const AFDQ_Query:TFDQuery); 
    function Listar(const AFDQ_Query:TFDQuery;
      AID:Integer = 0;
      ANOME:String='';
      AUF_SIGLA:String='';
      AIBGE:String='';
      APagina:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
 
    property ID:Integer read FID write SetID;
    property IBGE:Integer read FIBGE write SetIBGE;
    property NOME:String read FNOME write SetNOME;
    property SIGLA_UF:String read FSIGLA_UF write SetSIGLA_UF;
 
  end; 
 
implementation 
 
function Campo_Existe(const AConexao:TFDConnection; const AFDQ_Query:TFDQuery; const ATabela, ACampos: String): Boolean; 
begin 
  try 
    AFDQ_Query.Connection := AConexao; 
    AFDQ_Query.Active := False; 
    AFDQ_Query.Sql.Clear; 
    AFDQ_Query.Sql.Add('SELECT '); 
    AFDQ_Query.Sql.Add('  RF.* '); 
    AFDQ_Query.Sql.Add('FROM RDB$RELATION_FIELDS RF '); 
    AFDQ_Query.Sql.Add('WHERE TRIM(RF.RDB$FIELD_NAME) = ' + QuotedStr(Trim(ACampos))); 
    AFDQ_Query.Sql.Add('  AND TRIM(RF.RDB$RELATION_NAME) = ' + QuotedStr(Trim(ATabela))); 
    AFDQ_Query.Active := True; 
    Result := (not AFDQ_Query.IsEmpty); 
  except 
    On Ex:Exception do 
    begin 
      Result := False; 
      raise Exception.Create(Ex.Message); 
    end; 
  end; 
end; 
 
function Tabela_Existe(const AConexao:TFDConnection; const AFDQ_Query:TFDQuery; const ATabela: String): Boolean; 
begin 
  try 
    AFDQ_Query.Connection := AConexao; 
    AFDQ_Query.Active := False; 
    AFDQ_Query.Sql.Clear; 
    AFDQ_Query.Sql.Add('SELECT '); 
    AFDQ_Query.Sql.Add('  RR.* '); 
    AFDQ_Query.Sql.Add('FROM RDB$RELATIONS RR '); 
    AFDQ_Query.Sql.Add('WHERE TRIM(RR.RDB$RELATION_NAME) = ' + QuotedStr(Trim(ATabela))); 
    AFDQ_Query.Sql.Add('  AND RR.RDB$SYSTEM_FLAG = 0; '); 
    AFDQ_Query.Active := True; 
    Result := (not AFDQ_Query.IsEmpty); 
  except 
    On Ex:Exception do 
    begin 
      Result := False; 
      raise Exception.Create(Ex.Message); 
    end; 
  end; 
end; 
 
function Procedure_Existe(const AConexao:TFDConnection; const AFDQ_Query: TFDQuery; const AProcedure: String): Boolean; 
begin 
  try 
    AFDQ_Query.Connection := AConexao; 
    AFDQ_Query.Active := False; 
    AFDQ_Query.Sql.Clear; 
    AFDQ_Query.Sql.Add('SELECT '); 
    AFDQ_Query.Sql.Add('  RP.* '); 
    AFDQ_Query.Sql.Add('FROM RDB$PROCEDURES RP '); 
    AFDQ_Query.Sql.Add('WHERE TRIM(RP.RDB$PROCEDURE_NAME) = ' + QuotedStr(Trim(AProcedure))); 
    AFDQ_Query.Active := True; 
    Result := (not AFDQ_Query.IsEmpty); 
  except 
    On Ex:Exception do 
    begin 
      Result := False; 
      raise Exception.Create(Ex.Message); 
    end; 
  end; 
end; 
 
function Trigger_Existe(const AConexao:TFDConnection; const AFDQ_Query: TFDQuery; const ATrigger: String): Boolean; 
begin 
  try 
    AFDQ_Query.Connection := AConexao; 
    AFDQ_Query.Active := False; 
    AFDQ_Query.Sql.Clear; 
    AFDQ_Query.Sql.Add('SELECT '); 
    AFDQ_Query.Sql.Add('  RT.* '); 
    AFDQ_Query.Sql.Add('FROM RDB$TRIGGERS RT '); 
    AFDQ_Query.Sql.Add('WHERE TRIM(RT.RDB$TRIGGER_NAME) = ' + QuotedStr(Trim(ATrigger))); 
    AFDQ_Query.Sql.Add('  AND RT.RDB$SYSTEM_FLAG = 0; '); 
    AFDQ_Query.Active := True; 
    Result := (not AFDQ_Query.IsEmpty); 
  except 
    On Ex:Exception do 
    begin 
      Result := False; 
      raise Exception.Create(Ex.Message); 
    end; 
  end; 
end; 
 
function Generator_Existe(const AConexao:TFDConnection; const AFDQ_Query: TFDQuery;  const AGenerator: String): Boolean; 
begin 
  try 
    AFDQ_Query.Connection := AConexao; 
    AFDQ_Query.Active := False; 
    AFDQ_Query.Sql.Clear; 
    AFDQ_Query.Sql.Add('SELECT '); 
    AFDQ_Query.Sql.Add('  RD.* '); 
    AFDQ_Query.Sql.Add('FROM RDB$DEPENDENCIES RD '); 
    AFDQ_Query.Sql.Add('WHERE TRIM(RD.RDB$DEPENDED_ON_NAME) = ' + QuotedStr(Trim(AGenerator))); 
    AFDQ_Query.Active := True; 
    Result := (not AFDQ_Query.IsEmpty); 
  except 
    On Ex:Exception do 
    begin 
      Result := False; 
      raise Exception.Create(Ex.Message); 
    end; 
  end; 
end; 
 
function Indice_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AIndice: String): Boolean; 
begin 
  try 
    AFDQ_Query.Connection := AConexao; 
    AFDQ_Query.Active := False; 
    AFDQ_Query.Sql.Clear; 
    AFDQ_Query.Sql.Add('SELECT '); 
    AFDQ_Query.Sql.Add('  RI.* '); 
    AFDQ_Query.Sql.Add('FROM RDB$INDICES RI '); 
    AFDQ_Query.Sql.Add('WHERE TRIM(RI.RDB$INDEX_NAME) = ' + QuotedStr(Trim(AIndice))); 
    AFDQ_Query.Active := True; 
    Result := (not AFDQ_Query.IsEmpty); 
  except 
    On Ex:Exception do 
    begin 
      Result := False; 
      raise Exception.Create(Ex.Message); 
    end; 
  end; 
end; 
 
{ TMUNICIPIOS }
 
constructor TMUNICIPIOS.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end; 
 
destructor TMUNICIPIOS.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TMUNICIPIOS.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
var 
  lScript: TStringList; 
begin 
  try 
    try 
      AFDScript.Connection := FConexao; 
      AFDQuery.Connection := FConexao; 
 
      lScript := TStringList.Create; 
 
       //Relizando um DROP nos objetos da tabela... 
       begin 
         with AFDScript do 
         begin 
           SQLScripts.Clear; 
           SQLScripts.Add; 
           with SQLScripts[0].SQL do 
           begin 
            //Excluindo objetos da tabela MUNICIPIOS... 
            if Indice_Existe(FConexao,AFDQuery,'MUNICIPIOS_IDX2') then 
              Add('DROP INDEX MUNICIPIOS_IDX2;'); 
            if Indice_Existe(FConexao,AFDQuery,'MUNICIPIOS_IDX3') then 
              Add('DROP INDEX MUNICIPIOS_IDX3;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'MUNICIPIOS_BI') then 
              Add('DROP TRIGGER MUNICIPIOS_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_MUNICIPIOS_ID') then 
              Add('DROP GENERATOR GEN_MUNICIPIOS_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'MUNICIPIOS') then 
              Add('DROP TABLE MUNICIPIOS;'); 
 
            if Count > 0 then 
            begin 
              ValidateAll; 
              ExecuteAll; 
            end; 
          end; 
        end; 
      end; 
 
     //Criando tabelas...
      lScript.Clear; 
      lScript.Add('CREATE TABLE MUNICIPIOS ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,IBGE INTEGER NOT NULL');
      lScript.Add('  ,NOME VARCHAR(100) NOT NULL');
      lScript.Add('  ,SIGLA_UF VARCHAR(2) NOT NULL');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE MUNICIPIOS ADD CONSTRAINT PK_MUNICIPIOS PRIMARY KEY (ID);');
          Add('CREATE INDEX MUNICIPIOS_IDX2 ON MUNICIPIOS (NOME);');
          Add('CREATE INDEX MUNICIPIOS_IDX3 ON MUNICIPIOS (SIGLA_UF);');
          Add('COMMENT ON COLUMN MUNICIPIOS.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN MUNICIPIOS.IBGE IS ''CODIGO IBGE'';');
          Add('COMMENT ON COLUMN MUNICIPIOS.NOME IS ''NOME'';');
          Add('COMMENT ON COLUMN MUNICIPIOS.SIGLA_UF IS ''SIGLA DA UNIDADE FEDERATIVA'';');
          Add('CREATE SEQUENCE GEN_MUNICIPIOS_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER MUNICIPIOS_BI FOR MUNICIPIOS '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('as');
      lScript.Add('begin');
      lScript.Add('  if (new.id is null) then');
      lScript.Add('    new.id = gen_id(gen_municipios_id,1);');
      lScript.Add('end ^');
      lScript.Add(' '); 
      AFDScript.ExecuteScript(lScript); 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lScript); 
    {$ELSE} 
      lScript.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure TMUNICIPIOS.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TMUNICIPIOS.Inicia_Propriedades; 
begin 
  ID := -1; 
  IBGE := -1; 
  NOME := ''; 
  SIGLA_UF := ''; 
end; 
 
function  TMUNICIPIOS.Listar(const AFDQ_Query:TFDQuery;
      AID:Integer = 0;
      ANOME:String='';
      AUF_SIGLA:String='';
      AIBGE:String='';
      APagina:Integer=0): TJSONArray;
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT ');
      AFDQ_Query.Sql.Add('  M.* ');
      AFDQ_Query.Sql.Add('  ,UF.NOME AS UNIDADE_FEDERATIVA ');
      AFDQ_Query.Sql.Add('FROM MUNICIPIOS M ');
      AFDQ_Query.Sql.Add('  JOIN UNIDADE_FEDERATIVA UF ON UF.SIGLA = M.SIGLA_UF ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND M.ID = ' + AID.ToString);
      if ANOME <> '' then
        AFDQ_Query.Sql.Add('  AND M.NOME LIKE ' + QuotedStr('%'+ANOME+'%'));
      if Trim(AUF_SIGLA) <> '' then
        AFDQ_Query.Sql.Add('  AND M.SIGLA_UF = ' + QuotedStr(Trim(AUF_SIGLA)));
      if Trim(AIBGE) <> '' then
        AFDQ_Query.Sql.Add('  AND M.IBGE = ' + Trim(AIBGE));
      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  UF.ID_REGIAO ');
      AFDQ_Query.Sql.Add('  ,M.SIGLA_UF ');
      AFDQ_Query.Sql.Add('  ,M.ID ');
      if ((APagina > 0) and (FPaginas > 0))  then
      begin
        FPagina := (((APagina - 1) * FPaginas) + 1);
        FPaginas := (APagina * FPaginas);
        AFDQ_Query.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
      end;

      AFDQ_Query.Active := True;
      Result := AFDQ_Query.ToJSONArray;

      if not AFDQ_Query.IsEmpty then 
      begin 
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        IBGE := AFDQ_Query.FieldByName('IBGE').AsInteger;
        NOME := AFDQ_Query.FieldByName('NOME').AsString;
        SIGLA_UF := AFDQ_Query.FieldByName('SIGLA_UF').AsString;
      end; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TMUNICIPIOS.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FIBGE = -1 then 
        raise Exception.Create('IBGE: CODIGO IBGE não informado'); 
      if FNOME = '' then 
        raise Exception.Create('NOME: NOME não informado'); 
      if FSIGLA_UF = '' then 
        raise Exception.Create('SIGLA_UF: SIGLA DA UNIDADE FEDERATIVA não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO MUNICIPIOS( ');
      AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  ,IBGE');
      AFDQ_Query.Sql.Add('  ,NOME');
      AFDQ_Query.Sql.Add('  ,SIGLA_UF');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  ,:IBGE');
      AFDQ_Query.Sql.Add('  ,:NOME');
      AFDQ_Query.Sql.Add('  ,:SIGLA_UF');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('SIGLA_UF').AsString := FSIGLA_UF;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TMUNICIPIOS.Atualizar(const AFDQ_Query: TFDQuery; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE MUNICIPIOS SET ');
      if FIBGE > -1 then 
        AFDQ_Query.Sql.Add('  IBGE = :IBGE ');
      if FNOME <> '' then 
        AFDQ_Query.Sql.Add('  ,NOME = :NOME ');
      if FSIGLA_UF <> '' then 
        AFDQ_Query.Sql.Add('  ,SIGLA_UF = :SIGLA_UF ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FIBGE > -1 then 
        AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      if FNOME <> '' then 
        AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      if FSIGLA_UF <> '' then 
        AFDQ_Query.ParamByName('SIGLA_UF').AsString := FSIGLA_UF;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TMUNICIPIOS.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM MUNICIPIOS '); 
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL '); 
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := AID;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TMUNICIPIOS.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TMUNICIPIOS.SetIBGE( const Value:Integer);
begin 
  FIBGE := Value; 
end;
 
procedure TMUNICIPIOS.SetNOME( const Value:String);
begin 
  FNOME := Value; 
end;
 
procedure TMUNICIPIOS.SetSIGLA_UF( const Value:String);
begin 
  FSIGLA_UF := Value; 
end;
 
 
end. 
