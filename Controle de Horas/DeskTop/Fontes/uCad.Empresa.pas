unit uCad.Empresa;

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
  uDm.Global, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ListBox, FMX.dxGrid, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization,
  FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects;

type
  TTab_Status = (dsInsert,dsEdit);
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;

  TfrmCad_Empresa = class(TForm)
    FDQRegistros: TFDQuery;
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
    FDQRegistrosPESSOA_DESC: TStringField;
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
    Layout2: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1NOME: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA_DESC: TdxfmGridColumn;
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
    tiCadastro: TTabItem;
    lytConfig: TLayout;
    lytRow_001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbPESSOA: TLabel;
    edPESSOA: TComboBox;
    lbDOCUMENTO: TLabel;
    edDOCUMENTO: TEdit;
    lbINSC_EST: TLabel;
    edINSC_EST: TEdit;
    lytRow_002: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytRow_006: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    edTELEFONE: TEdit;
    lbTELEFONE: TLabel;
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
    procedure edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDOCUMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edINSC_ESTKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edENDERECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCIDADEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edTELEFONEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARTyping(Sender: TObject);
    procedure edCEPTyping(Sender: TObject);
    procedure edDOCUMENTOTyping(Sender: TObject);
    procedure edTELEFONETyping(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edCOMPLEMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
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
    procedure SetPesquisa(const Value: Boolean);
  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_Empresa: TfrmCad_Empresa;

implementation

{$R *.fmx}

procedure TfrmCad_Empresa.Cancelar;
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

procedure TfrmCad_Empresa.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
end;

procedure TfrmCad_Empresa.edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCIDADE.SetFocus;

end;

procedure TfrmCad_Empresa.edCELULARTyping(Sender: TObject);
begin
  Formatar(edCELULAR,Celular);
end;

procedure TfrmCad_Empresa.edCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edENDERECO.SetFocus;

end;

procedure TfrmCad_Empresa.edCEPTyping(Sender: TObject);
begin
  Formatar(edCEP,CEP);
end;

procedure TfrmCad_Empresa.edCIDADEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edUF.SetFocus;

end;

procedure TfrmCad_Empresa.edCOMPLEMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBAIRRO.SetFocus;

end;

procedure TfrmCad_Empresa.edDOCUMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edINSC_EST.SetFocus;

end;

procedure TfrmCad_Empresa.edDOCUMENTOTyping(Sender: TObject);
begin
  case edPESSOA.ItemIndex of
    0:Formatar(edDOCUMENTO,CPF);
    1:Formatar(edDOCUMENTO,CNPJ);
  end;
end;

procedure TfrmCad_Empresa.edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edTELEFONE.SetFocus;

end;

procedure TfrmCad_Empresa.edENDERECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edNUMERO.SetFocus;

end;

procedure TfrmCad_Empresa.edINSC_ESTKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edNOME.SetFocus;

end;

procedure TfrmCad_Empresa.Editar;
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

procedure TfrmCad_Empresa.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCEP.SetFocus;

end;

procedure TfrmCad_Empresa.edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCOMPLEMENTO.SetFocus;

end;

procedure TfrmCad_Empresa.edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDOCUMENTO.SetFocus;
end;

procedure TfrmCad_Empresa.edTELEFONEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCELULAR.SetFocus;

end;

procedure TfrmCad_Empresa.edTELEFONETyping(Sender: TObject);
begin
  Formatar(edTELEFONE,TelefoneFixo);
end;

procedure TfrmCad_Empresa.edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;

end;

procedure TfrmCad_Empresa.Excluir(Sender: TObject);
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
      FQuery.SQL.Add('DELETE FROM EMPRESA WHERE ID = :ID');
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

procedure TfrmCad_Empresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmCad_Empresa := Nil;
end;

procedure TfrmCad_Empresa.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCad_Empresa);
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

procedure TfrmCad_Empresa.imgFecharClick(Sender: TObject);
begin
  if FPesquisa then
  begin
    ExecuteOnClose(
      FDQRegistros.FieldByName('ID').AsInteger
      ,FDQRegistros.FieldByName('NOME').AsString);
  end;

  Close;
end;

procedure TfrmCad_Empresa.Incluir;
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

procedure TfrmCad_Empresa.Limpar_Campos;
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
end;

procedure TfrmCad_Empresa.rctCancelarClick(Sender: TObject);
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

procedure TfrmCad_Empresa.Salvar;
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
          FQuery.Sql.Add('INSERT INTO EMPRESA( ');
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
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
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
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE EMPRESA SET ');
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

procedure TfrmCad_Empresa.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  E.* ');
      FDQRegistros.SQL.Add('  ,CASE E.PESSOA ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''FÍSICA'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''JURÍDICA'' ');
      FDQRegistros.SQL.Add('  END PESSOA_DESC ');
      FDQRegistros.SQL.Add('FROM EMPRESA E ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  E.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;
end;

procedure TfrmCad_Empresa.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
