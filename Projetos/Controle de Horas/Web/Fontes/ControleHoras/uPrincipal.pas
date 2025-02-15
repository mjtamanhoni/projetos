unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, D2Bridge.Forms; //Declare D2Bridge.Forms always in the last unit

type
  TfrmPrincipal = class(TD2BridgeForm)
    MainMenu1: TMainMenu;
    menuCadastro: TMenuItem;
    menuMovimento: TMenuItem;
    Fechar1: TMenuItem;
    menuCad_Config: TMenuItem;
    Configuraes2: TMenuItem;
    Usurios1: TMenuItem;
    Empresas1: TMenuItem;
    Pessoas1: TMenuItem;
    PrestadordeServio1: TMenuItem;
    Cliente1: TMenuItem;
    Fornecedor1: TMenuItem;
    abeladePreo1: TMenuItem;
    Contas1: TMenuItem;
    Pagamento1: TMenuItem;
    Forma1: TMenuItem;
    Condio1: TMenuItem;
    ServiosPrestados1: TMenuItem;
    LanamentosFinanceiros1: TMenuItem;
    menuConsultas: TMenuItem;
    ServiosPrestados2: TMenuItem;
    procedure menuCadastroClick(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure menuCad_ConfigClick(Sender: TObject);
    procedure Empresas1Click(Sender: TObject);
    procedure PrestadordeServio1Click(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
    procedure Fornecedor1Click(Sender: TObject);
    procedure abeladePreo1Click(Sender: TObject);
    procedure Contas1Click(Sender: TObject);
    procedure Condio1Click(Sender: TObject);
    procedure Forma1Click(Sender: TObject);
    procedure ServiosPrestados2Click(Sender: TObject);
    procedure ServiosPrestados1Click(Sender: TObject);
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
   ControleHorasWebApp
   ,uCad.Usuarios
   ,uConfiguracoes
   ,uCad.Empresa
   ,uCad.PrestServico
   ,uCad.Cliente
   ,uCad.Fornecedor
   ,uCad.TabPreco
   ,uCad.Conta
   ,uCad.CondPagto
   ,uCad.FormaPagto
   ,uCon.ServisoPrestados
   ,uMov.ServicosPrestados;

Function frmPrincipal: TfrmPrincipal;
begin
 Result:= TfrmPrincipal(TfrmPrincipal.GetInstance);
end;

{$R *.dfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.Fechar1Click(Sender: TObject);
begin
  if frmCad_Usuarios <> Nil then
    frmCad_Usuarios.Close
  else if frmConfiguracoes <> Nil then
    frmConfiguracoes.Close
  else if frmCad_Empresa <> Nil then
    frmCad_Empresa.Close
  else if frmCad_PrestServico <> Nil then
    frmCad_PrestServico.Close
  else if frmCad_Cliente <> Nil then
    frmCad_Cliente.Close
  else if frmCad_Fornecedor <> Nil then
    frmCad_Fornecedor.Close
  else if frmCad_TabPreco <> Nil then
    frmCad_TabPreco.Close
  else if frmCad_Conta <> Nil then
    frmCad_Conta.Close
  else if frmCad_CondPagto <> Nil then
    frmCad_CondPagto.Close
  else if frmCad_FormaPagto <> Nil then
    frmCad_FormaPagto.Close
  else if frmCon_ServicosPrestados <> Nil then
    frmCon_ServicosPrestados.Close
  else if frmMov_ServicosPrestados <> Nil then
    frmMov_ServicosPrestados.Close
  else
    Close;
end;

procedure TfrmPrincipal.Forma1Click(Sender: TObject);
begin
  if frmCad_FormaPagto = Nil then
    TfrmCad_FormaPagto.CreateInstance;
  frmCad_FormaPagto.ShowModal;
end;

procedure TfrmPrincipal.Fornecedor1Click(Sender: TObject);
begin
  if frmCad_Fornecedor = Nil then
    TfrmCad_Fornecedor.CreateInstance;
  frmCad_Fornecedor.ShowModal;
end;

procedure TfrmPrincipal.abeladePreo1Click(Sender: TObject);
begin
  if frmCad_TabPreco = Nil then
    TfrmCad_TabPreco.CreateInstance;
  frmCad_TabPreco.ShowModal;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  if frmCad_Cliente = Nil then
    TfrmCad_Cliente.CreateInstance;
  frmCad_Cliente.ShowModal;
end;

procedure TfrmPrincipal.Condio1Click(Sender: TObject);
begin
  if frmCad_CondPagto = Nil then
    TfrmCad_CondPagto.CreateInstance;
  frmCad_CondPagto.ShowModal;
end;

procedure TfrmPrincipal.menuCad_ConfigClick(Sender: TObject);
begin
  if frmConfiguracoes = Nil then
    TfrmConfiguracoes.CreateInstance;
  frmConfiguracoes.ShowModal;
end;

procedure TfrmPrincipal.Contas1Click(Sender: TObject);
begin
  if frmCad_Conta = Nil then
    TfrmCad_Conta.CreateInstance;
  frmCad_Conta.ShowModal;
end;

procedure TfrmPrincipal.Empresas1Click(Sender: TObject);
begin
  if frmCad_Empresa = Nil then
    TfrmCad_Empresa.CreateInstance;
  frmCad_Empresa.ShowModal;
end;

procedure TfrmPrincipal.ExportD2Bridge;
begin
 inherited;

 Title:= 'Controle de Horas';
 SubTitle:= '';

 //TemplateClassForm:= TD2BridgeFormTemplate;
 D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
 D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

 //Export yours Controls
 with D2Bridge.Items.add do
 begin
  SideMenu(MainMenu1);
  {
  VCLObj(Label1);
  VCLObj(Label2);
  VCLObj(Label3);
  }
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

procedure TfrmPrincipal.menuCadastroClick(Sender: TObject);
begin
 frmPrincipal.Show;
end;

procedure TfrmPrincipal.PrestadordeServio1Click(Sender: TObject);
begin
  if frmCad_PrestServico = Nil then
    TfrmCad_PrestServico.CreateInstance;
  frmCad_PrestServico.ShowModal;
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

procedure TfrmPrincipal.ServiosPrestados1Click(Sender: TObject);
begin
  if frmMov_ServicosPrestados = Nil then
    TfrmMov_ServicosPrestados.CreateInstance;
  frmMov_ServicosPrestados.ShowModal;
end;

procedure TfrmPrincipal.ServiosPrestados2Click(Sender: TObject);
begin
  if frmCon_ServicosPrestados = Nil then
    TfrmCon_ServicosPrestados.CreateInstance;

  frmCon_ServicosPrestados.menuCadastro.Enabled := True;
  frmCon_ServicosPrestados.menuMovimento.Enabled := True;
  frmCon_ServicosPrestados.menuConsultas.Enabled := True;

  frmCon_ServicosPrestados.edFiltro_Cliente_ID.Text := '';
  frmCon_ServicosPrestados.edFiltro_Cliente.Text := '';
  frmCon_ServicosPrestados.edFiltro_Cliente_ID.Enabled := True;
  frmCon_ServicosPrestados.edFiltro_Cliente_ID.RightButton.Visible := True;
  frmCon_ServicosPrestados.edFiltro_Cliente.Enabled := True;
  frmCon_ServicosPrestados.FDMem_Registro.Active := False;
  frmCon_ServicosPrestados.FDMem_Registro.Active := True;
  frmCon_ServicosPrestados.ShowModal;
end;

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  if frmCad_Usuarios = Nil then
    TfrmCad_Usuarios.CreateInstance;
  frmCad_Usuarios.ShowModal;
end;

end.



{
Cores:
But�o Edit: #A1A29D
}
