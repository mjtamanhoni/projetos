unit uConfiguracoes;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,

  D2Bridge.Forms,
  uPrincipal, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Mask,
  IniFiles;

type
  TfrmConfiguracoes = class(TfrmPrincipal)
    pcPrincipal: TPageControl;
    tsPlanoContasPadrao: TTabSheet;
    tsFinanceiro: TTabSheet;
    ImageList: TImageList;
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
    tsServidor: TTabSheet;
    lbS_Host: TLabel;
    edS_Host: TEdit;
    lbS_Porta: TLabel;
    edS_Porta: TEdit;
    edFP_Horas: TEdit;
    pnTools: TPanel;
    btConfirmar: TButton;
    btCancelar: TButton;
    OpenDialog: TOpenDialog;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edCP_ApontamentoHoras_IDRightButtonClick(Sender: TObject);
  private
    FIniFiles :TIniFile;
    FEnder :String;
    FHost :String;

    procedure Ler_Config;
    procedure Salvar_Config;
    procedure Loc_Conta(Sender: TObject);
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

procedure TfrmConfiguracoes.btConfirmarClick(Sender: TObject);
begin
  inherited;
  Salvar_Config;
  Close;
end;

procedure TfrmConfiguracoes.edCP_ApontamentoHoras_IDRightButtonClick(Sender: TObject);
begin
  inherited;
  Loc_Conta(Sender);
end;

procedure TfrmConfiguracoes.Loc_Conta(Sender :TObject);
begin
  //
end;

procedure TfrmConfiguracoes.Salvar_Config;
begin
  try

    {$Region 'Contas padrão'}
      FIniFiles.WriteString('CONTAS.PADRAO','AP.HORAS.ID',edCP_ApontamentoHoras_ID.Text);
      FIniFiles.WriteString('CONTAS.PADRAO','AP.HORAS',edCP_ApontamentoHoras.Text);
      FIniFiles.WriteString('CONTAS.PADRAO','HORAS.EXC.MES.ANT.ID',edCP_Horas_Exc_Mes_Ant_ID.Text);
      FIniFiles.WriteString('CONTAS.PADRAO','HORAS.EXC.MES.ANT',edCP_Horas_Exc_Mes_Ant.Text);
      FIniFiles.WriteString('CONTAS.PADRAO','HORAS.PAGAS.ID',edCP_Horas_Pagas_ID.Text);
      FIniFiles.WriteString('CONTAS.PADRAO','HORAS.PAGAS',edCP_Horas_Pagas.Text);
      FIniFiles.WriteString('CONTAS.PADRAO','HORAS.RECEBIDAS.ID',edCP_Horas_Recebidas_ID.Text);
      FIniFiles.WriteString('CONTAS.PADRAO','HORAS.RECEBIDAS',edCP_Horas_Recebidas.Text);
    {$EndRegion 'Contas padrão'}

    {$Region 'Financeiro padrão'}
      FIniFiles.WriteString('FINANCEIRO.PADRAO','HORAS.PREVISTAS',edFP_Horas.Text);
    {$EndRegion 'Financeiro padrão'}

    {$Region 'Servidor padrão'}
      FIniFiles.WriteString('SERVIDOR.PADRAO','HOST',edS_Host.Text);
      FIniFiles.WriteString('SERVIDOR.PADRAO','PORTA',edS_Porta.Text);
    {$EndRegion 'Servidor padrão'}

  except on E: Exception do
    MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
  end;
end;

procedure TfrmConfiguracoes.Ler_Config;
begin
  try
    {$Region 'Contas padrão'}
      edCP_ApontamentoHoras_ID.Text := FIniFiles.ReadString('CONTAS.PADRAO','AP.HORAS.ID','');
      edCP_ApontamentoHoras.Text := FIniFiles.ReadString('CONTAS.PADRAO','AP.HORAS','');
      edCP_Horas_Exc_Mes_Ant_ID.Text := FIniFiles.ReadString('CONTAS.PADRAO','HORAS.EXC.MES.ANT.ID','');
      edCP_Horas_Exc_Mes_Ant.Text := FIniFiles.ReadString('CONTAS.PADRAO','HORAS.EXC.MES.ANT','');
      edCP_Horas_Pagas_ID.Text := FIniFiles.ReadString('CONTAS.PADRAO','HORAS.PAGAS.ID','');
      edCP_Horas_Pagas.Text := FIniFiles.ReadString('CONTAS.PADRAO','HORAS.PAGAS','');
      edCP_Horas_Recebidas_ID.Text := FIniFiles.ReadString('CONTAS.PADRAO','HORAS.RECEBIDAS.ID','');
      edCP_Horas_Recebidas.Text := FIniFiles.ReadString('CONTAS.PADRAO','HORAS.RECEBIDAS','');
    {$EndRegion 'Contas padrão'}

    {$Region 'Financeiro padrão'}
      edFP_Horas.Text := FIniFiles.ReadString('FINANCEIRO.PADRAO','HORAS.PREVISTAS','');
    {$EndRegion 'Financeiro padrão'}

    {$Region 'Servidor padrão'}
      edS_Host.Text := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','');
      edS_Porta.Text := FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
      FHost := '';
      FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
    {$EndRegion 'Servidor padrão'}
  except on E: Exception do
    MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
  end;
end;

procedure TfrmConfiguracoes.btCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
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
    begin
      VCLObj(pnTools);
      with Row(CSSClass.DivHtml.Align_Center).Items.Add do
      begin
        VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize3);
        VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize3);
      end;
    end;

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
            FormGroup(lbCP_Horas_Recebidas.Caption, CSSClass.Col.colsize2).AddVCLObj(edCP_Horas_Recebidas_ID);
            FormGroup('', CSSClass.Col.colsize10).AddVCLObj(edCP_Horas_Recebidas);
          end;
        end;
      end;

      with AddTab(pcPrincipal.Pages[1].Caption).Items.Add do
      begin
        with Card.Items.Add do
        begin
          with Row.Items.Add do
          begin
            FormGroup(lbFP_Horas.Caption, CSSClass.Col.colsize2).AddVCLObj(edFP_Horas);
          end;
        end;
      end;

      with AddTab(pcPrincipal.Pages[2].Caption).Items.Add do
      begin
        with Card.Items.Add do
        begin
          with Row.Items.Add do
          begin
            FormGroup(lbS_Host.Caption, CSSClass.Col.colsize10).AddVCLObj(edS_Host);
            FormGroup(lbS_Porta.Caption, CSSClass.Col.colsize2).AddVCLObj(edS_Porta);
          end;
        end;
      end;

     end;
  end;

end;

procedure TfrmConfiguracoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := TCloseAction.caFree;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  inherited;
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  pcPrincipal.ActivePage := tsPlanoContasPadrao;
end;

procedure TfrmConfiguracoes.FormShow(Sender: TObject);
begin
  inherited;
  Ler_Config;
end;

procedure TfrmConfiguracoes.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

 if PrismControl.VCLComponent = edS_Host then
  PrismControl.AsEdit.TextMask:= TPrismTextMask.URL;

 if PrismControl.VCLComponent = edS_Porta then
  PrismControl.AsEdit.TextMask:= '''mask'' : ''9999''';

 if PrismControl.VCLComponent = edFP_Horas then
  PrismControl.AsEdit.TextMask:= '''mask'' : ''999:99:99''';


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
