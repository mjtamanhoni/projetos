unit uModel.CLIENTE;
 
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
  TCLIENTE = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer; 
    FPaginas :Integer; 
    
    FID :Integer;
    FNOME :String;
    FPESSOA :Integer;
    FDOCUMENTO :String;
    FINSC_EST :String;
    FCEP :String;
    FENDERECO :String;
    FCOMPLEMENTO :String;
    FNUMERO :String;
    FBAIRRO :String;
    FCIDADE :String;
    FUF :String;
    FTELEFONE :String;
    FCELULAR :String;
    FEMAIL :String;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetNOME( const Value:String);
    procedure SetPESSOA( const Value:Integer);
    procedure SetDOCUMENTO( const Value:String);
    procedure SetINSC_EST( const Value:String);
    procedure SetCEP( const Value:String);
    procedure SetENDERECO( const Value:String);
    procedure SetCOMPLEMENTO( const Value:String);
    procedure SetNUMERO( const Value:String);
    procedure SetBAIRRO( const Value:String);
    procedure SetCIDADE( const Value:String);
    procedure SetUF( const Value:String);
    procedure SetTELEFONE( const Value:String);
    procedure SetCELULAR( const Value:String);
    procedure SetEMAIL( const Value:String);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHR_CADASTRO( const Value:TTime);
 
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
    property NOME:String read FNOME write SetNOME;
    property PESSOA:Integer read FPESSOA write SetPESSOA;
    property DOCUMENTO:String read FDOCUMENTO write SetDOCUMENTO;
    property INSC_EST:String read FINSC_EST write SetINSC_EST;
    property CEP:String read FCEP write SetCEP;
    property ENDERECO:String read FENDERECO write SetENDERECO;
    property COMPLEMENTO:String read FCOMPLEMENTO write SetCOMPLEMENTO;
    property NUMERO:String read FNUMERO write SetNUMERO;
    property BAIRRO:String read FBAIRRO write SetBAIRRO;
    property CIDADE:String read FCIDADE write SetCIDADE;
    property UF:String read FUF write SetUF;
    property TELEFONE:String read FTELEFONE write SetTELEFONE;
    property CELULAR:String read FCELULAR write SetCELULAR;
    property EMAIL:String read FEMAIL write SetEMAIL;
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
 
{ TCLIENTE }
 
constructor TCLIENTE.Create(AConnexao: TFDConnection); 
begin 
  FPaginas := C_Paginas; 
  FConexao := AConnexao; 
end; 
 
destructor TCLIENTE.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TCLIENTE.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela CLIENTE... 
 
            if Trigger_Existe(FConexao,AFDQuery,'CLIENTE_BI') then 
              Add('DROP TRIGGER CLIENTE_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_CLIENTE_ID') then 
              Add('DROP GENERATOR GEN_CLIENTE_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'CLIENTE') then 
              Add('DROP TABLE CLIENTE;'); 
 
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
      lScript.Add('CREATE TABLE CLIENTE ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,NOME VARCHAR(100) NOT NULL');
      lScript.Add('  ,PESSOA INTEGER NOT NULL');
      lScript.Add('  ,DOCUMENTO VARCHAR(20)');
      lScript.Add('  ,INSC_EST VARCHAR(20)');
      lScript.Add('  ,CEP VARCHAR(10)');
      lScript.Add('  ,ENDERECO VARCHAR(255)');
      lScript.Add('  ,COMPLEMENTO VARCHAR(255)');
      lScript.Add('  ,NUMERO VARCHAR(10)');
      lScript.Add('  ,BAIRRO VARCHAR(100)');
      lScript.Add('  ,CIDADE VARCHAR(100)');
      lScript.Add('  ,UF VARCHAR(2)');
      lScript.Add('  ,TELEFONE VARCHAR(20)');
      lScript.Add('  ,CELULAR VARCHAR(20)');
      lScript.Add('  ,EMAIL VARCHAR(255)');
      lScript.Add('  ,DT_CADASTRO DATE DEFAULT CURRENT_DATE');
      lScript.Add('  ,HR_CADASTRO TIME DEFAULT CURRENT_TIME');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE PRIMARY KEY (ID);');
          Add('COMMENT ON COLUMN CLIENTE.ID IS ''ID'';');
          Add('COMMENT ON COLUMN CLIENTE.NOME IS ''NOME'';');
          Add('COMMENT ON COLUMN CLIENTE.PESSOA IS ''0-FISICA, 1-JURIDICA'';');
          Add('COMMENT ON COLUMN CLIENTE.DOCUMENTO IS ''CNPJ/CPF'';');
          Add('COMMENT ON COLUMN CLIENTE.INSC_EST IS ''INSCRICAO ESTADUAL'';');
          Add('COMMENT ON COLUMN CLIENTE.CEP IS ''CEP'';');
          Add('COMMENT ON COLUMN CLIENTE.ENDERECO IS ''ENDERECO'';');
          Add('COMMENT ON COLUMN CLIENTE.COMPLEMENTO IS ''COMPLEMENTO DO ENDERECO'';');
          Add('COMMENT ON COLUMN CLIENTE.NUMERO IS ''NUMERO DO ENDERECO'';');
          Add('COMMENT ON COLUMN CLIENTE.BAIRRO IS ''BAIRRO'';');
          Add('COMMENT ON COLUMN CLIENTE.CIDADE IS ''CIDADE'';');
          Add('COMMENT ON COLUMN CLIENTE.UF IS ''UNIDADE FEDERATIVA'';');
          Add('COMMENT ON COLUMN CLIENTE.TELEFONE IS ''TELEFONE'';');
          Add('COMMENT ON COLUMN CLIENTE.CELULAR IS ''CELULAR'';');
          Add('COMMENT ON COLUMN CLIENTE.EMAIL IS ''EMAIL'';');
          Add('');
          Add('');
          Add('CREATE SEQUENCE GEN_CLIENTE_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER CLIENTE_BI FOR CLIENTE '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_CLIENTE_ID,1);');
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
 
procedure TCLIENTE.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TCLIENTE.Inicia_Propriedades; 
begin 
  ID := -1; 
  NOME := ''; 
  PESSOA := -1; 
  STATUS := '';
  INSC_EST := '';
  CEP := '';
  ENDERECO := '';
  COMPLEMENTO := '';
  NUMERO := '';
  BAIRRO := '';
  CIDADE := '';
  UF := '';
  TELEFONE := '';
  CELULAR := '';
  EMAIL := '';
  DT_CADASTRO := Date;
  HR_CADASTRO := Time; 
end; 
 
function  TCLIENTE.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray;
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM CLIENTE') ;
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
        NOME := AFDQ_Query.FieldByName('NOME').AsString;
        PESSOA := AFDQ_Query.FieldByName('PESSOA').AsInteger;
        DOCUMENTO := AFDQ_Query.FieldByName('DOCUMENTO').AsString;
        INSC_EST := AFDQ_Query.FieldByName('INSC_EST').AsString;
        CEP := AFDQ_Query.FieldByName('CEP').AsString;
        ENDERECO := AFDQ_Query.FieldByName('ENDERECO').AsString;
        COMPLEMENTO := AFDQ_Query.FieldByName('COMPLEMENTO').AsString;
        NUMERO := AFDQ_Query.FieldByName('NUMERO').AsString;
        BAIRRO := AFDQ_Query.FieldByName('BAIRRO').AsString;
        CIDADE := AFDQ_Query.FieldByName('CIDADE').AsString;
        UF := AFDQ_Query.FieldByName('UF').AsString;
        TELEFONE := AFDQ_Query.FieldByName('TELEFONE').AsString;
        CELULAR := AFDQ_Query.FieldByName('CELULAR').AsString;
        EMAIL := AFDQ_Query.FieldByName('EMAIL').AsString;
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
 
procedure TCLIENTE.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FNOME = '' then 
        raise Exception.Create('NOME: NOME não informado'); 
      if FPESSOA = -1 then 
        raise Exception.Create('PESSOA: 0-FISICA, 1-JURIDICA não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO CLIENTE( ');
      //AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  NOME');
      AFDQ_Query.Sql.Add('  ,PESSOA');
      AFDQ_Query.Sql.Add('  ,DOCUMENTO');
      AFDQ_Query.Sql.Add('  ,INSC_EST');
      AFDQ_Query.Sql.Add('  ,CEP');
      AFDQ_Query.Sql.Add('  ,ENDERECO');
      AFDQ_Query.Sql.Add('  ,COMPLEMENTO');
      AFDQ_Query.Sql.Add('  ,NUMERO');
      AFDQ_Query.Sql.Add('  ,BAIRRO');
      AFDQ_Query.Sql.Add('  ,CIDADE');
      AFDQ_Query.Sql.Add('  ,UF');
      AFDQ_Query.Sql.Add('  ,TELEFONE');
      AFDQ_Query.Sql.Add('  ,CELULAR');
      AFDQ_Query.Sql.Add('  ,EMAIL');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      //AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  :NOME');
      AFDQ_Query.Sql.Add('  ,:PESSOA');
      AFDQ_Query.Sql.Add('  ,:DOCUMENTO');
      AFDQ_Query.Sql.Add('  ,:INSC_EST');
      AFDQ_Query.Sql.Add('  ,:CEP');
      AFDQ_Query.Sql.Add('  ,:ENDERECO');
      AFDQ_Query.Sql.Add('  ,:COMPLEMENTO');
      AFDQ_Query.Sql.Add('  ,:NUMERO');
      AFDQ_Query.Sql.Add('  ,:BAIRRO');
      AFDQ_Query.Sql.Add('  ,:CIDADE');
      AFDQ_Query.Sql.Add('  ,:UF');
      AFDQ_Query.Sql.Add('  ,:TELEFONE');
      AFDQ_Query.Sql.Add('  ,:CELULAR');
      AFDQ_Query.Sql.Add('  ,:EMAIL');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('PESSOA').AsInteger := FPESSOA;
      AFDQ_Query.ParamByName('DOCUMENTO').AsString := FDOCUMENTO;
      AFDQ_Query.ParamByName('INSC_EST').AsString := FINSC_EST;
      AFDQ_Query.ParamByName('CEP').AsString := FCEP;
      AFDQ_Query.ParamByName('ENDERECO').AsString := FENDERECO;
      AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      AFDQ_Query.ParamByName('CIDADE').AsString := FCIDADE;
      AFDQ_Query.ParamByName('UF').AsString := FUF;
      AFDQ_Query.ParamByName('TELEFONE').AsString := FTELEFONE;
      AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
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
 
procedure TCLIENTE.Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin
   try
     try
       AFDQ_Query.Connection := FConexao;
 
 
      AFDQ_Query.Sql.Add('UPDATE CLIENTE SET ');
      if FNOME <> '' then 
        AFDQ_Query.Sql.Add('  NOME = :NOME ');
      if FPESSOA > -1 then 
        AFDQ_Query.Sql.Add('  ,PESSOA = :PESSOA ');
      if FDOCUMENTO <> '' then 
        AFDQ_Query.Sql.Add('  ,DOCUMENTO = :DOCUMENTO ');
      if FINSC_EST <> '' then 
        AFDQ_Query.Sql.Add('  ,INSC_EST = :INSC_EST ');
      if FCEP <> '' then 
        AFDQ_Query.Sql.Add('  ,CEP = :CEP ');
      if FENDERECO <> '' then 
        AFDQ_Query.Sql.Add('  ,ENDERECO = :ENDERECO ');
      if FCOMPLEMENTO <> '' then 
        AFDQ_Query.Sql.Add('  ,COMPLEMENTO = :COMPLEMENTO ');
      if FNUMERO <> '' then 
        AFDQ_Query.Sql.Add('  ,NUMERO = :NUMERO ');
      if FBAIRRO <> '' then 
        AFDQ_Query.Sql.Add('  ,BAIRRO = :BAIRRO ');
      if FCIDADE <> '' then 
        AFDQ_Query.Sql.Add('  ,CIDADE = :CIDADE ');
      if FUF <> '' then 
        AFDQ_Query.Sql.Add('  ,UF = :UF ');
      if FTELEFONE <> '' then 
        AFDQ_Query.Sql.Add('  ,TELEFONE = :TELEFONE ');
      if FCELULAR <> '' then 
        AFDQ_Query.Sql.Add('  ,CELULAR = :CELULAR ');
      if FEMAIL <> '' then 
        AFDQ_Query.Sql.Add('  ,EMAIL = :EMAIL ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FNOME <> '' then 
        AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      if FPESSOA > -1 then 
        AFDQ_Query.ParamByName('PESSOA').AsInteger := FPESSOA;
      if FDOCUMENTO <> '' then 
        AFDQ_Query.ParamByName('DOCUMENTO').AsString := FDOCUMENTO;
      if FINSC_EST <> '' then 
        AFDQ_Query.ParamByName('INSC_EST').AsString := FINSC_EST;
      if FCEP <> '' then 
        AFDQ_Query.ParamByName('CEP').AsString := FCEP;
      if FENDERECO <> '' then 
        AFDQ_Query.ParamByName('ENDERECO').AsString := FENDERECO;
      if FCOMPLEMENTO <> '' then 
        AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      if FNUMERO <> '' then 
        AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      if FBAIRRO <> '' then 
        AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      if FCIDADE <> '' then 
        AFDQ_Query.ParamByName('CIDADE').AsString := FCIDADE;
      if FUF <> '' then 
        AFDQ_Query.ParamByName('UF').AsString := FUF;
      if FTELEFONE <> '' then 
        AFDQ_Query.ParamByName('TELEFONE').AsString := FTELEFONE;
      if FCELULAR <> '' then 
        AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      if FEMAIL <> '' then 
        AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
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
 
procedure TCLIENTE.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM CLIENTE '); 
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
 
procedure TCLIENTE.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TCLIENTE.SetNOME( const Value:String);
begin 
  FNOME := Value; 
end;
 
procedure TCLIENTE.SetPESSOA( const Value:Integer);
begin 
  FPESSOA := Value; 
end;
 
procedure TCLIENTE.SetDOCUMENTO( const Value:String);
begin 
  FDOCUMENTO := Value; 
end;
 
procedure TCLIENTE.SetINSC_EST( const Value:String);
begin 
  FINSC_EST := Value; 
end;
 
procedure TCLIENTE.SetCEP( const Value:String);
begin 
  FCEP := Value; 
end;
 
procedure TCLIENTE.SetENDERECO( const Value:String);
begin 
  FENDERECO := Value; 
end;
 
procedure TCLIENTE.SetCOMPLEMENTO( const Value:String);
begin 
  FCOMPLEMENTO := Value; 
end;
 
procedure TCLIENTE.SetNUMERO( const Value:String);
begin 
  FNUMERO := Value; 
end;
 
procedure TCLIENTE.SetBAIRRO( const Value:String);
begin 
  FBAIRRO := Value; 
end;
 
procedure TCLIENTE.SetCIDADE( const Value:String);
begin 
  FCIDADE := Value; 
end;
 
procedure TCLIENTE.SetUF( const Value:String);
begin 
  FUF := Value; 
end;
 
procedure TCLIENTE.SetTELEFONE( const Value:String);
begin 
  FTELEFONE := Value; 
end;
 
procedure TCLIENTE.SetCELULAR( const Value:String);
begin 
  FCELULAR := Value; 
end;
 
procedure TCLIENTE.SetEMAIL( const Value:String);
begin 
  FEMAIL := Value; 
end;
 
procedure TCLIENTE.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TCLIENTE.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
