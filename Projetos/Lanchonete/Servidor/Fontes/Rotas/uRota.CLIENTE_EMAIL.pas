unit uRota.CLIENTE_EMAIL; 
 
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
 
  uModel.CLIENTE_EMAIL, 
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
  {$Region 'CLIENTE_EMAIL'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/clienteEmail',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/clienteEmail',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/clienteEmail',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/clienteEmail',Delete);
  {$EndRegion 'CLIENTE_EMAIL'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCLIENTE_EMAIL :TCLIENTE_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_CLIENTE :Integer;
  lID :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCLIENTE_EMAIL := TCLIENTE_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_CLIENTE := 0; 
      lID_CLIENTE := StrToIntDef(Req.Query['idCliente'],0); 
      lID := 0; 
      lID := StrToIntDef(Req.Query['id'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTCLIENTE_EMAIL.Listar(lQuery,lID_CLIENTE,lID,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('CLIENTE_EMAIL não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_EMAIL não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de CLIENTE_EMAIL'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar CLIENTE_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCLIENTE_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCLIENTE_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCLIENTE_EMAIL :TCLIENTE_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then 
        DM_Lanchonete.FDC_Lanchonete.StartTransaction; 
 
      lTCLIENTE_EMAIL := TCLIENTE_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCLIENTE_EMAIL.Inicia_Propriedades; 
 
        lTCLIENTE_EMAIL.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTCLIENTE_EMAIL.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCLIENTE_EMAIL.RESPONSAVEL := lBody[I].GetValue<String>('responsavel',''); 
        lTCLIENTE_EMAIL.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTCLIENTE_EMAIL.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTCLIENTE_EMAIL.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTCLIENTE_EMAIL.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_EMAIL.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_EMAIL.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('CLIENTE_EMAIL cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_EMAIL cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        DM_Lanchonete.FDC_Lanchonete.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar CLIENTE_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCLIENTE_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCLIENTE_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCLIENTE_EMAIL :TCLIENTE_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then 
        DM_Lanchonete.FDC_Lanchonete.StartTransaction; 
 
      lTCLIENTE_EMAIL := TCLIENTE_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCLIENTE_EMAIL.Inicia_Propriedades; 
 
        lTCLIENTE_EMAIL.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTCLIENTE_EMAIL.ID := lBody[I].GetValue<Integer>('id',0); 
        lTCLIENTE_EMAIL.RESPONSAVEL := lBody[I].GetValue<String>('responsavel',''); 
        lTCLIENTE_EMAIL.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTCLIENTE_EMAIL.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTCLIENTE_EMAIL.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTCLIENTE_EMAIL.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_EMAIL.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_EMAIL.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('CLIENTE_EMAIL alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_EMAIL alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        DM_Lanchonete.FDC_Lanchonete.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar CLIENTE_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCLIENTE_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCLIENTE_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTCLIENTE_EMAIL :TCLIENTE_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_CLIENTE :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTCLIENTE_EMAIL := TCLIENTE_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_CLIENTE := StrToIntDef(Req.Query['idCliente'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTCLIENTE_EMAIL.Excluir(lQuery,lID_CLIENTE,lID); 
 
      Res.Send('CLIENTE_EMAIL excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_EMAIL excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o CLIENTE_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTCLIENTE_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTCLIENTE_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
