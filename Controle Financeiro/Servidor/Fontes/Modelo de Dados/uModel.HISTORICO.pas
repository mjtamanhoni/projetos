unit uModel.HISTORICO;
 
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
  THISTORICO = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer; 
    FPaginas :Integer; 
    
    FID :Integer;
    FDATA :TDate;
    FHORA :TTime;
    FFUNCAO :String;
    FDESCRICAO :String;
 
    procedure SetID( const Value:Integer);
    procedure SetDATA( const Value:TDate);
    procedure SetHORA( const Value:TTime);
    procedure SetFUNCAO( const Value:String);
    procedure SetDESCRICAO( const Value:String);
 
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
    property DATA:TDate read FDATA write SetDATA;
    property HORA:TTime read FHORA write SetHORA;
    property FUNCAO:String read FFUNCAO write SetFUNCAO;
    property DESCRICAO:String read FDESCRICAO write SetDESCRICAO;
 
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
 
{ THISTORICO }
 
constructor THISTORICO.Create(AConnexao: TFDConnection); 
begin 
  FPaginas := C_Paginas; 
  FConexao := AConnexao; 
end; 
 
destructor THISTORICO.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure THISTORICO.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela HISTORICO... 
 
            if Trigger_Existe(FConexao,AFDQuery,'HISTORICO_BI') then 
              Add('DROP TRIGGER HISTORICO_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_HISTORICO_ID') then 
              Add('DROP GENERATOR GEN_HISTORICO_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'HISTORICO') then 
              Add('DROP TABLE HISTORICO;'); 
 
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
      lScript.Add('CREATE TABLE HISTORICO ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,DATA DATE DEFAULT CURRENT_DATE');
      lScript.Add('  ,HORA TIME DEFAULT CURRENT_TIME');
      lScript.Add('  ,FUNCAO VARCHAR(255)');
      lScript.Add('  ,DESCRICAO BLOB SUB_TYPE 1 SEGMENT SIZE 4096');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE HISTORICO ADD CONSTRAINT PK_HISTORICO PRIMARY KEY (ID);');
          Add('COMMENT ON COLUMN HISTORICO.ID IS ''ID'';');
          Add('COMMENT ON COLUMN HISTORICO.DATA IS ''DATA'';');
          Add('COMMENT ON COLUMN HISTORICO.HORA IS ''HORA'';');
          Add('COMMENT ON COLUMN HISTORICO.FUNCAO IS ''FUNCAO DO HISTORICO'';');
          Add('COMMENT ON COLUMN HISTORICO.DESCRICAO IS ''MENSAGEM'';');
          Add('CREATE SEQUENCE GEN_HISTORICO_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER HISTORICO_BI FOR HISTORICO '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_HISTORICO_ID,1);');
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
 
procedure THISTORICO.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure THISTORICO.Inicia_Propriedades; 
begin 
  ID := -1; 
  DATA := Date; 
  HORA := Time; 
  FUNCAO := ''; 
  DESCRICAO := ''; 
end; 
 
function  THISTORICO.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray;
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM HISTORICO') ;
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
        DATA := AFDQ_Query.FieldByName('DATA').AsDateTime;
        HORA := AFDQ_Query.FieldByName('HORA').AsDateTime;
        FUNCAO := AFDQ_Query.FieldByName('FUNCAO').AsString;
        DESCRICAO := AFDQ_Query.FieldByName('DESCRICAO').AsString;
      end; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure THISTORICO.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO HISTORICO( ');
      //AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  DATA');
      AFDQ_Query.Sql.Add('  ,HORA');
      AFDQ_Query.Sql.Add('  ,FUNCAO');
      AFDQ_Query.Sql.Add('  ,DESCRICAO');
      AFDQ_Query.Sql.Add(') VALUES(');
      //AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  :DATA');
      AFDQ_Query.Sql.Add('  ,:HORA');
      AFDQ_Query.Sql.Add('  ,:FUNCAO');
      AFDQ_Query.Sql.Add('  ,:DESCRICAO');
      AFDQ_Query.Sql.Add(');');
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('DATA').AsDateTime := FDATA;
      AFDQ_Query.ParamByName('HORA').AsDateTime := FHORA;
      AFDQ_Query.ParamByName('FUNCAO').AsString := FFUNCAO;
      AFDQ_Query.ParamByName('DESCRICAO').AsString := FDESCRICAO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure THISTORICO.Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE HISTORICO SET ');
      if FDATA > 0 then 
        AFDQ_Query.Sql.Add('  DATA = :DATA ');
      if FHORA > 0 then 
        AFDQ_Query.Sql.Add('  ,HORA = :HORA ');
      if FFUNCAO <> '' then 
        AFDQ_Query.Sql.Add('  ,FUNCAO = :FUNCAO ');
      if FDESCRICAO <> '' then 
        AFDQ_Query.Sql.Add('  ,DESCRICAO = :DESCRICAO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FDATA > 0 then 
        AFDQ_Query.ParamByName('DATA').AsDateTime := FDATA;
      if FHORA > 0 then 
        AFDQ_Query.ParamByName('HORA').AsDateTime := FHORA;
      if FFUNCAO <> '' then 
        AFDQ_Query.ParamByName('FUNCAO').AsString := FFUNCAO;
      if FDESCRICAO <> '' then 
        AFDQ_Query.ParamByName('DESCRICAO').AsString := FDESCRICAO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure THISTORICO.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM HISTORICO '); 
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
 
procedure THISTORICO.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure THISTORICO.SetDATA( const Value:TDate);
begin 
  FDATA := Value; 
end;
 
procedure THISTORICO.SetHORA( const Value:TTime);
begin 
  FHORA := Value; 
end;
 
procedure THISTORICO.SetFUNCAO( const Value:String);
begin 
  FFUNCAO := Value; 
end;
 
procedure THISTORICO.SetDESCRICAO( const Value:String);
begin 
  FDESCRICAO := Value; 
end;
 
 
end. 
