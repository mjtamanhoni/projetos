unit uCad.FormaPagamento;

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
  TExecuteOnClose = procedure(Aid:Integer; ANome:String; AClassificacao:String) of Object;

  TfrmFormaPagamento = class(TForm)
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    FDQCondicao: TFDQuery;
    DSCondicao: TDataSource;
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
    lbCLASSIFICACAO: TLabel;
    cbCLASSIFICACAO: TComboBox;
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCRICAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1CLASSIFICACAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    lytRow_003: TLayout;
    rctCondicaoPagto: TRectangle;
    rctCondicao_Tit: TRectangle;
    lbCondicao_Tit: TLabel;
    ShadowEffect1: TShadowEffect;
    lytCondicaoPagto_Detail: TLayout;
    lytCondicaoPagto_Footer: TLayout;
    rctCondicaoPagto_Footer: TRectangle;
    rctCondicaoPagto_Incluir: TRectangle;
    imgCondicaoPagto_Incluir: TImage;
    rctCondicaoPagto_Excluir: TRectangle;
    imgCondicaoPagto_Excluir: TImage;
    dxfmGrid2: TdxfmGrid;
    dxfmGridRootLevel1: TdxfmGridRootLevel;
    dxfmGridRootLevel1ID: TdxfmGridColumn;
    dxfmGridRootLevel1ID_FORMA_PAGAMENTO: TdxfmGridColumn;
    dxfmGridRootLevel1ID_CONDICAO_PAGAMENTO: TdxfmGridColumn;
    dxfmGridRootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGridRootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGridRootLevel1CONDICAO: TdxfmGridColumn;
    rctInc_Condicao_Tampa: TRectangle;
    rctInc_Condicao: TRectangle;
    ShadowEffect2: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    rctInc_Condicao_Footer: TRectangle;
    rctInc_Condicao_Salvar: TRectangle;
    imgInc_Condicao_Salvar: TImage;
    rctInc_Condicao_Cancelar: TRectangle;
    imgInc_Condicao_Cancelar: TImage;
    lytInc_Condicao_Row001: TLayout;
    lbInc_Condicao_ID: TLabel;
    edInc_Condicao_ID: TEdit;
    edInc_Condicao: TEdit;
    imgInc_Condicao_ID: TImage;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosDESCRICAO: TStringField;
    FDQRegistrosCLASSIFICACAO: TStringField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    lytCondicaoPagto_Tit: TLayout;
    dxfmGrid1Level2: TdxfmGridLevel;
    dxfmGrid1Level2ID: TdxfmGridColumn;
    dxfmGrid1Level2ID_FORMA_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1Level2ID_CONDICAO_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1Level2DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1Level2HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1Level2CONDICAO: TdxfmGridColumn;
    FDQ_Condicao_Grid: TFDQuery;
    DS_Condicao_Grid: TDataSource;
    FDQ_Condicao_GridID: TIntegerField;
    FDQ_Condicao_GridID_FORMA_PAGAMENTO: TIntegerField;
    FDQ_Condicao_GridID_CONDICAO_PAGAMENTO: TIntegerField;
    FDQ_Condicao_GridDT_CADASTRO: TDateField;
    FDQ_Condicao_GridHR_CADASTRO: TTimeField;
    FDQ_Condicao_GridCONDICAO: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure cbCLASSIFICACAOChange(Sender: TObject);
    procedure rctInc_Condicao_CancelarClick(Sender: TObject);
    procedure rctCondicaoPagto_ExcluirClick(Sender: TObject);
    procedure imgInc_Condicao_IDClick(Sender: TObject);
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
    procedure Selecionar_Condicao;
    procedure Selecionar_Condicao_Grid;
    procedure Configura_Botoes;
    procedure Limpar_Campos;
    procedure SetPesquisa(const Value: Boolean);
    procedure Salvar_Condicao;
    procedure Incluir_Condicao;
    procedure Excluir_Condicao(Sender :TOBject);
    procedure Sel_Condicao(Aid:Integer; ADescricao:String; AParcelas,ATipoIntervalo,AIntervalo:Integer);
    procedure Limpar_Campos_Condicao;
  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmFormaPagamento: TfrmFormaPagamento;

implementation

{$R *.fmx}

uses
  uCad.CondicaoPagamento, uCad.Empresa;

{ TfrmFormaPagamento }

procedure TfrmFormaPagamento.Cancelar;
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

procedure TfrmFormaPagamento.cbCLASSIFICACAOChange(Sender: TObject);
begin
  if edDESCRICAO.CanFocus then
    edDESCRICAO.SetFocus;
end;

procedure TfrmFormaPagamento.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmFormaPagamento.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edDESCRICAO.Text := FDQRegistros.FieldByName('DESCRICAO').AsString;
      cbCLASSIFICACAO.ItemIndex := cbCLASSIFICACAO.Items.IndexOf(FDQRegistros.FieldByName('CLASSIFICACAO').AsString);

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edDESCRICAO.CanFocus then
        edDESCRICAO.SetFocus;
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
    Selecionar_Condicao;
  end;
end;

procedure TfrmFormaPagamento.Excluir(Sender: TObject);
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
      FQuery.SQL.Add('DELETE FROM FORMA_PAGAMENTO WHERE ID = :ID');
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

procedure TfrmFormaPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmFormaPagamento := Nil;
end;

procedure TfrmFormaPagamento.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmFormaPagamento);
  FEnder := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  FIniFile := TIniFile.Create(FEnder);

  tcPrincipal.ActiveTab := tiLista;

  lytFormulario.Align := TAlignLayout.Center;

  FDm_Global := TDM_Global.Create(Nil);
  FDQRegistros.Connection := FDm_Global.FDC_Firebird;

  Selecionar_Registros;
  Selecionar_Condicao_Grid;
  Configura_Botoes;

end;

procedure TfrmFormaPagamento.imgFecharClick(Sender: TObject);
begin
  if FPesquisa then
  begin
    ExecuteOnClose(
      FDQRegistros.FieldByName('ID').AsInteger
      ,FDQRegistros.FieldByName('DESCRICAO').AsString
      ,FDQRegistros.FieldByName('CLASSIFICACAO').AsString
      );
  end;

  Close;
end;

procedure TfrmFormaPagamento.imgInc_Condicao_IDClick(Sender: TObject);
begin
  if NOT Assigned(frmCondicao_Pagamento) then
    Application.CreateForm(TfrmCondicao_Pagamento, frmCondicao_Pagamento);

  frmCondicao_Pagamento.Pesquisa := True;
  frmCondicao_Pagamento.ExecuteOnClose := Sel_Condicao;
  frmCondicao_Pagamento.Height := frmPrincipal.Height;
  frmCondicao_Pagamento.Width := frmPrincipal.Width;

  frmCondicao_Pagamento.Show;
end;

procedure TfrmFormaPagamento.Sel_Condicao(Aid:Integer; ADescricao:String; AParcelas,ATipoIntervalo,AIntervalo:Integer);
begin
  edInc_Condicao_ID.Text := Aid.ToString;
  edInc_Condicao.Text := ADescricao;
end;

procedure TfrmFormaPagamento.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;
      Limpar_Campos;

      tcPrincipal.GotoVisibleTab(1);
      if cbCLASSIFICACAO.CanFocus then
        cbCLASSIFICACAO.SetFocus;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmFormaPagamento.Limpar_Campos;
begin
  edID.Text := '';
  cbCLASSIFICACAO.ItemIndex := -1;
  edDESCRICAO.Text := '';

  Limpar_Campos_Condicao;
end;

procedure TfrmFormaPagamento.Limpar_Campos_Condicao;
begin
  edInc_Condicao_ID.Text := '';
  edInc_Condicao.Text := '';
end;

procedure TfrmFormaPagamento.rctCancelarClick(Sender: TObject);
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

procedure TfrmFormaPagamento.rctCondicaoPagto_ExcluirClick(Sender: TObject);
begin
  case TRectangle(Sender).Tag of
    0:Incluir_Condicao;
    1:FFancyDialog.Show(TIconDialog.Question,'Excluir','Deseja Excluir a Condição selecionada?','Sim',Excluir_Condicao,'Não');
  end;
end;

procedure TfrmFormaPagamento.Incluir_Condicao;
begin
  Limpar_Campos_Condicao;
  rctInc_Condicao_Tampa.Align := TAlignLayout.Contents;
  rctInc_Condicao_Tampa.Visible := True;
end;

procedure TfrmFormaPagamento.Excluir_Condicao(Sender :TOBject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      if FDQCondicao.IsEmpty then
        raise Exception.Create('Não há condição para ser Excluído');

      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM FORMA_CONDICAO_PAGAMENTO WHERE ID = :ID;');
      FQuery.ParamByName('ID').AsInteger := FDQCondicao.FieldByName('ID').AsInteger;
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
    Selecionar_Condicao;
  end;
end;

procedure TfrmFormaPagamento.rctInc_Condicao_CancelarClick(Sender: TObject);
begin
  case TRectangle(Sender).Tag of
    0:Salvar_Condicao;
    1:rctInc_Condicao_Tampa.Visible := False;
  end;
end;

procedure TfrmFormaPagamento.Salvar_Condicao;
var
  FQuery :TFDQuery;
  FId :Integer;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      if Trim(edID.Text) = '' then
        raise Exception.Create('É necessário selecionar uma forma de pagamento');
      if Trim(edInc_Condicao_ID.Text) = '' then
        raise Exception.Create('É necessário selecionar uma forma de pagamento');

      FId := 0;
      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('SELECT GEN_ID(GEN_FORMA_CONDICAO_PAGAMENTO_ID,1) AS SEQ FROM RDB$DATABASE;');
      FQuery.Open;
      FId := FQuery.FieldByName('SEQ').AsInteger;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('INSERT INTO FORMA_CONDICAO_PAGAMENTO( ');
      FQuery.Sql.Add('  ID ');
      FQuery.Sql.Add('  ,ID_FORMA_PAGAMENTO ');
      FQuery.Sql.Add('  ,ID_CONDICAO_PAGAMENTO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add(')VALUES( ');
      FQuery.Sql.Add('  :ID ');
      FQuery.Sql.Add('  ,:ID_FORMA_PAGAMENTO ');
      FQuery.Sql.Add('  ,:ID_CONDICAO_PAGAMENTO ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('ID').AsInteger := FId;
      FQuery.ParamByName('ID_FORMA_PAGAMENTO').AsInteger := StrToInt(edID.Text);
      FQuery.ParamByName('ID_CONDICAO_PAGAMENTO').AsInteger := StrToInt(edInc_Condicao_ID.Text);
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ExecSQL;

      FDm_Global.FDC_Firebird.Commit;
      rctInc_Condicao_Tampa.Visible := False;

    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Salvar: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    Selecionar_Condicao;
  end;
end;

procedure TfrmFormaPagamento.Salvar;
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
          FQuery.Sql.Add('SELECT GEN_ID(GEN_FORMA_PAGAMENTO_ID,1) AS SEQ FROM RDB$DATABASE;');
          FQuery.Open;
          FId := FQuery.FieldByName('SEQ').AsInteger;
        end;
        dsEdit: FId := StrToIntDef(edID.Text,0);
      end;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      case FTab_Status of
        dsInsert :begin
          FQuery.Sql.Add('INSERT INTO FORMA_PAGAMENTO( ');
          FQuery.Sql.Add('  ID ');
          FQuery.Sql.Add('  ,DESCRICAO ');
          FQuery.Sql.Add('  ,CLASSIFICACAO ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :ID ');
          FQuery.Sql.Add('  ,:DESCRICAO ');
          FQuery.Sql.Add('  ,:CLASSIFICACAO ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE FORMA_PAGAMENTO SET ');
          FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
          FQuery.Sql.Add('  ,CLASSIFICACAO = :CLASSIFICACAO ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
        end;
      end;
      FQuery.ParamByName('ID').AsInteger := FId;
      FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
      FQuery.ParamByName('CLASSIFICACAO').AsString := cbCLASSIFICACAO.Items.Strings[cbCLASSIFICACAO.ItemIndex];
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
    Selecionar_Condicao_Grid;
  end;
end;

procedure TfrmFormaPagamento.Selecionar_Condicao;
begin
  try
    try
      FDQCondicao.Active := False;
      FDQCondicao.SQL.Clear;
      FDQCondicao.SQL.Add('SELECT ');
      FDQCondicao.SQL.Add('  FCP.* ');
      FDQCondicao.SQL.Add('  ,CP.DESCRICAO AS CONDICAO ');
      FDQCondicao.SQL.Add('FROM FORMA_CONDICAO_PAGAMENTO FCP ');
      FDQCondicao.SQL.Add('  JOIN CONDICAO_PAGAMENTO CP ON CP.ID = FCP.ID_CONDICAO_PAGAMENTO ');
      FDQCondicao.SQL.Add('WHERE FCP.ID_FORMA_PAGAMENTO = ' + IntToStr(FDQRegistrosID.AsInteger));
      FDQCondicao.SQL.Add('ORDER BY ');
      FDQCondicao.SQL.Add('  FCP.ID_FORMA_PAGAMENTO ');
      FDQCondicao.SQL.Add('  ,FCP.ID_CONDICAO_PAGAMENTO; ');
      FDQCondicao.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar condição. ' + E.Message,'Ok');
    end;
  finally

  end;
end;

procedure TfrmFormaPagamento.Selecionar_Condicao_Grid;
begin
  try
    try
      FDQ_Condicao_Grid.Active := False;
      FDQ_Condicao_Grid.SQL.Clear;
      FDQ_Condicao_Grid.SQL.Add('SELECT ');
      FDQ_Condicao_Grid.SQL.Add('  FCP.* ');
      FDQ_Condicao_Grid.SQL.Add('  ,CP.DESCRICAO AS CONDICAO ');
      FDQ_Condicao_Grid.SQL.Add('FROM FORMA_CONDICAO_PAGAMENTO FCP ');
      FDQ_Condicao_Grid.SQL.Add('  JOIN CONDICAO_PAGAMENTO CP ON CP.ID = FCP.ID_CONDICAO_PAGAMENTO ');
      FDQ_Condicao_Grid.SQL.Add('ORDER BY ');
      FDQ_Condicao_Grid.SQL.Add('  FCP.ID_FORMA_PAGAMENTO ');
      FDQ_Condicao_Grid.SQL.Add('  ,FCP.ID_CONDICAO_PAGAMENTO; ');
      FDQ_Condicao_Grid.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar condição. ' + E.Message,'Ok');
    end;
  finally

  end;
end;

procedure TfrmFormaPagamento.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  FP.* ');
      FDQRegistros.SQL.Add('FROM FORMA_PAGAMENTO FP ');
      FDQRegistros.SQL.Add('WHERE NOT FP.ID IS NULL ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  FP.ID; ');
      FDQRegistros.Active := True;
      if not FDQRegistros.IsEmpty then
        Selecionar_Condicao;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;
end;

procedure TfrmFormaPagamento.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
