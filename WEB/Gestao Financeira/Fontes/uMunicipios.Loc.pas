unit uMunicipios.Loc;

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
  TfrmMunicipios_Loc = class(TD2BridgeForm)
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_RegistroidUf: TIntegerField;
    FDMem_RegistrosiglaUf: TStringField;
    FDMem_Registroibge: TIntegerField;
    FDMem_RegistrocepPadrao: TStringField;
    FDMem_Registrodescricao: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrounidadeFederativa: TStringField;
    FDMem_Registroregiao: TStringField;
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

function frmMunicipios_Loc:TfrmMunicipios_Loc;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmMunicipios_Loc:TfrmMunicipios_Loc;
begin
  result:= TfrmMunicipios_Loc(TfrmMunicipios_Loc.GetInstance);
end;

procedure TfrmMunicipios_Loc.btCancelarClick(Sender: TObject);
begin
  {$Region 'Retornando valores'}
    Gestao_Financeira.Mun_Id := 0;
    Gestao_Financeira.Mun_IdUF := 0;
    Gestao_Financeira.Mun_SilaUF := '';
    Gestao_Financeira.Mun_IBGE := 0;
    Gestao_Financeira.Mun_CepPadrao := '';
    Gestao_Financeira.Mun_Descricao := '';
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmMunicipios_Loc.btConfirmarClick(Sender: TObject);
begin
  {$Region 'Retornando valores'}
    Gestao_Financeira.Mun_Id := FDMem_Registroid.AsInteger;
    Gestao_Financeira.Mun_IdUF := FDMem_RegistroidUf.AsInteger;
    Gestao_Financeira.Mun_SilaUF := FDMem_RegistrosiglaUf.AsString;
    Gestao_Financeira.Mun_IBGE := FDMem_Registroibge.AsInteger;
    Gestao_Financeira.Mun_CepPadrao := FDMem_RegistrocepPadrao.AsString;
    Gestao_Financeira.Mun_Descricao := FDMem_Registrodescricao.AsString;
  {$Region 'Retornando valores'}

  Close;

end;

procedure TfrmMunicipios_Loc.edPesquisarRightButtonClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmMunicipios_Loc.ExportD2Bridge;
begin
  inherited;

  Title:= 'Localiza Município';

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

procedure TfrmMunicipios_Loc.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmMunicipios_Loc.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmMunicipios_Loc.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmMunicipios_Loc.Pesquisar;
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
        3:FTipoPesquisa := 'regiao';
        4:FTipoPesquisa := 'ufSigla';
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
                 .Resource('municipio')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .Resource('municipio')
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
            FDMem_RegistroidUf.AsInteger := FBody.Get(x).GetValue<Integer>('idUf',0);
            FDMem_RegistrosiglaUf.AsString := FBody.Get(x).GetValue<String>('siglaUf','');
            FDMem_Registroibge.AsInteger := FBody.Get(x).GetValue<Integer>('ibge',0);
            FDMem_RegistrocepPadrao.AsString := FBody.Get(x).GetValue<String>('cepPadrao','');
            FDMem_Registrodescricao.AsString := FBody.Get(x).GetValue<String>('descricao','');
            FDMem_RegistrodtCadastro.AsDateTime := TFuncoes.StringParaData(FBody.Get(x).GetValue<String>('dtCadastro',''));
            FDMem_RegistrohrCadastro.AsDateTime := TFuncoes.StringParaHora(FBody.Get(x).GetValue<String>('hrCadastro',''));
            FDMem_RegistrounidadeFederativa.AsString := FBody.Get(x).GetValue<String>('unidadeFederativa','');
            FDMem_Registroregiao.AsString := FBody.Get(x).GetValue<String>('regiao','');
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

procedure TfrmMunicipios_Loc.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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