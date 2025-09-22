unit uModel.Publico;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,

  DateUtils, System.Math,  System.SysUtils, System.JSON, System.Classes

  ,IniFiles
  ,DataSet.Serialize
  ,uFuncoes.Gerais;

type

  {$Region 'TUsuario'}
  TUsuario = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function Login(FPin, FUsuario, FSenha: String): TJSONObject;
    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ANome:String='';
      ALogin:String='';
      AEmail:String='';
      AStatus:Integer=1):TJSONArray;
    function JSon_ListaEmpresas(APagina:Integer=0; APaginas:Integer=0; AID:Integer=0):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'TUsuario'}

  {$Region 'Regi�es...'}
  TRegioes = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ANome:String='';
      AIBGE:Integer=0):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Regi�es...'}

  {$Region 'Unidades Federativas...'}
  TUnidadesFederativas = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ANome:String='';
      AIBGE:Integer=0;
      ARegiao:String=''):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Unidades Federativas...'}

  {$Region 'Munic�pios...'}
  TMunicipios = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ANome:String='';
      AIBGE:Integer=0;
      AUF_Sgla:String='';
      ARegiao:String=''):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Munic�pios...'}

  {$Region 'Empresa...'}
  TEmpresa = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ARazaoSocial:String='';
      ANomeFantasia:String='';
      ACNPJ:String=''):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Empresa...'}

  {$Region 'Formas de Pagamento...'}
  TFormaPgto = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ANome:String=''):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Formas de Pagamento...'}

  {$Region 'Condi��es de Pagamento...'}
  TCondPgto = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ANome:String=''):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Condi��es de Pagamento...'}

  {$Region 'Condi��es de Pagamento de uma Forma de Pagamento...'}
  TFormaCondPgto = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AId_Forma:Integer=0;
      AId_Cond:Integer=0):TJSONArray;
    function JSon_Listagem_Forma(APagina, APaginas, AId_Forma, AId_Cond, ATipo, AStatus: Integer; AClass:String): TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Condi��es de Pagamento de uma Forma de Pagamento...'}

  {$Region 'Unidades de Medida...'}
  TUnidadesMedida = class
  private
    FConexao :TFDConnection;

  public
    constructor Create(AConexao:TFDConnection);

    function JSon_Listagem(
      APagina:Integer=0;
      APaginas:Integer=0;
      AID:Integer=0;
      ANome:String='';
      ASigla:String=''):TJSONArray;
    function Json_Insert(AJSon:TJSONArray):Boolean;
    function Json_Update(AJSon:TJSONArray):Boolean;
    function Json_Delete(AId:Integer):Boolean;
  end;
  {$EndRegion 'Unidades de Medida...'}

  {$Region 'Projetos'}
    TProjeto = class
    private
      FConexao :TFDConnection;

    public
      constructor Create(AConexao:TFDConnection);

      function JSon_Listagem(
        APagina:Integer=0;
        APaginas:Integer=0;
        AID:Integer=0;
        AStatus:Integer=0;
        ADescricao:String=''):TJSONArray;
      function Json_Insert(AJSon:TJSONArray):Boolean;
      function Json_Update(AJSon:TJSONArray):Boolean;
      function Json_Delete(AId:Integer):Boolean;
    end;
  {$EndRegion 'Projetos'}

  {$Region 'Tipos Formul�rios'}
    TTipos_Forms = class
    private
      FConexao :TFDConnection;

    public
      constructor Create(AConexao:TFDConnection);

      function JSon_Listagem(
        APagina:Integer=0;
        APaginas:Integer=0;
        AID:Integer=0;
        AStatus:Integer=0;
        ATipo:String='';
        ADescricao:String=''):TJSONArray;
      function Json_Insert(AJSon:TJSONArray):Boolean;
      function Json_Update(AJSon:TJSONArray):Boolean;
      function Json_Delete(AId:Integer):Boolean;
    end;
  {$EndRegion 'Tipos Formul�rios'}

  {$Region 'Telas - Projetos'}
    TTelas_Projeto = class
    private
      FConexao :TFDConnection;

    public
      constructor Create(AConexao:TFDConnection);

      function JSon_Listagem(
        APagina:Integer=0;
        APaginas:Integer=0;
        AID:Integer=0;
        AStatus:Integer=0;
        ADescricao:String='';
        AID_Projeto:Integer=0;
        AProjeto:String=''):TJSONArray;
      function Json_Insert(AJSon:TJSONArray):Boolean;
      function Json_Update(AJSon:TJSONArray):Boolean;
      function Json_Delete(AId:Integer):Boolean;
    end;
  {$EndRegion 'Telas - Projetos'}

implementation

{$Region 'TUsuario'}
constructor TUsuario.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TUsuario.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado o Usu�rio a ser Exclu�do');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.usuario where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Usu�rio ' + AId.ToString + ' n�o localizado. A exclus�o ser� cancelada');

      FDQ_Delete.Close;
      FDQ_Delete.Sql.Clear;
      FDQ_Delete.SQL.Add('delete from public.usuario_empresa where id_usuario = ' + AId.ToString);
      FDQ_Delete.ExecSQL;

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.usuario ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TUsuario.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;
  FJson_Empresa :TJSONArray;

  I,J :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        Result := False;
        raise Exception.Create('N�o h� informa��es a serem inseridas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FJson_Empresa := AJSon[I].GetValue<TJSONArray>('empresa',Nil);

        FDQ_Insert.Close;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.usuario ( ');
        FDQ_Insert.Sql.Add('  nome ');
        FDQ_Insert.Sql.Add('  ,login ');
        FDQ_Insert.Sql.Add('  ,senha ');
        FDQ_Insert.Sql.Add('  ,pin ');
        FDQ_Insert.Sql.Add('  ,email ');
        FDQ_Insert.Sql.Add('  ,senha_hash ');
        FDQ_Insert.Sql.Add('  ,tipo ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :nome ');
        FDQ_Insert.Sql.Add('  ,:login ');
        FDQ_Insert.Sql.Add('  ,:senha ');
        FDQ_Insert.Sql.Add('  ,:pin ');
        FDQ_Insert.Sql.Add('  ,:email ');
        FDQ_Insert.Sql.Add('  ,:senha_hash ');
        FDQ_Insert.Sql.Add('  ,:tipo ');
        FDQ_Insert.Sql.Add(') ');
        FDQ_Insert.Sql.Add('returning :id; ');
        FDQ_Insert.ParamByName('nome').AsString := AJSon[I].GetValue<String>('nome','');
        FDQ_Insert.ParamByName('login').AsString := AJSon[I].GetValue<String>('login','');
        FDQ_Insert.ParamByName('senha').AsString := AJSon[I].GetValue<String>('senha','');
        FDQ_Insert.ParamByName('pin').AsString := AJSon[I].GetValue<String>('pin','');
        FDQ_Insert.ParamByName('email').AsString := AJSon[I].GetValue<String>('email','');
        FDQ_Insert.ParamByName('senha_hash').AsString := AJSon[I].GetValue<String>('senhaHash','');
        FDQ_Insert.ParamByName('tipo').AsInteger := AJSon[I].GetValue<Integer>('tipo',2); //Tipo 2 - Normal
        FDQ_Insert.Open;
        FId := FDQ_Insert.ParamByName('id').AsInteger;

        //Empresas do usu�rio...
        if FJson_Empresa.Size > 0 then
        begin
          for J := 0 to Pred(FJson_Empresa.Size) do
          begin
            FDQ_Insert.Close;
            FDQ_Insert.SQL.Clear;
            FDQ_Insert.Sql.Add('INSERT INTO public.usuario_empresa( ');
            FDQ_Insert.Sql.Add('  id_usuario ');
            FDQ_Insert.Sql.Add('  ,id_empresa ');
            FDQ_Insert.Sql.Add('  ,dt_cadastro ');
            FDQ_Insert.Sql.Add('  ,hr_cadastro ');
            FDQ_Insert.Sql.Add(') VALUES( ');
            FDQ_Insert.Sql.Add('  :id_usuario ');
            FDQ_Insert.Sql.Add('  ,:id_empresa ');
            FDQ_Insert.Sql.Add('  ,:dt_cadastro ');
            FDQ_Insert.Sql.Add('  ,:hr_cadastro ');
            FDQ_Insert.Sql.Add('); ');
            FDQ_Insert.ParamByName('id_usuario').AsInteger := FId;
            FDQ_Insert.ParamByName('id_empresa').AsInteger := FJson_Empresa[J].GetValue<Integer>('id',0);
            FDQ_Insert.ParamByName('dt_cadastro').AsDate := Date;
            FDQ_Insert.ParamByName('hr_cadastro').AsTime := Time;
            FDQ_Insert.ExecSQL;
          end;
        end;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TUsuario.JSon_ListaEmpresas(APagina, APaginas, AID: Integer): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  ue.* ');
    FDQ_Select.Sql.Add('  ,u.login ');
    FDQ_Select.Sql.Add('  ,u.nome as usuario ');
    FDQ_Select.Sql.Add('  ,e.razao_social as empresa ');
    FDQ_Select.Sql.Add('from public.usuario_empresa ue ');
    FDQ_Select.Sql.Add('  join public.usuario u on u.id = ue.id_usuario ');
    FDQ_Select.Sql.Add('  join public.empresa e on e.id = ue.id_empresa ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AID > 0 then
      FDQ_Select.Sql.Add('  and ue.id_usuario = ' + AId.ToString);

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;

    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TUsuario.JSon_Listagem(
  APagina:Integer=0;
  APaginas:Integer=0;
  AID:Integer=0;
  ANome:String='';
  ALogin:String='';
  AEmail:String='';
  AStatus:Integer=1): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  u.* ');
    FDQ_Select.Sql.Add('  ,case u.tipo ');
    FDQ_Select.Sql.Add('    when 0 then ''Administrador'' ');
    FDQ_Select.Sql.Add('    when 1 then ''Gerente'' ');
    FDQ_Select.Sql.Add('    when 2 then ''Normal'' ');
    FDQ_Select.Sql.Add('  end tipo_desc ');
    FDQ_Select.Sql.Add('  ,case u.status ');
    FDQ_Select.Sql.Add('    when 0 then ''INATIVO'' ');
    FDQ_Select.Sql.Add('    when 1 then ''ATIVO'' ');
    FDQ_Select.Sql.Add('  end status_desc ');
    FDQ_Select.Sql.Add('from public.usuario u ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AStatus > 0 then
      FDQ_Select.Sql.Add('  and u.status = ' + AStatus.ToString);
    if Trim(AEmail) <> '' then
      FDQ_Select.Sql.Add('  and u.email = ' + QuotedStr(AEmail));
    if Trim(ALogin) <> '' then
      FDQ_Select.Sql.Add('  and u.login = ' + QuotedStr(ALogin));
    if Trim(ANome) <> '' then
      FDQ_Select.Sql.Add('  and u.nome like ' + QuotedStr('%'+ANome+'%') );
    if AID > 0 then
      FDQ_Select.Sql.Add('  and u.id = ' + AId.ToString);

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;

    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TUsuario.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;
  FDQ_Insert :TFDQuery;
  FDQ_Delete :TFDQuery;
  FJson_Empresa :TJSONArray;

  I,J :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;
  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem alteradas');

      for I := 0 to AJSon.Size - 1 do
      begin
        FJson_Empresa := AJSon[I].GetValue<TJSONArray>('empresa',Nil);

        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.usuario u where u.id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
          raise Exception.Create('Usu�rio ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('update public.usuario set ');
        FDQ_Update.Sql.Add('  nome = :nome ');
        FDQ_Update.Sql.Add('  ,email = :email ');
        FDQ_Update.Sql.Add('  ,tipo = :tipo ');
        FDQ_Update.Sql.Add('where id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('nome').AsString := AJSon[I].GetValue<String>('nome','');
        FDQ_Update.ParamByName('email').AsString := AJSon[I].GetValue<String>('email','');
        FDQ_Update.ParamByName('tipo').AsInteger := AJSon[I].GetValue<Integer>('tipo',0);
        FDQ_Update.ExecSQL;

        //Empresa...
        FDQ_Delete.Close;
        FDQ_Delete.Sql.Clear;
        FDQ_Delete.SQL.Add('delete from public.usuario_empresa where id_usuario = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Delete.ExecSQL;

        if FJson_Empresa.Size > 0 then
        begin
          for J := 0 to Pred(FJson_Empresa.Size) do
          begin
            FDQ_Insert.Close;
            FDQ_Insert.SQL.Clear;
            FDQ_Insert.Sql.Add('INSERT INTO public.usuario_empresa( ');
            FDQ_Insert.Sql.Add('  id_usuario ');
            FDQ_Insert.Sql.Add('  ,id_empresa ');
            FDQ_Insert.Sql.Add('  ,dt_cadastro ');
            FDQ_Insert.Sql.Add('  ,hr_cadastro ');
            FDQ_Insert.Sql.Add(') VALUES( ');
            FDQ_Insert.Sql.Add('  :id_usuario ');
            FDQ_Insert.Sql.Add('  ,:id_empresa ');
            FDQ_Insert.Sql.Add('  ,:dt_cadastro ');
            FDQ_Insert.Sql.Add('  ,:hr_cadastro ');
            FDQ_Insert.Sql.Add('); ');
            FDQ_Insert.ParamByName('id_usuario').AsInteger := AJSon[I].GetValue<Integer>('id',0);
            FDQ_Insert.ParamByName('id_empresa').AsInteger := FJson_Empresa[J].GetValue<Integer>('id',0);
            FDQ_Insert.ParamByName('dt_cadastro').AsDate := Date;
            FDQ_Insert.ParamByName('hr_cadastro').AsTime := Time;
            FDQ_Insert.ExecSQL;
          end;
        end;

      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Delete);
  end;
end;

function TUsuario.Login(FPin, FUsuario, FSenha: String): TJSONObject;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FConexao;

      if ((Trim(FPin) = '') and (Trim(FUsuario) = '') and (Trim(FSenha) = '')) then
        raise Exception.Create('E obrigat�rio informar o PIN ou o Usu�rio e a Senha');

      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('select  ');
      FQuery.Sql.Add('  u.* ');
      FQuery.Sql.Add('from public.usuario u ');
      FQuery.Sql.Add('where 1=1 ');
      if (Trim(FPin) <> '') then
        FQuery.Sql.Add('  and u.pin = ' + QuotedStr(FPin))
      else
      begin
        FQuery.Sql.Add('  and u.login = :login ');
        FQuery.ParamByName('login').AsString := FUsuario;
      end;
      FQuery.Active := True;
      if FQuery.IsEmpty then
      begin
        if (Trim(FPin) <> '') then
          raise Exception.Create('PIN informado inv�lido.')
        else
          raise Exception.Create('Usu�rio n�o localizado.');
      end;

      Result := FQuery.ToJSONObject;

    except on E: Exception do
      raise Exception.Create('Login: ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;
{$EndRegion 'TUsuario'}

{$Region 'TRegioes'}
constructor TRegioes.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TRegioes.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Regi�o a ser Exclu�da');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.regioes where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Regi�o ' + AId.ToString + ' n�o localizada. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.regioes ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TRegioes.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem inseridas');

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.regioes( ');
        FDQ_Insert.Sql.Add('  ibge ');
        FDQ_Insert.Sql.Add('  ,nome ');
        FDQ_Insert.Sql.Add('  ,sigla ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :ibge ');
        FDQ_Insert.Sql.Add('  ,:nome ');
        FDQ_Insert.Sql.Add('  ,:sigla ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('ibge').AsInteger := AJSon[I].GetValue<Integer>('ibge',0);
        FDQ_Insert.ParamByName('nome').AsString := AJSon[I].GetValue<String>('nome','');
        FDQ_Insert.ParamByName('sigla').AsString := AJSon[I].GetValue<String>('sigla','');
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TRegioes.JSon_Listagem(APagina, APaginas, AID: Integer; ANome: String; AIBGE: Integer): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  t.* ');
    FDQ_Select.Sql.Add('from regioes t ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AID > 0 then
      FDQ_Select.Sql.Add('  and t.id = ' + AID.ToString);
    if Trim(ANome) <> '' then
      FDQ_Select.Sql.Add('  and t.nome like ' + QuotedStr('%'+ANome+'%'));
    if AIBGE > 0 then
      FDQ_Select.Sql.Add('  and t.ibge = ' + AIBGE.ToString);
    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  t.id ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;

    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TRegioes.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem alteradas');

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.regioes u where u.id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
          raise Exception.Create('Regi�o ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.regioes SET ');
        FDQ_Update.Sql.Add('  id = id ');
        FDQ_Update.Sql.Add('  ,ibge = :ibge ');
        FDQ_Update.Sql.Add('  ,nome = :nome ');
        FDQ_Update.Sql.Add('  ,sigla = :sigla ');
        FDQ_Update.Sql.Add('where id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('ibge').AsInteger := AJSon[I].GetValue<Integer>('ibge',0);
        FDQ_Update.ParamByName('nome').AsString := AJSon[I].GetValue<String>('nome','');
        FDQ_Update.ParamByName('sigla').AsString := AJSon[I].GetValue<String>('sigla','');
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TRegioes'}

{$Region 'TUnidadesFederativas}
constructor TUnidadesFederativas.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TUnidadesFederativas.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Regi�o a ser Exclu�da');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.unidades_federativas where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Unidade Federativa ' + AId.ToString + ' n�o localizada. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.unidades_federativas ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TUnidadesFederativas.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem inseridas');

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.unidades_federativas ( ');
        FDQ_Insert.Sql.Add('  id_regiao ');
        FDQ_Insert.Sql.Add('  ,ibge ');
        FDQ_Insert.Sql.Add('  ,sigla ');
        FDQ_Insert.Sql.Add('  ,descricao ');
        FDQ_Insert.Sql.Add('  ,capital ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :id_regiao ');
        FDQ_Insert.Sql.Add('  ,:ibge ');
        FDQ_Insert.Sql.Add('  ,:sigla ');
        FDQ_Insert.Sql.Add('  ,:descricao ');
        FDQ_Insert.Sql.Add('  ,:capital ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('id_regiao').AsInteger := AJSon[I].GetValue<Integer>('idRegiao',0);
        FDQ_Insert.ParamByName('ibge').AsInteger := AJSon[I].GetValue<Integer>('ibge',0);
        FDQ_Insert.ParamByName('sigla').AsString := AJSon[I].GetValue<String>('sigla','');
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ParamByName('capital').AsString := AJSon[I].GetValue<String>('capital','');
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TUnidadesFederativas.JSon_Listagem(APagina, APaginas, AID: Integer; ANome: String; AIBGE: Integer;
  ARegiao: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  uf.* ');
    FDQ_Select.Sql.Add('  ,r.nome as nome_regiao ');
    FDQ_Select.Sql.Add('from unidades_federativas uf ');
    FDQ_Select.Sql.Add('  join regioes r on r.id = uf.id_regiao ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AID > 0 then
      FDQ_Select.Sql.Add('  and uf.id = ' + AId.ToString);
    if Trim(ANome) <> '' then
      FDQ_Select.Sql.Add('  and uf.descricao like ' + QuotedStr('%'+ANome+'%'));
    if AIBGE > 0 then
      FDQ_Select.Sql.Add('  and uf.ibge = ' + AIBGE.ToString);
    if Trim(ARegiao) <> '' then
      FDQ_Select.Sql.Add('  and r.nome like ' + QuotedStr('%'+ARegiao+'%'));
    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  r.id ');
    FDQ_Select.Sql.Add('  ,uf.id; ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;

    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;

end;

function TUnidadesFederativas.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Unidades Federativas. N�o h� informa��es a serem alteradas');
        raise Exception.Create('N�o h� informa��es a serem alteradas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.unidades_federativas uf where uf.id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
        begin
          TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Unidade Federativa ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');
          raise Exception.Create('Unidade Federativa ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');
        end;

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.unidades_federativas SET ');
        FDQ_Update.Sql.Add('  id_regiao = :id_regiao ');
        FDQ_Update.Sql.Add('  ,ibge = :ibge ');
        FDQ_Update.Sql.Add('  ,sigla = :sigla ');
        FDQ_Update.Sql.Add('  ,descricao = :descricao ');
        FDQ_Update.Sql.Add('  ,capital = :capital ');
        FDQ_Update.Sql.Add('WHERE id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('id_regiao').AsInteger := AJSon[I].GetValue<Integer>('idRegiao',0);
        FDQ_Update.ParamByName('ibge').AsInteger := AJSon[I].GetValue<Integer>('ibge',0);
        FDQ_Update.ParamByName('sigla').AsString := AJSon[I].GetValue<String>('sigla','');
        FDQ_Update.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Update.ParamByName('capital').AsString := AJSon[I].GetValue<String>('capital','');
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Unidades Federativas. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TUnidadesFederativas }

{$Region 'TMunicipios' }
constructor TMunicipios.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TMunicipios.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado o Munic�pio a ser Exclu�do');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.municipios where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Munic�pio ' + AId.ToString + ' n�o localizado. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.municipios ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TMunicipios.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem inseridas');

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.municipios ( ');
        FDQ_Insert.Sql.Add('  id_uf ');
        FDQ_Insert.Sql.Add('  ,sigla_uf ');
        FDQ_Insert.Sql.Add('  ,ibge ');
        FDQ_Insert.Sql.Add('  ,cep_padrao ');
        FDQ_Insert.Sql.Add('  ,descricao ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :id_uf ');
        FDQ_Insert.Sql.Add('  ,:sigla_uf ');
        FDQ_Insert.Sql.Add('  ,:ibge ');
        FDQ_Insert.Sql.Add('  ,:cep_padrao ');
        FDQ_Insert.Sql.Add('  ,:descricao ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('id_uf').AsInteger := AJSon[I].GetValue<Integer>('idUf',0);
        FDQ_Insert.ParamByName('sigla_uf').AsString := AJSon[I].GetValue<String>('siglaUf','');
        FDQ_Insert.ParamByName('ibge').AsInteger := AJSon[I].GetValue<Integer>('ibge',0);
        FDQ_Insert.ParamByName('cep_padrao').AsString := AJSon[I].GetValue<String>('cepPadrao','');
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TMunicipios.JSon_Listagem(APagina, APaginas, AID: Integer; ANome: String; AIBGE: Integer; AUF_Sgla,
  ARegiao: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  m.* ');
    FDQ_Select.Sql.Add('  ,uf.descricao as unidade_federativa ');
    FDQ_Select.Sql.Add('  ,r.nome as regiao ');
    FDQ_Select.Sql.Add('from municipios m ');
    FDQ_Select.Sql.Add('  join unidades_federativas uf on uf.id = m.id_uf ');
    FDQ_Select.Sql.Add('  join regioes r on r.id = uf.id_regiao ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AID > 0 then
      FDQ_Select.Sql.Add('  and m.id = ' + AID.ToString);
    if AIBGE > 0 then
      FDQ_Select.Sql.Add('  and m.ibge = ' + AIBGE.ToString);
    if Trim(AUF_Sgla) <> '' then
      FDQ_Select.Sql.Add('  and uf.sigla = ' + QuotedStr(AUF_Sgla));
    if Trim(ARegiao) <> '' then
      FDQ_Select.Sql.Add('  and r.nome like ' + QuotedStr('%'+ARegiao+'%'));
    if Trim(ANome) <> '' then
      FDQ_Select.Sql.Add('  and m.descricao like ' + QuotedStr('%'+ANome+'%'));
    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  m.id_uf ');
    FDQ_Select.Sql.Add('  ,m.id; ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;
    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TMunicipios.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Munic�pios. N�o h� informa��es a serem alteradas');
        raise Exception.Create('N�o h� informa��es a serem alteradas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.municipios where id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
        begin
          TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Munic�pio ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
          raise Exception.Create('Munic�pio ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
        end;

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.municipios SET ');
        FDQ_Update.Sql.Add('  id_uf = :id_uf ');
        FDQ_Update.Sql.Add('  ,sigla_uf = :sigla_uf ');
        FDQ_Update.Sql.Add('  ,ibge = :ibge ');
        FDQ_Update.Sql.Add('  ,cep_padrao = :cep_padrao ');
        FDQ_Update.Sql.Add('  ,descricao = :descricao ');
        FDQ_Update.Sql.Add('WHERE id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('id_uf').AsInteger := AJSon[I].GetValue<Integer>('idUf',0);
        FDQ_Update.ParamByName('sigla_uf').AsString := AJSon[I].GetValue<String>('siglaUf','');
        FDQ_Update.ParamByName('ibge').AsInteger := AJSon[I].GetValue<Integer>('ibge',0);
        FDQ_Update.ParamByName('cep_padrao').AsString := AJSon[I].GetValue<String>('cepPadrao','');
        FDQ_Update.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Munic�pio. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TMunicipios' }

{$Region 'TEmpresa'}
constructor TEmpresa.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TEmpresa.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Empresa a ser Exclu�da');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.empresa where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Empresa ' + AId.ToString + ' n�o localizada. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('DELETE FROM public.empresa ');
      FDQ_Delete.Sql.Add('WHERE id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TEmpresa.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere Empresa. N�o h� informa��es a serem Inseridas');
        raise Exception.Create('N�o h� informa��es a serem inseridas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.empresa ( ');
        FDQ_Insert.Sql.Add('  status ');
        FDQ_Insert.Sql.Add('  ,tipo ');
        FDQ_Insert.Sql.Add('  ,tipo_pessoa ');
        FDQ_Insert.Sql.Add('  ,razao_social ');
        FDQ_Insert.Sql.Add('  ,fantasia ');
        FDQ_Insert.Sql.Add('  ,cnpj ');
        FDQ_Insert.Sql.Add('  ,insc_estadual ');
        FDQ_Insert.Sql.Add('  ,contato ');
        FDQ_Insert.Sql.Add('  ,endereco ');
        FDQ_Insert.Sql.Add('  ,complemento ');
        FDQ_Insert.Sql.Add('  ,numero ');
        FDQ_Insert.Sql.Add('  ,bairro ');
        FDQ_Insert.Sql.Add('  ,id_cidade ');
        FDQ_Insert.Sql.Add('  ,cidade_ibge ');
        FDQ_Insert.Sql.Add('  ,cidade ');
        FDQ_Insert.Sql.Add('  ,sigla_uf ');
        FDQ_Insert.Sql.Add('  ,cep ');
        FDQ_Insert.Sql.Add('  ,telefone ');
        FDQ_Insert.Sql.Add('  ,celular ');
        FDQ_Insert.Sql.Add('  ,email ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :status ');
        FDQ_Insert.Sql.Add('  ,:tipo ');
        FDQ_Insert.Sql.Add('  ,:tipo_pessoa ');
        FDQ_Insert.Sql.Add('  ,:razao_social ');
        FDQ_Insert.Sql.Add('  ,:fantasia ');
        FDQ_Insert.Sql.Add('  ,:cnpj ');
        FDQ_Insert.Sql.Add('  ,:insc_estadual ');
        FDQ_Insert.Sql.Add('  ,:contato ');
        FDQ_Insert.Sql.Add('  ,:endereco ');
        FDQ_Insert.Sql.Add('  ,:complemento ');
        FDQ_Insert.Sql.Add('  ,:numero ');
        FDQ_Insert.Sql.Add('  ,:bairro ');
        FDQ_Insert.Sql.Add('  ,:id_cidade ');
        FDQ_Insert.Sql.Add('  ,:cidade_ibge ');
        FDQ_Insert.Sql.Add('  ,:cidade ');
        FDQ_Insert.Sql.Add('  ,:sigla_uf ');
        FDQ_Insert.Sql.Add('  ,:cep ');
        FDQ_Insert.Sql.Add('  ,:telefone ');
        FDQ_Insert.Sql.Add('  ,:celular ');
        FDQ_Insert.Sql.Add('  ,:email ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Insert.ParamByName('tipo').AsInteger := AJSon[I].GetValue<Integer>('tipo',0);
        FDQ_Insert.ParamByName('tipo_pessoa').AsInteger := AJSon[I].GetValue<Integer>('tipoPessoa',0);
        FDQ_Insert.ParamByName('razao_social').AsString := AJSon[I].GetValue<String>('razaoSocial','');
        FDQ_Insert.ParamByName('fantasia').AsString := AJSon[I].GetValue<String>('fantasia','');
        FDQ_Insert.ParamByName('cnpj').AsString := AJSon[I].GetValue<String>('cnpj','');
        FDQ_Insert.ParamByName('insc_estadual').AsString := AJSon[I].GetValue<String>('inscEstadual','');
        FDQ_Insert.ParamByName('contato').AsString := AJSon[I].GetValue<String>('contato','');
        FDQ_Insert.ParamByName('endereco').AsString := AJSon[I].GetValue<String>('endereco','');
        FDQ_Insert.ParamByName('complemento').AsString := AJSon[I].GetValue<String>('complemento','');
        FDQ_Insert.ParamByName('numero').AsString := AJSon[I].GetValue<String>('numero','');
        FDQ_Insert.ParamByName('bairro').AsString := AJSon[I].GetValue<String>('bairro','');
        FDQ_Insert.ParamByName('id_cidade').AsInteger := AJSon[I].GetValue<Integer>('idCidade',0);
        FDQ_Insert.ParamByName('cidade_ibge').AsInteger := AJSon[I].GetValue<Integer>('cidadeIbge',0);
        FDQ_Insert.ParamByName('cidade').AsString := AJSon[I].GetValue<String>('cidade','');
        FDQ_Insert.ParamByName('sigla_uf').AsString := AJSon[I].GetValue<String>('siglaUf','');
        FDQ_Insert.ParamByName('cep').AsString := AJSon[I].GetValue<String>('cep','');
        FDQ_Insert.ParamByName('telefone').AsString := AJSon[I].GetValue<String>('telefone','');
        FDQ_Insert.ParamByName('celular').AsString := AJSon[I].GetValue<String>('celular','');
        FDQ_Insert.ParamByName('email').AsString := AJSon[I].GetValue<String>('email','');
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TEmpresa.JSon_Listagem(APagina, APaginas, AID: Integer; ARazaoSocial, ANomeFantasia, ACNPJ: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  e.* ');
    FDQ_Select.Sql.Add('  ,case e.status ');
    FDQ_Select.Sql.Add('    when 0 then ''INATIVO'' ');
    FDQ_Select.Sql.Add('    when 1 then ''ATIVO'' ');
    FDQ_Select.Sql.Add('  end status_desc ');
    FDQ_Select.Sql.Add('  ,case e.tipo ');
    FDQ_Select.Sql.Add('    when 0 then ''MATRIZ'' ');
    FDQ_Select.Sql.Add('    when 1 then ''FILIAL'' ');
    FDQ_Select.Sql.Add('  end tipo_desc ');
    FDQ_Select.Sql.Add('  ,case e.tipo_pessoa ');
    FDQ_Select.Sql.Add('    when 0 then ''F�SICA'' ');
    FDQ_Select.Sql.Add('    when 1 then ''JUR�DICA'' ');
    FDQ_Select.Sql.Add('  end tipo_pessoa_desc ');
    FDQ_Select.Sql.Add('from empresa e  ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AID > 0 then
      FDQ_Select.Sql.Add('  and e.id = ' + AID.ToString);
    if Trim(ARazaoSocial) <> '' then
      FDQ_Select.Sql.Add('  and e.razao_social like ' + QuotedStr('%'+ARazaoSocial+'%'));
    if Trim(ANomeFantasia) <> '' then
      FDQ_Select.Sql.Add('  and e.fantasia like ' + QuotedStr('%'+ANomeFantasia+'%'));
    if Trim(ACNPJ) <> '' then
      FDQ_Select.Sql.Add('  and e.cnpj = ' + QuotedStr(ACNPJ));
    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  e.id; ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;
    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TEmpresa.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Empresa. N�o h� informa��es a serem alteradas');
        raise Exception.Create('N�o h� informa��es a serem alteradas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.empresa where id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
        begin
          TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Empresa ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');
          raise Exception.Create('Empresa ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');
        end;

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.empresa SET ');
        FDQ_Update.Sql.Add('  status = :status ');
        FDQ_Update.Sql.Add('  ,tipo = :tipo ');
        FDQ_Update.Sql.Add('  ,tipo_pessoa = :tipo_pessoa ');
        FDQ_Update.Sql.Add('  ,razao_social = :razao_social ');
        FDQ_Update.Sql.Add('  ,fantasia = :fantasia ');
        FDQ_Update.Sql.Add('  ,cnpj = :cnpj ');
        FDQ_Update.Sql.Add('  ,insc_estadual = :insc_estadual ');
        FDQ_Update.Sql.Add('  ,contato = :contato ');
        FDQ_Update.Sql.Add('  ,endereco = :endereco ');
        FDQ_Update.Sql.Add('  ,complemento = :complemento ');
        FDQ_Update.Sql.Add('  ,numero = :numero ');
        FDQ_Update.Sql.Add('  ,bairro = :bairro ');
        FDQ_Update.Sql.Add('  ,id_cidade = :id_cidade ');
        FDQ_Update.Sql.Add('  ,cidade_ibge = :cidade_ibge ');
        FDQ_Update.Sql.Add('  ,cidade = :cidade ');
        FDQ_Update.Sql.Add('  ,sigla_uf = :sigla_uf ');
        FDQ_Update.Sql.Add('  ,cep = :cep ');
        FDQ_Update.Sql.Add('  ,telefone = :telefone ');
        FDQ_Update.Sql.Add('  ,celular = :celular ');
        FDQ_Update.Sql.Add('  ,email = :email ');
        FDQ_Update.Sql.Add('WHERE id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Update.ParamByName('tipo').AsInteger := AJSon[I].GetValue<Integer>('tipo',0);
        FDQ_Update.ParamByName('tipo_pessoa').AsInteger := AJSon[I].GetValue<Integer>('tipoPessoa',0);
        FDQ_Update.ParamByName('razao_social').AsString := AJSon[I].GetValue<String>('razaoSocial','');
        FDQ_Update.ParamByName('fantasia').AsString := AJSon[I].GetValue<String>('fantasia','');
        FDQ_Update.ParamByName('cnpj').AsString := AJSon[I].GetValue<String>('cnpj','');
        FDQ_Update.ParamByName('insc_estadual').AsString := AJSon[I].GetValue<String>('inscEstadual','');
        FDQ_Update.ParamByName('contato').AsString := AJSon[I].GetValue<String>('contato','');
        FDQ_Update.ParamByName('endereco').AsString := AJSon[I].GetValue<String>('endereco','');
        FDQ_Update.ParamByName('complemento').AsString := AJSon[I].GetValue<String>('complemento','');
        FDQ_Update.ParamByName('numero').AsString := AJSon[I].GetValue<String>('numero','');
        FDQ_Update.ParamByName('bairro').AsString := AJSon[I].GetValue<String>('bairro','');
        FDQ_Update.ParamByName('id_cidade').AsInteger := AJSon[I].GetValue<Integer>('idCidade',0);
        FDQ_Update.ParamByName('cidade_ibge').AsInteger := AJSon[I].GetValue<Integer>('cidadeIbge',0);
        FDQ_Update.ParamByName('cidade').AsString := AJSon[I].GetValue<String>('cidade','');
        FDQ_Update.ParamByName('sigla_uf').AsString := AJSon[I].GetValue<String>('siglaUf','');
        FDQ_Update.ParamByName('cep').AsString := AJSon[I].GetValue<String>('cep','');
        FDQ_Update.ParamByName('telefone').AsString := AJSon[I].GetValue<String>('telefone','');
        FDQ_Update.ParamByName('celular').AsString := AJSon[I].GetValue<String>('celular','');
        FDQ_Update.ParamByName('email').AsString := AJSon[I].GetValue<String>('email','');
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Empresa. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TEmpresa'}

{$Region 'TFormaPgto'}
constructor TFormaPgto.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TFormaPgto.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Forma de Pagamento a ser Exclu�da');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.formas_pagamento where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Forma de Pagamento ' + AId.ToString + ' n�o localizada. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.formas_pagamento ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TFormaPgto.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;
  FJsonCond :TJSONArray;

  I,X :Integer;
  FId :Integer;
begin

  Result := True;
  //FJsonCond := TJSONArray.Create;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem inseridas');

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.formas_pagamento( ');
        FDQ_Insert.Sql.Add('  forma_pagamento ');
        FDQ_Insert.Sql.Add('  ,descricao ');
        FDQ_Insert.Sql.Add('  ,status ');
        FDQ_Insert.Sql.Add('  ,tipo ');
        FDQ_Insert.Sql.Add('  ,classificacao ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :forma_pagamento ');
        FDQ_Insert.Sql.Add('  ,:descricao ');
        FDQ_Insert.Sql.Add('  ,:status ');
        FDQ_Insert.Sql.Add('  ,:tipo ');
        FDQ_Insert.Sql.Add('  ,:classificacao ');
        FDQ_Insert.Sql.Add(') ');
        FDQ_Insert.Sql.Add('RETURNING ID; ');
        FDQ_Insert.ParamByName('forma_pagamento').AsString := AJSon[I].GetValue<String>('formaPagamento','');
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Insert.ParamByName('tipo').AsInteger := AJSon[I].GetValue<Integer>('tipo',1);
        FDQ_Insert.ParamByName('classificacao').AsString := AJSon[I].GetValue<String>('classificacao','');
        FDQ_Insert.Active := True;
        FId := FDQ_Insert.FieldByName('id').AsInteger;

        {$Region 'Condi��es da Forma de Pagamento'}
          FJsonCond := AJSon[I].GetValue<TJSONArray>('condPagto',Nil);
          if FJsonCond.Size > 0 then
          begin
            for X := 0 to FJsonCond.Size - 1 do
            begin
              FDQ_Insert.Active := False;
              FDQ_Insert.SQL.Clear;
              FDQ_Insert.Sql.Add('INSERT INTO public.forma_cond_pagto( ');
              FDQ_Insert.Sql.Add('  id_forma_pagamento ');
              FDQ_Insert.Sql.Add('  ,id_condicao_pagamento ');
              FDQ_Insert.Sql.Add(') VALUES( ');
              FDQ_Insert.Sql.Add('  :id_forma_pagamento ');
              FDQ_Insert.Sql.Add('  ,:id_condicao_pagamento ');
              FDQ_Insert.Sql.Add('); ');
              FDQ_Insert.ParamByName('id_forma_pagamento').AsInteger := FId;
              FDQ_Insert.ParamByName('id_condicao_pagamento').AsInteger := FJsonCond[X].GetValue<Integer>('idcondicaopagamento',0);
              FDQ_Insert.ExecSQL;
            end;
          end;
        {$EndRegion 'Condi��es da Forma de Pagamento'}
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TFormaPgto.JSon_Listagem(APagina, APaginas, AID: Integer; ANome: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
  FForma :TJSONArray;
  FCondicao :TJSONArray;
  FCondForma :TJSONObject;
  I :Integer;
  FPos :String;
begin
  try
    try
      FPos := '000';
      FDQ_Select := TFDQuery.Create(Nil);
      FDQ_Select.Connection := FConexao;
      FCondForma := TJSONObject.Create;

      if APaginas > 0 then
        FPaginas := APaginas;

      FPos := '001';
      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select ');
      FDQ_Select.Sql.Add('  t.* ');
      FDQ_Select.Sql.Add('	,case t.status ');
      FDQ_Select.Sql.Add('    when 0 then ''INATIVO'' ');
      FDQ_Select.Sql.Add('    when 1 then ''ATIVO'' ');
      FDQ_Select.Sql.Add('  end status_desc ');
      FDQ_Select.Sql.Add('	,case t.tipo ');
      FDQ_Select.Sql.Add('    when 0 then ''A VISTA'' ');
      FDQ_Select.Sql.Add('    when 1 then ''A PRAZO'' ');
      FDQ_Select.Sql.Add('  end tipo_desc ');
      FDQ_Select.Sql.Add('from formas_pagamento t ');
      FDQ_Select.Sql.Add('where 1=1 ');
      if Trim(ANome) <> '' then
        FDQ_Select.Sql.Add('  and t.forma_pagamento like ' + QuotedStr('%'+ANome+'%') );
      if AID > 0 then
        FDQ_Select.Sql.Add('  and t.id = ' + AId.ToString);

      if ((APagina > 0) and (APaginas > 0))  then
      begin
        FPagina := (((APagina - 1) * FPaginas) + 1);
        FPaginas := (APagina * FPaginas);
        FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
      end;
      FDQ_Select.Active := True;
      FPos := '002';
      FForma := FDQ_Select.ToJSONArray;

      {$Region 'Inserindo condi��es'}
        FPos := '003';
        if FForma.Size > 0 then
        begin
          for I := 0 to FForma.Size - 1 do
          begin
            //FCondicao := TJSONArray.Create;
            FDQ_Select.Active := False;
            FDQ_Select.Sql.Clear;
            FDQ_Select.Sql.Add('select ');
            FDQ_Select.Sql.Add('  fcp.id_forma_pagamento ');
            FDQ_Select.Sql.Add('  ,fcp.id_condicao_pagamento ');
            FDQ_Select.Sql.Add('  ,cp.condicao_pagamento ');
            FDQ_Select.Sql.Add('  ,cp.descricao ');
            FDQ_Select.Sql.Add('  ,cp.parcelas ');
            FDQ_Select.Sql.Add('  ,cp.intervalo ');
            FDQ_Select.Sql.Add('  ,cp.juros ');
            FDQ_Select.Sql.Add('  ,cp.descontos ');
            FDQ_Select.Sql.Add('from forma_cond_pagto fcp ');
            FDQ_Select.Sql.Add('  join condicao_pagamento cp on cp.id = fcp.id_condicao_pagamento ');
            FDQ_Select.Sql.Add('                            and cp.status = 1 ');
            FDQ_Select.Sql.Add('where fcp.id_forma_pagamento = :id_forma_pagamento');
            FDQ_Select.Sql.Add('order by ');
            FDQ_Select.Sql.Add('  fcp.id_condicao_pagamento; ');
            FDQ_Select.ParamByName('id_forma_pagamento').AsInteger := FForma[I].GetValue<Integer>('id',0);
            FDQ_Select.Active := True;
            FPos := '004';
            (FForma[I] as TJSONObject).AddPair('condicoes',FDQ_Select.ToJSONArray);
          end;
        end;
      {$EndRegion 'Inserindo condi��es'}

      FPos := '006';
      Result := FForma;
    except on E: Exception do
      raise Exception.Create(FPos + ' - ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
      //FreeAndNil(FForma);
    {$ELSE}
      FDQ_Select.DisposeOf;
      //FForma.DisposeOf;
    {$ENDIF}
  end;
end;

function TFormaPgto.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
  FJsonCond :TJSONArray;

  I,X :Integer;
begin

  Result := True;
  //FJsonCond := TJSONArray.Create;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem alteradas');

      for I := 0 to (AJSon.Size - 1) do
      begin
        FJsonCond := AJSon[I].GetValue<TJSONArray>('condPagto',Nil);

        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.formas_pagamento where id = ' + IntToStr(AJSon[I].GetValue<Integer>('id',0)));
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
          raise Exception.Create('Forma de Pagamento ' + IntToStr(AJSon[I].GetValue<Integer>('id',0)) + ' n�o localizada. As altera��es ser�o canceladas');

        //Alterando registros...
        if AJSon[I].GetValue<Integer>('id',0) > 0 then
        begin
          FDQ_Update.Active := False;
          FDQ_Update.SQL.Clear;
          FDQ_Update.Sql.Add('UPDATE public.formas_pagamento SET ');
          FDQ_Update.Sql.Add('  id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
          FDQ_Update.Sql.Add('  ,forma_pagamento = ' + QuotedStr(AJSon[I].GetValue<String>('formaPagamento','')));
          FDQ_Update.Sql.Add('  ,descricao = ' + QuotedStr(AJSon[I].GetValue<String>('descricao','')));
          FDQ_Update.Sql.Add('  ,status = ' + AJSon[I].GetValue<Integer>('status',1).ToString);
          FDQ_Update.Sql.Add('  ,tipo = ' + AJSon[I].GetValue<Integer>('tipo',0).ToString);
          FDQ_Update.Sql.Add('  ,classificacao = ' + QuotedStr(AJSon[I].GetValue<String>('classificacao','')));
          FDQ_Update.Sql.Add('where id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
          FDQ_Update.ExecSQL;

          {$Region 'Condi��es da Forma de Pagamento'}
            if Assigned(FJsonCond) then
            begin
              if FJsonCond.Size > 0 then
              begin
                FDQ_Delete.Active := False;
                FDQ_Delete.SQL.Clear;
                FDQ_Delete.Sql.Add('delete from public.forma_cond_pagto where id_forma_pagamento = :id_forma_pagamento');
                FDQ_Delete.ParamByName('id_forma_pagamento').AsInteger := AJSon[0].GetValue<Integer>('id',0);
                FDQ_Delete.ExecSQL;

                for X := 0 to (FJsonCond.Size - 1) do
                begin
                  FDQ_Update.Active := False;
                  FDQ_Update.SQL.Clear;
                  FDQ_Update.Sql.Add('INSERT INTO public.forma_cond_pagto( ');
                  FDQ_Update.Sql.Add('  id_forma_pagamento ');
                  FDQ_Update.Sql.Add('  ,id_condicao_pagamento ');
                  FDQ_Update.Sql.Add(') VALUES( ');
                  FDQ_Update.Sql.Add('  :id_forma_pagamento ');
                  FDQ_Update.Sql.Add('  ,:id_condicao_pagamento ');
                  FDQ_Update.Sql.Add('); ');
                  FDQ_Update.ParamByName('id_forma_pagamento').AsInteger := FJsonCond[X].GetValue<Integer>('idformapagamento',0);
                  FDQ_Update.ParamByName('id_condicao_pagamento').AsInteger := FJsonCond[X].GetValue<Integer>('idcondicaopagamento',0);
                  FDQ_Update.ExecSQL;
                end;

              end;
            end;
          {$EndRegion 'Condi��es da Forma de Pagamento'}
        end;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
    FreeAndNil(FDQ_Delete);
  end;
end;
{$EndRegion 'TFormaPgto'}

{$Region 'TCondPgto'}
constructor TCondPgto.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TCondPgto.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Condi��o de Pagamento a ser Exclu�da');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.condicao_pagamento where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Condi��o de Pagamento ' + AId.ToString + ' n�o localizada. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.condicao_pagamento ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TCondPgto.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem inseridas');

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.condicao_pagamento( ');
        FDQ_Insert.Sql.Add('  condicao_pagamento ');
        FDQ_Insert.Sql.Add('  ,descricao ');
        FDQ_Insert.Sql.Add('  ,parcelas ');
        FDQ_Insert.Sql.Add('  ,intervalo ');
        FDQ_Insert.Sql.Add('  ,juros ');
        FDQ_Insert.Sql.Add('  ,descontos ');
        FDQ_Insert.Sql.Add('  ,status ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :condicao_pagamento ');
        FDQ_Insert.Sql.Add('  ,:descricao ');
        FDQ_Insert.Sql.Add('  ,:parcelas ');
        FDQ_Insert.Sql.Add('  ,:intervalo ');
        FDQ_Insert.Sql.Add('  ,:juros ');
        FDQ_Insert.Sql.Add('  ,:descontos ');
        FDQ_Insert.Sql.Add('  ,:status ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('condicao_pagamento').AsString := AJSon[I].GetValue<String>('condicaoPagamento','');
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ParamByName('parcelas').AsInteger := AJSon[I].GetValue<Integer>('parcelas',1);
        FDQ_Insert.ParamByName('intervalo').AsInteger := AJSon[I].GetValue<Integer>('intervalo',0);
        FDQ_Insert.ParamByName('juros').AsFloat := AJSon[I].GetValue<Double>('juros',0);
        FDQ_Insert.ParamByName('descontos').AsFloat := AJSon[I].GetValue<Double>('descontos',0);
        FDQ_Insert.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TCondPgto.JSon_Listagem(APagina, APaginas, AID: Integer; ANome: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  t.* ');
    FDQ_Select.Sql.Add('  ,case t.status ');
    FDQ_Select.Sql.Add('    when 0 then ''INATIVO'' ');
    FDQ_Select.Sql.Add('    when 1 then ''ATIVO'' ');
    FDQ_Select.Sql.Add('  end status_desc ');
    FDQ_Select.Sql.Add('from condicao_pagamento t ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AID > 0 then
      FDQ_Select.Sql.Add('  and t.id = ' + AID.ToString);
    if Trim(ANome) <> '' then
      FDQ_Select.Sql.Add('  and t.condicao_pagamento like ' + QuotedStr('%'+ANome+'%'));
    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  t.id ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;

    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TCondPgto.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem alteradas');

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.condicao_pagamento u where u.id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
          raise Exception.Create('Condi��o de Pagamento ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.condicao_pagamento SET ');
        FDQ_Update.Sql.Add('  id = id ');
        if Trim(AJSon[I].GetValue<String>('condicaoPagamento','')) <> '' then
        begin
          FDQ_Update.Sql.Add('  ,condicao_pagamento = :condicao_pagamento ');
          FDQ_Update.ParamByName('condicao_pagamento').AsString := AJSon[I].GetValue<String>('condicaoPagamento','')
        end;
        if Trim(AJSon[I].GetValue<String>('descricao','')) <> '' then
        begin
          FDQ_Update.Sql.Add('  ,descricao = :descricao ');
          FDQ_Update.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','')
        end;
        if AJSon[I].GetValue<Integer>('parcelas',0) >= 0 then
        begin
          FDQ_Update.Sql.Add('  ,parcelas = :parcelas ');
          FDQ_Update.ParamByName('parcelas').AsInteger := AJSon[I].GetValue<Integer>('parcelas',0)
        end;
        if AJSon[I].GetValue<Integer>('intervalo',0) >= 0 then
        begin
          FDQ_Update.Sql.Add('  ,intervalo = :intervalo ');
          FDQ_Update.ParamByName('intervalo').AsInteger := AJSon[I].GetValue<Integer>('intervalo',0)
        end;
        if AJSon[I].GetValue<Double>('juros',0) >= 0 then
        begin
          FDQ_Update.Sql.Add('  ,juros = :juros ');
          FDQ_Update.ParamByName('juros').AsFloat := AJSon[I].GetValue<Double>('juros',0)
        end;
        if AJSon[I].GetValue<Double>('descontos',0) >= 0 then
        begin
          FDQ_Update.Sql.Add('  ,descontos = :descontos ');
          FDQ_Update.ParamByName('descontos').AsFloat := AJSon[I].GetValue<Double>('descontos',0)
        end;
        FDQ_Update.Sql.Add('  ,status = :status ');
        FDQ_Update.Sql.Add('where id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TCondPgto'}

{$Region 'TFormaCondPgto'}
constructor TFormaCondPgto.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TFormaCondPgto.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Condi��o de Pagamento da Forma de Pagamento a ser Exclu�da');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.forma_cond_pagto where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Condi��o de Pagamento da Forma de Pagamento' + AId.ToString + ' n�o localizada. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.forma_cond_pagto ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TFormaCondPgto.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
        raise Exception.Create('N�o h� informa��es a serem inseridas');

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.forma_cond_pagto( ');
        FDQ_Insert.Sql.Add('  id_forma_pagamento ');
        FDQ_Insert.Sql.Add('  ,id_condicao_pagamento ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :id_forma_pagamento ');
        FDQ_Insert.Sql.Add('  ,:id_condicao_pagamento ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('id_forma_pagamento').AsInteger := AJSon[I].GetValue<Integer>('idFormaPagamento',0);
        FDQ_Insert.ParamByName('id_condicao_pagamento').AsInteger := AJSon[I].GetValue<Integer>('idCondicaoPagamento',0);
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TFormaCondPgto.JSon_Listagem(APagina, APaginas, AId_Forma, AId_Cond: Integer): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('	fcp.* ');
    FDQ_Select.Sql.Add('  ,fp.forma_pagamento ');
    FDQ_Select.Sql.Add('  ,fp.descricao as forma_pagamento_desc ');
    FDQ_Select.Sql.Add('  ,fp.tipo ');
    FDQ_Select.Sql.Add('  ,case fp.tipo ');
    FDQ_Select.Sql.Add('    when 0 then ''A VISTA'' ');
    FDQ_Select.Sql.Add('    when 1 then ''A PRAZO'' ');
    FDQ_Select.Sql.Add('  end fp_tipo_desc ');
    FDQ_Select.Sql.Add('  ,fp.classificacao ');
    FDQ_Select.Sql.Add('  ,cp.condicao_pagamento ');
    FDQ_Select.Sql.Add('  ,cp.descricao as cond_pagamento_desc ');
    FDQ_Select.Sql.Add('  ,cp.parcelas ');
    FDQ_Select.Sql.Add('  ,cp.intervalo ');
    FDQ_Select.Sql.Add('  ,cp.juros ');
    FDQ_Select.Sql.Add('  ,cp.descontos ');
    FDQ_Select.Sql.Add('from forma_cond_pagto fcp ');
    FDQ_Select.Sql.Add('  join formas_pagamento fp on fp.id = fcp.id_forma_pagamento ');
    FDQ_Select.Sql.Add('                          and fp.status = 1 ');
    FDQ_Select.Sql.Add('  join condicao_pagamento cp on cp.id = fcp.id_condicao_pagamento ');
    FDQ_Select.Sql.Add('                            and cp.status = 1 ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AId_Forma > 0 then
      FDQ_Select.Sql.Add('  and fcp.id_forma_pagamento = ' + AId_Forma.ToString);
    if AId_Cond > 0 then
      FDQ_Select.Sql.Add('  and fcp.id_condicao_pagamento = ' + AId_Cond.ToString);
    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  fp.id ');
    FDQ_Select.Sql.Add('  ,cp.id ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;

    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TFormaCondPgto.JSon_Listagem_Forma(APagina, APaginas, AId_Forma, AId_Cond, ATipo, AStatus: Integer;
  AClass: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select distinct ');
    FDQ_Select.Sql.Add('  fcp.id_forma_pagamento ');
    FDQ_Select.Sql.Add('  ,fp.forma_pagamento ');
    FDQ_Select.Sql.Add('  ,fp.descricao as forma_pagamento_desc ');
    FDQ_Select.Sql.Add('  ,fp.tipo ');
    FDQ_Select.Sql.Add('  ,case fp.tipo ');
    FDQ_Select.Sql.Add('    when 0 then ''A VISTA'' ');
    FDQ_Select.Sql.Add('    when 1 then ''A PRAZO'' ');
    FDQ_Select.Sql.Add('  end fp_tipo_desc ');
    FDQ_Select.Sql.Add('  ,fp.classificacao ');
    FDQ_Select.Sql.Add('from public.forma_cond_pagto fcp ');
    FDQ_Select.Sql.Add('  join public.formas_pagamento fp on fp.id = fcp.id_forma_pagamento ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AId_Forma > 0 then
      FDQ_Select.Sql.Add('  and fcp.id_forma_pagamento = ' + AId_Forma.ToString);
    if ATipo > 0 then
      FDQ_Select.Sql.Add('  and fp.tipo = ' + ATipo.ToString);
    if Trim(AClass) <> '' then
      FDQ_Select.Sql.Add('  and fp.classificacao = ' + QuotedStr(AClass));
    if AStatus >= 0 then
      FDQ_Select.Sql.Add('  and fp.status = ' + AStatus.ToString);

    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  fcp.id_forma_pagamento ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;

    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TFormaCondPgto.Json_Update(AJSon: TJSONArray): Boolean;
begin
  raise Exception.Create('N�o h� altera��es para essa Rota');
end;
{$EndRegion 'TFormaCondPgto'}

{$Region 'TUnidadesMedida'}
constructor TUnidadesMedida.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TUnidadesMedida.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Unidade de Medida a ser Exclu�da');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.unidades_medidas where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Unidade de Medida ' + AId.ToString + ' n�o localizada. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('delete from public.unidades_medidas ');
      FDQ_Delete.Sql.Add('where id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TUnidadesMedida.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere Unidade de Medida. N�o h� informa��es a serem Inseridas');
        raise Exception.Create('N�o h� informa��es a serem inseridas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.unidades_medidas ( ');
        FDQ_Insert.Sql.Add('  id_fiscal ');
        FDQ_Insert.Sql.Add('  ,sigla ');
        FDQ_Insert.Sql.Add('  ,descricao ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :id_fiscal ');
        FDQ_Insert.Sql.Add('  ,:sigla ');
        FDQ_Insert.Sql.Add('  ,:descricao ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('id_fiscal').AsInteger := AJSon[I].GetValue<Integer>('idFiscal',0);
        FDQ_Insert.ParamByName('sigla').AsString := AJSon[I].GetValue<String>('sigla','');
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TUnidadesMedida.JSon_Listagem(APagina, APaginas, AID: Integer; ANome, ASigla: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    FDQ_Select.Active := False;
    FDQ_Select.Sql.Clear;
    FDQ_Select.Sql.Add('select ');
    FDQ_Select.Sql.Add('  um.* ');
    FDQ_Select.Sql.Add('from unidades_medidas um ');
    FDQ_Select.Sql.Add('where 1=1 ');
    if AID > 0 then
      FDQ_Select.Sql.Add('  and um.id = ' + AID.ToString);
    if Trim(ASigla) <> '' then
      FDQ_Select.Sql.Add('  and um.sigla = ' + QuotedStr(ASigla));
    if Trim(ANome) <> '' then
      FDQ_Select.Sql.Add('  and um.descricao like ' + QuotedStr('%'+ANome+'%'));
    FDQ_Select.Sql.Add('order by ');
    FDQ_Select.Sql.Add('  um.id; ');

    if ((APagina > 0) and (APaginas > 0))  then
    begin
      FPagina := (((APagina - 1) * FPaginas) + 1);
      FPaginas := (APagina * FPaginas);
      FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
    end;
    FDQ_Select.Active := True;

    Result := FDQ_Select.ToJSONArray;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TUnidadesMedida.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Unidade de Medida. N�o h� informa��es a serem alteradas');
        raise Exception.Create('N�o h� informa��es a serem alteradas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.unidades_medidas where id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
        begin
          TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Unidade de Medida ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');
          raise Exception.Create('Unidade de Medida ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizada. As altera��es ser�o canceladas');
        end;

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.unidades_medidas SET ');
        FDQ_Update.Sql.Add('  id_fiscal = :id_fiscal ');
        FDQ_Update.Sql.Add('  ,sigla = :sigla ');
        FDQ_Update.Sql.Add('  ,descricao = :descricao ');
        FDQ_Update.Sql.Add('WHERE id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('id_fiscal').AsInteger := AJSon[I].GetValue<Integer>('idFiscal',0);
        FDQ_Update.ParamByName('sigla').AsString := AJSon[I].GetValue<String>('sigla','');
        FDQ_Update.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Unidade de Medida. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TUnidadesMedida'}

{$Region 'TProjeto'}
constructor TProjeto.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TProjeto.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado o Projeto a ser Exclu�do');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.projetos where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Projeto ' + AId.ToString + ' n�o localizado. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('DELETE FROM public.projetos ');
      FDQ_Delete.Sql.Add('WHERE id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Exclui Projeto. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Exclui Projeto. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TProjeto.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere Projetos. N�o h� informa��es a serem Inseridas');
        raise Exception.Create('N�o h� informa��es a serem inseridas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.projetos ( ');
        FDQ_Insert.Sql.Add('  descricao ');
        FDQ_Insert.Sql.Add('  ,dt_cadastro ');
        FDQ_Insert.Sql.Add('  ,hr_cadastro ');
        FDQ_Insert.Sql.Add('  ,status ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :descricao ');
        FDQ_Insert.Sql.Add('  ,:dt_cadastro ');
        FDQ_Insert.Sql.Add('  ,:hr_cadastro ');
        FDQ_Insert.Sql.Add('  ,:status ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Insert.ParamByName('dt_cadastro').AsDate := Date;
        FDQ_Insert.ParamByName('hr_cadastro').AsTime := Time;
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except
      on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere dados Projetos. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere dados Projetos. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TProjeto.JSon_Listagem(APagina:Integer=0;APaginas:Integer=0;AID:Integer=0;AStatus:Integer=0;ADescricao:String=''):TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    try
      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select ');
      FDQ_Select.Sql.Add('  p.* ');
      FDQ_Select.Sql.Add('  ,case p.status ');
      FDQ_Select.Sql.Add('    when 0 then ''INATIVO'' ');
      FDQ_Select.Sql.Add('    when 1 then ''ATIVO'' ');
      FDQ_Select.Sql.Add('  end status_desc ');
      FDQ_Select.Sql.Add('from public.projetos p ');
      FDQ_Select.Sql.Add('where 1=1 ');
      if AID > 0 then
        FDQ_Select.Sql.Add('  and p.id = ' + AID.ToString);
      if Trim(ADescricao) <> '' then
        FDQ_Select.Sql.Add('  and p.descricao like ' + QuotedStr('%'+ADescricao+'%'));
      if AStatus <> 2 then
        FDQ_Select.Sql.Add('  and p.status = ' + AStatus.ToString);

      FDQ_Select.Sql.Add('order by p.id; ');

      if ((APagina > 0) and (APaginas > 0))  then
      begin
        FPagina := (((APagina - 1) * FPaginas) + 1);
        FPaginas := (APagina * FPaginas);
        FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
      end;
      FDQ_Select.Active := True;

      Result := FDQ_Select.ToJSONArray;

    except
      on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Listando Projetos. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Listando Projetos. Banco de dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TProjeto.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Projetos. N�o h� informa��es a serem alteradas');
        raise Exception.Create('N�o h� informa��es a serem alteradas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.projetos where id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
        begin
          TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Projetos ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
          raise Exception.Create('Projetos ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
        end;

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.projetos SET ');
        FDQ_Update.Sql.Add('  descricao = :descricao ');
        FDQ_Update.Sql.Add('  ,status = :status ');
        FDQ_Update.Sql.Add('WHERE id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Update.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',0);
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except
      on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Atualiza dados Projetos. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Atualiza dados Projetos. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TProjeto'}

{$Region 'TTelas_Projeto' }
constructor TTelas_Projeto.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TTelas_Projeto.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado a Tela do Formul�rio a ser Exclu�do');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.telas_projetos where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Tela do Formul�rio ' + AId.ToString + ' n�o localizado. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('DELETE FROM public.telas_projetos ');
      FDQ_Delete.Sql.Add('WHERE id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Exclui Tela do Formujl�rio. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Exclui Tela do Formul�rio. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TTelas_Projeto.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere Telas do Projeto. N�o h� informa��es a serem Inseridas');
        raise Exception.Create('N�o h� informa��es a serem inseridas');
      end;

      TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', AJson.ToString);


      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.telas_projetos ( ');
        FDQ_Insert.Sql.Add('  id_projeto ');
        FDQ_Insert.Sql.Add('  ,nome_form ');
        FDQ_Insert.Sql.Add('  ,descricao ');
        FDQ_Insert.Sql.Add('  ,id_tipo_form ');
        FDQ_Insert.Sql.Add('  ,status ');
        FDQ_Insert.Sql.Add('  ,dt_cadastro ');
        FDQ_Insert.Sql.Add('  ,hr_cadastro ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :id_projeto ');
        FDQ_Insert.Sql.Add('  ,:nome_form ');
        FDQ_Insert.Sql.Add('  ,:descricao ');
        FDQ_Insert.Sql.Add('  ,:id_tipo_form ');
        FDQ_Insert.Sql.Add('  ,:status ');
        FDQ_Insert.Sql.Add('  ,:dt_cadastro ');
        FDQ_Insert.Sql.Add('  ,:hr_cadastro ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('id_projeto').AsInteger := AJSon[I].GetValue<Integer>('idprojeto',0);
        FDQ_Insert.ParamByName('nome_form').AsString := AJSon[I].GetValue<String>('nomeform','');
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ParamByName('id_tipo_form').AsInteger := AJSon[I].GetValue<Integer>('idtipoform',0);
        FDQ_Insert.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Insert.ParamByName('dt_cadastro').AsDate := Date;
        FDQ_Insert.ParamByName('hr_cadastro').AsTime := Time;
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except
      on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere dados Telas do Projeto. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere dados Telas do Projeto. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TTelas_Projeto.JSon_Listagem(APagina, APaginas, AID, AStatus: Integer; ADescricao: String; AID_Projeto: Integer;
  AProjeto: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    try
      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('SELECT ');
      FDQ_Select.Sql.Add('  tp.* ');
      FDQ_Select.Sql.Add('  ,case tp.status ');
      FDQ_Select.Sql.Add('    when 0 then ''INATIVO'' ');
      FDQ_Select.Sql.Add('    when 1 then ''ATIVO'' ');
      FDQ_Select.Sql.Add('  end status_desc ');
      FDQ_Select.Sql.Add('  ,case tf.tipo ');
      FDQ_Select.Sql.Add('    when 0 then ''LOGIN'' ');
      FDQ_Select.Sql.Add('    when 1 then ''CONFIG'' ');
      FDQ_Select.Sql.Add('    when 2 then ''PRINCIPAL'' ');
      FDQ_Select.Sql.Add('    when 3 then ''CADASTRO'' ');
      FDQ_Select.Sql.Add('    when 4 then ''MOVIMENTO'' ');
      FDQ_Select.Sql.Add('    when 5 then ''RELATORIO'' ');
      FDQ_Select.Sql.Add('    when 6 then ''CONSULTA'' ');
      FDQ_Select.Sql.Add('    when 7 then ''DASHBOARD'' ');
      FDQ_Select.Sql.Add('  end tipo_form_tipo_desc ');
      FDQ_Select.Sql.Add('  ,tf.descricao as id_tipo_form_desc ');
      FDQ_Select.Sql.Add('  ,p.descricao as id_projeto_desc ');
      FDQ_Select.Sql.Add('FROM public.telas_projetos tp ');
      FDQ_Select.Sql.Add('  join public.tipos_forms tf on tf.id = tp.id_tipo_form ');
      FDQ_Select.Sql.Add('  join public.projetos p on p.id = tp.id_projeto ');
      FDQ_Select.Sql.Add('where 1=1 ');
      if AID > 0 then
        FDQ_Select.Sql.Add('  and tp.id = ' + AID.ToString);
      if Trim(ADescricao) <> '' then
        FDQ_Select.Sql.Add('  and tp.descricao like ' + QuotedStr('%'+ADescricao+'%'));
      if AStatus <> 2 then
        FDQ_Select.Sql.Add('  and tp.status = ' + AStatus.ToString);
      if AID_Projeto > 0 then
        FDQ_Select.Sql.Add('  and tp.id_projeto = ' + AID_Projeto.ToString);
      if Trim(AProjeto) <> '' then
        FDQ_Select.Sql.Add('  and p.descricao like ' + QuotedStr('%'+AProjeto+'%'));

      FDQ_Select.Sql.Add('order by tp.id; ');

      if ((APagina > 0) and (APaginas > 0))  then
      begin
        FPagina := (((APagina - 1) * FPaginas) + 1);
        FPaginas := (APagina * FPaginas);
        FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
      end;
      FDQ_Select.Active := True;

      Result := FDQ_Select.ToJSONArray;

    except
      on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Listando Formul�rios do Projeto. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Listando Formul�rios do Projeto. Banco de dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TTelas_Projeto.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Telas do Projeto. N�o h� informa��es a serem alteradas');
        raise Exception.Create('N�o h� informa��es a serem alteradas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.telas_projetos where id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
        begin
          TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Telas do Projeto ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
          raise Exception.Create('Telas do Projeto ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
        end;

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.telas_projetos SET ');
        FDQ_Update.Sql.Add('  id_projeto = :id_projeto ');
        FDQ_Update.Sql.Add('  ,nome_form = :nome_form ');
        FDQ_Update.Sql.Add('  ,descricao = :descricao ');
        FDQ_Update.Sql.Add('  ,id_tipo_form = :id_tipo_form ');
        FDQ_Update.Sql.Add('  ,status = :status ');
        FDQ_Update.Sql.Add('WHERE id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('id_projeto').AsInteger := AJSon[I].GetValue<Integer>('idprojeto',0);
        FDQ_Update.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Update.ParamByName('nome_form').AsString := AJSon[I].GetValue<String>('nomeform','');
        FDQ_Update.ParamByName('id_tipo_form').AsInteger := AJSon[I].GetValue<Integer>('idtipoform',0);
        FDQ_Update.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',0);
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except
      on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Atualiza dados Telas do Formul�rio. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Atualiza dados Telas do Formul�rio. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TTelas_Projeto' }

{$Region 'TTipos_Forms'}
constructor TTipos_Forms.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TTipos_Forms.Json_Delete(AId: Integer): Boolean;
var
  FDQ_Delete :TFDQuery;
  FDQ_Select :TFDQuery;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Delete := TFDQuery.Create(Nil);
  FDQ_Delete.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AId = 0 then
        raise Exception.Create('N�o foi informado o Tipo do Formul�rio a ser Exclu�do');

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('select * from public.tipos_forms where id = ' + AId.ToString);
      FDQ_Select.Active := True;
      if FDQ_Select.IsEmpty then
        raise Exception.Create('Tipo Formul�rio ' + AId.ToString + ' n�o localizado. A exclus�o ser� cancelada');

      FDQ_Delete.Active := False;
      FDQ_Delete.SQL.Clear;
      FDQ_Delete.Sql.Add('DELETE FROM public.tipos_forms ');
      FDQ_Delete.Sql.Add('WHERE id = :id; ');
      FDQ_Delete.ParamByName('id').AsInteger := AId;
      FDQ_Delete.ExecSQL;

      FConexao.Commit;

    except on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Exclui Tipo de Formul�rio. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Exclui Tipo de Formul�rio. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Delete);
    FreeAndNil(FDQ_Select);
  end;
end;

function TTipos_Forms.Json_Insert(AJSon: TJSONArray): Boolean;
var
  FDQ_Insert :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
  FId :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Insert := TFDQuery.Create(Nil);
  FDQ_Insert.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere Tipos de Formul�rios. N�o h� informa��es a serem Inseridas');
        raise Exception.Create('N�o h� informa��es a serem inseridas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        FId := 0;

        FDQ_Insert.Active := False;
        FDQ_Insert.SQL.Clear;
        FDQ_Insert.Sql.Add('INSERT INTO public.tipos_forms ( ');
        FDQ_Insert.Sql.Add('  tipo ');
        FDQ_Insert.Sql.Add('  ,descricao ');
        FDQ_Insert.Sql.Add('  ,status ');
        FDQ_Insert.Sql.Add('  ,dt_cadastro ');
        FDQ_Insert.Sql.Add('  ,hr_cadastro ');
        FDQ_Insert.Sql.Add(') VALUES( ');
        FDQ_Insert.Sql.Add('  :tipo ');
        FDQ_Insert.Sql.Add('  ,:descricao ');
        FDQ_Insert.Sql.Add('  ,:status ');
        FDQ_Insert.Sql.Add('  ,:dt_cadastro ');
        FDQ_Insert.Sql.Add('  ,:hr_cadastro ');
        FDQ_Insert.Sql.Add('); ');
        FDQ_Insert.ParamByName('tipo').AsInteger := AJSon[I].GetValue<Integer>('tipo',0);
        FDQ_Insert.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Insert.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',1);
        FDQ_Insert.ParamByName('dt_cadastro').AsDate := Date;
        FDQ_Insert.ParamByName('hr_cadastro').AsTime := Time;
        FDQ_Insert.ExecSQL;
      end;

      FConexao.Commit;

    except
      on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere dados Tipos Formul�rios. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Insere dados Tipos de Formul�rios. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Insert);
    FreeAndNil(FDQ_Select);
  end;
end;

function TTipos_Forms.JSon_Listagem(APagina, APaginas, AID, AStatus: Integer; ATipo, ADescricao: String): TJSONArray;
var
  FDQ_Select :TFDQuery;
  FPagina :Integer;
  FPaginas :Integer;
begin

  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  if APaginas > 0 then
    FPaginas := APaginas;

  try
    try
      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('SELECT ');
      FDQ_Select.Sql.Add('  tf.* ');
      FDQ_Select.Sql.Add('  ,case tf.status ');
      FDQ_Select.Sql.Add('    when 0 then ''INATIVO'' ');
      FDQ_Select.Sql.Add('    when 1 then ''ATIVO'' ');
      FDQ_Select.Sql.Add('  end status_desc ');
      FDQ_Select.Sql.Add('  ,case tf.tipo ');
      FDQ_Select.Sql.Add('    when 0 then ''LOGIN'' ');
      FDQ_Select.Sql.Add('    when 1 then ''CONFIG'' ');
      FDQ_Select.Sql.Add('    when 2 then ''PRINCIPAL'' ');
      FDQ_Select.Sql.Add('    when 3 then ''CADASTRO'' ');
      FDQ_Select.Sql.Add('    when 4 then ''MOVIMENTO'' ');
      FDQ_Select.Sql.Add('    when 5 then ''RELAT�RIO'' ');
      FDQ_Select.Sql.Add('    when 6 then ''CONSULTA'' ');
      FDQ_Select.Sql.Add('    when 7 then ''DASHBOARD'' ');
      FDQ_Select.Sql.Add('  end tipo_desc ');
      FDQ_Select.Sql.Add('FROM public.tipos_forms tf ');
      FDQ_Select.Sql.Add('where 1=1 ');
      if AID > 0 then
        FDQ_Select.Sql.Add('  and tf.id = ' + AID.ToString);
      if Trim(ADescricao) <> '' then
        FDQ_Select.Sql.Add('  and tf.descricao like ' + QuotedStr('%'+ADescricao+'%'));
      if AStatus <> 2 then
        FDQ_Select.Sql.Add('  and tf.status = ' + AStatus.ToString);
      if Trim(ATipo) <> '' then
        FDQ_Select.Sql.Add('  and tf.tipo like ' + QuotedStr('%'+ATipo+'%'));

      FDQ_Select.Sql.Add('order by tf.id; ');

      if ((APagina > 0) and (APaginas > 0))  then
      begin
        FPagina := (((APagina - 1) * FPaginas) + 1);
        FPaginas := (APagina * FPaginas);
        FDQ_Select.Sql.Add('ROWS ' + FPagina.ToString + ' TO ' + FPaginas.ToString);
      end;
      FDQ_Select.Active := True;

      Result := FDQ_Select.ToJSONArray;

    except
      on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Listando Tipos de Formul�rios. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Listando Tipos de Formul�rios. Banco de dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

function TTipos_Forms.Json_Update(AJSon: TJSONArray): Boolean;
var
  FDQ_Update :TFDQuery;
  FDQ_Select :TFDQuery;

  I :Integer;
begin

  Result := True;

  FConexao.StartTransaction;

  FDQ_Update := TFDQuery.Create(Nil);
  FDQ_Update.Connection := FConexao;
  FDQ_Select := TFDQuery.Create(Nil);
  FDQ_Select.Connection := FConexao;

  try
    try
      if AJSon.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Altera Tipos de Formul�rios. N�o h� informa��es a serem alteradas');
        raise Exception.Create('N�o h� informa��es a serem alteradas');
      end;

      for I := 0 to AJSon.Size - 1 do
      begin
        //Verifica se o usu�rio existe...
        FDQ_Select.Active := False;
        FDQ_Select.Sql.Clear;
        FDQ_Select.Sql.Add('select * from public.tipos_forms where id = ' + AJSon[I].GetValue<Integer>('id',0).ToString);
        FDQ_Select.Active := True;
        if FDQ_Select.IsEmpty then
        begin
          TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Tipo de Formul�rio ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
          raise Exception.Create('Tipo de Formul�rio ' + AJSon[I].GetValue<Integer>('id',0).ToString + ' n�o localizado. As altera��es ser�o canceladas');
        end;

        //Alterando registros...
        FDQ_Update.Active := False;
        FDQ_Update.SQL.Clear;
        FDQ_Update.Sql.Add('UPDATE public.tipos_forms SET ');
        FDQ_Update.Sql.Add('  tipo = :tipo ');
        FDQ_Update.Sql.Add('  ,descricao = :descricao ');
        FDQ_Update.Sql.Add('  ,status = :status ');
        FDQ_Update.Sql.Add('WHERE id = :id; ');
        FDQ_Update.ParamByName('id').AsInteger := AJSon[I].GetValue<Integer>('id',0);
        FDQ_Update.ParamByName('tipo').AsInteger := AJSon[I].GetValue<Integer>('tipo',0);
        FDQ_Update.ParamByName('descricao').AsString := AJSon[I].GetValue<String>('descricao','');
        FDQ_Update.ParamByName('status').AsInteger := AJSon[I].GetValue<Integer>('status',0);
        FDQ_Update.ExecSQL;
      end;

      FConexao.Commit;

    except
      on E: Exception do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Atualiza dados Tipo de Formul�rio. ' + E.Message);
        raise Exception.Create(E.Message);
      end;
      on E: EDatabaseError do
      begin
        FConexao.Rollback;
        Result := False;
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, 'LOG_SERVICO.TXT', 'Atualiza dados Tipo de Formul�rio. Banco de Dados: ' + sLineBreak + E.Message);
        raise Exception.Create('Erro ao acessar o Banco de Dados: ' + sLineBreak +  E.Message);
      end;
    end;
  finally
    FreeAndNil(FDQ_Update);
    FreeAndNil(FDQ_Select);
  end;
end;
{$EndRegion 'TTipos_Forms'}

end.
