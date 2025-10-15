unit uUsuarios.Empresa;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,
  uFuncoes.Gerais,
  uPrincipal,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Vcl.ExtCtrls,

  uEmpresa.Loc;

type
  TfrmUsuarios_Empresa = class(TD2BridgeForm)
    pnRow001: TPanel;
    lbEmpresa: TLabel;
    pnFooter: TPanel;
    btCancelar: TButton;
    btConfirnar: TButton;
    edidEmpresa: TButtonedEdit;
    edidEmpresa_Desc: TEdit;
    procedure btConfirnarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private

    FfrmEmpresa_Loc :TfrmEmpresa_Loc;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    procedure Pesquisar;

  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmUsuarios_Empresa:TfrmUsuarios_Empresa;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmUsuarios_Empresa:TfrmUsuarios_Empresa;
begin
  result:= TfrmUsuarios_Empresa(TfrmUsuarios_Empresa.GetInstance);
end;

procedure TfrmUsuarios_Empresa.btCancelarClick(Sender: TObject);
begin
  {$Region 'Retornando valores'}
    Gestao_Financeira.Emp_ID := 0;
    Gestao_Financeira.Emp_RazaoSocial := '';
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmUsuarios_Empresa.btConfirnarClick(Sender: TObject);
begin
  if Trim(edidEmpresa.Text) = '' then
  begin
    MessageDlg('É necessário informar a empresa desejada.',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK],0);
    Exit;
  end;

  {$Region 'Retornando valores'}
    Gestao_Financeira.Emp_ID := StrToInt(edidEmpresa.Text);
    Gestao_Financeira.Emp_RazaoSocial := edidEmpresa_Desc.Text;
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmUsuarios_Empresa.ExportD2Bridge;
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

procedure TfrmUsuarios_Empresa.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = edidEmpresa then
  begin
    with PrismControl.AsButtonedEdit do
      ButtonRightCSS:= CSSClass.Button.list;
  end;

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

procedure TfrmUsuarios_Empresa.Pesquisar;
begin

end;

procedure TfrmUsuarios_Empresa.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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