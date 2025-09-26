unit uUnidadeFederativa.Cad;

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

  uRegioes.Loc;

type
  TfrmUnidadeFederativa_Cad = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_RegistroidRegiao: TIntegerField;
    FDMem_Registroibge: TIntegerField;
    FDMem_Registrosigla: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrocapital: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistronomeRegiao: TStringField;
    btCancelar: TButton;
    btConfirmar: TButton;
    pnRow001: TPanel;
    lbid: TLabel;
    edid: TEdit;
    pnRow002: TPanel;
    lbidRegiao: TLabel;
    edidRegiao_Desc: TEdit;
    edidRegiao: TButtonedEdit;
    lbibge: TLabel;
    edibge: TEdit;
    lbsigla: TLabel;
    edsigla: TEdit;
    pnRow003: TPanel;
    lbcapital: TLabel;
    edcapital: TEdit;
    lbdescricao: TLabel;
    eddescricao: TEdit;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure edidKeyPress(Sender: TObject; var Key: Char);
    procedure edibgeKeyPress(Sender: TObject; var Key: Char);
    procedure edsiglaKeyPress(Sender: TObject; var Key: Char);
    procedure eddescricaoKeyPress(Sender: TObject; var Key: Char);
    procedure edcapitalKeyPress(Sender: TObject; var Key: Char);
    procedure edidRegiaoRightButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmRegioes_Loc :TfrmRegioes_Loc;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    procedure ShowPopup(const AName:String; var CanShow:Boolean);
    procedure PopupOpened(AName:String); override;

    procedure ClosePopup(const AName:String; var CanClose:Boolean);
    procedure PopupClosed(const AName:String); override;

  public
    procedure Configura_Form;

  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmUnidadeFederativa_Cad:TfrmUnidadeFederativa_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmUnidadeFederativa_Cad:TfrmUnidadeFederativa_Cad;
begin
  result:= TfrmUnidadeFederativa_Cad(TfrmUnidadeFederativa_Cad.GetInstance);
end;

procedure TfrmUnidadeFederativa_Cad.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUnidadeFederativa_Cad.btConfirmarClick(Sender: TObject);
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

        if ((Gestao_Financeira.UF_Status_Tab = 'Edit') and (Trim(edid.Text) = ''))  then
          raise Exception.Create('Id da Unidade Federativa é obrigatória.');

        if Trim(edibge.Text) = '' then
          raise Exception.Create('Código IBGE da Unidade Federativa é obrigatória.');

        if Trim(eddescricao.Text) = '' then
          raise Exception.Create('Descrição do Formulário do Projeto é obrigatória.');

        if Trim(edsigla.Text) = '' then
          raise Exception.Create('Sigla da Unidade Federativa é obrigatória.');

        if Trim(edcapital.Text) = '' then
          raise Exception.Create('Capital da Unidade Federativa é obrigatória.');

        if Trim(edidRegiao.Text) = '' then
          raise Exception.Create('Região da Unidade Federativa é obrigatória.');

        FDMem_Registro.Insert;
          if Gestao_Financeira.UF_Status_Tab = 'Edit' then
            FDMem_Registro.FieldByName('id').AsInteger := StrToIntDef(edid.Text,0);

          FDMem_Registro.FieldByName('idRegiao').AsInteger := StrToIntDef(edidRegiao.Text,0);
          FDMem_Registro.FieldByName('ibge').AsInteger := StrToIntDef(edibge.Text,0);
          FDMem_Registro.FieldByName('sigla').AsString := edsigla.Text;
          FDMem_Registro.FieldByName('descricao').AsString := eddescricao.Text;
          FDMem_Registro.FieldByName('capital').AsString := edcapital.Text;
        FDMem_Registro.Post;
        FDMem_Registro.ToJSONArray;
      {$EndRegion 'Gravando/Gerando JSon dos dados'}

      {$Region 'Enviando dados para o Servidor'}
        FBody := FDMem_Registro.ToJSONArray;
        if FBody.Size = 0 then
          raise Exception.Create('Não há dados para serem salvos.');

        if Gestao_Financeira.UF_Status_Tab = 'Insert' then
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('unidadeFederativa')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end
        else
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('unidadeFederativa')
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
        ShowMessage(E.Message);
        Close;
      end;
    end;
  finally

  end;
end;

procedure TfrmUnidadeFederativa_Cad.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmUnidadeFederativa_Cad.Configura_Form;
begin
  edid.Clear;
  edibge.Clear;
  edsigla.Clear;
  eddescricao.Clear;
  edcapital.Clear;
  edidRegiao.Clear;
  edidRegiao_Desc.Clear;
end;

procedure TfrmUnidadeFederativa_Cad.edcapitalKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edidRegiao.SetFocus;

end;

procedure TfrmUnidadeFederativa_Cad.eddescricaoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edcapital.SetFocus;

end;

procedure TfrmUnidadeFederativa_Cad.edibgeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edsigla.SetFocus;

end;

procedure TfrmUnidadeFederativa_Cad.edidKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edibge.SetFocus;

end;

procedure TfrmUnidadeFederativa_Cad.edidRegiaoRightButtonClick(Sender: TObject);
begin
  ShowPopupModal('Popup' + FfrmRegioes_Loc.Name);
end;

procedure TfrmUnidadeFederativa_Cad.edsiglaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    eddescricao.SetFocus;

end;

procedure TfrmUnidadeFederativa_Cad.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Unidades Federativas';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmRegioes_Loc := TfrmRegioes_Loc.Create(Self);
  D2Bridge.AddNested(FfrmRegioes_Loc);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with Card.Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup(lbid.Caption,CSSClass.Col.colsize2).AddVCLObj(edid);
          FormGroup(lbibge.Caption,CSSClass.Col.colsize2).AddVCLObj(edibge);
          FormGroup(lbsigla.Caption,CSSClass.Col.colsize2).AddVCLObj(edsigla);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbdescricao.Caption,CSSClass.col.colsize6).Items.Add.VCLObj(eddescricao);
          FormGroup(lbcapital.Caption,CSSClass.col.colsize6).Items.Add.VCLObj(edcapital);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbidRegiao.Caption,CSSClass.col.colsize2).Items.Add.VCLObj(edidRegiao);
          FormGroup('',CSSClass.col.col).Items.Add.VCLObj(edidRegiao_Desc);
        end;
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize2);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize2);
    end;

    with Popup('Popup' + FfrmRegioes_Loc.Name,'Localiza Região',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmRegioes_Loc);
  end;

end;

procedure TfrmUnidadeFederativa_Cad.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmUnidadeFederativa_Cad.FormShow(Sender: TObject);
begin
  Configura_Form;
end;

procedure TfrmUnidadeFederativa_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = edidRegiao then
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

procedure TfrmUnidadeFederativa_Cad.PopupClosed(const AName: String);
begin
  inherited;
  if UpperCase(AName) = UpperCase('Popup' + FfrmRegioes_Loc.Name)  then
  begin
    edidRegiao.Text := Gestao_Financeira.Regiao_ID.ToString;
    edidRegiao_Desc.Text := Gestao_Financeira.Regiao_Nome;
  end;

end;

procedure TfrmUnidadeFederativa_Cad.PopupOpened(AName: String);
begin
  inherited;

end;

procedure TfrmUnidadeFederativa_Cad.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmUnidadeFederativa_Cad.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.