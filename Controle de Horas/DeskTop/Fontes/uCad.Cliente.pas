unit uCad.Cliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.dxGrid, FMX.dxControlUtils,
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
  uDm.Global,
  uCad.TabPrecos,
  FMX.ListBox;

type
  TTab_Status = (dsInsert,dsEdit);
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;

  TfrmCad_Cliente = class(TForm)
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
    lytRow_002: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytRow_006: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    OpenDialog: TOpenDialog;
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosNOME: TStringField;
    FDQRegistrosPESSOA: TIntegerField;
    FDQRegistrosDOCUMENTO: TStringField;
    FDQRegistrosINSC_EST: TStringField;
    FDQRegistrosCEP: TStringField;
    FDQRegistrosENDERECO: TStringField;
    FDQRegistrosCOMPLEMENTO: TStringField;
    FDQRegistrosNUMERO: TStringField;
    FDQRegistrosBAIRRO: TStringField;
    FDQRegistrosCIDADE: TStringField;
    FDQRegistrosUF: TStringField;
    FDQRegistrosTELEFONE: TStringField;
    FDQRegistrosCELULAR: TStringField;
    FDQRegistrosEMAIL: TStringField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1NOME: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DOCUMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1INSC_EST: TdxfmGridColumn;
    dxfmGrid1RootLevel1CEP: TdxfmGridColumn;
    dxfmGrid1RootLevel1ENDERECO: TdxfmGridColumn;
    dxfmGrid1RootLevel1COMPLEMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1NUMERO: TdxfmGridColumn;
    dxfmGrid1RootLevel1BAIRRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1CIDADE: TdxfmGridColumn;
    dxfmGrid1RootLevel1UF: TdxfmGridColumn;
    dxfmGrid1RootLevel1TELEFONE: TdxfmGridColumn;
    dxfmGrid1RootLevel1CELULAR: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMAIL: TdxfmGridColumn;
    lbPESSOA: TLabel;
    edPESSOA: TComboBox;
    lbDOCUMENTO: TLabel;
    edDOCUMENTO: TEdit;
    lbINSC_EST: TLabel;
    edINSC_EST: TEdit;
    lytRow_003: TLayout;
    lbCEP: TLabel;
    edCEP: TEdit;
    edENDERECO: TEdit;
    lbENDERECO: TLabel;
    edNUMERO: TEdit;
    lbNUMERO: TLabel;
    lytRow_004: TLayout;
    lbCOMPLEMENTO: TLabel;
    edCOMPLEMENTO: TEdit;
    lytRow_005: TLayout;
    lbBAIRRO: TLabel;
    edBAIRRO: TEdit;
    edCIDADE: TEdit;
    lbCIDADE: TLabel;
    edUF: TEdit;
    lbUF: TLabel;
    edTELEFONE: TEdit;
    lbTELEFONE: TLabel;
    lytRow_007: TLayout;
    lbID_TAB_PRECO: TLabel;
    edID_TAB_PRECO_Desc: TEdit;
    edID_TAB_PRECO: TEdit;
    FDQRegistrosID_TAB_PRECO: TIntegerField;
    FDQRegistrosPESSOA_DESC: TStringField;
    FDQRegistrosDESCRICAO: TStringField;
    FDQRegistrosTIPO_DESC: TStringField;
    FDQRegistrosVALOR: TFMTBCDField;
    dxfmGrid1RootLevel1ID_TAB_PRECO: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCRICAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
    edID_TAB_PRECO_Valor: TEdit;
    edID_TAB_PRECO_Tipo: TEdit;
    imgID_TAB_PRECO: TImage;
    lytRow_008: TLayout;
    lbID_FORNECEDOR: TLabel;
    edID_FORNECEDOR_Desc: TEdit;
    edID_FORNECEDOR: TEdit;
    imgID_PESSOA: TImage;
    FDQRegistrosID_FORNECEDOR: TIntegerField;
    FDQRegistrosFORNECEDOR: TStringField;
    procedure edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDOCUMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edINSC_ESTKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edENDERECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCOMPLEMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCIDADEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edTELEFONEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgFecharClick(Sender: TObject);
    procedure edTELEFONETyping(Sender: TObject);
    procedure edCELULARTyping(Sender: TObject);
    procedure edCEPTyping(Sender: TObject);
    procedure edDOCUMENTOTyping(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure imgID_TAB_PRECOClick(Sender: TObject);
    procedure imgID_PESSOAClick(Sender: TObject);
    procedure edID_FORNECEDORExit(Sender: TObject);
    procedure edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_TAB_PRECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
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
    procedure Limpar_Campos;
    procedure Sel_TabPreco(Aid: Integer; ADescricao: String; ATipo: Integer; AValor: Double);
    procedure SetPesquisa(const Value: Boolean);
    procedure Sel_Pessoa(ATipo: String; Aid: Integer; ANome, ADocumento: String);
  public
    ExecuteOnClose :TExecuteOnClose;
    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_Cliente: TfrmCad_Cliente;

implementation

{$R *.fmx}

uses
  uPesq_Pessoas;

procedure TfrmCad_Cliente.Cancelar;
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

procedure TfrmCad_Cliente.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmCad_Cliente.edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCIDADE.SetFocus;
end;

procedure TfrmCad_Cliente.edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_TAB_PRECO.SetFocus;

end;

procedure TfrmCad_Cliente.edCELULARTyping(Sender: TObject);
begin
  Formatar(edCELULAR,Celular);
end;

procedure TfrmCad_Cliente.edCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edENDERECO.SetFocus;
end;

procedure TfrmCad_Cliente.edCEPTyping(Sender: TObject);
begin
  Formatar(edCEP,CEP);
end;

procedure TfrmCad_Cliente.edCIDADEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edUF.SetFocus;
end;

procedure TfrmCad_Cliente.edCOMPLEMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBAIRRO.SetFocus;
end;

procedure TfrmCad_Cliente.edDOCUMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edINSC_EST.SetFocus;
end;

procedure TfrmCad_Cliente.edDOCUMENTOTyping(Sender: TObject);
begin
  case edPESSOA.ItemIndex of
    0:Formatar(edDOCUMENTO,CPF);
    1:Formatar(edDOCUMENTO,CNPJ);
  end;
end;

procedure TfrmCad_Cliente.edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edTELEFONE.SetFocus;
end;

procedure TfrmCad_Cliente.edENDERECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edNUMERO.SetFocus;
end;

procedure TfrmCad_Cliente.edID_FORNECEDORExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      FDm_Global.Listar_Fornecedor(edID_FORNECEDOR.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_FORNECEDOR_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmCad_Cliente.edID_TAB_PRECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_FORNECEDOR.SetFocus;

end;

procedure TfrmCad_Cliente.edINSC_ESTKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edNOME.SetFocus;
end;

procedure TfrmCad_Cliente.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edNOME.Text := FDQRegistros.FieldByName('NOME').AsString;
      edPESSOA.ItemIndex := FDQRegistros.FieldByName('PESSOA').AsInteger;
      edDOCUMENTO.Text := FDQRegistros.FieldByName('DOCUMENTO').AsString;
      edINSC_EST.Text := FDQRegistros.FieldByName('INSC_EST').AsString;
      edCEP.Text := FDQRegistros.FieldByName('CEP').AsString;
      edENDERECO.Text := FDQRegistros.FieldByName('ENDERECO').AsString;
      edCOMPLEMENTO.Text := FDQRegistros.FieldByName('COMPLEMENTO').AsString;
      edNUMERO.Text := FDQRegistros.FieldByName('NUMERO').AsString;
      edBAIRRO.Text := FDQRegistros.FieldByName('BAIRRO').AsString;
      edCIDADE.Text := FDQRegistros.FieldByName('CIDADE').AsString;
      edUF.Text := FDQRegistros.FieldByName('UF').AsString;
      edTELEFONE.Text := FDQRegistros.FieldByName('TELEFONE').AsString;
      edCELULAR.Text := FDQRegistros.FieldByName('CELULAR').AsString;
      edEMAIL.Text := FDQRegistros.FieldByName('EMAIL').AsString;
      edID_TAB_PRECO.Text := FDQRegistros.FieldByName('ID_TAB_PRECO').AsString;
      edID_TAB_PRECO_Desc.Text := FDQRegistros.FieldByName('DESCRICAO').AsString;
      edID_TAB_PRECO_Tipo.Text := FDQRegistros.FieldByName('TIPO_DESC').AsString;
      edID_TAB_PRECO_Valor.Text := FormatFLoat('R$ #,##0.00',FDQRegistros.FieldByName('VALOR').AsFloat);
      edID_FORNECEDOR.Text := IntToStr(FDQRegistros.FieldByName('ID_FORNECEDOR').AsInteger);
      edID_FORNECEDOR_Desc.Text := FDQRegistros.FieldByName('FORNECEDOR').AsString;

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edPESSOA.CanFocus then
        edPESSOA.SetFocus;
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Cliente.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCEP.SetFocus;
end;

procedure TfrmCad_Cliente.edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCOMPLEMENTO.SetFocus;
end;

procedure TfrmCad_Cliente.edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDOCUMENTO.SetFocus;
end;

procedure TfrmCad_Cliente.edTELEFONEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCELULAR.SetFocus;
end;

procedure TfrmCad_Cliente.edTELEFONETyping(Sender: TObject);
begin
  Formatar(edTELEFONE,TelefoneFixo);
end;

procedure TfrmCad_Cliente.edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;
end;

procedure TfrmCad_Cliente.Excluir(Sender: TObject);
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
      FQuery.SQL.Add('DELETE FROM CLIENTE WHERE ID = :ID');
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

procedure TfrmCad_Cliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmCad_Cliente := Nil;
end;

procedure TfrmCad_Cliente.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCad_Cliente);
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

procedure TfrmCad_Cliente.imgFecharClick(Sender: TObject);
begin
  if FPesquisa then
  begin
    ExecuteOnClose(
      FDQRegistros.FieldByName('ID').AsInteger
      ,FDQRegistros.FieldByName('NOME').AsString);
  end;

  Close;
end;

procedure TfrmCad_Cliente.imgID_PESSOAClick(Sender: TObject);
begin
  if NOT Assigned(frmPesq_Pessoas) then
    Application.CreateForm(TfrmPesq_Pessoas,frmPesq_Pessoas);

  frmPesq_Pessoas.TipoFiltro := 2; //Fornecedor

  frmPesq_Pessoas.ExecuteOnClose := Sel_Pessoa;
  frmPesq_Pessoas.Height := frmPrincipal.Height;
  frmPesq_Pessoas.Width := frmPrincipal.Width;

  frmPesq_Pessoas.Show;
end;

procedure TfrmCad_Cliente.Sel_Pessoa(ATipo:String; Aid:Integer; ANome:String; ADocumento:String);
begin
  edID_FORNECEDOR.Text := Aid.ToString;
  edID_FORNECEDOR_Desc.Text := ANome;

  if edID_FORNECEDOR.CanFocus then
    edID_FORNECEDOR.SetFocus;

end;

procedure TfrmCad_Cliente.imgID_TAB_PRECOClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_TabPrecos) then
    Application.CreateForm(TfrmCad_TabPrecos, frmCad_TabPrecos);

  frmCad_TabPrecos.Pesquisa := True;
  frmCad_TabPrecos.ExecuteOnClose := Sel_TabPreco;

  frmCad_TabPrecos.Show;
end;

procedure TfrmCad_Cliente.Sel_TabPreco(Aid:Integer; ADescricao:String; ATipo:Integer; AValor:Double);
begin
  edID_TAB_PRECO.Text := Aid.ToString;
  edID_TAB_PRECO_Desc.Text := ADescricao;
  case ATipo of
    0:edID_TAB_PRECO_Tipo.Text := 'HORA';
    1:edID_TAB_PRECO_Tipo.Text := 'FIXO';
  end;
  edID_TAB_PRECO_Valor.Text := FormatFloat('R$ #,##0.00',AValor);
end;

procedure TfrmCad_Cliente.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_Cliente.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;
      Limpar_Campos;

      tcPrincipal.GotoVisibleTab(1);
      if edPESSOA.CanFocus then
        edPESSOA.SetFocus;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Cliente.Limpar_Campos;
begin
  edID.Text := '';
  edNOME.Text := '';
  edPESSOA.ItemIndex := -1;
  edDOCUMENTO.Text := '';
  edINSC_EST.Text := '';
  edCEP.Text := '';
  edENDERECO.Text := '';
  edCOMPLEMENTO.Text := '';
  edNUMERO.Text := '';
  edBAIRRO.Text := '';
  edCIDADE.Text := '';
  edUF.Text := '';
  edTELEFONE.Text := '';
  edCELULAR.Text := '';
  edEMAIL.Text := '';
  edID_TAB_PRECO.Text := '';
  edID_TAB_PRECO_Desc.Text := '';
  edID_TAB_PRECO_Tipo.Text := '';
  edID_TAB_PRECO_Valor.Text := '';
  edID_FORNECEDOR_Desc.Text := '';
  edID_FORNECEDOR.Text := '';
end;

procedure TfrmCad_Cliente.rctCancelarClick(Sender: TObject);
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

procedure TfrmCad_Cliente.Salvar;
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
          FQuery.Sql.Add('INSERT INTO CLIENTE( ');
          FQuery.Sql.Add('  NOME ');
          FQuery.Sql.Add('  ,PESSOA ');
          FQuery.Sql.Add('  ,DOCUMENTO ');
          FQuery.Sql.Add('  ,INSC_EST ');
          FQuery.Sql.Add('  ,CEP ');
          FQuery.Sql.Add('  ,ENDERECO ');
          FQuery.Sql.Add('  ,COMPLEMENTO ');
          FQuery.Sql.Add('  ,NUMERO ');
          FQuery.Sql.Add('  ,BAIRRO ');
          FQuery.Sql.Add('  ,CIDADE ');
          FQuery.Sql.Add('  ,UF ');
          FQuery.Sql.Add('  ,TELEFONE ');
          FQuery.Sql.Add('  ,CELULAR ');
          FQuery.Sql.Add('  ,EMAIL ');
          FQuery.Sql.Add('  ,ID_TAB_PRECO ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add('  ,ID_FORNECEDOR ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :NOME ');
          FQuery.Sql.Add('  ,:PESSOA ');
          FQuery.Sql.Add('  ,:DOCUMENTO ');
          FQuery.Sql.Add('  ,:INSC_EST ');
          FQuery.Sql.Add('  ,:CEP ');
          FQuery.Sql.Add('  ,:ENDERECO ');
          FQuery.Sql.Add('  ,:COMPLEMENTO ');
          FQuery.Sql.Add('  ,:NUMERO ');
          FQuery.Sql.Add('  ,:BAIRRO ');
          FQuery.Sql.Add('  ,:CIDADE ');
          FQuery.Sql.Add('  ,:UF ');
          FQuery.Sql.Add('  ,:TELEFONE ');
          FQuery.Sql.Add('  ,:CELULAR ');
          FQuery.Sql.Add('  ,:EMAIL ');
          FQuery.Sql.Add('  ,:ID_TAB_PRECO ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('  ,:ID_FORNECEDOR ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE CLIENTE SET ');
          FQuery.Sql.Add('  NOME = :NOME ');
          FQuery.Sql.Add('  ,PESSOA = :PESSOA ');
          FQuery.Sql.Add('  ,DOCUMENTO = :DOCUMENTO ');
          FQuery.Sql.Add('  ,INSC_EST = :INSC_EST ');
          FQuery.Sql.Add('  ,CEP = :CEP ');
          FQuery.Sql.Add('  ,ENDERECO = :ENDERECO ');
          FQuery.Sql.Add('  ,COMPLEMENTO = :COMPLEMENTO ');
          FQuery.Sql.Add('  ,NUMERO = :NUMERO ');
          FQuery.Sql.Add('  ,BAIRRO = :BAIRRO ');
          FQuery.Sql.Add('  ,CIDADE = :CIDADE ');
          FQuery.Sql.Add('  ,UF = :UF ');
          FQuery.Sql.Add('  ,TELEFONE = :TELEFONE ');
          FQuery.Sql.Add('  ,CELULAR = :CELULAR ');
          FQuery.Sql.Add('  ,EMAIL = :EMAIL ');
          FQuery.Sql.Add('  ,ID_TAB_PRECO = :ID_TAB_PRECO ');
          FQuery.Sql.Add('  ,ID_FORNECEDOR = :ID_FORNECEDOR ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('NOME').AsString := edNOME.Text;
      FQuery.ParamByName('PESSOA').AsInteger := edPESSOA.ItemIndex;
      FQuery.ParamByName('DOCUMENTO').AsString := edDOCUMENTO.Text;
      FQuery.ParamByName('INSC_EST').AsString := edINSC_EST.Text;
      FQuery.ParamByName('CEP').AsString := edCEP.Text;
      FQuery.ParamByName('ENDERECO').AsString := edENDERECO.Text;
      FQuery.ParamByName('COMPLEMENTO').AsString := edCOMPLEMENTO.Text;
      FQuery.ParamByName('NUMERO').AsString := edNUMERO.Text;
      FQuery.ParamByName('BAIRRO').AsString := edBAIRRO.Text;
      FQuery.ParamByName('CIDADE').AsString := edCIDADE.Text;
      FQuery.ParamByName('UF').AsString := edUF.Text;
      FQuery.ParamByName('TELEFONE').AsString := edTELEFONE.Text;
      FQuery.ParamByName('CELULAR').AsString := edCELULAR.Text;
      FQuery.ParamByName('EMAIL').AsString := edEMAIL.Text;
      FQuery.ParamByName('ID_TAB_PRECO').AsInteger := StrToIntDef(edID_TAB_PRECO.Text,0);
      FQuery.ParamByName('ID_FORNECEDOR').AsInteger := StrToIntDef(edID_FORNECEDOR.Text,0);
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

procedure TfrmCad_Cliente.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  C.* ');
      FDQRegistros.SQL.Add('  ,CASE C.PESSOA ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''FÍSICA'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''JURÍDICA'' ');
      FDQRegistros.SQL.Add('  END PESSOA_DESC ');
      FDQRegistros.SQL.Add('  ,TP.DESCRICAO ');
      FDQRegistros.SQL.Add('  ,CASE TP.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''HORA'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''FIXO'' ');
      FDQRegistros.SQL.Add('  END TIPO_DESC ');
      FDQRegistros.SQL.Add('  ,TP.VALOR ');
	    FDQRegistros.SQL.Add('  ,F.NOME AS FORNECEDOR ');
      FDQRegistros.SQL.Add('FROM CLIENTE C ');
      FDQRegistros.SQL.Add('  LEFT JOIN TABELA_PRECO TP ON TP.ID = C.ID_TAB_PRECO ');
      FDQRegistros.SQL.Add('  LEFT JOIN FORNECEDOR F ON F.ID = C.ID_FORNECEDOR ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  C.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;
end;

end.
