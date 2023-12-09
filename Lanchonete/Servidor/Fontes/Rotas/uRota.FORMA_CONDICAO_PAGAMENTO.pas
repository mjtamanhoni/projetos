unit uRota.FORMA_CONDICAO_PAGAMENTO; 
 
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
 
  uModel.FORMA_CONDICAO_PAGAMENTO, 
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
  {$Region 'FORMA_CONDICAO_PAGAMENTO'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/formaCondicaoPagamento',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/formaCondicaoPagamento',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/formaCondicaoPagamento',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/formaCondicaoPagamento',Delete);
  {$EndRegion 'FORMA_CONDICAO_PAGAMENTO'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORMA_CONDICAO_PAGAMENTO :TFORMA_CONDICAO_PAGAMENTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_FORMA :Integer;
  lID_CONDICAO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFORMA_CONDICAO_PAGAMENTO := TFORMA_CONDICAO_PAGAMENTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FORMA := StrToIntDef(Req.Query['idForma'],0); 
      lID_CONDICAO := StrToIntDef(Req.Query['idCondicao'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTFORMA_CONDICAO_PAGAMENTO.Listar(lQuery,lID_FORMA,lID_CONDICAO,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('FORMA_CONDICAO_PAGAMENTO não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'FORMA_CONDICAO_PAGAMENTO não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de FORMA_CONDICAO_PAGAMENTO');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar FORMA_CONDICAO_PAGAMENTO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFORMA_CONDICAO_PAGAMENTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFORMA_CONDICAO_PAGAMENTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORMA_CONDICAO_PAGAMENTO :TFORMA_CONDICAO_PAGAMENTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTFORMA_CONDICAO_PAGAMENTO := TFORMA_CONDICAO_PAGAMENTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFORMA_CONDICAO_PAGAMENTO.Inicia_Propriedades; 
 
        lTFORMA_CONDICAO_PAGAMENTO.ID_FORMA := lBody[I].GetValue<Integer>('idForma',0); 
        lTFORMA_CONDICAO_PAGAMENTO.ID_CONDICAO := lBody[I].GetValue<Integer>('idCondicao',0); 
        lTFORMA_CONDICAO_PAGAMENTO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFORMA_CONDICAO_PAGAMENTO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFORMA_CONDICAO_PAGAMENTO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFORMA_CONDICAO_PAGAMENTO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTFORMA_CONDICAO_PAGAMENTO.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FORMA_CONDICAO_PAGAMENTO cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FORMA_CONDICAO_PAGAMENTO cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar FORMA_CONDICAO_PAGAMENTO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFORMA_CONDICAO_PAGAMENTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFORMA_CONDICAO_PAGAMENTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORMA_CONDICAO_PAGAMENTO :TFORMA_CONDICAO_PAGAMENTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTFORMA_CONDICAO_PAGAMENTO := TFORMA_CONDICAO_PAGAMENTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFORMA_CONDICAO_PAGAMENTO.Inicia_Propriedades; 
 
        lTFORMA_CONDICAO_PAGAMENTO.ID_FORMA := lBody[I].GetValue<Integer>('idForma',0); 
        lTFORMA_CONDICAO_PAGAMENTO.ID_CONDICAO := lBody[I].GetValue<Integer>('idCondicao',0); 
        lTFORMA_CONDICAO_PAGAMENTO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFORMA_CONDICAO_PAGAMENTO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFORMA_CONDICAO_PAGAMENTO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFORMA_CONDICAO_PAGAMENTO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTFORMA_CONDICAO_PAGAMENTO.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FORMA_CONDICAO_PAGAMENTO alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FORMA_CONDICAO_PAGAMENTO alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar FORMA_CONDICAO_PAGAMENTO: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFORMA_CONDICAO_PAGAMENTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFORMA_CONDICAO_PAGAMENTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORMA_CONDICAO_PAGAMENTO :TFORMA_CONDICAO_PAGAMENTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_FORMA :Integer;
  lID_CONDICAO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFORMA_CONDICAO_PAGAMENTO := TFORMA_CONDICAO_PAGAMENTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FORMA := StrToIntDef(Req.Query['idForma'],0); 
      lID_CONDICAO := StrToIntDef(Req.Query['idCondicao'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTFORMA_CONDICAO_PAGAMENTO.Excluir(lQuery,lID_FORMA,lID_CONDICAO,lID); 
 
      Res.Send('FORMA_CONDICAO_PAGAMENTO excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FORMA_CONDICAO_PAGAMENTO excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o FORMA_CONDICAO_PAGAMENTO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFORMA_CONDICAO_PAGAMENTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFORMA_CONDICAO_PAGAMENTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
