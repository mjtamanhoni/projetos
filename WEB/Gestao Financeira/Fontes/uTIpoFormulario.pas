unit uTIpoFormulario;

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

  uTIpoFormulario.Cad, frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF, Vcl.Menus;

type
  TfrmTipoFormulario = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrodt_cadastro: TDateField;
    FDMem_Registrohr_cadastro: TTimeField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_Registrostatus_desc: TStringField;
    dsRegistros: TDataSource;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    pnHeader: TPanel;
    btNovo: TButton;
    FDMem_Registrotipo: TStringField;
    FDMem_Registrotipo_desc: TStringField;
    PopupMenu: TPopupMenu;
    mnuPop_Filtro_ID: TMenuItem;
    mnuPop_Filtro_Nome: TMenuItem;
    mnuPop_Filtro_SiglaUF: TMenuItem;
    frxReport: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBDataset: TfrxDBDataset;
    edPesquisar: TEdit;
    btFiltros: TButton;
    btPrint: TButton;
    mnuFiltro_TipoForm: TMenuItem;
    procedure btFecharClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure edPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure mnuPop_Filtro_NomeClick(Sender: TObject);
  private
    FfrmTipoFormulario_Cad :TfrmTipoFormulario_Cad;

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

  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmTipoFormulario:TfrmTipoFormulario;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmTipoFormulario:TfrmTipoFormulario;
begin
  result:= TfrmTipoFormulario(TfrmTipoFormulario.GetInstance);
end;

procedure TfrmTipoFormulario.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTipoFormulario.btNovoClick(Sender: TObject);
var
  FRetorno:Boolean;
begin

  Gestao_Financeira.TipoFormulario_Status_Tab := '';
  Gestao_Financeira.TipoFormulario_Status_Tab := 'Insert';

  ShowPopupModal('Popup' + FfrmTipoFormulario_Cad.Name);
end;

procedure TfrmTipoFormulario.btPrintClick(Sender: TObject);
begin
  inherited;
  try
    if FDMem_Registro.IsEmpty then
      raise Exception.Create('Não há registros a serem impressos');

    frxPDFExport.FileName := PrismSession.PathSession + 'Rel_TipoForm.pdf';

    // Config. do rel e exportacao do pdf...
    frxReport.LoadFromFile(RootDirectory + '/Reports/Rel_TipoForm.fr3');
    frxReport.PrepareReport;
    frxReport.Export(frxPDFExport);

    if FileExists(PrismSession.PathSession + 'Rel_TipoForm.pdf') then
      D2Bridge.PrismSession.SendFile(PrismSession.PathSession + 'Rel_TipoForm.pdf')
    else
      raise Exception.Create('Erro ao gerar o PDF');

  except on E: Exception do
    MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
  end;

end;

procedure TfrmTipoFormulario.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmTipoFormulario.edPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    Pesquisar;

end;

procedure TfrmTipoFormulario.ExportD2Bridge;
begin
  inherited;

  Title:= 'Tipos de Formulários';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmTipoFormulario_Cad := TfrmTipoFormulario_Cad.Create(Self);
  D2Bridge.AddNested(FfrmTipoFormulario_Cad);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize10).Items.Add do
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
            VCLObj(btNovo, CSSClass.Button.add);
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

    with Popup('Popup' + FfrmTipoFormulario_Cad.Name,'Cadastro de Tipo de Formulário',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmTipoFormulario_Cad);
  end;

end;

procedure TfrmTipoFormulario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caNone;
end;

procedure TfrmTipoFormulario.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmTipoFormulario.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmTipoFormulario.InitControlsD2Bridge(const PrismControl: TPrismControl);
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
         Width := 55;
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
        Width:= 50;
        HTML:= '<span class="badge ${data.status == 0 ? '+QuotedStr('bg-danger')+' : '+QuotedStr('bg-success')+'} rounded-pill p-2" style="width: 7em;">  ${data.status_desc}</span>';
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

procedure TfrmTipoFormulario.mnuPop_Filtro_NomeClick(Sender: TObject);
begin
  inherited;
  edPesquisar.Tag := TMenuItem(Sender).Tag;
  case TMenuItem(Sender).Tag of
    0:edPesquisar.TextHint := 'Pesquisar pelo ID do Tipo de Formulário';
    1:edPesquisar.TextHint := 'Pesquisar pela Descrição do Tipo de Formulário';
    2:edPesquisar.TextHint := 'Pesquisar pelo Tipo do Tipo de Formulário';
  end;
  Pesquisar;

end;

procedure TfrmTipoFormulario.OnEdit(Sender: TObject);
var
  FRetorno :Boolean;
begin
  Gestao_Financeira.TipoFormulario_Status_Tab := '';
  Gestao_Financeira.TipoFormulario_Status_Tab := 'Edit';
  ShowPopupModal('Popup' + FfrmTipoFormulario_Cad.Name);
end;

procedure TfrmTipoFormulario.OnExcluir(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir o Tipo de Formulário selecionado?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(Gestao_Financeira.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(Gestao_Financeira.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('tipoForm')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmTipoFormulario.Pesquisar;
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
        1:FTipoPesquisa := 'descricao';
        2:FTipoPesquisa := 'tipo';
        3:FStatus := 0;
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
                 .AddParam('status',FStatus.ToString)
                 .Resource('tipoForm')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam('status',FStatus.ToString)
                 .Resource('tipoForm')
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
            FDMem_Registrotipo.AsInteger := FBody.Get(x).GetValue<Integer>('tipo',-1);
            FDMem_Registrodescricao.AsString := FBody.Get(x).GetValue<String>('descricao','');
            FDMem_Registrostatus.AsInteger := FBody.Get(x).GetValue<Integer>('status',-1);
            FDMem_Registrostatus_desc.AsString := FBody.Get(x).GetValue<String>('statusDesc','');
            FDMem_Registrotipo_desc.AsString := FBody.Get(x).GetValue<String>('tipoDesc','');
            FDMem_Registrodt_cadastro.AsDateTime := TFuncoes.StringParaData(FBody.Get(x).GetValue<String>('dtCadastro',''));
            FDMem_Registrohr_cadastro.AsDateTime := TFuncoes.StringParaHora(FBody.Get(x).GetValue<String>('hrCadastro',''));
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
    FResp := Nil;
    FBody := Nil;
    FDMem_Registro.EnableControls;
  end;
end;

procedure TfrmTipoFormulario.PopupClosed(const AName: String);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmTipoFormulario.PopupOpened(AName: String);
begin
  inherited;
  if Gestao_Financeira.TipoFormulario_Status_Tab = 'Insert' then
    FfrmTipoFormulario_Cad.cbstatus.ItemIndex := 1
  else if Gestao_Financeira.TipoFormulario_Status_Tab = 'Edit' then
  begin
    FfrmTipoFormulario_Cad.edid.Text := FDMem_Registro.FieldByName('id').AsString;
    FfrmTipoFormulario_Cad.cbtipo.ItemIndex := FDMem_Registro.FieldByName('tipo').AsInteger;
    FfrmTipoFormulario_Cad.eddescricao.Text := FDMem_Registro.FieldByName('descricao').AsString;
    FfrmTipoFormulario_Cad.cbstatus.ItemIndex := FDMem_Registro.FieldByName('status').AsInteger;
  end;

end;

procedure TfrmTipoFormulario.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmTipoFormulario.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.