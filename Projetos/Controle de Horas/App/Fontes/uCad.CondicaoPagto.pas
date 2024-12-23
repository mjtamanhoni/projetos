unit uCad.CondicaoPagto;

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
    uFrame.CondicaoPagto,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(AId,ATipoIntervalo,AIntervalo,AParcelas:Integer; ANome:String) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_CondicaoPagto = class(TForm)
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
    lytTIPO_INTERVALO: TLayout;
    lbTIPO_INTERVALO: TLabel;
    edTIPO_INTERVALO: TEdit;
    imgTIPO_INTERVALO: TImage;
    lytINTEVALOR: TLayout;
    lbINTEVALOR: TLabel;
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
    lytRow_003: TLayout;
    lytPARCELAS: TLayout;
    lbPARCELAS: TLabel;
    edPARCELAS: TEdit;
    edINTEVALOR: TEdit;
    procedure imgVoltarClick(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edPARCELASKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edTIPO_INTERVALOClick(Sender: TObject);
    procedure edTIPO_INTERVALOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgLimparClick(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edPARCELASChange(Sender: TObject);
    procedure edINTEVALORChange(Sender: TObject);
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
  frmCad_CondicaoPagto: TfrmCad_CondicaoPagto;

implementation

{$R *.fmx}

{ TfrmCad_CondicaoPagto }

procedure TfrmCad_CondicaoPagto.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_CondicaoPagto;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_CondicaoPagto;

  FId := FFrame.lbDescricao.Tag;
  FDescricao := FFrame.lbDescricao.Text;
  FTipoIntervalo := FFrame.lbTipoIntervalo.Tag;
  FParcelas := FFrame.lbParcelas.Tag;
  FIntervalo := FFrame.lbIntervalo.Tag;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmCad_CondicaoPagto.AddRegistros_LB(
  AId, ASincronizado, AExcluido, ATipoIntervalo, AParcelas, AIntervalo: Integer;
  ADescricao, ATipoIntervalo_Desc: String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_CondicaoPagto;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 50;
    FItem.Tag := AId;
    FItem.TagString := ADescricao;
    FItem.Selectable := True;

    FFrame := TFrame_CondicaoPagto.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbDescricao.Text := ADescricao;
    FFrame.lbDescricao.Tag := AId;
    FFrame.lbTipoIntervalo.Tag := ATipoIntervalo;
    FFrame.lbTipoIntervalo.Text := 'Em: ' + ATipoIntervalo_Desc;
    FFrame.lbIntervalo.Tag := AIntervalo;
    FFrame.lbIntervalo.Text := 'Intervalo: ' + AIntervalo.ToString;
    FFrame.lbParcelas.Tag := AParcelas;
    FFrame.lbParcelas.Text := 'Parcelas: ' + AParcelas.ToString;
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

procedure TfrmCad_CondicaoPagto.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmCad_CondicaoPagto.CriandoCombos;
begin

  cComboTipo := TCustomCombo.Create(frmCad_CondicaoPagto);

  {$Region 'Combo Tipo'}
    cComboTipo.ItemBackgroundColor := $FF363428;
    cComboTipo.ItemFontSize := 15;
    cComboTipo.ItemFontColor := $FFA1B24E;

    cComboTipo.TitleMenuText := 'Escolha o Tipo do Intervalo';
    cComboTipo.TitleFontSize := 17;
    cComboTipo.TitleFontColor := $FF363428;

    cComboTipo.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboTipo.SubTitleFontSize := 13;
    cComboTipo.SubTitleFontColor := $FF363428;

    cComboTipo.BackgroundColor := $FFF2F2F8;
    cComboTipo.OnClick := ItemClick_Tipo;

    cComboTipo.AddItem('0', 'DIAS');
    cComboTipo.AddItem('1', 'MESES');
  {$EndRegion 'Combo Tipo'}

end;

procedure TfrmCad_CondicaoPagto.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmCad_CondicaoPagto);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);
end;

procedure TfrmCad_CondicaoPagto.edDESCRICAOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edPARCELAS.SetFocus;
end;

procedure TfrmCad_CondicaoPagto.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_CondicaoPagto.edINTEVALORChange(Sender: TObject);
begin
  edINTEVALOR.Tag := StrToIntDef(edINTEVALOR.Text,0);
end;

procedure TfrmCad_CondicaoPagto.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmCad_CondicaoPagto,'Editando o Registro');
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
    FQuery.Sql.Add('  ,CASE T.TIPO_INTERVALO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''DIAS'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''MESES'' ');
    FQuery.Sql.Add('  END TIPO_INTERVALO_DESC ');
    FQuery.Sql.Add('FROM CONDICAO_PAGAMENTO T ');
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
        edTIPO_INTERVALO.Tag := FQuery.FieldByName('TIPO_INTERVALO').AsInteger;
        case edTIPO_INTERVALO.Tag of
          0: edTIPO_INTERVALO.Text := 'DIAS';
          1: edTIPO_INTERVALO.Text := 'MESES';
        end;
        edDESCRICAO.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edINTEVALOR.Tag := FQuery.FieldByName('INTEVALOR').AsInteger;
        edINTEVALOR.Text := FQuery.FieldByName('INTEVALOR').AsString;
        edPARCELAS.Tag := FQuery.FieldByName('PARCELAS').AsInteger;
        edPARCELAS.Text := FQuery.FieldByName('PARCELAS').AsString;
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

procedure TfrmCad_CondicaoPagto.edPARCELASChange(Sender: TObject);
begin
  edPARCELAS.Tag := StrToIntDef(edPARCELAS.Text,0);
end;

procedure TfrmCad_CondicaoPagto.edPARCELASKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edTIPO_INTERVALO.SetFocus;
end;

procedure TfrmCad_CondicaoPagto.edTIPO_INTERVALOClick(Sender: TObject);
begin
  cComboTipo.ShowMenu;
end;

procedure TfrmCad_CondicaoPagto.edTIPO_INTERVALOKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edINTEVALOR.SetFocus;
end;

procedure TfrmCad_CondicaoPagto.Excluir(Sender: TObject);
begin
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');

end;

procedure TfrmCad_CondicaoPagto.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_CondicaoPagto,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE CONDICAO_PAGAMENTO SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmCad_CondicaoPagto.FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmCad_CondicaoPagto := Nil;

end;

procedure TfrmCad_CondicaoPagto.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FACBr_Validador := TACBr_Validador.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_CondicaoPagto);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;

end;

procedure TfrmCad_CondicaoPagto.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_CondicaoPagto.imgAcao_01Click(Sender: TObject);
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

procedure TfrmCad_CondicaoPagto.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
  Listar_Registros(edFiltro.Text)
end;

procedure TfrmCad_CondicaoPagto.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FTipoIntervalo,FIntervalo,FParcelas,FDescricao);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

{$IFDEF MSWINDOWS}
procedure TfrmCad_CondicaoPagto.ItemClick_Tipo(Sender: TObject);
begin
  cComboTipo.HideMenu;
  edTIPO_INTERVALO.Tag := StrToInt(cComboTipo.CodItem);
  edTIPO_INTERVALO.Text := cComboTipo.DescrItem;
end;
{$ELSE}
procedure TfrmCad_CondicaoPagto.ItemClick_Tipo(Sender: TObject; const Point: TPointF);
begin
  cComboTipo.HideMenu;
  edTIPO_INTERVALO.Tag := StrToInt(cComboTipo.CodItem);
  edTIPO_INTERVALO.Text := cComboTipo.DescrItem;
end;
{$ENDIF}

procedure TfrmCad_CondicaoPagto.lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FDescricao := Item.TagString;
end;

procedure TfrmCad_CondicaoPagto.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edTIPO_INTERVALO.Text := '';
  edTIPO_INTERVALO.Tag := 0;
  edDESCRICAO.Text := '';
  edPARCELAS.Text := '';
  edPARCELAS.Tag := 0;
  edINTEVALOR.Tag := 0;
  edINTEVALOR.Text := '';
end;

procedure TfrmCad_CondicaoPagto.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmCad_CondicaoPagto,'Listando Registros');
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
    FQuery.Sql.Add('  ,CASE T.TIPO_INTERVALO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''DIAS'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''MESES'' ');
    FQuery.Sql.Add('  END TIPO_INTERVALO_DESC ');
    FQuery.Sql.Add('FROM CONDICAO_PAGAMENTO T ');
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
            ,FQuery.FieldByName('TIPO_INTERVALO').AsInteger
            ,FQuery.FieldByName('PARCELAS').AsInteger
            ,FQuery.FieldByName('INTEVALOR').AsInteger
            ,FQuery.FieldByName('DESCRICAO').AsString
            ,FQuery.FieldByName('TIPO_INTERVALO_DESC').AsString
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

procedure TfrmCad_CondicaoPagto.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_CondicaoPagto,'Salvando alterações');

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
      FQuery.Sql.Add('INSERT INTO CONDICAO_PAGAMENTO( ');
      FQuery.Sql.Add('  DESCRICAO ');
      FQuery.Sql.Add('  ,PARCELAS ');
      FQuery.Sql.Add('  ,TIPO_INTERVALO ');
      FQuery.Sql.Add('  ,INTEVALOR ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :DESCRICAO ');
      FQuery.Sql.Add('  ,:PARCELAS ');
      FQuery.Sql.Add('  ,:TIPO_INTERVALO ');
      FQuery.Sql.Add('  ,:INTEVALOR ');
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
      FQuery.Sql.Add('UPDATE CONDICAO_PAGAMENTO SET ');
      FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
      FQuery.Sql.Add('  ,PARCELAS = :PARCELAS');
      FQuery.Sql.Add('  ,TIPO_INTERVALO = :TIPO_INTERVALO');
      FQuery.Sql.Add('  ,INTEVALOR = :INTEVALOR');
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
    FQuery.ParamByName('PARCELAS').AsInteger := edPARCELAS.Tag;
    FQuery.ParamByName('TIPO_INTERVALO').AsInteger := edTIPO_INTERVALO.Tag;
    FQuery.ParamByName('INTEVALOR').AsInteger := edINTEVALOR.Tag;
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

procedure TfrmCad_CondicaoPagto.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_CondicaoPagto.TThreadEnd_Editar(Sender: TOBject);
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

procedure TfrmCad_CondicaoPagto.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_CondicaoPagto.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);

end;

procedure TfrmCad_CondicaoPagto.TTHreadEnd_Salvar(Sender: TOBject);
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
