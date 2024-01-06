unit uRota.FORNECEDOR.TELEFONES;

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

  uModel.FORNECEDOR.TELEFONES,
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
  {$Region 'FORNECEDOR_TELEFONES'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/fornecedor/telefones',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/fornecedor/telefones',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/fornecedor/telefones',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/fornecedor/telefones',Delete);
  {$EndRegion 'FORNECEDOR_TELEFONES'}
end;

procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_TELEFONES :TFORNECEDOR_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;

  I :Integer;

  lId :Integer;
  lIdFornecedor :Integer;
  lPagina :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFORNECEDOR_TELEFONES := TFORNECEDOR_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lId := 0;
      lIdFornecedor := 0;
      lPagina := 0;

      lId := StrToIntDef(Req.Query['id'],0);
      lIdFornecedor := StrToIntDef(Req.Query['idFornecedor'],0);
      lPagina := StrToIntDef(Req.Query['pagina'],0);

      lJson_Ret := lTFORNECEDOR_TELEFONES.Listar(
        lQuery
        ,lIdFornecedor
        ,lId
        ,lPagina);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Telefones não localizados').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery,'Telefones do Fornecedor não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de Telefones do Fornecedor');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao listar Telefones do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFORNECEDOR_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTFORNECEDOR_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_TELEFONES :TFORNECEDOR_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin

  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFORNECEDOR_TELEFONES := TFORNECEDOR_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFORNECEDOR_TELEFONES.Inicia_Propriedades;

        lTFORNECEDOR_TELEFONES.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFORNECEDOR_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0);
        lTFORNECEDOR_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTFORNECEDOR_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFORNECEDOR_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFORNECEDOR_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_TELEFONES.Inserir(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefone do Fornecedor cadastrado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Fornecedor cadastrado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar Telefone do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFORNECEDOR_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      lTFORNECEDOR_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_TELEFONES :TFORNECEDOR_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;

  I:Integer;
begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;

      lTFORNECEDOR_TELEFONES := TFORNECEDOR_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser alterados');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTFORNECEDOR_TELEFONES.Inicia_Propriedades;

        lTFORNECEDOR_TELEFONES.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFORNECEDOR_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0);
        lTFORNECEDOR_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0);
        lTFORNECEDOR_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero','');
        lTFORNECEDOR_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTFORNECEDOR_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTFORNECEDOR_TELEFONES.Atualizar(lQuery);
      end;

      DM_Lanchonete.FDC_Lanchonete.Commit;

      Res.Send('Telefone do Fornecedor alterado com sucesso').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Fornecedor alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar o Telefone do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lTFORNECEDOR_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      lTFORNECEDOR_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lJson_Ret :TJSONArray;

  DM_Lanchonete :TDM_Lanchonete;
  lTFORNECEDOR_TELEFONES :TFORNECEDOR_TELEFONES;
  lErro :String;

  lQuery :TFDQuery;
  lID_FORNECEDOR :Integer;
  lID :Integer;

begin
  try
    try
      DM_Lanchonete := TDM_Lanchonete.Create(Nil);

      lTFORNECEDOR_TELEFONES := TFORNECEDOR_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

      lID_FORNECEDOR := StrToIntDef(Req.Query['idFornecedor'],0);
      lID := StrToIntDef(Req.Query['id'],0);

      lTFORNECEDOR_TELEFONES.Excluir(lQuery,lID_FORNECEDOR,lID);

      Res.Send('Telefone do Fornecedor excluído').Status(200);
      TFuncoes.Gravar_Hitorico(lQuery,'Telefone do Fornecedor excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o Telefone do Fornecedor: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(DM_Lanchonete);
      FreeAndNil(lTFORNECEDOR_TELEFONES);
    {$ELSE}
      lQuery.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTFORNECEDOR_TELEFONES.DisposeOf;
    {$ENDIF}
  end;
end;

end.
