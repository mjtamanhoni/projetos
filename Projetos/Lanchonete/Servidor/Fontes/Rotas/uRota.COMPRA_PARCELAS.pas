unit uRota.COMPRA_PARCELAS; 
 
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
 
  uModel.COMPRA_PARCELAS, 
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
  {$Region 'COMPRA_PARCELAS'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/compraParcelas',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/compraParcelas',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/compraParcelas',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/compraParcelas',Delete);
  {$EndRegion 'COMPRA_PARCELAS'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA_PARCELAS :TCOMPRA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_COMPRA :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCOMPRA_PARCELAS := TCOMPRA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_COMPRA := StrToIntDef(Req.Query['idCompra'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTCOMPRA_PARCELAS.Listar(lQuery,lID_COMPRA,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('COMPRA_PARCELAS não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'COMPRA_PARCELAS não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de COMPRA_PARCELAS');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar COMPRA_PARCELAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCOMPRA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCOMPRA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA_PARCELAS :TCOMPRA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCOMPRA_PARCELAS := TCOMPRA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCOMPRA_PARCELAS.Inicia_Propriedades; 
 
        lTCOMPRA_PARCELAS.ID_COMPRA := lBody[I].GetValue<Integer>('idCompra',0); 
        lTCOMPRA_PARCELAS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCOMPRA_PARCELAS.PARCELA := lBody[I].GetValue<Integer>('parcela',0); 
        lTCOMPRA_PARCELAS.DT_VENCIMENTO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtVencimento',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.VLR_PARCELA := lBody[I].GetValue<Double>('vlrParcela',0); 
        lTCOMPRA_PARCELAS.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTCOMPRA_PARCELAS.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTCOMPRA_PARCELAS.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTCOMPRA_PARCELAS.DT_PAGO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtPago',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.HR_PAGO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrPago',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.VLR_PAGO := lBody[I].GetValue<Double>('vlrPago',0); 
        lTCOMPRA_PARCELAS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTCOMPRA_PARCELAS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('COMPRA_PARCELAS cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'COMPRA_PARCELAS cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar COMPRA_PARCELAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCOMPRA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCOMPRA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA_PARCELAS :TCOMPRA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCOMPRA_PARCELAS := TCOMPRA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCOMPRA_PARCELAS.Inicia_Propriedades; 
 
        lTCOMPRA_PARCELAS.ID_COMPRA := lBody[I].GetValue<Integer>('idCompra',0); 
        lTCOMPRA_PARCELAS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCOMPRA_PARCELAS.PARCELA := lBody[I].GetValue<Integer>('parcela',0); 
        lTCOMPRA_PARCELAS.DT_VENCIMENTO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtVencimento',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.VLR_PARCELA := lBody[I].GetValue<Double>('vlrParcela',0); 
        lTCOMPRA_PARCELAS.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTCOMPRA_PARCELAS.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTCOMPRA_PARCELAS.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTCOMPRA_PARCELAS.DT_PAGO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtPago',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.HR_PAGO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrPago',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.VLR_PAGO := lBody[I].GetValue<Double>('vlrPago',0); 
        lTCOMPRA_PARCELAS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTCOMPRA_PARCELAS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA_PARCELAS.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('COMPRA_PARCELAS alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'COMPRA_PARCELAS alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar COMPRA_PARCELAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCOMPRA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCOMPRA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA_PARCELAS :TCOMPRA_PARCELAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_COMPRA :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCOMPRA_PARCELAS := TCOMPRA_PARCELAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_COMPRA := StrToIntDef(Req.Query['idCompra'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTCOMPRA_PARCELAS.Excluir(lQuery,lID_COMPRA,lID); 
 
      Res.Send('COMPRA_PARCELAS excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'COMPRA_PARCELAS excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o COMPRA_PARCELAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCOMPRA_PARCELAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCOMPRA_PARCELAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
