unit uRota.EMPRESA;
 
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
 
  uModel.EMPRESA, 
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
  {$Region 'EMPRESA'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/empresa',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/empresa',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/empresa',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/empresa',Delete);
  {$EndRegion 'EMPRESA'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA :TEMPRESA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 

  lId :Integer;
  lPagina :Integer;
  lNome :String;
  lDocumento :String;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTEMPRESA := TEMPRESA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lId := 0;
      lPagina := 0;
      lNome := '';
      lDocumento := '';
 
      lId := StrToIntDef(Req.Query['id'],0);
      lNome := Req.Query['nome'];
      lPagina := StrToIntDef(Req.Query['pagina'],0);
      lDocumento := Req.Query['documento'];

      lJson_Ret := lTEMPRESA.Listar(
        lQuery
        ,lId
        ,lNome
        ,lDocumento
        ,lPagina);

      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('EMPRESA não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'EMPRESA não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de EMPRESA');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar EMPRESA: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA :TEMPRESA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTEMPRESA := TEMPRESA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA.Inicia_Propriedades; 

        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_EMPRESA_ID,1) AS SEQ FROM RDB$DATABASE');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTEMPRESA.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTEMPRESA.ID := lBody[I].GetValue<Integer>('id',0);

        lTEMPRESA.RAZAO_SOCIAL := lBody[I].GetValue<String>('razaoSocial','');
        lTEMPRESA.NOME_FANTASIA := lBody[I].GetValue<String>('nomeFantasia',''); 
        lTEMPRESA.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTEMPRESA.TIPO_PESSOA := lBody[I].GetValue<String>('tipoPessoa',''); 
        lTEMPRESA.DOCUMENTO := lBody[I].GetValue<String>('documento',''); 
        lTEMPRESA.INSCRICAO_ESTADUAL := lBody[I].GetValue<String>('inscricaoEstadual',''); 
        lTEMPRESA.INSCRICAO_MUNICIPAL := lBody[I].GetValue<String>('inscricaoMunicipal',''); 
        lTEMPRESA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0);
        lTEMPRESA.DT_CADASTRO := TFuncoes.Converte_Data(lBody[I].GetValue<String>('dtCadastro',FormatDateTime('YYYY-MM-DD',Date)));
        lTEMPRESA.HR_CADASTRO := TFuncoes.Converte_Hora(lBody[I].GetValue<String>('hrCadastro',FormatDateTime('HH:NN:SS'+'.000',Time)));
        lTEMPRESA.Inserir(lQuery);
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('EMPRESA cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'EMPRESA cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar EMPRESA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA :TEMPRESA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTEMPRESA := TEMPRESA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTEMPRESA.Inicia_Propriedades; 
 
        lTEMPRESA.ID := lBody[I].GetValue<Integer>('id',0); 
        lTEMPRESA.RAZAO_SOCIAL := lBody[I].GetValue<String>('razaoSocial','');
        lTEMPRESA.NOME_FANTASIA := lBody[I].GetValue<String>('nomeFantasia',''); 
        lTEMPRESA.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTEMPRESA.TIPO_PESSOA := lBody[I].GetValue<String>('tipoPessoa',''); 
        lTEMPRESA.DOCUMENTO := lBody[I].GetValue<String>('documento',''); 
        lTEMPRESA.INSCRICAO_ESTADUAL := lBody[I].GetValue<String>('inscricaoEstadual',''); 
        lTEMPRESA.INSCRICAO_MUNICIPAL := lBody[I].GetValue<String>('inscricaoMunicipal',''); 
        lTEMPRESA.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTEMPRESA.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTEMPRESA.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro);
        lTEMPRESA.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('EMPRESA alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'EMPRESA alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar EMPRESA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTEMPRESA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTEMPRESA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTEMPRESA :TEMPRESA; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTEMPRESA := TEMPRESA.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTEMPRESA.Excluir(lQuery,lId); 
 
      Res.Send('EMPRESA excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'EMPRESA excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o EMPRESA: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTEMPRESA); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTEMPRESA.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
