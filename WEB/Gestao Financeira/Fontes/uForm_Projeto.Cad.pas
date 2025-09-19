unit uForm_Projeto.Cad;

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
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,

  uTIpoFormulario.Loc, uProjetos.Loc;

type
  TfrmForm_Projeto_Cad = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registroid_projeto: TIntegerField;
    FDMem_Registronome_form: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registroid_tipo_form: TIntegerField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_Registrostatus_desc: TStringField;
    FDMem_Registroid_tipo_form_desc: TStringField;
    FDMem_Registroid_projeto_desc: TStringField;
    FDMem_Registrohr_cadastro: TTimeField;
    FDMem_Registrodt_cadastro: TDateField;
    btCancelar: TButton;
    btConfirmar: TButton;
    pnRow001: TPanel;
    lbid: TLabel;
    lbnome_form: TLabel;
    lbStatus: TLabel;
    edid: TEdit;
    ednome_form: TEdit;
    cbstatus: TComboBox;
    pnRow004: TPanel;
    lbdescricao: TLabel;
    eddescricao: TMemo;
    pnRow003: TPanel;
    lbid_tipo_form: TLabel;
    edid_tipo_form_Desc: TEdit;
    edid_tipo_form: TButtonedEdit;
    pnRow002: TPanel;
    lbid_projeto: TLabel;
    edid_projeto_Desc: TEdit;
    edid_projeto: TButtonedEdit;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmTipoFormulario_Loc :TfrmTipoFormulario_Loc;
    FfrmProjetos_Loc :TfrmProjetos_Loc;

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

function frmForm_Projeto_Cad:TfrmForm_Projeto_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmForm_Projeto_Cad:TfrmForm_Projeto_Cad;
begin
  result:= TfrmForm_Projeto_Cad(TfrmForm_Projeto_Cad.GetInstance);
end;

procedure TfrmForm_Projeto_Cad.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmForm_Projeto_Cad.btConfirmarClick(Sender: TObject);
var
  FResp :IResponse;
  FBody :TJSONArray;
begin
  try
    try
      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      {$Region 'Gravando/Gerando JSon dos dados'}
        FDMem_Registro.Active := False;
        FDMem_Registro.Active := True;

        if ((Gestao_Financeira.FormProjeto_Status_Tab = 'Edit') and (Trim(edid.Text) = ''))  then
          raise Exception.Create('Id do Formulário do Projeto é obrigatório');

        if Trim(ednome_form.Text) = '' then
          raise Exception.Create('Nome do Formulário do Projeto é obrigatório');

        if Trim(eddescricao.Text) = '' then
          raise Exception.Create('Descrição do Formulário do Projeto é obrigatória');

        if edid_tipo_form.Text = '' then
          raise Exception.Create('Tipo do Formulário é obrigatório');

        FDMem_Registro.Insert;
          if Gestao_Financeira.FormProjeto_Status_Tab = 'Edit' then
            FDMem_Registro.FieldByName('id').AsInteger := StrToIntDef(edid.Text,0);

          FDMem_Registro.FieldByName('status').AsInteger := cbstatus.ItemIndex;
          FDMem_Registro.FieldByName('nome_form').AsString := ednome_form.Text;
          FDMem_Registro.FieldByName('id_projeto').AsInteger := StrToIntDef(edid_tipo_form.Text,0);
          FDMem_Registro.FieldByName('descricao').AsString := eddescricao.Text;

        FDMem_Registro.Post;
        FDMem_Registro.ToJSONArray;
      {$EndRegion 'Gravando/Gerando JSon dos dados'}

      {$Region 'Enviando dados para o Servidor'}
        FBody := FDMem_Registro.ToJSONArray;
        if FBody.Size = 0 then
          raise Exception.Create('Não há dados para serem salvos.');

        if Gestao_Financeira.TipoFormulario_Status_Tab = 'Insert' then
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('telaProjeto')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end
        else
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('telaProjeto')
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

procedure TfrmForm_Projeto_Cad.Configura_Form;
begin
  edid.Clear;
  cbstatus.ItemIndex := -1;
  ednome_form.Clear;
  edid_tipo_form.Clear;
  eddescricao.Clear;
end;

procedure TfrmForm_Projeto_Cad.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Formulários do Projeto';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmTipoFormulario_Loc := TfrmTipoFormulario_Loc.Create(Self);
  D2Bridge.AddNested(FfrmTipoFormulario_Loc);

  FfrmProjetos_Loc := TfrmProjetos_Loc.Create(Self);
  D2Bridge.AddNested(FfrmProjetos_Loc);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with Card.Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup(lbid.Caption,CSSClass.Col.colsize2).AddVCLObj(edid);
          FormGroup(lbStatus.Caption,CSSClass.Col.colsize2).AddVCLObj(cbstatus);
          FormGroup(lbnome_form.Caption,CSSClass.Col.col).AddVCLObj(ednome_form);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbid_projeto.Caption,CSSClass.col.colsize2).Items.Add.VCLObj(edid_projeto);
          FormGroup('',CSSClass.col.col).Items.Add.VCLObj(edid_projeto_Desc);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbid_tipo_form.Caption,CSSClass.col.colsize2).Items.Add.VCLObj(edid_tipo_form);
          FormGroup('',CSSClass.col.col).Items.Add.VCLObj(edid_tipo_form_Desc);
        end;
        with Row.Items.add do
          FormGroup(lbdescricao.Caption,CSSClass.Col.col).AddVCLObj(eddescricao);
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize2);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize2);
    end;

    with Popup('Popup' + FfrmTipoFormulario_Loc.Name,'Localiza Tipo de Formulário',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmTipoFormulario_Loc);

    with Popup('Popup' + FfrmProjetos_Loc.Name,'Localiza Projeto',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmProjetos_Loc);

  end;

end;

procedure TfrmForm_Projeto_Cad.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmForm_Projeto_Cad.FormShow(Sender: TObject);
begin
  Configura_Form;
end;

procedure TfrmForm_Projeto_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = edid_projeto then
  begin
    with PrismControl.AsButtonedEdit do
      ButtonRightCSS:= CSSClass.Button.list;
  end;

  if PrismControl.VCLComponent = edid_tipo_form then
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

procedure TfrmForm_Projeto_Cad.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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