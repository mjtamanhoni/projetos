unit uModel.Usuario;

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
  TUsuario = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FLOGRADOURO: String;
    FIBGE: Integer;
    FHR_CADASTRO: TTime;
    FBAIRRO: String;
    FEMAIL: String;
    FUF: String;
    FID: Integer;
    FFOTO: String;
    FNUMERO: Integer;
    FUF_SIGLA: String;
    FMUNICIPIO: String;
    FSTATUS: Integer;
    FSENHA: String;
    FCOMPLEMENTO: String;
    FDT_CADASTRO: TDate;
    FLOGIN: String;
    FNOME: String;
    FTIPO: Integer;
    FCLASSIFICACAO: Integer;
    FPIN: String;
    FCELULAR: String;
    FORIGEM_DESCRICAO: String;
    FORIGEM_CODIGO: Integer;
    FORIGEM_TIPO: Integer;
    FTOKEN: String;
    FPUSH_NOTIFICATION: String;
    FID_FUNCIONARIO: Integer;

    procedure SetBAIRRO(const Value: String);
    procedure SetCELULAR(const Value: String);
    procedure SetCLASSIFICACAO(const Value: Integer);
    procedure SetCOMPLEMENTO(const Value: String);
    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetEMAIL(const Value: String);
    procedure SetFOTO(const Value: String);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetIBGE(const Value: Integer);
    procedure SetID(const Value: Integer);
    procedure SetLOGIN(const Value: String);
    procedure SetLOGRADOURO(const Value: String);
    procedure SetMUNICIPIO(const Value: String);
    procedure SetNOME(const Value: String);
    procedure SetNUMERO(const Value: Integer);
    procedure SetPIN(const Value: String);
    procedure SetSENHA(const Value: String);
    procedure SetSTATUS(const Value: Integer);
    procedure SetTIPO(const Value: Integer);
    procedure SetUF(const Value: String);
    procedure SetUF_SIGLA(const Value: String);
    procedure SetORIGEM_TIPO(const Value: Integer);
    procedure SetORIGEM_CODIGO(const Value: Integer);
    procedure SetORIGEM_DESCRICAO(const Value: String);
    procedure SetTOKEN(const Value: String);
    procedure SetPUSH_NOTIFICATION(const Value: String);
    procedure SetID_FUNCIONARIO(const Value: Integer);

  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery);
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery);
    procedure Inicia_Propriedades;
    function Listar(
      const AFDQ_Query:TFDQuery;
      const ACodigo:Integer=0;
      const ANome:String='';
      const APIN:String='';
      const AEmail:String='';
      const APagina:Integer=0): TJSONArray;
    procedure Inserir(const AFDQ_Query:TFDQuery);
    procedure Atualizar(const AFDQ_Query:TFDQuery);
    procedure Excluir(const AFDQ_Query:TFDQuery);
    function Sequencial(const AFDQ_Query:TFDQuery):Integer;
    function ValidaLogin(
      const AFDQ_Query:TFDQuery;
      const AUsuario:String;
      const ASenha:String;
      const APin:String):TJsonObject;

    property ID :Integer read FID write SetID;
    property NOME :String read FNOME write SetNOME;
	  property STATUS :Integer read FSTATUS write SetSTATUS;
	  property TIPO :Integer read FTIPO write SetTIPO;
    property LOGIN :String read FLOGIN write SetLOGIN;
    property SENHA :String read FSENHA write SetSENHA;
    property PIN :String read FPIN write SetPIN;
    property TOKEN :String read FTOKEN write SetTOKEN;
    property EMAIL :String read FEMAIL write SetEMAIL;
    property CELULAR :String read FCELULAR write SetCELULAR;
	  property CLASSIFICACAO :Integer read FCLASSIFICACAO write SetCLASSIFICACAO;
    property LOGRADOURO :String read FLOGRADOURO write SetLOGRADOURO;
    property NUMERO :Integer read FNUMERO write SetNUMERO;
    property COMPLEMENTO :String read FCOMPLEMENTO write SetCOMPLEMENTO;
    property BAIRRO :String read FBAIRRO write SetBAIRRO;
    property IBGE :Integer read FIBGE write SetIBGE;
    property MUNICIPIO :String read FMUNICIPIO write SetMUNICIPIO;
    property UF_SIGLA :String read FUF_SIGLA write SetUF_SIGLA;
    property UF :String read FUF write SetUF;
    property FOTO :String read FFOTO write SetFOTO;
    property ID_FUNCIONARIO :Integer read FID_FUNCIONARIO write SetID_FUNCIONARIO;
    property PUSH_NOTIFICATION :String read FPUSH_NOTIFICATION write SetPUSH_NOTIFICATION;
    property ORIGEM_TIPO :Integer read FORIGEM_TIPO write SetORIGEM_TIPO;  //0-EndPoint, 1-App, 2-Web...
    property ORIGEM_DESCRICAO :String read FORIGEM_DESCRICAO write SetORIGEM_DESCRICAO;  //Ex: Para 1-App, informa o código do App, (Nr-Celular)...
    property ORIGEM_CODIGO :Integer read FORIGEM_CODIGO write SetORIGEM_CODIGO;
    property DT_CADASTRO :TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO :TTime read FHR_CADASTRO write SetHR_CADASTRO;


  end;

  TUsuario_Permissoes = class
  private
    FConexao: TFDConnection;
    FHR_CADASTRO: TTime;
    FID: Integer;
    FDT_CADASTRO: TDate;
    FOBJETO: String;
    FID_USUARIO: Integer;
    FALTERAR_PER: String;
    FVISUALIZAR_PER: String;
    FEXCLUIR_PER: String;
    FINCLUIR_PER: String;

    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetID(const Value: Integer);
    procedure SetID_USUARIO(const Value: Integer);
    procedure SetOBJETO(const Value: String);
    procedure SetALTERAR_PER(const Value: String);
    procedure SetEXCLUIR_PER(const Value: String);
    procedure SetINCLUIR_PER(const Value: String);
    procedure SetVISUALIZAR_PER(const Value: String);

  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery);
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery);
    procedure Inicia_Propriedades;
    function Listar(
      const AFDQ_Query:TFDQuery;
      const AUsuario:Integer=0;
      const AObjeto:String='';
      const APagina:Integer=0):TJSONArray;
    procedure Inserir(const AFDQ_Query:TFDQuery);
    procedure Atualizar(const AFDQ_Query:TFDQuery);
    procedure Excluir(const AFDQ_Query:TFDQuery);

    property ID_USUARIO :Integer read FID_USUARIO write SetID_USUARIO;
    property ID :Integer read FID write SetID;
    property OBJETO :String read FOBJETO write SetOBJETO;
    property VISUALIZAR_PER :String read FVISUALIZAR_PER write SetVISUALIZAR_PER;
    property INCLUIR_PER :String read FINCLUIR_PER write SetINCLUIR_PER;
    property ALTERAR_PER :String read FALTERAR_PER write SetALTERAR_PER;
    property EXCLUIR_PER :String read FEXCLUIR_PER write SetEXCLUIR_PER;
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

{ TUsuario }

procedure TUsuario.Atualizar(const AFDQ_Query: TFDQuery);
begin
  try
    AFDQ_Query.Connection := FConexao;

    AFDQ_Query.Active := False;
    AFDQ_Query.SQL.Clear;
    AFDQ_Query.SQL.Add('UPDATE USUARIO SET ');
    AFDQ_Query.SQL.Add('  ID = ID ');
    if Trim(FNOME) <> '' then
      AFDQ_Query.SQL.Add('  ,NOME = :NOME ');
    if FSTATUS >= 0 then
      AFDQ_Query.SQL.Add('  ,STATUS = :STATUS ');
    if FTIPO >= 0 then
      AFDQ_Query.SQL.Add('  ,TIPO = :TIPO ');
    if Trim(FLOGIN) <> '' then
      AFDQ_Query.SQL.Add('  ,LOGIN = :LOGIN ');
    if Trim(FSENHA) <> '' then
      AFDQ_Query.SQL.Add('  ,SENHA = :SENHA ');
    if FPIN <> '' then
      AFDQ_Query.SQL.Add('  ,PIN = :PIN ');
    if Trim(FTOKEN) <> '' then
      AFDQ_Query.SQL.Add('  ,TOKEN = :TOKEN ');
    if Trim(FEMAIL) <> '' then
      AFDQ_Query.SQL.Add('  ,EMAIL = :EMAIL ');
    if Trim(FCELULAR) <> '' then
      AFDQ_Query.SQL.Add('  ,CELULAR = :CELULAR ');
    if FCLASSIFICACAO >= 0 then
      AFDQ_Query.SQL.Add('  ,CLASSIFICACAO = :CLASSIFICACAO ');
    if Trim(FLOGRADOURO) <> '' then
      AFDQ_Query.SQL.Add('  ,LOGRADOURO= :LOGRADOURO ');
    if FNUMERO > 0 then
      AFDQ_Query.SQL.Add('  ,NUMERO = :NUMERO ');
    if Trim(FCOMPLEMENTO) <> '' then
      AFDQ_Query.SQL.Add('  ,COMPLEMENTO = :COMPLEMENTO ');
    if Trim(FBAIRRO) <> '' then
      AFDQ_Query.SQL.Add('  ,BAIRRO = :BAIRRO ');
    if FIBGE > 0 then
      AFDQ_Query.SQL.Add('  ,IBGE = :IBGE ');
    if Trim(FMUNICIPIO) <> '' then
      AFDQ_Query.SQL.Add('  ,MUNICIPIO = :MUNICIPIO ');
    if Trim(FUF_SIGLA) <> '' then
      AFDQ_Query.SQL.Add('  ,UF_SIGLA = :UF_SIGLA ');
    if Trim(FUF) <> '' then
      AFDQ_Query.SQL.Add('  ,UF = :UF ');
    if Trim(FFOTO) <> '' then
      AFDQ_Query.SQL.Add('  ,FOTO = :FOTO ');
    if Trim(FPUSH_NOTIFICATION) <> '' then
      AFDQ_Query.SQL.Add('  ,PUSH_NOTIFICATION = :PUSH_NOTIFICATION ');
    if FORIGEM_TIPO > -1 then
      AFDQ_Query.SQL.Add('  ,ORIGEM_TIPO = :ORIGEM_TIPO ');
    if Trim(FORIGEM_DESCRICAO) <> '' then
      AFDQ_Query.SQL.Add('  ,ORIGEM_DESCRICAO = :ORIGEM_DESCRICAO ');
    if FORIGEM_CODIGO > 0 then
      AFDQ_Query.SQL.Add('  ,ORIGEM_CODIGO = :ORIGEM_CODIGO ');
    if FID_FUNCIONARIO > 0 then
      AFDQ_Query.SQL.Add('  ,ID_FUNCIONARIO = :ID_FUNCIONARIO ');
    AFDQ_Query.SQL.Add('WHERE ID = :ID; ');
    AFDQ_Query.ParamByName('ID').AsInteger := FID;
    if Trim(FNOME) <> '' then
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
    if FSTATUS >= 0 then
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
    if FTIPO >= 0 then
      AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
    if Trim(FLOGIN) <> '' then
      AFDQ_Query.ParamByName('LOGIN').AsString := FLOGIN;
    if Trim(FSENHA) <> '' then
      AFDQ_Query.ParamByName('SENHA').AsString := FSENHA;
    if FPIN <> '' then
      AFDQ_Query.ParamByName('PIN').AsString := FPIN;
    if Trim(FEMAIL) <> '' then
      AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
    if Trim(FCELULAR) <> '' then
      AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
    if FCLASSIFICACAO >= 0 then
      AFDQ_Query.ParamByName('CLASSIFICACAO').AsInteger := FCLASSIFICACAO;
    if Trim(FLOGRADOURO) <> '' then
      AFDQ_Query.ParamByName('LOGRADOURO').AsString := FLOGRADOURO;
    if FNUMERO > 0 then
      AFDQ_Query.ParamByName('NUMERO').AsInteger := FNUMERO;
    if Trim(FCOMPLEMENTO) <> '' then
      AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
    if Trim(FBAIRRO) <> '' then
      AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
    if FIBGE > 0 then
      AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
    if Trim(FMUNICIPIO) <> '' then
      AFDQ_Query.ParamByName('MUNICIPIO').AsString := FMUNICIPIO;
    if Trim(FUF_SIGLA) <> '' then
      AFDQ_Query.ParamByName('UF_SIGLA').AsString := FUF_SIGLA;
    if Trim(FUF) <> '' then
      AFDQ_Query.ParamByName('UF').AsString := FUF;
    if Trim(FFOTO) <> '' then
      AFDQ_Query.ParamByName('FOTO').AsString := FFOTO;
    if Trim(FPUSH_NOTIFICATION) <> '' then
      AFDQ_Query.ParamByName('PUSH_NOTIFICATION').AsString := FPUSH_NOTIFICATION;
    if FORIGEM_TIPO > -1 then
      AFDQ_Query.ParamByName('ORIGEM_TIPO').AsInteger := FORIGEM_TIPO;
    if Trim(FORIGEM_DESCRICAO) <> '' then
      AFDQ_Query.ParamByName('ORIGEM_DESCRICAO').AsString := FORIGEM_DESCRICAO;
    if FORIGEM_CODIGO > 0 then
      AFDQ_Query.ParamByName('ORIGEM_CODIGO').AsInteger := FORIGEM_CODIGO;
    if FID_FUNCIONARIO > 0 then
      AFDQ_Query.ParamByName('ID_FUNCIONARIO').AsInteger := FID_FUNCIONARIO;
    AFDQ_Query.ExecSQL;
  except
    On Ex:Exception do
      raise Exception.Create(Ex.Message);
  end;
end;

procedure TUsuario.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

constructor TUsuario.Create(AConnexao: TFDConnection);
begin
  FConexao := AConnexao;
  FPaginas := 30;
end;

destructor TUsuario.Destroy;
begin

  inherited;
end;

procedure TUsuario.Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery);
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
            //Excluindo objetos da tabela USUARIO_PERMISSOES...
            if Indice_Existe(FConexao,AFDQuery,'PER_USUARIO_OBJETO_IDX') then
               Add('DROP INDEX PER_USUARIO_OBJETO_IDX;');
            if Trigger_Existe(FConexao,AFDQuery,'USUARIO_PERMISSOES_BI') then
              Add('DROP TRIGGER USUARIO_PERMISSOES_BI;');
            if Tabela_Existe(FConexao,AFDQuery,'USUARIO_PERMISSOES') then
              Add('DROP TABLE USUARIO_PERMISSOES;');

            //Excluindo objetos da tabela USUARIO...
            if Indice_Existe(FConexao,AFDQuery,'USUARIO_PIN_IDX') then
               Add('DROP INDEX USUARIO_PIN_IDX;');
            if Indice_Existe(FConexao,AFDQuery,'USUARIO_NOME_IDX') then
               Add('DROP INDEX USUARIO_NOME_IDX;');
            if Indice_Existe(FConexao,AFDQuery,'USUARIO_LOGIN_IDX') then
               Add('DROP INDEX USUARIO_LOGIN_IDX;');
            if Indice_Existe(FConexao,AFDQuery,'USUARIO_EMAIL_IDX') then
               Add('DROP INDEX USUARIO_EMAIL_IDX;');
            if Procedure_Existe(FConexao,AFDQuery,'SP_GEN_USUARIO_ID') then
              Add('DROP PROCEDURE SP_GEN_USUARIO_ID;');
            if Trigger_Existe(FConexao,AFDQuery,'USUARIO_BI') then
              Add('DROP TRIGGER USUARIO_BI;');
            if Tabela_Existe(FConexao,AFDQuery,'USUARIO') then
              Add('DROP TABLE USUARIO;');
            if Generator_Existe(FConexao,AFDQuery,'GEN_USUARIO_ID') then
               Add('DROP GENERATOR GEN_USUARIO_ID;');
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
      lScript.Add('CREATE TABLE USUARIO ( ');
      lScript.Add('  ID INTEGER NOT NULL, ');
      lScript.Add('  NOME VARCHAR(100) NOT NULL, ');
      lScript.Add('  STATUS INTEGER NOT NULL, ');
      lScript.Add('  TIPO INTEGER NOT NULL, ');
      lScript.Add('  LOGIN VARCHAR(100) NOT NULL, ');
      lScript.Add('  SENHA VARCHAR(100) NOT NULL, ');
      lScript.Add('  PIN VARCHAR(4) NOT NULL, ');
      lScript.Add('  TOKEN VARCHAR(255), ');
      lScript.Add('  EMAIL VARCHAR(255) NOT NULL, ');
      lScript.Add('  CELULAR VARCHAR(20), ');
      lScript.Add('  CLASSIFICACAO INTEGER NOT NULL, ');
      lScript.Add('  LOGRADOURO VARCHAR(100), ');
      lScript.Add('  NUMERO INTEGER, ');
      lScript.Add('  COMPLEMENTO VARCHAR(255), ');
      lScript.Add('  BAIRRO VARCHAR(100), ');
      lScript.Add('  IBGE INTEGER, ');
      lScript.Add('  MUNICIPIO VARCHAR(100), ');
      lScript.Add('  UF_SIGLA VARCHAR(2), ');
      lScript.Add('  UF VARCHAR(100), ');
      lScript.Add('  FOTO BLOB SUB_TYPE 1 SEGMENT SIZE 4096, ');
      lScript.Add('  ID_FUNCIONARIO INTEGER, ');
      lScript.Add('  PUSH_NOTIFICATION VARCHAR(255), ');
      lScript.Add('  ORIGEM_TIPO INTEGER, ');
      lScript.Add('  ORIGEM_DESCRICAO VARCHAR(100), ');
      lScript.Add('  ORIGEM_CODIGO INTEGER, ');
      lScript.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE NOT NULL, ');
      lScript.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME NOT NULL); ');
      AFDScript.ExecuteScript(lScript);

      //Criando Chave primaria...
      with AFDScript do
      begin
        SQLScripts.Clear;
        SQLScripts.Add;
        with SQLScripts[0].SQL do
        begin
          Add('ALTER TABLE USUARIO ADD CONSTRAINT PK_USUARIO PRIMARY KEY (ID);');
          Add('ALTER TABLE USUARIO ADD CONSTRAINT FK_USUARIO_FUNCIONARIO FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO (ID);');
          Add('COMMENT ON COLUMN USUARIO.ID IS ''Código sequencial''; ');
          Add('COMMENT ON COLUMN USUARIO.NOME  IS ''Nome completo''; ');
          Add('COMMENT ON COLUMN USUARIO.STATUS  IS ''0-Ativo, 1-Inativo''; ');
          Add('COMMENT ON COLUMN USUARIO.TIPO  IS ''0-Funcionário, 1-Fornecedor, 2-Cliente. (Usado apenas na WEB e no APP)''; ');
          Add('COMMENT ON COLUMN USUARIO.SENHA  IS ''Senha de acesso''; ');
          Add('COMMENT ON COLUMN USUARIO.LOGIN  IS ''Login de acesso''; ');
          Add('COMMENT ON COLUMN USUARIO.PIN  IS ''Pin de acesso''; ');
          Add('COMMENT ON COLUMN USUARIO.TOKEN  IS ''TOKEN de acesso''; ');
          Add('COMMENT ON COLUMN USUARIO.EMAIL  IS ''Email''; ');
          Add('COMMENT ON COLUMN USUARIO.CELULAR  IS ''Celular para contato''; ');
          Add('COMMENT ON COLUMN USUARIO.CLASSIFICACAO  IS ''0-Administrador, 1-Gerente, 2-Caixa, 3-Vendedor, 4-Entregador, 5-Consumidor''; ');
          Add('COMMENT ON COLUMN USUARIO.NUMERO  IS ''Número do enderço''; ');
          Add('COMMENT ON COLUMN USUARIO.LOGRADOURO  IS ''Endereço do usuário''; ');
          Add('COMMENT ON COLUMN USUARIO.COMPLEMENTO  IS ''Complemento do endereço''; ');
          Add('COMMENT ON COLUMN USUARIO.BAIRRO  IS ''Bairro do endereço''; ');
          Add('COMMENT ON COLUMN USUARIO.IBGE  IS ''Código IBGE do município''; ');
          Add('COMMENT ON COLUMN USUARIO.MUNICIPIO  IS ''Nome do Município''; ');
          Add('COMMENT ON COLUMN USUARIO.UF_SIGLA  IS ''Sigla da Unidade Federativa''; ');
          Add('COMMENT ON COLUMN USUARIO.UF  IS ''Unidade Federativa''; ');
          Add('COMMENT ON COLUMN USUARIO.FOTO  IS ''Foto em base 64''; ');
          Add('COMMENT ON COLUMN USUARIO.ID_FUNCIONARIO  IS ''Codigo do funcionario''; ');
          Add('COMMENT ON COLUMN USUARIO.PUSH_NOTIFICATION  IS ''Token para enviar/receber mensagens''; ');
          Add('COMMENT ON COLUMN USUARIO.ORIGEM_TIPO  IS ''Origem do cadastro. 0-EndPoint, 1-App, 2-Web''; ');
          Add('COMMENT ON COLUMN USUARIO.ORIGEM_DESCRICAO  IS ''Descrição da origem. Ex: App envia o código do Celular ou Nr. do Telefone''; ');
          Add('COMMENT ON COLUMN USUARIO.ORIGEM_CODIGO  IS ''Código do registro na origem''; ');
          Add('COMMENT ON COLUMN USUARIO.DT_CADASTRO  IS ''Data do cadastro''; ');
          Add('COMMENT ON COLUMN USUARIO.HR_CADASTRO  IS ''Hora do cadastro''; ');
          Add('CREATE SEQUENCE GEN_USUARIO_ID; ');
          Add('CREATE INDEX USUARIO_NOME_IDX ON USUARIO (NOME); ');
          Add('CREATE INDEX USUARIO_LOGIN_IDX ON USUARIO (LOGIN); ');
          Add('CREATE INDEX USUARIO_PIN_IDX ON USUARIO (PIN); ');
          Add('CREATE INDEX USUARIO_EMAIL_IDX ON USUARIO (EMAIL); ');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      //Criando Trigger...
      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER USUARIO_BI FOR USUARIO ');
      lScript.Add('  ACTIVE BEFORE INSERT POSITION 0 ');
      lScript.Add('  AS ');
      lScript.Add('  BEGIN ');
      lScript.Add('    IF (NEW.ID IS NULL) THEN ');
      lScript.Add('      NEW.ID = GEN_ID(GEN_USUARIO_ID,1); ');
      lScript.Add(' ');
      lScript.Add('END ^');
      AFDScript.ExecuteScript(lScript);

      //Criando Procedure...
      {
      lScript.Clear;
      lScript.Add('SET TERM ^; ');
      lScript.Add('CREATE OR ALTER PROCEDURE SP_GEN_USUARIO_ID ');
      lScript.Add('RETURNS (ID INTEGER) ');
      lScript.Add('AS ');
      lScript.Add('BEGIN ');
      lScript.Add('  ID = GEN_ID(GEN_USUARIO_ID, 1); ');
      lScript.Add('  SUSPEND; ');
      lScript.Add('END ^ ');
      AFDScript.ExecuteScript(lScript);
      }
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

procedure TUsuario.Excluir(const AFDQ_Query: TFDQuery);
begin
  try
    AFDQ_Query.Connection := FConexao;

    AFDQ_Query.Active := False;
    AFDQ_Query.Sql.Clear;
    AFDQ_Query.Sql.Add('DELETE FROM USUARIO WHERE ID = :ID;');
    AFDQ_Query.ParamByName('ID').AsInteger := FID;
    AFDQ_Query.ExecSQL;
  except
    On Ex:Exception do
      raise Exception.Create(Ex.Message);
  end;
end;

procedure TUsuario.Inicia_Propriedades;
begin
  ID := -1;
  NOME := '';
	STATUS := -1;
	TIPO := -1;
  LOGIN := '';
  SENHA := '';
  PIN := '';
  TOKEN := '';
  EMAIL := '';
  CELULAR := '';
	CLASSIFICACAO := -1;
  LOGRADOURO := '';
  NUMERO := -1;
  COMPLEMENTO := '';
  BAIRRO := '';
  IBGE := -1;
  ID_FUNCIONARIO := -1;
  MUNICIPIO := '';
  UF_SIGLA := '';
  UF := '';
  FOTO := '';
  ORIGEM_TIPO := -1;
  ORIGEM_DESCRICAO := '';
  ORIGEM_CODIGO := -1;
  DT_CADASTRO := Date;
  HR_CADASTRO := Time;
end;

procedure TUsuario.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if Trim(FNOME) = '' then
        raise Exception.Create('Nome não informado...');
      if FTIPO = -1 then
        raise Exception.Create('Tipo não informado...');
      if Trim(FLOGIN) = '' then
        raise Exception.Create('Login não informado...');
      if Trim(FSENHA) = '' then
        raise Exception.Create('Senha não informado...');
      if FPIN = '' then
        raise Exception.Create('PIN não informado...');
      if Trim(FEMAIL) = '' then
        raise Exception.Create('Email não informado...');
      if FCLASSIFICACAO = -1 then
        raise Exception.Create('Classificação não informado...');

      ID := Sequencial(AFDQ_Query);

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO USUARIO( ');
      AFDQ_Query.Sql.Add('  ID ');
      AFDQ_Query.Sql.Add('  ,NOME ');
      AFDQ_Query.Sql.Add('  ,STATUS ');
      AFDQ_Query.Sql.Add('  ,TIPO ');
      AFDQ_Query.Sql.Add('  ,LOGIN ');
      AFDQ_Query.Sql.Add('  ,SENHA ');
      AFDQ_Query.Sql.Add('  ,PIN ');
      AFDQ_Query.Sql.Add('  ,TOKEN ');
      AFDQ_Query.Sql.Add('  ,EMAIL ');
      if Trim(FCELULAR) <> '' then
        AFDQ_Query.Sql.Add('  ,CELULAR ');
      AFDQ_Query.Sql.Add('  ,CLASSIFICACAO ');
      if Trim(FLOGRADOURO) <> '' then
        AFDQ_Query.Sql.Add('  ,LOGRADOURO ');
      if FNUMERO > 0 then
        AFDQ_Query.Sql.Add('  ,NUMERO ');
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.Sql.Add('  ,COMPLEMENTO ');
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.Sql.Add('  ,BAIRRO ');
      if FIBGE > 0 then
        AFDQ_Query.Sql.Add('  ,IBGE ');
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.Sql.Add('  ,MUNICIPIO ');
      if Trim(FUF_SIGLA) <> '' then
        AFDQ_Query.Sql.Add('  ,UF_SIGLA ');
      if Trim(FUF) <> '' then
        AFDQ_Query.Sql.Add('  ,UF ');
      if Trim(FFOTO) <> '' then
        AFDQ_Query.Sql.Add('  ,FOTO ');
      if Trim(FPUSH_NOTIFICATION) <> '' then
        AFDQ_Query.Sql.Add('  ,PUSH_NOTIFICATION ');
      if FORIGEM_TIPO > -1 then
        AFDQ_Query.Sql.Add('  ,ORIGEM_TIPO ');
      if Trim(FORIGEM_DESCRICAO) <> '' then
        AFDQ_Query.Sql.Add('  ,ORIGEM_DESCRICAO ');
      if FORIGEM_CODIGO > 0 then
        AFDQ_Query.Sql.Add('  ,ORIGEM_CODIGO ');
      if FID_FUNCIONARIO > 0 then
        AFDQ_Query.Sql.Add('  ,ID_FUNCIONARIO ');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO ');
      AFDQ_Query.Sql.Add(') VALUES( ');
      AFDQ_Query.Sql.Add('  :ID ');
      AFDQ_Query.Sql.Add('  ,:NOME ');
      AFDQ_Query.Sql.Add('  ,:STATUS ');
      AFDQ_Query.Sql.Add('  ,:TIPO ');
      AFDQ_Query.Sql.Add('  ,:LOGIN ');
      AFDQ_Query.Sql.Add('  ,:SENHA ');
      AFDQ_Query.Sql.Add('  ,:PIN ');
      AFDQ_Query.Sql.Add('  ,:TOKEN ');
      AFDQ_Query.Sql.Add('  ,:EMAIL ');
      if Trim(FCELULAR) <> '' then
        AFDQ_Query.Sql.Add('  ,:CELULAR ');
      AFDQ_Query.Sql.Add('  ,:CLASSIFICACAO ');
      if Trim(FLOGRADOURO) <> '' then
        AFDQ_Query.Sql.Add('  ,:LOGRADOURO ');
      if FNUMERO > 0 then
        AFDQ_Query.Sql.Add('  ,:NUMERO ');
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.Sql.Add('  ,:COMPLEMENTO ');
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.Sql.Add('  ,:BAIRRO ');
      if FIBGE > 0 then
        AFDQ_Query.Sql.Add('  ,:IBGE ');
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.Sql.Add('  ,:MUNICIPIO ');
      if Trim(FUF_SIGLA) <> '' then
        AFDQ_Query.Sql.Add('  ,:UF_SIGLA ');
      if Trim(FUF) <> '' then
        AFDQ_Query.Sql.Add('  ,:UF ');
      if Trim(FFOTO) <> '' then
        AFDQ_Query.Sql.Add('  ,:FOTO ');
      if Trim(FPUSH_NOTIFICATION) <> '' then
        AFDQ_Query.Sql.Add('  ,:PUSH_NOTIFICATION ');
      if FORIGEM_TIPO > -1 then
        AFDQ_Query.Sql.Add('  ,:ORIGEM_TIPO ');
      if Trim(FORIGEM_DESCRICAO) <> '' then
        AFDQ_Query.Sql.Add('  ,:ORIGEM_DESCRICAO ');
      if FORIGEM_CODIGO > 0 then
        AFDQ_Query.Sql.Add('  ,:ORIGEM_CODIGO ');
      if FID_FUNCIONARIO > 0 then
        AFDQ_Query.Sql.Add('  ,:ID_FUNCIONARIO ');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('TIPO').AsInteger := FTIPO;
      AFDQ_Query.ParamByName('LOGIN').AsString := FLOGIN;
      AFDQ_Query.ParamByName('SENHA').AsString := FSENHA;
      AFDQ_Query.ParamByName('PIN').AsString := FPIN;
      AFDQ_Query.ParamByName('TOKEN').AsString := FTOKEN;
      AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
      if Trim(FCELULAR) <> '' then
        AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      AFDQ_Query.ParamByName('CLASSIFICACAO').AsInteger := FCLASSIFICACAO;
      if Trim(FLOGRADOURO) <> '' then
        AFDQ_Query.ParamByName('LOGRADOURO').AsString := FLOGRADOURO;
      if FNUMERO = -1 then
        AFDQ_Query.ParamByName('NUMERO').AsInteger := FNUMERO;
      if Trim(FCOMPLEMENTO) <> '' then
        AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      if Trim(FBAIRRO) <> '' then
        AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      if FIBGE > 0 then
        AFDQ_Query.ParamByName('IBGE').AsInteger := FIBGE;
      if Trim(FMUNICIPIO) <> '' then
        AFDQ_Query.ParamByName('MUNICIPIO').AsString := FMUNICIPIO;
      if Trim(FUF_SIGLA) <> '' then
        AFDQ_Query.ParamByName('UF_SIGLA').AsString := FUF_SIGLA;
      if Trim(FUF) <> '' then
        AFDQ_Query.ParamByName('UF').AsString := FUF;
      if Trim(FFOTO) <> '' then
        AFDQ_Query.ParamByName('FOTO').AsString := FFOTO;
      if Trim(FPUSH_NOTIFICATION) <> '' then
        AFDQ_Query.ParamByName('PUSH_NOTIFICATION').AsString := FPUSH_NOTIFICATION;
      if FORIGEM_TIPO > -1 then
        AFDQ_Query.ParamByName('ORIGEM_TIPO').AsInteger := FORIGEM_TIPO;
      if Trim(FORIGEM_DESCRICAO) <> '' then
        AFDQ_Query.ParamByName('ORIGEM_DESCRICAO').AsString := FORIGEM_DESCRICAO;
      if FORIGEM_CODIGO > 0 then
        AFDQ_Query.ParamByName('ORIGEM_CODIGO').AsInteger := FORIGEM_CODIGO;
      if FID_FUNCIONARIO > 0 then
        AFDQ_Query.ParamByName('ID_FUNCIONARIO').AsInteger := FID_FUNCIONARIO;
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

function TUsuario.Listar(
      const AFDQ_Query:TFDQuery;
      const ACodigo:Integer=0;
      const ANome:String='';
      const APIN:String='';
      const AEmail:String='';
      const APagina:Integer=0): TJSONArray;
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT ');
      AFDQ_Query.Sql.Add('  U.* ');
      AFDQ_Query.Sql.Add('  ,CASE U.STATUS ');
      AFDQ_Query.Sql.Add('    WHEN 0 THEN ''ATIVO'' ');
      AFDQ_Query.Sql.Add('    WHEN 1 THEN ''INATIVO'' ');
      AFDQ_Query.Sql.Add('  END STATUS_DESC ');
      AFDQ_Query.Sql.Add('  ,CASE U.TIPO ');
      AFDQ_Query.Sql.Add('    WHEN 0 THEN ''FUNCIONÁRIO'' ');
      AFDQ_Query.Sql.Add('    WHEN 1 THEN ''FORNECEDOR'' ');
      AFDQ_Query.Sql.Add('    WHEN 2 THEN ''CLIENTE'' ');
      AFDQ_Query.Sql.Add('  END TIPO_DESC ');
      AFDQ_Query.Sql.Add('  ,CASE U.CLASSIFICACAO ');
      AFDQ_Query.Sql.Add('    WHEN 0 THEN ''ADMINISTRADOR'' ');
      AFDQ_Query.Sql.Add('    WHEN 1 THEN ''GERENTE'' ');
      AFDQ_Query.Sql.Add('    WHEN 2 THEN ''CAIXA'' ');
      AFDQ_Query.Sql.Add('    WHEN 3 THEN ''VENDEDOR'' ');
      AFDQ_Query.Sql.Add('    WHEN 4 THEN ''ENTREGADOR'' ');
      AFDQ_Query.Sql.Add('    WHEN 5 THEN ''CONSUMIDOR'' ');
      AFDQ_Query.Sql.Add('  END CLASSIFICACAO_DESC ');
      AFDQ_Query.Sql.Add('  ,CASE U.ORIGEM_TIPO ');
      AFDQ_Query.Sql.Add('    WHEN 0 THEN ''END-POINT'' ');
      AFDQ_Query.Sql.Add('    WHEN 1 THEN ''APP'' ');
      AFDQ_Query.Sql.Add('    WHEN 2 THEN ''WEB'' ');
      AFDQ_Query.Sql.Add('  END ORIGEM_TIPO_DESC ');
      AFDQ_Query.Sql.Add('FROM USUARIO U ');
      AFDQ_Query.Sql.Add('WHERE NOT U.ID IS NULL ');
      if ACodigo > 0 then
        AFDQ_Query.Sql.Add('  AND U.ID = ' + ACodigo.ToString);
      if APIN <> '' then
        AFDQ_Query.Sql.Add('  AND U.PIN = ' + QuotedStr(APIN));
      if ANome <> '' then
        AFDQ_Query.Sql.Add('  AND U.NOME LIKE ' + QuotedStr('%'+ ANome + '%'));
      if AEmail <> '' then
        AFDQ_Query.Sql.Add('  AND U.EMAIL = ' + QuotedStr(AEmail));
      AFDQ_Query.Sql.Add('ORDER BY U.ID ');

      if ((APagina > 0) and (FPaginas > 0))  then
      begin
        FPagina := (((APagina - 1) * C_Paginas) + 1);
        FPaginas := (APagina * FPaginas);
        AFDQ_Query.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + C_Paginas.ToString);
      end;

      AFDQ_Query.Active := True;
      Result := AFDQ_Query.ToJSONArray;

      if not AFDQ_Query.IsEmpty then
      begin
        ID := AFDQ_Query.FieldByName('ID').AsInteger;
        NOME := AFDQ_Query.FieldByName('NOME').AsString;
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        TIPO := AFDQ_Query.FieldByName('TIPO').AsInteger;
        LOGIN := AFDQ_Query.FieldByName('LOGIN').AsString;
        SENHA := AFDQ_Query.FieldByName('SENHA').AsString;
        PIN := AFDQ_Query.FieldByName('PIN').AsString;
        if not AFDQ_Query.FieldByName('TOKEN').IsNull then
          TOKEN := AFDQ_Query.FieldByName('TOKEN').AsString;
        EMAIL := AFDQ_Query.FieldByName('EMAIL').AsString;
        if not AFDQ_Query.FieldByName('CELULAR').IsNull then
          CELULAR := AFDQ_Query.FieldByName('CELULAR').AsString;
        CLASSIFICACAO := AFDQ_Query.FieldByName('CLASSIFICACAO').AsInteger;
        if not AFDQ_Query.FieldByName('LOGRADOURO').IsNull then
          LOGRADOURO := AFDQ_Query.FieldByName('LOGRADOURO').AsString;
        if not AFDQ_Query.FieldByName('NUMERO').IsNull then
          NUMERO := AFDQ_Query.FieldByName('NUMERO').AsInteger;
        if not AFDQ_Query.FieldByName('COMPLEMENTO').IsNull then
          COMPLEMENTO := AFDQ_Query.FieldByName('COMPLEMENTO').AsString;
        if not AFDQ_Query.FieldByName('BAIRRO').IsNull then
          BAIRRO := AFDQ_Query.FieldByName('BAIRRO').AsString;
        if not AFDQ_Query.FieldByName('IBGE').IsNull then
          IBGE := AFDQ_Query.FieldByName('IBGE').AsInteger;
        if not AFDQ_Query.FieldByName('MUNICIPIO').IsNull then
          MUNICIPIO := AFDQ_Query.FieldByName('MUNICIPIO').AsString;
        if not AFDQ_Query.FieldByName('UF_SIGLA').IsNull then
          UF_SIGLA := AFDQ_Query.FieldByName('UF_SIGLA').AsString;
        if not AFDQ_Query.FieldByName('UF').IsNull then
          UF := AFDQ_Query.FieldByName('UF').AsString;
        if not AFDQ_Query.FieldByName('FOTO').IsNull then
          FOTO := AFDQ_Query.FieldByName('FOTO').AsString;
        if not AFDQ_Query.FieldByName('PUSH_NOTIFICATION').IsNull then
          PUSH_NOTIFICATION := AFDQ_Query.FieldByName('PUSH_NOTIFICATION').AsString;
        if not AFDQ_Query.FieldByName('ORIGEM_TIPO').IsNull then
          ORIGEM_TIPO := AFDQ_Query.FieldByName('ORIGEM_TIPO').AsInteger;
        if not AFDQ_Query.FieldByName('ORIGEM_DESCRICAO').IsNull then
          ORIGEM_DESCRICAO := AFDQ_Query.FieldByName('ORIGEM_DESCRICAO').AsString;
        if not AFDQ_Query.FieldByName('ORIGEM_CODIGO').IsNull then
          ORIGEM_CODIGO := AFDQ_Query.FieldByName('ORIGEM_CODIGO').AsInteger;
        if not AFDQ_Query.FieldByName('ID_FUNCIONARIO').IsNull then
          ID_FUNCIONARIO := AFDQ_Query.FieldByName('ID_FUNCIONARIO').AsInteger;
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

function TUsuario.Sequencial(const AFDQ_Query: TFDQuery): Integer;
begin
  try
    Result := 0;
    AFDQ_Query.Connection := FConexao;

    AFDQ_Query.Active := False;
    AFDQ_Query.Sql.Clear;
    AFDQ_Query.Sql.Add('SELECT ID FROM SP_GEN_USUARIO_ID;');
    AFDQ_Query.Active := True;
    if not AFDQ_Query.IsEmpty then
      Result := AFDQ_Query.FieldByName('ID').AsInteger;
  except
    On Ex:Exception do
      raise Exception.Create(Ex.Message);
  end;
end;

procedure TUsuario.SetBAIRRO(const Value: String);
begin
  FBAIRRO := Value;
end;

procedure TUsuario.SetCELULAR(const Value: String);
begin
  FCELULAR := Value;
end;

procedure TUsuario.SetCLASSIFICACAO(const Value: Integer);
begin
  FCLASSIFICACAO := Value;
end;

procedure TUsuario.SetCOMPLEMENTO(const Value: String);
begin
  FCOMPLEMENTO := Value;
end;

procedure TUsuario.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TUsuario.SetEMAIL(const Value: String);
begin
  FEMAIL := Value;
end;

procedure TUsuario.SetFOTO(const Value: String);
begin
  FFOTO := Value;
end;

procedure TUsuario.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TUsuario.SetIBGE(const Value: Integer);
begin
  FIBGE := Value;
end;

procedure TUsuario.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TUsuario.SetID_FUNCIONARIO(const Value: Integer);
begin
  FID_FUNCIONARIO := Value;
end;

procedure TUsuario.SetLOGIN(const Value: String);
begin
  FLOGIN := Value;
end;

procedure TUsuario.SetLOGRADOURO(const Value: String);
begin
  FLOGRADOURO := Value;
end;

procedure TUsuario.SetMUNICIPIO(const Value: String);
begin
  FMUNICIPIO := Value;
end;

procedure TUsuario.SetNOME(const Value: String);
begin
  FNOME := Value;
end;

procedure TUsuario.SetNUMERO(const Value: Integer);
begin
  FNUMERO := Value;
end;

procedure TUsuario.SetORIGEM_TIPO(const Value: Integer);
begin
  FORIGEM_TIPO := Value;
end;

procedure TUsuario.SetORIGEM_CODIGO(const Value: Integer);
begin
  FORIGEM_CODIGO := Value;
end;

procedure TUsuario.SetORIGEM_DESCRICAO(const Value: String);
begin
  FORIGEM_DESCRICAO := Value;
end;

procedure TUsuario.SetPIN(const Value: String);
begin
  FPIN := Value;
end;

procedure TUsuario.SetPUSH_NOTIFICATION(const Value: String);
begin
  FPUSH_NOTIFICATION := Value;
end;

procedure TUsuario.SetSENHA(const Value: String);
begin
  FSENHA := Value;
end;

procedure TUsuario.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TUsuario.SetTIPO(const Value: Integer);
begin
  FTIPO := Value;
end;

procedure TUsuario.SetTOKEN(const Value: String);
begin
  FTOKEN := Value;
end;

procedure TUsuario.SetUF(const Value: String);
begin
  FUF := Value;
end;

procedure TUsuario.SetUF_SIGLA(const Value: String);
begin
  FUF_SIGLA := Value;
end;


function TUsuario.ValidaLogin(
      const AFDQ_Query:TFDQuery;
      const AUsuario:String;
      const ASenha:String;
      const APin:String): TJsonObject;
begin
  try
    AFDQ_Query.Connection := FConexao;
    AFDQ_Query.Active := False;
    AFDQ_Query.SQL.Clear;
    AFDQ_Query.Sql.Add('SELECT ');
    AFDQ_Query.Sql.Add('  U.* ');
    AFDQ_Query.Sql.Add('FROM USUARIO U ');
    AFDQ_Query.Sql.Add('WHERE NOT U.ID IS NULL ');
    if APin <> '' then
      AFDQ_Query.Sql.Add('  AND U.PIN = ' + QuotedStr(APin))
    else
    begin
      AFDQ_Query.Sql.Add('  AND U.LOGIN = ' + QuotedStr(AUsuario));
      AFDQ_Query.Sql.Add('  AND U.SENHA = ' + QuotedStr(ASenha));
    end;
    AFDQ_Query.Active := True;

    Result := AFDQ_Query.ToJSONObject;
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

{ TUsuario_Permissoes }
procedure TUsuario_Permissoes.Atualizar(const AFDQ_Query: TFDQuery);
begin
  try
    AFDQ_Query.Connection := FConexao;

    AFDQ_Query.Active := False;
    AFDQ_Query.SQL.Clear;
    AFDQ_Query.Sql.Add('UPDATE USUARIO_PERMISSOES SET ');
    AFDQ_Query.Sql.Add('  OBJETO = OBJETO ');
    if Trim(FOBJETO) <> '' then
      AFDQ_Query.Sql.Add('  ,OBJETO = :OBJETO ');
    if Trim(FVISUALIZAR_PER) <> '' then
      AFDQ_Query.Sql.Add('  ,VISUALIZAR_PER = :VISUALIZAR_PER ');
    if Trim(FINCLUIR_PER) <> '' then
      AFDQ_Query.Sql.Add('  ,INCLUIR_PER = :INCLUIR_PER ');
    if Trim(FALTERAR_PER) <> '' then
      AFDQ_Query.Sql.Add('  ,ALTERAR_PER = :ALTERAR_PER ');
    if Trim(FEXCLUIR_PER) <> '' then
      AFDQ_Query.Sql.Add('  ,EXCLUIR_PER = :EXCLUIR_PER ');
    AFDQ_Query.Sql.Add('WHERE ID_USUARIO = :ID_USUARIO ');
    AFDQ_Query.Sql.Add('  AND ID = :ID; ');
    AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
    AFDQ_Query.ParamByName('ID').AsInteger := FID;
    if Trim(FOBJETO) <> '' then
      AFDQ_Query.ParamByName('OBJETO').AsString := FOBJETO;
    if Trim(FVISUALIZAR_PER) <> '' then
      AFDQ_Query.ParamByName('VISUALIZAR_PER').AsString := FVISUALIZAR_PER;
    if Trim(FINCLUIR_PER) <> '' then
      AFDQ_Query.ParamByName('INCLUIR_PER').AsString := FINCLUIR_PER;
    if Trim(FALTERAR_PER) <> '' then
      AFDQ_Query.ParamByName('ALTERAR_PER').AsString := FALTERAR_PER;
    if Trim(FEXCLUIR_PER) <> '' then
      AFDQ_Query.ParamByName('EXCLUIR_PER').AsString := FEXCLUIR_PER;
    AFDQ_Query.ExecSQL;

  except on E: Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TUsuario_Permissoes.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

constructor TUsuario_Permissoes.Create(AConnexao: TFDConnection);
begin
  FConexao := AConnexao;
end;

procedure TUsuario_Permissoes.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery);
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
            if Trigger_Existe(FConexao,AFDQuery,'USUARIO_PERMISSOES_BI') then
              Add('DROP TRIGGER USUARIO_PERMISSOES_BI;');
            if Tabela_Existe(FConexao,AFDQuery,'USUARIO_PERMISSOES') then
              Add('DROP TABLE USUARIO_PERMISSOES;');
            if Indice_Existe(FConexao,AFDQuery,'PER_USUARIO_OBJETO_IDX') then
               Add('DROP INDEX PER_USUARIO_OBJETO_IDX;');
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
      lScript.Add('CREATE TABLE USUARIO_PERMISSOES ( ');
      lScript.Add('  ID_USUARIO INTEGER NOT NULL, ');
      lScript.Add('  ID INTEGER NOT NULL, ');
      lScript.Add('  OBJETO VARCHAR(100) NOT NULL, ');
      lScript.Add('  VISUALIZAR_PER VARCHAR(1) NOT NULL, ');
      lScript.Add('  INCLUIR_PER VARCHAR(1) NOT NULL, ');
      lScript.Add('  ALTERAR_PER VARCHAR(1) NOT NULL, ');
      lScript.Add('  EXCLUIR_PER VARCHAR(1) NOT NULL, ');
      lScript.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE NOT NULL, ');
      lScript.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME NOT NULL); ');
      AFDScript.ExecuteScript(lScript);

      //Criando Chave primaria...
      with AFDScript do
      begin
        SQLScripts.Clear;
        SQLScripts.Add;
        with SQLScripts[0].SQL do
        begin
          Add('ALTER TABLE USUARIO_PERMISSOES ADD CONSTRAINT PK_USUARIO_PERMISSOES PRIMARY KEY (ID_USUARIO,ID);');
          Add('ALTER TABLE USUARIO_PERMISSOES ADD CONSTRAINT FK_USUARIO_PERMISSOES_1 FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID) ON DELETE CASCADE;');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.ID_USUARIO IS ''Código do usuário'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.ID IS ''Sequencial'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.OBJETO IS ''Nome do Formulário/Tela/Tabela'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.VISUALIZAR_PER IS ''Permite visualizar a tela e os registros - S-Sim, N-Não'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.INCLUIR_PER IS ''Permite incluir registros - S-Sim, N-Não'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.ALTERAR_PER IS ''Permite alterar registros - S-Sim, N-Não'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.EXCLUIR_PER IS ''Permite excluir registros - S-Sim, N-Não'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.DT_CADASTRO IS ''Data do cadastro'';');
          Add('COMMENT ON COLUMN USUARIO_PERMISSOES.HR_CADASTRO IS ''Hora do cadastro'';');
          Add('CREATE INDEX PER_USUARIO_OBJETO_IDX ON USUARIO_PERMISSOES (OBJETO); ');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      //Criando Trigger...
      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER USUARIO_PERMISSOES_BI FOR USUARIO_PERMISSOES ');
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      lScript.Add('AS ');
      lScript.Add('BEGIN ');
      lScript.Add('  IF (NEW.ID IS NULL) THEN ');
      lScript.Add('    SELECT (COALESCE(MAX(ID),0) + 1) FROM USUARIO_PERMISSOES WHERE ID_USUARIO = NEW.ID_USUARIO INTO NEW.ID; ');
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

destructor TUsuario_Permissoes.Destroy;
begin

  inherited;
end;

procedure TUsuario_Permissoes.Excluir(const AFDQ_Query: TFDQuery);
begin
  try
    AFDQ_Query.Connection := FConexao;

    AFDQ_Query.Active := False;
    AFDQ_Query.SQL.Clear;
    AFDQ_Query.Sql.Add('DELETE FROM USUARIO_PERMISSOES ');
    AFDQ_Query.Sql.Add('WHERE ID_USUARIO = :ID_USUARIO ');
    AFDQ_Query.Sql.Add('  AND ID = :ID; ');
    AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
    AFDQ_Query.ParamByName('ID').AsInteger := FID;
    AFDQ_Query.ExecSQL;

  except on E: Exception do
    raise Exception.Create(e.Message);
  end;
end;

procedure TUsuario_Permissoes.Inicia_Propriedades;
begin
  ID_USUARIO := -1;
  ID := -1;
  OBJETO := '';
  VISUALIZAR_PER := '';
  INCLUIR_PER := '';
  ALTERAR_PER := '';
  EXCLUIR_PER := '';
  DT_CADASTRO := Date;
  HR_CADASTRO := Time;
end;

procedure TUsuario_Permissoes.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    AFDQ_Query.Connection := FConexao;

    if FID_USUARIO = 0 then
      raise Exception.Create('Código do usuário não informado');
    if Trim(FOBJETO) = '' then
      raise Exception.Create('Descrição do objeto não informado');

    AFDQ_Query.Active := False;
    AFDQ_Query.Sql.Clear;
    AFDQ_Query.Sql.Add('INSERT INTO USUARIO_PERMISSOES( ');
    AFDQ_Query.Sql.Add('  ID_USUARIO ');
    AFDQ_Query.Sql.Add('  ,OBJETO ');
    AFDQ_Query.Sql.Add('  ,VISUALIZAR_PER ');
    AFDQ_Query.Sql.Add('  ,INCLUIR_PER ');
    AFDQ_Query.Sql.Add('  ,ALTERAR_PER ');
    AFDQ_Query.Sql.Add('  ,EXCLUIR_PER ');
    AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
    AFDQ_Query.Sql.Add('  ,HR_CADASTRO ');
    AFDQ_Query.Sql.Add(') VALUES( ');
    AFDQ_Query.Sql.Add('  :ID_USUARIO ');
    AFDQ_Query.Sql.Add('  ,:OBJETO ');
    AFDQ_Query.Sql.Add('  ,:VISUALIZAR_PER ');
    AFDQ_Query.Sql.Add('  ,:INCLUIR_PER ');
    AFDQ_Query.Sql.Add('  ,:ALTERAR_PER ');
    AFDQ_Query.Sql.Add('  ,:EXCLUIR_PER ');
    AFDQ_Query.Sql.Add('  ,:DT_CADASTRO ');
    AFDQ_Query.Sql.Add('  ,:HR_CADASTRO ');
    AFDQ_Query.Sql.Add('); ');
    AFDQ_Query.ParamByName('ID_USUARIO').AsInteger := FID_USUARIO;
    AFDQ_Query.ParamByName('OBJETO').AsString := FOBJETO;
    AFDQ_Query.ParamByName('VISUALIZAR_PER').AsString := FVISUALIZAR_PER;
    AFDQ_Query.ParamByName('INCLUIR_PER').AsString := FINCLUIR_PER;
    AFDQ_Query.ParamByName('ALTERAR_PER').AsString := FALTERAR_PER;
    AFDQ_Query.ParamByName('EXCLUIR_PER').AsString := FEXCLUIR_PER;
    AFDQ_Query.ParamByName('DT_CADASTRO').AsDate := FDT_CADASTRO;
    AFDQ_Query.ParamByName('HR_CADASTRO').AsTime := FHR_CADASTRO;
    AFDQ_Query.ExecSQL;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TUsuario_Permissoes.Listar(
      const AFDQ_Query:TFDQuery;
      const AUsuario:Integer=0;
      const AObjeto:String='';
      const APagina:Integer=0): TJSONArray;
begin
  try
    AFDQ_Query.Connection := FConexao;

    Inicia_Propriedades;

    AFDQ_Query.Active := False;
    AFDQ_Query.Sql.Clear;
    AFDQ_Query.Sql.Add('SELECT * FROM USUARIO_PERMISSOES UP ');
    AFDQ_Query.Sql.Add('WHERE NOT UP.ID IS NULL ');
    if AUsuario > 0 then
      AFDQ_Query.Sql.Add('  AND UP.ID_USUARIO = ' + AUsuario.ToString);
    if Trim(AObjeto) <> '' then
      AFDQ_Query.Sql.Add('  AND UP.OBJETO = ' + AObjeto);
    AFDQ_Query.Active := True;
    Result := AFDQ_Query.ToJSONArray;

    if not AFDQ_Query.IsEmpty then
    begin
      ID_USUARIO := AFDQ_Query.FieldByName('ID_USUARIO').AsInteger;
      ID := AFDQ_Query.FieldByName('ID').AsInteger;
      OBJETO := AFDQ_Query.FieldByName('OBJETO').AsString;
      VISUALIZAR_PER := AFDQ_Query.FieldByName('VISUALIZAR_PER').AsString;
      INCLUIR_PER := AFDQ_Query.FieldByName('INCLUIR_PER').AsString;
      ALTERAR_PER := AFDQ_Query.FieldByName('ALTERAR_PER').AsString;
      EXCLUIR_PER := AFDQ_Query.FieldByName('EXCLUIR_PER').AsString;
      DT_CADASTRO := AFDQ_Query.FieldByName('DT_CADASTRO').AsDateTime;
      HR_CADASTRO := AFDQ_Query.FieldByName('HR_CADASTRO').AsDateTime;
    end;
  except
    On Ex:Exception do
      raise Exception.Create(Ex.Message);
  end;
end;

procedure TUsuario_Permissoes.SetALTERAR_PER(const Value: String);
begin
  FALTERAR_PER := Value;
end;

procedure TUsuario_Permissoes.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TUsuario_Permissoes.SetEXCLUIR_PER(const Value: String);
begin
  FEXCLUIR_PER := Value;
end;

procedure TUsuario_Permissoes.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TUsuario_Permissoes.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TUsuario_Permissoes.SetID_USUARIO(const Value: Integer);
begin
  FID_USUARIO := Value;
end;

procedure TUsuario_Permissoes.SetINCLUIR_PER(const Value: String);
begin
  FINCLUIR_PER := Value;
end;

procedure TUsuario_Permissoes.SetOBJETO(const Value: String);
begin
  FOBJETO := Value;
end;

procedure TUsuario_Permissoes.SetVISUALIZAR_PER(const Value: String);
begin
  FVISUALIZAR_PER := Value;
end;

end.
