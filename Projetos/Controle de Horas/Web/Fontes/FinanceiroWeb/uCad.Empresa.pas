unit uCad.Empresa;

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

  uCad.Empresa.Add;

type
  TfrmCad_Empresa = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    pnHeader: TPanel;
    lbTipo: TLabel;
    lbPesquisar: TLabel;
    cbTipo: TComboBox;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
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
    pnFooter: TPanel;
    btExcluir: TButton;
    btEditar: TButton;
    btNovo: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    FfrmCad_Empresa_Add :TfrmCad_Empresa_Add;

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

function frmCad_Empresa:TfrmCad_Empresa;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmCad_Empresa:TfrmCad_Empresa;
begin
  result:= TfrmCad_Empresa(TfrmCad_Empresa.GetInstance);
end;

procedure TfrmCad_Empresa.btEditarClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_Empresa_Add.edID.Text := FDMem_RegistroID.AsString;
    FfrmCad_Empresa_Add.edNome.Text := FDMem_RegistroNOME.AsString;
    FfrmCad_Empresa_Add.cbPESSOA.ItemIndex := FDMem_RegistroPESSOA.AsInteger;
    FfrmCad_Empresa_Add.edDOCUMENTO.Text := FDMem_RegistroDOCUMENTO.AsString;
    FfrmCad_Empresa_Add.edINSC_EST.Text := FDMem_RegistroINSC_EST.AsString;
    FfrmCad_Empresa_Add.edCEP.Text := FDMem_RegistroCEP.AsString;
    FfrmCad_Empresa_Add.edENDERECO.Text := FDMem_RegistroENDERECO.AsString;
    FfrmCad_Empresa_Add.edCOMPLEMENTO.Text := FDMem_RegistroCOMPLEMENTO.AsString;
    FfrmCad_Empresa_Add.edNUMERO.Text := FDMem_RegistroNUMERO.AsString;
    FfrmCad_Empresa_Add.edBAIRRO.Text := FDMem_RegistroBAIRRO.AsString;
    FfrmCad_Empresa_Add.edCIDADE.Text := FDMem_RegistroCIDADE.AsString;
    FfrmCad_Empresa_Add.cbUF.Text := FDMem_RegistroUF.AsString;
    FfrmCad_Empresa_Add.edTELEFONE.Text := FDMem_RegistroTELEFONE.AsString;
    FfrmCad_Empresa_Add.edCELULAR.Text := FDMem_RegistroCELULAR.AsString;
    FfrmCad_Empresa_Add.edEMAIL.Text := FDMem_RegistroEMAIL.AsString;
    FfrmCad_Empresa_Add.Status_Tabela := 1;


    ShowPopupModal('PopupCadEmpresaAdd');
  end
  else
  begin
    FfrmCad_Empresa_Add := TfrmCad_Empresa_Add.Create(Self);
    FfrmCad_Empresa_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_Empresa.btExcluirClick(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir a Empresa selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(FinanceiroWeb.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(FinanceiroWeb.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('empresa')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmCad_Empresa.btNovoClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_Empresa_Add.FDMem_Registro.Active := False;
    FfrmCad_Empresa_Add.FDMem_Registro.Active := True;

    FfrmCad_Empresa_Add.edID.Text := '';
    FfrmCad_Empresa_Add.edNome.Text := '';
    FfrmCad_Empresa_Add.cbPESSOA.Text := '';
    FfrmCad_Empresa_Add.cbPESSOA.ItemIndex := -1;
    FfrmCad_Empresa_Add.edDOCUMENTO.Text := '';
    FfrmCad_Empresa_Add.edINSC_EST.Text := '';
    FfrmCad_Empresa_Add.edCEP.Text := '';
    FfrmCad_Empresa_Add.edENDERECO.Text := '';
    FfrmCad_Empresa_Add.edCOMPLEMENTO.Text := '';
    FfrmCad_Empresa_Add.edNUMERO.Text := '';
    FfrmCad_Empresa_Add.edBAIRRO.Text := '';
    FfrmCad_Empresa_Add.edCIDADE.Text := '';
    FfrmCad_Empresa_Add.cbUF.Text := '';
    FfrmCad_Empresa_Add.cbUF.ItemIndex := -1;
    FfrmCad_Empresa_Add.edTELEFONE.Text := '';
    FfrmCad_Empresa_Add.edCELULAR.Text := '';
    FfrmCad_Empresa_Add.edEMAIL.Text := '';
    FfrmCad_Empresa_Add.Status_Tabela := 0;

    ShowPopupModal('PopupCadEmpresaAdd')
  end
  else
  begin
    FfrmCad_Empresa_Add := TfrmCad_Empresa_Add.Create(Self);
    FfrmCad_Empresa_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_Empresa.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_Empresa.ExportD2Bridge;
begin
  inherited;

  Title:= 'Empresas';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmCad_Empresa_Add := TfrmCad_Empresa_Add.Create(Self);
  D2Bridge.AddNested(FfrmCad_Empresa_Add);

  with D2Bridge.Items.add do
  begin
    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbTipo.Caption,CSSClass.Col.colsize2).AddVCLObj(cbTipo);
        FormGroup(lbPesquisar.Caption,CSSClass.Col.colsize6).AddVCLObj(edPesquisar);

        FormGroup('',CSSClass.Col.colsize2).AddVCLObj(btPesquisar,CSSClass.Button.search);
        FormGroup('',CSSClass.Col.colsize2).AddVCLObj(btNovo,CSSClass.Button.add)
      end;
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    //Abrindo formulário popup
    with Popup('PopupCadEmpresaAdd','Cadastro de Empresa').Items.Add do
      Nested(FfrmCad_Empresa_Add);
  end;

end;

procedure TfrmCad_Empresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinanceiroWeb.Empresa_ID := 0;
  FinanceiroWeb.Empresa_Nome := '';
  if not FDMem_Registro.IsEmpty then
  begin
    FinanceiroWeb.Empresa_ID := FDMem_RegistroID.AsInteger;
    FinanceiroWeb.Empresa_Nome := FDMem_RegistroNOME.AsString;
  end;
  Action := CaFree;
end;

procedure TfrmCad_Empresa.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
end;

procedure TfrmCad_Empresa.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_Empresa.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage := 10;
   //PrismControl.AsDBGrid.MaxRecords:= 2000;
    with PrismControl.AsDBGrid do
    begin
      with Columns.Add do
      begin
         Title:= 'Ações';
         ColumnIndex :=0;
         Width := 65;
         With Buttons.Add do
           begin
            ButtonModel := TButtonModel.edit;
            Caption:='';
            Onclick:=btEditarClick;
           end;

         With Buttons.Add do
           begin
            ButtonModel := TButtonModel.Delete;
            Caption:='';
            Onclick:=btExcluirClick;
           end;
      end;
    end;
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

procedure TfrmCad_Empresa.Pesquisar;
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

    if Trim(FinanceiroWeb.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    if Trim(FTipoPesquisa) <> '' then
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .AddParam(FTipoPesquisa,edPesquisar.Text)
               .Resource('empresa')
               .Accept('application/json')
               .Get;
    end
    else
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .Resource('empresa')
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

procedure TfrmCad_Empresa.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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