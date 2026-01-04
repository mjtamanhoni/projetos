unit uDM_Emissor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConn_Emissor;

type

  { TDM_Emissor }

  TDM_Emissor = class(TDataModule)
    ZConn_Emissor: TZConnection;
    ZQuery1: TZQuery;
    ZTrans_Emissor: TZTransaction;
    procedure ZConn_EmissorAfterConnect(Sender: TObject);
  private

  public
    function ConectarPostgres: TZConnection;

  end;

var
  DM_Emissor: TDM_Emissor;

implementation

{$R *.lfm}

{ TDM_Emissor }

procedure TDM_Emissor.ZConn_EmissorAfterConnect(Sender: TObject);
begin

end;

function TDM_Emissor.ConectarPostgres: TZConnection;
begin
  Result := TZConnection.Create(nil);
  try
    Result.Protocol := 'postgresql-7';   // ou 'postgresql-9' dependendo da versão
    Result.HostName := 'localhost';      // endereço do servidor
    Result.Port := 5432;                 // porta padrão do PostgreSQL
    Result.Database := 'emissor';      // nome do banco
    Result.User := 'postegres';        // usuário
    Result.Password := 'Cs@#1519';    // senha
    Result.LoginPrompt := False;         // evita prompt de login
    Result.Connected := True;            // abre a conexão
  except
    on E: Exception do
    begin
      Writeln('Erro ao conectar: ', E.Message);
      FreeAndNil(Result);
    end;
  end;
end;


end.

