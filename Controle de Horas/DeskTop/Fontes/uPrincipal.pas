unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Effects, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uDm.Global;

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
  private
    FDm_Global :TDM_Global;
    procedure AbreForm(AForm:TFormClass);

  public
    FUser_Login: String;
    FUser_Nome: String;
    FUser_Celular: String;
    FUser_Id: Integer;
    FUser_PIN: String;
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
  ,uMov.ServicosPrestados;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FDm_Global);

  Action := tCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FDm_Global := TDM_Global.Create(Nil);
  exCadastro.Height := 400;
  exMovimento.Height := 100;
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

  FForm := AForm.Create(Nil);
  FForm.Parent := Self;
  FForm.Height := Self.Height;
  FForm.Width := Self.Width;
  FForm.Show;

end;

procedure TfrmPrincipal.rctServPrestadosClick(Sender: TObject);
begin
  AbreForm(TfrmMov_ServicosPrestados);
end;

procedure TfrmPrincipal.rctCadUsuarioClick(Sender: TObject);
begin
  AbreForm(TfrmCad_Usuario);
end;

procedure TfrmPrincipal.rctClienteClick(Sender: TObject);
begin
  AbreForm(TfrmCad_Cliente);
end;

procedure TfrmPrincipal.rctConfigClick(Sender: TObject);
begin
  AbreForm(TfrmConfig);
end;

procedure TfrmPrincipal.rctContasClick(Sender: TObject);
begin
  AbreForm(TfrmCad_Contas);
end;

procedure TfrmPrincipal.rctEmpresaClick(Sender: TObject);
begin
  AbreForm(TfrmCad_Empresa);
end;

procedure TfrmPrincipal.rctFornecedorClick(Sender: TObject);
begin
  AbreForm(TfrmCad_Fornecedor);
end;

procedure TfrmPrincipal.rctPrestServiceClick(Sender: TObject);
begin
  AbreForm(TfrmCad_PrestServico);
end;

procedure TfrmPrincipal.rctTabPrecosClick(Sender: TObject);
begin
  AbreForm(TfrmCad_TabPrecos);
end;

end.


{
#363428
#A1B24E
}
