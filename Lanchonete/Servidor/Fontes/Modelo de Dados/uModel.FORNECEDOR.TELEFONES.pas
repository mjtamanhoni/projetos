unit uModel.FORNECEDOR.TELEFONES;

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
  TFORNECEDOR_TELEFONES = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FID_FORNECEDOR :Integer;
    FID :Integer;
    FTIPO :Integer;
    FNUMERO :String;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;

    procedure SetID_FORNECEDOR( const Value:Integer);
    procedure SetID( const Value:Integer);
    procedure SetTIPO( const Value:Integer);
    procedure SetNUMERO( const Value:String);
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
      const AID_FORNECEDOR:Integer = 0;
      const AID:Integer = 0;
      const APagina:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0);

    property ID_FORNECEDOR:Integer read FID_FORNECEDOR write SetID_FORNECEDOR;
    property ID:Integer read FID write SetID;
    property TIPO:Integer read FTIPO write SetTIPO;
    property NUMERO:String read FNUMERO write SetNUMERO;
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

{ TFORNECEDOR_TELEFONES }

constructor TFORNECEDOR_TELEFONES.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

destructor TFORNECEDOR_TELEFONES.Destroy;
begin

  inherited;
end;

procedure TFORNECEDOR_TELEFONES.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery);
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
            //Excluindo objetos da tabela FORNECEDOR_TELEFONES...
            if Indice_Existe(FConexao,AFDQuery,'FK_FORNECEDOR_TELEFONES_1') then
              Add('DROP INDEX FK_FORNECEDOR_TELEFONES_1;');

            if Trigger_Existe(FConexao,AFDQuery,'FORNECEDOR_TELEFONES_BI') then
              Add('DROP TRIGGER FORNECEDOR_TELEFONES_BI;');


            if Tabela_Existe(FConexao,AFDQuery,'FORNECEDOR_TELEFONES') then
              Add('DROP TABLE FORNECEDOR_TELEFONES;');

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
      lScript.Add('CREATE TABLE FORNECEDOR_TELEFONES ( ');
      lScript.Add('  ID_FORNECEDOR INTEGER NOT NULL');
      lScript.Add('  ,ID INTEGER NOT NULL');
      lScript.Add('  ,TIPO INTEGER NOT NULL');
      lScript.Add('  ,NUMERO VARCHAR(50) NOT NULL');
      lScript.Add('  ,ID_USUARIO INTEGER NOT NULL');
      lScript.Add('  ,DT_CADASTRO DATE NOT NULL DEFAULT CURRENT_DATE');
      lScript.Add('  ,HR_CADASTRO TIME NOT NULL DEFAULT CURRENT_TIME');
      lScript.Add(');');
      AFDScript.ExecuteScript(lScript);

      //Criando Chave primaria, estrangeira, generators e coment�rios...
      with AFDScript do
      begin
        SQLScripts.Clear;
        SQLScripts.Add;
        with SQLScripts[0].SQL do
        begin
          Add('ALTER TABLE FORNECEDOR_TELEFONES ADD CONSTRAINT PK_FORNECEDOR_TELEFONES PRIMARY KEY (ID_FORNECEDOR,ID);');
          Add('ALTER TABLE FORNECEDOR_TELEFONES ADD CONSTRAINT FK_FORNECEDOR_TELEFONES_1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID) ON DELETE CASCADE;');
          Add('CREATE INDEX FK_FORNECEDOR_TELEFONES_1 ON FORNECEDOR_TELEFONES (ID_FORNECEDOR);');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.ID_FORNECEDOR IS ''CÓDIGO DO FORNECEDOR'';');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.TIPO IS ''TIPO DO FORNECEDOR: 0-TELEFONE COMERCIAL, 1-CELULAR, 2-TELEFONE RESIDENCIAL'';');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.NUMERO IS ''NUMERO DO TELEFONE'';');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.ID_USUARIO IS ''CÓDIGO DO USUÁRIO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER FORNECEDOR_TELEFONES_BI FOR FORNECEDOR_TELEFONES ');
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM FORNECEDOR_TELEFONES WHERE ID_FORNECEDOR = NEW.ID_FORNECEDOR INTO :NEW.ID;');
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

procedure TFORNECEDOR_TELEFONES.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

procedure TFORNECEDOR_TELEFONES.Inicia_Propriedades;
begin
  ID_FORNECEDOR := -1;
  ID := -1;
  TIPO := -1;
  NUMERO := '';
  ID_USUARIO := -1;
  DT_CADASTRO := Date;
  HR_CADASTRO := Time;
end;

function  TFORNECEDOR_TELEFONES.Listar(
  const AFDQ_Query:TFDQuery;
  const AID_FORNECEDOR:Integer = 0;
  const AID:Integer = 0;
  const APagina:Integer=0): TJSONArray;
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT ');
      AFDQ_Query.Sql.Add('  FT.* ');
      AFDQ_Query.Sql.Add('  ,CASE FT.TIPO ');
      AFDQ_Query.Sql.Add('    WHEN 0 THEN ''COMERCIAL'' ');
      AFDQ_Query.Sql.Add('    WHEN 1 THEN ''CELULAR'' ');
      AFDQ_Query.Sql.Add('    WHEN 2 THEN ''RESIDENCIAL'' ');
      AFDQ_Query.Sql.Add('  END TIPO_DESC ');
      AFDQ_Query.Sql.Add('FROM FORNECEDOR_TELEFONES FT ');
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL');
      if AID_FORNECEDOR > 0 then
        AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = ' + AID_FORNECEDOR.ToString);
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND ID = ' + AID.ToString);
      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  FT.ID_FORNECEDOR ');
      AFDQ_Query.Sql.Add('  ,FT.ID ');

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
        TIPO := AFDQ_Query.FieldByName('TIPO').AsInteger;
        NUMERO := AFDQ_Query.FieldByName('NUMERO').AsString;
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

procedure TFORNECEDOR_TELEFONES.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if FTIPO = -1 then
        raise Exception.Create('TIPO: TIPO DO FORNECEDOR: 0-TELEFONE COMERCIAL, 1-CELULAR, 2-TELEFONE RESIDENCIAL n�o informado');
      if FNUMERO = '' then
        raise Exception.Create('NUMERO: NUMERO DO TELEFONE n�o informado');
      if FID_USUARIO = -1 then
        raise Exception.Create('ID_USUARIO: CÓDIGO DO USUÁRIO n�o informado');
      if FDT_CADASTRO = 0 then
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO n�o informado');
      if FHR_CADASTRO = 0 then
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO n�o informado');
      if FID_FORNECEDOR = 0 then
        raise Exception.Create('FID_FORNECEDOR: C�DIGO DA FORNECEDOR n�o informado');

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO FORNECEDOR_TELEFONES( ');
      AFDQ_Query.Sql.Add('  ID_FORNECEDOR');
      //AFDQ_Query.Sql.Add('  ,ID');
      AFDQ_Query.Sql.Add('  ,TIPO');
      AFDQ_Query.Sql.Add('  ,NUMERO');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_FORNECEDOR');
      //AFDQ_Query.Sql.Add('  ,:ID');
      AFDQ_Query.Sql.Add('  ,:TIPO');
      AFDQ_Query.Sql.Add('  ,:NUMERO');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
      AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
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

procedure TFORNECEDOR_TELEFONES.Atualizar(const AFDQ_Query: TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0);
begin
   try
     try
       AFDQ_Query.Connection := FConexao;


      AFDQ_Query.Sql.Add('UPDATE FORNECEDOR_TELEFONES SET ');
      if FTIPO > -1 then
        AFDQ_Query.Sql.Add('  TIPO = :TIPO ');
      if FNUMERO <> '' then
        AFDQ_Query.Sql.Add('  ,NUMERO = :NUMERO ');
      if FID_USUARIO > -1 then
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      if FDT_CADASTRO > 0 then
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = :ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FTIPO > -1 then
        AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
      if FNUMERO <> '' then
        AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
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

procedure TFORNECEDOR_TELEFONES.Excluir(const AFDQ_Query:TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('DELETE FROM FORNECEDOR_TELEFONES ');
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL ');
      AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = :ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := AID_FORNECEDOR;
      AFDQ_Query.ParamByName('ID').AsInteger := AID;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFORNECEDOR_TELEFONES.SetID_FORNECEDOR( const Value:Integer);
begin
  FID_FORNECEDOR := Value;
end;

procedure TFORNECEDOR_TELEFONES.SetID( const Value:Integer);
begin
  FID := Value;
end;

procedure TFORNECEDOR_TELEFONES.SetTIPO( const Value:Integer);
begin
  FTIPO := Value;
end;

procedure TFORNECEDOR_TELEFONES.SetNUMERO( const Value:String);
begin
  FNUMERO := Value;
end;

procedure TFORNECEDOR_TELEFONES.SetID_USUARIO( const Value:Integer);
begin
  FID_USUARIO := Value;
end;

procedure TFORNECEDOR_TELEFONES.SetDT_CADASTRO( const Value:TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TFORNECEDOR_TELEFONES.SetHR_CADASTRO( const Value:TTime);
begin
  FHR_CADASTRO := Value;
end;


end.
