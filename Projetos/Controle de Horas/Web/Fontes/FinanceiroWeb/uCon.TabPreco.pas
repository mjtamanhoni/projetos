unit uCon.TabPreco;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.IOUtils,

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  uPrincipal, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCon_TabPreco = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    pnFiltros: TPanel;
    lbTipo: TLabel;
    lbPesquisar: TLabel;
    cbTipo: TComboBox;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    pnFooter: TPanel;
    btConfirmar: TButton;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroTIPO: TStringField;
    FDMem_RegistroVALOR: TFloatField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroTIPO_DESC: TStringField;
    procedure btPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
  private

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    procedure Pesquisar;
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmCon_TabPreco:TfrmCon_TabPreco;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmCon_TabPreco:TfrmCon_TabPreco;
begin
  result:= TfrmCon_TabPreco(TfrmCon_TabPreco.GetInstance);
end;

procedure TfrmCon_TabPreco.btConfirmarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCon_TabPreco.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCon_TabPreco.ExportD2Bridge;
begin
  inherited;

  Title:= 'Consulta de Tabela de Preços';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin
    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbTipo.Caption,CSSClass.Col.colsize3).AddVCLObj(cbTipo);
        FormGroup(lbPesquisar.Caption,CSSClass.Col.colsize6).AddVCLObj(edPesquisar);

        FormGroup('',CSSClass.Col.colsize3).AddVCLObj(btPesquisar,CSSClass.Button.search);
      end;
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        with Row(CSSClass.DivHtml.Align_Center).Items.Add do
        begin
          VCLObj(btConfirmar, CSSClass.Button.close + CSSClass.Col.colsize3);
        end;
      end;
    end;
  end;

end;

procedure TfrmCon_TabPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinanceiroWeb.Tab_Preco_ID := 0;
  FinanceiroWeb.Tab_Preco_Nome := '';
  if not FDMem_Registro.IsEmpty then
  begin
    FinanceiroWeb.Tab_Preco_ID := FDMem_RegistroID.AsInteger;
    FinanceiroWeb.Tab_Preco_Nome := FDMem_RegistroDESCRICAO.AsString;
  end;

end;

procedure TfrmCon_TabPreco.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmCon_TabPreco.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCon_TabPreco.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage := 12;
   //PrismControl.AsDBGrid.MaxRecords:= 2000;
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

procedure TfrmCon_TabPreco.Pesquisar;
var
  FResp :IResponse;
  FBody :TJSONArray;
  FTipoPesquisa:String;
  x:Integer;
begin
  try
    try

    FDMem_Registro.Active := False;
    FDMem_Registro.Active := True;
    FDMem_Registro.DisableControls;

    FTipoPesquisa := '';
    case cbTipo.ItemIndex of
      0:FTipoPesquisa := 'id';
      1:FTipoPesquisa := 'descricao';
    end;


    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(FinanceiroWeb.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    if Trim(FTipoPesquisa) <> '' then
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .AddParam(FTipoPesquisa,edPesquisar.Text)
               .Resource('tabelaPreco')
               .Accept('application/json')
               .Get;
    end
    else
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .Resource('tabelaPreco')
               .Accept('application/json')
               .Get;
    end;

    if FResp.StatusCode = 200 then
    begin
      if FResp.Content = '' then
        raise Exception.Create('Registros não localizados');

      FBody := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(FResp.Content),0) as TJSONArray;

      for x := 0 to FBody.Size - 1 do
      begin
        FDMem_Registro.Insert;
          FDMem_RegistroID.AsInteger := FBody.Get(x).GetValue<Integer>('id',0);
          FDMem_RegistroDESCRICAO.AsString := FBody.Get(x).GetValue<String>('descricao','');
          FDMem_RegistroTIPO.AsInteger := FBody.Get(x).GetValue<Integer>('tipo',0);
          FDMem_RegistroVALOR.AsFloat := FBody.Get(x).GetValue<Double>('valor',0);
          FDMem_RegistroTIPO_DESC.AsString := FBody.Get(x).GetValue<String>('tipoDesc','');
          FDMem_RegistroDT_CADASTRO.AsDateTime := StrToDateDef(FBody.Get(x).GetValue<String>('dtCadastro',''),Date);
          FDMem_RegistroHR_CADASTRO.AsDateTime := StrToTimeDef(FBody.Get(x).GetValue<String>('hrCadastro',''),Time);
        FDMem_Registro.Post;
      end;

    end;

    except on E: Exception do
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    end;
  finally
    FDMem_Registro.EnableControls;
  end;
end;

procedure TfrmCon_TabPreco.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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