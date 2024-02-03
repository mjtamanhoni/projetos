unit uRota.CLIENTE_TABELA; 
 
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
 
  uModel.CLIENTE_TABELA, 
  uFuncoes, 
  uDm.Servidor,
 
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
  {$Region 'CLIENTE_TABELA'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/clienteTabela',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/clienteTabela',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/clienteTabela',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/clienteTabela',Delete);
  {$EndRegion 'CLIENTE_TABELA'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM_Servidor;
  lTCLIENTE_TABELA :TCLIENTE_TABELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_CLIENTE :Integer;
  lID_TABELA :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
 
      lTCLIENTE_TABELA := TCLIENTE_TABELA.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID_CLIENTE := 0; 
      lID_CLIENTE := StrToIntDef(Req.Query['idCliente'],0); 
      lID_TABELA := 0; 
      lID_TABELA := StrToIntDef(Req.Query['idTabela'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTCLIENTE_TABELA.Listar(lQuery,lID_CLIENTE,lID_TABELA,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('CLIENTE_TABELA não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_TABELA não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de CLIENTE_TABELA'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar CLIENTE_TABELA: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTCLIENTE_TABELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTCLIENTE_TABELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM_Servidor;
  lTCLIENTE_TABELA :TCLIENTE_TABELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTCLIENTE_TABELA := TCLIENTE_TABELA.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCLIENTE_TABELA.Inicia_Propriedades; 
 
        lTCLIENTE_TABELA.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTCLIENTE_TABELA.ID_TABELA := lBody[I].GetValue<Integer>('idTabela',0); 
        lTCLIENTE_TABELA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_TABELA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_TABELA.Inserir(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('CLIENTE_TABELA cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_TABELA cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar CLIENTE_TABELA: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCLIENTE_TABELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCLIENTE_TABELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM_Servidor;
  lTCLIENTE_TABELA :TCLIENTE_TABELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTCLIENTE_TABELA := TCLIENTE_TABELA.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTCLIENTE_TABELA.Inicia_Propriedades; 
 
        lTCLIENTE_TABELA.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTCLIENTE_TABELA.ID_TABELA := lBody[I].GetValue<Integer>('idTabela',0); 
        lTCLIENTE_TABELA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_TABELA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTCLIENTE_TABELA.Atualizar(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('CLIENTE_TABELA alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_TABELA alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar CLIENTE_TABELA: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTCLIENTE_TABELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTCLIENTE_TABELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM_Servidor;
  lTCLIENTE_TABELA :TCLIENTE_TABELA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_CLIENTE :Integer;
  lID_TABELA :Integer;
 
begin 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
 
      lTCLIENTE_TABELA := TCLIENTE_TABELA.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID_CLIENTE := StrToIntDef(Req.Query['idCliente'],0); 
      lID_TABELA := StrToIntDef(Req.Query['idTabela'],0); 
 
      lTCLIENTE_TABELA.Excluir(lQuery,lID_CLIENTE,lID_TABELA); 
 
      Res.Send('CLIENTE_TABELA excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - CLIENTE_TABELA excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o CLIENTE_TABELA: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTCLIENTE_TABELA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTCLIENTE_TABELA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
