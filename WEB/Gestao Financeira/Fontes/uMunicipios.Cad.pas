unit uMunicipios.Cad;

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
  uValidacaoDocumentos,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,

  uUnidadeFederativa.Loc;

type
  TfrmMunicipios_Cad = class(TD2BridgeForm)
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
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure edidKeyPress(Sender: TObject; var Key: Char);
    procedure edidUfKeyPress(Sender: TObject; var Key: Char);
    procedure edibgeKeyPress(Sender: TObject; var Key: Char);
    procedure edcepPadraoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edcepPadraoExit(Sender: TObject);
  private
    FfrmUnidadeFederativa_Loc :TfrmUnidadeFederativa_Loc;

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

function frmMunicipios_Cad:TfrmMunicipios_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmMunicipios_Cad:TfrmMunicipios_Cad;
begin
  result:= TfrmMunicipios_Cad(TfrmMunicipios_Cad.GetInstance);
end;

procedure TfrmMunicipios_Cad.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMunicipios_Cad.btConfirmarClick(Sender: TObject);
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

        //Adicionando as validações...

        FDMem_Registro.Insert;
          if Gestao_Financeira.Mun_Status_Tag = 'Edit' then
            FDMem_Registro.FieldByName('id').AsInteger := StrToIntDef(edid.Text,0);

          FDMem_Registro.FieldByName('idUf').AsInteger := StrToIntDef(edidUf.Text,0);
          FDMem_Registro.FieldByName('siglaUf').AsString := edsiglaUf.Text;
          FDMem_Registro.FieldByName('ibge').AsInteger := StrToIntDef(edibge.Text,0);
          FDMem_Registro.FieldByName('cepPadrao').AsString := edcepPadrao.Text;
          FDMem_Registro.FieldByName('descricao').AsString := eddescricao.Text;
          FDMem_Registro.FieldByName('dtCadastro').AsDateTime := Date;
          FDMem_Registro.FieldByName('hrCadastro').AsDateTime := Time;

        FDMem_Registro.Post;
        FDMem_Registro.ToJSONArray;
      {$EndRegion 'Gravando/Gerando JSon dos dados'}

      {$Region 'Enviando dados para o Servidor'}
        FBody := FDMem_Registro.ToJSONArray;
        if FBody.Size = 0 then
          raise Exception.Create('Não há dados para serem salvos.');

        if Gestao_Financeira.Mun_Status_Tag = 'Insert' then
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('municipio')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end
        else
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('municipio')
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

procedure TfrmMunicipios_Cad.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmMunicipios_Cad.Configura_Form;
begin
  edid.Clear;
  edidUf.Clear;
  edsiglaUf.Clear;
  edidUf_Desc.Clear;
  edibge.Clear;
  edcepPadrao.Clear;
  eddescricao.Clear;
end;

procedure TfrmMunicipios_Cad.edcepPadraoExit(Sender: TObject);
begin
  with ValidarDocumento(edcepPadrao.Text,tdCEP) do
  begin
    if not Valido then
    begin
      MessageDlg(Mensagem, TMsgDlgType.mtInformation, [mbok], 0);
      if edcepPadrao.CanFocus then
        edcepPadrao.SetFocus;
    end;
  end;
end;

procedure TfrmMunicipios_Cad.edcepPadraoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    eddescricao.SetFocus;

end;

procedure TfrmMunicipios_Cad.edibgeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edcepPadrao.SetFocus;

end;

procedure TfrmMunicipios_Cad.edidKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edidUf.SetFocus;

end;

procedure TfrmMunicipios_Cad.edidUfKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edibge.SetFocus;

end;

procedure TfrmMunicipios_Cad.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Municípios';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmUnidadeFederativa_Loc := TfrmUnidadeFederativa_Loc.Create(Self);
  D2Bridge.AddNested(FfrmUnidadeFederativa_Loc);


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
          FormGroup(lbcepPadrao.Caption,CSSClass.Col.colsize2).AddVCLObj(edcepPadrao);
        end;
        with Row.Items.Add do
        begin
          with FormGroup('Unidade Federativa',CSSClass.col.colsize12).items.Add do
          begin
            //with Row.Items.Add do
            begin
              FormGroup('',CSSClass.Col.colsize2).AddVCLObj(edidUf);
              FormGroup('',CSSClass.Col.colsize2).AddVCLObj(edsiglaUf);
              FormGroup('',CSSClass.Col.colsize8).AddVCLObj(edidUf_Desc);
            end;
          end;
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbdescricao.Caption,CSSClass.col.colsize12).Items.Add.VCLObj(eddescricao);
        end;
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize2);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize2);
    end;

    with Popup('Popup' + FfrmUnidadeFederativa_Loc.Name,'Localiza Unidade Federativa',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmUnidadeFederativa_Loc);
  end;

end;

procedure TfrmMunicipios_Cad.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmMunicipios_Cad.FormShow(Sender: TObject);
begin
  Configura_Form;
end;

procedure TfrmMunicipios_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = edidUf then
  begin
    with PrismControl.AsButtonedEdit do
      ButtonRightCSS:= CSSClass.Button.list;
  end;

   if PrismControl.VCLComponent = edcepPadrao then
     PrismControl.AsEdit.TextMask := TPrismTextMask.BrazilCep;


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

procedure TfrmMunicipios_Cad.PopupClosed(const AName: String);
begin
  inherited;
  if UpperCase(AName) = UpperCase('Popup' + FfrmUnidadeFederativa_Loc.Name)  then
  begin
    edidUf.Text := Gestao_Financeira.UF_Id.ToString;
    edsiglaUf.Text := Gestao_Financeira.UF_Sigla;
    edidUf_Desc.Text := Gestao_Financeira.UF_Descricao;
  end;

end;

procedure TfrmMunicipios_Cad.PopupOpened(AName: String);
begin
  inherited;

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

procedure TfrmMunicipios_Cad.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.