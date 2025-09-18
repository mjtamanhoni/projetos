unit uProjetos;

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
  D2Bridge.Forms, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,

  uProjetos.Cad;

type
  TfrmProjetos = class(TfrmPrincipal)
    pnHeader: TPanel;
    lbStatus: TLabel;
    cbStatus: TComboBox;
    edPesquisar: TButtonedEdit;
    lbPesquisa: TLabel;
    btNovo: TButton;
    btFechar: TButton;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    FDMem_Registro: TFDMemTable;
    dsRegistros: TDataSource;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrodt_cadastro: TDateField;
    FDMem_Registrohr_cadastro: TTimeField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_Registrostatus_desc: TStringField;
    lbTipo: TLabel;
    cbTipo: TComboBox;
    procedure btFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure edPesquisarRightButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmProjetos_Cad :TfrmProjetos_Cad;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    procedure OnEdit(Sender :TObject);
    procedure OnExcluir(Sender :TObject);

    procedure Pesquisar;

    function OnShowPopupEvent(APopupName: String): string;
    function OnClosePopupEvent(APopupName: String): string;

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

function frmProjetos:TfrmProjetos;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmProjetos:TfrmProjetos;
begin
  result:= TfrmProjetos(TfrmProjetos.GetInstance);
end;

procedure TfrmProjetos.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProjetos.btNovoClick(Sender: TObject);
var
  FRetorno:Boolean;
begin

  Gestao_Financeira.Projeto_Status_Tab := '';
  Gestao_Financeira.Projeto_Status_Tab := 'Insert';

  ShowPopupModal('Popup' + FfrmProjetos_Cad.Name);

end;

procedure TfrmProjetos.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmProjetos.edPesquisarRightButtonClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmProjetos.ExportD2Bridge;
begin
  inherited;

  Title:= 'Projetos';

  //OnShowPopup:= OnShowPopupEvent;
  //OnClosePopup:= OnClosePopupEvent;

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmProjetos_Cad := TfrmProjetos_Cad.Create(Self);
  D2Bridge.AddNested(FfrmProjetos_Cad);

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

    with Popup('Popup' + FfrmProjetos_Cad.Name,'Cadastro de Projetos',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmProjetos_Cad);

  end;

end;

procedure TfrmProjetos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caNone;
end;

procedure TfrmProjetos.FormCreate(Sender: TObject);
begin
  cbStatus.ItemIndex := 1;

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');
end;

procedure TfrmProjetos.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmProjetos.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

function TfrmProjetos.OnClosePopupEvent(APopupName: String): string;
begin

end;

procedure TfrmProjetos.OnEdit(Sender: TObject);
var
  FRetorno :Boolean;
begin
  Gestao_Financeira.Projeto_Status_Tab := '';
  Gestao_Financeira.Projeto_Status_Tab := 'Edit';
  ShowPopupModal('Popup' + FfrmProjetos_Cad.Name);
end;

procedure TfrmProjetos.OnExcluir(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir o Projeto selecionado?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(Gestao_Financeira.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(Gestao_Financeira.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('projeto')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

function TfrmProjetos.OnShowPopupEvent(APopupName: String): string;
begin

end;

procedure TfrmProjetos.Pesquisar;
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
                 .Resource('projeto')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam('status',cbStatus.ItemIndex.ToString)
                 .Resource('projeto')
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
            FDMem_Registrodescricao.AsString := FBody.Get(x).GetValue<String>('descricao','');
            FDMem_Registrostatus.AsInteger := FBody.Get(x).GetValue<Integer>('status',-1);
            FDMem_Registrostatus_desc.AsString := FBody.Get(x).GetValue<String>('statusDesc','');
            FDMem_Registrodt_cadastro.AsDateTime := TFuncoes.StringParaData(FBody.Get(x).GetValue<String>('dtCadastro',''));
            FDMem_Registrohr_cadastro.AsDateTime := TFuncoes.StringParaHora(FBody.Get(x).GetValue<String>('hrCadastro',''));
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

procedure TfrmProjetos.PopupClosed(const AName: String);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmProjetos.PopupOpened(AName: String);
begin
  inherited;
  if Gestao_Financeira.Projeto_Status_Tab = 'Insert' then
    FfrmProjetos_Cad.cbstatus.ItemIndex := 1
  else if Gestao_Financeira.Projeto_Status_Tab = 'Edit' then
  begin
    FfrmProjetos_Cad.edid.Text := FDMem_Registro.FieldByName('id').AsString;
    FfrmProjetos_Cad.eddescricao.Text := FDMem_Registro.FieldByName('descricao').AsString;
    FfrmProjetos_Cad.cbstatus.ItemIndex := FDMem_Registro.FieldByName('status').AsInteger;
  end;
end;

procedure TfrmProjetos.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmProjetos.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.