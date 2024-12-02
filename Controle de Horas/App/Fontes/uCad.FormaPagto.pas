unit uCad.FormaPagto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uCombobox,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uACBr,
  uFuncoes,

  {$Region 'Frames'}
    uFrame.FormaPagto,
    uFrame.CondFormaPagto,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(AId,ATipoIntervalo:Integer; ANome:String) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_FormaPagto = class(TForm)
    imgCancelar: TImage;
    imgChecked: TImage;
    imgEditar: TImage;
    imgEsconder: TImage;
    imgExcluir: TImage;
    imgExibir: TImage;
    imgNovo: TImage;
    imgSalvar: TImage;
    imgUnChecked: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytLista: TLayout;
    lbRegistros: TListBox;
    lytFiltro: TLayout;
    edFiltro: TEdit;
    imgLimpar: TImage;
    tiCampos: TTabItem;
    lytCampos: TLayout;
    lytCampos_001: TLayout;
    lytRow_001: TLayout;
    lytID: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytRow_002: TLayout;
    lytDESCRICAO: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    lytCLASSIFICACAO: TLayout;
    lbCLASSIFICACAO: TLabel;
    edCLASSIFICACAO: TEdit;
    imgCLASSIFICACAO: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    procedure imgVoltarClick(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure edCLASSIFICACAOClick(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgLimparClick(Sender: TObject);
  private
    FPesquisa: Boolean;

    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    cComboTipo :TCustomCombo;
    cComboStatus :TCustomCombo;
    FMenu_Frame :TActionSheet;

    FId :Integer;
    FDescricao :String;
    FTipoIntervalo :Integer;
    FParcelas :Integer;
    FIntervalo :Integer;

    FACBr_Validador :TACBr_Validador;

    procedure LimparCampos;
    procedure Salvar;
    procedure TTHreadEnd_Salvar(Sender: TOBject);
    procedure Cancelar(Sender: TOBject);

    {$IFDEF MSWINDOWS}
      procedure ItemClick_Tipo(Sender: TObject);
    {$ELSE}
      procedure ItemClick_Tipo(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    procedure Listar_Registros(APesquisa:String);

    procedure CriandoCombos;
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure AddRegistros_LB(AId, ASincronizado, AExcluido, ATipoIntervalo, AParcelas, AIntervalo: Integer; ADescricao, ATipoIntervalo_Desc: String);
    procedure Abre_Menu_Registros(Sender :TOBject);
    procedure CriandoMenus;
    procedure Editar(Sender: TOBject);
    procedure Excluir(Sender: TObject);
    procedure TThreadEnd_Editar(Sender: TOBject);
    procedure Excluir_Registro(Sender: TObject);
    procedure TThreadEnd_ExcluirRegistro(Sender: TOBject);
    procedure SetPesquisa(const Value: Boolean);
  public
    ExecuteOnClose :TExecuteOnClose;
    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_FormaPagto: TfrmCad_FormaPagto;

implementation

{$R *.fmx}

{ TfrmCad_FormaPagto }

procedure TfrmCad_FormaPagto.Abre_Menu_Registros(Sender: TOBject);
begin

end;

procedure TfrmCad_FormaPagto.AddRegistros_LB(AId, ASincronizado, AExcluido, ATipoIntervalo, AParcelas,
  AIntervalo: Integer; ADescricao, ATipoIntervalo_Desc: String);
begin

end;

procedure TfrmCad_FormaPagto.Cancelar(Sender: TOBject);
begin

end;

procedure TfrmCad_FormaPagto.CriandoCombos;
begin

end;

procedure TfrmCad_FormaPagto.CriandoMenus;
begin

end;

procedure TfrmCad_FormaPagto.edCLASSIFICACAOClick(Sender: TObject);
begin
  //
end;

procedure TfrmCad_FormaPagto.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  //
end;

procedure TfrmCad_FormaPagto.Editar(Sender: TOBject);
begin

end;

procedure TfrmCad_FormaPagto.Excluir(Sender: TObject);
begin

end;

procedure TfrmCad_FormaPagto.Excluir_Registro(Sender: TObject);
begin

end;

procedure TfrmCad_FormaPagto.imgAcao_01Click(Sender: TObject);
begin
  //
end;

procedure TfrmCad_FormaPagto.imgLimparClick(Sender: TObject);
begin
  //
end;

procedure TfrmCad_FormaPagto.imgVoltarClick(Sender: TObject);
begin
  //
end;

{$IFDEF MSWINDOWS}
procedure TfrmCad_FormaPagto.ItemClick_Tipo(Sender: TObject);
begin

end
{$ELSE}
procedure TfrmCad_FormaPagto.ItemClick_Tipo(Sender: TObject; const Point: TPointF);
begin

end;
{$ENDIF}

procedure TfrmCad_FormaPagto.lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  //
end;

procedure TfrmCad_FormaPagto.LimparCampos;
begin

end;

procedure TfrmCad_FormaPagto.Listar_Registros(APesquisa: String);
begin

end;

procedure TfrmCad_FormaPagto.Salvar;
begin

end;

procedure TfrmCad_FormaPagto.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_FormaPagto.TThreadEnd_Editar(Sender: TOBject);
begin

end;

procedure TfrmCad_FormaPagto.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin

end;

procedure TfrmCad_FormaPagto.TThreadEnd_Listar_Registros(Sender: TObject);
begin

end;

procedure TfrmCad_FormaPagto.TTHreadEnd_Salvar(Sender: TOBject);
begin

end;

end.
