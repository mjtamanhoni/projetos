unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Effects, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView;

type
  TfrmPrincipal = class(TForm)
    rctHeader: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    imgLog: TImage;
    StyleBook_Principal: TStyleBook;
    mtvMenu: TMultiView;
    lytMenu_Header: TLayout;
    rctMenuHeader: TRectangle;
    ShadowEffect18: TShadowEffect;
    lytMenu_Detail: TLayout;
    lbxMenu: TListBox;
    lbiConfig: TListBoxItem;
    rctConfig: TRectangle;
    imgConfig: TImage;
    lbConfig: TLabel;
    lytMenu_Footer: TLayout;
    rctMenu_Footer: TRectangle;
    lytFechar_Icon: TLayout;
    Image2: TImage;
    lytFechar_Desc: TLayout;
    lbFechar: TLabel;
    sbFechar: TSpeedButton;
    lbVersao: TLabel;
    Label1: TLabel;
    rctFooter: TRectangle;
    lytHeaderPrincipal: TLayout;
    lytHeaderTitle: TLayout;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    lytTollBar: TLayout;
    lytPrincipal: TLayout;
    imgFechar: TImage;
    Rectangle1: TRectangle;
    lbVersaoPrincipal: TLabel;
    lbiCadUsuario: TListBoxItem;
    rctCadUsuario: TRectangle;
    imgCadUsuario: TImage;
    lbCadUsuario: TLabel;
    procedure imgLogClick(Sender: TObject);
    procedure rctConfigClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctCadUsuarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uConfig
  ,uCad.Usuario;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := tCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.imgLogClick(Sender: TObject);
begin
  mtvMenu.ShowMaster;
end;

procedure TfrmPrincipal.rctCadUsuarioClick(Sender: TObject);
begin
  mtvMenu.HideMaster;
  Application.CreateForm(TfrmCad_Usuario,frmCad_Usuario);
  frmCad_Usuario.Parent := lytPrincipal;
  frmCad_Usuario.Show;
end;

procedure TfrmPrincipal.rctConfigClick(Sender: TObject);
begin
  mtvMenu.HideMaster;
  Application.CreateForm(TfrmConfig,frmConfig);
  frmConfig.Parent := lytPrincipal;
  frmConfig.Show;
end;

end.


{
#363428
#A1B24E
}
