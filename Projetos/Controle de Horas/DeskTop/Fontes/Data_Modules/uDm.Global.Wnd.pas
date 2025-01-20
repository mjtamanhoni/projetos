unit uDm.Global.Wnd;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,

  IniFiles,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.Comp.DataSet;

type
  TDM_Global_Wnd = class(TDataModule)
    FDConnectionF: TFDConnection;
    FDTransaction: TFDTransaction;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQ_SelectP: TFDQuery;
    FDConnectionP: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    Firebird_Erro: String;
    Banco_Conectado: Boolean;

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
  FEnder   :String;

  FDatabase :String;
  FUser_Name :String;
  FPassword :String;
  FProtocol :String;
  FPort :String;
  FServer :String;
  FDriverID :String;
  FSchemaName :String;
  FLibrary :String;

begin
  Banco_Conectado := True;
  Firebird_Erro := '';

  try
    try
      FEnder  := '';
      FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';

      if not FileExists(FEnder) then
        Exit;
      IniFile := TIniFile.Create(FEnder);

      if IniFile.ReadString('BANDO_FIREBIRD','BANCO','') = '' then
        Exit;

      if not FileExists(IniFile.ReadString('BANDO_FIREBIRD','BANCO','')) then
        Exit;

      FDatabase := '';
      FUser_Name := '';
      FPassword := '';
      FProtocol := '';
      FPort := '';
      FServer := '';
      FDriverID := '';
      FSchemaName := '';
      FLibrary := '';

      case IniFile.ReadInteger('BANDO','USADO.ID',0) of
        0:begin
          {$Region 'Pegando informações Banco Firebird'}
            FDatabase := IniFile.ReadString('BANDO_FIREBIRD','BANCO','');
            FUser_Name := IniFile.ReadString('BANDO_FIREBIRD','USUARIO','');
            FPassword := IniFile.ReadString('BANDO_FIREBIRD','SENHA','');
            FServer := IniFile.ReadString('BANDO_FIREBIRD','SERVIDOR','');
            if FServer = 'LOCALHOST' then
              FProtocol := 'LOCAL'
            else
              FProtocol := 'TCPIP';
            FPort := IniFile.ReadString('BANDO_FIREBIRD','PORTA','');
            FDriverID := 'FB';

            FDConnectionF.Connected   := False;
            FDConnectionF.LoginPrompt := False;
            FDConnectionF.Params.Clear;
            FDConnectionF.Params.Add('Database=' + FDatabase);
            FDConnectionF.Params.Add('User_Name=' + FUser_Name);
            FDConnectionF.Params.Add('Password=' + FPassword);
            FDConnectionF.Params.Add('Protocol=' + FProtocol);
            FDConnectionF.Params.Add('Port=' + FPort);
            FDConnectionF.Params.Add('Server=' + FServer);
            FDConnectionF.Params.Add('DriverID=' + FDriverID);
            FDConnectionF.Connected := True;
          {$EndRegion 'Pegando informações Banco Firebird'}
        end;
        1:begin
          FDriverID := IniFile.ReadString('BANDO.POSTGRESQL','DRIVER','');
          FServer := IniFile.ReadString('BANDO.POSTGRESQL','SERVER','');
          FPort := IniFile.ReadString('BANDO.POSTGRESQL','PORT','');
          FDatabase := IniFile.ReadString('BANDO.POSTGRESQL','DATABASE','');
          FUser_Name := IniFile.ReadString('BANDO.POSTGRESQL','USER_NAME','');
          FPassword := IniFile.ReadString('BANDO.POSTGRESQL','PASSWORD','');
          FSchemaName := IniFile.ReadString('BANDO.POSTGRESQL','SCHEMANAME','');
          FLibrary := IniFile.ReadString('BANDO.POSTGRESQL','VENDOR_LIB','');

          FDConnectionP.Connected   := False;
          FDConnectionP.LoginPrompt := False;
          FDConnectionP.Params.Clear;
          FDConnectionP.DriverName := 'PG';
          FDConnectionP.Params.Add('Server=' + FServer);
          FDConnectionP.Params.Add('Port=' + FPort);
          FDConnectionP.Params.Add('Database=' + FDatabase);
          FDConnectionP.Params.Add('User_Name=' + FUser_Name);
          FDConnectionP.Params.Add('Password=' + FPassword);
          FDConnectionP.Params.Add('SchemaName=' + FSchemaName);
          FDPhysPgDriverLink.VendorLib := FLibrary;
          FDConnectionP.Connected := True;
        end;
      end;

      Banco_Conectado := FDConnectionF.Connected;

      if not Banco_Conectado then
      begin
        Firebird_Erro := Firebird_Erro + FServer + ' - ' +  FPort + sLineBreak;
        Firebird_Erro := Firebird_Erro + FUser_Name + sLineBreak;
        Firebird_Erro := Firebird_Erro + FPassword + sLineBreak;
        Firebird_Erro := Firebird_Erro + FDatabase;
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
