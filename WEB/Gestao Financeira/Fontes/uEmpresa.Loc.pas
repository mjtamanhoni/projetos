unit uEmpresa.Loc;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF,
  Vcl.Menus;

type
  TfrmEmpresa_Loc = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_Registrotipo: TIntegerField;
    FDMem_RegistrorazaoSocial: TStringField;
    FDMem_Registrofantasia: TStringField;
    FDMem_Registrocnpj: TStringField;
    FDMem_RegistroinscEstadual: TStringField;
    FDMem_Registrocontato: TStringField;
    FDMem_Registroendereco: TStringField;
    FDMem_Registronumero: TStringField;
    FDMem_Registrocomplemento: TStringField;
    FDMem_Registrobairro: TStringField;
    FDMem_RegistroidCidade: TIntegerField;
    FDMem_RegistrocidadeIbge: TIntegerField;
    FDMem_Registrocidade: TStringField;
    FDMem_RegistrosiglaUf: TStringField;
    FDMem_Registrocep: TStringField;
    FDMem_Registrotelefone: TStringField;
    FDMem_Registrocelular: TStringField;
    FDMem_Registroemail: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrotipoPessoa: TIntegerField;
    FDMem_RegistrostatusDesc: TStringField;
    FDMem_RegistrotipoDesc: TStringField;
    FDMem_RegistrotipoPessoaDesc: TStringField;
    dsRegistros: TDataSource;
    PopupMenu: TPopupMenu;
    mnuPop_Filtro_ID: TMenuItem;
    mnuFiltro_RazaoSocial: TMenuItem;
    mnuFiltro_NomeFantasia: TMenuItem;
    mnuFiltro_CNPJ: TMenuItem;
    mnuFiltro_Inativo: TMenuItem;
    frxReport: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBDataset: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmEmpresa_Loc:TfrmEmpresa_Loc;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmEmpresa_Loc:TfrmEmpresa_Loc;
begin
  result:= TfrmEmpresa_Loc(TfrmEmpresa_Loc.GetInstance);
end;

procedure TfrmEmpresa_Loc.ExportD2Bridge;
begin
  inherited;

  Title:= 'My D2Bridge Form';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin
   {Yours Controls}
  end;

end;

procedure TfrmEmpresa_Loc.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmEmpresa_Loc.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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