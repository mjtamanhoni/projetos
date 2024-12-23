unit uModel.SERVICOS_PRESTADOS;
 
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
  TSERVICOS_PRESTADOS = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer; 
    FPaginas :Integer; 
    
    FID :Integer;
    FDESCRICAO :String;
    FSTATUS :Integer;
    FID_PRESTADOR_SERVICO :Integer;
    FID_CLIENTE :Integer;
    FID_TABELA :Integer;
    FDATA :TDate;
    FHR_INICIO :TTime;
    FHR_FIM :TTime;
    FHR_TOTAL :TTime;
    FVLR_HORA :Double;
    FSUB_TOTAL :Double;
    FDESCONTO :Double;
    FDESCONTO_MOTIVO :String;
    FACRESCIMO :Double;
    FACRESCIMO_MOTIVO :String;
    FTOTAL :Double;
    FDT_PAGO :TDate;
    FVLR_PAGO :Double;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
    FID_USUARIO :Integer;
 
    procedure SetID( const Value:Integer);
    procedure SetDESCRICAO( const Value:String);
    procedure SetSTATUS( const Value:Integer);
    procedure SetID_PRESTADOR_SERVICO( const Value:Integer);
    procedure SetID_CLIENTE( const Value:Integer);
    procedure SetID_TABELA( const Value:Integer);
    procedure SetDATA( const Value:TDate);
    procedure SetHR_INICIO( const Value:TTime);
    procedure SetHR_FIM( const Value:TTime);
    procedure SetHR_TOTAL( const Value:TTime);
    procedure SetVLR_HORA( const Value:Double);
    procedure SetSUB_TOTAL( const Value:Double);
    procedure SetDESCONTO( const Value:Double);
    procedure SetDESCONTO_MOTIVO( const Value:String);
    procedure SetACRESCIMO( const Value:Double);
    procedure SetACRESCIMO_MOTIVO( const Value:String);
    procedure SetTOTAL( const Value:Double);
    procedure SetDT_PAGO( const Value:TDate);
    procedure SetVLR_PAGO( const Value:Double);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHR_CADASTRO( const Value:TTime);
    procedure SetID_USUARIO( const Value:Integer);
 
  public 
    constructor Create(AConnexao: TFDConnection); 
    destructor Destroy; override; 
 
    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery); 
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery); 
    procedure Inicia_Propriedades; 
    procedure Inserir(const AFDQ_Query:TFDQuery); 
    function Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
 
    property ID:Integer read FID write SetID;
    property DESCRICAO:String read FDESCRICAO write SetDESCRICAO;
    property STATUS:Integer read FSTATUS write SetSTATUS;
    property ID_PRESTADOR_SERVICO:Integer read FID_PRESTADOR_SERVICO write SetID_PRESTADOR_SERVICO;
    property ID_CLIENTE:Integer read FID_CLIENTE write SetID_CLIENTE;
    property ID_TABELA:Integer read FID_TABELA write SetID_TABELA;
    property DATA:TDate read FDATA write SetDATA;
    property HR_INICIO:TTime read FHR_INICIO write SetHR_INICIO;
    property HR_FIM:TTime read FHR_FIM write SetHR_FIM;
    property HR_TOTAL:TTime read FHR_TOTAL write SetHR_TOTAL;
    property VLR_HORA:Double read FVLR_HORA write SetVLR_HORA;
    property SUB_TOTAL:Double read FSUB_TOTAL write SetSUB_TOTAL;
    property DESCONTO:Double read FDESCONTO write SetDESCONTO;
    property DESCONTO_MOTIVO:String read FDESCONTO_MOTIVO write SetDESCONTO_MOTIVO;
    property ACRESCIMO:Double read FACRESCIMO write SetACRESCIMO;
    property ACRESCIMO_MOTIVO:String read FACRESCIMO_MOTIVO write SetACRESCIMO_MOTIVO;
    property TOTAL:Double read FTOTAL write SetTOTAL;
    property DT_PAGO:TDate read FDT_PAGO write SetDT_PAGO;
    property VLR_PAGO:Double read FVLR_PAGO write SetVLR_PAGO;
    property DT_CADASTRO:TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO:TTime read FHR_CADASTRO write SetHR_CADASTRO;
    property ID_USUARIO:Integer read FID_USUARIO write SetID_USUARIO;
 
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
 
{ TSERVICOS_PRESTADOS }
 
constructor TSERVICOS_PRESTADOS.Create(AConnexao: TFDConnection); 
begin 
  FPaginas := C_Paginas; 
  FConexao := AConnexao; 
end; 
 
destructor TSERVICOS_PRESTADOS.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TSERVICOS_PRESTADOS.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela SERVICOS_PRESTADOS... 
            if Indice_Existe(FConexao,AFDQuery,'FK_SERVICOS_PRESTADOS_1') then 
              Add('DROP INDEX FK_SERVICOS_PRESTADOS_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_SERVICOS_PRESTADOS_2') then 
              Add('DROP INDEX FK_SERVICOS_PRESTADOS_2;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_SERVICOS_PRESTADOS_3') then 
              Add('DROP INDEX FK_SERVICOS_PRESTADOS_3;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_SERVICOS_PRESTADOS_4') then 
              Add('DROP INDEX FK_SERVICOS_PRESTADOS_4;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'SERVICOS_PRESTADOS_BI') then 
              Add('DROP TRIGGER SERVICOS_PRESTADOS_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_SERVICOS_PRESTADOS_ID') then 
              Add('DROP GENERATOR GEN_SERVICOS_PRESTADOS_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'SERVICOS_PRESTADOS') then 
              Add('DROP TABLE SERVICOS_PRESTADOS;'); 
 
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
      lScript.Add('CREATE TABLE SERVICOS_PRESTADOS ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,DESCRICAO VARCHAR(500)');
      lScript.Add('  ,STATUS INTEGER NOT NULL');
      lScript.Add('  ,ID_PRESTADOR_SERVICO INTEGER NOT NULL');
      lScript.Add('  ,ID_CLIENTE INTEGER NOT NULL');
      lScript.Add('  ,ID_TABELA INTEGER NOT NULL');
      lScript.Add('  ,DATA DATE NOT NULL');
      lScript.Add('  ,HR_INICIO TIME');
      lScript.Add('  ,HR_FIM TIME');
      lScript.Add('  ,HR_TOTAL TIME');
      lScript.Add('  ,VLR_HORA NUMERIC(15,2) DEFAULT 0');
      lScript.Add('  ,SUB_TOTAL NUMERIC(15,2) DEFAULT 0');
      lScript.Add('  ,DESCONTO NUMERIC(15,2) DEFAULT 0');
      lScript.Add('  ,DESCONTO_MOTIVO VARCHAR(500)');
      lScript.Add('  ,ACRESCIMO NUMERIC(15,2) DEFAULT 0');
      lScript.Add('  ,ACRESCIMO_MOTIVO VARCHAR(500)');
      lScript.Add('  ,TOTAL NUMERIC(15,2) DEFAULT 0');
      lScript.Add('  ,DT_PAGO DATE');
      lScript.Add('  ,VLR_PAGO NUMERIC(15,2)');
      lScript.Add('  ,DT_CADASTRO DATE DEFAULT CURRENT_DATE');
      lScript.Add('  ,HR_CADASTRO TIME DEFAULT CURRENT_TIME');
      lScript.Add('  ,ID_USUARIO INTEGER');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE SERVICOS_PRESTADOS ADD CONSTRAINT PK_SERVICOS_PRESTADOS PRIMARY KEY (ID);');
          Add('ALTER TABLE SERVICOS_PRESTADOS ADD CONSTRAINT FK_SERVICOS_PRESTADOS_1 FOREIGN KEY (ID_PRESTADOR_SERVICO) REFERENCES PRESTADOR_SERVICO(ID) ;');
          Add('ALTER TABLE SERVICOS_PRESTADOS ADD CONSTRAINT FK_SERVICOS_PRESTADOS_2 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID) ;');
          Add('ALTER TABLE SERVICOS_PRESTADOS ADD CONSTRAINT FK_SERVICOS_PRESTADOS_3 FOREIGN KEY (ID_TABELA) REFERENCES TABELA_PRECO(ID) ;');
          Add('ALTER TABLE SERVICOS_PRESTADOS ADD CONSTRAINT FK_SERVICOS_PRESTADOS_4 FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID) ;');
          Add('CREATE INDEX FK_SERVICOS_PRESTADOS_1 ON SERVICOS_PRESTADOS (ID_PRESTADOR_SERVICO);');
          Add('CREATE INDEX FK_SERVICOS_PRESTADOS_2 ON SERVICOS_PRESTADOS (ID_CLIENTE);');
          Add('CREATE INDEX FK_SERVICOS_PRESTADOS_3 ON SERVICOS_PRESTADOS (ID_TABELA);');
          Add('CREATE INDEX FK_SERVICOS_PRESTADOS_4 ON SERVICOS_PRESTADOS (ID_USUARIO);');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.ID IS ''ID'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.DESCRICAO IS ''DESCRICAO DO SERVICO PRESTADO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.STATUS IS ''STATUS DO SERVICO: 0-ABERTO, 1-PAGO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.ID_PRESTADOR_SERVICO IS ''ID DO PRESTADOR'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.ID_CLIENTE IS ''TOMADOR DO SERVICO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.ID_TABELA IS ''ID DA TABELA'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.DATA IS ''DATA DA PRESTACAO DO SERVICO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.HR_INICIO IS ''INICIO DO SERVICO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.HR_FIM IS ''TERMINO DO SERVICO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.HR_TOTAL IS ''TOTAL DE HORAS GASTAS'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.VLR_HORA IS ''VALOR DA HORA'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.SUB_TOTAL IS ''TOTAL BRUTO DO SERVICO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.DESCONTO IS ''VALOR DO DESCONTO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.DESCONTO_MOTIVO IS ''MOTIVO DO DESCONTO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.ACRESCIMO IS ''VARLO DO ACRESCIMO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.ACRESCIMO_MOTIVO IS ''MOTIVO DO ACRESCIMO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.TOTAL IS ''TOTAL LIQUIDO A RECEBER'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.DT_PAGO IS ''DATA DO PAGAMENTO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.VLR_PAGO IS ''VALOR DO PAGAMENTO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('COMMENT ON COLUMN SERVICOS_PRESTADOS.ID_USUARIO IS ''USUARIO QUE EFETUOU O CADASTRO'';');
          Add('CREATE SEQUENCE GEN_SERVICOS_PRESTADOS_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER SERVICOS_PRESTADOS_BI FOR SERVICOS_PRESTADOS '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_SERVICOS_PRESTADOS_ID,1);');
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
 
procedure TSERVICOS_PRESTADOS.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TSERVICOS_PRESTADOS.Inicia_Propriedades; 
begin 
  ID := -1; 
  DESCRICAO := ''; 
  STATUS := -1; 
  ID_PRESTADOR_SERVICO := -1; 
  ID_CLIENTE := -1; 
  ID_TABELA := -1; 
  DATA := Date; 
  HR_INICIO := Time; 
  HR_FIM := Time; 
  HR_TOTAL := Time; 
  VLR_HORA := 0; 
  SUB_TOTAL := 0; 
  DESCONTO := 0; 
  DESCONTO_MOTIVO := ''; 
  ACRESCIMO := 0; 
  ACRESCIMO_MOTIVO := ''; 
  TOTAL := 0; 
  DT_PAGO := Date; 
  VLR_PAGO := 0; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
  ID_USUARIO := -1; 
end; 
 
function  TSERVICOS_PRESTADOS.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM SERVICOS_PRESTADOS') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND ID = ' + AID.ToString);

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
        DESCRICAO := AFDQ_Query.FieldByName('DESCRICAO').AsString;
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        ID_PRESTADOR_SERVICO := AFDQ_Query.FieldByName('ID_PRESTADOR_SERVICO').AsInteger;
        ID_CLIENTE := AFDQ_Query.FieldByName('ID_CLIENTE').AsInteger;
        ID_TABELA := AFDQ_Query.FieldByName('ID_TABELA').AsInteger;
        DATA := AFDQ_Query.FieldByName('DATA').AsDateTime;
        HR_INICIO := AFDQ_Query.FieldByName('HR_INICIO').AsDateTime;
        HR_FIM := AFDQ_Query.FieldByName('HR_FIM').AsDateTime;
        HR_TOTAL := AFDQ_Query.FieldByName('HR_TOTAL').AsDateTime;
        VLR_HORA := AFDQ_Query.FieldByName('VLR_HORA').AsFloat;
        SUB_TOTAL := AFDQ_Query.FieldByName('SUB_TOTAL').AsFloat;
        DESCONTO := AFDQ_Query.FieldByName('DESCONTO').AsFloat;
        DESCONTO_MOTIVO := AFDQ_Query.FieldByName('DESCONTO_MOTIVO').AsString;
        ACRESCIMO := AFDQ_Query.FieldByName('ACRESCIMO').AsFloat;
        ACRESCIMO_MOTIVO := AFDQ_Query.FieldByName('ACRESCIMO_MOTIVO').AsString;
        TOTAL := AFDQ_Query.FieldByName('TOTAL').AsFloat;
        DT_PAGO := AFDQ_Query.FieldByName('DT_PAGO').AsDateTime;
        VLR_PAGO := AFDQ_Query.FieldByName('VLR_PAGO').AsFloat;
        DT_CADASTRO := AFDQ_Query.FieldByName('DT_CADASTRO').AsDateTime;
        HR_CADASTRO := AFDQ_Query.FieldByName('HR_CADASTRO').AsDateTime;
        ID_USUARIO := AFDQ_Query.FieldByName('ID_USUARIO').AsInteger;
      end; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TSERVICOS_PRESTADOS.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FSTATUS = -1 then 
        raise Exception.Create('STATUS: STATUS DO SERVICO: 0-ABERTO, 1-PAGO não informado'); 
      if FID_PRESTADOR_SERVICO = -1 then 
        raise Exception.Create('ID_PRESTADOR_SERVICO: ID DO PRESTADOR não informado'); 
      if FID_CLIENTE = -1 then 
        raise Exception.Create('ID_CLIENTE: TOMADOR DO SERVICO não informado'); 
      if FID_TABELA = -1 then 
        raise Exception.Create('ID_TABELA: ID DA TABELA não informado'); 
      if FDATA = 0 then 
        raise Exception.Create('DATA: DATA DA PRESTACAO DO SERVICO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO SERVICOS_PRESTADOS( ');
      //AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  DESCRICAO');
      AFDQ_Query.Sql.Add('  ,STATUS');
      AFDQ_Query.Sql.Add('  ,ID_PRESTADOR_SERVICO');
      AFDQ_Query.Sql.Add('  ,ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,ID_TABELA');
      AFDQ_Query.Sql.Add('  ,DATA');
      AFDQ_Query.Sql.Add('  ,HR_INICIO');
      AFDQ_Query.Sql.Add('  ,HR_FIM');
      AFDQ_Query.Sql.Add('  ,HR_TOTAL');
      AFDQ_Query.Sql.Add('  ,VLR_HORA');
      AFDQ_Query.Sql.Add('  ,SUB_TOTAL');
      AFDQ_Query.Sql.Add('  ,DESCONTO');
      AFDQ_Query.Sql.Add('  ,DESCONTO_MOTIVO');
      AFDQ_Query.Sql.Add('  ,ACRESCIMO');
      AFDQ_Query.Sql.Add('  ,ACRESCIMO_MOTIVO');
      AFDQ_Query.Sql.Add('  ,TOTAL');
      AFDQ_Query.Sql.Add('  ,DT_PAGO');
      AFDQ_Query.Sql.Add('  ,VLR_PAGO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add(') VALUES(');
      //AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  :DESCRICAO');
      AFDQ_Query.Sql.Add('  ,:STATUS');
      AFDQ_Query.Sql.Add('  ,:ID_PRESTADOR_SERVICO');
      AFDQ_Query.Sql.Add('  ,:ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,:ID_TABELA');
      AFDQ_Query.Sql.Add('  ,:DATA');
      AFDQ_Query.Sql.Add('  ,:HR_INICIO');
      AFDQ_Query.Sql.Add('  ,:HR_FIM');
      AFDQ_Query.Sql.Add('  ,:HR_TOTAL');
      AFDQ_Query.Sql.Add('  ,:VLR_HORA');
      AFDQ_Query.Sql.Add('  ,:SUB_TOTAL');
      AFDQ_Query.Sql.Add('  ,:DESCONTO');
      AFDQ_Query.Sql.Add('  ,:DESCONTO_MOTIVO');
      AFDQ_Query.Sql.Add('  ,:ACRESCIMO');
      AFDQ_Query.Sql.Add('  ,:ACRESCIMO_MOTIVO');
      AFDQ_Query.Sql.Add('  ,:TOTAL');
      AFDQ_Query.Sql.Add('  ,:DT_PAGO');
      AFDQ_Query.Sql.Add('  ,:VLR_PAGO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add(');');
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('DESCRICAO').AsString := FDESCRICAO;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := FID_PRESTADOR_SERVICO;
      AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      AFDQ_Query.ParamByName('ID_TABELA').AsInteger := FID_TABELA;
      AFDQ_Query.ParamByName('DATA').AsDateTime := FDATA;
      AFDQ_Query.ParamByName('HR_INICIO').AsDateTime := FHR_INICIO;
      AFDQ_Query.ParamByName('HR_FIM').AsDateTime := FHR_FIM;
      AFDQ_Query.ParamByName('HR_TOTAL').AsDateTime := FHR_TOTAL;
      AFDQ_Query.ParamByName('VLR_HORA').AsFloat := FVLR_HORA;
      AFDQ_Query.ParamByName('SUB_TOTAL').AsFloat := FSUB_TOTAL;
      AFDQ_Query.ParamByName('DESCONTO').AsFloat := FDESCONTO;
      AFDQ_Query.ParamByName('DESCONTO_MOTIVO').AsString := FDESCONTO_MOTIVO;
      AFDQ_Query.ParamByName('ACRESCIMO').AsFloat := FACRESCIMO;
      AFDQ_Query.ParamByName('ACRESCIMO_MOTIVO').AsString := FACRESCIMO_MOTIVO;
      AFDQ_Query.ParamByName('TOTAL').AsFloat := FTOTAL;
      AFDQ_Query.ParamByName('DT_PAGO').AsDateTime := FDT_PAGO;
      AFDQ_Query.ParamByName('VLR_PAGO').AsFloat := FVLR_PAGO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsDateTime := FHR_CADASTRO;
      AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TSERVICOS_PRESTADOS.Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE SERVICOS_PRESTADOS SET ');
      if FDESCRICAO <> '' then 
        AFDQ_Query.Sql.Add('  DESCRICAO = :DESCRICAO ');
      if FSTATUS > -1 then 
        AFDQ_Query.Sql.Add('  ,STATUS = :STATUS ');
      if FID_PRESTADOR_SERVICO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO ');
      if FID_CLIENTE > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_CLIENTE = :ID_CLIENTE ');
      if FID_TABELA > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_TABELA = :ID_TABELA ');
      if FDATA > 0 then 
        AFDQ_Query.Sql.Add('  ,DATA = :DATA ');
      if FHR_INICIO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_INICIO = :HR_INICIO ');
      if FHR_FIM > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_FIM = :HR_FIM ');
      if FHR_TOTAL > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_TOTAL = :HR_TOTAL ');
      if FVLR_HORA > -1 then 
        AFDQ_Query.Sql.Add('  ,VLR_HORA = :VLR_HORA ');
      if FSUB_TOTAL > -1 then 
        AFDQ_Query.Sql.Add('  ,SUB_TOTAL = :SUB_TOTAL ');
      if FDESCONTO > -1 then 
        AFDQ_Query.Sql.Add('  ,DESCONTO = :DESCONTO ');
      if FDESCONTO_MOTIVO <> '' then 
        AFDQ_Query.Sql.Add('  ,DESCONTO_MOTIVO = :DESCONTO_MOTIVO ');
      if FACRESCIMO > -1 then 
        AFDQ_Query.Sql.Add('  ,ACRESCIMO = :ACRESCIMO ');
      if FACRESCIMO_MOTIVO <> '' then 
        AFDQ_Query.Sql.Add('  ,ACRESCIMO_MOTIVO = :ACRESCIMO_MOTIVO ');
      if FTOTAL > -1 then 
        AFDQ_Query.Sql.Add('  ,TOTAL = :TOTAL ');
      if FDT_PAGO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_PAGO = :DT_PAGO ');
      if FVLR_PAGO > -1 then 
        AFDQ_Query.Sql.Add('  ,VLR_PAGO = :VLR_PAGO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FDESCRICAO <> '' then 
        AFDQ_Query.ParamByName('DESCRICAO').AsString := FDESCRICAO;
      if FSTATUS > -1 then 
        AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      if FID_PRESTADOR_SERVICO > -1 then 
        AFDQ_Query.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := FID_PRESTADOR_SERVICO;
      if FID_CLIENTE > -1 then 
        AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      if FID_TABELA > -1 then 
        AFDQ_Query.ParamByName('ID_TABELA').AsInteger := FID_TABELA;
      if FDATA > 0 then 
        AFDQ_Query.ParamByName('DATA').AsDateTime := FDATA;
      if FHR_INICIO > 0 then 
        AFDQ_Query.ParamByName('HR_INICIO').AsDateTime := FHR_INICIO;
      if FHR_FIM > 0 then 
        AFDQ_Query.ParamByName('HR_FIM').AsDateTime := FHR_FIM;
      if FHR_TOTAL > 0 then 
        AFDQ_Query.ParamByName('HR_TOTAL').AsDateTime := FHR_TOTAL;
      if FVLR_HORA > -1 then 
        AFDQ_Query.ParamByName('VLR_HORA').AsFloat := FVLR_HORA;
      if FSUB_TOTAL > -1 then 
        AFDQ_Query.ParamByName('SUB_TOTAL').AsFloat := FSUB_TOTAL;
      if FDESCONTO > -1 then 
        AFDQ_Query.ParamByName('DESCONTO').AsFloat := FDESCONTO;
      if FDESCONTO_MOTIVO <> '' then 
        AFDQ_Query.ParamByName('DESCONTO_MOTIVO').AsString := FDESCONTO_MOTIVO;
      if FACRESCIMO > -1 then 
        AFDQ_Query.ParamByName('ACRESCIMO').AsFloat := FACRESCIMO;
      if FACRESCIMO_MOTIVO <> '' then 
        AFDQ_Query.ParamByName('ACRESCIMO_MOTIVO').AsString := FACRESCIMO_MOTIVO;
      if FTOTAL > -1 then 
        AFDQ_Query.ParamByName('TOTAL').AsFloat := FTOTAL;
      if FDT_PAGO > 0 then 
        AFDQ_Query.ParamByName('DT_PAGO').AsDateTime := FDT_PAGO;
      if FVLR_PAGO > -1 then 
        AFDQ_Query.ParamByName('VLR_PAGO').AsFloat := FVLR_PAGO;
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('HR_CADASTRO').AsDateTime := FHR_CADASTRO;
      if FID_USUARIO > -1 then 
        AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TSERVICOS_PRESTADOS.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM SERVICOS_PRESTADOS '); 
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
 
procedure TSERVICOS_PRESTADOS.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetDESCRICAO( const Value:String);
begin 
  FDESCRICAO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetSTATUS( const Value:Integer);
begin 
  FSTATUS := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetID_PRESTADOR_SERVICO( const Value:Integer);
begin 
  FID_PRESTADOR_SERVICO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetID_CLIENTE( const Value:Integer);
begin 
  FID_CLIENTE := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetID_TABELA( const Value:Integer);
begin 
  FID_TABELA := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetDATA( const Value:TDate);
begin 
  FDATA := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetHR_INICIO( const Value:TTime);
begin 
  FHR_INICIO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetHR_FIM( const Value:TTime);
begin 
  FHR_FIM := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetHR_TOTAL( const Value:TTime);
begin 
  FHR_TOTAL := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetVLR_HORA( const Value:Double);
begin 
  FVLR_HORA := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetSUB_TOTAL( const Value:Double);
begin 
  FSUB_TOTAL := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetDESCONTO( const Value:Double);
begin 
  FDESCONTO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetDESCONTO_MOTIVO( const Value:String);
begin 
  FDESCONTO_MOTIVO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetACRESCIMO( const Value:Double);
begin 
  FACRESCIMO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetACRESCIMO_MOTIVO( const Value:String);
begin 
  FACRESCIMO_MOTIVO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetTOTAL( const Value:Double);
begin 
  FTOTAL := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetDT_PAGO( const Value:TDate);
begin 
  FDT_PAGO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetVLR_PAGO( const Value:Double);
begin 
  FVLR_PAGO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
procedure TSERVICOS_PRESTADOS.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
 
end. 
