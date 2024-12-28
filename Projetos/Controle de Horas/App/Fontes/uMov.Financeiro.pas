unit uMov.Financeiro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uCombobox,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uACBr,
  uFuncoes,

  {$Region 'Frames'}
    uFrame.LancFinanceiro,
    uFrame.LancFinanceiro_H,
    uFrame.LancFinanceiro_F,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Calendar;

type
  TExecuteOnClose = procedure(AId:Integer) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmMov_Financeiro = class(TForm)
    imgCancelar: TImage;
    imgChecked: TImage;
    imgEditar: TImage;
    imgEsconder: TImage;
    imgExcluir: TImage;
    imgExibir: TImage;
    imgNovo: TImage;
    imgSalvar: TImage;
    imgUnChecked: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytLista: TLayout;
    lbRegistros: TListBox;
    lytFiltro: TLayout;
    edFiltro: TEdit;
    imgLimpar: TImage;
    tiCampos: TTabItem;
    lytCampos: TLayout;
    tcCampos: TTabControl;
    tiCampos_001: TTabItem;
    lytCampos_001: TLayout;
    lytRow_C01_001: TLayout;
    lytID: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytSTATUS: TLayout;
    lbSTATUS: TLabel;
    edSTATUS: TEdit;
    imgSTATUS: TImage;
    lytDATA: TLayout;
    lbDATA: TLabel;
    edDATA: TEdit;
    imgDATA: TImage;
    lytRow_Navegar_01: TLayout;
    imgAvancar_001: TImage;
    tiCampos_002: TTabItem;
    lytCampos_002: TLayout;
    lytRow_Navegar_02: TLayout;
    imgRetornar_001: TImage;
    lytRow_C01_002: TLayout;
    lytID_EMPRESA: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_C01_003: TLayout;
    lytID_CONTA: TLayout;
    lbID_CONTA: TLabel;
    edID_CONTA: TEdit;
    imgID_CONTA: TImage;
    lytRow_C01_005: TLayout;
    lytFormaCond_Pagto: TLayout;
    lbFormaCond_Pagto: TLabel;
    edFORMA_PAGTO_ID: TEdit;
    imgFORMA_PAGTO_ID: TImage;
    lytRow_C01_004: TLayout;
    lytID_PESSOA: TLayout;
    lbID_PESSOA: TLabel;
    edID_PESSOA: TEdit;
    imgID_PESSOA: TImage;
    lytRow_C02_002: TLayout;
    lytDESCONTO_BAIXA: TLayout;
    lbDESCONTO_BAIXA: TLabel;
    edDESCONTO_BAIXA: TEdit;
    lytJUROS_BAIXA: TLayout;
    lbJUROS_BAIXA: TLabel;
    edJUROS_BAIXA: TEdit;
    lytRow_C02_003: TLayout;
    lytOBSERVACAO: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_C02_001: TLayout;
    lytVALOR_BAIXA: TLayout;
    lbVALOR_BAIXA: TLabel;
    edVALOR_BAIXA: TEdit;
    lytDT_BAIXA: TLayout;
    lbDT_BAIXA: TLabel;
    edDT_BAIXA: TEdit;
    imgDT_BAIXA: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    rctCalendario_Tampa: TRectangle;
    rctCalendario: TRectangle;
    ShadowEffect2: TShadowEffect;
    lytCalendario_Header: TLayout;
    rctCalendario_Header: TRectangle;
    lbCalendario_Titulo: TLabel;
    imgCalendario_Cancelar: TImage;
    lytCalendario_Detail: TLayout;
    rctCalendario_Detail: TRectangle;
    Calendar: TCalendar;
    lytCalendario_Footer: TLayout;
    rctCalendario_Footer: TRectangle;
    lytRow_C01_006: TLayout;
    lytVALOR: TLayout;
    lbVALOR: TLabel;
    edVALOR: TEdit;
    lytDT_VENCIMENTO: TLayout;
    lbDT_VENCIMENTO: TLabel;
    edDT_VENCIMENTO: TEdit;
    imgDT_VENCIMENTO: TImage;
    edCOND_PAGTO_ID: TEdit;
    edTIPO_CONTA: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgRetornar_001Click(Sender: TObject);
    procedure imgAvancar_001Click(Sender: TObject);
    procedure imgDATAClick(Sender: TObject);
    procedure edID_EMPRESAClick(Sender: TObject);
    procedure edID_CONTAClick(Sender: TObject);
    procedure edID_PESSOAClick(Sender: TObject);
    procedure edFORMA_PAGTO_IDClick(Sender: TObject);
    procedure edVALORTyping(Sender: TObject);
    procedure edDESCONTO_BAIXATyping(Sender: TObject);
    procedure edJUROS_BAIXATyping(Sender: TObject);
    procedure edVALOR_BAIXATyping(Sender: TObject);
    procedure edDT_BAIXATyping(Sender: TObject);
    procedure edDATATyping(Sender: TObject);
    procedure edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edSTATUSKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edID_EMPRESAKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edID_CONTAKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edID_PESSOAKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edFORMA_PAGTO_IDKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edDT_VENCIMENTOKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edVALORKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edDT_BAIXAKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTO_BAIXAKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edJUROS_BAIXAKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edVALOR_BAIXAKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure imgAcao_01Click(Sender: TObject);
    procedure imgCalendario_CancelarClick(Sender: TObject);
    procedure CalendarDateSelected(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
  private
    FDataRetorno :Integer;
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    cComboStatus :TCustomCombo;
    FMenu_Frame :TActionSheet;
    FValor_Hora :Double;
    FEdidanto :Boolean;

    FId :Integer;
    FDescricao :String;

    FACBr_Validador :TACBr_Validador;
    FPesquisa: Boolean;

    {$IFDEF MSWINDOWS}
      procedure ItemClick_Status(Sender: TObject);
    {$ELSE}
      procedure ItemClick_Status(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    procedure LimparCampos;
    procedure Salvar;
    procedure TTHreadEnd_Salvar(Sender: TOBject);
    procedure Cancelar(Sender: TOBject);
    procedure CriandoCombos;
    procedure Listar_Registros(APesquisa:String);
    procedure AddRegistros_LB(
      AId,AContaID,APessoaID,ASincronizado,AExcluido,AStatus:Integer;
      APessoa,AConta,AConta_Tipo,AEmissao,AVencimento,APagamento:String;
      AValor,AValor_Pagto:Double);
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure AddRegistros_LB_Header(AConta_ID:Integer;AConta:String);
    procedure AddRegistros_LB_Footer(ATotal:Double);
    procedure Abre_Menu_Registros(Sender :TOBject);
    procedure CriandoMenus;
    procedure Editar(Sender: TOBject);
    procedure TThreadEnd_Editar(Sender: TOBject);
    procedure Excluir(Sender: TObject);
    procedure Excluir_Registro(Sender: TObject);
    procedure TThreadEnd_ExcluirRegistro(Sender: TOBject);

    procedure SetPesquisa(const Value: Boolean);
    procedure Sel_Empresa(Aid: Integer; ANome: String);
    procedure Sel_Conta(Aid,ATipo: Integer; ANome,ATipoDesc: String);
    procedure Sel_Pessoa(Aid: Integer; ANome: String);
    procedure Sel_FormaCond(AId, ACondicao_ID: Integer; ADescricao,
      AClassificacao, ACondicao: String);

  public
    ExecuteOnClose :TExecuteOnClose;
    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmMov_Financeiro: TfrmMov_Financeiro;

implementation

{$R *.fmx}

uses
  uMov.ServicosPrestados
  ,uCad.Conta
  ,uCad.Empresa
  ,uCad.Cliente
  ,uCad.Fornecedor
  ,uCad.FormaPagto;

{$IFDEF MSWINDOWS}
procedure TfrmMov_Financeiro.ItemClick_Status(Sender: TObject);
begin
  cComboStatus.HideMenu;
  edSTATUS.Text := cComboStatus.DescrItem;
  edSTATUS.Tag := StrToIntDef(cComboStatus.CodItem,0);
end;
{$ELSE}
procedure TfrmMov_Financeiro.ItemClick_Status(Sender: TObject; const Point: TPointF);
begin
  cComboStatus.HideMenu;
  edSTATUS.Text := cComboStatus.DescrItem;
  edSTATUS.Tag := StrToIntDef(cComboStatus.CodItem,0);
end;
{$ENDIF}

procedure TfrmMov_Financeiro.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_LancFinanceiro;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_LancFinanceiro;

  FId := FFrame.lbId.Tag;
  FDescricao := FFrame.lbId.Text;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmMov_Financeiro.AddRegistros_LB(
      AId,AContaID,APessoaID,ASincronizado,AExcluido,AStatus:Integer;
      APessoa,AConta,AConta_Tipo,AEmissao,AVencimento,APagamento:String;
      AValor,AValor_Pagto:Double);
var
  FItem :TListBoxItem;
  FFrame :TFrame_LancFinanceiro;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 130;
    FItem.Tag := AId;
    FItem.Selectable := True;

    FFrame := TFrame_LancFinanceiro.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbID.Text := AId.ToString;
    FFrame.lbID.Tag := AId;
    FFrame.lbConta.Text := AConta;
    FFrame.lbConta.Tag := AContaID;
    FFrame.lbPessoa.Text := APessoa;
    FFrame.lbPessoa.Tag := APessoaID;
    FFrame.lbDT_EMISSAO.Text := AEmissao;
    FFrame.lbDT_VENCIMENTO.Text := AVencimento;
    FFrame.lbVALOR.Text := FormatFloat('R$ #,##0.00',AValor);
    FFrame.lbVALOR.TagFloat := AValor;
    FFrame.lbDT_BAIXA.Text := APagamento;
    FFrame.lbVALOR_BAIXA.Text := FormatFloat('R$ #,##0.00',AValor_Pagto);
    FFrame.lbVALOR_BAIXA.TagFloat := AValor_Pagto;

    case ASincronizado of
      0:FFrame.imgSincronizado.Opacity := 0.3;
      1:FFrame.imgSincronizado.Opacity := 1;
    end;
    case AExcluido of
      0:FFrame.imgExcluído.Opacity := 0.3;
      1:FFrame.imgExcluído.Opacity := 1;
    end;
    FFrame.rctMenu.OnClick := Abre_Menu_Registros;

    lbRegistros.AddObject(FItem);

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmMov_Financeiro.AddRegistros_LB_Footer(ATotal: Double);
var
  FItem :TListBoxItem;
  FFrame :TFrame_LancFinanceiro_F;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 40;

    FFrame := TFrame_LancFinanceiro_F.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbTotal.Text := FormatFloat('R$ #,##0.00',ATotal);
    FFrame.lbTotal.TagFloat:= ATotal;

    lbRegistros.AddObject(FItem);

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmMov_Financeiro.AddRegistros_LB_Header(AConta_ID:Integer;AConta:String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_LancFinanceiro_H;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 30;
    FItem.Tag := AConta_ID;
    FItem.TagString := AConta;

    FFrame := TFrame_LancFinanceiro_H.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbConta.Text := AConta;
    FFrame.lbConta.Tag := AConta_ID;

    lbRegistros.AddObject(FItem);

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmMov_Financeiro.CalendarDateSelected(Sender: TObject);
begin
  case FDataRetorno of
    0:edDATA.Text := DateToStr(Calendar.Date);
    1:edDT_VENCIMENTO.Text := DateToStr(Calendar.Date);
    2:edDT_BAIXA.Text := DateToStr(Calendar.Date);
  end;

  rctCalendario_Tampa.Visible := False;

end;

procedure TfrmMov_Financeiro.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmMov_Financeiro.CriandoCombos;
begin

  cComboStatus := TCustomCombo.Create(frmMov_Financeiro);

  {$Region 'Combo Status'}
    cComboStatus.ItemBackgroundColor := $FF363428;
    cComboStatus.ItemFontSize := 15;
    cComboStatus.ItemFontColor := $FFA1B24E;

    cComboStatus.TitleMenuText := 'Escolha o Status';
    cComboStatus.TitleFontSize := 17;
    cComboStatus.TitleFontColor := $FF363428;

    cComboStatus.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboStatus.SubTitleFontSize := 13;
    cComboStatus.SubTitleFontColor := $FF363428;

    cComboStatus.BackgroundColor := $FFF2F2F8;
    cComboStatus.OnClick := ItemClick_Status;

    cComboStatus.AddItem('0', 'INATIVO');
    cComboStatus.AddItem('1', 'ATIVO');
  {$EndRegion 'Combo Status'}
end;

procedure TfrmMov_Financeiro.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmMov_Financeiro);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);
end;

procedure TfrmMov_Financeiro.edDATAKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edSTATUS.SetFocus;
end;

procedure TfrmMov_Financeiro.edDATATyping(Sender: TObject);
begin
  Formatar(edDATA,Dt);
end;

procedure TfrmMov_Financeiro.edDESCONTO_BAIXAKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edJUROS_BAIXA.SetFocus;

end;

procedure TfrmMov_Financeiro.edDESCONTO_BAIXATyping(Sender: TObject);
begin
  Formatar(edDESCONTO_BAIXA,Money);
  edDESCONTO_BAIXA.TagFloat := TFuncoes.RetornaValor_TextMoney(edDESCONTO_BAIXA.Text,2);
end;

procedure TfrmMov_Financeiro.edDT_BAIXAKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCONTO_BAIXA.SetFocus;

end;

procedure TfrmMov_Financeiro.edDT_BAIXATyping(Sender: TObject);
begin
  Formatar(edDT_BAIXA,Dt);
end;

procedure TfrmMov_Financeiro.edDT_VENCIMENTOKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR.SetFocus;

end;

procedure TfrmMov_Financeiro.edFORMA_PAGTO_IDClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_FormaPagto) then
    Application.CreateForm(TfrmCad_FormaPagto,frmCad_FormaPagto);

  frmCad_FormaPagto.Pesquisa := True;
  frmCad_FormaPagto.ExecuteOnClose := Sel_FormaCond;
  frmCad_FormaPagto.Show;
end;

procedure TfrmMov_Financeiro.edFORMA_PAGTO_IDKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edDT_VENCIMENTO.SetFocus;

end;

procedure TfrmMov_Financeiro.Sel_FormaCond(AId,ACondicao_ID:Integer; ADescricao,AClassificacao, ACondicao:String);
begin
  edFORMA_PAGTO_ID.Tag := AId;
  edFORMA_PAGTO_ID.Text := ADescricao;
  edCOND_PAGTO_ID.Tag := ACondicao_ID;
  edCOND_PAGTO_ID.Text := ACondicao;
end;

procedure TfrmMov_Financeiro.edID_CONTAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas,frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_Conta;
  frmCad_Contas.Show;
end;

procedure TfrmMov_Financeiro.edID_CONTAKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_PESSOA.SetFocus;

end;

procedure TfrmMov_Financeiro.Sel_Conta(Aid,ATipo: Integer; ANome,ATipoDesc: String);
begin
  edID_CONTA.Tag := Aid;
  edID_CONTA.Text := ANome;
  edTIPO_CONTA.Tag := ATipo;
  edTIPO_CONTA.Text := ATipoDesc;
end;

procedure TfrmMov_Financeiro.edID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa,frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Show;
end;

procedure TfrmMov_Financeiro.edID_EMPRESAKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CONTA.SetFocus;

end;

procedure TfrmMov_Financeiro.edID_PESSOAClick(Sender: TObject);
begin
  case edTIPO_CONTA.Tag of
    0:begin
        if NOT Assigned(frmCad_Cliente) then
          Application.CreateForm(TfrmCad_Cliente,frmCad_Cliente);

        frmCad_Cliente.Pesquisa := True;
        frmCad_Cliente.ExecuteOnClose := Sel_Pessoa;
        frmCad_Cliente.Show;
    end;
    1:begin
        if NOT Assigned(frmCad_Fornecedor) then
          Application.CreateForm(TfrmCad_Fornecedor,frmCad_Fornecedor);

        frmCad_Fornecedor.Pesquisa := True;
        frmCad_Fornecedor.ExecuteOnClose := Sel_Pessoa;
        frmCad_Fornecedor.Show;
    end;
  end;

end;

procedure TfrmMov_Financeiro.edID_PESSOAKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edFORMA_PAGTO_ID.SetFocus;

end;

procedure TfrmMov_Financeiro.Sel_Pessoa(Aid:Integer; ANome:String);
begin
  edID_PESSOA.Tag := Aid;
  edID_PESSOA.Text := ANome;
end;

procedure TfrmMov_Financeiro.Sel_Empresa(Aid:Integer; ANome:String);
begin
  edID_EMPRESA.Tag := Aid;
  edID_EMPRESA.Text := ANome;
end;

procedure TfrmMov_Financeiro.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmMov_Financeiro,'Editando o Registro');
  LimparCampos;
  FEdidanto := True;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('SELECT ');
    FQuery.Sql.Add('  L.* ');
    FQuery.Sql.Add('  ,E.NOME AS EMPRESA ');
    FQuery.Sql.Add('  ,C.DESCRICAO AS CONTA ');
    FQuery.Sql.Add('  ,C.TIPO AS TIPO_CONTA ');
    FQuery.Sql.Add('  ,CASE C.TIPO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''CRÉDITO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''DÉBITO'' ');
    FQuery.Sql.Add('  END TIPO_CONTA_DESC ');
    FQuery.Sql.Add('  ,CASE C.TIPO ');
    FQuery.Sql.Add('    WHEN 0 THEN CL.NOME ');
    FQuery.Sql.Add('    WHEN 1 THEN F.NOME ');
    FQuery.Sql.Add('  END PESSOA ');
    FQuery.Sql.Add('  ,CASE L.STATUS ');
    FQuery.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''ATVO'' ');
    FQuery.Sql.Add('  END STATUS_DESC ');
    FQuery.Sql.Add('  ,FP.DESCRICAO AS FORMA_PAGTO ');
    FQuery.Sql.Add('  ,FP.CLASSIFICACAO AS CLASS_FORMA ');
    FQuery.Sql.Add('  ,CP.DESCRICAO AS COND_PAGTO ');
    FQuery.Sql.Add('  ,CP.PARCELAS ');
    FQuery.Sql.Add('  ,CP.TIPO_INTERVALO ');
    FQuery.Sql.Add('  ,CASE CP.TIPO_INTERVALO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''DIAS'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''MESES'' ');
    FQuery.Sql.Add('  END TIPO_INTERVALO_DESC ');
    FQuery.Sql.Add('  ,CP.INTEVALOR ');
    FQuery.Sql.Add('FROM LANCAMENTOS L ');
    FQuery.Sql.Add('  JOIN EMPRESA E ON E.ID = L.ID_EMPRESA ');
    FQuery.Sql.Add('  JOIN CONTA C ON C.ID = L.ID_CONTA ');
    FQuery.Sql.Add('  LEFT JOIN CLIENTE CL ON CL.ID = L.ID_PESSOA ');
    FQuery.Sql.Add('  LEFT JOIN FORNECEDOR F ON F.ID = L.ID_PESSOA ');
    FQuery.Sql.Add('  JOIN FORMA_PAGAMENTO FP ON FP.ID = L.FORMA_PAGTO_ID ');
    FQuery.Sql.Add('  JOIN CONDICAO_PAGAMENTO CP ON CP.ID = L.COND_PAGTO_ID ');
    FQuery.Sql.Add('WHERE L.ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.Active := True;
    if not FQuery.IsEmpty then
    begin
      FQuery.First;
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        edID.Tag := FQuery.FieldByName('ID').AsInteger;
        edID.Text := FQuery.FieldByName('ID').AsString;
        edDATA.Text := FormatDateTime('DD/MM/YYYY', FQuery.FieldByName('DT_EMISSAO').AsDateTime);
        edSTATUS.Tag := FQuery.FieldByName('STATUS').AsInteger;
        edSTATUS.Text := FQuery.FieldByName('STATUS_DESC').AsString;
        edID_EMPRESA.Tag := FQuery.FieldByName('ID_EMPRESA').AsInteger;
        edID_EMPRESA.Text := FQuery.FieldByName('EMPRESA').AsString;
        edID_CONTA.Tag := FQuery.FieldByName('ID_CONTA').AsInteger;
        edID_CONTA.Text := FQuery.FieldByName('CONTA').AsString;
        edID_PESSOA.Tag := FQuery.FieldByName('ID_PESSOA').AsInteger;
        edID_PESSOA.Text := FQuery.FieldByName('PESSOA').AsString;
        edFORMA_PAGTO_ID.Tag := FQuery.FieldByName('FORMA_PAGTO_ID').AsInteger;
        edFORMA_PAGTO_ID.Text := FQuery.FieldByName('FORMA_PAGTO').AsString;
        edCOND_PAGTO_ID.Tag := FQuery.FieldByName('COND_PAGTO_ID').AsInteger;
        edCOND_PAGTO_ID.Text := FQuery.FieldByName('COND_PAGTO').AsString;
        edDT_VENCIMENTO.Text := FormatDateTime('DD/MM/YYYY', FQuery.FieldByName('DT_VENCIMENTO').AsDateTime);
        edVALOR.TagFloat := FQuery.FieldByName('VALOR').AsFloat;
        edVALOR.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('VALOR').AsFloat);
        edOBSERVACAO.Text := FQuery.FieldByName('OBSERVACAO').AsString;
        if NOT FQuery.FieldByName('DT_BAIXA').iSnULL then
        begin
          edDT_BAIXA.Text := FormatDateTime('DD/MM/YYYY', FQuery.FieldByName('DT_BAIXA').AsDateTime);
          edDESCONTO_BAIXA.TagFloat := FQuery.FieldByName('DESCONTO_BAIXA').AsFloat;
          edDESCONTO_BAIXA.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('DESCONTO_BAIXA').AsFloat);
          edJUROS_BAIXA.TagFloat := FQuery.FieldByName('JUROS_BAIXA').AsFloat;
          edJUROS_BAIXA.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('JUROS_BAIXA').AsFloat);
          edVALOR_BAIXA.TagFloat := FQuery.FieldByName('VALOR_BAIXA').AsFloat;
          edVALOR_BAIXA.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('VALOR_BAIXA').AsFloat);
        end;
      end);

    end;

    {$IFDEF MSWINDWOS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}
  end);

  t.OnTerminate := TThreadEnd_Editar;
  t.Start;
end;

procedure TfrmMov_Financeiro.edJUROS_BAIXAKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR_BAIXA.SetFocus;

end;

procedure TfrmMov_Financeiro.edJUROS_BAIXATyping(Sender: TObject);
begin
  Formatar(edJUROS_BAIXA,Money);
  edJUROS_BAIXA.TagFloat := TFuncoes.RetornaValor_TextMoney(edJUROS_BAIXA.Text,2);
end;

procedure TfrmMov_Financeiro.edSTATUSKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_EMPRESA.SetFocus;

end;

procedure TfrmMov_Financeiro.edVALORKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcCampos.GotoVisibleTab(1);
    edDT_BAIXA.SetFocus;
  end;

end;

procedure TfrmMov_Financeiro.edVALORTyping(Sender: TObject);
begin
  Formatar(edVALOR,Money);
  edVALOR.TagFloat := TFuncoes.RetornaValor_TextMoney(edVALOR.Text,2);
end;

procedure TfrmMov_Financeiro.edVALOR_BAIXAKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edOBSERVACAO.SetFocus;

end;

procedure TfrmMov_Financeiro.edVALOR_BAIXATyping(Sender: TObject);
begin
  Formatar(edVALOR_BAIXA,Money);
  edVALOR_BAIXA.TagFloat := TFuncoes.RetornaValor_TextMoney(edVALOR_BAIXA.Text,2);
end;

procedure TfrmMov_Financeiro.Excluir(Sender: TObject);
begin
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmMov_Financeiro.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmMov_Financeiro,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE LANCAMENTOS SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmMov_Financeiro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(cComboStatus);
    FreeAndNil(FACBr_Validador);
    FreeAndNil(FMenu_Frame);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    cComboStatus.DisposeOf;
    FACBr_Validador.DisposeOf;
    FMenu_Frame.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmMov_Financeiro := Nil;

end;

procedure TfrmMov_Financeiro.FormCreate(Sender: TObject);
begin
  tcCampos.Margins.Bottom := 0;

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FACBr_Validador := TACBr_Validador.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmMov_Financeiro);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;
  tcCampos.ActiveTab := tiCampos_001;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;
  FEdidanto := False;

end;

procedure TfrmMov_Financeiro.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmMov_Financeiro.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      FTab_Status := dsInsert;
      edSTATUS.Tag := 1;
      edSTATUS.Text := 'ATIVO';
      LimparCampos;
      imgAcao_01.Tag := 1;
      imgAcao_01.Bitmap := imgSalvar.Bitmap;
      tcCampos.TabIndex := 0;
      edSTATUS.Tag := 1;
      edSTATUS.Text := 'ATIVO';
      edDATA.Text := DateToStr(Date);
      tcPrincipal.GotoVisibleTab(1);
      if edDATA.CanFocus then
        edDATA.SetFocus;
      FEdidanto := False;
    end;
    1:Salvar;
  end;
end;

procedure TfrmMov_Financeiro.imgAvancar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmMov_Financeiro.imgCalendario_CancelarClick(Sender: TObject);
begin
  rctCalendario_Tampa.Visible := False;
end;

procedure TfrmMov_Financeiro.imgDATAClick(Sender: TObject);
begin
  rctCalendario_Tampa.Align := TAlignLayout.Contents;
  FDataRetorno := TImage(Sender).Tag;
  Calendar.Date := Date;
  rctCalendario_Tampa.Visible := True;
end;

procedure TfrmMov_Financeiro.imgRetornar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(0);
end;

procedure TfrmMov_Financeiro.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

procedure TfrmMov_Financeiro.LimparCampos;
begin
  edID.Tag := 0;
  edID.Text := '';
  edDATA.Text := '';
  edSTATUS.Tag := -1;
  edSTATUS.Text := '';
  edID_EMPRESA.Tag := 0;
  edID_EMPRESA.Text := '';
  edID_CONTA.Tag := 0;
  edID_CONTA.Text := '';
  edID_PESSOA.Tag := 0;
  edID_PESSOA.Text := '';
  edFORMA_PAGTO_ID.Tag := 0;
  edFORMA_PAGTO_ID.Text := '';
  edCOND_PAGTO_ID.Tag := 0;
  edCOND_PAGTO_ID.Text := '';
  edDT_VENCIMENTO.Text := '';
  edVALOR.TagFloat := 0;
  edVALOR.Text := '';
  edDT_BAIXA.Text := '';
  edDESCONTO_BAIXA.TagFloat := 0;
  edDESCONTO_BAIXA.Text := '';
  edJUROS_BAIXA.TagFloat := 0;
  edJUROS_BAIXA.Text := '';
  edVALOR_BAIXA.TagFloat := 0;
  edVALOR_BAIXA.Text := '';
  edOBSERVACAO.Text := '';
end;

procedure TfrmMov_Financeiro.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin

  TLoading.Show(frmMov_Financeiro,'Listando Registros');
  lbRegistros.Clear;
  lbRegistros.BeginUpdate;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
    FQuery_H :TFDQuery;
    FTotal :Double;
  begin
    FQuery_H := TFDQuery.Create(Nil);
    FQuery_H.Connection := FDm_Global.FDC_SQLite;
    FQuery_H.Active := False;
    FQuery_H.Sql.Clear;
    FQuery_H.Sql.Add('SELECT DISTINCT ');
    FQuery_H.Sql.Add('  C.TIPO');
    FQuery_H.Sql.Add('  ,CASE C.TIPO ');
    FQuery_H.Sql.Add('    WHEN 0 THEN ''CRÉDITO'' ');
    FQuery_H.Sql.Add('    WHEN 1 THEN ''DÉBITO'' ');
    FQuery_H.Sql.Add('  END TIPO_DESC ');
    FQuery_H.Sql.Add('FROM LANCAMENTOS L ');
    FQuery_H.Sql.Add('  JOIN CONTA C ON C.ID = L.ID_CONTA ');
    FQuery_H.Sql.Add('WHERE NOT L.ID IS NULL ');
    FQuery_H.Sql.Add('ORDER BY ');
    FQuery_H.Sql.Add('  L.ID_EMPRESA ');
    FQuery_H.Sql.Add('  ,C.TIPO; ');
    FQuery_H.Active := True;
    if not FQuery_H.IsEmpty then
    begin
      FQuery_H.First;
      while not FQuery_H.Eof do
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          AddRegistros_LB_Header(FQuery_H.FieldByName('TIPO').AsInteger,FQuery_H.FieldByName('TIPO_DESC').AsString);
        end);

        FQuery := TFDQuery.Create(Nil);
        FQuery.Connection := FDm_Global.FDC_SQLite;
        FQuery.Active := False;
        FQuery.Sql.Clear;
        FQuery.Sql.Add('SELECT ');
        FQuery.Sql.Add('  L.* ');
        FQuery.Sql.Add('  ,E.NOME AS EMPRESA ');
        FQuery.Sql.Add('  ,C.DESCRICAO AS CONTA ');
        FQuery.Sql.Add('  ,C.TIPO AS TIPO_CONTA ');
        FQuery.Sql.Add('  ,CASE C.TIPO ');
        FQuery.Sql.Add('    WHEN 0 THEN ''CRÉDITO'' ');
        FQuery.Sql.Add('    WHEN 1 THEN ''DÉBITO'' ');
        FQuery.Sql.Add('  END TIPO_CONTA_DESC ');
        FQuery.Sql.Add('  ,CASE C.TIPO ');
        FQuery.Sql.Add('    WHEN 0 THEN CL.NOME ');
        FQuery.Sql.Add('    WHEN 1 THEN F.NOME ');
        FQuery.Sql.Add('  END PESSOA ');
        FQuery.Sql.Add('  ,CASE L.STATUS ');
        FQuery.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
        FQuery.Sql.Add('    WHEN 1 THEN ''ATVO'' ');
        FQuery.Sql.Add('  END STATUS_DESC ');
        FQuery.Sql.Add('  ,FP.DESCRICAO AS FORMA_PAGTO ');
        FQuery.Sql.Add('  ,FP.CLASSIFICACAO AS CLASS_FORMA ');
        FQuery.Sql.Add('  ,CP.DESCRICAO AS COND_PAGTO ');
        FQuery.Sql.Add('  ,CP.PARCELAS ');
        FQuery.Sql.Add('  ,CP.TIPO_INTERVALO ');
        FQuery.Sql.Add('  ,CASE CP.TIPO_INTERVALO ');
        FQuery.Sql.Add('    WHEN 0 THEN ''DIAS'' ');
        FQuery.Sql.Add('    WHEN 1 THEN ''MESES'' ');
        FQuery.Sql.Add('  END TIPO_INTERVALO_DESC ');
        FQuery.Sql.Add('  ,CP.INTEVALOR ');
        FQuery.Sql.Add('FROM LANCAMENTOS L ');
        FQuery.Sql.Add('  JOIN EMPRESA E ON E.ID = L.ID_EMPRESA ');
        FQuery.Sql.Add('  JOIN CONTA C ON C.ID = L.ID_CONTA ');
        FQuery.Sql.Add('  LEFT JOIN CLIENTE CL ON CL.ID = L.ID_PESSOA ');
        FQuery.Sql.Add('  LEFT JOIN FORNECEDOR F ON F.ID = L.ID_PESSOA ');
        FQuery.Sql.Add('  JOIN FORMA_PAGAMENTO FP ON FP.ID = L.FORMA_PAGTO_ID ');
        FQuery.Sql.Add('  JOIN CONDICAO_PAGAMENTO CP ON CP.ID = L.COND_PAGTO_ID ');
        FQuery.Sql.Add('WHERE NOT L.ID IS NULL ');
        FQuery.Sql.Add('  AND C.TIPO = ' + FQuery_H.FieldByName('TIPO').AsString);
        FQuery.Sql.Add('ORDER BY ');
        FQuery.Sql.Add('  L.ID_EMPRESA; ');
        FQuery.Active := True;
        if not FQuery.IsEmpty then
        begin
          FTotal := 0;
          FQuery.First;
          while not FQuery.Eof do
          begin
            TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              AddRegistros_LB(
                FQuery.FieldByName('ID').AsInteger
                ,FQuery.FieldByName('ID_CONTA').AsInteger
                ,FQuery.FieldByName('ID_PESSOA').AsInteger
                ,FQuery.FieldByName('SINCRONIZADO').AsInteger
                ,FQuery.FieldByName('EXCLUIDO').AsInteger
                ,FQuery.FieldByName('STATUS').AsInteger
                ,FQuery.FieldByName('PESSOA').AsString
                ,FQuery.FieldByName('CONTA').AsString
                ,FQuery.FieldByName('TIPO_CONTA_DESC').AsString
                ,FQuery.FieldByName('DT_EMISSAO').AsString
                ,FQuery.FieldByName('DT_VENCIMENTO').AsString
                ,FQuery.FieldByName('DT_BAIXA').AsString
                ,FQuery.FieldByName('VALOR').AsFloat
                ,FQuery.FieldByName('VALOR_BAIXA').AsFloat
              );
            end);

            FTotal := (FTotal + FQuery.FieldByName('VALOR').AsFloat);
            FQuery.Next;
          end;
        end;
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          AddRegistros_LB_Footer(FTotal);
        end);
        FQuery_H.Next;
      end;
    end;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbRegistros.EndUpdate;
    end);

    if Assigned(FQuery) then
      FreeAndNil(FQuery);

  end);

  t.OnTerminate := TThreadEnd_Listar_Registros;
  t.Start;
end;

procedure TfrmMov_Financeiro.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmMov_Financeiro,'Salvando alterações');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
    FId :Integer;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;

    FQuery.Active := False;
    FQuery.Sql.Clear;

    if FTab_Status = dsInsert then
    begin
      FQuery.Sql.Add('INSERT INTO LANCAMENTOS( ');
      FQuery.Sql.Add('  ID_EMPRESA ');
      FQuery.Sql.Add('  ,DT_EMISSAO ');
      FQuery.Sql.Add('  ,ID_CONTA ');
      FQuery.Sql.Add('  ,ID_PESSOA ');
      FQuery.Sql.Add('  ,STATUS ');
      FQuery.Sql.Add('  ,FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,VALOR ');
      FQuery.Sql.Add('  ,ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,ID_ORIGEM_LANCAMENTO ');
      if Trim(edDT_BAIXA.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,DT_BAIXA ');
        FQuery.Sql.Add('  ,HR_BAIXA ');
        FQuery.Sql.Add('  ,ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,JUROS_BAIXA ');
        FQuery.Sql.Add('  ,VALOR_BAIXA ');
      end;
      FQuery.Sql.Add('  ,ID_USUARIO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,OBSERVACAO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :ID_EMPRESA ');
      FQuery.Sql.Add('  ,:DT_EMISSAO ');
      FQuery.Sql.Add('  ,:ID_CONTA ');
      FQuery.Sql.Add('  ,:ID_PESSOA ');
      FQuery.Sql.Add('  ,:STATUS ');
      FQuery.Sql.Add('  ,:FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,:COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,:DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,:VALOR ');
      FQuery.Sql.Add('  ,:ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,:ID_ORIGEM_LANCAMENTO ');
      if Trim(edDT_BAIXA.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,:DT_BAIXA ');
        FQuery.Sql.Add('  ,:HR_BAIXA ');
        FQuery.Sql.Add('  ,:ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,:DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,:JUROS_BAIXA ');
        FQuery.Sql.Add('  ,:VALOR_BAIXA ');
      end;
      FQuery.Sql.Add('  ,:ID_USUARIO ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('  ,:OBSERVACAO ');
      FQuery.Sql.Add('  ,:SINCRONIZADO ');
      FQuery.Sql.Add('  ,:ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,:EXCLUIDO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
      FQuery.ParamByName('ID_PRINCIPAL').AsInteger := 0;
      FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
      FQuery.ParamByName('EXCLUIDO').AsInteger := 0;
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'PROPRIO';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsInteger := FId;
    end
    else if FTab_Status = dsEdit then
    begin
      FQuery.Sql.Add('UPDATE LANCAMENTOS SET ');
      FQuery.Sql.Add('  ID_EMPRESA = :ID_EMPRESA ');
      FQuery.Sql.Add('  ,DT_EMISSAO = :DT_EMISSAO ');
      FQuery.Sql.Add('  ,ID_CONTA = :ID_CONTA ');
      FQuery.Sql.Add('  ,ID_PESSOA = :ID_PESSOA ');
      FQuery.Sql.Add('  ,STATUS = :STATUS ');
      FQuery.Sql.Add('  ,FORMA_PAGTO_ID = :FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,COND_PAGTO_ID = :COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,DT_VENCIMENTO = :DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,VALOR = :VALOR ');
      if Trim(edDT_BAIXA.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,DT_BAIXA = :DT_BAIXA ');
        FQuery.Sql.Add('  ,HR_BAIXA = :HR_BAIXA ');
        FQuery.Sql.Add('  ,ID_USUARIO_BAIXA = :ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,DESCONTO_BAIXA = :DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,JUROS_BAIXA = :JUROS_BAIXA ');
        FQuery.Sql.Add('  ,VALOR_BAIXA = :VALOR_BAIXA ');
      end;
      FQuery.Sql.Add('  ,OBSERVACAO = :OBSERVACAO ');
      //FQuery.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      //FQuery.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      //FQuery.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      //FQuery.Sql.Add('  ,SINCRONIZADO = :SINCRONIZADO');
      //FQuery.Sql.Add('  ,ID_PRINCIPAL = :ID_PRINCIPAL');
      //FQuery.Sql.Add('  ,EXCLUIDO = :EXCLUIDO');
      FQuery.Sql.Add('WHERE ID = :ID; ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('ID_EMPRESA').AsInteger := edID_EMPRESA.Tag;
    FQuery.ParamByName('DT_EMISSAO').AsDate := StrToDate(edDATA.Text);
    FQuery.ParamByName('ID_CONTA').AsInteger := edID_CONTA.Tag;
    FQuery.ParamByName('ID_PESSOA').AsInteger := edID_PESSOA.Tag;
    FQuery.ParamByName('STATUS').AsInteger := edSTATUS.Tag;
    FQuery.ParamByName('FORMA_PAGTO_ID').AsInteger := edFORMA_PAGTO_ID.Tag;
    FQuery.ParamByName('COND_PAGTO_ID').AsInteger := edCOND_PAGTO_ID.Tag;
    FQuery.ParamByName('DT_VENCIMENTO').AsDate := StrToDate(edDT_VENCIMENTO.Text);
    FQuery.ParamByName('VALOR').AsFloat := edVALOR.TagFloat;
    if Trim(edDT_BAIXA.Text) <> '' then
    begin
      FQuery.ParamByName('DT_BAIXA').AsDate := StrToDate(edDT_BAIXA.Text);
      FQuery.ParamByName('HR_BAIXA').AsTime := Time;
      FQuery.ParamByName('ID_USUARIO_BAIXA').AsInteger := frmPrincipal.FUser_Id;
      FQuery.ParamByName('DESCONTO_BAIXA').AsFloat := edDESCONTO_BAIXA.TagFloat;
      FQuery.ParamByName('JUROS_BAIXA').AsFloat := edJUROS_BAIXA.TagFloat;
      FQuery.ParamByName('VALOR_BAIXA').AsFloat := edVALOR_BAIXA.TagFloat;
    end;
    FQuery.ParamByName('OBSERVACAO').AsString := edOBSERVACAO.Text;
    FQuery.ExecSQL;

    {$IFDEF MSWINDOWS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}

  end);

  t.OnTerminate := TTHreadEnd_Salvar;
  t.Start;
end;

procedure TfrmMov_Financeiro.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmMov_Financeiro.TThreadEnd_Editar(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FTab_Status := dsEdit;
    imgAcao_01.Tag := 1;
    imgAcao_01.Bitmap := imgSalvar.Bitmap;
    tcCampos.TabIndex := 0;
    tcPrincipal.GotoVisibleTab(1);
    FEdidanto := False;
  end;
end;

procedure TfrmMov_Financeiro.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmMov_Financeiro.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmMov_Financeiro.TTHreadEnd_Salvar(Sender: TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Salvar',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FTab_Status := dsLista;
    imgAcao_01.Tag := 0;
    imgAcao_01.Bitmap := imgNovo.Bitmap;
    tcPrincipal.GotoVisibleTab(0);
    Listar_Registros(edFiltro.Text);
  end;
end;

end.
