unit uCad.CondicaoPagamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox,
  FMX.dxGrid, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects;

type
  TTab_Status = (dsInsert,dsEdit);
  TExecuteOnClose = procedure(Aid:Integer; ADescricao:String; AParcelas,ATipoIntervalo,AIntervalo:Integer) of Object;

  TfrmCondicao_Pagamento = class(TForm)
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    OpenDialog: TOpenDialog;
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
    lytLista: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    tiCadastro: TTabItem;
    lytCadastro: TLayout;
    lytRow_001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbTIPO_INTERVALO: TLabel;
    cbTIPO_INTERVALO: TComboBox;
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosDESCRICAO: TStringField;
    FDQRegistrosPARCELAS: TIntegerField;
    FDQRegistrosTIPO_INTERVALO: TIntegerField;
    FDQRegistrosINTEVALOR: TIntegerField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosTIPO_INTERVALO_DESC: TStringField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCRICAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1PARCELAS: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_INTERVALO: TdxfmGridColumn;
    dxfmGrid1RootLevel1INTEVALOR: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_INTERVALO_DESC: TdxfmGridColumn;
    lbPARCELAS: TLabel;
    edPARCELAS: TEdit;
    edINTEVALOR: TEdit;
    lbINTEVALOR: TLabel;
    procedure edPARCELASKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure cbTIPO_INTERVALOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edINTEVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure cbTIPO_INTERVALOChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
  private
    FPesquisa: Boolean;
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;

    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Selecionar_Registros;
    procedure Configura_Botoes;
    procedure Limpar_Campos;

    procedure SetPesquisa(const Value: Boolean);

  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCondicao_Pagamento: TfrmCondicao_Pagamento;

implementation

{$R *.fmx}

procedure TfrmCondicao_Pagamento.Cancelar;
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

procedure TfrmCondicao_Pagamento.cbTIPO_INTERVALOChange(Sender: TObject);
begin
  edINTEVALOR.SetFocus;
end;

procedure TfrmCondicao_Pagamento.cbTIPO_INTERVALOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edINTEVALOR.SetFocus;
end;

procedure TfrmCondicao_Pagamento.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmCondicao_Pagamento.edINTEVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCRICAO.SetFocus;

end;

procedure TfrmCondicao_Pagamento.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edDESCRICAO.Text := FDQRegistros.FieldByName('DESCRICAO').AsString;
      cbTIPO_INTERVALO.ItemIndex := FDQRegistros.FieldByName('CLASSIFICACAO').AsInteger;

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edPARCELAS.CanFocus then
        edPARCELAS.SetFocus;

    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCondicao_Pagamento.edPARCELASKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    cbTIPO_INTERVALO.SetFocus;
end;

procedure TfrmCondicao_Pagamento.Excluir(Sender: TObject);
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
      FQuery.SQL.Add('DELETE FROM CONDICAO_PAGAMENTO WHERE ID = :ID');
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

procedure TfrmCondicao_Pagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmCondicao_Pagamento := Nil;

end;

procedure TfrmCondicao_Pagamento.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCondicao_Pagamento);
  FEnder := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  FIniFile := TIniFile.Create(FEnder);

  tcPrincipal.ActiveTab := tiLista;

  lytFormulario.Align := TAlignLayout.Center;

  FDm_Global := TDM_Global.Create(Nil);
  FDQRegistros.Connection := FDm_Global.FDC_Firebird;

  Selecionar_Registros;
  Configura_Botoes;
end;

procedure TfrmCondicao_Pagamento.imgFecharClick(Sender: TObject);
begin
  if FPesquisa then
  begin
    ExecuteOnClose(
      FDQRegistros.FieldByName('ID').AsInteger
      ,FDQRegistros.FieldByName('DESCRICAO').AsString
      ,FDQRegistros.FieldByName('PARCELAS').AsInteger
      ,FDQRegistros.FieldByName('TIPO_INTERVALO').AsInteger
      ,FDQRegistros.FieldByName('INTEVALOR').AsInteger
      );
  end;

  Close;
end;

procedure TfrmCondicao_Pagamento.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;
      Limpar_Campos;

      tcPrincipal.GotoVisibleTab(1);
      if edPARCELAS.CanFocus then
        edPARCELAS.SetFocus;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCondicao_Pagamento.Limpar_Campos;
begin
  edID.Text := '';
  edPARCELAS.Text := '';
  cbTIPO_INTERVALO.ItemIndex := -1;
  edINTEVALOR.Text := '';
  edDESCRICAO.Text := '';
end;

procedure TfrmCondicao_Pagamento.rctCancelarClick(Sender: TObject);
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

procedure TfrmCondicao_Pagamento.Salvar;
var
  FQuery :TFDQuery;
  FId :Integer;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      FId := 0;
      case FTab_Status of
        dsInsert: begin
          FQuery.Active := False;
          FQuery.Sql.Clear;
          FQuery.Sql.Add('SELECT GEN_ID(GEN_CONDICAO_PAGAMENTO_ID,1) AS SEQ FROM RDB$DATABASE;');
          FQuery.Open;
          FId := FQuery.FieldByName('SEQ').AsInteger;
        end;
        dsEdit: FId := StrToIntDef(edID.Text,0);
      end;


      FQuery.Active := False;
      FQuery.Sql.Clear;
      case FTab_Status of
        dsInsert :begin
          FQuery.Sql.Add('INSERT INTO CONDICAO_PAGAMENTO( ');
          FQuery.Sql.Add('  ID ');
          FQuery.Sql.Add('  ,DESCRICAO ');
          FQuery.Sql.Add('  ,PARCELAS ');
          FQuery.Sql.Add('  ,TIPO_INTERVALO ');
          FQuery.Sql.Add('  ,INTEVALOR ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :ID ');
          FQuery.Sql.Add('  ,:DESCRICAO ');
          FQuery.Sql.Add('  ,:PARCELAS ');
          FQuery.Sql.Add('  ,:TIPO_INTERVALO ');
          FQuery.Sql.Add('  ,:INTEVALOR ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE TABELA_PRECO SET ');
          FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
          FQuery.Sql.Add('  ,PARCELAS = :PARCELAS ');
          FQuery.Sql.Add('  ,TIPO_INTERVALO = :TIPO_INTERVALO ');
          FQuery.Sql.Add('  ,INTEVALOR = :INTEVALOR ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
        end;
      end;
      FQuery.ParamByName('ID').AsInteger := FId;
      FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
      FQuery.ParamByName('PARCELAS').AsInteger := StrToIntDef(edPARCELAS.Text,1);
      FQuery.ParamByName('TIPO_INTERVALO').AsInteger := cbTIPO_INTERVALO.ItemIndex;
      FQuery.ParamByName('INTEVALOR').AsInteger := StrToIntDef(edINTEVALOR.Text,1);
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

procedure TfrmCondicao_Pagamento.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  CP.* ');
      FDQRegistros.SQL.Add('  ,CASE CP.TIPO_INTERVALO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''DIAS'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''MESES'' ');
      FDQRegistros.SQL.Add('  END TIPO_INTERVALO_DESC ');
      FDQRegistros.SQL.Add('FROM CONDICAO_PAGAMENTO CP ');
      FDQRegistros.SQL.Add('WHERE NOT CP.ID IS NULL ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  CP.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;
end;

procedure TfrmCondicao_Pagamento.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
