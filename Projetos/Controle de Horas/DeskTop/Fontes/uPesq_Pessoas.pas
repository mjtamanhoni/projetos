unit uPesq_Pessoas;

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
  FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.ListBox;

type
  TExecuteOnClose = procedure(ATipo:String; Aid:Integer; ANome:String; ADocumento:String) of Object;

  TfrmPesq_Pessoas = class(TForm)
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
    lytFiltro_Tipo: TLayout;
    rctFiltro_Tipo: TRectangle;
    lbFiltro_Tipo: TLabel;
    lytFiltro_Pessoa: TLayout;
    rctFiltro_Pessoa: TRectangle;
    edFiltro_Pessoa: TEdit;
    edFiltro_Pessoa_ID: TEdit;
    lytFiltro_Pessoa_Tit: TLabel;
    lytLista: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    cbFiltro_Tipo: TComboBox;
    FDQRegistrosTIPO: TStringField;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosNOME: TStringField;
    FDQRegistrosPESSOA: TIntegerField;
    FDQRegistrosDOCUMENTO: TStringField;
    FDQRegistrosINSC_EST: TStringField;
    FDQRegistrosENDERECO: TStringField;
    FDQRegistrosCOMPLEMENTO: TStringField;
    FDQRegistrosNUMERO: TStringField;
    FDQRegistrosBAIRRO: TStringField;
    FDQRegistrosCIDADE: TStringField;
    FDQRegistrosUF: TStringField;
    FDQRegistrosTELEFONE: TStringField;
    FDQRegistrosCELULAR: TStringField;
    FDQRegistrosEMAIL: TStringField;
    FDQRegistrosID_TAB_PRECO: TIntegerField;
    dxfmGrid1RootLevel1TIPO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1NOME: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DOCUMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1INSC_EST: TdxfmGridColumn;
    dxfmGrid1RootLevel1ENDERECO: TdxfmGridColumn;
    dxfmGrid1RootLevel1COMPLEMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1NUMERO: TdxfmGridColumn;
    dxfmGrid1RootLevel1BAIRRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1CIDADE: TdxfmGridColumn;
    dxfmGrid1RootLevel1UF: TdxfmGridColumn;
    dxfmGrid1RootLevel1TELEFONE: TdxfmGridColumn;
    dxfmGrid1RootLevel1CELULAR: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMAIL: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_TAB_PRECO: TdxfmGridColumn;
    FDQRegistrosPESSOA_DESC: TStringField;
    dxfmGrid1RootLevel1PESSOA_DESC: TdxfmGridColumn;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbFiltro_TipoChange(Sender: TObject);
  private
    FTipoFiltro: Integer;
    FFancyDialog :TFancyDialog;
    FDm_Global :TDM_Global;

    procedure SetTipoFiltro(const Value: Integer);
    procedure TThreadEnd_ListarRegistros(Sender: TOBject);
    procedure Listar_Registros;

  public
    ExecuteOnClose :TExecuteOnClose;

    property TipoFiltro :Integer read FTipoFiltro write SetTipoFiltro;
  end;

var
  frmPesq_Pessoas: TfrmPesq_Pessoas;

implementation

{$R *.fmx}

procedure TfrmPesq_Pessoas.Listar_Registros;
var
  t :TThread;
begin
  TLoading.Show(frmPesq_Pessoas,'Filtrando registros...');
  FDQRegistros.DisableControls;

  t := TThread.CreateAnonymousThread(
  procedure
  begin
    FDQRegistros.Active;
    FDQRegistros.SQL.Clear;
    FDQRegistros.SQL.Add('SELECT ');
    FDQRegistros.SQL.Add('  C.TIPO ');
    FDQRegistros.SQL.Add('  ,C.ID ');
    FDQRegistros.SQL.Add('  ,C.NOME ');
    FDQRegistros.SQL.Add('  ,C.PESSOA ');
    FDQRegistros.SQL.Add('  ,C.DOCUMENTO ');
    FDQRegistros.SQL.Add('  ,C.INSC_EST ');
    FDQRegistros.SQL.Add('  ,C.ENDERECO ');
    FDQRegistros.SQL.Add('  ,C.COMPLEMENTO ');
    FDQRegistros.SQL.Add('  ,C.NUMERO ');
    FDQRegistros.SQL.Add('  ,C.BAIRRO ');
    FDQRegistros.SQL.Add('  ,C.CIDADE ');
    FDQRegistros.SQL.Add('  ,C.UF ');
    FDQRegistros.SQL.Add('  ,C.TELEFONE ');
    FDQRegistros.SQL.Add('  ,C.CELULAR ');
    FDQRegistros.SQL.Add('  ,C.EMAIL ');
    FDQRegistros.SQL.Add('  ,C.ID_TAB_PRECO ');
    FDQRegistros.SQL.Add('  ,CASE C.PESSOA ');
    FDQRegistros.SQL.Add('    WHEN 0 THEN ''FÍSICA'' ');
    FDQRegistros.SQL.Add('    WHEN 1 THEN ''JURÍDICA'' ');
    FDQRegistros.SQL.Add('  END PESSOA_DESC ');
    FDQRegistros.SQL.Add('FROM RDB$DATABASE ');
    FDQRegistros.SQL.Add('  JOIN (SELECT ');
    FDQRegistros.SQL.Add('          ''Cliente'' AS TIPO ');
    FDQRegistros.SQL.Add('          ,C.ID ');
    FDQRegistros.SQL.Add('          ,C.NOME ');
    FDQRegistros.SQL.Add('          ,C.PESSOA ');
    FDQRegistros.SQL.Add('          ,C.DOCUMENTO ');
    FDQRegistros.SQL.Add('          ,C.INSC_EST ');
    FDQRegistros.SQL.Add('          ,C.ENDERECO ');
    FDQRegistros.SQL.Add('          ,C.COMPLEMENTO ');
    FDQRegistros.SQL.Add('          ,C.NUMERO ');
    FDQRegistros.SQL.Add('          ,C.BAIRRO ');
    FDQRegistros.SQL.Add('          ,C.CIDADE ');
    FDQRegistros.SQL.Add('          ,C.UF ');
    FDQRegistros.SQL.Add('          ,C.TELEFONE ');
    FDQRegistros.SQL.Add('          ,C.CELULAR ');
    FDQRegistros.SQL.Add('          ,C.EMAIL ');
    FDQRegistros.SQL.Add('          ,C.ID_TAB_PRECO ');
    FDQRegistros.SQL.Add('        FROM CLIENTE C ');
    FDQRegistros.SQL.Add('        UNION ALL ');
    FDQRegistros.SQL.Add('        SELECT ');
    FDQRegistros.SQL.Add('          ''Fornecedor'' AS TIPO ');
    FDQRegistros.SQL.Add('          ,F.ID ');
    FDQRegistros.SQL.Add('          ,F.NOME ');
    FDQRegistros.SQL.Add('          ,F.PESSOA ');
    FDQRegistros.SQL.Add('          ,F.DOCUMENTO ');
    FDQRegistros.SQL.Add('          ,F.INSC_EST ');
    FDQRegistros.SQL.Add('          ,F.ENDERECO ');
    FDQRegistros.SQL.Add('          ,F.COMPLEMENTO ');
    FDQRegistros.SQL.Add('          ,F.NUMERO ');
    FDQRegistros.SQL.Add('          ,F.BAIRRO ');
    FDQRegistros.SQL.Add('          ,F.CIDADE ');
    FDQRegistros.SQL.Add('          ,F.UF ');
    FDQRegistros.SQL.Add('          ,F.TELEFONE ');
    FDQRegistros.SQL.Add('          ,F.CELULAR ');
    FDQRegistros.SQL.Add('          ,F.EMAIL ');
    FDQRegistros.SQL.Add('          ,0 AS ID_TAB_PRECO ');
    FDQRegistros.SQL.Add('        FROM FORNECEDOR F) C ON 1=1 ');
    FDQRegistros.SQL.Add('WHERE NOT C.ID IS NULL ');
    case cbFiltro_Tipo.ItemIndex of
      1:FDQRegistros.SQL.Add('  AND C.TIPO = ''Cliente'' ');
      2:FDQRegistros.SQL.Add('  AND C.TIPO = ''Fornecedor'' ');
    end;
    if Trim(edFiltro_Pessoa_ID.Text) <> '' then
      FDQRegistros.SQL.Add('  AND C.ID = ' + edFiltro_Pessoa_ID.Text);
    if Trim(edFiltro_Pessoa.Text) <> '' then
      FDQRegistros.SQL.Add('  AND C.NOME LIKE ' + QuotedStr('%'+edFiltro_Pessoa.Text+'%'));

    FDQRegistros.SQL.Add('ORDER BY 1,2; ');
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

procedure TfrmPesq_Pessoas.TThreadEnd_ListarRegistros(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Total horas pagas. ' + Exception(TThread(Sender).FatalException).Message)

end;

procedure TfrmPesq_Pessoas.cbFiltro_TipoChange(Sender: TObject);
begin
  Listar_Registros;
end;

procedure TfrmPesq_Pessoas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmPesq_Pessoas := Nil;
end;

procedure TfrmPesq_Pessoas.FormCreate(Sender: TObject);
begin
  lytFormulario.Align := TAlignLayout.Center;

  FFancyDialog := TFancyDialog.Create(frmPesq_Pessoas);
  FDm_Global := TDM_Global.Create(Nil);
  FDQRegistros.Connection := FDm_Global.FDC_Firebird;

  TipoFiltro := 0;
end;

procedure TfrmPesq_Pessoas.FormShow(Sender: TObject);
begin
  cbFiltro_Tipo.ItemIndex := FTipoFiltro;
end;

procedure TfrmPesq_Pessoas.imgFecharClick(Sender: TObject);
begin
  ExecuteOnClose(
    FDQRegistros.FieldByName('TIPO').AsString
    ,FDQRegistros.FieldByName('ID').AsInteger
    ,FDQRegistros.FieldByName('NOME').AsString
    ,FDQRegistros.FieldByName('DOCUMENTO').AsString);

  Close;
end;

procedure TfrmPesq_Pessoas.SetTipoFiltro(const Value: Integer);
begin
  FTipoFiltro := Value;
end;

end.
