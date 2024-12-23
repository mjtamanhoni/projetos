unit uModel.EMPRESA;

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
  TEMPRESA = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;
    FHR_CADASTRO: TTime;
    FBAIRRO: String;
    FEMAIL: String;
    FUF: String;
    FSINCRONIZADO: Integer;
    FCEP: String;
    FID: Integer;
    FSTATUS: Integer;
    FCOMPLEMENTO: String;
    FDT_CADASTRO: TDate;
    FNOME: String;
    FCIDADE: String;
    FENDERECO: String;
    FCELULAR: String;
    procedure SetBAIRRO(const Value: String);
    procedure SetCELULAR(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCIDADE(const Value: String);
    procedure SetCOMPLEMENTO(const Value: String);
    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetEMAIL(const Value: String);
    procedure SetENDERECO(const Value: String);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetID(const Value: Integer);
    procedure SetNOME(const Value: String);
    procedure SetSINCRONIZADO(const Value: Integer);
    procedure SetSTATUS(const Value: Integer);
    procedure SetUF(const Value: String);

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
    property STATUS:Integer read FSTATUS write SetSTATUS;
    property CELULAR:String read FCELULAR write SetCELULAR;
    property EMAIL:String read FEMAIL write SetEMAIL;
    property CEP:String read FCEP write SetCEP;
    property ENDERECO:String read FENDERECO write SetENDERECO;
    property COMPLEMENTO:String read FCOMPLEMENTO write SetCOMPLEMENTO;
    property BAIRRO:String read FBAIRRO write SetBAIRRO;
    property CIDADE:String read FCIDADE write SetCIDADE;
    property UF:String read FUF write SetUF;
    property SINCRONIZADO:Integer read FSINCRONIZADO write SetSINCRONIZADO;
    property DT_CADASTRO:TDate read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO:TTime read FHR_CADASTRO write SetHR_CADASTRO;

  end;

implementation

{ TCLIENTE }

procedure TEMPRESA.Atualizar(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TEMPRESA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery);
begin

end;

constructor TEMPRESA.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

procedure TEMPRESA.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery);
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
            //Excluindo objetos da tabela CLIENTE...

            if Trigger_Existe(FConexao,AFDQuery,'EMPRESA_BI') then
              Add('DROP TRIGGER EMPRESA_BI;');

            if Generator_Existe(FConexao,AFDQuery,'GEN_EMPRESA_ID') then
              Add('DROP GENERATOR GEN_EMPRESA_ID;');

            if Tabela_Existe(FConexao,AFDQuery,'EMPRESA') then
              Add('DROP TABLE EMPRESA;');

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
      lScript.Add('CREATE TABLE EMPRESA ( ');
      lScript.Add('  ID INTEGER NOT NULL, ');
      lScript.Add('  NOME VARCHAR(255), ');
      lScript.Add('  STATUS INTEGER DEFAULT 1, ');
      lScript.Add('  CELULAR VARCHAR(20), ');
      lScript.Add('  EMAIL VARCHAR(255), ');
      lScript.Add('  CEP VARCHAR(10), ');
      lScript.Add('  ENDERECO VARCHAR(255), ');
      lScript.Add('  COMPLEMENTO VARCHAR(255), ');
      lScript.Add('  BAIRRO VARCHAR(100), ');
      lScript.Add('  CIDADE VARCHAR(100), ');
      lScript.Add('  UF VARCHAR(2), ');
      lScript.Add('  SINCRONIZADO INTEGER, ');
      lScript.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE, ');
      lScript.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME, ');
      lScript.Add('  CONSTRAINT PK_EMPRESA PRIMARY KEY (ID) ');
      lScript.Add('); ');
      AFDScript.ExecuteScript(lScript);

      //Criando Chave primaria, estrangeira, generators e comentários...
      with AFDScript do
      begin
        SQLScripts.Clear;
        SQLScripts.Add;
        with SQLScripts[0].SQL do
        begin
          Add('COMMENT ON COLUMN EMPRESA.ID IS ''ID'';');
          Add('COMMENT ON COLUMN EMPRESA.NOME IS ''NOME'';');
          Add('COMMENT ON COLUMN EMPRESA.STATUS IS ''0-INATIVO, 1-ATIVO'';');
          Add('COMMENT ON COLUMN EMPRESA.CELULAR IS ''CELULAR'';');
          Add('COMMENT ON COLUMN EMPRESA.EMAIL IS ''EMAIL'';');
          Add('COMMENT ON COLUMN EMPRESA.CEP IS ''CEP'';');
          Add('COMMENT ON COLUMN EMPRESA.ENDERECO IS ''ENDERECO'';');
          Add('COMMENT ON COLUMN EMPRESA.COMPLEMENTO IS ''COMPLEMENTO DO ENDERECO'';');
          Add('COMMENT ON COLUMN EMPRESA.BAIRRO IS ''BAIRRO'';');
          Add('COMMENT ON COLUMN EMPRESA.CIDADE IS ''CIDADE'';');
          Add('COMMENT ON COLUMN EMPRESA.UF IS ''UNIDADE FEDERATIVA'';');
          Add('COMMENT ON COLUMN EMPRESA.SINCRONIZADO IS ''0-NAO, 1-SIM'';');
          Add('COMMENT ON COLUMN EMPRESA.DT_CADASTRO IS ''DATA DO CADASTRO'';');
          Add('COMMENT ON COLUMN EMPRESA.HR_CADASTRO IS ''HORA DO CADASTRO'';');
          Add('');
          Add('');
          Add('CREATE SEQUENCE GEN_EMPRESA_ID');
          ValidateAll;
          ExecuteAll;
        end;
      end;

      lScript.Clear;
      lScript.Add('SET TERM ^ ; ');
      lScript.Add('CREATE OR ALTER TRIGGER EMPRESA_BI FOR EMPRESA ');
      lScript.Add('ACTIVE BEFORE INSERT POSITION 0');
      lScript.Add('AS');
      lScript.Add('BEGIN');
      lScript.Add('  IF (NEW.ID IS NULL) THEN');
      lScript.Add('    NEW.ID = GEN_ID(GEN_EMPRESA_ID,1);');
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

destructor TEMPRESA.Destroy;
begin

  inherited;
end;

procedure TEMPRESA.Excluir(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TEMPRESA.Inicia_Propriedades;
begin
  ID := 0;
  NOME := '';
  STATUS := 1;
  CELULAR := '';
  EMAIL := '';
  CEP := '';
  ENDERECO := '';
  COMPLEMENTO := '';
  BAIRRO := '';
  CIDADE := '';
  UF := '';
  SINCRONIZADO := 0;
  DT_CADASTRO := 0;
  HR_CADASTRO := 0;
end;

procedure TEMPRESA.Inserir(const AFDQ_Query: TFDQuery);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      if FNOME = '' then
        raise Exception.Create('NOME: NOME não informado');
        raise Exception.Create('PESSOA: 0-FISICA, 1-JURIDICA não informado');
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO EMPRESA( ');
      //AFDQ_Query.Sql.Add('  ID ');
      AFDQ_Query.Sql.Add('  ,NOME ');
      AFDQ_Query.Sql.Add('  ,STATUS ');
      AFDQ_Query.Sql.Add('  ,CELULAR ');
      AFDQ_Query.Sql.Add('  ,EMAIL ');
      AFDQ_Query.Sql.Add('  ,CEP ');
      AFDQ_Query.Sql.Add('  ,ENDERECO ');
      AFDQ_Query.Sql.Add('  ,COMPLEMENTO ');
      AFDQ_Query.Sql.Add('  ,BAIRRO ');
      AFDQ_Query.Sql.Add('  ,CIDADE ');
      AFDQ_Query.Sql.Add('  ,UF ');
      AFDQ_Query.Sql.Add('  ,SINCRONIZADO ');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO ');
      AFDQ_Query.Sql.Add(') VALUES( ');
      //AFDQ_Query.Sql.Add('  :ID ');
      AFDQ_Query.Sql.Add('  ,:NOME ');
      AFDQ_Query.Sql.Add('  ,:STATUS ');
      AFDQ_Query.Sql.Add('  ,:CELULAR ');
      AFDQ_Query.Sql.Add('  ,:EMAIL ');
      AFDQ_Query.Sql.Add('  ,:CEP ');
      AFDQ_Query.Sql.Add('  ,:ENDERECO ');
      AFDQ_Query.Sql.Add('  ,:COMPLEMENTO ');
      AFDQ_Query.Sql.Add('  ,:BAIRRO ');
      AFDQ_Query.Sql.Add('  ,:CIDADE ');
      AFDQ_Query.Sql.Add('  ,:UF ');
      AFDQ_Query.Sql.Add('  ,:SINCRONIZADO ');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO ');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO ');
      AFDQ_Query.Sql.Add('); ');
      //AFDQ_Query.ParamByName('ID').AsInteger := FID;
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('STATUS').AsInteger := FSTATUS;
      AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
      AFDQ_Query.ParamByName('CEP').AsString := FCEP;
      AFDQ_Query.ParamByName('ENDERECO').AsString := FENDERECO;
      AFDQ_Query.ParamByName('COMPLEMENTO').AsString := FCOMPLEMENTO;
      AFDQ_Query.ParamByName('BAIRRO').AsString := FBAIRRO;
      AFDQ_Query.ParamByName('CIDADE').AsString := FCIDADE;
      AFDQ_Query.ParamByName('UF').AsString := FUF;
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

function TEMPRESA.Listar(const AFDQ_Query: TFDQuery; AID, APagina: Integer): TJSONArray;
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT * FROM EMPRESA') ;
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
        STATUS := AFDQ_Query.FieldByName('STATUS').AsInteger;
        CELULAR := AFDQ_Query.FieldByName('CELULAR').AsString;
        EMAIL := AFDQ_Query.FieldByName('EMAIL').AsString;
        CEP := AFDQ_Query.FieldByName('CEP').AsString;
        ENDERECO := AFDQ_Query.FieldByName('ENDERECO').AsString;
        COMPLEMENTO := AFDQ_Query.FieldByName('COMPLEMENTO').AsString;
        BAIRRO := AFDQ_Query.FieldByName('BAIRRO').AsString;
        CIDADE := AFDQ_Query.FieldByName('CIDADE').AsString;
        UF := AFDQ_Query.FieldByName('UF').AsString;
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

procedure TEMPRESA.SetBAIRRO(const Value: String);
begin
  FBAIRRO := Value;
end;

procedure TEMPRESA.SetCELULAR(const Value: String);
begin
  FCELULAR := Value;
end;

procedure TEMPRESA.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TEMPRESA.SetCIDADE(const Value: String);
begin
  FCIDADE := Value;
end;

procedure TEMPRESA.SetCOMPLEMENTO(const Value: String);
begin
  FCOMPLEMENTO := Value;
end;

procedure TEMPRESA.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TEMPRESA.SetEMAIL(const Value: String);
begin
  FEMAIL := Value;
end;

procedure TEMPRESA.SetENDERECO(const Value: String);
begin
  FENDERECO := Value;
end;

procedure TEMPRESA.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TEMPRESA.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TEMPRESA.SetNOME(const Value: String);
begin
  FNOME := Value;
end;

procedure TEMPRESA.SetSINCRONIZADO(const Value: Integer);
begin
  FSINCRONIZADO := Value;
end;

procedure TEMPRESA.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TEMPRESA.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
