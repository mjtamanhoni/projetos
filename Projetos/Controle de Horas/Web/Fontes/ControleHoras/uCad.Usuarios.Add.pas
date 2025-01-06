unit uCad.Usuarios.Add;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uFormat.VCL;



type
  TfrmCad_Usuario_ADD = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroNOME: TStringField;
    FDMem_RegistroLOGIN: TStringField;
    FDMem_RegistroSENHA: TStringField;
    FDMem_RegistroPIN: TStringField;
    FDMem_RegistroCELULAR: TStringField;
    FDMem_RegistroEMAIL: TStringField;
    FDMem_RegistroID_EMPRESA: TIntegerField;
    FDMem_RegistroID_PRESTADOR_SERVICO: TIntegerField;
    FDMem_RegistroFOTO: TStringField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroSINCRONIZADO: TIntegerField;
    FDMem_RegistroEMPRESA: TStringField;
    FDMem_RegistroPRESTADOR_SERVICO: TStringField;
    dmRegistro: TDataSource;
    lbID: TLabel;
    edID: TDBEdit;
    lbNOME: TLabel;
    edNOME: TDBEdit;
    lbLOGIN: TLabel;
    edLOGIN: TDBEdit;
    lbSENHA: TLabel;
    edSENHA: TDBEdit;
    lbPIN: TLabel;
    edPIN: TDBEdit;
    lbCELULAR: TLabel;
    edCELULAR: TDBEdit;
    lbEMAIL: TLabel;
    edEMAIL: TDBEdit;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA: TDBEdit;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO: TDBEdit;
    lbFOTO: TLabel;
    edFOTO: TDBEdit;
    lbEMPRESA: TLabel;
    edEMPRESA: TDBEdit;
    lbPRESTADOR_SERVICO: TLabel;
    edPRESTADOR_SERVICO: TDBEdit;
    btConfirmar: TButton;
    btCancelar: TButton;
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    FStatus_Tabela: Integer;
  public
    property Status_Tabela :Integer read FStatus_Tabela write FStatus_Tabela;
      //0-Inserir
      //1-Editar
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmCad_Usuario_ADD:TfrmCad_Usuario_ADD;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_Usuario_ADD:TfrmCad_Usuario_ADD;
begin
  result:= TfrmCad_Usuario_ADD(TfrmCad_Usuario_ADD.GetInstance);
end;

procedure TfrmCad_Usuario_ADD.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCad_Usuario_ADD.btConfirmarClick(Sender: TObject);
var
  FHost :String;
  FResp :IResponse;
  FBody :TJSONArray;
begin
  //Salvando o Usu�rio...
  try
    try

      FHost := '';
      FHost := 'http:\\localhost:3000';

      if Trim(FHost) = '' then
        raise Exception.Create('Host n�o informado');

      if FDMem_Registro.IsEmpty then
        raise Exception.Create('N�o h� registro a ser salvo');

      FBody := FDMem_Registro.ToJSONArray;
      case FStatus_Tabela of
        0:begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('usuario')
                   .TokenBearer(ControleHoras.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('usuario')
                   .TokenBearer(ControleHoras.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if FResp.StatusCode = 200 then
        Close
      else
        raise Exception.Create(FResp.Content);

    except on E: Exception do
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    end;
  finally
  end;

end;

procedure TfrmCad_Usuario_ADD.ExportD2Bridge;
begin
  inherited;

  Title:= 'Usu�rios - Cadastro';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin
    with card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbID.Caption,CSSClass.Col.colsize2).AddVCLObj(edID);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbNOME.Caption,CSSClass.Col.colsize12).AddVCLObj(edNOME);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbLOGIN.Caption,CSSClass.Col.colsize5).AddVCLObj(edLOGIN);
        FormGroup(lbSENHA.Caption,CSSClass.Col.colsize5).AddVCLObj(edSENHA);
        FormGroup(lbPIN.Caption,CSSClass.Col.colsize2).AddVCLObj(edPIN);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbCELULAR.Caption,CSSClass.Col.colsize3).AddVCLObj(edCELULAR);
        FormGroup(lbEMAIL.Caption,CSSClass.Col.colsize9).AddVCLObj(edEMAIL);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbID_EMPRESA.Caption,CSSClass.Col.colsize2).AddVCLObj(edID_EMPRESA);
        FormGroup(lbEMPRESA.Caption,CSSClass.Col.colsize10).AddVCLObj(edEMPRESA);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbID_PRESTADOR_SERVICO.Caption,CSSClass.Col.colsize2).AddVCLObj(edID_PRESTADOR_SERVICO);
        FormGroup(lbPRESTADOR_SERVICO.Caption,CSSClass.Col.colsize10).AddVCLObj(edPRESTADOR_SERVICO);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbFOTO.Caption,CSSClass.Col.colsize12).AddVCLObj(edFOTO);
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize3);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize3);
    end;
  end;

end;

procedure TfrmCad_Usuario_ADD.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_Usuario_ADD.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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
