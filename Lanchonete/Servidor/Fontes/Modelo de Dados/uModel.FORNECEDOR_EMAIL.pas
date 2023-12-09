unit uModel.FORNECEDOR_EMAIL; 
 
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
  TFORNECEDOR_EMAIL = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer; 
    FPaginas :Integer; 
    
    FID_FORNECEDOR :Integer;
    FID :Integer;
    FRESPONSAVEL :String;
    FID_SETOR :Integer;
    FEMAIL :String;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHF_CADASTRO :TTime;
 
    procedure SetID_FORNECEDOR( const Value:Integer);
    procedure SetID( const Value:Integer);
    procedure SetRESPONSAVEL( const Value:String);
    procedure SetID_SETOR( const Value:Integer);
    procedure SetEMAIL( const Value:String);
    procedure SetID_USUARIO( const Value:Integer);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHF_CADASTRO( const Value:TTime);
 
  public 
    constructor Create(AConnexao: TFDConnection); 
    destructor Destroy; override; 
 
    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery); 
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery); 
    procedure Inicia_Propriedades; 
    procedure Inserir(const AFDQ_Query:TFDQuery); 
    function Listar(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0; APagina:Integer=0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0);
 
    property ID_FORNECEDOR:Integer read FID_FORNECEDOR write SetID_FORNECEDOR;
    property ID:Integer read FID write SetID;
    property RESPONSAVEL:String read FRESPONSAVEL write SetRESPONSAVEL;
    property ID_SETOR:Integer read FID_SETOR write SetID_SETOR;
    property EMAIL:String read FEMAIL write SetEMAIL;
    property ID_USUARIO:Integer read FID_USUARIO write SetID_USUARIO;
    property DT_CADASTRO:TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HF_CADASTRO:TTime read FHF_CADASTRO write SetHF_CADASTRO;
 
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
 
{ TFORNECEDOR_EMAIL }
 
constructor TFORNECEDOR_EMAIL.Create(AConnexao: TFDConnection); 
begin 
  FPaginas := C_Paginas; 
  FConexao := AConnexao; 
end; 
 
destructor TFORNECEDOR_EMAIL.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TFORNECEDOR_EMAIL.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela FORNECEDOR_EMAIL... 
            if Indice_Existe(FConexao,AFDQuery,'FK_FORNECEDOR_EMAIL_1') then 
              Add('DROP INDEX FK_FORNECEDOR_EMAIL_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_FORNECEDOR_EMAIL_2') then 
              Add('DROP INDEX FK_FORNECEDOR_EMAIL_2;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'FORNECEDOR_EMAIL_BI') then 
              Add('DROP TRIGGER FORNECEDOR_EMAIL_BI;'); 
 
 
            if Tabela_Existe(FConexao,AFDQuery,'FORNECEDOR_EMAIL') then 
              Add('DROP TABLE FORNECEDOR_EMAIL;'); 
 
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
      lScript.Add('CREATE TABLE FORNECEDOR_EMAIL ( '); 
      lScript.Add('  ID_FORNECEDOR INTEGER NOT NULL');
      lScript.Add('  ,ID INTEGER NOT NULL');
      lScript.Add('  ,RESPONSAVEL VARCHAR(100)');
      lScript.Add('  ,ID_SETOR INTEGER');
      lScript.Add('  ,EMAIL VARCHAR(255) NOT NULL');
      lScript.Add('  ,ID_USUARIO INTEGER NOT NULL');
      lScript.Add('  ,DT_CADASTRO DATE NOT NULL DEFAULT CURRENT_DATE');
      lScript.Add('  ,HF_CADASTRO TIME NOT NULL DEFAULT CURRENT_TIME');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE FORNECEDOR_EMAIL ADD CONSTRAINT PK_FORNECEDOR_EMAIL PRIMARY KEY (ID_FORNECEDOR,ID);');
          Add('ALTER TABLE FORNECEDOR_EMAIL ADD CONSTRAINT FK_FORNECEDOR_EMAIL_1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID) ON DELETE CASCADE;');
          Add('ALTER TABLE FORNECEDOR_EMAIL ADD CONSTRAINT FK_FORNECEDOR_EMAIL_2 FOREIGN KEY (ID_SETOR) REFERENCES SETOR(ID) ;');
          Add('CREATE INDEX FK_FORNECEDOR_EMAIL_1 ON FORNECEDOR_EMAIL (ID_FORNECEDOR);');
          Add('CREATE INDEX FK_FORNECEDOR_EMAIL_2 ON FORNECEDOR_EMAIL (ID_SETOR);');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.ID_FORNECEDOR IS ''CODIGO DO FORNECEDOR'';');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.RESPONSAVEL IS ''NOME DO RESPONSAVEL PELO EMAIL'';');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.ID_SETOR IS ''CODIGO DO SETOR'';');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.EMAIL IS ''EMAIL'';');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.ID_USUARIO IS ''CODIGO DO USUARIO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_EMAIL.HF_CADASTRO IS ''HORA DO CADASTRO'';');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER FORNECEDOR_EMAIL_BI FOR FORNECEDOR_EMAIL '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM FORNECEDOR_EMAIL WHERE ID_FORNECEDOR = NEW.ID_FORNECEDOR INTO NEW.ID;');
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
 
procedure TFORNECEDOR_EMAIL.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TFORNECEDOR_EMAIL.Inicia_Propriedades; 
begin 
  ID_FORNECEDOR := -1; 
  ID := -1; 
  RESPONSAVEL := ''; 
  ID_SETOR := -1; 
  EMAIL := ''; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HF_CADASTRO := Time; 
end; 
 
function  TFORNECEDOR_EMAIL.Listar(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0; APagina:Integer=0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM FORNECEDOR_EMAIL') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = :ID_FORNECEDOR');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := AID_FORNECEDOR;
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := AID;
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
        ID_FORNECEDOR := AFDQ_Query.FieldByName('ID_FORNECEDOR').AsInteger;
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        RESPONSAVEL := AFDQ_Query.FieldByName('RESPONSAVEL').AsString;
        ID_SETOR := AFDQ_Query.FieldByName('ID_SETOR').AsInteger;
        EMAIL := AFDQ_Query.FieldByName('EMAIL').AsString;
        ID_USUARIO := AFDQ_Query.FieldByName('ID_USUARIO').AsInteger;
        DT_CADASTRO := AFDQ_Query.FieldByName('DT_CADASTRO').AsDateTime;
        HF_CADASTRO := AFDQ_Query.FieldByName('HF_CADASTRO').AsDateTime;
      end; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TFORNECEDOR_EMAIL.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FEMAIL = '' then 
        raise Exception.Create('EMAIL: EMAIL não informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USUARIO não informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado'); 
      if FHF_CADASTRO = 0 then 
        raise Exception.Create('HF_CADASTRO: HORA DO CADASTRO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO FORNECEDOR_EMAIL( ');
      AFDQ_Query.Sql.Add('  ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,ID');
      AFDQ_Query.Sql.Add('  ,RESPONSAVEL');
      AFDQ_Query.Sql.Add('  ,ID_SETOR');
      AFDQ_Query.Sql.Add('  ,EMAIL');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HF_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,:ID');
      AFDQ_Query.Sql.Add('  ,:RESPONSAVEL');
      AFDQ_Query.Sql.Add('  ,:ID_SETOR');
      AFDQ_Query.Sql.Add('  ,:EMAIL');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HF_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('RESPONSAVEL').AsString := FRESPONSAVEL;
      AFDQ_Query.ParamByName('ID_SETOR').AsInteger := FID_SETOR;
      AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
      AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HF_CADASTRO').AsDateTime := FHF_CADASTRO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TFORNECEDOR_EMAIL.Atualizar(const AFDQ_Query: TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE FORNECEDOR_EMAIL SET ');
      if FRESPONSAVEL <> '' then 
        AFDQ_Query.Sql.Add('  RESPONSAVEL = :RESPONSAVEL ');
      if FID_SETOR > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_SETOR = :ID_SETOR ');
      if FEMAIL <> '' then 
        AFDQ_Query.Sql.Add('  ,EMAIL = :EMAIL ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHF_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HF_CADASTRO = :HF_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = :ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FRESPONSAVEL <> '' then 
        AFDQ_Query.ParamByName('RESPONSAVEL').AsString := FRESPONSAVEL;
      if FID_SETOR > -1 then 
        AFDQ_Query.ParamByName('ID_SETOR').AsInteger := FID_SETOR;
      if FEMAIL <> '' then 
        AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
      if FID_USUARIO > -1 then 
        AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('DT_CADASTRO').AsDateTime := FDT_CADASTRO;
      if FHF_CADASTRO > 0 then 
        AFDQ_Query.ParamByName('HF_CADASTRO').AsDateTime := FHF_CADASTRO;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TFORNECEDOR_EMAIL.Excluir(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM FORNECEDOR_EMAIL '); 
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL '); 
      AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = :ID_FORNECEDOR');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := AID_FORNECEDOR;
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
 
procedure TFORNECEDOR_EMAIL.SetID_FORNECEDOR( const Value:Integer);
begin 
  FID_FORNECEDOR := Value; 
end;
 
procedure TFORNECEDOR_EMAIL.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TFORNECEDOR_EMAIL.SetRESPONSAVEL( const Value:String);
begin 
  FRESPONSAVEL := Value; 
end;
 
procedure TFORNECEDOR_EMAIL.SetID_SETOR( const Value:Integer);
begin 
  FID_SETOR := Value; 
end;
 
procedure TFORNECEDOR_EMAIL.SetEMAIL( const Value:String);
begin 
  FEMAIL := Value; 
end;
 
procedure TFORNECEDOR_EMAIL.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TFORNECEDOR_EMAIL.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TFORNECEDOR_EMAIL.SetHF_CADASTRO( const Value:TTime);
begin 
  FHF_CADASTRO := Value; 
end;
 
 
end. 
