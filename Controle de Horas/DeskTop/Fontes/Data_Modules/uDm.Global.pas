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
