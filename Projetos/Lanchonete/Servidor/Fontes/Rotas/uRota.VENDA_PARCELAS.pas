unit uRota.VENDA_PARCELAS;
 
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
 
  uModel.VENDA_PARCELAS, 
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
  {$Region 'VENDA_PARCELAS'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/vendaParcelas',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/vendaParcelas',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/vendaParcelas',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/vendaParcelas',Delete);
  {$EndRegion 'VENDA_PARCELAS'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA_PARCELAS :TVENDA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_VENDA :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTVENDA_PARCELAS := TVENDA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_VENDA := StrToIntDef(Req.Query['idVenda'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTVENDA_PARCELAS.Listar(lQuery,lID_VENDA,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('VENDA_PARCELAS não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'VENDA_PARCELAS não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de VENDA_PARCELAS');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar VENDA_PARCELAS: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTVENDA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTVENDA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA_PARCELAS :TVENDA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTVENDA_PARCELAS := TVENDA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTVENDA_PARCELAS.Inicia_Propriedades; 
 
        lTVENDA_PARCELAS.ID_VENDA := lBody[I].GetValue<Integer>('idVenda',0); 
        lTVENDA_PARCELAS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTVENDA_PARCELAS.PARCELA := lBody[I].GetValue<Integer>('parcela',0); 
        lTVENDA_PARCELAS.DT_VENCIMENTO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtVencimento',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.VLR_PARCELA := lBody[I].GetValue<Double>('vlrParcela',0); 
        lTVENDA_PARCELAS.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTVENDA_PARCELAS.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTVENDA_PARCELAS.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTVENDA_PARCELAS.DT_PAGO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtPago',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.HR_PAGO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrPago',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.VLR_PAGO := lBody[I].GetValue<Double>('vlrPago',0); 
        lTVENDA_PARCELAS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTVENDA_PARCELAS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('VENDA_PARCELAS cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'VENDA_PARCELAS cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar VENDA_PARCELAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTVENDA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTVENDA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA_PARCELAS :TVENDA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTVENDA_PARCELAS := TVENDA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTVENDA_PARCELAS.Inicia_Propriedades; 
 
        lTVENDA_PARCELAS.ID_VENDA := lBody[I].GetValue<Integer>('idVenda',0); 
        lTVENDA_PARCELAS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTVENDA_PARCELAS.PARCELA := lBody[I].GetValue<Integer>('parcela',0); 
        lTVENDA_PARCELAS.DT_VENCIMENTO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtVencimento',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.VLR_PARCELA := lBody[I].GetValue<Double>('vlrParcela',0); 
        lTVENDA_PARCELAS.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTVENDA_PARCELAS.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTVENDA_PARCELAS.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTVENDA_PARCELAS.DT_PAGO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtPago',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.HR_PAGO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrPago',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.VLR_PAGO := lBody[I].GetValue<Double>('vlrPago',0); 
        lTVENDA_PARCELAS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTVENDA_PARCELAS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTVENDA_PARCELAS.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('VENDA_PARCELAS alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'VENDA_PARCELAS alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar VENDA_PARCELAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTVENDA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTVENDA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA_PARCELAS :TVENDA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_VENDA :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTVENDA_PARCELAS := TVENDA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_VENDA := StrToIntDef(Req.Query['idVenda'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTVENDA_PARCELAS.Excluir(lQuery,lID_VENDA,lID); 
 
      Res.Send('VENDA_PARCELAS excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'VENDA_PARCELAS excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o VENDA_PARCELAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTVENDA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTVENDA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
