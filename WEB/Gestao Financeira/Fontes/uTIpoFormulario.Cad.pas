unit uTIpoFormulario.Cad;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 

  System.JSON,
  IniFiles,
  DataSet.Serialize,
  RESTRequest4D,

  uPrincipal,
  uFuncoes.Gerais,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TfrmTipoFormulario_Cad = class(TD2BridgeForm)
    btCancelar: TButton;
    btConfirmar: TButton;
    pnRow001: TPanel;
    lbid: TLabel;
    lbStatus: TLabel;
    edid: TEdit;
    cbstatus: TComboBox;
    lbtipo: TLabel;
    cbtipo: TComboBox;
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrotipo: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrodt_cadastro: TDateField;
    FDMem_Registrohr_cadastro: TTimeField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_Registrostatus_desc: TStringField;
    FDMem_Registrotipo_desc: TStringField;
    Panel1: TPanel;
    lbdescricao: TLabel;
    edDescricao: TMemo;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

  public
    procedure Configura_Form;
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmTipoFormulario_Cad:TfrmTipoFormulario_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmTipoFormulario_Cad:TfrmTipoFormulario_Cad;
begin
  result:= TfrmTipoFormulario_Cad(TfrmTipoFormulario_Cad.GetInstance);
end;

procedure TfrmTipoFormulario_Cad.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTipoFormulario_Cad.btConfirmarClick(Sender: TObject);
var
  FResp :IResponse;
  FBody :TJSONArray;
begin
  try
    try
      if Trim(FHost) = '' then
        raise Exception.Create('Host n�o informado');

      {$Region 'Gravando/Gerando JSon dos dados'}
        FDMem_Registro.Active := False;
        FDMem_Registro.Active := True;

        if ((Gestao_Financeira.Projeto_Status_Tab = 'Edit') and (Trim(edid.Text) = ''))  then
          raise Exception.Create('Id do Tipo de Formul�rio � obrigat�rio');

        if Trim(eddescricao.Text) = '' then
          raise Exception.Create('Nome do Tipo de Formul�rio � obrigat�rio');

        FDMem_Registro.Insert;
          if Gestao_Financeira.TipoFormulario_Status_Tab = 'Edit' then
            FDMem_Registro.FieldByName('id').AsInteger := StrToIntDef(edid.Text,0);

          FDMem_Registro.FieldByName('descricao').AsString := eddescricao.Text;
          FDMem_Registro.FieldByName('status').AsInteger := cbstatus.ItemIndex;
          FDMem_Registro.FieldByName('tipo').AsInteger := cbtipo.ItemIndex;
        FDMem_Registro.Post;
        FDMem_Registro.ToJSONArray;
      {$EndRegion 'Gravando/Gerando JSon dos dados'}

      {$Region 'Enviando dados para o Servidor'}
        FBody := FDMem_Registro.ToJSONArray;
        if FBody.Size = 0 then
          raise Exception.Create('N�o h� dados para serem salvos.');

        if Gestao_Financeira.TipoFormulario_Status_Tab = 'Insert' then
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('tipoForm')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end
        else
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('tipoForm')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Put;
        end;

        if FResp.StatusCode = 200 then
          Close
        else
          raise Exception.Create(FResp.Content);

      {$EndRegion 'Enviando dados para o Servidor'}

      Close;
    except on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Close;
      end;
    end;
  finally

  end;
end;

procedure TfrmTipoFormulario_Cad.Configura_Form;
begin
  edid.Clear;
  eddescricao.Clear;
  cbstatus.ItemIndex := -1;
  cbtipo.ItemIndex := -1;
end;

procedure TfrmTipoFormulario_Cad.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Tipo de Formul�rio';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with Card.Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup(lbid.Caption,CSSClass.Col.colsize2).AddVCLObj(edid);
          FormGroup(lbStatus.Caption,CSSClass.Col.colsize3).AddVCLObj(cbstatus);
          FormGroup(lbtipo.Caption,CSSClass.Col.colsize3).AddVCLObj(cbtipo);
        end;
        with Row.Items.Add do
          FormGroup(lbdescricao.Caption,CSSClass.Col.col).AddVCLObj(eddescricao);
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize2);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize2);
    end;
  end;
  end;

end;

procedure TfrmTipoFormulario_Cad.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmTipoFormulario_Cad.FormShow(Sender: TObject);
begin
  Configura_Form;
end;

procedure TfrmTipoFormulario_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmTipoFormulario_Cad.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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