unit uCad.Conta;

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
    uFrame.Conta,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_Contas = class(TForm)
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
    lytTIPO: TLayout;
    lbTIPO: TLabel;
    edTIPO: TEdit;
    imgPESSOA: TImage;
    lytRow_002: TLayout;
    lytDESCRICAO: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    lytSTATUS: TLayout;
    lbSTATUS: TLabel;
    edSTATUS: TEdit;
    imgSTATUS: TImage;
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edTIPOClick(Sender: TObject);
    procedure edSTATUSClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure imgLimparClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
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
    FTipo :Integer;
    FStatus :Integer;

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

    {$IFDEF MSWINDOWS}
      procedure ItemClick_Status(Sender: TObject);
    {$ELSE}
      procedure ItemClick_Status(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    procedure Listar_Registros(APesquisa:String);

    procedure CriandoCombos;
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure AddRegistros_LB(AId, ASincronizado, AExcluido, ATipo, AStatus: Integer; ADescricao, ATipo_Desc,AStatus_Desc: String);
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
  frmCad_Contas: TfrmCad_Contas;

implementation

{$R *.fmx}

{ TfrmCad_Contas }

procedure TfrmCad_Contas.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_Conta;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_Conta;

  FId := FFrame.lbDescricao.Tag;
  FDescricao := FFrame.lbDescricao.Text;
  FTipo := FFrame.lbTipo.Tag;
  FStatus := FFrame.lbStatus.Tag;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmCad_Contas.AddRegistros_LB(AId, ASincronizado, AExcluido, ATipo, AStatus: Integer; ADescricao,
  ATipo_Desc,AStatus_Desc: String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_Conta;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 50;
    FItem.Tag := AId;
    FItem.TagString := ADescricao;
    FItem.Selectable := True;

    FFrame := TFrame_Conta.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbDescricao.Text := ADescricao;
    FFrame.lbDescricao.Tag := AId;
    FFrame.lbTipo.Text := ATipo_Desc;
    FFrame.lbTipo.Tag := ATipo;
    FFrame.lbStatus.Text := AStatus_Desc;
    FFrame.lbStatus.Tag := AStatus;
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

procedure TfrmCad_Contas.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmCad_Contas.CriandoCombos;
begin

  cComboTipo := TCustomCombo.Create(frmCad_Contas);
  cComboStatus := TCustomCombo.Create(frmCad_Contas);

  {$Region 'Combo Tipo'}
    cComboTipo.ItemBackgroundColor := $FF363428;
    cComboTipo.ItemFontSize := 15;
    cComboTipo.ItemFontColor := $FFA1B24E;

    cComboTipo.TitleMenuText := 'Escolha o tipo da Conta';
    cComboTipo.TitleFontSize := 17;
    cComboTipo.TitleFontColor := $FF363428;

    cComboTipo.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboTipo.SubTitleFontSize := 13;
    cComboTipo.SubTitleFontColor := $FF363428;

    cComboTipo.BackgroundColor := $FFF2F2F8;
    cComboTipo.OnClick := ItemClick_Tipo;

    cComboTipo.AddItem('0', 'CRÉDITO');
    cComboTipo.AddItem('1', 'DÉBITO');
  {$EndRegion 'Combo Tipo'}

  {$Region 'Combo Status'}
    cComboStatus.ItemBackgroundColor := $FF363428;
    cComboStatus.ItemFontSize := 15;
    cComboStatus.ItemFontColor := $FFA1B24E;

    cComboStatus.TitleMenuText := 'Defina o Status do Registro';
    cComboStatus.TitleFontSize := 17;
    cComboStatus.TitleFontColor := $FF363428;

    cComboStatus.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboStatus.SubTitleFontSize := 13;
    cComboStatus.SubTitleFontColor := $FF363428;

    cComboStatus.BackgroundColor := $FFF2F2F8;
    cComboStatus.OnClick := ItemClick_Status;

    cComboStatus.AddItem('0', 'INATIVO');
    cComboStatus.AddItem('1', 'ATIVO');
  {$EndRegion 'Combo Status'}

end;

procedure TfrmCad_Contas.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmCad_Contas);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);
end;

procedure TfrmCad_Contas.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);

end;

procedure TfrmCad_Contas.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmCad_Contas,'Editando o Registro');
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
    FQuery.Sql.Add('  ,CASE T.STATUS ');
    FQuery.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''ATIVO'' ');
    FQuery.Sql.Add('  END STATUS_DESC ');
    FQuery.Sql.Add('FROM CONTA T ');
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
          0: edTIPO.Text := 'CRÉDITO';
          1: edTIPO.Text := 'DÉBITO';
        end;
        edDESCRICAO.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edSTATUS.Tag := FQuery.FieldByName('STATUS').AsInteger;
        case edSTATUS.Tag of
          0 :edSTATUS.Text := 'INATIVO';
          1 :edSTATUS.Text := 'ATIVO';
        end;
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

procedure TfrmCad_Contas.edSTATUSClick(Sender: TObject);
begin
  cComboStatus.ShowMenu;
end;

procedure TfrmCad_Contas.edTIPOClick(Sender: TObject);
begin
  cComboTipo.ShowMenu;
end;

procedure TfrmCad_Contas.Excluir(Sender: TObject);
begin
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmCad_Contas.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_Contas,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE CONTA SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmCad_Contas.FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmCad_Contas := Nil;
end;

procedure TfrmCad_Contas.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FACBr_Validador := TACBr_Validador.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_Contas);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;
end;

procedure TfrmCad_Contas.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_Contas.imgAcao_01Click(Sender: TObject);
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

procedure TfrmCad_Contas.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
  Listar_Registros(edFiltro.Text)
end;

procedure TfrmCad_Contas.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FDescricao);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

procedure TfrmCad_Contas.lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FDescricao := Item.TagString;

end;

{$IFDEF MSWINDOWS}
procedure TfrmCad_Contas.ItemClick_Tipo(Sender: TObject);
begin
  cComboTipo.HideMenu;
  edTIPO.Tag := StrToInt(cComboTipo.CodItem);
  edTIPO.Text := cComboTipo.DescrItem;
end;
{$ELSE}
procedure TfrmCad_Contas.ItemClick_Tipo(Sender: TObject; const Point: TPointF);
begin
  cComboTipo.HideMenu;
  edTIPO.Tag := StrToInt(cComboTipo.CodItem);
  edTIPO.Text := cComboTipo.DescrItem;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
procedure TfrmCad_Contas.ItemClick_Status(Sender: TObject);
begin
  cComboStatus.HideMenu;
  edSTATUS.Tag := StrToInt(cComboStatus.CodItem);
  edSTATUS.Text := cComboStatus.DescrItem;

end;
{$ELSE}
procedure TfrmCad_Contas.ItemClick_Status(Sender: TObject; const Point: TPointF);
begin
  cComboStatus.HideMenu;
  edSTATUS.Tag := StrToInt(cComboStatus.CodItem);
  edSTATUS.Text := cComboStatus.DescrItem;
end;
{$ENDIF}

procedure TfrmCad_Contas.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edTIPO.Text := '';
  edTIPO.Tag := 0;
  edDESCRICAO.Text := '';
  edSTATUS.Text := '';
  edSTATUS.Tag := 0;
end;

procedure TfrmCad_Contas.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmCad_Contas,'Listando Registros');
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
    FQuery.Sql.Add('    WHEN 0 THEN ''CRÉDITO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''DÉBITO'' ');
    FQuery.Sql.Add('  END TIPO_DESC ');
    FQuery.Sql.Add('  ,CASE T.STATUS ');
    FQuery.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''ATIVO'' ');
    FQuery.Sql.Add('  END STATUS_DESC ');
    FQuery.Sql.Add('FROM CONTA T ');
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
            ,FQuery.FieldByName('STATUS').AsInteger
            ,FQuery.FieldByName('DESCRICAO').AsString
            ,FQuery.FieldByName('TIPO_DESC').AsString
            ,FQuery.FieldByName('STATUS_DESC').AsString
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

procedure TfrmCad_Contas.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_Contas,'Salvando alterações');

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
      FQuery.Sql.Add('INSERT INTO CONTA( ');
      FQuery.Sql.Add('  DESCRICAO ');
      FQuery.Sql.Add('  ,TIPO ');
      FQuery.Sql.Add('  ,STATUS ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :DESCRICAO ');
      FQuery.Sql.Add('  ,:TIPO ');
      FQuery.Sql.Add('  ,:STATUS ');
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
      FQuery.Sql.Add('UPDATE CONTA SET ');
      FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
      FQuery.Sql.Add('  ,TIPO = :TIPO ');
      FQuery.Sql.Add('  ,STATUS = :STATUS ');
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
    FQuery.ParamByName('TIPO').AsInteger := edTIPO.Tag;
    FQuery.ParamByName('STATUS').AsFloat := edSTATUS.Tag;
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

procedure TfrmCad_Contas.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_Contas.TThreadEnd_Editar(Sender: TOBject);
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

procedure TfrmCad_Contas.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);

end;

procedure TfrmCad_Contas.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);

end;

procedure TfrmCad_Contas.TTHreadEnd_Salvar(Sender: TOBject);
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
