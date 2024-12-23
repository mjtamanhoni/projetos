unit uMov.Financeiro;

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
    uFrame.SPData,
    uFrame.SPDados,
    uFrame.SPTotais,
  {$EndRegion 'Frames'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,FMX.ListBox,
  FMX.ListView, FMX.TabControl, FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Calendar;

type
  TExecuteOnClose = procedure(AId:Integer) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmMov_Financeiro = class(TForm)
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
    tcCampos: TTabControl;
    tiCampos_001: TTabItem;
    lytCampos_001: TLayout;
    lytRow_C01_001: TLayout;
    lytID: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytSTATUS: TLayout;
    lbSTATUS: TLabel;
    edSTATUS: TEdit;
    imgSTATUS: TImage;
    lytDATA: TLayout;
    lbDATA: TLabel;
    edDATA: TEdit;
    imgDATA: TImage;
    lytRow_Navegar_01: TLayout;
    imgAvancar_001: TImage;
    tiCampos_002: TTabItem;
    lytCampos_002: TLayout;
    lytRow_Navegar_02: TLayout;
    imgRetornar_001: TImage;
    lytRow_C01_002: TLayout;
    lytID_EMPRESA: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_C01_003: TLayout;
    lytID_CONTA: TLayout;
    lbID_CONTA: TLabel;
    edID_CONTA: TEdit;
    imgID_CONTA: TImage;
    lytRow_C01_005: TLayout;
    lytFormaCond_Pagto: TLayout;
    lbFormaCond_Pagto: TLabel;
    edFORMA_PAGTO_ID: TEdit;
    imgFORMA_PAGTO_ID: TImage;
    lytRow_C01_004: TLayout;
    lytID_PESSOA: TLayout;
    lbID_PESSOA: TLabel;
    edID_PESSOA: TEdit;
    imgID_PESSOA: TImage;
    lytRow_C02_002: TLayout;
    lytDESCONTO_BAIXA: TLayout;
    lbDESCONTO_BAIXA: TLabel;
    edDESCONTO_BAIXA: TEdit;
    lytJUROS_BAIXA: TLayout;
    lbJUROS_BAIXA: TLabel;
    edJUROS_BAIXA: TEdit;
    lytRow_C02_003: TLayout;
    lytOBSERVACAO: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_C02_001: TLayout;
    lytVALOR_BAIXA: TLayout;
    lbVALOR_BAIXA: TLabel;
    edVALOR_BAIXA: TEdit;
    lytDT_BAIXA: TLayout;
    lbDT_BAIXA: TLabel;
    edDT_BAIXA: TEdit;
    imgDT_BAIXA: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    rctCalendario_Tampa: TRectangle;
    rctCalendario: TRectangle;
    ShadowEffect2: TShadowEffect;
    lytCalendario_Header: TLayout;
    rctCalendario_Header: TRectangle;
    lbCalendario_Titulo: TLabel;
    imgCalendario_Cancelar: TImage;
    lytCalendario_Detail: TLayout;
    rctCalendario_Detail: TRectangle;
    Calendar: TCalendar;
    lytCalendario_Footer: TLayout;
    rctCalendario_Footer: TRectangle;
    lytRow_C01_006: TLayout;
    lytVALOR: TLayout;
    lbVALOR: TLabel;
    edVALOR: TEdit;
    lytDT_VENCIMENTO: TLayout;
    lbDT_VENCIMENTO: TLabel;
    edDT_VENCIMENTO: TEdit;
    imgDT_VENCIMENTO: TImage;
    edCOND_PAGTO_ID: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure imgRetornar_001Click(Sender: TObject);
    procedure imgAvancar_001Click(Sender: TObject);
    procedure imgDATAClick(Sender: TObject);
  private
    FDataRetorno :Integer;
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    cComboStatus :TCustomCombo;
    FMenu_Frame :TActionSheet;
    FValor_Hora :Double;
    FEdidanto :Boolean;

    FId :Integer;
    FDescricao :String;

    FACBr_Validador :TACBr_Validador;
    FPesquisa: Boolean;

    {$IFDEF MSWINDOWS}
      procedure ItemClick_Status(Sender: TObject);
    {$ELSE}
      procedure ItemClick_Status(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    procedure LimparCampos;
    procedure Salvar;
    procedure TTHreadEnd_Salvar(Sender: TOBject);
    procedure Cancelar(Sender: TOBject);
    procedure CriandoCombos;
    procedure Listar_Registros(APesquisa:String);
    procedure AddRegistros_LB(
      AId,ASincronizado,AExcluido,AStatus:Integer;
      ACliente,AConta,AHora_I,AHora_F,AHora_T,ADescricao:String;
      AValor,ATotal:Double);
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure AddRegistros_LB_Header(AData:TDate);
    procedure AddRegistros_LB_Footer(ATotal:Double);
    procedure Abre_Menu_Registros(Sender :TOBject);
    procedure CriandoMenus;
    procedure Editar(Sender: TOBject);
    procedure TThreadEnd_Editar(Sender: TOBject);
    procedure Excluir(Sender: TObject);
    procedure Excluir_Registro(Sender: TObject);
    procedure TThreadEnd_ExcluirRegistro(Sender: TOBject);

    procedure SetPesquisa(const Value: Boolean);

  public
    ExecuteOnClose :TExecuteOnClose;
    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmMov_Financeiro: TfrmMov_Financeiro;

implementation

{$R *.fmx}

{$IFDEF MSWINDOWS}
procedure ItemClick_Status(Sender: TObject);
begin
  cComboStatus.HideMenu;
  edSTATUS.Text := cComboStatus.DescrItem;
  edSTATUS.Tag := StrToIntDef(cComboStatus.CodItem,0);
end
{$ELSE}
procedure TfrmMov_Financeiro.ItemClick_Status(Sender: TObject; const Point: TPointF);
begin
  cComboStatus.HideMenu;
  edSTATUS.Text := cComboStatus.DescrItem;
  edSTATUS.Tag := StrToIntDef(cComboStatus.CodItem,0);
end;
{$ENDIF}

procedure TfrmMov_Financeiro.Abre_Menu_Registros(Sender: TOBject);
begin

end;

procedure TfrmMov_Financeiro.AddRegistros_LB(AId, ASincronizado, AExcluido, AStatus: Integer; ACliente,
  AConta, AHora_I, AHora_F, AHora_T, ADescricao: String; AValor, ATotal: Double);
begin

end;

procedure TfrmMov_Financeiro.AddRegistros_LB_Footer(ATotal: Double);
begin

end;

procedure TfrmMov_Financeiro.AddRegistros_LB_Header(AData: TDate);
begin

end;

procedure TfrmMov_Financeiro.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmMov_Financeiro.CriandoCombos;
begin

  cComboStatus := TCustomCombo.Create(frmMov_Financeiro);

  {$Region 'Combo Status'}
    cComboStatus.ItemBackgroundColor := $FF363428;
    cComboStatus.ItemFontSize := 15;
    cComboStatus.ItemFontColor := $FFA1B24E;

    cComboStatus.TitleMenuText := 'Escolha o Status';
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

procedure TfrmMov_Financeiro.CriandoMenus;
begin

end;

procedure TfrmMov_Financeiro.Editar(Sender: TOBject);
begin

end;

procedure TfrmMov_Financeiro.Excluir(Sender: TObject);
begin

end;

procedure TfrmMov_Financeiro.Excluir_Registro(Sender: TObject);
begin

end;

procedure TfrmMov_Financeiro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(cComboStatus);
    FreeAndNil(FACBr_Validador);
    FreeAndNil(FMenu_Frame);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    cComboStatus.DisposeOf;
    FACBr_Validador.DisposeOf;
    FMenu_Frame.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmMov_Financeiro := Nil;

end;

procedure TfrmMov_Financeiro.FormCreate(Sender: TObject);
begin
  tcCampos.Margins.Bottom := 0;

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FACBr_Validador := TACBr_Validador.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmMov_ServicosPrestados);
  CriandoCombos;
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;
  tcCampos.ActiveTab := tiCampos_001;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Pesquisa := False;
  FEdidanto := False;

end;

procedure TfrmMov_Financeiro.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmMov_Financeiro.imgAvancar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(1);
end;

procedure TfrmMov_Financeiro.imgDATAClick(Sender: TObject);
begin
  rctCalendario_Tampa.Align := TAlignLayout.Contents;
  FDataRetorno := TImage(Sender).Tag;
  Calendar.Date := Date;
  rctCalendario_Tampa.Visible := True;
end;

procedure TfrmMov_Financeiro.imgRetornar_001Click(Sender: TObject);
begin
  tcCampos.GotoVisibleTab(0);
end;

procedure TfrmMov_Financeiro.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

procedure TfrmMov_Financeiro.LimparCampos;
begin
  edID.Tag := 0;
  edID.Text := '';
  edDATA.Text := '';
  edSTATUS.Tag := -1;
  edSTATUS.Text := '';
  edID_EMPRESA.Tag := 0;
  edID_EMPRESA.Text := '';
  edID_CONTA.Tag := 0;
  edID_CONTA.Text := '';
  edID_PESSOA.Tag := 0;
  edID_PESSOA.Text := '';
  edFORMA_PAGTO_ID.Tag := 0;
  edFORMA_PAGTO_ID.Text := '';
  edCOND_PAGTO_ID.Tag := 0;
  edCOND_PAGTO_ID.Text := '';
  edDT_VENCIMENTO.Text := '';
  edVALOR.TagFloat := 0;
  edVALOR.Text := '';
  edDT_BAIXA.Text := '';
  edDESCONTO_BAIXA.TagFloat := 0;
  edDESCONTO_BAIXA.Text := '';
  edJUROS_BAIXA.TagFloat := 0;
  edJUROS_BAIXA.Text := '';
  edVALOR_BAIXA.TagFloat := 0;
  edVALOR_BAIXA.Text := '';
  edOBSERVACAO.Text := '';
end;

procedure TfrmMov_Financeiro.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin

  TLoading.Show(frmMov_Financeiro,'Listando Registros');
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
    FQuery.Sql.Add('SELECT ');
    FQuery.Sql.Add('  L.* ');
    FQuery.Sql.Add('  ,E.NOME AS EMPRESA ');
    FQuery.Sql.Add('  ,C.DESCRICAO AS CONTA ');
    FQuery.Sql.Add('  ,C.TIPO AS TIPO_CONTA ');
    FQuery.Sql.Add('  ,CASE C.TIPO ');
    FQuery.Sql.Add('    WHEN 0 THEN CL.NOME ');
    FQuery.Sql.Add('    WHEN 1 THEN F.NOME ');
    FQuery.Sql.Add('  END PESSOA ');
    FQuery.Sql.Add('  ,CASE L.STATUS ');
    FQuery.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''ATVO'' ');
    FQuery.Sql.Add('  END STATUS_DESC ');
    FQuery.Sql.Add('  ,FP.DESCRICAO AS FORMA_PAGTO ');
    FQuery.Sql.Add('  ,FP.CLASSIFICACAO AS CLASS_FORMA ');
    FQuery.Sql.Add('  ,CP.DESCRICAO AS COND_PAGTO ');
    FQuery.Sql.Add('  ,CP.PARCELAS ');
    FQuery.Sql.Add('  ,CP.TIPO_INTERVALO ');
    FQuery.Sql.Add('  ,CASE CP.TIPO_INTERVALO ');
    FQuery.Sql.Add('    WHEN 0 THEN ''DIAS'' ');
    FQuery.Sql.Add('    WHEN 1 THEN ''MESES'' ');
    FQuery.Sql.Add('  END TIPO_INTERVALO_DESC ');
    FQuery.Sql.Add('  ,CP.INTEVALOR ');
    FQuery.Sql.Add('FROM LANCAMENTOS L ');
    FQuery.Sql.Add('  JOIN EMPRESA E ON E.ID = L.ID_EMPRESA ');
    FQuery.Sql.Add('  JOIN CONTA C ON C.ID = L.ID_CONTA ');
    FQuery.Sql.Add('  LEFT JOIN CLIENTE CL ON CL.ID = L.ID_PESSOA ');
    FQuery.Sql.Add('  LEFT JOIN FORNECEDOR F ON F.ID = L.ID_PESSOA ');
    FQuery.Sql.Add('  JOIN FORMA_PAGAMENTO FP ON FP.ID = L.FORMA_PAGTO_ID ');
    FQuery.Sql.Add('  JOIN CONDICAO_PAGAMENTO CP ON CP.ID = L.COND_PAGTO_ID ');
    FQuery.Sql.Add('WHERE NOT L.ID IS NULL ');
    FQuery.Sql.Add('ORDER BY ');
    FQuery.Sql.Add('  L.ID_EMPRESA; ');
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
            ,FQuery.FieldByName('STATUS').AsInteger
            ,FQuery.FieldByName('CLIENTE').AsString
            ,FQuery.FieldByName('CONTA_NOME').AsString
            ,FQuery.FieldByName('HR_INICIO').AsString
            ,FQuery.FieldByName('HR_FIM').AsString
            ,FQuery.FieldByName('HR_TOTAL').AsString
            ,FQuery.FieldByName('DESCRICAO').AsString
            ,FQuery.FieldByName('VLR_HORA').AsFloat
            ,FQuery.FieldByName('TOTAL').AsFloat
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

procedure TfrmMov_Financeiro.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmMov_Financeiro,'Salvando alterações');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
    FId :Integer;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;

    FQuery.Active := False;
    FQuery.SQL.Clear;
    FQuery.SQL.Add('SELECT GEN_ID(GEN_LANCAMENTOS_ID,1) AS SEQ FROM RDB$DATABASE;');
    FQuery.Active := True;
    if not FQuery.IsEmpty then
      FId := FQuery.FieldByName('SEQ').AsInteger;

    FQuery.Active := False;
    FQuery.Sql.Clear;

    if FTab_Status = dsInsert then
    begin
      FQuery.Sql.Add('INSERT INTO LANCAMENTOS( ');
      FQuery.Sql.Add('  ID ');
      FQuery.Sql.Add('  ,ID_EMPRESA ');
      FQuery.Sql.Add('  ,DT_EMISSAO ');
      FQuery.Sql.Add('  ,ID_CONTA ');
      FQuery.Sql.Add('  ,ID_PESSOA ');
      FQuery.Sql.Add('  ,FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,VALOR ');
      FQuery.Sql.Add('  ,ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,ID_ORIGEM_LANCAMENTO ');
      if Trim(edDT_BAIXA.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,DT_BAIXA ');
        FQuery.Sql.Add('  ,HR_BAIXA ');
        FQuery.Sql.Add('  ,ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,JUROS_BAIXA ');
        FQuery.Sql.Add('  ,VALOR_BAIXA ');
      end;
      FQuery.Sql.Add('  ,ID_USUARIO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,OBSERVACAO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :ID ');
      FQuery.Sql.Add('  ,:ID_EMPRESA ');
      FQuery.Sql.Add('  ,:DT_EMISSAO ');
      FQuery.Sql.Add('  ,:ID_CONTA ');
      FQuery.Sql.Add('  ,:ID_PESSOA ');
      FQuery.Sql.Add('  ,:STATUS ');
      FQuery.Sql.Add('  ,:FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,:COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,:DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,:VALOR ');
      FQuery.Sql.Add('  ,:ORIGEM_LANCAMENTO ');
      FQuery.Sql.Add('  ,:ID_ORIGEM_LANCAMENTO ');
      if Trim(edDT_BAIXA.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,:DT_BAIXA ');
        FQuery.Sql.Add('  ,:HR_BAIXA ');
        FQuery.Sql.Add('  ,:ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,:DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,:JUROS_BAIXA ');
        FQuery.Sql.Add('  ,:VALOR_BAIXA ');
      end;
      FQuery.Sql.Add('  ,:ID_USUARIO ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('  ,:OBSERVACAO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
      FQuery.ParamByName('ID_PRINCIPAL').AsInteger := 0;
      FQuery.ParamByName('ID_USUARIO').AsInteger := frmPrincipal.FUser_Id;
      FQuery.ParamByName('EXCLUIDO').AsInteger := 0;
      FQuery.ParamByName('ORIGEM_LANCAMENTO').AsString := 'PROPRIO';
      FQuery.ParamByName('ID_ORIGEM_LANCAMENTO').AsString := FId;
    end
    else if FTab_Status = dsEdit then
    begin
      FQuery.Sql.Add('UPDATE LANCAMENTOS SET ');
      FQuery.Sql.Add('  ID_EMPRESA = :ID_EMPRESA ');
      FQuery.Sql.Add('  ,DT_EMISSAO = :DT_EMISSAO ');
      FQuery.Sql.Add('  ,ID_CONTA = :ID_CONTA ');
      FQuery.Sql.Add('  ,ID_PESSOA = :ID_PESSOA ');
      FQuery.Sql.Add('  ,STATUS = :STATUS ');
      FQuery.Sql.Add('  ,FORMA_PAGTO_ID = :FORMA_PAGTO_ID ');
      FQuery.Sql.Add('  ,COND_PAGTO_ID = :COND_PAGTO_ID ');
      FQuery.Sql.Add('  ,DT_VENCIMENTO = :DT_VENCIMENTO ');
      FQuery.Sql.Add('  ,VALOR = :VALOR ');
      if Trim(edDT_BAIXA.Text) <> '' then
      begin
        FQuery.Sql.Add('  ,DT_BAIXA = :DT_BAIXA ');
        FQuery.Sql.Add('  ,HR_BAIXA = :HR_BAIXA ');
        FQuery.Sql.Add('  ,ID_USUARIO_BAIXA = :ID_USUARIO_BAIXA ');
        FQuery.Sql.Add('  ,DESCONTO_BAIXA = :DESCONTO_BAIXA ');
        FQuery.Sql.Add('  ,JUROS_BAIXA = :JUROS_BAIXA ');
        FQuery.Sql.Add('  ,VALOR_BAIXA = :VALOR_BAIXA ');
      end;
      FQuery.Sql.Add('  ,ID_USUARIO = :ID_USUARIO ');
      FQuery.Sql.Add('  ,DT_CADASTRO = :DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO = :HR_CADASTRO ');
      FQuery.Sql.Add('  ,OBSERVACAO = :OBSERVACAO ');
      FQuery.Sql.Add('  ,SINCRONIZADO = :SINCRONIZADO');
      FQuery.Sql.Add('  ,ID_PRINCIPAL = :ID_PRINCIPAL');
      FQuery.Sql.Add('  ,EXCLUIDO = :EXCLUIDO');
      FQuery.Sql.Add('WHERE ID = :ID; ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('ID_EMPRESA').AsInteger := edID_EMPRESA.Tag;
    FQuery.ParamByName('DT_EMISSAO').AsDate := StrToDate(edDATA.Text);
    FQuery.ParamByName('ID_CONTA').AsInteger := edID_CONTA.Tag;
    FQuery.ParamByName('ID_PESSOA').AsInteger := edID_PESSOA.Tag;
    FQuery.ParamByName('STATUS').AsInteger := edSTATUS.Tag;
    FQuery.ParamByName('FORMA_PAGTO_ID').AsInteger := edFORMA_PAGTO_ID.Tag;
    FQuery.ParamByName('COND_PAGTO_ID').AsInteger := edCOND_PAGTO_ID.Tag;
    FQuery.ParamByName('DT_VENCIMENTO').AsDate := StrToDate(edDT_VENCIMENTO.Text);
    FQuery.ParamByName('VALOR').AsFloat := edVALOR.TagFloat;
    if Trim(edDT_BAIXA.Text) <> '' then
    begin
      FQuery.ParamByName('DT_BAIXA').AsDate := StrToDate(edDT_BAIXA.Text);
      FQuery.ParamByName('HR_BAIXA').AsTime := Time;
      FQuery.ParamByName('ID_USUARIO_BAIXA').AsInteger := frmPrincipal.FUser_Id;
      FQuery.ParamByName('DESCONTO_BAIXA').AsFloat := edDESCONTO_BAIXA.TagFloat;
      FQuery.ParamByName('JUROS_BAIXA').AsFloat := edJUROS_BAIXA.TagFloat;
      FQuery.ParamByName('VALOR_BAIXA').AsFloat := edVALOR_BAIXA.TagFloat;
    end;
    FQuery.ParamByName('OBSERVACAO').AsString := edOBSERVACAO.Text;
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

procedure TfrmMov_Financeiro.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmMov_Financeiro.TThreadEnd_Editar(Sender: TOBject);
begin

end;

procedure TfrmMov_Financeiro.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin

end;

procedure TfrmMov_Financeiro.TThreadEnd_Listar_Registros(Sender: TObject);
begin

end;

procedure TfrmMov_Financeiro.TTHreadEnd_Salvar(Sender: TOBject);
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
