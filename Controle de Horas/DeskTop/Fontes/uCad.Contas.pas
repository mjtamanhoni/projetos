unit uCad.Contas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global, FMX.ListBox, FMX.dxGrid, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization, FMX.Edit,
  FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TTab_Status = (dsInsert,dsEdit);
  TExecuteOnClose = procedure(Aid:Integer; ADescricao:String; ATipo:Integer) of Object;

  TfrmCad_Contas = class(TForm)
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
    lbSTATUS: TLabel;
    edSTATUS: TComboBox;
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    OpenDialog: TOpenDialog;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosSTATUS: TIntegerField;
    FDQRegistrosDESCRICAO: TStringField;
    FDQRegistrosTIPO: TIntegerField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosSTATUS_DESC: TStringField;
    FDQRegistrosTIPO_DESC: TStringField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCRICAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_DESC: TdxfmGridColumn;
    edTIPO: TComboBox;
    lbTIPO: TLabel;
    procedure edTIPOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSTATUSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
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
  frmCad_Contas: TfrmCad_Contas;

implementation

{$R *.fmx}

procedure TfrmCad_Contas.Cancelar;
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

procedure TfrmCad_Contas.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmCad_Contas.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edDESCRICAO.Text := FDQRegistros.FieldByName('DESCRICAO').AsString;
      edTIPO.ItemIndex := FDQRegistros.FieldByName('TIPO').AsInteger;
      edSTATUS.ItemIndex := FDQRegistros.FieldByName('STATUS').AsInteger;

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

procedure TfrmCad_Contas.edSTATUSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCRICAO.SetFocus;
end;

procedure TfrmCad_Contas.edTIPOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edSTATUS.SetFocus;
end;

procedure TfrmCad_Contas.Excluir(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Excluído');

      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM CONTA WHERE ID = :ID');
      FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluir: ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmCad_Contas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmCad_Contas := Nil;
end;

procedure TfrmCad_Contas.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCad_Contas);
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

procedure TfrmCad_Contas.imgFecharClick(Sender: TObject);
begin
  if FPesquisa then
  begin
    ExecuteOnClose(
      FDQRegistros.FieldByName('ID').AsInteger
      ,FDQRegistros.FieldByName('DESCRICAO').AsString
      ,FDQRegistros.FieldByName('TIPO').AsInteger);
  end;

  Close;
end;

procedure TfrmCad_Contas.Incluir;
begin
  try
    try
      edID.Text := '';
      edDESCRICAO.Text := '';
      edTIPO.ItemIndex := -1;
      edSTATUS.ItemIndex := 1;

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

procedure TfrmCad_Contas.rctCancelarClick(Sender: TObject);
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

procedure TfrmCad_Contas.Salvar;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FQuery.Active := False;
      FQuery.Sql.Clear;

      case FTab_Status of
        dsInsert :begin
          FQuery.Sql.Add('INSERT INTO CONTA( ');
          FQuery.Sql.Add('  STATUS ');
          FQuery.Sql.Add('  ,DESCRICAO ');
          FQuery.Sql.Add('  ,TIPO ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :STATUS ');
          FQuery.Sql.Add('  ,:DESCRICAO ');
          FQuery.Sql.Add('  ,:TIPO ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE CONTA SET ');
          FQuery.Sql.Add('  STATUS = :STATUS ');
          FQuery.Sql.Add('  ,DESCRICAO = :DESCRICAO ');
          FQuery.Sql.Add('  ,TIPO = :TIPO ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
      FQuery.ParamByName('TIPO').AsInteger := edTIPO.ItemIndex;
      FQuery.ParamByName('STATUS').AsInteger := edSTATUS.ItemIndex;
      FQuery.ExecSQL;
    except on E: Exception do
      raise Exception.Create('Salvar: ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmCad_Contas.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  C.* ');
      FDQRegistros.SQL.Add('  ,CASE C.STATUS ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''INATIVO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''ATIVO'' ');
      FDQRegistros.SQL.Add('  END STATUS_DESC ');
      FDQRegistros.SQL.Add('  ,CASE C.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''CRÉDITO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''DÉBITO'' ');
      FDQRegistros.SQL.Add('  END TIPO_DESC ');
      FDQRegistros.SQL.Add('FROM CONTA C ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  C.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;
end;

procedure TfrmCad_Contas.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
