unit uRota.EMPRESA_EMAIL; 
 
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
 
  uModel.EMPRESA_EMAIL, 
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
  {$Region 'EMPRESA_EMAIL'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/empresa/email',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/empresa/email',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/empresa/email',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/empresa/email',Delete);
  {$EndRegion 'EMPRESA_EMAIL'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_EMAIL :TEMPRESA_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_EMPRESA :Integer;
  lID :Integer;
  lID_SETOR :Integer;
  lRESPONSAVEL :String;
  lEMAIL :String;

  lPagina :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTEMPRESA_EMAIL := TEMPRESA_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lID_EMPRESA := 0;
      lID_EMPRESA := StrToIntDef(Req.Query['idEmpresa'],0);
      lID := 0;
      lID := StrToIntDef(Req.Query['id'],0);
      lID_SETOR := 0;
      lID_SETOR := StrToIntDef(Req.Query['idSetor'],0);
      lRESPONSAVEL := '';
      lRESPONSAVEL := Req.Query['responsavel'];
      lEMAIL := '';
      lEMAIL := Req.Query['email'];

      lPagina := 0;
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTEMPRESA_EMAIL.Listar(
        lQuery
        ,lID_EMPRESA
        ,lID
        ,lID_SETOR
        ,lRESPONSAVEL
        ,lEMAIL
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin 
        Res.Send('EMPRESA_EMAIL não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - EMPRESA_EMAIL não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de EMPRESA_EMAIL'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar EMPRESA_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_EMAIL :TEMPRESA_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then 
        DM_Lanchonete.FDC_Lanchonete.StartTransaction; 
 
      lTEMPRESA_EMAIL := TEMPRESA_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA_EMAIL.Inicia_Propriedades; 
 
        lTEMPRESA_EMAIL.ID_EMPRESA := lBody[I].GetValue<Integer>('idEmpresa',0); 
        lTEMPRESA_EMAIL.ID := lBody[I].GetValue<Integer>('id',0); 
        lTEMPRESA_EMAIL.RESPONSAVEL := lBody[I].GetValue<String>('responsavel',''); 
        lTEMPRESA_EMAIL.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTEMPRESA_EMAIL.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTEMPRESA_EMAIL.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTEMPRESA_EMAIL.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_EMAIL.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_EMAIL.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 

      Res.Send('Email da Empresa cadastrado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,' - Email da Empresa cadastrados com sucesso');

    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar Email da Empresa: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_EMAIL :TEMPRESA_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then 
        DM_Lanchonete.FDC_Lanchonete.StartTransaction; 
 
      lTEMPRESA_EMAIL := TEMPRESA_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA_EMAIL.Inicia_Propriedades; 
 
        lTEMPRESA_EMAIL.ID_EMPRESA := lBody[I].GetValue<Integer>('idEmpresa',0); 
        lTEMPRESA_EMAIL.ID := lBody[I].GetValue<Integer>('id',0); 
        lTEMPRESA_EMAIL.RESPONSAVEL := lBody[I].GetValue<String>('responsavel',''); 
        lTEMPRESA_EMAIL.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTEMPRESA_EMAIL.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTEMPRESA_EMAIL.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTEMPRESA_EMAIL.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_EMAIL.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTEMPRESA_EMAIL.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('EMPRESA_EMAIL alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - EMPRESA_EMAIL alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        DM_Lanchonete.FDC_Lanchonete.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar EMPRESA_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA_EMAIL :TEMPRESA_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_EMPRESA :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTEMPRESA_EMAIL := TEMPRESA_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_EMPRESA := StrToIntDef(Req.Query['idEmpresa'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTEMPRESA_EMAIL.Excluir(lQuery,lID_EMPRESA,lID); 
 
      Res.Send('E-mail da Empresa excluído').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,' - E-mail da empresa excluído');
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o E-mail da Empresa: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
