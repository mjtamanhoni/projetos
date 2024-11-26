unit uCad.Usuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.TabControl,
  FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_Usuario = class(TForm)
    lytHeader: TLayout;
    lytDetail: TLayout;
    lytFooter: TLayout;
    rctHeader: TRectangle;
    rctFooter: TRectangle;
    imgVoltar: TImage;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    tiCampos: TTabItem;
    lytLista: TLayout;
    lytCampos: TLayout;
    imgAcao_01: TImage;
    imgNovo: TImage;
    imgExcluir: TImage;
    imgSalvar: TImage;
    imgCancelar: TImage;
    imgChecked: TImage;
    imgUnChecked: TImage;
    lvLista: TListView;
    lytFiltro: TLayout;
    edFiltro: TEdit;
    imgFiltrar: TImage;
    imgLimpar: TImage;
    lytRow_001: TLayout;
    lytID: TLayout;
    lytPIN: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbPIN: TLabel;
    edPIN: TEdit;
    lytRow_002: TLayout;
    lytNOME: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytRow_003: TLayout;
    lytLOGIN: TLayout;
    lbLOGIN: TLabel;
    edLOGIN: TEdit;
    lytRow_004: TLayout;
    lytSENHA: TLayout;
    lbSENHA: TLabel;
    edSENHA: TEdit;
    lytRow_006: TLayout;
    lytCELULAR: TLayout;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    lytRow_005: TLayout;
    lytEMAIL: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lytRow_008: TLayout;
    lytID_PRESTADOR_SERVICO: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO: TEdit;
    lytRow_007: TLayout;
    Layout9: TLayout;
    Label9: TLabel;
    edID_EMPRESA: TEdit;
    imgEditar: TImage;
    imgSenha: TImage;
    imgExibir: TImage;
    imgEsconder: TImage;
    Image1: TImage;
    Image2: TImage;
    procedure imgVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edPINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edLOGINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSENHAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARTyping(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure imgSenhaClick(Sender: TObject);
    procedure edID_EMPRESAClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;

    procedure Configura_Botoes;
    procedure Selecionar_Registros;
    procedure Cancelar(Sender: TOBject);
    procedure LimparCampos;
    procedure Salvar;
    procedure TTHreadEnd_Salvar(Sender: TOBject);
    procedure Sel_Empresa(Aid:Integer; ANome:String);

  public
    { Public declarations }
  end;

var
  frmCad_Usuario: TfrmCad_Usuario;

implementation

{$R *.fmx}

uses uCad.Empresa;

procedure TfrmCad_Usuario.edCELULARTyping(Sender: TObject);
begin
  Formatar(edCELULAR,Celular);
end;

procedure TfrmCad_Usuario.edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCELULAR.SetFocus;

end;

procedure TfrmCad_Usuario.edID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa,frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Show;
end;

procedure TfrmCad_Usuario.Sel_Empresa(Aid:Integer; ANome:String);
begin
  edID_EMPRESA.Tag := Aid;
  edID_EMPRESA.Text := ANome;
end;

procedure TfrmCad_Usuario.edLOGINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edSENHA.SetFocus;

end;

procedure TfrmCad_Usuario.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edLOGIN.SetFocus;

end;

procedure TfrmCad_Usuario.edPINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edNOME.SetFocus;
end;

procedure TfrmCad_Usuario.edSENHAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;

end;

procedure TfrmCad_Usuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmCad_Usuario := Nil;
end;

procedure TfrmCad_Usuario.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_Usuario);

  tcPrincipal.ActiveTab := tiLista;

  FDm_Global := TDM_Global.Create(Nil);

  FTab_Status := dsLista;

  Selecionar_Registros;
  Configura_Botoes;
end;

procedure TfrmCad_Usuario.Selecionar_Registros;
begin

end;

procedure TfrmCad_Usuario.Configura_Botoes;
begin

end;

procedure TfrmCad_Usuario.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      FTab_Status := dsInsert;
      LimparCampos;
      imgAcao_01.Tag := 1;
      imgAcao_01.Bitmap := imgSalvar.Bitmap;
      tcPrincipal.GotoVisibleTab(1);
      if edPIN.CanFocus then
        edPIN.SetFocus;
    end;
    1:Salvar;
  end;
end;

procedure TfrmCad_Usuario.imgSenhaClick(Sender: TObject);
begin
  case imgSenha.Tag of
    0:begin
      imgSenha.Tag := 1;
      imgSenha.Bitmap := imgEsconder.Bitmap;
      edSENHA.Password := False;
    end;
    1:begin
      imgSenha.Tag := 0;
      imgSenha.Bitmap := imgExibir.Bitmap;
      edSENHA.Password := True;
    end;
  end;
end;

procedure TfrmCad_Usuario.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_Usuario,'Salvando alterações');

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
      FQuery.Sql.Add('INSERT INTO USUARIO( ');
      FQuery.Sql.Add('  NOME ');
      FQuery.Sql.Add('  ,LOGIN ');
      FQuery.Sql.Add('  ,SENHA ');
      FQuery.Sql.Add('  ,PIN ');
      FQuery.Sql.Add('  ,CELULAR ');
      FQuery.Sql.Add('  ,EMAIL ');
      FQuery.Sql.Add('  ,ID_EMPRESA ');
      FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,FOTO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :NOME ');
      FQuery.Sql.Add('  ,:LOGIN ');
      FQuery.Sql.Add('  ,:SENHA ');
      FQuery.Sql.Add('  ,:PIN ');
      FQuery.Sql.Add('  ,:CELULAR ');
      FQuery.Sql.Add('  ,:EMAIL ');
      FQuery.Sql.Add('  ,:ID_EMPRESA ');
      FQuery.Sql.Add('  ,:ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,:FOTO ');
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
      FQuery.Sql.Add('UPDATE USUARIO SET ');
      FQuery.Sql.Add('  ,NOME = :NOME ');
      FQuery.Sql.Add('  ,LOGIN = :LOGIN ');
      FQuery.Sql.Add('  ,SENHA = :SENHA ');
      FQuery.Sql.Add('  ,PIN = :PIN ');
      FQuery.Sql.Add('  ,CELULAR = :CELULAR ');
      FQuery.Sql.Add('  ,EMAIL = :EMAIL ');
      FQuery.Sql.Add('  ,ID_EMPRESA = :ID_EMPRESA ');
      FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,FOTO = :FOTO ');
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := 0;
    end;
    FQuery.ParamByName('NOME').AsString := edNOME.Text;
    FQuery.ParamByName('LOGIN').AsString := edLOGIN.Text;
    FQuery.ParamByName('SENHA').AsString := edSENHA.Text;
    FQuery.ParamByName('PIN').AsString := edPIN.Text;
    FQuery.ParamByName('CELULAR').AsString := edCELULAR.Text;
    FQuery.ParamByName('EMAIL').AsString := edEMAIL.Text;
    FQuery.ParamByName('ID_EMPRESA').AsInteger := edID_EMPRESA.Tag;
    FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := edID_PRESTADOR_SERVICO.Tag;
    FQuery.ParamByName('FOTO').AsString := '';
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

procedure TfrmCad_Usuario.TTHreadEnd_Salvar(Sender :TOBject);
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
    Selecionar_Registros;
  end;

end;

procedure TfrmCad_Usuario.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:Close;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

procedure TfrmCad_Usuario.Cancelar(Sender :TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmCad_Usuario.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edPIN.Text := '';
  edNOME.Text := '';
  edLOGIN.Text := '';
  edSENHA.Text := '';
  edEMAIL.Text := '';
  edCELULAR.Text := '';
  edID_EMPRESA.Text := '';
  edID_EMPRESA.Tag := 0;
  edID_PRESTADOR_SERVICO.Text := '';
  edID_PRESTADOR_SERVICO.Tag := 0;
end;

end.
