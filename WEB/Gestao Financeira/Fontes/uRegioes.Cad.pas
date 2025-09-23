unit uRegioes.Cad;

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
  TfrmRegioes_Cad = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registroibge: TIntegerField;
    FDMem_Registronome: TStringField;
    FDMem_Registrosigla: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    pnRow001: TPanel;
    lbid: TLabel;
    lbnome: TLabel;
    edid: TEdit;
    ednome: TEdit;
    lbibge: TLabel;
    edibge: TEdit;
    edsigla: TEdit;
    lbsigla: TLabel;
    btConfirmar: TButton;
    btCancelar: TButton;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure edidKeyPress(Sender: TObject; var Key: Char);
    procedure edibgeKeyPress(Sender: TObject; var Key: Char);
    procedure ednomeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

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

function frmRegioes_Cad:TfrmRegioes_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmRegioes_Cad:TfrmRegioes_Cad;
begin
  result:= TfrmRegioes_Cad(TfrmRegioes_Cad.GetInstance);
end;

procedure TfrmRegioes_Cad.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRegioes_Cad.btConfirmarClick(Sender: TObject);
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

        if ((Gestao_Financeira.Regiao_Status_Tab = 'Edit') and (Trim(edid.Text) = ''))  then
          raise Exception.Create('Id da Região é obrigatória.');

        if Trim(ednome.Text) = '' then
          raise Exception.Create('Nome da Região é obrigatória.');

        if (Trim(edibge.Text) = '') then
          raise Exception.Create('IBGE da Região obrigatória.');

        FDMem_Registro.Insert;
          if Gestao_Financeira.Regiao_Status_Tab= 'Edit' then
            FDMem_Registro.FieldByName('id').AsInteger := StrToIntDef(edid.Text,0);

          FDMem_Registro.FieldByName('nome').AsString := ednome.Text;
          FDMem_Registro.FieldByName('ibge').AsString := edibge.Text;
          FDMem_Registro.FieldByName('sigla').AsString := edsigla.Text;

        FDMem_Registro.Post;
        FDMem_Registro.ToJSONArray;
      {$EndRegion 'Gravando/Gerando JSon dos dados'}

      {$Region 'Enviando dados para o Servidor'}
        FBody := FDMem_Registro.ToJSONArray;
        if FBody.Size = 0 then
          raise Exception.Create('Não há dados para serem salvos.');

        if Gestao_Financeira.Usuario_Status_Tab = 'Insert' then
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('regioes')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end
        else
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('regioes')
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

procedure TfrmRegioes_Cad.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmRegioes_Cad.Configura_Form;
begin
  edid.Clear;
  ednome.Clear;
  edibge.clear;
  edsigla.Clear;
end;

procedure TfrmRegioes_Cad.edibgeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    ednome.SetFocus;

end;

procedure TfrmRegioes_Cad.edidKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edibge.SetFocus;

end;

procedure TfrmRegioes_Cad.ednomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edsigla.SetFocus;

end;

procedure TfrmRegioes_Cad.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Regiões Brasileiras';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

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
          FormGroup(lbnome.Caption,CSSClass.Col.colsize6).AddVCLObj(ednome);
          FormGroup(lbsigla.Caption,CSSClass.Col.colsize2).AddVCLObj(edsigla);
        end;
      end;
    end;

    with Row(CSSClass.DivHtml.Align_Center).Items.Add do
    begin
      VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize2);
      VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize2);
    end;
  end;

end;

procedure TfrmRegioes_Cad.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmRegioes_Cad.FormShow(Sender: TObject);
begin
  Configura_Form;
end;

procedure TfrmRegioes_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmRegioes_Cad.PopupClosed(const AName: String);
begin
  inherited;

end;

procedure TfrmRegioes_Cad.PopupOpened(AName: String);
begin
  inherited;

end;

procedure TfrmRegioes_Cad.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmRegioes_Cad.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.