unit uCad.Cliente.Add;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,

   Vcl.ComCtrls, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  Vcl.ImgList

  ,uCon.Fornecedor
  ,uCon.TabPreco;

type
  TfrmCad_Cliente_Add = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroNOME: TStringField;
    FDMem_RegistroPESSOA: TIntegerField;
    FDMem_RegistroDOCUMENTO: TStringField;
    FDMem_RegistroINSC_EST: TStringField;
    FDMem_RegistroCEP: TStringField;
    FDMem_RegistroENDERECO: TStringField;
    FDMem_RegistroCOMPLEMENTO: TStringField;
    FDMem_RegistroNUMERO: TStringField;
    FDMem_RegistroBAIRRO: TStringField;
    FDMem_RegistroCIDADE: TStringField;
    FDMem_RegistroUF: TStringField;
    FDMem_RegistroTELEFONE: TStringField;
    FDMem_RegistroCELULAR: TStringField;
    FDMem_RegistroEMAIL: TStringField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroPESSOA_DESC: TStringField;
    lbID: TLabel;
    edID: TEdit;
    lbNOME: TLabel;
    edNome: TEdit;
    lbPESSOA: TLabel;
    edDOCUMENTO: TEdit;
    lbDOCUMENTO: TLabel;
    cbPESSOA: TComboBox;
    lbINSC_EST: TLabel;
    edINSC_EST: TEdit;
    lbCEP: TLabel;
    edCEP: TEdit;
    lbENDERECO: TLabel;
    edENDERECO: TEdit;
    edCOMPLEMENTO: TEdit;
    lbCOMPLEMENTO: TLabel;
    lbNUMERO: TLabel;
    edNUMERO: TEdit;
    lbBAIRRO: TLabel;
    edBAIRRO: TEdit;
    edCIDADE: TEdit;
    lbCIDADE: TLabel;
    lbUF: TLabel;
    cbUF: TComboBox;
    edTELEFONE: TEdit;
    lbTELEFONE: TLabel;
    edCELULAR: TEdit;
    lbCELULAR: TLabel;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    btConfirmar: TButton;
    btCancelar: TButton;
    ImageList: TImageList;
    lbID_FORNECEDOR: TLabel;
    edID_FORNECEDOR: TButtonedEdit;
    lbID_TAB_PRECO: TLabel;
    edID_TAB_PRECO: TButtonedEdit;
    edFORNECEDOR: TEdit;
    edTAB_PRECO: TEdit;
    FDMem_RegistroID_FORNECEDOR: TIntegerField;
    FDMem_RegistroID_TAB_PRECO: TIntegerField;
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edDOCUMENTOExit(Sender: TObject);
    procedure edID_FORNECEDORRightButtonClick(Sender: TObject);
    procedure edID_TAB_PRECORightButtonClick(Sender: TObject);
  private
    FfrmCon_Fornecedor :TfrmCon_Fornecedor;
    FfrmCon_TabPreco :TfrmCon_TabPreco;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;
    FStatus_Tabela: Integer;

    procedure Gravando_Registro;
  public
    property Status_Tabela :Integer read FStatus_Tabela write FStatus_Tabela;
      //0-Inserir
      //1-Editar
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmCad_Cliente_Add:TfrmCad_Cliente_Add;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_Cliente_Add:TfrmCad_Cliente_Add;
begin
  result:= TfrmCad_Cliente_Add(TfrmCad_Cliente_Add.GetInstance);
end;

procedure TfrmCad_Cliente_Add.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCad_Cliente_Add.btConfirmarClick(Sender: TObject);
var
  FResp :IResponse;
  FBody :TJSONArray;
begin
  try
    try

      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      Gravando_Registro;

      if FDMem_Registro.IsEmpty then
        raise Exception.Create('Não há registro a ser salvo');


      FBody := FDMem_Registro.ToJSONArray;
      case FStatus_Tabela of
        0:begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('cliente')
                   .TokenBearer(ControleHoras.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('cliente')
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

procedure TfrmCad_Cliente_Add.edDOCUMENTOExit(Sender: TObject);
var
  FDocumento :String;
begin
  FDocumento := '';
  FDocumento := edDOCUMENTO.Text;

  case cbPESSOA.ItemIndex of
    0:edDOCUMENTO.Text := Copy(FDocumento,1,3) + '.' + Copy(FDocumento,4,3)  + '.' + Copy(FDocumento,7,3) + '-' + Copy(FDocumento,10,2);
    1:edDOCUMENTO.Text := Copy(FDocumento,1,2) + '.' + Copy(FDocumento,3,3)  + '.' + Copy(FDocumento,6,3) + '/' + Copy(FDocumento,9,4) + '-' +  Copy(FDocumento,13,2);
  end;
end;

procedure TfrmCad_Cliente_Add.edID_FORNECEDORRightButtonClick(Sender: TObject);
begin
  ShowPopupModal('PopupConFornecedor');
  if ControleHoras.Fornecedor_ID > 0 then
  begin
    edID_FORNECEDOR.Text := IntToStr(ControleHoras.Fornecedor_ID);
    edFORNECEDOR.Text := ControleHoras.Fornecedor_Nome;
  end;

end;

procedure TfrmCad_Cliente_Add.edID_TAB_PRECORightButtonClick(Sender: TObject);
begin
  ShowPopupModal('PopupConTabPreco');
  if ControleHoras.Tab_Preco_ID > 0 then
  begin
    edID_TAB_PRECO.Text := IntToStr(ControleHoras.Tab_Preco_ID);
    edTAB_PRECO.Text := ControleHoras.Tab_Preco_Nome;
  end;

end;

procedure TfrmCad_Cliente_Add.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Cliente';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';


  //Configurações do Form Popup
  FfrmCon_Fornecedor := TfrmCon_Fornecedor.Create(Self);
  D2Bridge.AddNested(FfrmCon_Fornecedor);

  FfrmCon_TabPreco := TfrmCon_TabPreco.Create(Self);
  D2Bridge.AddNested(FfrmCon_TabPreco);

  with D2Bridge.Items.add do
  begin
    with card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbID.Caption,CSSClass.Col.colsize2).AddVCLObj(edID);
        FormGroup(lbNOME.Caption,CSSClass.Col.colsize10).AddVCLObj(edNOME);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbPESSOA.Caption,CSSClass.Col.colsize2).AddVCLObj(cbPESSOA);
        FormGroup(lbDOCUMENTO.Caption,CSSClass.Col.colsize5).AddVCLObj(edDOCUMENTO);
        FormGroup(lbINSC_EST.Caption,CSSClass.Col.colsize5).AddVCLObj(edINSC_EST);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbCEP.Caption,CSSClass.Col.colsize2).AddVCLObj(edCEP);
        FormGroup(lbENDERECO.Caption,CSSClass.Col.colsize10).AddVCLObj(edENDERECO);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbNUMERO.Caption,CSSClass.Col.colsize2).AddVCLObj(edNUMERO);
        FormGroup(lbCOMPLEMENTO.Caption,CSSClass.Col.colsize10).AddVCLObj(edCOMPLEMENTO);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbBAIRRO.Caption,CSSClass.Col.colsize5).AddVCLObj(edBAIRRO);
        FormGroup(lbCIDADE.Caption,CSSClass.Col.colsize5).AddVCLObj(edCIDADE);
        FormGroup(lbUF.Caption,CSSClass.Col.colsize2).AddVCLObj(cbUF);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbTELEFONE.Caption,CSSClass.Col.colsize3).AddVCLObj(edTELEFONE);
        FormGroup(lbCELULAR.Caption,CSSClass.Col.colsize3).AddVCLObj(edCELULAR);
        FormGroup(lbEMAIL.Caption,CSSClass.Col.colsize6).AddVCLObj(edEMAIL);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbID_FORNECEDOR.Caption,CSSClass.Col.colsize2).AddVCLObj(edID_FORNECEDOR);
        FormGroup('',CSSClass.Col.colsize10).AddVCLObj(edFORNECEDOR);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbID_TAB_PRECO.Caption,CSSClass.Col.colsize2).AddVCLObj(edID_TAB_PRECO);
        FormGroup('',CSSClass.Col.colsize10).AddVCLObj(edTAB_PRECO);
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize3);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize3);
    end;

    //Popup
    with Popup('PopupConFornecedor','Cadastro de Fornecedor').Items.Add do
      Nested(FfrmCon_Fornecedor);
    with Popup('PopupConTabPreco','Cadastro de Tabela de Preço').Items.Add do
      Nested(FfrmCon_TabPreco);
  end;

end;

procedure TfrmCad_Cliente_Add.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //
end;

procedure TfrmCad_Cliente_Add.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
end;

procedure TfrmCad_Cliente_Add.Gravando_Registro;
begin
  try
    FDMem_Registro.Active := False;
    FDMem_Registro.Active := True;
    FDMem_Registro.Insert;
    if FStatus_Tabela = 1 then
      FDMem_RegistroID.AsInteger := StrToIntDef(edID.Text,1);
      FDMem_RegistroNOME.Text := edNome.Text;
      FDMem_RegistroPESSOA.AsInteger := cbPESSOA.ItemIndex;
      FDMem_RegistroDOCUMENTO.AsString := edDOCUMENTO.Text;
      FDMem_RegistroINSC_EST.AsString := edINSC_EST.Text;
      FDMem_RegistroCEP.AsString := edCEP.Text;
      FDMem_RegistroENDERECO.AsString := edENDERECO.Text;
      FDMem_RegistroCOMPLEMENTO.AsString := edCOMPLEMENTO.Text;
      FDMem_RegistroNUMERO.AsString := edNUMERO.Text;
      FDMem_RegistroBAIRRO.AsString := edBAIRRO.Text;
      FDMem_RegistroCIDADE.AsString := edCIDADE.Text;
      FDMem_RegistroUF.AsString := cbUF.Text;
      FDMem_RegistroTELEFONE.AsString := edTELEFONE.Text;
      FDMem_RegistroCELULAR.AsString := edCELULAR.Text;
      FDMem_RegistroEMAIL.AsString := edEMAIL.Text;
      FDMem_RegistroDT_CADASTRO.AsDateTime := Date;
      FDMem_RegistroHR_CADASTRO.AsDateTime := Time;
      FDMem_RegistroID_FORNECEDOR.AsInteger := StrToIntDef(edID_FORNECEDOR.Text,1);
      FDMem_RegistroID_TAB_PRECO.AsInteger := StrToIntDef(edID_TAB_PRECO.Text,1);
    FDMem_Registro.Post;

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;

end;

procedure TfrmCad_Cliente_Add.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

 if PrismControl.VCLComponent = edCELULAR then
  PrismControl.AsEdit.TextMask:= '''mask'' : ''(99)99999-9999''';
 if PrismControl.VCLComponent = edTELEFONE then
  PrismControl.AsEdit.TextMask:= '''mask'' : ''(99)9999-9999''';
 if PrismControl.VCLComponent = edCEP then
   PrismControl.AsEdit.TextMask := TPrismTextMask.BrazilCep;
 if PrismControl.VCLComponent = edEMAIL then
   PrismControl.AsEdit.TextMask:= TPrismTextMask.Email;

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

procedure TfrmCad_Cliente_Add.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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