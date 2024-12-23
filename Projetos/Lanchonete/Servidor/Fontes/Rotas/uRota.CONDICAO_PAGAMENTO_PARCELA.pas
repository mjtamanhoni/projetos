unit uRota.CONDICAO_PAGAMENTO_PARCELA;
 
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
 
  uModel.CONDICAO_PAGAMENTO_PARCELA, 
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
  {$Region 'CONDICAO_PAGAMENTO_PARCELA'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/condicaoPagamentoParcela',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/condicaoPagamentoParcela',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/condicaoPagamentoParcela',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/condicaoPagamentoParcela',Delete);
  {$EndRegion 'CONDICAO_PAGAMENTO_PARCELA'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCONDICAO_PAGAMENTO_PARCELA :TCONDICAO_PAGAMENTO_PARCELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_CONDICAO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCONDICAO_PAGAMENTO_PARCELA := TCONDICAO_PAGAMENTO_PARCELA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_CONDICAO := StrToIntDef(Req.Query['idCondicao'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTCONDICAO_PAGAMENTO_PARCELA.Listar(lQuery,lID_CONDICAO,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('CONDICAO_PAGAMENTO_PARCELA não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'CONDICAO_PAGAMENTO_PARCELA não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de CONDICAO_PAGAMENTO_PARCELA');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar CONDICAO_PAGAMENTO_PARCELA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCONDICAO_PAGAMENTO_PARCELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCONDICAO_PAGAMENTO_PARCELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCONDICAO_PAGAMENTO_PARCELA :TCONDICAO_PAGAMENTO_PARCELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCONDICAO_PAGAMENTO_PARCELA := TCONDICAO_PAGAMENTO_PARCELA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCONDICAO_PAGAMENTO_PARCELA.Inicia_Propriedades; 
 
        lTCONDICAO_PAGAMENTO_PARCELA.ID_CONDICAO := lBody[I].GetValue<Integer>('idCondicao',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.PARCELA := lBody[I].GetValue<Integer>('parcela',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.DIAS := lBody[I].GetValue<Integer>('dias',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('CONDICAO_PAGAMENTO_PARCELA cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'CONDICAO_PAGAMENTO_PARCELA cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar CONDICAO_PAGAMENTO_PARCELA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCONDICAO_PAGAMENTO_PARCELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCONDICAO_PAGAMENTO_PARCELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCONDICAO_PAGAMENTO_PARCELA :TCONDICAO_PAGAMENTO_PARCELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTCONDICAO_PAGAMENTO_PARCELA := TCONDICAO_PAGAMENTO_PARCELA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCONDICAO_PAGAMENTO_PARCELA.Inicia_Propriedades; 
 
        lTCONDICAO_PAGAMENTO_PARCELA.ID_CONDICAO := lBody[I].GetValue<Integer>('idCondicao',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.PARCELA := lBody[I].GetValue<Integer>('parcela',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.DIAS := lBody[I].GetValue<Integer>('dias',0); 
        lTCONDICAO_PAGAMENTO_PARCELA.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('CONDICAO_PAGAMENTO_PARCELA alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'CONDICAO_PAGAMENTO_PARCELA alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar CONDICAO_PAGAMENTO_PARCELA: ' + E.Message);
      end; 
    end; 
  finally
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCONDICAO_PAGAMENTO_PARCELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCONDICAO_PAGAMENTO_PARCELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCONDICAO_PAGAMENTO_PARCELA :TCONDICAO_PAGAMENTO_PARCELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_CONDICAO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCONDICAO_PAGAMENTO_PARCELA := TCONDICAO_PAGAMENTO_PARCELA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_CONDICAO := StrToIntDef(Req.Query['idCondicao'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTCONDICAO_PAGAMENTO_PARCELA.Excluir(lQuery,lID_CONDICAO,lID); 
 
      Res.Send('CONDICAO_PAGAMENTO_PARCELA excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'CONDICAO_PAGAMENTO_PARCELA excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o CONDICAO_PAGAMENTO_PARCELA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCONDICAO_PAGAMENTO_PARCELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCONDICAO_PAGAMENTO_PARCELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
