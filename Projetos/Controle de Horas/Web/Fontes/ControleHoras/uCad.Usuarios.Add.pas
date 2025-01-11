unit uCad.Usuarios.Add;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;



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
    FDMem_RegistroTIPO: TIntegerField;
    FDMem_RegistroID_CLIENTE: TIntegerField;
    FDMem_RegistroFORM_INICIAL: TStringField;
    FDMem_RegistroCLIENTE: TStringField;
    FDMem_RegistroTIPO_DESC: TStringField;
    lbTIPO: TLabel;
    cbTIPO: TDBComboBox;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE: TDBEdit;
    lbCLIENTE: TLabel;
    edCLIENTE: TDBEdit;
    lbFORM_INICIAL: TLabel;
    edFORM_INICIAL: TDBEdit;
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FStatus_Tabela: Integer;
    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

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
  FResp :IResponse;
  FBody :TJSONArray;
begin
  //Salvando o Usuário...
  try
    try
      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if FDMem_Registro.IsEmpty then
        raise Exception.Create('Não há registro a ser salvo');

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

  Title:= 'Usuários - Cadastro';

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
        FormGroup(lbTIPO.Caption,CSSClass.Col.colsize2).AddVCLObj(cbTIPO);
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
        FormGroup('',CSSClass.Col.colsize10).AddVCLObj(edEMPRESA);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbID_PRESTADOR_SERVICO.Caption,CSSClass.Col.colsize2).AddVCLObj(edID_PRESTADOR_SERVICO);
        FormGroup('',CSSClass.Col.colsize10).AddVCLObj(edPRESTADOR_SERVICO);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbID_CLIENTE.Caption,CSSClass.Col.colsize2).AddVCLObj(edID_CLIENTE);
        FormGroup('',CSSClass.Col.colsize10).AddVCLObj(edCLIENTE);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbFORM_INICIAL.Caption,CSSClass.Col.colsize12).AddVCLObj(edFORM_INICIAL);
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

procedure TfrmCad_Usuario_ADD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Action := TCloseAction.caFree;
end;

procedure TfrmCad_Usuario_ADD.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
end;

procedure TfrmCad_Usuario_ADD.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

 //if PrismControl.VCLComponent = edCELULAR then
 // PrismControl.AsEdit.TextMask:= TPrismTextMask.Phone;

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
