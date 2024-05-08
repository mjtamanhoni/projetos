unit DM.Email;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Comp.UI,
  FireDAC.Phys.IBBase;

type
  TDM_Email = class(TDataModule)
    FDC_Firebird: TFDConnection;
    FDT_Firebird: TFDTransaction;
    FDP_Firebired: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQ_Select: TFDQuery;
    FDQ_Insert: TFDQuery;
    FDQ_Update: TFDQuery;
    FDQ_Delete: TFDQuery;
    FDQ_Sequencia: TFDQuery;
    FDMT_BancoDados: TFDMemTable;
    FDMT_BancoDadosid: TIntegerField;
    FDMT_BancoDadosversao: TIntegerField;
    FDMT_BancoDadosservidor: TStringField;
    FDMT_BancoDadosporta: TIntegerField;
    FDMT_BancoDadosbanco: TStringField;
    FDMT_BancoDadosusuario: TStringField;
    FDMT_BancoDadossenha: TStringField;
    FDMT_BancoDadosbiblioteca: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_Email: TDM_Email;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
