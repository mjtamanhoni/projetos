unit uRota.EMPRESA_ENDERECO;
 
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
 
  uModel.EMPRESA_ENDERECO, 
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
  {$Region 'EMPRESA_ENDERECO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/empresa/endereco',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/empresa/endereco',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/empresa/endereco',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/empresa/endereco',Delete);
  {$EndRegion 'EMPRESA_ENDERECO'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_ENDERECO :TEMPRESA_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lId :Integer;
  lIdEmpresa :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTEMPRESA_ENDERECO := TEMPRESA_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdEmpresa := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdEmpresa := StrToIntDef(Req.Query['idEmpresa'],0);

      lJson_Ret := lTEMPRESA_ENDERECO.Listar(
        lQuery
        ,lIdEmpresa
        ,lId);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('401 - Endereço da Empresa não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Endereço da empresa não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Endereços da Empresa');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar Endereços da Empresa: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_ENDERECO :TEMPRESA_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTEMPRESA_ENDERECO := TEMPRESA_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA_ENDERECO.Inicia_Propriedades; 
 
        lTEMPRESA_ENDERECO.ID_EMPRESA := lBody[I].GetValue<Integer>('idEmpresa',0); 
        lTEMPRESA_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTEMPRESA_ENDERECO.CEP := lBody[I].GetValue<String>('cep',''); 
        lTEMPRESA_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro',''); 
        lTEMPRESA_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTEMPRESA_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento',''); 
        lTEMPRESA_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro',''); 
        lTEMPRESA_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTEMPRESA_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio',''); 
        lTEMPRESA_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf',''); 
        lTEMPRESA_ENDERECO.UF := lBody[I].GetValue<String>('uf',''); 
        lTEMPRESA_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao',''); 
        lTEMPRESA_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0); 
        lTEMPRESA_ENDERECO.PAIS := lBody[I].GetValue<String>('pais',''); 
        lTEMPRESA_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTEMPRESA_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_ENDERECO.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('Endereço da Empresa cadastrado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço da Empresa cadastrado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar o endereço da Empresa: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_ENDERECO :TEMPRESA_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTEMPRESA_ENDERECO := TEMPRESA_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA_ENDERECO.Inicia_Propriedades; 
 
        lTEMPRESA_ENDERECO.ID_EMPRESA := lBody[I].GetValue<Integer>('idEmpresa',0); 
        lTEMPRESA_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTEMPRESA_ENDERECO.CEP := lBody[I].GetValue<String>('cep',''); 
        lTEMPRESA_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro',''); 
        lTEMPRESA_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTEMPRESA_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento',''); 
        lTEMPRESA_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro',''); 
        lTEMPRESA_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTEMPRESA_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio',''); 
        lTEMPRESA_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf',''); 
        lTEMPRESA_ENDERECO.UF := lBody[I].GetValue<String>('uf',''); 
        lTEMPRESA_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao',''); 
        lTEMPRESA_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0); 
        lTEMPRESA_ENDERECO.PAIS := lBody[I].GetValue<String>('pais',''); 
        lTEMPRESA_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTEMPRESA_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_ENDERECO.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('Endereço da Empresa alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço da Empresa alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao alterar o Endereço da Empresa: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_ENDERECO :TEMPRESA_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_EMPRESA :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTEMPRESA_ENDERECO := TEMPRESA_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_EMPRESA := StrToIntDef(Req.Query['empresaId'],0);
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTEMPRESA_ENDERECO.Excluir(lQuery,lID_EMPRESA,lId);

      Res.Send('Endereço da Empresa excluído').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Endereço da Empresa excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o endereço da Empresa: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
