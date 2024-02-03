unit unPrincipal;

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

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,

  IniFiles,
  uFuncoes,
  uDm.Servidor,

  {$Region 'Rotas'}
    uRota.CLIENTE,
    uRota.CLIENTE_TABELA,
    uRota.HISTORICO,
    uRota.PRESTADOR_SERVICO,
    uRota.SERVICOS_PRESTADOS,
    uRota.TABELA_PRECO,
    uRota.USUARIO,
  {$EndRegion 'Rotas'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Layouts, FMX.Objects, FMX.Effects, FMX.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    lytHeader: TLayout;
    lytPrincipal: TLayout;
    lytFooter: TLayout;
    mvPrincipal: TMultiView;
    lytDetail: TLayout;
    StyleBook_Principal: TStyleBook;
    Memo_Historico: TMemo;
    rctHeader: TRectangle;
    rctFooter: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    lytFechar: TLayout;
    imgFechar: TImage;
    lytMenu: TLayout;
    imgMenu: TImage;
    lytPorta: TLayout;
    rctPorta: TRectangle;
    lbPorta: TLabel;
    lytVersao: TLayout;
    rctVersao: TRectangle;
    lbVersao: TLabel;
    rctMenuPrincipal: TRectangle;
    lytMenuFechar: TLayout;
    imgMenuFechar: TImage;
    ShadowEffect3: TShadowEffect;
    lbTitulo: TLabel;
    lytMenu_Principal: TLayout;
    lytMenu_Geral: TLayout;
    lytMenu_Config: TLayout;
    imgMenu_Config: TImage;
    lytMenu_Estrutura: TLayout;
    imgMenu_Estrutura: TImage;
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgMenuClick(Sender: TObject);
    procedure imgMenuFecharClick(Sender: TObject);
    procedure imgMenu_ConfigClick(Sender: TObject);
    procedure imgMenu_EstruturaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm :TDM_Servidor;


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
    lEnder_Ini := FEnder + '\CONFIG_HORAS_TRAB.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_HORAS_TRAB.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  mvPrincipal.HideMaster;
  FMensagem := TFancyDialog.Create(frmPrincipal);

  FDm := TDM_Servidor.Create(Nil);

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
  if not Assigned(frmConfiguracoes) then
    Application.CreateForm(TfrmConfiguracoes,frmConfiguracoes);
  frmConfiguracoes.Show;
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




  {
  CORES DO APP
    Verde Escuro: #FF363428
    Verde Claro: #FFA1B24E
    Componentes: #FFD9D7CA
  }

