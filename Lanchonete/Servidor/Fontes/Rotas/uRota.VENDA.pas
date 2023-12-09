unit uRota.VENDA;
 
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
 
  uModel.VENDA, 
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
  {$Region 'VENDA'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/venda',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/venda',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/venda',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/venda',Delete);
  {$EndRegion 'VENDA'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA :TVENDA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTVENDA := TVENDA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTVENDA.Listar(lQuery,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('VENDA não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'VENDA não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de VENDA');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar VENDA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTVENDA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTVENDA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA :TVENDA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTVENDA := TVENDA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTVENDA.Inicia_Propriedades;

        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_VENDA_ID,1) AS SEQ FROM RDB$DATABASE;');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTVENDA.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTVENDA.ID := lBody[I].GetValue<Integer>('id',0);
        lTVENDA.DT_VENDA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtVenda',DateToStr(Date)),lErro);
        lTVENDA.HR_VENDA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrVenda',DateToStr(Date)),lErro); 
        lTVENDA.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTVENDA.ID_FORMA_PAGAMENTO := lBody[I].GetValue<Integer>('idFormaPagamento',0); 
        lTVENDA.ID_COND_PAGAMENTO := lBody[I].GetValue<Integer>('idCondPagamento',0); 
        lTVENDA.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTVENDA.QTD_ITENS := lBody[I].GetValue<Integer>('qtdItens',0); 
        lTVENDA.SUB_TOTAL := lBody[I].GetValue<Double>('subTotal',0); 
        lTVENDA.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTVENDA.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTVENDA.TOTAL := lBody[I].GetValue<Double>('total',0); 
        lTVENDA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTVENDA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTVENDA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTVENDA.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('VENDA cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'VENDA cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar VENDA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTVENDA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTVENDA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA :TVENDA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTVENDA := TVENDA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTVENDA.Inicia_Propriedades; 
 
        lTVENDA.ID := lBody[I].GetValue<Integer>('id',0); 
        lTVENDA.DT_VENDA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtVenda',DateToStr(Date)),lErro); 
        lTVENDA.HR_VENDA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrVenda',DateToStr(Date)),lErro); 
        lTVENDA.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTVENDA.ID_FORMA_PAGAMENTO := lBody[I].GetValue<Integer>('idFormaPagamento',0); 
        lTVENDA.ID_COND_PAGAMENTO := lBody[I].GetValue<Integer>('idCondPagamento',0); 
        lTVENDA.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTVENDA.QTD_ITENS := lBody[I].GetValue<Integer>('qtdItens',0); 
        lTVENDA.SUB_TOTAL := lBody[I].GetValue<Double>('subTotal',0); 
        lTVENDA.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTVENDA.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTVENDA.TOTAL := lBody[I].GetValue<Double>('total',0); 
        lTVENDA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTVENDA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTVENDA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTVENDA.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('VENDA alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'VENDA alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar VENDA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTVENDA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTVENDA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTVENDA :TVENDA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTVENDA := TVENDA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTVENDA.Excluir(lQuery,lID); 
 
      Res.Send('VENDA excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'VENDA excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o VENDA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTVENDA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTVENDA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
