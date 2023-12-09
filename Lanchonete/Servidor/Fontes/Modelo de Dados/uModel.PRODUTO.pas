unit uModel.PRODUTO;
 
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
 
type 
  TPRODUTO = class 
  private 
    FConexao: TFDConnection; 
    
    FID :Integer;
    FCOD_BARRAS :String;
    FNOME :String;
    FSTATUS :Integer;
    FUNIDADE_SIGLA :String;
    FID_GRUPO :Integer;
    FID_SUB_GRUPO :Integer;
    FID_SETOR :Integer;
    FID_FORNECEDOR :Integer;
    FEMBALAGEM :String;
    FEMBALAGEM_QTDE :Double;
    FPRECO_COMPRA :Double;
    FLUCRO_PERC :Double;
    FPERCO_VENDA :Double;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetCOD_BARRAS( const Value:String);
    procedure SetNOME( const Value:String);
    procedure SetSTATUS( const Value:Integer);
    procedure SetUNIDADE_SIGLA( const Value:String);
    procedure SetID_GRUPO( const Value:Integer);
    procedure SetID_SUB_GRUPO( const Value:Integer);
    procedure SetID_SETOR( const Value:Integer);
    procedure SetID_FORNECEDOR( const Value:Integer);
    procedure SetEMBALAGEM( const Value:String);
    procedure SetEMBALAGEM_QTDE( const Value:Double);
    procedure SetPRECO_COMPRA( const Value:Double);
    procedure SetLUCRO_PERC( const Value:Double);
    procedure SetPERCO_VENDA( const Value:Double);
    procedure SetID_USUARIO( const Value:Integer);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHR_CADASTRO( const Value:TTime);
 
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
      AID_GRUPO:Integer=0;
      AID_SUB_GRUPO:Integer=0;
      AID_SETOR:Integer=0;
      AID_FORNECEDOR:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
 
    property ID:Integer read FID write SetID;
    property COD_BARRAS:String read FCOD_BARRAS write SetCOD_BARRAS;
    property NOME:String read FNOME write SetNOME;
    property STATUS:Integer read FSTATUS write SetSTATUS;
    property UNIDADE_SIGLA:String read FUNIDADE_SIGLA write SetUNIDADE_SIGLA;
    property ID_GRUPO:Integer read FID_GRUPO write SetID_GRUPO;
    property ID_SUB_GRUPO:Integer read FID_SUB_GRUPO write SetID_SUB_GRUPO;
    property ID_SETOR:Integer read FID_SETOR write SetID_SETOR;
    property ID_FORNECEDOR:Integer read FID_FORNECEDOR write SetID_FORNECEDOR;
    property EMBALAGEM:String read FEMBALAGEM write SetEMBALAGEM;
    property EMBALAGEM_QTDE:Double read FEMBALAGEM_QTDE write SetEMBALAGEM_QTDE;
    property PRECO_COMPRA:Double read FPRECO_COMPRA write SetPRECO_COMPRA;
    property LUCRO_PERC:Double read FLUCRO_PERC write SetLUCRO_PERC;
    property PERCO_VENDA:Double read FPERCO_VENDA write SetPERCO_VENDA;
    property ID_USUARIO:Integer read FID_USUARIO write SetID_USUARIO;
    property DT_CADASTRO:TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO:TTime read FHR_CADASTRO write SetHR_CADASTRO;
 
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
 
{ TPRODUTO }
 
constructor TPRODUTO.Create(AConnexao: TFDConnection); 
begin 
  FConexao := AConnexao; 
end; 
 
destructor TPRODUTO.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TPRODUTO.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela PRODUTO... 
            if Indice_Existe(FConexao,AFDQuery,'FK_PRODUTO_1') then 
              Add('DROP INDEX FK_PRODUTO_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_PRODUTO_2') then 
              Add('DROP INDEX FK_PRODUTO_2;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_PRODUTO_2') then 
              Add('DROP INDEX FK_PRODUTO_2;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_PRODUTO_3') then 
              Add('DROP INDEX FK_PRODUTO_3;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_PRODUTO_4') then 
              Add('DROP INDEX FK_PRODUTO_4;'); 
            if Indice_Existe(FConexao,AFDQuery,'PRODUTO_IDX1') then 
              Add('DROP INDEX PRODUTO_IDX1;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'PRODUTO_BI') then 
              Add('DROP TRIGGER PRODUTO_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_PRODUTO_ID') then 
              Add('DROP GENERATOR GEN_PRODUTO_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'PRODUTO') then 
              Add('DROP TABLE PRODUTO;'); 
 
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
      lScript.Add('CREATE TABLE PRODUTO ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,COD_BARRAS VARCHAR(50)');
      lScript.Add('  ,NOME VARCHAR(255) NOT NULL');
      lScript.Add('  ,STATUS INTEGER NOT NULL');
      lScript.Add('  ,UNIDADE_SIGLA VARCHAR(10) NOT NULL');
      lScript.Add('  ,ID_GRUPO INTEGER NOT NULL');
      lScript.Add('  ,ID_SUB_GRUPO INTEGER NOT NULL');
      lScript.Add('  ,ID_SETOR INTEGER NOT NULL');
      lScript.Add('  ,ID_FORNECEDOR INTEGER');
      lScript.Add('  ,EMBALAGEM VARCHAR(50)');
      lScript.Add('  ,EMBALAGEM_QTDE NUMERIC(15,2)');
      lScript.Add('  ,PRECO_COMPRA NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,LUCRO_PERC NUMERIC(15,2) NOT NULL DEFAULT 100');
      lScript.Add('  ,PERCO_VENDA NUMERIC(15,2) NOT NULL DEFAULT 0');
      lScript.Add('  ,ID_USUARIO INTEGER NOT NULL');
      lScript.Add('  ,DT_CADASTRO DATE NOT NULL DEFAULT CURRENT_DATE');
      lScript.Add('  ,HR_CADASTRO TIME NOT NULL DEFAULT CURRENT_TIME');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE PRODUTO ADD CONSTRAINT PK_PRODUTO PRIMARY KEY (ID);');
          Add('ALTER TABLE PRODUTO ADD CONSTRAINT FK_PRODUTO_1 FOREIGN KEY (ID_GRUPO) REFERENCES GRUPO(ID) ;');
          Add('ALTER TABLE PRODUTO ADD CONSTRAINT FK_PRODUTO_2 FOREIGN KEY (ID_GRUPO,ID_SUB_GRUPO) REFERENCES SUB_GRUPO(ID,ID_GRUPO) ;');
          Add('ALTER TABLE PRODUTO ADD CONSTRAINT FK_PRODUTO_3 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID) ;');
          Add('ALTER TABLE PRODUTO ADD CONSTRAINT FK_PRODUTO_4 FOREIGN KEY (ID_SETOR) REFERENCES SETOR(ID) ;');
          Add('CREATE INDEX FK_PRODUTO_1 ON PRODUTO (ID_GRUPO);');
          Add('CREATE INDEX FK_PRODUTO_2 ON PRODUTO (ID_GRUPO);');
          Add('CREATE INDEX FK_PRODUTO_2 ON PRODUTO (ID_SUB_GRUPO);');
          Add('CREATE INDEX FK_PRODUTO_3 ON PRODUTO (ID_FORNECEDOR);');
          Add('CREATE INDEX FK_PRODUTO_4 ON PRODUTO (ID_SETOR);');
          Add('CREATE INDEX PRODUTO_IDX1 ON PRODUTO (NOME);');
          Add('COMMENT ON COLUMN PRODUTO.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN PRODUTO.COD_BARRAS IS ''CODIGO DE BARRAS'';');
          Add('COMMENT ON COLUMN PRODUTO.NOME IS ''NOME'';');
          Add('COMMENT ON COLUMN PRODUTO.STATUS IS ''STATUS; 0-INATIVO, 1-ATIVO'';');
          Add('COMMENT ON COLUMN PRODUTO.UNIDADE_SIGLA IS ''SIGLA DA UNIDADE DE MEDIDA'';');
          Add('COMMENT ON COLUMN PRODUTO.ID_GRUPO IS ''CODIGO DO GRUPO'';');
          Add('COMMENT ON COLUMN PRODUTO.ID_SUB_GRUPO IS ''CODIGO DO SUB-GRUPO'';');
          Add('COMMENT ON COLUMN PRODUTO.ID_SETOR IS ''CODIGO DO SETOR'';');
          Add('COMMENT ON COLUMN PRODUTO.ID_FORNECEDOR IS ''CODIGO DO FORNECEDOR'';');
          Add('COMMENT ON COLUMN PRODUTO.EMBALAGEM IS ''DESCRICAO DO TIPO DE EMBALAGEM'';');
          Add('COMMENT ON COLUMN PRODUTO.EMBALAGEM_QTDE IS ''QUANTIDADE POR EMBALAGEM'';');
          Add('COMMENT ON COLUMN PRODUTO.PRECO_COMPRA IS ''PRECO DE COMPRA'';');
          Add('COMMENT ON COLUMN PRODUTO.LUCRO_PERC IS ''PERCENTUAL DE LUCRO'';');
          Add('COMMENT ON COLUMN PRODUTO.PERCO_VENDA IS ''PERCO DE VENDA'';');
          Add('COMMENT ON COLUMN PRODUTO.ID_USUARIO IS ''CODIGO DO USUARIO'';');
          Add('COMMENT ON COLUMN PRODUTO.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN PRODUTO.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('CREATE SEQUENCE GEN_PRODUTO_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER PRODUTO_BI FOR PRODUTO '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('as');
      lScript.Add('begin');
      lScript.Add('  if (new.id is null) then');
      lScript.Add('    new.id = gen_id(gen_produto_id,1);');
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
 
procedure TPRODUTO.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TPRODUTO.Inicia_Propriedades; 
begin 
  ID := -1; 
  COD_BARRAS := ''; 
  NOME := ''; 
  STATUS := -1; 
  UNIDADE_SIGLA := ''; 
  ID_GRUPO := -1; 
  ID_SUB_GRUPO := -1; 
  ID_SETOR := -1; 
  ID_FORNECEDOR := -1; 
  EMBALAGEM := ''; 
  EMBALAGEM_QTDE := 0; 
  PRECO_COMPRA := 0; 
  LUCRO_PERC := 0; 
  PERCO_VENDA := 0; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end; 
 
function  TPRODUTO.Listar(const AFDQ_Query:TFDQuery;
      AID:Integer = 0;
      ANOME:String='';
      AID_GRUPO:Integer=0;
      AID_SUB_GRUPO:Integer=0;
      AID_SETOR:Integer=0;
      AID_FORNECEDOR:Integer=0): TJSONArray;
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM PRODUTO');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID > 0 then
      begin
        AFDQ_Query.Sql.Add('  AND ID = :ID');
        AFDQ_Query.ParamByName('ID').AsInteger := AID;
      end;
      if ANOME <> '' then
        AFDQ_Query.Sql.Add('  AND NOME LIKE ' + QuotedStr('%'+ANOME+'%'));
      if AID_GRUPO > 0 then
        AFDQ_Query.Sql.Add('  AND ID_GRUPO = ' + AID_GRUPO.ToString);
      if AID_SUB_GRUPO > 0 then
        AFDQ_Query.Sql.Add('  AND ID_SUB_GRUPO = ' + AID_SUB_GRUPO.ToString);
      if AID_SETOR > 0 then
        AFDQ_Query.Sql.Add('  AND ID_SETOR = ' + AID_SETOR.ToString);
      if AID_FORNECEDOR > 0 then
        AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = ' + AID_FORNECEDOR.ToString);
      AFDQ_Query.Active := True;
      Result := AFDQ_Query.ToJSONArray;

      if not AFDQ_Query.IsEmpty then
      begin
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        COD_BARRAS := AFDQ_Query.FieldByName('COD_BARRAS').AsString;
        NOME := AFDQ_Query.FieldByName('NOME').AsString;
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        UNIDADE_SIGLA := AFDQ_Query.FieldByName('UNIDADE_SIGLA').AsString;
        ID_GRUPO := AFDQ_Query.FieldByName('ID_GRUPO').AsInteger;
        ID_SUB_GRUPO := AFDQ_Query.FieldByName('ID_SUB_GRUPO').AsInteger;
        ID_SETOR := AFDQ_Query.FieldByName('ID_SETOR').AsInteger;
        ID_FORNECEDOR := AFDQ_Query.FieldByName('ID_FORNECEDOR').AsInteger;
        EMBALAGEM := AFDQ_Query.FieldByName('EMBALAGEM').AsString;
        EMBALAGEM_QTDE := AFDQ_Query.FieldByName('EMBALAGEM_QTDE').AsFloat;
        PRECO_COMPRA := AFDQ_Query.FieldByName('PRECO_COMPRA').AsFloat;
        LUCRO_PERC := AFDQ_Query.FieldByName('LUCRO_PERC').AsFloat;
        PERCO_VENDA := AFDQ_Query.FieldByName('PERCO_VENDA').AsFloat;
        ID_USUARIO := AFDQ_Query.FieldByName('ID_USUARIO').AsInteger;
        DT_CADASTRO := AFDQ_Query.FieldByName('DT_CADASTRO').AsDateTime;
        HR_CADASTRO := AFDQ_Query.FieldByName('HR_CADASTRO').AsDateTime;
      end; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TPRODUTO.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FNOME = '' then 
        raise Exception.Create('NOME: NOME não informado'); 
      if FSTATUS = -1 then 
        raise Exception.Create('STATUS: STATUS; 0-INATIVO, 1-ATIVO não informado'); 
      if FUNIDADE_SIGLA = '' then 
        raise Exception.Create('UNIDADE_SIGLA: SIGLA DA UNIDADE DE MEDIDA não informado'); 
      if FID_GRUPO = -1 then 
        raise Exception.Create('ID_GRUPO: CODIGO DO GRUPO não informado'); 
      if FID_SUB_GRUPO = -1 then 
        raise Exception.Create('ID_SUB_GRUPO: CODIGO DO SUB-GRUPO não informado'); 
      if FID_SETOR = -1 then 
        raise Exception.Create('ID_SETOR: CODIGO DO SETOR não informado'); 
      if FPRECO_COMPRA = 0 then 
        raise Exception.Create('PRECO_COMPRA: PRECO DE COMPRA não informado'); 
      if FLUCRO_PERC = 0 then 
        raise Exception.Create('LUCRO_PERC: PERCENTUAL DE LUCRO não informado'); 
      if FPERCO_VENDA = 0 then 
        raise Exception.Create('PERCO_VENDA: PERCO DE VENDA não informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USUARIO não informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO PRODUTO( ');
      AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  ,COD_BARRAS');
      AFDQ_Query.Sql.Add('  ,NOME');
      AFDQ_Query.Sql.Add('  ,STATUS');
      AFDQ_Query.Sql.Add('  ,UNIDADE_SIGLA');
      AFDQ_Query.Sql.Add('  ,ID_GRUPO');
      AFDQ_Query.Sql.Add('  ,ID_SUB_GRUPO');
      AFDQ_Query.Sql.Add('  ,ID_SETOR');
      AFDQ_Query.Sql.Add('  ,ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,EMBALAGEM');
      AFDQ_Query.Sql.Add('  ,EMBALAGEM_QTDE');
      AFDQ_Query.Sql.Add('  ,PRECO_COMPRA');
      AFDQ_Query.Sql.Add('  ,LUCRO_PERC');
      AFDQ_Query.Sql.Add('  ,PERCO_VENDA');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  ,:COD_BARRAS');
      AFDQ_Query.Sql.Add('  ,:NOME');
      AFDQ_Query.Sql.Add('  ,:STATUS');
      AFDQ_Query.Sql.Add('  ,:UNIDADE_SIGLA');
      AFDQ_Query.Sql.Add('  ,:ID_GRUPO');
      AFDQ_Query.Sql.Add('  ,:ID_SUB_GRUPO');
      AFDQ_Query.Sql.Add('  ,:ID_SETOR');
      AFDQ_Query.Sql.Add('  ,:ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,:EMBALAGEM');
      AFDQ_Query.Sql.Add('  ,:EMBALAGEM_QTDE');
      AFDQ_Query.Sql.Add('  ,:PRECO_COMPRA');
      AFDQ_Query.Sql.Add('  ,:LUCRO_PERC');
      AFDQ_Query.Sql.Add('  ,:PERCO_VENDA');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('COD_BARRAS').AsString := FCOD_BARRAS;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('UNIDADE_SIGLA').AsString := FUNIDADE_SIGLA;
      AFDQ_Query.ParamByName('ID_GRUPO').AsInteger := FID_GRUPO;
      AFDQ_Query.ParamByName('ID_SUB_GRUPO').AsInteger := FID_SUB_GRUPO;
      AFDQ_Query.ParamByName('ID_SETOR').AsInteger := FID_SETOR;
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('EMBALAGEM').AsString := FEMBALAGEM;
      AFDQ_Query.ParamByName('EMBALAGEM_QTDE').AsFloat := FEMBALAGEM_QTDE;
      AFDQ_Query.ParamByName('PRECO_COMPRA').AsFloat := FPRECO_COMPRA;
      AFDQ_Query.ParamByName('LUCRO_PERC').AsFloat := FLUCRO_PERC;
      AFDQ_Query.ParamByName('PERCO_VENDA').AsFloat := FPERCO_VENDA;
      AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsDateTime := FHR_CADASTRO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TPRODUTO.Atualizar(const AFDQ_Query: TFDQuery; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE PRODUTO SET ');
      if FCOD_BARRAS <> '' then 
        AFDQ_Query.Sql.Add('  COD_BARRAS = :COD_BARRAS ');
      if FNOME <> '' then 
        AFDQ_Query.Sql.Add('  ,NOME = :NOME ');
      if FSTATUS > -1 then 
        AFDQ_Query.Sql.Add('  ,STATUS = :STATUS ');
      if FUNIDADE_SIGLA <> '' then 
        AFDQ_Query.Sql.Add('  ,UNIDADE_SIGLA = :UNIDADE_SIGLA ');
      if FID_GRUPO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_GRUPO = :ID_GRUPO ');
      if FID_SUB_GRUPO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_SUB_GRUPO = :ID_SUB_GRUPO ');
      if FID_SETOR > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_SETOR = :ID_SETOR ');
      if FID_FORNECEDOR > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_FORNECEDOR = :ID_FORNECEDOR ');
      if FEMBALAGEM <> '' then 
        AFDQ_Query.Sql.Add('  ,EMBALAGEM = :EMBALAGEM ');
      if FEMBALAGEM_QTDE > -1 then 
        AFDQ_Query.Sql.Add('  ,EMBALAGEM_QTDE = :EMBALAGEM_QTDE ');
      if FPRECO_COMPRA > -1 then 
        AFDQ_Query.Sql.Add('  ,PRECO_COMPRA = :PRECO_COMPRA ');
      if FLUCRO_PERC > -1 then 
        AFDQ_Query.Sql.Add('  ,LUCRO_PERC = :LUCRO_PERC ');
      if FPERCO_VENDA > -1 then 
        AFDQ_Query.Sql.Add('  ,PERCO_VENDA = :PERCO_VENDA ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FCOD_BARRAS <> '' then 
        AFDQ_Query.ParamByName('COD_BARRAS').AsString := FCOD_BARRAS;
      if FNOME <> '' then 
        AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      if FSTATUS > -1 then 
        AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      if FUNIDADE_SIGLA <> '' then 
        AFDQ_Query.ParamByName('UNIDADE_SIGLA').AsString := FUNIDADE_SIGLA;
      if FID_GRUPO > -1 then 
        AFDQ_Query.ParamByName('ID_GRUPO').AsInteger := FID_GRUPO;
      if FID_SUB_GRUPO > -1 then 
        AFDQ_Query.ParamByName('ID_SUB_GRUPO').AsInteger := FID_SUB_GRUPO;
      if FID_SETOR > -1 then 
        AFDQ_Query.ParamByName('ID_SETOR').AsInteger := FID_SETOR;
      if FID_FORNECEDOR > -1 then 
        AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      if FEMBALAGEM <> '' then 
        AFDQ_Query.ParamByName('EMBALAGEM').AsString := FEMBALAGEM;
      if FEMBALAGEM_QTDE > -1 then 
        AFDQ_Query.ParamByName('EMBALAGEM_QTDE').AsFloat := FEMBALAGEM_QTDE;
      if FPRECO_COMPRA > -1 then 
        AFDQ_Query.ParamByName('PRECO_COMPRA').AsFloat := FPRECO_COMPRA;
      if FLUCRO_PERC > -1 then 
        AFDQ_Query.ParamByName('LUCRO_PERC').AsFloat := FLUCRO_PERC;
      if FPERCO_VENDA > -1 then 
        AFDQ_Query.ParamByName('PERCO_VENDA').AsFloat := FPERCO_VENDA;
      if FID_USUARIO > -1 then 
        AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('HR_CADASTRO').AsDateTime := FHR_CADASTRO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TPRODUTO.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM PRODUTO '); 
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
 
procedure TPRODUTO.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TPRODUTO.SetCOD_BARRAS( const Value:String);
begin 
  FCOD_BARRAS := Value; 
end;
 
procedure TPRODUTO.SetNOME( const Value:String);
begin 
  FNOME := Value; 
end;
 
procedure TPRODUTO.SetSTATUS( const Value:Integer);
begin 
  FSTATUS := Value; 
end;
 
procedure TPRODUTO.SetUNIDADE_SIGLA( const Value:String);
begin 
  FUNIDADE_SIGLA := Value; 
end;
 
procedure TPRODUTO.SetID_GRUPO( const Value:Integer);
begin 
  FID_GRUPO := Value; 
end;
 
procedure TPRODUTO.SetID_SUB_GRUPO( const Value:Integer);
begin 
  FID_SUB_GRUPO := Value; 
end;
 
procedure TPRODUTO.SetID_SETOR( const Value:Integer);
begin 
  FID_SETOR := Value; 
end;
 
procedure TPRODUTO.SetID_FORNECEDOR( const Value:Integer);
begin 
  FID_FORNECEDOR := Value; 
end;
 
procedure TPRODUTO.SetEMBALAGEM( const Value:String);
begin 
  FEMBALAGEM := Value; 
end;
 
procedure TPRODUTO.SetEMBALAGEM_QTDE( const Value:Double);
begin 
  FEMBALAGEM_QTDE := Value; 
end;
 
procedure TPRODUTO.SetPRECO_COMPRA( const Value:Double);
begin 
  FPRECO_COMPRA := Value; 
end;
 
procedure TPRODUTO.SetLUCRO_PERC( const Value:Double);
begin 
  FLUCRO_PERC := Value; 
end;
 
procedure TPRODUTO.SetPERCO_VENDA( const Value:Double);
begin 
  FPERCO_VENDA := Value; 
end;
 
procedure TPRODUTO.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TPRODUTO.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TPRODUTO.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
