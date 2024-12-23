unit uRota.UNIDADE_FEDERATIVA;
 
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
 
  uModel.UNIDADE_FEDERATIVA, 
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
  {$Region 'UNIDADE_FEDERATIVA'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/unidadeFederativa',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/unidadeFederativa',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/unidadeFederativa',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/unidadeFederativa',Delete);
  {$EndRegion 'UNIDADE_FEDERATIVA'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTUNIDADE_FEDERATIVA :TUNIDADE_FEDERATIVA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lSigla :String;
  lPagina :Integer;
  lID_Regiao :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTUNIDADE_FEDERATIVA := TUNIDADE_FEDERATIVA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0);
      lSigla := Req.Query['sigla'];
      lPagina := StrToIntDef(Req.Query['pagina'],0);
      lID_Regiao := StrToIntDef(Req.Query['idRegiao'],0);

      lJson_Ret := lTUNIDADE_FEDERATIVA.Listar(lQuery,lID,lSigla,lID_Regiao,lPagina);
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('UNIDADE_FEDERATIVA não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'UNIDADE_FEDERATIVA não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'UNIDADE_FEDERATIVA não localizado');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar UNIDADE_FEDERATIVA: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTUNIDADE_FEDERATIVA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTUNIDADE_FEDERATIVA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTUNIDADE_FEDERATIVA :TUNIDADE_FEDERATIVA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTUNIDADE_FEDERATIVA := TUNIDADE_FEDERATIVA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTUNIDADE_FEDERATIVA.Inicia_Propriedades; 

        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_UNIDADE_FEDERATIVA_ID,1) AS SEQ FROM RDB$DATABASE');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTUNIDADE_FEDERATIVA.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTUNIDADE_FEDERATIVA.ID := lBody[I].GetValue<Integer>('id',0);
        lTUNIDADE_FEDERATIVA.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTUNIDADE_FEDERATIVA.NOME := lBody[I].GetValue<String>('nome',''); 
        lTUNIDADE_FEDERATIVA.SIGLA := lBody[I].GetValue<String>('sigla',''); 
        lTUNIDADE_FEDERATIVA.ID_REGIAO := lBody[I].GetValue<Integer>('idRegiao',0); 
        lTUNIDADE_FEDERATIVA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTUNIDADE_FEDERATIVA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTUNIDADE_FEDERATIVA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTUNIDADE_FEDERATIVA.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('UNIDADE_FEDERATIVA cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'UNIDADE_FEDERATIVA cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar UNIDADE_FEDERATIVA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTUNIDADE_FEDERATIVA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTUNIDADE_FEDERATIVA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTUNIDADE_FEDERATIVA :TUNIDADE_FEDERATIVA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTUNIDADE_FEDERATIVA := TUNIDADE_FEDERATIVA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTUNIDADE_FEDERATIVA.Inicia_Propriedades; 
 
        lTUNIDADE_FEDERATIVA.ID := lBody[I].GetValue<Integer>('id',0); 
        lTUNIDADE_FEDERATIVA.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTUNIDADE_FEDERATIVA.NOME := lBody[I].GetValue<String>('nome',''); 
        lTUNIDADE_FEDERATIVA.SIGLA := lBody[I].GetValue<String>('sigla',''); 
        lTUNIDADE_FEDERATIVA.ID_REGIAO := lBody[I].GetValue<Integer>('idRegiao',0); 
        lTUNIDADE_FEDERATIVA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTUNIDADE_FEDERATIVA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTUNIDADE_FEDERATIVA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTUNIDADE_FEDERATIVA.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('UNIDADE_FEDERATIVA alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'UNIDADE_FEDERATIVA alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar UNIDADE_FEDERATIVA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTUNIDADE_FEDERATIVA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTUNIDADE_FEDERATIVA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTUNIDADE_FEDERATIVA :TUNIDADE_FEDERATIVA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTUNIDADE_FEDERATIVA := TUNIDADE_FEDERATIVA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTUNIDADE_FEDERATIVA.Excluir(lQuery,lID); 
 
      Res.Send('UNIDADE_FEDERATIVA excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'UNIDADE_FEDERATIVA excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o UNIDADE_FEDERATIVA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTUNIDADE_FEDERATIVA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTUNIDADE_FEDERATIVA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
