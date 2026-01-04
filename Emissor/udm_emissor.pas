unit uDm_Emissor;

{ Copyright 2026 / 2027 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Classes, SysUtils, Controls, Graphics, Dialogs, StdCtrls, ZConnection, IniFiles;

type

  { TDM_Emissor }

  TDM_Emissor = class(TDataModule)
    Conexao: TZConnection;
    Transacao: TZTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    FConectado: Boolean;
  private
    property Conectado :Boolean read FConectado write FConectado;

    function ConnectPostgresFromIni(const IniFileName: string): TZConnection;

  published
    class procedure CreateInstance;
    procedure DestroyInstance;
  public
    { Public declarations }
  end;

function DM_Emissor: TDM_Emissor;

implementation

uses
  D2Bridge.Instance, EmissorWebApp;

{$R *.lfm}

procedure TDM_Emissor.DataModuleCreate(Sender: TObject);
begin
  Conexao := ConnectPostgresFromIni('dbconfig.ini');
  FConectado := Conexao.Connected;
end;

function TDM_Emissor.ConnectPostgresFromIni(const IniFileName: string ): TZConnection;
var
  Ini: TIniFile;
  Conn: TZConnection;
begin
  Ini := TIniFile.Create(IniFileName);
  Conn := TZConnection.Create(nil);
  try
    Conn.Protocol := 'postgresql'; // protocolo Zeos
    Conn.HostName := Ini.ReadString('Database', 'Host', 'localhost');
    Conn.Port     := Ini.ReadInteger('Database', 'Port', 5432);
    Conn.Database := Ini.ReadString('Database', 'Database', '');
    Conn.User     := Ini.ReadString('Database', 'User', '');
    Conn.Password := Ini.ReadString('Database', 'Password', '');

    Conn.LoginPrompt := False;

    Conn.Connect; // tenta conectar

    Result := Conn; // retorna conexão já aberta
  finally
    Ini.Free;
  end;
end;

class procedure TDM_Emissor.CreateInstance;
begin
  D2BridgeInstance.CreateInstance(self);
end;

function DM_Emissor: TDM_Emissor;
begin
  result:= (D2BridgeInstance.GetInstance(TDM_Emissor) as TDM_Emissor);
end;

procedure TDM_Emissor.DestroyInstance;
begin
  D2BridgeInstance.DestroyInstance(self);
end;

end.
