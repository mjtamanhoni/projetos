unit uConfig;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls,

  {$Region '99 Coders'}
    uFancyDialog,
  {$EndRegion '99 Coders'}
  IniFiles,
  uPrincipal, FMX.TabControl, FMX.Edit, FMX.ListBox;

type
  TfrmConfig = class(TForm)
    lytFormulario: TLayout;
    rctFooter: TRectangle;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    rctDetail: TRectangle;
    ShadowEffect4: TShadowEffect;
    rctTampa: TRectangle;
    tcPrincipal: TTabControl;
    tiDB: TTabItem;
    lytBancoDados: TLayout;
    imgConfirmar: TImage;
    lytBDF_Row001: TLayout;
    lbBDF_Servidor: TLabel;
    edBDF_Servidor: TEdit;
    edBDF_Porta: TEdit;
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
    lbBDF_Porta: TLabel;
    OpenDialog: TOpenDialog;
    imgEsconteSenha: TImage;
    imgExibeSenha: TImage;
    rctSubTit: TRectangle;
    lbSubTit: TLabel;
    ShadowEffect1: TShadowEffect;
    lytOpcoes: TLayout;
    gplOpcoes: TGridPanelLayout;
    imgDB: TImage;
    imgOpcoes: TImage;
    tiPlanoContas: TTabItem;
    lytPlanoContas: TLayout;
    lytRow_001: TLayout;
    lbApontHoras: TLabel;
    edApontHoras: TEdit;
    edID_ApontHoras: TEdit;
    imgID_ApontHoras: TImage;
    lytRow_002: TLayout;
    lbHrExced_MesAnt: TLabel;
    edHrExced_MesAnt_Desc: TEdit;
    edHrExced_MesAnt: TEdit;
    imgHrExced_MesAnt: TImage;
    lytRow_003: TLayout;
    lbedHorasPagas: TLabel;
    edHorasPagas_Desc: TEdit;
    ededHorasPagas: TEdit;
    imgedHorasPagas: TImage;
    tiFinanceiro: TTabItem;
    lytFinanceiro: TLayout;
    lytFin_Row001: TLayout;
    lbTotalHoraBase: TLabel;
    edTotalHorasBase: TEdit;
    imgFinanceiro: TImage;
    lytRow_004: TLayout;
    lbHorasRecebidas: TLabel;
    edHorasRecebidas_Desc: TEdit;
    edHorasRecebidas: TEdit;
    imgHorasRecebidas: TImage;
    lytRow_000: TLayout;
    rctRow_000: TRectangle;
    lbPlanoContas_Tit: TLabel;
    lytRow_005: TLayout;
    rctRow_005: TRectangle;
    lbFormaCond_Pagto_Tit: TLabel;
    lytRow_006: TLayout;
    lbFormaPagto: TLabel;
    edFormaPagto_Desc: TEdit;
    edFormaPagto_Id: TEdit;
    imgFormaPagto_Id: TImage;
    lytRow_007: TLayout;
    lbCondPagto: TLabel;
    edCondPagto_Desc: TEdit;
    edCondPagto_Id: TEdit;
    imgCondPagto: TImage;
    tcBanco: TTabControl;
    tiFirebird: TTabItem;
    tiPostgreSql: TTabItem;
    Layout1: TLayout;
    lbBD_PS_Server: TLabel;
    edBD_PS_Server: TEdit;
    edBD_PS_Port: TEdit;
    lbBD_PS_Port: TLabel;
    Layout2: TLayout;
    lbBD_PS_Banco: TLabel;
    edBD_PS_Banco: TEdit;
    Layout3: TLayout;
    lbBD_PS_Usuario: TLabel;
    edBD_PS_Usuario: TEdit;
    lbBD_PS_Senha: TLabel;
    edBD_PS_Senha: TEdit;
    Layout4: TLayout;
    Image1: TImage;
    sbBD_PS_Senha: TSpeedButton;
    Layout5: TLayout;
    lbBD_PS_Biblioteca: TLabel;
    edBD_PS_Biblioteca: TEdit;
    SpeedButton3: TSpeedButton;
    Layout6: TLayout;
    lbBancoDados: TLabel;
    cbBancoDados: TComboBox;
    edBD_PS_Schema: TEdit;
    lbBD_PS_Schema: TLabel;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgConfirmarClick(Sender: TObject);
    procedure dbBDF_BancoClick(Sender: TObject);
    procedure sbSenhaClick(Sender: TObject);
    procedure sbBDF_BibliotecaClick(Sender: TObject);
    procedure edBDF_ServidorKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBDF_PortaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBDF_BancoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBDF_UsuarioKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edBDF_SenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure imgDBClick(Sender: TObject);
    procedure imgID_ApontHorasClick(Sender: TObject);
    procedure imgHrExced_MesAntClick(Sender: TObject);
    procedure imgedHorasPagasClick(Sender: TObject);
    procedure imgHorasRecebidasClick(Sender: TObject);
    procedure imgFormaPagto_IdClick(Sender: TObject);
    procedure imgCondPagtoClick(Sender: TObject);
    procedure cbBancoDadosChange(Sender: TObject);
    procedure sbBD_PS_SenhaClick(Sender: TObject);
    procedure edBD_PS_SchemaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;

    procedure Grava_Configuracoes;
    procedure Ler_Configuracoes;
    procedure Sel_ApontHoras(Aid:Integer; ADescricao:String; ATipo:Integer);
    procedure Sel_HorasExcedida(Aid:Integer; ADescricao:String; ATipo:Integer);
    procedure Sel_HorasPagas(Aid:Integer; ADescricao:String; ATipo:Integer);
    procedure Sel_HorasRecebidas(Aid: Integer; ADescricao: String; ATipo: Integer);
    procedure Sel_FormaPagto(Aid: Integer; ANome, AClassificacao: String);
    procedure Sel_CondPagto(Aid: Integer; ADescricao: String; AParcelas,
      ATipoIntervalo, AIntervalo: Integer);
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.fmx}

uses
  uCad.Contas
  ,uCad.FormaPagamento
  ,uCad.CondicaoPagamento;

procedure TfrmConfig.cbBancoDadosChange(Sender: TObject);
begin
  tcBanco.GotoVisibleTab(cbBancoDados.ItemIndex);
end;

procedure TfrmConfig.dbBDF_BancoClick(Sender: TObject);
begin
  OpenDialog.DefaultExt := '*.FDB';
  OpenDialog.Filter := 'Bando de dados Firebird|*.FDB';
  OpenDialog.Execute;
  if FileExists(OpenDialog.FileName) then
    edBDF_Banco.Text := OpenDialog.FileName;
end;

procedure TfrmConfig.edBDF_BancoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBD_PS_Schema.SetFocus;
end;

procedure TfrmConfig.edBDF_PortaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBD_PS_Banco.SetFocus;
end;

procedure TfrmConfig.edBDF_SenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBD_PS_Biblioteca.SetFocus;
end;

procedure TfrmConfig.edBDF_ServidorKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBD_PS_Port.SetFocus;
end;

procedure TfrmConfig.edBDF_UsuarioKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBD_PS_Senha.SetFocus;
end;

procedure TfrmConfig.edBD_PS_SchemaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edBD_PS_Usuario.SetFocus;
end;

procedure TfrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);

  Action := TCloseAction.caFree;
  frmConfig := Nil;
end;

procedure TfrmConfig.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmConfig);
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';

  FIniFile := TIniFile.Create(FEnder);

  lytFormulario.Align := TAlignLayout.Center;
  tcPrincipal.ActiveTab := tiDB;
  tcBanco.ActiveTab := tiFirebird;

  Ler_Configuracoes;
end;

procedure TfrmConfig.FormShow(Sender: TObject);
begin
  if edBDF_Servidor.CanFocus then
    edBDF_Servidor.SetFocus;
end;

procedure TfrmConfig.Ler_Configuracoes;
begin
  try
    try
      {$Region 'Banco de Dados'}
        cbBancoDados.ItemIndex := FIniFile.ReadInteger('BANDO','USADO.ID',-1);

        //Firebird
        edBDF_Servidor.Text    := FIniFile.ReadString('BANDO_FIREBIRD','SERVIDOR','');
        edBDF_Porta.Text       := FIniFile.ReadInteger('BANDO_FIREBIRD','PORTA',3050).ToString;
        edBDF_Banco.Text       := FIniFile.ReadString('BANDO_FIREBIRD','BANCO','');
        edBDF_Usuario.Text     := FIniFile.ReadString('BANDO_FIREBIRD','USUARIO','');
        edBDF_Senha.Text       := FIniFile.ReadString('BANDO_FIREBIRD','SENHA','');
        edBDF_Biblioteca.Text  := FIniFile.ReadString('BANDO_FIREBIRD','BIBLIOTECA','');

        //PostgreSql
        edBD_PS_Server.Text := FIniFile.ReadString('BANDO.POSTGRESQL','SERVER','');
        edBD_PS_Port.Text := FIniFile.ReadString('BANDO.POSTGRESQL','PORT','5432');
        edBD_PS_Banco.Text := FIniFile.ReadString('BANDO.POSTGRESQL','DATABASE','');
        edBD_PS_Usuario.Text := FIniFile.ReadString('BANDO.POSTGRESQL','USER_NAME','');
        edBD_PS_Senha.Text := FIniFile.ReadString('BANDO.POSTGRESQL','PASSWORD','');
        edBD_PS_Schema.Text := FIniFile.ReadString('BANDO.POSTGRESQL','SCHEMANAME','');
        edBD_PS_Biblioteca.Text := FIniFile.ReadString('BANDO.POSTGRESQL','VENDOR_LIB','');
      {$EndRegion 'Banco de Dados'}

      {$Region 'Plano de Contas - Lançamentos'}
        edID_ApontHoras.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','APONT.HORAS','');
        edApontHoras.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','APONT.HORAS.DESC','');
        edHrExced_MesAnt.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.EXCED','');
        edHrExced_MesAnt_DEsc.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.EXCED.DESC','');
        ededHorasPagas.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.PAGAS','');
        edHorasPagas_Desc.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.PAGAS.DESC','');
        edHorasRecebidas.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.RECEBIDAS','');
        edHorasRecebidas_Desc.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.RECEBIDAS.DESC','');
      {$EndRegion 'Plano de Contas - Lançamentos'}

      {$Region 'Forma e Condição de Pagamento - Lançamentos'}
        edFormaPagto_Id.Text := FIniFile.ReadString('FORMA.COND.LANC','FORMA.ID','');
        edFormaPagto_Desc.Text := FIniFile.ReadString('FORMA.COND.LANC','FORMA.DESC','');
        edCondPagto_Id.Text := FIniFile.ReadString('FORMA.COND.LANC','COND.ID','');
        edCondPagto_Desc.Text := FIniFile.ReadString('FORMA.COND.LANC','COND.DESC','');
      {$EndRegion 'Forma e Condição de Pagamento - Lançamentos'}

      {$Region 'Financeiro'}
        edTotalHorasBase.Text := FIniFile.ReadString('FINANCEIRO','TOTAL.HORAS','');
      {$EndRegion 'Financeiro'}

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Lendo Configurações',E.Message,'Ok');
    end;
  finally

  end;
end;

procedure TfrmConfig.imgCondPagtoClick(Sender: TObject);
begin
  if NOT Assigned(frmCondicao_Pagamento) then
    Application.CreateForm(TfrmCondicao_Pagamento, frmCondicao_Pagamento);

  frmCondicao_Pagamento.Pesquisa := True;
  frmCondicao_Pagamento.ExecuteOnClose := Sel_CondPagto;
  frmCondicao_Pagamento.Parent := frmPrincipal;
  frmCondicao_Pagamento.Height := frmPrincipal.Height;
  frmCondicao_Pagamento.Width := frmPrincipal.Width;

  frmCondicao_Pagamento.Show;
end;

procedure TfrmConfig.Sel_CondPagto(Aid:Integer; ADescricao:String; AParcelas,ATipoIntervalo,AIntervalo:Integer);
begin
  edCondPagto_Id.Tag := Aid;
  edCondPagto_Id.Text := Aid.ToString;
  edCondPagto_Desc.Text := ADescricao;
end;

procedure TfrmConfig.imgConfirmarClick(Sender: TObject);
begin
  Grava_Configuracoes;
end;

procedure TfrmConfig.imgDBClick(Sender: TObject);
begin
  imgDB.Opacity := 0.5;
  imgOpcoes.Opacity := 0.5;
  imgFinanceiro.Opacity := 0.5;

  case TImage(Sender).Tag of
    0:begin
      lbSubTit.Text := 'Banco de Dados';
    end;
    1:begin
      lbSubTit.Text := 'Padrões para Lançamento Financeiro';
    end;
    2:begin
      lbSubTit.Text := 'Financeiro';
    end;
  end;
  TImage(Sender).Opacity := 1;

  tcPrincipal.GotoVisibleTab(TImage(Sender).Tag);
end;

procedure TfrmConfig.imgedHorasPagasClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas, frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_HorasPagas;
  frmCad_Contas.Parent := frmPrincipal;
  frmCad_Contas.Height := frmPrincipal.Height;
  frmCad_Contas.Width := frmPrincipal.Width;

  frmCad_Contas.Show;

end;

procedure TfrmConfig.Grava_Configuracoes;
begin
  try
    try
      {$Region 'Banco de Dados'}
        FIniFile.WriteInteger('BANDO','USADO.ID',cbBancoDados.ItemIndex);
        FIniFile.WriteString('BANDO','USADO.NOME',cbBancoDados.ListItems[cbBancoDados.ItemIndex].Text);
        case cbBancoDados.ItemIndex of
          0:FIniFile.WriteString('BANDO','USADO.SIGLA','FB');
          1:FIniFile.WriteString('BANDO','USADO.SIGLA','PG');
        end;

        //Firebird
        FIniFile.WriteString('BANDO_FIREBIRD','SERVIDOR',edBDF_Servidor.Text);
        FIniFile.WriteInteger('BANDO_FIREBIRD','PORTA',StrToIntDef(edBDF_Porta.Text,0));
        FIniFile.WriteString('BANDO_FIREBIRD','BANCO',edBDF_Banco.Text);
        FIniFile.WriteString('BANDO_FIREBIRD','USUARIO',edBDF_Usuario.Text);
        FIniFile.WriteString('BANDO_FIREBIRD','SENHA',edBDF_Senha.Text);
        FIniFile.WriteString('BANDO_FIREBIRD','BIBLIOTECA',edBDF_Biblioteca.Text);

        //PostgreSql
        FIniFile.WriteString('BANDO.POSTGRESQL','DRIVER','PG');
        FIniFile.WriteString('BANDO.POSTGRESQL','SERVER',edBD_PS_Server.Text);
        FIniFile.WriteString('BANDO.POSTGRESQL','PORT',edBD_PS_Port.Text);
        FIniFile.WriteString('BANDO.POSTGRESQL','DATABASE',edBD_PS_Banco.Text);
        FIniFile.WriteString('BANDO.POSTGRESQL','USER_NAME',edBD_PS_Usuario.Text);
        FIniFile.WriteString('BANDO.POSTGRESQL','PASSWORD',edBD_PS_Senha.Text);
        FIniFile.WriteString('BANDO.POSTGRESQL','SCHEMANAME',edBD_PS_Schema.Text);
        FIniFile.WriteString('BANDO.POSTGRESQL','VENDOR_LIB',edBD_PS_Biblioteca.Text);
      {$EndRegion 'Banco de Dados'}

      {$Region 'Plano de Contas - Lançamentos'}
        FIniFile.WriteString('PLANO_CONTAS.LANC','APONT.HORAS',edID_ApontHoras.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','APONT.HORAS.DESC',edApontHoras.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.EXCED',edHrExced_MesAnt.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.EXCED.DESC',edHrExced_MesAnt_DEsc.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.PAGAS',ededHorasPagas.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.PAGAS.DESC',edHorasPagas_Desc.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.RECEBIDAS',edHorasRecebidas.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.RECEBIDAS.DESC',edHorasRecebidas_Desc.Text);
      {$EndRegion 'Plano de Contas - Lançamentos'}

      {$Region 'Forma e Condição de Pagamento - Lançamentos'}
        FIniFile.WriteString('FORMA.COND.LANC','FORMA.ID',edFormaPagto_Id.Text);
        FIniFile.WriteString('FORMA.COND.LANC','FORMA.DESC',edFormaPagto_Desc.Text);
        FIniFile.WriteString('FORMA.COND.LANC','COND.ID',edCondPagto_Id.Text);
        FIniFile.WriteString('FORMA.COND.LANC','COND.DESC',edCondPagto_Desc.Text);
      {$EndRegion 'Forma e Condição de Pagamento - Lançamentos'}

      {$Region 'Financeiro'}
        FIniFile.WriteString('FINANCEIRO','TOTAL.HORAS',edTotalHorasBase.Text);
      {$EndRegion 'Financeiro'}

      FFancyDialog.Show(TIconDialog.Success,'Atenção','Configurações com sucesso','Ok');
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'Ok');
    end;
  finally
  end;
end;


procedure TfrmConfig.imgHorasRecebidasClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas, frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_HorasRecebidas;
  frmCad_Contas.Parent := frmPrincipal;
  frmCad_Contas.Height := frmPrincipal.Height;
  frmCad_Contas.Width := frmPrincipal.Width;

  frmCad_Contas.Show;
end;

procedure TfrmConfig.imgHrExced_MesAntClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas, frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_HorasExcedida;
  frmCad_Contas.Parent := frmPrincipal;
  frmCad_Contas.Height := frmPrincipal.Height;
  frmCad_Contas.Width := frmPrincipal.Width;

  frmCad_Contas.Show;
end;

procedure TfrmConfig.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfig.imgFormaPagto_IdClick(Sender: TObject);
begin
  if NOT Assigned(frmFormaPagamento) then
    Application.CreateForm(TfrmFormaPagamento, frmFormaPagamento);

  frmFormaPagamento.Pesquisa := True;
  frmFormaPagamento.ExecuteOnClose := Sel_FormaPagto;
  frmFormaPagamento.Parent := frmPrincipal;
  frmFormaPagamento.Height := frmPrincipal.Height;
  frmFormaPagamento.Width := frmPrincipal.Width;

  frmFormaPagamento.Show;

end;

procedure TfrmConfig.imgID_ApontHorasClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Contas) then
    Application.CreateForm(TfrmCad_Contas, frmCad_Contas);

  frmCad_Contas.Pesquisa := True;
  frmCad_Contas.ExecuteOnClose := Sel_ApontHoras;
  frmCad_Contas.Parent := frmPrincipal;
  frmCad_Contas.Height := frmPrincipal.Height;
  frmCad_Contas.Width := frmPrincipal.Width;

  frmCad_Contas.Show;
end;

procedure TfrmConfig.Sel_FormaPagto(Aid:Integer; ANome:String; AClassificacao:String);
begin
  edFormaPagto_Id.Tag := Aid;
  edFormaPagto_Id.Text := AId.ToString;
  edFormaPagto_Desc.Text := ANome;
end;

procedure TfrmConfig.Sel_ApontHoras(Aid:Integer; ADescricao:String; ATipo:Integer);
begin
  edID_ApontHoras.Text := Aid.ToString;
  edApontHoras.Text := ADescricao;
end;

procedure TfrmConfig.Sel_HorasExcedida(Aid: Integer; ADescricao: String; ATipo: Integer);
begin
  edHrExced_MesAnt.Text := Aid.ToString;
  edHrExced_MesAnt_Desc.Text := ADescricao;
end;

procedure TfrmConfig.Sel_HorasPagas(Aid: Integer; ADescricao: String; ATipo: Integer);
begin
  ededHorasPagas.Text := Aid.ToString;
  edHorasPagas_Desc.Text := ADescricao;
end;

procedure TfrmConfig.Sel_HorasRecebidas(Aid: Integer; ADescricao: String; ATipo: Integer);
begin
  edHorasRecebidas.Text := Aid.ToString;
  edHorasRecebidas_Desc.Text := ADescricao;
end;

procedure TfrmConfig.SpeedButton3Click(Sender: TObject);
begin
  OpenDialog.DefaultExt := '*.DLL';
  OpenDialog.Filter := 'Biblioteca Firebird|*.DLL';
  OpenDialog.Execute;
  if FileExists(OpenDialog.FileName) then
    edBD_PS_Biblioteca.Text := OpenDialog.FileName;
end;

procedure TfrmConfig.sbBD_PS_SenhaClick(Sender: TObject);
begin
  case sbBD_PS_Senha.Tag of
    0:begin
      edBD_PS_Senha.Password := False;
      imgSenha.Bitmap := imgEsconteSenha.Bitmap;
      sbBD_PS_Senha.Tag := 1;
    end;
    1:begin
      edBD_PS_Senha.Password := True;
      imgSenha.Bitmap := imgExibeSenha.Bitmap;
      sbBD_PS_Senha.Tag := 0;
    end;
  end;

end;

procedure TfrmConfig.sbBDF_BibliotecaClick(Sender: TObject);
begin
  OpenDialog.DefaultExt := '*.DLL';
  OpenDialog.Filter := 'Biblioteca Firebird|*.DLL';
  OpenDialog.Execute;
  if FileExists(OpenDialog.FileName) then
    edBDF_Biblioteca.Text := OpenDialog.FileName;
end;

procedure TfrmConfig.sbSenhaClick(Sender: TObject);
begin
  case sbSenha.Tag of
    0:begin
      edBDF_Senha.Password := False;
      imgSenha.Bitmap := imgEsconteSenha.Bitmap;
      sbSenha.Tag := 1;
    end;
    1:begin
      edBDF_Senha.Password := True;
      imgSenha.Bitmap := imgExibeSenha.Bitmap;
      sbSenha.Tag := 0;
    end;
  end;
end;

end.
