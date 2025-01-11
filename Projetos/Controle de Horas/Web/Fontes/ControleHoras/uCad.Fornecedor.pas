unit uCad.Fornecedor;

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
  TfrmCad_Fornecedor = class(TfrmPrincipal)
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
    pnHeader: TPanel;
    lbTipo: TLabel;
    lbPesquisar: TLabel;
    cbTipo: TComboBox;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    pnFooter: TPanel;
    btExcluir: TButton;
    btEditar: TButton;
    btNovo: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    FfrmCad_Fornecedor_Add :TfrmCad_Fornecedor_Add;

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

function frmCad_Fornecedor:TfrmCad_Fornecedor;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_Fornecedor:TfrmCad_Fornecedor;
begin
  result:= TfrmCad_Fornecedor(TfrmCad_Fornecedor.GetInstance);
end;

procedure TfrmCad_Fornecedor.btEditarClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_Fornecedor_Add.edID.Text := FDMem_RegistroID.AsString;
    FfrmCad_Fornecedor_Add.edNome.Text := FDMem_RegistroNOME.AsString;
    FfrmCad_Fornecedor_Add.cbPESSOA.ItemIndex := FDMem_RegistroPESSOA.AsInteger;
    FfrmCad_Fornecedor_Add.edDOCUMENTO.Text := FDMem_RegistroDOCUMENTO.AsString;
    FfrmCad_Fornecedor_Add.edINSC_EST.Text := FDMem_RegistroINSC_EST.AsString;
    FfrmCad_Fornecedor_Add.edCEP.Text := FDMem_RegistroCEP.AsString;
    FfrmCad_Fornecedor_Add.edENDERECO.Text := FDMem_RegistroENDERECO.AsString;
    FfrmCad_Fornecedor_Add.edCOMPLEMENTO.Text := FDMem_RegistroCOMPLEMENTO.AsString;
    FfrmCad_Fornecedor_Add.edNUMERO.Text := FDMem_RegistroNUMERO.AsString;
    FfrmCad_Fornecedor_Add.edBAIRRO.Text := FDMem_RegistroBAIRRO.AsString;
    FfrmCad_Fornecedor_Add.edCIDADE.Text := FDMem_RegistroCIDADE.AsString;
    FfrmCad_Fornecedor_Add.cbUF.Text := FDMem_RegistroUF.AsString;
    FfrmCad_Fornecedor_Add.edTELEFONE.Text := FDMem_RegistroTELEFONE.AsString;
    FfrmCad_Fornecedor_Add.edCELULAR.Text := FDMem_RegistroCELULAR.AsString;
    FfrmCad_Fornecedor_Add.edEMAIL.Text := FDMem_RegistroEMAIL.AsString;
    FfrmCad_Fornecedor_Add.Status_Tabela := 1;


    ShowPopupModal('PopupCadFornecedorAdd');
  end
  else
  begin
    FfrmCad_Fornecedor_Add := TfrmCad_Fornecedor_Add.Create(Self);
    FfrmCad_Fornecedor_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_Fornecedor.btExcluirClick(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir a Fornecedor selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(ControleHoras.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('fornecedor')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmCad_Fornecedor.btNovoClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_Fornecedor_Add.FDMem_Registro.Active := False;
    FfrmCad_Fornecedor_Add.FDMem_Registro.Active := True;

    FfrmCad_Fornecedor_Add.edID.Text := '';
    FfrmCad_Fornecedor_Add.edNome.Text := '';
    FfrmCad_Fornecedor_Add.cbPESSOA.Text := '';
    FfrmCad_Fornecedor_Add.cbPESSOA.ItemIndex := -1;
    FfrmCad_Fornecedor_Add.edDOCUMENTO.Text := '';
    FfrmCad_Fornecedor_Add.edINSC_EST.Text := '';
    FfrmCad_Fornecedor_Add.edCEP.Text := '';
    FfrmCad_Fornecedor_Add.edENDERECO.Text := '';
    FfrmCad_Fornecedor_Add.edCOMPLEMENTO.Text := '';
    FfrmCad_Fornecedor_Add.edNUMERO.Text := '';
    FfrmCad_Fornecedor_Add.edBAIRRO.Text := '';
    FfrmCad_Fornecedor_Add.edCIDADE.Text := '';
    FfrmCad_Fornecedor_Add.cbUF.Text := '';
    FfrmCad_Fornecedor_Add.cbUF.ItemIndex := -1;
    FfrmCad_Fornecedor_Add.edTELEFONE.Text := '';
    FfrmCad_Fornecedor_Add.edCELULAR.Text := '';
    FfrmCad_Fornecedor_Add.edEMAIL.Text := '';
    FfrmCad_Fornecedor_Add.Status_Tabela := 0;

    ShowPopupModal('PopupCadFornecedorAdd')
  end
  else
  begin
    FfrmCad_Fornecedor_Add := TfrmCad_Fornecedor_Add.Create(Self);
    FfrmCad_Fornecedor_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_Fornecedor.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_Fornecedor.ExportD2Bridge;
begin
  inherited;

  Title:= 'Fornecedor';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmCad_Fornecedor_Add := TfrmCad_Fornecedor_Add.Create(Self);
  D2Bridge.AddNested(FfrmCad_Fornecedor_Add);

  with D2Bridge.Items.add do
  begin
    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbTipo.Caption,CSSClass.Col.colsize1).AddVCLObj(cbTipo);
        FormGroup(lbPesquisar.Caption,CSSClass.Col.colsize6).AddVCLObj(edPesquisar);

        FormGroup('',CSSClass.Col.colsize2).AddVCLObj(btPesquisar,CSSClass.Button.search);
      end;
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    with Card.Items.Add do
    begin
      with Row(CSSClass.DivHtml.Align_Left).Items.Add do
      begin
        VCLObj(btNovo,CSSClass.Button.add + CSSClass.Col.colsize1);
        VCLObj(btEditar,CSSClass.Button.edit + CSSClass.Col.colsize1);
        VCLObj(btExcluir,CSSClass.Button.delete + CSSClass.Col.colsize1);
      end;
    end;

    //Abrindo formulário popup
    with Popup('PopupCadFornecedorAdd','Cadastro de Fornecedor').Items.Add do
      Nested(FfrmCad_Fornecedor_Add);
  end;

end;

procedure TfrmCad_Fornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ControleHoras.Fornecedor_ID := 0;
  ControleHoras.Fornecedor_Nome := '';
  if not FDMem_Registro.IsEmpty then
  begin
    ControleHoras.Fornecedor_ID := FDMem_RegistroID.AsInteger;
    ControleHoras.Fornecedor_Nome := FDMem_RegistroNOME.AsString;
  end;
  Action := CaFree;
end;

procedure TfrmCad_Fornecedor.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
end;

procedure TfrmCad_Fornecedor.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_Fornecedor.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_Fornecedor.Pesquisar;
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

procedure TfrmCad_Fornecedor.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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