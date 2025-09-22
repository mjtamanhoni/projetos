unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, D2Bridge.Forms; //Declare D2Bridge.Forms always in the last unit

type
  TfrmPrincipal = class(TD2BridgeForm)
    MainMenu1: TMainMenu;
    Module11: TMenuItem;
    Gerais1: TMenuItem;
    Projeto: TMenuItem;
    Projeto1: TMenuItem;
    Projeto2: TMenuItem;
    Usurios1: TMenuItem;
    Empresa1: TMenuItem;
    CadastrosGeogrficos1: TMenuItem;
    Regies1: TMenuItem;
    Regies2: TMenuItem;
    MunicpiosCidades1: TMenuItem;
    Pagamengos1: TMenuItem;
    CondiesdePagamentos1: TMenuItem;
    FormasdePagamentos1: TMenuItem;
    UnidadesdeMedidas1: TMenuItem;
    PlanodeContasGerencial1: TMenuItem;
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
    Movimentos1: TMenuItem;
    Financeiro2: TMenuItem;
    ContaPagar1: TMenuItem;
    ContasaReceber1: TMenuItem;
    Dashboard1: TMenuItem;
    Relatrios1: TMenuItem;
    Arquivos1: TMenuItem;
    Configuraes1: TMenuItem;
    Configuraes2: TMenuItem;
    Fechar1: TMenuItem;
    ipodeFormulrios1: TMenuItem;
    procedure Module11Click(Sender: TObject);
    procedure Projeto1Click(Sender: TObject);
    procedure ipodeFormulrios1Click(Sender: TObject);
    procedure Projeto2Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
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
   uProjetos, uTIpoFormulario, uForm_Projeto, uUsuarios;

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

procedure TfrmPrincipal.ipodeFormulrios1Click(Sender: TObject);
begin
  if frmTipoFormulario = Nil then
    TfrmTipoFormulario.CreateInstance;
  frmTipoFormulario.Show;

end;

procedure TfrmPrincipal.Module11Click(Sender: TObject);
begin
 TD2BridgeForm(Session.PrimaryForm).Show;
end;

procedure TfrmPrincipal.Projeto1Click(Sender: TObject);
begin
  if frmProjetos = Nil then
    TfrmProjetos.CreateInstance;
  frmProjetos.Show;
end;

procedure TfrmPrincipal.Projeto2Click(Sender: TObject);
begin
  if frmForm_Projeto = Nil then
    TfrmForm_Projeto.CreateInstance;
  frmForm_Projeto.Show;

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

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  if frmUsuarios = Nil then
    TfrmUsuarios.CreateInstance;
  frmUsuarios.Show;

end;

end.
