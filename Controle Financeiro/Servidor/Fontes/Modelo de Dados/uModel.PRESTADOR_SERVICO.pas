unit uModel.PRESTADOR_SERVICO;
 
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
  TPRESTADOR_SERVICO = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer; 
    FPaginas :Integer; 
    
    FID :Integer;
    FNOME :String;
    FCELULAR :String;
    FEMAIL :String;
    FDT_CADASTRO :TDate;
    FHF_CADASTRO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetNOME( const Value:String);
    procedure SetCELULAR( const Value:String);
    procedure SetEMAIL( const Value:String);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHF_CADASTRO( const Value:TTime);
 
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
    property CELULAR:String read FCELULAR write SetCELULAR;
    property EMAIL:String read FEMAIL write SetEMAIL;
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
 
{ TPRESTADOR_SERVICO }
 
constructor TPRESTADOR_SERVICO.Create(AConnexao: TFDConnection); 
begin 
  FPaginas := C_Paginas; 
  FConexao := AConnexao; 
end; 
 
destructor TPRESTADOR_SERVICO.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TPRESTADOR_SERVICO.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela PRESTADOR_SERVICO... 
 
            if Trigger_Existe(FConexao,AFDQuery,'PRESTADOR_SERVICO_BI') then 
              Add('DROP TRIGGER PRESTADOR_SERVICO_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_PRESTADOR_SERVICO_ID') then 
              Add('DROP GENERATOR GEN_PRESTADOR_SERVICO_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'PRESTADOR_SERVICO') then 
              Add('DROP TABLE PRESTADOR_SERVICO;'); 
 
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
      lScript.Add('CREATE TABLE PRESTADOR_SERVICO ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,NOME VARCHAR(10) NOT NULL');
      lScript.Add('  ,CELULAR VARCHAR(20)');
      lScript.Add('  ,EMAIL VARCHAR(255)');
      lScript.Add('  ,DT_CADASTRO DATE DEFAULT CURRENT_DATE');
      lScript.Add('  ,HF_CADASTRO TIME DEFAULT CURRENT_TIME');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE PRESTADOR_SERVICO ADD CONSTRAINT PK_PRESTADOR_SERVICO PRIMARY KEY (ID);');
          Add('COMMENT ON COLUMN PRESTADOR_SERVICO.ID IS ''ID'';');
          Add('COMMENT ON COLUMN PRESTADOR_SERVICO.NOME IS ''NOME'';');
          Add('COMMENT ON COLUMN PRESTADOR_SERVICO.CELULAR IS ''CELULAR'';');
          Add('COMMENT ON COLUMN PRESTADOR_SERVICO.EMAIL IS ''EMAIL'';');
          Add('COMMENT ON COLUMN PRESTADOR_SERVICO.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN PRESTADOR_SERVICO.HF_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('CREATE SEQUENCE GEN_PRESTADOR_SERVICO_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER PRESTADOR_SERVICO_BI FOR PRESTADOR_SERVICO '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_PRESTADOR_SERVICO_ID,1);');
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
 
procedure TPRESTADOR_SERVICO.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TPRESTADOR_SERVICO.Inicia_Propriedades; 
begin 
  ID := -1; 
  NOME := ''; 
  CELULAR := ''; 
  EMAIL := ''; 
  DT_CADASTRO := Date; 
  HF_CADASTRO := Time; 
end; 
 
function  TPRESTADOR_SERVICO.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray;
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM PRESTADOR_SERVICO') ;
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
        CELULAR := AFDQ_Query.FieldByName('CELULAR').AsString;
        EMAIL := AFDQ_Query.FieldByName('EMAIL').AsString;
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
 
procedure TPRESTADOR_SERVICO.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FNOME = '' then 
        raise Exception.Create('NOME: NOME não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO PRESTADOR_SERVICO( ');
      //AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  NOME');
      AFDQ_Query.Sql.Add('  ,CELULAR');
      AFDQ_Query.Sql.Add('  ,EMAIL');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HF_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      //AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  :NOME');
      AFDQ_Query.Sql.Add('  ,:CELULAR');
      AFDQ_Query.Sql.Add('  ,:EMAIL');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HF_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
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
 
procedure TPRESTADOR_SERVICO.Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE PRESTADOR_SERVICO SET ');
      if FNOME <> '' then 
        AFDQ_Query.Sql.Add('  NOME = :NOME ');
      if FCELULAR <> '' then 
        AFDQ_Query.Sql.Add('  ,CELULAR = :CELULAR ');
      if FEMAIL <> '' then 
        AFDQ_Query.Sql.Add('  ,EMAIL = :EMAIL ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHF_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HF_CADASTRO = :HF_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FNOME <> '' then 
        AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      if FCELULAR <> '' then 
        AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      if FEMAIL <> '' then 
        AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
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
 
procedure TPRESTADOR_SERVICO.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM PRESTADOR_SERVICO '); 
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
 
procedure TPRESTADOR_SERVICO.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TPRESTADOR_SERVICO.SetNOME( const Value:String);
begin 
  FNOME := Value; 
end;
 
procedure TPRESTADOR_SERVICO.SetCELULAR( const Value:String);
begin 
  FCELULAR := Value; 
end;
 
procedure TPRESTADOR_SERVICO.SetEMAIL( const Value:String);
begin 
  FEMAIL := Value; 
end;
 
procedure TPRESTADOR_SERVICO.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TPRESTADOR_SERVICO.SetHF_CADASTRO( const Value:TTime);
begin 
  FHF_CADASTRO := Value; 
end;
 
 
end. 
