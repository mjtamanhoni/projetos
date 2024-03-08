unit uModel.Cliente;

interface

uses
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,

  {$IFDEF MSWINDOWS}
    FireDAC.VCLUI.Wait,
  {$ENDIF}

  FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,

  DataSet.Serialize, DataSet.Serialize.Config,

  System.SysUtils, System.Classes,System.JSON;

  function Campo_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela, ACampos: String): Boolean;
  function Tabela_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela: String): Boolean;

const
  C_Paginas = 30;

type
  TCLIENTE = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;
    FHR_CADASTRO: String;
    FBAIRRO: String;
    FUF: String;
    FCEP: String;
    FID: Integer;
    FSTATUS: Integer;
    FCOMPLEMENTO: String;
    FDT_CADASTRO: String;
    FNOME: String;
    FCIDADE: String;
    FENDERECO: String;
    FCELULAR: String;
    FEMAIL: String;
    procedure SetBAIRRO(const Value: String);
    procedure SetCELULAR(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCIDADE(const Value: String);
    procedure SetCOMPLEMENTO(const Value: String);
    procedure SetDT_CADASTRO(const Value: String);
    procedure SetENDERECO(const Value: String);
    procedure SetHR_CADASTRO(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetNOME(const Value: String);
    procedure SetSTATUS(const Value: Integer);
    procedure SetUF(const Value: String);
    procedure SetEMAIL(const Value: String);


  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery; AManterDados:Boolean=False);
    procedure Inicia_Propriedades;
    function Inserir(const AFDQ_Query:TFDQuery):Integer;
    function Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
    procedure Marcar_Como_Sincronizado(const AFDQ_Query:TFDQuery; const AUsuario:Integer=0);

    property ID :Integer read FID write SetID;
    property NOME :String read FNOME write SetNOME;
    property STATUS :Integer read FSTATUS write SetSTATUS;
    property CELULAR :String read FCELULAR write SetCELULAR;
    property EMAIL :String read FEMAIL write SetEMAIL;
    property CEP :String read FCEP write SetCEP;
    property ENDERECO :String read FENDERECO write SetENDERECO;
    property COMPLEMENTO :String read FCOMPLEMENTO write SetCOMPLEMENTO;
    property BAIRRO :String read FBAIRRO write SetBAIRRO;
    property CIDADE :String read FCIDADE write SetCIDADE;
    property UF :String read FUF write SetUF;
    property DT_CADASTRO :String read FDT_CADASTRO write SetDT_CADASTRO;
    property HR_CADASTRO :String read FHR_CADASTRO write SetHR_CADASTRO;

  end;

implementation

function Campo_Existe(const AConexao:TFDConnection; const AFDQ_Query:TFDQuery; const ATabela, ACampos: String): Boolean;
begin
  try
    AFDQ_Query.Connection := AConexao;
    AFDQ_Query.Active := False;
    AFDQ_Query.Sql.Clear;
    AFDQ_Query.Sql.Add('SELECT ');
    AFDQ_Query.Sql.Add('    A.* ');
    AFDQ_Query.Sql.Add('FROM pragma_table_info('+QuotedStr(ATabela)+') A ');
    AFDQ_Query.Sql.Add('WHERE A.name = ' + QuotedStr(ACampos) );
    //AFDQ_Query.Sql.Add('ORDER BY A.cid; ');
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
    AFDQ_Query.Sql.Add('SELECT * FROM SQLITE_MASTER WHERE TYPE = ''table'' AND NAME = ' + QuotedStr(Trim(ATabela)));
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

{ TCLIENTE }

procedure TCLIENTE.Atualizar(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TCLIENTE.Atualizar_Estrutura(const AFDQ_Query: TFDQuery; AManterDados: Boolean);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := FConexao;

      if Tabela_Existe(FConexao,AFDQ_Query,'CLIENTE') then
      begin
        if AManterDados then
        begin
           if Tabela_Existe(FConexao,AFDQ_Query,'CLIENTE_TMP') then
           begin
              //Excluindo tabela...
              AFDQ_Query.Active := False;
              AFDQ_Query.Sql.Clear;
              AFDQ_Query.Sql.Add('DROP TABLE CLIENTE_TMP;');
              AFDQ_Query.ExecSQL;
           end;
           //Criando tabela temporária....
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('CREATE TABLE CLIENTE_TMP ( ');
           AFDQ_Query.Sql.Add('	ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
           AFDQ_Query.Sql.Add('	NOME VARCHAR(255), ');
           AFDQ_Query.Sql.Add('	STATUS INTEGER DEFAULT 1, ');
           AFDQ_Query.Sql.Add('	CELULAR VARCHAR(20), ');
           AFDQ_Query.Sql.Add('	EMAIL VARCHAR(255), ');
           AFDQ_Query.Sql.Add('	CEP VARCHAR(10), ');
           AFDQ_Query.Sql.Add('	ENDERECO VARCHAR(255), ');
           AFDQ_Query.Sql.Add('	COMPLEMENTO VARCHAR(255), ');
           AFDQ_Query.Sql.Add('	BAIRRO VARCHAR(100), ');
           AFDQ_Query.Sql.Add('	CIDADE VARCHAR(100), ');
           AFDQ_Query.Sql.Add('	UF VARCHAR(2), ');
           AFDQ_Query.Sql.Add(' SINCRONIZADO INTEGER, ');
           AFDQ_Query.Sql.Add('	DT_CADASTRO DATE DEFAULT CURRENT_DATE, ');
           AFDQ_Query.Sql.Add('	HR_CADASTRO TIME DEFAULT CURRENT_TIME); ');
           AFDQ_Query.ExecSQL;

           //Replicando dados...
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('INSERT INTO CLIENTE_TMP( ');
           AFDQ_Query.Sql.Add('  ID ');
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
           AFDQ_Query.Sql.Add('  ,HR_CADASTRO) ');
           AFDQ_Query.Sql.Add('SELECT ');
           AFDQ_Query.Sql.Add('  ID ');
           AFDQ_Query.Sql.Add('  ,NOME ');
           AFDQ_Query.Sql.Add('  ,STATUS ');
           AFDQ_Query.Sql.Add('  ,CELULAR ');
           if Campo_Existe(FConexao,lQuery,'CLIENTE','EMAIL') then
             AFDQ_Query.Sql.Add('  ,EMAIL ')
           else
             AFDQ_Query.Sql.Add('  ,'''' AS EMAIL ');
           AFDQ_Query.Sql.Add('  ,CEP ');
           AFDQ_Query.Sql.Add('  ,ENDERECO ');
           AFDQ_Query.Sql.Add('  ,COMPLEMENTO ');
           AFDQ_Query.Sql.Add('  ,BAIRRO ');
           AFDQ_Query.Sql.Add('  ,CIDADE ');
           AFDQ_Query.Sql.Add('  ,UF ');
           AFDQ_Query.Sql.Add('  ,SINCRONIZADO ');
           AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
           AFDQ_Query.Sql.Add('  ,HR_CADASTRO ');
           AFDQ_Query.Sql.Add('FROM CLIENTE ');
           AFDQ_Query.Sql.Add('ORDER BY ID; ');
           AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE CLIENTE;');
        AFDQ_Query.ExecSQL;
      end;

      //Recriando a estrutura...
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('CREATE TABLE CLIENTE ( ');
      AFDQ_Query.Sql.Add('  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
      AFDQ_Query.Sql.Add('  NOME VARCHAR(255), ');
      AFDQ_Query.Sql.Add('  STATUS INTEGER DEFAULT 1, ');
      AFDQ_Query.Sql.Add('  CELULAR VARCHAR(20), ');
      AFDQ_Query.Sql.Add('  EMAIL VARCHAR(255), ');
      AFDQ_Query.Sql.Add('  CEP VARCHAR(10), ');
      AFDQ_Query.Sql.Add('  ENDERECO VARCHAR(255), ');
      AFDQ_Query.Sql.Add('  COMPLEMENTO VARCHAR(255), ');
      AFDQ_Query.Sql.Add('  BAIRRO VARCHAR(100), ');
      AFDQ_Query.Sql.Add('  CIDADE VARCHAR(100), ');
      AFDQ_Query.Sql.Add('  UF VARCHAR(2), ');
      AFDQ_Query.Sql.Add('  SINCRONIZADO INTEGER, ');
      AFDQ_Query.Sql.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE, ');
      AFDQ_Query.Sql.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ExecSQL;

      if Tabela_Existe(FConexao,AFDQ_Query,'CLIENTE_TMP') then
      begin
        //Retornando dados para a tabela original
        if AManterDados then
        begin
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('INSERT INTO CLIENTE( ');
          AFDQ_Query.Sql.Add('  ID ');
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
          AFDQ_Query.Sql.Add('  ,HR_CADASTRO) ');
          AFDQ_Query.Sql.Add('SELECT ');
          AFDQ_Query.Sql.Add('  ID ');
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
          AFDQ_Query.Sql.Add('FROM CLIENTE_TMP ');
          AFDQ_Query.Sql.Add('ORDER BY ID; ');
          AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE CLIENTE_TMP;');
        AFDQ_Query.ExecSQL;
      end;
    except on E: Exception do
      raise Exception.Create('Cliente. ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

constructor TCLIENTE.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

destructor TCLIENTE.Destroy;
begin

  inherited;
end;

procedure TCLIENTE.Excluir(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TCLIENTE.Inicia_Propriedades;
begin

end;

function TCLIENTE.Inserir(const AFDQ_Query: TFDQuery): Integer;
begin

end;

function TCLIENTE.Listar(const AFDQ_Query: TFDQuery; AID, APagina: Integer): TJSONArray;
begin

end;

procedure TCLIENTE.Marcar_Como_Sincronizado(const AFDQ_Query: TFDQuery; const AUsuario: Integer);
begin

end;

procedure TCLIENTE.SetBAIRRO(const Value: String);
begin
  FBAIRRO := Value;
end;

procedure TCLIENTE.SetCELULAR(const Value: String);
begin
  FCELULAR := Value;
end;

procedure TCLIENTE.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TCLIENTE.SetCIDADE(const Value: String);
begin
  FCIDADE := Value;
end;

procedure TCLIENTE.SetCOMPLEMENTO(const Value: String);
begin
  FCOMPLEMENTO := Value;
end;

procedure TCLIENTE.SetDT_CADASTRO(const Value: String);
begin
  FDT_CADASTRO := Value;
end;

procedure TCLIENTE.SetEMAIL(const Value: String);
begin
  FEMAIL := Value;
end;

procedure TCLIENTE.SetENDERECO(const Value: String);
begin
  FENDERECO := Value;
end;

procedure TCLIENTE.SetHR_CADASTRO(const Value: String);
begin
  FHR_CADASTRO := Value;
end;

procedure TCLIENTE.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCLIENTE.SetNOME(const Value: String);
begin
  FNOME := Value;
end;

procedure TCLIENTE.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TCLIENTE.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
