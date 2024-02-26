unit uRota.HISTORICO; 
 
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
 
  uModel.HISTORICO, 
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
  {$Region 'HISTORICO'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/historico',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/historico',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/historico',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/historico',Delete);
  {$EndRegion 'HISTORICO'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM;
  lTHISTORICO :THISTORICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      FDm := TDM.Create(Nil);
 
      lTHISTORICO := THISTORICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := 0; 
      lID := StrToIntDef(Req.Query['id'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTHISTORICO.Listar(lQuery,lID,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('HISTORICO não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - HISTORICO não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de HISTORICO'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar HISTORICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTHISTORICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTHISTORICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM;
  lTHISTORICO :THISTORICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTHISTORICO := THISTORICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTHISTORICO.Inicia_Propriedades; 
 
        lTHISTORICO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTHISTORICO.DATA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('data',DateToStr(Date)),lErro); 
        lTHISTORICO.HORA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hora',DateToStr(Date)),lErro); 
        lTHISTORICO.FUNCAO := lBody[I].GetValue<String>('funcao',''); 
        lTHISTORICO.DESCRICAO := lBody[I].GetValue<String>('descricao',''); 
        lTHISTORICO.Inserir(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('HISTORICO cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - HISTORICO cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar HISTORICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTHISTORICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTHISTORICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM;
  lTHISTORICO :THISTORICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTHISTORICO := THISTORICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTHISTORICO.Inicia_Propriedades; 
 
        lTHISTORICO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTHISTORICO.DATA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('data',DateToStr(Date)),lErro); 
        lTHISTORICO.HORA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hora',DateToStr(Date)),lErro); 
        lTHISTORICO.FUNCAO := lBody[I].GetValue<String>('funcao',''); 
        lTHISTORICO.DESCRICAO := lBody[I].GetValue<String>('descricao',''); 
        lTHISTORICO.Atualizar(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('HISTORICO alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - HISTORICO alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar HISTORICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTHISTORICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTHISTORICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM;
  lTHISTORICO :THISTORICO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      FDm := TDM.Create(Nil);
 
      lTHISTORICO := THISTORICO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTHISTORICO.Excluir(lQuery,lID); 
 
      Res.Send('HISTORICO excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - HISTORICO excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o HISTORICO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTHISTORICO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTHISTORICO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
