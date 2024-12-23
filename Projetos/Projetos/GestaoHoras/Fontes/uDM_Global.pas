unit uDM_Global;

interface

uses
  System.SysUtils, System.Classes, System.Json, System.IOUtils,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  uFuncoes,
  IniFiles,
  uModel.Usuario,

  DataSet.Serialize.Config, DataSet.Serialize,
  RESTRequest4D;

type
  TDM = class(TDataModule)
    FDC_Conexao: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQ_Select: TFDQuery;
    FDQ_Insert: TFDQuery;
    FDQ_Delete: TFDQuery;
    FDQ_Update: TFDQuery;
    FDQ_Usuario: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;

    procedure DataModuleCreate(Sender: TObject);
    procedure FDC_ConexaoBeforeCommit(Sender: TObject);
  private
    FConexao :String;
    FIniFile :TIniFile;
    FEnder :String;

    lTUSUARIO :TUSUARIO;

    procedure CarregarConfigDB(Connection: TFDConnection);
  public
    function Realizar_Login(AEmail,ASenha:String):Boolean;
    function SolicitaToken(const APIN:String):String;

    {$Region 'Sincronizar'}
      function Sinc_Usuario:TJSONObject;
    {$EndRegion 'Sincronizar'}
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.CarregarConfigDB(Connection: TFDConnection);
begin
  FDC_Conexao.Connected := False;
  FDC_Conexao.Params.Values['DriverID'] := 'SQLite';
  {$IFDEF ANDROID}
    FDC_Conexao.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath,'DB_GLOBAL.S3DB');
  {$ENDIF}
  try
    FDC_Conexao.Connected := True;
  except
    On Ex:Exception do
      raise Exception.Create(TPath.Combine(TPath.GetDocumentsPath,'DB_GLOBAL.S3DB') + ' - ' + Ex.Message);
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\FINANCEIRO.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'GESTOR_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  //FDC_Conexao.Connected := True;

  FDC_Conexao.Connected := False;
  FDC_Conexao.Params.Values['DriverID'] := 'SQLite';
  {$IFDEF ANDROID}
    FDC_Conexao.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath,'DB_GLOBAL.S3DB');
  {$ENDIF}
  try
    FDC_Conexao.Connected := True;
  except
    On Ex:Exception do
      raise Exception.Create(TPath.Combine(TPath.GetDocumentsPath,'DB_GLOBAL.S3DB') + ' - ' + Ex.Message);
  end;

end;

procedure TDM.FDC_ConexaoBeforeCommit(Sender: TObject);
begin
  //CarregarConfigDB(FDC_Conexao);
end;

function TDM.Realizar_Login(AEmail, ASenha: String): Boolean;
begin
  try
    try
      Result := False;

      FDQ_Usuario.Active := False;
      FDQ_Usuario.Sql.Clear;
      FDQ_Usuario.Sql.Add('SELECT ');
      FDQ_Usuario.Sql.Add('  U.* ');
      FDQ_Usuario.Sql.Add('FROM USUARIO U ');
      FDQ_Usuario.Sql.Add('WHERE U.SENHA = ' + QuotedStr(ASenha));
      FDQ_Usuario.Sql.Add('  AND U.LOGIN = ' + QuotedStr(AEmail));
      FDQ_Usuario.Active := True;
      if FDQ_Usuario.IsEmpty then
        raise Exception.Create('Usuário ou Senha inválidos')
      else
        Result := True;

    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
  end;
end;

function TDM.Sinc_Usuario: TJSONObject;
var
  lQuery :TFDQuery;
  lHost :String;
  lResp :IResponse;
  lJson :TJSONArray;

begin
  try
    try
      //if not TFuncoes.TestaConexao(FConexao) then
      //  raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      lTUSUARIO := TUSUARIO.Create(FDC_Conexao);


      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := FDC_Conexao;

      lQuery.Active := False;
      lQuery.Sql.Clear;
      lQuery.Sql.Add('SELECT * FROM USUARIO U WHERE U.SINCRONIZADO = 0;');
      lQuery.Active := True;
      if not lQuery.IsEmpty then
      begin
        lJson := lQuery.ToJSONArray;

        lHost := FIniFile.ReadString('SERVER','BASE_URL','');
        if lHost = '' then
          raise Exception.Create('Favor informar a URL de conexão nas Configurações do APP.');

        if lHost = '' then
          raise Exception.Create('Necessário informar o Host...');

        lResp := TRequest.New.BaseURL(lHost)
                 .Resource('usuario')
                 .AddBody(lJson)
                 .Accept('application/json')
                 .Post;

        if lResp.StatusCode = 200 then
        begin
          Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONObject;
          lQuery.Active := False;
          lQuery.SQL.Clear;;
          lTUSUARIO.Marcar_Como_Sincronizado(lQuery);
        end
        else
          raise Exception.Create(lResp.Content);

      end
      else
        raise Exception.Create('Não há usuários para sincronizar');

    except on E: Exception do
      raise Exception.Create('Sinc. Usuario: ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTUSUARIO);
    {$ELSE}
      lQuery.DisposeOf;
      lTUSUARIO.DisposeOf;
    {$ENDIF}
  end;
end;

function TDM.SolicitaToken(const APIN: String): String;
var
  lBody :String;
  lHost :String;
  lResp :IResponse;
  lJson :TJSONObject;

begin
  try
    try
      Result := '';

      if Trim(APIN) = '' then
        raise Exception.Create('Erro ao solicitar Token. PIN do usuário não informado');

      lBody := '';
      lBody := lBody + '{';
      lBody := lBody + '  "login":"",';
      lBody := lBody + '  "senha":"",';
      lBody := lBody + '  "pin":"'+APIN+'"';
      lBody := lBody + '  "}';

      lHost := FIniFile.ReadString('SERVER','BASE_URL','');
      if lHost = '' then
        raise Exception.Create('Favor informar a URL de conexão nas Configurações do APP.');

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      lResp := TRequest.New.BaseURL(lHost)
               .Resource('usuario/login')
               .AddBody(lBody)
               .Accept('application/json')
               .Post;

      if lResp.StatusCode = 200 then
      begin
        lJson := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONObject;
        Result := lJson.GetValue<String>('tokenAuth');
      end
      else
        raise Exception.Create(lResp.Content);

    except on E: Exception do
      raise Exception.Create('Solicitar Token: ' + E.Message);
    end;
  finally

  end;
end;

end.
