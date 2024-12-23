unit uModel.CAIXA; 
 
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
  TCAIXA = class 
  private 
    FConexao: TFDConnection; 
    
    FID :Integer;
    FDT_CAIXA :TDate;
    FHR_CAIXA :TTime;
    FTIPO :Integer;
    FID_FORNECEDOR :Integer;
    FID_CLIENTE :Integer;
    FID_FORMA_PAGAMENTO :Integer;
    FID_COND_PAGAMENTO :Integer;
    FVLR_CAIXA :Double;
    FID_USUARIO_CAD :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
    FID_USUARIO_ALT :Integer;
    FDT_ALTERADO :TDate;
    FHR_ALTERADO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetDT_CAIXA( const Value:TDate);
    procedure SetHR_CAIXA( const Value:TTime);
    procedure SetTIPO( const Value:Integer);
    procedure SetID_FORNECEDOR( const Value:Integer);
    procedure SetID_CLIENTE( const Value:Integer);
    procedure SetID_FORMA_PAGAMENTO( const Value:Integer);
    procedure SetID_COND_PAGAMENTO( const Value:Integer);
    procedure SetVLR_CAIXA( const Value:Double);
    procedure SetID_USUARIO_CAD( const Value:Integer);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHR_CADASTRO( const Value:TTime);
    procedure SetID_USUARIO_ALT( const Value:Integer);
    procedure SetDT_ALTERADO( const Value:TDate);
    procedure SetHR_ALTERADO( const Value:TTime);
 
  public 
    constructor Create(AConnexao: TFDConnection); 
    destructor Destroy; override; 
 
    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery); 
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery); 
    procedure Inicia_Propriedades; 
    procedure Inserir(const AFDQ_Query:TFDQuery); 
    function Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
 
    property ID:Integer read FID write SetID;
    property DT_CAIXA:TDate read FDT_CAIXA write SetDT_CAIXA;
    property HR_CAIXA:TTime read FHR_CAIXA write SetHR_CAIXA;
    property TIPO:Integer read FTIPO write SetTIPO;
    property ID_FORNECEDOR:Integer read FID_FORNECEDOR write SetID_FORNECEDOR;
    property ID_CLIENTE:Integer read FID_CLIENTE write SetID_CLIENTE;
    property ID_FORMA_PAGAMENTO:Integer read FID_FORMA_PAGAMENTO write SetID_FORMA_PAGAMENTO;
    property ID_COND_PAGAMENTO:Integer read FID_COND_PAGAMENTO write SetID_COND_PAGAMENTO;
    property VLR_CAIXA:Double read FVLR_CAIXA write SetVLR_CAIXA;
    property ID_USUARIO_CAD:Integer read FID_USUARIO_CAD write SetID_USUARIO_CAD;
    property DT_CADASTRO:TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO:TTime read FHR_CADASTRO write SetHR_CADASTRO;
    property ID_USUARIO_ALT:Integer read FID_USUARIO_ALT write SetID_USUARIO_ALT;
    property DT_ALTERADO:TDate read FDT_ALTERADO write SetDT_ALTERADO;
    property HR_ALTERADO:TTime read FHR_ALTERADO write SetHR_ALTERADO;
 
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
 
{ TCAIXA }
 
constructor TCAIXA.Create(AConnexao: TFDConnection); 
begin 
  FConexao := AConnexao; 
end; 
 
destructor TCAIXA.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TCAIXA.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela CAIXA... 
            if Indice_Existe(FConexao,AFDQuery,'FK_CAIXA_1') then 
              Add('DROP INDEX FK_CAIXA_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_CAIXA_2') then 
              Add('DROP INDEX FK_CAIXA_2;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_CAIXA_3') then 
              Add('DROP INDEX FK_CAIXA_3;'); 
            if Indice_Existe(FConexao,AFDQuery,'CAIXA_IDX1') then 
              Add('DROP INDEX CAIXA_IDX1;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'CAIXA_BI') then 
              Add('DROP TRIGGER CAIXA_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_CAIXA_ID') then 
              Add('DROP GENERATOR GEN_CAIXA_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'CAIXA') then 
              Add('DROP TABLE CAIXA;'); 
 
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
      lScript.Add('CREATE TABLE CAIXA ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,DT_CAIXA DATE NOT NULL DEFAULT CURRENT_DATE');
      lScript.Add('  ,HR_CAIXA TIME NOT NULL DEFAULT CURRENT_TIME');
      lScript.Add('  ,TIPO INTEGER NOT NULL');
      lScript.Add('  ,ID_FORNECEDOR INTEGER');
      lScript.Add('  ,ID_CLIENTE INTEGER');
      lScript.Add('  ,ID_FORMA_PAGAMENTO INTEGER NOT NULL');
      lScript.Add('  ,ID_COND_PAGAMENTO INTEGER NOT NULL');
      lScript.Add('  ,VLR_CAIXA NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,ID_USUARIO_CAD INTEGER NOT NULL');
      lScript.Add('  ,DT_CADASTRO DATE NOT NULL DEFAULT CURRENT_DATE');
      lScript.Add('  ,HR_CADASTRO TIME NOT NULL DEFAULT CURRENT_TIME');
      lScript.Add('  ,ID_USUARIO_ALT INTEGER');
      lScript.Add('  ,DT_ALTERADO DATE');
      lScript.Add('  ,HR_ALTERADO TIME');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE CAIXA ADD CONSTRAINT PK_CAIXA PRIMARY KEY (ID);');
          Add('ALTER TABLE CAIXA ADD CONSTRAINT FK_CAIXA_1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID) ;');
          Add('ALTER TABLE CAIXA ADD CONSTRAINT FK_CAIXA_2 FOREIGN KEY (ID_FORMA_PAGAMENTO) REFERENCES FORMA_PAGAMENTO(ID) ;');
          Add('ALTER TABLE CAIXA ADD CONSTRAINT FK_CAIXA_3 FOREIGN KEY (ID_COND_PAGAMENTO) REFERENCES CONDICAO_PAGAMENTO(ID) ;');
          Add('CREATE INDEX FK_CAIXA_1 ON CAIXA (ID_FORNECEDOR);');
          Add('CREATE INDEX FK_CAIXA_2 ON CAIXA (ID_FORMA_PAGAMENTO);');
          Add('CREATE INDEX FK_CAIXA_3 ON CAIXA (ID_COND_PAGAMENTO);');
          Add('CREATE INDEX CAIXA_IDX1 ON CAIXA (DT_CAIXA);');
          Add('COMMENT ON COLUMN CAIXA.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN CAIXA.DT_CAIXA IS ''DATA DO CAIXA'';');
          Add('COMMENT ON COLUMN CAIXA.HR_CAIXA IS ''HORA DO CAIXA'';');
          Add('COMMENT ON COLUMN CAIXA.TIPO IS ''TIPO DA ENTRADA: 0-COMPRA, 1-VENDA'';');
          Add('COMMENT ON COLUMN CAIXA.ID_FORNECEDOR IS ''CODIGO DO FORNECEDOR'';');
          Add('COMMENT ON COLUMN CAIXA.ID_CLIENTE IS ''CODIGO DO CLIENTE'';');
          Add('');
          Add('');
          Add('COMMENT ON COLUMN CAIXA.VLR_CAIXA IS ''VALOR DO CAIXA'';');
          Add('COMMENT ON COLUMN CAIXA.ID_USUARIO_CAD IS ''USUARIO DE CADASTRO'';');
          Add('COMMENT ON COLUMN CAIXA.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN CAIXA.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('COMMENT ON COLUMN CAIXA.ID_USUARIO_ALT IS ''USUARIO DE CADASTRO'';');
          Add('COMMENT ON COLUMN CAIXA.DT_ALTERADO IS ''DATA DA ALTERACAO'';');
          Add('COMMENT ON COLUMN CAIXA.HR_ALTERADO IS ''HORA DA ALTERACAO'';');
          Add('CREATE SEQUENCE GEN_CAIXA_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER CAIXA_BI FOR CAIXA '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_CAIXA_ID,1);');
      lScript.Add('END ^');
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
 
procedure TCAIXA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TCAIXA.Inicia_Propriedades; 
begin 
  ID := -1; 
  DT_CAIXA := Date; 
  HR_CAIXA := Time; 
  TIPO := -1; 
  ID_FORNECEDOR := -1; 
  ID_CLIENTE := -1; 
  ID_FORMA_PAGAMENTO := -1; 
  ID_COND_PAGAMENTO := -1; 
  VLR_CAIXA := 0; 
  ID_USUARIO_CAD := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
  ID_USUARIO_ALT := -1; 
  DT_ALTERADO := Date; 
  HR_ALTERADO := Time; 
end; 
 
function  TCAIXA.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM CAIXA') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := AID;
      AFDQ_Query.Active := True; 
      Result := AFDQ_Query.ToJSONArray; 
 
      if not AFDQ_Query.IsEmpty then 
      begin 
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        DT_CAIXA := AFDQ_Query.FieldByName('DT_CAIXA').AsDateTime;
        HR_CAIXA := AFDQ_Query.FieldByName('HR_CAIXA').AsDateTime;
        TIPO := AFDQ_Query.FieldByName('TIPO').AsInteger;
        ID_FORNECEDOR := AFDQ_Query.FieldByName('ID_FORNECEDOR').AsInteger;
        ID_CLIENTE := AFDQ_Query.FieldByName('ID_CLIENTE').AsInteger;
        ID_FORMA_PAGAMENTO := AFDQ_Query.FieldByName('ID_FORMA_PAGAMENTO').AsInteger;
        ID_COND_PAGAMENTO := AFDQ_Query.FieldByName('ID_COND_PAGAMENTO').AsInteger;
        VLR_CAIXA := AFDQ_Query.FieldByName('VLR_CAIXA').AsFloat;
        ID_USUARIO_CAD := AFDQ_Query.FieldByName('ID_USUARIO_CAD').AsInteger;
        DT_CADASTRO := AFDQ_Query.FieldByName('DT_CADASTRO').AsDateTime;
        HR_CADASTRO := AFDQ_Query.FieldByName('HR_CADASTRO').AsDateTime;
        ID_USUARIO_ALT := AFDQ_Query.FieldByName('ID_USUARIO_ALT').AsInteger;
        DT_ALTERADO := AFDQ_Query.FieldByName('DT_ALTERADO').AsDateTime;
        HR_ALTERADO := AFDQ_Query.FieldByName('HR_ALTERADO').AsDateTime;
      end; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TCAIXA.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FDT_CAIXA = 0 then 
        raise Exception.Create('DT_CAIXA: DATA DO CAIXA não informado'); 
      if FHR_CAIXA = 0 then 
        raise Exception.Create('HR_CAIXA: HORA DO CAIXA não informado'); 
      if FTIPO = -1 then 
        raise Exception.Create('TIPO: TIPO DA ENTRADA: 0-COMPRA, 1-VENDA não informado'); 
      if FID_FORMA_PAGAMENTO = -1 then 
        raise Exception.Create('ID_FORMA_PAGAMENTO:  não informado'); 
      if FID_COND_PAGAMENTO = -1 then 
        raise Exception.Create('ID_COND_PAGAMENTO:  não informado'); 
      if FVLR_CAIXA = 0 then 
        raise Exception.Create('VLR_CAIXA: VALOR DO CAIXA não informado'); 
      if FID_USUARIO_CAD = -1 then 
        raise Exception.Create('ID_USUARIO_CAD: USUARIO DE CADASTRO não informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO CAIXA( ');
      AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  ,DT_CAIXA');
      AFDQ_Query.Sql.Add('  ,HR_CAIXA');
      AFDQ_Query.Sql.Add('  ,TIPO');
      AFDQ_Query.Sql.Add('  ,ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,ID_FORMA_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,ID_COND_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,VLR_CAIXA');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO_CAD');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO_ALT');
      AFDQ_Query.Sql.Add('  ,DT_ALTERADO');
      AFDQ_Query.Sql.Add('  ,HR_ALTERADO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  ,:DT_CAIXA');
      AFDQ_Query.Sql.Add('  ,:HR_CAIXA');
      AFDQ_Query.Sql.Add('  ,:TIPO');
      AFDQ_Query.Sql.Add('  ,:ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,:ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,:ID_FORMA_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,:ID_COND_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,:VLR_CAIXA');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO_CAD');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO_ALT');
      AFDQ_Query.Sql.Add('  ,:DT_ALTERADO');
      AFDQ_Query.Sql.Add('  ,:HR_ALTERADO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('DT_CAIXA').AsDateTime := FDT_CAIXA;
      AFDQ_Query.ParamByName('HR_CAIXA').AsDateTime := FHR_CAIXA;
      AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      AFDQ_Query.ParamByName('ID_FORMA_PAGAMENTO').AsInteger := FID_FORMA_PAGAMENTO;
      AFDQ_Query.ParamByName('ID_COND_PAGAMENTO').AsInteger := FID_COND_PAGAMENTO;
      AFDQ_Query.ParamByName('VLR_CAIXA').AsFloat := FVLR_CAIXA;
      AFDQ_Query.ParamByName('ID_USUARIO_CAD').AsInteger := FID_USUARIO_CAD;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsDateTime := FHR_CADASTRO;
      AFDQ_Query.ParamByName('ID_USUARIO_ALT').AsInteger := FID_USUARIO_ALT;
      AFDQ_Query.ParamByName('DT_ALTERADO').AsDateTime := FDT_ALTERADO;
      AFDQ_Query.ParamByName('HR_ALTERADO').AsDateTime := FHR_ALTERADO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TCAIXA.Atualizar(const AFDQ_Query: TFDQuery; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE CAIXA SET ');
      if FDT_CAIXA > 0 then 
        AFDQ_Query.Sql.Add('  DT_CAIXA = :DT_CAIXA ');
      if FHR_CAIXA > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CAIXA = :HR_CAIXA ');
      if FTIPO > -1 then 
        AFDQ_Query.Sql.Add('  ,TIPO = :TIPO ');
      if FID_FORNECEDOR > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_FORNECEDOR = :ID_FORNECEDOR ');
      if FID_CLIENTE > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_CLIENTE = :ID_CLIENTE ');
      if FID_FORMA_PAGAMENTO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_FORMA_PAGAMENTO = :ID_FORMA_PAGAMENTO ');
      if FID_COND_PAGAMENTO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_COND_PAGAMENTO = :ID_COND_PAGAMENTO ');
      if FVLR_CAIXA > -1 then 
        AFDQ_Query.Sql.Add('  ,VLR_CAIXA = :VLR_CAIXA ');
      if FID_USUARIO_CAD > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO_CAD = :ID_USUARIO_CAD ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      if FID_USUARIO_ALT > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO_ALT = :ID_USUARIO_ALT ');
      if FDT_ALTERADO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_ALTERADO = :DT_ALTERADO ');
      if FHR_ALTERADO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_ALTERADO = :HR_ALTERADO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FDT_CAIXA > 0 then 
        AFDQ_Query.ParamByName('DT_CAIXA').AsDateTime := FDT_CAIXA;
      if FHR_CAIXA > 0 then 
        AFDQ_Query.ParamByName('HR_CAIXA').AsDateTime := FHR_CAIXA;
      if FTIPO > -1 then 
        AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
      if FID_FORNECEDOR > -1 then 
        AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      if FID_CLIENTE > -1 then 
        AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      if FID_FORMA_PAGAMENTO > -1 then 
        AFDQ_Query.ParamByName('ID_FORMA_PAGAMENTO').AsInteger := FID_FORMA_PAGAMENTO;
      if FID_COND_PAGAMENTO > -1 then 
        AFDQ_Query.ParamByName('ID_COND_PAGAMENTO').AsInteger := FID_COND_PAGAMENTO;
      if FVLR_CAIXA > -1 then 
        AFDQ_Query.ParamByName('VLR_CAIXA').AsFloat := FVLR_CAIXA;
      if FID_USUARIO_CAD > -1 then 
        AFDQ_Query.ParamByName('ID_USUARIO_CAD').AsInteger := FID_USUARIO_CAD;
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('HR_CADASTRO').AsDateTime := FHR_CADASTRO;
      if FID_USUARIO_ALT > -1 then 
        AFDQ_Query.ParamByName('ID_USUARIO_ALT').AsInteger := FID_USUARIO_ALT;
      if FDT_ALTERADO > 0 then 
        AFDQ_Query.ParamByName('DT_ALTERADO').AsDateTime := FDT_ALTERADO;
      if FHR_ALTERADO > 0 then 
        AFDQ_Query.ParamByName('HR_ALTERADO').AsDateTime := FHR_ALTERADO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TCAIXA.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM CAIXA '); 
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
 
procedure TCAIXA.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TCAIXA.SetDT_CAIXA( const Value:TDate);
begin 
  FDT_CAIXA := Value; 
end;
 
procedure TCAIXA.SetHR_CAIXA( const Value:TTime);
begin 
  FHR_CAIXA := Value; 
end;
 
procedure TCAIXA.SetTIPO( const Value:Integer);
begin 
  FTIPO := Value; 
end;
 
procedure TCAIXA.SetID_FORNECEDOR( const Value:Integer);
begin 
  FID_FORNECEDOR := Value; 
end;
 
procedure TCAIXA.SetID_CLIENTE( const Value:Integer);
begin 
  FID_CLIENTE := Value; 
end;
 
procedure TCAIXA.SetID_FORMA_PAGAMENTO( const Value:Integer);
begin 
  FID_FORMA_PAGAMENTO := Value; 
end;
 
procedure TCAIXA.SetID_COND_PAGAMENTO( const Value:Integer);
begin 
  FID_COND_PAGAMENTO := Value; 
end;
 
procedure TCAIXA.SetVLR_CAIXA( const Value:Double);
begin 
  FVLR_CAIXA := Value; 
end;
 
procedure TCAIXA.SetID_USUARIO_CAD( const Value:Integer);
begin 
  FID_USUARIO_CAD := Value; 
end;
 
procedure TCAIXA.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TCAIXA.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
procedure TCAIXA.SetID_USUARIO_ALT( const Value:Integer);
begin 
  FID_USUARIO_ALT := Value; 
end;
 
procedure TCAIXA.SetDT_ALTERADO( const Value:TDate);
begin 
  FDT_ALTERADO := Value; 
end;
 
procedure TCAIXA.SetHR_ALTERADO( const Value:TTime);
begin 
  FHR_ALTERADO := Value; 
end;
 
 
end. 
