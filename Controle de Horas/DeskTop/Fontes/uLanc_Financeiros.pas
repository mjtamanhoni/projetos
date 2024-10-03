unit uLanc_Financeiros;

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
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects,
  FMX.dxGrid, FMX.Layouts, FMX.Ani, FMX.ListBox, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization,
  FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TTab_Status = (dsInsert,dsEdit);

  TfrmLanc_Financeiros = class(TForm)
    OpenDialog: TOpenDialog;
    DSRegistros: TDataSource;
    FDQRegistros: TFDQuery;
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
    rctPagamento: TRectangle;
    imPagamento: TImage;
    rctTot_Receber: TRectangle;
    lbTot_Receber_Tit: TLabel;
    lbTot_Receber: TLabel;
    rctTot_Pagar: TRectangle;
    lbTot_Pagar_Tit: TLabel;
    lbTot_Pagar: TLabel;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    lytFiltro_Periodo: TLayout;
    rctFiltro_Periodo: TRectangle;
    lbFiltro_Periodo_Tit: TLabel;
    lbFiltro_Data_A: TLabel;
    edFIltro_Dt_I: TEdit;
    edFIltro_Dt_F: TEdit;
    lytFiltro_Empresa: TLayout;
    rctFiltro_Empresa: TRectangle;
    lytFiltro_Empresa_Tit: TLabel;
    edFiltro_Empresa_ID: TEdit;
    imgFiltro_Empresa: TImage;
    edFiltro_Empresa: TEdit;
    lytFiltro_TipoStatus: TLayout;
    rctFiltro_TipoStatus: TRectangle;
    lytFiltro_Cliente: TLayout;
    rctFiltro_Cliente: TRectangle;
    edFiltro_Cliente: TEdit;
    edFiltro_Cliente_ID: TEdit;
    imgFiltro_Cliente: TImage;
    lytLista: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    tiCadastro: TTabItem;
    lytCadastro: TLayout;
    lytRow_001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbSTATUS: TLabel;
    edSTATUS: TComboBox;
    lbDATA: TLabel;
    edDATA: TEdit;
    lytRow_002: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA_Desc: TEdit;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_003: TLayout;
    lbID_CONTA: TLabel;
    edID_CONTA_Desc: TEdit;
    edID_CONTA: TEdit;
    imgID_CONTA: TImage;
    lytRow_004: TLayout;
    lbID_PESSOA: TLabel;
    edID_PESSOA_Desc: TEdit;
    edID_PESSOA: TEdit;
    imgID_PESSOA: TImage;
    lytRow_005: TLayout;
    lbVALOR: TLabel;
    edVALOR: TEdit;
    lytRow_007: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_006: TLayout;
    lbDT_PAGAMENTO: TLabel;
    edDT_PAGAMENTO: TEdit;
    lbVALOR_PAGO: TLabel;
    edVALOR_PAGO: TEdit;
    rctMenu_Tampa: TRectangle;
    rctMenu: TRectangle;
    lytMenu_Titulo: TLayout;
    lbMenu_Titulo: TLabel;
    imgMenuFechar: TImage;
    faMenu: TFloatAnimation;
    rctMenu_BaixarHoras: TRectangle;
    lbMenu_BaixarHoras: TLabel;
    rctFecharMes: TRectangle;
    lbFecharMes: TLabel;
    rctMenuBaixar_Horas: TRectangle;
    rctBH_Detail: TRectangle;
    ShadowEffect1: TShadowEffect;
    rctBH_Header: TRectangle;
    lbBH_Titulo: TLabel;
    lytBH_ValorPago: TLayout;
    edBH_ValorPago: TEdit;
    lytBH_Data: TLayout;
    edBH_Data: TEdit;
    lytBH_TotalHoras: TLayout;
    lbBH_TotalHoras: TLabel;
    lytBH_Footer: TLayout;
    gplBH_Footer: TGridPanelLayout;
    rctBH_Confirmar: TRectangle;
    imgBH_Confirmar: TImage;
    rctBH_Cancelar: TRectangle;
    imgBH_Cancelar: TImage;
    lytBH_Cliente: TLayout;
    edBH_Cliente: TEdit;
    imgBH_Cliente: TImage;
    lbBH_Cliente: TLabel;
    rctTot_Saldo: TRectangle;
    lbTot_Saldo_Tit: TLabel;
    lbTot_Saldo: TLabel;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosID_EMPRESA: TIntegerField;
    FDQRegistrosDT_EMISSAO: TDateField;
    FDQRegistrosID_CONTA: TIntegerField;
    FDQRegistrosID_PESSOA: TIntegerField;
    FDQRegistrosSTATUS: TIntegerField;
    FDQRegistrosDT_VENCIMENTO: TDateField;
    FDQRegistrosVALOR: TFMTBCDField;
    FDQRegistrosDT_PAGAMENTO: TDateField;
    FDQRegistrosDESCONTO: TFMTBCDField;
    FDQRegistrosJUROS: TFMTBCDField;
    FDQRegistrosVALOR_PAGO: TFMTBCDField;
    FDQRegistrosORIGEM_LANCAMENTO: TStringField;
    FDQRegistrosID_ORIGEM_LANCAMENTO: TIntegerField;
    FDQRegistrosID_USUARIO: TIntegerField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosOBSERVACAO: TStringField;
    FDQRegistrosEMPRESA: TStringField;
    FDQRegistrosCONTA: TStringField;
    FDQRegistrosTIPO_CONTA: TIntegerField;
    FDQRegistrosTIPO_CONTA_DESC: TStringField;
    FDQRegistrosPESSOA: TStringField;
    FDQRegistrosSTATUS_DESC: TStringField;
    FDQRegistrosUSUARIO: TStringField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_EMISSAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_VENCIMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1JUROS: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR_PAGO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ORIGEM_LANCAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_ORIGEM_LANCAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_USUARIO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1OBSERVACAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_CONTA_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1USUARIO: TdxfmGridColumn;
    imgFiltro_Aberto: TImage;
    imgChecked: TImage;
    imgUnChecked: TImage;
    lbFiltro_Aberto: TLabel;
    imgFiltro_Pago: TImage;
    lbFiltroPessoa: TLabel;
    cbFiltro_Tipo_Periodo: TComboBox;
    lbFiltro_Pago: TLabel;
    lbFiltro_TipoStatus: TLabel;
    lytFiltro_Tipo_DC: TLayout;
    rctFiltro_Tipo_DC: TRectangle;
    lbFIltro_Tipo_DC: TLabel;
    cbFiltro_Tipo_DC: TComboBox;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lbJUROS: TLabel;
    edJUROS: TEdit;
    lbDT_VENCIMENTO: TLabel;
    edDT_VENCIMENTO: TEdit;
    edConta_Tipo: TEdit;
    procedure imgFiltro_ClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edFiltro_Cliente_IDChange(Sender: TObject);
    procedure imgFiltro_AbertoClick(Sender: TObject);
    procedure imgFiltro_PagoClick(Sender: TObject);
    procedure imgFiltro_EmpresaClick(Sender: TObject);
    procedure cbFiltro_Tipo_DCChange(Sender: TObject);
    procedure cbFiltro_Tipo_PeriodoChange(Sender: TObject);
    procedure edFIltro_Dt_IChange(Sender: TObject);
    procedure edFIltro_Dt_FChange(Sender: TObject);
    procedure edFiltro_Empresa_IDChange(Sender: TObject);
    procedure edFIltro_Dt_ITyping(Sender: TObject);
    procedure edFIltro_Dt_FTyping(Sender: TObject);
    procedure cbFiltro_Tipo_DCKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure cbFiltro_Tipo_PeriodoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltro_Empresa_IDExit(Sender: TObject);
    procedure edFiltro_Cliente_IDExit(Sender: TObject);
    procedure edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure rctCancelarClick(Sender: TObject);
    procedure edDATATyping(Sender: TObject);
    procedure edDT_VENCIMENTOTyping(Sender: TObject);
    procedure edDT_PAGAMENTOTyping(Sender: TObject);
    procedure edVALORTyping(Sender: TObject);
    procedure edVALORChange(Sender: TObject);
    procedure edDESCONTOChange(Sender: TObject);
    procedure edJUROSChange(Sender: TObject);
    procedure imgID_EMPRESAClick(Sender: TObject);
    procedure edID_EMPRESAExit(Sender: TObject);
    procedure imgID_PESSOAClick(Sender: TObject);
    procedure imgID_CONTAClick(Sender: TObject);
    procedure edID_PESSOAExit(Sender: TObject);
    procedure edID_CONTAExit(Sender: TObject);
    procedure edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSTATUSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_PESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDT_VENCIMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDT_PAGAMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edJUROSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edVALOR_PAGOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTOTyping(Sender: TObject);
    procedure edJUROSTyping(Sender: TObject);
    procedure edVALOR_PAGOTyping(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;

    procedure Sel_Pessoa(ATipo:String; Aid:Integer; ANome:String; ADocumento:String);
    procedure Sel_Empresa(Aid: Integer; ANome: String);
    procedure Configura_Botoes;
    procedure Selecionar_Registros;

    procedure Cancelar;
    procedure Editar(Sender :TObject);
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Menu(Sender: TOBject);
    procedure Sel_Conta(Aid: Integer; ADescricao: String; ATipo: Integer);
    procedure Limpar_Campos;
    procedure Editando_Lancamento(Sender :TOBject);

  public
    { Public declarations }
  end;

var
  frmLanc_Financeiros: TfrmLanc_Financeiros;

implementation

{$R *.fmx}

uses
  uPesq_Pessoas
  ,uCad.Cliente
  ,uCad.Empresa, uCad.Contas;

procedure TfrmLanc_Financeiros.edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_EMPRESA.SetFocus;
end;

procedure TfrmLanc_Financeiros.edDATATyping(Sender: TObject);
begin
  Formatar(edDATA,Dt);
end;

procedure TfrmLanc_Financeiros.edDESCONTOChange(Sender: TObject);
begin
  edDESCONTO.TagFloat := StrToFloatDef(Trim(StringReplace(edDESCONTO.Text,'R$','',[rfReplaceAll])),0);
end;

procedure TfrmLanc_Financeiros.edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edJUROS.SetFocus;

end;

procedure TfrmLanc_Financeiros.edDESCONTOTyping(Sender: TObject);
begin
  Formatar(edDESCONTO,Money);
end;

procedure TfrmLanc_Financeiros.edDT_PAGAMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCONTO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edDT_PAGAMENTOTyping(Sender: TObject);
begin
  Formatar(edDT_PAGAMENTO,Dt);
end;

procedure TfrmLanc_Financeiros.edDT_VENCIMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR.SetFocus;

end;

procedure TfrmLanc_Financeiros.edDT_VENCIMENTOTyping(Sender: TObject);
begin
  Formatar(edDT_VENCIMENTO,Dt);
end;

procedure TfrmLanc_Financeiros.edFiltro_Cliente_IDChange(Sender: TObject);
begin
  if Trim(edFiltro_Cliente_ID.Text) = '' then
  begin
    edFiltro_Cliente.Text := '';
    lbFiltroPessoa.Tag := -1;
    lbFiltroPessoa.Text := 'Pessoa';
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFiltro_Cliente_IDExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      edFiltro_Cliente.Text := '';

      if Trim(edFiltro_Cliente_ID.Text) = '' then
        Exit;

      
      case cbFiltro_Tipo_DC.ItemIndex of
        1:FDm_Global.Listar_Cliente(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);
        2:FDm_Global.Listar_Fornecedor(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);
      end;

      if not FQuery.IsEmpty then
        edFiltro_Cliente.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    cbFiltro_Tipo_DC.SetFocus;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_FChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFiltro_Empresa_ID.SetFocus;

end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_FTyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_F,Dt);
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_IChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFIltro_Dt_F.SetFocus;

end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_ITyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_I,Dt);
end;

procedure TfrmLanc_Financeiros.edFiltro_Empresa_IDChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFiltro_Empresa_IDExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try

      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      edFiltro_Empresa.Text := '';           
      if Trim(edFiltro_Empresa_ID.Text) = '' then
        Exit;
              
      FDm_Global.Listar_Empresa(edFiltro_Empresa_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Empresa.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFiltro_Cliente_ID.SetFocus;

end;

procedure TfrmLanc_Financeiros.edID_CONTAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edID_CONTA.Text) = '' then
        Exit;

      FDm_Global.Listar_Contas(edID_CONTA.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
      begin
        edID_CONTA_Desc.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edConta_Tipo.Tag := FQuery.FieldByName('TIPO').AsInteger;
        case FQuery.FieldByName('TIPO').AsInteger of
          0:edConta_Tipo.Text := 'RECEBER';
          1:edConta_Tipo.Text := 'PAGAR';
        end;
      end;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_PESSOA.SetFocus;

end;

procedure TfrmLanc_Financeiros.edID_EMPRESAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edID_EMPRESA.Text) = '' then
        Exit;

      FDm_Global.Listar_Empresa(edID_EMPRESA.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_EMPRESA_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CONTA.SetFocus;

end;

procedure TfrmLanc_Financeiros.edID_PESSOAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      edFiltro_Cliente.Text := '';

      if Trim(edFiltro_Cliente_ID.Text) = '' then
        Exit;


      case edConta_Tipo.Tag of
        1:FDm_Global.Listar_Cliente(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);
        2:FDm_Global.Listar_Fornecedor(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);
      end;

      if not FQuery.IsEmpty then
        edFiltro_Cliente.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.edID_PESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDT_VENCIMENTO.SetFocus;

end;

procedure TfrmLanc_Financeiros.Editar(Sender :TObject);
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      if FDQRegistros.FieldByName('ORIGEM_LANCAMENTO').AsString = 'PROPRIO' then
      begin
        FFancyDialog.Show(TIconDialog.Question,'Atenção','Não será possível EDITAR o registro, pois não é de lançamento PRÓPRIO','SIM',Editando_Lancamento,'NÃO');
      end
      else
        Editando_Lancamento(Sender);
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmLanc_Financeiros.edJUROSChange(Sender: TObject);
begin
  edJUROS.TagFloat := StrToFloatDef(Trim(StringReplace(edJUROS.Text,'R$','',[rfReplaceAll])),0);
end;

procedure TfrmLanc_Financeiros.edJUROSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR_PAGO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edJUROSTyping(Sender: TObject);
begin
  Formatar(edJUROS,Money);
end;

procedure TfrmLanc_Financeiros.edSTATUSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_EMPRESA.SetFocus;

end;

procedure TfrmLanc_Financeiros.edVALORChange(Sender: TObject);
begin
  edVALOR.TagFloat := StrToFloatDef(Trim(StringReplace(edVALOR.Text,'R$','',[rfReplaceAll])),0);
end;

procedure TfrmLanc_Financeiros.edVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDT_PAGAMENTO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edVALORTyping(Sender: TObject);
begin
  Formatar(edVALOR,Money)
end;

procedure TfrmLanc_Financeiros.edVALOR_PAGOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edOBSERVACAO.SetFocus;

end;

procedure TfrmLanc_Financeiros.edVALOR_PAGOTyping(Sender: TObject);
begin
  Formatar(edVALOR_PAGO,Money);
end;

procedure TfrmLanc_Financeiros.Excluir(Sender: TObject);
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

      {$Region 'Verifica se o Lançamento pode ser excluído'}
        FQuery.Active := False;
        FQuery.SQL.Clear;
        FQuery.SQL.Add('SELECT * FROM LANCAMENTOS WHERE ID = :ID AND ORIGEM_LANCAMENTO <> ''PROPRIO'' ');
        FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
        FQuery.Active := True;
        if not FQuery.IsEmpty then
          raise Exception.Create('Lançamento não tem origem PRÓPRIO. Não erá possível excluir.');
      {$Region 'Verifica se o Lançamento pode ser excluído'}


      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM LANCAMENTOS WHERE ID = :ID AND ORIGEM_LANCAMENTO = ''PROPRIO'' ');
      FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

      //PROPRIO

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

procedure TfrmLanc_Financeiros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.CaFree;
  frmLanc_Financeiros := Nil;
end;

procedure TfrmLanc_Financeiros.FormCreate(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  lytFormulario.Align := TAlignLayout.Center;
  try
    FDm_Global := TDM_Global.Create(Nil);
    FDQRegistros.Connection := FDm_Global.FDC_Firebird;

    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_Firebird;

    with TFuncoes.Datas(Date) do
    begin
      edFIltro_Dt_I.Text := DateToStr(PrimeiroDia);
      edFIltro_Dt_F.Text := DateToStr(UltimoDia);
    end;
    if frmPrincipal.FUser_Empresa > 0 then
    begin
      edFiltro_Empresa_ID.Text := IntToStr(frmPrincipal.FUser_Empresa);
      FDm_Global.Listar_Empresa(frmPrincipal.FUser_Empresa,'',FQuery);
      if not FQuery.IsEmpty then
        edFiltro_Empresa.Text := FQuery.FieldByName('NOME').AsString;
    end;

    FFancyDialog := TFancyDialog.Create(frmLanc_Financeiros);
    FEnder := '';
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
    FIniFile := TIniFile.Create(FEnder);

    tcPrincipal.ActiveTab := tiLista;

    Selecionar_Registros;
    Configura_Botoes;

    rctMenu.Width := 0;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.Salvar;
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

      FQuery.Active := False;
      FQuery.Sql.Clear;
      case FTab_Status of
        dsInsert :begin
          FQuery.Active := False;
          FQuery.SQL.Clear;
          FQuery.SQL.Add('SELECT GEN_ID(GEN_LANCAMENTOS_ID,1) AS SEQ FROM RDB$DATABASE;');
          FQuery.Active := True;
          if not FQuery.IsEmpty then
            FId := FQuery.FieldByName('SEQ').AsInteger;

          FQuery.Active := False;
          FQuery.Sql.Clear;
          FQuery.Sql.Add('INSERT INTO LANCAMENTOS( ');
          FQuery.Sql.Add('  ID ');
          FQuery.Sql.Add('  ,ID_EMPRESA ');
          FQuery.Sql.Add('  ,DT_EMISSAO ');
          FQuery.Sql.Add('  ,ID_CONTA ');
          FQuery.Sql.Add('  ,ID_PESSOA ');
          FQuery.Sql.Add('  ,STATUS ');
          FQuery.Sql.Add('  ,DT_VENCIMENTO ');
          FQuery.Sql.Add('  ,VALOR ');
          FQuery.Sql.Add('  ,ORIGEM_LANCAMENTO ');
          FQuery.Sql.Add('  ,ID_ORIGEM_LANCAMENTO ');
          FQuery.Sql.Add('  ,ID_USUARIO ');
          FQuery.Sql.Add('  ,OBSERVACAO ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :ID ');
          FQuery.Sql.Add('  ,:ID_EMPRESA ');
          FQuery.Sql.Add('  ,:DT_EMISSAO ');
          FQuery.Sql.Add('  ,:ID_CONTA ');
          FQuery.Sql.Add('  ,:ID_PESSOA ');
          FQuery.Sql.Add('  ,:STATUS ');
          FQuery.Sql.Add('  ,:DT_VENCIMENTO ');
          FQuery.Sql.Add('  ,:VALOR ');
          FQuery.Sql.Add('  ,:ORIGEM_LANCAMENTO ');
          FQuery.Sql.Add('  ,:ID_ORIGEM_LANCAMENTO ');
          FQuery.Sql.Add('  ,:ID_USUARIO ');
          FQuery.Sql.Add('  ,:OBSERVACAO ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
          FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
        end;
        dsEdit :begin
          FId := StrToIntDef(edID.Text,0);
          FQuery.Sql.Add('UPDATE LANCAMENTOS SET ');
          FQuery.Sql.Add('  ID_EMPRESA = :ID_EMPRESA ');
          FQuery.Sql.Add('  ,DT_EMISSAO = :DT_EMISSAO ');
          FQuery.Sql.Add('  ,ID_CONTA = :ID_CONTA ');
          FQuery.Sql.Add('  ,ID_PESSOA = :ID_PESSOA ');
          FQuery.Sql.Add('  ,STATUS = :STATUS ');
          FQuery.Sql.Add('  ,DT_VENCIMENTO = :DT_VENCIMENTO ');
          FQuery.Sql.Add('  ,VALOR = :VALOR ');
          FQuery.Sql.Add('  ,DT_PAGAMENTO = :DT_PAGAMENTO ');
          FQuery.Sql.Add('  ,DESCONTO = :DESCONTO ');
          FQuery.Sql.Add('  ,JUROS = :JUROS ');
          FQuery.Sql.Add('  ,VALOR_PAGO = :VALOR_PAGO ');
          FQuery.Sql.Add('  ,OBSERVACAO = :OBSERVACAO ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := FId;
          FId := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edID_EMPRESA.Text,0);;
      FQuery.ParamByName('DT_EMISSAO').AsDate := StrToDateDef(edDATA.Text,Date);
      FQuery.ParamByName('ID_CONTA').AsInteger := StrToIntDef(edID_CONTA.Text,0);
      FQuery.ParamByName('ID_PESSOA').AsInteger := StrToIntDef(edID_PESSOA.Text,0);;
      FQuery.ParamByName('STATUS').AsInteger := 0;  //0-Aberto, 1-pago
      FQuery.ParamByName('DT_VENCIMENTO').AsDate := StrToDateDef(edDT_VENCIMENTO.Text,Date); //Calcular
      FQuery.ParamByName('VALOR').AsFloat := edVALOR.TagFloat;
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'PROPRIO';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := FId;
      FQuery.ParamByName('OBSERVACAO').AsString := edOBSERVACAO.Text;
      FQuery.ParamByName('DT_PAGAMENTO').AsDate := StrToDateDef(edDT_PAGAMENTO.Text,Date); //Calcular
      FQuery.ParamByName('DESCONTO').AsFloat := edDESCONTO.TagFloat;
      FQuery.ParamByName('JUROS').AsFloat := edJUROS.TagFloat;
      FQuery.ParamByName('VALOR_PAGO').AsFloat := edVALOR_PAGO.TagFloat;
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

procedure TfrmLanc_Financeiros.Selecionar_Registros;
var
  FDQ_Total :TFDQuery;
begin
  try
    try
      FDQ_Total := TFDQuery.Create(Nil);
      FDQ_Total.Connection := FDm_Global.FDC_Firebird;

      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  L.* ');
      FDQRegistros.SQL.Add('  ,E.NOME AS EMPRESA ');
      FDQRegistros.SQL.Add('  ,C.DESCRICAO AS CONTA ');
      FDQRegistros.SQL.Add('  ,C.TIPO AS TIPO_CONTA ');
      FDQRegistros.SQL.Add('  ,CASE C.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''CRÉDITO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''DÉBITO'' ');
      FDQRegistros.SQL.Add('  END TIPO_CONTA_DESC ');
      FDQRegistros.SQL.Add('  ,CASE C.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN CL.NOME ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN F.NOME ');
      FDQRegistros.SQL.Add('  END PESSOA ');
      FDQRegistros.SQL.Add('  ,CASE L.STATUS ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''ABERTO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''PAGO'' ');
      FDQRegistros.SQL.Add('  END STATUS_DESC ');
      FDQRegistros.SQL.Add('  ,U.NOME AS USUARIO ');
      FDQRegistros.SQL.Add('FROM LANCAMENTOS L ');
      FDQRegistros.SQL.Add('  JOIN EMPRESA E ON E.ID = L.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  JOIN CONTA C ON C.ID = L.ID_CONTA ');
      FDQRegistros.SQL.Add('  LEFT JOIN CLIENTE CL ON CL.ID = L.ID_PESSOA ');
      FDQRegistros.SQL.Add('  LEFT JOIN FORNECEDOR F ON F.ID = L.ID_PESSOA ');
      FDQRegistros.SQL.Add('  JOIN USUARIO U ON U.ID = L.ID_USUARIO ');
      FDQRegistros.SQL.Add('WHERE NOT L.ID IS NULL ');
      case cbFiltro_Tipo_Periodo.ItemIndex of
        0:FDQRegistros.SQL.Add('  AND L.DT_EMISSAO BETWEEN :DATA_I AND :DATA_F ');
        1:FDQRegistros.SQL.Add('  AND L.DT_VENCIMENTO BETWEEN :DATA_I AND :DATA_F ');
      end;
      if Trim(edFiltro_Empresa_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND L.ID_EMPRESA = :ID_EMPRESA');
        FDQRegistros.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
      end;
      if Trim(edFiltro_Cliente_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND L.ID_PESSOA = :ID_PESSOA');
        FDQRegistros.ParamByName('ID_PESSOA').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
      end;
      case cbFiltro_Tipo_DC.ItemIndex of
        1:FDQRegistros.SQL.Add('  AND C.TIPO = 0');
        2:FDQRegistros.SQL.Add('  AND C.TIPO = 1');
      end;
      if imgFiltro_Aberto.Tag = 0 then
        FDQRegistros.SQL.Add('  AND L.STATUS <> 0');
      if imgFiltro_Pago.Tag = 0 then
        FDQRegistros.SQL.Add('  AND L.STATUS <> 1');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  L.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  ,C.TIPO ');
      case cbFiltro_Tipo_Periodo .ItemIndex of
        0:FDQRegistros.SQL.Add('  ,L.DT_EMISSAO; ');
        1:FDQRegistros.SQL.Add('  ,L.DT_VENCIMENTO; ');
      end;
      FDQRegistros.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
      FDQRegistros.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
      FDQRegistros.Active := True;

      (*
      {$Region 'Totalizando'}
        FDQ_Total.Active := False;
        FDQ_Total.Sql.Clear;
        FDQ_Total.Sql.Add('SELECT ');
        FDQ_Total.Sql.Add('  LPAD(DATEDIFF(HOUR,CAST(CURRENT_DATE AS TIMESTAMP),D.DH),3,''0'') || '':'' || ');
        FDQ_Total.Sql.Add('  LPAD(EXTRACT(MINUTE FROM D.DH),2,''0'') || '':'' || ');
        FDQ_Total.Sql.Add('  LPAD(CAST(EXTRACT(SECOND FROM D.DH) AS INTEGER),2,''0'') AS HORA');
        FDQ_Total.Sql.Add('  ,D.TOTAL ');
        FDQ_Total.Sql.Add('FROM ( ');
        FDQ_Total.Sql.Add('  SELECT ');
        FDQ_Total.Sql.Add('    DATEADD(HOUR,C.HORA,C.DM) AS DH ');
        FDQ_Total.Sql.Add('    ,C.TOTAL ');
        FDQ_Total.Sql.Add('  FROM ( ');
        FDQ_Total.Sql.Add('    SELECT ');
        FDQ_Total.Sql.Add('      B.HORA ');
        FDQ_Total.Sql.Add('      ,DATEADD(MINUTE,B.MINUTO,B.DS) DM ');
        FDQ_Total.Sql.Add('      ,B.TOTAL ');
        FDQ_Total.Sql.Add('    FROM ( ');
        FDQ_Total.Sql.Add('      SELECT ');
        FDQ_Total.Sql.Add('        A.HORA ');
        FDQ_Total.Sql.Add('        ,A.MINUTO ');
        FDQ_Total.Sql.Add('        ,DATEADD(SECOND, A.SEGUNDO, CAST(CURRENT_DATE AS TIMESTAMP)) AS DS ');
        FDQ_Total.Sql.Add('        ,A.TOTAL ');
        FDQ_Total.Sql.Add('      FROM ( ');
        FDQ_Total.Sql.Add('        SELECT ');
				FDQ_Total.Sql.Add('	      	 SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
				FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 2) ');
				FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 3) ');
				FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS HORA ');
				FDQ_Total.Sql.Add('	      	 ,SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
				FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 4 FOR 2) ');
				FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 5 FOR 2) ');
				FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS MINUTO ');
				FDQ_Total.Sql.Add('	      	 ,SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
				FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 7 FOR 2) ');
				FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 8 FOR 2) ');
				FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS SEGUNDO ');
        FDQ_Total.Sql.Add('          ,SUM(SP.TOTAL) AS TOTAL ');
        FDQ_Total.Sql.Add('        FROM SERVICOS_PRESTADOS SP ');
        FDQ_Total.SQL.Add('        WHERE NOT SP.ID IS NULL ');
        FDQ_Total.SQL.Add('          AND SP.DATA BETWEEN :DATA_I AND :DATA_F ');
        if Trim(edFiltro_Empresa_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('          AND SP.ID_EMPRESA = :ID_EMPRESA');
          FDQ_Total.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
        end;
        if Trim(edFiltro_Cliente_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('          AND SP.ID_CLIENTE = :ID_CLIENTE');
          FDQ_Total.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
        end;
        FDQ_Total.SQL.Add(') A) B) C) D; ');
        FDQ_Total.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
        FDQ_Total.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
        FDQ_Total.Active := True;
        if not FDQ_Total.IsEmpty then
        begin
          //
        end;
      {$EndRegion 'Totalizando'}
      *)
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
    FreeAndNil(FDQ_Total);
  end;
end;

procedure TfrmLanc_Financeiros.Cancelar;
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

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_DCChange(Sender: TObject);
begin
  edFiltro_Cliente_ID.Text := '';
  edFiltro_Cliente.Text := '';
  
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_DCKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    cbFiltro_Tipo_Periodo.SetFocus;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_PeriodoChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_PeriodoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFIltro_Dt_I.SetFocus;

end;

procedure TfrmLanc_Financeiros.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmLanc_Financeiros.imgFecharClick(Sender: TObject);
begin
  Close
end;

procedure TfrmLanc_Financeiros.imgFiltro_AbertoClick(Sender: TObject);
begin
  case imgFiltro_Aberto.Tag of
    0:begin
      imgFiltro_Aberto.Tag := 1;
      imgFiltro_Aberto.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Aberto.Tag := 0;
      imgFiltro_Aberto.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.imgFiltro_ClienteClick(Sender: TObject);
begin
  if NOT Assigned(frmPesq_Pessoas) then
    Application.CreateForm(TfrmPesq_Pessoas,frmPesq_Pessoas);

  frmPesq_Pessoas.TipoFiltro := cbFiltro_Tipo_DC.ItemIndex;

  frmPesq_Pessoas.ExecuteOnClose := Sel_Pessoa;
  frmPesq_Pessoas.Height := frmPrincipal.Height;
  frmPesq_Pessoas.Width := frmPrincipal.Width;

  frmPesq_Pessoas.Show;

end;

procedure TfrmLanc_Financeiros.imgFiltro_EmpresaClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmLanc_Financeiros.Sel_Empresa(Aid: Integer; ANome: String);
begin
  edID_EMPRESA_Desc.Text := ANome;

  if edFiltro_Empresa_ID.CanFocus then
    edFiltro_Empresa_ID.SetFocus;
end;

procedure TfrmLanc_Financeiros.imgFiltro_PagoClick(Sender: TObject);
begin
  case imgFiltro_Pago.Tag of
    0:begin
      imgFiltro_Pago.Tag := 1;
      imgFiltro_Pago.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Pago.Tag := 0;
      imgFiltro_Pago.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.imgID_CONTAClick(Sender: TObject);
begin
//Aid:Integer; ADescricao:String; ATipo:Integer
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas, frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_Conta;
  frmCad_Contas.Height := frmPrincipal.Height;
  frmCad_Contas.Width := frmPrincipal.Width;

  frmCad_Contas.Show;
end;

procedure TfrmLanc_Financeiros.Sel_Conta(Aid:Integer; ADescricao:String; ATipo:Integer);
begin
  edID_CONTA.Text := Aid.ToString;
  edID_CONTA_Desc.Text := ADescricao;
  edConta_Tipo.Tag := ATipo;

  case ATipo of
    0:edConta_Tipo.Text := 'RECEBER';
    1:edConta_Tipo.Text := 'PAGAR';
  end;
end;

procedure TfrmLanc_Financeiros.imgID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmLanc_Financeiros.imgID_PESSOAClick(Sender: TObject);
begin
  if NOT Assigned(frmPesq_Pessoas) then
    Application.CreateForm(TfrmPesq_Pessoas,frmPesq_Pessoas);

  frmPesq_Pessoas.TipoFiltro := (edConta_Tipo.Tag + 1);

  frmPesq_Pessoas.ExecuteOnClose := Sel_Pessoa;
  frmPesq_Pessoas.Height := frmPrincipal.Height;
  frmPesq_Pessoas.Width := frmPrincipal.Width;

  frmPesq_Pessoas.Show;
end;

procedure TfrmLanc_Financeiros.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;
      Limpar_Campos;

      edDATA.Text := DateToStr(Date);
      edSTATUS.ItemIndex := 0;

      tcPrincipal.GotoVisibleTab(1);
      if edDATA.CanFocus then
        edDATA.SetFocus;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmLanc_Financeiros.Limpar_Campos;
begin
  edID.Text := '';
  edDATA.Text := '';
  edSTATUS.ItemIndex := -1;
  edID_EMPRESA.Text := '';
  edID_EMPRESA_Desc.Text := '';
  edID_CONTA.Text := '';
  edID_CONTA_Desc.Text := '';
  edConta_Tipo.Tag := -1;
  edConta_Tipo.Text := '';
  edID_PESSOA.Text := '';
  edID_PESSOA_Desc.Text := '';
  edDT_VENCIMENTO.Text := '';
  edVALOR.Text := '';
  edDT_PAGAMENTO.Text := '';
  edDESCONTO.Text := '';
  edJUROS.Text := '';
  edVALOR_PAGO.Text := '';
  edOBSERVACAO.Text := '';
end;

procedure TfrmLanc_Financeiros.Editando_Lancamento(Sender :TOBject);
begin
  edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
  edDATA.Text := FDQRegistros.FieldByName('DT_EMISSAO').AsString;
  edSTATUS.ItemIndex := FDQRegistros.FieldByName('STATUS').AsInteger;
  edID_EMPRESA.Text := FDQRegistros.FieldByName('ID_EMPRESA').AsString;
  edID_CONTA.Text := FDQRegistros.FieldByName('ID_CONTA').AsString;
  edID_PESSOA.Text := FDQRegistros.FieldByName('ID_PESSOA').AsString;
  edDT_VENCIMENTO.Text := FDQRegistros.FieldByName('DT_VENCIMENTO').AsString;
  edVALOR.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VALOR').AsFloat);
  edVALOR.TagFloat := FDQRegistros.FieldByName('VALOR').AsFloat;
  edDT_PAGAMENTO.Text := FDQRegistros.FieldByName('DT_PAGAMENTO').AsString;
  edDESCONTO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('DESCONTO').AsFloat);
  edDESCONTO.TagFloat := FDQRegistros.FieldByName('DESCONTO').AsFloat;
  edJUROS.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('JUROS').AsFloat);
  edJUROS.TagFloat := FDQRegistros.FieldByName('JUROS').AsFloat;
  edVALOR_PAGO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VALOR_PAGO').AsFloat);
  edVALOR_PAGO.TagFloat := FDQRegistros.FieldByName('VALOR_PAGO').AsFloat;
  edOBSERVACAO.Text := FDQRegistros.FieldByName('OBSERVACAO').AsString;
  FTab_Status := TTab_Status.dsEdit;
  tcPrincipal.GotoVisibleTab(1);
  if edDATA.CanFocus then
    edDATA.SetFocus;
end;

procedure TfrmLanc_Financeiros.Menu(Sender: TOBject);
begin

end;

procedure TfrmLanc_Financeiros.rctCancelarClick(Sender: TObject);
begin
  try
    try
      case TRectangle(Sender).Tag of
        0:Incluir;
        1:Editar(Sender);
        2:Salvar;
        3:Cancelar;
        4:FFancyDialog.Show(TIconDialog.Question,'Excluir','Deseja Excluir o registro selecionado?','Sim',Excluir,'Não') ;
        5:Menu(Sender);
      end;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
    end;
  finally
    Configura_Botoes;
  end;
end;

procedure TfrmLanc_Financeiros.Sel_Pessoa(ATipo:String; Aid:Integer; ANome:String; ADocumento:String);
begin
  lbFiltroPessoa.Text := ATipo;
  if ATipo = 'Cliente' then
    lbFiltroPessoa.Tag := 0
  else if ATipo = 'Fornecedor' then
    lbFiltroPessoa.Tag := 1;

  edID_PESSOA.Text := Aid.ToString;
  edID_PESSOA_Desc.Text := ANome;
end;

end.
