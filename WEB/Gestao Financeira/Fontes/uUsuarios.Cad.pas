unit uUsuarios.Cad;

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
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmUsuarios_Cad = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registronome: TStringField;
    FDMem_Registrologin: TStringField;
    FDMem_Registrosenha: TStringField;
    FDMem_Registropin: TStringField;
    FDMem_Registroemail: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrosenhaHash: TStringField;
    FDMem_Registrotipo: TIntegerField;
    FDMem_RegistrotipoDesc: TStringField;
    FDMem_RegistrostatusDesc: TStringField;
    btCancelar: TButton;
    btConfirmar: TButton;
    pnRow001: TPanel;
    lbid: TLabel;
    lbnome: TLabel;
    lbStatus: TLabel;
    edid: TEdit;
    ednome: TEdit;
    cbstatus: TComboBox;
    pnRow002: TPanel;
    lbtipo: TLabel;
    cbtipo: TComboBox;
    lblogin: TLabel;
    edlogin: TEdit;
    edsenha: TEdit;
    lbsenha: TLabel;
    edpin: TEdit;
    lbpin: TLabel;
    FDMem_Registrostatus: TIntegerField;
    pnRow003: TPanel;
    edemail: TEdit;
    lbemail: TLabel;
    pcPrincipal: TPageControl;
    tsPermissoes: TTabSheet;
    tsEmpresas: TTabSheet;
    DBGrid_Permissoes: TDBGrid;
    pnPermissoes: TPanel;
    pnEmpresa: TPanel;
    DBGrid_Empresa: TDBGrid;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure edidKeyPress(Sender: TObject; var Key: Char);
    procedure cbstatusKeyPress(Sender: TObject; var Key: Char);
    procedure ednomeKeyPress(Sender: TObject; var Key: Char);
    procedure cbtipoKeyPress(Sender: TObject; var Key: Char);
    procedure edloginKeyPress(Sender: TObject; var Key: Char);
    procedure edsenhaKeyPress(Sender: TObject; var Key: Char);
    procedure edpinKeyPress(Sender: TObject; var Key: Char);
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

function frmUsuarios_Cad:TfrmUsuarios_Cad;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmUsuarios_Cad:TfrmUsuarios_Cad;
begin
  result:= TfrmUsuarios_Cad(TfrmUsuarios_Cad.GetInstance);
end;

procedure TfrmUsuarios_Cad.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarios_Cad.btConfirmarClick(Sender: TObject);
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

        if ((Gestao_Financeira.Usuario_Status_Tab = 'Edit') and (Trim(edid.Text) = ''))  then
          raise Exception.Create('Id do Usuário é obrigatório.');

        if Trim(ednome.Text) = '' then
          raise Exception.Create('Nome do Usuário é obrigatório.');

        if ((Trim(edlogin.Text) = '') and (Gestao_Financeira.Usuario_Status_Tab = 'Insert')) then
          raise Exception.Create('Login do Usuário é obrigatório.');

        if ((Trim((edsenha).Text) = '') and (Gestao_Financeira.Usuario_Status_Tab = 'Insert')) then
          raise Exception.Create('Senha do usuário é obrigatório.');

        if ((Trim(edpin.Text) = '') and (Gestao_Financeira.Usuario_Status_Tab = 'Insert')) then
          raise Exception.Create('PIN do usuário é obrigatório.');

        FDMem_Registro.Insert;
          if Gestao_Financeira.FormProjeto_Status_Tab = 'Edit' then
            FDMem_Registro.FieldByName('id').AsInteger := StrToIntDef(edid.Text,0);

          FDMem_Registro.FieldByName('status').AsInteger := cbstatus.ItemIndex;
          FDMem_Registro.FieldByName('tipo').AsInteger := cbtipo.ItemIndex;
          FDMem_Registro.FieldByName('nome').AsString := ednome.Text;
          FDMem_Registro.FieldByName('login').AsString := edlogin.Text;
          if Trim(edsenha.Text) <> '' then
            FDMem_Registro.FieldByName('senha').AsString := TFuncoes.CriptografarSenha(edsenha.Text)
          else
            FDMem_Registro.FieldByName('senha').AsString := '';
          if Trim(edpin.Text) <> '' then
            FDMem_Registro.FieldByName('pin').AsString := TFuncoes.CriptografarSenha(edpin.Text)
          else
            FDMem_Registro.FieldByName('pin').AsString := '';
          FDMem_Registro.FieldByName('email').AsString := edemail.Text;


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
                   .Resource('usuario')
                   .TokenBearer(Gestao_Financeira.Usuario_Token)
                   .AddBody(FBody)
                   .Accept('application/json')
                   .Post;
        end
        else
        begin
          FResp := TRequest.New.BaseURL(FHost)
                   .Resource('usuario')
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

procedure TfrmUsuarios_Cad.cbstatusKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    ednome.SetFocus;

end;

procedure TfrmUsuarios_Cad.cbtipoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edlogin.SetFocus;

end;

procedure TfrmUsuarios_Cad.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmUsuarios_Cad.Configura_Form;
begin
  edid.Clear;
  cbstatus.ItemIndex := -1;
  ednome.Clear;
  cbtipo.ItemIndex := -1;
  edlogin.clear;
  edsenha.Clear;
  edpin.Clear;
  edemail.Clear;
end;

procedure TfrmUsuarios_Cad.edidKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cbstatus.SetFocus;

end;

procedure TfrmUsuarios_Cad.edloginKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edsenha.SetFocus;

end;

procedure TfrmUsuarios_Cad.ednomeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    cbtipo.SetFocus;

end;

procedure TfrmUsuarios_Cad.edpinKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edemail.SetFocus;

end;

procedure TfrmUsuarios_Cad.edsenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edpin.SetFocus;

end;

procedure TfrmUsuarios_Cad.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Usuário';

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
          FormGroup(lbStatus.Caption,CSSClass.Col.colsize2).AddVCLObj(cbstatus);
          FormGroup(lbnome.Caption,CSSClass.Col.col).AddVCLObj(ednome);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbtipo.Caption,CSSClass.col.colsize3).Items.Add.VCLObj(cbtipo);
          FormGroup(lblogin.Caption,CSSClass.col.colsize4).Items.Add.VCLObj(edlogin);
          FormGroup(lbsenha.Caption,CSSClass.col.colsize3).Items.Add.VCLObj(edsenha);
          FormGroup(lbpin.Caption,CSSClass.col.colsize2).Items.Add.VCLObj(edpin);
        end;
        with Row.Items.Add do
        begin
          FormGroup(lbemail.Caption,CSSClass.col.col).Items.Add.VCLObj(edemail);
        end;
      end;
    end;

    with Row.Items.Add do
    begin
      with Tabs('TabControl1') do
      begin
      //Disable Tabs
      //ShowTabs:= false;

        with AddTab(pcPrincipal.Pages[0].Caption).Items.Add do
        begin
          with Row.Items.Add do
            VCLObj(DBGrid_Permissoes);
        end;

        with AddTab(pcPrincipal.Pages[1].Caption).Items.Add do
        begin
          with Row.Items.Add do
            VCLObj(DBGrid_Empresa);
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

procedure TfrmUsuarios_Cad.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmUsuarios_Cad.FormShow(Sender: TObject);
begin
  Configura_Form;
end;

procedure TfrmUsuarios_Cad.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmUsuarios_Cad.PopupClosed(const AName: String);
begin
  inherited;

end;

procedure TfrmUsuarios_Cad.PopupOpened(AName: String);
begin
  inherited;

end;

procedure TfrmUsuarios_Cad.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmUsuarios_Cad.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.