unit uModel.Projetos;

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
  TPROJETOS = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FHR_CADASTRO: TTime;
    FHR_RECEBIMENTO: TTime;
    FTOTAL_RECEBER: Double;
    FID_TABELA_PRECO: Integer;
    FID_CLIENTE: Integer;
    FID: Integer;
    FSTATUS: Integer;
    FQTD_HORAS: String;
    FDT_CADASTRO: TDate;
    FID_EMPRESA: Integer;
    FDT_RECEBIMENTO: TDate;
    FVALOR_DIFERENCA: Double;
    FNOME: String;
    FID_USUARIO: Integer;
    FVALOR_HORA: Double;

    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetDT_RECEBIMENTO(const Value: TDate);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetHR_RECEBIMENTO(const Value: TTime);
    procedure SetID(const Value: Integer);
    procedure SetID_CLIENTE(const Value: Integer);
    procedure SetID_EMPRESA(const Value: Integer);
    procedure SetID_TABELA_PRECO(const Value: Integer);
    procedure SetID_USUARIO(const Value: Integer);
    procedure SetNOME(const Value: String);
    procedure SetQTD_HORAS(const Value: String);
    procedure SetSTATUS(const Value: Integer);
    procedure SetTOTAL_RECEBER(const Value: Double);
    procedure SetVALOR_DIFERENCA(const Value: Double);
    procedure SetVALOR_HORA(const Value: Double);

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
    property ID_EMPRESA :Integer read FID_EMPRESA write SetID_EMPRESA;
    property ID_CLIENTE :Integer read FID_CLIENTE write SetID_CLIENTE;
    property ID_USUARIO :Integer read FID_USUARIO write SetID_USUARIO;
    property ID_TABELA_PRECO :Integer read FID_TABELA_PRECO write SetID_TABELA_PRECO;
    property VALOR_HORA :Double read FVALOR_HORA write SetVALOR_HORA;
    property STATUS :Integer read FSTATUS write SetSTATUS;
    property QTD_HORAS :String read FQTD_HORAS write SetQTD_HORAS;
    property TOTAL_RECEBER :Double read FTOTAL_RECEBER write SetTOTAL_RECEBER;
    property DT_RECEBIMENTO :TDate read FDT_RECEBIMENTO write SetDT_RECEBIMENTO;
    property HR_RECEBIMENTO :TTime read FHR_RECEBIMENTO write SetHR_RECEBIMENTO;
    property VALOR_DIFERENCA :Double read FVALOR_DIFERENCA write SetVALOR_DIFERENCA;
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

{ TPROJETOS }

procedure TPROJETOS.Atualizar(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TPROJETOS.Atualizar_Estrutura(const AFDQ_Query: TFDQuery; AManterDados: Boolean);
begin
  try
    try
      if Tabela_Existe(FConexao,AFDQ_Query,'PROJETOS') then
      begin
        if AManterDados then
        begin
           //Criando tabela temporária....
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('CREATE TABLE PROJETOS_TMP ( ');
           AFDQ_Query.Sql.Add('   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
           AFDQ_Query.Sql.Add('   NOME VARCHAR(255), ');
           AFDQ_Query.Sql.Add('   ID_EMPRESA INTEGER, ');
           AFDQ_Query.Sql.Add('   ID_CLIENTE INTEGER, ');
           AFDQ_Query.Sql.Add('   ID_USUARIO INTEGER, ');
           AFDQ_Query.Sql.Add('   ID_TABELA_PRECO INTEGER, ');
           AFDQ_Query.Sql.Add('   VALOR_HORA NUMERIC(15,2), ');
           AFDQ_Query.Sql.Add('   STATUS INTEGER DEFAULT 0, ');
           AFDQ_Query.Sql.Add('   QTD_HORAS VARCHAR(50), ');
           AFDQ_Query.Sql.Add('   TOTAL_RECEBER NUMERIC(15,2), ');
           AFDQ_Query.Sql.Add('   DT_RECEBIMENTO DATE, ');
           AFDQ_Query.Sql.Add('   HR_RECEBIMENTO TIME, ');
           AFDQ_Query.Sql.Add('   VALOR_DIFERENCA NUMERIC(15,2), ');
           AFDQ_Query.Sql.Add('   DT_CADASTRO DATE, ');
           AFDQ_Query.Sql.Add('   HR_CADASTRO TIME ');
           AFDQ_Query.Sql.Add(' ); ');
           AFDQ_Query.ExecSQL;

           //Replicando dados...
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('INSERT INTO PROJETOS_TMP( ');
           AFDQ_Query.Sql.Add('   ID ');
           AFDQ_Query.Sql.Add('   ,NOME ');
           AFDQ_Query.Sql.Add('   ,ID_EMPRESA ');
           AFDQ_Query.Sql.Add('   ,ID_CLIENTE ');
           AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
           AFDQ_Query.Sql.Add('   ,ID_TABELA_PRECO ');
           AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
           AFDQ_Query.Sql.Add('   ,STATUS ');
           AFDQ_Query.Sql.Add('   ,QTD_HORAS ');
           AFDQ_Query.Sql.Add('   ,TOTAL_RECEBER ');
           AFDQ_Query.Sql.Add('   ,DT_RECEBIMENTO ');
           AFDQ_Query.Sql.Add('   ,HR_RECEBIMENTO ');
           AFDQ_Query.Sql.Add('   ,VALOR_DIFERENCA ');
           AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
           AFDQ_Query.Sql.Add('   ,HR_CADASTRO) ');
           AFDQ_Query.Sql.Add(' SELECT ');
           AFDQ_Query.Sql.Add('   ID ');
           AFDQ_Query.Sql.Add('   ,NOME ');
           AFDQ_Query.Sql.Add('   ,ID_EMPRESA ');
           AFDQ_Query.Sql.Add('   ,ID_CLIENTE ');
           AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
           AFDQ_Query.Sql.Add('   ,ID_TABELA_PRECO ');
           AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
           AFDQ_Query.Sql.Add('   ,STATUS ');
           AFDQ_Query.Sql.Add('   ,QTD_HORAS ');
           AFDQ_Query.Sql.Add('   ,TOTAL_RECEBER ');
           AFDQ_Query.Sql.Add('   ,DT_RECEBIMENTO ');
           AFDQ_Query.Sql.Add('   ,HR_RECEBIMENTO ');
           AFDQ_Query.Sql.Add('   ,VALOR_DIFERENCA ');
           AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
           AFDQ_Query.Sql.Add('   ,HR_CADASTRO ');
           AFDQ_Query.Sql.Add(' FROM PROJETOS ');
           AFDQ_Query.Sql.Add(' ORDER BY ID; ');
           AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE PROJETOS;');
        AFDQ_Query.ExecSQL;
      end;

      //Recriando a estrutura...
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('CREATE TABLE PROJETOS ( ');
      AFDQ_Query.Sql.Add('   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
      AFDQ_Query.Sql.Add('   NOME VARCHAR(255), ');
      AFDQ_Query.Sql.Add('   ID_EMPRESA INTEGER, ');
      AFDQ_Query.Sql.Add('   ID_CLIENTE INTEGER, ');
      AFDQ_Query.Sql.Add('   ID_USUARIO INTEGER, ');
      AFDQ_Query.Sql.Add('   ID_TABELA_PRECO INTEGER, ');
      AFDQ_Query.Sql.Add('   VALOR_HORA NUMERIC(15,2), ');
      AFDQ_Query.Sql.Add('   STATUS INTEGER DEFAULT 0, ');
      AFDQ_Query.Sql.Add('   QTD_HORAS VARCHAR(50), ');
      AFDQ_Query.Sql.Add('   TOTAL_RECEBER NUMERIC(15,2), ');
      AFDQ_Query.Sql.Add('   DT_RECEBIMENTO DATE, ');
      AFDQ_Query.Sql.Add('   HR_RECEBIMENTO TIME, ');
      AFDQ_Query.Sql.Add('   VALOR_DIFERENCA NUMERIC(15,2), ');
      AFDQ_Query.Sql.Add('   DT_CADASTRO DATE, ');
      AFDQ_Query.Sql.Add('   HR_CADASTRO TIME ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ExecSQL;

      if Tabela_Existe(FConexao,AFDQ_Query,'PROJETOS_TMP') then
      begin
        if AManterDados then
        begin
          //Retornando dados para a tabela original
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('INSERT INTO PROJETOS( ');
          AFDQ_Query.Sql.Add('   ID ');
          AFDQ_Query.Sql.Add('   ,NOME ');
          AFDQ_Query.Sql.Add('   ,ID_EMPRESA ');
          AFDQ_Query.Sql.Add('   ,ID_CLIENTE ');
          AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
          AFDQ_Query.Sql.Add('   ,ID_TABELA_PRECO ');
          AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
          AFDQ_Query.Sql.Add('   ,STATUS ');
          AFDQ_Query.Sql.Add('   ,QTD_HORAS ');
          AFDQ_Query.Sql.Add('   ,TOTAL_RECEBER ');
          AFDQ_Query.Sql.Add('   ,DT_RECEBIMENTO ');
          AFDQ_Query.Sql.Add('   ,HR_RECEBIMENTO ');
          AFDQ_Query.Sql.Add('   ,VALOR_DIFERENCA ');
          AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('   ,HR_CADASTRO) ');
          AFDQ_Query.Sql.Add(' SELECT ');
          AFDQ_Query.Sql.Add('   ID ');
          AFDQ_Query.Sql.Add('   ,NOME ');
          AFDQ_Query.Sql.Add('   ,ID_EMPRESA ');
          AFDQ_Query.Sql.Add('   ,ID_CLIENTE ');
          AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
          AFDQ_Query.Sql.Add('   ,ID_TABELA_PRECO ');
          AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
          AFDQ_Query.Sql.Add('   ,STATUS ');
          AFDQ_Query.Sql.Add('   ,QTD_HORAS ');
          AFDQ_Query.Sql.Add('   ,TOTAL_RECEBER ');
          AFDQ_Query.Sql.Add('   ,DT_RECEBIMENTO ');
          AFDQ_Query.Sql.Add('   ,HR_RECEBIMENTO ');
          AFDQ_Query.Sql.Add('   ,VALOR_DIFERENCA ');
          AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('   ,HR_CADASTRO ');
          AFDQ_Query.Sql.Add(' FROM PROJETOS_TMP ');
          AFDQ_Query.Sql.Add(' ORDER BY ID; ');
          AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE PROJETOS_TMP;');
        AFDQ_Query.ExecSQL;
      end;
    except on E: Exception do
      raise Exception.Create('Projetos. ' + E.Message);
    end;
  finally

  end;
end;

constructor TPROJETOS.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

destructor TPROJETOS.Destroy;
begin

  inherited;
end;

procedure TPROJETOS.Excluir(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TPROJETOS.Inicia_Propriedades;
begin

end;

function TPROJETOS.Inserir(const AFDQ_Query: TFDQuery): Integer;
begin

end;

function TPROJETOS.Listar(const AFDQ_Query: TFDQuery; AID, APagina: Integer): TJSONArray;
begin

end;

procedure TPROJETOS.Marcar_Como_Sincronizado(const AFDQ_Query: TFDQuery; const AUsuario: Integer);
begin

end;

procedure TPROJETOS.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TPROJETOS.SetDT_RECEBIMENTO(const Value: TDate);
begin
  FDT_RECEBIMENTO := Value;
end;

procedure TPROJETOS.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TPROJETOS.SetHR_RECEBIMENTO(const Value: TTime);
begin
  FHR_RECEBIMENTO := Value;
end;

procedure TPROJETOS.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPROJETOS.SetID_CLIENTE(const Value: Integer);
begin
  FID_CLIENTE := Value;
end;

procedure TPROJETOS.SetID_EMPRESA(const Value: Integer);
begin
  FID_EMPRESA := Value;
end;

procedure TPROJETOS.SetID_TABELA_PRECO(const Value: Integer);
begin
  FID_TABELA_PRECO := Value;
end;

procedure TPROJETOS.SetID_USUARIO(const Value: Integer);
begin
  FID_USUARIO := Value;
end;

procedure TPROJETOS.SetNOME(const Value: String);
begin
  FNOME := Value;
end;

procedure TPROJETOS.SetQTD_HORAS(const Value: String);
begin
  FQTD_HORAS := Value;
end;

procedure TPROJETOS.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TPROJETOS.SetTOTAL_RECEBER(const Value: Double);
begin
  FTOTAL_RECEBER := Value;
end;

procedure TPROJETOS.SetVALOR_DIFERENCA(const Value: Double);
begin
  FVALOR_DIFERENCA := Value;
end;

procedure TPROJETOS.SetVALOR_HORA(const Value: Double);
begin
  FVALOR_HORA := Value;
end;

end.
