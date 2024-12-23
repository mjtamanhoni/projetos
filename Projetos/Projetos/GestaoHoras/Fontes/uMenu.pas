unit uMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FMX.TabControl, FMX.Effects;

type
  TfrmMenu = class(TForm)
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    imgConfirmar: TImage;
    tcPrincipal: TTabControl;
    tiCadastros: TTabItem;
    lytCadastros: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    imgEmpresa: TImage;
    lbEmpresa: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    imgCliente: TImage;
    lbCliente: TLabel;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    imgTabPreco: TImage;
    lbTabPreco: TLabel;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    imgProjetos: TImage;
    lbProjetos: TLabel;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgConfirmarClick(Sender: TObject);
    procedure imgEmpresaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.fmx}
uses
  uEmpresa;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.CaFree;
  frmMenu := Nil;
end;

procedure TfrmMenu.imgConfirmarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenu.imgEmpresaClick(Sender: TObject);
begin
  if not Assigned(frmEmpresa) then
    Application.CreateForm(TfrmEmpresa,frmEmpresa);
  frmEmpresa.Show;

  Close;
end;

end.
