unit uRota.IMPRESSORA_SETOR;
 
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
 
  uModel.IMPRESSORA_SETOR, 
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
  {$Region 'IMPRESSORA_SETOR'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/impressora/setor',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/impressora/setor',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/impressora/setor',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/impressora/setor',Delete);
  {$EndRegion 'IMPRESSORA_SETOR'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORA_SETOR :TIMPRESSORA_SETOR; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTIMPRESSORA_SETOR := TIMPRESSORA_SETOR.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTIMPRESSORA_SETOR.Listar(lQuery,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('IMPRESSORA_SETOR não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORA_SETOR não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de IMPRESSORA_SETOR');
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar IMPRESSORA_SETOR: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTIMPRESSORA_SETOR); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTIMPRESSORA_SETOR.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORA_SETOR :TIMPRESSORA_SETOR; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTIMPRESSORA_SETOR := TIMPRESSORA_SETOR.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTIMPRESSORA_SETOR.Inicia_Propriedades; 
        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_IMPRESSORA_SETOR_ID,1) AS SEQ FROM RDB$DATABASE');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTIMPRESSORA_SETOR.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTIMPRESSORA_SETOR.ID := lBody[I].GetValue<Integer>('id',0);
        lTIMPRESSORA_SETOR.ID_IMPRESSORA := lBody[I].GetValue<Integer>('idImpressora',0); 
        lTIMPRESSORA_SETOR.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTIMPRESSORA_SETOR.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTIMPRESSORA_SETOR.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTIMPRESSORA_SETOR.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTIMPRESSORA_SETOR.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('IMPRESSORA_SETOR cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORA_SETOR cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar IMPRESSORA_SETOR: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTIMPRESSORA_SETOR); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTIMPRESSORA_SETOR.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORA_SETOR :TIMPRESSORA_SETOR; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTIMPRESSORA_SETOR := TIMPRESSORA_SETOR.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTIMPRESSORA_SETOR.Inicia_Propriedades; 
 
        lTIMPRESSORA_SETOR.ID := lBody[I].GetValue<Integer>('id',0); 
        lTIMPRESSORA_SETOR.ID_IMPRESSORA := lBody[I].GetValue<Integer>('idImpressora',0); 
        lTIMPRESSORA_SETOR.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTIMPRESSORA_SETOR.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTIMPRESSORA_SETOR.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTIMPRESSORA_SETOR.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTIMPRESSORA_SETOR.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('IMPRESSORA_SETOR alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORA_SETOR alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar IMPRESSORA_SETOR: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTIMPRESSORA_SETOR); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTIMPRESSORA_SETOR.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORA_SETOR :TIMPRESSORA_SETOR; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTIMPRESSORA_SETOR := TIMPRESSORA_SETOR.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTIMPRESSORA_SETOR.Excluir(lQuery,lID); 
 
      Res.Send('IMPRESSORA_SETOR excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORA_SETOR excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o IMPRESSORA_SETOR: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTIMPRESSORA_SETOR); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTIMPRESSORA_SETOR.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
