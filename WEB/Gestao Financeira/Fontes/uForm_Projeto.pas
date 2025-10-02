unit uForm_Projeto;

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
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,

  uForm_Projeto.Cad, frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF, Vcl.Menus;

type
  TfrmForm_Projeto = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    dsRegistros: TDataSource;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    pnHeader: TPanel;
    btNovo: TButton;
    FDMem_Registroid: TIntegerField;
    FDMem_RegistroidProjeto: TIntegerField;
    FDMem_RegistronomeForm: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_RegistroidTipoForm: TIntegerField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrostatusDesc: TStringField;
    FDMem_RegistrotipoFormTipoDesc: TStringField;
    FDMem_RegistroidTipoFormDesc: TStringField;
    FDMem_RegistroidProjetoDesc: TStringField;
    edPesquisar: TEdit;
    btFiltros: TButton;
    btPrint: TButton;
    PopupMenu: TPopupMenu;
    mnuPop_Filtro_ID: TMenuItem;
    mnuPop_Filtro_Nome: TMenuItem;
    mnuPop_Filtro_SiglaUF: TMenuItem;
    frxReport: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBDataset: TfrxDBDataset;
    procedure btFecharClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure edPesquisarRightButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmForm_Projeto_Cad :TfrmForm_Projeto_Cad;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    procedure OnEdit(Sender :TObject);
    procedure OnExcluir(Sender :TObject);

    procedure Pesquisar;

    procedure ShowPopup(const AName:String; var CanShow:Boolean);
    procedure PopupOpened(AName:String); override;

    procedure ClosePopup(const AName:String; var CanClose:Boolean);
    procedure PopupClosed(const AName:String); override;

  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmForm_Projeto:TfrmForm_Projeto;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmForm_Projeto:TfrmForm_Projeto;
begin
  result:= TfrmForm_Projeto(TfrmForm_Projeto.GetInstance);
end;

procedure TfrmForm_Projeto.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmForm_Projeto.btNovoClick(Sender: TObject);
begin
  Gestao_Financeira.FormProjeto_Status_Tab := '';
  Gestao_Financeira.FormProjeto_Status_Tab := 'Insert';

  ShowPopupModal('Popup' + FfrmForm_Projeto_Cad.Name);
end;

procedure TfrmForm_Projeto.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmForm_Projeto.edPesquisarRightButtonClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmForm_Projeto.ExportD2Bridge;
begin
  inherited;

  Title:= 'Formulários do Projeto';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmForm_Projeto_Cad := TfrmForm_Projeto_Cad.Create(Self);
  D2Bridge.AddNested(FfrmForm_Projeto_Cad);


  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize10 + ' ' + CSSClass.ColorName.beige).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3).Items.Add do
        begin
          With FormGroup(lbStatus.Caption,CSSClass.Col.colsize2).Items.Add do
            VCLObj(cbStatus);
          With FormGroup(lbPesquisa.Caption,CSSClass.Col.col).Items.Add do
          begin
            with Row.Items.Add do
            begin
              FormGroup('',CSSClass.col.colsize2).Items.Add.VCLObj(cbTipo);
              FormGroup('',CSSClass.col.col).Items.Add.VCLObj(edPesquisar);
            end;
          end;
        end;
      end;

      with HTMLDIV(CSSClass.Col.colsize2).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3 + ' ' + CSSClass.Space.margim_top4).Items.Add do
        begin
          with HTMLDIV(CSSClass.Text.Align.right).Items.Add do
          begin
            VCLObj(btNovo, CSSClass.Button.add);
            VCLObj(btFechar, CSSClass.Button.close);
          end;
        end;
      end;
    end;

    with Row.Items.Add do
      VCLObj(DBGrid_Registros);

    //Popup('Popup'+frmProjetos_Cad.Name, 'Cadastro de Projetos',True,CSSClass.Popup.ExtraLarge).Items.Add.Nested(FfrmProjetos_Cad.Name);

    with Popup('Popup' + FfrmForm_Projeto_Cad.Name,'Cadastro de Formulários do Projeto',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmForm_Projeto_Cad);

  end;

end;

procedure TfrmForm_Projeto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caNone;
end;

procedure TfrmForm_Projeto.FormCreate(Sender: TObject);
begin
  cbStatus.ItemIndex := 1;

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmForm_Projeto.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmForm_Projeto.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = edPesquisar then
  begin
    with PrismControl.AsButtonedEdit do
      ButtonRightCSS:= CSSClass.Button.search;
  end;

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
         //Height := 50;
         With Buttons.Add do
         begin
          ButtonModel := TButtonModel.edit;
          Caption:='';
          Onclick:=OnEdit;
         end;
         With Buttons.Add do
         begin
          ButtonModel := TButtonModel.Delete;
          Caption:='';
          Onclick:=OnExcluir;
         end;
      end;

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

procedure TfrmForm_Projeto.OnEdit(Sender: TObject);
begin
  Gestao_Financeira.FormProjeto_Status_Tab := '';
  Gestao_Financeira.FormProjeto_Status_Tab := 'Edit';
  ShowPopupModal('Popup' + FfrmForm_Projeto_Cad.Name);
end;

procedure TfrmForm_Projeto.OnExcluir(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir o Formulário do Projeto selecionado?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(Gestao_Financeira.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(Gestao_Financeira.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('telaProjeto')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmForm_Projeto.Pesquisar;
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
      FDMem_Registro.EmptyDataSet;

      FDMem_Registro.DisableControls;

      FTipoPesquisa := '';
      case cbTipo.ItemIndex of
        0:FTipoPesquisa := 'id';
        1:FTipoPesquisa := 'descricao';
        2:FTipoPesquisa := 'idProjeto';
        3:FTipoPesquisa := 'projeto';
      end;

      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if Trim(Gestao_Financeira.Usuario_Token) = '' then
        raise Exception.Create('Token do Usuário inválido');

      if Trim(FTipoPesquisa) <> '' then
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam(FTipoPesquisa,edPesquisar.Text)
                 .AddParam('status',cbStatus.ItemIndex.ToString)
                 .Resource('telaProjeto')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam('status',cbStatus.ItemIndex.ToString)
                 .Resource('telaProjeto')
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
            FDMem_RegistroidProjeto.AsInteger := FBody.Get(x).GetValue<Integer>('idProjeto',0);
            FDMem_RegistronomeForm.AsString := FBody.Get(x).GetValue<String>('nomeForm','');
            FDMem_Registrodescricao.AsString := FBody.Get(x).GetValue<String>('descricao','');
            FDMem_RegistroidTipoForm.AsInteger := FBody.Get(x).GetValue<Integer>('idTipoForm',0);
            FDMem_Registrostatus.AsInteger := FBody.Get(x).GetValue<Integer>('status',-1);
            FDMem_RegistrostatusDesc.AsString := FBody.Get(x).GetValue<String>('statusDesc','');
            FDMem_RegistrotipoFormTipoDesc.AsString := FBody.Get(x).GetValue<String>('tipoFormTipoDesc','');
            FDMem_RegistroidTipoFormDesc.AsString := FBody.Get(x).GetValue<String>('idTipoFormDesc','');
            FDMem_RegistroidProjetoDesc.AsString := FBody.Get(x).GetValue<String>('idProjetoDesc','');
            FDMem_RegistrodtCadastro.AsDateTime := TFuncoes.StringParaData(FBody.Get(x).GetValue<String>('dtCadastro',''));
            FDMem_RegistrohrCadastro.AsDateTime := TFuncoes.StringParaHora(FBody.Get(x).GetValue<String>('hrCadastro',''));
          FDMem_Registro.Post;
        end;
      end
      else
      begin
        raise Exception.Create(FResp.StatusCode.ToString + ': ' + FResp.Content);
      end;

    except on E: Exception do
      ShowMessage(E.Message,True,True,10000);
    end;
  finally
    FDMem_Registro.EnableControls;
  end;
end;

procedure TfrmForm_Projeto.PopupClosed(const AName: String);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmForm_Projeto.PopupOpened(AName: String);
begin
  inherited;
  if Gestao_Financeira.FormProjeto_Status_Tab = 'Insert' then
    FfrmForm_Projeto_Cad.cbstatus.ItemIndex := 1
  else if Gestao_Financeira.FormProjeto_Status_Tab = 'Edit' then
  begin
    FfrmForm_Projeto_Cad.edid.Text := FDMem_Registro.FieldByName('id').AsString;
    FfrmForm_Projeto_Cad.cbstatus.ItemIndex := FDMem_Registro.FieldByName('status').AsInteger;
    FfrmForm_Projeto_Cad.ednome_form.Text := FDMem_Registro.FieldByName('nomeForm').AsString;
    FfrmForm_Projeto_Cad.edid_projeto.Text := FDMem_Registro.FieldByName('idProjeto').AsString;
    FfrmForm_Projeto_Cad.edid_projeto_Desc.Text := FDMem_Registro.FieldByName('idProjetoDesc').AsString;
    FfrmForm_Projeto_Cad.edid_tipo_form.Text := FDMem_Registro.FieldByName('idTipoForm').AsString;
    FfrmForm_Projeto_Cad.edid_tipo_form_Desc.Text := FDMem_Registro.FieldByName('idTipoFormDesc').AsString;
    FfrmForm_Projeto_Cad.eddescricao.Lines.Add(FDMem_Registro.FieldByName('descricao').AsString);
  end;

end;

procedure TfrmForm_Projeto.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmForm_Projeto.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.