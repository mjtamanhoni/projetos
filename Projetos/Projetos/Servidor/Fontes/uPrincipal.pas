unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
  {$EndRegion '99 Coders'}

  {$Region 'Horse'}
    Horse,
    Horse.Jhonson,
    Horse.BasicAuthentication,
    Horse.CORS,
    DataSet.Serialize.Config,
  {$EndRegion 'Horse'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Effects, FMX.Objects, FMX.Layouts,
  FMX.Controls.Presentation, FMX.MultiView,

  IniFiles,
  uFuncoes,
  uDM_Global,

  {$Region 'Rotas'}
    uRota.CLIENTE,
    uRota.CLIENTE_TABELA,
    uRota.HISTORICO,
    uRota.PRESTADOR_SERVICO,
    uRota.SERVICOS_PRESTADOS,
    uRota.TABELA_PRECO,
    uRota.USUARIO,
  {$EndRegion 'Rotas'}

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TfrmPrincipal = class(TForm)
    StyleBook_Principal: TStyleBook;
    mvPrincipal: TMultiView;
    rctMenuPrincipal: TRectangle;
    lytMenu_Principal: TLayout;
    lytMenuFechar: TLayout;
    imgMenuFechar: TImage;
    lytMenu_Config: TLayout;
    imgMenu_Config: TImage;
    lytMenu_Estrutura: TLayout;
    imgMenu_Estrutura: TImage;
    lytMenu_Geral: TLayout;
    ShadowEffect3: TShadowEffect;
    lytPrincipal: TLayout;
    lytDetail: TLayout;
    Memo_Historico: TMemo;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    ShadowEffect1: TShadowEffect;
    lytFechar: TLayout;
    imgFechar: TImage;
    lytMenu: TLayout;
    imgMenu: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    ShadowEffect2: TShadowEffect;
    lytPorta: TLayout;
    rctPorta: TRectangle;
    lbPorta: TLabel;
    lytVersao: TLayout;
    rctVersao: TRectangle;
    lbVersao: TLabel;
    procedure imgMenuClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgMenu_ConfigClick(Sender: TObject);
    procedure imgMenu_EstruturaClick(Sender: TObject);
    procedure imgMenuFecharClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm :TDM;


    procedure Listar_Historico;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uConfig
  ,uEstrutura.Gerar;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm);
  {$ELSE}
    FMensagem.DisposeOf;
    FIniFile.DisposeOf;
    FDm.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  lEnder_Ini :String;
begin

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\FINANCEIRO.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'FINANCEIRO.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  mvPrincipal.HideMaster;
  FMensagem := TFancyDialog.Create(frmPrincipal);

  FDm := TDM.Create(Nil);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  lArq :String;
begin

  lbPorta.Tag := FIniFile.ReadInteger('SERVER','PORTA',0);
  lbPorta.Text := 'Porta: ' + lbPorta.Tag.ToString;

  {$Region 'Configurando Horse'}
    THorse.Use(Jhonson());
    THorse.Use(CORS);

    {$Region 'Registrando rotas'}
      uRota.CLIENTE.RegistrarRotas;
      uRota.CLIENTE_TABELA.RegistrarRotas;
      uRota.HISTORICO.RegistrarRotas;
      uRota.PRESTADOR_SERVICO.RegistrarRotas;
      uRota.SERVICOS_PRESTADOS.RegistrarRotas;
      uRota.TABELA_PRECO.RegistrarRotas;
      uRota.USUARIO.RegistrarRotas;
    {$EndRegion 'Registrando rotas'}

    //TControllers.RegistrarRotas;
    THorse.Listen(lbPorta.Tag, procedure(Horse:THorse)
    begin
      lbPorta.Text := lbPorta.Text;
    end);
  {$EndRegion 'Configurando Horse'}

  lArq := '';
  {$IFDEF MSWINDOWS}
    lArq := TFuncoes.Pasta_Sistema + '/Historico_' + FormatDateTime('YYYYMMDD',Date) + '.txt';
  {$ELSE}
    lArq := TPath.Combine(TFuncoes.Pasta_Sistema,'Historico_' + FormatDateTime('YYYYMMDD',Date) + '.txt');
  {$ENDIF}

  Listar_Historico;
end;

procedure TfrmPrincipal.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
  mvPrincipal.ShowMaster;
end;

procedure TfrmPrincipal.imgMenuFecharClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
end;

procedure TfrmPrincipal.imgMenu_ConfigClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  if not Assigned(frmConfig) then
    Application.CreateForm(TfrmConfig,frmConfig);
  frmConfig.Show;
end;

procedure TfrmPrincipal.imgMenu_EstruturaClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  if not Assigned(frmCriarEstrutura) then
    Application.CreateForm(TfrmCriarEstrutura,frmCriarEstrutura);
  frmCriarEstrutura.Show;
end;

procedure TfrmPrincipal.Listar_Historico;
var
  lQuery :TFDQuery;
  lMensagem :String;
begin
  try
    try
      Memo_Historico.Lines.Clear;

      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := FDm.FDC_Servidor;

      lQuery.Active := False;
      lQuery.Sql.Clear;
      lQuery.Sql.Add('SELECT * FROM HISTORICO WHERE DT_HISTORICO = :DT_HISTORICO ORDER BY ID;');
      lQuery.ParamByName('DT_HISTORICO').AsDate := Date;
      lQuery.Active := True;
      if not lQuery.IsEmpty then
      begin
        lQuery.First;
        while not lQuery.Eof do
        begin
          lMensagem := '';
          lMensagem := lMensagem + TFuncoes.PreencheVariavel(FormatFloat('#,##0',lQuery.RecNo),' ','E',10) + ':  ' +
                                   lQuery.FieldByName('DT_HISTORICO').AsString + ' ' +
                                   lQuery.FieldByName('HR_HISTORICO').AsString + ' - ' +
                                   lQuery.FieldByName('DESCRICAO').AsString;
          Memo_Historico.Lines.Insert(0,lMensagem);
          lQuery.Next;
        end;
      end;
    except on E: Exception do
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
    Memo_Historico.Lines.Insert(0,' ');
    Memo_Historico.Lines.Insert(0,' ');
    Memo_Historico.Lines.Add(' ');
    Memo_Historico.Lines.Add(' ');
  end;
end;

end.
