unit uModel.Empresa;

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
  TEMPRESA = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;
    FHR_CADASTRO: TTime;
    FBAIRRO: String;
    FUF: String;
    FCEP: String;
    FID: Integer;
    FSTATUS: Integer;
    FCOMPLEMENTO: String;
    FDT_CADASTRO: TDate;
    FNOME: String;
    FCIDADE: String;
    FENDERECO: String;
    FCELULAR: String;
    FSINCRONIZADO: Integer;
    FEMAIL: String;

    procedure SetBAIRRO(const Value: String);
    procedure SetCELULAR(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCIDADE(const Value: String);
    procedure SetCOMPLEMENTO(const Value: String);
    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetENDERECO(const Value: String);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetID(const Value: Integer);
    procedure SetNOME(const Value: String);
    procedure SetSTATUS(const Value: Integer);
    procedure SetUF(const Value: String);
    procedure SetSINCRONIZADO(const Value: Integer);
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
    property SINCRONIZADO :Integer read FSINCRONIZADO write SetSINCRONIZADO;
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
    AFDQ_Query.Sql.Add('  A.* ');
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

{ TEMPRESA }

procedure TEMPRESA.Atualizar(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TEMPRESA.Atualizar_Estrutura(const AFDQ_Query: TFDQuery; AManterDados: Boolean);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := FConexao;

      if Tabela_Existe(FConexao,AFDQ_Query,'EMPRESA') then
      begin
        if AManterDados then
        begin
           if Tabela_Existe(FConexao,AFDQ_Query,'EMPRESA_TMP') then
           begin
              //Excluindo tabela...
              AFDQ_Query.Active := False;
              AFDQ_Query.Sql.Clear;
              AFDQ_Query.Sql.Add('DROP TABLE EMPRESA_TMP;');
              AFDQ_Query.ExecSQL;
           end;

           //Criando tabela temporária....
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('CREATE TABLE EMPRESA_TMP ( ');
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
           AFDQ_Query.Sql.Add('INSERT INTO EMPRESA_TMP( ');
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
           if Campo_Existe(FConexao,lQuery,'EMPRESA','EMAIL') then
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
           AFDQ_Query.Sql.Add('FROM EMPRESA ');
           AFDQ_Query.Sql.Add('ORDER BY ID; ');
           AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE EMPRESA;');
        AFDQ_Query.ExecSQL;
      end;

      //Recriando a estrutura...
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('CREATE TABLE EMPRESA ( ');
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

      if Tabela_Existe(FConexao,AFDQ_Query,'EMPRESA_TMP') then
      begin
        //Retornando dados para a tabela original
        if AManterDados then
        begin
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('INSERT INTO EMPRESA( ');
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
          AFDQ_Query.Sql.Add('FROM EMPRESA_TMP ');
          AFDQ_Query.Sql.Add('ORDER BY ID; ');
          AFDQ_Query.ExecSQL;
        end;
        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE EMPRESA_TMP;');
        AFDQ_Query.ExecSQL;
      end;
    except on E: Exception do
      raise Exception.Create('Empresa. ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

constructor TEMPRESA.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
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
  STATUS := -1;
  CELULAR := '';
  EMAIL := '';
  CEP := '';
  ENDERECO := '';
  COMPLEMENTO := '';
  BAIRRO := '';
  CIDADE := '';
  UF := '';
  SINCRONIZADO := -1;
  DT_CADASTRO := Date;
  HR_CADASTRO := Time;
end;

function TEMPRESA.Inserir(const AFDQ_Query: TFDQuery): Integer;
begin
  try
    try
      Result := 0;

      AFDQ_Query.Connection := FConexao;

      FDT_CADASTRO := Date;
      FHR_CADASTRO := Time;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO EMPRESA( ');
      AFDQ_Query.Sql.Add('  NOME ');
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
      AFDQ_Query.Sql.Add('  :NOME ');
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
      AFDQ_Query.ParamByName('SINCRONIZADO').AsInteger := FSINCRONIZADO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDate := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsTime := FHR_CADASTRO;
      AFDQ_Query.ExecSQL;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT COALESCE(MAX(ID),0) AS ID FROM EMPRESA; ');
      AFDQ_Query.Active := True;
      if not AFDQ_Query.IsEmpty then
        Result := AFDQ_Query.FieldByName('ID').AsInteger;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

function TEMPRESA.Listar(const AFDQ_Query: TFDQuery; AID, APagina: Integer): TJSONArray;
begin

end;

procedure TEMPRESA.Marcar_Como_Sincronizado(const AFDQ_Query: TFDQuery; const AUsuario: Integer);
begin

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
