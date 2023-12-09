unit uModel.Fornecedor;

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
  TFornecedor = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FID: Integer;
    FINSCRICAO_MUNICIPAL: String;
    FINSCRICAO_ESTADUAL: String;
    FDOCUMENTO: String;
    FRAZAO_SOCIAL: String;
    FSTATUS: Integer;
    FNOME_FANTASIA: String;
    FTIPO_PESSOA: String;
    FID_USUARIO: Integer;
    FHR_CADASTRO: TTime;
    FDT_CADASTRO: TDate;

    procedure SetID(const Value: Integer);
    procedure SetDOCUMENTO(const Value: String);
    procedure SetID_USUARIO(const Value: Integer);
    procedure SetINSCRICAO_ESTADUAL(const Value: String);
    procedure SetINSCRICAO_MUNICIPAL(const Value: String);
    procedure SetNOME_FANTASIA(const Value: String);
    procedure SetRAZAO_SOCIAL(const Value: String);
    procedure SetSTATUS(const Value: Integer);
    procedure SetTIPO_PESSOA(const Value: String);
    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetHR_CADASTRO(const Value: TTime);

  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery);
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery);
    procedure Inicia_Propriedades;
    function Listar(
      const AFDQ_Query:TFDQuery;
      const AID :Integer=0;
      const ARAZAO_SOCIAL :String='';
      const ANOME_FANTASIA :String='';
      const ADOCUMENTO :String='';
      const APagina:Integer=0): TJSONArray;
    procedure Inserir(const AFDQ_Query:TFDQuery);
    procedure Atualizar(const AFDQ_Query:TFDQuery);
    procedure Excluir(const AFDQ_Query:TFDQuery;const AID:Integer=0);
    function Sequencial(const AFDQ_Query:TFDQuery):Integer;

    property ID :Integer read FID write SetID;
    property RAZAO_SOCIAL :String read FRAZAO_SOCIAL write SetRAZAO_SOCIAL;
    property NOME_FANTASIA :String read FNOME_FANTASIA write SetNOME_FANTASIA;
    property STATUS :Integer read FSTATUS write SetSTATUS;
    property TIPO_PESSOA :String read FTIPO_PESSOA write SetTIPO_PESSOA;
    property DOCUMENTO :String read FDOCUMENTO write SetDOCUMENTO;
    property INSCRICAO_ESTADUAL :String read FINSCRICAO_ESTADUAL write SetINSCRICAO_ESTADUAL;
    property INSCRICAO_MUNICIPAL :String read FINSCRICAO_MUNICIPAL write SetINSCRICAO_MUNICIPAL;
    property ID_USUARIO :Integer read FID_USUARIO write SetID_USUARIO;
    property DT_CADASTRO :TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO :TTime read FHR_CADASTRO write SetHR_CADASTRO;

  end;

  TFornecedor_Telefone = class
  private
    FConexao: TFDConnection;
    FID: Integer;
    FHR_CADASTRO: TTime;
    FNUMERO: String;
    FDT_CADASTRO: TDate;
    FID_FORNECEDOR: Integer;
    FTIPO: Integer;
    FID_USUARIO: Integer;

    procedure SetID(const Value: Integer);
    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetID_FORNECEDOR(const Value: Integer);
    procedure SetID_USUARIO(const Value: Integer);
    procedure SetNUMERO(const Value: String);
    procedure SetTIPO(const Value: Integer);

  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery);
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery);
    procedure Inicia_Propriedades;
    function Listar(
      const AFDQ_Query:TFDQuery;
      const AID_FORNECEDOR :Integer=0;
      const AID :Integer=0): TJSONArray;
    procedure Inserir(const AFDQ_Query:TFDQuery);
    procedure Atualizar(const AFDQ_Query:TFDQuery);
    procedure Excluir(const AFDQ_Query:TFDQuery;AId_Fornecedor:Integer=0;AId:Integer=0);
    function Sequencial(const AFDQ_Query:TFDQuery):Integer;

	  property ID_FORNECEDOR :Integer read FID_FORNECEDOR write SetID_FORNECEDOR;
    property ID :Integer read FID write SetID;
    property TIPO :Integer read FTIPO write SetTIPO;
    property NUMERO :String read FNUMERO write SetNUMERO;
    property ID_USUARIO :Integer read FID_USUARIO write SetID_USUARIO;
    property DT_CADASTRO :TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO :TTime read FHR_CADASTRO write SetHR_CADASTRO;

  end;

  TFornecedor_Endereco = class
  private
    FConexao: TFDConnection;
    FID: Integer;
    FLOGRADOURO: String;
    FREGIAO: String;
    FIBGE: Integer;
    FHR_CADASTRO: TTime;
    FBAIRRO: String;
    FUF: String;
    FCEP: String;
    FNUMERO: String;
    FSIGLA_UF: String;
    FMUNICIPIO: String;
    FCOMPLEMENTO: String;
    FDT_CADASTRO: TDate;
    FID_FORNECEDOR: Integer;
    FCODIGO_PAIS: Integer;
    FPAIS: String;
    FID_USUARIO: Integer;

    procedure SetID(const Value: Integer);
    procedure SetBAIRRO(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCODIGO_PAIS(const Value: Integer);
    procedure SetCOMPLEMENTO(const Value: String);
    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetIBGE(const Value: Integer);
    procedure SetID_FORNECEDOR(const Value: Integer);
    procedure SetID_USUARIO(const Value: Integer);
    procedure SetLOGRADOURO(const Value: String);
    procedure SetMUNICIPIO(const Value: String);
    procedure SetNUMERO(const Value: String);
    procedure SetPAIS(const Value: String);
    procedure SetREGIAO(const Value: String);
    procedure SetSIGLA_UF(const Value: String);
    procedure SetUF(const Value: String);

  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery);
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery);
    procedure Inicia_Propriedades;
    function Listar(
      const AFDQ_Query:TFDQuery;
      const AID_FORNECEDOR :Integer=0;
      const AID :Integer=0): TJSONArray;
    procedure Inserir(const AFDQ_Query:TFDQuery);
    procedure Atualizar(const AFDQ_Query:TFDQuery);
    procedure Excluir(const AFDQ_Query:TFDQuery;const AIdFornecedor:Integer=0;const AId:Integer=0);
    function Sequencial(const AFDQ_Query:TFDQuery):Integer;

    property ID_FORNECEDOR :Integer read FID_FORNECEDOR write SetID_FORNECEDOR;
    property ID :Integer read FID write SetID;
    property CEP :String read FCEP write SetCEP;
    property LOGRADOURO :String read FLOGRADOURO write SetLOGRADOURO;
    property NUMERO :String read FNUMERO write SetNUMERO;
    property COMPLEMENTO :String read FCOMPLEMENTO write SetCOMPLEMENTO;
    property BAIRRO :String read FBAIRRO write SetBAIRRO;
    property IBGE :Integer read FIBGE write SetIBGE;
    property MUNICIPIO :String read FMUNICIPIO write SetMUNICIPIO;
    property SIGLA_UF :String read FSIGLA_UF write SetSIGLA_UF;
    property UF :String read FUF write SetUF;
    property REGIAO :String read FREGIAO write SetREGIAO;
    property CODIGO_PAIS :Integer read FCODIGO_PAIS write SetCODIGO_PAIS;
    property PAIS :String read FPAIS write SetPAIS;
    property ID_USUARIO :Integer read FID_USUARIO write SetID_USUARIO;
    property DT_CADASTRO :TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO :TTime read FHR_CADASTRO write SetHR_CADASTRO;

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

{ TFornecedor }

procedure TFornecedor.Atualizar(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('UPDATE FORNECEDOR SET ');
      if Trim(FRAZAO_SOCIAL) <> '' then
        AFDQ_Query.Sql.Add('  RAZAO_SOCIAL = :RAZAO_SOCIAL ');
      if Trim(FNOME_FANTASIA) <> '' then
        AFDQ_Query.Sql.Add('  ,NOME_FANTASIA = :NOME_FANTASIA ');
      if FSTATUS > -1 then
        AFDQ_Query.Sql.Add('  ,STATUS = :STATUS ');
      if Trim(FTIPO_PESSOA) <> '' then
        AFDQ_Query.Sql.Add('  ,TIPO_PESSOA = :TIPO_PESSOA ');
      if Trim(FDOCUMENTO) <> '' then
        AFDQ_Query.Sql.Add('  ,DOCUMENTO = :DOCUMENTO ');
      if Trim(FINSCRICAO_ESTADUAL) <> '' then
        AFDQ_Query.Sql.Add('  ,INSCRICAO_ESTADUAL = :INSCRICAO_ESTADUAL ');
      if Trim(FINSCRICAO_MUNICIPAL) <> '' then
        AFDQ_Query.Sql.Add('  ,INSCRICAO_MUNICIPAL = :INSCRICAO_MUNICIPAL ');
      if FID_USUARIO > 0 then
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      AFDQ_Query.Sql.Add('  WHERE ID = :ID ');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if Trim(FRAZAO_SOCIAL) <> '' then
        AFDQ_Query.ParamByName('RAZAO_SOCIAL').AsString := FRAZAO_SOCIAL;
      if Trim(FNOME_FANTASIA) <> '' then
        AFDQ_Query.ParamByName('NOME_FANTASIA').AsString := FNOME_FANTASIA;
      if FSTATUS > -1 then
        AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      if Trim(FTIPO_PESSOA) <> '' then
        AFDQ_Query.ParamByName('TIPO_PESSOA').AsString := FTIPO_PESSOA;
      if Trim(FDOCUMENTO) <> '' then
        AFDQ_Query.ParamByName('DOCUMENTO').AsString := FDOCUMENTO;
      if Trim(FINSCRICAO_ESTADUAL) <> '' then
        AFDQ_Query.ParamByName('INSCRICAO_ESTADUAL').AsString := FINSCRICAO_ESTADUAL;
      if Trim(FINSCRICAO_ESTADUAL) <> '' then
        AFDQ_Query.ParamByName('INSCRICAO_MUNICIPAL').AsString := FINSCRICAO_ESTADUAL;
      if FID_USUARIO > 0 then
        AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFornecedor.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

constructor TFornecedor.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

procedure TFornecedor.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery);
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
            //Excluindo objetos da tabela FORNECEDORES_TELEFONE...
            if Trigger_Existe(FConexao,AFDQuery,'FORNECEDOR_TELEFONES_BI') then
              Add('DROP TRIGGER FORNECEDOR_TELEFONES_BI;');
            if Tabela_Existe(FConexao,AFDQuery,'FORNECEDOR_TELEFONES') then
              Add('DROP TABLE FORNECEDOR_TELEFONES;');

            //Excluindo objetos da tabela FORNECEDORES_ENDERECO...
            if Trigger_Existe(FConexao,AFDQuery,'FORNECEDOR_ENDERECO_BI') then
              Add('DROP TRIGGER FORNECEDOR_ENDERECO_BI;');

            if Tabela_Existe(FConexao,AFDQuery,'FORNECEDOR_ENDERECO') then
              Add('DROP TABLE FORNECEDOR_ENDERECO;');

            //Excluindo objetos da tabela USUARIO...
            if Indice_Existe(FConexao,AFDQuery,'FORNECEDOR_IDX2') then
               Add('DROP INDEX FORNECEDOR_IDX2;');
            if Indice_Existe(FConexao,AFDQuery,'FORNECEDOR_IDX1') then
               Add('DROP INDEX FORNECEDOR_IDX1;');

            if Procedure_Existe(FConexao,AFDQuery,'SP_GEN_FORNECEDOR_ID') then
              Add('DROP PROCEDURE SP_GEN_FORNECEDOR_ID;');

            if Trigger_Existe(FConexao,AFDQuery,'FORNECEDOR_BI') then
              Add('DROP TRIGGER FORNECEDOR_BI;');

            if Tabela_Existe(FConexao,AFDQuery,'FORNECEDOR') then
              Add('DROP TABLE FORNECEDOR;');

            if Generator_Existe(FConexao,AFDQuery,'GEN_FORNECEDOR_ID') then
               Add('DROP GENERATOR GEN_FORNECEDOR_ID;');
            if Count > 0 then
            begin
              ValidateAll;
              ExecuteAll;
            end;
          end;
        end;
      end;

      //Criando tabela...
      lScript.Clear;
      lScript.Add('CREATE TABLE FORNECEDOR ( ');
      lScript.Add('  ID INTEGER NOT NULL, ');
      lScript.Add('  RAZAO_SOCIAL VARCHAR(100) NOT NULL, ');
      lScript.Add('  NOME_FANTASIA VARCHAR(100), ');
      lScript.Add('  STATUS INTEGER DEFAULT 0 NOT NULL, ');
      lScript.Add('  TIPO_PESSOA VARCHAR(1) NOT NULL, ');
      lScript.Add('  DOCUMENTO VARCHAR(50), ');
      lScript.Add('  INSCRICAO_ESTADUAL VARCHAR(50), ');
      lScript.Add('  INSCRICAO_MUNICIPAL VARCHAR(50), ');
      lScript.Add('  ID_USUARIO INTEGER NOT NULL, ');
      lScript.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE NOT NULL, ');
      lScript.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME NOT NULL); ');
      AFDScript.ExecuteScript(lScript);

      //Criando Chave primaria e comentários...
      with AFDScript do
      begin
        SQLScripts.Clear;
        SQLScripts.Add;
        with SQLScripts[0].SQL do
        begin
          Add('ALTER TABLE FORNECEDOR ADD CONSTRAINT PK_FORNECEDOR PRIMARY KEY (ID);');
          Add('CREATE INDEX FORNECEDOR_IDX2 ON FORNECEDOR (DOCUMENTO);');
          Add('CREATE INDEX FORNECEDOR_IDX1 ON FORNECEDOR (RAZAO_SOCIAL);');

          Add('COMMENT ON COLUMN FORNECEDOR.ID IS ''SEQUENCIAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.RAZAO_SOCIAL IS ''RAZÃO SOCIAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.NOME_FANTASIA IS ''NOME FANTASIA''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.STATUS IS ''STATUS DO CADASTRO: 0-ATIVO, 1-INATIVO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.TIPO_PESSOA IS ''TIPO DE PESSOA: F-FÍSICO, J-JURÍDICO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.DOCUMENTO IS ''DOCUMENTO: CNPJ/CPF''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.INSCRICAO_ESTADUAL IS ''INSCRIÇÃO ESTADUAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.INSCRICAO_MUNICIPAL IS ''INSCRICAO MUNICIPAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.ID_USUARIO IS ''CODIGO DO USUÁRIO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.DT_CADASTRO IS ''DATA DO CADASTRO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR.HR_CADASTRO IS ''HORA DO CADASTRO''; ');

          Add('CREATE SEQUENCE GEN_FORNECEDOR_ID; ');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      //Criando Trigger...
      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER FORNECEDOR_BI FOR FORNECEDOR ');
      lScript.Add('  ACTIVE BEFORE INSERT POSITION 0 ');
      lScript.Add('  AS ');
      lScript.Add('  BEGIN ');
      lScript.Add('    IF (NEW.ID IS NULL) THEN ');
      lScript.Add('      NEW.ID = GEN_ID(GEN_FORNECEDOR_ID,1); ');
      lScript.Add(' ');
      lScript.Add('END ^');
      AFDScript.ExecuteScript(lScript);

      //Criando Procedure...
      lScript.Clear;
      lScript.Add('SET TERM ^; ');
      lScript.Add('CREATE OR ALTER PROCEDURE SP_GEN_FORNECEDOR_ID ');
      lScript.Add('RETURNS (ID INTEGER) ');
      lScript.Add('AS ');
      lScript.Add('BEGIN ');
      lScript.Add('  ID = GEN_ID(GEN_FORNECEDOR_ID, 1); ');
      lScript.Add('  SUSPEND; ');
      lScript.Add('END ^ ');
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

destructor TFornecedor.Destroy;
begin

  inherited;
end;

procedure TFornecedor.Excluir(const AFDQ_Query:TFDQuery;const AID:Integer=0);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('DELETE FROM FORNECEDOR ');
      if AID > 0 then
      begin
        AFDQ_Query.Sql.Add('WHERE ID = :ID ');
        AFDQ_Query.ParamByName('ID').AsInteger := AID;
      end;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFornecedor.Inicia_Propriedades;
begin
  ID := 0;
  RAZAO_SOCIAL := '';
  NOME_FANTASIA := '';
  STATUS := 0;
  TIPO_PESSOA := '';
  DOCUMENTO := '';
  INSCRICAO_ESTADUAL := '';
  INSCRICAO_MUNICIPAL := '';
  ID_USUARIO := 0;
  DT_CADASTRO := Date;
  HR_CADASTRO := Time;
end;

procedure TFornecedor.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if Trim(FRAZAO_SOCIAL) = '' then
        raise Exception.Create('Razão Social não informada...');
      if FSTATUS = -1 then
        raise Exception.Create('Status não informado...');
      if Trim(FTIPO_PESSOA) = '' then
        raise Exception.Create('Tipo pessoa não informado...');

      ID := Sequencial(AFDQ_Query);

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO FORNECEDOR( ');
      AFDQ_Query.Sql.Add('  ID ');
      AFDQ_Query.Sql.Add('  ,RAZAO_SOCIAL ');
      if Trim(FNOME_FANTASIA) <> '' then
        AFDQ_Query.Sql.Add('  ,NOME_FANTASIA ');
      AFDQ_Query.Sql.Add('  ,STATUS ');
      AFDQ_Query.Sql.Add('  ,TIPO_PESSOA ');
      AFDQ_Query.Sql.Add('  ,DOCUMENTO ');
      AFDQ_Query.Sql.Add('  ,INSCRICAO_ESTADUAL ');
      AFDQ_Query.Sql.Add('  ,INSCRICAO_MUNICIPAL ');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO ');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO ');
      AFDQ_Query.Sql.Add(') VALUES( ');
      AFDQ_Query.Sql.Add('  :ID ');
      AFDQ_Query.Sql.Add('  ,:RAZAO_SOCIAL ');
      if Trim(FNOME_FANTASIA) <> '' then
        AFDQ_Query.Sql.Add('  ,:NOME_FANTASIA ');
      AFDQ_Query.Sql.Add('  ,:STATUS ');
      AFDQ_Query.Sql.Add('  ,:TIPO_PESSOA ');
      AFDQ_Query.Sql.Add('  ,:DOCUMENTO ');
      AFDQ_Query.Sql.Add('  ,:INSCRICAO_ESTADUAL ');
      AFDQ_Query.Sql.Add('  ,:INSCRICAO_MUNICIPAL ');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO ');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('RAZAO_SOCIAL').AsString := FRAZAO_SOCIAL;
      if Trim(FNOME_FANTASIA) <> '' then
        AFDQ_Query.ParamByName('NOME_FANTASIA').AsString := FNOME_FANTASIA;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('TIPO_PESSOA').AsString := FTIPO_PESSOA;
      if Trim(FDOCUMENTO) <> '' then
        AFDQ_Query.ParamByName('DOCUMENTO').AsString := FDOCUMENTO;
      if Trim(FINSCRICAO_ESTADUAL) <> '' then
        AFDQ_Query.ParamByName('INSCRICAO_ESTADUAL').AsString := FINSCRICAO_ESTADUAL;
      if Trim(FINSCRICAO_ESTADUAL) <> '' then
        AFDQ_Query.ParamByName('INSCRICAO_MUNICIPAL').AsString := FINSCRICAO_ESTADUAL;
      AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDate := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsTime := FHR_CADASTRO;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

function TFornecedor.Listar(
      const AFDQ_Query:TFDQuery;
      const AID :Integer=0;
      const ARAZAO_SOCIAL :String='';
      const ANOME_FANTASIA :String='';
      const ADOCUMENTO :String='';
      const APagina:Integer=0): TJSONArray;
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT ');
      AFDQ_Query.Sql.Add('  F.* ');
      AFDQ_Query.Sql.Add('  ,CASE F.STATUS ');
      AFDQ_Query.Sql.Add('    WHEN 0 THEN ''ATIVO'' ');
      AFDQ_Query.Sql.Add('    WHEN 1 THEN ''INATIVO'' ');
      AFDQ_Query.Sql.Add('  END STATUS_DESC ');
      AFDQ_Query.Sql.Add('  ,CASE F.TIPO_PESSOA ');
      AFDQ_Query.Sql.Add('    WHEN ''F'' THEN ''FÍSICO'' ');
      AFDQ_Query.Sql.Add('    WHEN ''J'' THEN ''JURÍDICO'' ');
      AFDQ_Query.Sql.Add('  END TIPO_PESSOA_DESC ');
      AFDQ_Query.Sql.Add('FROM FORNECEDOR F ');
      AFDQ_Query.Sql.Add('WHERE F.ID = F.ID ');
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND F.ID = ' + AID.ToString);
      if ARAZAO_SOCIAL <> '' then
        AFDQ_Query.Sql.Add('  AND F.RAZAO_SOCIAL LIKE ' + QuotedStr('%'+ ARAZAO_SOCIAL + '%'));
      if ANOME_FANTASIA <> '' then
        AFDQ_Query.Sql.Add('  AND F.NOME_FANTASIA LIKE ' + QuotedStr('%'+ ANOME_FANTASIA + '%'));
      if ADOCUMENTO <> '' then
        AFDQ_Query.Sql.Add('  AND F.DOCUMENTO = ' + QuotedStr(ADOCUMENTO));
      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  F.ID ');
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
        RAZAO_SOCIAL := AFDQ_Query.FieldByName('RAZAO_SOCIAL').AsString;
        if not AFDQ_Query.FieldByName('RAZAO_SOCIAL').IsNull then
          NOME_FANTASIA := AFDQ_Query.FieldByName('NOME_FANTASIA').AsString;
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        TIPO_PESSOA := AFDQ_Query.FieldByName('TIPO_PESSOA').AsString;
        if not AFDQ_Query.FieldByName('DOCUMENTO').IsNull then
          DOCUMENTO := AFDQ_Query.FieldByName('DOCUMENTO').AsString;
        if not AFDQ_Query.FieldByName('INSCRICAO_ESTADUAL').IsNull then
          INSCRICAO_ESTADUAL := AFDQ_Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
        if not AFDQ_Query.FieldByName('INSCRICAO_MUNICIPAL').IsNull then
          INSCRICAO_MUNICIPAL := AFDQ_Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
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

function TFornecedor.Sequencial(const AFDQ_Query: TFDQuery): Integer;
begin
  try
    Result := 0;
    AFDQ_Query.Connection := FConexao;

    AFDQ_Query.Active := False;
    AFDQ_Query.Sql.Clear;
    AFDQ_Query.Sql.Add('SELECT ID FROM SP_GEN_FORNECEDOR_ID;');
    AFDQ_Query.Active := True;
    if not AFDQ_Query.IsEmpty then
      Result := AFDQ_Query.FieldByName('ID').AsInteger;
  except
    On Ex:Exception do
      raise Exception.Create(Ex.Message);
  end;
end;

procedure TFornecedor.SetDOCUMENTO(const Value: String);
begin
  FDOCUMENTO := Value;
end;

procedure TFornecedor.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TFornecedor.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TFornecedor.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TFornecedor.SetID_USUARIO(const Value: Integer);
begin
  FID_USUARIO := Value;
end;

procedure TFornecedor.SetINSCRICAO_ESTADUAL(const Value: String);
begin
  FINSCRICAO_ESTADUAL := Value;
end;

procedure TFornecedor.SetINSCRICAO_MUNICIPAL(const Value: String);
begin
  FINSCRICAO_MUNICIPAL := Value;
end;

procedure TFornecedor.SetNOME_FANTASIA(const Value: String);
begin
  FNOME_FANTASIA := Value;
end;

procedure TFornecedor.SetRAZAO_SOCIAL(const Value: String);
begin
  FRAZAO_SOCIAL := Value;
end;

procedure TFornecedor.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TFornecedor.SetTIPO_PESSOA(const Value: String);
begin
  FTIPO_PESSOA := Value;
end;

{ TFornecedor_Telefone }

procedure TFornecedor_Telefone.Atualizar(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if FID = 0 then
        raise Exception.Create('Código do telefone não informado');
      if FID_FORNECEDOR = 0 then
        raise Exception.Create('Código do fornecedor não informado');

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('UPDATE FORNECEDOR_TELEFONES SET ');
      if FTIPO >= 0 then
        AFDQ_Query.Sql.Add('  TIPO = :TIPO ');
      if Trim(FNUMERO) <> '' then
        AFDQ_Query.Sql.Add('  ,NUMERO = :NUMERO ');
      if FID_USUARIO >0 then
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      AFDQ_Query.Sql.Add('WHERE ID = :ID ');
      AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = :ID_FORNECEDOR');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FTIPO >= 0 then
        AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
      if Trim(FNUMERO) <> '' then
        AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      if FID_USUARIO >0 then
        AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFornecedor_Telefone.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

constructor TFornecedor_Telefone.Create(AConnexao: TFDConnection);
begin
  FConexao := AConnexao;
end;

procedure TFornecedor_Telefone.Criar_Estrutura(const AFDScript: TFDScript;
  AFDQuery: TFDQuery);
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
            //Excluindo objetos da tabela FORNECEDORES_TELEFONE...
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

      //Criando tabela...
      lScript.Clear;
      lScript.Add('CREATE TABLE FORNECEDOR_TELEFONES ( ');
      lScript.Add('  ID_FORNECEDOR INTEGER NOT NULL, ');
      lScript.Add('  ID INTEGER NOT NULL, ');
      lScript.Add('  TIPO INTEGER NOT NULL, ');
      lScript.Add('  NUMERO VARCHAR(50) NOT NULL, ');
      lScript.Add('  ID_USUARIO INTEGER NOT NULL, ');
      lScript.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE NOT NULL, ');
      lScript.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME NOT NULL); ');
      AFDScript.ExecuteScript(lScript);

      //Criando Chave primaria e comentários...
      with AFDScript do
      begin
        SQLScripts.Clear;
        SQLScripts.Add;
        with SQLScripts[0].SQL do
        begin
          Add('ALTER TABLE FORNECEDOR_TELEFONES ADD CONSTRAINT PK_FORNECEDOR_TELEFONES PRIMARY KEY (ID_FORNECEDOR,ID);');
          Add('ALTER TABLE FORNECEDOR_TELEFONES ADD CONSTRAINT FK_FORNECEDOR_TELEFONES_1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID) ON DELETE CASCADE;');

          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.ID_FORNECEDOR IS ''CÓDIGO DO FORNECEDOR''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.ID IS ''SEQUENCIAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.TIPO IS ''TIPO DO FORNECEDOR: 0-TELEFONE COMERCIAL, 1-CELULAR, 2-TELEFONE RESIDENCIAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.NUMERO IS ''NUMERO DO TELEFONE''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.ID_USUARIO IS ''CÓDIGO DO USUÁRIO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.DT_CADASTRO IS ''DATA DO CADASTRO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_TELEFONES.HR_CADASTRO IS ''HORA DO CADASTRO''; ');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      //Criando Trigger...
      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER FORNECEDOR_TELEFONES_BI FOR FORNECEDOR_TELEFONES ');
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      lScript.Add('AS ');
      lScript.Add('BEGIN ');
      lScript.Add('  IF (NEW.ID IS NULL) THEN ');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM FORNECEDOR_TELEFONES WHERE ID_FORNECEDOR = NEW.ID_FORNECEDOR INTO :NEW.ID; ');
      lScript.Add(' ');
      lScript.Add('END ^');
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

destructor TFornecedor_Telefone.Destroy;
begin

  inherited;
end;

procedure TFornecedor_Telefone.Excluir(const AFDQ_Query:TFDQuery;AId_Fornecedor:Integer=0;AId:Integer=0);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('DELETE FROM FORNECEDOR_TELEFONES ');
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL ');
      if AId > 0 then
        AFDQ_Query.Sql.Add('  AND ID = ' + AId.ToString);
      if AId_Fornecedor > 0 then
        AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = ' + AId_Fornecedor.ToString);
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFornecedor_Telefone.Inicia_Propriedades;
begin
	ID_FORNECEDOR := -1;
	ID := -1;
	TIPO := -1;
	NUMERO := '';
	ID_USUARIO := -1;
	DT_CADASTRO := Date;
	HR_CADASTRO := Time;
end;

procedure TFornecedor_Telefone.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if FID_FORNECEDOR = 0 then
        raise Exception.Create('Código do fornecedor não informado');
      if FTIPO = -1 then
        raise Exception.Create('Tipo não informado');
      if Trim(FNUMERO) = '' then
        raise Exception.Create('Número não informado');

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO FORNECEDOR_TELEFONES( ');
      AFDQ_Query.Sql.Add('  ID_FORNECEDOR ');
      AFDQ_Query.Sql.Add('  ,TIPO ');
      AFDQ_Query.Sql.Add('  ,NUMERO ');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO ');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO ');
      AFDQ_Query.Sql.Add(') VALUES( ');
      AFDQ_Query.Sql.Add('  :ID_FORNECEDOR ');
      AFDQ_Query.Sql.Add('  ,:TIPO ');
      AFDQ_Query.Sql.Add('  ,:NUMERO ');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO ');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
      AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDate := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsTime := FHR_CADASTRO;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

function TFornecedor_Telefone.Listar(
      const AFDQ_Query:TFDQuery;
      const AID_FORNECEDOR :Integer=0;
      const AID :Integer=0): TJSONArray;
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
      AFDQ_Query.Sql.Add('    WHEN 0 THEN ''TELEFONE COMERCIAL'' ');
      AFDQ_Query.Sql.Add('    WHEN 1 THEN ''CELULAR'' ');
      AFDQ_Query.Sql.Add('    WHEN 2 THEN ''TELEFONE RESIDENCIAL'' ');
      AFDQ_Query.Sql.Add('  END TIPO_DESC ');
      AFDQ_Query.Sql.Add('  ,F.RAZAO_SOCIAL ');
      AFDQ_Query.Sql.Add('  ,F.NOME_FANTASIA ');
      AFDQ_Query.Sql.Add('FROM FORNECEDOR_TELEFONES FT ');
      AFDQ_Query.Sql.Add('	JOIN FORNECEDOR F ON F.ID = FT.ID_FORNECEDOR ');
      AFDQ_Query.Sql.Add('WHERE NOT FT.ID IS NULL ');
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND FT.ID = ' + AID.ToString);
      if AID_FORNECEDOR > 0 then
        AFDQ_Query.Sql.Add('  AND FT.ID_FORNECEDOR = ' + ID_FORNECEDOR.ToString);
      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  FT.ID_FORNECEDOR ');
      AFDQ_Query.Sql.Add('  ,FT.ID; ');
      AFDQ_Query.Active := True;
      Result := AFDQ_Query.ToJSONArray;

      if not AFDQ_Query.IsEmpty then
      begin
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        ID_FORNECEDOR := AFDQ_Query.FieldByName('ID_FORNECEDOR').AsInteger;
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

function TFornecedor_Telefone.Sequencial(const AFDQ_Query: TFDQuery): Integer;
begin

end;

procedure TFornecedor_Telefone.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TFornecedor_Telefone.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TFornecedor_Telefone.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TFornecedor_Telefone.SetID_FORNECEDOR(const Value: Integer);
begin
  FID_FORNECEDOR := Value;
end;

procedure TFornecedor_Telefone.SetID_USUARIO(const Value: Integer);
begin
  FID_USUARIO := Value;
end;

procedure TFornecedor_Telefone.SetNUMERO(const Value: String);
begin
  FNUMERO := Value;
end;

procedure TFornecedor_Telefone.SetTIPO(const Value: Integer);
begin
  FTIPO := Value;
end;

{ TFornecedor_Endereco }

procedure TFornecedor_Endereco.Atualizar(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if FID_FORNECEDOR = 0 then
        raise Exception.Create('Código do fornecedor não informado');
      if FID = 0 then
        raise Exception.Create('Código do endereço não informado');

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('UPDATE FORNECEDOR_ENDERECO SET ');
      if Trim(FCEP) <> '' then
        AFDQ_Query.Sql.Add('  CEP = :CEP');
      if Trim(FLOGRADOURO) <> '' then
        AFDQ_Query.Sql.Add('  ,LOGRADOURO = :LOGRADOURO');
      if Trim(FNUMERO) <> '' then
        AFDQ_Query.Sql.Add('  ,NUMERO = :NUMERO ');
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.Sql.Add('  ,COMPLEMENTO = :COMPLEMENTO ');
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.Sql.Add('  ,BAIRRO = :BAIRRO ');
      if FIBGE > 0 then
        AFDQ_Query.Sql.Add('  ,IBGE = :IBGE ');
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.Sql.Add('  ,MUNICIPIO = :MUNICIPIO ');
      if Trim(FSIGLA_UF) <> '' then
        AFDQ_Query.Sql.Add('  ,SIGLA_UF = :SIGLA_UF ');
      if Trim(FUF) <> '' then
        AFDQ_Query.Sql.Add('  ,UF = :UF ');
      if Trim(FREGIAO) <> '' then
        AFDQ_Query.Sql.Add('  ,REGIAO = :REGIAO ');
      if CODIGO_PAIS > 0 then
        AFDQ_Query.Sql.Add('  ,CODIGO_PAIS = :CODIGO_PAIS ');
      if Trim(FPAIS) <> '' then
        AFDQ_Query.Sql.Add('  ,PAIS = :PAIS ');
      if FID_USUARIO > 0 then
        AFDQ_Query.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      AFDQ_Query.Sql.Add('WHERE ID = :ID ');
      AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = :ID_FORNECEDOR ');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      if Trim(FCEP) <> '' then
        AFDQ_Query.ParamByName('CEP').AsString := FCEP;
      if Trim(FLOGRADOURO) <> '' then
        AFDQ_Query.ParamByName('LOGRADOURO').AsString := FLOGRADOURO;
      if Trim(FNUMERO) <> '' then
        AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      if FIBGE > 0 then
        AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.ParamByName('MUNICIPIO').AsString := FMUNICIPIO;
      if Trim(FSIGLA_UF) <> '' then
        AFDQ_Query.ParamByName('SIGLA_UF').AsString := FSIGLA_UF;
      if Trim(FUF) <> '' then
        AFDQ_Query.ParamByName('UF').AsString := FUF;
      if Trim(FREGIAO) <> '' then
        AFDQ_Query.ParamByName('REGIAO').AsString := FREGIAO;
      if CODIGO_PAIS > 0 then
        AFDQ_Query.ParamByName('CODIGO_PAIS').AsInteger := FCODIGO_PAIS;
      if Trim(FPAIS) <> '' then
        AFDQ_Query.ParamByName('PAIS').AsString := FPAIS;
      if FID_USUARIO > 0 then
        AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFornecedor_Endereco.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

constructor TFornecedor_Endereco.Create(AConnexao: TFDConnection);
begin
  FConexao := AConnexao;
end;

procedure TFornecedor_Endereco.Criar_Estrutura(const AFDScript: TFDScript;
  AFDQuery: TFDQuery);
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
            //Excluindo objetos da tabela FORNECEDORES_TELEFONE...
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

      //Criando tabela...
      lScript.Clear;
      lScript.Add('CREATE TABLE FORNECEDOR_ENDERECO ( ');
      lScript.Add('  ID_FORNECEDOR INTEGER NOT NULL, ');
      lScript.Add('  ID INTEGER NOT NULL, ');
      lScript.Add('  CEP VARCHAR(10), ');
      lScript.Add('  LOGRADOURO VARCHAR(255), ');
      lScript.Add('  NUMERO VARCHAR(50), ');
      lScript.Add('  COMPLEMENTO VARCHAR(255), ');
      lScript.Add('  BAIRRO VARCHAR(100), ');
      lScript.Add('  IBGE INTEGER, ');
      lScript.Add('  MUNICIPIO VARCHAR(255), ');
      lScript.Add('  SIGLA_UF VARCHAR(2), ');
      lScript.Add('  UF VARCHAR(255), ');
      lScript.Add('  REGIAO VARCHAR(255), ');
      lScript.Add('  CODIGO_PAIS INTEGER, ');
      lScript.Add('  PAIS VARCHAR(255), ');
      lScript.Add('  ID_USUARIO INTEGER NOT NULL, ');
      lScript.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE NOT NULL, ');
      lScript.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME NOT NULL); ');
      AFDScript.ExecuteScript(lScript);

      //Criando Chave primaria e comentários...
      with AFDScript do
      begin
        SQLScripts.Clear;
        SQLScripts.Add;
        with SQLScripts[0].SQL do
        begin
          Add('ALTER TABLE FORNECEDOR_ENDERECO ADD CONSTRAINT PK_FORNECEDOR_ENDERECO PRIMARY KEY (ID_FORNECEDOR,ID); ');
          Add('ALTER TABLE FORNECEDOR_ENDERECO ADD CONSTRAINT FK_FORNECEDOR_ENDERECO_1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR(ID) ON DELETE CASCADE;');

          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.ID_FORNECEDOR IS ''CODIGO DO FORNECEDOR''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.ID IS ''SEQUENCIAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.CEP IS ''CÓDIGO DO ENDEREÇO POSTAL''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.LOGRADOURO IS ''LOGRADOURO: RUA, AVENIDA, BECO...''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.NUMERO IS ''NUMERO DO ESTABELECIMENTO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.COMPLEMENTO IS ''COMPLEMENTO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.BAIRRO IS ''BAIRRO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.IBGE IS ''CÓDIGO IBGE DO MUNICÍPIO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.MUNICIPIO IS ''NOME DO MUNICÍPIO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.SIGLA_UF IS ''SIGLA DA UNIDADE FEDERATIVA''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.UF IS ''NOME DA UNIDADE FEDERATIVA''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.REGIAO IS ''NOME DA REGIÃO NO PAIS''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.CODIGO_PAIS IS ''CÓDIGO INTERNACIONAL DO PAIS''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.PAIS IS ''NOME DO PAIS''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.ID_USUARIO IS ''CODIGO DO USUÁRIO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.DT_CADASTRO IS ''DATA DO CADASTRO''; ');
          Add('COMMENT ON COLUMN FORNECEDOR_ENDERECO.HR_CADASTRO IS ''HORA DO CADASTRO''; ');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      //Criando Trigger...
      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER FORNECEDOR_ENDERECO_BI FOR FORNECEDOR_ENDERECO ');
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      lScript.Add('AS ');
      lScript.Add('BEGIN ');
      lScript.Add('  IF (NEW.ID IS NULL) THEN ');
      lScript.Add('    SELECT COALESCE(MAX(ID),0) + 1 FROM FORNECEDOR_ENDERECO WHERE ID_FORNECEDOR = NEW.ID_FORNECEDOR INTO NEW.ID; ');
      lScript.Add(' ');
      lScript.Add('END ^');
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

destructor TFornecedor_Endereco.Destroy;
begin

  inherited;
end;

procedure TFornecedor_Endereco.Excluir(const AFDQ_Query:TFDQuery;const AIdFornecedor:Integer=0;const AId:Integer=0);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('DELETE FROM FORNECEDOR_ENDERECO ');
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL ');
      if AId > 0 then
        AFDQ_Query.Sql.Add('  AND ID = ' + AId.ToString);
      if AIdFornecedor > 0 then
        AFDQ_Query.Sql.Add('  AND ID_FORNECEDOR = ' + AIdFornecedor.ToString);
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TFornecedor_Endereco.Inicia_Propriedades;
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

procedure TFornecedor_Endereco.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if FID_FORNECEDOR = 0 then
        raise Exception.Create('Código do fornecedor não informado');

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO FORNECEDOR_ENDERECO( ');
      AFDQ_Query.Sql.Add('  ID_FORNECEDOR ');
      if Trim(FCEP) <> '' then
        AFDQ_Query.Sql.Add('  ,CEP ');
      if Trim(FLOGRADOURO)<> '' then
        AFDQ_Query.Sql.Add('  ,LOGRADOURO ');
      if Trim(FNUMERO) <> '' then
        AFDQ_Query.Sql.Add('  ,NUMERO ');
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.Sql.Add('  ,COMPLEMENTO ');
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.Sql.Add('  ,BAIRRO ');
      if FIBGE > 0 then
        AFDQ_Query.Sql.Add('  ,IBGE ');
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.Sql.Add('  ,MUNICIPIO ');
      if Trim(FSIGLA_UF) <> '' then
        AFDQ_Query.Sql.Add('  ,SIGLA_UF ');
      if Trim(FUF) <> '' then
        AFDQ_Query.Sql.Add('  ,UF ');
      if Trim(FREGIAO) <> '' then
        AFDQ_Query.Sql.Add('  ,REGIAO ');
      if CODIGO_PAIS > 0 then
        AFDQ_Query.Sql.Add('  ,CODIGO_PAIS ');
      if Trim(FPAIS) <> '' then
        AFDQ_Query.Sql.Add('  ,PAIS ');
      AFDQ_Query.Sql.Add('  ,ID_USUARIO ');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO ');
      AFDQ_Query.Sql.Add(') VALUES( ');
      AFDQ_Query.Sql.Add('  :ID_FORNECEDOR ');
      if Trim(FCEP) <> '' then
        AFDQ_Query.Sql.Add('  ,:CEP ');
      if Trim(FLOGRADOURO) <> '' then
        AFDQ_Query.Sql.Add('  ,:LOGRADOURO ');
      if Trim(FNUMERO) <> '' then
        AFDQ_Query.Sql.Add('  ,:NUMERO ');
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.Sql.Add('  ,:COMPLEMENTO ');
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.Sql.Add('  ,:BAIRRO ');
      if FIBGE > 0 then
        AFDQ_Query.Sql.Add('  ,:IBGE ');
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.Sql.Add('  ,:MUNICIPIO ');
      if Trim(FSIGLA_UF) <> '' then
        AFDQ_Query.Sql.Add('  ,:SIGLA_UF ');
      if Trim(FUF) <> '' then
        AFDQ_Query.Sql.Add('  ,:UF ');
      if Trim(FREGIAO) <> '' then
        AFDQ_Query.Sql.Add('  ,:REGIAO ');
      if CODIGO_PAIS > 0 then
        AFDQ_Query.Sql.Add('  ,:CODIGO_PAIS ');
      if Trim(FPAIS) <> '' then
        AFDQ_Query.Sql.Add('  ,:PAIS ');
      AFDQ_Query.Sql.Add('  ,:ID_USUARIO ');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ParamByName('ID_FORNECEDOR').AsInteger := FID_FORNECEDOR;
      if Trim(FCEP) <> '' then
        AFDQ_Query.ParamByName('CEP').AsString := FCEP;
      if Trim(FLOGRADOURO) <> '' then
        AFDQ_Query.ParamByName('LOGRADOURO').AsString := FLOGRADOURO;
      if Trim(FNUMERO) <> '' then
        AFDQ_Query.ParamByName('NUMERO').AsString := FNUMERO;
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      if FIBGE > 0 then
        AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.ParamByName('MUNICIPIO').AsString := FMUNICIPIO;
      if Trim(FSIGLA_UF) <> '' then
        AFDQ_Query.ParamByName('SIGLA_UF').AsString := FSIGLA_UF;
      if Trim(FUF) <> '' then
        AFDQ_Query.ParamByName('UF').AsString := FUF;
      if Trim(FREGIAO) <> '' then
        AFDQ_Query.ParamByName('REGIAO').AsString := FREGIAO;
      if CODIGO_PAIS > 0 then
        AFDQ_Query.ParamByName('CODIGO_PAIS').AsInteger := FCODIGO_PAIS;
      if Trim(FPAIS) <> '' then
        AFDQ_Query.ParamByName('PAIS').AsString := FPAIS;
      AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDate := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsTime := FHR_CADASTRO;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

function TFornecedor_Endereco.Listar(
      const AFDQ_Query:TFDQuery;
      const AID_FORNECEDOR :Integer=0;
      const AID :Integer=0): TJSONArray;
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT ');
      AFDQ_Query.Sql.Add('  FE.* ');
      AFDQ_Query.Sql.Add('  ,F.RAZAO_SOCIAL ');
      AFDQ_Query.Sql.Add('  ,F.NOME_FANTASIA ');
      AFDQ_Query.Sql.Add('FROM FORNECEDOR_ENDERECO FE ');
      AFDQ_Query.Sql.Add('	JOIN FORNECEDOR F ON F.ID = FE.ID_FORNECEDOR ');
      AFDQ_Query.Sql.Add('WHERE NOT FE.ID IS NULL ');
      if AID > 0 then
        AFDQ_Query.Sql.Add('  AND FE.ID = ' + AID.ToString);
      if AID_FORNECEDOR > 0 then
        AFDQ_Query.Sql.Add('  AND FE.ID_FORNECEDOR = ' + AID_FORNECEDOR.ToString);
      AFDQ_Query.Sql.Add('ORDER BY ');
      AFDQ_Query.Sql.Add('  FE.ID_FORNECEDOR ');
      AFDQ_Query.Sql.Add('  ,FE.ID; ');
      AFDQ_Query.Active := True;
      Result := AFDQ_Query.ToJSONArray;

      if not AFDQ_Query.IsEmpty then
      begin
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        ID_FORNECEDOR := AFDQ_Query.FieldByName('ID_FORNECEDOR').AsInteger;
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

function TFornecedor_Endereco.Sequencial(const AFDQ_Query: TFDQuery): Integer;
begin

end;

procedure TFornecedor_Endereco.SetBAIRRO(const Value: String);
begin
  FBAIRRO := Value;
end;

procedure TFornecedor_Endereco.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TFornecedor_Endereco.SetCODIGO_PAIS(const Value: Integer);
begin
  FCODIGO_PAIS := Value;
end;

procedure TFornecedor_Endereco.SetCOMPLEMENTO(const Value: String);
begin
  FCOMPLEMENTO := Value;
end;

procedure TFornecedor_Endereco.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TFornecedor_Endereco.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TFornecedor_Endereco.SetIBGE(const Value: Integer);
begin
  FIBGE := Value;
end;

procedure TFornecedor_Endereco.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TFornecedor_Endereco.SetID_FORNECEDOR(const Value: Integer);
begin
  FID_FORNECEDOR := Value;
end;

procedure TFornecedor_Endereco.SetID_USUARIO(const Value: Integer);
begin
  FID_USUARIO := Value;
end;

procedure TFornecedor_Endereco.SetLOGRADOURO(const Value: String);
begin
  FLOGRADOURO := Value;
end;

procedure TFornecedor_Endereco.SetMUNICIPIO(const Value: String);
begin
  FMUNICIPIO := Value;
end;

procedure TFornecedor_Endereco.SetNUMERO(const Value: String);
begin
  FNUMERO := Value;
end;

procedure TFornecedor_Endereco.SetPAIS(const Value: String);
begin
  FPAIS := Value;
end;

procedure TFornecedor_Endereco.SetREGIAO(const Value: String);
begin
  FREGIAO := Value;
end;

procedure TFornecedor_Endereco.SetSIGLA_UF(const Value: String);
begin
  FSIGLA_UF := Value;
end;

procedure TFornecedor_Endereco.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
