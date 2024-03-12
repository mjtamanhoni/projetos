unit uEmpresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,System.IOUtils,

  uFuncoes,
  uModel.Empresa,
  uDM_Global,
  IniFiles,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
    uFormat,
    uComboBox,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, FMX.TabControl, FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmEmpresa = class(TForm)
    lytDetail: TLayout;
    tcCadastro: TTabControl;
    tiGuia_1: TTabItem;
    rctGuia_1: TRectangle;
    lytNome: TLayout;
    edNome: TEdit;
    lbNome: TLabel;
    faNome: TFloatAnimation;
    imgVerSenha: TImage;
    lytStatus: TLayout;
    edStatus: TEdit;
    lbStatus: TLabel;
    faStatus: TFloatAnimation;
    tiGuia_2: TTabItem;
    rctGuia_2: TRectangle;
    lytCelular: TLayout;
    edCelular: TEdit;
    lbCelular: TLabel;
    faCelular: TFloatAnimation;
    lytEtapa1_Acoes: TLayout;
    lytAnterior: TLayout;
    imgAnterior: TImage;
    lytProximo: TLayout;
    imgProximo: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    imgAcao_1: TImage;
    imgAcao_2: TImage;
    StyleBook_Principal: TStyleBook;
    tcPrincipal: TTabControl;
    tiListagem: TTabItem;
    tiCadastro: TTabItem;
    lvRegistros: TListView;
    lytEmail: TLayout;
    edEmail: TEdit;
    lbEmail: TLabel;
    faEmail: TFloatAnimation;
    tiGuia_3: TTabItem;
    lytCep: TLayout;
    edCep: TEdit;
    lbCep: TLabel;
    faCep: TFloatAnimation;
    lytEndereco: TLayout;
    edEndereco: TEdit;
    lbEndereco: TLabel;
    faEndereco: TFloatAnimation;
    lytComplemento: TLayout;
    edComplemento: TEdit;
    lbComplemento: TLabel;
    faComplemento: TFloatAnimation;
    tiGuia_4: TTabItem;
    lytBairro: TLayout;
    edBairro: TEdit;
    lbBairro: TLabel;
    faBairro: TFloatAnimation;
    lytUF: TLayout;
    edUF: TEdit;
    lbUF: TLabel;
    faUF: TFloatAnimation;
    lytCidade: TLayout;
    edCidade: TEdit;
    lbCidade: TLabel;
    faCidade: TFloatAnimation;
    imgVoltar: TImage;
    imgCancelar: TImage;
    imgEdit: TImage;
    imgNovo: TImage;
    imgSalvar: TImage;
    imgUF: TImage;
    procedure imgAnteriorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure edStatusClick(Sender: TObject);
    procedure imgAcao_1Click(Sender: TObject);
    procedure imgAcao_2Click(Sender: TObject);
    procedure edUFClick(Sender: TObject);
    procedure edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCelularKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCepKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEnderecoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edComplementoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBairroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCidadeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNomeTyping(Sender: TObject);
    procedure edCelularTyping(Sender: TObject);
    procedure edEmailTyping(Sender: TObject);
    procedure edCepTyping(Sender: TObject);
    procedure edEnderecoTyping(Sender: TObject);
    procedure edComplementoTyping(Sender: TObject);
    procedure edBairroTyping(Sender: TObject);
    procedure edCidadeTyping(Sender: TObject);
  private
    FComboStatus :TCustomCombo;
    FComboUF :TCustomCombo;

    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;

    FTEMPRESA :TEMPRESA;

    procedure Novo_Empresa(Sender: TOBject);
    procedure Salvar_Empresa(Sender: TObject);
    procedure Cancelar_Empresa(Sender: TOBject);
    procedure Editar_Empresa(Sender: TOBject);

    procedure Combo_Status;
    procedure Combo_UF;

    {$IFDEF MSWINDOWS}
      procedure ItemStatusClick(Sender: TOBject);
    {$ELSE}
      procedure ItemStatusClick(Sender: TOBject; const Point: TPointF);
    {$ENDIF}

    {$IFDEF MSWINDOWS}
      procedure ItemUFClick(Sender: TOBject);
    procedure TThreadEnd_SalvarEmpresa(Sender: TOBject);
    {$ELSE}
      procedure ItemUFClick(Sender: TOBject; const Point: TPointF);
    procedure TThreadEnd_SalvarEmpresa(Sender: TOBject);
    {$ENDIF}

    {$Region 'Listando Empresas'}
      procedure Listar_Empresas(
        const ABusca:String;
        const APagina:Integer;
        const AInd_Clear:Boolean);

      procedure AddEmpresas_LV(
        const ACodigo:Integer;
        const ANome:String;
        const ASinc:Integer);

      procedure ThreadEnd_Empresas_LV(Sender: TOBject);
    {$EndRegion 'Listando Empresas'}


  public
    { Public declarations }
  end;

var
  frmEmpresa: TfrmEmpresa;

implementation

{$R *.fmx}

procedure TfrmEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FIniFile);
    FreeAndNil(FMensagem);
    FreeAndNil(FComboStatus);
    FreeAndNil(FComboUF);
    FreeAndNil(FTEMPRESA);
  {$ELSE}
    FIniFile.DisposeOf;
    FMensagem.DisposeOf;
    FComboStatus.DisposeOf;
    FComboUF.DisposeOf;
    FTEMPRESA.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmEmpresa := Nil;
end;

procedure TfrmEmpresa.FormCreate(Sender: TObject);
begin

  tcPrincipal.ActiveTab := tiListagem;
  tcCadastro.ActiveTab := tiGuia_1;

  FTEMPRESA := TEMPRESA.Create(DM.FDC_Conexao);

  FMensagem := TFancyDialog.Create(frmEmpresa);
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\GESTOR_HORA.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'GESTOR_HORA.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);
end;

procedure TfrmEmpresa.Cancelar_Empresa(Sender: TOBject);
begin
  imgAcao_1.Tag := 0;
  imgAcao_2.Tag := 0;
  imgVoltar.Visible := True;
  imgAcao_1.Bitmap := imgNovo.Bitmap;
  imgAcao_2.Bitmap := imgEdit.Bitmap;
  lbTitulo.Text := 'Empresas';
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmEmpresa.Combo_Status;
begin
  FComboStatus := TCustomCombo.Create(frmEmpresa);

  FComboStatus.TitleMenuText := 'Escolha o Status';
  FComboStatus.TitleFontSize := 20;
  FComboStatus.TitleFontColor := TColorRec.Red;

  FComboStatus.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
  FComboStatus.SubTitleFontSize := 15;
  FComboStatus.SubTitleFontColor := TColorRec.Red;

  FComboStatus.BackgroundColor := $FFF2F2F8;

  FComboStatus.OnClick := ItemStatusClick;

  FComboStatus.AddItem('1', 'ATIVO');
  FComboStatus.AddItem('0', 'INATIVO');

  FComboStatus.ShowMenu;

end;

procedure TfrmEmpresa.Combo_UF;
begin
  FComboUF := TCustomCombo.Create(frmEmpresa);

  FComboUF.TitleMenuText := 'Escolha a UF';
  FComboUF.TitleFontSize := 20;
  FComboUF.TitleFontColor := TColorRec.Red;

  FComboUF.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
  FComboUF.SubTitleFontSize := 15;
  FComboUF.SubTitleFontColor := TColorRec.Red;

  FComboUF.BackgroundColor := $FFF2F2F8;

  FComboUF.OnClick := ItemUFClick;

  FComboUF.AddItem('AC', 'ACRE');
  FComboUF.AddItem('AL', 'ALAGOAS');
  FComboUF.AddItem('AP', 'AMAPÁ');
  FComboUF.AddItem('AM', 'AMAZONAS');
  FComboUF.AddItem('BA', 'BAHIA');
  FComboUF.AddItem('CE', 'CEARÁ');
  FComboUF.AddItem('DF', 'DISTRITO FEDERAL');
  FComboUF.AddItem('ES', 'ESPÍRITO SANTO');
  FComboUF.AddItem('GO', 'GOIÁS');
  FComboUF.AddItem('MA', 'MARANHÃO');
  FComboUF.AddItem('MT', 'MATO GROSSO');
  FComboUF.AddItem('MS', 'MATO GROSSO DO SUL');
  FComboUF.AddItem('MG', 'MINAS GERAIS');
  FComboUF.AddItem('PA', 'PARÁ');
  FComboUF.AddItem('PB', 'PARAÍBA');
  FComboUF.AddItem('PR', 'PARANÁ');
  FComboUF.AddItem('PE', 'PERNAMBUCO');
  FComboUF.AddItem('PI', 'PIAUÍ');
  FComboUF.AddItem('RJ', 'RIO DE JANEIRO');
  FComboUF.AddItem('RN', 'RIO GRANDE DO NORTE');
  FComboUF.AddItem('RS', 'RIO GRANDE DO SUL');
  FComboUF.AddItem('RO', 'RONDÔNIA');
  FComboUF.AddItem('RR', 'RORAIMA');
  FComboUF.AddItem('SC', 'SANTA CATARINA');
  FComboUF.AddItem('SP', 'SÃO PAULO');
  FComboUF.AddItem('SE', 'SERGIPE');
  FComboUF.AddItem('TO', 'TOCANTINS');

  FComboUF.ShowMenu;
end;

procedure TfrmEmpresa.edBairroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edCidade);
end;

procedure TfrmEmpresa.edBairroTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edBairro,lbBairro,faBairro,10,-20);
end;

procedure TfrmEmpresa.edCelularKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edEmail);

end;

procedure TfrmEmpresa.edCelularTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCelular,lbCelular,faCelular,10,-20);
  Formatar(edCelular,TFormato.Celular);
end;

procedure TfrmEmpresa.edCepKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edEndereco);
end;

procedure TfrmEmpresa.edCepTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCep,lbCep,faCep,10,-20);
  Formatar(edCep,TFormato.CEP);
end;

procedure TfrmEmpresa.edCidadeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edUF);
end;

procedure TfrmEmpresa.edCidadeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edCidade,lbCidade,faCidade,10,-20);
end;

procedure TfrmEmpresa.edComplementoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcCadastro.GotoVisibleTab(tcCadastro.TabIndex + 1);
    TFuncoes.PularCampo(edBairro);
  end;
end;

procedure TfrmEmpresa.edComplementoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edComplemento,lbComplemento,faComplemento,10,-20);
end;

procedure TfrmEmpresa.edEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    tcCadastro.GotoVisibleTab(tcCadastro.TabIndex + 1);
    TFuncoes.PularCampo(edEmail);
  end;
end;

procedure TfrmEmpresa.edEmailTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail,lbEmail,faEmail,10,-20);
end;

procedure TfrmEmpresa.edEnderecoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edComplemento);
end;

procedure TfrmEmpresa.edEnderecoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEndereco,lbEndereco,faEndereco,10,-20);
end;

procedure TfrmEmpresa.Editar_Empresa(Sender: TOBject);
begin
  imgAcao_1.Tag := 1;
  imgAcao_2.Tag := 1;
  imgVoltar.Visible := False;;
  imgAcao_1.Bitmap := imgSalvar.Bitmap;
  imgAcao_2.Bitmap := imgCancelar.Bitmap;
  lbTitulo.Text := 'Cadastro';
  tcPrincipal.GotoVisibleTab(1);
end;

procedure TfrmEmpresa.edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edStatus);
end;

procedure TfrmEmpresa.edNomeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNome,lbNome,faNome,10,-20);
end;

procedure TfrmEmpresa.edStatusClick(Sender: TObject);
begin
  Combo_Status;
end;

procedure TfrmEmpresa.edUFClick(Sender: TObject);
begin
  Combo_UF;
end;

procedure TfrmEmpresa.imgAcao_1Click(Sender: TObject);
begin
  case imgAcao_1.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja inserir uma nova Empresa?','Sim',Novo_Empresa,'Não');
    1:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja salvar as alterações?','Sim',Salvar_Empresa,'Não');
  end;
end;

procedure TfrmEmpresa.imgAcao_2Click(Sender: TObject);
begin
  case imgAcao_2.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja editar o Apontamento selecionado?','Sim',Editar_Empresa,'Não');
    1:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações?','Sim',Cancelar_Empresa,'Não');
  end;
end;

procedure TfrmEmpresa.imgAnteriorClick(Sender: TObject);
begin
  tcCadastro.GotoVisibleTab(tcCadastro.TabIndex + TImage(Sender).Tag);
end;

procedure TfrmEmpresa.imgVoltarClick(Sender: TObject);
begin
  Close;
end;

{$IFDEF MSWINDOWS}
procedure TfrmEmpresa.ItemStatusClick(Sender :TOBject);
begin
  FComboStatus.HideMenu;
  edStatus.TagString := FComboStatus.CodItem;
  edStatus.Text := FComboStatus.DescrItem;
  tcCadastro.GotoVisibleTab(tcCadastro.TabIndex + 1);
  TFuncoes.PularCampo(edStatus);
  TFuncoes.ExibeLabel(edStatus,lbStatus,faStatus,10,-20);
end;
{$ELSE}
procedure TfrmEmpresa.ItemStatusClick(Sender :TOBject; const Point:TPointF);
begin
  FComboStatus.HideMenu;
  edStatus.TagString := FComboStatus.CodItem;
  edStatus.Text := FComboStatus.DescrItem;
  tcCadastro.GotoVisibleTab(tcCadastro.TabIndex + 1);
  TFuncoes.PularCampo(edStatus);
  TFuncoes.ExibeLabel(edStatus,lbStatus,faStatus,10,-20);
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TfrmEmpresa.ItemUFClick(Sender :TOBject);
begin
  FComboUF.HideMenu;
  edUF.TagString := FComboUF.CodItem;
  edUF.Text := FComboUF.DescrItem;
  TFuncoes.ExibeLabel(edUF,lbUF,faUF,10,-20);
end;
{$ELSE}
procedure TfrmEmpresa.ItemUFClick(Sender :TOBject; const Point:TPointF);
begin
  FComboUF.HideMenu;
  edUF.TagString := FComboUF.CodItem;
  edUF.Text := FComboUF.DescrItem;
  TFuncoes.ExibeLabel(edUF,lbUF,faUF,10,-20);
end;
{$ENDIF}

procedure TfrmEmpresa.Listar_Empresas(const ABusca: String; const APagina: Integer; const AInd_Clear: Boolean);
begin

end;

procedure TfrmEmpresa.AddEmpresas_LV(const ACodigo: Integer; const ANome: String; const ASinc: Integer);
begin

end;

procedure TfrmEmpresa.ThreadEnd_Empresas_LV(Sender: TOBject);
begin

end;

procedure TfrmEmpresa.Novo_Empresa(Sender: TOBject);
begin
  imgAcao_1.Tag := 1;
  imgAcao_2.Tag := 1;
  imgVoltar.Visible := False;
  imgAcao_1.Bitmap := imgSalvar.Bitmap;
  imgAcao_2.Bitmap := imgCancelar.Bitmap;
  lbTitulo.Text := 'Cadastro';
  tcPrincipal.GotoVisibleTab(1);
end;

procedure TfrmEmpresa.Salvar_Empresa(Sender: TObject);
var
  t :TThread;

begin
  TLoading.Show(frmEmpresa,'Salvando modificações');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FDQ_Query :TFDQuery;
    lCodigo :Integer;
  begin
    FTEMPRESA.ID := 0;
    FTEMPRESA.NOME := edNome.Text;
    FTEMPRESA.STATUS := edStatus.TagString.ToInteger;
    FTEMPRESA.CELULAR := edCelular.Text;
    FTEMPRESA.EMAIL := edEmail.Text;
    FTEMPRESA.CEP := edCep.Text;
    FTEMPRESA.ENDERECO := edEndereco.Text;
    FTEMPRESA.COMPLEMENTO := edComplemento.Text;
    FTEMPRESA.BAIRRO := edBairro.Text;
    FTEMPRESA.CIDADE := edCidade.Text;
    FTEMPRESA.UF := edUF.Text;
    FTEMPRESA.SINCRONIZADO := 0;
    FTEMPRESA.DT_CADASTRO := Date;
    FTEMPRESA.HR_CADASTRO := Time;

    FDQ_Query := TFDQuery.Create(Nil);
    try
      lCodigo := 0;
      FDQ_Query.Connection := DM.FDC_Conexao;
      lCodigo := FTEMPRESA.Inserir(FDQ_Query);
    finally
      {$IFDEF MSWINDOWS}
        FreeAndNil(FDQ_Query);
      {$ELSE}
        FDQ_Query.DisposeOf;
      {$ENDIF}
    end;
  end);

  t.OnTerminate := TThreadEnd_SalvarEmpresa;
  t.Start;

end;

procedure TfrmEmpresa.TThreadEnd_SalvarEmpresa(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    imgAcao_1.Tag := 0;
    imgAcao_2.Tag := 0;
    imgVoltar.Visible := True;
    imgAcao_1.Bitmap := imgNovo.Bitmap;
    imgAcao_2.Bitmap := imgEdit.Bitmap;
    lbTitulo.Text := 'Empresas';
    tcPrincipal.GotoVisibleTab(0);
  end;
end;

end.
