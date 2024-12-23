unit uRota.MUNICIPIOS;
 
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
 
  uModel.MUNICIPIOS, 
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
  {$Region 'MUNICIPIOS'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/municipios',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/municipios',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/municipios',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/municipios',Delete);
  {$EndRegion 'MUNICIPIOS'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTMUNICIPIOS :TMUNICIPIOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lPagina :Integer;
  lNome :String;
  lUfSigla :String;
  lIbge :String;

begin
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTMUNICIPIOS := TMUNICIPIOS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0);
      lPagina := StrToIntDef(Req.Query['pagina'],0);
      lNome := Req.Query['nome'];
      lUfSigla := Req.Query['ufSigla'];
      lIbge := Req.Query['ibge'];

      lJson_Ret := lTMUNICIPIOS.Listar(lQuery,lID,lNome,lUfSigla,lIbge,lPagina);
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('MUNICIPIOS não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'MUNICIPIOS não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'MUNICIPIOS não localizado');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar MUNICIPIOS: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTMUNICIPIOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTMUNICIPIOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTMUNICIPIOS :TMUNICIPIOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTMUNICIPIOS := TMUNICIPIOS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;


      lBody := Req.Body<TJsonArray>;
      if lBody = Nil then
        raise Exception.Create('Não há registros para ser cadastrado');

      for I := 0 to (lBody.Size - 1) do
      begin
        lTMUNICIPIOS.Inicia_Propriedades;

        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_MUNICIPIOS_ID,1) AS SEQ FROM RDB$DATABASE');
        lQuery.Active := True;

        if not lQuery.IsEmpty then
          lTMUNICIPIOS.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTMUNICIPIOS.ID := lBody[I].GetValue<Integer>('id',0);
        lTMUNICIPIOS.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTMUNICIPIOS.NOME := lBody[I].GetValue<String>('nome',''); 
        lTMUNICIPIOS.SIGLA_UF := lBody[I].GetValue<String>('siglaUf',''); 
        lTMUNICIPIOS.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('MUNICIPIOS cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'MUNICIPIOS cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar MUNICIPIOS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTMUNICIPIOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTMUNICIPIOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTMUNICIPIOS :TMUNICIPIOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTMUNICIPIOS := TMUNICIPIOS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTMUNICIPIOS.Inicia_Propriedades; 
 
        lTMUNICIPIOS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTMUNICIPIOS.IBGE := lBody[I].GetValue<Integer>('ibge',0); 
        lTMUNICIPIOS.NOME := lBody[I].GetValue<String>('nome',''); 
        lTMUNICIPIOS.SIGLA_UF := lBody[I].GetValue<String>('siglaUf',''); 
        lTMUNICIPIOS.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('MUNICIPIOS alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'MUNICIPIOS alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar MUNICIPIOS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTMUNICIPIOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTMUNICIPIOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTMUNICIPIOS :TMUNICIPIOS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTMUNICIPIOS := TMUNICIPIOS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTMUNICIPIOS.Excluir(lQuery,lID); 
 
      Res.Send('MUNICIPIOS excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'MUNICIPIOS excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o MUNICIPIOS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTMUNICIPIOS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTMUNICIPIOS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 

end.



