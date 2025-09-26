unit uUnidadeFederativa;

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

  uUnidadeFederativa.Cad;

type
  TfrmUnidadeFederativa = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    dsRegistros: TDataSource;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    pnHeader: TPanel;
    lbStatus: TLabel;
    lbPesquisa: TLabel;
    lbTipo: TLabel;
    cbStatus: TComboBox;
    edPesquisar: TButtonedEdit;
    btNovo: TButton;
    btFechar: TButton;
    cbTipo: TComboBox;
    FDMem_Registroid: TIntegerField;
    FDMem_RegistroidRegiao: TIntegerField;
    FDMem_Registroibge: TIntegerField;
    FDMem_Registrosigla: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrocapital: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistronomeRegiao: TStringField;
    procedure btFecharClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure edPesquisarRightButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmUnidadeFederativa_Cad :TfrmUnidadeFederativa_Cad;

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

function frmUnidadeFederativa:TfrmUnidadeFederativa;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmUnidadeFederativa:TfrmUnidadeFederativa;
begin
  result:= TfrmUnidadeFederativa(TfrmUnidadeFederativa.GetInstance);
end;

procedure TfrmUnidadeFederativa.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUnidadeFederativa.btNovoClick(Sender: TObject);
begin
  Gestao_Financeira.UF_Status_Tab := '';
  Gestao_Financeira.UF_Status_Tab := 'Insert';

  ShowPopupModal('Popup' + FfrmUnidadeFederativa_Cad.Name);

end;

procedure TfrmUnidadeFederativa.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmUnidadeFederativa.edPesquisarRightButtonClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmUnidadeFederativa.ExportD2Bridge;
begin
  inherited;

  Title:= 'Unidades Federativas';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmUnidadeFederativa_Cad := TfrmUnidadeFederativa_Cad.Create(Self);
  D2Bridge.AddNested(FfrmUnidadeFederativa_Cad);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize10 + ' ' + CSSClass.ColorName.beige).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3).Items.Add do
        begin
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

    with Popup('Popup' + FfrmUnidadeFederativa_Cad.Name,'Cadastro de Unidades Federativas',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmUnidadeFederativa_Cad);
  end;

end;

procedure TfrmUnidadeFederativa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caNone;
end;

procedure TfrmUnidadeFederativa.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmUnidadeFederativa.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmUnidadeFederativa.InitControlsD2Bridge(const PrismControl: TPrismControl);
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
    end;
  end;
end;

procedure TfrmUnidadeFederativa.OnEdit(Sender: TObject);
begin
  Gestao_Financeira.UF_Status_Tab := '';
  Gestao_Financeira.UF_Status_Tab := 'Edit';
  ShowPopupModal('Popup' + FfrmUnidadeFederativa_Cad.Name);
end;

procedure TfrmUnidadeFederativa.OnExcluir(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir a Unidade Federativa selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(Gestao_Financeira.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(Gestao_Financeira.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('unidadeFederativa')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmUnidadeFederativa.Pesquisar;
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
        1:FTipoPesquisa := 'nome';
        2:FTipoPesquisa := 'ibge';
        3:FTipoPesquisa := 'sigla';
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
                 .Resource('unidadeFederativa')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .Resource('unidadeFederativa')
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
            FDMem_RegistroidRegiao.AsInteger := FBody.Get(x).GetValue<Integer>('idRegiao',0);
            FDMem_Registroibge.AsInteger := FBody.Get(x).GetValue<Integer>('ibge',0);
            FDMem_Registrosigla.AsString := FBody.Get(x).GetValue<String>('sigla','');
            FDMem_Registrodescricao.AsString := FBody.Get(x).GetValue<String>('descricao','');
            FDMem_Registrocapital.AsString := FBody.Get(x).GetValue<String>('capital','');
            FDMem_RegistronomeRegiao.AsString := FBody.Get(x).GetValue<String>('nomeRegiao','');
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

procedure TfrmUnidadeFederativa.PopupClosed(const AName: String);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmUnidadeFederativa.PopupOpened(AName: String);
begin
  inherited;
  if Gestao_Financeira.UF_Status_Tab = 'Edit' then
  begin
    FfrmUnidadeFederativa_Cad.edid.Text := FDMem_Registro.FieldByName('id').AsString;
    FfrmUnidadeFederativa_Cad.edidRegiao.Text := FDMem_Registro.FieldByName('idRegiao').AsString;
    FfrmUnidadeFederativa_Cad.edidRegiao_Desc.Text := FDMem_Registro.FieldByName('nomeRegiao').AsString;
    FfrmUnidadeFederativa_Cad.edibge.Text := FDMem_Registro.FieldByName('ibge').AsString;
    FfrmUnidadeFederativa_Cad.edsigla.Text := FDMem_Registro.FieldByName('sigla').AsString;
    FfrmUnidadeFederativa_Cad.eddescricao.Text := FDMem_Registro.FieldByName('descricao').AsString;
    FfrmUnidadeFederativa_Cad.edcapital.Text := FDMem_Registro.FieldByName('capital').AsString;
  end;

end;

procedure TfrmUnidadeFederativa.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmUnidadeFederativa.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.