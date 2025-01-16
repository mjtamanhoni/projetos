unit uMov.ServicosPrestados;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.IOUtils,

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  uPrincipal, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  uMov.ServicosPrestados.Add, System.ImageList, Vcl.ImgList, Vcl.ComCtrls;

type
  TfrmMov_ServicosPrestados = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    pnFooter: TPanel;
    btNovo: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    pnHeader: TPanel;
    lbFiltro_Periodo: TLabel;
    btPesquisar: TButton;
    lbFiltro_Empresa: TLabel;
    ImageList: TImageList;
    edFiltro_DataI: TDateTimePicker;
    edFiltro_DataF: TDateTimePicker;
    edFiltro__ID: TButtonedEdit;
    edFiltro_Empresa: TEdit;
    lbFiltro_Prestador: TLabel;
    edFiltro_Prestador_Id: TButtonedEdit;
    edFiltro_Prestador: TEdit;
    lbFIltro_Cliente: TLabel;
    edFiltro_Cliente_Id: TButtonedEdit;
    edFIltro_Cliente: TEdit;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroSTATUS: TIntegerField;
    FDMem_RegistroID_EMPRESA: TIntegerField;
    FDMem_RegistroID_PRESTADOR_SERVICO: TIntegerField;
    FDMem_RegistroID_CLIENTE: TIntegerField;
    FDMem_RegistroID_TABELA: TIntegerField;
    FDMem_RegistroID_CONTA: TIntegerField;
    FDMem_RegistroDATA: TDateField;
    FDMem_RegistroHR_INICIO: TTimeField;
    FDMem_RegistroHR_FIM: TTimeField;
    FDMem_RegistroHR_TOTAL: TStringField;
    FDMem_RegistroVLR_HORA: TFloatField;
    FDMem_RegistroSUB_TOTAL: TFloatField;
    FDMem_RegistroDESCONTO: TFloatField;
    FDMem_RegistroDESCONTO_MOTIVO: TStringField;
    FDMem_RegistroACRESCIMO: TFloatField;
    FDMem_RegistroACRESCIMO_MOTIVO: TStringField;
    FDMem_RegistroTOTAL: TFloatField;
    FDMem_RegistroOBSERVACAO: TStringField;
    FDMem_RegistroDT_PAGO: TDateField;
    FDMem_RegistroVLR_PAGO: TFloatField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroID_USUARIO: TIntegerField;
  private
    FfrmMov_ServicosPrestados_Add :TfrmMov_ServicosPrestados_Add;
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmMov_ServicosPrestados:TfrmMov_ServicosPrestados;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmMov_ServicosPrestados:TfrmMov_ServicosPrestados;
begin
  result:= TfrmMov_ServicosPrestados(TfrmMov_ServicosPrestados.GetInstance);
end;

procedure TfrmMov_ServicosPrestados.ExportD2Bridge;
begin
  inherited;

  Title:= 'Serviços Prestados';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmMov_ServicosPrestados_Add := TfrmMov_ServicosPrestados_Add.Create(Self);
  D2Bridge.AddNested(FfrmMov_ServicosPrestados_Add);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with Card.Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup(lbFiltro_Periodo.Caption,CSSClass.Col.colsize2).AddVCLObj(edFiltro_DataI);
          FormGroup('',CSSClass.Col.colsize2).AddVCLObj(edFiltro_DataF);

          FormGroup(lbFiltro_Empresa.Caption,CSSClass.Col.colsize3).AddVCLObj(edFiltro__ID);

          FormGroup(lbFiltro_Prestador.Caption,CSSClass.Col.colsize2).AddVCLObj(edFiltro_Prestador_Id);

          FormGroup(lbFIltro_Cliente.Caption,CSSClass.Col.colsize3).AddVCLObj(edFiltro_Cliente_Id);
        end;
      end;
    end;


    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    with Card.Items.Add do
    begin
      with Row(CSSClass.DivHtml.Align_Left).Items.Add do
      begin
        VCLObj(btNovo,CSSClass.Button.add + CSSClass.Col.colsize1);
        VCLObj(btEditar,CSSClass.Button.edit + CSSClass.Col.colsize1);
        VCLObj(btExcluir,CSSClass.Button.delete + CSSClass.Col.colsize1);
      end;
    end;

    //Abrindo formulário popup
    with Popup('PopupMovServPrestAdd','Cadastro de Tabela de Preços').Items.Add do
      Nested(FfrmMov_ServicosPrestados_Add);
  end;

end;

procedure TfrmMov_ServicosPrestados.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmMov_ServicosPrestados.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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