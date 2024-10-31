unit uDm.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase, System.ImageList, FMX.ImgList, FireDAC.FMXUI.Wait,
  IniFiles;

type
  TDM_Global = class(TDataModule)
    FDC_Firebird: TFDConnection;
    FDT_Firebird: TFDTransaction;
    FDP_Firebired: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQ_Select: TFDQuery;
    FDQ_Insert: TFDQuery;
    FDQ_Update: TFDQuery;
    FDQ_Delete: TFDQuery;
    FDQ_Sequencia: TFDQuery;
    imRegistros: TImageList;
    FDQ_DadosUsuarios: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Firebird_Erro: String;
    Firebird_Conectado: Boolean;

    procedure Conectar_Banco;
    function Valida_Pin(APin :String):Boolean;

    {$Region 'Listar Dados'}
      procedure Listar_Usuarios(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_Empresa(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_Cliente(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_Fornecedor(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_TabelaPrecos(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_PrestadorServico(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_Contas(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_FormaPagto(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
      procedure Listar_CondPagto(ACodigo:Integer; ANome:String; out FDQuery:TFDQuery);
    {$EndRegion 'Listar Dados'}

  end;

var
  DM_Global: TDM_Global;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM_Global.Conectar_Banco;
var
  IniFile  :TIniFile;
  lEnder   :String;

  lDatabase :String;
  lUser_Name :String;
  lPassword :String;
  lProtocol :String;
  lPort :String;
  lServer :String;
  lDriverID :String;
begin
  Firebird_Conectado := True;
  Firebird_Erro := '';

  FDC_Firebird.Connected   := False;
  try
    try
      lEnder  := '';
      lEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';

      if not FileExists(lEnder) then
        Exit;
      IniFile := TIniFile.Create(lEnder);

      if IniFile.ReadString('BANDO_FIREBIRD','BANCO','') = '' then
        Exit;

      if not FileExists(IniFile.ReadString('BANDO_FIREBIRD','BANCO','')) then
        Exit;

      {$Region 'Pegando informações do arquivo INI'}
        lDatabase := '';
        lUser_Name := '';
        lPassword := '';
        lProtocol := '';
        lPort := '';
        lServer := '';
        lDriverID := '';

        lDatabase := IniFile.ReadString('BANDO_FIREBIRD','BANCO','');
        lUser_Name := IniFile.ReadString('BANDO_FIREBIRD','USUARIO','');
        lPassword := IniFile.ReadString('BANDO_FIREBIRD','SENHA','');
        lServer := IniFile.ReadString('BANDO_FIREBIRD','SERVIDOR','');
        if lServer = 'LOCALHOST' then
          lProtocol := 'LOCAL'
        else
          lProtocol := 'TCPIP';
        lPort := IniFile.ReadString('BANDO_FIREBIRD','PORTA','');
        lDriverID := 'FB';
      {$EndRegion 'Pegando informações do arquivo INI'}

      FDC_Firebird.LoginPrompt := False;
      FDC_Firebird.Params.Clear;
      FDC_Firebird.Params.Add('Database=' + lDatabase);
      FDC_Firebird.Params.Add('User_Name=' + lUser_Name);
      FDC_Firebird.Params.Add('Password=' + lPassword);
      FDC_Firebird.Params.Add('Protocol=' + lProtocol);
      FDC_Firebird.Params.Add('Port=' + lPort);
      FDC_Firebird.Params.Add('Server=' + lServer);
      FDC_Firebird.Params.Add('DriverID=' + lDriverID);

      //if IniFile.ReadString('BANDO_FIREBIRD','VERSAO','') = 'FIREBIRD 2.1' then
      //begin
      //  FDP_Firebired.VendorLib := '';
      //  FDP_Firebired.VendorLib := IniFile.ReadString('BANDO_FIREBIRD','LIBRARY','');
      //end;

      FDC_Firebird.Connected := True;
      Firebird_Conectado := FDC_Firebird.Connected;

      if not Firebird_Conectado then
      begin
        Firebird_Erro := Firebird_Erro + lServer + ' - ' +  lPort + sLineBreak;
        Firebird_Erro := Firebird_Erro + lUser_Name + sLineBreak;
        Firebird_Erro := Firebird_Erro + lPassword + sLineBreak;
        Firebird_Erro := Firebird_Erro + lDatabase;
      end
      else
        Firebird_Erro := Firebird_Erro + ' Conectado';
    except
      On Ex:Exception do
      begin
        if (Ex is EDatabaseError) then
        begin
          Firebird_Erro := Firebird_Erro + sLineBreak + Ex.Message;
          raise Exception.Create(Ex.Message);
        end
        else
        begin
          Firebird_Erro := Firebird_Erro + sLineBreak + Ex.Message;
          raise Exception.Create(Ex.Message);
        end;
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(IniFile);
    {$ELSE}
      IniFile.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TDM_Global.DataModuleCreate(Sender: TObject);
begin
  Conectar_Banco;
end;

procedure TDM_Global.Listar_Cliente(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  C.* ');
      FDQuery.Sql.Add('FROM CLIENTE C ');
      FDQuery.Sql.Add('WHERE NOT C.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND C.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND C.NOME LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  C.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Cliente: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_CondPagto(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  CP.* ');
      FDQuery.Sql.Add('FROM CONDICAO_PAGAMENTO CP ');
      FDQuery.Sql.Add('WHERE NOT CP.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND CP.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND CP.DESCRICAO LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  CP.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Condições de Pagamento: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_Contas(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  C.* ');
      FDQuery.Sql.Add('FROM CONTA C ');
      FDQuery.Sql.Add('WHERE NOT C.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND C.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND C.DESCRICAO LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  C.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Conta: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_Empresa(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  E.* ');
      FDQuery.Sql.Add('FROM EMPRESA E ');
      FDQuery.Sql.Add('WHERE NOT E.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND E.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND E.NOME LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  E.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Empresa: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_FormaPagto(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  FP.* ');
      FDQuery.Sql.Add('FROM FORMA_PAGAMENTO FP ');
      FDQuery.Sql.Add('WHERE NOT FP.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND FP.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND FP.DESCRICAO LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  FP.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Formas de Pagamento: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_Fornecedor(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  F.* ');
      FDQuery.Sql.Add('FROM FORNECEDOR F ');
      FDQuery.Sql.Add('WHERE NOT F.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND F.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND F.NOME LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  F.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Fornecedores: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_PrestadorServico(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  PS.* ');
      FDQuery.Sql.Add('FROM PRESTADOR_SERVICO PS ');
      FDQuery.Sql.Add('WHERE NOT PS.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND PS.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND PS.NOME LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  PS.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Prestador de Serviço: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_TabelaPrecos(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  TP.* ');
      FDQuery.Sql.Add('  ,CASE TP.TIPO ');
      FDQuery.Sql.Add('    WHEN 0 THEN ''HORAS'' ');
      FDQuery.Sql.Add('    WHEN 1 THEN ''FIXO'' ');
      FDQuery.Sql.Add('  END TABELA_TIPO ');
      FDQuery.Sql.Add('FROM TABELA_PRECO TP ');
      FDQuery.Sql.Add('WHERE NOT TP.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND TP.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND TP.DESCRICAO LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  TP.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Tabela de Preços: ' + E.Message);
    end;
  finally
  end;
end;

procedure TDM_Global.Listar_Usuarios(ACodigo: Integer; ANome: String; out FDQuery: TFDQuery);
begin
  try
    try
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.Sql.Clear;
      FDQuery.Sql.Add('SELECT ');
      FDQuery.Sql.Add('  U.* ');
      FDQuery.Sql.Add('FROM USUARIO U ');
      FDQuery.Sql.Add('WHERE NOT U.ID IS NULL ');
      if ACodigo > 0 then
        FDQuery.Sql.Add('  AND U.ID = ' + ACodigo.ToString);
      if Trim(ANome) <> '' then
        FDQuery.Sql.Add('  AND U.NOME LIKE ' + QuotedStr('%' + ANome + '%'));
      FDQuery.Sql.Add('ORDER BY ');
      FDQuery.Sql.Add('  U.ID; ');
      FDQuery.Active := True;
    except on E: Exception do
      raise Exception.Create('Listar Usuário: ' + E.Message);
    end;
  finally
  end;
end;

function TDM_Global.Valida_Pin(APin: String): Boolean;
var
  FDQuery :TFDQuery;
begin
  try
    try
      Result := False;
      FDQuery := TFDQuery.Create(Nil);
      FDQuery.Connection := FDC_Firebird;
      FDQuery.Active := False;
      FDQuery.SQL.Clear;
      FDQuery.SQL.Add('SELECT ');
      FDQuery.SQL.Add('  U.* ');
      FDQuery.SQL.Add('FROM USUARIO U ');
      FDQuery.SQL.Add('WHERE U.PIN = ' + QuotedStr(APin));
      FDQuery.Active := True;
      if FDQuery.IsEmpty then
        raise Exception.Create('PIN Inválido')
      else
        Result := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
