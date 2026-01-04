unit uConfig;

{ Copyright 2026 / 2027 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Classes, SysUtils, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  D2Bridge.Forms, Forms;

type

  { TfrmConfig }

  TfrmConfig = class(TD2BridgeForm)
    btConfirmar: TButton;
    Button2: TButton;
    pnConfirmar: TPanel;
    pnBotoes: TPanel;
    pcConfig: TPageControl;
    pnCancelar: TPanel;
    tsDataBase: TTabSheet;
    procedure btConfirmarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; 
      var HTMLControl: string); override;
  end;

function frmConfig: TfrmConfig;

implementation

uses
  EmissorWebApp;

{$R *.lfm}

function frmConfig: TfrmConfig;
begin
  result:= (TfrmConfig.GetInstance as TfrmConfig);
end;

procedure TfrmConfig.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfig.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := TCloseAction.caFree;
end;

procedure TfrmConfig.btConfirmarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfig.ExportD2Bridge;
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

procedure TfrmConfig.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmConfig.RenderD2Bridge(const PrismControl: TPrismControl;
  var HTMLControl: string);
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
