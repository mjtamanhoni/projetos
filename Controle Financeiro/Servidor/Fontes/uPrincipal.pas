unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Effects, FMX.Objects, FMX.Layouts,
  FMX.Controls.Presentation, FMX.MultiView;

type
  TfrmPrincipal = class(TForm)
    StyleBook_Principal: TStyleBook;
    mvPrincipal: TMultiView;
    rctMenuPrincipal: TRectangle;
    lytMenu_Principal: TLayout;
    lytMenuFechar: TLayout;
    imgMenuFechar: TImage;
    lytMenu_Config: TLayout;
    imgMenu_Config: TImage;
    lytMenu_Estrutura: TLayout;
    imgMenu_Estrutura: TImage;
    lytMenu_Geral: TLayout;
    ShadowEffect3: TShadowEffect;
    lytPrincipal: TLayout;
    lytDetail: TLayout;
    Memo_Historico: TMemo;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    lytFechar: TLayout;
    imgFechar: TImage;
    lytMenu: TLayout;
    imgMenu: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    ShadowEffect2: TShadowEffect;
    lytPorta: TLayout;
    rctPorta: TRectangle;
    lbPorta: TLabel;
    lytVersao: TLayout;
    rctVersao: TRectangle;
    lbVersao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

end.
