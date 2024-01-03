unit uModel.EMPRESA_EMAIL;
 
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
  TEMPRESA_EMAIL = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer; 
    FPaginas :Integer; 
    
    FID_EMPRESA :Integer;
    FID :Integer;
    FRESPONSAVEL :String;
    FID_SETOR :Integer;
    FEMAIL :String;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHF_CADASTRO :TTime;
 
    procedure SetID_EMPRESA( const Value:Integer);
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
    function Listar(
      const AFDQ_Query:TFDQuery;
      const AID_EMPRESA:Integer = 0;
      const AID:Integer = 0;
      const AID_SETOR:Integer = 0;
      const ARESPONSAVEL:String = '';
      const AEMAIL:String = '';
      const APagina:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID_EMPRESA:Integer = 0; AID:Integer = 0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID_EMPRESA:Integer = 0; AID:Integer = 0);
 
    property ID_EMPRESA:Integer read FID_EMPRESA write SetID_EMPRESA;
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
 
{ TEMPRESA_EMAIL }
 
constructor TEMPRESA_EMAIL.Create(AConnexao: TFDConnection); 
begin 
  FPaginas := C_Paginas; 
  FConexao := AConnexao; 
end; 
 
destructor TEMPRESA_EMAIL.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TEMPRESA_EMAIL.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela EMPRESA_EMAIL... 
            if Indice_Existe(FConexao,AFDQuery,'FK_EMPRESA_EMAIL_1') then 
              Add('DROP INDEX FK_EMPRESA_EMAIL_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_EMPRESA_EMAIL_2') then 
              Add('DROP INDEX FK_EMPRESA_EMAIL_2;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'EMPRESA_EMAIL_BI') then 
              Add('DROP TRIGGER EMPRESA_EMAIL_BI;'); 
 
 
            if Tabela_Existe(FConexao,AFDQuery,'EMPRESA_EMAIL') then 
              Add('DROP TABLE EMPRESA_EMAIL;'); 
 
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
      lScript.Add('CREATE TABLE EMPRESA_EMAIL ( '); 
      lScript.Add('  ID_EMPRESA INTEGER NOT NULL');
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
          Add('ALTER TABLE EMPRESA_EMAIL ADD CONSTRAINT PK_EMPRESA_EMAIL PRIMARY KEY (ID_EMPRESA,ID);');
          Add('ALTER TABLE EMPRESA_EMAIL ADD CONSTRAINT FK_EMPRESA_EMAIL_1 FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESA(ID) ON DELETE CASCADE;');
          Add('ALTER TABLE EMPRESA_EMAIL ADD CONSTRAINT FK_EMPRESA_EMAIL_2 FOREIGN KEY (ID_SETOR) REFERENCES SETOR(ID) ;');
          Add('CREATE INDEX FK_EMPRESA_EMAIL_1 ON EMPRESA_EMAIL (ID_EMPRESA);');
          Add('CREATE INDEX FK_EMPRESA_EMAIL_2 ON EMPRESA_EMAIL (ID_SETOR);');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.ID_EMPRESA IS ''CODIGO DO EMPRESA'';');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.RESPONSAVEL IS ''NOME DO RESPONSAVEL PELO EMAIL'';');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.ID_SETOR IS ''CODIGO DO SETOR'';');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.EMAIL IS ''EMAIL'';');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.ID_USUARIO IS ''CODIGO DO USUARIO'';');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN EMPRESA_EMAIL.HF_CADASTRO IS ''HORA DO CADASTRO'';');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER EMPRESA_EMAIL_BI FOR EMPRESA_EMAIL '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM EMPRESA_EMAIL WHERE ID_EMPRESA = NEW.ID_EMPRESA INTO NEW.ID;');
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
 
procedure TEMPRESA_EMAIL.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TEMPRESA_EMAIL.Inicia_Propriedades; 
begin 
  ID_EMPRESA := -1; 
  ID := -1; 
  RESPONSAVEL := ''; 
  ID_SETOR := -1; 
  EMAIL := ''; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HF_CADASTRO := Time; 
end; 
 
function  TEMPRESA_EMAIL.Listar(
    const AFDQ_Query:TFDQuery;
    const AID_EMPRESA:Integer = 0;
    const AID:Integer = 0;
    const AID_SETOR:Integer = 0;
    const ARESPONSAVEL:String = '';
    const AEMAIL:String = '';
    const APagina:Integer=0): TJSONArray;
begin
  try 
    try 
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT EE.* ');
      AFDQ_Query.Sql.Add('  ,S.NOME AS SETOR ');
      AFDQ_Query.Sql.Add('FROM EMPRESA_EMAIL EE ');
      AFDQ_Query.Sql.Add('  JOIN SETOR S ON S.ID = EE.ID_SETOR ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID_EMPRESA > 0 then
        AFDQ_Query.Sql.Add('  AND EE.ID_EMPRESA = ' + AID_EMPRESA.ToString);
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND EE.ID = ' + AID.ToString);
      if AID_SETOR > 0 then
        AFDQ_Query.Sql.Add('  AND EE.ID_SETOR = ' + AID_SETOR.ToString);
      if ARESPONSAVEL <> '' then
        AFDQ_Query.Sql.Add('  AND EE.RESPONSAVEL = ' + QuotedStr(ARESPONSAVEL));
      if AEMAIL <> '' then
        AFDQ_Query.Sql.Add('  AND EE.EMAIL = ' + QuotedStr(AEMAIL));
      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  EE.ID_EMPRESA ');
      AFDQ_Query.Sql.Add('  ,EE.ID ');
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
        ID_EMPRESA := AFDQ_Query.FieldByName('ID_EMPRESA').AsInteger;
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
 
procedure TEMPRESA_EMAIL.Inserir(const AFDQ_Query: TFDQuery); 
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
      AFDQ_Query.Sql.Add('INSERT INTO EMPRESA_EMAIL( ');
      AFDQ_Query.Sql.Add('  ID_EMPRESA');
      AFDQ_Query.Sql.Add('  ,ID');
      AFDQ_Query.Sql.Add('  ,RESPONSAVEL');
      AFDQ_Query.Sql.Add('  ,ID_SETOR');
      AFDQ_Query.Sql.Add('  ,EMAIL');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HF_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_EMPRESA');
      AFDQ_Query.Sql.Add('  ,:ID');
      AFDQ_Query.Sql.Add('  ,:RESPONSAVEL');
      AFDQ_Query.Sql.Add('  ,:ID_SETOR');
      AFDQ_Query.Sql.Add('  ,:EMAIL');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HF_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_EMPRESA').AsInteger := FID_EMPRESA;
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
 
procedure TEMPRESA_EMAIL.Atualizar(const AFDQ_Query: TFDQuery; AID_EMPRESA:Integer = 0; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE EMPRESA_EMAIL SET ');
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
      AFDQ_Query.Sql.Add('  AND ID_EMPRESA = :ID_EMPRESA');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID_EMPRESA').AsInteger := FID_EMPRESA;
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
 
procedure TEMPRESA_EMAIL.Excluir(const AFDQ_Query:TFDQuery; AID_EMPRESA:Integer = 0; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM EMPRESA_EMAIL '); 
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL '); 
      AFDQ_Query.Sql.Add('  AND ID_EMPRESA = :ID_EMPRESA');
      AFDQ_Query.ParamByName('ID_EMPRESA').AsInteger := AID_EMPRESA;
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
 
procedure TEMPRESA_EMAIL.SetID_EMPRESA( const Value:Integer);
begin 
  FID_EMPRESA := Value; 
end;
 
procedure TEMPRESA_EMAIL.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TEMPRESA_EMAIL.SetRESPONSAVEL( const Value:String);
begin 
  FRESPONSAVEL := Value; 
end;
 
procedure TEMPRESA_EMAIL.SetID_SETOR( const Value:Integer);
begin 
  FID_SETOR := Value; 
end;
 
procedure TEMPRESA_EMAIL.SetEMAIL( const Value:String);
begin 
  FEMAIL := Value; 
end;
 
procedure TEMPRESA_EMAIL.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TEMPRESA_EMAIL.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TEMPRESA_EMAIL.SetHF_CADASTRO( const Value:TTime);
begin 
  FHF_CADASTRO := Value; 
end;
 
 
end. 
