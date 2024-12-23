unit uModel.FORNECEDOR.ENDERECO;

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
  TFORNECEDOR_ENDERECO = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FID_FORNECEDOR :Integer;
    FID :Integer;
    FCEP :String;
    FLOGRADOURO :String;
    FNUMERO :String;
    FCOMPLEMENTO :String;
    FBAIRRO :String;
    FIBGE :Integer;
    FMUNICIPIO :String;
    FSIGLA_UF :String;
    FUF :String;
    FREGIAO :String;
    FCODIGO_PAIS :Integer;
    FPAIS :String;
    FID_USUARIO :Integer;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;

    procedure SetID_FORNECEDOR( const Value:Integer);
    procedure SetID( const Value:Integer);
    procedure SetCEP( const Value:String);
    procedure SetLOGRADOURO( const Value:String);
    procedure SetNUMERO( const Value:String);
    procedure SetCOMPLEMENTO( const Value:String);
    procedure SetBAIRRO( const Value:String);
    procedure SetIBGE( const Value:Integer);
    procedure SetMUNICIPIO( const Value:String);
    procedure SetSIGLA_UF( const Value:String);
    procedure SetUF( const Value:String);
    procedure SetREGIAO( const Value:String);
    procedure SetCODIGO_PAIS( const Value:Integer);
    procedure SetPAIS( const Value:String);
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
    procedure Excluir(
      const AFDQ_Query:TFDQuery;
      const AID_FORNECEDOR:Integer = 0;
      const AID:Integer = 0);

    property ID_FORNECEDOR:Integer read FID_FORNECEDOR write SetID_FORNECEDOR;
    property ID:Integer read FID write SetID;
    property CEP:String read FCEP write SetCEP;
    property LOGRADOURO:String read FLOGRADOURO write SetLOGRADOURO;
    property NUMERO:String read FNUMERO write SetNUMERO;
    property COMPLEMENTO:String read FCOMPLEMENTO write SetCOMPLEMENTO;
    property BAIRRO:String read FBAIRRO write SetBAIRRO;
    property IBGE:Integer read FIBGE write SetIBGE;
    property MUNICIPIO:String read FMUNICIPIO write SetMUNICIPIO;
    property SIGLA_UF:String read FSIGLA_UF write SetSIGLA_UF;
    property UF:String read FUF write SetUF;
    property REGIAO:String read FREGIAO write SetREGIAO;
    property CODIGO_PAIS:Integer read FCODIGO_PAIS write SetCODIGO_PAIS;
    property PAIS:String read FPAIS write SetPAIS;
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

{ TEMPRESA_ENDERECO }

constructor TFORNECEDOR_ENDERECO.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

destructor TFORNECEDOR_ENDERECO.Destroy;
begin

  inherited;
end;

procedure TFORNECEDOR_ENDERECO.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery);
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
            //Excluindo objetos da tabela EMPRESA_ENDERECO...
            if Indice_Existe(FConexao,AFDQuery,'FK_FORNECEDOR_ENDERECO_1') then
              Add('DROP INDEX FK_FORNECEDOR_ENDERECO_1;');

            if Trigger_Existe(FConexao,AFDQuery,'FORNECEDOR_ENDERECO_BI') then
              Add('DROP TRIGGER FORNECEDOR_ENDERECO_BI;');


            if Tabela_Existe(FConexao,AFDQuery,'FORNECEDOR_ENDERECO') then
              Add('DROP TABLE FORNECEDOR_ENDERECO;');

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
      lScript.Add('CREATE TABLE FORNECEDOR_ENDERECO ( ');
      lScript.Add('  ID_FORNECEDOR INTEGER NOT NULL');
      lScript.Add('  ,ID INTEGER NOT NULL');
      lScript.Add('  ,CEP VARCHAR(10)');
      lScript.Add('  ,LOGRADOURO VARCHAR(255)');
      lScript.Add('  ,NUMERO VARCHAR(50)');
      lScript.Add('  ,COMPLEMENTO VARCHAR(255)');
      lScript.Add('  ,BAIRRO VARCHAR(100)');
      lScript.Add('  ,IBGE INTEGER');
      lScript.Add('  ,MUNICIPIO VARCHAR(255)');
      lScript.Add('  ,SIGLA_UF VARCHAR(2)');
      lScript.Add('  ,UF VARCHAR(255)');
      lScript.Add('  ,REGIAO VARCHAR(255)');
      lScript.Add('  ,CODIGO_PAIS INTEGER');
      lScript.Add('  ,PAIS VARCHAR(255)');
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
          Add('ALTER TABLE FORNECEDOR_ENDERECO ADD CONSTRAINT PK_FORNECEDOR_ENDERECO PRIMARY KEY (ID_FORNECEDOR,ID);');
          Add('ALTER TABLE FORNECEDOR_ENDERECO ADD CONSTRAINT FK_FORNECEDOR_ENDERECO_1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID) ON DELETE CASCADE;');
          Add('CREATE INDEX FK_FORNECEDOR_ENDERECO_1 ON FORNECEDOR_ENDERECO (ID_FORNECEDOR);');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.ID_FORNECEDOR IS ''CODIGO DO FORNECEDOR'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.ID IS ''SEQUENCIAL'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.CEP IS ''CODIGO DO ENDERECO POSTAL'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.LOGRADOURO IS ''LOGRADOURO: RUA, AVENIDA, BECO...'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.NUMERO IS ''NUMERO DO ESTABELECIMENTO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.COMPLEMENTO IS ''COMPLEMENTO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.BAIRRO IS ''BAIRRO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.IBGE IS ''CÃ“DIGO IBGE DO MUNICÃPIO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.MUNICIPIO IS ''NOME DO MUNICÃPIO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.SIGLA_UF IS ''SIGLA DA UNIDADE FEDERATIVA'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.UF IS ''NOME DA UNIDADE FEDERATIVA'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.REGIAO IS ''NOME DA REGIÃƒO NO PAIS'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.CODIGO_PAIS IS ''CODIGO INTERNACIONAL DO PAIS'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.PAIS IS ''NOME DO PAIS'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.ID_USUARIO IS ''CODIGO DO USUÃRIO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER FORNECEDOR_ENDERECO_BI FOR FORNECEDOR_ENDERECO ');
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM FORNECEDOR_ENDERECO WHERE ID_FORNECEDOR = NEW.ID_FORNECEDOR INTO NEW.ID;');
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

procedure TFORNECEDOR_ENDERECO.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

procedure TFORNECEDOR_ENDERECO.Inicia_Propriedades;
begin
  ID_FORNECEDOR := 0;
  ID := 0;
  CEP := '';
  LOGRADOURO := '';
  NUMERO := '';
  COMPLEMENTO := '';
  BAIRRO := '';
  IBGE := 0;
  MUNICIPIO := '';
  SIGLA_UF := '';
  UF := '';
  REGIAO := '';
  CODIGO_PAIS := 0;
  PAIS := '';
  ID_USUARIO := 0;
  DT_CADASTRO := Date;
  HR_CADASTRO := Time;
end;

function  TFORNECEDOR_ENDERECO.Listar(
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
      AFDQ_Query.Sql.Add('SELECT * FROM FORNECEDOR_ENDERECO FE');
      AFDQ_Query.Sql.Add('WHERE NOT FE.ID_FORNECEDOR IS NULL');
      if AID_FORNECEDOR > 0 then
        AFDQ_Query.Sql.Add('  AND FE.ID_FORNECEDOR = ' + AID_FORNECEDOR.ToString);
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND FE.ID = ' + AID.ToString);

      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  FE.ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,FE.ID');

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
        CEP := AFDQ_Query.FieldByName('CEP').AsString;
        LOGRADOURO := AFDQ_Query.FieldByName('LOGRADOURO').AsString;
        NUMERO := AFDQ_Query.FieldByName('NUMERO').AsString;
        COMPLEMENTO := AFDQ_Query.FieldByName('COMPLEMENTO').AsString;
        BAIRRO := AFDQ_Query.FieldByName('BAIRRO').AsString;
        IBGE := AFDQ_Query.FieldByName('IBGE').AsInteger;
        MUNICIPIO := AFDQ_Query.FieldByName('MUNICIPIO').AsString;
        SIGLA_UF := AFDQ_Query.FieldByName('SIGLA_UF').AsString;
        UF := AFDQ_Query.FieldByName('UF').AsString;
        REGIAO := AFDQ_Query.FieldByName('REGIAO').AsString;
        CODIGO_PAIS := AFDQ_Query.FieldByName('CODIGO_PAIS').AsInteger;
        PAIS := AFDQ_Query.FieldByName('PAIS').AsString;
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

procedure TFORNECEDOR_ENDERECO.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if FID_USUARIO = 0 then
        raise Exception.Create('ID_USUARIO: CODIGO DO USUARIO não informado');
      if FDT_CADASTRO = 0 then
        raise Exception.Create('DT_CADASTRO: DATA DO CADASTRO não informado');
      if FHR_CADASTRO = 0 then
        raise Exception.Create('HR_CADASTRO: HORA DO CADASTRO não informado');
      if FID_FORNECEDOR = 0 then
        raise Exception.Create('ID_FORNECEDOR: CODIGO DA FORNECEDOR não informado');

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO FORNECEDOR_ENDERECO( ');
      AFDQ_Query.Sql.Add('  ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,CEP');
      AFDQ_Query.Sql.Add('  ,LOGRADOURO');
      AFDQ_Query.Sql.Add('  ,NUMERO');
      AFDQ_Query.Sql.Add('  ,COMPLEMENTO');
      AFDQ_Query.Sql.Add('  ,BAIRRO');
      AFDQ_Query.Sql.Add('  ,IBGE');
      AFDQ_Query.Sql.Add('  ,MUNICIPIO');
      AFDQ_Query.Sql.Add('  ,SIGLA_UF');
      AFDQ_Query.Sql.Add('  ,UF');
      AFDQ_Query.Sql.Add('  ,REGIAO');
      AFDQ_Query.Sql.Add('  ,CODIGO_PAIS');
      AFDQ_Query.Sql.Add('  ,PAIS');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :ID_FORNECEDOR');
      AFDQ_Query.Sql.Add('  ,:CEP');
      AFDQ_Query.Sql.Add('  ,:LOGRADOURO');
      AFDQ_Query.Sql.Add('  ,:NUMERO');
      AFDQ_Query.Sql.Add('  ,:COMPLEMENTO');
      AFDQ_Query.Sql.Add('  ,:BAIRRO');
      AFDQ_Query.Sql.Add('  ,:IBGE');
      AFDQ_Query.Sql.Add('  ,:MUNICIPIO');
      AFDQ_Query.Sql.Add('  ,:SIGLA_UF');
      AFDQ_Query.Sql.Add('  ,:UF');
      AFDQ_Query.Sql.Add('  ,:REGIAO');
      AFDQ_Query.Sql.Add('  ,:CODIGO_PAIS');
      AFDQ_Query.Sql.Add('  ,:PAIS');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO');
      AFDQ_Query.Sql.Add(');');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('CEP').AsString := FCEP;
      AFDQ_Query.ParamByName('LOGRADOURO').AsString := FLOGRADOURO;
      AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      AFDQ_Query.ParamByName('MUNICIPIO').AsString := FMUNICIPIO;
      AFDQ_Query.ParamByName('SIGLA_UF').AsString := FSIGLA_UF;
      AFDQ_Query.ParamByName('UF').AsString := FUF;
      AFDQ_Query.ParamByName('REGIAO').AsString := FREGIAO;
      AFDQ_Query.ParamByName('CODIGO_PAIS').AsInteger := FCODIGO_PAIS;
      AFDQ_Query.ParamByName('PAIS').AsString := FPAIS;
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

procedure TFORNECEDOR_ENDERECO.Atualizar(const AFDQ_Query: TFDQuery; AID_FORNECEDOR:Integer = 0; AID:Integer = 0);
begin
   try
     try
       AFDQ_Query.Connection := FConexao;


      AFDQ_Query.Sql.Add('UPDATE FORNECEDOR_ENDERECO SET ');
      if FCEP <> '' then
        AFDQ_Query.Sql.Add('  CEP = :CEP ');
      if FLOGRADOURO <> '' then
        AFDQ_Query.Sql.Add('  ,LOGRADOURO = :LOGRADOURO ');
      if FNUMERO <> '' then
        AFDQ_Query.Sql.Add('  ,NUMERO = :NUMERO ');
      if FCOMPLEMENTO <> '' then
        AFDQ_Query.Sql.Add('  ,COMPLEMENTO = :COMPLEMENTO ');
      if FBAIRRO <> '' then
        AFDQ_Query.Sql.Add('  ,BAIRRO = :BAIRRO ');
      if FIBGE > 0 then
        AFDQ_Query.Sql.Add('  ,IBGE = :IBGE ');
      if FMUNICIPIO <> '' then
        AFDQ_Query.Sql.Add('  ,MUNICIPIO = :MUNICIPIO ');
      if FSIGLA_UF <> '' then
        AFDQ_Query.Sql.Add('  ,SIGLA_UF = :SIGLA_UF ');
      if FUF <> '' then
        AFDQ_Query.Sql.Add('  ,UF = :UF ');
      if FREGIAO <> '' then
        AFDQ_Query.Sql.Add('  ,REGIAO = :REGIAO ');
      if FCODIGO_PAIS > 0 then
        AFDQ_Query.Sql.Add('  ,CODIGO_PAIS = :CODIGO_PAIS ');
      if FPAIS <> '' then
        AFDQ_Query.Sql.Add('  ,PAIS = :PAIS ');
      if FID_USUARIO > 0 then
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
      if FCEP <> '' then
        AFDQ_Query.ParamByName('CEP').AsString := FCEP;
      if FLOGRADOURO <> '' then
        AFDQ_Query.ParamByName('LOGRADOURO').AsString := FLOGRADOURO;
      if FNUMERO <> '' then
        AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      if FCOMPLEMENTO <> '' then
        AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      if FBAIRRO <> '' then
        AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      if FIBGE > 0 then
        AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      if FMUNICIPIO <> '' then
        AFDQ_Query.ParamByName('MUNICIPIO').AsString := FMUNICIPIO;
      if FSIGLA_UF <> '' then
        AFDQ_Query.ParamByName('SIGLA_UF').AsString := FSIGLA_UF;
      if FUF <> '' then
        AFDQ_Query.ParamByName('UF').AsString := FUF;
      if FREGIAO <> '' then
        AFDQ_Query.ParamByName('REGIAO').AsString := FREGIAO;
      if FCODIGO_PAIS > 0 then
        AFDQ_Query.ParamByName('CODIGO_PAIS').AsInteger := FCODIGO_PAIS;
      if FPAIS <> '' then
        AFDQ_Query.ParamByName('PAIS').AsString := FPAIS;
      if FID_USUARIO > 0 then
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

procedure TFORNECEDOR_ENDERECO.Excluir(
  const AFDQ_Query:TFDQuery;
  const AID_FORNECEDOR:Integer = 0;
  const AID:Integer = 0);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('DELETE FROM FORNECEDOR_ENDERECO FE');
      AFDQ_Query.Sql.Add('WHERE NOT FE.ID IS NULL ');
      if AID_FORNECEDOR > 0 then
        AFDQ_Query.Sql.Add('  AND FE.ID_FORNECEDOR = ' + AID_FORNECEDOR.ToString);
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND FE.ID = ' + AID.ToString);

      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFORNECEDOR_ENDERECO.SetID_FORNECEDOR( const Value:Integer);
begin
  FID_FORNECEDOR := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetID( const Value:Integer);
begin
  FID := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetCEP( const Value:String);
begin
  FCEP := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetLOGRADOURO( const Value:String);
begin
  FLOGRADOURO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetNUMERO( const Value:String);
begin
  FNUMERO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetCOMPLEMENTO( const Value:String);
begin
  FCOMPLEMENTO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetBAIRRO( const Value:String);
begin
  FBAIRRO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetIBGE( const Value:Integer);
begin
  FIBGE := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetMUNICIPIO( const Value:String);
begin
  FMUNICIPIO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetSIGLA_UF( const Value:String);
begin
  FSIGLA_UF := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetUF( const Value:String);
begin
  FUF := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetREGIAO( const Value:String);
begin
  FREGIAO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetCODIGO_PAIS( const Value:Integer);
begin
  FCODIGO_PAIS := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetPAIS( const Value:String);
begin
  FPAIS := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetID_USUARIO( const Value:Integer);
begin
  FID_USUARIO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetDT_CADASTRO( const Value:TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TFORNECEDOR_ENDERECO.SetHR_CADASTRO( const Value:TTime);
begin
  FHR_CADASTRO := Value;
end;


end.
