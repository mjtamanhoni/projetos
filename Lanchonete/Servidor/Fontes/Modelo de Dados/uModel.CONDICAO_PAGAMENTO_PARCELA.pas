unit uModel.CONDICAO_PAGAMENTO_PARCELA;
 
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
  TCONDICAO_PAGAMENTO_PARCELA = class 
  private 
    FConexao: TFDConnection; 
    
    FID_CONDICAO :Integer;
    FID :Integer;
    FPARCELA :Integer;
    FDIAS :Integer;
 
    procedure SetID_CONDICAO( const Value:Integer);
    procedure SetID( const Value:Integer);
    procedure SetPARCELA( const Value:Integer);
    procedure SetDIAS( const Value:Integer);
 
  public 
    constructor Create(AConnexao: TFDConnection); 
    destructor Destroy; override; 
 
    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery); 
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery); 
    procedure Inicia_Propriedades; 
    procedure Inserir(const AFDQ_Query:TFDQuery); 
    function Listar(const AFDQ_Query:TFDQuery; AID_CONDICAO:Integer = 0; AID:Integer = 0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
    procedure Excluir(const AFDQ_Query:TFDQuery; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
 
    property ID_CONDICAO:Integer read FID_CONDICAO write SetID_CONDICAO;
    property ID:Integer read FID write SetID;
    property PARCELA:Integer read FPARCELA write SetPARCELA;
    property DIAS:Integer read FDIAS write SetDIAS;
 
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
 
{ TCONDICAO_PAGAMENTO_PARCELA }
 
constructor TCONDICAO_PAGAMENTO_PARCELA.Create(AConnexao: TFDConnection); 
begin 
  FConexao := AConnexao; 
end; 
 
destructor TCONDICAO_PAGAMENTO_PARCELA.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TCONDICAO_PAGAMENTO_PARCELA.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela CONDICAO_PAGAMENTO_PARCELA... 
            if Indice_Existe(FConexao,AFDQuery,'FK_CONDICAO_PAGAMENTO_PARCELA_1') then 
              Add('DROP INDEX FK_CONDICAO_PAGAMENTO_PARCELA_1;'); 
 
            if Trigger_Existe(FConexao,AFDQuery,'CONDICAO_PAGAMENTO_PARCELA_BI') then 
              Add('DROP TRIGGER CONDICAO_PAGAMENTO_PARCELA_BI;'); 
 
 
            if Tabela_Existe(FConexao,AFDQuery,'CONDICAO_PAGAMENTO_PARCELA') then 
              Add('DROP TABLE CONDICAO_PAGAMENTO_PARCELA;'); 
 
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
      lScript.Add('CREATE TABLE CONDICAO_PAGAMENTO_PARCELA ( '); 
      lScript.Add('  ID_CONDICAO INTEGER NOT NULL');
      lScript.Add('  ,ID INTEGER NOT NULL');
      lScript.Add('  ,PARCELA INTEGER NOT NULL');
      lScript.Add('  ,DIAS INTEGER NOT NULL DEFAULT 1');
      lScript.Add(');'); 
      AFDScript.ExecuteScript(lScript);
 
      //Criando Chave primaria, estrangeira, generators e comentários... 
      with AFDScript do 
      begin 
        SQLScripts.Clear; 
        SQLScripts.Add; 
        with SQLScripts[0].SQL do 
        begin 
          Add('ALTER TABLE CONDICAO_PAGAMENTO_PARCELA ADD CONSTRAINT PK_CONDICAO_PAGAMENTO_PARCELA PRIMARY KEY (ID_CONDICAO,ID);');
          Add('ALTER TABLE CONDICAO_PAGAMENTO_PARCELA ADD CONSTRAINT FK_CONDICAO_PAGAMENTO_PARCELA_1 FOREIGN KEY (ID_CONDICAO) REFERENCES CONDICAO_PAGAMENTO(ID) ON DELETE CASCADE;');
          Add('CREATE INDEX FK_CONDICAO_PAGAMENTO_PARCELA_1 ON CONDICAO_PAGAMENTO_PARCELA (ID_CONDICAO);');
          Add('COMMENT ON COLUMN CONDICAO_PAGAMENTO_PARCELA.ID_CONDICAO IS ''CODIGO DA CONDICAO'';');
          Add('COMMENT ON COLUMN CONDICAO_PAGAMENTO_PARCELA.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN CONDICAO_PAGAMENTO_PARCELA.PARCELA IS ''PARCELA'';');
          Add('COMMENT ON COLUMN CONDICAO_PAGAMENTO_PARCELA.DIAS IS ''DIAS DE VENCIMENTO'';');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
 
      lScript.Clear; 
      lScript.Add('SET TERM ^ ; '); 
      lScript.Add('CREATE OR ALTER TRIGGER CONDICAO_PAGAMENTO_PARCELA_BI FOR CONDICAO_PAGAMENTO_PARCELA '); 
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('as');
      lScript.Add('begin');
      lScript.Add('  if (new.id is null) then');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM condicao_pagamento_parcela WHERE ID_CONDICAO = NEW.ID_CONDICAO INTO NEW.ID;');
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
 
procedure TCONDICAO_PAGAMENTO_PARCELA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TCONDICAO_PAGAMENTO_PARCELA.Inicia_Propriedades; 
begin 
  ID_CONDICAO := -1; 
  ID := -1; 
  PARCELA := -1; 
  DIAS := -1; 
end; 
 
function  TCONDICAO_PAGAMENTO_PARCELA.Listar(const AFDQ_Query:TFDQuery; AID_CONDICAO:Integer = 0; AID:Integer = 0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM CONDICAO_PAGAMENTO_PARCELA') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID_CONDICAO > 0 then
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
        ID_CONDICAO := AFDQ_Query.FieldByName('ID_CONDICAO').AsInteger;
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        PARCELA := AFDQ_Query.FieldByName('PARCELA').AsInteger;
        DIAS := AFDQ_Query.FieldByName('DIAS').AsInteger;
      end; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TCONDICAO_PAGAMENTO_PARCELA.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      if FPARCELA = -1 then 
        raise Exception.Create('PARCELA: PARCELA não informado'); 
      if FDIAS = -1 then 
        raise Exception.Create('DIAS: DIAS DE VENCIMENTO não informado'); 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO CONDICAO_PAGAMENTO_PARCELA( ');
      AFDQ_Query.Sql.Add('  ID_CONDICAO');
      //AFDQ_Query.Sql.Add('  ,ID');
      AFDQ_Query.Sql.Add('  ,PARCELA');
      AFDQ_Query.Sql.Add('  ,DIAS');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_CONDICAO');
      //AFDQ_Query.Sql.Add('  ,:ID');
      AFDQ_Query.Sql.Add('  ,:PARCELA');
      AFDQ_Query.Sql.Add('  ,:DIAS');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_CONDICAO').AsInteger := FID_CONDICAO;
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('PARCELA').AsInteger := FPARCELA;
      AFDQ_Query.ParamByName('DIAS').AsInteger := FDIAS;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TCONDICAO_PAGAMENTO_PARCELA.Atualizar(const AFDQ_Query: TFDQuery; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE CONDICAO_PAGAMENTO_PARCELA SET ');
      if FPARCELA > -1 then 
        AFDQ_Query.Sql.Add('  PARCELA = :PARCELA ');
      if FDIAS > -1 then 
        AFDQ_Query.Sql.Add('  ,DIAS = :DIAS ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_CONDICAO = :ID_CONDICAO');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID_CONDICAO').AsInteger := FID_CONDICAO;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FPARCELA > -1 then 
        AFDQ_Query.ParamByName('PARCELA').AsInteger := FPARCELA;
      if FDIAS > -1 then 
        AFDQ_Query.ParamByName('DIAS').AsInteger := FDIAS;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TCONDICAO_PAGAMENTO_PARCELA.Excluir(const AFDQ_Query:TFDQuery; AID_CONDICAO:Integer = 0; AID:Integer = 0); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM CONDICAO_PAGAMENTO_PARCELA '); 
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL '); 
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
 
procedure TCONDICAO_PAGAMENTO_PARCELA.SetID_CONDICAO( const Value:Integer);
begin 
  FID_CONDICAO := Value; 
end;
 
procedure TCONDICAO_PAGAMENTO_PARCELA.SetID( const Value:Integer);
begin 
  FID := Value; 
end;
 
procedure TCONDICAO_PAGAMENTO_PARCELA.SetPARCELA( const Value:Integer);
begin 
  FPARCELA := Value; 
end;
 
procedure TCONDICAO_PAGAMENTO_PARCELA.SetDIAS( const Value:Integer);
begin 
  FDIAS := Value; 
end;
 
 
end. 
