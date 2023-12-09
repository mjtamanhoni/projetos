unit uModel.IMPRESSORAS; 
 
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
  TIMPRESSORAS = class 
  private 
    FConexao: TFDConnection; 
    
    FID :Integer;
    FNOME :String;
    FMODELO :String;
    FPORTA :String;
    FCOLUNAS :Integer;
    FESPACOS :Integer;
    FBUFFER :Integer;
    FLINHAS_PULAR :Integer;
    FCONTROLE_PORTA :Integer;
    FCORTAR_PAPEL :Integer;
    FTRADUZIR_TAGS :Integer;
    FIGNORAR_TAGS :Integer;
    FARQ_LOGO :String;
    FPAG_CODIGO :String;
    FCOD_BARRAS_LARGURA :Integer;
    FCOD_BARRAS_ALTURA :Integer;
    FCOD_BARRAS_EXIBE_NR :Integer;
    FQR_CODE_TIPO :Integer;
    FQR_CODE_LARGURA_MOD :Integer;
    FQR_CODE_ERROR_LEVEL :Integer;
    FGAVETA :Integer;
    FGAVETA_ON :Integer;
    FGAVETA_OFF :Integer;
    FGAVETA_INVERTIDO :Integer;
    FLOGOMARCA :String;
    FLOGOMARCA_TIPO :Integer;
    FLOGOMARCA_KC1 :Integer;
    FLOGOMARCA_KC2 :Integer;
    FLOGOMARCA_FATORX :Integer;
    FLOGOMARCA_FATORY :Integer;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetNOME( const Value:String);
    procedure SetMODELO( const Value:String);
    procedure SetPORTA( const Value:String);
    procedure SetCOLUNAS( const Value:Integer);
    procedure SetESPACOS( const Value:Integer);
    procedure SetBUFFER( const Value:Integer);
    procedure SetLINHAS_PULAR( const Value:Integer);
    procedure SetCONTROLE_PORTA( const Value:Integer);
    procedure SetCORTAR_PAPEL( const Value:Integer);
    procedure SetTRADUZIR_TAGS( const Value:Integer);
    procedure SetIGNORAR_TAGS( const Value:Integer);
    procedure SetARQ_LOGO( const Value:String);
    procedure SetPAG_CODIGO( const Value:String);
    procedure SetCOD_BARRAS_LARGURA( const Value:Integer);
    procedure SetCOD_BARRAS_ALTURA( const Value:Integer);
    procedure SetCOD_BARRAS_EXIBE_NR( const Value:Integer);
    procedure SetQR_CODE_TIPO( const Value:Integer);
    procedure SetQR_CODE_LARGURA_MOD( const Value:Integer);
    procedure SetQR_CODE_ERROR_LEVEL( const Value:Integer);
    procedure SetGAVETA( const Value:Integer);
    procedure SetGAVETA_ON( const Value:Integer);
    procedure SetGAVETA_OFF( const Value:Integer);
    procedure SetGAVETA_INVERTIDO( const Value:Integer);
    procedure SetLOGOMARCA( const Value:String);
    procedure SetLOGOMARCA_TIPO( const Value:Integer);
    procedure SetLOGOMARCA_KC1( const Value:Integer);
    procedure SetLOGOMARCA_KC2( const Value:Integer);
    procedure SetLOGOMARCA_FATORX( const Value:Integer);
    procedure SetLOGOMARCA_FATORY( const Value:Integer);
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
    property NOME:String read FNOME write SetNOME;
    property MODELO:String read FMODELO write SetMODELO;
    property PORTA:String read FPORTA write SetPORTA;
    property COLUNAS:Integer read FCOLUNAS write SetCOLUNAS;
    property ESPACOS:Integer read FESPACOS write SetESPACOS;
    property BUFFER:Integer read FBUFFER write SetBUFFER;
    property LINHAS_PULAR:Integer read FLINHAS_PULAR write SetLINHAS_PULAR;
    property CONTROLE_PORTA:Integer read FCONTROLE_PORTA write SetCONTROLE_PORTA;
    property CORTAR_PAPEL:Integer read FCORTAR_PAPEL write SetCORTAR_PAPEL;
    property TRADUZIR_TAGS:Integer read FTRADUZIR_TAGS write SetTRADUZIR_TAGS;
    property IGNORAR_TAGS:Integer read FIGNORAR_TAGS write SetIGNORAR_TAGS;
    property ARQ_LOGO:String read FARQ_LOGO write SetARQ_LOGO;
    property PAG_CODIGO:String read FPAG_CODIGO write SetPAG_CODIGO;
    property COD_BARRAS_LARGURA:Integer read FCOD_BARRAS_LARGURA write SetCOD_BARRAS_LARGURA;
    property COD_BARRAS_ALTURA:Integer read FCOD_BARRAS_ALTURA write SetCOD_BARRAS_ALTURA;
    property COD_BARRAS_EXIBE_NR:Integer read FCOD_BARRAS_EXIBE_NR write SetCOD_BARRAS_EXIBE_NR;
    property QR_CODE_TIPO:Integer read FQR_CODE_TIPO write SetQR_CODE_TIPO;
    property QR_CODE_LARGURA_MOD:Integer read FQR_CODE_LARGURA_MOD write SetQR_CODE_LARGURA_MOD;
    property QR_CODE_ERROR_LEVEL:Integer read FQR_CODE_ERROR_LEVEL write SetQR_CODE_ERROR_LEVEL;
    property GAVETA:Integer read FGAVETA write SetGAVETA;
    property GAVETA_ON:Integer read FGAVETA_ON write SetGAVETA_ON;
    property GAVETA_OFF:Integer read FGAVETA_OFF write SetGAVETA_OFF;
    property GAVETA_INVERTIDO:Integer read FGAVETA_INVERTIDO write SetGAVETA_INVERTIDO;
    property LOGOMARCA:String read FLOGOMARCA write SetLOGOMARCA;
    property LOGOMARCA_TIPO:Integer read FLOGOMARCA_TIPO write SetLOGOMARCA_TIPO;
    property LOGOMARCA_KC1:Integer read FLOGOMARCA_KC1 write SetLOGOMARCA_KC1;
    property LOGOMARCA_KC2:Integer read FLOGOMARCA_KC2 write SetLOGOMARCA_KC2;
    property LOGOMARCA_FATORX:Integer read FLOGOMARCA_FATORX write SetLOGOMARCA_FATORX;
    property LOGOMARCA_FATORY:Integer read FLOGOMARCA_FATORY write SetLOGOMARCA_FATORY;
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
 
{ TIMPRESSORAS }
 
constructor TIMPRESSORAS.Create(AConnexao: TFDConnection); 
begin 
  FConexao := AConnexao; 
end; 
 
destructor TIMPRESSORAS.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TIMPRESSORAS.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela IMPRESSORAS... 
 
            if Trigger_Existe(FConexao,AFDQuery,'IMPRESSORAS_BI') then 
              Add('DROP TRIGGER IMPRESSORAS_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_IMPRESSORAS_ID') then 
              Add('DROP GENERATOR GEN_IMPRESSORAS_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'IMPRESSORAS') then 
              Add('DROP TABLE IMPRESSORAS;'); 
 
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
      lScript.Add('CREATE TABLE IMPRESSORAS ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,NOME VARCHAR(255) NOT NULL');
      lScript.Add('  ,MODELO VARCHAR(100) NOT NULL');
      lScript.Add('  ,PORTA VARCHAR(255) NOT NULL');
      lScript.Add('  ,COLUNAS INTEGER NOT NULL DEFAULT 48');
      lScript.Add('  ,ESPACOS INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,BUFFER INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,LINHAS_PULAR INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,CONTROLE_PORTA INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,CORTAR_PAPEL INTEGER NOT NULL DEFAULT 1');
      lScript.Add('  ,TRADUZIR_TAGS INTEGER NOT NULL DEFAULT 1');
      lScript.Add('  ,IGNORAR_TAGS INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,ARQ_LOGO VARCHAR(255)');
      lScript.Add('  ,PAG_CODIGO VARCHAR(100)');
      lScript.Add('  ,COD_BARRAS_LARGURA INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,COD_BARRAS_ALTURA INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,COD_BARRAS_EXIBE_NR INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,QR_CODE_TIPO INTEGER NOT NULL DEFAULT 2');
      lScript.Add('  ,QR_CODE_LARGURA_MOD INTEGER NOT NULL DEFAULT 4');
      lScript.Add('  ,QR_CODE_ERROR_LEVEL INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,GAVETA INTEGER NOT NULL DEFAULT 1');
      lScript.Add('  ,GAVETA_ON INTEGER NOT NULL DEFAULT 50');
      lScript.Add('  ,GAVETA_OFF INTEGER NOT NULL DEFAULT 100');
      lScript.Add('  ,GAVETA_INVERTIDO INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,LOGOMARCA VARCHAR(255)');
      lScript.Add('  ,LOGOMARCA_TIPO INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,LOGOMARCA_KC1 INTEGER NOT NULL DEFAULT 32');
      lScript.Add('  ,LOGOMARCA_KC2 INTEGER NOT NULL DEFAULT 32');
      lScript.Add('  ,LOGOMARCA_FATORX INTEGER NOT NULL DEFAULT 1');
      lScript.Add('  ,LOGOMARCA_FATORY INTEGER NOT NULL DEFAULT 1');
      lScript.Add('  ,ID_USUARIO INTEGER NOT NULL');
      lScript.Add('  ,DT_CADASTRO DATE NOT NULL DEFAULT CURRENT_DATE');
      lScript.Add('  ,HR_CADASTRO TIME NOT NULL DEFAULT CURRENT_TIME');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e coment·rios... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE IMPRESSORAS ADD CONSTRAINT PK_IMPRESSORAS PRIMARY KEY (ID);');
          Add('COMMENT ON COLUMN IMPRESSORAS.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.NOME IS ''NOME DA IMPRESSORA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.MODELO IS ''MODELO DA IMPRESSORA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.PORTA IS ''PORTA DA IMPRESSORA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.COLUNAS IS ''QUANTIDADE DE COLUNAS DA IMPRESS√ÉO'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.ESPACOS IS ''QUANTIDADE DE ESPA√áOS'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.BUFFER IS ''BUFFER DE IMPESS√ÉO'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.LINHAS_PULAR IS ''QUANTIDADE DE LINHAS A PULAR'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.CONTROLE_PORTA IS ''CONTROLE DE PORTA: 0-N√ÉO, 1-SIM'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.CORTAR_PAPEL IS ''CORTAR PAPEL: 0-N√ÉO, 1-SIM'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.TRADUZIR_TAGS IS ''TRADUZIR AS TAGS: 0-N√ÉO, 1-SIM'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.IGNORAR_TAGS IS ''IGNORAR TAGS: 0-N√ÉO, 1-SIM'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.ARQ_LOGO IS ''ARQUIVO QUE VAI GUARDAR O LOG DAS IMPRESS√ïES'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.PAG_CODIGO IS ''PAGINA√á√ÉO DE C√ìDIGO'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.COD_BARRAS_LARGURA IS ''LARGURA DO C√ìDIGO DE BARRAS'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.COD_BARRAS_ALTURA IS ''ALTURA DO C√ìDIGO DE BARRAS'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.COD_BARRAS_EXIBE_NR IS ''EXIBE O N√öMERO DO C√ìDIGO DE BARRAS: 0-N√ÉO, 1-SIM'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.QR_CODE_TIPO IS ''TIPO DO QR-CODE'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.QR_CODE_LARGURA_MOD IS ''LARGURA DO MODELO DO QR-CODE'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.QR_CODE_ERROR_LEVEL IS ''ERROR LEVEL'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.GAVETA IS ''GAVETA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.GAVETA_ON IS ''GAVETA ON'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.GAVETA_OFF IS ''GAVETA OFF'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.GAVETA_INVERTIDO IS ''GAVETA INVERTIDO: 0-N√ÉO, 1-SIM'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.LOGOMARCA IS ''ARQUIVO DA LOGOMARCA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.LOGOMARCA_TIPO IS ''TIPO DA LOGOMARCA: 0-STREAM, 1-DE UM ARQUIVO'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.LOGOMARCA_KC1 IS ''TIPO KC1 LOGOMARCA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.LOGOMARCA_KC2 IS ''TIPO KC2 LOGOMARCA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.LOGOMARCA_FATORX IS ''TIPO FATORX LOGOMARCA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.LOGOMARCA_FATORY IS ''TIPO FATORY LOGOMARCA'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.ID_USUARIO IS ''CODIGO DO USU√ÅRIO'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN IMPRESSORAS.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('CREATE SEQUENCE GEN_IMPRESSORAS_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER IMPRESSORAS_BI FOR IMPRESSORAS '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_IMPRESSORAS_ID,1);');
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
 
procedure TIMPRESSORAS.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TIMPRESSORAS.Inicia_Propriedades; 
begin 
  ID := -1; 
  NOME := ''; 
  MODELO := ''; 
  PORTA := ''; 
  COLUNAS := -1; 
  ESPACOS := -1; 
  BUFFER := -1; 
  LINHAS_PULAR := -1; 
  CONTROLE_PORTA := -1; 
  CORTAR_PAPEL := -1; 
  TRADUZIR_TAGS := -1; 
  IGNORAR_TAGS := -1; 
  ARQ_LOGO := ''; 
  PAG_CODIGO := ''; 
  COD_BARRAS_LARGURA := -1; 
  COD_BARRAS_ALTURA := -1; 
  COD_BARRAS_EXIBE_NR := -1; 
  QR_CODE_TIPO := -1; 
  QR_CODE_LARGURA_MOD := -1; 
  QR_CODE_ERROR_LEVEL := -1; 
  GAVETA := -1; 
  GAVETA_ON := -1; 
  GAVETA_OFF := -1; 
  GAVETA_INVERTIDO := -1; 
  LOGOMARCA := ''; 
  LOGOMARCA_TIPO := -1; 
  LOGOMARCA_KC1 := -1; 
  LOGOMARCA_KC2 := -1; 
  LOGOMARCA_FATORX := -1; 
  LOGOMARCA_FATORY := -1; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end; 
 
function  TIMPRESSORAS.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM IMPRESSORAS;'); 
      AFDQ_Query.Active := True; 
      Result := AFDQ_Query.ToJSONArray; 
 
      if not AFDQ_Query.IsEmpty then 
      begin 
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        NOME := AFDQ_Query.FieldByName('NOME').AsString;
        MODELO := AFDQ_Query.FieldByName('MODELO').AsString;
        PORTA := AFDQ_Query.FieldByName('PORTA').AsString;
        COLUNAS := AFDQ_Query.FieldByName('COLUNAS').AsInteger;
        ESPACOS := AFDQ_Query.FieldByName('ESPACOS').AsInteger;
        BUFFER := AFDQ_Query.FieldByName('BUFFER').AsInteger;
        LINHAS_PULAR := AFDQ_Query.FieldByName('LINHAS_PULAR').AsInteger;
        CONTROLE_PORTA := AFDQ_Query.FieldByName('CONTROLE_PORTA').AsInteger;
        CORTAR_PAPEL := AFDQ_Query.FieldByName('CORTAR_PAPEL').AsInteger;
        TRADUZIR_TAGS := AFDQ_Query.FieldByName('TRADUZIR_TAGS').AsInteger;
        IGNORAR_TAGS := AFDQ_Query.FieldByName('IGNORAR_TAGS').AsInteger;
        ARQ_LOGO := AFDQ_Query.FieldByName('ARQ_LOGO').AsString;
        PAG_CODIGO := AFDQ_Query.FieldByName('PAG_CODIGO').AsString;
        COD_BARRAS_LARGURA := AFDQ_Query.FieldByName('COD_BARRAS_LARGURA').AsInteger;
        COD_BARRAS_ALTURA := AFDQ_Query.FieldByName('COD_BARRAS_ALTURA').AsInteger;
        COD_BARRAS_EXIBE_NR := AFDQ_Query.FieldByName('COD_BARRAS_EXIBE_NR').AsInteger;
        QR_CODE_TIPO := AFDQ_Query.FieldByName('QR_CODE_TIPO').AsInteger;
        QR_CODE_LARGURA_MOD := AFDQ_Query.FieldByName('QR_CODE_LARGURA_MOD').AsInteger;
        QR_CODE_ERROR_LEVEL := AFDQ_Query.FieldByName('QR_CODE_ERROR_LEVEL').AsInteger;
        GAVETA := AFDQ_Query.FieldByName('GAVETA').AsInteger;
        GAVETA_ON := AFDQ_Query.FieldByName('GAVETA_ON').AsInteger;
        GAVETA_OFF := AFDQ_Query.FieldByName('GAVETA_OFF').AsInteger;
        GAVETA_INVERTIDO := AFDQ_Query.FieldByName('GAVETA_INVERTIDO').AsInteger;
        LOGOMARCA := AFDQ_Query.FieldByName('LOGOMARCA').AsString;
        LOGOMARCA_TIPO := AFDQ_Query.FieldByName('LOGOMARCA_TIPO').AsInteger;
        LOGOMARCA_KC1 := AFDQ_Query.FieldByName('LOGOMARCA_KC1').AsInteger;
        LOGOMARCA_KC2 := AFDQ_Query.FieldByName('LOGOMARCA_KC2').AsInteger;
        LOGOMARCA_FATORX := AFDQ_Query.FieldByName('LOGOMARCA_FATORX').AsInteger;
        LOGOMARCA_FATORY := AFDQ_Query.FieldByName('LOGOMARCA_FATORY').AsInteger;
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
 
procedure TIMPRESSORAS.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FNOME = '' then 
        raise Exception.Create('NOME: NOME DA IMPRESSORA n„o informado'); 
      if FMODELO = '' then 
        raise Exception.Create('MODELO: MODELO DA IMPRESSORA n„o informado'); 
      if FPORTA = '' then 
        raise Exception.Create('PORTA: PORTA DA IMPRESSORA n„o informado'); 
      if FCOLUNAS = -1 then 
        raise Exception.Create('COLUNAS: QUANTIDADE DE COLUNAS DA IMPRESS√ÉO n„o informado'); 
      if FESPACOS = -1 then 
        raise Exception.Create('ESPACOS: QUANTIDADE DE ESPA√áOS n„o informado'); 
      if FBUFFER = -1 then 
        raise Exception.Create('BUFFER: BUFFER DE IMPESS√ÉO n„o informado'); 
      if FLINHAS_PULAR = -1 then 
        raise Exception.Create('LINHAS_PULAR: QUANTIDADE DE LINHAS A PULAR n„o informado'); 
      if FCONTROLE_PORTA = -1 then 
        raise Exception.Create('CONTROLE_PORTA: CONTROLE DE PORTA: 0-N√ÉO, 1-SIM n„o informado'); 
      if FCORTAR_PAPEL = -1 then 
        raise Exception.Create('CORTAR_PAPEL: CORTAR PAPEL: 0-N√ÉO, 1-SIM n„o informado'); 
      if FTRADUZIR_TAGS = -1 then 
        raise Exception.Create('TRADUZIR_TAGS: TRADUZIR AS TAGS: 0-N√ÉO, 1-SIM n„o informado'); 
      if FIGNORAR_TAGS = -1 then 
        raise Exception.Create('IGNORAR_TAGS: IGNORAR TAGS: 0-N√ÉO, 1-SIM n„o informado'); 
      if FCOD_BARRAS_LARGURA = -1 then 
        raise Exception.Create('COD_BARRAS_LARGURA: LARGURA DO C√ìDIGO DE BARRAS n„o informado'); 
      if FCOD_BARRAS_ALTURA = -1 then 
        raise Exception.Create('COD_BARRAS_ALTURA: ALTURA DO C√ìDIGO DE BARRAS n„o informado'); 
      if FCOD_BARRAS_EXIBE_NR = -1 then 
        raise Exception.Create('COD_BARRAS_EXIBE_NR: EXIBE O N√öMERO DO C√ìDIGO DE BARRAS: 0-N√ÉO, 1-SIM n„o informado'); 
      if FQR_CODE_TIPO = -1 then 
        raise Exception.Create('QR_CODE_TIPO: TIPO DO QR-CODE n„o informado'); 
      if FQR_CODE_LARGURA_MOD = -1 then 
        raise Exception.Create('QR_CODE_LARGURA_MOD: LARGURA DO MODELO DO QR-CODE n„o informado'); 
      if FQR_CODE_ERROR_LEVEL = -1 then 
        raise Exception.Create('QR_CODE_ERROR_LEVEL: ERROR LEVEL n„o informado'); 
      if FGAVETA = -1 then 
        raise Exception.Create('GAVETA: GAVETA n„o informado'); 
      if FGAVETA_ON = -1 then 
        raise Exception.Create('GAVETA_ON: GAVETA ON n„o informado'); 
      if FGAVETA_OFF = -1 then 
        raise Exception.Create('GAVETA_OFF: GAVETA OFF n„o informado'); 
      if FGAVETA_INVERTIDO = -1 then 
        raise Exception.Create('GAVETA_INVERTIDO: GAVETA INVERTIDO: 0-N√ÉO, 1-SIM n„o informado'); 
      if FLOGOMARCA_TIPO = -1 then 
        raise Exception.Create('LOGOMARCA_TIPO: TIPO DA LOGOMARCA: 0-STREAM, 1-DE UM ARQUIVO n„o informado'); 
      if FLOGOMARCA_KC1 = -1 then 
        raise Exception.Create('LOGOMARCA_KC1: TIPO KC1 LOGOMARCA n„o informado'); 
      if FLOGOMARCA_KC2 = -1 then 
        raise Exception.Create('LOGOMARCA_KC2: TIPO KC2 LOGOMARCA n„o informado'); 
      if FLOGOMARCA_FATORX = -1 then 
        raise Exception.Create('LOGOMARCA_FATORX: TIPO FATORX LOGOMARCA n„o informado'); 
      if FLOGOMARCA_FATORY = -1 then 
        raise Exception.Create('LOGOMARCA_FATORY: TIPO FATORY LOGOMARCA n„o informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USU√ÅRIO n„o informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO n„o informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO n„o informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO IMPRESSORAS( ');
      AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  ,NOME');
      AFDQ_Query.Sql.Add('  ,MODELO');
      AFDQ_Query.Sql.Add('  ,PORTA');
      AFDQ_Query.Sql.Add('  ,COLUNAS');
      AFDQ_Query.Sql.Add('  ,ESPACOS');
      AFDQ_Query.Sql.Add('  ,BUFFER');
      AFDQ_Query.Sql.Add('  ,LINHAS_PULAR');
      AFDQ_Query.Sql.Add('  ,CONTROLE_PORTA');
      AFDQ_Query.Sql.Add('  ,CORTAR_PAPEL');
      AFDQ_Query.Sql.Add('  ,TRADUZIR_TAGS');
      AFDQ_Query.Sql.Add('  ,IGNORAR_TAGS');
      AFDQ_Query.Sql.Add('  ,ARQ_LOGO');
      AFDQ_Query.Sql.Add('  ,PAG_CODIGO');
      AFDQ_Query.Sql.Add('  ,COD_BARRAS_LARGURA');
      AFDQ_Query.Sql.Add('  ,COD_BARRAS_ALTURA');
      AFDQ_Query.Sql.Add('  ,COD_BARRAS_EXIBE_NR');
      AFDQ_Query.Sql.Add('  ,QR_CODE_TIPO');
      AFDQ_Query.Sql.Add('  ,QR_CODE_LARGURA_MOD');
      AFDQ_Query.Sql.Add('  ,QR_CODE_ERROR_LEVEL');
      AFDQ_Query.Sql.Add('  ,GAVETA');
      AFDQ_Query.Sql.Add('  ,GAVETA_ON');
      AFDQ_Query.Sql.Add('  ,GAVETA_OFF');
      AFDQ_Query.Sql.Add('  ,GAVETA_INVERTIDO');
      AFDQ_Query.Sql.Add('  ,LOGOMARCA');
      AFDQ_Query.Sql.Add('  ,LOGOMARCA_TIPO');
      AFDQ_Query.Sql.Add('  ,LOGOMARCA_KC1');
      AFDQ_Query.Sql.Add('  ,LOGOMARCA_KC2');
      AFDQ_Query.Sql.Add('  ,LOGOMARCA_FATORX');
      AFDQ_Query.Sql.Add('  ,LOGOMARCA_FATORY');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  ,:NOME');
      AFDQ_Query.Sql.Add('  ,:MODELO');
      AFDQ_Query.Sql.Add('  ,:PORTA');
      AFDQ_Query.Sql.Add('  ,:COLUNAS');
      AFDQ_Query.Sql.Add('  ,:ESPACOS');
      AFDQ_Query.Sql.Add('  ,:BUFFER');
      AFDQ_Query.Sql.Add('  ,:LINHAS_PULAR');
      AFDQ_Query.Sql.Add('  ,:CONTROLE_PORTA');
      AFDQ_Query.Sql.Add('  ,:CORTAR_PAPEL');
      AFDQ_Query.Sql.Add('  ,:TRADUZIR_TAGS');
      AFDQ_Query.Sql.Add('  ,:IGNORAR_TAGS');
      AFDQ_Query.Sql.Add('  ,:ARQ_LOGO');
      AFDQ_Query.Sql.Add('  ,:PAG_CODIGO');
      AFDQ_Query.Sql.Add('  ,:COD_BARRAS_LARGURA');
      AFDQ_Query.Sql.Add('  ,:COD_BARRAS_ALTURA');
      AFDQ_Query.Sql.Add('  ,:COD_BARRAS_EXIBE_NR');
      AFDQ_Query.Sql.Add('  ,:QR_CODE_TIPO');
      AFDQ_Query.Sql.Add('  ,:QR_CODE_LARGURA_MOD');
      AFDQ_Query.Sql.Add('  ,:QR_CODE_ERROR_LEVEL');
      AFDQ_Query.Sql.Add('  ,:GAVETA');
      AFDQ_Query.Sql.Add('  ,:GAVETA_ON');
      AFDQ_Query.Sql.Add('  ,:GAVETA_OFF');
      AFDQ_Query.Sql.Add('  ,:GAVETA_INVERTIDO');
      AFDQ_Query.Sql.Add('  ,:LOGOMARCA');
      AFDQ_Query.Sql.Add('  ,:LOGOMARCA_TIPO');
      AFDQ_Query.Sql.Add('  ,:LOGOMARCA_KC1');
      AFDQ_Query.Sql.Add('  ,:LOGOMARCA_KC2');
      AFDQ_Query.Sql.Add('  ,:LOGOMARCA_FATORX');
      AFDQ_Query.Sql.Add('  ,:LOGOMARCA_FATORY');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('MODELO').AsString := FMODELO;
      AFDQ_Query.ParamByName('PORTA').AsString := FPORTA;
      AFDQ_Query.ParamByName('COLUNAS').AsInteger := FCOLUNAS;
      AFDQ_Query.ParamByName('ESPACOS').AsInteger := FESPACOS;
      AFDQ_Query.ParamByName('BUFFER').AsInteger := FBUFFER;
      AFDQ_Query.ParamByName('LINHAS_PULAR').AsInteger := FLINHAS_PULAR;
      AFDQ_Query.ParamByName('CONTROLE_PORTA').AsInteger := FCONTROLE_PORTA;
      AFDQ_Query.ParamByName('CORTAR_PAPEL').AsInteger := FCORTAR_PAPEL;
      AFDQ_Query.ParamByName('TRADUZIR_TAGS').AsInteger := FTRADUZIR_TAGS;
      AFDQ_Query.ParamByName('IGNORAR_TAGS').AsInteger := FIGNORAR_TAGS;
      AFDQ_Query.ParamByName('ARQ_LOGO').AsString := FARQ_LOGO;
      AFDQ_Query.ParamByName('PAG_CODIGO').AsString := FPAG_CODIGO;
      AFDQ_Query.ParamByName('COD_BARRAS_LARGURA').AsInteger := FCOD_BARRAS_LARGURA;
      AFDQ_Query.ParamByName('COD_BARRAS_ALTURA').AsInteger := FCOD_BARRAS_ALTURA;
      AFDQ_Query.ParamByName('COD_BARRAS_EXIBE_NR').AsInteger := FCOD_BARRAS_EXIBE_NR;
      AFDQ_Query.ParamByName('QR_CODE_TIPO').AsInteger := FQR_CODE_TIPO;
      AFDQ_Query.ParamByName('QR_CODE_LARGURA_MOD').AsInteger := FQR_CODE_LARGURA_MOD;
      AFDQ_Query.ParamByName('QR_CODE_ERROR_LEVEL').AsInteger := FQR_CODE_ERROR_LEVEL;
      AFDQ_Query.ParamByName('GAVETA').AsInteger := FGAVETA;
      AFDQ_Query.ParamByName('GAVETA_ON').AsInteger := FGAVETA_ON;
      AFDQ_Query.ParamByName('GAVETA_OFF').AsInteger := FGAVETA_OFF;
      AFDQ_Query.ParamByName('GAVETA_INVERTIDO').AsInteger := FGAVETA_INVERTIDO;
      AFDQ_Query.ParamByName('LOGOMARCA').AsString := FLOGOMARCA;
      AFDQ_Query.ParamByName('LOGOMARCA_TIPO').AsInteger := FLOGOMARCA_TIPO;
      AFDQ_Query.ParamByName('LOGOMARCA_KC1').AsInteger := FLOGOMARCA_KC1;
      AFDQ_Query.ParamByName('LOGOMARCA_KC2').AsInteger := FLOGOMARCA_KC2;
      AFDQ_Query.ParamByName('LOGOMARCA_FATORX').AsInteger := FLOGOMARCA_FATORX;
      AFDQ_Query.ParamByName('LOGOMARCA_FATORY').AsInteger := FLOGOMARCA_FATORY;
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
 
procedure TIMPRESSORAS.Atualizar(const AFDQ_Query: TFDQuery; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
      if FNOME = '' then 
        raise Exception.Create('NOME: NOME DA IMPRESSORA n„o informado'); 
      if FMODELO = '' then 
        raise Exception.Create('MODELO: MODELO DA IMPRESSORA n„o informado'); 
      if FPORTA = '' then 
        raise Exception.Create('PORTA: PORTA DA IMPRESSORA n„o informado'); 
      if FCOLUNAS = -1 then 
        raise Exception.Create('COLUNAS: QUANTIDADE DE COLUNAS DA IMPRESS√ÉO n„o informado'); 
      if FESPACOS = -1 then 
        raise Exception.Create('ESPACOS: QUANTIDADE DE ESPA√áOS n„o informado'); 
      if FBUFFER = -1 then 
        raise Exception.Create('BUFFER: BUFFER DE IMPESS√ÉO n„o informado'); 
      if FLINHAS_PULAR = -1 then 
        raise Exception.Create('LINHAS_PULAR: QUANTIDADE DE LINHAS A PULAR n„o informado'); 
      if FCONTROLE_PORTA = -1 then 
        raise Exception.Create('CONTROLE_PORTA: CONTROLE DE PORTA: 0-N√ÉO, 1-SIM n„o informado'); 
      if FCORTAR_PAPEL = -1 then 
        raise Exception.Create('CORTAR_PAPEL: CORTAR PAPEL: 0-N√ÉO, 1-SIM n„o informado'); 
      if FTRADUZIR_TAGS = -1 then 
        raise Exception.Create('TRADUZIR_TAGS: TRADUZIR AS TAGS: 0-N√ÉO, 1-SIM n„o informado'); 
      if FIGNORAR_TAGS = -1 then 
        raise Exception.Create('IGNORAR_TAGS: IGNORAR TAGS: 0-N√ÉO, 1-SIM n„o informado'); 
      if FARQ_LOGO = '' then 
        raise Exception.Create('ARQ_LOGO: ARQUIVO QUE VAI GUARDAR O LOG DAS IMPRESS√ïES n„o informado'); 
      if FPAG_CODIGO = '' then 
        raise Exception.Create('PAG_CODIGO: PAGINA√á√ÉO DE C√ìDIGO n„o informado'); 
      if FCOD_BARRAS_LARGURA = -1 then 
        raise Exception.Create('COD_BARRAS_LARGURA: LARGURA DO C√ìDIGO DE BARRAS n„o informado'); 
      if FCOD_BARRAS_ALTURA = -1 then 
        raise Exception.Create('COD_BARRAS_ALTURA: ALTURA DO C√ìDIGO DE BARRAS n„o informado'); 
      if FCOD_BARRAS_EXIBE_NR = -1 then 
        raise Exception.Create('COD_BARRAS_EXIBE_NR: EXIBE O N√öMERO DO C√ìDIGO DE BARRAS: 0-N√ÉO, 1-SIM n„o informado'); 
      if FQR_CODE_TIPO = -1 then 
        raise Exception.Create('QR_CODE_TIPO: TIPO DO QR-CODE n„o informado'); 
      if FQR_CODE_LARGURA_MOD = -1 then 
        raise Exception.Create('QR_CODE_LARGURA_MOD: LARGURA DO MODELO DO QR-CODE n„o informado'); 
      if FQR_CODE_ERROR_LEVEL = -1 then 
        raise Exception.Create('QR_CODE_ERROR_LEVEL: ERROR LEVEL n„o informado'); 
      if FGAVETA = -1 then 
        raise Exception.Create('GAVETA: GAVETA n„o informado'); 
      if FGAVETA_ON = -1 then 
        raise Exception.Create('GAVETA_ON: GAVETA ON n„o informado'); 
      if FGAVETA_OFF = -1 then 
        raise Exception.Create('GAVETA_OFF: GAVETA OFF n„o informado'); 
      if FGAVETA_INVERTIDO = -1 then 
        raise Exception.Create('GAVETA_INVERTIDO: GAVETA INVERTIDO: 0-N√ÉO, 1-SIM n„o informado'); 
      if FLOGOMARCA = '' then 
        raise Exception.Create('LOGOMARCA: ARQUIVO DA LOGOMARCA n„o informado'); 
      if FLOGOMARCA_TIPO = -1 then 
        raise Exception.Create('LOGOMARCA_TIPO: TIPO DA LOGOMARCA: 0-STREAM, 1-DE UM ARQUIVO n„o informado'); 
      if FLOGOMARCA_KC1 = -1 then 
        raise Exception.Create('LOGOMARCA_KC1: TIPO KC1 LOGOMARCA n„o informado'); 
      if FLOGOMARCA_KC2 = -1 then 
        raise Exception.Create('LOGOMARCA_KC2: TIPO KC2 LOGOMARCA n„o informado'); 
      if FLOGOMARCA_FATORX = -1 then 
        raise Exception.Create('LOGOMARCA_FATORX: TIPO FATORX LOGOMARCA n„o informado'); 
      if FLOGOMARCA_FATORY = -1 then 
        raise Exception.Create('LOGOMARCA_FATORY: TIPO FATORY LOGOMARCA n„o informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USU√ÅRIO n„o informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO n„o informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO n„o informado'); 
 
      AFDQ_Query.Sql.Add('UPDATE IMPRESSORAS SET ');
      if FNOME <> '' then 
        AFDQ_Query.Sql.Add('  NOME = :NOME ');
      if FMODELO <> '' then 
        AFDQ_Query.Sql.Add('  ,MODELO = :MODELO ');
      if FPORTA <> '' then 
        AFDQ_Query.Sql.Add('  ,PORTA = :PORTA ');
      if FCOLUNAS > -1 then 
        AFDQ_Query.Sql.Add('  ,COLUNAS = :COLUNAS ');
      if FESPACOS > -1 then 
        AFDQ_Query.Sql.Add('  ,ESPACOS = :ESPACOS ');
      if FBUFFER > -1 then 
        AFDQ_Query.Sql.Add('  ,BUFFER = :BUFFER ');
      if FLINHAS_PULAR > -1 then 
        AFDQ_Query.Sql.Add('  ,LINHAS_PULAR = :LINHAS_PULAR ');
      if FCONTROLE_PORTA > -1 then 
        AFDQ_Query.Sql.Add('  ,CONTROLE_PORTA = :CONTROLE_PORTA ');
      if FCORTAR_PAPEL > -1 then 
        AFDQ_Query.Sql.Add('  ,CORTAR_PAPEL = :CORTAR_PAPEL ');
      if FTRADUZIR_TAGS > -1 then 
        AFDQ_Query.Sql.Add('  ,TRADUZIR_TAGS = :TRADUZIR_TAGS ');
      if FIGNORAR_TAGS > -1 then 
        AFDQ_Query.Sql.Add('  ,IGNORAR_TAGS = :IGNORAR_TAGS ');
      if FARQ_LOGO <> '' then 
        AFDQ_Query.Sql.Add('  ,ARQ_LOGO = :ARQ_LOGO ');
      if FPAG_CODIGO <> '' then 
        AFDQ_Query.Sql.Add('  ,PAG_CODIGO = :PAG_CODIGO ');
      if FCOD_BARRAS_LARGURA > -1 then 
        AFDQ_Query.Sql.Add('  ,COD_BARRAS_LARGURA = :COD_BARRAS_LARGURA ');
      if FCOD_BARRAS_ALTURA > -1 then 
        AFDQ_Query.Sql.Add('  ,COD_BARRAS_ALTURA = :COD_BARRAS_ALTURA ');
      if FCOD_BARRAS_EXIBE_NR > -1 then 
        AFDQ_Query.Sql.Add('  ,COD_BARRAS_EXIBE_NR = :COD_BARRAS_EXIBE_NR ');
      if FQR_CODE_TIPO > -1 then 
        AFDQ_Query.Sql.Add('  ,QR_CODE_TIPO = :QR_CODE_TIPO ');
      if FQR_CODE_LARGURA_MOD > -1 then 
        AFDQ_Query.Sql.Add('  ,QR_CODE_LARGURA_MOD = :QR_CODE_LARGURA_MOD ');
      if FQR_CODE_ERROR_LEVEL > -1 then 
        AFDQ_Query.Sql.Add('  ,QR_CODE_ERROR_LEVEL = :QR_CODE_ERROR_LEVEL ');
      if FGAVETA > -1 then 
        AFDQ_Query.Sql.Add('  ,GAVETA = :GAVETA ');
      if FGAVETA_ON > -1 then 
        AFDQ_Query.Sql.Add('  ,GAVETA_ON = :GAVETA_ON ');
      if FGAVETA_OFF > -1 then 
        AFDQ_Query.Sql.Add('  ,GAVETA_OFF = :GAVETA_OFF ');
      if FGAVETA_INVERTIDO > -1 then 
        AFDQ_Query.Sql.Add('  ,GAVETA_INVERTIDO = :GAVETA_INVERTIDO ');
      if FLOGOMARCA <> '' then 
        AFDQ_Query.Sql.Add('  ,LOGOMARCA = :LOGOMARCA ');
      if FLOGOMARCA_TIPO > -1 then 
        AFDQ_Query.Sql.Add('  ,LOGOMARCA_TIPO = :LOGOMARCA_TIPO ');
      if FLOGOMARCA_KC1 > -1 then 
        AFDQ_Query.Sql.Add('  ,LOGOMARCA_KC1 = :LOGOMARCA_KC1 ');
      if FLOGOMARCA_KC2 > -1 then 
        AFDQ_Query.Sql.Add('  ,LOGOMARCA_KC2 = :LOGOMARCA_KC2 ');
      if FLOGOMARCA_FATORX > -1 then 
        AFDQ_Query.Sql.Add('  ,LOGOMARCA_FATORX = :LOGOMARCA_FATORX ');
      if FLOGOMARCA_FATORY > -1 then 
        AFDQ_Query.Sql.Add('  ,LOGOMARCA_FATORY = :LOGOMARCA_FATORY ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FNOME <> '' then 
        AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      if FMODELO <> '' then 
        AFDQ_Query.ParamByName('MODELO').AsString := FMODELO;
      if FPORTA <> '' then 
        AFDQ_Query.ParamByName('PORTA').AsString := FPORTA;
      if FCOLUNAS > -1 then 
        AFDQ_Query.ParamByName('COLUNAS').AsInteger := FCOLUNAS;
      if FESPACOS > -1 then 
        AFDQ_Query.ParamByName('ESPACOS').AsInteger := FESPACOS;
      if FBUFFER > -1 then 
        AFDQ_Query.ParamByName('BUFFER').AsInteger := FBUFFER;
      if FLINHAS_PULAR > -1 then 
        AFDQ_Query.ParamByName('LINHAS_PULAR').AsInteger := FLINHAS_PULAR;
      if FCONTROLE_PORTA > -1 then 
        AFDQ_Query.ParamByName('CONTROLE_PORTA').AsInteger := FCONTROLE_PORTA;
      if FCORTAR_PAPEL > -1 then 
        AFDQ_Query.ParamByName('CORTAR_PAPEL').AsInteger := FCORTAR_PAPEL;
      if FTRADUZIR_TAGS > -1 then 
        AFDQ_Query.ParamByName('TRADUZIR_TAGS').AsInteger := FTRADUZIR_TAGS;
      if FIGNORAR_TAGS > -1 then 
        AFDQ_Query.ParamByName('IGNORAR_TAGS').AsInteger := FIGNORAR_TAGS;
      if FARQ_LOGO <> '' then 
        AFDQ_Query.ParamByName('ARQ_LOGO').AsString := FARQ_LOGO;
      if FPAG_CODIGO <> '' then 
        AFDQ_Query.ParamByName('PAG_CODIGO').AsString := FPAG_CODIGO;
      if FCOD_BARRAS_LARGURA > -1 then 
        AFDQ_Query.ParamByName('COD_BARRAS_LARGURA').AsInteger := FCOD_BARRAS_LARGURA;
      if FCOD_BARRAS_ALTURA > -1 then 
        AFDQ_Query.ParamByName('COD_BARRAS_ALTURA').AsInteger := FCOD_BARRAS_ALTURA;
      if FCOD_BARRAS_EXIBE_NR > -1 then 
        AFDQ_Query.ParamByName('COD_BARRAS_EXIBE_NR').AsInteger := FCOD_BARRAS_EXIBE_NR;
      if FQR_CODE_TIPO > -1 then 
        AFDQ_Query.ParamByName('QR_CODE_TIPO').AsInteger := FQR_CODE_TIPO;
      if FQR_CODE_LARGURA_MOD > -1 then 
        AFDQ_Query.ParamByName('QR_CODE_LARGURA_MOD').AsInteger := FQR_CODE_LARGURA_MOD;
      if FQR_CODE_ERROR_LEVEL > -1 then 
        AFDQ_Query.ParamByName('QR_CODE_ERROR_LEVEL').AsInteger := FQR_CODE_ERROR_LEVEL;
      if FGAVETA > -1 then 
        AFDQ_Query.ParamByName('GAVETA').AsInteger := FGAVETA;
      if FGAVETA_ON > -1 then 
        AFDQ_Query.ParamByName('GAVETA_ON').AsInteger := FGAVETA_ON;
      if FGAVETA_OFF > -1 then 
        AFDQ_Query.ParamByName('GAVETA_OFF').AsInteger := FGAVETA_OFF;
      if FGAVETA_INVERTIDO > -1 then 
        AFDQ_Query.ParamByName('GAVETA_INVERTIDO').AsInteger := FGAVETA_INVERTIDO;
      if FLOGOMARCA <> '' then 
        AFDQ_Query.ParamByName('LOGOMARCA').AsString := FLOGOMARCA;
      if FLOGOMARCA_TIPO > -1 then 
        AFDQ_Query.ParamByName('LOGOMARCA_TIPO').AsInteger := FLOGOMARCA_TIPO;
      if FLOGOMARCA_KC1 > -1 then 
        AFDQ_Query.ParamByName('LOGOMARCA_KC1').AsInteger := FLOGOMARCA_KC1;
      if FLOGOMARCA_KC2 > -1 then 
        AFDQ_Query.ParamByName('LOGOMARCA_KC2').AsInteger := FLOGOMARCA_KC2;
      if FLOGOMARCA_FATORX > -1 then 
        AFDQ_Query.ParamByName('LOGOMARCA_FATORX').AsInteger := FLOGOMARCA_FATORX;
      if FLOGOMARCA_FATORY > -1 then 
        AFDQ_Query.ParamByName('LOGOMARCA_FATORY').AsInteger := FLOGOMARCA_FATORY;
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
 
procedure TIMPRESSORAS.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM IMPRESSORAS ');
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
 
procedure TIMPRESSORAS.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TIMPRESSORAS.SetNOME( const Value:String);
begin 
  FNOME := Value; 
end;
 
procedure TIMPRESSORAS.SetMODELO( const Value:String);
begin 
  FMODELO := Value; 
end;
 
procedure TIMPRESSORAS.SetPORTA( const Value:String);
begin 
  FPORTA := Value; 
end;
 
procedure TIMPRESSORAS.SetCOLUNAS( const Value:Integer);
begin 
  FCOLUNAS := Value; 
end;
 
procedure TIMPRESSORAS.SetESPACOS( const Value:Integer);
begin 
  FESPACOS := Value; 
end;
 
procedure TIMPRESSORAS.SetBUFFER( const Value:Integer);
begin 
  FBUFFER := Value; 
end;
 
procedure TIMPRESSORAS.SetLINHAS_PULAR( const Value:Integer);
begin 
  FLINHAS_PULAR := Value; 
end;
 
procedure TIMPRESSORAS.SetCONTROLE_PORTA( const Value:Integer);
begin 
  FCONTROLE_PORTA := Value; 
end;
 
procedure TIMPRESSORAS.SetCORTAR_PAPEL( const Value:Integer);
begin 
  FCORTAR_PAPEL := Value; 
end;
 
procedure TIMPRESSORAS.SetTRADUZIR_TAGS( const Value:Integer);
begin 
  FTRADUZIR_TAGS := Value; 
end;
 
procedure TIMPRESSORAS.SetIGNORAR_TAGS( const Value:Integer);
begin 
  FIGNORAR_TAGS := Value; 
end;
 
procedure TIMPRESSORAS.SetARQ_LOGO( const Value:String);
begin 
  FARQ_LOGO := Value; 
end;
 
procedure TIMPRESSORAS.SetPAG_CODIGO( const Value:String);
begin 
  FPAG_CODIGO := Value; 
end;
 
procedure TIMPRESSORAS.SetCOD_BARRAS_LARGURA( const Value:Integer);
begin 
  FCOD_BARRAS_LARGURA := Value; 
end;
 
procedure TIMPRESSORAS.SetCOD_BARRAS_ALTURA( const Value:Integer);
begin 
  FCOD_BARRAS_ALTURA := Value; 
end;
 
procedure TIMPRESSORAS.SetCOD_BARRAS_EXIBE_NR( const Value:Integer);
begin 
  FCOD_BARRAS_EXIBE_NR := Value; 
end;
 
procedure TIMPRESSORAS.SetQR_CODE_TIPO( const Value:Integer);
begin 
  FQR_CODE_TIPO := Value; 
end;
 
procedure TIMPRESSORAS.SetQR_CODE_LARGURA_MOD( const Value:Integer);
begin 
  FQR_CODE_LARGURA_MOD := Value; 
end;
 
procedure TIMPRESSORAS.SetQR_CODE_ERROR_LEVEL( const Value:Integer);
begin 
  FQR_CODE_ERROR_LEVEL := Value; 
end;
 
procedure TIMPRESSORAS.SetGAVETA( const Value:Integer);
begin 
  FGAVETA := Value; 
end;
 
procedure TIMPRESSORAS.SetGAVETA_ON( const Value:Integer);
begin 
  FGAVETA_ON := Value; 
end;
 
procedure TIMPRESSORAS.SetGAVETA_OFF( const Value:Integer);
begin 
  FGAVETA_OFF := Value; 
end;
 
procedure TIMPRESSORAS.SetGAVETA_INVERTIDO( const Value:Integer);
begin 
  FGAVETA_INVERTIDO := Value; 
end;
 
procedure TIMPRESSORAS.SetLOGOMARCA( const Value:String);
begin 
  FLOGOMARCA := Value; 
end;
 
procedure TIMPRESSORAS.SetLOGOMARCA_TIPO( const Value:Integer);
begin 
  FLOGOMARCA_TIPO := Value; 
end;
 
procedure TIMPRESSORAS.SetLOGOMARCA_KC1( const Value:Integer);
begin 
  FLOGOMARCA_KC1 := Value; 
end;
 
procedure TIMPRESSORAS.SetLOGOMARCA_KC2( const Value:Integer);
begin 
  FLOGOMARCA_KC2 := Value; 
end;
 
procedure TIMPRESSORAS.SetLOGOMARCA_FATORX( const Value:Integer);
begin 
  FLOGOMARCA_FATORX := Value; 
end;
 
procedure TIMPRESSORAS.SetLOGOMARCA_FATORY( const Value:Integer);
begin 
  FLOGOMARCA_FATORY := Value; 
end;
 
procedure TIMPRESSORAS.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TIMPRESSORAS.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TIMPRESSORAS.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
