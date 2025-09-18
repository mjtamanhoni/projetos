unit uRota.Publica;

interface
uses
  System.SysUtils,
  System.JSON,
  System.Net.HttpClient,
  System.Classes,

  IniFiles,

  FMX.Dialogs,

  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.JWT,

  FireDAC.Comp.Client,

  {$Region 'Modelo de dados'}
    uModel.Publico,
    uModel.Cadastro,
    uModel.Movimento,
  {$EndRegion 'Modelo de dados'}

  uDM,
  uFuncoes.Gerais,
  uRota.Auth;

procedure RegistrarRotas;

{$Region 'Usu�rios'}
  procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Empresa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Usu�rios'}

{$Region 'Regi�es'}
  procedure Regioes_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Regioes_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Regioes_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Regioes_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Regi�es'}

{$Region 'Unidades Federativas'}
  procedure UnidadeFederativa_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure UnidadeFederativa_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure UnidadeFederativa_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure UnidadeFederativa_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Unidades Federativas'}

{$Region 'Munic�pios'}
  procedure Municipio_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Municipio_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Municipio_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Municipio_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Munic�pios'}

{$Region 'Empresa'}
  procedure Empresa_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Empresa_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Empresa_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Empresa_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Empresa'}

{$Region 'Formas de Pagamento'}
  procedure FormaPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaCondPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaCondPagto_Forma_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);

  procedure FormaCondPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaCondPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Formas de Pagamento'}

{$Region 'Condi��es de Pagamento'}
  procedure CondPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure CondPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure CondPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure CondPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Condi��es de Pagamento'}

{$Region 'Unidade de Medida'}
  procedure UnidadeMedida_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure UnidadeMedida_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure UnidadeMedida_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure UnidadeMedida_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Unidade de Medida'}

{$Region 'Projetos'}
  procedure Projeto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Projeto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Projeto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Projeto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Projetos'}

{$Region 'Tipos Formul�rios'}
  procedure TipoForm_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TipoForm_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TipoForm_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TipoForm_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Tipos Formul�rios'}

{$Region 'Telas - Projetos'}
  procedure TelaProjeto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TelaProjeto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TelaProjeto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TelaProjeto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Telas - Projetos'}

implementation

procedure RegistrarRotas;
begin
  try
    {$Region 'Usu�rios'}
      THorse.Post('/usuario/login',Login);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/usuario',Usuario_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/usuario/empresa',Usuario_Empresa);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/usuario',Usuario_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/usuario',Usuario_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/usuario',Usuario_Delete);
    {$EndRegion 'Usu�rios'}

    {$Region 'Regi�es'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/regioes',Regioes_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/regioes',Regioes_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/regioes',Regioes_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/regioes',Regioes_Delete);
    {$EndRegion 'Regi�es'}

    {$Region 'Unidade Federativas'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/unidadeFederativa',UnidadeFederativa_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/unidadeFederativa',UnidadeFederativa_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/unidadeFederativa',UnidadeFederativa_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/unidadeFederativa',UnidadeFederativa_Delete);
    {$EndRegion 'Unidades Federativas'}

    {$Region 'Munic�pio'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/municipio',Municipio_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/municipio',Municipio_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/municipio',Municipio_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/municipio',Municipio_Delete);
    {$EndRegion 'Munic�pio'}

    {$Region 'Empresa'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/empresa',Empresa_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/empresa',Empresa_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/empresa',Empresa_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/empresa',Empresa_Delete);
    {$EndRegion 'Empresa'}

    {$Region 'Formas de Pagamento'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/formaPagamento',FormaPagto_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/formaPagamento',FormaPagto_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/formaPagamento',FormaPagto_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/formaPagamento',FormaPagto_Delete);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/formaPagamento/formaCondPagto',FormaCondPagto_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/formaPagamento/formaCondPagto/forma',FormaCondPagto_Forma_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/formaPagamento/condicaoPagamento',FormaCondPagto_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/formaPagamento/condicaoPagamento',FormaCondPagto_Delete);
    {$EndRegion 'Formas de Pagamento'}

    {$Region 'Condi��es de Pagamento'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/condPagamento',CondPagto_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/condPagamento',CondPagto_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/condPagamento',CondPagto_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/condPagamento',CondPagto_Delete);
    {$EndRegion 'Condi��es de Pagamento'}

    {$Region 'Unidade de Medida'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/unidadeMedida',UnidadeMedida_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/unidadeMedida',UnidadeMedida_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/unidadeMedida',UnidadeMedida_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/unidadeMedida',UnidadeMedida_Delete);
    {$EndRegion 'Unidade de Medida'}

    {$Region 'Projeto'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/projeto',Projeto_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/projeto',Projeto_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/projeto',Projeto_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/projeto',Projeto_Delete);
    {$EndRegion 'Projeto'}

    {$Region 'Tipos Formul�rios'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/tipoForm',TipoForm_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/tipoForm',TipoForm_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/tipoForm',TipoForm_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/tipoForm',TipoForm_Delete);
    {$EndRegion 'Tipos Formul�rios'}

    {$Region 'Telas - Projeto'}
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/telaProjeto',TelaProjeto_Select);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/telaProjeto',TelaProjeto_Insert);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/telaProjeto',TelaProjeto_Update);
      THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/telaProjeto',TelaProjeto_Delete);
    {$EndRegion 'Telas - Projeto'}

  except on E: Exception do
    raise Exception.Create('Registrando rotaas Usu�rios: ' + E.Message);
  end;
end;

{$Region 'Usu�rios'}
procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONObject;
  FJSon :TJSONObject;


  FUsuario :String;
  FSenha :String;
  FPin :String;

  FUsuarioID :Integer;
  FUsuarioNome :String;

  FDM :TDM;
  FTUsuario :TUsuario;

begin
  try
    try
      FDM := TDM.Create(Nil);
      FTUsuario := TUsuario.Create(FDM.FDConnectionP);

      FBody := Req.Body<TJSONObject>;

      FUsuario := FBody.GetValue<string>('usuario','');
      FSenha := FBody.GetValue<string>('senha','');
      FPin := TFuncoes.EncryptString(FBody.GetValue<string>('pin',''));

      if not TFuncoes.ValidaEmail(FUsuario) then
        FUsuario := TFuncoes.Crip_Adapta(FUsuario);

      FJSon := FTUsuario.Login(FPin,FUsuario,FSenha);
      if FJson.Size = 0 then
      begin
        Res.Send('Usu�rio ou senha inv�lidos.').Status(401);
      end
      else
      begin
        FUsuarioID := 0;
        FUsuarioID := FJSon.GetValue<integer>('id',0);
        FUsuarioNome := '';
        FUsuarioNome := FJSon.GetValue<string>('nome','');

        if FUsuarioID = 0 then
        begin
          Res.Send('Usu�rio ou senha inv�lidos.').Status(401);
        end
        else
        begin
          FJSon.AddPair('token',Criar_Token(FUsuarioID));
          Res.Send<TJSONObject>(FJSon).Status(200);
        end;
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM);
    FreeAndNil(FTUsuario);
  end;
end;

procedure Usuario_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FLogin :String;
  FPIN :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FUsuario :TUsuario;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FUsuario := TUsuario.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FNome := '';
      FLogin := '';
      FPIN := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FLogin := Req.Query['login'];
      FPin := Req.Query['pin'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FUsuario.JSon_Listagem(FPagina, FPaginas, FId, FNome, FLogin, FPin);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('N�o foi poss�vel localizar os Usu�rios.').Status(204);
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar os Usu�rios.');
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Lista de Usu�rios retornada',C_LINHA_ERRO);
      end;

    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FUsuario);
  end;
end;

procedure Usuario_Empresa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId_Usuario :Integer;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FUsuario :TUsuario;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FUsuario := TUsuario.Create(FDM_PostgreSql.FDConnectionP);

      FId_Usuario := 0;

      FPagina := 0;
      FPaginas := 0;

      FId_Usuario := StrToIntDef(Req.Query['idUsuario'],0);
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FUsuario.JSon_ListaEmpresas(FPagina, FPaginas, FId_Usuario);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('N�o foi poss�vel localizar as Empresas do Usu�rio.').Status(204);
        //Gravar um log no computador para controlar os retornos
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
        //Gravar um log no computador para controla os retornos
      end;

    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        //Gravar um log no computador para controlar os retornos
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FUsuario);
  end;
end;

procedure Usuario_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUsuario;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUsuario.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Usu�rio cadastrado com sucesso').Status(200)
      else
        Res.Send('N�o foi poss�vel cadatrar o usu�rio.').Status(422);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Usuario_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUsuario;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUsuario.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Usu�rio alterado com sucesso').Status(200)
      else
        Res.Send('N�o foi poss�vel alterar o usu�rio.').Status(422);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure Usuario_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUsuario;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUsuario.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Usu�rio exclu�do com sucesso').Status(200)
      else
        Res.Send('N�o foi poss�vel excluir o usu�rio.').Status(409);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Usu�rios'}

{$Region 'Regi�es'}
procedure Regioes_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FIBGE :Integer;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TRegioes;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TRegioes.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FNome := '';
      FIBGE := 0;

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FIBGE := StrToIntDef(Req.Query['ibge'],0);

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FId, FNome, FIBGE);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel localizar as Regi�es.');
        Res.Send('N�o foi poss�vel localizar as Regi�es.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Pesquisa de Regi�es: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Regioes_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TRegioes;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TRegioes.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Regi�o cadastrada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel cadatrar a Regi�o Brasileira.');
        Res.Send('N�o foi poss�vel cadatrar a Regi�o Brasileira.').Status(422);
      end;

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Regioes_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TRegioes;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TRegioes.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Regi�o alterada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel alterar a Regi�o Brasileira.');
        Res.Send('N�o foi poss�vel alterar a Regi�o Brasileira.').Status(422);
      end;

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure Regioes_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TRegioes;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TRegioes.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Regi�o exclu�da com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel excluir a Regi�o Brasileira.');
        Res.Send('N�o foi poss�vel excluir a Regi�o.').Status(409);
      end;

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Regi�es'}

{$Region 'Unidades Federativas'}
procedure UnidadeFederativa_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FIBGE :Integer;
  FRegiao :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesFederativas;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesFederativas.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FNome := '';
      FRegiao := '';
      FIBGE := 0;

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FIBGE := StrToIntDef(Req.Query['ibge'],0);
      FRegiao := Req.Query['regiao'];

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FId, FNome, FIBGE, FRegiao);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel localizar as Unidades Federativas.');
        Res.Send('N�o foi poss�vel localizar as Unidades Federativas.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Pesquisa de Unidades Federativas: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure UnidadeFederativa_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesFederativas;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesFederativas.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Unidade Federativa cadastrada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel cadatrar a Unidade Federativa.');
        Res.Send('N�o foi poss�vel cadatrar a Unidade Federativa.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Unidade Federativa. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure UnidadeFederativa_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesFederativas;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesFederativas.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Unidade Federativa alterada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel alterar a Unidade Federativa.');
        Res.Send('N�o foi poss�vel alterar a Unidade Federativa.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Unidade Federativa. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure UnidadeFederativa_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesFederativas;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesFederativas.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Unidade Federativa exclu�da com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel excluir a Unidade Federativa.');
        Res.Send('N�o foi poss�vel excluir a Unidade Federativa.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Unidade Federativa. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Unidades Federativas'}

{$Region 'Munic�pios'}
procedure Municipio_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FIBGE :Integer;
  FRegiao :String;
  FUf_Sigla :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TMunicipios;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TMunicipios.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FNome := '';
      FRegiao := '';
      FIBGE := 0;
      FUf_Sigla := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FIBGE := StrToIntDef(Req.Query['ibge'],0);
      FRegiao := Req.Query['regiao'];
      FUf_Sigla := Req.Query['ufSigla'];

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FId, FNome, FIBGE, FUf_Sigla, FRegiao);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel localizar os Munic�pios.');
        Res.Send('N�o foi poss�vel localizar os Munic�pios.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Pesquisa de Munic�pios: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Municipio_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TMunicipios;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TMunicipios.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Munic�pio cadastrado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel cadatrar o Munic�pio.');
        Res.Send('N�o foi poss�vel cadatrar o Munic�pio.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Munic�pio. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Municipio_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TMunicipios;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TMunicipios.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Munic�pio alterado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel alterar o Munic�pio.');
        Res.Send('N�o foi poss�vel alterar o Munic�pio.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Munic�pio. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure Municipio_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TMunicipios;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TMunicipios.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Munic�pio exclu�do com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'N�o foi poss�vel excluir o Munic�pio.');
        Res.Send('N�o foi poss�vel excluir o Munic�pio.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico,C_NOME_LOG, 'Munic�pio. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Munic�pios'}

{$Region 'Empresa'}
procedure Empresa_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FRazaoSocial :String;
  FNomeFantasia :String;
  FCNPJ :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TEmpresa;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FRazaoSocial := '';
      FNomeFantasia := '';
      FCNPJ := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FRazaoSocial := Req.Query['razaoSocial'];
      FNomeFantasia := Req.Query['nomeFantasia'];
      FCNPJ := Req.Query['cnpj'];

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FId, FRazaoSocial, FNomeFantasia,FCNPJ);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar as Empresas.');
        Res.Send('N�o foi poss�vel localizar as Empresas.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Pesquisa de Empresas: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Empresa_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TEmpresa;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Empresa cadastrada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar a Empresa.');
        Res.Send('N�o foi poss�vel cadatrar a Empresa.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Empresa. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Empresa_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TEmpresa;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Empresa alterada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel alterar a Empresa.');
        Res.Send('N�o foi poss�vel alterar a Empresa.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Empresa. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure Empresa_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TEmpresa;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Empresa exclu�da com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir a Empresa.');
        Res.Send('N�o foi poss�vel excluir a Empresa.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Empresa. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Empresa'}

{$Region 'Formas de Pagamento'}
procedure FormaPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FLogin :String;
  FPIN :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TFormaPgto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaPgto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FNome := '';
      FLogin := '';
      FPIN := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FId, FNome);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar as Formas de Pagamento.');
        Res.Send('N�o foi poss�vel localizar as Formas de Pagamento.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure FormaPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TFormaPgto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaPgto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Forma de Pagamento cadastrada com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar a Forma de Pagamento.');
        Res.Send('N�o foi poss�vel cadatrar a Forma de Pagamento.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure FormaPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TFormaPgto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaPgto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      //if FModeloDados.Json_Update(FBody) then
      if FModeloDados.Json_Update(Req.Body<TJSONArray>) then
        Res.Send('Forma de Pagamento alterada com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel alterar a Forma de Pagamento.');
        Res.Send('N�o foi poss�vel alterar a Forma de Pagamento.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure FormaPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TFormaPgto;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaPgto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Forma de Pagamento exclu�da com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir a Forma de Pagamento.');
        Res.Send('N�o foi poss�vel excluir a Forma de Pagamento.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure FormaCondPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FIdForma :Integer;
  FIdCond :Integer;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TFormaCondPgto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaCondPgto.Create(FDM_PostgreSql.FDConnectionP);

      FIdForma := 0;
      FIdCond := 0;

      FPagina := 0;
      FPaginas := 0;

      FIdForma := StrToIntDef(Req.Query['idForma'],0);
      FIdCond := StrToIntDef(Req.Query['idCondicao'],0);
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FIdForma, FIdCond);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar as Condi��es de Pagamento da Forma de Pagamento.');
        Res.Send('N�o foi poss�vel localizar as Condi��es de Pagamento da Forma de Pagamento.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure FormaCondPagto_Forma_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FIdForma :Integer;
  FIdCond :Integer;
  FTipo :Integer;
  FClass :String;
  FStatus :Integer;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TFormaCondPgto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaCondPgto.Create(FDM_PostgreSql.FDConnectionP);

      FIdForma := 0;
      FIdCond := 0;
      FTipo := 0;
      FClass := '';
      FStatus := -1;

      FPagina := 0;
      FPaginas := 0;

      FIdForma := StrToIntDef(Req.Query['idForma'],0);
      FIdCond := StrToIntDef(Req.Query['idCondicao'],0);
      FTipo := StrToIntDef(Req.Query['tipo'],0);
      FStatus := StrToIntDef(Req.Query['status'],-1);
      FClass := Req.Query['classificacao'];

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem_Forma(FPagina, FPaginas, FIdForma, FIdCond, FTipo, FStatus, FClass);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar as Condi��es de Pagamento da Forma de Pagamento.');
        Res.Send('N�o foi poss�vel localizar as Condi��es de Pagamento da Forma de Pagamento.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure FormaCondPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TFormaPgto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaPgto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Condi��o da Forma de Pagamento cadastrada com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar a Condi��o da Forma de Pagamento.');
        Res.Send('N�o foi poss�vel cadatrar a Condi��o da Forma de Pagamento.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure FormaCondPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TFormaPgto;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TFormaPgto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Condi��o da Forma de Pagamento exclu�da com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir a Condi��o da Forma de Pagamento.');
        Res.Send('N�o foi poss�vel excluir a Condi��o da Forma de Pagamento.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Formas de Pagamento'}

{$Region 'Condi��es de Pagamento'}
procedure CondPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FLogin :String;
  FPIN :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TCondPgto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TCondPgto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FNome := '';
      FLogin := '';
      FPIN := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FId, FNome);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar as Condi��es de Pagamento.');
        Res.Send('N�o foi poss�vel localizar as Condi��es de Pagamento.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure CondPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TCondPgto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TCondPgto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Condi��o de Pagamento cadastrada com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar a Condi��o de Pagamento.');
        Res.Send('N�o foi poss�vel cadatrar a Condi��o de Pagamento.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure CondPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TCondPgto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TCondPgto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Condi��o de Pagamento alterada com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel alterar a Condi��o de Pagamento.');
        Res.Send('N�o foi poss�vel alterar a Condi��o de Pagamento.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure CondPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TCondPgto;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TCondPgto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Condi��o de Pagamento exclu�da com sucesso').Status(200)
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir a Condi��o de Pagamento.');
        Res.Send('N�o foi poss�vel excluir a Condi��o de Pagamento.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Condi��es de Pagamento'}

{$Region 'Unidade de Medida'}
procedure UnidadeMedida_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FSigla :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesMedida;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesMedida.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FNome := '';
      FSigla := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FSigla := Req.Query['sigla'];

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina, FPaginas, FId, FNome, FSigla);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar as Unidades de Medida.');
        Res.Send('N�o foi poss�vel localizar as Unidades de Medida.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Pesquisa de Unidades de Medida: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure UnidadeMedida_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesMedida;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesMedida.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Unidade de Medida cadastrada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar a Unidade de Medida.');
        Res.Send('N�o foi poss�vel cadatrar a Unidade de Medida.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Unidade de Medida. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure UnidadeMedida_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesMedida;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesMedida.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Unidade de Medida alterada com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel alterar a Unidade de Medida.');
        Res.Send('N�o foi poss�vel alterar a Unidade de Medida.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Unidade de Medida. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure UnidadeMedida_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TUnidadesMedida;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TUnidadesMedida.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Unidade de Medida exclu�da com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir a Unidade de Medida.');
        Res.Send('N�o foi poss�vel excluir a Unidade de Medida.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Unidade de Medida. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Unidade de Medida'}

{$Region 'Projetos'}
procedure Projeto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDescricao :String;
  FStatus :Integer;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TProjeto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TProjeto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FDescricao := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FStatus := StrToIntDef(Req.Query['status'],1);
      FDescricao := Req.Query['descricao'];

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(
        FPagina
        ,FPaginas
        ,FId
        ,FStatus
        ,FDescricao);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar o Projeto.');
        Res.Send('N�o foi poss�vel localizar o Projeto.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Pesquisa de Projeto: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Projeto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TProjeto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TProjeto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Projetos cadastrado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar o Projeto.');
        Res.Send('N�o foi poss�vel cadatrar o Projeto.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Projeto. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure Projeto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TProjeto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TProjeto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Projeto alterado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel alterar o Projeto.');
        Res.Send('N�o foi poss�vel alterar o Projeto.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Projeto. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure Projeto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TProjeto;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TProjeto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Projeto exclu�do com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir o Projeto.');
        Res.Send('N�o foi poss�vel excluir o Projeto.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Projeto. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Projetos'}

{$Region 'Tipos Formul�rios'}
procedure TipoForm_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDescricao :String;
  FStatus :Integer;
  FTipo :String;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TTipos_Forms;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTipos_Forms.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FDescricao := '';
      FStatus := 1;
      FTipo := '';

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FStatus := StrToIntDef(Req.Query['status'],1);
      FDescricao := Req.Query['descricao'];
      FTipo := Req.Query['tipo'];

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(
        FPagina
        ,FPaginas
        ,FId
        ,FStatus
        ,FTipo
        ,FDescricao);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar o Tipo do Formul�rio.');
        Res.Send('N�o foi poss�vel localizar o Tipo do Formul�rio.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Pesquisa de Tipo de Formul�rio: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure TipoForm_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TTipos_Forms;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTipos_Forms.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Tipo de Formul�rio cadastrado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar o Tipo de Formul�rio.');
        Res.Send('N�o foi poss�vel cadatrar o Tipo de Formul�rio.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Tipo de Formul�rio. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure TipoForm_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TTipos_Forms;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTipos_Forms.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Tipo de Formul�rio alterado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel alterar o Tipo de Formul�rio.');
        Res.Send('N�o foi poss�vel alterar o Tipo de Formul�rio.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Tipo de Formul�rio. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure TipoForm_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TTipos_Forms;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTipos_Forms.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Tipo de Formul�rio exclu�do com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir o Tipo de Formul�rio.');
        Res.Send('N�o foi poss�vel excluir o Tipo de Formul�rio.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Tipo de Formul�rio. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Tipos Formul�rios'}

{$Region 'Telas - Projetos'}
procedure TelaProjeto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDescricao :String;
  FStatus :Integer;
  FProjeto :String;
  FId_Projeto :Integer;

  FPagina :Integer;
  FPaginas :Integer;

  FDM_PostgreSql :TDM;
  FModeloDados :TTelas_Projeto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTelas_Projeto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FDescricao := '';
      FStatus := 1;
      FProjeto := '';
      FId_Projeto := 0;

      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FStatus := StrToIntDef(Req.Query['status'],1);
      FDescricao := Req.Query['descricao'];
      FProjeto := Req.Query['projeto'];
      FId_Projeto := StrToIntDef(Req.Query['idProjeto'],0);

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(
        FPagina
        ,FPaginas
        ,FId
        ,FStatus
        ,FDescricao
        ,FId_Projeto
        ,FProjeto);

      if FJSon_Retorno.Size = 0 then
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel localizar o Formul�rio do Projeto.');
        Res.Send('N�o foi poss�vel localizar o Formul�rio do Projeto.').Status(204);
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Pesquisa de Formul�rio do Projeto: ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure TelaProjeto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TTelas_Projeto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTelas_Projeto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
      begin
        Res.Send('Formul�rio do Projeto cadastrado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel cadatrar o Formul�rio do Projeto.');
        Res.Send('N�o foi poss�vel cadatrar o Formul�rio do Projeto.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Formul�rio do Projeto. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FDM_PostgreSql);
    FreeAndNil(FModeloDados);
  end;
end;

procedure TelaProjeto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TTelas_Projeto;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTelas_Projeto.Create(FDM_PostgreSql.FDConnectionP);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
      begin
        Res.Send('Formul�rio do Projeto alterado com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel alterar o Formul�rio do Projeto.');
        Res.Send('N�o foi poss�vel alterar o Formul�rio do Projeto.').Status(422);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Formul�rio do Projeto. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;

procedure TelaProjeto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_PostgreSql :TDM;
  FModeloDados :TTelas_Projeto;
  FId :Integer;
begin
  try
    try

      FDM_PostgreSql := TDM.Create(Nil);
      FModeloDados := TTelas_Projeto.Create(FDM_PostgreSql.FDConnectionP);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
      begin
        Res.Send('Formul�rio do Projeo exclu�do com sucesso').Status(200);
      end
      else
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'N�o foi poss�vel excluir o Formul�rio do Projeto.');
        Res.Send('N�o foi poss�vel excluir o Formul�rio do Projeto.').Status(409);
      end;

    except on E: Exception do
      begin
        TFuncoes.Salvar_Log(TFuncoes.Dir_Servico, C_NOME_LOG, 'Formul�rio do Projeto. ' + E.Message);
        Res.Send(E.Message).Status(500);
      end;
    end;
  finally
    FreeAndNil(FModeloDados);
    FreeAndNil(FDM_PostgreSql);
  end;
end;
{$EndRegion 'Telas - Projetos'}

end.

