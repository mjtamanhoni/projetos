unit uRota.CAIXA; 
 
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
 
  uModel.CAIXA, 
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
  {$Region 'CAIXA'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/caixa',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/caixa',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/caixa',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/caixa',Delete);
  {$EndRegion 'CAIXA'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCAIXA :TCAIXA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCAIXA := TCAIXA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTCAIXA.Listar(lQuery,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('CAIXA não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'CAIXA não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'CAIXA não localizado');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar CAIXA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCAIXA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCAIXA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCAIXA :TCAIXA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCAIXA := TCAIXA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCAIXA.Inicia_Propriedades; 
        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_CAIXA_ID,1) AS SEQ FROM RDB$DATABASE;');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTCAIXA.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTCAIXA.ID := lBody[I].GetValue<Integer>('id',0);
        lTCAIXA.DT_CAIXA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCaixa',DateToStr(Date)),lErro); 
        lTCAIXA.HR_CAIXA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCaixa',DateToStr(Date)),lErro); 
        lTCAIXA.TIPO := lBody[I].GetValue<Integer>('tipo',0); 
        lTCAIXA.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0); 
        lTCAIXA.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTCAIXA.ID_FORMA_PAGAMENTO := lBody[I].GetValue<Integer>('idFormaPagamento',0); 
        lTCAIXA.ID_COND_PAGAMENTO := lBody[I].GetValue<Integer>('idCondPagamento',0); 
        lTCAIXA.VLR_CAIXA := lBody[I].GetValue<Double>('vlrCaixa',0); 
        lTCAIXA.ID_USUARIO_CAD := lBody[I].GetValue<Integer>('idUsuarioCad',0);
        lTCAIXA.DT_CADASTRO := TFuncoes.Converte_Data(lBody[I].GetValue<String>('dtCadastro',FormatDateTime('YYYY-MM-DD',Date)));
        lTCAIXA.HR_CADASTRO := TFuncoes.Converte_Hora(lBody[I].GetValue<String>('hrCadastro',FormatDateTime('HH:NN:SS'+'.000',Time)));
        lTCAIXA.ID_USUARIO_ALT := lBody[I].GetValue<Integer>('idUsuarioAlt',0);
        lTCAIXA.DT_ALTERADO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtAlterado',DateToStr(Date)),lErro); 
        lTCAIXA.HR_ALTERADO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrAlterado',DateToStr(Date)),lErro); 
        lTCAIXA.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('CAIXA cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'CAIXA cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar CAIXA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCAIXA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCAIXA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCAIXA :TCAIXA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCAIXA := TCAIXA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCAIXA.Inicia_Propriedades; 
 
        lTCAIXA.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCAIXA.DT_CAIXA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCaixa',DateToStr(Date)),lErro); 
        lTCAIXA.HR_CAIXA := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCaixa',DateToStr(Date)),lErro); 
        lTCAIXA.TIPO := lBody[I].GetValue<Integer>('tipo',0); 
        lTCAIXA.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0); 
        lTCAIXA.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTCAIXA.ID_FORMA_PAGAMENTO := lBody[I].GetValue<Integer>('idFormaPagamento',0); 
        lTCAIXA.ID_COND_PAGAMENTO := lBody[I].GetValue<Integer>('idCondPagamento',0); 
        lTCAIXA.VLR_CAIXA := lBody[I].GetValue<Double>('vlrCaixa',0); 
        lTCAIXA.ID_USUARIO_CAD := lBody[I].GetValue<Integer>('idUsuarioCad',0); 
        lTCAIXA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCAIXA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCAIXA.ID_USUARIO_ALT := lBody[I].GetValue<Integer>('idUsuarioAlt',0); 
        lTCAIXA.DT_ALTERADO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtAlterado',DateToStr(Date)),lErro); 
        lTCAIXA.HR_ALTERADO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrAlterado',DateToStr(Date)),lErro); 
        lTCAIXA.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('CAIXA alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'CAIXA alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar CAIXA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCAIXA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCAIXA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCAIXA :TCAIXA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCAIXA := TCAIXA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTCAIXA.Excluir(lQuery,lID); 
 
      Res.Send('CAIXA excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'CAIXA excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o CAIXA: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCAIXA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCAIXA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
