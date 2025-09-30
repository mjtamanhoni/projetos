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
    AppModule21: TMenuItem;
    Modules1: TMenuItem;
    Module12: TMenuItem;
    Module21: TMenuItem;
    CoreModules1: TMenuItem;
    CoreModule11: TMenuItem;
    procedure Module11Click(Sender: TObject);
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
   ProdutosWebApp;

Function frmPrincipal: TfrmPrincipal;
begin
 Result:= TfrmPrincipal(TfrmPrincipal.GetInstance);
end;

{$R *.dfm}

{ TForm1 }

procedure TfrmPrincipal.ExportD2Bridge;
begin
 inherited;

 Title:= 'Menu Principal';
 SubTitle:= '';

 //TemplateClassForm:= TD2BridgeFormTemplate;
 D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
 D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

 //Export yours Controls
 with D2Bridge.Items.add do
 begin
  SideMenu(MainMenu1);
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

procedure TfrmPrincipal.Module11Click(Sender: TObject);
begin
 TD2BridgeForm(Session.PrimaryForm).Show;
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

end.
