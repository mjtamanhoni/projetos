unit uPesq_FormaCond_Pagto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uFuncoes,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.dxGrid,
  FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization, FMX.Edit, FMX.ListBox, FMX.TabControl, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TExecuteOnClose = procedure(AId,AId_Forma,AId_Condicao:Integer; ADesc_Forma,ADesc_Condicao:String) of Object;

  TfrmPesq_FormaCond_Pagto = class(TForm)
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctIncluir: TRectangle;
    imgIncluir: TImage;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    lytFiltro: TLayout;
    rctFiltro: TRectangle;
    edFiltro: TEdit;
    lytFiltro_Tit: TLabel;
    lytLista: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_FORMA_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_CONDICAO_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1FORMA_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1CONDICAO_PAGAMENTO: TdxfmGridColumn;
    FDQRegistrosid: TIntegerField;
    FDQRegistrosid_forma_pagamento: TIntegerField;
    FDQRegistrosid_condicao_pagamento: TIntegerField;
    FDQRegistrosdt_cadastro: TDateField;
    FDQRegistroshr_cadastro: TTimeField;
    FDQRegistrosforma_pagamento: TWideStringField;
    FDQRegistroscondicao_pagamento: TWideStringField;
    procedure imgFecharClick(Sender: TObject);
    procedure edFiltroChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FDm_Global :TDM_Global;

    procedure TThreadEnd_ListarRegistros(Sender: TOBject);
    procedure Listar_Registros;

  public
    ExecuteOnClose :TExecuteOnClose;
  end;

var
  frmPesq_FormaCond_Pagto: TfrmPesq_FormaCond_Pagto;

implementation

{$R *.fmx}

{ TfrmPesq_FormaCond_Pagto }

procedure TfrmPesq_FormaCond_Pagto.edFiltroChange(Sender: TObject);
begin
  Listar_Registros;
end;

procedure TfrmPesq_FormaCond_Pagto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmPesq_FormaCond_Pagto := Nil;

end;

procedure TfrmPesq_FormaCond_Pagto.FormCreate(Sender: TObject);
begin
  lytFormulario.Align := TAlignLayout.Center;

  FFancyDialog := TFancyDialog.Create(frmPesq_FormaCond_Pagto);
  FDm_Global := TDM_Global.Create(Nil);
  FDQRegistros.Connection := FDm_Global.FDC_Firebird;

  Listar_Registros;

end;

procedure TfrmPesq_FormaCond_Pagto.imgFecharClick(Sender: TObject);
begin
  ExecuteOnClose(
    FDQRegistros.FieldByName('ID').AsInteger
    ,FDQRegistros.FieldByName('ID_FORMA_PAGAMENTO').AsInteger
    ,FDQRegistros.FieldByName('ID_CONDICAO_PAGAMENTO').AsInteger
    ,FDQRegistros.FieldByName('FORMA_PAGAMENTO').AsString
    ,FDQRegistros.FieldByName('CONDICAO_PAGAMENTO').AsString);

  Close;
end;

procedure TfrmPesq_FormaCond_Pagto.Listar_Registros;
var
  t :TThread;
begin
  TLoading.Show(frmPesq_FormaCond_Pagto,'Filtrando registros...');
  FDQRegistros.DisableControls;

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    FDQRegistros.Active;
    FDQRegistros.SQL.Clear;
    FDQRegistros.SQL.Add('SELECT ');
    FDQRegistros.SQL.Add('  FCP.* ');
    FDQRegistros.SQL.Add('  ,FP.DESCRICAO AS FORMA_PAGAMENTO ');
    FDQRegistros.SQL.Add('  ,CP.DESCRICAO AS CONDICAO_PAGAMENTO ');
    FDQRegistros.SQL.Add('FROM FORMA_CONDICAO_PAGAMENTO FCP ');
    FDQRegistros.SQL.Add('  JOIN FORMA_PAGAMENTO FP ON FP.ID = FCP.ID_FORMA_PAGAMENTO ');
    FDQRegistros.SQL.Add('  JOIN CONDICAO_PAGAMENTO CP ON CP.ID = FCP.ID_CONDICAO_PAGAMENTO ');
    FDQRegistros.SQL.Add('WHERE NOT FCP.ID IS NULL ');
    if Trim(edFiltro.Text) <> '' then
      FDQRegistros.SQL.Add('  AND FP.DESCRICAO LIKE ' + QuotedStr('%'+edFiltro.Text+'%'));
    FDQRegistros.SQL.Add('ORDER BY ');
    FDQRegistros.SQL.Add('  FCP.ID_FORMA_PAGAMENTO ');
    FDQRegistros.SQL.Add('  ,FCP.ID_CONDICAO_PAGAMENTO; ');
    FDQRegistros.Active := True;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      FDQRegistros.EnableControls;
    end);
  end);

  t.OnTerminate := TThreadEnd_ListarRegistros;
  t.Start;
end;

procedure TfrmPesq_FormaCond_Pagto.TThreadEnd_ListarRegistros(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Total horas pagas. ' + Exception(TThread(Sender).FatalException).Message)

end;

end.
