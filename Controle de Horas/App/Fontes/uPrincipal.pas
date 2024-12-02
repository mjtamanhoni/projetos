unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uSuperChart,
  {$EndRegion '99 Coders'}

  uDM.Global,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, FMX.ListBox,
  FMX.Layouts, FMX.Effects, FMX.Controls.Presentation, FMX.MultiView, FMX.TabControl;

type
  TfrmPrincipal = class(TForm)
    lytPrincipal: TLayout;
    mtvMenu: TMultiView;
    lytMenu_Header: TLayout;
    rctMenuHeader: TRectangle;
    ShadowEffect18: TShadowEffect;
    lbMenuPrincipal: TLabel;
    lytMenu_Detail: TLayout;
    sbMenu: TScrollBox;
    exCadastro: TExpander;
    lbxCadastro: TListBox;
    lbiConfig: TListBoxItem;
    rctConfig: TRectangle;
    imgConfig: TImage;
    lbConfig: TLabel;
    lbiCadUsuario: TListBoxItem;
    rctCadUsuario: TRectangle;
    imgCadUsuario: TImage;
    lbCadUsuario: TLabel;
    lbiEmpresa: TListBoxItem;
    rctEmpresa: TRectangle;
    imgEmpresa: TImage;
    lbEmpresa: TLabel;
    lbiPrestService: TListBoxItem;
    rctPrestService: TRectangle;
    imgPrestService: TImage;
    lbPrestService: TLabel;
    lbiCliente: TListBoxItem;
    rctCliente: TRectangle;
    imgCliente: TImage;
    lbCliente: TLabel;
    lbiFornecedor: TListBoxItem;
    rctFornecedor: TRectangle;
    imgFornecedor: TImage;
    lbFornecedor: TLabel;
    lbiTabPrecos: TListBoxItem;
    rctTabPrecos: TRectangle;
    imgTabPrecos: TImage;
    lbTabPrecos: TLabel;
    lbiContas: TListBoxItem;
    rctContas: TRectangle;
    imgContas: TImage;
    lbContas: TLabel;
    lbiCondPagto: TListBoxItem;
    rctCondPagto: TRectangle;
    imgCondPagto: TImage;
    lbCondPagto: TLabel;
    lbiFormaPagto: TListBoxItem;
    rctFormaPagto: TRectangle;
    imgFormaPagto: TImage;
    lbFormaPagto: TLabel;
    exMovimento: TExpander;
    lbxMovimento: TListBox;
    lbiServPrestados: TListBoxItem;
    rctServPrestados: TRectangle;
    imgServPrestados: TImage;
    lbServPrestados: TLabel;
    lbiLancamentos: TListBoxItem;
    rctLancamentos: TRectangle;
    imgLancamentos: TImage;
    lbLancamentos: TLabel;
    lytMenu_Footer: TLayout;
    rctMenu_Footer: TRectangle;
    lytFechar_Icon: TLayout;
    Image2: TImage;
    lytFechar_Desc: TLayout;
    lbFechar: TLabel;
    sbFechar: TSpeedButton;
    lbVersao: TLabel;
    rctFooter: TRectangle;
    ShadowEffect2: TShadowEffect;
    rctVersao: TRectangle;
    lbVersaoPrincipal: TLabel;
    rctUsuario: TRectangle;
    lbUsuario: TLabel;
    rctHeader: TRectangle;
    ShadowEffect1: TShadowEffect;
    imgLog: TImage;
    lytHeaderPrincipal: TLayout;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    StyleBook_Adapta: TStyleBook;
    lytTotais: TLayout;
    rctTotaisTitulo: TRectangle;
    lbTotaisTitulo: TLabel;
    ShadowEffect4: TShadowEffect;
    rctTotais: TRectangle;
    lytDashBoard: TLayout;
    rctDashBoard: TRectangle;
    rctDashBoardTit: TRectangle;
    lbDashBoardTit: TLabel;
    ShadowEffect5: TShadowEffect;
    gplTotais: TGridPanelLayout;
    lbCredito: TLabel;
    lbDebitoTit: TLabel;
    lbDebito: TLabel;
    lbSaldoTit: TLabel;
    lbSaldo: TLabel;
    lbCreditoTit: TLabel;
    lytDashBoard_Exibir: TLayout;
    tcDashBoard: TTabControl;
    tiCreditoDebito: TTabItem;
    tiCredito: TTabItem;
    tiDebito: TTabItem;
    lytGraficoCD: TLayout;
    lytGraficoCredito: TLayout;
    lytGraficoDebito: TLayout;
    rctGraficoCd: TRectangle;
    rctGraficoC: TRectangle;
    lytGraficoC: TLayout;
    rctGraficoD: TRectangle;
    lytGraficoD: TLayout;
    exArquivo: TExpander;
    lbxArquivo: TListBox;
    lbiEstrutura: TListBoxItem;
    rctEstrutura: TRectangle;
    imgEstrutura: TImage;
    lbEstrutura: TLabel;
    lbiSincronizar: TListBoxItem;
    rctSincronizar: TRectangle;
    imgSincronizar: TImage;
    lbSincronizar: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rctGCreditoClick(Sender: TObject);
    procedure imgLogClick(Sender: TObject);
    procedure rctCadUsuarioClick(Sender: TObject);
    procedure rctEstruturaClick(Sender: TObject);
    procedure rctEmpresaClick(Sender: TObject);
    procedure exArquivoExpandedChanged(Sender: TObject);
    procedure exCadastroExpandedChanged(Sender: TObject);
    procedure exMovimentoExpandedChanged(Sender: TObject);
    procedure rctPrestServiceClick(Sender: TObject);
    procedure mtvMenuHidden(Sender: TObject);
    procedure rctFornecedorClick(Sender: TObject);
    procedure rctTabPrecosClick(Sender: TObject);
    procedure rctClienteClick(Sender: TObject);
    procedure rctContasClick(Sender: TObject);
    procedure rctCondPagtoClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FDm_Global :TDM_Global;
    FEnder :String;

    procedure Totalizar;
    procedure TThread_EndTotalizar(Sender :TObject);
    procedure Config_Menu;
    procedure TThreadEnd_Estrutura(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uCad.Usuario
  ,uCad.Empresa
  ,uCad.PrestadorServicos
  ,uModelo.Dados
  ,uCad.Fornecedor
  ,uCad.TabelaPreco
  ,uCad.Cliente
  ,uCad.Conta
  ,uCad.CondicaoPagto;

procedure TfrmPrincipal.exArquivoExpandedChanged(Sender: TObject);
begin
  exArquivo.Height := 200;
end;

procedure TfrmPrincipal.exCadastroExpandedChanged(Sender: TObject);
begin
  //exCadastro.Size.Height := 400;
  exCadastro.Height := 400;
end;

procedure TfrmPrincipal.exMovimentoExpandedChanged(Sender: TObject);
begin
  //exMovimento.Size.Height := 150;
  exMovimento.Height := 150;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FDm_Global);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FDm_Global.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}

  FFancyDialog := TFancyDialog.Create(frmPrincipal);
  FDm_Global := TDM_Global.Create(Nil);

  Totalizar;
end;

procedure TfrmPrincipal.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.imgLogClick(Sender: TObject);
begin
  exArquivo.IsExpanded := False;
  exCadastro.IsExpanded := False;
  exMovimento.IsExpanded := False;
  mtvMenu.ShowMaster;
end;

procedure TfrmPrincipal.mtvMenuHidden(Sender: TObject);
begin
  exArquivo.Height := 200;
  exCadastro.Height := 400;
  exMovimento.Height := 150;
end;

procedure TfrmPrincipal.rctCadUsuarioClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Usuario,frmCad_Usuario);
  frmCad_Usuario.Show;
end;

procedure TfrmPrincipal.rctClienteClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Cliente,frmCad_Cliente);
  frmCad_Cliente.Show;
end;

procedure TfrmPrincipal.rctCondPagtoClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_CondicaoPagto,frmCad_CondicaoPagto);
  frmCad_CondicaoPagto.Show;

end;

procedure TfrmPrincipal.rctContasClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Contas,frmCad_Contas);
  frmCad_Contas.Show;

end;

procedure TfrmPrincipal.rctEmpresaClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Empresa,frmCad_Empresa);
  frmCad_Empresa.Show;
end;

procedure TfrmPrincipal.rctEstruturaClick(Sender: TObject);
var
  t :TThread;

begin
  Config_Menu;

  TLoading.Show(frmPrincipal,'Reestruturando Banco de Dados');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FEstrutura :TEstrutura;
  begin
    FEstrutura := TEstrutura.Create(FDm_Global.FDC_SQLite,FEnder);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Usuários');
    end);
    FEstrutura.USUARIO;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Empresas');
    end);
    FEstrutura.EMPRESA;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Contas');
    end);
    FEstrutura.CONTA;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Formas de Pagamento');
    end);
    FEstrutura.FORMA_PAGAMENTO;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Fornecedores');
    end);
    FEstrutura.FORNECEDOR;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Condições de Pagamento');
    end);
    FEstrutura.CONDICAO_PAGAMENTO;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Prestador de Serviços');
    end);
    FEstrutura.PRESTADOR_SERVICO;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Tabela de Preços');
    end);
    FEstrutura.TABELA_PRECO;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Condições de Forma de Pagamento');
    end);
    FEstrutura.FORMA_CONDICAO_PAGAMENTO;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Clientes');
    end);
    FEstrutura.CLIENTE;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Clientes associado com Tabelas');
    end);
    FEstrutura.CLIENTE_TABELA;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Serviços Prestados');
    end);
    FEstrutura.SERVICOS_PRESTADOS;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      TLoading.ChangeText('Reestruturando Tabela de Lançamentos');
    end);
    FEstrutura.LANCAMENTOS;

  end);

  t.OnTerminate := TThreadEnd_Estrutura;
  t.Start;

end;

procedure TfrmPrincipal.rctFornecedorClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Fornecedor,frmCad_Fornecedor);
  frmCad_Fornecedor.Show;
end;

procedure TfrmPrincipal.TThreadEnd_Estrutura(Sender :TObject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Salvar',Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmPrincipal.rctGCreditoClick(Sender: TObject);
begin
  tcDashBoard.ActiveTab.Index := TRectangle(Sender).Tag;
end;

procedure TfrmPrincipal.rctPrestServiceClick(Sender: TObject);
begin
  Config_Menu;
  if frmCad_PrestadorServicos = Nil then
    Application.CreateForm(TfrmCad_PrestadorServicos,frmCad_PrestadorServicos);
  frmCad_PrestadorServicos.Show;

end;

procedure TfrmPrincipal.rctTabPrecosClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_TabelaPreco,frmCad_TabelaPreco);
  frmCad_TabelaPreco.Show;
end;

procedure TfrmPrincipal.Totalizar;
var
  t :TThread;
begin
  TLoading.Show(frmPrincipal,'Gerando Totais');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FChart :TSuperChart;
    FErro :String;
    FJsonStr :String;//Sera substituido pelo banco de dados...
    Vlr_Credito:String;
    Vlr_Debito:String;
  begin

    //Pegando valores no banco de dados...

    //Passando os totais...
    lbCredito.TagFloat := 6325.20;
    lbDebito.TagFloat := 2235.00;
    lbSaldo.TagFloat := (lbCredito.TagFloat - lbDebito.TagFloat);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbCredito.Text := FormatFloat('R$ #,##0.00',lbCredito.TagFloat);
      lbDebito.Text := FormatFloat('R$ #,##0.00',lbDebito.TagFloat);
      lbSaldo.Text := FormatFloat('R$ #,##0.00',lbSaldo.TagFloat);
    end);

    //Está sendo montado por um Json, mas vai ser substituido por um DataSet, como abaixo
    //FChart.LoadFromDataset(qry, 'VALOR', 'MES', erro);
    FChart := TSuperChart.Create(lytGraficoCD, VerticalBar);

    //Gerando gráfico
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      // Valores
      FChart.ShowValues := False;
      FChart.FontSizeValues := 13;
      FChart.FontColorValues := $FF363428;
      FChart.FormatValues := '';
    end);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      // Barras
      FChart.BarColor := $FFA1B24E;
      FChart.ShowBackground := True;
      FChart.BackgroundColor := $FF363428;
      FChart.RoundedBotton := false;
      FChart.RoundedTop := true;
      //FChart.LineColor := $FFFFD270;
    end);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      // Arguments
      FChart.FontSizeArgument := 12;
      FChart.FontColorArgument := $FF363428;
    end);

    FJsonStr := '';
    Vlr_Credito := '';
    Vlr_Debito := '';

    Vlr_Credito := StringReplace(StringReplace(FloatToStr(lbCredito.TagFloat),'.','',[rfReplaceAll]),',','.',[rfReplaceAll]);
    Vlr_Debito := StringReplace(StringReplace(FloatToStr(lbDebito.TagFloat),'.','',[rfReplaceAll]),',','.',[rfReplaceAll]);

    FJsonStr := FJsonStr + '[{"field":"Crédito", "valor":'+Vlr_Credito+'},';
    FJsonStr := FJsonStr + '{"field":"Débito", "valor":'+Vlr_Debito+'}]';

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      FChart.LoadFromJSON(FJsonStr, FErro);
    end);

    if FErro <> '' then
      raise Exception.Create(FErro);

  end);


  t.OnTerminate := TThread_EndTotalizar;
  t.Start;

end;

procedure TfrmPrincipal.TThread_EndTotalizar(Sender :TObject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Totalizando',Exception(TThread(Sender).FatalException).Message)
end;

procedure TfrmPrincipal.Config_Menu;
begin
  mtvMenu.HideMaster;
  exArquivo.IsExpanded := False;
  exCadastro.IsExpanded := False;
  exMovimento.IsExpanded := False;
  //exArquivo.Size.Height := 150;
  //exCadastro.Size.Height := 400;
  //exCadastro.Height := 400;
  //exMovimento.Size.Height := 150;
end;

end.
