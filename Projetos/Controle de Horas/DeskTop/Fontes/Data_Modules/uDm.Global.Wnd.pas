unit uDm.Global.Wnd;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,

  IniFiles,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Comp.UI;

type
  TDM_Global_Wnd = class(TDataModule)
    FDConnection: TFDConnection;
    FDTransaction: TFDTransaction;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    Firebird_Erro: String;
    Firebird_Conectado: Boolean;

    procedure Conectar_Banco;
  end;

var
  DM_Global_Wnd: TDM_Global_Wnd;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDataModule1 }

procedure TDM_Global_Wnd.Conectar_Banco;
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

  FDConnection.Connected   := False;
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

      FDConnection.LoginPrompt := False;
      FDConnection.Params.Clear;
      FDConnection.Params.Add('Database=' + lDatabase);
      FDConnection.Params.Add('User_Name=' + lUser_Name);
      FDConnection.Params.Add('Password=' + lPassword);
      FDConnection.Params.Add('Protocol=' + lProtocol);
      FDConnection.Params.Add('Port=' + lPort);
      FDConnection.Params.Add('Server=' + lServer);
      FDConnection.Params.Add('DriverID=' + lDriverID);

      //if IniFile.ReadString('BANDO_FIREBIRD','VERSAO','') = 'FIREBIRD 2.1' then
      //begin
      //  FDP_Firebired.VendorLib := '';
      //  FDP_Firebired.VendorLib := IniFile.ReadString('BANDO_FIREBIRD','LIBRARY','');
      //end;

      FDConnection.Connected := True;
      Firebird_Conectado := FDConnection.Connected;

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

procedure TDM_Global_Wnd.DataModuleCreate(Sender: TObject);
begin
  Conectar_Banco;
end;

end.
