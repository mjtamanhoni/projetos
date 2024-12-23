unit uRota.Fornecedores;

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

  uModel.Fornecedor,
  uFuncoes,
  uDm_Lanchonete,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

procedure RegistrarRotas;

  {$Region 'Fornecedor'}
    procedure Fornecedor_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Fornecedor_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Fornecedor_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Fornecedor_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  {$EndRegion 'Fornecedor'}

  {$Region 'Fornecedor Endereço'}
    procedure FornecedorE_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure FornecedorE_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure FornecedorE_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure FornecedorE_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  {$EndRegion 'Fornecedor Endereço'}

  {$Region 'Fornecedor Telefone'}
    procedure FornecedorT_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure FornecedorT_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure FornecedorT_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure FornecedorT_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  {$EndRegion 'Fornecedor Telefone'}

implementation

procedure RegistrarRotas;
begin
  {$Region 'Fornecedor'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/fornecedor',Fornecedor_Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/fornecedor',Fornecedor_Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/fornecedor',Fornecedor_Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/fornecedor',Fornecedor_Delete);
  {$EndRegion 'Fornecedor'}

  (*
  {$Region 'Fornecedor Endereço'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/fornecedor/endereco',FornecedorE_Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/fornecedor/endereco',FornecedorE_Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/fornecedor/endereco',FornecedorE_Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/fornecedor/endereco',FornecedorE_Delete);
  {$EndRegion 'Fornecedor Endereço'}

  {$Region 'Fornecedor Telefone'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/fornecedor/telefone',FornecedorT_Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/fornecedor/telefone',FornecedorT_Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/fornecedor/telefone',FornecedorT_Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/fornecedor/telefone',FornecedorT_Delete);
  {$EndRegion 'Fornecedor Telefone'}
  *)

end;

{$Region 'Fornecedor'}
procedure Fornecedor_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor :TFornecedor;
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

      lTFornecedor := TFornecedor.Create(DM_Lanchonete.FDC_Lanchonete);
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

      lJson_Ret := lTFornecedor.Listar(
        lQuery
        ,lId
        ,lRazaoSocial
        ,lNomeFantasia
        ,lDocumento
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Fornecedor não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Fornecedor não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Fornecedores');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar Fornecedores: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFornecedor);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Fornecedor_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor :TFornecedor;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFornecedor := TFornecedor.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFornecedor.Inicia_Propriedades;

        lTFornecedor.RAZAO_SOCIAL := lBody[I].GetValue<String>('razaoSocial','');
        lTFornecedor.NOME_FANTASIA := lBody[I].GetValue<String>('nomeFantasia','');
        lTFornecedor.STATUS := lBody[I].GetValue<Integer>('status',0);
        lTFornecedor.TIPO_PESSOA := lBody[I].GetValue<String>('tipoPessoa','');
        lTFornecedor.DOCUMENTO := lBody[I].GetValue<String>('documento','');
        lTFornecedor.INSCRICAO_ESTADUAL := lBody[I].GetValue<String>('inscricaoEstadual','');
        lTFornecedor.INSCRICAO_MUNICIPAL := lBody[I].GetValue<String>('inscricaoMunicipal','');
        lTFornecedor.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFornecedor.DT_CADASTRO := TFuncoes.Converte_Data(lBody[I].GetValue<String>('dtCadastro',FormatDateTime('YYYY-MM-DD',Date)));
        lTFornecedor.HR_CADASTRO := TFuncoes.Converte_Hora(lBody[I].GetValue<String>('hrCadastro',FormatDateTime('HH:NN:SS'+'.000',Time)));
        lTFornecedor.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Fornecedores cadastrados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Fornecedores cadastrados com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar fornecedores: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFornecedor);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Fornecedor_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor :TFornecedor;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFornecedor := TFornecedor.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFornecedor.Inicia_Propriedades;

        lTFornecedor.ID := lBody[I].GetValue<Integer>('id',0);
        lTFornecedor.RAZAO_SOCIAL := lBody[I].GetValue<String>('razaoSocial','');
        lTFornecedor.NOME_FANTASIA := lBody[I].GetValue<String>('nomeFantasia','');
        lTFornecedor.STATUS := lBody[I].GetValue<Integer>('status',0);
        lTFornecedor.TIPO_PESSOA := lBody[I].GetValue<String>('tipoPessoa','');
        lTFornecedor.DOCUMENTO := lBody[I].GetValue<String>('documento','');
        lTFornecedor.INSCRICAO_ESTADUAL := lBody[I].GetValue<String>('inscricaoEstadual','');
        lTFornecedor.INSCRICAO_MUNICIPAL := lBody[I].GetValue<String>('inscricaoMunicipal','');
        lTFornecedor.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFornecedor.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Fornecedor alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Fornecedor alterado com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFornecedor);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Fornecedor_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor :TFornecedor;
  lErro :String;

  lQuery :TFDQuery;
  lId :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFornecedor := TFornecedor.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lId := StrToIntDef(Req.Query['id'],0);

      lTFornecedor.Excluir(lQuery,lId);

      Res.Send('Fornecedor excluído').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Fornecedor excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFornecedor);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;
{$EndRegion 'Fornecedor'}

{$Region 'Endereço do fornecedor'}
procedure FornecedorE_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Endereco :TFornecedor_Endereco;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdFornecedor :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFornecedor_Endereco := TFornecedor_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdFornecedor := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdFornecedor := StrToIntDef(Req.Query['idFornecedor'],0);

      lJson_Ret := lTFornecedor_Endereco.Listar(
        lQuery
        ,lId
        ,lIdFornecedor);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Endereços do Fornecedor não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Endereços do Fornecedor não localizados');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Endereços do Fornecedor');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar Endereços do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFornecedor_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure FornecedorE_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Endereco :TFornecedor_Endereco;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFornecedor_Endereco := TFornecedor_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFornecedor_Endereco.Inicia_Propriedades;

        lTFornecedor_Endereco.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFornecedor_Endereco.CEP := lBody[I].GetValue<String>('cep','');
        lTFornecedor_Endereco.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTFornecedor_Endereco.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFornecedor_Endereco.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTFornecedor_Endereco.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTFornecedor_Endereco.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTFornecedor_Endereco.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTFornecedor_Endereco.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTFornecedor_Endereco.UF := lBody[I].GetValue<String>('uf','');
        lTFornecedor_Endereco.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTFornecedor_Endereco.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTFornecedor_Endereco.PAIS := lBody[I].GetValue<String>('pais','');
        lTFornecedor_Endereco.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFornecedor_Endereco.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTFornecedor_Endereco.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',TimeToStr(Time)),lErro);
        lTFornecedor_Endereco.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereços do Fornecedor cadastrados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereços do Fornecedor cadastrados com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar endereços do fornecedores: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFornecedor_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure FornecedorE_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Endereco :TFornecedor_Endereco;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFornecedor_Endereco := TFornecedor_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFornecedor_Endereco.Inicia_Propriedades;

        lTFornecedor_Endereco.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFornecedor_Endereco.ID := lBody[I].GetValue<Integer>('id',0);
        lTFornecedor_Endereco.CEP := lBody[I].GetValue<String>('cep','');
        lTFornecedor_Endereco.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTFornecedor_Endereco.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFornecedor_Endereco.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTFornecedor_Endereco.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTFornecedor_Endereco.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTFornecedor_Endereco.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTFornecedor_Endereco.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTFornecedor_Endereco.UF := lBody[I].GetValue<String>('uf','');
        lTFornecedor_Endereco.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTFornecedor_Endereco.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTFornecedor_Endereco.PAIS := lBody[I].GetValue<String>('pais','');
        lTFornecedor_Endereco.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFornecedor_Endereco.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereços do Fornecedor alterados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereços do Fornecedor alterados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao alterar endereços do fornecedores: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFornecedor_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure FornecedorE_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Endereco :TFornecedor_Endereco;
  lErro :String;

  lQuery :TFDQuery;
  lId :Integer;
  lIdFornecedor :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFornecedor_Endereco := TFornecedor_Endereco.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdFornecedor := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdFornecedor := StrToIntDef(Req.Query['idFornecedor'],0);

      lTFornecedor_Endereco.Excluir(lQuery,lIdFornecedor,lId);

      Res.Send('Endereço do Fornecedor excluído com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Fornecedor excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir Endereço do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFornecedor_Endereco);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;
{$EndRegion 'Endereço do fornecedor'}

{$Region 'Fornecedor Telefone'}
procedure FornecedorT_Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Telefone :TFornecedor_Telefone;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdFornecedor :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFornecedor_Telefone := TFornecedor_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdFornecedor := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdFornecedor := StrToIntDef(Req.Query['idFornecedor'],0);

      lJson_Ret := lTFornecedor_Telefone.Listar(
        lQuery
        ,lId
        ,lIdFornecedor);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Telefones do Fornecedor não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Fornecedor não localizados');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Telefones do Fornecedor');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar Telefones do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFornecedor_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

procedure FornecedorT_Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Telefone :TFornecedor_Telefone;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFornecedor_Telefone := TFornecedor_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFornecedor_Telefone.Inicia_Propriedades;

        lTFornecedor_Telefone.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFornecedor_Telefone.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTFornecedor_Telefone.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFornecedor_Telefone.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFornecedor_Telefone.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTFornecedor_Telefone.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',TimeToStr(Time)),lErro);
        lTFornecedor_Telefone.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefones do Fornecedor cadastrados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Fornecedor cadastrados com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar telefones do fornecedores: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFornecedor_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure FornecedorT_Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Telefone :TFornecedor_Telefone;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFornecedor_Telefone := TFornecedor_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFornecedor_Telefone.Inicia_Propriedades;

        lTFornecedor_Telefone.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFornecedor_Telefone.ID := lBody[I].GetValue<Integer>('id',0);
        lTFornecedor_Telefone.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTFornecedor_Telefone.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFornecedor_Telefone.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFornecedor_Telefone.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefones do Fornecedor alterados com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Fornecedor alterados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar telefones do fornecedores: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFornecedor_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      lTUsuario_Permissoes.DisposeOf;
    {$ENDIF}
  end;
end;

procedure FornecedorT_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFornecedor_Telefone :TFornecedor_Telefone;
  lErro :String;

  lQuery :TFDQuery;
  lId :Integer;
  lIdFornecedor :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFornecedor_Telefone := TFornecedor_Telefone.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdFornecedor := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdFornecedor := StrToIntDef(Req.Query['idFornecedor'],0);

      lTFornecedor_Telefone.Excluir(lQuery,lIdFornecedor,lId);

      Res.Send('Telefone excluído com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Fornecedor excluído com sucesso');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir Telefones do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFornecedor_Telefone);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;
{$EndRegion 'Fornecedor Telefone'}

end.
