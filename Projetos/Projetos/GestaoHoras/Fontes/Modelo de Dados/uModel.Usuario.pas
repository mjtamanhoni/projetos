unit uModel.Usuario;

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
  TUSUARIO = class
  private
    FConexao: TFDConnection;
    FPagina :Integer;
    FPaginas :Integer;

    FID :Integer;
    FNOME :String;
    FLOGIN :String;
    FSENHA :String;
    FPIN :String;
    FCELULAR :String;
    FEMAIL :String;
    FDT_CADASTRO :TDate;
    FHR_CADASTRO :TTime;
    FSINCRONIZADO: Integer;

    procedure SetID( const Value:Integer);
    procedure SetNOME( const Value:String);
    procedure SetLOGIN( const Value:String);
    procedure SetSENHA( const Value:String);
    procedure SetPIN( const Value:String);
    procedure SetCELULAR( const Value:String);
    procedure SetEMAIL( const Value:String);
    procedure SetDT_CADASTRO( const Value:TDate);
    procedure SetHR_CADASTRO( const Value:TTime);
    procedure SetSINCRONIZADO(const Value: Integer);

  public
    constructor Create(AConnexao: TFDConnection);
    destructor Destroy; override;

    procedure Criar_Estrutura(AFDQuery: TFDQuery);
    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery; AManterDados:Boolean=False);
    procedure Inicia_Propriedades;
    function Inserir(const AFDQ_Query:TFDQuery):Integer;
    function Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray;
    procedure Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
    procedure Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
    procedure Marcar_Como_Sincronizado(const AFDQ_Query:TFDQuery; const AUsuario:Integer=0);

    function ValidaLogin(
      const AFDQ_Query:TFDQuery;
      const AUsuario:String;
      const ASenha:String;
      const APin:String):TJsonObject;

    property ID:Integer read FID write SetID;
    property NOME:String read FNOME write SetNOME;
    property LOGIN:String read FLOGIN write SetLOGIN;
    property SENHA:String read FSENHA write SetSENHA;
    property PIN:String read FPIN write SetPIN;
    property CELULAR:String read FCELULAR write SetCELULAR;
    property EMAIL:String read FEMAIL write SetEMAIL;
    property SINCRONIZADO :Integer read FSINCRONIZADO write SetSINCRONIZADO;
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

{ TUSUARIO }

constructor TUSUARIO.Create(AConnexao: TFDConnection);
begin
  FPaginas := C_Paginas;
  FConexao := AConnexao;
end;

destructor TUSUARIO.Destroy;
begin

  inherited;
end;

procedure TUSUARIO.Criar_Estrutura(AFDQuery: TFDQuery);
begin
  try
    try

    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TUSUARIO.Atualizar_Estrutura(const AFDQ_Query:TFDQuery; AManterDados:Boolean=False);
begin
  try
    try
      if Tabela_Existe(FConexao,AFDQ_Query,'USUARIO') then
      begin
        if AManterDados then
        begin
          if Tabela_Existe(FConexao,AFDQ_Query,'USUARIO_TEMP') then
          begin
            AFDQ_Query.Active := False;
            AFDQ_Query.Sql.Clear;
            AFDQ_Query.Sql.Add('DROP TABLE USUARIO;');
            AFDQ_Query.ExecSQL;
          end;

          //Criando tabela temporária....
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('CREATE TABLE USUARIO_TEMP ( ');
          AFDQ_Query.Sql.Add('  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
          AFDQ_Query.Sql.Add('  NOME VARCHAR(100) NOT NULL, ');
          AFDQ_Query.Sql.Add('  LOGIN VARCHAR(50) NOT NULL, ');
          AFDQ_Query.Sql.Add('  SENHA VARCHAR(50) NOT NULL, ');
          AFDQ_Query.Sql.Add('  PIN VARCHAR(4), ');
          AFDQ_Query.Sql.Add('  CELULAR VARCHAR(15), ');
          AFDQ_Query.Sql.Add('  EMAIL VARCHAR(255), ');
          AFDQ_Query.Sql.Add('  FOTO BLOB SUB_TYPE TEXT, ');
          AFDQ_Query.Sql.Add('  SINCRONIZADO INTEGER, ');
          AFDQ_Query.Sql.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE, ');
          AFDQ_Query.Sql.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME ');
          AFDQ_Query.Sql.Add('); ');
          AFDQ_Query.ExecSQL;

          //Replicando dados...
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('INSERT INTO USUARIO_TEMP( ');
          AFDQ_Query.Sql.Add('  ID ');
          AFDQ_Query.Sql.Add('  ,NOME ');
          AFDQ_Query.Sql.Add('  ,LOGIN ');
          AFDQ_Query.Sql.Add('  ,SENHA ');
          AFDQ_Query.Sql.Add('  ,PIN ');
          AFDQ_Query.Sql.Add('  ,CELULAR ');
          AFDQ_Query.Sql.Add('  ,EMAIL ');
          AFDQ_Query.Sql.Add('  ,FOTO ');
          AFDQ_Query.Sql.Add('  ,SINCRONIZADO ');
          AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('  ,HR_CADASTRO) ');
          AFDQ_Query.Sql.Add('SELECT ');
          AFDQ_Query.Sql.Add('  U.ID ');
          AFDQ_Query.Sql.Add('  ,U.NOME ');
          AFDQ_Query.Sql.Add('  ,U.LOGIN ');
          AFDQ_Query.Sql.Add('  ,U.SENHA ');
          AFDQ_Query.Sql.Add('  ,U.PIN ');
          AFDQ_Query.Sql.Add('  ,U.CELULAR ');
          AFDQ_Query.Sql.Add('  ,U.EMAIL ');
          AFDQ_Query.Sql.Add('  ,U.FOTO ');
          AFDQ_Query.Sql.Add('  ,U.SINCRONIZADO ');
          AFDQ_Query.Sql.Add('  ,U.DT_CADASTRO ');
          AFDQ_Query.Sql.Add('  ,U.HR_CADASTRO ');
          AFDQ_Query.Sql.Add('FROM USUARIO U ');
          AFDQ_Query.Sql.Add('ORDER BY U.ID; ');
          AFDQ_Query.ExecSQL;

        end;
        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE USUARIO;');
        AFDQ_Query.ExecSQL;
      end;

      //Recriando a estrutura...
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('CREATE TABLE USUARIO ( ');
      AFDQ_Query.Sql.Add('  ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ');
      AFDQ_Query.Sql.Add('  NOME VARCHAR(100) NOT NULL, ');
      AFDQ_Query.Sql.Add('  LOGIN VARCHAR(50) NOT NULL, ');
      AFDQ_Query.Sql.Add('  SENHA VARCHAR(50) NOT NULL, ');
      AFDQ_Query.Sql.Add('  PIN VARCHAR(4), ');
      AFDQ_Query.Sql.Add('  CELULAR VARCHAR(15), ');
      AFDQ_Query.Sql.Add('  EMAIL VARCHAR(255), ');
      AFDQ_Query.Sql.Add('  FOTO BLOB SUB_TYPE TEXT, ');
      AFDQ_Query.Sql.Add('  SINCRONIZADO INTEGER, ');
      AFDQ_Query.Sql.Add('  DT_CADASTRO DATE DEFAULT CURRENT_DATE, ');
      AFDQ_Query.Sql.Add('  HR_CADASTRO TIME DEFAULT CURRENT_TIME ');
      AFDQ_Query.Sql.Add('); ');
      AFDQ_Query.ExecSQL;

      if Tabela_Existe(FConexao,AFDQ_Query,'USUARIO_TEMP') then
      begin
        if AManterDados then
        begin
          //Retornando dados para a tabela original
          AFDQ_Query.Active := False;
          AFDQ_Query.Sql.Clear;
          AFDQ_Query.Sql.Add('INSERT INTO USUARIO( ');
          AFDQ_Query.Sql.Add('  ID ');
          AFDQ_Query.Sql.Add('  ,NOME ');
          AFDQ_Query.Sql.Add('  ,LOGIN ');
          AFDQ_Query.Sql.Add('  ,SENHA ');
          AFDQ_Query.Sql.Add('  ,PIN ');
          AFDQ_Query.Sql.Add('  ,CELULAR ');
          AFDQ_Query.Sql.Add('  ,EMAIL ');
          AFDQ_Query.Sql.Add('  ,FOTO ');
          AFDQ_Query.Sql.Add('  ,SINCRONIZADO ');
          AFDQ_Query.Sql.Add('  ,DT_CADASTRO ');
          AFDQ_Query.Sql.Add('  ,HR_CADASTRO) ');
          AFDQ_Query.Sql.Add('SELECT ');
          AFDQ_Query.Sql.Add('  U.ID ');
          AFDQ_Query.Sql.Add('  ,U.NOME ');
          AFDQ_Query.Sql.Add('  ,U.LOGIN ');
          AFDQ_Query.Sql.Add('  ,U.SENHA ');
          AFDQ_Query.Sql.Add('  ,U.PIN ');
          AFDQ_Query.Sql.Add('  ,U.CELULAR ');
          AFDQ_Query.Sql.Add('  ,U.EMAIL ');
          AFDQ_Query.Sql.Add('  ,U.FOTO ');
          AFDQ_Query.Sql.Add('  ,U.SINCRONIZADO ');
          AFDQ_Query.Sql.Add('  ,U.DT_CADASTRO ');
          AFDQ_Query.Sql.Add('  ,U.HR_CADASTRO ');
          AFDQ_Query.Sql.Add('FROM USUARIO_TEMP U ');
          AFDQ_Query.Sql.Add('ORDER BY U.ID; ');
          AFDQ_Query.ExecSQL;
        end;
        //Excluindo tabela...
        AFDQ_Query.Active := False;
        AFDQ_Query.Sql.Clear;
        AFDQ_Query.Sql.Add('DROP TABLE USUARIO_TEMP;');
        AFDQ_Query.ExecSQL;
      end;
    except on E: Exception do
      raise Exception.Create('Usuário. ' + E.Message);
    end;
  finally

  end;
end;

procedure TUSUARIO.Inicia_Propriedades;
begin
  ID := -1;
  NOME := '';
  LOGIN := '';
  SENHA := '';
  PIN := '';
  CELULAR := '';
  EMAIL := '';
  SINCRONIZADO := 0;
  DT_CADASTRO := Date;
  HR_CADASTRO := Time;
end;

function  TUSUARIO.Listar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0): TJSONArray;
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      Inicia_Propriedades;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT * FROM USUARIO') ;
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
        LOGIN := AFDQ_Query.FieldByName('LOGIN').AsString;
        SENHA := AFDQ_Query.FieldByName('SENHA').AsString;
        PIN := AFDQ_Query.FieldByName('PIN').AsString;
        CELULAR := AFDQ_Query.FieldByName('CELULAR').AsString;
        EMAIL := AFDQ_Query.FieldByName('EMAIL').AsString;
        SINCRONIZADO := AFDQ_Query.FieldByName('SINCRONIZADO').AsInteger;
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

procedure TUSUARIO.Marcar_Como_Sincronizado(const AFDQ_Query:TFDQuery; const AUsuario:Integer=0);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('UPDATE USUARIO SET ');
      AFDQ_Query.Sql.Add('  SINCRONIZADO = 1 ');
      if AUsuario > 0 then
        AFDQ_Query.Sql.Add('WHERE USUARIO.ID = ' + AUsuario.ToString);
      AFDQ_Query.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Marca como sincronizado' + E.Message);
    end;
  finally
  end;
end;

function TUSUARIO.Inserir(const AFDQ_Query: TFDQuery):Integer;
begin
  try
    try
      Result := 0;

      AFDQ_Query.Connection := FConexao;

      if FNOME = '' then
        raise Exception.Create('NOME: NOME não informado');
      if FLOGIN = '' then
        raise Exception.Create('LOGIN: LOGIN não informado');
      if FSENHA = '' then
        raise Exception.Create('SENHA: SENHA não informado');

      FDT_CADASTRO := Date;
      FHR_CADASTRO := Time;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('INSERT INTO USUARIO( ');
      AFDQ_Query.Sql.Add('  NOME');
      AFDQ_Query.Sql.Add('  ,LOGIN');
      AFDQ_Query.Sql.Add('  ,SENHA');
      AFDQ_Query.Sql.Add('  ,PIN');
      AFDQ_Query.Sql.Add('  ,CELULAR');
      AFDQ_Query.Sql.Add('  ,EMAIL');
      AFDQ_Query.Sql.Add('  ,SINCRONIZADO');
      AFDQ_Query.Sql.Add('  ,DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,HR_CADASTRO');
      AFDQ_Query.Sql.Add(') VALUES(');
      AFDQ_Query.Sql.Add('  :NOME');
      AFDQ_Query.Sql.Add('  ,:LOGIN');
      AFDQ_Query.Sql.Add('  ,:SENHA');
      AFDQ_Query.Sql.Add('  ,:PIN');
      AFDQ_Query.Sql.Add('  ,:CELULAR');
      AFDQ_Query.Sql.Add('  ,:EMAIL');
      AFDQ_Query.Sql.Add('  ,:SINCRONIZADO');
      AFDQ_Query.Sql.Add('  ,:DT_CADASTRO');
      AFDQ_Query.Sql.Add('  ,:HR_CADASTRO);');
      AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      AFDQ_Query.ParamByName('LOGIN').AsString := FLOGIN;
      AFDQ_Query.ParamByName('SENHA').AsString := FSENHA;
      AFDQ_Query.ParamByName('PIN').AsString := FPIN;
      AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
      AFDQ_Query.ParamByName('SINCRONIZADO').AsInteger := FSINCRONIZADO;
      AFDQ_Query.ParamByName('DT_CADASTRO').AsDate := FDT_CADASTRO;
      AFDQ_Query.ParamByName('HR_CADASTRO').AsTime := FHR_CADASTRO;
      AFDQ_Query.ExecSQL;

      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('SELECT COALESCE(MAX(ID),0) AS ID FROM USUARIO; ');
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

procedure TUSUARIO.Atualizar(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin
   try
     try
       AFDQ_Query.Connection := FConexao;


      AFDQ_Query.Sql.Add('UPDATE USUARIO SET ');
      if FNOME <> '' then
        AFDQ_Query.Sql.Add('  NOME = :NOME ');
      if FLOGIN <> '' then
        AFDQ_Query.Sql.Add('  ,LOGIN = :LOGIN ');
      if FSENHA <> '' then
        AFDQ_Query.Sql.Add('  ,SENHA = :SENHA ');
      if FPIN <> '' then
        AFDQ_Query.Sql.Add('  ,PIN = :PIN ');
      if FCELULAR <> '' then
        AFDQ_Query.Sql.Add('  ,CELULAR = :CELULAR ');
      if FEMAIL <> '' then
        AFDQ_Query.Sql.Add('  ,EMAIL = :EMAIL ');
      if FSINCRONIZADO >= 0 then
        AFDQ_Query.Sql.Add('  ,SINCRONIZADO = :SINCRONIZADO ');
      if FDT_CADASTRO > 0 then
        AFDQ_Query.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      if FHR_CADASTRO > 0 then
        AFDQ_Query.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      AFDQ_Query.Sql.Add('WHERE 1=1');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := FID;
      if FNOME <> '' then
        AFDQ_Query.ParamByName('NOME').AsString := FNOME;
      if FLOGIN <> '' then
        AFDQ_Query.ParamByName('LOGIN').AsString := FLOGIN;
      if FSENHA <> '' then
        AFDQ_Query.ParamByName('SENHA').AsString := FSENHA;
      if FPIN <> '' then
        AFDQ_Query.ParamByName('PIN').AsString := FPIN;
      if FCELULAR <> '' then
        AFDQ_Query.ParamByName('CELULAR').AsString := FCELULAR;
      if FEMAIL <> '' then
        AFDQ_Query.ParamByName('EMAIL').AsString := FEMAIL;
      if FSINCRONIZADO >= 0 then
        AFDQ_Query.ParamByName('SINCRONIZADO').AsInteger := FSINCRONIZADO;
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

procedure TUSUARIO.Excluir(const AFDQ_Query:TFDQuery; AID:Integer = 0; APagina:Integer=0);
begin
  try
    try
      AFDQ_Query.Connection := FConexao;
      AFDQ_Query.Active := False;
      AFDQ_Query.Sql.Clear;
      AFDQ_Query.Sql.Add('DELETE FROM USUARIO ');
      AFDQ_Query.Sql.Add('WHERE NOT ID IS NULL ');
      AFDQ_Query.Sql.Add('  AND ID = :ID');
      AFDQ_Query.ParamByName('ID').AsInteger := AID;
      AFDQ_Query.ExecSQL;
    except
      On Ex:Exception do
        raise Exception.Create(Ex.Message);
    end;
  finally
  end;
end;

procedure TUSUARIO.SetID( const Value:Integer);
begin
  FID := Value;
end;

procedure TUSUARIO.SetNOME( const Value:String);
begin
  FNOME := Value;
end;

procedure TUSUARIO.SetLOGIN( const Value:String);
begin
  FLOGIN := Value;
end;

procedure TUSUARIO.SetSENHA( const Value:String);
begin
  FSENHA := Value;
end;

procedure TUSUARIO.SetSINCRONIZADO(const Value: Integer);
begin
  FSINCRONIZADO := Value;
end;

function TUSUARIO.ValidaLogin(const AFDQ_Query: TFDQuery; const AUsuario, ASenha, APin: String): TJsonObject;
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

procedure TUSUARIO.SetPIN( const Value:String);
begin
  FPIN := Value;
end;

procedure TUSUARIO.SetCELULAR( const Value:String);
begin
  FCELULAR := Value;
end;

procedure TUSUARIO.SetEMAIL( const Value:String);
begin
  FEMAIL := Value;
end;

procedure TUSUARIO.SetDT_CADASTRO( const Value:TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TUSUARIO.SetHR_CADASTRO( const Value:TTime);
begin
  FHR_CADASTRO := Value;
end;


end.
