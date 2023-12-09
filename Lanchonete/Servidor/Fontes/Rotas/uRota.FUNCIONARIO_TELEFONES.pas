unit uRota.FUNCIONARIO_TELEFONES; 
 
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
 
  uModel.FUNCIONARIO_TELEFONES, 
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
  {$Region 'FUNCIONARIO_TELEFONES'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/funcionarioTelefones',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/funcionarioTelefones',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/funcionarioTelefones',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/funcionarioTelefones',Delete);
  {$EndRegion 'FUNCIONARIO_TELEFONES'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_TELEFONES :TFUNCIONARIO_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_FUNCIONARIO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFUNCIONARIO_TELEFONES := TFUNCIONARIO_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FUNCIONARIO := StrToIntDef(Req.Query['idFuncionario'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTFUNCIONARIO_TELEFONES.Listar(lQuery,lID_FUNCIONARIO,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('FUNCIONARIO_TELEFONES não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_TELEFONES não localizado');
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de FUNCIONARIO_TELEFONES');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar FUNCIONARIO_TELEFONES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFUNCIONARIO_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFUNCIONARIO_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_TELEFONES :TFUNCIONARIO_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTFUNCIONARIO_TELEFONES := TFUNCIONARIO_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFUNCIONARIO_TELEFONES.Inicia_Propriedades; 
 
        lTFUNCIONARIO_TELEFONES.ID_FUNCIONARIO := lBody[I].GetValue<Integer>('idFuncionario',0); 
        lTFUNCIONARIO_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFUNCIONARIO_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0); 
        lTFUNCIONARIO_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTFUNCIONARIO_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFUNCIONARIO_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_TELEFONES.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FUNCIONARIO_TELEFONES cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_TELEFONES cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar FUNCIONARIO_TELEFONES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFUNCIONARIO_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFUNCIONARIO_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_TELEFONES :TFUNCIONARIO_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTFUNCIONARIO_TELEFONES := TFUNCIONARIO_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFUNCIONARIO_TELEFONES.Inicia_Propriedades; 
 
        lTFUNCIONARIO_TELEFONES.ID_FUNCIONARIO := lBody[I].GetValue<Integer>('idFuncionario',0); 
        lTFUNCIONARIO_TELEFONES.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFUNCIONARIO_TELEFONES.TIPO := lBody[I].GetValue<Integer>('tipo',0); 
        lTFUNCIONARIO_TELEFONES.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTFUNCIONARIO_TELEFONES.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFUNCIONARIO_TELEFONES.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_TELEFONES.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_TELEFONES.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FUNCIONARIO_TELEFONES alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_TELEFONES alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar FUNCIONARIO_TELEFONES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFUNCIONARIO_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFUNCIONARIO_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_TELEFONES :TFUNCIONARIO_TELEFONES; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_FUNCIONARIO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFUNCIONARIO_TELEFONES := TFUNCIONARIO_TELEFONES.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FUNCIONARIO := StrToIntDef(Req.Query['idFuncionario'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTFUNCIONARIO_TELEFONES.Excluir(lQuery,lID_FUNCIONARIO,lID); 
 
      Res.Send('FUNCIONARIO_TELEFONES excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_TELEFONES excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o FUNCIONARIO_TELEFONES: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFUNCIONARIO_TELEFONES); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFUNCIONARIO_TELEFONES.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
