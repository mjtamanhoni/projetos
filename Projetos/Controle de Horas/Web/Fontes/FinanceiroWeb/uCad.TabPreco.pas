unit uCad.TabPreco;

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
  uCad.TabPreco.Add;

type
  TfrmCad_TabPreco = class(TfrmPrincipal)
    pnHeader: TPanel;
    lbTipo: TLabel;
    lbPesquisar: TLabel;
    cbTipo: TComboBox;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    FDMem_Registro: TFDMemTable;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroTIPO: TStringField;
    FDMem_RegistroVALOR: TFloatField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroTIPO_DESC: TStringField;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    pnFooter: TPanel;
    btNovo: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    FDMem_RegistroTOTAL_HORAS_PREVISTA: TStringField;
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmCad_TabPreco_Add :TfrmCad_TabPreco_Add;

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

function frmCad_TabPreco:TfrmCad_TabPreco;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmCad_TabPreco:TfrmCad_TabPreco;
begin
  result:= TfrmCad_TabPreco(TfrmCad_TabPreco.GetInstance);
end;

procedure TfrmCad_TabPreco.btEditarClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_TabPreco_Add.edID.Text := FDMem_RegistroID.AsString;
    FfrmCad_TabPreco_Add.edDESCRICAO.Text := FDMem_RegistroDESCRICAO.AsString;
    FfrmCad_TabPreco_Add.cbTIPO.ItemIndex := FDMem_RegistroTIPO.AsInteger;
    FfrmCad_TabPreco_Add.edVALOR.Text := FloatToStr(FDMem_RegistroVALOR.AsFloat);
    FfrmCad_TabPreco_Add.edTOTAL_HORAS_PREVISTA.Text := FDMem_RegistroTOTAL_HORAS_PREVISTA.AsString;
    FfrmCad_TabPreco_Add.Status_Tabela := 1;

    ShowPopupModal('PopupCadTabPrecoAdd');
  end
  else
  begin
    FfrmCad_TabPreco_Add := TfrmCad_TabPreco_Add.Create(Self);
    FfrmCad_TabPreco_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_TabPreco.btExcluirClick(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir a Tabela de Preço selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(FinanceiroWeb.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(FinanceiroWeb.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('tabelaPreco')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmCad_TabPreco.btNovoClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_TabPreco_Add.FDMem_Registro.Active := False;
    FfrmCad_TabPreco_Add.FDMem_Registro.Active := True;

    FfrmCad_TabPreco_Add.edID.Text := '';
    FfrmCad_TabPreco_Add.edDESCRICAO.Text := '';
    FfrmCad_TabPreco_Add.cbTIPO.Text := '';
    FfrmCad_TabPreco_Add.cbTIPO.ItemIndex := -1;
    FfrmCad_TabPreco_Add.edVALOR.Text := '';
    FfrmCad_TabPreco_Add.edTOTAL_HORAS_PREVISTA.Text := '';
    FfrmCad_TabPreco_Add.Status_Tabela := 0;

    ShowPopupModal('PopupCadTabPrecoAdd')
  end
  else
  begin
    FfrmCad_TabPreco_Add := TfrmCad_TabPreco_Add.Create(Self);
    FfrmCad_TabPreco_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_TabPreco.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_TabPreco.ExportD2Bridge;
begin
  inherited;

  Title:= 'Tabela de Preço';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmCad_TabPreco_Add := TfrmCad_TabPreco_Add.Create(Self);
  D2Bridge.AddNested(FfrmCad_TabPreco_Add);

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
    with Popup('PopupCadTabPrecoAdd','Cadastro de Tabela de Preços').Items.Add do
      Nested(FfrmCad_TabPreco_Add);
  end;

end;

procedure TfrmCad_TabPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FinanceiroWeb.Tab_Preco_ID := 0;
  FinanceiroWeb.Tab_Preco_Nome := '';
  if not FDMem_Registro.IsEmpty then
  begin
    FinanceiroWeb.Tab_Preco_ID := FDMem_RegistroID.AsInteger;
    FinanceiroWeb.Tab_Preco_Nome := FDMem_RegistroDESCRICAO.AsString;
  end;
  Action := CaFree;
end;

procedure TfrmCad_TabPreco.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
end;

procedure TfrmCad_TabPreco.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_TabPreco.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_TabPreco.Pesquisar;
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
          FDMem_RegistroTOTAL_HORAS_PREVISTA.AsString := FBody.Get(x).GetValue<String>('totalHorasPrevista','');
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

procedure TfrmCad_TabPreco.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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