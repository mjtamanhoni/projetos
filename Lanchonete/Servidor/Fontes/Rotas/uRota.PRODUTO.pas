unit uRota.PRODUTO; 
 
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
 
  uModel.PRODUTO, 
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
  {$Region 'PRODUTO'} 
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/produto',Listar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/produto',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/produto',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/produto',Delete);
  {$EndRegion 'PRODUTO'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPRODUTO :TPRODUTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lNOME :String;
  lID_GRUPO :Integer;
  lID_SUB_GRUPO :Integer;
  lID_SETOR :Integer;
  lID_FORNECEDOR :Integer;

begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTPRODUTO := TPRODUTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 

      lID := StrToIntDef(Req.Query['id'],0); 
      lNOME := Req.Query['nome'];
      lID_GRUPO := StrToIntDef(Req.Query['idGrupo'],0);
      lID_SUB_GRUPO := StrToIntDef(Req.Query['idSubGrupo'],0);
      lID_SETOR := StrToIntDef(Req.Query['idSetor'],0);
      lID_FORNECEDOR := StrToIntDef(Req.Query['idFornecedor'],0);

      lJson_Ret := lTPRODUTO.Listar(lQuery,lID,lNOME,lID_GRUPO,lID_SUB_GRUPO,lID_SETOR,lID_FORNECEDOR);

      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('PRODUTO não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,'PRODUTO não localizado');
      end
      else
      begin
        Res.Send(lJson_Ret).Status(200);
        TFuncoes.Gravar_Hitorico(lQuery,'Listagem de PRODUTO');
      end;
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Listar PRODUTO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTPRODUTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTPRODUTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPRODUTO :TPRODUTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTPRODUTO := TPRODUTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTPRODUTO.Inicia_Propriedades; 

        lQuery.Active := False;
        lQuery.Sql.Clear;
        lQuery.Sql.Add('SELECT GEN_ID(GEN_PRODUTO_ID,1) AS SEQ FROM RDB$DATABASE');
        lQuery.Active := True;
        if not lQuery.IsEmpty then
          lTPRODUTO.ID := lQuery.FieldByName('SEQ').AsInteger
        else
          lTPRODUTO.ID := lBody[I].GetValue<Integer>('id',0);
        lTPRODUTO.COD_BARRAS := lBody[I].GetValue<String>('codBarras','');
        lTPRODUTO.NOME := lBody[I].GetValue<String>('nome',''); 
        lTPRODUTO.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTPRODUTO.UNIDADE_SIGLA := lBody[I].GetValue<String>('unidadeSigla',''); 
        lTPRODUTO.ID_GRUPO := lBody[I].GetValue<Integer>('idGrupo',0); 
        lTPRODUTO.ID_SUB_GRUPO := lBody[I].GetValue<Integer>('idSubGrupo',0); 
        lTPRODUTO.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTPRODUTO.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0); 
        lTPRODUTO.EMBALAGEM := lBody[I].GetValue<String>('embalagem',''); 
        lTPRODUTO.EMBALAGEM_QTDE := lBody[I].GetValue<Double>('embalagemQtde',0); 
        lTPRODUTO.PRECO_COMPRA := lBody[I].GetValue<Double>('precoCompra',0); 
        lTPRODUTO.LUCRO_PERC := lBody[I].GetValue<Double>('lucroPerc',0); 
        lTPRODUTO.PERCO_VENDA := lBody[I].GetValue<Double>('percoVenda',0); 
        lTPRODUTO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTPRODUTO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTPRODUTO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTPRODUTO.Inserir(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('PRODUTO cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'PRODUTO cadastrados com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Cadastrar PRODUTO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTPRODUTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTPRODUTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPRODUTO :TPRODUTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
      if not DM_Lanchonete.FDC_Lanchonete.InTransaction then
        DM_Lanchonete.FDC_Lanchonete.StartTransaction;
 
      lTPRODUTO := TPRODUTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTPRODUTO.Inicia_Propriedades; 
 
        lTPRODUTO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTPRODUTO.COD_BARRAS := lBody[I].GetValue<String>('codBarras',''); 
        lTPRODUTO.NOME := lBody[I].GetValue<String>('nome',''); 
        lTPRODUTO.STATUS := lBody[I].GetValue<Integer>('status',0); 
        lTPRODUTO.UNIDADE_SIGLA := lBody[I].GetValue<String>('unidadeSigla',''); 
        lTPRODUTO.ID_GRUPO := lBody[I].GetValue<Integer>('idGrupo',0); 
        lTPRODUTO.ID_SUB_GRUPO := lBody[I].GetValue<Integer>('idSubGrupo',0); 
        lTPRODUTO.ID_SETOR := lBody[I].GetValue<Integer>('idSetor',0); 
        lTPRODUTO.ID_FORNECEDOR := lBody[I].GetValue<Integer>('idFornecedor',0); 
        lTPRODUTO.EMBALAGEM := lBody[I].GetValue<String>('embalagem',''); 
        lTPRODUTO.EMBALAGEM_QTDE := lBody[I].GetValue<Double>('embalagemQtde',0); 
        lTPRODUTO.PRECO_COMPRA := lBody[I].GetValue<Double>('precoCompra',0); 
        lTPRODUTO.LUCRO_PERC := lBody[I].GetValue<Double>('lucroPerc',0); 
        lTPRODUTO.PERCO_VENDA := lBody[I].GetValue<Double>('percoVenda',0); 
        lTPRODUTO.ID_USUARIO := lBody[I].GetValue<Integer>('idUsuario',0); 
        lTPRODUTO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTPRODUTO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTPRODUTO.Atualizar(lQuery); 
      end; 
 
      DM_Lanchonete.FDC_Lanchonete.Commit; 
 
      Res.Send('PRODUTO alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'PRODUTO alterado com sucesso');
    except on E: Exception do
      begin
        DM_Lanchonete.FDC_Lanchonete.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao Alterar PRODUTO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTPRODUTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTPRODUTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  DM_Lanchonete :TDM_Lanchonete; 
  lTPRODUTO :TPRODUTO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      DM_Lanchonete := TDM_Lanchonete.Create(Nil); 
 
      lTPRODUTO := TPRODUTO.Create(DM_Lanchonete.FDC_Lanchonete); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTPRODUTO.Excluir(lQuery,lID); 
 
      Res.Send('PRODUTO excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,'PRODUTO excluído');
    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery,'Erro ao excluir o PRODUTO: ' + E.Message);
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(DM_Lanchonete); 
      FreeAndNil(lTPRODUTO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      DM_Lanchonete.DisposeOf; 
      lTPRODUTO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
end. 
