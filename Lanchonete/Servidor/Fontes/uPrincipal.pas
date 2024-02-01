unit uPrincipal;

{Senha do App para envio de email atraves de um app
ivng xyrx fwmp igix
}
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

  IniFiles,
  uFuncoes,
  {$Region 'Rotas'}
    uRota.Usuario,
    uRota.Fornecedores,
    uRota.FORNECEDOR.ENDERECO,
    uRota.FORNECEDOR.TELEFONES,
    uRota.Clientes,
    uRota.IMPRESSORAS,
    uRota.SETOR,
    uRota.EMPRESA,
    uRota.EMPRESA_ENDERECO,
    uRota.EMPRESA_TELEFONES,
    uRota.EMPRESA_EMAIL,
    uRota.IMPRESSORA_SETOR,
    uRota.GRUPO,
    uRota.SUB_GRUPO,
    uRota.PAISES,
    uRota.REGIOES,
    uRota.UNIDADE_FEDERATIVA,
    uRota.MUNICIPIOS,
    uRota.UNIDADE,
    uRota.PRODUTO,
    uRota.FORNECEDOR_EMAIL,
  {$EndRegion 'Rotas'}

  {$Region 'Modelos'}
    uModel.Usuario,
    uModel.Fornecedor,
    uModel.Cliente,
  {$EndRegion 'Modelos'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.MultiView, FMX.Edit,

  uDm_Lanchonete, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmPrincipal = class(TForm)
    lytHeader: TLayout;
    lytFooter: TLayout;
    lytDetail: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytMenu: TLayout;
    imgMenu: TImage;
    rctFooter: TRectangle;
    lytPorta: TLayout;
    rctPorta: TRectangle;
    lbPorta: TLabel;
    lytDataBase: TLayout;
    rctDataBase: TRectangle;
    lbDataBase: TLabel;
    mvPrincipal: TMultiView;
    lytConfig: TLayout;
    rctMenu: TRectangle;
    lytPrincipal: TLayout;
    imgMenu_Config: TImage;
    lbMenu_Config: TLabel;
    rctMenu_Config: TRectangle;
    lytMenu_Fechar: TLayout;
    rctMenu_Fechar: TRectangle;
    lbMenu_Fechar: TLabel;
    imgMenuFechar: TImage;
    rctMenu_Principal: TRectangle;
    StyleBook_Principal: TStyleBook;
    imgDataBase: TImage;
    lytEstrutura: TLayout;
    rctEstrutura: TRectangle;
    imgEstrutura: TImage;
    lbEstrutura: TLabel;
    lytAtualiza_Historico: TLayout;
    rctAtualiza_Historico: TRectangle;
    imgAtualiza_Historico: TImage;
    lytCriaUnit: TLayout;
    rctCriaUnit: TRectangle;
    imgCriaUnit: TImage;
    lbCriaUnit: TLabel;
    lytVersao: TLayout;
    rctVersao: TRectangle;
    lbVersao: TLabel;
    Memo_Historico: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctMenu_ConfigClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rctMenu_FecharClick(Sender: TObject);
    procedure rctMenu_PrincipalClick(Sender: TObject);
    procedure imgDataBaseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rctEstruturaClick(Sender: TObject);
    procedure rctAtualiza_HistoricoClick(Sender: TObject);
    procedure rctCriaUnitClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;

    procedure Fechar(Sender: TObject);
    procedure RefazerEstrutura(Sender: TObject);
    procedure ThreadEnd_RefazerEstrutura(Sender: TOBject);
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
  ,uCriarEstrutura;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FIniFile);
  {$ELSE}
    FMensagem.DisposeOf;
    FIniFile.DisposeOf;
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
    lEnder_Ini := FEnder + '\CONFIG_LANCHONETE.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_LANCHONETE.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  mvPrincipal.HideMaster;
  FMensagem := TFancyDialog.Create(frmPrincipal);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  lArq :String;
begin
  imgDataBase.Visible := not DM_Lanchonete.Firebird_Conectado;
  if DM_Lanchonete.Firebird_Conectado then
    lbDataBase.Text := 'CONECTADO'
  else
    lbDataBase.Text := 'DESCONECTADO';

  lbPorta.Tag := FIniFile.ReadInteger('SERVER','PORTA',0);
  lbPorta.Text := 'Porta: ' + lbPorta.Tag.ToString;

  {$Region 'Configurando Horse'}
    THorse.Use(Jhonson());
    THorse.Use(CORS);

    {$Region 'Registrando rotas'}
      uRota.Usuario.RegistrarRotas;
      uRota.Fornecedores.RegistrarRotas;
      uRota.FORNECEDOR.ENDERECO.RegistrarRotas;
      uRota.FORNECEDOR.TELEFONES.RegistrarRotas;
      uRota.FORNECEDOR_EMAIL.RegistrarRotas;
      uRota.Clientes.RegistrarRotas;
      uRota.IMPRESSORAS.RegistrarRotas;
      uRota.SETOR.RegistrarRotas;
      uRota.EMPRESA.RegistrarRotas;
      uRota.EMPRESA_ENDERECO.RegistrarRotas;
      uRota.EMPRESA_TELEFONES.RegistrarRotas;
      uRota.EMPRESA_EMAIL.RegistrarRotas;
      uRota.IMPRESSORA_SETOR.RegistrarRotas;
      uRota.GRUPO.RegistrarRotas;
      uRota.SUB_GRUPO.RegistrarRotas;
      uRota.PAISES.RegistrarRotas;
      uRota.REGIOES.RegistrarRotas;
      uRota.UNIDADE_FEDERATIVA.RegistrarRotas;
      uRota.MUNICIPIOS.RegistrarRotas;
      uRota.UNIDADE.RegistrarRotas;
      uRota.PRODUTO.RegistrarRotas;
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

procedure TfrmPrincipal.Listar_Historico;
var
  lQuery :TFDQuery;
  lMensagem :String;
begin
  try
    try
      Memo_Historico.Lines.Clear;

      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := DM_Lanchonete.FDC_Lanchonete;

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
  end;
end;

procedure TfrmPrincipal.imgDataBaseClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Erro na conexão',DM_Lanchonete.Firebird_Erro,'Ok');
end;

procedure TfrmPrincipal.rctAtualiza_HistoricoClick(Sender: TObject);
begin
  Listar_Historico;
end;

procedure TfrmPrincipal.rctCriaUnitClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  if not Assigned(frmCriarEstrutura) then
    Application.CreateForm(TfrmCriarEstrutura,frmCriarEstrutura);
  frmCriarEstrutura.Show;
end;

procedure TfrmPrincipal.rctEstruturaClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja refazer a estrutura do banco de dados?','Sim',RefazerEstrutura,'Não');
end;

procedure TfrmPrincipal.RefazerEstrutura(Sender :TObject);
var
  t :TThread;

begin
  TLoading.Show(frmPrincipal,'Refazendo estrutura');

  t := TThread.CreateAnonymousThread(
    procedure
    var
      lQuery_Hist :TFDQuery;
    begin
      lQuery_Hist := TFDQuery.Create(Nil);
      lQuery_Hist.Connection := DM_Lanchonete.FDC_Lanchonete;
      TFuncoes.Gravar_Hitorico(lQuery_Hist,'Refazendo estrutura');
      DM_Lanchonete.Refazendo_Estrutura;

      {$IFDEF MSWINDOWS}
        FreeAndNil(lQuery_Hist);
      {$ELSE}
        lQuery_Hist.DisposeOf;
      {$ENDIF}
    end);

  t.OnTerminate := ThreadEnd_RefazerEstrutura;
  t.Start;

end;

procedure TfrmPrincipal.ThreadEnd_RefazerEstrutura(Sender :TOBject);
begin
  TLoading.Hide;
  Listar_Historico;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmPrincipal.rctMenu_ConfigClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  if not Assigned(frmConfiguracoes) then
    Application.CreateForm(TfrmConfiguracoes,frmConfiguracoes);
  frmConfiguracoes.Show;
end;

procedure TfrmPrincipal.rctMenu_FecharClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja fechar o Servidor?','Sim',Fechar,'Não');
end;

procedure TfrmPrincipal.Fechar(Sender :TObject);
begin
  Close;
end;

procedure TfrmPrincipal.rctMenu_PrincipalClick(Sender: TObject);
begin
  mvPrincipal.ShowMaster;
end;

end.








