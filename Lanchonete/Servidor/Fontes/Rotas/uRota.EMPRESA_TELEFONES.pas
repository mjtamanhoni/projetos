unit uRota.EMPRESA_TELEFONES;
 
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
 
  uModel.EMPRESA_TELEFONES, 
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
  {$Region 'EMPRESA_TELEFONES'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/empresa/telefones',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/empresa/telefones',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/empresa/telefones',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/empresa/telefones',Delete);
  {$EndRegion 'EMPRESA_TELEFONES'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_TELEFONES :TEMPRESA_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lId :Integer;
  lIdEmpresa :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTEMPRESA_TELEFONES := TEMPRESA_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdEmpresa := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdEmpresa := StrToIntDef(Req.Query['idEmpresa'],0);

      lJson_Ret := lTEMPRESA_TELEFONES.Listar(
        lQuery
        ,lIdEmpresa
        ,lId);
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('Telefones n�o localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Telefones da Empressa n�o localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Telefones da Empresa');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao listar Telefones da Empresa: ' + E.Message);
      end;
    end;
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_TELEFONES :TEMPRESA_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTEMPRESA_TELEFONES := TEMPRESA_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('N�o h� registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA_TELEFONES.Inicia_Propriedades; 
 
        lTEMPRESA_TELEFONES.ID_EMPRESA := lBody[I].GetValue<Integer>('idEmpresa',0); 
        lTEMPRESA_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0); 
        lTEMPRESA_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0); 
        lTEMPRESA_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTEMPRESA_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTEMPRESA_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_TELEFONES.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('EMPRESA_TELEFONES cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'EMPRESA_TELEFONES cadastrados com sucesso');
    except on E: Exception do 
      begin 
        DM_Lanchonete.FDC_Lanchonete.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar EMPRESA_TELEFONES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_TELEFONES :TEMPRESA_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTEMPRESA_TELEFONES := TEMPRESA_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('N�o h� registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA_TELEFONES.Inicia_Propriedades; 
 
        lTEMPRESA_TELEFONES.ID_EMPRESA := lBody[I].GetValue<Integer>('idEmpresa',0); 
        lTEMPRESA_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0); 
        lTEMPRESA_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0); 
        lTEMPRESA_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTEMPRESA_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTEMPRESA_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_TELEFONES.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('EMPRESA_TELEFONES alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'EMPRESA_TELEFONES alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar EMPRESA_TELEFONES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_TELEFONES :TEMPRESA_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_EMPRESA :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTEMPRESA_TELEFONES := TEMPRESA_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lID_EMPRESA := StrToIntDef(Req.Query['idEmpresa'],0);
      lID := StrToIntDef(Req.Query['id'],0);

      lTEMPRESA_TELEFONES.Excluir(lQuery,lID_EMPRESA,lID);
 
      Res.Send('EMPRESA_TELEFONES exclu�do').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'EMPRESA_TELEFONES exclu�do');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o EMPRESA_TELEFONES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
