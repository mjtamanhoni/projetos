unit uRota.CLIENTE; 
 
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
 
  uModel.CLIENTE, 
  uFuncoes, 
  uDm.Servidor,

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
  {$Region 'CLIENTE'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/cliente',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/cliente',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/cliente',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/cliente',Delete);
  {$EndRegion 'CLIENTE'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM_Servidor;
  lTCLIENTE :TCLIENTE; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
 
      lTCLIENTE := TCLIENTE.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := 0; 
      lID := StrToIntDef(Req.Query['id'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTCLIENTE.Listar(lQuery,lID,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('CLIENTE não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de CLIENTE'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar CLIENTE: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTCLIENTE); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTCLIENTE.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM_Servidor;
  lTCLIENTE :TCLIENTE; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTCLIENTE := TCLIENTE.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCLIENTE.Inicia_Propriedades; 
 
        lTCLIENTE.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCLIENTE.NOME := lBody[I].GetValue<String>('nome',''); 
        lTCLIENTE.PESSOA := lBody[I].GetValue<Integer>('pessoa',0); 
        lTCLIENTE.DOCUMENTO := lBody[I].GetValue<String>('documento',''); 
        lTCLIENTE.INSC_EST := lBody[I].GetValue<String>('inscEst',''); 
        lTCLIENTE.CEP := lBody[I].GetValue<String>('cep',''); 
        lTCLIENTE.ENDERECO := lBody[I].GetValue<String>('endereco',''); 
        lTCLIENTE.COMPLEMENTO := lBody[I].GetValue<String>('complemento',''); 
        lTCLIENTE.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTCLIENTE.BAIRRO := lBody[I].GetValue<String>('bairro',''); 
        lTCLIENTE.CIDADE := lBody[I].GetValue<String>('cidade',''); 
        lTCLIENTE.UF := lBody[I].GetValue<String>('uf',''); 
        lTCLIENTE.TELEFONE := lBody[I].GetValue<String>('telefone',''); 
        lTCLIENTE.CELULAR := lBody[I].GetValue<String>('celular',''); 
        lTCLIENTE.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTCLIENTE.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE.Inserir(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('CLIENTE cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar CLIENTE: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCLIENTE); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCLIENTE.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM_Servidor;
  lTCLIENTE :TCLIENTE; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTCLIENTE := TCLIENTE.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCLIENTE.Inicia_Propriedades; 
 
        lTCLIENTE.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCLIENTE.NOME := lBody[I].GetValue<String>('nome',''); 
        lTCLIENTE.PESSOA := lBody[I].GetValue<Integer>('pessoa',0); 
        lTCLIENTE.DOCUMENTO := lBody[I].GetValue<String>('documento',''); 
        lTCLIENTE.INSC_EST := lBody[I].GetValue<String>('inscEst',''); 
        lTCLIENTE.CEP := lBody[I].GetValue<String>('cep',''); 
        lTCLIENTE.ENDERECO := lBody[I].GetValue<String>('endereco',''); 
        lTCLIENTE.COMPLEMENTO := lBody[I].GetValue<String>('complemento',''); 
        lTCLIENTE.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTCLIENTE.BAIRRO := lBody[I].GetValue<String>('bairro',''); 
        lTCLIENTE.CIDADE := lBody[I].GetValue<String>('cidade',''); 
        lTCLIENTE.UF := lBody[I].GetValue<String>('uf',''); 
        lTCLIENTE.TELEFONE := lBody[I].GetValue<String>('telefone',''); 
        lTCLIENTE.CELULAR := lBody[I].GetValue<String>('celular',''); 
        lTCLIENTE.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTCLIENTE.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE.Atualizar(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('CLIENTE alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar CLIENTE: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCLIENTE); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCLIENTE.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM_Servidor;
  lTCLIENTE :TCLIENTE; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
 
      lTCLIENTE := TCLIENTE.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTCLIENTE.Excluir(lQuery,lID); 
 
      Res.Send('CLIENTE excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o CLIENTE: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTCLIENTE); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTCLIENTE.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
