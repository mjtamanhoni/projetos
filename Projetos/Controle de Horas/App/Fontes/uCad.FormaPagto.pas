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
  TExecuteOnClose = procedure(AId:Integer; ADescricao,AClassificacao:String) of Object;
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
    rctCondicaoPagto: TRectangle;
    rctCondicaoPagto_Tit: TRectangle;
    lbCondicaoPagto_Tit: TLabel;
    ShadowEffect1: TShadowEffect;
    lytCondicaoPagto_Footer: TLayout;
    rctCondicaoPagto_Footer: TRectangle;
    imbCondicaoPagto_Novo: TImage;
    lbCondicaoPagto: TListBox;
    imbCondicaoPagto_Excluir: TImage;
    procedure imgVoltarClick(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure edCLASSIFICACAOClick(Sender: TObject);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure imgLimparClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure imbCondicaoPagto_NovoClick(Sender: TObject);
    procedure lbCondicaoPagtoItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure imbCondicaoPagto_ExcluirClick(Sender: TObject);
  private
    FPesquisa: Boolean;

    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    cComboClassificacao :TCustomCombo;
    FMenu_Frame :TActionSheet;

    FId :Integer;
    FDescricao :String;
    FClassificacao :String;

    FId_Condicao :Integer;
    FDescricao_Condicao :String;

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
    procedure AddRegistros_LB(AId, ASincronizado, AExcluido: Integer; ADescricao, AClassificacao: String);
    procedure Abre_Menu_Registros(Sender :TOBject);
    procedure CriandoMenus;
    procedure Editar(Sender: TOBject);
    procedure Excluir(Sender: TObject);
    procedure TThreadEnd_Editar(Sender: TOBject);
    procedure Excluir_Registro(Sender: TObject);
    procedure TThreadEnd_ExcluirRegistro(Sender: TOBject);
    procedure SetPesquisa(const Value: Boolean);
    procedure Sel_Condicao(AId, ATipoIntervalo, AIntervalo, AParcelas: Integer; ANome: String);
    procedure Listar_CondicaoPagto;
    procedure AddRegistrosCP_LB(AId, AParcelas, ATipoIntervalo, AIntervalo: Integer; ADescricao,
      ATipoIntervalo_Desc: String);
    procedure TThreadEnd_Listar_RegistrosCP(Sender: TOBject);
    procedure Excluir_Condica(Sender: TOBject);
    procedure TThreadEnd_Excluir_Condicao(Sender: TOBject);
  public
    ExecuteOnClose :TExecuteOnClose;
    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_FormaPagto: TfrmCad_FormaPagto;

implementation

{$R *.fmx}

uses
  uCad.CondicaoPagto;

{ TfrmCad_FormaPagto }

procedure TfrmCad_FormaPagto.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_FormaPagto;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_FormaPagto;

  FId := FFrame.lbDescricao.Tag;
  FDescricao := FFrame.lbDescricao.Text;
  FClassificacao := FFrame.lbClassificacao.Text;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmCad_FormaPagto.AddRegistros_LB(AId, ASincronizado, AExcluido: Integer; ADescricao, AClassificacao: String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_FormaPagto;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 50;
    FItem.Tag := AId;
    FItem.TagString := ADescricao;
    FItem.Selectable := True;

    FFrame := TFrame_FormaPagto.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbDescricao.Text := ADescricao;
    FFrame.lbDescricao.Tag := AId;
    FFrame.lbClassificacao.Text := AClassificacao;
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

procedure TfrmCad_FormaPagto.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  Listar_Registros(edFiltro.Text);
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);

end;

procedure TfrmCad_FormaPagto.CriandoCombos;
begin

  cComboClassificacao := TCustomCombo.Create(frmCad_FormaPagto);

  {$Region 'Combo Tipo'}
    cComboClassificacao.ItemBackgroundColor := $FF363428;
    cComboClassificacao.ItemFontSize := 15;
    cComboClassificacao.ItemFontColor := $FFA1B24E;

    cComboClassificacao.TitleMenuText := 'Escolha a Classificação';
    cComboClassificacao.TitleFontSize := 17;
    cComboClassificacao.TitleFontColor := $FF363428;

    cComboClassificacao.SubTitleMenuText := 'Você pode mudar sua escolha no futuro';
    cComboClassificacao.SubTitleFontSize := 13;
    cComboClassificacao.SubTitleFontColor := $FF363428;

    cComboClassificacao.BackgroundColor := $FFF2F2F8;
    cComboClassificacao.OnClick := ItemClick_Tipo;

    cComboClassificacao.AddItem('DINHEIRO', 'DINHEIRO');
    cComboClassificacao.AddItem('CREDIARIO', 'CREDIARIO');
    cComboClassificacao.AddItem('BOLETO', 'BOLETO');
    cComboClassificacao.AddItem('PIX', 'PIX');
    cComboClassificacao.AddItem('CARTAO DEBITO', 'CARTAO DEBITO');
    cComboClassificacao.AddItem('CARTAO CREDITO', 'CARTAO CREDITO');
    cComboClassificacao.AddItem('CHEQUE A VISTA', 'CHEQUE A VISTA');
    cComboClassificacao.AddItem('CHEQUE A PRAZO', 'CHEQUE A PRAZO');
  {$EndRegion 'Combo Tipo'}
end;

procedure TfrmCad_FormaPagto.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmCad_FormaPagto);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);
end;

procedure TfrmCad_FormaPagto.edCLASSIFICACAOClick(Sender: TObject);
begin
  cComboClassificacao.ShowMenu;
end;

procedure TfrmCad_FormaPagto.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);

end;

procedure TfrmCad_FormaPagto.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmCad_FormaPagto,'Editando o Registro');
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
    FQuery.Sql.Add('FROM FORMA_PAGAMENTO T ');
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
        edDESCRICAO.Text := FQuery.FieldByName('DESCRICAO').AsString;
        edCLASSIFICACAO.Text := FQuery.FieldByName('CLASSIFICACAO').AsString;
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

procedure TfrmCad_FormaPagto.Excluir(Sender: TObject);
begin
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmCad_FormaPagto.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_FormaPagto,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE FORMA_PAGAMENTO SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmCad_FormaPagto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(cComboClassificacao);
    FreeAndNil(FACBr_Validador);
    FreeAndNil(FMenu_Frame);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    cComboClassificacao.DisposeOf;
    FACBr_Validador.DisposeOf;
    FMenu_Frame.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmCad_FormaPagto := Nil;
end;

procedure TfrmCad_FormaPagto.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FACBr_Validador := TACBr_Validador.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_FormaPagto);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;
end;

procedure TfrmCad_FormaPagto.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_FormaPagto.imbCondicaoPagto_ExcluirClick(Sender: TObject);
begin
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir a Condição de Pagamento','Sim',Excluir_Condica,'Não');
end;

procedure TfrmCad_FormaPagto.Excluir_Condica(Sender :TOBject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_FormaPagto,'Excluindo condição de pagamento');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;

    if FId_Condicao = 0 then
      raise Exception.Create('Condição de Pagamento não selecinada');

    FQuery.Active := False;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('DELETE FROM FORMA_CONDICAO_PAGAMENTO WHERE ID = ' + FId_Condicao.ToString);
    FQuery.ExecSQL;

    {$IFDEF MSWINODWS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}
  end);

  t.OnTerminate := TThreadEnd_Excluir_Condicao;
  t.Start;

end;

procedure TfrmCad_FormaPagto.TThreadEnd_Excluir_Condicao(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Listar_CondicaoPagto;
    FId_Condicao := 0;
  end;
end;

procedure TfrmCad_FormaPagto.imbCondicaoPagto_NovoClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_CondicaoPagto) then
    Application.CreateForm(TfrmCad_CondicaoPagto,frmCad_CondicaoPagto);

  frmCad_CondicaoPagto.Pesquisa := True;
  frmCad_CondicaoPagto.ExecuteOnClose := Sel_Condicao;
  frmCad_CondicaoPagto.Show;
end;

procedure TfrmCad_FormaPagto.Sel_Condicao(AId,ATipoIntervalo,AIntervalo,AParcelas:Integer; ANome:String);
var
  FDQuery :TFDQuery;
begin
  try
    try
      FDQuery := TFDQuery.Create(Nil);
      FDQuery.Connection := FDm_Global.FDC_SQLite;

      if Trim(edID.Text) = '' then
        raise Exception.Create('Não há uma Forma de Pagamento selecionada');

      {$Region 'Verificando se a condição já foi inserido para essa forma de pagamento'}
        FDQuery.Active := False;
        FDQuery.SQL.Clear;
        FDQuery.SQL.Add('SELECT ');
        FDQuery.SQL.Add('  FCP.* ');
        FDQuery.SQL.Add('FROM FORMA_CONDICAO_PAGAMENTO FCP ');
        FDQuery.SQL.Add('WHERE FCP.ID_CONDICAO_PAGAMENTO = ' + AId.ToString);
        FDQuery.SQL.Add('  AND FCP.ID_FORMA_PAGAMENTO = ' +  edID.Text);
        FDQuery.Active := True;
        if not FDQuery.IsEmpty then
          raise Exception.Create('A Condição de Pagamento ' + ANome + ' já foi inserida.');
      {$EndRegion 'Verificando se a condição já foi inserido para essa forma de pagamento'}

      {$Region 'Inserindo'}
        FDQuery.Active := False;
        FDQuery.SQL.Clear;
        FDQuery.SQL.Add('INSERT INTO FORMA_CONDICAO_PAGAMENTO( ');
        FDQuery.SQL.Add('  ID_FORMA_PAGAMENTO ');
        FDQuery.SQL.Add('  ,ID_CONDICAO_PAGAMENTO ');
        FDQuery.SQL.Add('  ,DT_CADASTRO ');
        FDQuery.SQL.Add('  ,HR_CADASTRO ');
        FDQuery.SQL.Add('  ,SINCRONIZADO ');
        FDQuery.SQL.Add('  ,ID_PRINCIPAL ');
        FDQuery.SQL.Add('  ,EXCLUIDO ');
        FDQuery.SQL.Add(') VALUES( ');
        FDQuery.SQL.Add('  :ID_FORMA_PAGAMENTO ');
        FDQuery.SQL.Add('  ,:ID_CONDICAO_PAGAMENTO ');
        FDQuery.SQL.Add('  ,:DT_CADASTRO ');
        FDQuery.SQL.Add('  ,:HR_CADASTRO ');
        FDQuery.SQL.Add('  ,:SINCRONIZADO ');
        FDQuery.SQL.Add('  ,:ID_PRINCIPAL ');
        FDQuery.SQL.Add('  ,:EXCLUIDO ');
        FDQuery.SQL.Add('); ');
        FDQuery.ParamByName('ID_FORMA_PAGAMENTO').AsInteger := edID.Tag;
        FDQuery.ParamByName('ID_CONDICAO_PAGAMENTO').AsInteger := AId;
        FDQuery.ParamByName('DT_CADASTRO').AsDate := Date;
        FDQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        FDQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
        FDQuery.ParamByName('ID_PRINCIPAL').AsInteger := 0;
        FDQuery.ParamByName('EXCLUIDO').AsInteger := 0;
        FDQuery.ExecSQL;
      {$EndRegion 'Inserindo'}

      Listar_CondicaoPagto;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'Ok');
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQuery);
    {$ELSE}
      FDQuery.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TfrmCad_FormaPagto.Listar_CondicaoPagto;
var
  t :TThread;
begin
  TLoading.Show(frmCad_FormaPagto,'Listando Condicoes de Pagamento');
  lbCondicaoPagto.Clear;
  lbCondicaoPagto.BeginUpdate;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('SELECT ');
    FQuery.Sql.Add('  FCP.* ');
    FQuery.Sql.Add('  ,CP.DESCRICAO AS CONDICAO ');
    FQuery.Sql.Add('  ,CP.PARCELAS ');
    FQuery.Sql.Add('  ,CP.TIPO_INTERVALO ');
    FQuery.Sql.Add('  ,CASE CP.TIPO_INTERVALO ');
    FQuery.Sql.Add('     WHEN 0 THEN ''DIAS'' ');
    FQuery.Sql.Add('     WHEN 1 THEN ''MESES'' ');
    FQuery.Sql.Add('   END TIPO_INTERVALO_DESC ');
    FQuery.Sql.Add('  ,CP.INTEVALOR ');
    FQuery.Sql.Add('  ,FP.DESCRICAO AS FORMA ');
    FQuery.Sql.Add('FROM FORMA_CONDICAO_PAGAMENTO FCP ');
    FQuery.Sql.Add('  JOIN CONDICAO_PAGAMENTO CP ON CP.ID = FCP.ID_CONDICAO_PAGAMENTO ');
    FQuery.Sql.Add('  JOIN FORMA_PAGAMENTO FP ON FP.ID = FCP.ID_FORMA_PAGAMENTO ');
    FQuery.Sql.Add('WHERE FCP.EXCLUIDO = 0');
    FQuery.Sql.Add('  AND FCP.ID_FORMA_PAGAMENTO = ' + edID.Text);
    FQuery.Active := True;
    if not FQuery.IsEmpty then
    begin
      FQuery.First;
      while not FQuery.Eof do
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          AddRegistrosCP_LB(
            FQuery.FieldByName('ID').AsInteger
            ,FQuery.FieldByName('PARCELAS').AsInteger
            ,FQuery.FieldByName('TIPO_INTERVALO').AsInteger
            ,FQuery.FieldByName('INTEVALOR').AsInteger
            ,FQuery.FieldByName('CONDICAO').AsString
            ,FQuery.FieldByName('TIPO_INTERVALO_DESC').AsString
          );
        end);
        FQuery.Next;
      end;
    end;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbCondicaoPagto.EndUpdate;
    end);

    if Assigned(FQuery) then
      FreeAndNil(FQuery);

  end);

  t.OnTerminate := TThreadEnd_Listar_RegistrosCP;
  t.Start;
end;

procedure TfrmCad_FormaPagto.TThreadEnd_Listar_RegistrosCP(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmCad_FormaPagto.AddRegistrosCP_LB(AId,AParcelas,ATipoIntervalo,AIntervalo: Integer; ADescricao, ATipoIntervalo_Desc: String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_CondFormaPagto;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 35;
    FItem.Tag := AId;
    FItem.TagString := ADescricao;
    FItem.Selectable := True;

    FFrame := TFrame_CondFormaPagto.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbNome.Text := ADescricao;
    FFrame.lbNome.Tag := AId;
    FFrame.lbInfPagto.Text := 'P: '+AParcelas.ToString+' - TI: '+ATipoIntervalo_Desc+' - I: ' + AIntervalo.ToString;

    lbCondicaoPagto.AddObject(FItem);

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmCad_FormaPagto.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      rctCondicaoPagto.Enabled := False;
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

procedure TfrmCad_FormaPagto.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
  Listar_Registros(edFiltro.Text)
end;

procedure TfrmCad_FormaPagto.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FDescricao,FClassificacao);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

{$IFDEF MSWINDOWS}
procedure TfrmCad_FormaPagto.ItemClick_Tipo(Sender: TObject);
begin
  cComboClassificacao.HideMenu;
  edCLASSIFICACAO.Text := cComboClassificacao.DescrItem;
end;
{$ELSE}
procedure TfrmCad_FormaPagto.ItemClick_Tipo(Sender: TObject; const Point: TPointF);
begin
  cComboClassificacao.HideMenu;
  edCLASSIFICACAO.Text := cComboClassificacao.DescrItem;
end;
{$ENDIF}

procedure TfrmCad_FormaPagto.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edCLASSIFICACAO.Text := '';
  edDESCRICAO.Text := '';
end;

procedure TfrmCad_FormaPagto.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmCad_FormaPagto,'Listando Registros');
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
    FQuery.Sql.Add('FROM FORMA_PAGAMENTO T ');
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
            ,FQuery.FieldByName('DESCRICAO').AsString
            ,FQuery.FieldByName('CLASSIFICACAO').AsString
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

procedure TfrmCad_FormaPagto.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_FormaPagto,'Salvando alterações');

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
      FQuery.Sql.Add('INSERT INTO FORMA_PAGAMENTO( ');
      FQuery.Sql.Add('  DESCRICAO ');
      FQuery.Sql.Add('  ,CLASSIFICACAO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :DESCRICAO ');
      FQuery.Sql.Add('  ,:CLASSIFICACAO ');
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
      FQuery.Sql.Add('UPDATE FORMA_PAGAMENTO SET ');
      FQuery.Sql.Add('  DESCRICAO = :DESCRICAO ');
      FQuery.Sql.Add('  ,CLASSIFICACAO = :CLASSIFICACAO');
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('DESCRICAO').AsString := edDESCRICAO.Text;
    FQuery.ParamByName('CLASSIFICACAO').AsString := edCLASSIFICACAO.Text;
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

procedure TfrmCad_FormaPagto.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_FormaPagto.TThreadEnd_Editar(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FTab_Status := dsEdit;
    FId_Condicao := 0;
    rctCondicaoPagto.Enabled := True;
    lbCondicaoPagto.Clear;
    Listar_CondicaoPagto;
    imgAcao_01.Tag := 1;
    imgAcao_01.Bitmap := imgSalvar.Bitmap;
    tcPrincipal.GotoVisibleTab(1);
  end;
end;

procedure TfrmCad_FormaPagto.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_FormaPagto.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);

end;

procedure TfrmCad_FormaPagto.TTHreadEnd_Salvar(Sender: TOBject);
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

procedure TfrmCad_FormaPagto.lbCondicaoPagtoItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FId_Condicao := Item.Tag;
  FDescricao_Condicao := Item.Text;
end;

procedure TfrmCad_FormaPagto.lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FDescricao := Item.TagString;
end;

end.
