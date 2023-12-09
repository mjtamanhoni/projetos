unit uModel.VENDA; 
 
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
  TVENDA = class 
  private 
    FConexao: TFDConnection; 
    
    FID :Integer;
    FDT_VENDA :TDate;
    FHR_VENDA :TTime;
    FID_CLIENTE :Integer;
    FID_FORMA_PAGAMENTO :Integer;
    FID_COND_PAGAMENTO :Integer;
    FSTATUS :Integer;
    FQTD_ITENS :Integer;
    FSUB_TOTAL :Double;
    FACRESCIMO :Double;
    FDESCONTO :Double;
    FTOTAL :Double;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetDT_VENDA( const Value:TDate);
    procedure SetHR_VENDA( const Value:TTime);
    procedure SetID_CLIENTE( const Value:Integer);
    procedure SetID_FORMA_PAGAMENTO( const Value:Integer);
    procedure SetID_COND_PAGAMENTO( const Value:Integer);
    procedure SetSTATUS( const Value:Integer);
    procedure SetQTD_ITENS( const Value:Integer);
    procedure SetSUB_TOTAL( const Value:Double);
    procedure SetACRESCIMO( const Value:Double);
    procedure SetDESCONTO( const Value:Double);
    procedure SetTOTAL( const Value:Double);
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
    function Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
 
    property ID:Integer read FID write SetID;
    property DT_VENDA:TDate read FDT_VENDA write SetDT_VENDA;
    property HR_VENDA:TTime read FHR_VENDA write SetHR_VENDA;
    property ID_CLIENTE:Integer read FID_CLIENTE write SetID_CLIENTE;
    property ID_FORMA_PAGAMENTO:Integer read FID_FORMA_PAGAMENTO write SetID_FORMA_PAGAMENTO;
    property ID_COND_PAGAMENTO:Integer read FID_COND_PAGAMENTO write SetID_COND_PAGAMENTO;
    property STATUS:Integer read FSTATUS write SetSTATUS;
    property QTD_ITENS:Integer read FQTD_ITENS write SetQTD_ITENS;
    property SUB_TOTAL:Double read FSUB_TOTAL write SetSUB_TOTAL;
    property ACRESCIMO:Double read FACRESCIMO write SetACRESCIMO;
    property DESCONTO:Double read FDESCONTO write SetDESCONTO;
    property TOTAL:Double read FTOTAL write SetTOTAL;
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
 
{ TVENDA }
 
constructor TVENDA.Create(AConnexao: TFDConnection); 
begin 
  FConexao := AConnexao; 
end; 
 
destructor TVENDA.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TVENDA.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela VENDA... 
            if Indice_Existe(FConexao,AFDQuery,'FK_VENDA_1') then 
              Add('DROP INDEX FK_VENDA_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_VENDA_2') then 
              Add('DROP INDEX FK_VENDA_2;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_VENDA_3') then 
              Add('DROP INDEX FK_VENDA_3;'); 
            if Indice_Existe(FConexao,AFDQuery,'VENDA_IDX1') then 
              Add('DROP INDEX VENDA_IDX1;'); 
            if Indice_Existe(FConexao,AFDQuery,'VENDA_IDX2') then 
              Add('DROP INDEX VENDA_IDX2;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'VENDA_BI') then 
              Add('DROP TRIGGER VENDA_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_VENDA_ID') then 
              Add('DROP GENERATOR GEN_VENDA_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'VENDA') then 
              Add('DROP TABLE VENDA;'); 
 
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
      lScript.Add('CREATE TABLE VENDA ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,DT_VENDA DATE NOT NULL');
      lScript.Add('  ,HR_VENDA TIME NOT NULL');
      lScript.Add('  ,ID_CLIENTE INTEGER NOT NULL');
      lScript.Add('  ,ID_FORMA_PAGAMENTO INTEGER NOT NULL');
      lScript.Add('  ,ID_COND_PAGAMENTO INTEGER NOT NULL');
      lScript.Add('  ,STATUS INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,QTD_ITENS INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,SUB_TOTAL NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,ACRESCIMO NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,DESCONTO NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,TOTAL NUMERIC(15,4) NOT NULL DEFAULT 0');
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
          Add('ALTER TABLE VENDA ADD CONSTRAINT PK_VENDA PRIMARY KEY (ID);');
          Add('ALTER TABLE VENDA ADD CONSTRAINT FK_VENDA_1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID) ;');
          Add('ALTER TABLE VENDA ADD CONSTRAINT FK_VENDA_2 FOREIGN KEY (ID_FORMA_PAGAMENTO) REFERENCES FORMA_PAGAMENTO(ID) ;');
          Add('ALTER TABLE VENDA ADD CONSTRAINT FK_VENDA_3 FOREIGN KEY (ID_COND_PAGAMENTO) REFERENCES CONDICAO_PAGAMENTO(ID) ;');
          Add('CREATE INDEX FK_VENDA_1 ON VENDA (ID_CLIENTE);');
          Add('CREATE INDEX FK_VENDA_2 ON VENDA (ID_FORMA_PAGAMENTO);');
          Add('CREATE INDEX FK_VENDA_3 ON VENDA (ID_COND_PAGAMENTO);');
          Add('CREATE INDEX VENDA_IDX1 ON VENDA (DT_VENDA);');
          Add('CREATE INDEX VENDA_IDX2 ON VENDA (STATUS);');
          Add('COMMENT ON COLUMN VENDA.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN VENDA.DT_VENDA IS ''DATA DA VENDA'';');
          Add('COMMENT ON COLUMN VENDA.HR_VENDA IS ''HORA DA VENDA'';');
          Add('COMMENT ON COLUMN VENDA.ID_CLIENTE IS ''CODIGO DO CLIENTE'';');
          Add('COMMENT ON COLUMN VENDA.ID_FORMA_PAGAMENTO IS ''FORMA DE PAGAMENTO'';');
          Add('COMMENT ON COLUMN VENDA.ID_COND_PAGAMENTO IS ''CONDICAO DE PAGAMENTO'';');
          Add('COMMENT ON COLUMN VENDA.STATUS IS ''STATUS: 0-ABERTO, 1-RENEGOCIADO, 2-PAGO'';');
          Add('COMMENT ON COLUMN VENDA.QTD_ITENS IS ''TOTAL DE ITENS'';');
          Add('COMMENT ON COLUMN VENDA.SUB_TOTAL IS ''SUB-TOTAL'';');
          Add('COMMENT ON COLUMN VENDA.ACRESCIMO IS ''ACRESCIMO'';');
          Add('COMMENT ON COLUMN VENDA.DESCONTO IS ''DESCONTO'';');
          Add('COMMENT ON COLUMN VENDA.TOTAL IS ''TOTAL'';');
          Add('COMMENT ON COLUMN VENDA.ID_USUARIO IS ''CODIGO DO USUARIO'';');
          Add('COMMENT ON COLUMN VENDA.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN VENDA.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('CREATE SEQUENCE GEN_VENDA_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER VENDA_BI FOR VENDA '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_VENDA_ID,1);');
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
 
procedure TVENDA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TVENDA.Inicia_Propriedades; 
begin 
  ID := -1; 
  DT_VENDA := Date; 
  HR_VENDA := Time; 
  ID_CLIENTE := -1; 
  ID_FORMA_PAGAMENTO := -1; 
  ID_COND_PAGAMENTO := -1; 
  STATUS := -1; 
  QTD_ITENS := -1; 
  SUB_TOTAL := 0; 
  ACRESCIMO := 0; 
  DESCONTO := 0; 
  TOTAL := 0; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end; 
 
function  TVENDA.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM VENDA') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := AID;
      AFDQ_Query.Active := True; 
      Result := AFDQ_Query.ToJSONArray; 
 
      if not AFDQ_Query.IsEmpty then 
      begin 
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        DT_VENDA := AFDQ_Query.FieldByName('DT_VENDA').AsDateTime;
        HR_VENDA := AFDQ_Query.FieldByName('HR_VENDA').AsDateTime;
        ID_CLIENTE := AFDQ_Query.FieldByName('ID_CLIENTE').AsInteger;
        ID_FORMA_PAGAMENTO := AFDQ_Query.FieldByName('ID_FORMA_PAGAMENTO').AsInteger;
        ID_COND_PAGAMENTO := AFDQ_Query.FieldByName('ID_COND_PAGAMENTO').AsInteger;
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        QTD_ITENS := AFDQ_Query.FieldByName('QTD_ITENS').AsInteger;
        SUB_TOTAL := AFDQ_Query.FieldByName('SUB_TOTAL').AsFloat;
        ACRESCIMO := AFDQ_Query.FieldByName('ACRESCIMO').AsFloat;
        DESCONTO := AFDQ_Query.FieldByName('DESCONTO').AsFloat;
        TOTAL := AFDQ_Query.FieldByName('TOTAL').AsFloat;
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
 
procedure TVENDA.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FDT_VENDA = 0 then 
        raise Exception.Create('DT_VENDA: DATA DA VENDA não informado'); 
      if FHR_VENDA = 0 then 
        raise Exception.Create('HR_VENDA: HORA DA VENDA não informado'); 
      if FID_CLIENTE = -1 then 
        raise Exception.Create('ID_CLIENTE: CODIGO DO CLIENTE não informado'); 
      if FID_FORMA_PAGAMENTO = -1 then 
        raise Exception.Create('ID_FORMA_PAGAMENTO: FORMA DE PAGAMENTO não informado'); 
      if FID_COND_PAGAMENTO = -1 then 
        raise Exception.Create('ID_COND_PAGAMENTO: CONDICAO DE PAGAMENTO não informado'); 
      if FSTATUS = -1 then 
        raise Exception.Create('STATUS: STATUS: 0-ABERTO, 1-RENEGOCIADO, 2-PAGO não informado'); 
      if FQTD_ITENS = -1 then 
        raise Exception.Create('QTD_ITENS: TOTAL DE ITENS não informado'); 
      if FSUB_TOTAL = 0 then 
        raise Exception.Create('SUB_TOTAL: SUB-TOTAL não informado'); 
      if FACRESCIMO = 0 then 
        raise Exception.Create('ACRESCIMO: ACRESCIMO não informado'); 
      if FDESCONTO = 0 then 
        raise Exception.Create('DESCONTO: DESCONTO não informado'); 
      if FTOTAL = 0 then 
        raise Exception.Create('TOTAL: TOTAL não informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USUARIO não informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO VENDA( ');
      AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  ,DT_VENDA');
      AFDQ_Query.Sql.Add('  ,HR_VENDA');
      AFDQ_Query.Sql.Add('  ,ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,ID_FORMA_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,ID_COND_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,STATUS');
      AFDQ_Query.Sql.Add('  ,QTD_ITENS');
      AFDQ_Query.Sql.Add('  ,SUB_TOTAL');
      AFDQ_Query.Sql.Add('  ,ACRESCIMO');
      AFDQ_Query.Sql.Add('  ,DESCONTO');
      AFDQ_Query.Sql.Add('  ,TOTAL');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  ,:DT_VENDA');
      AFDQ_Query.Sql.Add('  ,:HR_VENDA');
      AFDQ_Query.Sql.Add('  ,:ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,:ID_FORMA_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,:ID_COND_PAGAMENTO');
      AFDQ_Query.Sql.Add('  ,:STATUS');
      AFDQ_Query.Sql.Add('  ,:QTD_ITENS');
      AFDQ_Query.Sql.Add('  ,:SUB_TOTAL');
      AFDQ_Query.Sql.Add('  ,:ACRESCIMO');
      AFDQ_Query.Sql.Add('  ,:DESCONTO');
      AFDQ_Query.Sql.Add('  ,:TOTAL');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('DT_VENDA').AsDateTime := FDT_VENDA;
      AFDQ_Query.ParamByName('HR_VENDA').AsDateTime := FHR_VENDA;
      AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      AFDQ_Query.ParamByName('ID_FORMA_PAGAMENTO').AsInteger := FID_FORMA_PAGAMENTO;
      AFDQ_Query.ParamByName('ID_COND_PAGAMENTO').AsInteger := FID_COND_PAGAMENTO;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('QTD_ITENS').AsInteger := FQTD_ITENS;
      AFDQ_Query.ParamByName('SUB_TOTAL').AsFloat := FSUB_TOTAL;
      AFDQ_Query.ParamByName('ACRESCIMO').AsFloat := FACRESCIMO;
      AFDQ_Query.ParamByName('DESCONTO').AsFloat := FDESCONTO;
      AFDQ_Query.ParamByName('TOTAL').AsFloat := FTOTAL;
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
 
procedure TVENDA.Atualizar(const AFDQ_Query: TFDQuery; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE VENDA SET ');
      if FDT_VENDA > 0 then 
        AFDQ_Query.Sql.Add('  DT_VENDA = :DT_VENDA ');
      if FHR_VENDA > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_VENDA = :HR_VENDA ');
      if FID_CLIENTE > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_CLIENTE = :ID_CLIENTE ');
      if FID_FORMA_PAGAMENTO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_FORMA_PAGAMENTO = :ID_FORMA_PAGAMENTO ');
      if FID_COND_PAGAMENTO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_COND_PAGAMENTO = :ID_COND_PAGAMENTO ');
      if FSTATUS > -1 then 
        AFDQ_Query.Sql.Add('  ,STATUS = :STATUS ');
      if FQTD_ITENS > -1 then 
        AFDQ_Query.Sql.Add('  ,QTD_ITENS = :QTD_ITENS ');
      if FSUB_TOTAL > -1 then 
        AFDQ_Query.Sql.Add('  ,SUB_TOTAL = :SUB_TOTAL ');
      if FACRESCIMO > -1 then 
        AFDQ_Query.Sql.Add('  ,ACRESCIMO = :ACRESCIMO ');
      if FDESCONTO > -1 then 
        AFDQ_Query.Sql.Add('  ,DESCONTO = :DESCONTO ');
      if FTOTAL > -1 then 
        AFDQ_Query.Sql.Add('  ,TOTAL = :TOTAL ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FDT_VENDA > 0 then 
        AFDQ_Query.ParamByName('DT_VENDA').AsDateTime := FDT_VENDA;
      if FHR_VENDA > 0 then 
        AFDQ_Query.ParamByName('HR_VENDA').AsDateTime := FHR_VENDA;
      if FID_CLIENTE > -1 then 
        AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      if FID_FORMA_PAGAMENTO > -1 then 
        AFDQ_Query.ParamByName('ID_FORMA_PAGAMENTO').AsInteger := FID_FORMA_PAGAMENTO;
      if FID_COND_PAGAMENTO > -1 then 
        AFDQ_Query.ParamByName('ID_COND_PAGAMENTO').AsInteger := FID_COND_PAGAMENTO;
      if FSTATUS > -1 then 
        AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      if FQTD_ITENS > -1 then 
        AFDQ_Query.ParamByName('QTD_ITENS').AsInteger := FQTD_ITENS;
      if FSUB_TOTAL > -1 then 
        AFDQ_Query.ParamByName('SUB_TOTAL').AsFloat := FSUB_TOTAL;
      if FACRESCIMO > -1 then 
        AFDQ_Query.ParamByName('ACRESCIMO').AsFloat := FACRESCIMO;
      if FDESCONTO > -1 then 
        AFDQ_Query.ParamByName('DESCONTO').AsFloat := FDESCONTO;
      if FTOTAL > -1 then 
        AFDQ_Query.ParamByName('TOTAL').AsFloat := FTOTAL;
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
 
procedure TVENDA.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM VENDA '); 
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
 
procedure TVENDA.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TVENDA.SetDT_VENDA( const Value:TDate);
begin 
  FDT_VENDA := Value; 
end;
 
procedure TVENDA.SetHR_VENDA( const Value:TTime);
begin 
  FHR_VENDA := Value; 
end;
 
procedure TVENDA.SetID_CLIENTE( const Value:Integer);
begin 
  FID_CLIENTE := Value; 
end;
 
procedure TVENDA.SetID_FORMA_PAGAMENTO( const Value:Integer);
begin 
  FID_FORMA_PAGAMENTO := Value; 
end;
 
procedure TVENDA.SetID_COND_PAGAMENTO( const Value:Integer);
begin 
  FID_COND_PAGAMENTO := Value; 
end;
 
procedure TVENDA.SetSTATUS( const Value:Integer);
begin 
  FSTATUS := Value; 
end;
 
procedure TVENDA.SetQTD_ITENS( const Value:Integer);
begin 
  FQTD_ITENS := Value; 
end;
 
procedure TVENDA.SetSUB_TOTAL( const Value:Double);
begin 
  FSUB_TOTAL := Value; 
end;
 
procedure TVENDA.SetACRESCIMO( const Value:Double);
begin 
  FACRESCIMO := Value; 
end;
 
procedure TVENDA.SetDESCONTO( const Value:Double);
begin 
  FDESCONTO := Value; 
end;
 
procedure TVENDA.SetTOTAL( const Value:Double);
begin 
  FTOTAL := Value; 
end;
 
procedure TVENDA.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TVENDA.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TVENDA.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
