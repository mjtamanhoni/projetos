unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, D2Bridge.Forms; //Declare D2Bridge.Forms always in the last unit

type
  TfrmPrincipal = class(TD2BridgeForm)
    MainMenu1: TMainMenu;
    mnuCadastro: TMenuItem;
    mnuGerais: TMenuItem;
    mnuProjeto: TMenuItem;
    mnuProjetos: TMenuItem;
    mnuForms: TMenuItem;
    mnuUsusario: TMenuItem;
    mnuEmpresa: TMenuItem;
    mnuGeografico: TMenuItem;
    mnuRegiao: TMenuItem;
    mnuEstados: TMenuItem;
    mnuCidades: TMenuItem;
    mnuPagamento: TMenuItem;
    mnuPag_Condicao: TMenuItem;
    mnuPag_Formas: TMenuItem;
    mnuUnidadeMedida: TMenuItem;
    mnuPlanoContasGer: TMenuItem;
    UnidadesdeMedidas2: TMenuItem;
    Pessoa1: TMenuItem;
    N1: TMenuItem;
    Funcionrios1: TMenuItem;
    Fornecedores1: TMenuItem;
    Clientes1: TMenuItem;
    Fabricante1: TMenuItem;
    Pessoas1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    Famlia1: TMenuItem;
    Localizao1: TMenuItem;
    Segmento1: TMenuItem;
    Grupo1: TMenuItem;
    Grupo2: TMenuItem;
    SubGrupo1: TMenuItem;
    abeladePreo1: TMenuItem;
    Fiscal1: TMenuItem;
    CFOP1: TMenuItem;
    abeladePreo2: TMenuItem;
    Financeiro1: TMenuItem;
    Banco1: TMenuItem;
    ContasBancrias1: TMenuItem;
    mnuMovimento: TMenuItem;
    Financeiro2: TMenuItem;
    ContaPagar1: TMenuItem;
    ContasaReceber1: TMenuItem;
    mnuDashboard: TMenuItem;
    mnuRelatorios: TMenuItem;
    mnuArquivos: TMenuItem;
    Configuraes1: TMenuItem;
    mnuConfig: TMenuItem;
    mnuDesconectar: TMenuItem;
    mnuTipoForm: TMenuItem;
    procedure mnuCadastroClick(Sender: TObject);
    procedure mnuProjetosClick(Sender: TObject);
    procedure mnuTipoFormClick(Sender: TObject);
    procedure mnuFormsClick(Sender: TObject);
    procedure mnuUsusarioClick(Sender: TObject);
    procedure mnuRegiaoClick(Sender: TObject);
    procedure mnuEstadosClick(Sender: TObject);
    procedure mnuDesconectarClick(Sender: TObject);
    procedure mnuCidadesClick(Sender: TObject);
    procedure mnuEmpresaClick(Sender: TObject);
  private

  public

  protected
   procedure ExportD2Bridge; override;
   procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
   procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

Function frmPrincipal: TfrmPrincipal;

implementation

Uses
   Gestao_FinanceiraWebApp,
   uProjetos, uTIpoFormulario, uForm_Projeto, uUsuarios, uRegioes, uUnidadeFederativa, uMunicipios, uEmpresa;

Function frmPrincipal: TfrmPrincipal;
begin
 Result:= TfrmPrincipal(TfrmPrincipal.GetInstance);
end;

{$R *.dfm}

{ TForm1 }

procedure TfrmPrincipal.ExportD2Bridge;
begin
 inherited;

 Title:= 'Gerenciamento da Saúde Financeira de suas Empresas';
 //SubTitle:= 'Menu Principal';

 //TemplateClassForm:= TD2BridgeFormTemplate;
 //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
 //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

 //Export yours Controls
 with D2Bridge.Items.add do
 begin
  SideMenu(MainMenu1);
  //VCLObj(Label1);
  //VCLObj(Label2);
  //VCLObj(Label3);
 end;
end;

procedure TfrmPrincipal.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = MainMenu1 then
  begin
    with PrismControl.AsSideMenu do
    begin
      PrismControl.AsSideMenu.Color := clBlue;
      {$Region 'Principal'}
      PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuCadastro).Icon := 'fa-solid fa-address-card';
      PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuMovimento).Icon := 'fa-solid fa-money-bill-transfer';
      PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuDashboard).Icon := 'fa-solid fa-chart-line';
      PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuRelatorios).Icon := 'fa-solid fa-print';
      PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuArquivos).Icon := 'fa-solid fa-file';
      PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuConfig).Icon := 'fa-solid fa-gear';
      PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuDesconectar).Icon := 'fa-solid fa-arrow-right-from-bracket';
      {$EndRegion 'Principal'}

      {$Region 'Cadastro de Projetos'}
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuGerais).Icon := 'fa-solid fa-bars-progress';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuProjeto).Icon := 'fa-solid fa-list-check';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuProjetos).Icon := 'fa-solid fa-diagram-project';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuTipoForm).Icon := 'fa-solid fa-border-all';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuForms).Icon := 'fa-solid fa-table-columns';
      {$EndRegion 'Cadastro de Projetos'}

      {$Region 'Cadastro Geográficos'}
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuGeografico).Icon := 'fa-solid fa-earth-africa';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuRegiao).Icon := 'fa-solid fa-map-location';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuEstados).Icon := 'fa-solid fa-location-dot';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuCidades).Icon := 'fa-solid fa-building-user';
      {$EndRegion 'Cadastro Geográficos'}

      {$Region 'Usuarios'}
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuUsusario).Icon := 'fa-solid fa-users';
      {$EndRegion 'Usuarios'}

      {$Region 'Empresa'}
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuEmpresa).Icon := 'fa-solid fa-building';
      {$EndRegion 'Empresa'}

      {$Region 'Pagamentos'}
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuPagamento).Icon := 'fa-solid fa-cash-register';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuPag_Condicao).Icon := 'fa-solid fa-money-bills';
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuPag_Formas).Icon := 'fa-solid fa-money-bill';
      {$EndRegion 'Pagamentos'}

      {$Region 'Unidade de Medida'}
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuUnidadeMedida).Icon := 'fa-solid fa-weight-scale';
      {$EndRegion 'Unidade de Medida'}

      {$Region 'Plano de contas gerencial'}
        PrismControl.AsSideMenu.MenuItemFromVCLComponent(mnuPlanoContasGer).Icon := 'fa-solid fa-receipt';
      {$EndRegion 'Plano de contas gerencial'}
    end;
  end;

 //Menu example
 {
  if PrismControl.VCLComponent = MainMenu1 then
   PrismControl.AsMainMenu.Title:= 'AppTeste'; //or in SideMenu use asSideMenu

  if PrismControl.VCLComponent = MainMenu1 then
   PrismControl.AsMainMenu.Image.URL:= 'https://d2bridge.com.br/images/LogoD2BridgeTransp.png'; //or in SideMenu use asSideMenu

  //GroupIndex example
  if PrismControl.VCLComponent = MainMenu1 then
   with PrismControl.AsMainMenu do  //or in SideMenu use asSideMenu
   begin
    MenuGroups[0].Caption:= 'Principal';
    MenuGroups[1].Caption:= 'Services';
    MenuGroups[2].Caption:= 'Items';
   end;

  //Chance Icon and Propertys MODE 1 *Using MenuItem component
  PrismControl.AsMainMenu.MenuItemFromVCLComponent(Abrout1).Icon:= 'fa-solid fa-rocket';

  //Chance Icon and Propertys MODE 2 *Using MenuItem name
  PrismControl.AsMainMenu.MenuItemFromName('Abrout1').Icon:= 'fa-solid fa-rocket';
 }

 //Change Init Property of Prism Controls
 {
  if PrismControl.VCLComponent = Edit1 then
   PrismControl.AsEdit.DataType:= TPrismFieldType.PrismFieldTypeInteger;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage:= 10;
   PrismControl.AsDBGrid.MaxRecords:= 2000;
  end;
 }
end;

procedure TfrmPrincipal.mnuTipoFormClick(Sender: TObject);
begin
  if frmTipoFormulario = Nil then
    TfrmTipoFormulario.CreateInstance;
  frmTipoFormulario.Show;

end;

procedure TfrmPrincipal.mnuCadastroClick(Sender: TObject);
begin
 TD2BridgeForm(Session.PrimaryForm).Show;
end;

procedure TfrmPrincipal.mnuCidadesClick(Sender: TObject);
begin
  if frmMunicipios = Nil then
    TfrmMunicipios.CreateInstance;
  frmMunicipios.Show;
end;

procedure TfrmPrincipal.mnuDesconectarClick(Sender: TObject);
begin
  if IsD2BridgeContext then
    Session.Close(True)
  else
    Application.Terminate;
end;

procedure TfrmPrincipal.mnuProjetosClick(Sender: TObject);
begin
  if frmProjetos = Nil then
    TfrmProjetos.CreateInstance;
  frmProjetos.Show;
end;

procedure TfrmPrincipal.mnuFormsClick(Sender: TObject);
begin
  if frmForm_Projeto = Nil then
    TfrmForm_Projeto.CreateInstance;
  frmForm_Projeto.Show;
end;

procedure TfrmPrincipal.mnuRegiaoClick(Sender: TObject);
begin
  if frmRegioes = Nil then
    TfrmRegioes.CreateInstance;
  frmRegioes.Show;

end;

procedure TfrmPrincipal.mnuEmpresaClick(Sender: TObject);
begin
  if frmEmpresa = Nil then
    TfrmEmpresa.CreateInstance;
  frmEmpresa.Show;
end;

procedure TfrmPrincipal.mnuEstadosClick(Sender: TObject);
begin
  if frmUnidadeFederativa = Nil then
    TfrmUnidadeFederativa.CreateInstance;
  frmUnidadeFederativa.Show;

end;

procedure TfrmPrincipal.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
begin
 inherited;

 //Intercept HTML
 {
  if PrismControl.VCLComponent = Edit1 then
  begin
   HTMLControl:= '</>';
  end;
 }
end;

procedure TfrmPrincipal.mnuUsusarioClick(Sender: TObject);
begin
  if frmUsuarios = Nil then
    TfrmUsuarios.CreateInstance;
  frmUsuarios.Show;

end;

end.
