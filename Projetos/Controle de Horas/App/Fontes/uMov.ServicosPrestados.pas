unit uMov.ServicosPrestados;

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
    uFrame.SPData,
    uFrame.SPDados,
    uFrame.SPTotais,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Calendar;

type
  TExecuteOnClose = procedure(AId:Integer; ADescricao:String) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmMov_ServicosPrestados = class(TForm)
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
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
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
    lytRow_C01_002: TLayout;
    lytDESCRICAO: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    lytRow_Navegar_01: TLayout;
    imgAvancar_001: TImage;
    lytRow_C02_001: TLayout;
    lytID_EMPRESA: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_C02_002: TLayout;
    lytID_CONTA: TLayout;
    lbID_CONTA: TLabel;
    edID_CONTA: TEdit;
    imgID_CONTA: TImage;
    tiCampos_002: TTabItem;
    lytCampos_002: TLayout;
    lytRow_Navegar_02: TLayout;
    imgAvancar_002: TImage;
    imgRetornar_001: TImage;
    tiCampos_003: TTabItem;
    lytCampos_003: TLayout;
    lytRow_C03_001: TLayout;
    lytHR_INICIO: TLayout;
    lbHR_INICIO: TLabel;
    edHR_INICIO: TEdit;
    lytHR_TOTAL: TLayout;
    lbHR_TOTAL: TLabel;
    edHR_TOTAL: TEdit;
    lytRow_C03_002: TLayout;
    lytRow_Navegar_03: TLayout;
    imgRetornar_002: TImage;
    lytDATA: TLayout;
    lbDATA: TLabel;
    edDATA: TEdit;
    imgDATA: TImage;
    lytRow_C02_003: TLayout;
    lytID_PRESTADOR_SERVICO: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO: TEdit;
    imgID_PRESTADOR_SERVICO: TImage;
    lytRow_C02_004: TLayout;
    lytID_CLIENTE: TLayout;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE: TEdit;
    imgID_CLIENTE: TImage;
    lytRow_C02_005: TLayout;
    lytID_TABELA: TLayout;
    lbID_TABELA: TLabel;
    edID_TABELA: TEdit;
    imgID_TABELA: TImage;
    lytHR_FIM: TLayout;
    lbHR_FIM: TLabel;
    edHR_FIM: TEdit;
    lytDESCONTO: TLayout;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lytSUB_TOTAL: TLayout;
    lbSUB_TOTAL: TLabel;
    edSUB_TOTAL: TEdit;
    lytACRESCIMO: TLayout;
    lbACRESCIMO: TLabel;
    edACRESCIMO: TEdit;
    lytRow_C03_003: TLayout;
    lytTOTAL: TLayout;
    lbTOTAL: TLabel;
    edTOTAL: TEdit;
    lytRow_C03_004: TLayout;
    lytOBSERVACAO: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_C03_005: TLayout;
    lytVLR_PAGO: TLayout;
    lbVLR_PAGO: TLabel;
    lytDT_PAGO: TLayout;
    lbDT_PAGO: TLabel;
    edDT_PAGO: TEdit;
    imgDT_PAGO: TImage;
    edVLR_PAGO: TEdit;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure imgAvancar_001Click(Sender: TObject);
    procedure imgRetornar_001Click(Sender: TObject);
    procedure imgAvancar_002Click(Sender: TObject);
    procedure imgRetornar_002Click(Sender: TObject);
    procedure edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDATATyping(Sender: TObject);
    procedure edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edID_PRESTADOR_SERVICOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edID_CLIENTEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edHR_INICIOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edHR_INICIOTyping(Sender: TObject);
    procedure edHR_FIMKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edHR_TOTALTyping(Sender: TObject);
    procedure edHR_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSUB_TOTALTyping(Sender: TObject);
    procedure edDESCONTOTyping(Sender: TObject);
    procedure edSUB_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edACRESCIMOTyping(Sender: TObject);
    procedure edACRESCIMOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edOBSERVACAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDT_PAGOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDT_PAGOTyping(Sender: TObject);
    procedure edVLR_PAGOTyping(Sender: TObject);
    procedure edHR_FIMExit(Sender: TObject);
    procedure imgDATAClick(Sender: TObject);
    procedure imgDT_PAGOClick(Sender: TObject);
    procedure imgCalendario_CancelarClick(Sender: TObject);
    procedure CalendarDateSelected(Sender: TObject);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgLimparClick(Sender: TObject);
    procedure edSTATUSClick(Sender: TObject);
    procedure edID_EMPRESAClick(Sender: TObject);
    procedure edID_CONTAClick(Sender: TObject);
    procedure edID_PRESTADOR_SERVICOClick(Sender: TObject);
    procedure edID_CLIENTEClick(Sender: TObject);
    procedure edID_TABELAClick(Sender: TObject);
    procedure edHR_FIMTyping(Sender: TObject);
    procedure edHR_INICIOChange(Sender: TObject);
    procedure edSUB_TOTALChange(Sender: TObject);
    procedure edHR_TOTALChange(Sender: TObject);
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
      AId,ASincronizado,AExcluido,AStatus:Integer;
      ACliente,AConta,AHora_I,AHora_F,AHora_T,ADescricao:String;
      AValor,ATotal:Double);
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure AddRegistros_LB_Header(AData:TDate);
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
    procedure Sel_Conta(Aid,ATipo: Integer; ANome: String);
    procedure Sel_Prest_Servicos(Aid: Integer; ANome: String);
    procedure Sel_Cliente(Aid: Integer; ANome: String);
    procedure Sel_TabPreco(Aid: Integer; ANome: String; AValor:Double);
    procedure TThreadEnd_CalcHora(Sender: TObject);
    procedure TThreadEnd_CalculaValor(Sender: TOBject);

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
  ,uCad.Conta
  ,uCad.PrestadorServicos
  ,uCad.Cliente
  ,uCad.TabelaPreco;

procedure TfrmMov_ServicosPrestados.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_SP_Dados;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_SP_Dados;

  FId := FFrame.lbId.Tag;
  FDescricao := FFrame.lbId.Text;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmMov_ServicosPrestados.AddRegistros_LB(
      AId,ASincronizado,AExcluido,AStatus:Integer;
      ACliente,AConta,AHora_I,AHora_F,AHora_T,ADescricao:String;
      AValor,ATotal:Double);
var
  FItem :TListBoxItem;
  FFrame :TFrame_SP_Dados;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 100;
    FItem.Tag := AId;
    FItem.TagString := ADescricao;
    FItem.Selectable := True;

    FFrame := TFrame_SP_Dados.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbID.Text := AId.ToString;
    FFrame.lbID.Tag := AId;
    FFrame.lbConta.Text := AConta;
    FFrame.lbCliente.Text := ACliente;
    FFrame.lbHR_INICIO.Text := AHora_I;
    FFrame.lbHR_FIM.Text := AHora_F;
    FFrame.lbHR_TOTAL.Text := AHora_T;
    FFrame.lbVLR_HORA.TagFloat := AValor;
    FFrame.lbVLR_HORA.Text := FormatFloat('R$ #,##0.00',AValor);
    FFrame.lbTOTAL.TagFloat := ATotal;
    FFrame.lbTOTAL.Text := FormatFloat('R$ #,##0.00',ATotal);
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

procedure TfrmMov_ServicosPrestados.AddRegistros_LB_Footer(ATotal: Double);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.AddRegistros_LB_Header(AData: TDate);
begin
  //
end;

procedure TfrmMov_ServicosPrestados.CalendarDateSelected(Sender: TObject);
begin
  case FDataRetorno of
    0:edDATA.Text := DateToStr(Calendar.Date);
    1:edDT_PAGO.Text := DateToStr(Calendar.Date);
  end;

  rctCalendario_Tampa.Visible := False;

end;

procedure TfrmMov_ServicosPrestados.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmMov_ServicosPrestados.CriandoCombos;
begin

  cComboStatus := TCustomCombo.Create(frmMov_ServicosPrestados);

  {$Region 'Combo Pessoa'}
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
  {$EndRegion 'Combo Pessoa'}

end;

procedure TfrmMov_ServicosPrestados.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmMov_ServicosPrestados);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);
end;

procedure TfrmMov_ServicosPrestados.edACRESCIMOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edOBSERVACAO.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edACRESCIMOTyping(Sender: TObject);
begin
  Formatar(edACRESCIMO,Money);
  edACRESCIMO.TagFloat := TFuncoes.RetornaValor_TextMoney(edACRESCIMO.Text,2);

end;

procedure TfrmMov_ServicosPrestados.edDATAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edSTATUS.SetFocus;
end;

procedure TfrmMov_ServicosPrestados.edDATATyping(Sender: TObject);
begin
  Formatar(edDATA,Dt);
end;

procedure TfrmMov_ServicosPrestados.edDESCONTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edACRESCIMO.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edDESCONTOTyping(Sender: TObject);
begin
  Formatar(edDESCONTO,Money);
  edDESCONTO.TagFloat := TFuncoes.RetornaValor_TextMoney(edDESCONTO.Text,2);

end;

procedure TfrmMov_ServicosPrestados.edDT_PAGOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edVLR_PAGO.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edDT_PAGOTyping(Sender: TObject);
begin
  Formatar(edDT_PAGO,Dt);
end;

procedure TfrmMov_ServicosPrestados.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);

end;

procedure TfrmMov_ServicosPrestados.edHR_FIMExit(Sender: TObject);
begin
  if ((Trim(edHR_INICIO.Text) = '') and (Trim(edHR_FIM.Text) = '')) then
  begin
    edHR_TOTAL.ReadOnly := True;
    edHR_TOTAL.TabStop := False;
  end
  else
  begin
    edHR_TOTAL.ReadOnly := False;
    edHR_TOTAL.TabStop := True;
  end;

end;

procedure TfrmMov_ServicosPrestados.edHR_FIMKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if Trim(edHR_INICIO.Text) = '' then
    begin
      edHR_TOTAL.ReadOnly := False;
      edHR_TOTAL.SetFocus;
    end
    else
    begin
      edHR_TOTAL.ReadOnly := True;
      edSUB_TOTAL.SetFocus;
    end;
  end;
end;

procedure TfrmMov_ServicosPrestados.edHR_FIMTyping(Sender: TObject);
begin
  Formatar(edHR_FIM,Hr);
end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOChange(Sender: TObject);
var
  t :TThread;

begin

  if FEdidanto then
    Exit;

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
        FTotal_Receber := ((FHora_Resultado * 24) * edID_TABELA.TagFloat);
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
    edHR_FIM.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edHR_INICIOTyping(Sender: TObject);
begin
  Formatar(edHR_INICIO,Hr);
end;

procedure TfrmMov_ServicosPrestados.edHR_TOTALChange(Sender: TObject);
var
  FHora_Resultado :TDateTime;
  FTotal_Receber :Double;
  FHora, FMinuto, FSegundo :Integer;
  FVlr_Hr, FVlr_Mn, FVlr_Sg :Double;

begin
  if ((Trim(edHR_INICIO.Text) = '') and (Trim(edHR_FIM.Text) = '')) then
  begin
    FHora := 0;
    FMinuto := 0;
    FSegundo := 0;
    FVlr_Hr := 0;
    FVlr_Mn := 0;
    FVlr_Sg := 0;

    FHora := StrToIntDef(Copy(edHR_TOTAL.Text,1,3),0);
    FMinuto := StrToIntDef(Copy(edHR_TOTAL.Text,5,2),0);
    FSegundo := StrToIntDef(Copy(edHR_TOTAL.Text,8,2),0);

    FVlr_Hr := (FHora * edID_TABELA.TagFloat);
    FVlr_Mn := (FMinuto * (edID_TABELA.TagFloat / 60));
    FVlr_Sg := (FSegundo * (edID_TABELA.TagFloat / 3600));;

    FTotal_Receber := (FVlr_Hr + FVlr_Mn + FVlr_Sg);
    edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00',FTotal_Receber);
    edSUB_TOTAL.TagFloat := FTotal_Receber;
    edSUB_TOTALChange(Sender);
  end;
end;

procedure TfrmMov_ServicosPrestados.edHR_TOTALKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
    if Trim(edHR_INICIO.Text) = '' then
      edDESCONTO.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edHR_TOTALTyping(Sender: TObject);
begin
  if ((Trim(edHR_INICIO.Text) = '') and (Trim(edHR_FIM.Text) = '')) then
    Formatar(edHR_TOTAL,Tempo);
end;

procedure TfrmMov_ServicosPrestados.edID_CLIENTEClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Cliente) then
    Application.CreateForm(TfrmCad_Cliente,frmCad_Cliente);

  frmCad_Cliente.Pesquisa := True;
  frmCad_Cliente.ExecuteOnClose := Sel_Cliente;
  frmCad_Cliente.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_Cliente(Aid:Integer; ANome:String);
begin
  edID_CLIENTE.Tag := Aid;
  edID_CLIENTE.Text := ANome;
end;

procedure TfrmMov_ServicosPrestados.edID_CLIENTEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_TABELA.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edID_CONTAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas,frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_Conta;
  frmCad_Contas.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_Conta(Aid,ATipo:Integer; ANome:String);
begin
  edID_CONTA.Tag := Aid;
  edID_CONTA.Text := ANome;
end;

procedure TfrmMov_ServicosPrestados.edID_CONTAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_PRESTADOR_SERVICO.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa,frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_Empresa(Aid:Integer; ANome:String);
begin
  edID_EMPRESA.Tag := Aid;
  edID_EMPRESA.Text := ANome;
end;

procedure TfrmMov_ServicosPrestados.edID_EMPRESAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CONTA.SetFocus
end;

procedure TfrmMov_ServicosPrestados.edID_PRESTADOR_SERVICOClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_PrestadorServicos) then
    Application.CreateForm(TfrmCad_PrestadorServicos,frmCad_PrestadorServicos);

  frmCad_PrestadorServicos.Pesquisa := True;
  frmCad_PrestadorServicos.ExecuteOnClose := Sel_Prest_Servicos;
  frmCad_PrestadorServicos.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_Prest_Servicos(Aid:Integer; ANome:String);
begin
  edID_PRESTADOR_SERVICO.Tag := Aid;
  edID_PRESTADOR_SERVICO.Text := ANome;
end;

procedure TfrmMov_ServicosPrestados.edID_PRESTADOR_SERVICOKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edID_CLIENTE.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edID_TABELAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_TabelaPreco) then
    Application.CreateForm(TfrmCad_TabelaPreco,frmCad_TabelaPreco);

  frmCad_TabelaPreco.Pesquisa := True;
  frmCad_TabelaPreco.ExecuteOnClose := Sel_TabPreco;
  frmCad_TabelaPreco.Show;
end;

procedure TfrmMov_ServicosPrestados.Sel_TabPreco(Aid: Integer; ANome: String; AValor:Double);
begin
  edID_TABELA.Tag := Aid;
  edID_TABELA.Text := ANome + ' - ' + FormatFloat('R$ #,##0.00',AValor);
  edID_TABELA.TagFloat := AValor;
  FValor_Hora := AValor;
end;

procedure TfrmMov_ServicosPrestados.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmMov_ServicosPrestados,'Editando o Registro');
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
    FQuery.Sql.Add('  SP.* ');
    FQuery.Sql.Add('  ,CASE SP.STATUS ');
    FQuery.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''ATIVO'' ');
    FQuery.Sql.Add('  END STATUS_DES ');
    FQuery.Sql.Add('  ,E.NOME AS EMPRESA ');
    FQuery.Sql.Add('  ,PS.NOME AS PREST_SERVICO ');
    FQuery.Sql.Add('  ,C.NOME AS CLIENTE ');
    FQuery.Sql.Add('  ,TP.DESCRICAO AS TAB_PRECO ');
    FQuery.Sql.Add('  ,TP.VALOR ');
    FQuery.Sql.Add('  ,CASE TP.TIPO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''HORA'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''FIXO'' ');
    FQuery.Sql.Add('  END TIPO_TABELA ');
    FQuery.Sql.Add('  ,CN.DESCRICAO AS CONTA_NOME ');
    FQuery.Sql.Add('FROM SERVICOS_PRESTADOS SP ');
    FQuery.Sql.Add('  JOIN EMPRESA E ON E.ID = SP.ID_EMPRESA ');
    FQuery.Sql.Add('  JOIN PRESTADOR_SERVICO PS ON PS.ID = SP.ID_PRESTADOR_SERVICO ');
    FQuery.Sql.Add('  JOIN CLIENTE C ON C.ID = SP.ID_CLIENTE ');
    FQuery.Sql.Add('  JOIN TABELA_PRECO TP ON TP.ID = SP.ID_TABELA ');
    FQuery.Sql.Add('  JOIN CONTA CN ON CN.ID = SP.ID_CONTA ');
    FQuery.Sql.Add('WHERE SP.ID = :ID ');
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
        edDATA.Text := FormatDateTime('DD/MM/YYYY', FQuery.FieldByName('DATA').AsDateTime);
        edSTATUS.Tag := FQuery.FieldByName('STATUS').AsInteger;
        edSTATUS.Text := FQuery.FieldByName('STATUS_DES').AsString;
        edDESCRICAO.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edID_EMPRESA.Tag := FQuery.FieldByName('ID_EMPRESA').AsInteger;
        edID_EMPRESA.Text := FQuery.FieldByName('EMPRESA').AsString;
        edID_CONTA.Tag := FQuery.FieldByName('ID_CONTA').AsInteger;
        edID_CONTA.Text := FQuery.FieldByName('CONTA_NOME').AsString;
        edID_PRESTADOR_SERVICO.Tag := FQuery.FieldByName('ID_PRESTADOR_SERVICO').AsInteger;
        edID_PRESTADOR_SERVICO.Text := FQuery.FieldByName('PREST_SERVICO').AsString;
        edID_CLIENTE.Tag := FQuery.FieldByName('ID_CLIENTE').AsInteger;
        edID_CLIENTE.Text := FQuery.FieldByName('CLIENTE').AsString;
        edID_TABELA.Tag := FQuery.FieldByName('ID_TABELA').AsInteger;
        edID_TABELA.Text := FQuery.FieldByName('TAB_PRECO').AsString + ' - ' +
                            FormatFloat('R$ #,##0.00',FQuery.FieldByName('VALOR').AsFloat);
        edID_TABELA.TagFloat := FQuery.FieldByName('VLR_HORA').AsFloat;
        edHR_INICIO.Text := FormatDateTime('HH:NN:SS', FQuery.FieldByName('HR_INICIO').AsDateTime);
        edHR_FIM.Text := FormatDateTime('HH:NN:SS', FQuery.FieldByName('HR_FIM').AsDateTime);
        edHR_TOTAL.Text := FormatDateTime('HH:NN:SS', FQuery.FieldByName('HR_TOTAL').AsDateTime);
        edSUB_TOTAL.TagFloat := FQuery.FieldByName('SUB_TOTAL').AsFloat;
        edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('SUB_TOTAL').AsFloat);
        edDESCONTO.TagFloat := FQuery.FieldByName('DESCONTO').AsFloat;
        edDESCONTO.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('DESCONTO').AsFloat);
        edACRESCIMO.TagFloat := FQuery.FieldByName('ACRESCIMO').AsFloat;
        edACRESCIMO.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('ACRESCIMO').AsFloat);
        edTOTAL.TagFloat := FQuery.FieldByName('TOTAL').AsFloat;
        edTOTAL.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('TOTAL').AsFloat);
        edOBSERVACAO.Text := FQuery.FieldByName('OBSERVACAO').AsString;
        if not FQuery.FieldByName('DT_PAGO').IsNull then
          edDT_PAGO.Text := FormatDateTime('DD/MM/YYYY', FQuery.FieldByName('DT_PAGO').AsDateTime);
        edVLR_PAGO.TagFloat := FQuery.FieldByName('VLR_PAGO').AsFloat;
        edVLR_PAGO.Text := FormatFloat('R$ #,##0.00', FQuery.FieldByName('VLR_PAGO').AsFloat);
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

procedure TfrmMov_ServicosPrestados.edOBSERVACAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDT_PAGO.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edSTATUSClick(Sender: TObject);
begin
  cComboStatus.ShowMenu;
end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALChange(Sender: TObject);
var
  t :TThread;

begin

  if FEdidanto then
    Exit;

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
    edDESCONTO.SetFocus

end;

procedure TfrmMov_ServicosPrestados.edSUB_TOTALTyping(Sender: TObject);
begin
  Formatar(edSUB_TOTAL,Money);
  edSUB_TOTAL.TagFloat := TFuncoes.RetornaValor_TextMoney(edSUB_TOTAL.Text,2);
end;

procedure TfrmMov_ServicosPrestados.edVLR_PAGOTyping(Sender: TObject);
begin
  Formatar(edVLR_PAGO,Money);
  edVLR_PAGO.TagFloat := TFuncoes.RetornaValor_TextMoney(edVLR_PAGO.Text,2);

end;

procedure TfrmMov_ServicosPrestados.Excluir(Sender: TObject);
begin
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmMov_ServicosPrestados.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmMov_ServicosPrestados,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE SERVICOS_PRESTADOS SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmMov_ServicosPrestados.FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmMov_ServicosPrestados := Nil;
end;

procedure TfrmMov_ServicosPrestados.FormCreate(Sender: TObject);
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

  FFancyDialog := TFancyDialog.Create(frmMov_ServicosPrestados);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;
  tcCampos.ActiveTab := tiCampos_001;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;
  FEdidanto := False;
end;

procedure TfrmMov_ServicosPrestados.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmMov_ServicosPrestados.imgAcao_01Click(Sender: TObject);
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
      edDESCONTO.Tag := 0;
      edACRESCIMO.Tag := 0;
      edDATA.Text := DateToStr(Date);
      tcPrincipal.GotoVisibleTab(1);
      if edDATA.CanFocus then
        edDATA.SetFocus;
      FEdidanto := False;
    end;
    1:Salvar;
  end;
end;

procedure TfrmMov_ServicosPrestados.imgAvancar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmMov_ServicosPrestados.imgAvancar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(2);
end;

procedure TfrmMov_ServicosPrestados.imgCalendario_CancelarClick(Sender: TObject);
begin
  rctCalendario_Tampa.Visible := False;
end;

procedure TfrmMov_ServicosPrestados.imgDATAClick(Sender: TObject);
begin
  rctCalendario_Tampa.Align := TAlignLayout.Contents;
  FDataRetorno := TImage(Sender).Tag;
  Calendar.Date := Date;
  rctCalendario_Tampa.Visible := True;

end;

procedure TfrmMov_ServicosPrestados.imgDT_PAGOClick(Sender: TObject);
begin
  rctCalendario_Tampa.Align := TAlignLayout.Contents;
  FDataRetorno := TImage(Sender).Tag;
  Calendar.Date := Date;
  rctCalendario_Tampa.Visible := True;

end;

procedure TfrmMov_ServicosPrestados.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmMov_ServicosPrestados.imgRetornar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(0);
end;

procedure TfrmMov_ServicosPrestados.imgRetornar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmMov_ServicosPrestados.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FDescricao);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

{$IFDEF MSWINDOWS}
procedure TfrmMov_ServicosPrestados.ItemClick_Status(Sender: TObject);
begin
  cComboStatus.HideMenu;
  edSTATUS.Text := cComboStatus.DescrItem;
  edSTATUS.Tag := StrToIntDef(cComboStatus.CodItem,0);
end;
{$ELSE}
procedure TfrmMov_ServicosPrestados.ItemClick_Status(Sender: TObject; const Point: TPointF);
begin
  cComboStatus.HideMenu;
  edSTATUS.Text := cComboStatus.DescrItem;
  edSTATUS.Tag := StrToIntDef(cComboStatus.CodItem,0);
end;
{$ENDIF}

procedure TfrmMov_ServicosPrestados.lbRegistrosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FDescricao := Item.TagString;
end;

procedure TfrmMov_ServicosPrestados.LimparCampos;
begin
  edID.Tag := 0;
  edID.Text := '';
  edDATA.Text := '';
  edSTATUS.Tag := -1;
  edSTATUS.Text := '';
  edDESCRICAO.Text := '';
  edID_EMPRESA.Tag := 0;
  edID_EMPRESA.Text := '';
  edID_CONTA.Tag := 0;
  edID_CONTA.Text := '';
  edID_PRESTADOR_SERVICO.Tag := 0;
  edID_PRESTADOR_SERVICO.Text := '';
  edID_CLIENTE.Tag := 0;
  edID_CLIENTE.Text := '';
  edID_TABELA.Tag := 0;
  edID_TABELA.Text := '';
  edHR_INICIO.Text := '';
  edHR_FIM.Text := '';
  edHR_TOTAL.Text := '';
  edSUB_TOTAL.TagFloat := 0;
  edSUB_TOTAL.Text := '';
  edDESCONTO.TagFloat := 0;
  edDESCONTO.Text := '';
  edACRESCIMO.TagFloat := 0;
  edACRESCIMO.Text := '';
  edTOTAL.TagFloat := 0;
  edTOTAL.Text := '';
  edOBSERVACAO.Text := '';
  edDT_PAGO.Text := '';
  edVLR_PAGO.TagFloat := 0;
  edVLR_PAGO.Text;
end;

procedure TfrmMov_ServicosPrestados.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmMov_ServicosPrestados,'Listando Registros');
  lbRegistros.Clear;
  lbRegistros.BeginUpdate;

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
    FQuery.Sql.Add('  SP.* ');
    FQuery.Sql.Add('  ,CASE SP.STATUS ');
    FQuery.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''ATIVO'' ');
    FQuery.Sql.Add('  END STATUS_DES ');
    FQuery.Sql.Add('  ,E.NOME AS EMPRESA ');
    FQuery.Sql.Add('  ,PS.NOME AS PREST_SERVICO ');
    FQuery.Sql.Add('  ,C.NOME AS CLIENTE ');
    FQuery.Sql.Add('  ,TP.DESCRICAO AS TAB_PRECO ');
    FQuery.Sql.Add('  ,TP.VALOR ');
    FQuery.Sql.Add('  ,CASE TP.TIPO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''HORA'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''FIXO'' ');
    FQuery.Sql.Add('  END TIPO_TABELA ');
    FQuery.Sql.Add('  ,CN.DESCRICAO AS CONTA_NOME ');
    FQuery.Sql.Add('FROM SERVICOS_PRESTADOS SP ');
    FQuery.Sql.Add('  JOIN EMPRESA E ON E.ID = SP.ID_EMPRESA ');
    FQuery.Sql.Add('  JOIN PRESTADOR_SERVICO PS ON PS.ID = SP.ID_PRESTADOR_SERVICO ');
    FQuery.Sql.Add('  JOIN CLIENTE C ON C.ID = SP.ID_CLIENTE ');
    FQuery.Sql.Add('  JOIN TABELA_PRECO TP ON TP.ID = SP.ID_TABELA ');
    FQuery.Sql.Add('  JOIN CONTA CN ON CN.ID = SP.ID_CONTA ');
    FQuery.Sql.Add('WHERE NOT SP.ID IS NULL ');
    FQuery.Sql.Add('ORDER BY ');
    FQuery.Sql.Add('  SP.ID; ');
    if Trim(APesquisa) <> '' then
    begin
      FQuery.Sql.Add('  AND PS.DESCRICAO LIKE :DESCRICAO');
      FQuery.ParamByName('DESCRICAO').AsString := '%' + APesquisa + '%';
    end;
    FQuery.Active := True;
    if not FQuery.IsEmpty then
    begin
      FQuery.First;
      while not FQuery.Eof do
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          AddRegistros_LB(
            FQuery.FieldByName('ID').AsInteger
            ,FQuery.FieldByName('SINCRONIZADO').AsInteger
            ,FQuery.FieldByName('EXCLUIDO').AsInteger
            ,FQuery.FieldByName('STATUS').AsInteger
            ,FQuery.FieldByName('CLIENTE').AsString
            ,FQuery.FieldByName('CONTA_NOME').AsString
            ,FQuery.FieldByName('HR_INICIO').AsString
            ,FQuery.FieldByName('HR_FIM').AsString
            ,FQuery.FieldByName('HR_TOTAL').AsString
            ,FQuery.FieldByName('DESCRICAO').AsString
            ,FQuery.FieldByName('VLR_HORA').AsFloat
            ,FQuery.FieldByName('TOTAL').AsFloat
          );
        end);

        FQuery.Next;
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

procedure TfrmMov_ServicosPrestados.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmMov_ServicosPrestados,'Salvando alterações');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;

    if FTab_Status = dsInsert then
    begin
      FQuery.Sql.Add('INSERT INTO SERVICOS_PRESTADOS( ');
      FQuery.Sql.Add('  DESCRICAO ');
      FQuery.Sql.Add('  ,STATUS ');
      FQuery.Sql.Add('  ,ID_EMPRESA ');
      FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,ID_CLIENTE ');
      FQuery.Sql.Add('  ,ID_TABELA ');
      FQuery.Sql.Add('  ,ID_CONTA ');
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
      if Trim(edDT_PAGO.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,DT_PAGO ');
        FQuery.Sql.Add('  ,VLR_PAGO ');
      end;
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,ID_USUARIO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') ');
      FQuery.Sql.Add('VALUES( ');
      FQuery.Sql.Add('  :DESCRICAO ');
      FQuery.Sql.Add('  ,:STATUS ');
      FQuery.Sql.Add('  ,:ID_EMPRESA ');
      FQuery.Sql.Add('  ,:ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,:ID_CLIENTE ');
      FQuery.Sql.Add('  ,:ID_TABELA ');
      FQuery.Sql.Add('  ,:ID_CONTA ');
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
      if Trim(edDT_PAGO.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,:DT_PAGO ');
        FQuery.Sql.Add('  ,:VLR_PAGO ');
      end;
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('  ,:ID_USUARIO ');
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
    end
    else if FTab_Status = dsEdit then
    begin
      FQuery.Sql.Add('UPDATE SERVICOS_PRESTADOS SET ');
      FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
      FQuery.Sql.Add('  ,STATUS = :STATUS ');
      FQuery.Sql.Add('  ,ID_EMPRESA = :ID_EMPRESA ');
      FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,ID_CLIENTE = :ID_CLIENTE ');
      FQuery.Sql.Add('  ,ID_TABELA = :ID_TABELA ');
      FQuery.Sql.Add('  ,ID_CONTA = :ID_CONTA ');
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
      if Trim(edDT_PAGO.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,DT_PAGO = :DT_PAGO ');
        FQuery.Sql.Add('  ,VLR_PAGO = :VLR_PAGO ');
      end;
      FQuery.Sql.Add('WHERE ID = :ID; ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
    FQuery.ParamByName('STATUS').AsInteger := edSTATUS.Tag;
    FQuery.ParamByName('ID_EMPRESA').AsInteger := edID_EMPRESA.Tag;
    FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := edID_PRESTADOR_SERVICO.Tag;
    FQuery.ParamByName('ID_CLIENTE').AsInteger := edID_CLIENTE.Tag;
    FQuery.ParamByName('ID_TABELA').AsInteger := edID_TABELA.Tag;
    FQuery.ParamByName('ID_CONTA').AsInteger := edID_CONTA.Tag;
    FQuery.ParamByName('DATA').AsDate := StrToDate(edDATA.Text);
    FQuery.ParamByName('HR_INICIO').AsTime := StrToTime(edHR_INICIO.Text);
    FQuery.ParamByName('HR_FIM').AsTime := StrToTime(edHR_FIM.Text);
    FQuery.ParamByName('HR_TOTAL').AsString := edHR_TOTAL.Text;
    FQuery.ParamByName('VLR_HORA').AsFloat := edID_TABELA.TagFloat; //O Valor da hora está armazenada nessa Tag.
    FQuery.ParamByName('SUB_TOTAL').AsFloat := edSUB_TOTAL.TagFloat;
    FQuery.ParamByName('DESCONTO').AsFloat := edDESCONTO.TagFloat;
    FQuery.ParamByName('DESCONTO_MOTIVO').AsString := '';
    FQuery.ParamByName('ACRESCIMO').AsFloat := edACRESCIMO.TagFloat;
    FQuery.ParamByName('ACRESCIMO_MOTIVO').AsString := '';
    FQuery.ParamByName('TOTAL').AsFloat := edTOTAL.TagFloat;
    FQuery.ParamByName('OBSERVACAO').AsString := edOBSERVACAO.Text;
    if Trim(edDT_PAGO.Text) <> '' then
    begin
      FQuery.ParamByName('DT_PAGO').AsDate := StrToDate(edDT_PAGO.Text);
      FQuery.ParamByName('VLR_PAGO').AsFloat := edVLR_PAGO.TagFloat;
    end;
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

procedure TfrmMov_ServicosPrestados.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_Editar(Sender: TOBject);
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

procedure TfrmMov_ServicosPrestados.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);

end;

procedure TfrmMov_ServicosPrestados.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);

end;

procedure TfrmMov_ServicosPrestados.TTHreadEnd_Salvar(Sender: TOBject);
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
