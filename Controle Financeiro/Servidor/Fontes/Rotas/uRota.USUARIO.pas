unit uRota.USUARIO;
 
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
 
  uModel.USUARIO, 
  uFuncoes, 
  uDM_Global,
 
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, 
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, 
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, 
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, 
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase, 
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script; 
 
  procedure RegistrarRotas;

  {$Region 'Rotas não protegidas'}
    procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  {$EndRegion 'Rotas não protegidas'}

  procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
 
implementation 
 
procedure RegistrarRotas; 
begin
  {$Region 'Rotas não protegidas'}
    THorse.Post('/usuario',Cadastro);
    THorse.Post('/usuario/login',Login);
  {$EndRegion 'Rotas não protegidas'}

  {$Region 'USUARIO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/usuario',Listar);
    //THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/usuario',Cadastro);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/usuario',Alterar);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/usuario',Delete);
  {$EndRegion 'USUARIO'} 
end; 
 
procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM;
  lTUSUARIO :TUSUARIO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I :Integer; 
 
  lID :Integer;
  lPagina :Integer; 
 
begin 
  try 
    try 
      FDm := TDM.Create(Nil);
 
      lTUSUARIO := TUSUARIO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := 0; 
      lID := StrToIntDef(Req.Query['id'],0); 
      lPagina := StrToIntDef(Req.Query['pagina'],0); 
 
      lJson_Ret := lTUSUARIO.Listar(lQuery,lID,lPagina); 
 
      if lJson_Ret.Size = 0  then 
      begin 
        Res.Send('USUARIO não localizados').Status(401); 
        TFuncoes.Gravar_Hitorico(lQuery,' - USUARIO não localizado'); 
      end 
      else 
      begin 
        Res.Send(lJson_Ret).Status(200); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Listagem de USUARIO'); 
      end; 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Listar USUARIO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTUSUARIO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTUSUARIO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONArray;
  FDm :TDM;
  lTUSUARIO :TUSUARIO;
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTUSUARIO := TUSUARIO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser cadastrado'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTUSUARIO.Inicia_Propriedades;

        lTUSUARIO.ID := lBody[I].GetValue<Integer>('id',0);
        lTUSUARIO.NOME := lBody[I].GetValue<String>('nome','');
        lTUSUARIO.LOGIN := lBody[I].GetValue<String>('login','');
        lTUSUARIO.SENHA := lBody[I].GetValue<String>('senha','');
        lTUSUARIO.PIN := lBody[I].GetValue<String>('pin','');
        lTUSUARIO.CELULAR := lBody[I].GetValue<String>('celular','');
        lTUSUARIO.EMAIL := lBody[I].GetValue<String>('email','');
        lTUSUARIO.SINCRONIZADO := 1;//lBody[I].GetValue<Integer>('sincronizado',0);
        lTUSUARIO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro);
        lTUSUARIO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTUSUARIO.Inserir(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('USUARIO cadastrados com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - USUARIO cadastrados com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
        TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Cadastrar USUARIO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTUSUARIO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTUSUARIO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lBody :TJSONArray; 
  FDm :TDM;
  lTUSUARIO :TUSUARIO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
 
  I:Integer; 
begin 
 
  try 
    try 
      FDm := TDM.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then 
        FDm.FDC_Servidor.StartTransaction; 
 
      lTUSUARIO := TUSUARIO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lBody := Req.Body<TJsonArray>; 
      if lBody = Nil then 
        raise Exception.Create('Não há registros para ser alterados'); 
 
      for I := 0 to (lBody.Size - 1) do 
      begin 
        lTUSUARIO.Inicia_Propriedades; 
 
        lTUSUARIO.ID := lBody[I].GetValue<Integer>('id',0); 
        lTUSUARIO.NOME := lBody[I].GetValue<String>('nome',''); 
        lTUSUARIO.LOGIN := lBody[I].GetValue<String>('login',''); 
        lTUSUARIO.SENHA := lBody[I].GetValue<String>('senha',''); 
        lTUSUARIO.PIN := lBody[I].GetValue<String>('pin',''); 
        lTUSUARIO.CELULAR := lBody[I].GetValue<String>('celular',''); 
        lTUSUARIO.EMAIL := lBody[I].GetValue<String>('email',''); 
        lTUSUARIO.DT_CADASTRO := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('dtCadastro',DateToStr(Date)),lErro); 
        lTUSUARIO.HR_CADASTRO := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('hrCadastro',DateToStr(Date)),lErro); 
        lTUSUARIO.Atualizar(lQuery); 
      end; 
 
      FDm.FDC_Servidor.Commit; 
 
      Res.Send('USUARIO alterado com sucesso').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - USUARIO alterado com sucesso'); 
 
    except on E: Exception do 
      begin 
        FDm.FDC_Servidor.Rollback; 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao Alterar USUARIO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(lTUSUARIO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      lTUSUARIO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 
 
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); 
var 
  lJson_Ret :TJSONArray; 
 
  FDm :TDM;
  lTUSUARIO :TUSUARIO; 
  lErro :String; 
 
  lQuery :TFDQuery; 
  lID :Integer;
 
begin 
  try 
    try 
      FDm := TDM.Create(Nil);
 
      lTUSUARIO := TUSUARIO.Create(FDm.FDC_Servidor); 
      lQuery := TFDQuery.Create(Nil); 
      lQuery.Connection := FDm.FDC_Servidor; 
 
      lID := StrToIntDef(Req.Query['id'],0); 
 
      lTUSUARIO.Excluir(lQuery,lID); 
 
      Res.Send('USUARIO excluído').Status(200); 
      TFuncoes.Gravar_Hitorico(lQuery,' - USUARIO excluído'); 
    except on E: Exception do 
      begin 
        Res.Send(E.Message).Status(500); 
      TFuncoes.Gravar_Hitorico(lQuery,' - Erro ao excluir o USUARIO: ' + E.Message); 
      end; 
    end; 
  finally 
    {$IFDEF MSWINDOWS} 
      FreeAndNil(lQuery); 
      FreeAndNil(FDm); 
      FreeAndNil(lTUSUARIO); 
    {$ELSE} 
      lQuery.DisposeOf; 
      FDm.DisposeOf; 
      lTUSUARIO.DisposeOf; 
    {$ENDIF} 
  end; 
end; 

procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBody :TJSONObject;
  lJson_Ret :TJSONObject;
  lJsonValida_Ret :TJSONArray;

  FDm :TDM;
  lTUsuario :TUsuario;
  lErro :String;

  lQuery :TFDQuery;
  lQuery_Hist :TFDQuery;

  I :Integer;
  lId :Integer;

  lUsuario :String;
  lSenha :String;
  lPin :String;
begin
  try
    try
      FDm := TDM.Create(Nil);

      lTUsuario := TUsuario.Create(FDm.FDC_Servidor);
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := FDm.FDC_Servidor;
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := FDm.FDC_Servidor;

      lBody := Req.Body<TJSONObject>;
      if lBody = Nil then
        raise Exception.Create('Não há informações para o Login');

      lUsuario := '';
      lSenha := '';
      lPin := '';

      {$Region 'Verifica se há usuários cadastrados no banco de dados'}
        lJsonValida_Ret := lTUsuario.Listar(lQuery);
        if lJsonValida_Ret.Size = 0  then
        begin
          Res.Send('Não há usuários cadastrados').Status(204);
          TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login. Não há usuários cadastrados');
          Exit;
        end;
      {$EndRegion 'Verifica se há usuários cadastrados no banco de dados'}

      lUsuario := lBody.GetValue<String>('login','');
      lSenha := lBody.GetValue<String>('senha','');
      lPin := lBody.GetValue<String>('pin','');

      lJson_Ret := lTUsuario.ValidaLogin(lQuery,lUsuario,lSenha,lPin);

      if lJson_Ret.Size = 0  then
      begin
        Res.Send('Login não autorizado').Status(401);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login não autorizado');
      end
      else
      begin
        lId := 0;
        lId := lJson_Ret.GetValue<integer>('id',0);
        if lId = 0 then
        begin
          Res.Send('Login não autorizado').Status(401);
          TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login não autorizado');
        end
        else
        begin
          lJson_Ret.AddPair('tokenAuth',Criar_Token(lId));
          Res.Send(lJson_Ret).Status(200);
          TFuncoes.Gravar_Hitorico(lQuery_Hist,'Login efetuado com sucesso');
        end;
      end;

    except on E: Exception do
      begin
        FDm.FDC_Servidor.Rollback;
        Res.Send(E.Message).Status(500);
        TFuncoes.Gravar_Hitorico(lQuery_Hist,'Erro ao efetuar o login: ' + E.Message);
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
      FreeAndNil(lQuery_Hist);
      FreeAndNil(FDm);
      FreeAndNil(lTUsuario);
    {$ELSE}
      lQuery.DisposeOf;
      lQuery_Hist.DisposeOf;
      DM_Lanchonete.DisposeOf;
      lTUsuario.DisposeOf;
    {$ENDIF}
  end;
end;

end. 
