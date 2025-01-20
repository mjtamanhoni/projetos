unit uCad.Forma.Cond.Add;

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
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmFormaCond_Add = class(TD2BridgeForm)
    DBGrid: TDBGrid;
    pnFiltros: TPanel;
    lbTipo: TLabel;
    lbPesquisar: TLabel;
    cbTipo: TComboBox;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    pnFooter: TPanel;
    btConfirmar: TButton;
    FDMem_Registro: TFDMemTable;
    dmRegistro: TDataSource;
    btCancelar: TButton;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroPARCELAS: TIntegerField;
    FDMem_RegistroTIPO_INTERVALO: TIntegerField;
    FDMem_RegistroINTEVALOR: TIntegerField;
    FDMem_RegistroTIPO_INTERVALO_DESC: TStringField;
    procedure btConfirmarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
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

function frmFormaCond_Add:TfrmFormaCond_Add;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmFormaCond_Add:TfrmFormaCond_Add;
begin
  result:= TfrmFormaCond_Add(TfrmFormaCond_Add.GetInstance);
end;

procedure TfrmFormaCond_Add.btCancelarClick(Sender: TObject);
begin
  ControleHoras.Cond_Pagto_ID := 0;
  ControleHoras.Cond_Pagto_Nome := '';
  Close;

end;

procedure TfrmFormaCond_Add.btConfirmarClick(Sender: TObject);
begin
  ControleHoras.Cond_Pagto_ID := FDMem_RegistroID.AsInteger;
  ControleHoras.Cond_Pagto_Nome := FDMem_RegistroDESCRICAO.AsString;
  Close;
end;

procedure TfrmFormaCond_Add.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmFormaCond_Add.ExportD2Bridge;
begin
  inherited;

  Title:= 'Condições de Pagamento';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with D2Bridge.Items.add do
  begin
    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbTipo.Caption,CSSClass.Col.colsize3).AddVCLObj(cbTipo);
        FormGroup(lbPesquisar.Caption,CSSClass.Col.colsize6).AddVCLObj(edPesquisar);

        FormGroup('',CSSClass.Col.colsize3).AddVCLObj(btPesquisar,CSSClass.Button.search);
      end;
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        with Row(CSSClass.DivHtml.Align_Center).Items.Add do
        begin
          VCLObj(btConfirmar, CSSClass.Button.close + CSSClass.Col.colsize3);
          VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize3);
        end;
      end;
    end;
  end;

end;

procedure TfrmFormaCond_Add.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmFormaCond_Add.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmFormaCond_Add.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmFormaCond_Add.Pesquisar;
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

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    if Trim(FTipoPesquisa) <> '' then
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .AddParam(FTipoPesquisa,edPesquisar.Text)
               .Resource('condicaoPagto')
               .Accept('application/json')
               .Get;
    end
    else
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .Resource('condicaoPagto')
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
          FDMem_RegistroPARCELAS.AsInteger := FBody.Get(x).GetValue<Integer>('parcelas',0);
          FDMem_RegistroTIPO_INTERVALO.AsInteger := FBody.Get(x).GetValue<Integer>('tipoIntervalo',0);
          FDMem_RegistroINTEVALOR.AsInteger := FBody.Get(x).GetValue<Integer>('intevalor',0);
          FDMem_RegistroTIPO_INTERVALO_DESC.AsString := FBody.Get(x).GetValue<String>('tipoIntervaloDesc','');
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

procedure TfrmFormaCond_Add.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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