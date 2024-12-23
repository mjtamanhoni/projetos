unit uRota.IMPRESSORAS;
 
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
 
  uModel.IMPRESSORAS, 
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
  {$Region 'IMPRESSORAS'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/impressoras',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/impressoras',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/impressoras',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/impressoras',Delete);
  {$EndRegion 'IMPRESSORAS'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORAS :TIMPRESSORAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lId :Integer; 
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTIMPRESSORAS := TIMPRESSORAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lId := 0; 
 
      lId := StrToIntDef(Req.Query['id'],0); 
 
      lJson_Ret := lTIMPRESSORAS.Listar( 
        lQuery); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('IMPRESSORAS não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORAS não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de IMPRESSORAS');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar IMPRESSORAS: ' + E.Message);
      end;
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTIMPRESSORAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTIMPRESSORAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORAS :TIMPRESSORAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTIMPRESSORAS := TIMPRESSORAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado');


      for I := 0 to (lBody.Size - 1) do
      begin
        lTIMPRESSORAS.Inicia_Propriedades;

        //Gerar sequencial...
        lTIMPRESSORAS.ID := 0;
        lQuery.Active := False;
        lQuery.SQL.Clear;
        lQuery.SQL.Add('SELECT GEN_ID(GEN_IMPRESSORAS_ID,1) AS SEQ FROM RDB$DATABASE;');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTIMPRESSORAS.ID := lQuery.FieldByName('SEQ').AsInteger;

        //lTIMPRESSORAS.ID := lBody[I].GetValue<Integer>('id',0);
        lTIMPRESSORAS.NOME := lBody[I].GetValue<String>('nome','');
        lTIMPRESSORAS.MODELO := lBody[I].GetValue<String>('modelo',''); 
        lTIMPRESSORAS.PORTA := lBody[I].GetValue<String>('porta',''); 
        lTIMPRESSORAS.COLUNAS := lBody[I].GetValue<Integer>('colunas',0); 
        lTIMPRESSORAS.ESPACOS := lBody[I].GetValue<Integer>('espacos',0); 
        lTIMPRESSORAS.BUFFER := lBody[I].GetValue<Integer>('buffer',0); 
        lTIMPRESSORAS.LINHAS_PULAR := lBody[I].GetValue<Integer>('linhasPular',0); 
        lTIMPRESSORAS.CONTROLE_PORTA := lBody[I].GetValue<Integer>('controlePorta',0); 
        lTIMPRESSORAS.CORTAR_PAPEL := lBody[I].GetValue<Integer>('cortarPapel',0); 
        lTIMPRESSORAS.TRADUZIR_TAGS := lBody[I].GetValue<Integer>('traduzirTags',0); 
        lTIMPRESSORAS.IGNORAR_TAGS := lBody[I].GetValue<Integer>('ignorarTags',0); 
        lTIMPRESSORAS.ARQ_LOGO := lBody[I].GetValue<String>('arqLogo',''); 
        lTIMPRESSORAS.PAG_CODIGO := lBody[I].GetValue<String>('pagCodigo',''); 
        lTIMPRESSORAS.COD_BARRAS_LARGURA := lBody[I].GetValue<Integer>('codBarrasLargura',0); 
        lTIMPRESSORAS.COD_BARRAS_ALTURA := lBody[I].GetValue<Integer>('codBarrasAltura',0); 
        lTIMPRESSORAS.COD_BARRAS_EXIBE_NR := lBody[I].GetValue<Integer>('codBarrasExibeNr',0); 
        lTIMPRESSORAS.QR_CODE_TIPO := lBody[I].GetValue<Integer>('qrCodeTipo',0); 
        lTIMPRESSORAS.QR_CODE_LARGURA_MOD := lBody[I].GetValue<Integer>('qrCodeLarguraMod',0); 
        lTIMPRESSORAS.QR_CODE_ERROR_LEVEL := lBody[I].GetValue<Integer>('qrCodeErrorLevel',0); 
        lTIMPRESSORAS.GAVETA := lBody[I].GetValue<Integer>('gaveta',0); 
        lTIMPRESSORAS.GAVETA_ON := lBody[I].GetValue<Integer>('gavetaOn',0); 
        lTIMPRESSORAS.GAVETA_OFF := lBody[I].GetValue<Integer>('gavetaOff',0); 
        lTIMPRESSORAS.GAVETA_INVERTIDO := lBody[I].GetValue<Integer>('gavetaInvertido',0); 
        lTIMPRESSORAS.LOGOMARCA := lBody[I].GetValue<String>('logomarca',''); 
        lTIMPRESSORAS.LOGOMARCA_TIPO := lBody[I].GetValue<Integer>('logomarcaTipo',0); 
        lTIMPRESSORAS.LOGOMARCA_KC1 := lBody[I].GetValue<Integer>('logomarcaKc1',0); 
        lTIMPRESSORAS.LOGOMARCA_KC2 := lBody[I].GetValue<Integer>('logomarcaKc2',0); 
        lTIMPRESSORAS.LOGOMARCA_FATORX := lBody[I].GetValue<Integer>('logomarcaFatorx',0); 
        lTIMPRESSORAS.LOGOMARCA_FATORY := lBody[I].GetValue<Integer>('logomarcaFatory',0); 
        lTIMPRESSORAS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTIMPRESSORAS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTIMPRESSORAS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',TimeToStr(Time)),lErro);
        lTIMPRESSORAS.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('IMPRESSORAS cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORAS cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar IMPRESSORAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTIMPRESSORAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTIMPRESSORAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORAS :TIMPRESSORAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTIMPRESSORAS := TIMPRESSORAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTIMPRESSORAS.Inicia_Propriedades; 
 
        lTIMPRESSORAS.ID := lBody[I].GetValue<Integer>('id',0); 
        lTIMPRESSORAS.NOME := lBody[I].GetValue<String>('nome',''); 
        lTIMPRESSORAS.MODELO := lBody[I].GetValue<String>('modelo',''); 
        lTIMPRESSORAS.PORTA := lBody[I].GetValue<String>('porta',''); 
        lTIMPRESSORAS.COLUNAS := lBody[I].GetValue<Integer>('colunas',0); 
        lTIMPRESSORAS.ESPACOS := lBody[I].GetValue<Integer>('espacos',0); 
        lTIMPRESSORAS.BUFFER := lBody[I].GetValue<Integer>('buffer',0); 
        lTIMPRESSORAS.LINHAS_PULAR := lBody[I].GetValue<Integer>('linhasPular',0); 
        lTIMPRESSORAS.CONTROLE_PORTA := lBody[I].GetValue<Integer>('controlePorta',0); 
        lTIMPRESSORAS.CORTAR_PAPEL := lBody[I].GetValue<Integer>('cortarPapel',0); 
        lTIMPRESSORAS.TRADUZIR_TAGS := lBody[I].GetValue<Integer>('traduzirTags',0); 
        lTIMPRESSORAS.IGNORAR_TAGS := lBody[I].GetValue<Integer>('ignorarTags',0); 
        lTIMPRESSORAS.ARQ_LOGO := lBody[I].GetValue<String>('arqLogo',''); 
        lTIMPRESSORAS.PAG_CODIGO := lBody[I].GetValue<String>('pagCodigo',''); 
        lTIMPRESSORAS.COD_BARRAS_LARGURA := lBody[I].GetValue<Integer>('codBarrasLargura',0); 
        lTIMPRESSORAS.COD_BARRAS_ALTURA := lBody[I].GetValue<Integer>('codBarrasAltura',0); 
        lTIMPRESSORAS.COD_BARRAS_EXIBE_NR := lBody[I].GetValue<Integer>('codBarrasExibeNr',0); 
        lTIMPRESSORAS.QR_CODE_TIPO := lBody[I].GetValue<Integer>('qrCodeTipo',0); 
        lTIMPRESSORAS.QR_CODE_LARGURA_MOD := lBody[I].GetValue<Integer>('qrCodeLarguraMod',0); 
        lTIMPRESSORAS.QR_CODE_ERROR_LEVEL := lBody[I].GetValue<Integer>('qrCodeErrorLevel',0); 
        lTIMPRESSORAS.GAVETA := lBody[I].GetValue<Integer>('gaveta',0); 
        lTIMPRESSORAS.GAVETA_ON := lBody[I].GetValue<Integer>('gavetaOn',0); 
        lTIMPRESSORAS.GAVETA_OFF := lBody[I].GetValue<Integer>('gavetaOff',0); 
        lTIMPRESSORAS.GAVETA_INVERTIDO := lBody[I].GetValue<Integer>('gavetaInvertido',0); 
        lTIMPRESSORAS.LOGOMARCA := lBody[I].GetValue<String>('logomarca',''); 
        lTIMPRESSORAS.LOGOMARCA_TIPO := lBody[I].GetValue<Integer>('logomarcaTipo',0); 
        lTIMPRESSORAS.LOGOMARCA_KC1 := lBody[I].GetValue<Integer>('logomarcaKc1',0); 
        lTIMPRESSORAS.LOGOMARCA_KC2 := lBody[I].GetValue<Integer>('logomarcaKc2',0); 
        lTIMPRESSORAS.LOGOMARCA_FATORX := lBody[I].GetValue<Integer>('logomarcaFatorx',0); 
        lTIMPRESSORAS.LOGOMARCA_FATORY := lBody[I].GetValue<Integer>('logomarcaFatory',0); 
        lTIMPRESSORAS.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTIMPRESSORAS.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTIMPRESSORAS.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',TimeToStr(Time)),lErro);
        lTIMPRESSORAS.Atualizar(lQuery);
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('IMPRESSORAS alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORAS alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar IMPRESSORAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTIMPRESSORAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTIMPRESSORAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTIMPRESSORAS :TIMPRESSORAS; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTIMPRESSORAS := TIMPRESSORAS.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTIMPRESSORAS.Excluir(lQuery,lId); 
 
      Res.Send('IMPRESSORAS excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'IMPRESSORAS excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o IMPRESSORAS: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTIMPRESSORAS); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTIMPRESSORAS.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
