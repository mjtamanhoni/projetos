unit uDM;

interface

uses
  System.SysUtils, System.Classes, System.JSON,

  DataSet.Serialize,
  DateUtils, System.Math,

  uFuncoes.Gerais,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  IniFiles,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TDM = class(TDataModule)
    FDTransaction: TFDTransaction;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQ_SelectP: TFDQuery;
    FDConnectionP: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Banco_Erro :String;
    Banco_Conectado: Boolean;
    IniFile  :TIniFile;
    FEnder   :String;

    procedure Conectar_Banco(AEnder:String);

    {$Region 'Usuários'}
    function Login(FPin,FUsuario,FSenha:String) :TJSONObject;
    {$EndRegion 'Usuários'}
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

procedure TDM.Conectar_Banco(AEnder:String);
var
  FDatabase :String;
  FUser_Name :String;
  FPassword :String;
  FProtocol :String;
  FPort :String;
  FServer :String;
  FDriverID :String;
  FSchemaName :String;
  FLibrary :String;

  FArquivo :String;
  I :Integer;

begin
  Banco_Conectado := True;
  Banco_Erro := '';
  FEnder  := '';
  FArquivo := '';
  //FEnder := System.SysUtils.GetCurrentDir + '\SERVICO_BANCO.ini';
  FEnder := ExtractFilePath(ParamStr(0));
  FArquivo := FEnder + 'MJT_Systems.ini';
  IniFile  := TIniFile.Create(FArquivo);

  try
    try
      if not FileExists(FArquivo) then
        raise Exception.Create('Arquivo ' + FArquivo + ' não localizado');


      FDatabase := '';
      FUser_Name := '';
      FPassword := '';
      FProtocol := '';
      FPort := '';
      FServer := '';
      FDriverID := '';
      FSchemaName := '';
      FLibrary := '';

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
      if Trim(FSchemaName) <> '' then
        FDConnectionP.Params.Add('SchemaName=' + FSchemaName);
      FDPhysPgDriverLink.VendorLib := FLibrary;
      FDConnectionP.Connected := True;

      Banco_Conectado := FDConnectionP.Connected;


      //Banco_Erro := '';
      if not Banco_Conectado then
      begin
        Banco_Erro := Banco_Erro + ' Erro' + sLineBreak;
        Banco_Erro := Banco_Erro + FServer + ' - ' +  FPort + sLineBreak;
        Banco_Erro := Banco_Erro + FUser_Name + sLineBreak;
        Banco_Erro := Banco_Erro + FPassword + sLineBreak;
        Banco_Erro := Banco_Erro + FDatabase;
        raise Exception.Create('Erro ao conectar banco PostgreSql. ' + Banco_Erro);
      end
      else
        Banco_Erro := Banco_Erro + ' Conectado';

    except
      On Ex:Exception do
      begin
        if (Ex is EDatabaseError) then
        begin
          Banco_Erro := Banco_Erro + sLineBreak + Ex.Message;
          raise Exception.Create('Erro ao conectar banco PostgreSql. ' + Banco_Erro);
        end
        else
        begin
          Banco_Erro := Banco_Erro + sLineBreak + Ex.Message;
          raise Exception.Create('Erro ao conectar banco PostgreSql. ' + Banco_Erro);
        end;
      end;
    end;
  finally
    FreeAndNil(IniFile);
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FEnder := '';
  FEnder := ExtractFilePath(ParamStr(0));
  Conectar_Banco(FEnder);
end;

function TDM.Login(FPin, FUsuario, FSenha: String): TJSONObject;
begin

end;

end.
