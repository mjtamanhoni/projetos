unit uModel.FORMA_CONDICAO_PAGAMENTO;
 
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
  TFORMA_CONDICAO_PAGAMENTO = class 
  private 
    FConexao: TFDConnection; 
    
    FID_FORMA :Integer;
    FID_CONDICAO :Integer;
    FID :Integer;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID_FORMA( const Value:Integer);
    procedure SetID_CONDICAO( const Value:Integer);
    procedure SetID( const Value:Integer);
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
    function Listar(const AFDQ_Query:TFDQuery; AID_FORMA:Integer = 0; AID_CONDICAO:Integer = 0; AID:Integer = 0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID_FORMA:Integer = 0; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID_FORMA:Integer = 0; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
 
    property ID_FORMA:Integer read FID_FORMA write SetID_FORMA;
    property ID_CONDICAO:Integer read FID_CONDICAO write SetID_CONDICAO;
    property ID:Integer read FID write SetID;
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
 
{ TFORMA_CONDICAO_PAGAMENTO }
 
constructor TFORMA_CONDICAO_PAGAMENTO.Create(AConnexao: TFDConnection); 
begin 
  FConexao := AConnexao; 
end; 
 
destructor TFORMA_CONDICAO_PAGAMENTO.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TFORMA_CONDICAO_PAGAMENTO.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela FORMA_CONDICAO_PAGAMENTO... 
            if Indice_Existe(FConexao,AFDQuery,'FK_FORMA_CONDICAO_PAGAMENTO_1') then 
              Add('DROP INDEX FK_FORMA_CONDICAO_PAGAMENTO_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_FORMA_CONDICAO_PAGAMENTO_2') then 
              Add('DROP INDEX FK_FORMA_CONDICAO_PAGAMENTO_2;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'FORMA_CONDICAO_PAGAMENTO_BI') then 
              Add('DROP TRIGGER FORMA_CONDICAO_PAGAMENTO_BI;'); 
 
 
            if Tabela_Existe(FConexao,AFDQuery,'FORMA_CONDICAO_PAGAMENTO') then 
              Add('DROP TABLE FORMA_CONDICAO_PAGAMENTO;'); 
 
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
      lScript.Add('CREATE TABLE FORMA_CONDICAO_PAGAMENTO ( '); 
      lScript.Add('  ID_FORMA INTEGER NOT NULL');
      lScript.Add('  ,ID_CONDICAO INTEGER NOT NULL');
      lScript.Add('  ,ID INTEGER NOT NULL');
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
          Add('ALTER TABLE FORMA_CONDICAO_PAGAMENTO ADD CONSTRAINT PK_FORMA_CONDICAO_PAGAMENTO PRIMARY KEY (ID_FORMA,ID_CONDICAO,ID);');
          Add('ALTER TABLE FORMA_CONDICAO_PAGAMENTO ADD CONSTRAINT FK_FORMA_CONDICAO_PAGAMENTO_1 FOREIGN KEY (ID_FORMA) REFERENCES FORMA_PAGAMENTO(ID) ON DELETE CASCADE;');
          Add('ALTER TABLE FORMA_CONDICAO_PAGAMENTO ADD CONSTRAINT FK_FORMA_CONDICAO_PAGAMENTO_2 FOREIGN KEY (ID_CONDICAO) REFERENCES CONDICAO_PAGAMENTO(ID) ON DELETE CASCADE;');
          Add('CREATE INDEX FK_FORMA_CONDICAO_PAGAMENTO_1 ON FORMA_CONDICAO_PAGAMENTO (ID_FORMA);');
          Add('CREATE INDEX FK_FORMA_CONDICAO_PAGAMENTO_2 ON FORMA_CONDICAO_PAGAMENTO (ID_CONDICAO);');
          Add('COMMENT ON COLUMN FORMA_CONDICAO_PAGAMENTO.ID_FORMA IS ''CODIGO DA FORMA DE PAGAMENTO'';');
          Add('COMMENT ON COLUMN FORMA_CONDICAO_PAGAMENTO.ID_CONDICAO IS ''CODIGO DA CONDICAO DE PAGAMENTO'';');
          Add('COMMENT ON COLUMN FORMA_CONDICAO_PAGAMENTO.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN FORMA_CONDICAO_PAGAMENTO.ID_USUARIO IS ''CODIGO DO USUARIO'';');
          Add('COMMENT ON COLUMN FORMA_CONDICAO_PAGAMENTO.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN FORMA_CONDICAO_PAGAMENTO.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER FORMA_CONDICAO_PAGAMENTO_BI FOR FORMA_CONDICAO_PAGAMENTO '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('as');
      lScript.Add('begin');
      lScript.Add('  if (new.id is null) then');
      lScript.Add('  BEGIN');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1');
      lScript.Add('    FROM forma_condicao_pagamento');
      lScript.Add('    WHERE ID_CONDICAO = NEW.ID_CONDICAO');
      lScript.Add('      AND ID_FORMA = NEW.ID_FORMA');
      lScript.Add('    INTO new.id;');
      lScript.Add('  END');
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
 
procedure TFORMA_CONDICAO_PAGAMENTO.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TFORMA_CONDICAO_PAGAMENTO.Inicia_Propriedades; 
begin 
  ID_FORMA := -1; 
  ID_CONDICAO := -1; 
  ID := -1; 
  ID_USUARIO := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end; 
 
function  TFORMA_CONDICAO_PAGAMENTO.Listar(const AFDQ_Query:TFDQuery; AID_FORMA:Integer = 0; AID_CONDICAO:Integer = 0; AID:Integer = 0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM FORMA_CONDICAO_PAGAMENTO') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID_FORMA > 0 then
      begin
        AFDQ_Query.Sql.Add('  AND ID_FORMA = :ID_FORMA');
        AFDQ_Query.ParamByName('ID_FORMA').AsInteger := AID_FORMA;
      end;
      if AID_CONDICAO > 0  then
      begin
        AFDQ_Query.Sql.Add('  AND ID_CONDICAO = :ID_CONDICAO');
        AFDQ_Query.ParamByName('ID_CONDICAO').AsInteger := AID_CONDICAO;
      end;
      if AID > 0 then
      begin
        AFDQ_Query.Sql.Add('  AND ID = :ID');
        AFDQ_Query.ParamByName('ID').AsInteger := AID;
      end;
      AFDQ_Query.Active := True; 
      Result := AFDQ_Query.ToJSONArray; 
 
      if not AFDQ_Query.IsEmpty then 
      begin 
        ID_FORMA := AFDQ_Query.FieldByName('ID_FORMA').AsInteger;
        ID_CONDICAO := AFDQ_Query.FieldByName('ID_CONDICAO').AsInteger;
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
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
 
procedure TFORMA_CONDICAO_PAGAMENTO.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FID_USUARIO = -1 then 
        raise Exception.Create('ID_USUARIO: CODIGO DO USUARIO não informado'); 
      if FDT_CADASTRO = 0 then 
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado'); 
      if FHR_CADASTRO = 0 then 
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO FORMA_CONDICAO_PAGAMENTO( ');
      AFDQ_Query.Sql.Add('  ID_FORMA');
      AFDQ_Query.Sql.Add('  ,ID_CONDICAO');
      //AFDQ_Query.Sql.Add('  ,ID');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_FORMA');
      AFDQ_Query.Sql.Add('  ,:ID_CONDICAO');
      //AFDQ_Query.Sql.Add('  ,:ID');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_FORMA').AsInteger := FID_FORMA;
      AFDQ_Query.ParamByName('ID_CONDICAO').AsInteger := FID_CONDICAO;
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
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
 
procedure TFORMA_CONDICAO_PAGAMENTO.Atualizar(const AFDQ_Query: TFDQuery; AID_FORMA:Integer = 0; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE FORMA_CONDICAO_PAGAMENTO SET ');
      if FID_USUARIO > -1 then 
        AFDQ_Query.Sql.Add('  ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_FORMA = :ID_FORMA');
      AFDQ_Query.Sql.Add('  AND ID_CONDICAO = :ID_CONDICAO');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID_FORMA').AsInteger := FID_FORMA;
      AFDQ_Query.ParamByName('ID_CONDICAO').AsInteger := FID_CONDICAO;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
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
 
procedure TFORMA_CONDICAO_PAGAMENTO.Excluir(const AFDQ_Query:TFDQuery; AID_FORMA:Integer = 0; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM FORMA_CONDICAO_PAGAMENTO '); 
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL '); 
      AFDQ_Query.Sql.Add('  AND ID_FORMA = :ID_FORMA');
      AFDQ_Query.ParamByName('ID_FORMA').AsInteger := AID_FORMA;
      AFDQ_Query.Sql.Add('  AND ID_CONDICAO = :ID_CONDICAO');
      AFDQ_Query.ParamByName('ID_CONDICAO').AsInteger := AID_CONDICAO;
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
 
procedure TFORMA_CONDICAO_PAGAMENTO.SetID_FORMA( const Value:Integer);
begin 
  FID_FORMA := Value; 
end;
 
procedure TFORMA_CONDICAO_PAGAMENTO.SetID_CONDICAO( const Value:Integer);
begin 
  FID_CONDICAO := Value; 
end;
 
procedure TFORMA_CONDICAO_PAGAMENTO.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TFORMA_CONDICAO_PAGAMENTO.SetID_USUARIO( const Value:Integer);
begin 
  FID_USUARIO := Value; 
end;
 
procedure TFORMA_CONDICAO_PAGAMENTO.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TFORMA_CONDICAO_PAGAMENTO.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
