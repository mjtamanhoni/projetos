unit uUnidadeFederativa.Loc;

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
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmUnidadeFederativa_Loc = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_RegistroidRegiao: TIntegerField;
    FDMem_Registroibge: TIntegerField;
    FDMem_Registrosigla: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrocapital: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistronomeRegiao: TStringField;
    dsRegistros: TDataSource;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    pnHeader: TPanel;
    lbStatus: TLabel;
    lbPesquisa: TLabel;
    lbTipo: TLabel;
    cbStatus: TComboBox;
    edPesquisar: TButtonedEdit;
    cbTipo: TComboBox;
    btConfirmar: TButton;
    btCancelar: TButton;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure edPesquisarRightButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

function frmUnidadeFederativa_Loc:TfrmUnidadeFederativa_Loc;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmUnidadeFederativa_Loc:TfrmUnidadeFederativa_Loc;
begin
  result:= TfrmUnidadeFederativa_Loc(TfrmUnidadeFederativa_Loc.GetInstance);
end;

procedure TfrmUnidadeFederativa_Loc.btCancelarClick(Sender: TObject);
begin
  {$Region 'Retornando valores'}
    Gestao_Financeira.UF_Id := 0;
    Gestao_Financeira.UF_IdRegiao := 0;
    Gestao_Financeira.UF_IBGE := 0;
    Gestao_Financeira.UF_Sigla := '';
    Gestao_Financeira.UF_Descricao := '';
    Gestao_Financeira.UF_Capital := '';
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmUnidadeFederativa_Loc.btConfirmarClick(Sender: TObject);
begin
  {$Region 'Retornando valores'}
    Gestao_Financeira.UF_Id := FDMem_Registroid.AsInteger;
    Gestao_Financeira.UF_IdRegiao := FDMem_RegistroidRegiao.AsInteger;
    Gestao_Financeira.UF_IBGE := FDMem_Registroibge.AsInteger;
    Gestao_Financeira.UF_Sigla := FDMem_Registrosigla.AsString;
    Gestao_Financeira.UF_Descricao := FDMem_Registrodescricao.AsString;
    Gestao_Financeira.UF_Capital := FDMem_Registrocapital.AsString;
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmUnidadeFederativa_Loc.edPesquisarRightButtonClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmUnidadeFederativa_Loc.ExportD2Bridge;
begin
  inherited;

  Title:= 'Localiza Unidade Federativa';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize12).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom2).Items.Add do
        begin
          FormGroup('',CssClass.Col.colsize3).AddVCLObj(cbTipo);
          With FormGroup('',CSSClass.Col.colsize9).Items.Add do
            VCLObj(edPesquisar);
        end;
      end;
    end;

    with Row.Items.Add do
    begin
      with PanelGroup('Listagem','',False,CSSClass.Col.colsize12).Items.Add do
      begin
        VCLObj(DBGrid_Registros);
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

procedure TfrmUnidadeFederativa_Loc.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');


end;

procedure TfrmUnidadeFederativa_Loc.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmUnidadeFederativa_Loc.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmUnidadeFederativa_Loc.Pesquisar;
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

procedure TfrmUnidadeFederativa_Loc.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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