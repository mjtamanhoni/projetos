unit uModel.UNIDADE_FEDERATIVA;
 
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
  TUNIDADE_FEDERATIVA = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer;
    FPaginas :Integer;

    FID :Integer;
    FIBGE :Integer;
    FNOME :String;
    FSIGLA :String;
    FID_REGIAO :Integer;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID( const Value:Integer);
    procedure SetIBGE( const Value:Integer);
    procedure SetNOME( const Value:String);
    procedure SetSIGLA( const Value:String);
    procedure SetID_REGIAO( const Value:Integer);
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
    function Listar(const AFDQ_Query:TFDQuery;
      AID:Integer = 0;
      ASIGLA:String='';
      AID_REGIAO:Integer=0;
      APagina:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
 
    property ID:Integer read FID write SetID;
    property IBGE:Integer read FIBGE write SetIBGE;
    property NOME:String read FNOME write SetNOME;
    property SIGLA:String read FSIGLA write SetSIGLA;
    property ID_REGIAO:Integer read FID_REGIAO write SetID_REGIAO;
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
 
{ TUNIDADE_FEDERATIVA }
 
constructor TUNIDADE_FEDERATIVA.Create(AConnexao: TFDConnection);
begin 
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end; 
 
destructor TUNIDADE_FEDERATIVA.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TUNIDADE_FEDERATIVA.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela UNIDADE_FEDERATIVA... 
 
            if Trigger_Existe(FConexao,AFDQuery,'UNIDADE_FEDERATIVA_BI') then 
              Add('DROP TRIGGER UNIDADE_FEDERATIVA_BI;'); 
 
            if Generator_Existe(FConexao,AFDQuery,'GEN_UNIDADE_FEDERATIVA_ID') then 
              Add('DROP GENERATOR GEN_UNIDADE_FEDERATIVA_ID;'); 
 
            if Tabela_Existe(FConexao,AFDQuery,'UNIDADE_FEDERATIVA') then 
              Add('DROP TABLE UNIDADE_FEDERATIVA;'); 
 
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
      lScript.Add('CREATE TABLE UNIDADE_FEDERATIVA ( '); 
      lScript.Add('  ID INTEGER NOT NULL');
      lScript.Add('  ,IBGE INTEGER NOT NULL');
      lScript.Add('  ,NOME VARCHAR(100) NOT NULL');
      lScript.Add('  ,SIGLA VARCHAR(2) NOT NULL');
      lScript.Add('  ,ID_REGIAO INTEGER NOT NULL');
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
          Add('ALTER TABLE UNIDADE_FEDERATIVA ADD CONSTRAINT PK_UNIDADE_FEDERATIVA PRIMARY KEY (ID);');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.IBGE IS ''CODIGO IBGE'';');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.NOME IS ''NOME'';');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.SIGLA IS ''SIGLA'';');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.ID_REGIAO IS ''CODIGO DA REGIAO'';');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.ID_USUARIO IS ''CODIGO DO USUARIO'';');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN UNIDADE_FEDERATIVA.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('CREATE SEQUENCE GEN_UNIDADE_FEDERATIVA_ID');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER UNIDADE_FEDERATIVA_BI FOR UNIDADE_FEDERATIVA '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('as');
      lScript.Add('begin');
      lScript.Add('  if (new.id is null) then');
      lScript.Add('    new.id = gen_id(gen_unidade_federativa_id,1);');
      lScript.Add('end ^');
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
 
procedure TUNIDADE_FEDERATIVA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TUNIDADE_FEDERATIVA.Inicia_Propriedades; 
begin 
  ID := -1; 
  IBGE := -1; 
  NOME := ''; 
  SIGLA := ''; 
  ID_REGIAO := -1; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end; 
 
function  TUNIDADE_FEDERATIVA.Listar(const AFDQ_Query:TFDQuery;
      AID:Integer = 0;
      ASIGLA:String='';
      AID_REGIAO:Integer=0;
      APagina:Integer=0): TJSONArray;
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT ');
      AFDQ_Query.Sql.Add('  UF.* ');
      AFDQ_Query.Sql.Add('  ,R.NOME AS REGIAO ');
      AFDQ_Query.Sql.Add('FROM UNIDADE_FEDERATIVA UF ');
      AFDQ_Query.Sql.Add('  JOIN REGIOES R ON R.ID = UF.ID_REGIAO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID_REGIAO > 0 then
        AFDQ_Query.Sql.Add('  AND UF.ID_REGIAO = ' + AID_REGIAO.ToString);
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND UF.ID = ' + AID.ToString);
      if ASIGLA <> '' then
        AFDQ_Query.Sql.Add('  AND UF.SIGLA = ' + ASIGLA);
      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  R.ID ');
      AFDQ_Query.Sql.Add('  ,UF.ID ');
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
        IBGE := AFDQ_Query.FieldByName('IBGE').AsInteger;
        NOME := AFDQ_Query.FieldByName('NOME').AsString;
        SIGLA := AFDQ_Query.FieldByName('SIGLA').AsString;
        ID_REGIAO := AFDQ_Query.FieldByName('ID_REGIAO').AsInteger;
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
 
procedure TUNIDADE_FEDERATIVA.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FIBGE = -1 then 
        raise Exception.Create('IBGE: CODIGO IBGE não informado'); 
      if FNOME = '' then 
        raise Exception.Create('NOME: NOME não informado'); 
      if FSIGLA = '' then 
        raise Exception.Create('SIGLA: SIGLA não informado'); 
      if FID_REGIAO = -1 then 
        raise Exception.Create('ID_REGIAO: CODIGO DA REGIAO não informado'); 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USUARIO não informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO UNIDADE_FEDERATIVA( ');
      AFDQ_Query.Sql.Add('  ID');
      AFDQ_Query.Sql.Add('  ,IBGE');
      AFDQ_Query.Sql.Add('  ,NOME');
      AFDQ_Query.Sql.Add('  ,SIGLA');
      AFDQ_Query.Sql.Add('  ,ID_REGIAO');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID');
      AFDQ_Query.Sql.Add('  ,:IBGE');
      AFDQ_Query.Sql.Add('  ,:NOME');
      AFDQ_Query.Sql.Add('  ,:SIGLA');
      AFDQ_Query.Sql.Add('  ,:ID_REGIAO');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('SIGLA').AsString := FSIGLA;
      AFDQ_Query.ParamByName('ID_REGIAO').AsInteger := FID_REGIAO;
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
 
procedure TUNIDADE_FEDERATIVA.Atualizar(const AFDQ_Query: TFDQuery; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE UNIDADE_FEDERATIVA SET ');
      if FIBGE > -1 then 
        AFDQ_Query.Sql.Add('  IBGE = :IBGE ');
      if FNOME <> '' then 
        AFDQ_Query.Sql.Add('  ,NOME = :NOME ');
      if FSIGLA <> '' then 
        AFDQ_Query.Sql.Add('  ,SIGLA = :SIGLA ');
      if FID_REGIAO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_REGIAO = :ID_REGIAO ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FIBGE > -1 then 
        AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      if FNOME <> '' then 
        AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      if FSIGLA <> '' then 
        AFDQ_Query.ParamByName('SIGLA').AsString := FSIGLA;
      if FID_REGIAO > -1 then 
        AFDQ_Query.ParamByName('ID_REGIAO').AsInteger := FID_REGIAO;
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
 
procedure TUNIDADE_FEDERATIVA.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM UNIDADE_FEDERATIVA '); 
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
 
procedure TUNIDADE_FEDERATIVA.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TUNIDADE_FEDERATIVA.SetIBGE( const Value:Integer);
begin 
  FIBGE := Value; 
end;
 
procedure TUNIDADE_FEDERATIVA.SetNOME( const Value:String);
begin 
  FNOME := Value; 
end;
 
procedure TUNIDADE_FEDERATIVA.SetSIGLA( const Value:String);
begin 
  FSIGLA := Value; 
end;
 
procedure TUNIDADE_FEDERATIVA.SetID_REGIAO( const Value:Integer);
begin 
  FID_REGIAO := Value; 
end;
 
procedure TUNIDADE_FEDERATIVA.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TUNIDADE_FEDERATIVA.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TUNIDADE_FEDERATIVA.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
