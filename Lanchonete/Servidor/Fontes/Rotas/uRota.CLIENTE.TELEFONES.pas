unit uRota.CLIENTE.TELEFONES;

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

  uModel.CLIENTE.TELEFONES,
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
  {$Region 'CLIENTE_TELEFONES'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/cliente/telefones',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/cliente/telefones',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/cliente/telefones',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/cliente/telefones',Delete);
  {$EndRegion 'CLIENTE_TELEFONES'}
end;

procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_TELEFONES :TCLIENTE_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdCliente :Integer;
  lPagina :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCLIENTE_TELEFONES := TCLIENTE_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdCliente := 0;
      lPagina := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdCliente := StrToIntDef(Req.Query['idCliente'],0);
      lPagina := StrToIntDef(Req.Query['pagina'],0);

      lJson_Ret := lTCLIENTE_TELEFONES.Listar(
        lQuery
        ,lIdCliente
        ,lId
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Telefones n�o localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Cliente n�o localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Telefones do Cliente');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao listar Telefones do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCLIENTE_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTCLIENTE_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_TELEFONES :TCLIENTE_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCLIENTE_TELEFONES := TCLIENTE_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('N�o h� registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCLIENTE_TELEFONES.Inicia_Propriedades;

        lTCLIENTE_TELEFONES.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0);
        lTCLIENTE_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0);
        lTCLIENTE_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTCLIENTE_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCLIENTE_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCLIENTE_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_TELEFONES.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefone do Cliente cadastrado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Cliente cadastrado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar Telefone do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCLIENTE_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      lTCLIENTE_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_TELEFONES :TCLIENTE_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTCLIENTE_TELEFONES := TCLIENTE_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('N�o h� registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTCLIENTE_TELEFONES.Inicia_Propriedades;

        lTCLIENTE_TELEFONES.ID_CLIENTE := lBody[I].GetValue<Integer>('idCliente',0);
        lTCLIENTE_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0);
        lTCLIENTE_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTCLIENTE_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero','');
        lTCLIENTE_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTCLIENTE_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTCLIENTE_TELEFONES.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefone do Cliente alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Cliente alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar o Telefone do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTCLIENTE_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      lTCLIENTE_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTCLIENTE_TELEFONES :TCLIENTE_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;
  lID_CLIENTE :Integer;
  lID :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTCLIENTE_TELEFONES := TCLIENTE_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lID_CLIENTE := StrToIntDef(Req.Query['idCliente'],0);
      lID := StrToIntDef(Req.Query['id'],0);

      lTCLIENTE_TELEFONES.Excluir(lQuery,lID_CLIENTE,lID);

      Res.Send('Telefone do Cliente exclu�do').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Cliente exclu�do');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o Telefone do Cliente: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTCLIENTE_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTCLIENTE_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

end.
