unit uCad.FormaPagto.Add;

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
  TfrmCad_FormaPagto_Add = class(TD2BridgeForm)
    lbID: TLabel;
    lbDESCRICAO: TLabel;
    lbCLASSIFICACAO: TLabel;
    edID: TEdit;
    edDESCRICAO: TEdit;
    btConfirmar: TButton;
    btCancelar: TButton;
    FDMem_Registro: TFDMemTable;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroCLASSIFICACAO: TStringField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    pnClassificacao: TPanel;
    rbDINHEIRO: TRadioButton;
    rbCREDIARIO: TRadioButton;
    rbBOLETO: TRadioButton;
    rbPIX: TRadioButton;
    rbCARTAO_DEBITO: TRadioButton;
    rbCARTAO_CREDITO: TRadioButton;
    rbCHEQUE_A_VISTA: TRadioButton;
    rbCHEQUE_A_PRAZO: TRadioButton;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

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

function frmCad_FormaPagto_Add:TfrmCad_FormaPagto_Add;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_FormaPagto_Add:TfrmCad_FormaPagto_Add;
begin
  result:= TfrmCad_FormaPagto_Add(TfrmCad_FormaPagto_Add.GetInstance);
end;

procedure TfrmCad_FormaPagto_Add.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCad_FormaPagto_Add.btConfirmarClick(Sender: TObject);
var
  FResp :IResponse;
  FBody :TJSONArray;
begin
  //Salvando o Fornecedor...
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
                   .Resource('formaPagto')
                   .TokenBearer(ControleHoras.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('formaPagto')
                   .TokenBearer(ControleHoras.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('formaPagto/json')
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

procedure TfrmCad_FormaPagto_Add.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Formas de Pagamento';

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
        FormGroup(lbDESCRICAO.Caption,CSSClass.Col.colsize7).AddVCLObj(edDESCRICAO);
      end;
    end;
    with card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        with PanelGroup('Seleciona uma Classificação').Items.Add do
        begin
          VCLObj(rbDINHEIRO);
          VCLObj(rbCREDIARIO);
          VCLObj(rbBOLETO);
          VCLObj(rbPIX);
          VCLObj(rbCARTAO_DEBITO);
          VCLObj(rbCARTAO_CREDITO);
          VCLObj(rbCHEQUE_A_VISTA);
          VCLObj(rbCHEQUE_A_PRAZO);
        end;
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize3);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize3);
    end;
  end;

end;

procedure TfrmCad_FormaPagto_Add.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmCad_FormaPagto_Add.Gravando_Registro;
begin
  try
    FDMem_Registro.Active := False;
    FDMem_Registro.Active := True;
    FDMem_Registro.Insert;
    if FStatus_Tabela = 1 then
      FDMem_RegistroID.AsInteger := StrToIntDef(edID.Text,1);
      FDMem_RegistroDESCRICAO.AsString := edDESCRICAO.Text;
      if rbDINHEIRO.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'DINHEIRO'
      else if rbCREDIARIO.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'CREDIARIO'
      else if rbBOLETO.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'BOLETO'
      else if rbPIX.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'PIX'
      else if rbCARTAO_DEBITO.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'CARTAO DEBITO'
      else if rbCARTAO_CREDITO.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'CARTAO CREDITO'
      else if rbCHEQUE_A_VISTA.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'CHEQUE A VISTA'
      else if rbCHEQUE_A_PRAZO.Checked then
        FDMem_RegistroCLASSIFICACAO.Text := 'CHEQUE A PRAZO';
      FDMem_RegistroDT_CADASTRO.AsDateTime := Date;
      FDMem_RegistroHR_CADASTRO.AsDateTime := Time;
    FDMem_Registro.Post;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmCad_FormaPagto_Add.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_FormaPagto_Add.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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