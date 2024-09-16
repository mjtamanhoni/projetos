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
  uPrincipal, FMX.TabControl, FMX.Edit;

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
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;

    procedure Grava_Configuracoes;
    procedure Ler_Configuracoes;
    procedure Sel_ApontHoras(Aid:Integer; ADescricao:String; ATipo:Integer);
    procedure Sel_HorasExcedida(Aid:Integer; ADescricao:String; ATipo:Integer);
    procedure Sel_HorasPagas(Aid:Integer; ADescricao:String; ATipo:Integer);
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.fmx}

uses
  uCad.Contas;

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
    edBDF_Usuario.SetFocus;
end;

procedure TfrmConfig.edBDF_PortaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBDF_Banco.SetFocus;
end;

procedure TfrmConfig.edBDF_SenhaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBDF_Biblioteca.SetFocus;
end;

procedure TfrmConfig.edBDF_ServidorKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBDF_Porta.SetFocus;
end;

procedure TfrmConfig.edBDF_UsuarioKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edBDF_Senha.SetFocus;
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
        edBDF_Servidor.Text    := FIniFile.ReadString('BANDO_FIREBIRD','SERVIDOR','');
        edBDF_Porta.Text       := FIniFile.ReadInteger('BANDO_FIREBIRD','PORTA',3050).ToString;
        edBDF_Banco.Text       := FIniFile.ReadString('BANDO_FIREBIRD','BANCO','');
        edBDF_Usuario.Text     := FIniFile.ReadString('BANDO_FIREBIRD','USUARIO','');
        edBDF_Senha.Text       := FIniFile.ReadString('BANDO_FIREBIRD','SENHA','');
        edBDF_Biblioteca.Text  := FIniFile.ReadString('BANDO_FIREBIRD','BIBLIOTECA','');
      {$EndRegion 'Banco de Dados'}

      {$Region 'Plano de Contas - Lançamentos'}
        edID_ApontHoras.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','APONT.HORAS','');
        edApontHoras.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','APONT.HORAS.DESC','');
        edHrExced_MesAnt.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.EXCED','');
        edHrExced_MesAnt_DEsc.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.EXCED.DESC','');
        ededHorasPagas.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.PAGAS','');
        edHorasPagas_Desc.Text := FIniFile.ReadString('PLANO_CONTAS.LANC','HORAS.PAGAS.DESC','');
      {$EndRegion 'Plano de Contas - Lançamentos'}

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Lendo Configurações',E.Message,'Ok');
    end;
  finally

  end;
end;

procedure TfrmConfig.imgConfirmarClick(Sender: TObject);
begin
  Grava_Configuracoes;
end;

procedure TfrmConfig.imgDBClick(Sender: TObject);
begin
  imgDB.Opacity := 0.5;
  imgOpcoes.Opacity := 0.5;

  case TImage(Sender).Tag of
    0:begin
      lbSubTit.Text := 'Banco de Dados';
    end;
    1:begin
      lbSubTit.Text := 'Plano de Contas padrão (Lançamentos)';
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
        FIniFile.WriteString('BANDO_FIREBIRD','SERVIDOR',edBDF_Servidor.Text);
        FIniFile.WriteInteger('BANDO_FIREBIRD','PORTA',StrToIntDef(edBDF_Porta.Text,0));
        FIniFile.WriteString('BANDO_FIREBIRD','BANCO',edBDF_Banco.Text);
        FIniFile.WriteString('BANDO_FIREBIRD','USUARIO',edBDF_Usuario.Text);
        FIniFile.WriteString('BANDO_FIREBIRD','SENHA',edBDF_Senha.Text);
        FIniFile.WriteString('BANDO_FIREBIRD','BIBLIOTECA',edBDF_Biblioteca.Text);
      {$EndRegion 'Banco de Dados'}

      {$Region 'Plano de Contas - Lançamentos'}
        FIniFile.WriteString('PLANO_CONTAS.LANC','APONT.HORAS',edID_ApontHoras.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','APONT.HORAS.DESC',edApontHoras.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.EXCED',edHrExced_MesAnt.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.EXCED.DESC',edHrExced_MesAnt_DEsc.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.PAGAS',ededHorasPagas.Text);
        FIniFile.WriteString('PLANO_CONTAS.LANC','HORAS.PAGAS.DESC',edHorasPagas_Desc.Text);
      {$EndRegion 'Plano de Contas - Lançamentos'}

      FFancyDialog.Show(TIconDialog.Success,'Atenção','Configurações com sucesso','Ok');
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'Ok');
    end;
  finally
  end;
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
