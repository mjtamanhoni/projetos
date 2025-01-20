unit uCon.Fornecedor;

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
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uCad.Fornecedor.Add;

type
  TfrmCon_Fornecedor = class(TD2BridgeForm)
    pnFiltros: TPanel;
    lbTipo: TLabel;
    cbTipo: TComboBox;
    lbPesquisar: TLabel;
    edPesquisar: TEdit;
    btPesquisar: TButton;
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
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    pnFooter: TPanel;
    btConfirmar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
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

function frmCon_Fornecedor:TfrmCon_Fornecedor;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCon_Fornecedor:TfrmCon_Fornecedor;
begin
  result:= TfrmCon_Fornecedor(TfrmCon_Fornecedor.GetInstance);
end;

procedure TfrmCon_Fornecedor.btConfirmarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCon_Fornecedor.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCon_Fornecedor.ExportD2Bridge;
begin
  inherited;

  Title:= 'Consulta de Fornecedores';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

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

procedure TfrmCon_Fornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ControleHoras.Fornecedor_ID := 0;
  ControleHoras.Fornecedor_Nome := '';
  if not FDMem_Registro.IsEmpty then
  begin
    ControleHoras.Fornecedor_ID := FDMem_RegistroID.AsInteger;
    ControleHoras.Fornecedor_Nome := FDMem_RegistroNOME.AsString;
  end;
end;

procedure TfrmCon_Fornecedor.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
end;

procedure TfrmCon_Fornecedor.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCon_Fornecedor.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCon_Fornecedor.Pesquisar;
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
      1:FTipoPesquisa := 'nome';
    end;


    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    if Trim(FTipoPesquisa) <> '' then
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .AddParam(FTipoPesquisa,edPesquisar.Text)
               .Resource('fornecedor')
               .Accept('application/json')
               .Get;
    end
    else
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .Resource('fornecedor')
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
          FDMem_RegistroNOME.AsString := FBody.Get(x).GetValue<String>('nome','');
          FDMem_RegistroPESSOA.AsInteger := FBody.Get(x).GetValue<Integer>('pessoa',0);
          FDMem_RegistroDOCUMENTO.AsString := FBody.Get(x).GetValue<String>('documento','');
          FDMem_RegistroINSC_EST.AsString := FBody.Get(x).GetValue<String>('inscEst','');
          FDMem_RegistroCEP.AsString := FBody.Get(x).GetValue<String>('cep','');
          FDMem_RegistroENDERECO.AsString := FBody.Get(x).GetValue<String>('endereco','');
          FDMem_RegistroCOMPLEMENTO.AsString := FBody.Get(x).GetValue<String>('complemento','');
          FDMem_RegistroNUMERO.AsString := FBody.Get(x).GetValue<String>('numero','');
          FDMem_RegistroBAIRRO.AsString := FBody.Get(x).GetValue<String>('bairro','');
          FDMem_RegistroCIDADE.AsString := FBody.Get(x).GetValue<String>('cidade','');
          FDMem_RegistroUF.AsString := FBody.Get(x).GetValue<String>('uf','');
          FDMem_RegistroTELEFONE.AsString := FBody.Get(x).GetValue<String>('telefone','');
          FDMem_RegistroCELULAR.AsString := FBody.Get(x).GetValue<String>('celular','');
          FDMem_RegistroEMAIL.AsString := FBody.Get(x).GetValue<String>('email','');
          FDMem_RegistroDT_CADASTRO.AsDateTime := StrToDateDef(FBody.Get(x).GetValue<String>('dtCadastro',''),Date);
          FDMem_RegistroHR_CADASTRO.AsDateTime := StrToTimeDef(FBody.Get(x).GetValue<String>('hrCadastro',''),Time);
          FDMem_RegistroPESSOA_DESC.AsString := FBody.Get(x).GetValue<String>('pessoaDesc','');
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

procedure TfrmCon_Fornecedor.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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