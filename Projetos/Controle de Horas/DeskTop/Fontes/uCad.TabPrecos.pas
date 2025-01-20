unit uCad.TabPrecos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.dxGrid, FMX.dxControlUtils,
  FMX.dxControls, FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Layouts, FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global;

type
  TTab_Status = (dsInsert,dsEdit);
  TExecuteOnClose = procedure(Aid:Integer; ADescricao:String; ATipo:Integer; AValor:Double) of Object;

  TfrmCad_TabPrecos = class(TForm)
    imgEsconteSenha: TImage;
    imgExibeSenha: TImage;
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctIncluir: TRectangle;
    imgIncluir: TImage;
    rctEditar: TRectangle;
    imgEditar: TImage;
    rctSalvar: TRectangle;
    imgSalvar: TImage;
    rctCancelar: TRectangle;
    imgCancelar: TImage;
    rctExcluir: TRectangle;
    imgExcluir: TImage;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    edPesquisar: TEdit;
    imgPesquisar: TImage;
    Layout2: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    tiCadastro: TTabItem;
    lytConfig: TLayout;
    lytRow_001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbTIPO: TLabel;
    edTIPO: TComboBox;
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    lytRow_003: TLayout;
    lbVALOR: TLabel;
    edVALOR: TEdit;
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    OpenDialog: TOpenDialog;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCRICAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1TOTAL_HORAS_PREVISTA: TdxfmGridColumn;
    lbHR_TOTAL: TLabel;
    edTOTAL_HORAS_PREVISTA: TEdit;
    FDQRegistrosid: TIntegerField;
    FDQRegistrosdescricao: TWideStringField;
    FDQRegistrostipo: TIntegerField;
    FDQRegistrosvalor: TBCDField;
    FDQRegistrostotal_horas_prevista: TWideStringField;
    FDQRegistrosdt_cadastro: TDateField;
    FDQRegistroshr_cadastro: TTimeField;
    FDQRegistrostipo_desc: TWideMemoField;
    procedure imgFecharClick(Sender: TObject);
    procedure edVALORTyping(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edTIPOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edVALORChange(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edTOTAL_HORAS_PREVISTATyping(Sender: TObject);
    procedure edVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    FPesquisa: Boolean;

    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Selecionar_Registros;
    procedure Configura_Botoes;
    procedure SetPesquisa(const Value: Boolean);
  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_TabPrecos: TfrmCad_TabPrecos;

implementation

{$R *.fmx}

procedure TfrmCad_TabPrecos.Cancelar;
begin
  try
    try
      tcPrincipal.GotoVisibleTab(0);
    except on E: Exception do
      raise Exception.Create('Cancelar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_TabPrecos.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmCad_TabPrecos.edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR.SetFocus;
end;

procedure TfrmCad_TabPrecos.edTOTAL_HORAS_PREVISTATyping(Sender: TObject);
begin
  Formatar(edTOTAL_HORAS_PREVISTA,Tempo);
end;

procedure TfrmCad_TabPrecos.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edDESCRICAO.Text := FDQRegistros.FieldByName('DESCRICAO').AsString;
      edTIPO.ItemIndex := FDQRegistros.FieldByName('TIPO').AsInteger;
      edVALOR.Text := FloatToStr(FDQRegistros.FieldByName('VALOR').AsFloat);
      edVALOR.TagFloat := FDQRegistros.FieldByName('VALOR').AsFloat;
      edTOTAL_HORAS_PREVISTA.Text := FDQRegistros.FieldByName('TOTAL_HORAS_PREVISTA').AsString;

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edDESCRICAO.CanFocus then
        edDESCRICAO.SetFocus;
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_TabPrecos.edTIPOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCRICAO.SetFocus;
end;

procedure TfrmCad_TabPrecos.edVALORChange(Sender: TObject);
begin
  if Trim(edVALOR.Text) <> '' then
    edVALOR.TagFloat := StrToFloatDef(edVALOR.Text,0);
end;

procedure TfrmCad_TabPrecos.edVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edTOTAL_HORAS_PREVISTA.SetFocus;
end;

procedure TfrmCad_TabPrecos.edVALORTyping(Sender: TObject);
begin
  Formatar(edVALOR,Money);
end;

procedure TfrmCad_TabPrecos.Excluir(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Excluído');

      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM TABELA_PRECO WHERE ID = :ID');
      FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

      FDm_Global.FDC_Firebird.Commit;

    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Excluir: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmCad_TabPrecos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmCad_TabPrecos := Nil;
end;

procedure TfrmCad_TabPrecos.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCad_TabPrecos);
  FEnder := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  FIniFile := TIniFile.Create(FEnder);
  Pesquisa := False;

  tcPrincipal.ActiveTab := tiLista;

  lytFormulario.Align := TAlignLayout.Center;

  FDm_Global := TDM_Global.Create(Nil);
  FDQRegistros.Connection := FDm_Global.FDC_Firebird;

  Selecionar_Registros;
  Configura_Botoes;
end;

procedure TfrmCad_TabPrecos.imgFecharClick(Sender: TObject);
begin
  if FPesquisa then
  begin
    ExecuteOnClose(
      FDQRegistros.FieldByName('ID').AsInteger
      ,FDQRegistros.FieldByName('DESCRICAO').AsString
      ,FDQRegistros.FieldByName('TIPO').AsInteger
      ,FDQRegistros.FieldByName('VALOR').AsFloat);
  end;

  Close;
end;

procedure TfrmCad_TabPrecos.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;

      tcPrincipal.GotoVisibleTab(1);
      if edDESCRICAO.CanFocus then
        edDESCRICAO.SetFocus;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_TabPrecos.rctCancelarClick(Sender: TObject);
begin
  try
    try
      case TRectangle(Sender).Tag of
        0:Incluir;
        1:Editar;
        2:Salvar;
        3:Cancelar;
        4:FFancyDialog.Show(TIconDialog.Question,'Excluir','Deseja Excluir o registro selecionado?','Sim',Excluir,'Não') ;
      end;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
    end;
  finally
    Configura_Botoes;
  end;
end;

procedure TfrmCad_TabPrecos.Salvar;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      FQuery.Active := False;
      FQuery.Sql.Clear;

      case FTab_Status of
        dsInsert :begin
          FQuery.Sql.Add('INSERT INTO TABELA_PRECO( ');
          FQuery.Sql.Add('  DESCRICAO ');
          FQuery.Sql.Add('  ,TIPO ');
          FQuery.Sql.Add('  ,VALOR ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add('  ,TOTAL_HORAS_PREVISTA ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :DESCRICAO ');
          FQuery.Sql.Add('  ,:TIPO ');
          FQuery.Sql.Add('  ,:VALOR ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('  ,:TOTAL_HORAS_PREVISTA ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE TABELA_PRECO SET ');
          FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
          FQuery.Sql.Add('  ,TIPO = :TIPO ');
          FQuery.Sql.Add('  ,VALOR = :VALOR ');
          FQuery.Sql.Add('  ,TOTAL_HORAS_PREVISTA = :TOTAL_HORAS_PREVISTA ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
      FQuery.ParamByName('TIPO').AsInteger := edTIPO.ItemIndex;
      FQuery.ParamByName('VALOR').AsFloat := edVALOR.TagFloat;
      FQuery.ParamByName('TOTAL_HORAS_PREVISTA').AsString := edTOTAL_HORAS_PREVISTA.Text;
      FQuery.ExecSQL;

      FDm_Global.FDC_Firebird.Commit;

    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Salvar: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmCad_TabPrecos.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  TP.* ');
      FDQRegistros.SQL.Add('  ,CASE TP.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''HORA'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''FIXO'' ');
      FDQRegistros.SQL.Add('  END TIPO_DESC ');
      FDQRegistros.SQL.Add('FROM TABELA_PRECO TP ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  TP.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;
end;

procedure TfrmCad_TabPrecos.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
