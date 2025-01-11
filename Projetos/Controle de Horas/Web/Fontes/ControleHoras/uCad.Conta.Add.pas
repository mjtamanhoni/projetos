unit uCad.Conta.Add;

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
  TfrmCad_Conta_Add = class(TD2BridgeForm)
    lbID: TLabel;
    lbDESCRICAO: TLabel;
    lbTIPO: TLabel;
    edID: TEdit;
    edDESCRICAO: TEdit;
    cbTIPO: TComboBox;
    btConfirmar: TButton;
    btCancelar: TButton;
    FDMem_Registro: TFDMemTable;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroSTATUS: TIntegerField;
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroTIPO: TIntegerField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroSTATUS_DESC: TStringField;
    FDMem_RegistroTIPO_DESC: TStringField;
    cbSTATUS: TComboBox;
    lbSTATUS: TLabel;
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
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmCad_Conta_Add:TfrmCad_Conta_Add;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_Conta_Add:TfrmCad_Conta_Add;
begin
  result:= TfrmCad_Conta_Add(TfrmCad_Conta_Add.GetInstance);
end;

procedure TfrmCad_Conta_Add.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCad_Conta_Add.btConfirmarClick(Sender: TObject);
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
                   .Resource('conta')
                   .TokenBearer(ControleHoras.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('conta')
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

procedure TfrmCad_Conta_Add.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Contas';

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
        FormGroup(lbDESCRICAO.Caption,CSSClass.Col.colsize10).AddVCLObj(edDESCRICAO);
      end;
      with Row.Items.Add do
      begin
        FormGroup(lbSTATUS.Caption,CSSClass.Col.colsize2).AddVCLObj(cbSTATUS);
        FormGroup(lbTIPO.Caption,CSSClass.Col.colsize2).AddVCLObj(cbTIPO);
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize3);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize3);
    end;
  end;

end;

procedure TfrmCad_Conta_Add.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmCad_Conta_Add.Gravando_Registro;
begin
  try
    FDMem_Registro.Active := False;
    FDMem_Registro.Active := True;
    FDMem_Registro.Insert;
    if FStatus_Tabela = 1 then
      FDMem_RegistroID.AsInteger := StrToIntDef(edID.Text,1);
      FDMem_RegistroDESCRICAO.AsString := edDESCRICAO.Text;
      FDMem_RegistroTIPO.AsInteger := cbTIPO.ItemIndex;
      FDMem_RegistroTIPO_DESC.AsString := cbTIPO.Text;
      FDMem_RegistroSTATUS.AsInteger := cbSTATUS.ItemIndex;
      FDMem_RegistroSTATUS_DESC.AsString := cbSTATUS.Text;
      FDMem_RegistroDT_CADASTRO.AsDateTime := Date;
      FDMem_RegistroHR_CADASTRO.AsDateTime := Time;
    FDMem_Registro.Post;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmCad_Conta_Add.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_Conta_Add.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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