unit uUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MediaLibrary, FMX.Ani, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.TabControl, FMX.Layouts, FMX.MediaLibrary.Actions,
  System.Actions, FMX.ActnList, FMX.StdActns;

type
  TfrmUsuario = class(TForm)
    ActionList: TActionList;
    actLibrary: TTakePhotoFromLibraryAction;
    actCamera: TTakePhotoFromCameraAction;
    imgNVer: TImage;
    imgVer: TImage;
    lytDetail: TLayout;
    tcCadastro: TTabControl;
    tiEtapa1: TTabItem;
    rctEtapa1: TRectangle;
    lytEtapa1: TLayout;
    lytFoto: TLayout;
    Circle_Foto: TCircle;
    imgTirarFoto: TImage;
    lytNome: TLayout;
    edNome: TEdit;
    lbNome: TLabel;
    faNome: TFloatAnimation;
    lytLogin: TLayout;
    edLogin: TEdit;
    lbLogin: TLabel;
    faLogin: TFloatAnimation;
    lytSenha: TLayout;
    edSenha: TEdit;
    lbSenha: TLabel;
    faSenha: TFloatAnimation;
    imgVerSenha: TImage;
    StyleBook_Principal: TStyleBook;
    tiEtapa2: TTabItem;
    rctEtapa2: TRectangle;
    lytEtapa2: TLayout;
    lytPin: TLayout;
    edPin: TEdit;
    lbPin: TLabel;
    faPin: TFloatAnimation;
    lytCelular: TLayout;
    edCelular: TEdit;
    lbCelular: TLabel;
    faCelular: TFloatAnimation;
    lytEmail: TLayout;
    edEmail: TEdit;
    lbEmail: TLabel;
    faEmail: TFloatAnimation;
    tiEtapa3: TTabItem;
    rctEtapa3: TRectangle;
    lytEtapa3: TLayout;
    lytEtapa3_Foto: TLayout;
    Circle_Etapa3_Foto: TCircle;
    lytEtapa3_Opcoes: TLayout;
    lytEtapa3_Buttons: TLayout;
    imgNovoFoto: TImage;
    imgFotoExistente: TImage;
    StyleBook1: TStyleBook;
    lytEtapa1_Acoes: TLayout;
    lytAnterior: TLayout;
    imgAnterior: TImage;
    lytProximo: TLayout;
    imgProximo: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytFechar: TLayout;
    imgFechar: TImage;
    lytConfirmar: TLayout;
    imgConfirmar: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.fmx}

end.
