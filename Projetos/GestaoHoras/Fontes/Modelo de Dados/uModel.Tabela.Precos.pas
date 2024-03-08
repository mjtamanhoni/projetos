unit uModel.Tabela.Precos;

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
  TTABELA_PRECOS = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FHR_CADASTRO: String;
    FVALOR: Double;
    FDESCRICAO: String;
    FID: Integer;
    FSTATUS: Integer;
    FDT_CADASTRO: String;

    procedure SetDESCRICAO(const Value: String);
    procedure SetDT_CADASTRO(const Value: String);
    procedure SetHR_CADASTRO(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetSTATUS(const Value: Integer);
    procedure SetVALOR(const Value: Double);

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
    property DESCRICAO :String read FDESCRICAO write SetDESCRICAO;
    property STATUS :Integer read FSTATUS write SetSTATUS;
    property VALOR :Double read FVALOR write SetVALOR;
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
    AFDQ_Query.Sql.Add('ORDER BY A.cid; ');
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

{ TTABELA_PRECOS }

procedure TTABELA_PRECOS.Atualizar(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TTABELA_PRECOS.Atualizar_Estrutura(const AFDQ_Query: TFDQuery; AManterDados: Boolean);
begin
  try
    try
      if Tabela_Existe(FConexao,AFDQ_Query,'TABELA_PRECOS') then
      begin
        if AManterDados then
        begin
           //Criando tabela temporária....
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('CREATE TABLE TABELA_PRECOS_TMP ( ');
           AFDQ_Query.Sql.Add('   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
           AFDQ_Query.Sql.Add('   DESCRICAO VARCHAR(255), ');
           AFDQ_Query.Sql.Add('   STATUS INTEGER DEFAULT 1, ');
           AFDQ_Query.Sql.Add('   VALOR NUMERIC(15,2), ');
           AFDQ_Query.Sql.Add('   SINCRONIZADO INTEGER, ');
           AFDQ_Query.Sql.Add('   DT_CADASTRO DATE, ');
           AFDQ_Query.Sql.Add('   HR_CADASTRO TIME ');
           AFDQ_Query.Sql.Add(' ); ');
           AFDQ_Query.ExecSQL;

           //Replicando dados...
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('INSERT INTO TABELA_PRECOS_TMP( ');
           AFDQ_Query.Sql.Add('   ID ');
           AFDQ_Query.Sql.Add('   ,DESCRICAO ');
           AFDQ_Query.Sql.Add('   ,STATUS ');
           AFDQ_Query.Sql.Add('   ,VALOR ');
           AFDQ_Query.Sql.Add('   ,SINCRONIZADO ');
           AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
           AFDQ_Query.Sql.Add('   ,HR_CADASTRO) ');
           AFDQ_Query.Sql.Add(' SELECT ');
           AFDQ_Query.Sql.Add('   ID ');
           AFDQ_Query.Sql.Add('   ,DESCRICAO ');
           AFDQ_Query.Sql.Add('   ,STATUS ');
           AFDQ_Query.Sql.Add('   ,VALOR ');
           AFDQ_Query.Sql.Add('   ,SINCRONIZADO ');
           AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
           AFDQ_Query.Sql.Add('   ,HR_CADASTRO ');
           AFDQ_Query.Sql.Add(' FROM TABELA_PRECOS ');
           AFDQ_Query.Sql.Add(' ORDER BY ID; ');
           AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE TABELA_PRECOS;');
        AFDQ_Query.ExecSQL;
      end;

      //Recriando a estrutura...
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('CREATE TABLE TABELA_PRECOS ( ');
      AFDQ_Query.Sql.Add('  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
      AFDQ_Query.Sql.Add('  DESCRICAO VARCHAR(255), ');
      AFDQ_Query.Sql.Add('  STATUS INTEGER DEFAULT 1, ');
      AFDQ_Query.Sql.Add('  VALOR NUMERIC(15,2), ');
      AFDQ_Query.Sql.Add('  SINCRONIZADO INTEGER, ');
      AFDQ_Query.Sql.Add('  DT_CADASTRO DATE, ');
      AFDQ_Query.Sql.Add('  HR_CADASTRO TIME ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ExecSQL;

      if Tabela_Existe(FConexao,AFDQ_Query,'TABELA_PRECOS_TMP') then
      begin
        if AManterDados then
        begin
          //Retornando dados para a tabela original
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('INSERT INTO TABELA_PRECOS( ');
          AFDQ_Query.Sql.Add('   ID ');
          AFDQ_Query.Sql.Add('   ,DESCRICAO ');
          AFDQ_Query.Sql.Add('   ,STATUS ');
          AFDQ_Query.Sql.Add('   ,VALOR ');
          AFDQ_Query.Sql.Add('   ,SINCRONIZADO ');
          AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('   ,HR_CADASTRO) ');
          AFDQ_Query.Sql.Add(' SELECT ');
          AFDQ_Query.Sql.Add('   ID ');
          AFDQ_Query.Sql.Add('   ,DESCRICAO ');
          AFDQ_Query.Sql.Add('   ,STATUS ');
          AFDQ_Query.Sql.Add('   ,VALOR ');
          AFDQ_Query.Sql.Add('   ,SINCRONIZADO ');
          AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('   ,HR_CADASTRO ');
          AFDQ_Query.Sql.Add(' FROM TABELA_PRECOS_TMP ');
          AFDQ_Query.Sql.Add(' ORDER BY ID; ');
          AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE TABELA_PRECOS_TMP;');
        AFDQ_Query.ExecSQL;
      end;
    except on E: Exception do
      raise Exception.Create('Tabela de Preços. ' + E.Message);
    end;
  finally

  end;
end;

constructor TTABELA_PRECOS.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

destructor TTABELA_PRECOS.Destroy;
begin

  inherited;
end;

procedure TTABELA_PRECOS.Excluir(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TTABELA_PRECOS.Inicia_Propriedades;
begin

end;

function TTABELA_PRECOS.Inserir(const AFDQ_Query: TFDQuery): Integer;
begin

end;

function TTABELA_PRECOS.Listar(const AFDQ_Query: TFDQuery; AID, APagina: Integer): TJSONArray;
begin

end;

procedure TTABELA_PRECOS.Marcar_Como_Sincronizado(const AFDQ_Query: TFDQuery; const AUsuario: Integer);
begin

end;

procedure TTABELA_PRECOS.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

procedure TTABELA_PRECOS.SetDT_CADASTRO(const Value: String);
begin
  FDT_CADASTRO := Value;
end;

procedure TTABELA_PRECOS.SetHR_CADASTRO(const Value: String);
begin
  FHR_CADASTRO := Value;
end;

procedure TTABELA_PRECOS.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TTABELA_PRECOS.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TTABELA_PRECOS.SetVALOR(const Value: Double);
begin
  FVALOR := Value;
end;

end.
