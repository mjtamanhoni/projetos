unit DM.ContHoras;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.IOUtils,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  uFuncoes,
  IniFiles,
  uModel.Usuario,

  DataSet.Serialize,
  RESTRequest4D;

type
  TDM_ConrHoras = class(TDataModule)
    FDC_Conexao: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQ_Select: TFDQuery;
    FDQ_Insert: TFDQuery;
    FDQ_Update: TFDQuery;
    FDQ_Delete: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQ_Usuario: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FConexao :String;
    FIniFile :TIniFile;
    FEnder :String;

    lTUSUARIO :TUSUARIO;

  public
    {$Region 'Sincronizar'}
      function Sinc_Usuario:TJSONObject;
    {$EndRegion 'Sincronizar'}
  end;

var
  DM_ConrHoras: TDM_ConrHoras;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDM_ConrHoras }

procedure TDM_ConrHoras.DataModuleCreate(Sender: TObject);
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONT_HORA.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONT_HORA.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FDC_Conexao.Connected := False;
  FDC_Conexao.Params.Values['DriverID'] := 'SQLite';
  {$IFDEF ANDROID}
    FDC_Conexao.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath,'\CONTROLE_HORAS.S3DB');
  {$ENDIF}
  FDC_Conexao.Connected := True;

  lTUSUARIO := TUSUARIO.Create(FDC_Conexao);
end;

function TDM_ConrHoras.Sinc_Usuario: TJSONObject;
var
  lQuery :TFDQuery;
  lHost :String;
  lResp :IResponse;
  lJson :TJSONArray;

begin
  try
    try
      //if not TFuncoes.TestaConexao(FConexao) then
      //  raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := FDC_Conexao;

      lQuery.Active := False;
      lQuery.Sql.Clear;
      lQuery.Sql.Add('SELECT * FROM USUARIO U WHERE U.SINCRONIZADO = 0;');
      lQuery.Active := True;
      if not lQuery.IsEmpty then
      begin
        lJson := lQuery.ToJSONArray;

        lHost := FIniFile.ReadString('SERVIDOR','URL','');
        if lHost = '' then
          lHost := 'http://localhost:3002';

        if lHost = '' then
          raise Exception.Create('Necessário informar o Host...');

        lResp := TRequest.New.BaseURL(lHost)
                 .Resource('usuario')
                 .AddBody(lJson)
                 .Accept('application/json')
                 .Post;

        if lResp.StatusCode = 200 then
        begin
          Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONObject;
          lQuery.Active := False;
          lQuery.SQL.Clear;;
          lTUSUARIO.Marcar_Como_Sincronizado(lQuery);
        end
        else
          raise Exception.Create(lResp.Content);

      end
      else
        raise Exception.Create('Não há usuários para sincronizar');

    except on E: Exception do
      raise Exception.Create('Sinc. Usuario: ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;

end;

end.
