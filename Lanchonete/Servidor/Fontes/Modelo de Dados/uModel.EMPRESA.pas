unit uModel.EMPRESA;
 
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
  TEMPRESA = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer;
    FPaginas :Integer;

    FID :Integer;
    FRAZAO_SOCIAL :String;
    FNOME_FANTASIA :String;
    FSTATUS :Integer;
    FTIPO_PESSOA :String;
    FDOCUMENTO :String;
    FINSCRICAO_ESTADUAL :String;
    FINSCRICAO_MUNICIPAL :String;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetRAZAO_SOCIAL( const Value:String);
    procedure SetNOME_FANTASIA( const Value:String);
    procedure SetSTATUS( const Value:Integer);
    procedure SetTIPO_PESSOA( const Value:String);
    procedure SetDOCUMENTO( const Value:String);
    procedure SetINSCRICAO_ESTADUAL( const Value:String);
    procedure SetINSCRICAO_MUNICIPAL( const Value:String);
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
    function Listar(
      const AFDQ_Query:TFDQuery;
      const AID:Integer = 0;
      const ANOME:String='';
      const ADOCUMENTO :String='';
      const APagina:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
 
    property ID:Integer read FID write SetID;
    property RAZAO_SOCIAL:String read FRAZAO_SOCIAL write SetRAZAO_SOCIAL;
    property NOME_FANTASIA:String read FNOME_FANTASIA write SetNOME_FANTASIA;
    property STATUS:Integer read FSTATUS write SetSTATUS;
    property TIPO_PESSOA:String read FTIPO_PESSOA write SetTIPO_PESSOA;
    property DOCUMENTO:String read FDOCUMENTO write SetDOCUMENTO;
    property INSCRICAO_ESTADUAL:String read FINSCRICAO_ESTADUAL write SetINSCRICAO_ESTADUAL;
    property INSCRICAO_MUNICIPAL:String read FINSCRICAO_MUNICIPAL write SetINSCRICAO_MUNICIPAL;
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
 
{ TEMPRESA }
 
constructor TEMPRESA.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end; 
 
destructor TEMPRESA.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TEMPRESA.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela EMPRESA... 
            if Indice_Existe(FConexao,AFDQuery,'EMPRESA_IDX1') then 
              Add('DROP INDEX EMPRESA_IDX1;'); 
            if Indice_Existe(FConexao,AFDQuery,'EMPRESA_IDX2') then 
              Add('DROP INDEX EMPRESA_IDX2;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'EMPRESA_BI') then 
              Add('DROP TRIGGER EMPRESA_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_EMPRESA_ID') then 
              Add('DROP GENERATOR GEN_EMPRESA_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'EMPRESA') then 
              Add('DROP TABLE EMPRESA;'); 
 
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
      lScript.Add('CREATE TABLE EMPRESA ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,RAZAO_SOCIAL VARCHAR(100) NOT NULL');
      lScript.Add('  ,NOME_FANTASIA VARCHAR(100)');
      lScript.Add('  ,STATUS INTEGER NOT NULL DEFAULT 0');
      lScript.Add('  ,TIPO_PESSOA VARCHAR(1) NOT NULL');
      lScript.Add('  ,DOCUMENTO VARCHAR(50)');
      lScript.Add('  ,INSCRICAO_ESTADUAL VARCHAR(50)');
      lScript.Add('  ,INSCRICAO_MUNICIPAL VARCHAR(50)');
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
          Add('ALTER TABLE EMPRESA ADD CONSTRAINT PK_EMPRESA PRIMARY KEY (ID);');
          Add('CREATE INDEX EMPRESA_IDX1 ON EMPRESA (RAZAO_SOCIAL);');
          Add('CREATE INDEX EMPRESA_IDX2 ON EMPRESA (DOCUMENTO);');
          Add('COMMENT ON COLUMN EMPRESA.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN EMPRESA.RAZAO_SOCIAL IS ''RAZ√ÉO SOCIAL'';');
          Add('COMMENT ON COLUMN EMPRESA.NOME_FANTASIA IS ''NOME FANTASIA'';');
          Add('COMMENT ON COLUMN EMPRESA.STATUS IS ''STATUS DO CADASTRO: 0-ATIVO, 1-INATIVO'';');
          Add('COMMENT ON COLUMN EMPRESA.TIPO_PESSOA IS ''TIPO DE PESSOA: F-F√çSICO, J-JUR√çDICO'';');
          Add('COMMENT ON COLUMN EMPRESA.DOCUMENTO IS ''DOCUMENTO: CNPJ/CPF'';');
          Add('COMMENT ON COLUMN EMPRESA.INSCRICAO_ESTADUAL IS ''INSCRI√á√ÉO ESTADUAL'';');
          Add('COMMENT ON COLUMN EMPRESA.INSCRICAO_MUNICIPAL IS ''INSCRICAO MUNICIPAL'';');
          Add('COMMENT ON COLUMN EMPRESA.ID_USUARIO IS ''CODIGO DO USU√ÅRIO'';');
          Add('COMMENT ON COLUMN EMPRESA.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN EMPRESA.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('CREATE SEQUENCE GEN_EMPRESA_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER EMPRESA_BI FOR EMPRESA '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_EMPRESA_ID,1);');
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
 
procedure TEMPRESA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TEMPRESA.Inicia_Propriedades; 
begin 
  ID := -1; 
  RAZAO_SOCIAL := '';
  NOME_FANTASIA := ''; 
  STATUS := -1; 
  TIPO_PESSOA := ''; 
  DOCUMENTO := ''; 
  INSCRICAO_ESTADUAL := ''; 
  INSCRICAO_MUNICIPAL := ''; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end;
 
function  TEMPRESA.Listar(
      const AFDQ_Query:TFDQuery;
      const AID:Integer = 0;
      const ANOME:String='';
      const ADOCUMENTO :String='';
      const APagina:Integer=0): TJSONArray;
begin 
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT E.* FROM EMPRESA E');
      AFDQ_Query.Sql.Add('WHERE 1=1 ');
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND E.ID = ' + AID.ToString);
      if Trim(ANOME) <> '' then
        AFDQ_Query.Sql.Add('  AND E.NOME LIKE ' + QuotedStr('%'+ANOME+'%'));
      if Trim(ADOCUMENTO) <> '' then
        AFDQ_Query.Sql.Add('  AND E.NOME = ' + QuotedStr(ADOCUMENTO));
      AFDQ_Query.Sql.Add('ORDER BY E.ID ');
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
        RAZAO_SOCIAL := AFDQ_Query.FieldByName('RAZAO_SOCIAL').AsString;
        NOME_FANTASIA := AFDQ_Query.FieldByName('NOME_FANTASIA').AsString;
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        TIPO_PESSOA := AFDQ_Query.FieldByName('TIPO_PESSOA').AsString;
        DOCUMENTO := AFDQ_Query.FieldByName('DOCUMENTO').AsString;
        INSCRICAO_ESTADUAL := AFDQ_Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
        INSCRICAO_MUNICIPAL := AFDQ_Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
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
 
procedure TEMPRESA.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FRAZAO_SOCIAL = '' then
        raise Exception.Create('RAZAO_SOCIAL: RAZ√ÉO SOCIAL n„o informado');
      if FSTATUS = -1 then 
        raise Exception.Create('STATUS: STATUS DO CADASTRO: 0-ATIVO, 1-INATIVO n„o informado'); 
      if FTIPO_PESSOA = '' then 
        raise Exception.Create('TIPO_PESSOA: TIPO DE PESSOA: F-F√çSICO, J-JUR√çDICO n„o informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USU√ÅRIO n„o informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO n„o informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO n„o informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO EMPRESA( ');
      AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  ,RAZAO_SOCIAL');
      AFDQ_Query.Sql.Add('  ,NOME_FANTASIA');
      AFDQ_Query.Sql.Add('  ,STATUS');
      AFDQ_Query.Sql.Add('  ,TIPO_PESSOA');
      AFDQ_Query.Sql.Add('  ,DOCUMENTO');
      AFDQ_Query.Sql.Add('  ,INSCRICAO_ESTADUAL');
      AFDQ_Query.Sql.Add('  ,INSCRICAO_MUNICIPAL');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  ,:RAZAO_SOCIAL');
      AFDQ_Query.Sql.Add('  ,:NOME_FANTASIA');
      AFDQ_Query.Sql.Add('  ,:STATUS');
      AFDQ_Query.Sql.Add('  ,:TIPO_PESSOA');
      AFDQ_Query.Sql.Add('  ,:DOCUMENTO');
      AFDQ_Query.Sql.Add('  ,:INSCRICAO_ESTADUAL');
      AFDQ_Query.Sql.Add('  ,:INSCRICAO_MUNICIPAL');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('RAZAO_SOCIAL').AsString := FRAZAO_SOCIAL;
      AFDQ_Query.ParamByName('NOME_FANTASIA').AsString := FNOME_FANTASIA;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('TIPO_PESSOA').AsString := FTIPO_PESSOA;
      AFDQ_Query.ParamByName('DOCUMENTO').AsString := FDOCUMENTO;
      AFDQ_Query.ParamByName('INSCRICAO_ESTADUAL').AsString := FINSCRICAO_ESTADUAL;
      AFDQ_Query.ParamByName('INSCRICAO_MUNICIPAL').AsString := FINSCRICAO_MUNICIPAL;
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
 
procedure TEMPRESA.Atualizar(const AFDQ_Query: TFDQuery; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
      AFDQ_Query.Sql.Add('UPDATE EMPRESA SET ');
      if FRAZAO_SOCIAL <> '' then
        AFDQ_Query.Sql.Add('  RAZAO_SOCIAL = :RAZAO_SOCIAL ');
      if FNOME_FANTASIA <> '' then 
        AFDQ_Query.Sql.Add('  ,NOME_FANTASIA = :NOME_FANTASIA ');
      if FSTATUS > -1 then 
        AFDQ_Query.Sql.Add('  ,STATUS = :STATUS ');
      if FTIPO_PESSOA <> '' then 
        AFDQ_Query.Sql.Add('  ,TIPO_PESSOA = :TIPO_PESSOA ');
      if FDOCUMENTO <> '' then 
        AFDQ_Query.Sql.Add('  ,DOCUMENTO = :DOCUMENTO ');
      if FINSCRICAO_ESTADUAL <> '' then 
        AFDQ_Query.Sql.Add('  ,INSCRICAO_ESTADUAL = :INSCRICAO_ESTADUAL ');
      if FINSCRICAO_MUNICIPAL <> '' then 
        AFDQ_Query.Sql.Add('  ,INSCRICAO_MUNICIPAL = :INSCRICAO_MUNICIPAL ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FRAZAO_SOCIAL <> '' then
        AFDQ_Query.ParamByName('RAZAO_SOCIAL').AsString := FRAZAO_SOCIAL;
      if FNOME_FANTASIA <> '' then 
        AFDQ_Query.ParamByName('NOME_FANTASIA').AsString := FNOME_FANTASIA;
      if FSTATUS > -1 then 
        AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      if FTIPO_PESSOA <> '' then 
        AFDQ_Query.ParamByName('TIPO_PESSOA').AsString := FTIPO_PESSOA;
      if FDOCUMENTO <> '' then 
        AFDQ_Query.ParamByName('DOCUMENTO').AsString := FDOCUMENTO;
      if FINSCRICAO_ESTADUAL <> '' then 
        AFDQ_Query.ParamByName('INSCRICAO_ESTADUAL').AsString := FINSCRICAO_ESTADUAL;
      if FINSCRICAO_MUNICIPAL <> '' then 
        AFDQ_Query.ParamByName('INSCRICAO_MUNICIPAL').AsString := FINSCRICAO_MUNICIPAL;
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
 
procedure TEMPRESA.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM EMPRESA '); 
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
 
procedure TEMPRESA.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TEMPRESA.SetRAZAO_SOCIAL( const Value:String);
begin 
  FRAZAO_SOCIAL := Value;
end;
 
procedure TEMPRESA.SetNOME_FANTASIA( const Value:String);
begin 
  FNOME_FANTASIA := Value; 
end;
 
procedure TEMPRESA.SetSTATUS( const Value:Integer);
begin 
  FSTATUS := Value; 
end;
 
procedure TEMPRESA.SetTIPO_PESSOA( const Value:String);
begin 
  FTIPO_PESSOA := Value; 
end;
 
procedure TEMPRESA.SetDOCUMENTO( const Value:String);
begin 
  FDOCUMENTO := Value; 
end;
 
procedure TEMPRESA.SetINSCRICAO_ESTADUAL( const Value:String);
begin 
  FINSCRICAO_ESTADUAL := Value; 
end;
 
procedure TEMPRESA.SetINSCRICAO_MUNICIPAL( const Value:String);
begin 
  FINSCRICAO_MUNICIPAL := Value; 
end;
 
procedure TEMPRESA.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TEMPRESA.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TEMPRESA.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
