unit uDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,

  DataSet.Serialize.Config, DataSet.Serialize,

  IniFiles;

type
  TdmSpedContribuicoes = class(TDataModule)
    FDC_Sped: TFDConnection;
    FDT_Sped: TFDTransaction;
    FDP_Servidor: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQ_Select: TFDQuery;
    FDQ_Insert: TFDQuery;
    FDQ_Update: TFDQuery;
    FDQ_Delete: TFDQuery;
    FDQ_Sequencia: TFDQuery;
    FDScript1: TFDScript;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDC_SpedBeforeConnect(Sender: TObject);
  private
    FEnder :String;
    lEnder_Ini :String;
    FIniFile :TIniFile;

    procedure CarregarConfigDB(Connection: TFDConnection);
  public
    { Public declarations }
  end;

var
  dmSpedContribuicoes: TdmSpedContribuicoes;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmSpedContribuicoes }

procedure TdmSpedContribuicoes.CarregarConfigDB(Connection: TFDConnection);
var
  lEnder_Ini :String;

  lDatabase :String;
  lUser_Name :String;
  lPassword :String;
  lProtocol :String;
  lPort :String;
  lServer :String;
  lDriverID :String;
  lBiblioteca :String;
  lVersao :Integer;

begin

  FDC_Sped.Connected := False;

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_SCONT.INI';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_SCONT.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  try
    lDatabase := '';
    lUser_Name := '';
    lPassword := '';
    lProtocol := '';
    lPort := '';
    lServer := '';
    lDriverID := '';
    lBiblioteca := '';
    lVersao := -1;

    lDatabase := FIniFile.ReadString('FIREBIRD','BANCO','');
    lUser_Name := FIniFile.ReadString('FIREBIRD','USUARIO','');
    lPassword := FIniFile.ReadString('FIREBIRD','SENHA','');
    lServer := FIniFile.ReadString('FIREBIRD','SERVIDOR','');
    if lServer = 'LOCALHOST' then
      lProtocol := 'LOCAL'
    else
      lProtocol := 'TCPIP';
    lPort := FIniFile.ReadString('FIREBIRD','PORTA','');
    lDriverID := 'FB';
    lBiblioteca := FIniFile.ReadString('FIREBIRD','BIBLIOTECA','');
    lVersao := FIniFile.ReadInteger('FIREBIRD','VERSAO',-1); //0-2.1, 1-3.0

    Connection.LoginPrompt := False;
    Connection.Params.Clear;
    Connection.Params.Add('Database=' + lDatabase);
    Connection.Params.Add('User_Name=' + lUser_Name);
    Connection.Params.Add('Password=' + lPassword);
    Connection.Params.Add('Protocol=' + lProtocol);
    Connection.Params.Add('Port=' + lPort);
    Connection.Params.Add('Server=' + lServer);
    Connection.Params.Add('DriverID=' + lDriverID);

    if lVersao = 0 then
    begin
      FDP_Servidor.VendorLib := '';
      FDP_Servidor.VendorLib := lBiblioteca;
    end;
  except
    On Ex:Exception do
      raise Exception.Create(Ex.Message);
  end;
end;

procedure TdmSpedContribuicoes.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  FDC_Sped.Connected := True;
end;

procedure TdmSpedContribuicoes.FDC_SpedBeforeConnect(Sender: TObject);
begin
  CarregarConfigDB(FDC_Sped);
end;

end.
