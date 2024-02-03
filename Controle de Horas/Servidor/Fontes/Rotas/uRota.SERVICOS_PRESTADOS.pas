unit uRota.SERVICOS_PRESTADOS; 
 
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
 
  uModel.SERVICOS_PRESTADOS, 
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
  {$Region 'SERVICOS_PRESTADOS'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/servicosPrestados',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/servicosPrestados',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/servicosPrestados',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/servicosPrestados',Delete);
  {$EndRegion 'SERVICOS_PRESTADOS'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM_Servidor;
  lTSERVICOS_PRESTADOS :TSERVICOS_PRESTADOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
 
      lTSERVICOS_PRESTADOS := TSERVICOS_PRESTADOS.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := 0; 
      lID := StrToIntDef(Req.Query['id'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTSERVICOS_PRESTADOS.Listar(lQuery,lID,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('SERVICOS_PRESTADOS não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - SERVICOS_PRESTADOS não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de SERVICOS_PRESTADOS'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar SERVICOS_PRESTADOS: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTSERVICOS_PRESTADOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTSERVICOS_PRESTADOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM_Servidor;
  lTSERVICOS_PRESTADOS :TSERVICOS_PRESTADOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTSERVICOS_PRESTADOS := TSERVICOS_PRESTADOS.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTSERVICOS_PRESTADOS.Inicia_Propriedades; 
 
        lTSERVICOS_PRESTADOS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTSERVICOS_PRESTADOS.DESCRICAO := lBody[I].GetValue<String>('descricao',''); 
        lTSERVICOS_PRESTADOS.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTSERVICOS_PRESTADOS.ID_PRESTADOR_SERVICO := lBody[I].GetValue<Integer>('idPrestadorServico',0); 
        lTSERVICOS_PRESTADOS.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTSERVICOS_PRESTADOS.ID_TABELA := lBody[I].GetValue<Integer>('idTabela',0); 
        lTSERVICOS_PRESTADOS.DATA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('data',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_INICIO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrInicio',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_FIM := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrFim',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_TOTAL := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrTotal',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.VLR_HORA := lBody[I].GetValue<Double>('vlrHora',0); 
        lTSERVICOS_PRESTADOS.SUB_TOTAL := lBody[I].GetValue<Double>('subTotal',0); 
        lTSERVICOS_PRESTADOS.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTSERVICOS_PRESTADOS.DESCONTO_MOTIVO := lBody[I].GetValue<String>('descontoMotivo',''); 
        lTSERVICOS_PRESTADOS.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTSERVICOS_PRESTADOS.ACRESCIMO_MOTIVO := lBody[I].GetValue<String>('acrescimoMotivo',''); 
        lTSERVICOS_PRESTADOS.TOTAL := lBody[I].GetValue<Double>('total',0); 
        lTSERVICOS_PRESTADOS.DT_PAGO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtPago',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.VLR_PAGO := lBody[I].GetValue<Double>('vlrPago',0); 
        lTSERVICOS_PRESTADOS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTSERVICOS_PRESTADOS.Inserir(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('SERVICOS_PRESTADOS cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - SERVICOS_PRESTADOS cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar SERVICOS_PRESTADOS: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTSERVICOS_PRESTADOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTSERVICOS_PRESTADOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM_Servidor;
  lTSERVICOS_PRESTADOS :TSERVICOS_PRESTADOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTSERVICOS_PRESTADOS := TSERVICOS_PRESTADOS.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTSERVICOS_PRESTADOS.Inicia_Propriedades; 
 
        lTSERVICOS_PRESTADOS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTSERVICOS_PRESTADOS.DESCRICAO := lBody[I].GetValue<String>('descricao',''); 
        lTSERVICOS_PRESTADOS.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTSERVICOS_PRESTADOS.ID_PRESTADOR_SERVICO := lBody[I].GetValue<Integer>('idPrestadorServico',0); 
        lTSERVICOS_PRESTADOS.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0); 
        lTSERVICOS_PRESTADOS.ID_TABELA := lBody[I].GetValue<Integer>('idTabela',0); 
        lTSERVICOS_PRESTADOS.DATA := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('data',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_INICIO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrInicio',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_FIM := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrFim',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_TOTAL := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrTotal',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.VLR_HORA := lBody[I].GetValue<Double>('vlrHora',0); 
        lTSERVICOS_PRESTADOS.SUB_TOTAL := lBody[I].GetValue<Double>('subTotal',0); 
        lTSERVICOS_PRESTADOS.DESCONTO := lBody[I].GetValue<Double>('desconto',0); 
        lTSERVICOS_PRESTADOS.DESCONTO_MOTIVO := lBody[I].GetValue<String>('descontoMotivo',''); 
        lTSERVICOS_PRESTADOS.ACRESCIMO := lBody[I].GetValue<Double>('acrescimo',0); 
        lTSERVICOS_PRESTADOS.ACRESCIMO_MOTIVO := lBody[I].GetValue<String>('acrescimoMotivo',''); 
        lTSERVICOS_PRESTADOS.TOTAL := lBody[I].GetValue<Double>('total',0); 
        lTSERVICOS_PRESTADOS.DT_PAGO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtPago',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.VLR_PAGO := lBody[I].GetValue<Double>('vlrPago',0); 
        lTSERVICOS_PRESTADOS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTSERVICOS_PRESTADOS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTSERVICOS_PRESTADOS.Atualizar(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('SERVICOS_PRESTADOS alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - SERVICOS_PRESTADOS alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar SERVICOS_PRESTADOS: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTSERVICOS_PRESTADOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTSERVICOS_PRESTADOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM_Servidor;
  lTSERVICOS_PRESTADOS :TSERVICOS_PRESTADOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      FDm := TDM_Servidor.Create(Nil);
 
      lTSERVICOS_PRESTADOS := TSERVICOS_PRESTADOS.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTSERVICOS_PRESTADOS.Excluir(lQuery,lID); 
 
      Res.Send('SERVICOS_PRESTADOS excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - SERVICOS_PRESTADOS excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o SERVICOS_PRESTADOS: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTSERVICOS_PRESTADOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTSERVICOS_PRESTADOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
