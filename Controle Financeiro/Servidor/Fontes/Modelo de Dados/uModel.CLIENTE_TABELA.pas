unit uModel.CLIENTE_TABELA;
 
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
  TCLIENTE_TABELA = class 
  private 
    FConexao: TFDConnection; 
    FPagina :Integer; 
    FPaginas :Integer; 
    
    FID_CLIENTE :Integer;
    FID_TABELA :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
 
    procedure SetID_CLIENTE( const Value:Integer);
    procedure SetID_TABELA( const Value:Integer);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHR_CADASTRO( const Value:TTime);
 
  public 
    constructor Create(AConnexao: TFDConnection); 
    destructor Destroy; override; 
 
    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery); 
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery); 
    procedure Inicia_Propriedades; 
    procedure Inserir(const AFDQ_Query:TFDQuery); 
    function Listar(const AFDQ_Query:TFDQuery; AID_CLIENTE:Integer = 0; AID_TABELA:Integer = 0; APagina:Integer=0): TJSONArray; 
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID_CLIENTE:Integer = 0; AID_TABELA:Integer = 0; APagina:Integer=0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID_CLIENTE:Integer = 0; AID_TABELA:Integer = 0; APagina:Integer=0);
 
    property ID_CLIENTE:Integer read FID_CLIENTE write SetID_CLIENTE;
    property ID_TABELA:Integer read FID_TABELA write SetID_TABELA;
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
 
{ TCLIENTE_TABELA }
 
constructor TCLIENTE_TABELA.Create(AConnexao: TFDConnection); 
begin 
  FPaginas := C_Paginas; 
  FConexao := AConnexao; 
end; 
 
destructor TCLIENTE_TABELA.Destroy; 
begin 
 
  inherited; 
end; 
 
procedure TCLIENTE_TABELA.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); 
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
            //Excluindo objetos da tabela CLIENTE_TABELA... 
            if Indice_Existe(FConexao,AFDQuery,'FK_CLIENTE_TABELA_1') then 
              Add('DROP INDEX FK_CLIENTE_TABELA_1;'); 
            if Indice_Existe(FConexao,AFDQuery,'FK_CLIENTE_TABELA_2') then 
              Add('DROP INDEX FK_CLIENTE_TABELA_2;'); 
 
 
 
            if Tabela_Existe(FConexao,AFDQuery,'CLIENTE_TABELA') then 
              Add('DROP TABLE CLIENTE_TABELA;'); 
 
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
      lScript.Add('CREATE TABLE CLIENTE_TABELA ( '); 
      lScript.Add('  ID_CLIENTE INTEGER NOT NULL');
      lScript.Add('  ,ID_TABELA INTEGER NOT NULL');
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
          Add('ALTER TABLE CLIENTE_TABELA ADD CONSTRAINT PK_CLIENTE_TABELA PRIMARY KEY (ID_CLIENTE,ID_TABELA);');
          Add('ALTER TABLE CLIENTE_TABELA ADD CONSTRAINT FK_CLIENTE_TABELA_1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID) ON DELETE CASCADE;');
          Add('ALTER TABLE CLIENTE_TABELA ADD CONSTRAINT FK_CLIENTE_TABELA_2 FOREIGN KEY (ID_TABELA) REFERENCES TABELA_PRECO(ID) ON DELETE CASCADE;');
          Add('CREATE INDEX FK_CLIENTE_TABELA_1 ON CLIENTE_TABELA (ID_CLIENTE);');
          Add('CREATE INDEX FK_CLIENTE_TABELA_2 ON CLIENTE_TABELA (ID_TABELA);');
          Add('COMMENT ON COLUMN CLIENTE_TABELA.ID_CLIENTE IS ''ID DO CLIENTE'';');
          Add('COMMENT ON COLUMN CLIENTE_TABELA.ID_TABELA IS ''ID DA TABELA'';');
          Add('COMMENT ON COLUMN CLIENTE_TABELA.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN CLIENTE_TABELA.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          ValidateAll; 
          ExecuteAll; 
        end; 
      end; 
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
 
procedure TCLIENTE_TABELA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); 
begin 
 
end; 
 
procedure TCLIENTE_TABELA.Inicia_Propriedades; 
begin 
  ID_CLIENTE := -1; 
  ID_TABELA := -1; 
  DT_CADASTRO := Date; 
  HR_CADASTRO := Time; 
end; 
 
function  TCLIENTE_TABELA.Listar(const AFDQ_Query:TFDQuery; AID_CLIENTE:Integer = 0; AID_TABELA:Integer = 0; APagina:Integer=0): TJSONArray; 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
      Inicia_Propriedades; 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('SELECT * FROM CLIENTE_TABELA') ;
      AFDQ_Query.Sql.Add('WHERE 1=1');
      if AID_CLIENTE > 0 then
        AFDQ_Query.Sql.Add('  AND ID_CLIENTE = ' + AID_CLIENTE.ToString);
      if AID_TABELA > 0 then
        AFDQ_Query.Sql.Add('  AND ID_TABELA = ' + AID_TABELA.ToString);

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
        ID_CLIENTE := AFDQ_Query.FieldByName('ID_CLIENTE').AsInteger;
        ID_TABELA := AFDQ_Query.FieldByName('ID_TABELA').AsInteger;
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
 
procedure TCLIENTE_TABELA.Inserir(const AFDQ_Query: TFDQuery); 
begin 
  try 
    try 
      AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('INSERT INTO CLIENTE_TABELA( ');
      AFDQ_Query.Sql.Add('  ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,ID_TABELA');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_CLIENTE');
      AFDQ_Query.Sql.Add('  ,:ID_TABELA');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      AFDQ_Query.ParamByName('ID_TABELA').AsInteger := FID_TABELA;
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
 
procedure TCLIENTE_TABELA.Atualizar(const AFDQ_Query:TFDQuery; AID_CLIENTE:Integer = 0; AID_TABELA:Integer = 0; APagina:Integer=0);
begin 
   try 
     try 
       AFDQ_Query.Connection := FConexao; 
 
 
      AFDQ_Query.Sql.Add('UPDATE CLIENTE_TABELA SET ');
      if FDT_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then 
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_CLIENTE = :ID_CLIENTE');
      AFDQ_Query.Sql.Add('  AND ID_TABELA = :ID_TABELA');
      AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := FID_CLIENTE;
      AFDQ_Query.ParamByName('ID_TABELA').AsInteger := FID_TABELA;
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
 
procedure TCLIENTE_TABELA.Excluir(const AFDQ_Query:TFDQuery; AID_CLIENTE:Integer = 0; AID_TABELA:Integer = 0; APagina:Integer=0);
begin
  try
    try 
      AFDQ_Query.Connection := FConexao; 
      AFDQ_Query.Active := False; 
      AFDQ_Query.Sql.Clear; 
      AFDQ_Query.Sql.Add('DELETE FROM CLIENTE_TABELA '); 
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL '); 
      AFDQ_Query.Sql.Add('  AND ID_CLIENTE = :ID_CLIENTE');
      AFDQ_Query.ParamByName('ID_CLIENTE').AsInteger := AID_CLIENTE;
      AFDQ_Query.Sql.Add('  AND ID_TABELA = :ID_TABELA');
      AFDQ_Query.ParamByName('ID_TABELA').AsInteger := AID_TABELA;
      AFDQ_Query.ExecSQL; 
    except 
      On Ex:Exception do 
        raise Exception.Create(Ex.Message); 
    end; 
  finally 
  end; 
end; 
 
procedure TCLIENTE_TABELA.SetID_CLIENTE( const Value:Integer);
begin 
  FID_CLIENTE := Value; 
end;
 
procedure TCLIENTE_TABELA.SetID_TABELA( const Value:Integer);
begin 
  FID_TABELA := Value; 
end;
 
procedure TCLIENTE_TABELA.SetDT_CADASTRO( const Value:TDate);
begin 
  FDT_CADASTRO := Value; 
end;
 
procedure TCLIENTE_TABELA.SetHR_CADASTRO( const Value:TTime);
begin 
  FHR_CADASTRO := Value; 
end;
 
 
end. 
