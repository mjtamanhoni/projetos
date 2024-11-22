unit uCad.Empresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uCombobox,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  FMX.ListView, FMX.TabControl, FMX.Layouts;

type
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_Empresa = class(TForm)
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
    lvLista: TListView;
    lytFiltro: TLayout;
    edFiltro: TEdit;
    imgFiltrar: TImage;
    imgLimpar: TImage;
    tiCampos: TTabItem;
    lytCampos: TLayout;
    lytRow_001: TLayout;
    lytID: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytPESSOA: TLayout;
    lbPESSOA: TLabel;
    edPESSOA: TEdit;
    lytRow_002: TLayout;
    lytNOME: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytRow_003: TLayout;
    lytDOCUMENTO: TLayout;
    lbDOCUMENTO: TLabel;
    edDOCUMENTO: TEdit;
    lytRow_004: TLayout;
    lytCEP: TLayout;
    lbCEP: TLabel;
    edCEP: TEdit;
    imgCEP: TImage;
    lytRow_005: TLayout;
    lytENDERECO: TLayout;
    lbENDERECO: TLabel;
    edENDERECO: TEdit;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    lytINSC_EST: TLayout;
    lbINSC_EST: TLabel;
    edINSC_EST: TEdit;
    tcCampos: TTabControl;
    tiCampos_001: TTabItem;
    tiCampos_002: TTabItem;
    lytCampos_001: TLayout;
    lytCampos_002: TLayout;
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
    tiCampos_003: TTabItem;
    lytCampos_003: TLayout;
    lytRow_Navegar_01: TLayout;
    imgAvancar_001: TImage;
    lytRow_Navegar_02: TLayout;
    imgAvancar_002: TImage;
    imgRetornar_001: TImage;
    lytRow_Navegar_03: TLayout;
    imgRetornar_002: TImage;
    imgPESSOA: TImage;
    Image1: TImage;
    procedure imgVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgAvancar_001Click(Sender: TObject);
    procedure imgRetornar_001Click(Sender: TObject);
    procedure imgAvancar_002Click(Sender: TObject);
    procedure imgRetornar_002Click(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure edTELEFONETyping(Sender: TObject);
    procedure edCELULARTyping(Sender: TObject);
    procedure edCEPTyping(Sender: TObject);
    procedure edDOCUMENTOTyping(Sender: TObject);
    procedure edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDOCUMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edINSC_ESTKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edENDERECOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCOMPLEMENTOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCIDADEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edTELEFONEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edPESSOAClick(Sender: TObject);
    procedure edUFClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    cComboPessoa :TCustomCombo;
    cComboUF :TCustomCombo;

    procedure Configura_Botoes;
    procedure Selecionar_Registros;
    procedure LimparCampos;
    procedure Salvar;
    procedure Cancelar(Sender: TOBject);
    procedure CriandoCombos;

    {$IFDEF MSWINDOWS}
      procedure ItemClick_Pessoa(Sender: TObject);
      procedure ItemClick_UF(Sender: TObject);
    {$ELSE}
      procedure ItemClick_UF(Sender: TObject; const Point: TPointF);
      procedure ItemClick_Pessoa(Sender: TObject; const Point: TPointF);
    {$ENDIF}


  public
    { Public declarations }
  end;

var
  frmCad_Empresa: TfrmCad_Empresa;

implementation

{$R *.fmx}


procedure TfrmCad_Empresa.edBAIRROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCIDADE.SetFocus;

end;

procedure TfrmCad_Empresa.edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;

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
  case edPESSOA.Tag of
    0:Formatar(edDOCUMENTO,CPF);
    1:Formatar(edDOCUMENTO,CNPJ);
  end;
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
  begin
    tcCampos.GotoVisibleTab(1);
    edCEP.SetFocus;
  end;
end;

procedure TfrmCad_Empresa.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDOCUMENTO.SetFocus;

end;

procedure TfrmCad_Empresa.edNUMEROKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCOMPLEMENTO.SetFocus;

end;

procedure TfrmCad_Empresa.edPESSOAClick(Sender: TObject);
begin
  cComboPessoa.ShowMenu;
end;

procedure TfrmCad_Empresa.edPESSOAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edNOME.SetFocus;
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

procedure TfrmCad_Empresa.edUFClick(Sender: TObject);
begin
  cComboUF.ShowMenu;
end;

procedure TfrmCad_Empresa.edUFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcCampos.GotoVisibleTab(2);
    edTELEFONE.SetFocus;
  end;

end;

procedure TfrmCad_Empresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(cComboPessoa);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    cComboPessoa.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmCad_Empresa := Nil;
end;

procedure TfrmCad_Empresa.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_Empresa);
  CriandoCombos;

  tcPrincipal.ActiveTab := tiLista;
  tcCampos.ActiveTab := tiCampos_001;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Selecionar_Registros;
  Configura_Botoes;
end;

procedure TfrmCad_Empresa.CriandoCombos;
begin

  cComboUF := TCustomCombo.Create(frmCad_Empresa);
  cComboPessoa := TCustomCombo.Create(frmCad_Empresa);

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

procedure TfrmCad_Empresa.Selecionar_Registros;
begin

end;

procedure TfrmCad_Empresa.Configura_Botoes;
begin

end;

procedure TfrmCad_Empresa.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      FTab_Status := dsInsert;
      LimparCampos;
      imgAcao_01.Tag := 1;
      imgAcao_01.Bitmap := imgSalvar.Bitmap;
      tcPrincipal.GotoVisibleTab(1);
      if edNOME.CanFocus then
        edNOME.SetFocus;
    end;
    1:Salvar;
  end;
end;

procedure TfrmCad_Empresa.Salvar;
begin

end;

procedure TfrmCad_Empresa.LimparCampos;
begin

end;

procedure TfrmCad_Empresa.imgAvancar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmCad_Empresa.imgAvancar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(2);
end;

procedure TfrmCad_Empresa.imgRetornar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(0);
end;

procedure TfrmCad_Empresa.imgRetornar_002Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmCad_Empresa.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:Close;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

{$IFDEF MSWINDOWS}
procedure TfrmCad_Empresa.ItemClick_Pessoa(Sender: TObject);
begin
  cComboPessoa.HideMenu;
  edPessoa.Text := cComboPessoa.DescrItem;
  edPessoa.Tag := StrToIntDef(cComboPessoa.CodItem,0);
end;
{$ELSE}
procedure TfrmCad_Empresa.ItemClick_Pessoa(Sender: TObject; const Point: TPointF);
begin
  cComboPessoa.HideMenu;
  edPessoa.Text := cComboPessoa.DescrItem;
  edPessoa.Tag := StrToIntDef(cComboPessoa.CodItem,0);
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TfrmCad_Empresa.ItemClick_UF(Sender: TObject);
begin
  cComboUF.HideMenu;
  edUF.Text := cComboUF.CodItem;
end;
{$ELSE}
procedure TfrmCad_Empresa.ItemClick_UF(Sender: TObject; const Point: TPointF);
begin
  cComboUF.HideMenu;
  edUF.Text := cComboUF.CodItem;
end;
{$ENDIF}

procedure TfrmCad_Empresa.Cancelar(Sender :TOBject);
begin
  tcPrincipal.GotoVisibleTab(0);
end;

end.
