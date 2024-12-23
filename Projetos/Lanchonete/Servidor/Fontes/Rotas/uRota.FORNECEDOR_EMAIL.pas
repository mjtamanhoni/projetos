unit uRota.FORNECEDOR_EMAIL; 
 
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
 
  uModel.FORNECEDOR_EMAIL, 
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
  {$Region 'FORNECEDOR_EMAIL'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/fornecedor/email',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/fornecedor/email',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/fornecedor/email',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/fornecedor/email',Delete);
  {$EndRegion 'FORNECEDOR_EMAIL'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORNECEDOR_EMAIL :TFORNECEDOR_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_FORNECEDOR :Integer;
  lID :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFORNECEDOR_EMAIL := TFORNECEDOR_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FORNECEDOR := 0; 
      lID_FORNECEDOR := StrToIntDef(Req.Query['idFornecedor'],0); 
      lID := 0; 
      lID := StrToIntDef(Req.Query['id'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTFORNECEDOR_EMAIL.Listar(lQuery,lID_FORNECEDOR,lID,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('FORNECEDOR_EMAIL não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - FORNECEDOR_EMAIL não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de FORNECEDOR_EMAIL'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar FORNECEDOR_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFORNECEDOR_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFORNECEDOR_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORNECEDOR_EMAIL :TFORNECEDOR_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then 
        DM_Lanchonete.FDC_Lanchonete.StartTransaction; 
 
      lTFORNECEDOR_EMAIL := TFORNECEDOR_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFORNECEDOR_EMAIL.Inicia_Propriedades; 

        lTFORNECEDOR_EMAIL.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0);
        lTFORNECEDOR_EMAIL.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFORNECEDOR_EMAIL.RESPONSAVEL := lBody[I].GetValue<String>('responsavel',''); 
        lTFORNECEDOR_EMAIL.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0);
        lTFORNECEDOR_EMAIL.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTFORNECEDOR_EMAIL.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFORNECEDOR_EMAIL.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFORNECEDOR_EMAIL.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTFORNECEDOR_EMAIL.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FORNECEDOR_EMAIL cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - FORNECEDOR_EMAIL cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        DM_Lanchonete.FDC_Lanchonete.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar FORNECEDOR_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFORNECEDOR_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFORNECEDOR_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORNECEDOR_EMAIL :TFORNECEDOR_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then 
        DM_Lanchonete.FDC_Lanchonete.StartTransaction; 
 
      lTFORNECEDOR_EMAIL := TFORNECEDOR_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFORNECEDOR_EMAIL.Inicia_Propriedades; 
 
        lTFORNECEDOR_EMAIL.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0); 
        lTFORNECEDOR_EMAIL.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFORNECEDOR_EMAIL.RESPONSAVEL := lBody[I].GetValue<String>('responsavel',''); 
        lTFORNECEDOR_EMAIL.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTFORNECEDOR_EMAIL.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTFORNECEDOR_EMAIL.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFORNECEDOR_EMAIL.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFORNECEDOR_EMAIL.HF_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hfCadastro',DateToStr(Date)),lErro); 
        lTFORNECEDOR_EMAIL.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FORNECEDOR_EMAIL alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - FORNECEDOR_EMAIL alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        DM_Lanchonete.FDC_Lanchonete.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar FORNECEDOR_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFORNECEDOR_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFORNECEDOR_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFORNECEDOR_EMAIL :TFORNECEDOR_EMAIL; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_FORNECEDOR :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFORNECEDOR_EMAIL := TFORNECEDOR_EMAIL.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FORNECEDOR := StrToIntDef(Req.Query['idFornecedor'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTFORNECEDOR_EMAIL.Excluir(lQuery,lID_FORNECEDOR,lID); 
 
      Res.Send('FORNECEDOR_EMAIL excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - FORNECEDOR_EMAIL excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o FORNECEDOR_EMAIL: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFORNECEDOR_EMAIL); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFORNECEDOR_EMAIL.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
