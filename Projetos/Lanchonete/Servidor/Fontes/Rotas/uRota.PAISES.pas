unit uRota.PAISES;
 
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
 
  uModel.PAISES, 
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
  {$Region 'PAISES'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/paises',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/paises',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/paises',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/paises',Delete);
  {$EndRegion 'PAISES'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPAISES :TPAISES; 
  lErro :String; 
 
  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I :Integer;
 
  lID :Integer;
  lNome :String;
  lPagina :Integer;

begin 
  try 
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTPAISES := TPAISES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;

      lID := StrToIntDef(Req.Query['id'],0);
      lNome := Req.Query['nome'];
      lPagina := StrToIntDef(Req.Query['pagina'],0);

      lJson_Ret := lTPAISES.Listar(lQuery,lID,lNome,lPagina);

      if lJson_Ret.Size = 0  then
      begin 
        Res.Send('PAISES não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'PAISES não localizados');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Listagem de PAISES');
      end;
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao Listar PAISES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTPAISES);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTPAISES.DisposeOf;
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPAISES :TPAISES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTPAISES := TPAISES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTPAISES.Inicia_Propriedades; 

        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_PAISES_ID,1) AS SEQ FROM RDB$DATABASE');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTPAISES.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTPAISES.ID := lBody[I].GetValue<Integer>('id',0);
        lTPAISES.ID_SPEED := lBody[I].GetValue<String>('idSpeed',''); 
        lTPAISES.NOME := lBody[I].GetValue<String>('nome',''); 
        lTPAISES.ID_SISCOMEX := lBody[I].GetValue<String>('idSiscomex',''); 
        lTPAISES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTPAISES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTPAISES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTPAISES.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('PAISES cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'PAISES cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar PAISES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTPAISES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTPAISES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPAISES :TPAISES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTPAISES := TPAISES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTPAISES.Inicia_Propriedades; 
 
        lTPAISES.ID := lBody[I].GetValue<Integer>('id',0); 
        lTPAISES.ID_SPEED := lBody[I].GetValue<String>('idSpeed',''); 
        lTPAISES.NOME := lBody[I].GetValue<String>('nome',''); 
        lTPAISES.ID_SISCOMEX := lBody[I].GetValue<String>('idSiscomex',''); 
        lTPAISES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTPAISES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTPAISES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTPAISES.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('PAISES alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'PAISES alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar PAISES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTPAISES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTPAISES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPAISES :TPAISES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTPAISES := TPAISES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTPAISES.Excluir(lQuery,lID); 
 
      Res.Send('PAISES excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'PAISES excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o PAISES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTPAISES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTPAISES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
