unit uCad.TabelaPreco;

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
    uFrame.TabelaPreco,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(Aid:Integer; ANome:String; AValor:Double) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_TabelaPreco = class(TForm)
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
    lytRow_003: TLayout;
    lytVALOR: TLayout;
    lbVALOR: TLabel;
    edVALOR: TEdit;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    lytTIPO: TLayout;
    lbTIPO: TLabel;
    edTIPO: TEdit;
    imgPESSOA: TImage;
    procedure edTIPOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgVoltarClick(Sender: TObject);
    procedure edTIPOClick(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure imgLimparClick(Sender: TObject);
    procedure edVALORTyping(Sender: TObject);
    procedure edVALORChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    FValor :Double;
    FTipo :Integer;

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
    procedure AddRegistros_LB(AId,ASincronizado,AExcluido,ATipo:Integer; ADescricao,ATipo_Desc:String;AValor:Double);
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
  frmCad_TabelaPreco: TfrmCad_TabelaPreco;

implementation

{$R *.fmx}

{ TfrmCad_TabelaPrec}


{$IFDEF MSWINDOWS}
procedure TfrmCad_TabelaPreco.ItemClick_Tipo(Sender: TObject);
begin
  cComboTipo.HideMenu;
  edTIPO.Tag := StrToInt(cComboTipo.CodItem);
  edTIPO.Text := cComboTipo.DescrItem;
end;
{$ELSE}
procedure TfrmCad_TabelaPreco.ItemClick_Tipo(Sender: TObject; const Point: TPointF);
begin
  cComboTipo.HideMenu;
  edTIPO.Tag := StrToInt(cComboTipo.CodItem);
  edTIPO.Text := cComboTipo.DescrItem;
end;
{$ENDIF}

procedure TfrmCad_TabelaPreco.lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FDescricao := Item.TagString;
  FValor := Item.TagFloat;
end;

procedure TfrmCad_TabelaPreco.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_TabelaPreco;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_TabelaPreco;

  FId := FFrame.lbDescricao.Tag;
  FDescricao := FFrame.lbDescricao.Text;
  FValor := FFrame.lbValor.TagFloat;
  FTipo := FFrame.lbTipo.Tag;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmCad_TabelaPreco.AddRegistros_LB(AId,ASincronizado,AExcluido,ATipo:Integer; ADescricao,ATipo_Desc:String;AValor:Double);
var
  FItem :TListBoxItem;
  FFrame :TFrame_TabelaPreco;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 50;
    FItem.Tag := AId;
    FItem.TagString := ADescricao;
    FItem.TagFloat := AValor;
    FItem.Selectable := True;

    FFrame := TFrame_TabelaPreco.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbDescricao.Text := ADescricao;
    FFrame.lbDescricao.Tag := AId;
    FFrame.lbTipo.Text := ATipo_Desc;
    FFrame.lbTipo.Tag := ATipo;
    FFrame.lbValor.Text := FormatFloat('#,##0.00',AValor);
    FFrame.lbValor.TagFloat := AValor;
    case ASincronizado of
      0:FFrame.imgSincronizado.Opacity := 0.3;
      1:FFrame.imgSincronizado.Opacity := 1;
    end;
    case AExcluido of
      0:FFrame.imgExcluído.Opacity := 0.3;
      1:FFrame.imgExcluído.Opacity := 1;
    end;
    FFrame.rctMenu.OnClick := Abre_Menu_Registros;

    lbRegistros.AddObject(FItem);

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmCad_TabelaPreco.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmCad_TabelaPreco.CriandoCombos;
begin

  cComboTipo := TCustomCombo.Create(frmCad_TabelaPreco);

  {$Region 'Combo Tipo'}
    cComboTipo.ItemBackgroundColor := $FF363428;
    cComboTipo.ItemFontSize := 15;
    cComboTipo.ItemFontColor := $FFA1B24E;

    cComboTipo.TitleMenuText := 'Escolha o tipo da Tabela';
    cComboTipo.TitleFontSize := 17;
    cComboTipo.TitleFontColor := $FF363428;

    cComboTipo.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboTipo.SubTitleFontSize := 13;
    cComboTipo.SubTitleFontColor := $FF363428;

    cComboTipo.BackgroundColor := $FFF2F2F8;
    cComboTipo.OnClick := ItemClick_Tipo;

    cComboTipo.AddItem('0', 'HORA');
    cComboTipo.AddItem('1', 'FIXO');
  {$EndRegion 'Combo Tipo'}

end;

procedure TfrmCad_TabelaPreco.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmCad_TabelaPreco);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);

end;

procedure TfrmCad_TabelaPreco.edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edVALOR.SetFocus;
end;

procedure TfrmCad_TabelaPreco.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_TabelaPreco.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmCad_TabelaPreco,'Editando o Registro');
  LimparCampos;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('SELECT  ');
    FQuery.Sql.Add('  T.*  ');
    FQuery.Sql.Add('  ,CASE T.TIPO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''HORA'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''FIXO'' ');
    FQuery.Sql.Add('  END TIPO_DESC ');
    FQuery.Sql.Add('FROM TABELA_PRECO T ');
    FQuery.Sql.Add('WHERE T.ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.Active := True;
    if not FQuery.IsEmpty then
    begin
      FQuery.First;
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        edID.Tag := FQuery.FieldByName('ID').AsInteger;
        edID.Text := FQuery.FieldByName('ID').AsString;
        edTIPO.Tag := FQuery.FieldByName('TIPO').AsInteger;
        case edTIPO.Tag of
          0: edTIPO.Text := 'HORA';
          1: edTIPO.Text := 'FIXO';
        end;
        edDESCRICAO.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edVALOR.TagFloat := FQuery.FieldByName('VALOR').AsFloat;
        edVALOR.Text := FormatFloat(',##0.00',FQuery.FieldByName('VALOR').AsFloat);
      end);
    end;

    {$IFDEF MSWINDWOS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}


  end);

  t.OnTerminate := TThreadEnd_Editar;
  t.Start;
end;

procedure TfrmCad_TabelaPreco.edTIPOClick(Sender: TObject);
begin
  cComboTipo.ShowMenu;
end;

procedure TfrmCad_TabelaPreco.edTIPOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edDESCRICAO.SetFocus;
end;

procedure TfrmCad_TabelaPreco.edVALORChange(Sender: TObject);
begin
  edVALOR.TagFloat := TFuncoes.RetornaValor_TextMoney(edVALOR.Text,2);
end;

procedure TfrmCad_TabelaPreco.edVALORTyping(Sender: TObject);
begin
  Formatar(edVALOR,Valor);
end;

procedure TfrmCad_TabelaPreco.Excluir(Sender: TObject);
begin
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmCad_TabelaPreco.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_TabelaPreco,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE TABELA_PRECO SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmCad_TabelaPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(cComboTipo);
    FreeAndNil(FACBr_Validador);
    FreeAndNil(FMenu_Frame);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    cComboTipo.DisposeOf;
    FACBr_Validador.DisposeOf;
    FMenu_Frame.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmCad_TabelaPreco := Nil;
end;

procedure TfrmCad_TabelaPreco.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FACBr_Validador := TACBr_Validador.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_TabelaPreco);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;
end;

procedure TfrmCad_TabelaPreco.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_TabelaPreco.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      FTab_Status := dsInsert;
      LimparCampos;
      imgAcao_01.Tag := 1;
      imgAcao_01.Bitmap := imgSalvar.Bitmap;
      tcPrincipal.GotoVisibleTab(1);
      if edDESCRICAO.CanFocus then
        edDESCRICAO.SetFocus;
    end;
    1:Salvar;
  end;
end;

procedure TfrmCad_TabelaPreco.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
end;

procedure TfrmCad_TabelaPreco.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FDescricao,FValor);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

procedure TfrmCad_TabelaPreco.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edTIPO.Text := '';
  edTIPO.Tag := 0;
  edDESCRICAO.Text := '';
  edVALOR.Text := '';
  edVALOR.TagFloat := 0;
end;

procedure TfrmCad_TabelaPreco.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmCad_TabelaPreco,'Listando Registros');
  lbRegistros.Clear;
  lbRegistros.BeginUpdate;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('SELECT  ');
    FQuery.Sql.Add('  T.*  ');
    FQuery.Sql.Add('  ,CASE T.TIPO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''HORA'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''FIXO'' ');
    FQuery.Sql.Add('  END TIPO_DESC ');
    FQuery.Sql.Add('FROM TABELA_PRECO T ');
    FQuery.Sql.Add('WHERE NOT T.ID IS NULL ');
    if Trim(APesquisa) <> '' then
    begin
      FQuery.Sql.Add('  AND T.DESCRICAO LIKE :DESCRICAO');
      FQuery.ParamByName('DESCRICAO').AsString := '%' + APesquisa + '%';
    end;
    FQuery.Active := True;
    if not FQuery.IsEmpty then
    begin
      FQuery.First;
      while not FQuery.Eof do
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          AddRegistros_LB(
            FQuery.FieldByName('ID').AsInteger
            ,FQuery.FieldByName('SINCRONIZADO').AsInteger
            ,FQuery.FieldByName('EXCLUIDO').AsInteger
            ,FQuery.FieldByName('TIPO').AsInteger
            ,FQuery.FieldByName('DESCRICAO').AsString
            ,FQuery.FieldByName('TIPO_DESC').AsString
            ,FQuery.FieldByName('VALOR').AsFloat
          );
        end);
        FQuery.Next;
      end;
    end;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbRegistros.EndUpdate;
    end);

    if Assigned(FQuery) then
      FreeAndNil(FQuery);

  end);

  t.OnTerminate := TThreadEnd_Listar_Registros;
  t.Start;
end;

procedure TfrmCad_TabelaPreco.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_TabelaPreco,'Salvando alterações');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;

    if FTab_Status = dsInsert then
    begin
      FQuery.Sql.Add('INSERT INTO TABELA_PRECO( ');
      FQuery.Sql.Add('  DESCRICAO ');
      FQuery.Sql.Add('  ,TIPO ');
      FQuery.Sql.Add('  ,VALOR ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :DESCRICAO ');
      FQuery.Sql.Add('  ,:TIPO ');
      FQuery.Sql.Add('  ,:VALOR ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('  ,:SINCRONIZADO ');
      FQuery.Sql.Add('  ,:ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,:EXCLUIDO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
      FQuery.ParamByName('ID_PRINCIPAL').AsInteger := 0;
      FQuery.ParamByName('EXCLUIDO').AsInteger := 0;
    end
    else if FTab_Status = dsEdit then
    begin
      FQuery.Sql.Add('UPDATE TABELA_PRECO SET ');
      FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
      FQuery.Sql.Add('  ,TIPO = :TIPO ');
      FQuery.Sql.Add('  ,VALOR = :VALOR ');
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
    FQuery.ParamByName('TIPO').AsInteger := edTIPO.Tag;
    FQuery.ParamByName('VALOR').AsFloat := edVALOR.TagFloat;
    FQuery.ExecSQL;

    {$IFDEF MSWINDOWS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}

  end);

  t.OnTerminate := TTHreadEnd_Salvar;
  t.Start;
end;

procedure TfrmCad_TabelaPreco.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_TabelaPreco.TThreadEnd_Editar(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FTab_Status := dsEdit;
    imgAcao_01.Tag := 1;
    imgAcao_01.Bitmap := imgSalvar.Bitmap;
    tcPrincipal.GotoVisibleTab(1);
  end;
end;

procedure TfrmCad_TabelaPreco.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_TabelaPreco.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmCad_TabelaPreco.TTHreadEnd_Salvar(Sender: TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Salvar',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FTab_Status := dsLista;
    imgAcao_01.Tag := 0;
    imgAcao_01.Bitmap := imgNovo.Bitmap;
    tcPrincipal.GotoVisibleTab(0);
    Listar_Registros(edFiltro.Text);
  end;
end;

end.
