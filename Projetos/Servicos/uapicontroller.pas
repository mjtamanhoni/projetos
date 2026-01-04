unit uApiController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SvcMgr, Horse, Horse.Jhonson, Horse.BasicAuth,
  sqldb, pgsqlconn, fpjson, jsonparser;

type
  TMeuServicoREST = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceDestroy(Sender: TObject);
  private
    procedure ConfigurarServidor;
    procedure GetUsuarios(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure GetUsuarioPorId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure PostUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure PutUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure DeleteUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  public
    function GetServiceController: TServiceController; override;
  end;

var
  MeuServicoREST: TMeuServicoREST;
  SQLConnection: TSQLConnection;
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;

implementation

{$R *.lfm}

function TMeuServicoREST.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMeuServicoREST.ServiceCreate(Sender: TObject);
begin
  // Configurações iniciais ao criar o serviço
end;

procedure TMeuServicoREST.ServiceStart(Sender: TService; var Started: Boolean);
begin
  ConfigurarServidor;
  Started := True;
  LogMessage('Serviço REST iniciado na porta 9000');
end;

procedure TMeuServicoREST.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  THorse.StopListen;
  LogMessage('Serviço REST parado');
  Stopped := True;
end;

procedure TMeuServicoREST.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(SQLQuery);
  FreeAndNil(SQLTransaction);
  FreeAndNil(SQLConnection);
end;

procedure TMeuServicoREST.ConfigurarServidor;
begin
  // Conexão PostgreSQL
  SQLConnection := TSQLConnection.Create(nil);
  SQLConnection.HostName := 'localhost';
  SQLConnection.DatabaseName := 'meubanco';
  SQLConnection.UserName := 'postgres';
  SQLConnection.Password := 'senha';
  SQLConnection.CharSet := 'UTF8';
  SQLConnection.Transaction := SQLTransaction;
  SQLConnection.Connected := True;

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLTransaction.DataBase := SQLConnection;

  SQLQuery := TSQLQuery.Create(nil);
  SQLQuery.DataBase := SQLConnection;
  SQLQuery.Transaction := SQLTransaction;

  // Cria tabela exemplo
  SQLQuery.SQL.Text := 'CREATE TABLE IF NOT EXISTS usuarios (id SERIAL PRIMARY KEY, nome TEXT, email TEXT, ativo INTEGER)';
  SQLQuery.ExecSQL;
  SQLTransaction.Commit;

  // Configura Horse
  THorse.Use(Jhonson);

  // Autenticação Basic (admin/123)
  THorse.Use(BasicAuth('Autenticação',
    procedure(const AUsername, APassword: string; var AUser: TObject)
    begin
      if (AUsername = 'admin') and (APassword = '123') then
        AUser := TObject(1)
      else
        raise EHorseException.New.Error('Credenciais inválidas').Status(THTTPStatus.Unauthorized);
    end
  ));

  // Endpoints
  THorse.Get('/usuarios', GetUsuarios);
  THorse.Get('/usuarios/:id', GetUsuarioPorId);
  THorse.Post('/usuarios', PostUsuario);
  THorse.Put('/usuarios/:id', PutUsuario);
  THorse.Delete('/usuarios/:id', DeleteUsuario);

  THorse.Listen(9000);
end;

procedure TMeuServicoREST.GetUsuarios(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONArr: TJSONArray;
  JSONObject: TJSONObject;
begin
  SQLQuery.Close;
  SQLQuery.SQL.Text := 'SELECT * FROM usuarios';
  SQLQuery.Open;

  JSONArr := TJSONArray.Create;
  while not SQLQuery.EOF do
  begin
    JSONObject := TJSONObject.Create;
    JSONObject.Add('id', SQLQuery.FieldByName('id').AsInteger);
    JSONObject.Add('nome', SQLQuery.FieldByName('nome').AsString);
    JSONObject.Add('email', SQLQuery.FieldByName('email').AsString);
    JSONObject.Add('ativo', SQLQuery.FieldByName('ativo').AsInteger);
    JSONArr.Add(JSONObject);
    SQLQuery.Next;
  end;

  Res.ContentType('application/json');
  Res.Send<TJSONArray>(JSONArr);
end;

procedure TMeuServicoREST.GetUsuarioPorId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONObject: TJSONObject;
  Id: Integer;
begin
  Id := StrToIntDef(Req.Params['id'], 0);
  SQLQuery.Close;
  SQLQuery.SQL.Text := 'SELECT * FROM usuarios WHERE id = :id';
  SQLQuery.ParamByName('id').AsInteger := Id;
  SQLQuery.Open;

  if SQLQuery.EOF then
  begin
    Res.Status(404);
    Res.Send('Usuário não encontrado');
    Exit;
  end;

  JSONObject := TJSONObject.Create;
  JSONObject.Add('id', SQLQuery.FieldByName('id').AsInteger);
  JSONObject.Add('nome', SQLQuery.FieldByName('nome').AsString);
  JSONObject.Add('email', SQLQuery.FieldByName('email').AsString);
  JSONObject.Add('ativo', SQLQuery.FieldByName('ativo').AsInteger);

  Res.ContentType('application/json');
  Res.Send<TJSONObject>(JSONObject);
end;

procedure TMeuServicoREST.PostUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject(Req.Body<TJSONObject>);

  SQLQuery.Close;
  SQLQuery.SQL.Text := 'INSERT INTO usuarios (nome, email, ativo) VALUES (:nome, :email, :ativo)';
  SQLQuery.ParamByName('nome').AsString := JSONObj.GetValue<string>('nome');
  SQLQuery.ParamByName('email').AsString := JSONObj.GetValue<string>('email');
  SQLQuery.ParamByName('ativo').AsInteger := JSONObj.GetValue<Integer>('ativo', 1);
  SQLQuery.ExecSQL;
  SQLTransaction.Commit;

  Res.Status(201);
  Res.Send('Usuário criado');
end;

procedure TMeuServicoREST.PutUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONObj: TJSONObject;
  Id: Integer;
begin
  Id := StrToIntDef(Req.Params['id'], 0);
  JSONObj := TJSONObject(Req.Body<TJSONObject>);

  SQLQuery.Close;
  SQLQuery.SQL.Text := 'UPDATE usuarios SET nome = :nome, email = :email, ativo = :ativo WHERE id = :id';
  SQLQuery.ParamByName('id').AsInteger := Id;
  SQLQuery.ParamByName('nome').AsString := JSONObj.GetValue<string>('nome');
  SQLQuery.ParamByName('email').AsString := JSONObj.GetValue<string>('email');
  SQLQuery.ParamByName('ativo').AsInteger := JSONObj.GetValue<Integer>('ativo', 1);
  SQLQuery.ExecSQL;
  SQLTransaction.Commit;

  Res.Send('Usuário atualizado');
end;

procedure TMeuServicoREST.DeleteUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Id: Integer;
begin
  Id := StrToIntDef(Req.Params['id'], 0);
  SQLQuery.Close;
  SQLQuery.SQL.Text := 'DELETE FROM usuarios WHERE id = :id';
  SQLQuery.ParamByName('id').AsInteger := Id;
  SQLQuery.ExecSQL;
  SQLTransaction.Commit;

  Res.Send('Usuário excluído');
end;

end.
