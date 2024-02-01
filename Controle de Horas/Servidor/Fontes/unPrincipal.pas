unit unPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Layouts, FMX.Objects, FMX.Effects, FMX.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    lytHeader: TLayout;
    lytPrincipal: TLayout;
    lytFooter: TLayout;
    mvPrincipal: TMultiView;
    lytDetail: TLayout;
    StyleBook_Principal: TStyleBook;
    memoHistorico: TMemo;
    rctHeader: TRectangle;
    rctFooter: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    lytFechar: TLayout;
    imgFechar: TImage;
    lytMenu: TLayout;
    imgMenu: TImage;
    lytPorta: TLayout;
    rctPorta: TRectangle;
    lbPorta: TLabel;
    lytVersao: TLayout;
    rctVersao: TRectangle;
    lbVersao: TLabel;
    rctMenuPrincipal: TRectangle;
    lytMenuFechar: TLayout;
    imgMenuFechar: TImage;
    ShadowEffect3: TShadowEffect;
    lbTitulo: TLabel;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgMenuClick(Sender: TObject);
    procedure imgMenuFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
  mvPrincipal.ShowMaster;
end;

procedure TfrmPrincipal.imgMenuFecharClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
end;

end.




{
CORES DO APP
  Verde Escuro: #FF363428
  Verde Claro: #FFA1B24E
  Componentes: #FFD9D7CA
}
