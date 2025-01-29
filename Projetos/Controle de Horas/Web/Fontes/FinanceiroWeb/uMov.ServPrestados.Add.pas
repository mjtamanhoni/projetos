unit uMov.ServPrestados.Add;


{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Vcl.ComCtrls, uPrincipal;

type
  TfrmMov_ServPrestados_Add = class(TfrmPrincipal)
    lbid: TLabel;
    edid: TEdit;
    lbdescricao: TLabel;
    eddescricao: TEdit;
    lbstatus: TLabel;
    cbstatus: TComboBox;
    lbid_empresa: TLabel;
    edid_empresa: TEdit;
    btid_empresa: TButton;
    lbid_prestador_servico: TLabel;
    edid_prestador_servico: TEdit;
    btid_prestador_servico: TButton;
    lbid_cliente: TLabel;
    edid_cliente: TEdit;
    btid_cliente: TButton;
    lbid_tabela: TLabel;
    edid_tabela: TEdit;
    btid_tabela: TButton;
    edid_tabela_Vlr: TEdit;
    lbid_conta: TLabel;
    edid_conta: TEdit;
    btid_conta: TButton;
    edid_conta_tipo: TEdit;
    eddt_registro: TDateTimePicker;
    lbdt_registro: TLabel;
    edhr_inicio: TDateTimePicker;
    lbhr_inicio: TLabel;
    lbhr_fim: TLabel;
    edhr_fim: TDateTimePicker;
    lbhr_total: TLabel;
    lbvlr_hora: TLabel;
    edvlr_hora: TEdit;
    lbsub_total: TLabel;
    edsub_total: TEdit;
    eddesconto: TEdit;
    lbdesconto: TLabel;
    edacrescimo: TEdit;
    lbacrescimo: TLabel;
    lbtotal: TLabel;
    edtotal: TEdit;
    lbobservacao: TLabel;
    edobservacao: TEdit;
    lbdt_pago: TLabel;
    eddt_pago: TDateTimePicker;
    edhr_total: TEdit;
    lbvlr_pago: TLabel;
    edvlr_pago: TEdit;
    Button1: TButton;
    btConfirmar: TButton;
    btCancelar: TButton;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btid_empresaClick(Sender: TObject);
    procedure btid_prestador_servicoClick(Sender: TObject);
    procedure btid_clienteClick(Sender: TObject);
    procedure btid_tabelaClick(Sender: TObject);
    procedure btid_contaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmMov_ServPrestados_Add:TfrmMov_ServPrestados_Add;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmMov_ServPrestados_Add:TfrmMov_ServPrestados_Add;
begin
  result:= TfrmMov_ServPrestados_Add(TfrmMov_ServPrestados_Add.GetInstance);
end;

procedure TfrmMov_ServPrestados_Add.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMov_ServPrestados_Add.btConfirmarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMov_ServPrestados_Add.btid_clienteClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Pesquisar Cliente');
end;

procedure TfrmMov_ServPrestados_Add.btid_contaClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Pesquisar Conta');
end;

procedure TfrmMov_ServPrestados_Add.btid_empresaClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Pesquisar Empresa',True,True,10000);
end;

procedure TfrmMov_ServPrestados_Add.btid_prestador_servicoClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Pesquisar Prestador de Serviço');
end;

procedure TfrmMov_ServPrestados_Add.btid_tabelaClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Pesquisar Tabela de Preço');
end;

procedure TfrmMov_ServPrestados_Add.ExportD2Bridge;
begin
  inherited;

  Title:= 'Lançamentos dos Serviços Prestados';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= 'forms-servicosPrestados.html';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'forms-cadastro-serprestados.html';

  with D2Bridge.Items.add do
  begin
   VCLObj(edid);
   VCLObj(eddt_registro);

   VCLObj(eddescricao);
   VCLObj(cbstatus);
   VCLObj(edid_empresa);
   VCLObj(btid_empresa);
   VCLObj(edid_prestador_servico);
   VCLObj(btid_prestador_servico);
   VCLObj(edid_cliente);
   VCLObj(btid_cliente);
   VCLObj(edid_tabela);
   VCLObj(edid_tabela_Vlr);
   VCLObj(btid_tabela);
   VCLObj(edid_conta);
   VCLObj(edid_conta_tipo);
   VCLObj(btid_conta);
   VCLObj(edhr_inicio);
   VCLObj(edhr_fim);
   VCLObj(edhr_total);
   VCLObj(edvlr_hora);
   VCLObj(edsub_total);
   VCLObj(eddesconto);
   VCLObj(edacrescimo);
   VCLObj(edtotal);
   VCLObj(edobservacao);
   VCLObj(eddt_pago);
   VCLObj(edvlr_pago);
   VCLObj(btConfirmar);
   VCLObj(btCancelar);
  end;

end;

procedure TfrmMov_ServPrestados_Add.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

 //Change Init Property of Prism Controls
 {
  if PrismControl.VCLComponent = Edit1 then
   PrismControl.AsEdit.DataType:= TPrismFieldType.PrismFieldTypeInteger;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage:= 10;
   PrismControl.AsDBGrid.MaxRecords:= 2000;
  end;
 }
end;

procedure TfrmMov_ServPrestados_Add.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
begin
 inherited;

 //Intercept HTML
 {
  if PrismControl.VCLComponent = Edit1 then
  begin
   HTMLControl:= '</>';
  end;
 }
end;

end.