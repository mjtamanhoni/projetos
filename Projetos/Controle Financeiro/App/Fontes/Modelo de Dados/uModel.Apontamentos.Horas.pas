unit uModel.Apontamentos.Horas;

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
  TAPONTAMENTO_HORAS = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FHR_INICIO: TTime;
    FHR_CADASTRO: TTime;
    FID_PROJETO: Integer;
    FID_TABELA: Integer;
    FID: Integer;
    FDT_CADASTRO: TDate;
    FVLR_TOTAL: Double;
    FHR_TOTAL: TDate;
    FDATA: TDate;
    FID_USUARIO: Integer;
    FHR_FIM: TTime;
    FVALOR_HORA: Double;

    procedure SetDATA(const Value: TDate);
    procedure SetDT_CADASTRO(const Value: TDate);
    procedure SetHR_CADASTRO(const Value: TTime);
    procedure SetHR_FIM(const Value: TTime);
    procedure SetHR_INICIO(const Value: TTime);
    procedure SetHR_TOTAL(const Value: TDate);
    procedure SetID(const Value: Integer);
    procedure SetID_PROJETO(const Value: Integer);
    procedure SetID_TABELA(const Value: Integer);
    procedure SetID_USUARIO(const Value: Integer);
    procedure SetVALOR_HORA(const Value: Double);
    procedure SetVLR_TOTAL(const Value: Double);

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
    property ID_PROJETO :Integer read FID_PROJETO write SetID_PROJETO;
    property ID_USUARIO :Integer read FID_USUARIO write SetID_USUARIO;
    property ID_TABELA :Integer read FID_TABELA write SetID_TABELA;
    property VALOR_HORA :Double read FVALOR_HORA write SetVALOR_HORA;
    property DATA :TDate read FDATA write SetDATA;
    property HR_INICIO :TTime read FHR_INICIO write SetHR_INICIO;
    property HR_FIM :TTime read FHR_FIM write SetHR_FIM;
    property HR_TOTAL :TDate read FHR_TOTAL write SetHR_TOTAL;
    property VLR_TOTAL :Double read FVLR_TOTAL write SetVLR_TOTAL;
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

{ TAPONTAMENTO_HORAS }

procedure TAPONTAMENTO_HORAS.Atualizar(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TAPONTAMENTO_HORAS.Atualizar_Estrutura(const AFDQ_Query: TFDQuery; AManterDados: Boolean);
begin
  try
    try
      if Tabela_Existe(FConexao,AFDQ_Query,'APONTAMENTOS_HORAS') then
      begin
        if AManterDados then
        begin
           //Criando tabela temporária....
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('CREATE TABLE APONTAMENTOS_HORAS_TMP ( ');
           AFDQ_Query.Sql.Add('   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
           AFDQ_Query.Sql.Add('   ID_PROJETO INTEGER, ');
           AFDQ_Query.Sql.Add('   ID_USUARIO INTEGER, ');
           AFDQ_Query.Sql.Add('   ID_TABELA INTEGER, ');
           AFDQ_Query.Sql.Add('   VALOR_HORA NUMERIC(15,2), ');
           AFDQ_Query.Sql.Add('   "DATA" DATE, ');
           AFDQ_Query.Sql.Add('   HR_INICIO TIME, ');
           AFDQ_Query.Sql.Add('   HR_FIM TIME, ');
           AFDQ_Query.Sql.Add('   HR_TOTAL VARCHAR(50), ');
           AFDQ_Query.Sql.Add('   VLR_TOTAL NUMERIC(15,2), ');
           AFDQ_Query.Sql.Add('   DT_CADASTRO DATE, ');
           AFDQ_Query.Sql.Add('   HR_CADASTRO TIME ');
           AFDQ_Query.Sql.Add(' ); ');
           AFDQ_Query.ExecSQL;

           //Replicando dados...
           AFDQ_Query.Active := False;
           AFDQ_Query.Sql.Clear;
           AFDQ_Query.Sql.Add('INSERT INTO APONTAMENTOS_HORAS_TMP( ');
           AFDQ_Query.Sql.Add('   ID ');
           AFDQ_Query.Sql.Add('   ,ID_PROJETO ');
           AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
           AFDQ_Query.Sql.Add('   ,ID_TABELA ');
           AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
           AFDQ_Query.Sql.Add('   ,DATA ');
           AFDQ_Query.Sql.Add('   ,HR_INICIO ');
           AFDQ_Query.Sql.Add('   ,HR_FIM ');
           AFDQ_Query.Sql.Add('   ,HR_TOTAL ');
           AFDQ_Query.Sql.Add('   ,VLR_TOTAL ');
           AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
           AFDQ_Query.Sql.Add('   ,HR_CADASTRO) ');
           AFDQ_Query.Sql.Add(' SELECT ');
           AFDQ_Query.Sql.Add('   ID ');
           AFDQ_Query.Sql.Add('   ,ID_PROJETO ');
           AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
           AFDQ_Query.Sql.Add('   ,ID_TABELA ');
           AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
           AFDQ_Query.Sql.Add('   ,DATA ');
           AFDQ_Query.Sql.Add('   ,HR_INICIO ');
           AFDQ_Query.Sql.Add('   ,HR_FIM ');
           AFDQ_Query.Sql.Add('   ,HR_TOTAL ');
           AFDQ_Query.Sql.Add('   ,VLR_TOTAL ');
           AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
           AFDQ_Query.Sql.Add('   ,HR_CADASTRO ');
           AFDQ_Query.Sql.Add(' FROM APONTAMENTOS_HORAS ');
           AFDQ_Query.Sql.Add(' ORDER BY ID; ');
           AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE APONTAMENTOS_HORAS;');
        AFDQ_Query.ExecSQL;
      end;

      //Recriando a estrutura...
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('CREATE TABLE APONTAMENTOS_HORAS ( ');
      AFDQ_Query.Sql.Add('   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
      AFDQ_Query.Sql.Add('   ID_PROJETO INTEGER, ');
      AFDQ_Query.Sql.Add('   ID_USUARIO INTEGER, ');
      AFDQ_Query.Sql.Add('   ID_TABELA INTEGER, ');
      AFDQ_Query.Sql.Add('   VALOR_HORA NUMERIC(15,2), ');
      AFDQ_Query.Sql.Add('   "DATA" DATE, ');
      AFDQ_Query.Sql.Add('   HR_INICIO TIME, ');
      AFDQ_Query.Sql.Add('   HR_FIM TIME, ');
      AFDQ_Query.Sql.Add('   HR_TOTAL VARCHAR(50), ');
      AFDQ_Query.Sql.Add('   VLR_TOTAL NUMERIC(15,2), ');
      AFDQ_Query.Sql.Add('   DT_CADASTRO DATE, ');
      AFDQ_Query.Sql.Add('   HR_CADASTRO TIME ');
      AFDQ_Query.ExecSQL;

      if Tabela_Existe(FConexao,AFDQ_Query,'APONTAMENTOS_HORAS_TMP') then
      begin
        if AManterDados then
        begin
          //Retornando dados para a tabela original
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('INSERT INTO APONTAMENTOS_HORAS( ');
          AFDQ_Query.Sql.Add('   ID ');
          AFDQ_Query.Sql.Add('   ,ID_PROJETO ');
          AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
          AFDQ_Query.Sql.Add('   ,ID_TABELA ');
          AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
          AFDQ_Query.Sql.Add('   ,DATA ');
          AFDQ_Query.Sql.Add('   ,HR_INICIO ');
          AFDQ_Query.Sql.Add('   ,HR_FIM ');
          AFDQ_Query.Sql.Add('   ,HR_TOTAL ');
          AFDQ_Query.Sql.Add('   ,VLR_TOTAL ');
          AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('   ,HR_CADASTRO) ');
          AFDQ_Query.Sql.Add(' SELECT ');
          AFDQ_Query.Sql.Add('   ID ');
          AFDQ_Query.Sql.Add('   ,ID_PROJETO ');
          AFDQ_Query.Sql.Add('   ,ID_USUARIO ');
          AFDQ_Query.Sql.Add('   ,ID_TABELA ');
          AFDQ_Query.Sql.Add('   ,VALOR_HORA ');
          AFDQ_Query.Sql.Add('   ,DATA ');
          AFDQ_Query.Sql.Add('   ,HR_INICIO ');
          AFDQ_Query.Sql.Add('   ,HR_FIM ');
          AFDQ_Query.Sql.Add('   ,HR_TOTAL ');
          AFDQ_Query.Sql.Add('   ,VLR_TOTAL ');
          AFDQ_Query.Sql.Add('   ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('   ,HR_CADASTRO ');
          AFDQ_Query.Sql.Add(' FROM APONTAMENTOS_HORAS_TMP ');
          AFDQ_Query.Sql.Add(' ORDER BY ID; ');
          AFDQ_Query.ExecSQL;
        end;

        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE APONTAMENTOS_HORAS_TMP;');
        AFDQ_Query.ExecSQL;
      end;
    except on E: Exception do
      raise Exception.Create('Apontamento de Horas. ' + E.Message);
    end;
  finally

  end;
end;

constructor TAPONTAMENTO_HORAS.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

destructor TAPONTAMENTO_HORAS.Destroy;
begin

  inherited;
end;

procedure TAPONTAMENTO_HORAS.Excluir(const AFDQ_Query: TFDQuery; AID, APagina: Integer);
begin

end;

procedure TAPONTAMENTO_HORAS.Inicia_Propriedades;
begin

end;

function TAPONTAMENTO_HORAS.Inserir(const AFDQ_Query: TFDQuery): Integer;
begin

end;

function TAPONTAMENTO_HORAS.Listar(const AFDQ_Query: TFDQuery; AID, APagina: Integer): TJSONArray;
begin

end;

procedure TAPONTAMENTO_HORAS.Marcar_Como_Sincronizado(const AFDQ_Query: TFDQuery; const AUsuario: Integer);
begin

end;

procedure TAPONTAMENTO_HORAS.SetDATA(const Value: TDate);
begin
  FDATA := Value;
end;

procedure TAPONTAMENTO_HORAS.SetDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TAPONTAMENTO_HORAS.SetHR_CADASTRO(const Value: TTime);
begin
  FHR_CADASTRO := Value;
end;

procedure TAPONTAMENTO_HORAS.SetHR_FIM(const Value: TTime);
begin
  FHR_FIM := Value;
end;

procedure TAPONTAMENTO_HORAS.SetHR_INICIO(const Value: TTime);
begin
  FHR_INICIO := Value;
end;

procedure TAPONTAMENTO_HORAS.SetHR_TOTAL(const Value: TDate);
begin
  FHR_TOTAL := Value;
end;

procedure TAPONTAMENTO_HORAS.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TAPONTAMENTO_HORAS.SetID_PROJETO(const Value: Integer);
begin
  FID_PROJETO := Value;
end;

procedure TAPONTAMENTO_HORAS.SetID_TABELA(const Value: Integer);
begin
  FID_TABELA := Value;
end;

procedure TAPONTAMENTO_HORAS.SetID_USUARIO(const Value: Integer);
begin
  FID_USUARIO := Value;
end;

procedure TAPONTAMENTO_HORAS.SetVALOR_HORA(const Value: Double);
begin
  FVALOR_HORA := Value;
end;

procedure TAPONTAMENTO_HORAS.SetVLR_TOTAL(const Value: Double);
begin
  FVLR_TOTAL := Value;
end;

end.
