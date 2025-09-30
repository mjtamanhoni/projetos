unit uMunicipios.Cad;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,

  uUnidadeFederativa.Loc;

type
  TfrmMunicipios_Cad = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_RegistroidUf: TIntegerField;
    FDMem_RegistrosiglaUf: TStringField;
    FDMem_Registroibge: TIntegerField;
    FDMem_RegistrocepPadrao: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrounidadeFederativa: TStringField;
    FDMem_Registroregiao: TStringField;
    btCancelar: TButton;
    btConfirmar: TButton;
    pnRow001: TPanel;
    lbid: TLabel;
    lbibge: TLabel;
    edid: TEdit;
    edibge: TEdit;
    lbidUf: TLabel;
    edsiglaUf: TEdit;
    edidUf: TButtonedEdit;
    pnRow003: TPanel;
    lbdescricao: TLabel;
    eddescricao: TEdit;
    edidUf_Desc: TEdit;
    edcepPadrao: TEdit;
    lbcepPadrao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmMunicipios_Cad:TfrmMunicipios_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmMunicipios_Cad:TfrmMunicipios_Cad;
begin
  result:= TfrmMunicipios_Cad(TfrmMunicipios_Cad.GetInstance);
end;

procedure TfrmMunicipios_Cad.ExportD2Bridge;
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

procedure TfrmMunicipios_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmMunicipios_Cad.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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