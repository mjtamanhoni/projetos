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
  uPrincipal,
  uDm.Global, System.Actions, FMX.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Fmx.Bind.Navigator, Data.Bind.Components,
  Data.Bind.DBScope;

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
    edPesquisar: TEdit;
    imgPesquisar: TImage;
    rctIncluir: TRectangle;
    rctEditar: TRectangle;
    rctSalvar: TRectangle;
    rctCancelar: TRectangle;
    rctExcluir: TRectangle;
    FDQRegistros: TFDQuery;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosNOME: TStringField;
    FDQRegistrosLOGIN: TStringField;
    FDQRegistrosSENHA: TStringField;
    FDQRegistrosPIN: TStringField;
    FDQRegistrosCELULAR: TStringField;
    FDQRegistrosEMAIL: TStringField;
    FDQRegistrosFOTO: TMemoField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosSINCRONIZADO: TIntegerField;
    DSRegistros: TDataSource;
    imgIncluir: TImage;
    imgEditar: TImage;
    imgSalvar: TImage;
    imgCancelar: TImage;
    imgExcluir: TImage;
    Layout2: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    dxfmGrid1RootLevel1Column1: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column2: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column3: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column4: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column5: TdxfmGridColumn;
    procedure imgFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctCancelarClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;

    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Selecionar_Registros;
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

  FDm_Global := TDM_Global.Create(Nil);
  FDQRegistros.Connection := FDm_Global.FDC_Firebird;


  Selecionar_Registros;
end;

procedure TfrmCad_Usuario.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  U.* ');
      FDQRegistros.SQL.Add('FROM USUARIO U ');
      FDQRegistros.SQL.Add('WHERE NOT U.ID IS NULL ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  U.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally

  end;
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
