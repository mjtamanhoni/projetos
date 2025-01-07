unit uConfiguracoes;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms,
  uPrincipal, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Mask;

type
  TfrmConfiguracoes = class(TfrmPrincipal)
    pcPrincipal: TPageControl;
    tsBancoDeDados: TTabSheet;
    tsPlanoContasPadrao: TTabSheet;
    tsFinanceiro: TTabSheet;
    lbBD_Servidor: TLabel;
    edBD_Servidor: TEdit;
    lbBD_Porta: TLabel;
    lbBD_Banco: TLabel;
    edBD_BancoDados: TButtonedEdit;
    ImageList: TImageList;
    lbBD_Usuario: TLabel;
    edBD_Usuario: TEdit;
    lbBD_Senha: TLabel;
    edBD_Senha: TEdit;
    lbBD_Biblioteca: TLabel;
    edBD_Biblioteca: TButtonedEdit;
    lbCP_ApontamentoHoras: TLabel;
    edCP_ApontamentoHoras_ID: TButtonedEdit;
    edCP_ApontamentoHoras: TEdit;
    lbCP_Horas_Exc_Mes_Ant: TLabel;
    edCP_Horas_Exc_Mes_Ant_ID: TButtonedEdit;
    edCP_Horas_Exc_Mes_Ant: TEdit;
    lbCP_Horas_Pagas: TLabel;
    edCP_Horas_Pagas_ID: TButtonedEdit;
    edCP_Horas_Pagas: TEdit;
    lbCP_Horas_Recebidas: TLabel;
    edCP_Horas_Recebidas_ID: TButtonedEdit;
    edCP_Horas_Recebidas: TEdit;
    lbFP_Horas: TLabel;
    edFP_Horas: TMaskEdit;
    tsServidor: TTabSheet;
    lbS_Host: TLabel;
    edS_Host: TEdit;
    lbS_Porta: TLabel;
    edS_Porta: TSpinEdit;
    edBD_Porta: TButtonedEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmConfiguracoes:TfrmConfiguracoes;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmConfiguracoes:TfrmConfiguracoes;
begin
  result:= TfrmConfiguracoes(TfrmConfiguracoes.GetInstance);
end;

procedure TfrmConfiguracoes.ExportD2Bridge;
begin
  inherited;

  Title:= 'Configurações';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin

    with Row.Items.Add do
     with Tabs('TabControl1') do
     begin
      //Disable Tabs
      //ShowTabs:= false;

      with AddTab(pcPrincipal.Pages[0].Caption).Items.Add do
      begin
        with Card.Items.Add do
        begin
          with Row.Items.Add do
          begin
            FormGroup(lbBD_Servidor.Caption, CSSClass.Col.colsize10).AddVCLObj(edBD_Servidor);
            FormGroup(lbBD_Porta.Caption, CSSClass.Col.colsize2).AddVCLObj(edBD_Porta);
          end;
          with Row.Items.Add do
          begin
            FormGroup(lbBD_Banco.Caption, CSSClass.Col.colsize12).AddVCLObj(edBD_BancoDados);
          end;
          with Row.Items.Add do
          begin
            FormGroup(lbBD_Usuario.Caption, CSSClass.Col.colsize6).AddVCLObj(edBD_Usuario);
            FormGroup(lbBD_Senha.Caption, CSSClass.Col.colsize6).AddVCLObj(edBD_Senha);
          end;
          with Row.Items.Add do
          begin
            FormGroup(lbBD_Biblioteca.Caption, CSSClass.Col.colsize12).AddVCLObj(edBD_Biblioteca);
          end;
        end;
      end;


      with AddTab(pcPrincipal.Pages[1].Caption).Items.Add do
      begin
        with Card.Items.Add do
        begin
          with Row.Items.Add do
          begin
            FormGroup(lbCP_ApontamentoHoras.Caption, CSSClass.Col.colsize2).AddVCLObj(edCP_ApontamentoHoras_ID);
            FormGroup('', CSSClass.Col.colsize10).AddVCLObj(edCP_ApontamentoHoras);
          end;
          with Row.Items.Add do
          begin
            FormGroup(lbCP_Horas_Exc_Mes_Ant.Caption, CSSClass.Col.colsize2).AddVCLObj(edCP_Horas_Exc_Mes_Ant_ID);
            FormGroup('', CSSClass.Col.colsize10).AddVCLObj(edCP_Horas_Exc_Mes_Ant);
          end;
          with Row.Items.Add do
          begin
            FormGroup(lbCP_Horas_Pagas.Caption, CSSClass.Col.colsize2).AddVCLObj(edCP_Horas_Pagas_ID);
            FormGroup('', CSSClass.Col.colsize10).AddVCLObj(edCP_Horas_Pagas);
          end;
          with Row.Items.Add do
          begin
            FormGroup(lbCP_Horas_Pagas.Caption, CSSClass.Col.colsize2).AddVCLObj(edCP_Horas_Pagas_ID);
            FormGroup('', CSSClass.Col.colsize10).AddVCLObj(edCP_Horas_Pagas);
          end;
          with Row.Items.Add do
          begin
            FormGroup(lbCP_Horas_Recebidas.Caption, CSSClass.Col.colsize2).AddVCLObj(edCP_Horas_Recebidas_ID);
            FormGroup('', CSSClass.Col.colsize10).AddVCLObj(edCP_Horas_Recebidas);
          end;
        end;
      end;


      {
      with AddTab(pcPrincipal.Pages[2].Caption).Items.Add do
      FormGroup(lbFinanceiropadrao.Caption, CSSClass.Col.colsize4).AddVCLObj(lbFinanceiropadrao);

      with AddTab(pcPrincipal.Pages[3].Caption).Items.Add do
      FormGroup(lbFinanceiropadrao.Caption, CSSClass.Col.colsize4).AddVCLObj(lbFinanceiropadrao);
      }
     end;
  end;

end;

procedure TfrmConfiguracoes.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmConfiguracoes.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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
