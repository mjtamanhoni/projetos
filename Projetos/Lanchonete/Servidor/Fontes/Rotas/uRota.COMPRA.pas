unit uRota.COMPRA; 
 
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
 
  uModel.COMPRA, 
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
  {$Region 'COMPRA'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/compra',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/compra',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/compra',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/compra',Delete);
  {$EndRegion 'COMPRA'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA :TCOMPRA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCOMPRA := TCOMPRA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTCOMPRA.Listar(lQuery,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('COMPRA não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'COMPRA não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de COMPRA');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar COMPRA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCOMPRA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCOMPRA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA :TCOMPRA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCOMPRA := TCOMPRA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCOMPRA.Inicia_Propriedades;

        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_COMPRA_ID,1) AS SEQ FROM RDB$DATABASE;');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTCOMPRA.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTCOMPRA.ID := lBody[I].GetValue<Integer>('id',0);
        lTCOMPRA.DT_COMPRA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCompra',DateToStr(Date)),lErro);
        lTCOMPRA.HR_COMPRA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCompra',DateToStr(Date)),lErro); 
        lTCOMPRA.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0); 
        lTCOMPRA.ID_FORMA_PAGAMENTO := lBody[I].GetValue<Integer>('idFormaPagamento',0); 
        lTCOMPRA.ID_COND_PAGAMENTO := lBody[I].GetValue<Integer>('idCondPagamento',0); 
        lTCOMPRA.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTCOMPRA.QTD_ITENS := lBody[I].GetValue<Integer>('qtdItens',0); 
        lTCOMPRA.SUB_TOTAL := lBody[I].GetValue<Double>('subTotal',0); 
        lTCOMPRA.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTCOMPRA.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTCOMPRA.TOTAL := lBody[I].GetValue<Double>('total',0); 
        lTCOMPRA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTCOMPRA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('COMPRA cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'COMPRA cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar COMPRA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCOMPRA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCOMPRA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA :TCOMPRA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCOMPRA := TCOMPRA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCOMPRA.Inicia_Propriedades; 
 
        lTCOMPRA.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCOMPRA.DT_COMPRA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCompra',DateToStr(Date)),lErro); 
        lTCOMPRA.HR_COMPRA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCompra',DateToStr(Date)),lErro); 
        lTCOMPRA.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0); 
        lTCOMPRA.ID_FORMA_PAGAMENTO := lBody[I].GetValue<Integer>('idFormaPagamento',0); 
        lTCOMPRA.ID_COND_PAGAMENTO := lBody[I].GetValue<Integer>('idCondPagamento',0); 
        lTCOMPRA.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTCOMPRA.QTD_ITENS := lBody[I].GetValue<Integer>('qtdItens',0); 
        lTCOMPRA.SUB_TOTAL := lBody[I].GetValue<Double>('subTotal',0); 
        lTCOMPRA.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTCOMPRA.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTCOMPRA.TOTAL := lBody[I].GetValue<Double>('total',0); 
        lTCOMPRA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTCOMPRA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCOMPRA.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('COMPRA alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'COMPRA alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar COMPRA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCOMPRA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCOMPRA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCOMPRA :TCOMPRA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCOMPRA := TCOMPRA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTCOMPRA.Excluir(lQuery,lID); 
 
      Res.Send('COMPRA excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'COMPRA excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o COMPRA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCOMPRA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCOMPRA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
