unit uDM.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  System.IOUtils,


  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDM_Global = class(TDataModule)
    FDC_SQLite: TFDConnection;
    FDP_SQLite: TFDPhysSQLiteDriverLink;
    FDQ_Select: TFDQuery;
    FDQ_Insert: TFDQuery;
    FDQ_Delete: TFDQuery;
    FDQ_Update: TFDQuery;
    FDQ_Estrutura: TFDQuery;
    FDQ_Usuario: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQConfig: TFDQuery;
    FDT_SQLite: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_Global: TDM_Global;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM_Global.DataModuleCreate(Sender: TObject);
begin

  FDC_SQLite.Connected := False;
  FDC_SQLite.Params.Values['DriverID'] := 'SQLite';
  {$IFDEF ANDROID}
    FDC_SQLite.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath,'ControleHoras.s3db');
  {$ENDIF}

end;

end.
