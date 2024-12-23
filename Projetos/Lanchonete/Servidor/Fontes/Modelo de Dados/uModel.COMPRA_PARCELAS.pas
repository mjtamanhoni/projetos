unit uModel.COMPRA_PARCELAS; 
 
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
  TCOMPRA_PARCELAS = class 
  private 
    FConexao: TFDConnection; 
    
    FID_COMPRA :Integer;
    FID :Integer;
    FPARCELA :Integer;
    FDT_VENCIMENTO :TDate;
    FVLR_PARCELA :Double;
    FSTATUS :Integer;
    FACRESCIMO :Double;
    FDESCONTO :Double;
    FDT_PAGO :TDate;
    FHR_PAGO :TTime;
    FVLR_PAGO :Double;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID_COMPRA( const Value:Integer);
    procedure SetID( const Value:Integer);
    procedure SetPARCELA( const Value:Integer);
    procedure SetDT_VENCIMENTO( const Value:TDate);
    procedure SetVLR_PARCELA( const Value:Double);
    procedure SetSTATUS( const Value:Integer);
    procedure SetACRESCIMO( const Value:Double);
    procedure SetDESCONTO( const Value:Double);
    procedure SetDT_PAGO( const Value:TDate);
    procedure SetHR_PAGO( const Value:TTime);
    procedure SetVLR_PAGO( const Value:Double);
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
    function Listar(const AFDQ_Query:TFDQuery; AID_COMPRA:Integer = 0; AID:Integer = 0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID_COMPRA:Integer = 0; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID_COMPRA:Integer = 0; AID:Integer = 0); 
 
    property ID_COMPRA:Integer read FID_COMPRA write SetID_COMPRA;
    property ID:Integer read FID write SetID;
    property PARCELA:Integer read FPARCELA write SetPARCELA;
    property DT_VENCIMENTO:TDate read FDT_VENCIMENTO write SetDT_VENCIMENTO;
    property VLR_PARCELA:Double read FVLR_PARCELA write SetVLR_PARCELA;
    property STATUS:Integer read FSTATUS write SetSTATUS;
    property ACRESCIMO:Double read FACRESCIMO write SetACRESCIMO;
    property DESCONTO:Double read FDESCONTO write SetDESCONTO;
    property DT_PAGO:TDate read FDT_PAGO write SetDT_PAGO;
    property HR_PAGO:TTime read FHR_PAGO write SetHR_PAGO;
    property VLR_PAGO:Double read FVLR_PAGO write SetVLR_PAGO;
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
 
{ TCOMPRA_PARCELAS }
 
constructor TCOMPRA_PARCELAS.Create(AConnexao: TFDConnection); 
begin 
  FConexao := AConnexao; 
end; 
 
destructor TCOMPRA_PARCELAS.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TCOMPRA_PARCELAS.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela COMPRA_PARCELAS... 
            if Indice_Existe(FConexao,AFDQuery,'FK_COMPRA_PARCELAS_1') then 
              Add('DROP INDEX FK_COMPRA_PARCELAS_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'COMPRA_PARCELAS_IDX1') then 
              Add('DROP INDEX COMPRA_PARCELAS_IDX1;'); 
            if Indice_Existe(FConexao,AFDQuery,'COMPRA_PARCELAS_IDX2') then 
              Add('DROP INDEX COMPRA_PARCELAS_IDX2;'); 
            if Indice_Existe(FConexao,AFDQuery,'COMPRA_PARCELAS_IDX3') then 
              Add('DROP INDEX COMPRA_PARCELAS_IDX3;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'COMPRA_PARCELAS_BI') then 
              Add('DROP TRIGGER COMPRA_PARCELAS_BI;'); 
 
 
            if Tabela_Existe(FConexao,AFDQuery,'COMPRA_PARCELAS') then 
              Add('DROP TABLE COMPRA_PARCELAS;'); 
 
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
      lScript.Add('CREATE TABLE COMPRA_PARCELAS ( '); 
      lScript.Add('  ID_COMPRA INTEGER NOT NULL');
      lScript.Add('  ,ID INTEGER NOT NULL');
      lScript.Add('  ,PARCELA INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,DT_VENCIMENTO DATE NOT NULL');
      lScript.Add('  ,VLR_PARCELA NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,STATUS INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,ACRESCIMO NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,DESCONTO NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,DT_PAGO DATE');
      lScript.Add('  ,HR_PAGO TIME');
      lScript.Add('  ,VLR_PAGO NUMERIC(15,4) NOT NULL DEFAULT 0');
      lScript.Add('  ,ID_USUARIO INTEGER NOT NULL');
      lScript.Add('  ,DT_CADASTRO DATE NOT NULL');
      lScript.Add('  ,HR_CADASTRO TIME NOT NULL');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE COMPRA_PARCELAS ADD CONSTRAINT PK_COMPRA_PARCELAS PRIMARY KEY (ID_COMPRA,ID);');
          Add('ALTER TABLE COMPRA_PARCELAS ADD CONSTRAINT FK_COMPRA_PARCELAS_1 FOREIGN KEY (ID_COMPRA) REFERENCES COMPRA(ID) ON DELETE CASCADE;');
          Add('CREATE INDEX FK_COMPRA_PARCELAS_1 ON COMPRA_PARCELAS (ID_COMPRA);');
          Add('CREATE INDEX COMPRA_PARCELAS_IDX1 ON COMPRA_PARCELAS (STATUS);');
          Add('CREATE INDEX COMPRA_PARCELAS_IDX2 ON COMPRA_PARCELAS (DT_VENCIMENTO);');
          Add('CREATE INDEX COMPRA_PARCELAS_IDX3 ON COMPRA_PARCELAS (DT_PAGO);');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.ID_COMPRA IS ''CODIGO DA COMPRA'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.PARCELA IS ''CODIGO DA PARCELA'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.DT_VENCIMENTO IS ''DATA DO VENCIMENTO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.VLR_PARCELA IS ''VARLO DA PARCELA'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.STATUS IS ''STATUS: 0-ABERTO, 1-PAGO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.ACRESCIMO IS ''ACRESCIMO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.DESCONTO IS ''DESCONTO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.DT_PAGO IS ''DATA DO PAGAMENTO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.HR_PAGO IS ''HORA DO PAGAMENTO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.VLR_PAGO IS ''VALOR PAGO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.ID_USUARIO IS ''CODIGO DO USUARIO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN COMPRA_PARCELAS.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER COMPRA_PARCELAS_BI FOR COMPRA_PARCELAS '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM COMPRA_PARCELAS WHERE ID_COMPRA = NEW.ID_COMPRA INTO NEW.ID;');
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
 
procedure TCOMPRA_PARCELAS.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TCOMPRA_PARCELAS.Inicia_Propriedades; 
begin 
  ID_COMPRA := -1; 
  ID := -1; 
  PARCELA := -1; 
  DT_VENCIMENTO := Date; 
  VLR_PARCELA := 0; 
  STATUS := -1; 
  ACRESCIMO := 0; 
  DESCONTO := 0; 
  DT_PAGO := Date; 
  HR_PAGO := Time; 
  VLR_PAGO := 0; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end; 
 
function  TCOMPRA_PARCELAS.Listar(const AFDQ_Query:TFDQuery; AID_COMPRA:Integer = 0; AID:Integer = 0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM COMPRA_PARCELAS') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_COMPRA = :ID_COMPRA');
      AFDQ_Query.ParamByName('ID_COMPRA').AsInteger := AID_COMPRA;
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := AID;
      AFDQ_Query.Active := True; 
      Result := AFDQ_Query.ToJSONArray; 
 
      if not AFDQ_Query.IsEmpty then 
      begin 
        ID_COMPRA := AFDQ_Query.FieldByName('ID_COMPRA').AsInteger;
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        PARCELA := AFDQ_Query.FieldByName('PARCELA').AsInteger;
        DT_VENCIMENTO := AFDQ_Query.FieldByName('DT_VENCIMENTO').AsDateTime;
        VLR_PARCELA := AFDQ_Query.FieldByName('VLR_PARCELA').AsFloat;
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        ACRESCIMO := AFDQ_Query.FieldByName('ACRESCIMO').AsFloat;
        DESCONTO := AFDQ_Query.FieldByName('DESCONTO').AsFloat;
        DT_PAGO := AFDQ_Query.FieldByName('DT_PAGO').AsDateTime;
        HR_PAGO := AFDQ_Query.FieldByName('HR_PAGO').AsDateTime;
        VLR_PAGO := AFDQ_Query.FieldByName('VLR_PAGO').AsFloat;
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
 
procedure TCOMPRA_PARCELAS.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FPARCELA = -1 then 
        raise Exception.Create('PARCELA: CODIGO DA PARCELA não informado'); 
      if FDT_VENCIMENTO = 0 then 
        raise Exception.Create('DT_VENCIMENTO: DATA DO VENCIMENTO não informado'); 
      if FVLR_PARCELA = 0 then 
        raise Exception.Create('VLR_PARCELA: VARLO DA PARCELA não informado'); 
      if FSTATUS = -1 then 
        raise Exception.Create('STATUS: STATUS: 0-ABERTO, 1-PAGO não informado'); 
      if FACRESCIMO = 0 then 
        raise Exception.Create('ACRESCIMO: ACRESCIMO não informado'); 
      if FDESCONTO = 0 then 
        raise Exception.Create('DESCONTO: DESCONTO não informado'); 
      if FVLR_PAGO = 0 then 
        raise Exception.Create('VLR_PAGO: VALOR PAGO não informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USUARIO não informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO COMPRA_PARCELAS( ');
      AFDQ_Query.Sql.Add('  ID_COMPRA');
      AFDQ_Query.Sql.Add('  ,ID');
      AFDQ_Query.Sql.Add('  ,PARCELA');
      AFDQ_Query.Sql.Add('  ,DT_VENCIMENTO');
      AFDQ_Query.Sql.Add('  ,VLR_PARCELA');
      AFDQ_Query.Sql.Add('  ,STATUS');
      AFDQ_Query.Sql.Add('  ,ACRESCIMO');
      AFDQ_Query.Sql.Add('  ,DESCONTO');
      AFDQ_Query.Sql.Add('  ,DT_PAGO');
      AFDQ_Query.Sql.Add('  ,HR_PAGO');
      AFDQ_Query.Sql.Add('  ,VLR_PAGO');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_COMPRA');
      AFDQ_Query.Sql.Add('  ,:ID');
      AFDQ_Query.Sql.Add('  ,:PARCELA');
      AFDQ_Query.Sql.Add('  ,:DT_VENCIMENTO');
      AFDQ_Query.Sql.Add('  ,:VLR_PARCELA');
      AFDQ_Query.Sql.Add('  ,:STATUS');
      AFDQ_Query.Sql.Add('  ,:ACRESCIMO');
      AFDQ_Query.Sql.Add('  ,:DESCONTO');
      AFDQ_Query.Sql.Add('  ,:DT_PAGO');
      AFDQ_Query.Sql.Add('  ,:HR_PAGO');
      AFDQ_Query.Sql.Add('  ,:VLR_PAGO');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_COMPRA').AsInteger := FID_COMPRA;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('PARCELA').AsInteger := FPARCELA;
      AFDQ_Query.ParamByName('DT_VENCIMENTO').AsDateTime := FDT_VENCIMENTO;
      AFDQ_Query.ParamByName('VLR_PARCELA').AsFloat := FVLR_PARCELA;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('ACRESCIMO').AsFloat := FACRESCIMO;
      AFDQ_Query.ParamByName('DESCONTO').AsFloat := FDESCONTO;
      AFDQ_Query.ParamByName('DT_PAGO').AsDateTime := FDT_PAGO;
      AFDQ_Query.ParamByName('HR_PAGO').AsDateTime := FHR_PAGO;
      AFDQ_Query.ParamByName('VLR_PAGO').AsFloat := FVLR_PAGO;
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
 
procedure TCOMPRA_PARCELAS.Atualizar(const AFDQ_Query: TFDQuery; AID_COMPRA:Integer = 0; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE COMPRA_PARCELAS SET ');
      if FPARCELA > -1 then 
        AFDQ_Query.Sql.Add('  PARCELA = :PARCELA ');
      if FDT_VENCIMENTO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_VENCIMENTO = :DT_VENCIMENTO ');
      if FVLR_PARCELA > -1 then 
        AFDQ_Query.Sql.Add('  ,VLR_PARCELA = :VLR_PARCELA ');
      if FSTATUS > -1 then 
        AFDQ_Query.Sql.Add('  ,STATUS = :STATUS ');
      if FACRESCIMO > -1 then 
        AFDQ_Query.Sql.Add('  ,ACRESCIMO = :ACRESCIMO ');
      if FDESCONTO > -1 then 
        AFDQ_Query.Sql.Add('  ,DESCONTO = :DESCONTO ');
      if FDT_PAGO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_PAGO = :DT_PAGO ');
      if FHR_PAGO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_PAGO = :HR_PAGO ');
      if FVLR_PAGO > -1 then 
        AFDQ_Query.Sql.Add('  ,VLR_PAGO = :VLR_PAGO ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_COMPRA = :ID_COMPRA');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID_COMPRA').AsInteger := FID_COMPRA;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FPARCELA > -1 then 
        AFDQ_Query.ParamByName('PARCELA').AsInteger := FPARCELA;
      if FDT_VENCIMENTO > 0 then 
        AFDQ_Query.ParamByName('DT_VENCIMENTO').AsDateTime := FDT_VENCIMENTO;
      if FVLR_PARCELA > -1 then 
        AFDQ_Query.ParamByName('VLR_PARCELA').AsFloat := FVLR_PARCELA;
      if FSTATUS > -1 then 
        AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      if FACRESCIMO > -1 then 
        AFDQ_Query.ParamByName('ACRESCIMO').AsFloat := FACRESCIMO;
      if FDESCONTO > -1 then 
        AFDQ_Query.ParamByName('DESCONTO').AsFloat := FDESCONTO;
      if FDT_PAGO > 0 then 
        AFDQ_Query.ParamByName('DT_PAGO').AsDateTime := FDT_PAGO;
      if FHR_PAGO > 0 then 
        AFDQ_Query.ParamByName('HR_PAGO').AsDateTime := FHR_PAGO;
      if FVLR_PAGO > -1 then 
        AFDQ_Query.ParamByName('VLR_PAGO').AsFloat := FVLR_PAGO;
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
 
procedure TCOMPRA_PARCELAS.Excluir(const AFDQ_Query:TFDQuery; AID_COMPRA:Integer = 0; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM COMPRA_PARCELAS '); 
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL '); 
      AFDQ_Query.Sql.Add('  AND ID_COMPRA = :ID_COMPRA');
      AFDQ_Query.ParamByName('ID_COMPRA').AsInteger := AID_COMPRA;
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
 
procedure TCOMPRA_PARCELAS.SetID_COMPRA( const Value:Integer);
begin 
  FID_COMPRA := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetPARCELA( const Value:Integer);
begin 
  FPARCELA := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetDT_VENCIMENTO( const Value:TDate);
begin 
  FDT_VENCIMENTO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetVLR_PARCELA( const Value:Double);
begin 
  FVLR_PARCELA := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetSTATUS( const Value:Integer);
begin 
  FSTATUS := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetACRESCIMO( const Value:Double);
begin 
  FACRESCIMO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetDESCONTO( const Value:Double);
begin 
  FDESCONTO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetDT_PAGO( const Value:TDate);
begin 
  FDT_PAGO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetHR_PAGO( const Value:TTime);
begin 
  FHR_PAGO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetVLR_PAGO( const Value:Double);
begin 
  FVLR_PAGO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TCOMPRA_PARCELAS.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
