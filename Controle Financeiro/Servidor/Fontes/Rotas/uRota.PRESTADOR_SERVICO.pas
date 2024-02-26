unit uRota.PRESTADOR_SERVICO; 
 
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
 
  uModel.PRESTADOR_SERVICO, 
  uFuncoes, 
  uDM_Global,
 
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
  {$Region 'PRESTADOR_SERVICO'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/prestadorServico',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/prestadorServico',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/prestadorServico',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/prestadorServico',Delete);
  {$EndRegion 'PRESTADOR_SERVICO'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM;
  lTPRESTADOR_SERVICO :TPRESTADOR_SERVICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      FDm := TDM.Create(Nil);
 
      lTPRESTADOR_SERVICO := TPRESTADOR_SERVICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := 0; 
      lID := StrToIntDef(Req.Query['id'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTPRESTADOR_SERVICO.Listar(lQuery,lID,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('PRESTADOR_SERVICO não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - PRESTADOR_SERVICO não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de PRESTADOR_SERVICO'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar PRESTADOR_SERVICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTPRESTADOR_SERVICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTPRESTADOR_SERVICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM;
  lTPRESTADOR_SERVICO :TPRESTADOR_SERVICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTPRESTADOR_SERVICO := TPRESTADOR_SERVICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTPRESTADOR_SERVICO.Inicia_Propriedades; 
 
        lTPRESTADOR_SERVICO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTPRESTADOR_SERVICO.NOME := lBody[I].GetValue<String>('nome',''); 
        lTPRESTADOR_SERVICO.CELULAR := lBody[I].GetValue<String>('celular',''); 
        lTPRESTADOR_SERVICO.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTPRESTADOR_SERVICO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTPRESTADOR_SERVICO.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTPRESTADOR_SERVICO.Inserir(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('PRESTADOR_SERVICO cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - PRESTADOR_SERVICO cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar PRESTADOR_SERVICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTPRESTADOR_SERVICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTPRESTADOR_SERVICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM;
  lTPRESTADOR_SERVICO :TPRESTADOR_SERVICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTPRESTADOR_SERVICO := TPRESTADOR_SERVICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTPRESTADOR_SERVICO.Inicia_Propriedades; 
 
        lTPRESTADOR_SERVICO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTPRESTADOR_SERVICO.NOME := lBody[I].GetValue<String>('nome',''); 
        lTPRESTADOR_SERVICO.CELULAR := lBody[I].GetValue<String>('celular',''); 
        lTPRESTADOR_SERVICO.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTPRESTADOR_SERVICO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTPRESTADOR_SERVICO.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTPRESTADOR_SERVICO.Atualizar(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('PRESTADOR_SERVICO alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - PRESTADOR_SERVICO alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar PRESTADOR_SERVICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTPRESTADOR_SERVICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTPRESTADOR_SERVICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM;
  lTPRESTADOR_SERVICO :TPRESTADOR_SERVICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      FDm := TDM.Create(Nil);
 
      lTPRESTADOR_SERVICO := TPRESTADOR_SERVICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTPRESTADOR_SERVICO.Excluir(lQuery,lID); 
 
      Res.Send('PRESTADOR_SERVICO excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - PRESTADOR_SERVICO excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o PRESTADOR_SERVICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTPRESTADOR_SERVICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTPRESTADOR_SERVICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
