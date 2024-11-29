unit uCad.Fornecedor;

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

  {$Region 'Frames'}
    uFrame.Empresa,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_Fornecedor = class(TForm)
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
    lytRow_001: TLayout;
    lytID: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytPESSOA: TLayout;
    lbPESSOA: TLabel;
    edPESSOA: TEdit;
    imgPESSOA: TImage;
    lytRow_002: TLayout;
    lytNOME: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytRow_003: TLayout;
    lytDOCUMENTO: TLayout;
    lbDOCUMENTO: TLabel;
    edDOCUMENTO: TEdit;
    lytINSC_EST: TLayout;
    lbINSC_EST: TLabel;
    edINSC_EST: TEdit;
    lytRow_Navegar_01: TLayout;
    imgAvancar_001: TImage;
    tiCampos_002: TTabItem;
    lytCampos_002: TLayout;
    lytRow_004: TLayout;
    lytCEP: TLayout;
    lbCEP: TLabel;
    edCEP: TEdit;
    imgCEP: TImage;
    lytRow_005: TLayout;
    lytENDERECO: TLayout;
    lbENDERECO: TLabel;
    edENDERECO: TEdit;
    lytRow_006: TLayout;
    lytNUMERO: TLayout;
    lbNUMERO: TLabel;
    edNUMERO: TEdit;
    lytRow_007: TLayout;
    lytCOMPLEMENTO: TLayout;
    lbCOMPLEMENTO: TLabel;
    edCOMPLEMENTO: TEdit;
    lytRow_008: TLayout;
    lytBAIRRO: TLayout;
    lbBAIRRO: TLabel;
    edBAIRRO: TEdit;
    lytRow_009: TLayout;
    lytCIDADE: TLayout;
    lbCIDADE: TLabel;
    edCIDADE: TEdit;
    lytUF: TLayout;
    lbUF: TLabel;
    edUF: TEdit;
    Image1: TImage;
    lytRow_Navegar_02: TLayout;
    imgAvancar_002: TImage;
    imgRetornar_001: TImage;
    tiCampos_003: TTabItem;
    lytCampos_003: TLayout;
    lytRow_010: TLayout;
    lytTELEFONE: TLayout;
    lbTELEFONE: TLabel;
    edTELEFONE: TEdit;
    lytCELULAR: TLayout;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    lytRow_011: TLayout;
    lytEMAIL: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lytRow_Navegar_03: TLayout;
    imgRetornar_002: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    procedure edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARTyping(Sender: TObject);
    procedure edCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCEPTyping(Sender: TObject);
    procedure edCIDADEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCOMPLEMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDOCUMENTOExit(Sender: TObject);
    procedure edDOCUMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDOCUMENTOTyping(Sender: TObject);
    procedure edENDERECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edINSC_ESTKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edPESSOAClick(Sender: TObject);
    procedure edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edTELEFONEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edTELEFONETyping(Sender: TObject);
    procedure edUFClick(Sender: TObject);
    procedure edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure imgAvancar_001Click(Sender: TObject);
    procedure imgAvancar_002Click(Sender: TObject);
    procedure imgLimparClick(Sender: TObject);
    procedure imgRetornar_001Click(Sender: TObject);
    procedure imgRetornar_002Click(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    cComboPessoa :TCustomCombo;
    cComboUF :TCustomCombo;
    FMenu_Frame :TActionSheet;

    FId :Integer;
    FNome :String;

    FACBr_Validador :TACBr_Validador;
    FPesquisa: Boolean;

    procedure LimparCampos;
    procedure Salvar;
    procedure TTHreadEnd_Salvar(Sender: TOBject);
    procedure Cancelar(Sender: TOBject);

    {$IFDEF MSWINDOWS}
      procedure ItemClick_Pessoa(Sender: TObject);
      procedure ItemClick_UF(Sender: TObject);
    {$ELSE}
      procedure ItemClick_UF(Sender: TObject; const Point: TPointF);
      procedure ItemClick_Pessoa(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    procedure Listar_Registros(APesquisa:String);

    procedure CriandoCombos;
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure AddRegistros_LB(AId,ASincronizado,AExcluido:Integer; ANome,ADocumento,ACeluar:String);
    procedure Abre_Menu_Registros(Sender :TOBject);
    procedure CriandoMenus;
    procedure Editar(Sender: TOBject);
    procedure Excluir(Sender: TObject);
    procedure TThreadEnd_Editar(Sender: TOBject);
    procedure Excluir_Registro(Sender: TObject);
    procedure TThreadEnd_ExcluirRegistro(Sender: TOBject);
    procedure SetPesquisa(const Value: Boolean);

  public
    ExecuteOnClose :TExecuteOnClose;
    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_Fornecedor: TfrmCad_Fornecedor;

implementation

{$R *.fmx}

{ TfrmCad_Fornecedor }

procedure TfrmCad_Fornecedor.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_Empresa;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_Empresa;

  FId := FFrame.lbNome.Tag;
  FNome := FFrame.lbNome.Text;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmCad_Fornecedor.AddRegistros_LB(AId, ASincronizado, AExcluido: Integer; ANome, ADocumento,
  ACeluar: String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_Empresa;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 50;
    FItem.Tag := AId;
    FItem.TagString := ANome;
    FItem.Selectable := True;

    FFrame := TFrame_Empresa.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbNome.Text := ANome;
    FFrame.lbNome.Tag := AId;
    FFrame.lbDocumento.Text := ADocumento;
    FFrame.lbCelular.Text := ACeluar;
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

procedure TfrmCad_Fornecedor.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmCad_Fornecedor.CriandoCombos;
begin

  cComboUF := TCustomCombo.Create(frmCad_Fornecedor);
  cComboPessoa := TCustomCombo.Create(frmCad_Fornecedor);

  {$Region 'Combo Pessoa'}
    cComboPessoa.ItemBackgroundColor := $FF363428;
    cComboPessoa.ItemFontSize := 15;
    cComboPessoa.ItemFontColor := $FFA1B24E;

    cComboPessoa.TitleMenuText := 'Escolha o tipo da Pessoa';
    cComboPessoa.TitleFontSize := 17;
    cComboPessoa.TitleFontColor := $FF363428;

    cComboPessoa.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboPessoa.SubTitleFontSize := 13;
    cComboPessoa.SubTitleFontColor := $FF363428;

    cComboPessoa.BackgroundColor := $FFF2F2F8;
    cComboPessoa.OnClick := ItemClick_Pessoa;

    cComboPessoa.AddItem('0', 'FÍSSICA');
    cComboPessoa.AddItem('1', 'JURÍDICA');
  {$EndRegion 'Combo Pessoa'}

  {$Region 'Combo Unidades Federativas'}
    cComboUF.ItemBackgroundColor := $FF363428;
    cComboUF.ItemFontSize := 15;
    cComboUF.ItemFontColor := $FFA1B24E;

    cComboUF.TitleMenuText := 'Escolha o tipo da Pessoa';
    cComboUF.TitleFontSize := 17;
    cComboUF.TitleFontColor := $FF363428;

    cComboUF.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboUF.SubTitleFontSize := 13;
    cComboUF.SubTitleFontColor := $FF363428;

    cComboUF.BackgroundColor := $FFF2F2F8;
    cComboUF.OnClick := ItemClick_UF;

    cComboUF.AddItem('AC', 'ACRE');
    cComboUF.AddItem('AL', 'ALAGOAS');
    cComboUF.AddItem('AP', 'AMAPÁ');
    cComboUF.AddItem('AM', 'AMAZONAS');
    cComboUF.AddItem('BA', 'BAHIA');
    cComboUF.AddItem('CE', 'CEARÁ');
    cComboUF.AddItem('DF', 'DISTRITO FEDERAL');
    cComboUF.AddItem('ES', 'ESPÍRITO SANTO');
    cComboUF.AddItem('GO', 'GOIÁS');
    cComboUF.AddItem('MA', 'MARANHÃO');
    cComboUF.AddItem('MT', 'MATO GROSSO');
    cComboUF.AddItem('MS', 'MATO GROSSO DO SUL');
    cComboUF.AddItem('MG', 'MINAS GERAIS');
    cComboUF.AddItem('PA', 'PARÁ');
    cComboUF.AddItem('PB', 'PARAÍBA');
    cComboUF.AddItem('PR', 'PARANÁ');
    cComboUF.AddItem('PE', 'PERNAMBUCO');
    cComboUF.AddItem('PI', 'PIAUÍ');
    cComboUF.AddItem('RJ', 'RIO DE JANEIRO');
    cComboUF.AddItem('RN', 'RIO GRANDE DO NORTE');
    cComboUF.AddItem('RS', 'RIO GRANDE DO SUL');
    cComboUF.AddItem('RO', 'RONDÔNIA');
    cComboUF.AddItem('RR', 'RORAIMA');
    cComboUF.AddItem('SC', 'SANTA CATARINA');
    cComboUF.AddItem('SE', 'SERGIPE');
    cComboUF.AddItem('TO', 'TOCANTINS');
  {$EndRegion 'Combo Unidades Federativas'}

end;

procedure TfrmCad_Fornecedor.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmCad_Fornecedor);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);
end;

procedure TfrmCad_Fornecedor.edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCIDADE.SetFocus;

end;

procedure TfrmCad_Fornecedor.edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;

end;

procedure TfrmCad_Fornecedor.edCELULARTyping(Sender: TObject);
begin
  Formatar(edCELULAR,Celular);
end;

procedure TfrmCad_Fornecedor.edCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edENDERECO.SetFocus;

end;

procedure TfrmCad_Fornecedor.edCEPTyping(Sender: TObject);
begin
  Formatar(edCEP,CEP);
end;

procedure TfrmCad_Fornecedor.edCIDADEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edUF.SetFocus;

end;

procedure TfrmCad_Fornecedor.edCOMPLEMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBAIRRO.SetFocus;

end;

procedure TfrmCad_Fornecedor.edDOCUMENTOExit(Sender: TObject);
begin
  try
    case edPESSOA.Tag of
      0:begin
        if not FACBr_Validador.Validar(docCPF,edDOCUMENTO.Text) then
          edDOCUMENTO.SetFocus;
      end;
      1:begin
        if not FACBr_Validador.Validar(docCNPJ,edDOCUMENTO.Text) then
          edDOCUMENTO.SetFocus;
      end;
    end;
  except on E: Exception do
    FFancyDialog.Show(TIconDialog.Error,'Erro',e.Message,'Ok');
  end;
end;

procedure TfrmCad_Fornecedor.edDOCUMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edINSC_EST.SetFocus;

end;

procedure TfrmCad_Fornecedor.edDOCUMENTOTyping(Sender: TObject);
begin
  case edPESSOA.Tag of
    0:Formatar(edDOCUMENTO,CPF);
    1:Formatar(edDOCUMENTO,CNPJ);
  end;

end;

procedure TfrmCad_Fornecedor.edENDERECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edNUMERO.SetFocus;

end;

procedure TfrmCad_Fornecedor.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);

end;

procedure TfrmCad_Fornecedor.edINSC_ESTKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcCampos.GotoVisibleTab(1);
    edCEP.SetFocus;
  end;

end;

procedure TfrmCad_Fornecedor.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmCad_Fornecedor,'Editando o Registro');
  LimparCampos;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('SELECT  ');
    FQuery.Sql.Add('  E.*  ');
    FQuery.Sql.Add('FROM FORNECEDOR E ');
    FQuery.Sql.Add('WHERE E.ID = :ID ');
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
        edPESSOA.Tag := FQuery.FieldByName('PESSOA').AsInteger;
        case edPESSOA.Tag of
          0: edPESSOA.Text := 'FÍSICA';
          1: edPESSOA.Text := 'JURÍDICA';
        end;
        edNOME.Text := FQuery.FieldByName('NOME').AsString;
        edDOCUMENTO.Text := FQuery.FieldByName('DOCUMENTO').AsString;
        edINSC_EST.Text := FQuery.FieldByName('INSC_EST').AsString;
        edCEP.Text := FQuery.FieldByName('CEP').AsString;
        edENDERECO.Text := FQuery.FieldByName('ENDERECO').AsString;
        edNUMERO.Text := FQuery.FieldByName('NUMERO').AsString;
        edCOMPLEMENTO.Text := FQuery.FieldByName('COMPLEMENTO').AsString;
        edBAIRRO.Text := FQuery.FieldByName('BAIRRO').AsString;
        edCIDADE.Text := FQuery.FieldByName('CIDADE').AsString;
        edUF.Text := FQuery.FieldByName('UF').AsString;
        edTELEFONE.Text := FQuery.FieldByName('TELEFONE').AsString;
        edCELULAR.Text := FQuery.FieldByName('CELULAR').AsString;
        edEMAIL.Text := FQuery.FieldByName('EMAIL').AsString;
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

procedure TfrmCad_Fornecedor.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDOCUMENTO.SetFocus;

end;

procedure TfrmCad_Fornecedor.edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCOMPLEMENTO.SetFocus;

end;

procedure TfrmCad_Fornecedor.edPESSOAClick(Sender: TObject);
begin
  cComboPessoa.ShowMenu;
end;

procedure TfrmCad_Fornecedor.edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edNOME.SetFocus;

end;

procedure TfrmCad_Fornecedor.edTELEFONEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCELULAR.SetFocus;

end;

procedure TfrmCad_Fornecedor.edTELEFONETyping(Sender: TObject);
begin
  Formatar(edTELEFONE,TelefoneFixo);
end;

procedure TfrmCad_Fornecedor.edUFClick(Sender: TObject);
begin
  cComboUF.ShowMenu;
end;

procedure TfrmCad_Fornecedor.edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcCampos.GotoVisibleTab(2);
    edTELEFONE.SetFocus;
  end;

end;

procedure TfrmCad_Fornecedor.Excluir(Sender: TObject);
begin
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmCad_Fornecedor.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_Fornecedor,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE FORNECEDOR SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmCad_Fornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(cComboPessoa);
    FreeAndNil(FACBr_Validador);
    FreeAndNil(FMenu_Frame);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    cComboPessoa.DisposeOf;
    FACBr_Validador.DisposeOf;
    FMenu_Frame.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmCad_Fornecedor := Nil;

end;

procedure TfrmCad_Fornecedor.FormCreate(Sender: TObject);
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

  FFancyDialog := TFancyDialog.Create(frmCad_Fornecedor);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;
  tcCampos.ActiveTab := tiCampos_001;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;

end;

procedure TfrmCad_Fornecedor.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_Fornecedor.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      FTab_Status := dsInsert;
      LimparCampos;
      imgAcao_01.Tag := 1;
      imgAcao_01.Bitmap := imgSalvar.Bitmap;
      tcCampos.TabIndex := 0;
      tcPrincipal.GotoVisibleTab(1);
      if edNOME.CanFocus then
        edNOME.SetFocus;
    end;
    1:Salvar;
  end;

end;

procedure TfrmCad_Fornecedor.imgAvancar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmCad_Fornecedor.imgAvancar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(2);
end;

procedure TfrmCad_Fornecedor.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
  Listar_Registros(edFiltro.Text);

end;

procedure TfrmCad_Fornecedor.imgRetornar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(0);
end;

procedure TfrmCad_Fornecedor.imgRetornar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmCad_Fornecedor.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FNome);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;

end;


{$IFDEF MSWINDOWS}
procedure TfrmCad_Fornecedor.ItemClick_Pessoa(Sender: TObject);
begin
  cComboPessoa.HideMenu;
  edPessoa.Text := cComboPessoa.DescrItem;
  edPessoa.Tag := StrToIntDef(cComboPessoa.CodItem,0);
  case edPessoa.Tag of
    0:begin
      lbDOCUMENTO.Text := 'CPF';
      lbINSC_EST.Text := 'Identidade';
    end;
    1:begin
      lbDOCUMENTO.Text := 'CNPJ';
      lbINSC_EST.Text := 'Insc. Estadual';
    end;
  end;
end;
{$ELSE}
procedure TfrmCad_Fornecedor.ItemClick_Pessoa(Sender: TObject; const Point: TPointF);
begin
  cComboPessoa.HideMenu;
  edPessoa.Text := cComboPessoa.DescrItem;
  edPessoa.Tag := StrToIntDef(cComboPessoa.CodItem,0);
  case edPessoa.Tag of
    0:begin
      lbDOCUMENTO.Text := 'CPF';
      lbINSC_EST.Text := 'Identidade';
    end;
    1:begin
      lbDOCUMENTO.Text := 'CNPJ';
      lbINSC_EST.Text := 'Insc. Estadual';
    end;
  end;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TfrmCad_Fornecedor.ItemClick_UF(Sender: TObject);
begin
  cComboUF.HideMenu;
  edUF.Text := cComboUF.CodItem;
end;
{$ELSE}
procedure TfrmCad_Fornecedor.ItemClick_UF(Sender: TObject; const Point: TPointF);
begin
  cComboUF.HideMenu;
  edUF.Text := cComboUF.CodItem;
end;
{$ENDIF}

procedure TfrmCad_Fornecedor.lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FNome := Item.TagString;

end;

procedure TfrmCad_Fornecedor.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edPESSOA.Text := '';
  edPESSOA.Tag := 0;
  edNOME.Text := '';
  edDOCUMENTO.Text := '';
  edINSC_EST.Text := '';
  edCEP.Text := '';
  edENDERECO.Text := '';
  edNUMERO.Text := '';
  edCOMPLEMENTO.Text := '';
  edBAIRRO.Text := '';
  edCIDADE.Text := '';
  edUF.Text := '';
  edUF.TagString := '';
  edTELEFONE.Text := '';
  edCELULAR.Text := '';
  edEMAIL.Text := '';
end;

procedure TfrmCad_Fornecedor.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmCad_Fornecedor,'Listando Registros');
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
    FQuery.Sql.Add('SELECT  ');
    FQuery.Sql.Add('  E.*  ');
    FQuery.Sql.Add('FROM FORNECEDOR E ');
    FQuery.Sql.Add('WHERE NOT E.ID IS NULL ');
    if Trim(APesquisa) <> '' then
    begin
      FQuery.Sql.Add('  AND E.NOME LIKE :NOME');
      FQuery.ParamByName('NOME').AsString := '%' + APesquisa + '%';
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
            ,FQuery.FieldByName('NOME').AsString
            ,FQuery.FieldByName('DOCUMENTO').AsString
            ,FQuery.FieldByName('CELULAR').AsString
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

procedure TfrmCad_Fornecedor.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_Fornecedor,'Salvando alterações');

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
      FQuery.Sql.Add('INSERT INTO FORNECEDOR( ');
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
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
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
      FQuery.Sql.Add('  ,:SINCRONIZADO ');
      FQuery.Sql.Add('  ,:ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,:EXCLUIDO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
      FQuery.ParamByName('ID_PRINCIPAL').AsInteger := 0;
      FQuery.ParamByName('EXCLUIDO').AsInteger := 0;
    end
    else if FTab_Status = dsEdit then
    begin
      FQuery.Sql.Add('UPDATE FORNECEDOR SET ');
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
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('NOME').AsString := edNOME.Text;
    FQuery.ParamByName('PESSOA').AsInteger := edPESSOA.Tag;
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

    {$IFDEF MSWINDOWS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}

  end);

  t.OnTerminate := TTHreadEnd_Salvar;
  t.Start;
end;

procedure TfrmCad_Fornecedor.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_Fornecedor.TThreadEnd_Editar(Sender: TOBject);
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
  end;
end;

procedure TfrmCad_Fornecedor.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_Fornecedor.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);

end;

procedure TfrmCad_Fornecedor.TTHreadEnd_Salvar(Sender: TOBject);
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
