unit uEmpresa.Cad;

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

  uMunicipios.Loc;

type
  TfrmEmpresa_Cad = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_Registrotipo: TIntegerField;
    FDMem_RegistrorazaoSocial: TStringField;
    FDMem_Registrofantasia: TStringField;
    FDMem_Registrocnpj: TStringField;
    FDMem_RegistroinscEstadual: TStringField;
    FDMem_Registrocontato: TStringField;
    FDMem_Registroendereco: TStringField;
    FDMem_Registronumero: TStringField;
    FDMem_Registrocomplemento: TStringField;
    FDMem_Registrobairro: TStringField;
    FDMem_RegistroidCidade: TIntegerField;
    FDMem_RegistrocidadeIbge: TIntegerField;
    FDMem_Registrocidade: TStringField;
    FDMem_RegistrosiglaUf: TStringField;
    FDMem_Registrocep: TStringField;
    FDMem_Registrotelefone: TStringField;
    FDMem_Registrocelular: TStringField;
    FDMem_Registroemail: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrotipoPessoa: TIntegerField;
    FDMem_RegistrostatusDesc: TStringField;
    FDMem_RegistrotipoDesc: TStringField;
    FDMem_RegistrotipoPessoaDesc: TStringField;
    btCancelar: TButton;
    btConfirmar: TButton;
    pnRow001: TPanel;
    lbid: TLabel;
    lbstatus: TLabel;
    edid: TEdit;
    cbstatus: TComboBox;
    pnRow002: TPanel;
    pnRow003: TPanel;
    lbcontato: TLabel;
    edcontato: TEdit;
    lbrazaoSocial: TLabel;
    edrazaoSocial: TEdit;
    lbtipo: TLabel;
    cbtipo: TComboBox;
    edcnpj: TEdit;
    lbcnpj: TLabel;
    edinscEstadual: TEdit;
    lbinscEstadual: TLabel;
    edfantasia: TEdit;
    lbfantasia: TLabel;
    pnRow004: TPanel;
    lbcep: TLabel;
    edendereco: TEdit;
    lbnumero: TLabel;
    ednumero: TEdit;
    pnRow005: TPanel;
    lbcomplemento: TLabel;
    edcomplemento: TEdit;
    edcep: TEdit;
    lbendereco: TLabel;
    pnRow006: TPanel;
    lbbairro: TLabel;
    edbairro: TEdit;
    lbidCidade: TLabel;
    edidCidade: TButtonedEdit;
    edcidadeIbge: TEdit;
    edcidade: TEdit;
    edsiglaUf: TEdit;
    lbsiglaUf: TLabel;
    pnRow007: TPanel;
    lbtelefone: TLabel;
    lbcelular: TLabel;
    lbemail: TLabel;
    edtelefone: TEdit;
    edcelular: TEdit;
    edemail: TEdit;
    lbtipoPessoa: TLabel;
    cbtipoPessoa: TComboBox;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure edcnpjExit(Sender: TObject);
    procedure edinscEstadualExit(Sender: TObject);
    procedure edcepExit(Sender: TObject);
    procedure edidKeyPress(Sender: TObject; var Key: Char);
    procedure cbstatusKeyPress(Sender: TObject; var Key: Char);
    procedure cbtipoKeyPress(Sender: TObject; var Key: Char);
    procedure cbtipoPessoaKeyPress(Sender: TObject; var Key: Char);
    procedure edcnpjKeyPress(Sender: TObject; var Key: Char);
    procedure edinscEstadualKeyPress(Sender: TObject; var Key: Char);
    procedure edrazaoSocialKeyPress(Sender: TObject; var Key: Char);
    procedure edfantasiaKeyPress(Sender: TObject; var Key: Char);
    procedure edcontatoKeyPress(Sender: TObject; var Key: Char);
    procedure edcepKeyPress(Sender: TObject; var Key: Char);
    procedure edenderecoKeyPress(Sender: TObject; var Key: Char);
    procedure ednumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edcomplementoKeyPress(Sender: TObject; var Key: Char);
    procedure edbairroKeyPress(Sender: TObject; var Key: Char);
    procedure edidCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure edcelularKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edidCidadeRightButtonClick(Sender: TObject);
  private
    FfrmMunicipios_Loc :TfrmMunicipios_Loc;

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

function frmEmpresa_Cad:TfrmEmpresa_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmEmpresa_Cad:TfrmEmpresa_Cad;
begin
  result:= TfrmEmpresa_Cad(TfrmEmpresa_Cad.GetInstance);
end;

procedure TfrmEmpresa_Cad.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEmpresa_Cad.btConfirmarClick(Sender: TObject);
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
          if Gestao_Financeira.Emp_Status_Tag = 'Edit' then
            FDMem_Registro.FieldByName('id').AsInteger := StrToIntDef(edid.Text,0);

          FDMem_Registro.FieldByName('status').AsInteger := cbstatus.ItemIndex;
          FDMem_Registro.FieldByName('tipo').AsInteger := cbtipo.ItemIndex;
          FDMem_Registro.FieldByName('razaoSocial').AsString := edrazaoSocial.Text;
          FDMem_Registro.FieldByName('fantasia').AsString := edfantasia.Text;
          FDMem_Registro.FieldByName('cnpj').AsString := edcnpj.Text;
          FDMem_Registro.FieldByName('inscEstadual').AsString := edinscEstadual.Text;
          FDMem_Registro.FieldByName('contato').AsString := edcontato.Text;
          FDMem_Registro.FieldByName('endereco').AsString := edendereco.Text;
          FDMem_Registro.FieldByName('numero').AsString := ednumero.Text;
          FDMem_Registro.FieldByName('complemento').AsString := edcomplemento.Text;
          FDMem_Registro.FieldByName('bairro').AsString := edbairro.Text;
          FDMem_Registro.FieldByName('idCidade').AsInteger := StrToIntDef(edidCidade.Text,0);
          FDMem_Registro.FieldByName('cidadeIbge').AsInteger := StrToIntDef(edcidadeIbge.Text,0);
          FDMem_Registro.FieldByName('cidade').AsString := edcidade.Text;
          FDMem_Registro.FieldByName('siglaUf').AsString := edsiglaUf.Text;
          FDMem_Registro.FieldByName('cep').AsString := edcep.Text;
          FDMem_Registro.FieldByName('telefone').AsString := edtelefone.Text;
          FDMem_Registro.FieldByName('celular').AsString := edcelular.Text;
          FDMem_Registro.FieldByName('email').AsString := edemail.Text;
          FDMem_Registro.FieldByName('dtCadastro').AsDateTime := Date;
          FDMem_Registro.FieldByName('hrCadastro').AsDateTime := Time;
          FDMem_Registro.FieldByName('tipoPessoa').AsInteger := cbtipoPessoa.ItemIndex;
        FDMem_Registro.Post;
        FDMem_Registro.ToJSONArray;
      {$EndRegion 'Gravando/Gerando JSon dos dados'}

      {$Region 'Enviando dados para o Servidor'}
        FBody := FDMem_Registro.ToJSONArray;
        if FBody.Size = 0 then
          raise Exception.Create('Não há dados para serem salvos.');

        if Gestao_Financeira.Emp_Status_Tag = 'Insert' then
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('empresa')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end
        else
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('empresa')
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

procedure TfrmEmpresa_Cad.cbstatusKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cbtipo.SetFocus;

end;

procedure TfrmEmpresa_Cad.cbtipoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cbtipoPessoa.SetFocus;

end;

procedure TfrmEmpresa_Cad.cbtipoPessoaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edcnpj.SetFocus;

end;

procedure TfrmEmpresa_Cad.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmEmpresa_Cad.Configura_Form;
begin
  edid.Clear;
  cbstatus.ItemIndex := 1;
  cbtipo.ItemIndex := -1;
  edrazaoSocial.Clear;
  edfantasia.Clear;
  edcnpj.Clear;
  edinscEstadual.Clear;
  edcontato.Clear;
  edendereco.Clear;
  ednumero.Clear;
  edcomplemento.Clear;
  edbairro.Clear;
  edidCidade.Clear;
  edcidadeIbge.Clear;
  edcidade.Clear;
  edsiglaUf.Clear;
  edcep.Clear;
  edtelefone.Clear;
  edcelular.Clear;
  edemail.Clear;
  cbtipoPessoa.ItemIndex := -1;
end;

procedure TfrmEmpresa_Cad.edbairroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edidCidade.SetFocus;

end;

procedure TfrmEmpresa_Cad.edcelularKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edemail.SetFocus;

end;

procedure TfrmEmpresa_Cad.edcepExit(Sender: TObject);
begin
  if Trim(edcep.Text) = '' then
    Exit;

  with ValidarDocumento(edcep.Text,tdCEP) do
  begin
    if not Valido then
      MessageDlg(Mensagem, TMsgDlgType.mtInformation, [mbok], 0);
  end;

end;

procedure TfrmEmpresa_Cad.edcepKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edendereco.SetFocus;

end;

procedure TfrmEmpresa_Cad.edcnpjExit(Sender: TObject);
begin
  if Trim(edcnpj.Text) = '' then
    Exit;

  with ValidarDocumento(edcnpj.Text,tdCNPJ) do
  begin
    if not Valido then
      MessageDlg(Mensagem, TMsgDlgType.mtInformation, [mbok], 0);
  end;
end;

procedure TfrmEmpresa_Cad.edcnpjKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edinscEstadual.SetFocus;

end;

procedure TfrmEmpresa_Cad.edcomplementoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edbairro.SetFocus;

end;

procedure TfrmEmpresa_Cad.edcontatoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edcep.SetFocus;

end;

procedure TfrmEmpresa_Cad.edenderecoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    ednumero.SetFocus;

end;

procedure TfrmEmpresa_Cad.edfantasiaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edcontato.SetFocus;

end;

procedure TfrmEmpresa_Cad.edidCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edtelefone.SetFocus;

end;

procedure TfrmEmpresa_Cad.edidCidadeRightButtonClick(Sender: TObject);
begin
  ShowPopupModal('Popup' + FfrmMunicipios_Loc.Name);
end;

procedure TfrmEmpresa_Cad.edidKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cbstatus.SetFocus;

end;

procedure TfrmEmpresa_Cad.edinscEstadualExit(Sender: TObject);
begin
  if Trim(edinscEstadual.Text) = '' then
    Exit;
  if Trim(edinscEstadual.Text) = 'ISENTO' then
    Exit;

  with ValidarDocumento(edinscEstadual.Text,tdIE) do
  begin
    if not Valido then
      MessageDlg(Mensagem, TMsgDlgType.mtInformation, [mbok], 0);
  end;
end;

procedure TfrmEmpresa_Cad.edinscEstadualKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edrazaoSocial.SetFocus;

end;

procedure TfrmEmpresa_Cad.ednumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edcomplemento.SetFocus;

end;

procedure TfrmEmpresa_Cad.edrazaoSocialKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edfantasia.SetFocus;

end;

procedure TfrmEmpresa_Cad.edtelefoneKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edcelular.SetFocus;

end;

procedure TfrmEmpresa_Cad.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Empresas';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmMunicipios_Loc := TfrmMunicipios_Loc.Create(Self);
  D2Bridge.AddNested(FfrmMunicipios_Loc);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with Card.Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup(lbid.Caption,CSSClass.Col.colsize1).AddVCLObj(edid);
          FormGroup(lbstatus.Caption,CSSClass.Col.colsize2).AddVCLObj(cbstatus);
          FormGroup(lbtipo.Caption,CSSClass.Col.colsize2).AddVCLObj(cbtipo);
          FormGroup(lbtipoPessoa.Caption,CSSClass.Col.colsize2).AddVCLObj(cbtipoPessoa);
          FormGroup(lbcnpj.Caption,CSSClass.Col.colsize3).AddVCLObj(edcnpj);
          FormGroup(lbinscEstadual.Caption,CSSClass.Col.colsize2).AddVCLObj(edinscEstadual);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbrazaoSocial.Caption,CSSClass.Col.colsize6).AddVCLObj(edrazaoSocial);
          FormGroup(lbfantasia.Caption,CSSClass.Col.colsize6).AddVCLObj(edfantasia);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbcontato.Caption,CSSClass.Col.colsize12).AddVCLObj(edcontato);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbcep.Caption,CSSClass.Col.colsize2).AddVCLObj(edcep);
          FormGroup(lbendereco.Caption,CSSClass.Col.colsize8).AddVCLObj(edendereco);
          FormGroup(lbnumero.Caption,CSSClass.Col.colsize2).AddVCLObj(ednumero);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbcomplemento.Caption,CSSClass.Col.colsize12).AddVCLObj(edcomplemento);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbbairro.Caption,CSSClass.Col.colsize4).AddVCLObj(edbairro);
          with FormGroup(lbidCidade.Caption,CSSClass.col.colsize7).items.Add do
          begin
            FormGroup('',CSSClass.Col.colsize3).AddVCLObj(edidCidade);
            FormGroup('',CSSClass.Col.colsize2).AddVCLObj(edcidadeIbge);
            FormGroup('',CSSClass.Col.colsize7).AddVCLObj(edcidade);
          end;
          FormGroup(lbsiglaUf.Caption,CSSClass.Col.colsize1).AddVCLObj(edsiglaUf);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbtelefone.Caption,CSSClass.col.colsize3).Items.Add.VCLObj(edtelefone);
          FormGroup(lbcelular.Caption,CSSClass.col.colsize3).Items.Add.VCLObj(edcelular);
          FormGroup(lbemail.Caption,CSSClass.col.colsize6).Items.Add.VCLObj(edemail);
        end;
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize2);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize2);
    end;

    with Popup('Popup' + FfrmMunicipios_Loc.Name,'Localiza Municípios (Cidades)',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmMunicipios_Loc);
  end;

end;

procedure TfrmEmpresa_Cad.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmEmpresa_Cad.FormShow(Sender: TObject);
begin
  Configura_Form;
end;

procedure TfrmEmpresa_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = edidCidade then
  begin
    with PrismControl.AsButtonedEdit do
      ButtonRightCSS:= CSSClass.Button.list;
  end;

   if PrismControl.VCLComponent = edcep then
     PrismControl.AsEdit.TextMask := TPrismTextMask.BrazilCep;
   if PrismControl.VCLComponent = edcnpj then
     PrismControl.AsEdit.TextMask := TPrismTextMask.BrazilCNPJ;
   if PrismControl.VCLComponent = edtelefone then
     PrismControl.AsEdit.TextMask := TPrismTextMask.BrazilPhone;
   if PrismControl.VCLComponent = edcelular then
     PrismControl.AsEdit.TextMask := TPrismTextMask.Phone;

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

procedure TfrmEmpresa_Cad.PopupClosed(const AName: String);
begin
  inherited;
  if UpperCase(AName) = UpperCase('Popup' + FfrmMunicipios_Loc.Name)  then
  begin
    edidCidade.Text := Gestao_Financeira.Mun_Id.ToString;
    edcidadeIbge.Text := Gestao_Financeira.Mun_IBGE.ToString;
    edcidade.Text := Gestao_Financeira.Mun_Descricao;
    edsiglaUf.Text := Gestao_Financeira.Mun_SilaUF;
  end;

end;

procedure TfrmEmpresa_Cad.PopupOpened(AName: String);
begin
  inherited;

end;

procedure TfrmEmpresa_Cad.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmEmpresa_Cad.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.