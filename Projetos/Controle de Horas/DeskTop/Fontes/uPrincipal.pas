unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Effects, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uDm.Global, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFormClass = class of TForm;

  TfrmPrincipal = class(TForm)
    rctHeader: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    imgLog: TImage;
    mtvMenu: TMultiView;
    lytMenu_Header: TLayout;
    rctMenuHeader: TRectangle;
    ShadowEffect18: TShadowEffect;
    lytMenu_Detail: TLayout;
    lbxCadastro: TListBox;
    lbiConfig: TListBoxItem;
    rctConfig: TRectangle;
    imgConfig: TImage;
    lbConfig: TLabel;
    lytMenu_Footer: TLayout;
    rctMenu_Footer: TRectangle;
    lytFechar_Icon: TLayout;
    Image2: TImage;
    lytFechar_Desc: TLayout;
    lbFechar: TLabel;
    sbFechar: TSpeedButton;
    lbVersao: TLabel;
    lbMenuPrincipal: TLabel;
    rctFooter: TRectangle;
    lytHeaderPrincipal: TLayout;
    lytHeaderTitle: TLayout;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    lytTollBar: TLayout;
    lytPrincipal: TLayout;
    imgFechar: TImage;
    rctVersao: TRectangle;
    lbVersaoPrincipal: TLabel;
    lbiCadUsuario: TListBoxItem;
    rctCadUsuario: TRectangle;
    imgCadUsuario: TImage;
    lbCadUsuario: TLabel;
    rctUsuario: TRectangle;
    lbUsuario: TLabel;
    lbiPrestService: TListBoxItem;
    rctPrestService: TRectangle;
    imgPrestService: TImage;
    lbPrestService: TLabel;
    StyleBook_Adapta: TStyleBook;
    lbiCliente: TListBoxItem;
    rctCliente: TRectangle;
    imgCliente: TImage;
    lbCliente: TLabel;
    lbiTabPrecos: TListBoxItem;
    rctTabPrecos: TRectangle;
    imgTabPrecos: TImage;
    lbTabPrecos: TLabel;
    lbiContas: TListBoxItem;
    rctContas: TRectangle;
    imgContas: TImage;
    lbContas: TLabel;
    sbMenu: TScrollBox;
    exCadastro: TExpander;
    lbiEmpresa: TListBoxItem;
    rctEmpresa: TRectangle;
    imgEmpresa: TImage;
    lbEmpresa: TLabel;
    lbiFornecedor: TListBoxItem;
    rctFornecedor: TRectangle;
    imgFornecedor: TImage;
    lbFornecedor: TLabel;
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
    lbiFormaPagto: TListBoxItem;
    rctFormaPagto: TRectangle;
    imgFormaPagto: TImage;
    lbFormaPagto: TLabel;
    lbiCondPagto: TListBoxItem;
    rctCondPagto: TRectangle;
    imgCondPagto: TImage;
    lbCondPagto: TLabel;
    procedure imgLogClick(Sender: TObject);
    procedure rctConfigClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctCadUsuarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rctPrestServiceClick(Sender: TObject);
    procedure rctClienteClick(Sender: TObject);
    procedure rctTabPrecosClick(Sender: TObject);
    procedure rctContasClick(Sender: TObject);
    procedure rctEmpresaClick(Sender: TObject);
    procedure rctFornecedorClick(Sender: TObject);
    procedure rctServPrestadosClick(Sender: TObject);
    procedure rctLancamentosClick(Sender: TObject);
    procedure rctFormaPagtoClick(Sender: TObject);
    procedure rctCondPagtoClick(Sender: TObject);
  private
    FDm_Global :TDM_Global;
    procedure AbreForm(AForm:TFormClass);
    procedure Config_Menu;

  public
    FUser_Login: String;
    FUser_Nome: String;
    FUser_Celular: String;
    FUser_Id: Integer;
    FUser_PIN: String;
    FUser_Empresa :Integer;
    FUser_Prestador :Integer;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uConfig
  ,uCad.Usuario
  ,uCad.PrestServico
  ,uCad.Cliente
  ,uCad.TabPrecos
  ,uCad.Contas
  ,uCad.Empresa
  ,uCad.Fornecedor
  ,uMov.ServicosPrestados
  ,uLanc_Financeiros
  ,uCad.FormaPagamento
  ,uCad.CondicaoPagamento, uDm.Global.Wnd;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FDm_Global);

  Action := tCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  exCadastro.Height := 500;
  exMovimento.Height := 100;
  FDm_Global := TDM_Global.Create(Nil);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  FDQuery :TFDQuery;
begin
  try
    try
      FDQuery := TFDQuery.Create(Nil);
      FDQuery.Connection := FDm_Global.FDC_Firebird;
      FUser_Login := '';
      FUser_Nome := '';
      FUser_Celular := '';
      FUser_Id := 0;
      FUser_Empresa := 0;
      FUser_Prestador := 0;

      if Trim(FUser_PIN) <> '' then
      begin
        FDQuery.Active := False;
        FDQuery.SQL.Clear;
        FDQuery.SQL.Add('SELECT ');
        FDQuery.SQL.Add('  U.* ');
        FDQuery.SQL.Add('FROM USUARIO U ');
        FDQuery.SQL.Add('WHERE U.PIN = ' + QuotedStr(FUser_PIN));
        FDQuery.Active := True;
        if not FDQuery.IsEmpty then
        begin
          FUser_Login := FDQuery.FieldByName('LOGIN').AsString;
          FUser_Nome := FDQuery.FieldByName('NOME').AsString;
          FUser_Celular := FDQuery.FieldByName('CELULAR').AsString;
          FUser_Id := FDQuery.FieldByName('ID').AsInteger;
          FUser_Empresa := FDQuery.FieldByName('ID_EMPRESA').AsInteger;
          FUser_Prestador := FDQuery.FieldByName('ID_PRESTADOR_SERVICO').AsInteger;
        end;
      end;
    except on E: Exception do
    end;
  finally
    lbUsuario.Text := FUser_Nome;
    FreeAndNil(FDQuery);
  end;
end;

procedure TfrmPrincipal.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.imgLogClick(Sender: TObject);
begin
  exCadastro.IsExpanded := False;
  mtvMenu.ShowMaster;
end;

procedure TfrmPrincipal.AbreForm(AForm:TFormClass);
var
  FForm :TForm;

begin
  mtvMenu.HideMaster;
  exCadastro.IsExpanded := False;
  exMovimento.IsExpanded := False;
  exCadastro.Height := 400;
  exMovimento.Height := 100;

  Application.CreateForm(AForm,FForm);
  FForm.Parent := Self;
  FForm.Height := Self.Height;
  FForm.Width := Self.Width;
  FForm.Show;

end;

procedure TfrmPrincipal.Config_Menu;
begin
  mtvMenu.HideMaster;
  exCadastro.IsExpanded := False;
  exMovimento.IsExpanded := False;
  exCadastro.Height := 400;
  exMovimento.Height := 150;
end;

procedure TfrmPrincipal.rctServPrestadosClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmMov_ServicosPrestados,frmMov_ServicosPrestados);
  frmMov_ServicosPrestados.Parent := Self;
  frmMov_ServicosPrestados.Height := Self.Height;
  frmMov_ServicosPrestados.Width := Self.Width;
  frmMov_ServicosPrestados.Show;
end;

procedure TfrmPrincipal.rctCadUsuarioClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Usuario,frmCad_Usuario);
  frmCad_Usuario.Parent := Self;
  frmCad_Usuario.Height := Self.Height;
  frmCad_Usuario.Width := Self.Width;
  frmCad_Usuario.Show;
end;

procedure TfrmPrincipal.rctClienteClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Cliente,frmCad_Cliente);
  frmCad_Cliente.Parent := Self;
  frmCad_Cliente.Height := Self.Height;
  frmCad_Cliente.Width := Self.Width;
  frmCad_Cliente.Show;
end;

procedure TfrmPrincipal.rctCondPagtoClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCondicao_Pagamento,frmCondicao_Pagamento);
  frmCondicao_Pagamento.Parent := Self;
  frmCondicao_Pagamento.Height := Self.Height;
  frmCondicao_Pagamento.Width := Self.Width;
  frmCondicao_Pagamento.Show;
end;

procedure TfrmPrincipal.rctConfigClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmConfig,frmConfig);
  frmConfig.Parent := Self;
  frmConfig.Height := Self.Height;
  frmConfig.Width := Self.Width;
  frmConfig.Show;
end;

procedure TfrmPrincipal.rctContasClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Contas,frmCad_Contas);
  frmCad_Contas.Parent := Self;
  frmCad_Contas.Height := Self.Height;
  frmCad_Contas.Width := Self.Width;
  frmCad_Contas.Show;
end;

procedure TfrmPrincipal.rctEmpresaClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Empresa,frmCad_Empresa);
  frmCad_Empresa.Parent := Self;
  frmCad_Empresa.Height := Self.Height;
  frmCad_Empresa.Width := Self.Width;
  frmCad_Empresa.Show;
end;

procedure TfrmPrincipal.rctFormaPagtoClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmFormaPagamento,frmFormaPagamento);
  frmFormaPagamento.Parent := Self;
  frmFormaPagamento.Height := Self.Height;
  frmFormaPagamento.Width := Self.Width;
  frmFormaPagamento.Show;
end;

procedure TfrmPrincipal.rctFornecedorClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_Fornecedor,frmCad_Fornecedor);
  frmCad_Fornecedor.Parent := Self;
  frmCad_Fornecedor.Height := Self.Height;
  frmCad_Fornecedor.Width := Self.Width;
  frmCad_Fornecedor.Show;
end;

procedure TfrmPrincipal.rctLancamentosClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmLanc_Financeiros,frmLanc_Financeiros);
  frmLanc_Financeiros.Parent := Self;
  frmLanc_Financeiros.Height := Self.Height;
  frmLanc_Financeiros.Width := Self.Width;
  frmLanc_Financeiros.Show;
end;

procedure TfrmPrincipal.rctPrestServiceClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_PrestServico,frmCad_PrestServico);
  frmCad_PrestServico.Parent := Self;
  frmCad_PrestServico.Height := Self.Height;
  frmCad_PrestServico.Width := Self.Width;
  frmCad_PrestServico.Show;
end;

procedure TfrmPrincipal.rctTabPrecosClick(Sender: TObject);
begin
  Config_Menu;
  Application.CreateForm(TfrmCad_TabPrecos,frmCad_TabPrecos);
  frmCad_TabPrecos.Parent := Self;
  frmCad_TabPrecos.Height := Self.Height;
  frmCad_TabPrecos.Width := Self.Width;
  frmCad_TabPrecos.Show;
end;

end.


{
#363428
#A1B24E
}
