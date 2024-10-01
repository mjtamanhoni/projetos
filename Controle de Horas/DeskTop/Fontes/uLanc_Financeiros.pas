unit uLanc_Financeiros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uFuncoes,


  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects,
  FMX.dxGrid, FMX.Layouts, FMX.Ani, FMX.ListBox, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization,
  FMX.Edit, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmLanc_Financeiros = class(TForm)
    OpenDialog: TOpenDialog;
    DSRegistros: TDataSource;
    FDQRegistros: TFDQuery;
    imgEsconteSenha: TImage;
    imgExibeSenha: TImage;
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctIncluir: TRectangle;
    imgIncluir: TImage;
    rctEditar: TRectangle;
    imgEditar: TImage;
    rctSalvar: TRectangle;
    imgSalvar: TImage;
    rctCancelar: TRectangle;
    imgCancelar: TImage;
    rctExcluir: TRectangle;
    imgExcluir: TImage;
    rctPagamento: TRectangle;
    imPagamento: TImage;
    rctTot_Receber: TRectangle;
    lbTot_Receber_Tit: TLabel;
    lbTot_Receber: TLabel;
    rctTot_Pagar: TRectangle;
    lbTot_Pagar_Tit: TLabel;
    lbTot_Pagar: TLabel;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    lytFiltro_Periodo: TLayout;
    rctFiltro_Periodo: TRectangle;
    lbFiltro_Periodo_Tit: TLabel;
    lbFiltro_Data_A: TLabel;
    edFIltro_Dt_I: TEdit;
    edFIltro_Dt_F: TEdit;
    lytFiltro_Empresa: TLayout;
    rctFiltro_Empresa: TRectangle;
    lytFiltro_Empresa_Tit: TLabel;
    edFiltro_Empresa_ID: TEdit;
    imgFiltro_Empresa: TImage;
    edFiltro_Empresa: TEdit;
    lytFiltro_TipoStatus: TLayout;
    rctFiltro_TipoStatus: TRectangle;
    lytFiltro_Cliente: TLayout;
    rctFiltro_Cliente: TRectangle;
    edFiltro_Cliente: TEdit;
    edFiltro_Cliente_ID: TEdit;
    imgFiltro_Cliente: TImage;
    lytLista: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    tiCadastro: TTabItem;
    lytCadastro: TLayout;
    lytRow_001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbSTATUS: TLabel;
    edSTATUS: TComboBox;
    lbDATA: TLabel;
    edDATA: TEdit;
    lytRow_002: TLayout;
    lbDESCRICAO: TLabel;
    edDESCRICAO: TEdit;
    lytRow_003: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA_Desc: TEdit;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytRow_004: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO_Desc: TEdit;
    edID_PRESTADOR_SERVICO: TEdit;
    imgID_PRESTADOR_SERVICO: TImage;
    lytRow_005: TLayout;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE_Desc: TEdit;
    edID_CLIENTE: TEdit;
    imgID_CLIENTE: TImage;
    lytRow_006: TLayout;
    lbID_TABELA: TLabel;
    edID_TABELA_Desc: TEdit;
    edID_TABELA: TEdit;
    imgID_TABELA: TImage;
    edID_TABELA_Valor: TEdit;
    edID_TABELA_Tipo: TEdit;
    lytRow_007: TLayout;
    lbHR_INICIO: TLabel;
    edHR_INICIO: TEdit;
    edHR_FIM: TEdit;
    lbHR_FIM: TLabel;
    edHR_TOTAL: TEdit;
    lbHR_TOTAL: TLabel;
    lbVLR_HORA: TLabel;
    edVLR_HORA: TEdit;
    lytRow_008: TLayout;
    lbSUB_TOTAL: TLabel;
    edSUB_TOTAL: TEdit;
    lbDESCONTO: TLabel;
    edDESCONTO: TEdit;
    lbACRESCIMO: TLabel;
    edACRESCIMO: TEdit;
    lbTOTAL: TLabel;
    edTOTAL: TEdit;
    lytRow_009: TLayout;
    lbOBSERVACAO: TLabel;
    edOBSERVACAO: TEdit;
    lytRow_010: TLayout;
    lbDT_PAGO: TLabel;
    edDT_PAGO: TEdit;
    lbVLR_PAGO: TLabel;
    edVLR_PAGO: TEdit;
    rctMenu_Tampa: TRectangle;
    rctMenu: TRectangle;
    lytMenu_Titulo: TLayout;
    lbMenu_Titulo: TLabel;
    imgMenuFechar: TImage;
    faMenu: TFloatAnimation;
    rctMenu_BaixarHoras: TRectangle;
    lbMenu_BaixarHoras: TLabel;
    rctFecharMes: TRectangle;
    lbFecharMes: TLabel;
    rctMenuBaixar_Horas: TRectangle;
    rctBH_Detail: TRectangle;
    ShadowEffect1: TShadowEffect;
    rctBH_Header: TRectangle;
    lbBH_Titulo: TLabel;
    lytBH_ValorPago: TLayout;
    edBH_ValorPago: TEdit;
    lytBH_Data: TLayout;
    edBH_Data: TEdit;
    lytBH_TotalHoras: TLayout;
    lbBH_TotalHoras: TLabel;
    lytBH_Footer: TLayout;
    gplBH_Footer: TGridPanelLayout;
    rctBH_Confirmar: TRectangle;
    imgBH_Confirmar: TImage;
    rctBH_Cancelar: TRectangle;
    imgBH_Cancelar: TImage;
    lytBH_Cliente: TLayout;
    edBH_Cliente: TEdit;
    imgBH_Cliente: TImage;
    lbBH_Cliente: TLabel;
    rctTot_Saldo: TRectangle;
    lbTot_Saldo_Tit: TLabel;
    lbTot_Saldo: TLabel;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosID_EMPRESA: TIntegerField;
    FDQRegistrosDT_EMISSAO: TDateField;
    FDQRegistrosID_CONTA: TIntegerField;
    FDQRegistrosID_PESSOA: TIntegerField;
    FDQRegistrosSTATUS: TIntegerField;
    FDQRegistrosDT_VENCIMENTO: TDateField;
    FDQRegistrosVALOR: TFMTBCDField;
    FDQRegistrosDT_PAGAMENTO: TDateField;
    FDQRegistrosDESCONTO: TFMTBCDField;
    FDQRegistrosJUROS: TFMTBCDField;
    FDQRegistrosVALOR_PAGO: TFMTBCDField;
    FDQRegistrosORIGEM_LANCAMENTO: TStringField;
    FDQRegistrosID_ORIGEM_LANCAMENTO: TIntegerField;
    FDQRegistrosID_USUARIO: TIntegerField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosOBSERVACAO: TStringField;
    FDQRegistrosEMPRESA: TStringField;
    FDQRegistrosCONTA: TStringField;
    FDQRegistrosTIPO_CONTA: TIntegerField;
    FDQRegistrosTIPO_CONTA_DESC: TStringField;
    FDQRegistrosPESSOA: TStringField;
    FDQRegistrosSTATUS_DESC: TStringField;
    FDQRegistrosUSUARIO: TStringField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_EMISSAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_VENCIMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_PAGAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DESCONTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1JUROS: TdxfmGridColumn;
    dxfmGrid1RootLevel1VALOR_PAGO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ORIGEM_LANCAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_ORIGEM_LANCAMENTO: TdxfmGridColumn;
    dxfmGrid1RootLevel1ID_USUARIO: TdxfmGridColumn;
    dxfmGrid1RootLevel1DT_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1HR_CADASTRO: TdxfmGridColumn;
    dxfmGrid1RootLevel1OBSERVACAO: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMPRESA: TdxfmGridColumn;
    dxfmGrid1RootLevel1CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_CONTA: TdxfmGridColumn;
    dxfmGrid1RootLevel1TIPO_CONTA_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1PESSOA: TdxfmGridColumn;
    dxfmGrid1RootLevel1STATUS_DESC: TdxfmGridColumn;
    dxfmGrid1RootLevel1USUARIO: TdxfmGridColumn;
    imgFiltro_Aberto: TImage;
    imgChecked: TImage;
    imgUnChecked: TImage;
    lbFiltro_Aberto: TLabel;
    imgFiltro_Pago: TImage;
    lbFiltroPessoa: TLabel;
    cbFiltro_Tipo_Periodo: TComboBox;
    lbFiltro_Pago: TLabel;
    lbFiltro_TipoStatus: TLabel;
    lytFiltro_Tipo_DC: TLayout;
    rctFiltro_Tipo_DC: TRectangle;
    lbFIltro_Tipo_DC: TLabel;
    cbFiltro_Tipo_DC: TComboBox;
    procedure imgFiltro_ClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edFiltro_Cliente_IDChange(Sender: TObject);
    procedure imgFiltro_AbertoClick(Sender: TObject);
    procedure imgFiltro_PagoClick(Sender: TObject);
    procedure imgFiltro_EmpresaClick(Sender: TObject);
    procedure cbFiltro_Tipo_DCChange(Sender: TObject);
    procedure cbFiltro_Tipo_PeriodoChange(Sender: TObject);
    procedure edFIltro_Dt_IChange(Sender: TObject);
    procedure edFIltro_Dt_FChange(Sender: TObject);
    procedure edFiltro_Empresa_IDChange(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;

    procedure Sel_Pessoa(ATipo:String; Aid:Integer; ANome:String; ADocumento:String);
    procedure Sel_Empresa(Aid: Integer; ANome: String);
    procedure Configura_Botoes;
    procedure Selecionar_Registros;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLanc_Financeiros: TfrmLanc_Financeiros;

implementation

{$R *.fmx}

uses
  uPesq_Pessoas
  ,uCad.Empresa;

procedure TfrmLanc_Financeiros.edFiltro_Cliente_IDChange(Sender: TObject);
begin
  if Trim(edFiltro_Cliente_ID.Text) = '' then
  begin
    edFiltro_Cliente.Text := '';
    lbFiltroPessoa.Tag := -1;
    lbFiltroPessoa.Text := 'Pessoa';
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_FChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFIltro_Dt_IChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.edFiltro_Empresa_IDChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.CaFree;
  frmLanc_Financeiros := Nil;
end;

procedure TfrmLanc_Financeiros.FormCreate(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  lytFormulario.Align := TAlignLayout.Center;
  try
    FDm_Global := TDM_Global.Create(Nil);
    FDQRegistros.Connection := FDm_Global.FDC_Firebird;

    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_Firebird;

    with TFuncoes.Datas(Date) do
    begin
      edFIltro_Dt_I.Text := DateToStr(PrimeiroDia);
      edFIltro_Dt_F.Text := DateToStr(UltimoDia);
    end;
    if frmPrincipal.FUser_Empresa > 0 then
    begin
      edFiltro_Empresa_ID.Text := IntToStr(frmPrincipal.FUser_Empresa);
      FDm_Global.Listar_Empresa(frmPrincipal.FUser_Empresa,'',FQuery);
      if not FQuery.IsEmpty then
        edFiltro_Empresa.Text := FQuery.FieldByName('NOME').AsString;
    end;

    FFancyDialog := TFancyDialog.Create(frmLanc_Financeiros);
    FEnder := '';
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
    FIniFile := TIniFile.Create(FEnder);

    tcPrincipal.ActiveTab := tiLista;

    Selecionar_Registros;
    Configura_Botoes;

    rctMenu.Width := 0;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmLanc_Financeiros.Selecionar_Registros;
var
  FDQ_Total :TFDQuery;
begin
  try
    try
      FDQ_Total := TFDQuery.Create(Nil);
      FDQ_Total.Connection := FDm_Global.FDC_Firebird;

      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  L.* ');
      FDQRegistros.SQL.Add('  ,E.NOME AS EMPRESA ');
      FDQRegistros.SQL.Add('  ,C.DESCRICAO AS CONTA ');
      FDQRegistros.SQL.Add('  ,C.TIPO AS TIPO_CONTA ');
      FDQRegistros.SQL.Add('  ,CASE C.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''CRÉDITO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''DÉBITO'' ');
      FDQRegistros.SQL.Add('  END TIPO_CONTA_DESC ');
      FDQRegistros.SQL.Add('  ,CASE C.TIPO ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN CL.NOME ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN F.NOME ');
      FDQRegistros.SQL.Add('  END PESSOA ');
      FDQRegistros.SQL.Add('  ,CASE L.STATUS ');
      FDQRegistros.SQL.Add('    WHEN 0 THEN ''ABERTO'' ');
      FDQRegistros.SQL.Add('    WHEN 1 THEN ''PAGO'' ');
      FDQRegistros.SQL.Add('  END STATUS_DESC ');
      FDQRegistros.SQL.Add('  ,U.NOME AS USUARIO ');
      FDQRegistros.SQL.Add('FROM LANCAMENTOS L ');
      FDQRegistros.SQL.Add('  JOIN EMPRESA E ON E.ID = L.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  JOIN CONTA C ON C.ID = L.ID_CONTA ');
      FDQRegistros.SQL.Add('  LEFT JOIN CLIENTE CL ON CL.ID = L.ID_PESSOA ');
      FDQRegistros.SQL.Add('  LEFT JOIN FORNECEDOR F ON F.ID = L.ID_PESSOA ');
      FDQRegistros.SQL.Add('  JOIN USUARIO U ON U.ID = L.ID_USUARIO ');
      FDQRegistros.SQL.Add('WHERE NOT L.ID IS NULL ');
      case cbFiltro_Tipo_Periodo.ItemIndex of
        0:FDQRegistros.SQL.Add('  AND L.DT_EMISSAO BETWEEN :DATA_I AND :DATA_F ');
        1:FDQRegistros.SQL.Add('  AND L.DT_VENCIMENTO BETWEEN :DATA_I AND :DATA_F ');
      end;
      if Trim(edFiltro_Empresa_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND L.ID_EMPRESA = :ID_EMPRESA');
        FDQRegistros.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
      end;
      if Trim(edFiltro_Cliente_ID.Text) <> '' then
      begin
        FDQRegistros.SQL.Add('  AND L.ID_PESSOA = :ID_PESSOA');
        FDQRegistros.ParamByName('ID_PESSOA').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
      end;
      case cbFiltro_Tipo_DC.ItemIndex of
        1:FDQRegistros.SQL.Add('  AND C.TIPO = 0');
        2:FDQRegistros.SQL.Add('  AND C.TIPO = 1');
      end;
      if imgFiltro_Aberto.Tag = 0 then
        FDQRegistros.SQL.Add('  AND L.STATUS <> 0');
      if imgFiltro_Pago.Tag = 0 then
        FDQRegistros.SQL.Add('  AND L.STATUS <> 1');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  L.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  ,C.TIPO ');
      case cbFiltro_Tipo_Periodo .ItemIndex of
        0:FDQRegistros.SQL.Add('  ,L.DT_EMISSAO; ');
        1:FDQRegistros.SQL.Add('  ,L.DT_VENCIMENTO; ');
      end;
      FDQRegistros.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
      FDQRegistros.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
      FDQRegistros.Active := True;

      (*
      {$Region 'Totalizando'}
        FDQ_Total.Active := False;
        FDQ_Total.Sql.Clear;
        FDQ_Total.Sql.Add('SELECT ');
        FDQ_Total.Sql.Add('  LPAD(DATEDIFF(HOUR,CAST(CURRENT_DATE AS TIMESTAMP),D.DH),3,''0'') || '':'' || ');
        FDQ_Total.Sql.Add('  LPAD(EXTRACT(MINUTE FROM D.DH),2,''0'') || '':'' || ');
        FDQ_Total.Sql.Add('  LPAD(CAST(EXTRACT(SECOND FROM D.DH) AS INTEGER),2,''0'') AS HORA');
        FDQ_Total.Sql.Add('  ,D.TOTAL ');
        FDQ_Total.Sql.Add('FROM ( ');
        FDQ_Total.Sql.Add('  SELECT ');
        FDQ_Total.Sql.Add('    DATEADD(HOUR,C.HORA,C.DM) AS DH ');
        FDQ_Total.Sql.Add('    ,C.TOTAL ');
        FDQ_Total.Sql.Add('  FROM ( ');
        FDQ_Total.Sql.Add('    SELECT ');
        FDQ_Total.Sql.Add('      B.HORA ');
        FDQ_Total.Sql.Add('      ,DATEADD(MINUTE,B.MINUTO,B.DS) DM ');
        FDQ_Total.Sql.Add('      ,B.TOTAL ');
        FDQ_Total.Sql.Add('    FROM ( ');
        FDQ_Total.Sql.Add('      SELECT ');
        FDQ_Total.Sql.Add('        A.HORA ');
        FDQ_Total.Sql.Add('        ,A.MINUTO ');
        FDQ_Total.Sql.Add('        ,DATEADD(SECOND, A.SEGUNDO, CAST(CURRENT_DATE AS TIMESTAMP)) AS DS ');
        FDQ_Total.Sql.Add('        ,A.TOTAL ');
        FDQ_Total.Sql.Add('      FROM ( ');
        FDQ_Total.Sql.Add('        SELECT ');
				FDQ_Total.Sql.Add('	      	 SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
				FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 2) ');
				FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 1 FOR 3) ');
				FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS HORA ');
				FDQ_Total.Sql.Add('	      	 ,SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
				FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 4 FOR 2) ');
				FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 5 FOR 2) ');
				FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS MINUTO ');
				FDQ_Total.Sql.Add('	      	 ,SUM(CAST(CASE CHAR_LENGTH(SP.HR_TOTAL) ');
				FDQ_Total.Sql.Add('	      	  	      WHEN 8 THEN SUBSTRING(SP.HR_TOTAL FROM 7 FOR 2) ');
				FDQ_Total.Sql.Add('	      		        WHEN 9 THEN SUBSTRING(SP.HR_TOTAL FROM 8 FOR 2) ');
				FDQ_Total.Sql.Add('	      	       END AS INTEGER)) AS SEGUNDO ');
        FDQ_Total.Sql.Add('          ,SUM(SP.TOTAL) AS TOTAL ');
        FDQ_Total.Sql.Add('        FROM SERVICOS_PRESTADOS SP ');
        FDQ_Total.SQL.Add('        WHERE NOT SP.ID IS NULL ');
        FDQ_Total.SQL.Add('          AND SP.DATA BETWEEN :DATA_I AND :DATA_F ');
        if Trim(edFiltro_Empresa_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('          AND SP.ID_EMPRESA = :ID_EMPRESA');
          FDQ_Total.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edFiltro_Empresa_ID.Text,0);
        end;
        if Trim(edFiltro_Cliente_ID.Text) <> '' then
        begin
          FDQ_Total.SQL.Add('          AND SP.ID_CLIENTE = :ID_CLIENTE');
          FDQ_Total.ParamByName('ID_CLIENTE').AsInteger := StrToIntDef(edFiltro_Cliente_ID.Text,0);
        end;
        FDQ_Total.SQL.Add(') A) B) C) D; ');
        FDQ_Total.ParamByName('DATA_I').AsDate := StrToDateDef(edFIltro_Dt_I.Text,Date);
        FDQ_Total.ParamByName('DATA_F').AsDate := StrToDateDef(edFIltro_Dt_F.Text,Date);
        FDQ_Total.Active := True;
        if not FDQ_Total.IsEmpty then
        begin
          //
        end;
      {$EndRegion 'Totalizando'}
      *)
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
    FreeAndNil(FDQ_Total);
  end;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_DCChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.cbFiltro_Tipo_PeriodoChange(Sender: TObject);
begin
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmLanc_Financeiros.imgFecharClick(Sender: TObject);
begin
  Close
end;

procedure TfrmLanc_Financeiros.imgFiltro_AbertoClick(Sender: TObject);
begin
  case imgFiltro_Aberto.Tag of
    0:begin
      imgFiltro_Aberto.Tag := 1;
      imgFiltro_Aberto.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Aberto.Tag := 0;
      imgFiltro_Aberto.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.imgFiltro_ClienteClick(Sender: TObject);
begin
  if NOT Assigned(frmPesq_Pessoas) then
    Application.CreateForm(TfrmPesq_Pessoas,frmPesq_Pessoas);

  frmPesq_Pessoas.TipoFiltro := 0;
  frmPesq_Pessoas.ExecuteOnClose := Sel_Pessoa;
  frmPesq_Pessoas.Height := frmPrincipal.Height;
  frmPesq_Pessoas.Width := frmPrincipal.Width;

  frmPesq_Pessoas.Show;

end;

procedure TfrmLanc_Financeiros.imgFiltro_EmpresaClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmLanc_Financeiros.Sel_Empresa(Aid: Integer; ANome: String);
begin
  edID_EMPRESA_Desc.Text := ANome;

  if edFiltro_Empresa_ID.CanFocus then
    edFiltro_Empresa_ID.SetFocus;
end;

procedure TfrmLanc_Financeiros.imgFiltro_PagoClick(Sender: TObject);
begin
  case imgFiltro_Pago.Tag of
    0:begin
      imgFiltro_Pago.Tag := 1;
      imgFiltro_Pago.Bitmap := imgChecked.Bitmap;
    end;
    1:begin
      imgFiltro_Pago.Tag := 0;
      imgFiltro_Pago.Bitmap := imgUnChecked.Bitmap;
    end;
  end;
  Selecionar_Registros;
end;

procedure TfrmLanc_Financeiros.Sel_Pessoa(ATipo:String; Aid:Integer; ANome:String; ADocumento:String);
begin
  lbFiltroPessoa.Text := ATipo;
  if ATipo = 'Cliente' then
    lbFiltroPessoa.Tag := 0
  else if ATipo = 'Fornecedor' then
    lbFiltroPessoa.Tag := 1;

  edFiltro_Cliente_ID.Text := Aid.ToString;
  edFiltro_Cliente.Text := ANome;
end;

end.
