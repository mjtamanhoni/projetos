unit uRota.SUB_GRUPO;
 
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
 
  uModel.SUB_GRUPO, 
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
  {$Region 'SUB_GRUPO'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/subGrupo',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/subGrupo',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/subGrupo',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/subGrupo',Delete);
  {$EndRegion 'SUB_GRUPO'}
end;
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTSUB_GRUPO :TSUB_GRUPO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_GRUPO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTSUB_GRUPO := TSUB_GRUPO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_GRUPO := StrToIntDef(Req.Query['idGrupo'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTSUB_GRUPO.Listar(lQuery,lID_GRUPO,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('SUB_GRUPO não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'SUB_GRUPO não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de SUB_GRUPO');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar SUB_GRUPO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTSUB_GRUPO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTSUB_GRUPO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTSUB_GRUPO :TSUB_GRUPO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTSUB_GRUPO := TSUB_GRUPO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTSUB_GRUPO.Inicia_Propriedades; 
 
        lTSUB_GRUPO.ID_GRUPO := lBody[I].GetValue<Integer>('idGrupo',0); 
        lTSUB_GRUPO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTSUB_GRUPO.NOME := lBody[I].GetValue<String>('nome',''); 
        lTSUB_GRUPO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTSUB_GRUPO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTSUB_GRUPO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTSUB_GRUPO.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('SUB_GRUPO cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'SUB_GRUPO cadastrados com sucesso');
    except on E: Exception do 
      begin 
        DM_Lanchonete.FDC_Lanchonete.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar SUB_GRUPO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTSUB_GRUPO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTSUB_GRUPO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTSUB_GRUPO :TSUB_GRUPO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTSUB_GRUPO := TSUB_GRUPO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTSUB_GRUPO.Inicia_Propriedades; 
 
        lTSUB_GRUPO.ID_GRUPO := lBody[I].GetValue<Integer>('idGrupo',0); 
        lTSUB_GRUPO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTSUB_GRUPO.NOME := lBody[I].GetValue<String>('nome',''); 
        lTSUB_GRUPO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTSUB_GRUPO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTSUB_GRUPO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTSUB_GRUPO.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('SUB_GRUPO alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'SUB_GRUPO alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar SUB_GRUPO: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTSUB_GRUPO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTSUB_GRUPO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTSUB_GRUPO :TSUB_GRUPO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_GRUPO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTSUB_GRUPO := TSUB_GRUPO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_GRUPO := StrToIntDef(Req.Query['idGrupo'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTSUB_GRUPO.Excluir(lQuery,lID_GRUPO,lID); 
 
      Res.Send('SUB_GRUPO excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'SUB_GRUPO excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o SUB_GRUPO: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTSUB_GRUPO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTSUB_GRUPO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
