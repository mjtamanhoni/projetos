unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,System.IOUtils,

  uFuncoes,
  IniFiles,
  uDM_Global,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
  {$EndRegion '99 Coders'}

  {$Region 'Refazendo Estrutura'}
    uModel.Usuario,
    uModel.Tabela.Precos,
    uModel.Projetos,
    uModel.Empresa,
    uModel.Cliente,
    uModel.Apontamentos.Horas,
  {$EndRegion}


  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.TabControl, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.MultiView, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPrincipal = class(TForm)
    tcPrincipal: TTabControl;
    tiDashboard: TTabItem;
    tiLista: TTabItem;
    tiManutencao: TTabItem;
    lytDB_Header: TLayout;
    lytDB_Detail: TLayout;
    lytDB_Footer: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytL_Detail: TLayout;
    lytM_Detail: TLayout;
    imgDB_Menu: TImage;
    rctFooter: TRectangle;
    imgEscolha: TImage;
    imgDB_002: TImage;
    imgDB_001: TImage;
    imgNovo: TImage;
    imgEdit: TImage;
    imgSalvar: TImage;
    imgCancelar: TImage;
    imgDashboard: TImage;
    imgLista: TImage;
    mvPrincipal: TMultiView;
    rctMenuPrincipal: TRectangle;
    lytMenu_Principal: TLayout;
    lytMenuFechar: TLayout;
    imgMenuFechar: TImage;
    lytMenu_Config: TLayout;
    imgMenu_Config: TImage;
    lytMenu_Estrutura: TLayout;
    imgMenu_Estrutura: TImage;
    ShadowEffect3: TShadowEffect;
    StyleBook_Principal: TStyleBook;
    lytMenu: TLayout;
    imgMenu: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgEscolhaClick(Sender: TObject);
    procedure imgDB_001Click(Sender: TObject);
    procedure imgDB_002Click(Sender: TObject);
    procedure imgDB_MenuClick(Sender: TObject);
    procedure imgMenuFecharClick(Sender: TObject);
    procedure imgMenu_ConfigClick(Sender: TObject);
    procedure imgMenu_EstruturaClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;

    {$Region 'Modelo de Dados'}
      FTUSUARIO :TUSUARIO;
      FTEMPRESA :TEMPRESA;
      FTTABELA_PRECOS :TTABELA_PRECOS;
      FTPROJETOS :TPROJETOS;
      FTCLIENTE :TCLIENTE;
      FTAPONTAMENTO_HORAS :TAPONTAMENTO_HORAS;
    {$EndRegion 'Modelo de Dados'}

    procedure Novo_Apontamento(Sender: TOBject);
    procedure Salvar_Apontamento(Sender: TObject);
    procedure Cancelar_Apontamento(Sender: TOBject);
    procedure Editar_Apontamento(Sender: TOBject);
    procedure RefazerEstrutura(Sender: TOBject);
    procedure ThreadEnd_RefazerEstrutura(Sender: TOBject);

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uConfig,
  uMenu;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FIniFile);
    FreeAndNil(FMensagem);
    FreeAndNil(FTUSUARIO);
    FreeAndNil(FTEMPRESA);
    FreeAndNil(FTCLIENTE);
    FreeAndNil(FTTABELA_PRECOS);
    FreeAndNil(FTPROJETOS);
    FreeAndNil(FTAPONTAMENTO_HORAS);
  {$ELSE}
    FIniFile.DisposeOf;
    FMensagem.DisposeOf;
    FTUSUARIO.DisposeOf;
    FTEMPRESA.DisposeOf;
    FTCLIENTE.DisposeOf;
    FTTABELA_PRECOS.DisposeOf;
    FTPROJETOS.DisposeOf;
    FTAPONTAMENTO_HORAS.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FMensagem := TFancyDialog.Create(frmPrincipal);
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\GESTOR_HORA.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'GESTOR_HORA.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FTUSUARIO := TUSUARIO.Create(DM.FDC_Conexao);
  FTEMPRESA := TEMPRESA.Create(DM.FDC_Conexao);
  FTTABELA_PRECOS := TTABELA_PRECOS.Create(DM.FDC_Conexao);
  FTPROJETOS := TPROJETOS.Create(DM.FDC_Conexao);
  FTCLIENTE := TCLIENTE.Create(DM.FDC_Conexao);
  FTAPONTAMENTO_HORAS := TAPONTAMENTO_HORAS.Create(DM.FDC_Conexao);

  imgDB_001.Visible := False;
  imgDB_002.Visible := False;
  tcPrincipal.ActiveTab := tiDashboard;
end;

procedure TfrmPrincipal.imgDB_001Click(Sender: TObject);
begin
  case imgDB_001.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja inserir um novo Apontamento?','Sim',Novo_Apontamento,'Não');
    1:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja salvar as alterações?','Sim',Salvar_Apontamento,'Não');
  end;
end;

procedure TfrmPrincipal.imgDB_002Click(Sender: TObject);
begin
  case imgDB_002.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja editar o Apontamento selecionado?','Sim',Editar_Apontamento,'Não');
    1:FMensagem.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações?','Sim',Cancelar_Apontamento,'Não');
  end;
end;

procedure TfrmPrincipal.imgDB_MenuClick(Sender: TObject);
begin
  mvPrincipal.ShowMaster;
end;

procedure TfrmPrincipal.Editar_Apontamento(Sender :TOBject);
begin
  imgDB_001.Tag := 1;
  imgDB_002.Tag := 1;
  imgDB_Menu.Visible := False;;
  imgDB_001.Bitmap := imgSalvar.Bitmap;
  imgDB_002.Bitmap := imgCancelar.Bitmap;
  lbTitulo.Text := 'Manutenção';
  tcPrincipal.GotoVisibleTab(2);
end;

procedure TfrmPrincipal.Cancelar_Apontamento(Sender :TOBject);
begin
  //Thread para salvar o apontmento..
  imgDB_001.Tag := 0;
  imgDB_002.Tag := 0;
  imgDB_Menu.Visible := True;
  imgDB_001.Bitmap := imgNovo.Bitmap;
  imgDB_002.Bitmap := imgEdit.Bitmap;
  lbTitulo.Text := 'Apontamentos';
  tcPrincipal.GotoVisibleTab(1);
end;

procedure TfrmPrincipal.Novo_Apontamento(Sender :TOBject);
begin
  imgDB_001.Tag := 1;
  imgDB_002.Tag := 1;
  imgDB_Menu.Visible := False;
  imgDB_001.Bitmap := imgSalvar.Bitmap;
  imgDB_002.Bitmap := imgCancelar.Bitmap;
  lbTitulo.Text := 'Manutenção';
  tcPrincipal.GotoVisibleTab(2);
end;

procedure TfrmPrincipal.Salvar_Apontamento(Sender :TObject);
begin
  //Thread para salvar o apontmento..
  imgDB_001.Tag := 0;
  imgDB_002.Tag := 0;
  imgDB_Menu.Visible := True;
  imgDB_001.Bitmap := imgNovo.Bitmap;
  imgDB_002.Bitmap := imgEdit.Bitmap;
  lbTitulo.Text := 'Apontamentos';
  tcPrincipal.GotoVisibleTab(1);
end;

procedure TfrmPrincipal.imgEscolhaClick(Sender: TObject);
begin
  case imgEscolha.Tag of
    0:begin
      imgEscolha.Tag := 1;
      imgEscolha.Bitmap := imgDashboard.Bitmap;
      imgDB_001.Bitmap := imgNovo.Bitmap;
      imgDB_002.Bitmap := imgEdit.Bitmap;
      imgDB_002.Visible := True;
      imgDB_001.Visible := True;
      lbTitulo.Text := 'Apontamentos';
      tcPrincipal.GotoVisibleTab(1);
    end;
    1:begin
      imgEscolha.Tag := 0;
      imgEscolha.Bitmap := imgLista.Bitmap;
      imgDB_001.Visible := False;
      imgDB_002.Visible := False;
      lbTitulo.Text := 'Dashboard';
      tcPrincipal.GotoVisibleTab(0);
    end;
  end;
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  if not Assigned(frmMenu) then
    Application.CreateForm(TfrmMenu,frmMenu);
  frmMenu.Show;
end;

procedure TfrmPrincipal.imgMenuFecharClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
end;

procedure TfrmPrincipal.imgMenu_ConfigClick(Sender: TObject);
begin
  if not Assigned(frmConfig) then
    Application.CreateForm(TfrmConfig,frmConfig);
  frmConfig.Show;
end;

procedure TfrmPrincipal.imgMenu_EstruturaClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja refazer a extrutura do banco de dados?','Sim',RefazerEstrutura,'Não');
end;

procedure TfrmPrincipal.RefazerEstrutura(Sender :TOBject);
var
  t :TThread;

begin

  TLoading.Show(frmPrincipal,'Refazendo Estrutura');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lFDQ_Query :TFDQuery;
    lFDQ_Query_1 :TFDQuery;
  begin
    lFDQ_Query := TFDQuery.Create(Nil);
    lFDQ_Query.Connection := DM.FDC_Conexao;
    lFDQ_Query_1 := TFDQuery.Create(Nil);
    lFDQ_Query_1.Connection := DM.FDC_Conexao;

    TThread.Synchronize(nil,procedure
    begin
      TLoading.ChangeText('Estrutura Usuário');
    end);
    FTUSUARIO.Atualizar_Estrutura(lFDQ_Query,True);

    TThread.Synchronize(nil,procedure
    begin
      TLoading.ChangeText('Estrutura Empresa');
    end);
    FTEMPRESA.Atualizar_Estrutura(lFDQ_Query,lFDQ_Query_1,True);

    TThread.Synchronize(nil,procedure
    begin
      TLoading.ChangeText('Estrutura Cliente');
    end);
    FTCLIENTE.Atualizar_Estrutura(lFDQ_Query,lFDQ_Query_1,True);

    TThread.Synchronize(nil,procedure
    begin
      TLoading.ChangeText('Estrutura Tabela de Preços');
    end);
    FTTABELA_PRECOS.Atualizar_Estrutura(lFDQ_Query,True);

    TThread.Synchronize(nil,procedure
    begin
      TLoading.ChangeText('Estrutura Projetos');
    end);
    FTPROJETOS.Atualizar_Estrutura(lFDQ_Query,True);

    TThread.Synchronize(nil,procedure
    begin
      TLoading.ChangeText('Estrutura Apontamento de Horas');
    end);
    FTAPONTAMENTO_HORAS.Atualizar_Estrutura(lFDQ_Query,True);

    {$IFDEF MSWINDOWS}
      FreeAndNil(lFDQ_Query);
      FreeAndNil(lFDQ_Query_1);
    {$ELSE}
      lFDQ_Query.DisposeOf;
      lFDQ_Query_1.DisposeOf;
    {$ENDIF}
  end);


  t.OnTerminate := ThreadEnd_RefazerEstrutura;
  t.Start;

end;

procedure TfrmPrincipal.ThreadEnd_RefazerEstrutura(Sender :TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'',Exception(TThread(Sender).FatalException).Message)
end;

end.
