unit uMov.ServicosPrestados;

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
  uDm.Global,
  uFuncoes,

  uCad.TabPrecos, FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox, FMX.dxGrid, FMX.dxControlUtils, FMX.dxControls,
  FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts;

type
  TTab_Status = (dsInsert,dsEdit);

  TfrmMov_ServicosPrestados = class(TForm)
    OpenDialog: TOpenDialog;
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
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
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosDESCRICAO: TStringField;
    FDQRegistrosSTATUS: TIntegerField;
    FDQRegistrosID_EMPRESA: TIntegerField;
    FDQRegistrosID_PRESTADOR_SERVICO: TIntegerField;
    FDQRegistrosID_CLIENTE: TIntegerField;
    FDQRegistrosID_TABELA: TIntegerField;
    FDQRegistrosDATA: TDateField;
    FDQRegistrosHR_INICIO: TTimeField;
    FDQRegistrosHR_FIM: TTimeField;
    FDQRegistrosHR_TOTAL: TTimeField;
    FDQRegistrosVLR_HORA: TFMTBCDField;
    FDQRegistrosSUB_TOTAL: TFMTBCDField;
    FDQRegistrosDESCONTO: TFMTBCDField;
    FDQRegistrosDESCONTO_MOTIVO: TStringField;
    FDQRegistrosACRESCIMO: TFMTBCDField;
    FDQRegistrosACRESCIMO_MOTIVO: TStringField;
    FDQRegistrosTOTAL: TFMTBCDField;
    FDQRegistrosOBSERVACAO: TStringField;
    FDQRegistrosDT_PAGO: TDateField;
    FDQRegistrosVLR_PAGO: TFMTBCDField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosID_USUARIO: TIntegerField;
    FDQRegistrosSTATUS_DESC: TStringField;
    FDQRegistrosEMPRESA: TStringField;
    FDQRegistrosPRESTAOR_SERVICO: TStringField;
    FDQRegistrosCLIENTE: TStringField;
    FDQRegistrosTABELA: TStringField;
    FDQRegistrosTABELA_TIPO: TStringField;
    FDQRegistrosVALOR: TFMTBCDField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCRICAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_PRESTADOR_SERVICO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_CLIENTE: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_TABELA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DATA: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_INICIO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_FIM: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_TOTAL: TdxfmGridColumn;
    dxfmGrid1RootLevel1VLR_HORA: TdxfmGridColumn;
    dxfmGrid1RootLevel1SUB_TOTAL: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO_MOTIVO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ACRESCIMO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ACRESCIMO_MOTIVO: TdxfmGridColumn;
    dxfmGrid1RootLevel1TOTAL: TdxfmGridColumn;
    dxfmGrid1RootLevel1OBSERVACAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_PAGO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VLR_PAGO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_USUARIO: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1PRESTAOR_SERVICO: TdxfmGridColumn;
    dxfmGrid1RootLevel1CLIENTE: TdxfmGridColumn;
    dxfmGrid1RootLevel1TABELA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TABELA_TIPO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
    edDATA: TEdit;
    lytRow_003: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA_Desc: TEdit;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_004: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO_Desc: TEdit;
    edID_PRESTADOR_SERVICO: TEdit;
    imgID_PRESTADOR_SERVICO: TImage;
    lytRow_005: TLayout;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE_Desc: TEdit;
    edID_CLIENTE: TEdit;
    imgID_CLIENTE: TImage;
    lytRow_006: TLayout;
    lbID_TABELA: TLabel;
    edID_TABELA_Desc: TEdit;
    edID_TABELA: TEdit;
    imgID_TABELA: TImage;
    edID_TABELA_Valor: TEdit;
    edID_TABELA_Tipo: TEdit;
    lytRow_007: TLayout;
    lbHR_INICIO: TLabel;
    edHR_INICIO: TEdit;
    edHR_FIM: TEdit;
    lbHR_FIM: TLabel;
    edHR_TOTAL: TEdit;
    lbHR_TOTAL: TLabel;
    lbVLR_HORA: TLabel;
    edVLR_HORA: TEdit;
    lytRow_008: TLayout;
    lbSUB_TOTAL: TLabel;
    edSUB_TOTAL: TEdit;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lbACRESCIMO: TLabel;
    edACRESCIMO: TEdit;
    lbTOTAL: TLabel;
    edTOTAL: TEdit;
    lytRow_009: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_010: TLayout;
    lbDT_PAGO: TLabel;
    edDT_PAGO: TEdit;
    lbVLR_PAGO: TLabel;
    edVLR_PAGO: TEdit;
    rctPagamento: TRectangle;
    imPagamento: TImage;
    rctTotaisHoras: TRectangle;
    lbTotalHoras_Tit: TLabel;
    lbTotalHoras: TLabel;
    rctTotalReceber: TRectangle;
    lbTotalReceber_Tit: TLabel;
    lbTotalReceber: TLabel;
    lytFiltro_Periodo: TLayout;
    lytFiltro_Empresa: TLayout;
    lytFiltro_Prestador: TLayout;
    lytFiltro_Cliente: TLayout;
    lbFiltro_Periodo_Tit: TLabel;
    lytFiltro_Cliente_Tit: TLabel;
    lytFiltro_Empresa_Tit: TLabel;
    lytFiltro_Prestador_Filtro: TLabel;
    lbFiltro_Data_A: TLabel;
    edFiltro_Empresa_ID: TEdit;
    imgFiltro_Empresa: TImage;
    edFiltro_Empresa: TEdit;
    edFiltro_Cliente_ID: TEdit;
    imgFiltro_Cliente: TImage;
    edFiltro_Cliente: TEdit;
    edFiltro_Prestador_ID: TEdit;
    imgFiltro_Prestador: TImage;
    edFiltro_Prestador: TEdit;
    rctFiltro_Periodo: TRectangle;
    rctFiltro_Cliente: TRectangle;
    rctFiltro_Empresa: TRectangle;
    rctFiltro_Prestador: TRectangle;
    edFIltro_Dt_I: TEdit;
    edFIltro_Dt_F: TEdit;
    procedure edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_PRESTADOR_SERVICOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edID_CLIENTEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_TABELAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edHR_INICIOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edHR_FIMKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSUB_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edACRESCIMOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edOBSERVACAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDATATyping(Sender: TObject);
    procedure edHR_INICIOTyping(Sender: TObject);
    procedure edHR_FIMTyping(Sender: TObject);
    procedure edSUB_TOTALTyping(Sender: TObject);
    procedure edDESCONTOTyping(Sender: TObject);
    procedure edACRESCIMOTyping(Sender: TObject);
    procedure imgID_EMPRESAClick(Sender: TObject);
    procedure imgID_PRESTADOR_SERVICOClick(Sender: TObject);
    procedure imgID_CLIENTEClick(Sender: TObject);
    procedure imgID_TABELAClick(Sender: TObject);
    procedure edHR_INICIOChange(Sender: TObject);
    procedure edSUB_TOTALChange(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure edID_TABELAChangeTracking(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edID_CLIENTEExit(Sender: TObject);
    procedure edID_EMPRESAExit(Sender: TObject);
    procedure edID_PRESTADOR_SERVICOExit(Sender: TObject);
    procedure edID_TABELAExit(Sender: TObject);
    procedure imgFiltro_EmpresaClick(Sender: TObject);
    procedure edFiltro_Empresa_IDExit(Sender: TObject);
    procedure imgFiltro_PrestadorClick(Sender: TObject);
    procedure edFiltro_Prestador_IDExit(Sender: TObject);
    procedure imgFiltro_ClienteClick(Sender: TObject);
    procedure edFiltro_Cliente_IDExit(Sender: TObject);
    procedure edFIltro_Dt_ITyping(Sender: TObject);
    procedure edFIltro_Dt_FTyping(Sender: TObject);
    procedure edFIltro_Dt_IExit(Sender: TObject);
    procedure edFIltro_Dt_FExit(Sender: TObject);
    procedure edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFiltro_Prestador_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    FPesquisa: Boolean;

    procedure Sel_Empresa(Aid: Integer; ANome: String);
    procedure Sel_Empresa_Filtro(Aid: Integer; ANome: String);
    procedure Sel_PrestServicos(Aid: Integer; ANome: String);
    procedure Sel_PrestServicos_Filtro(Aid: Integer; ANome: String);
    procedure Sel_Cliente(Aid: Integer; ANome: String);
    procedure Sel_Cliente_Filtro(Aid: Integer; ANome: String);
    procedure Sel_TabPrecos(Aid: Integer; ADescricao: String; ATipo: Integer; AValor: Double);

    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Selecionar_Registros;
    procedure Configura_Botoes;
    procedure Limpar_Campos;
    procedure SetPesquisa(const Value: Boolean);
    procedure TThreadEnd_CalcHora(Sender: TObject);
    procedure TThreadEnd_CalculaValor(Sender: TOBject);
    procedure Baixar_Servico(Sender: TOBject);
    procedure Lancar_ContasReceber(AId:Integer);
  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmMov_ServicosPrestados: TfrmMov_ServicosPrestados;

implementation

{$R *.fmx}

uses
  uCad.Empresa
  ,uCad.PrestServico
  ,uCad.Cliente;

procedure TfrmMov_ServicosPrestados.Cancelar;
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

procedure TfrmMov_ServicosPrestados.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmMov_ServicosPrestados.edACRESCIMOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edOBSERVACAO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edACRESCIMOTyping(Sender: TObject);
begin
  Formatar(edACRESCIMO,Money);
end;

procedure TfrmMov_ServicosPrestados.edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCRICAO.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edDATATyping(Sender: TObject);
begin
  Formatar(edDATA,Dt);
end;

procedure TfrmMov_ServicosPrestados.edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edACRESCIMO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edDESCONTOTyping(Sender: TObject);
begin
  Formatar(edDESCONTO,Money);
end;

procedure TfrmMov_ServicosPrestados.edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_EMPRESA.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edFiltro_Cliente_IDExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edFiltro_Cliente_ID.Text) = '' then
        Exit;

      FDm_Global.Listar_Cliente(edFiltro_Cliente_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Cliente.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
    Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Cliente_IDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edFIltro_Dt_I.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Empresa_IDExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try

      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if edFiltro_Empresa_ID.Text = '' then
        Exit;

      FDm_Global.Listar_Empresa(edFiltro_Empresa_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Empresa.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
    Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Empresa_IDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edFiltro_Prestador_ID.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Prestador_IDExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if Trim(edFiltro_Prestador_ID.Text) = '' then
        Exit;

      FDm_Global.Listar_PrestadorServico(edFiltro_Prestador_ID.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edFiltro_Prestador.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
    Selecionar_Registros;
  end;
end;

procedure TfrmMov_ServicosPrestados.edFiltro_Prestador_IDKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edFiltro_Cliente_ID.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edHR_FIMKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edSUB_TOTAL.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edHR_FIMTyping(Sender: TObject);
begin
  Formatar(edHR_FIM,Hr);
end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOChange(Sender: TObject);
var
  t :TThread;

begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FHora :TDateTime;
    FHoraI_Valida :Boolean;
    FHoraF_Valida :Boolean;
    FHora_Resultado :TTime;
    FTotal_Receber :Double;
  begin

    FTotal_Receber := 0;

    FHoraI_Valida := TryStrToTime(edHR_INICIO.Text,FHora);
    FHoraF_Valida := TryStrToTime(edHR_FIM.Text,FHora);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      if ((FHoraI_Valida) and (FHoraF_Valida)) then
      begin
        FHora_Resultado := (StrToTimeDef(edHR_FIM.Text,Time) - StrToTimeDef(edHR_INICIO.Text,Time));
        edHR_TOTAL.Text := TimeToStr(FHora_Resultado);
        FTotal_Receber := ((FHora_Resultado * 24) * edVLR_HORA.TagFloat);
        edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00',FTotal_Receber);
        edSUB_TOTAL.TagFloat := FTotal_Receber;
        edSUB_TOTALChange(Sender);
      end;
    end);
  end);

  t.OnTerminate := TThreadEnd_CalcHora;
  t.Start;

end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_CalcHora(Sender :TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Calculando horas. ' + Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edHR_FIM.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOTyping(Sender: TObject);
begin
  Formatar(edHR_INICIO,Hr);
end;

procedure TfrmMov_ServicosPrestados.edID_CLIENTEExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_Cliente(edID_CLIENTE.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_CLIENTE_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_CLIENTEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_TABELA.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edID_EMPRESAExit(Sender: TObject);
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

procedure TfrmMov_ServicosPrestados.edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_PRESTADOR_SERVICO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edID_PRESTADOR_SERVICOExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_PrestadorServico(edID_PRESTADOR_SERVICO.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_PRESTADOR_SERVICO_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_PRESTADOR_SERVICOKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CLIENTE.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edID_TABELAChangeTracking(Sender: TObject);
var
  FSub_Total :Double;
  FDesconto :Double;
  FAcrescimo :Double;
  FTotal :Double;

begin
  FSub_Total := 0;
  FDesconto := 0;
  FAcrescimo := 0;
  FTotal := 0;

  FSub_Total := StrToFloatDef(edSUB_TOTAL.Text,0);
  FDesconto := StrToFloatDef(edDESCONTO.Text,0);
  FAcrescimo := StrToFloatDef(edACRESCIMO.Text,0);
  FTotal := ((FSub_Total + FAcrescimo) - FDesconto);

  edTOTAL.Text := FormatFloat('R$ #,##0.00',FTotal);
  edTOTAL.TagFloat := FTotal;
end;

procedure TfrmMov_ServicosPrestados.edID_TABELAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_TabelaPrecos(edID_TABELA.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
      begin
        edID_TABELA_Desc.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edID_TABELA_Valor.Text := FormatFloat('R$ #,##0.00',FQuery.FieldByName('VALOR').AsFloat);
        edID_TABELA_Valor.TagFloat := FQuery.FieldByName('VALOR').AsFloat;
        edID_TABELA_Tipo.Text := FQuery.FieldByName('TABELA_TIPO').AsString;
        edVLR_HORA.Text := FormatFloat('R$ #,##0.00',FQuery.FieldByName('VALOR').AsFloat);
        edVLR_HORA.TagFloat := FQuery.FieldByName('VALOR').AsFloat;
      end;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.edID_TABELAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edHR_INICIO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_FExit(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_FKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFiltro_Empresa_ID.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_FTyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_F,Dt);
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_IExit(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_IKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edFIltro_Dt_F.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edFIltro_Dt_ITyping(Sender: TObject);
begin
  Formatar(edFIltro_Dt_I,Dt);
end;

procedure TfrmMov_ServicosPrestados.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edDESCRICAO.Text := FDQRegistros.FieldByName('DESCRICAO').AsString;
      edSTATUS.ItemIndex := FDQRegistros.FieldByName('STATUS').AsInteger;
      edID_EMPRESA.Text := FDQRegistros.FieldByName('ID_EMPRESA').AsString;
      edID_PRESTADOR_SERVICO.Text := FDQRegistros.FieldByName('ID_PRESTADOR_SERVICO').AsString;
      edID_CLIENTE.Text := FDQRegistros.FieldByName('ID_CLIENTE').AsString;
      edID_TABELA.Text := FDQRegistros.FieldByName('ID_TABELA').AsString;
      edDATA.Text := FDQRegistros.FieldByName('DATA').AsString;
      edHR_INICIO.Text := FDQRegistros.FieldByName('HR_INICIO').AsString;
      edHR_FIM.Text := FDQRegistros.FieldByName('HR_FIM').AsString;
      edHR_TOTAL.Text := FDQRegistros.FieldByName('HR_TOTAL').AsString;
      edVLR_HORA.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VLR_HORA').AsFloat);
      edVLR_HORA.TagFloat := FDQRegistros.FieldByName('VLR_HORA').AsFloat;
      edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('SUB_TOTAL').AsFloat);
      edSUB_TOTAL.TagFloat := FDQRegistros.FieldByName('SUB_TOTAL').AsFloat;
      edDESCONTO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('DESCONTO').AsFloat);
      edDESCONTO.TagFloat := FDQRegistros.FieldByName('DESCONTO').AsFloat;
      edACRESCIMO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('ACRESCIMO').AsFloat);
      edACRESCIMO.TagFloat := FDQRegistros.FieldByName('ACRESCIMO').AsFloat;
      edTOTAL.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('TOTAL').AsFloat);
      edTOTAL.TagFloat := FDQRegistros.FieldByName('TOTAL').AsFloat;
      edOBSERVACAO.Text := FDQRegistros.FieldByName('OBSERVACAO').AsString;
      edDT_PAGO.Text := FDQRegistros.FieldByName('DT_PAGO').AsString;
      edVLR_PAGO.Text := FormatFloat('R$ #,##0.00', FDQRegistros.FieldByName('VLR_PAGO').AsFloat);
      edVLR_PAGO.TagFloat := FDQRegistros.FieldByName('VLR_PAGO').AsFloat;

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edDATA.CanFocus then
        edDATA.SetFocus;
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmMov_ServicosPrestados.edOBSERVACAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edOBSERVACAO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALChange(Sender: TObject);
var
  t :TThread;

begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FSub_Total :Double;
    FDesconto :Double;
    FAcrescimo :Double;
    FTotal :Double;
  begin
    FSub_Total := 0;
    FDesconto := 0;
    FAcrescimo := 0;
    FTotal := 0;

    edDESCONTO.TagFloat := StrToFloatDef(Trim(StringReplace(edDESCONTO.Text,'R$','',[rfReplaceAll])),0);
    edACRESCIMO.TagFloat := StrToFloatDef(Trim(StringReplace(edACRESCIMO.Text,'R$','',[rfReplaceAll])),0);

    FSub_Total := edSUB_TOTAL.TagFloat;
    FDesconto := edDESCONTO.TagFloat;
    FAcrescimo := edACRESCIMO.TagFloat;
    FTotal := ((FSub_Total + FAcrescimo) - FDesconto);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      edTOTAL.Text := FormatFloat('R$ #,##0.00',FTotal);
      edTOTAL.TagFloat := FTotal;
    end);

  end);

  t.OnTerminate := TThreadEnd_CalculaValor;
  t.Start;

end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_CalculaValor(Sender :TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'','Calculando valores. ' + Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCONTO.SetFocus;

end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALTyping(Sender: TObject);
begin
  Formatar(edSUB_TOTAL,Money);
end;

procedure TfrmMov_ServicosPrestados.Excluir(Sender: TObject);
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
      FQuery.Sql.Clear;
      FQuery.Sql.Add('DELETE FROM LANCAMENTOS ');
      FQuery.Sql.Add('WHERE ORIGEM_LANCAMENTO = :ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  AND ID_ORIGEM_LANCAMENTO = :ID_ORIGEM_LANCAMENTO; ');
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'SERVICOS_PRESTADOS';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM SERVICOS_PRESTADOS WHERE ID = :ID');
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

procedure TfrmMov_ServicosPrestados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmMov_ServicosPrestados := Nil;
end;

procedure TfrmMov_ServicosPrestados.FormCreate(Sender: TObject);
var
  FQuery :TFDQuery;
begin
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
    if frmPrincipal.FUser_Prestador > 0 then
    begin
      edFiltro_Prestador_ID.Text := IntToStr(frmPrincipal.FUser_Prestador);
      FDm_Global.Listar_PrestadorServico(frmPrincipal.FUser_Prestador,'',FQuery);
      if not FQuery.IsEmpty then
        edFiltro_Prestador.Text := FQuery.FieldByName('NOME').AsString;
    end;

    FFancyDialog := TFancyDialog.Create(frmMov_ServicosPrestados);
    FEnder := '';
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
    FIniFile := TIniFile.Create(FEnder);

    tcPrincipal.ActiveTab := tiLista;

    lytFormulario.Align := TAlignLayout.Center;

    Selecionar_Registros;
    Configura_Botoes;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMov_ServicosPrestados.imgFiltro_ClienteClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Cliente) then
    Application.CreateForm(TfrmCad_Cliente, frmCad_Cliente);

  frmCad_Cliente.Pesquisa := True;
  frmCad_Cliente.ExecuteOnClose := Sel_Cliente_Filtro;
  frmCad_Cliente.Height := frmPrincipal.Height;
  frmCad_Cliente.Width := frmPrincipal.Width;

  frmCad_Cliente.Show;

end;

procedure TfrmMov_ServicosPrestados.imgFiltro_EmpresaClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa_Filtro;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmMov_ServicosPrestados.imgFiltro_PrestadorClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_PrestServico) then
    Application.CreateForm(TfrmCad_PrestServico, frmCad_PrestServico);

  frmCad_PrestServico.Pesquisa := True;
  frmCad_PrestServico.ExecuteOnClose := Sel_PrestServicos_Filtro;
  frmCad_PrestServico.Height := frmPrincipal.Height;
  frmCad_PrestServico.Width := frmPrincipal.Width;

  frmCad_PrestServico.Show;

end;

procedure TfrmMov_ServicosPrestados.imgID_CLIENTEClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Cliente) then
    Application.CreateForm(TfrmCad_Cliente, frmCad_Cliente);

  frmCad_Cliente.Pesquisa := True;
  frmCad_Cliente.ExecuteOnClose := Sel_Cliente;
  frmCad_Cliente.Height := frmPrincipal.Height;
  frmCad_Cliente.Width := frmPrincipal.Width;

  frmCad_Cliente.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_Cliente(Aid:Integer; ANome:String);
begin
  edID_CLIENTE.Text := AId.ToString;
  edID_CLIENTE_Desc.Text := ANome;

  if edID_TABELA.CanFocus then
    edID_TABELA.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_Cliente_Filtro(Aid: Integer; ANome: String);
begin
  edFiltro_Cliente_ID.Text := AId.ToString;
  edFiltro_Cliente.Text := ANome;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.imgID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;

end;

procedure TfrmMov_ServicosPrestados.imgID_PRESTADOR_SERVICOClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_PrestServico) then
    Application.CreateForm(TfrmCad_PrestServico, frmCad_PrestServico);

  frmCad_PrestServico.Pesquisa := True;
  frmCad_PrestServico.ExecuteOnClose := Sel_PrestServicos;
  frmCad_PrestServico.Height := frmPrincipal.Height;
  frmCad_PrestServico.Width := frmPrincipal.Width;

  frmCad_PrestServico.Show;
end;

procedure TfrmMov_ServicosPrestados.imgID_TABELAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_TabPrecos) then
    Application.CreateForm(TfrmCad_TabPrecos, frmCad_TabPrecos);

  frmCad_TabPrecos.Pesquisa := True;
  frmCad_TabPrecos.ExecuteOnClose := Sel_TabPrecos;
  frmCad_TabPrecos.Height := frmPrincipal.Height;
  frmCad_TabPrecos.Width := frmPrincipal.Width;

  frmCad_TabPrecos.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_TabPrecos(Aid:Integer; ADescricao:String; ATipo:Integer; AValor:Double);
begin
  edID_TABELA.Text := Aid.ToString;
  edID_TABELA_Desc.Text := ADescricao;
  case ATipo of
    0:edID_TABELA_Tipo.Text := 'HORA';
    1:edID_TABELA_Tipo.Text := 'FIXO';
  end;
  edID_TABELA_Valor.Text := FormatFloat('R$ #,##0.00',AValor);
  edVLR_HORA.Text := FormatFloat('R$ #,##0.00',AValor);
  edVLR_HORA.TagFloat := AValor;

  if edHR_INICIO.CanFocus then
    edHR_INICIO.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_PrestServicos(Aid:Integer; ANome:String);
begin
  edID_PRESTADOR_SERVICO.Text := Aid.ToString;
  edID_PRESTADOR_SERVICO_Desc.Text := ANome;

  if edID_CLIENTE.CanFocus then
    edID_CLIENTE.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_PrestServicos_Filtro(Aid: Integer; ANome: String);
begin
  edFiltro_Prestador_ID.Text := Aid.ToString;
  edFiltro_Prestador.Text := ANome;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.Incluir;
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

procedure TfrmMov_ServicosPrestados.Limpar_Campos;
begin
  edID.Text := '';
  edDATA.Text := '';
  edSTATUS.ItemIndex := -1;
  edDESCRICAO.Text := '';
  edID_EMPRESA.Text := '';
  edID_EMPRESA_Desc.Text := '';
  edID_PRESTADOR_SERVICO.Text := '';
  edID_PRESTADOR_SERVICO_Desc.Text := '';
  edID_CLIENTE.Text := '';
  edID_CLIENTE_Desc.Text := '';
  edID_TABELA.Text := '';
  edID_TABELA_Desc.Text := '';
  edID_TABELA_Tipo.Text := '';
  edID_TABELA_Valor.Text := '';
  edHR_INICIO.Text := '';
  edHR_FIM.Text := '';
  edHR_TOTAL.Text := '';
  edVLR_HORA.Text := '';
  edSUB_TOTAL.Text := '';
  edDESCONTO.Text := '';
  edACRESCIMO.Text := '';
  edTOTAL.Text := '';
  edOBSERVACAO.Text := '';
  edDT_PAGO.Text := '';
  edVLR_PAGO.Text := '';
end;

procedure TfrmMov_ServicosPrestados.rctCancelarClick(Sender: TObject);
begin
  try
    try
      case TRectangle(Sender).Tag of
        0:Incluir;
        1:Editar;
        2:Salvar;
        3:Cancelar;
        4:FFancyDialog.Show(TIconDialog.Question,'Excluir','Deseja Excluir o registro selecionado?','Sim',Excluir,'Não') ;
        5:FFancyDialog.Show(TIconDialog.Question,'Baixar','Deseja o Serviço selecionado?','Sim',Baixar_Servico,'Não') ;
      end;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
    end;
  finally
    Configura_Botoes;
  end;
end;

procedure TfrmMov_ServicosPrestados.Baixar_Servico(Sender :TOBject);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.Salvar;
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
      FQuery.SQL.Clear;
      FQuery.SQL.Add('SELECT GEN_ID(GEN_SERVICOS_PRESTADOS_ID,1) AS SEQ FROM RDB$DATABASE;');
      FQuery.Active := True;
      if not FQuery.IsEmpty then
        FId := FQuery.FieldByName('SEQ').AsInteger;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      case FTab_Status of
        dsInsert :begin
          FQuery.Sql.Add('INSERT INTO SERVICOS_PRESTADOS( ');
          FQuery.Sql.Add('  ID ');
          FQuery.Sql.Add('  ,DESCRICAO ');
          FQuery.Sql.Add('  ,STATUS ');
          FQuery.Sql.Add('  ,ID_EMPRESA ');
          FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO ');
          FQuery.Sql.Add('  ,ID_CLIENTE ');
          FQuery.Sql.Add('  ,ID_TABELA ');
          FQuery.Sql.Add('  ,DATA ');
          FQuery.Sql.Add('  ,HR_INICIO ');
          FQuery.Sql.Add('  ,HR_FIM ');
          FQuery.Sql.Add('  ,HR_TOTAL ');
          FQuery.Sql.Add('  ,VLR_HORA ');
          FQuery.Sql.Add('  ,SUB_TOTAL ');
          FQuery.Sql.Add('  ,DESCONTO ');
          FQuery.Sql.Add('  ,DESCONTO_MOTIVO ');
          FQuery.Sql.Add('  ,ACRESCIMO ');
          FQuery.Sql.Add('  ,ACRESCIMO_MOTIVO ');
          FQuery.Sql.Add('  ,TOTAL ');
          FQuery.Sql.Add('  ,OBSERVACAO ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HR_CADASTRO ');
          FQuery.Sql.Add('  ,ID_USUARIO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :ID ');
          FQuery.Sql.Add('  ,:DESCRICAO ');
          FQuery.Sql.Add('  ,:STATUS ');
          FQuery.Sql.Add('  ,:ID_EMPRESA ');
          FQuery.Sql.Add('  ,:ID_PRESTADOR_SERVICO ');
          FQuery.Sql.Add('  ,:ID_CLIENTE ');
          FQuery.Sql.Add('  ,:ID_TABELA ');
          FQuery.Sql.Add('  ,:DATA ');
          FQuery.Sql.Add('  ,:HR_INICIO ');
          FQuery.Sql.Add('  ,:HR_FIM ');
          FQuery.Sql.Add('  ,:HR_TOTAL ');
          FQuery.Sql.Add('  ,:VLR_HORA ');
          FQuery.Sql.Add('  ,:SUB_TOTAL ');
          FQuery.Sql.Add('  ,:DESCONTO ');
          FQuery.Sql.Add('  ,:DESCONTO_MOTIVO ');
          FQuery.Sql.Add('  ,:ACRESCIMO ');
          FQuery.Sql.Add('  ,:ACRESCIMO_MOTIVO ');
          FQuery.Sql.Add('  ,:TOTAL ');
          FQuery.Sql.Add('  ,:OBSERVACAO ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HR_CADASTRO ');
          FQuery.Sql.Add('  ,:ID_USUARIO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
          FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
          FQuery.ParamByName('ID').AsInteger := FId;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE SERVICOS_PRESTADOS SET ');
          FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
          FQuery.Sql.Add('  ,STATUS = :STATUS ');
          FQuery.Sql.Add('  ,ID_EMPRESA = :ID_EMPRESA ');
          FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO ');
          FQuery.Sql.Add('  ,ID_CLIENTE = :ID_CLIENTE ');
          FQuery.Sql.Add('  ,ID_TABELA = :ID_TABELA ');
          FQuery.Sql.Add('  ,DATA = :DATA ');
          FQuery.Sql.Add('  ,HR_INICIO = :HR_INICIO ');
          FQuery.Sql.Add('  ,HR_FIM = :HR_FIM ');
          FQuery.Sql.Add('  ,HR_TOTAL = :HR_TOTAL ');
          FQuery.Sql.Add('  ,VLR_HORA = :VLR_HORA ');
          FQuery.Sql.Add('  ,SUB_TOTAL = :SUB_TOTAL ');
          FQuery.Sql.Add('  ,DESCONTO = :DESCONTO ');
          FQuery.Sql.Add('  ,DESCONTO_MOTIVO = :DESCONTO_MOTIVO ');
          FQuery.Sql.Add('  ,ACRESCIMO = :ACRESCIMO ');
          FQuery.Sql.Add('  ,ACRESCIMO_MOTIVO = :ACRESCIMO_MOTIVO ');
          FQuery.Sql.Add('  ,TOTAL = :TOTAL ');
          FQuery.Sql.Add('  ,OBSERVACAO = :OBSERVACAO ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := StrToIntDef(edID.Text,0);
          FId := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
      FQuery.ParamByName('STATUS').AsInteger := edSTATUS.ItemIndex;
      FQuery.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edID_EMPRESA.Text,0);
      FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := StrToIntDef(edID_PRESTADOR_SERVICO.Text,0);
      FQuery.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edID_CLIENTE.Text,0);
      FQuery.ParamByName('ID_TABELA').AsInteger := StrToIntDef(edID_TABELA.Text,0);
      FQuery.ParamByName('DATA').AsDate := StrToDateDef(edDATA.Text,Date);
      FQuery.ParamByName('HR_INICIO').AsTime := StrToTimeDef(edHR_INICIO.Text,Time);
      FQuery.ParamByName('HR_FIM').AsTime := StrToTimeDef(edHR_FIM.Text,Time);
      FQuery.ParamByName('HR_TOTAL').AsTime := StrToTimeDef(edHR_TOTAL.Text,Time);
      FQuery.ParamByName('VLR_HORA').AsFloat := edVLR_HORA.TagFloat;
      FQuery.ParamByName('SUB_TOTAL').AsFloat := edSUB_TOTAL.TagFloat;
      FQuery.ParamByName('DESCONTO').AsFloat := edDESCONTO.TagFloat;
      FQuery.ParamByName('DESCONTO_MOTIVO').AsString := '';
      FQuery.ParamByName('ACRESCIMO').AsFloat := edACRESCIMO.TagFloat;
      FQuery.ParamByName('ACRESCIMO_MOTIVO').AsString := '';
      FQuery.ParamByName('TOTAL').AsFloat := edTOTAL.TagFloat;
      FQuery.ParamByName('OBSERVACAO').AsString := edOBSERVACAO.Text;
      FQuery.ExecSQL;

      Lancar_ContasReceber(FId);

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

procedure TfrmMov_ServicosPrestados.Lancar_ContasReceber(AId:Integer);
var
  FQuery :TFDQuery;
  FData :TDate;
begin
  try
    try
      FData := TFuncoes.Datas(Date).UltimoDia;
      FData := TFuncoes.Datas(FData,0,5).Data_Add_Dia;

      FQuery.Connection := FDm_Global.FDC_Firebird;

      if FTab_Status = dsEdit then
      begin
        FQuery.Active := False;
        FQuery.Sql.Clear;
        FQuery.Sql.Add('DELETE FROM LANCAMENTOS ');
        FQuery.Sql.Add('WHERE ORIGEM_LANCAMENTO = :ORIGEM_LANCAMENTO ');
        FQuery.Sql.Add('  AND ID_ORIGEM_LANCAMENTO = :ID_ORIGEM_LANCAMENTO; ');
        FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'SERVICOS_PRESTADOS';
        FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := AId;
        FQuery.ExecSQL;
      end;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('INSERT INTO LANCAMENTOS( ');
      FQuery.Sql.Add('  ID_EMPRESA ');
      FQuery.Sql.Add('  ,DT_EMISSAO ');
      FQuery.Sql.Add('  ,ID_CONTA ');
      FQuery.Sql.Add('  ,ID_PESSOA ');
      FQuery.Sql.Add('  ,STATUS ');
      FQuery.Sql.Add('  ,DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,VALOR ');
      FQuery.Sql.Add('  ,ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,ID_ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,ID_USUARIO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :ID_EMPRESA ');
      FQuery.Sql.Add('  ,:DT_EMISSAO ');
      FQuery.Sql.Add('  ,:ID_CONTA ');
      FQuery.Sql.Add('  ,:ID_PESSOA ');
      FQuery.Sql.Add('  ,:STATUS ');
      FQuery.Sql.Add('  ,:DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,:VALOR ');
      FQuery.Sql.Add('  ,:ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,:ID_ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,:ID_USUARIO ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edID_EMPRESA.Text,0);;
      FQuery.ParamByName('DT_EMISSAO').AsDate := Date;
      FQuery.ParamByName('ID_CONTA').AsInteger := StrToIntDef(FIniFile.ReadString('PLANO_CONTAS.LANC','APONT.HORAS','0'),0);
      FQuery.ParamByName('ID_PESSOA').AsInteger := StrToIntDef(edID_CLIENTE.Text,0);;
      FQuery.ParamByName('STATUS').AsInteger := 0;  //0-Aberto, 1-pago
      FQuery.ParamByName('DT_VENCIMENTO').AsDate := FData; //Calcular
      FQuery.ParamByName('VALOR').AsFloat := edTOTAL.TagFloat;
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'SERVICOS_PRESTADOS';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := AId;
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
      FQuery.ExecSQL;

      {$Region 'ORIGEM_LANCAMENTO'}
        {
          PROPRIA
          SERVICOS_PRESTADOS
        }
      {$EndRegion 'ORIGEM_LANCAMENTO'}

    except on E: Exception do
      raise Exception.Create('Contas a Receber: ' + E.Message);
    end;
  finally

  end;
end;

procedure TfrmMov_ServicosPrestados.Selecionar_Registros;
var
  FQuery :TFDQuery;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  SP.* ');
      FDQRegistros.SQL.Add('  ,CASE SP.STATUS ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''ABERTO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''PAGO'' ');
      FDQRegistros.SQL.Add('  END STATUS_DESC ');
      FDQRegistros.SQL.Add('  ,E.NOME AS EMPRESA ');
      FDQRegistros.SQL.Add('  ,PS.NOME AS PRESTAOR_SERVICO ');
      FDQRegistros.SQL.Add('  ,C.NOME AS CLIENTE ');
      FDQRegistros.SQL.Add('  ,TP.DESCRICAO AS TABELA ');
      FDQRegistros.SQL.Add('  ,CASE TP.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''HORAS'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''FIXO'' ');
      FDQRegistros.SQL.Add('  END TABELA_TIPO ');
      FDQRegistros.SQL.Add('  ,TP.VALOR ');
      FDQRegistros.SQL.Add('FROM SERVICOS_PRESTADOS SP ');
      FDQRegistros.SQL.Add('  JOIN EMPRESA E ON E.ID = SP.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  JOIN PRESTADOR_SERVICO PS ON PS.ID = SP.ID_PRESTADOR_SERVICO ');
      FDQRegistros.SQL.Add('  JOIN CLIENTE C ON C.ID = SP.ID_CLIENTE ');
      FDQRegistros.SQL.Add('  JOIN TABELA_PRECO TP ON TP.ID = SP.ID_TABELA ');
      FDQRegistros.SQL.Add('WHERE NOT SP.ID IS NULL ');
      FDQRegistros.SQL.Add('  AND SP.DATA BETWEEN :DATA_I AND :DATA_F');
      if Trim(edFiltro_Empresa_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND SP.ID_EMPRESA = :ID_EMPRESA');
        FDQRegistros.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
      end;
      if Trim(edFiltro_Prestador_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND SP.ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO');
        FDQRegistros.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := StrToIntDef(edFiltro_Prestador_ID.Text,0);
      end;
      if Trim(edFiltro_Cliente_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND SP.ID_CLIENTE = :ID_CLIENTE');
        FDQRegistros.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
      end;
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  SP.ID; ');
      FDQRegistros.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
      FDQRegistros.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
      FDQRegistros.Active := True;

      {$Region 'Totalizando'}
        FQuery := TFDQuery.Create(Nil);
        FQuery.Connection := FDm_Global.FDC_Firebird;
        FQuery.Active := False;
        FQuery.Sql.Clear;
        FQuery.Sql.Add('SELECT ');
        FQuery.Sql.Add('  LPAD(DATEDIFF(HOUR,CAST(CURRENT_DATE AS TIMESTAMP),D.DH),2,''0'') || '':'' || ');
        FQuery.Sql.Add('  LPAD(EXTRACT(MINUTE FROM D.DH),2,''0'') || '':'' || ');
        FQuery.Sql.Add('  LPAD(CAST(EXTRACT(SECOND FROM D.DH) AS INTEGER),2,''0'') AS HORA');
        FQuery.Sql.Add('  ,D.TOTAL ');
        FQuery.Sql.Add('FROM ( ');
        FQuery.Sql.Add('  SELECT ');
        FQuery.Sql.Add('    DATEADD(HOUR,C.HORA,C.DM) AS DH ');
        FQuery.Sql.Add('    ,C.TOTAL ');
        FQuery.Sql.Add('  FROM ( ');
        FQuery.Sql.Add('    SELECT ');
        FQuery.Sql.Add('      B.HORA ');
        FQuery.Sql.Add('      ,DATEADD(MINUTE,B.MINUTO,B.DS) DM ');
        FQuery.Sql.Add('      ,B.TOTAL ');
        FQuery.Sql.Add('    FROM ( ');
        FQuery.Sql.Add('      SELECT ');
        FQuery.Sql.Add('        A.HORA ');
        FQuery.Sql.Add('        ,A.MINUTO ');
        FQuery.Sql.Add('        ,DATEADD(SECOND, A.SEGUNDO, CAST(CURRENT_DATE AS TIMESTAMP)) AS DS ');
        FQuery.Sql.Add('        ,A.TOTAL ');
        FQuery.Sql.Add('      FROM ( ');
        FQuery.Sql.Add('        SELECT ');
        FQuery.Sql.Add('          SUM(CAST(EXTRACT(HOUR FROM SP.HR_TOTAL) AS INTEGER)) AS HORA ');
        FQuery.Sql.Add('          ,SUM(CAST(EXTRACT(MINUTE FROM SP.HR_TOTAL) AS INTEGER)) AS MINUTO ');
        FQuery.Sql.Add('          ,SUM(CAST(EXTRACT(SECOND FROM SP.HR_TOTAL) AS INTEGER)) AS SEGUNDO ');
        FQuery.Sql.Add('          ,SUM(SP.TOTAL) AS TOTAL ');
        FQuery.Sql.Add('        FROM SERVICOS_PRESTADOS SP ');
        FQuery.SQL.Add('        WHERE NOT SP.ID IS NULL ');
        FQuery.SQL.Add('          AND SP.DATA BETWEEN :DATA_I AND :DATA_F ');
        if Trim(edFiltro_Empresa_ID.Text) <> '' then
        begin
          FQuery.SQL.Add('          AND SP.ID_EMPRESA = :ID_EMPRESA');
          FQuery.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
        end;
        if Trim(edFiltro_Prestador_ID.Text) <> '' then
        begin
          FQuery.SQL.Add('          AND SP.ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO');
          FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := StrToIntDef(edFiltro_Prestador_ID.Text,0);
        end;
        if Trim(edFiltro_Cliente_ID.Text) <> '' then
        begin
          FQuery.SQL.Add('          AND SP.ID_CLIENTE = :ID_CLIENTE');
          FQuery.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
        end;
        FQuery.SQL.Add(') A) B) C) D; ');
        FQuery.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
        FQuery.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
        FQuery.Active := True;
        if not FQuery.IsEmpty then
        begin
          lbTotalHoras.Text := '';
          lbTotalReceber.Text := '';
          lbTotalHoras.Text := FQuery.FieldByName('HORA').AsString;
          lbTotalReceber.Text := FormatFloat('R$ #,##0.00',FQuery.FieldByName('TOTAL').AsFloat);
        end;
      {$EndRegion 'Totalizando'}

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmMov_ServicosPrestados.Sel_Empresa(Aid:Integer; ANome:String);
begin
  edID_EMPRESA.Text := AId.ToString;
  edID_EMPRESA_Desc.Text := ANome;

  if edID_PRESTADOR_SERVICO.CanFocus then
    edID_PRESTADOR_SERVICO.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.Sel_Empresa_Filtro(Aid: Integer; ANome: String);
begin
  edFiltro_Empresa_ID.Text := AId.ToString;
  edFiltro_Empresa.Text := ANome;
  Selecionar_Registros;
end;

procedure TfrmMov_ServicosPrestados.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
