unit uRota.FUNCIONARIO_ENDERECO; 
 
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
 
  uModel.FUNCIONARIO_ENDERECO, 
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
  {$Region 'FUNCIONARIO_ENDERECO'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/funcionarioEndereco',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/funcionarioEndereco',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/funcionarioEndereco',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/funcionarioEndereco',Delete);
  {$EndRegion 'FUNCIONARIO_ENDERECO'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_ENDERECO :TFUNCIONARIO_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID_FUNCIONARIO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFUNCIONARIO_ENDERECO := TFUNCIONARIO_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FUNCIONARIO := StrToIntDef(Req.Query['idFuncionario'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTFUNCIONARIO_ENDERECO.Listar(lQuery,lID_FUNCIONARIO,lID); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('FUNCIONARIO_ENDERECO não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_ENDERECO não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de FUNCIONARIO_ENDERECO');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar FUNCIONARIO_ENDERECO: ' + E.Message);
      end;
    end;
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFUNCIONARIO_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFUNCIONARIO_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_ENDERECO :TFUNCIONARIO_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTFUNCIONARIO_ENDERECO := TFUNCIONARIO_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFUNCIONARIO_ENDERECO.Inicia_Propriedades; 
 
        lTFUNCIONARIO_ENDERECO.ID_FUNCIONARIO := lBody[I].GetValue<Integer>('idFuncionario',0); 
        lTFUNCIONARIO_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFUNCIONARIO_ENDERECO.CEP := lBody[I].GetValue<String>('cep',''); 
        lTFUNCIONARIO_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro',''); 
        lTFUNCIONARIO_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTFUNCIONARIO_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento',''); 
        lTFUNCIONARIO_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro',''); 
        lTFUNCIONARIO_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTFUNCIONARIO_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio',''); 
        lTFUNCIONARIO_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf',''); 
        lTFUNCIONARIO_ENDERECO.UF := lBody[I].GetValue<String>('uf',''); 
        lTFUNCIONARIO_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao',''); 
        lTFUNCIONARIO_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0); 
        lTFUNCIONARIO_ENDERECO.PAIS := lBody[I].GetValue<String>('pais',''); 
        lTFUNCIONARIO_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFUNCIONARIO_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_ENDERECO.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FUNCIONARIO_ENDERECO cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_ENDERECO cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar FUNCIONARIO_ENDERECO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFUNCIONARIO_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFUNCIONARIO_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_ENDERECO :TFUNCIONARIO_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTFUNCIONARIO_ENDERECO := TFUNCIONARIO_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTFUNCIONARIO_ENDERECO.Inicia_Propriedades; 
 
        lTFUNCIONARIO_ENDERECO.ID_FUNCIONARIO := lBody[I].GetValue<Integer>('idFuncionario',0); 
        lTFUNCIONARIO_ENDERECO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTFUNCIONARIO_ENDERECO.CEP := lBody[I].GetValue<String>('cep',''); 
        lTFUNCIONARIO_ENDERECO.LOGRADOURO := lBody[I].GetValue<String>('logradouro',''); 
        lTFUNCIONARIO_ENDERECO.NUMERO := lBody[I].GetValue<String>('numero',''); 
        lTFUNCIONARIO_ENDERECO.COMPLEMENTO := lBody[I].GetValue<String>('complemento',''); 
        lTFUNCIONARIO_ENDERECO.BAIRRO := lBody[I].GetValue<String>('bairro',''); 
        lTFUNCIONARIO_ENDERECO.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTFUNCIONARIO_ENDERECO.MUNICIPIO := lBody[I].GetValue<String>('municipio',''); 
        lTFUNCIONARIO_ENDERECO.SIGLA_UF := lBody[I].GetValue<String>('siglaUf',''); 
        lTFUNCIONARIO_ENDERECO.UF := lBody[I].GetValue<String>('uf',''); 
        lTFUNCIONARIO_ENDERECO.REGIAO := lBody[I].GetValue<String>('regiao',''); 
        lTFUNCIONARIO_ENDERECO.CODIGO_PAIS := lBody[I].GetValue<Integer>('codigoPais',0); 
        lTFUNCIONARIO_ENDERECO.PAIS := lBody[I].GetValue<String>('pais',''); 
        lTFUNCIONARIO_ENDERECO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTFUNCIONARIO_ENDERECO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_ENDERECO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTFUNCIONARIO_ENDERECO.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('FUNCIONARIO_ENDERECO alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_ENDERECO alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar FUNCIONARIO_ENDERECO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTFUNCIONARIO_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTFUNCIONARIO_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTFUNCIONARIO_ENDERECO :TFUNCIONARIO_ENDERECO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID_FUNCIONARIO :Integer;
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTFUNCIONARIO_ENDERECO := TFUNCIONARIO_ENDERECO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID_FUNCIONARIO := StrToIntDef(Req.Query['idFuncionario'],0); 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTFUNCIONARIO_ENDERECO.Excluir(lQuery,lID_FUNCIONARIO,lID); 
 
      Res.Send('FUNCIONARIO_ENDERECO excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'FUNCIONARIO_ENDERECO excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o FUNCIONARIO_ENDERECO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTFUNCIONARIO_ENDERECO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTFUNCIONARIO_ENDERECO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
