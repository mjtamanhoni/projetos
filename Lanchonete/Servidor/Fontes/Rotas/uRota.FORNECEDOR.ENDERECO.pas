unit uRota.FORNECEDOR.ENDERECO;

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

  uModel.FORNECEDOR.ENDERECO,
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
  {$Region 'FORNECEDOR_ENDERECO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/fornecedor/endereco',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/fornecedor/endereco',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/fornecedor/endereco',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/fornecedor/endereco',Delete);
  {$EndRegion 'FORNECEDOR_ENDERECO'}
end;

procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_ENDERECO :TFORNECEDOR_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdFornecedor :Integer;
  lPagina :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFORNECEDOR_ENDERECO := TFORNECEDOR_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdFornecedor := 0;
      lPagina := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdFornecedor := StrToIntDef(Req.Query['idFornecedor'],0);
      lPagina := StrToIntDef(Req.Query['pagina'],0);

      lJson_Ret := lTFORNECEDOR_ENDERECO.Listar(
        lQuery
        ,lIdFornecedor
        ,lId
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('401 - Endereço do Fornecedor não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Fornecedor não localizado');
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
      FreeAndNil(lTFORNECEDOR_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTFORNECEDOR_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_ENDERECO :TFORNECEDOR_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFORNECEDOR_ENDERECO := TFORNECEDOR_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFORNECEDOR_ENDERECO.Inicia_Propriedades;

        lTFORNECEDOR_ENDERECO.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFORNECEDOR_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0);
        lTFORNECEDOR_ENDERECO.CEP := lBody[I].GetValue<String>('cep','');
        lTFORNECEDOR_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTFORNECEDOR_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFORNECEDOR_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTFORNECEDOR_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTFORNECEDOR_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTFORNECEDOR_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTFORNECEDOR_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTFORNECEDOR_ENDERECO.UF := lBody[I].GetValue<String>('uf','');
        lTFORNECEDOR_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTFORNECEDOR_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTFORNECEDOR_ENDERECO.PAIS := lBody[I].GetValue<String>('pais','');
        lTFORNECEDOR_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFORNECEDOR_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_ENDERECO.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereço do Fornecedor cadastrado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Fornecedor cadastrado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar o endereço do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFORNECEDOR_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      lTFORNECEDOR_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_ENDERECO :TFORNECEDOR_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFORNECEDOR_ENDERECO := TFORNECEDOR_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFORNECEDOR_ENDERECO.Inicia_Propriedades;

        lTFORNECEDOR_ENDERECO.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFORNECEDOR_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0);
        lTFORNECEDOR_ENDERECO.CEP := lBody[I].GetValue<String>('cep','');
        lTFORNECEDOR_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro','');
        lTFORNECEDOR_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFORNECEDOR_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento','');
        lTFORNECEDOR_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro','');
        lTFORNECEDOR_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0);
        lTFORNECEDOR_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio','');
        lTFORNECEDOR_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf','');
        lTFORNECEDOR_ENDERECO.UF := lBody[I].GetValue<String>('uf','');
        lTFORNECEDOR_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao','');
        lTFORNECEDOR_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0);
        lTFORNECEDOR_ENDERECO.PAIS := lBody[I].GetValue<String>('pais','');
        lTFORNECEDOR_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFORNECEDOR_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_ENDERECO.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Endereço do Fornecedor alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Fornecedor alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao alterar o Endereço do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFORNECEDOR_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      lTFORNECEDOR_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_ENDERECO :TFORNECEDOR_ENDERECO;
  lErro :String;

  lQuery :TFDQuery;
  lID_FORNECEDOR :Integer;
  lID :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFORNECEDOR_ENDERECO := TFORNECEDOR_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lID_FORNECEDOR := StrToIntDef(Req.Query['fornecedorId'],0);
      lID := StrToIntDef(Req.Query['id'],0);

      lTFORNECEDOR_ENDERECO.Excluir(lQuery,lID_FORNECEDOR,lId);

      Res.Send('Endereço do Fornecedor excluído').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço do Fornecedor excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o endereço do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFORNECEDOR_ENDERECO);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTFORNECEDOR_ENDERECO.DisposeOf;
    {$ENDIF}
  end;
end;

end.
