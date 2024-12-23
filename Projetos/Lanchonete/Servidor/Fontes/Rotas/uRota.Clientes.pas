unit uRota.Clientes;

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

  uModel.Cliente,
  uFuncoes,
  uDm_Lanchonete,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

procedure RegistrarRotas;

  {$Region 'Cliente'}
    procedure Cliente_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Cliente_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Cliente_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Cliente_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  {$EndRegion 'Cliente'}

  {$Region 'Cliente Endereço'}
    procedure ClienteE_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure ClienteE_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure ClienteE_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure ClienteE_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  {$EndRegion 'Cliente Endereço'}

  {$Region 'Cliente Telefone'}
    procedure ClienteT_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure ClienteT_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure ClienteT_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure ClienteT_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  {$EndRegion 'Cliente Telefone'}

implementation

procedure RegistrarRotas;
begin
  {$Region 'CLiente'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/cliente',Cliente_Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/cliente',Cliente_Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/cliente',Cliente_Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/cliente',Cliente_Delete);
  {$EndRegion 'cliente'}

  {$Region 'cliente Endereço'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/cliente/endereco',ClienteE_Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/cliente/endereco',ClienteE_Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/cliente/endereco',ClienteE_Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/cliente/endereco',ClienteE_Delete);
  {$EndRegion 'cliente Endereço'}

  {$Region 'cliente Telefone'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/cliente/telefone',ClienteT_Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/cliente/telefone',ClienteT_Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/cliente/telefone',ClienteT_Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/cliente/telefone',ClienteT_Delete);
  {$EndRegion 'cliente Telefone'}

end;

{$Region 'cliente'}
procedure Cliente_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCliente :TCliente;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lPagina :Integer;
  lRazaoSocial :String;
  lNomeFantasia :String;
  lDocumento :String;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCliente := TCliente.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lPagina := 0;
      lRazaoSocial := '';
      lNomeFantasia := '';
      lDocumento := '';

      lId := StrToIntDef(Req.Query['id'],0);
      lPagina := StrToIntDef(Req.Query['pagina'],0);
      lRazaoSocial := Req.Query['razaoSocial'];
      lDocumento := Req.Query['documento'];
      lNomeFantasia := Req.Query['nomeFantasia'];

      lJson_Ret := lTCliente.Listar(
        lQuery
        ,lId
        ,lRazaoSocial
        ,lNomeFantasia
        ,lDocumento
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Cliente não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Cliente não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Clientees');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar Clientees: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCliente);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cliente_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCliente :TCliente;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCliente := TCliente.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCliente.Inicia_Propriedades;

        lTCliente.RAZAO_SOCIAL := lBody[I].GetValue<String>('razaoSocial','');
        lTCliente.NOME_FANTASIA := lBody[I].GetValue<String>('nomeFantasia','');
        lTCliente.STATUS := lBody[I].GetValue<Integer>('status',0);
        lTCliente.TIPO_PESSOA := lBody[I].GetValue<String>('tipoPessoa','');
        lTCliente.DOCUMENTO := lBody[I].GetValue<String>('documento','');
        lTCliente.INSCRICAO_ESTADUAL := lBody[I].GetValue<String>('inscricaoEstadual','');
        lTCliente.INSCRICAO_MUNICIPAL := lBody[I].GetValue<String>('inscricaoMunicipal','');
        lTCliente.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCliente.DT_CADASTRO := TFuncoes.Converte_Data(lBody[I].GetValue<String>('dtCadastro',FormatDateTime('YYYY-MM-DD',Date)));
        lTCliente.HR_CADASTRO := TFuncoes.Converte_Hora(lBody[I].GetValue<String>('hrCadastro',FormatDateTime('HH:NN:SS'+'.000',Time)));
        lTCliente.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Clientees cadastrados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Clientes cadastrados com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar Clientes: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCliente);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cliente_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCliente :TCliente;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCliente := TCliente.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCliente.Inicia_Propriedades;

        lTCliente.ID := lBody[I].GetValue<Integer>('id',0);
        lTCliente.RAZAO_SOCIAL := lBody[I].GetValue<String>('razaoSocial','');
        lTCliente.NOME_FANTASIA := lBody[I].GetValue<String>('nomeFantasia','');
        lTCliente.STATUS := lBody[I].GetValue<Integer>('status',0);
        lTCliente.TIPO_PESSOA := lBody[I].GetValue<String>('tipoPessoa','');
        lTCliente.DOCUMENTO := lBody[I].GetValue<String>('documento','');
        lTCliente.INSCRICAO_ESTADUAL := lBody[I].GetValue<String>('inscricaoEstadual','');
        lTCliente.INSCRICAO_MUNICIPAL := lBody[I].GetValue<String>('inscricaoMunicipal','');
        lTCliente.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCliente.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Cliente alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Cliente alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCliente);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cliente_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCliente :TCliente;
  lErro :String;

  lQuery :TFDQuery;
  lId :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCliente := TCliente.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lId := StrToIntDef(Req.Query['id'],0);

      lTCliente.Excluir(lQuery,lId);

      Res.Send('Cliente excluído').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Cliente excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCliente);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;
{$EndRegion 'Cliente'}

{$Region 'Endereço do Cliente'}
procedure ClienteE_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Endereco :TCliente_Endereco;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdCliente :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCliente_Endereco := TCliente_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdCliente := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdCliente := StrToIntDef(Req.Query['idCliente'],0);

      lJson_Ret := lTCliente_Endereco.Listar(
        lQuery
        ,lId
        ,lIdCliente);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Endereços do Cliente não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Endereços do Cliente não localizados');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Endereços do Cliente');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar Endereços do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCliente_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure ClienteE_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Endereco :TCliente_Endereco;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCliente_Endereco := TCliente_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCliente_Endereco.Inicia_Propriedades;

        lTCliente_Endereco.ID_Cliente := lBody[I].GetValue<Integer>('idCliente',0);
        lTCliente_Endereco.CEP := lBody[I].GetValue<String>('cep','');
        lTCliente_Endereco.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTCliente_Endereco.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCliente_Endereco.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTCliente_Endereco.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTCliente_Endereco.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTCliente_Endereco.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTCliente_Endereco.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTCliente_Endereco.UF := lBody[I].GetValue<String>('uf','');
        lTCliente_Endereco.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTCliente_Endereco.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTCliente_Endereco.PAIS := lBody[I].GetValue<String>('pais','');
        lTCliente_Endereco.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCliente_Endereco.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTCliente_Endereco.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',TimeToStr(Time)),lErro);
        lTCliente_Endereco.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereços do Cliente cadastrados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereços do Cliente cadastrados com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar endereços do Clientes: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCliente_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure ClienteE_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Endereco :TCliente_Endereco;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCliente_Endereco := TCliente_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCliente_Endereco.Inicia_Propriedades;

        lTCliente_Endereco.ID_Cliente := lBody[I].GetValue<Integer>('idCliente',0);
        lTCliente_Endereco.ID := lBody[I].GetValue<Integer>('id',0);
        lTCliente_Endereco.CEP := lBody[I].GetValue<String>('cep','');
        lTCliente_Endereco.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTCliente_Endereco.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCliente_Endereco.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTCliente_Endereco.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTCliente_Endereco.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTCliente_Endereco.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTCliente_Endereco.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTCliente_Endereco.UF := lBody[I].GetValue<String>('uf','');
        lTCliente_Endereco.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTCliente_Endereco.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTCliente_Endereco.PAIS := lBody[I].GetValue<String>('pais','');
        lTCliente_Endereco.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCliente_Endereco.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereços do Cliente alterados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereços do Cliente alterados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao alterar endereços do Clientes: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCliente_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure ClienteE_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Endereco :TCliente_Endereco;
  lErro :String;

  lQuery :TFDQuery;
  lId :Integer;
  lIdCliente :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCliente_Endereco := TCliente_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdCliente := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdCliente := StrToIntDef(Req.Query['idCliente'],0);

      lTCliente_Endereco.Excluir(lQuery,lIdCliente,lId);

      Res.Send('Endereço do Cliente excluído com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Cliente excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir Endereço do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCliente_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;
{$EndRegion 'Endereço do Cliente'}

{$Region 'Cliente Telefone'}
procedure ClienteT_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Telefone :TCliente_Telefone;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdCliente :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCliente_Telefone := TCliente_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdCliente := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdCliente := StrToIntDef(Req.Query['idCliente'],0);

      lJson_Ret := lTCliente_Telefone.Listar(
        lQuery
        ,lId
        ,lIdCliente);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Telefones do Cliente não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Cliente não localizados');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Telefones do Cliente');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar Telefones do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCliente_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure ClienteT_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Telefone :TCliente_Telefone;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCliente_Telefone := TCliente_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCliente_Telefone.Inicia_Propriedades;

        lTCliente_Telefone.ID_Cliente := lBody[I].GetValue<Integer>('idCliente',0);
        lTCliente_Telefone.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTCliente_Telefone.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCliente_Telefone.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCliente_Telefone.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTCliente_Telefone.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',TimeToStr(Time)),lErro);
        lTCliente_Telefone.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefones do Cliente cadastrados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Cliente cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar telefones do Clientes: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCliente_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure ClienteT_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Telefone :TCliente_Telefone;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCliente_Telefone := TCliente_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCliente_Telefone.Inicia_Propriedades;

        lTCliente_Telefone.ID_Cliente := lBody[I].GetValue<Integer>('idCliente',0);
        lTCliente_Telefone.ID := lBody[I].GetValue<Integer>('id',0);
        lTCliente_Telefone.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTCliente_Telefone.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCliente_Telefone.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCliente_Telefone.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefones do Cliente alterados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Cliente alterados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar telefones do Clientes: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCliente_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure ClienteT_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCliente_Telefone :TCliente_Telefone;
  lErro :String;

  lQuery :TFDQuery;
  lId :Integer;
  lIdCliente :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCliente_Telefone := TCliente_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdCliente := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdCliente := StrToIntDef(Req.Query['idCliente'],0);

      lTCliente_Telefone.Excluir(lQuery,lIdCliente,lId);

      Res.Send('Telefone excluído com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Cliente excluído com sucesso');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir Telefones do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCliente_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;
{$EndRegion 'Cliente Telefone'}

end.
