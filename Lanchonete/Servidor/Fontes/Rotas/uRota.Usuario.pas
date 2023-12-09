unit uRota.Usuario;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Net.HttpClient,
  System.Classes,

  FMX.Dialogs,

  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.JWT,

  uRota.Auth,

  uModel.Usuario,
  uFuncoes,
  uDm_Lanchonete,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

procedure RegistrarRotas;

{$Region 'Usuários'}
  //Rotas não protegidas
  procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  //Rotas protegidas
  procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Atualizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Deletar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Usuários'}

{$Region 'Permissões dos usuários'}
  procedure User_Permissoes_List(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure User_Permissoes_Cad(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure User_Permissoes_Alt(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure User_Permissoes_Del(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'Permissões dos usuários'}

implementation

procedure RegistrarRotas;
begin
  {$Region 'Usuários'}
    //Rotas não protegidas...
    THorse.Post('/usuario',Cadastro);
    THorse.Post('/usuario/login',Login);

    //Rotas protegidas...
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/usuario',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/usuario',Atualizar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/usuario',Deletar);
  {$EndRegion 'Usuários'}

  {$Region 'Permissões dos usuários'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/usuario/permissoes',User_Permissoes_List);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/usuario/permissoes',User_Permissoes_Cad);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/usuario/permissoes',User_Permissoes_Alt);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/usuario/permissoes',User_Permissoes_Del);
  {$EndRegion 'Permissões dos usuários'}

end;

procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario :TUsuario;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I :Integer;

  lId :Integer;
  lNome :String;
  lPin :String;
  lEmail :String;
  lPagina :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTUsuario := TUsuario.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lNome := '';
      lPin := '';
      lEmail := '';
      lPagina := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lNome := Req.Query['nome'];
      lEmail := Req.Query['email'];
      lPin := Req.Query['pin'];
      lPagina := StrToIntDef(Req.Query['pagina'],0);

      lJson_Ret := lTUsuario.Listar(
        lQuery
        ,lId
        ,lNome
        ,lPin
        ,lEmail
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Usuários não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Usuário não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Listagem de Usuários');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,' - Erro ao Listar Usuários: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTUsuario);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario :TUsuario;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I:Integer;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTUsuario := TUsuario.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTUsuario.Inicia_Propriedades;

        lTUsuario.NOME := lBody[I].GetValue<String>('nome','');
        lTUsuario.STATUS := lBody[I].GetValue<Integer>('status',0);
        lTUsuario.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTUsuario.LOGIN := lBody[I].GetValue<String>('login','');
        lTUsuario.SENHA := lBody[I].GetValue<String>('senha','');
        lTUsuario.PIN := lBody[I].GetValue<String>('pin','');
        lTUsuario.EMAIL := lBody[I].GetValue<String>('email','');
        lTUsuario.CELULAR := lBody[I].GetValue<String>('celular','');
        lTUsuario.CLASSIFICACAO := lBody[I].GetValue<Integer>('classificacao',0);
        lTUsuario.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTUsuario.NUMERO := lBody[I].GetValue<Integer>('numero',0);
        lTUsuario.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTUsuario.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTUsuario.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTUsuario.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTUsuario.UF_SIGLA := lBody[I].GetValue<String>('ufSigla','');
        lTUsuario.UF := lBody[I].GetValue<String>('uf','');
        lTUsuario.FOTO := lBody[I].GetValue<String>('foto','');
        lTUsuario.ORIGEM_TIPO := lBody[I].GetValue<Integer>('origemTipo',0);
        lTUsuario.ORIGEM_DESCRICAO := lBody[I].GetValue<String>('origemDescricao','');
        lTUsuario.ORIGEM_CODIGO := lBody[I].GetValue<Integer>('id',0);
        lTUsuario.DT_CADASTRO := TFuncoes.Converte_Data(lBody[I].GetValue<String>('dtCadastro',FormatDateTime('YYYY-MM-DD',Date)));
        lTUsuario.HR_CADASTRO := TFuncoes.Converte_Hora(lBody[I].GetValue<String>('hrCadastro',FormatDateTime('HH:NN:SS'+'.000',Time)));
        lTUsuario.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Usuário cadastrado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery_Hist,'Usuário cadastrado com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao Cadastrar usuario: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(lTUsuario);
      FreeAndNil(DM_Lanchonete);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      lTUsuario.DisposeOf;
      DM_Lanchonete.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Atualizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario :TUsuario;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I:Integer;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTUsuario := TUsuario.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser atualizado');


      for I := 0 to (lBody.Size - 1) do
      begin
        lTUsuario.Inicia_Propriedades;

        lTUsuario.ID := lBody[I].GetValue<Integer>('id',0);
        lTUsuario.NOME := lBody[I].GetValue<String>('nome','');
        lTUsuario.STATUS := lBody[I].GetValue<Integer>('status',-1);
        lTUsuario.TIPO := lBody[I].GetValue<Integer>('tipo',-1);
        lTUsuario.LOGIN := lBody[I].GetValue<String>('login','');
        lTUsuario.SENHA := lBody[I].GetValue<String>('senha','');
        lTUsuario.PIN := lBody[I].GetValue<String>('pin','');
        lTUsuario.EMAIL := lBody[I].GetValue<String>('email','');
        lTUsuario.CELULAR := lBody[I].GetValue<String>('celular','');
        lTUsuario.CLASSIFICACAO := lBody[I].GetValue<Integer>('classificacao',-1);
        lTUsuario.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTUsuario.NUMERO := lBody[I].GetValue<Integer>('numero',-1);
        lTUsuario.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTUsuario.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTUsuario.IBGE := lBody[I].GetValue<Integer>('ibge',-1);
        lTUsuario.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTUsuario.UF_SIGLA := lBody[I].GetValue<String>('ufSigla','');
        lTUsuario.UF := lBody[I].GetValue<String>('uf','');
        lTUsuario.FOTO := lBody[I].GetValue<String>('foto','');
        lTUsuario.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Usuário atualizado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery_Hist,'Usuário atualizado com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao atualizar usuario: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTUsuario);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Deletar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario :TUsuario;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I:Integer;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTUsuario := TUsuario.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lTUsuario.Inicia_Propriedades;
      lTUsuario.ID := StrToIntDef(Req.Query['id'],0);
      lTUsuario.Excluir(lQuery);

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Usuário excluído com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery_Hist,'Usuário excluído com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao excluír usuario: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTUsuario);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONObject;
  lJson_Ret :TJSONObject;
  lJsonValida_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario :TUsuario;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I :Integer;
  lId :Integer;

  lUsuario :String;
  lSenha :String;
  lPin :String;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTUsuario := TUsuario.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJSONObject>;
      if lBody = Nil then
        raise Exception.Create('Não há informações para o Login');

      lUsuario := '';
      lSenha := '';
      lPin := '';

      {$Region 'Verifica se há usuários cadastrados no banco de dados'}
        lJsonValida_Ret := lTUsuario.Listar(lQuery);
        if lJsonValida_Ret.Size = 0  then
        begin
          Res.Send('Não há usuários cadastrados').Status(204);
          TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login. Não há usuários cadastrados');
          Exit;
        end;
      {$EndRegion 'Verifica se há usuários cadastrados no banco de dados'}

      lUsuario := lBody.GetValue<String>('login','');
      lSenha := lBody.GetValue<String>('senha','');
      lPin := lBody.GetValue<String>('pin','');

      lJson_Ret := lTUsuario.ValidaLogin(lQuery,lUsuario,lSenha,lPin);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Login não autorizado').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login não autorizado');
      end
      else
      begin
        lId := 0;
        lId := lJson_Ret.GetValue<integer>('id',0);
        if lId = 0 then
        begin
          Res.Send('Login não autorizado').Status(401);
          TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login não autorizado');
        end
        else
        begin
          lJson_Ret.AddPair('tokenAuth',Criar_Token(lId));
          Res.Send(lJson_Ret).Status(200);
          TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login efetuado com sucesso');
        end;
      end;

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao efetuar o login: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTUsuario);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure User_Permissoes_List(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario_Permissoes :TUsuario_Permissoes;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I :Integer;

  lIdUsuario :Integer;
  lPagina :Integer;
  lObjeto :String;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTUsuario_Permissoes := TUsuario_Permissoes.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lIdUsuario := 0;
      lObjeto := '';

      lIdUsuario := StrToIntDef(Req.Query['idUsuario'],0);
      lPagina := StrToIntDef(Req.Query['pagina'],0);

      lObjeto := Req.Query['objeto'];

      lJson_Ret := lTUsuario_Permissoes.Listar(
        lQuery
        ,lIdUsuario
        ,lObjeto);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Permissões do usuário não localizadas').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Permissões do usuário não localizadas');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Listagem de Permissões dos Usuários');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao Listar Permissões dos Usuários: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTUsuario_Permissoes);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure User_Permissoes_Cad(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario_Permissoes :TUsuario_Permissoes;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;


      lTUsuario_Permissoes := TUsuario_Permissoes.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTUsuario_Permissoes.Inicia_Propriedades;

        lTUsuario_Permissoes.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTUsuario_Permissoes.OBJETO := lBody[I].GetValue<String>('objeto','');
        lTUsuario_Permissoes.VISUALIZAR_PER := lBody[I].GetValue<String>('visualizarPer','');
        lTUsuario_Permissoes.INCLUIR_PER := lBody[I].GetValue<String>('incluirPer','');
        lTUsuario_Permissoes.ALTERAR_PER := lBody[I].GetValue<String>('alterarPer','');
        lTUsuario_Permissoes.EXCLUIR_PER := lBody[I].GetValue<String>('excluirPer','');
        lTUsuario_Permissoes.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTUsuario_Permissoes.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',TimeToStr(Time)),lErro);
        lTUsuario_Permissoes.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Permissões do usuário cadastradas com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery_Hist,'Permissões do usuário cadastradas com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao Cadastrar permissões do usuario: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(lTUsuario_Permissoes);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;

end;

procedure User_Permissoes_Alt(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario_Permissoes :TUsuario_Permissoes;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;


      lTUsuario_Permissoes := TUsuario_Permissoes.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTUsuario_Permissoes.Inicia_Propriedades;

        lTUsuario_Permissoes.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTUsuario_Permissoes.ID := lBody[I].GetValue<Integer>('id',0);
        lTUsuario_Permissoes.OBJETO := lBody[I].GetValue<String>('objeto','');
        lTUsuario_Permissoes.VISUALIZAR_PER := lBody[I].GetValue<String>('visualizarPer','');
        lTUsuario_Permissoes.INCLUIR_PER := lBody[I].GetValue<String>('incluirPer','');
        lTUsuario_Permissoes.ALTERAR_PER := lBody[I].GetValue<String>('alterarPer','');
        lTUsuario_Permissoes.EXCLUIR_PER := lBody[I].GetValue<String>('excluirPer','');
        lTUsuario_Permissoes.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Permissões do usuário alteradas com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Permissões do usuário alteradas com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao alteradas permissões do usuario: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);

      FreeAndNil(lTUsuario_Permissoes);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure User_Permissoes_Del(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  DM_Lanchonete :TDM_Lanchonete;
  lTUsuario_Permissoes :TUsuario_Permissoes;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTUsuario_Permissoes := TUsuario_Permissoes.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lTUsuario_Permissoes.Inicia_Propriedades;
      lTUsuario_Permissoes.ID := StrToIntDef(Req.Query['id'],0);
      lTUsuario_Permissoes.ID_USUARIO := StrToIntDef(Req.Query['idUsuario'],0);
      lTUsuario_Permissoes.Excluir(lQuery);

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Permissão do usuário excluída com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Permissão do usuário excluída com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluír a permissão do usuario: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTUsuario_Permissoes);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

end.
