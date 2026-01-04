unit uDmEmissor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset, ZAbstractRODataset;

type

  { TDM_Emissor }

  TDM_Emissor = class(TDataModule)
    Conexao: TZConnection;
    Transacao: TZTransaction;
    ZQuery: TZQuery;
    ZQueryativo: TSmallintField;
    ZQuerydata_cadastro: TDateTimeField;
    ZQueryemail: TStringField;
    ZQueryid_perfil: TLongintField;
    ZQueryid_usuario: TLongintField;
    ZQuerylogin: TStringField;
    ZQuerynome: TStringField;
    ZQuerysenha: TStringField;
    ZQueryultimo_acesso: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
  private
    function ConnectPostgresFromIni(const IniFileName: string): TZConnection;
  public

  end;

var
  DM_Emissor: TDM_Emissor;

implementation

{$R *.lfm}

{ TDM_Emissor }

procedure TDM_Emissor.DataModuleCreate(Sender: TObject);
var
  Conn: TZConnection;
begin
  Conn := ConnectPostgresFromIni('dbconfig.ini');
  if Conn.Connected then
    WriteLn('Conexão estabelecida com sucesso!')
  else
    WriteLn('Falha na conexão.');

end;
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

end.

