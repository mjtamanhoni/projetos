unit uRota.CLIENTE.ENDERECO;

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

  uModel.CLIENTE.ENDERECO,
  uFuncoes,
  uDm_Lanchonete,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

  procedure RegistrarRotas;

  procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure RegistrarRotas;
begin
  {$Region 'CLIENTE_ENDERECO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/cliente/endereco',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/cliente/endereco',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/cliente/endereco',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/cliente/endereco',Delete);
  {$EndRegion 'CLIENTE_ENDERECO'}
end;

procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_ENDERECO :TCLIENTE_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdCliente :Integer;
  lPagina :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCLIENTE_ENDERECO := TCLIENTE_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdCliente := 0;
      lPagina := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdCliente := StrToIntDef(Req.Query['idCliente'],0);
      lPagina := StrToIntDef(Req.Query['pagina'],0);

      lJson_Ret := lTCLIENTE_ENDERECO.Listar(
        lQuery
        ,lIdCliente
        ,lId
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('401 - Endereço do Cliente não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Cliente não localizado');
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
      FreeAndNil(lTCLIENTE_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTCLIENTE_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_ENDERECO :TCLIENTE_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCLIENTE_ENDERECO := TCLIENTE_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCLIENTE_ENDERECO.Inicia_Propriedades;

        lTCLIENTE_ENDERECO.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0);
        lTCLIENTE_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0);
        lTCLIENTE_ENDERECO.CEP := lBody[I].GetValue<String>('cep','');
        lTCLIENTE_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTCLIENTE_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCLIENTE_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTCLIENTE_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTCLIENTE_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTCLIENTE_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTCLIENTE_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTCLIENTE_ENDERECO.UF := lBody[I].GetValue<String>('uf','');
        lTCLIENTE_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTCLIENTE_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTCLIENTE_ENDERECO.PAIS := lBody[I].GetValue<String>('pais','');
        lTCLIENTE_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCLIENTE_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_ENDERECO.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereço do Cliente cadastrado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Cliente cadastrado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar o endereço do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCLIENTE_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      lTCLIENTE_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_ENDERECO :TCLIENTE_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCLIENTE_ENDERECO := TCLIENTE_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCLIENTE_ENDERECO.Inicia_Propriedades;

        lTCLIENTE_ENDERECO.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0);
        lTCLIENTE_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0);
        lTCLIENTE_ENDERECO.CEP := lBody[I].GetValue<String>('cep','');
        lTCLIENTE_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTCLIENTE_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCLIENTE_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTCLIENTE_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTCLIENTE_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTCLIENTE_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTCLIENTE_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTCLIENTE_ENDERECO.UF := lBody[I].GetValue<String>('uf','');
        lTCLIENTE_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTCLIENTE_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTCLIENTE_ENDERECO.PAIS := lBody[I].GetValue<String>('pais','');
        lTCLIENTE_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCLIENTE_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_ENDERECO.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereço do Cliente alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Cliente alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao alterar o Endereço do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCLIENTE_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      lTCLIENTE_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_ENDERECO :TCLIENTE_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;
  lID_CLIENTE :Integer;
  lID :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCLIENTE_ENDERECO := TCLIENTE_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lID_CLIENTE := StrToIntDef(Req.Query['clienteId'],0);
      lID := StrToIntDef(Req.Query['id'],0);

      lTCLIENTE_ENDERECO.Excluir(lQuery,lID_CLIENTE,lId);

      Res.Send('Endereço do Cliente excluído').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Cliente excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o endereço do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCLIENTE_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTCLIENTE_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

end.
