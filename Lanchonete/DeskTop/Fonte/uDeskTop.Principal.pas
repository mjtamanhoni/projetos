unit uDeskTop.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
  {$EndRegion}

  IniFiles,
  uDm_DeskTop,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.MultiView, FMX.ScrollBox, FMX.Memo, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Effects, FMX.Ani,
  FMX.Menus, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmPrincipal = class(TForm)
    StyleBook_Principal: TStyleBook;
    lytPrincipal: TLayout;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytMenu: TLayout;
    rctMenu_Principal: TRectangle;
    imgMenu: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    lytVersao: TLayout;
    rctVersao: TRectangle;
    lbVersao: TLabel;
    lytDataBase: TLayout;
    rctDataBase: TRectangle;
    lbDataBase: TLabel;
    imgDataBase: TImage;
    lytDetail: TLayout;
    mvPrincipal: TMultiView;
    rctMenu: TRectangle;
    lytConfig: TLayout;
    rctMenu_Config: TRectangle;
    imgMenu_Config: TImage;
    lbMenu_Config: TLabel;
    lytMenu_Fechar: TLayout;
    rctMenu_Fechar: TRectangle;
    imgMenuFechar: TImage;
    lbMenu_Fechar: TLabel;
    lytFechar: TLayout;
    rctFechar: TRectangle;
    imgFechar: TImage;
    lytBotoes: TLayout;
    rctBotoes: TRectangle;
    lytBtCadastro: TLayout;
    lytBtCadastro_Img: TLayout;
    lytBtCadastro_Label: TLayout;
    imgCadastro: TImage;
    lbCadastro: TLabel;
    lytBtMovimento: TLayout;
    lytBtMovimento_Img: TLayout;
    imgBtMovimento: TImage;
    lytBtMovimento_Label: TLayout;
    lbBtMovimento_Label: TLabel;
    lytBtConsultas: TLayout;
    lytBtConsultas_Img: TLayout;
    imgBtConsultas: TImage;
    lytBtConsultas_Label: TLayout;
    lbBtConsultas: TLabel;
    lytBtRelatorios: TLayout;
    lytBtRelatorios_Img: TLayout;
    imgBtRelatorios: TImage;
    lytBtRelatorios_Label: TLayout;
    lbBtRelatorios: TLabel;
    rctBtCadastro: TRectangle;
    rctBtConsultas: TRectangle;
    rctBtMovimento: TRectangle;
    rctBtRelatorios: TRectangle;
    rctMenuCadastro: TRectangle;
    seBtCadastro: TShadowEffect;
    seBtConsultas: TShadowEffect;
    seBtMovimento: TShadowEffect;
    seBtRelatorios: TShadowEffect;
    FloatAnimation_MenuCad: TFloatAnimation;
    lytDetail_Espacos: TLayout;
    rctMenuMovimento: TRectangle;
    FloatAnimation_MenuMov: TFloatAnimation;
    rctMenuConsulta: TRectangle;
    rctMenuRelatorio: TRectangle;
    FloatAnimation_MenuRel: TFloatAnimation;
    FloatAnimation_MenuCon: TFloatAnimation;
    sbMenu_Cadastro: TScrollBox;
    rctMenuCad_Local: TRectangle;
    lytMenuCad_Local_Icon: TLayout;
    MenuCad_Local_Label: TLayout;
    lbMenuCad_Local: TLabel;
    imgMenuCad_Local: TImage;
    lytMenuCad_Local_Prox: TLayout;
    imgMenuCad_Local_Prox: TImage;
    rctMenuCad_User: TRectangle;
    lytMenuCad_User_Icon: TLayout;
    imbMenuCad_User: TImage;
    lytMenuCad_User_Label: TLayout;
    MenuCad_User_Prox: TLayout;
    imgMenuCad_User: TImage;
    rctMenuCad_Emp: TRectangle;
    MenuCad_Emp_Icon: TLayout;
    imgMenuCad_Emp: TImage;
    lytMenuCad_Emp_Label: TLayout;
    lbMenuCad_Emp: TLabel;
    lytMenuCad_Emp_Prox: TLayout;
    imgMenuCad_Emp_Prox: TImage;
    rctMenuCad_Fornec: TRectangle;
    lytMenuCad_Fornec_Icon: TLayout;
    imgMenuCad_Fornec: TImage;
    MenuCad_Fornec_Label: TLayout;
    lbMenuCad_Fornec: TLabel;
    lytMenuCad_Fornec_Prox: TLayout;
    imgMenuCad_Fornec_prox: TImage;
    rctMenuCad_Cliente: TRectangle;
    lytMenuCad_Cliente_Icon: TLayout;
    imgMenuCad_Cliente: TImage;
    lytMenuCad_Cliente_Label: TLayout;
    lbMenuCad_Cliente: TLabel;
    lytMenuCad_Cliente_Prox: TLayout;
    imgMenuCad_Cliente_Prox: TImage;
    rctMenuCad_Produto: TRectangle;
    lytMenuCad_Produto_Icon: TLayout;
    imgMenuCad_Produto: TImage;
    lytMenuCad_Produto_Label: TLayout;
    lbMenuCad_Produto: TLabel;
    lytMenuCad_Produto_Prox: TLayout;
    imgMenuCad_Produto_Prox: TImage;
    rctMenuCad_Pagto: TRectangle;
    lytMenuCad_Pagto_Icon: TLayout;
    imgMenuCad_Pagto: TImage;
    lytMenuCad_Pagto_Label: TLayout;
    lbMenuCad_Pagto: TLabel;
    lytMenuCad_Pagto_Prox: TLayout;
    imgMenuCad_Pagto_Prox: TImage;
    rctMenuCad_Imp: TRectangle;
    lytMenuCad_Imp_Icon: TLayout;
    imgMenuCad_Imp: TImage;
    lytMenuCad_Imp_Label: TLayout;
    lbMenuCad_Imp: TLabel;
    lytMenuCad_Imp_Prox: TLayout;
    imgMenuCad_Imp_Prox: TImage;
    lytMenuCadUser_Tit: TLayout;
    lytMenuCadUser_Usuario: TLayout;
    lbMenuCadUser_Usuario: TLabel;
    lytMenuCadUser_Permissao: TLayout;
    lbMenuCadUser_Permissao: TLabel;
    rctMenuCadUser_Usuario: TRectangle;
    rctMenuCadUser_Permissao: TRectangle;
    lbMenuCad_user: TLabel;
    imgExpandir: TImage;
    imgRetrair: TImage;
    lytMenuCad_Local_Tit: TLayout;
    lytMenuCad_Local_Paises: TLayout;
    rctMenuCad_Local_Paises: TRectangle;
    lbMenuCad_Local_Paises: TLabel;
    lytMenuCad_Local_Reg: TLayout;
    rctMenuCad_Local_Reg: TRectangle;
    lbMenuCad_Local_Reg: TLabel;
    lytMenuCad_Local_UF: TLayout;
    rctMenuCad_Local_UF: TRectangle;
    lbMenuCad_Local_UF: TLabel;
    lytMenuCad_Local_Mun: TLayout;
    rctMenuCad_Local_Mun: TRectangle;
    lbMenuCad_Local_Mun: TLabel;
    lytMenuCad_Emp_Tit: TLayout;
    lytMenuCad_Fornec_Tit: TLayout;
    lytMenuCad_Cliente_Tit: TLayout;
    lytMenuCad_Produto_Tit: TLayout;
    lytMenuCad_Produto_Grupo: TLayout;
    rctMenuCad_Produto_Grupo: TRectangle;
    lbMenuCad_Produto_Grupo: TLabel;
    lytMenuCad_Produto_SubGrupo: TLayout;
    rctMenuCad_Produto_SubGrupo: TRectangle;
    lbMenuCad_Produto_SubGrupo: TLabel;
    lytMenuCad_Produto_Un: TLayout;
    rctMenuCad_Produto_Un: TRectangle;
    lbMenuCad_Produto_Un: TLabel;
    lytMenuCad_Produto_Prod: TLayout;
    rctMenuCad_Produto_Prod: TRectangle;
    lbMenuCad_Produto_Prod: TLabel;
    lytMenuCad_Imp_Tit: TLayout;
    lytMenuCad_Pagto_Tit: TLayout;
    lytMenuCad_Pagto_Forma: TLayout;
    rctMenuCad_Pagto_Forma: TRectangle;
    lbMenuCad_Pagto_Forma: TLabel;
    lytMenuCad_Pagto_Cond: TLayout;
    rctMenuCad_Pagto_Cond: TRectangle;
    lbMenuCad_Pagto_Cond: TLabel;
    sbMenuMovimento: TScrollBox;
    rctMenuMov_Caixa: TRectangle;
    lytMenuMov_Caixa_Tit: TLayout;
    lytMenuMov_Caixa_Label: TLayout;
    lbMenuMov_Caixa: TLabel;
    lytMenuMov_Caixa_Prox: TLayout;
    imgMenuMov_Caixa_Prox: TImage;
    lytMenuMov_Caixa_Icon: TLayout;
    imgMenuMov_Caixa: TImage;
    lytMenuMov_Compra: TRectangle;
    lytMenuMov_Compra_Tit: TLayout;
    lytMenuMov_Compra_Icon: TLayout;
    imgMenuMov_Compra: TImage;
    lytMenuMov_Compra_IconProx: TLayout;
    imgMenuMov_Compra_Prox: TImage;
    lytMenuMov_Compra_Label: TLayout;
    lbMenuMov_Compra: TLabel;
    rctMenuMov_Venda: TRectangle;
    lytMenuMov_Venda_Tit: TLayout;
    lytMenuMov_Venda_Icon: TLayout;
    imgMenuMov_Venda_Icon: TImage;
    lytMenuMov_Venda_Label: TLayout;
    lbMenuMov_Venda: TLabel;
    lytMenuMov_Venda_Prox: TLayout;
    imgMenuMov_Venda_Prox: TImage;
    ListView1: TListView;
    lytUser_Logado: TLayout;
    rctUser_Logado: TRectangle;
    lbUser_Logado: TLabel;
    rctMenuCad_Setor: TRectangle;
    lytMenuCad_Setor: TLayout;
    lytMenuCad_Setor_Icon: TLayout;
    imgMenuCad_Setor: TImage;
    lytMenuCad_Setor_Label: TLayout;
    lbMenuCad_Setor: TLabel;
    lytMenuCad_Setor_Prox: TLayout;
    imgMenuCad_Setor_Prox: TImage;

    procedure rctFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctBtCadastroClick(Sender: TObject);
    procedure rctBtConsultasClick(Sender: TObject);
    procedure rctBtMovimentoClick(Sender: TObject);
    procedure rctBtRelatoriosClick(Sender: TObject);
    procedure lytDetail_EspacosResize(Sender: TObject);
    procedure rctMenuCad_UserClick(Sender: TObject);
    procedure rctMenuCad_LocalClick(Sender: TObject);
    procedure rctMenuCad_ProdutoClick(Sender: TObject);
    procedure rctMenuCad_PagtoClick(Sender: TObject);
    procedure rctMenuCad_ClienteClick(Sender: TObject);
    procedure rctMenuCad_Local_MunClick(Sender: TObject);
    procedure rctMenuCad_Local_PaisesClick(Sender: TObject);
    procedure rctMenuCad_Local_RegClick(Sender: TObject);
    procedure rctMenuCad_Local_UFClick(Sender: TObject);
    procedure rctMenuCad_EmpClick(Sender: TObject);
    procedure rctMenuCad_FornecClick(Sender: TObject);
    procedure rctMenuCad_ImpClick(Sender: TObject);
    procedure rctMenuCad_Pagto_CondClick(Sender: TObject);
    procedure rctMenuCad_Pagto_FormaClick(Sender: TObject);
    procedure rctMenuCad_Produto_GrupoClick(Sender: TObject);
    procedure rctMenuCad_Produto_ProdClick(Sender: TObject);
    procedure rctMenuCad_Produto_SetorClick(Sender: TObject);
    procedure rctMenuCad_Produto_SubGrupoClick(Sender: TObject);
    procedure rctMenuCad_Produto_UnClick(Sender: TObject);
    procedure rctMenuCadUser_PermissaoClick(Sender: TObject);
    procedure rctMenuCadUser_UsuarioClick(Sender: TObject);
    procedure lytMenuMov_CompraClick(Sender: TObject);
    procedure rctMenuMov_CaixaClick(Sender: TObject);
    procedure rctMenuMov_VendaClick(Sender: TObject);
    procedure rctMenu_PrincipalClick(Sender: TObject);
    procedure rctMenu_FecharClick(Sender: TObject);
    procedure rctMenu_ConfigClick(Sender: TObject);
    procedure rctMenuCad_SetorClick(Sender: TObject);
  private
    { Private declarations }
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FFechar_Sistema :Boolean;
    procedure Abortar_Fechamento(Sender: TOBject);
    procedure Confirmar_Fechamento(Sender :TObject);
    procedure FechaMenu(Sender:TObject);

    procedure Anima_MenuCadastro(const AFechar:Boolean=False);
    procedure Anima_MenuConsulta(const AFechar:Boolean=False);
    procedure Anima_MenuMovimento(const AFechar:Boolean=False);
    procedure Anima_MenuRelatorio(const AFechar:Boolean=False);

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uDeskTop.Config,
  uDeskTop.CadUsuario,
  uDeskTop.CadPaises,
  uDeskTop.CadRegioes,
  uDeskTop.CadUF,
  uDeskTop.CadMunicipios,
  uDeskTop.CadEmpresa,
  uDeskTop.CadFornecedor,
  uDeskTop.CadCliente;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FFechar_Sistema then
    Abortar_Fechamento(Sender);

  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
  {$ELSE}
    FMensagem.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.Confirmar_Fechamento(Sender :TObject);
begin
  FFechar_Sistema := True;
  Close;
end;

procedure TfrmPrincipal.Abortar_Fechamento(Sender :TOBject);
begin
  Abort;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  lEnder_Ini :String;
begin

  //Escondendo componentes...
  rctMenuCadastro.Visible := False;
  rctMenuMovimento.Visible := False;
  rctMenuConsulta.Visible := False;
  rctMenuRelatorio.Visible := False;

  FFechar_Sistema := False;
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_DESKTOP.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_DESKTOP.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  mvPrincipal.HideMaster;
  FMensagem := TFancyDialog.Create(frmPrincipal);
  lbUser_Logado.Text := Dm_DeskTop.FDMem_UsuariosNOME.AsString;

end;

procedure TfrmPrincipal.lytDetail_EspacosResize(Sender: TObject);
begin

  rctMenuCadastro.Position.X := lytBtCadastro.Position.X;
  rctMenuCadastro.Width := lytBtCadastro.Width;
  rctMenuCadastro.Height := lytDetail_Espacos.Height - 10;

  rctMenuConsulta.Position.X := lytBtConsultas.Position.X;
  rctMenuConsulta.Width := lytBtConsultas.Width;
  rctMenuConsulta.Height := lytDetail_Espacos.Height - 10;

  rctMenuMovimento.Position.X := lytBtMovimento.Position.X;
  rctMenuMovimento.Width := lytBtMovimento.Width;
  rctMenuMovimento.Height := lytDetail_Espacos.Height - 10;

  rctMenuRelatorio.Position.X := lytBtRelatorios.Position.X;
  rctMenuRelatorio.Width := lytBtRelatorios.Width;
  rctMenuRelatorio.Height := lytDetail_Espacos.Height - 10;

end;

procedure TfrmPrincipal.lytMenuMov_CompraClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Movimento Compra','Abre formulário do movimento de compra','OK');
  rctMenuMovimento.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_PagtoClick(Sender: TObject);
begin
  case rctMenuCad_Pagto.Tag of
    0:begin
      //Expandir...
      imgMenuCad_Pagto_Prox.Bitmap := imgRetrair.Bitmap;
      lytMenuCad_Pagto_Forma.Visible := True;
      lytMenuCad_Pagto_Cond.Visible := True;
      rctMenuCad_Pagto.Height := 130;
      rctMenuCad_Pagto.Tag := 1;
      rctMenuCad_Pagto.Opacity := 1;
    end;
    1:begin
      //Retrair...
      imgMenuCad_Pagto_Prox.Bitmap := imgExpandir.Bitmap;
      lytMenuCad_Pagto_Forma.Visible := False;
      lytMenuCad_Pagto_Cond.Visible := False;
      rctMenuCad_Pagto.Height := 50;
      rctMenuCad_Pagto.Tag := 0;
      rctMenuCad_Pagto.Opacity := 0.5;
    end;
  end;
end;

procedure TfrmPrincipal.rctMenuCad_Pagto_CondClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Cond. Pagto','Abre formulário do cadastro das condições de pagamentos','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Pagto_FormaClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Forma Pagto','Abre formulário do cadastro das formas de pagamento','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctBtCadastroClick(Sender: TObject);
begin

  rctMenuMovimento.Visible := False;
  rctMenuConsulta.Visible := False;
  rctMenuRelatorio.Visible := False;

  rctBtCadastro.Opacity := 1;
  rctBtConsultas.Opacity := 0.5;
  rctBtMovimento.Opacity := 0.5;
  rctBtRelatorios.Opacity := 0.5;

  Anima_MenuCadastro(rctMenuCadastro.Visible);
end;

procedure TfrmPrincipal.rctBtConsultasClick(Sender: TObject);
begin

  rctMenuMovimento.Visible := False;
  rctMenuCadastro.Visible := False;
  rctMenuRelatorio.Visible := False;

  rctBtCadastro.Opacity := 0.5;
  rctBtConsultas.Opacity := 1;
  rctBtMovimento.Opacity := 0.5;
  rctBtRelatorios.Opacity := 0.5;

  Anima_MenuConsulta;
end;

procedure TfrmPrincipal.rctBtMovimentoClick(Sender: TObject);
begin

  rctMenuCadastro.Visible := False;
  rctMenuConsulta.Visible := False;
  rctMenuRelatorio.Visible := False;

  rctBtCadastro.Opacity := 0.5;
  rctBtConsultas.Opacity := 0.5;
  rctBtMovimento.Opacity := 1;
  rctBtRelatorios.Opacity := 0.5;

  Anima_MenuMovimento;
end;

procedure TfrmPrincipal.rctBtRelatoriosClick(Sender: TObject);
begin

  rctMenuCadastro.Visible := False;
  rctMenuConsulta.Visible := False;
  rctMenuMovimento.Visible := False;

  rctBtCadastro.Opacity := 0.5;
  rctBtConsultas.Opacity := 0.5;
  rctBtMovimento.Opacity := 0.5;
  rctBtRelatorios.Opacity := 1;

  Anima_MenuRelatorio;
end;

procedure TfrmPrincipal.FechaMenu(Sender:TObject);
begin
  rctMenuCadastro.Visible := False;
  rctMenuMovimento.Visible := False;
  rctMenuConsulta.Visible := False;
  rctMenuRelatorio.Visible := False;
end;

procedure TfrmPrincipal.Anima_MenuCadastro(const AFechar:Boolean=False);
begin
  rctMenuCadastro.Position.Y := 0;
  rctMenuCadastro.Position.X := lytBtCadastro.Position.X;
  rctMenuCadastro.Width := lytBtCadastro.Width;
  rctMenuCadastro.Height := 0;
  if rctMenuCadastro.Visible then
  begin
    FloatAnimation_MenuCad.StartValue := lytDetail_Espacos.Height - 10;
    FloatAnimation_MenuCad.StopValue := 0;
  end
  else
  begin
    FloatAnimation_MenuCad.StartValue := 0;
    FloatAnimation_MenuCad.StopValue := lytDetail_Espacos.Height - 10;
  end;
  rctMenuCadastro.Visible := (not rctMenuCadastro.Visible);
  FloatAnimation_MenuCad.Start;
end;

procedure TfrmPrincipal.Anima_MenuConsulta(const AFechar:Boolean=False);
begin
  rctMenuConsulta.Position.Y := 0;
  rctMenuConsulta.Position.X := lytBtConsultas.Position.X;
  rctMenuConsulta.Width := lytBtConsultas.Width;
  rctMenuConsulta.Height := lytDetail_Espacos.Height - 10;
  if rctMenuConsulta.Visible then
  begin
    FloatAnimation_MenuCon.StartValue := lytDetail_Espacos.Height - 10;
    FloatAnimation_MenuCon.StopValue := 0;
  end
  else
  begin
    FloatAnimation_MenuCon.StartValue := 0;
    FloatAnimation_MenuCon.StopValue := lytDetail_Espacos.Height - 10;
  end;
  rctMenuConsulta.Visible := (not rctMenuConsulta.Visible);
  FloatAnimation_MenuCon.Start;
end;

procedure TfrmPrincipal.Anima_MenuMovimento(const AFechar:Boolean=False);
begin
  rctMenuMovimento.Position.Y := 0;
  rctMenuMovimento.Position.X := lytBtMovimento.Position.X;
  rctMenuMovimento.Width := lytBtMovimento.Width;
  rctMenuMovimento.Height := 0;
  if rctMenuMovimento.Visible then
  begin
    FloatAnimation_MenuMov.StartValue := lytDetail_Espacos.Height - 10;
    FloatAnimation_MenuMov.StopValue := 0;
  end
  else
  begin
    FloatAnimation_MenuMov.StartValue := 0;
    FloatAnimation_MenuMov.StopValue := lytDetail_Espacos.Height - 10;
  end;
  rctMenuMovimento.Visible := (not rctMenuMovimento.Visible);
  FloatAnimation_MenuMov.Start;
end;

procedure TfrmPrincipal.Anima_MenuRelatorio(const AFechar:Boolean=False);
begin
  rctMenuRelatorio.Position.Y := 0;
  rctMenuRelatorio.Position.X := lytBtRelatorios.Position.X;
  rctMenuRelatorio.Width := lytBtRelatorios.Width;
  rctMenuRelatorio.Height := 0;
  if rctMenuRelatorio.Visible then
  begin
    FloatAnimation_MenuRel.StartValue := lytDetail_Espacos.Height - 10;
    FloatAnimation_MenuRel.StopValue := 0;
  end
  else
  begin
    FloatAnimation_MenuRel.StartValue := 0;
    FloatAnimation_MenuRel.StopValue := lytDetail_Espacos.Height - 10;
  end;
  rctMenuRelatorio.Visible := (not rctMenuRelatorio.Visible);
  FloatAnimation_MenuRel.Start;
end;

procedure TfrmPrincipal.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja fechar o sistema?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

procedure TfrmPrincipal.rctMenuCadUser_PermissaoClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Permissões','Abre formulário do cadastro das permissões dos usuários','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCadUser_UsuarioClick(Sender: TObject);
begin
  if not Assigned(frmCadUsuario) then
    Application.CreateForm(TfrmCadUsuario, frmCadUsuario);
  frmCadUsuario.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_ClienteClick(Sender: TObject);
begin
  if not Assigned(frmCliente) then
    Application.CreateForm(TfrmCliente, frmCliente);
  frmCliente.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_EmpClick(Sender: TObject);
begin
  if not Assigned(frmEmpresa) then
    Application.CreateForm(TfrmEmpresa, frmEmpresa);
  frmEmpresa.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_FornecClick(Sender: TObject);
begin
  if not Assigned(frmFornecedor) then
    Application.CreateForm(TfrmFornecedor, frmFornecedor);
  frmFornecedor.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_ImpClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Impressoras','Abre formulário do cadastro dos impressoras','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_LocalClick(Sender: TObject);
begin
  case rctMenuCad_Local.Tag of
    0:begin
      //Expandir...
      imgMenuCad_Local_Prox.Bitmap := imgRetrair.Bitmap;
      lytMenuCad_Local_Paises.Visible := True;
      lytMenuCad_Local_Reg.Visible := True;
      lytMenuCad_Local_UF.Visible := True;
      lytMenuCad_Local_Mun.Visible := True;
      rctMenuCad_Local.Height := 200;
      rctMenuCad_Local.Tag := 1;
      rctMenuCad_Local.Opacity := 1;
    end;
    1:begin
      //Retrair...
      imgMenuCad_Local_Prox.Bitmap := imgExpandir.Bitmap;
      lytMenuCad_Local_Paises.Visible := False;
      lytMenuCad_Local_Reg.Visible := False;
      lytMenuCad_Local_UF.Visible := False;
      lytMenuCad_Local_Mun.Visible := False;
      rctMenuCad_Local.Height := 50;
      rctMenuCad_Local.Tag := 0;
      rctMenuCad_Local.Opacity := 0.5;
    end;
  end;
end;

procedure TfrmPrincipal.rctMenuCad_Local_MunClick(Sender: TObject);
begin
  if not Assigned(frmMunicipios) then
    Application.CreateForm(TfrmMunicipios, frmMunicipios);
  frmMunicipios.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Local_PaisesClick(Sender: TObject);
begin
  if not Assigned(frmCadPaises) then
    Application.CreateForm(TfrmCadPaises, frmCadPaises);
  frmCadPaises.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Local_RegClick(Sender: TObject);
begin
  if not Assigned(frmCad_Regioes) then
    Application.CreateForm(TfrmCad_Regioes, frmCad_Regioes);
  frmCad_Regioes.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Local_UFClick(Sender: TObject);
begin
  if not Assigned(frmUnidadeFederativa) then
    Application.CreateForm(TfrmUnidadeFederativa, frmUnidadeFederativa);
  frmUnidadeFederativa.Show;
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_ProdutoClick(Sender: TObject);
begin
  case rctMenuCad_Produto.Tag of
    0:begin
      //Expandir...
      imgMenuCad_Produto_Prox.Bitmap := imgRetrair.Bitmap;
      lytMenuCad_Produto_Grupo.Visible := True;
      lytMenuCad_Produto_SubGrupo.Visible := True;
      lytMenuCad_Produto_Un.Visible := True;
      lytMenuCad_Produto_Prod.Visible := True;
      rctMenuCad_Produto.Height := 195;
      rctMenuCad_Produto.Tag := 1;
      rctMenuCad_Produto.Opacity := 1;
    end;
    1:begin
      //Retrair...
      imgMenuCad_Produto_Prox.Bitmap := imgExpandir.Bitmap;
      lytMenuCad_Produto_Grupo.Visible := False;
      lytMenuCad_Produto_SubGrupo.Visible := False;
      lytMenuCad_Produto_Un.Visible := False;
      lytMenuCad_Produto_Prod.Visible := False;
      rctMenuCad_Produto.Height := 50;
      rctMenuCad_Produto.Tag := 0;
      rctMenuCad_Produto.Opacity := 0.5;
    end;
  end;
end;

procedure TfrmPrincipal.rctMenuCad_Produto_GrupoClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Grupo','Abre formulário do cadastro dos grupos','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Produto_ProdClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Produtos','Abre formulário do cadastro dos produtos','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Produto_SetorClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Setor','Abre formulário do cadastro dos setores','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Produto_SubGrupoClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Sub-Grupos','Abre formulário do cadastro dos sub-grupos','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_Produto_UnClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Unidades','Abre formulário do cadastro das unidades','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_SetorClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Cadastro de Setores','Abre formulário do cadastro dos setores','OK');
  rctMenuCadastro.Visible := False;
end;

procedure TfrmPrincipal.rctMenuCad_UserClick(Sender: TObject);
begin
  case rctMenuCad_User.Tag of
    0:begin
      //Expandir...
      imgMenuCad_User.Bitmap := imgRetrair.Bitmap;
      lytMenuCadUser_Permissao.Visible := True;
      lytMenuCadUser_Usuario.Visible := True;
      rctMenuCad_User.Height := 130;
      rctMenuCad_User.Tag := 1;
      rctMenuCad_User.Opacity := 1;
    end;
    1:begin
      //Retrair...
      imgMenuCad_User.Bitmap := imgExpandir.Bitmap;
      lytMenuCadUser_Permissao.Visible := False;
      lytMenuCadUser_Usuario.Visible := False;
      rctMenuCad_User.Height := 50;
      rctMenuCad_User.Tag := 0;
      rctMenuCad_User.Opacity := 0.5;
    end;
  end;
end;

procedure TfrmPrincipal.rctMenuMov_CaixaClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Movimento Caixa','Abre formulário do movimento do caixa','OK');
  rctMenuMovimento.Visible := False;
end;

procedure TfrmPrincipal.rctMenuMov_VendaClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Info,'Movimento Venda','Abre formulário do movimento de venda','OK');
  rctMenuMovimento.Visible := False;
end;

procedure TfrmPrincipal.rctMenu_ConfigClick(Sender: TObject);
begin
  if not Assigned(frmConfig) then
    Application.CreateForm(TfrmConfig, frmConfig);
  frmConfig.Show;
  mvPrincipal.HideMaster;
end;

procedure TfrmPrincipal.rctMenu_FecharClick(Sender: TObject);
begin
  mvPrincipal.HideMaster;
end;

procedure TfrmPrincipal.rctMenu_PrincipalClick(Sender: TObject);
begin
  mvPrincipal.ShowMaster;
end;

end.
