unit uCad.Usuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit, FMX.TabControl,
  FMX.Effects, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.dxControlUtils, FMX.dxGrid,
  FMX.dxControls, FMX.dxCustomization,

  {$Region '99 Coders'}
    uFancyDialog,
  {$EndRegion '99 Coders'}
  IniFiles,
  uPrincipal;

type
  TfrmCad_Usuario = class(TForm)
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiCadastro: TTabItem;
    lytConfig: TLayout;
    lytBDF_Row001: TLayout;
    lbBDF_Servidor: TLabel;
    edBDF_Servidor: TEdit;
    edBDF_Porta: TEdit;
    OpenDialog: TOpenDialog;
    lbBDF_Porta: TLabel;
    lytBDF_Row002: TLayout;
    lbBDF_Banco: TLabel;
    edBDF_Banco: TEdit;
    dbBDF_Banco: TSpeedButton;
    lytBDF_Row003: TLayout;
    lbBDF_Usuario: TLabel;
    edBDF_Usuario: TEdit;
    lbBDF_Senha: TLabel;
    edBDF_Senha: TEdit;
    lytExibeSenha: TLayout;
    imgSenha: TImage;
    sbSenha: TSpeedButton;
    lytBDF_Row004: TLayout;
    lbBDF_Biblioteca: TLabel;
    edBDF_Biblioteca: TEdit;
    sbBDF_Biblioteca: TSpeedButton;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    Layout2: TLayout;
    dxfmGrid: TdxfmGrid;
    dxfmGridRootLevel1: TdxfmGridRootLevel;
    edPesquisar: TEdit;
    imgPesquisar: TImage;
    rctIncluir: TRectangle;
    lbIncluir: TLabel;
    rctEditar: TRectangle;
    lbEditar: TLabel;
    rctSalvar: TRectangle;
    lbSalvar: TLabel;
    rctCancelar: TRectangle;
    lbCancelar: TLabel;
    rctExcluir: TRectangle;
    lbExcluir: TLabel;
    procedure imgFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctCancelarClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
  public
    { Public declarations }
  end;

var
  frmCad_Usuario: TfrmCad_Usuario;

implementation

{$R *.fmx}

procedure TfrmCad_Usuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);

  Action := TCloseAction.caFree;
  frmCad_Usuario := Nil;
end;

procedure TfrmCad_Usuario.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCad_Usuario);
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  FIniFile := TIniFile.Create(FEnder);

  tcPrincipal.ActiveTab := tiLista;

  lytFormulario.Align := TAlignLayout.Center;
end;

procedure TfrmCad_Usuario.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCad_Usuario.rctCancelarClick(Sender: TObject);
begin
  try
    case TRectangle(Sender).Tag of
      0:Incluir;
      1:Editar;
      2:Salvar;
      3:Cancelar;
      4:FFancyDialog.Show(TIconDialog.Question,'Excluir','Deseja Excluir o registro selecionado?','Sim',Excluir,'Não') ;
    end;
  except on E: Exception do
    FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
  end;
end;

procedure TfrmCad_Usuario.Incluir;
begin
  try
    try

    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Usuario.Editar;
begin
  try
    try

    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Usuario.Salvar;
begin
  try
    try

    except on E: Exception do
      raise Exception.Create('Salvar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Usuario.Cancelar;
begin
  try
    try

    except on E: Exception do
      raise Exception.Create('Cancelar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Usuario.Excluir(Sender:TObject);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create('Excluir: ' + E.Message);
    end;
  finally
  end;
end;


end.
