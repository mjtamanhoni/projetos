unit uEmpresa.Loc;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,
  uFuncoes.Gerais,
  uPrincipal,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF,
  Vcl.Menus, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TfrmEmpresa_Loc = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_Registrotipo: TIntegerField;
    FDMem_RegistrorazaoSocial: TStringField;
    FDMem_Registrofantasia: TStringField;
    FDMem_Registrocnpj: TStringField;
    FDMem_RegistroinscEstadual: TStringField;
    FDMem_Registrocontato: TStringField;
    FDMem_Registroendereco: TStringField;
    FDMem_Registronumero: TStringField;
    FDMem_Registrocomplemento: TStringField;
    FDMem_Registrobairro: TStringField;
    FDMem_RegistroidCidade: TIntegerField;
    FDMem_RegistrocidadeIbge: TIntegerField;
    FDMem_Registrocidade: TStringField;
    FDMem_RegistrosiglaUf: TStringField;
    FDMem_Registrocep: TStringField;
    FDMem_Registrotelefone: TStringField;
    FDMem_Registrocelular: TStringField;
    FDMem_Registroemail: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrotipoPessoa: TIntegerField;
    FDMem_RegistrostatusDesc: TStringField;
    FDMem_RegistrotipoDesc: TStringField;
    FDMem_RegistrotipoPessoaDesc: TStringField;
    dsRegistros: TDataSource;
    PopupMenu: TPopupMenu;
    mnuPop_Filtro_ID: TMenuItem;
    mnuFiltro_RazaoSocial: TMenuItem;
    mnuFiltro_NomeFantasia: TMenuItem;
    mnuFiltro_CNPJ: TMenuItem;
    mnuFiltro_Inativo: TMenuItem;
    frxReport: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBDataset: TfrxDBDataset;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    pnHeader: TPanel;
    edPesquisar: TEdit;
    btFiltros: TButton;
    btPrint: TButton;
    btConfirmar: TButton;
    btCancelar: TButton;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure mnuFiltro_InativoClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
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

function frmEmpresa_Loc:TfrmEmpresa_Loc;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmEmpresa_Loc:TfrmEmpresa_Loc;
begin
  result:= TfrmEmpresa_Loc(TfrmEmpresa_Loc.GetInstance);
end;

procedure TfrmEmpresa_Loc.btCancelarClick(Sender: TObject);
begin
  {$Region 'Retornando valores'}
    Gestao_Financeira.Emp_ID := 0;
    Gestao_Financeira.Emp_RazaoSocial := '';
    Gestao_Financeira.Emp_Fantasia := '';
    Gestao_Financeira.Emp_CNPJ := '';
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmEmpresa_Loc.btConfirmarClick(Sender: TObject);
begin
  {$Region 'Retornando valores'}
    Gestao_Financeira.Emp_ID := FDMem_Registroid.AsInteger;
    Gestao_Financeira.Emp_RazaoSocial := FDMem_RegistrorazaoSocial.AsString;
    Gestao_Financeira.Emp_Fantasia := FDMem_Registrofantasia.AsString;
    Gestao_Financeira.Emp_CNPJ := FDMem_Registrocnpj.AsString;
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmEmpresa_Loc.btPrintClick(Sender: TObject);
begin
  try
    if FDMem_Registro.IsEmpty then
      raise Exception.Create('Não há registros a serem impressos');

    frxPDFExport.FileName := PrismSession.PathSession + 'Rel_Empresa.pdf';

    // Config. do rel e exportacao do pdf...
    frxReport.LoadFromFile(RootDirectory + '/Reports/Rel_Empresa.fr3');
    frxReport.PrepareReport;
    frxReport.Export(frxPDFExport);

    if FileExists(PrismSession.PathSession + 'Rel_Empresa.pdf') then
      D2Bridge.PrismSession.SendFile(PrismSession.PathSession + 'Rel_Empresa.pdf')
    else
      raise Exception.Create('Erro ao gerar o PDF');

  except on E: Exception do
    MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
  end;

end;

procedure TfrmEmpresa_Loc.edPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Pesquisar;
end;

procedure TfrmEmpresa_Loc.ExportD2Bridge;
begin
  inherited;

  Title:= 'Localiza Empresa';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize9).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3).Items.Add do
        begin
          With FormGroup('',CSSClass.Col.col).Items.Add do
          begin
            VCLObj(edPesquisar);
            VCLObj(btFiltros, PopupMenu, CSSClass.Button.search);
          end;
        end;
      end;

      with HTMLDIV(CSSClass.Col.col).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3 + ' ' + CSSClass.Space.margim_top1).Items.Add do
        begin
          with HTMLDIV(CSSClass.Text.Align.right).Items.Add do
          begin
            VCLObj(btPrint, CSSClass.Button.print);
          end;
        end;
      end;
    end;

    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize12).Items.Add do
      begin
        with Row.Items.Add do
        begin
          with PanelGroup('Listagem','',False,CSSClass.Col.colsize12).Items.Add do
            VCLObj(DBGrid_Registros);
        end;
      end;
    end;

    with Row.Items.Add do
    begin
      with Row(CSSClass.DivHtml.Align_Right).Items.Add do
      begin
        VCLObj(btConfirmar, CSSClass.Button.select + ' ' + CSSClass.Col.colsize2);
        VCLObj(btCancelar, CSSClass.Button.cancel + ' ' + CSSClass.Col.colsize2);
      end;
    end;

  end;

end;

procedure TfrmEmpresa_Loc.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmEmpresa_Loc.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmEmpresa_Loc.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage := 10;
    with PrismControl.AsDBGrid do
    begin
      with Columns.Add do
      begin
        Title:= 'Status';
        Width:= 60;
        HTML:= '<span class="badge ${data.status == 0 ? '+QuotedStr('bg-danger')+' : '+QuotedStr('bg-success')+'} rounded-pill p-2" style="width: 7em;">  ${data.statusDesc}</span>';
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

procedure TfrmEmpresa_Loc.mnuFiltro_InativoClick(Sender: TObject);
begin
  edPesquisar.Tag := TMenuItem(Sender).Tag;
  case TMenuItem(Sender).Tag of
    0:edPesquisar.TextHint := 'Pesquisar pelo ID da Empresa';
    1:edPesquisar.TextHint := 'Pesquisar pela Razão Social da Empresa';
    2:edPesquisar.TextHint := 'Pesquisar pelo Nome Fantasia da Empresa';
    3:edPesquisar.TextHint := 'Pesquisar pelo CNPJ da Empresa';
  end;
  Pesquisar;

end;

procedure TfrmEmpresa_Loc.Pesquisar;
var
  FResp :IResponse;
  FBody :TJSONArray;
  FTipoPesquisa:String;
  x:Integer;
  FStatus :Integer;
begin
  try
    try
      FDMem_Registro.Active := False;
      FDMem_Registro.Active := True;
      FDMem_Registro.EmptyDataSet;

      FStatus := 1;

      FDMem_Registro.DisableControls;

      FTipoPesquisa := '';
      case edPesquisar.Tag of
        0:begin
          if TFuncoes.ContemNaoNumerico(edPesquisar.Text) then
            raise Exception.Create('Para pesquisar o ID não pode haver letras no texto da pesquisa');
          FTipoPesquisa := 'id';
        end;
        1:FTipoPesquisa := 'razaoSocial';
        2:FTipoPesquisa := 'nomeFantasia';
        3:FTipoPesquisa := 'cnpj';
        4:FStatus := 0;
      end;

      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if Trim(Gestao_Financeira.Usuario_Token) = '' then
        raise Exception.Create('Token do Usuário inválido');

      if ((Trim(FTipoPesquisa) <> '') and (Trim(edPesquisar.Text) <> '')) then
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam(FTipoPesquisa,edPesquisar.Text)
                 .AddParam('status',FStatus.ToString)
                 .Resource('empresa')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam('status',FStatus.ToString)
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
            FDMem_Registroid.AsInteger := FBody.Get(x).GetValue<Integer>('id',0);
            FDMem_Registrostatus.AsInteger := FBody.Get(x).GetValue<Integer>('status',0);
            FDMem_Registrotipo.AsInteger := FBody.Get(x).GetValue<Integer>('tipo',0);
            FDMem_RegistrorazaoSocial.AsString := FBody.Get(x).GetValue<String>('razaoSocial','');
            FDMem_Registrofantasia.AsString := FBody.Get(x).GetValue<String>('fantasia','');
            FDMem_Registrocnpj.AsString := FBody.Get(x).GetValue<String>('cnpj','');
            FDMem_RegistroinscEstadual.AsString := FBody.Get(x).GetValue<String>('inscEstadual','');
            FDMem_Registrocontato.AsString := FBody.Get(x).GetValue<String>('contato','');
            FDMem_Registroendereco.AsString := FBody.Get(x).GetValue<String>('endereco','');
            FDMem_Registronumero.AsString := FBody.Get(x).GetValue<String>('numero','');
            FDMem_Registrocomplemento.AsString := FBody.Get(x).GetValue<String>('complemento','');
            FDMem_Registrobairro.AsString := FBody.Get(x).GetValue<String>('bairro','');
            FDMem_RegistroidCidade.AsInteger := FBody.Get(x).GetValue<Integer>('idCidade',0);
            FDMem_RegistrocidadeIbge.AsInteger := FBody.Get(x).GetValue<Integer>('cidadeIbge',0);
            FDMem_Registrocidade.AsString := FBody.Get(x).GetValue<String>('cidade','');
            FDMem_RegistrosiglaUf.AsString := FBody.Get(x).GetValue<String>('siglaUf','');
            FDMem_Registrocep.AsString := FBody.Get(x).GetValue<String>('cep','');
            FDMem_Registrotelefone.AsString := FBody.Get(x).GetValue<String>('telefone','');
            FDMem_Registrocelular.AsString := FBody.Get(x).GetValue<String>('celular','');
            FDMem_Registroemail.AsString := FBody.Get(x).GetValue<String>('email','');
            FDMem_RegistrodtCadastro.AsDateTime := TFuncoes.StringParaData(FBody.Get(x).GetValue<String>('dtCadastro',''));
            FDMem_RegistrohrCadastro.AsDateTime := TFuncoes.StringParaHora(FBody.Get(x).GetValue<String>('hrCadastro',''));
            FDMem_RegistrotipoPessoa.AsInteger := FBody.Get(x).GetValue<Integer>('tipoPessoa',0);
            FDMem_RegistrostatusDesc.AsString := FBody.Get(x).GetValue<String>('statusDesc','');
            FDMem_RegistrotipoDesc.AsString := FBody.Get(x).GetValue<String>('tipoDesc','');
            FDMem_RegistrotipoPessoaDesc.AsString := FBody.Get(x).GetValue<String>('tipoPessoaDesc','');
          FDMem_Registro.Post;
        end;
      end
      else
      begin
        if FResp.StatusCode = 204 then
          raise Exception.Create('Registro não localizado')
        else
          raise Exception.Create(FResp.StatusCode.ToString + ': ' + FResp.Content);
      end;

    except on E: Exception do
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    end;
  finally
    FDMem_Registro.EnableControls;
  end;
end;

procedure TfrmEmpresa_Loc.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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