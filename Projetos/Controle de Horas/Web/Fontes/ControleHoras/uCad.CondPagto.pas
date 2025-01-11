unit uCad.CondPagto;

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

  uCad.CondPagto.Add;

type
  TfrmCad_CondPagto = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    pnFooter: TPanel;
    btNovo: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    pnHeader: TPanel;
    lbTipo: TLabel;
    lbPesquisar: TLabel;
    cbTipo: TComboBox;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroPARCELAS: TIntegerField;
    FDMem_RegistroTIPO_INTERVALO: TIntegerField;
    FDMem_RegistroINTEVALOR: TIntegerField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroTIPO_INTERVALO_DESC: TStringField;
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmCad_CondPagto_Add :TfrmCad_CondPagto_Add;

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

function frmCad_CondPagto:TfrmCad_CondPagto;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_CondPagto:TfrmCad_CondPagto;
begin
  result:= TfrmCad_CondPagto(TfrmCad_CondPagto.GetInstance);
end;

procedure TfrmCad_CondPagto.btEditarClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_CondPagto_Add.edID.Text := FDMem_RegistroID.AsString;
    FfrmCad_CondPagto_Add.edDESCRICAO.Text := FDMem_RegistroDESCRICAO.AsString;
    FfrmCad_CondPagto_Add.cbTIPO_INTERVALO.ItemIndex := FDMem_RegistroTIPO_INTERVALO.AsInteger;
    FfrmCad_CondPagto_Add.edINTEVALOR.Text := IntToStr(FDMem_RegistroINTEVALOR.AsInteger);
    FfrmCad_CondPagto_Add.edPARCELAS.Text := IntToStr(FDMem_RegistroPARCELAS.AsInteger);
    FfrmCad_CondPagto_Add.Status_Tabela := 1;

    ShowPopupModal('PopupCadCondPagtoAdd');
  end
  else
  begin
    FfrmCad_CondPagto_Add := TfrmCad_CondPagto_Add.Create(Self);
    FfrmCad_CondPagto_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_CondPagto.btExcluirClick(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir a Condiçãod e Pagamento selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(ControleHoras.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('condicaoPagto')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmCad_CondPagto.btNovoClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_CondPagto_Add.FDMem_Registro.Active := False;
    FfrmCad_CondPagto_Add.FDMem_Registro.Active := True;

    FfrmCad_CondPagto_Add.edID.Text := '';
    FfrmCad_CondPagto_Add.edDESCRICAO.Text := '';
    FfrmCad_CondPagto_Add.cbTIPO_INTERVALO.Text := '';
    FfrmCad_CondPagto_Add.cbTIPO_INTERVALO.ItemIndex := -1;
    FfrmCad_CondPagto_Add.edPARCELAS.Text := '';
    FfrmCad_CondPagto_Add.edINTEVALOR.Text := '';
    FfrmCad_CondPagto_Add.Status_Tabela := 0;

    ShowPopupModal('PopupCadCondPagtoAdd')
  end
  else
  begin
    FfrmCad_CondPagto_Add := TfrmCad_CondPagto_Add.Create(Self);
    FfrmCad_CondPagto_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_CondPagto.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_CondPagto.ExportD2Bridge;
begin
  inherited;

  Title:= 'Condições de Pagamento';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmCad_CondPagto_Add := TfrmCad_CondPagto_Add.Create(Self);
  D2Bridge.AddNested(FfrmCad_CondPagto_Add);

  with D2Bridge.Items.add do
  begin
    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbTipo.Caption,CSSClass.Col.colsize1).AddVCLObj(cbTipo);
        FormGroup(lbPesquisar.Caption,CSSClass.Col.colsize6).AddVCLObj(edPesquisar);

        FormGroup('',CSSClass.Col.colsize2).AddVCLObj(btPesquisar,CSSClass.Button.search);
      end;
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    with Card.Items.Add do
    begin
      with Row(CSSClass.DivHtml.Align_Left).Items.Add do
      begin
        VCLObj(btNovo,CSSClass.Button.add + CSSClass.Col.colsize1);
        VCLObj(btEditar,CSSClass.Button.edit + CSSClass.Col.colsize1);
        VCLObj(btExcluir,CSSClass.Button.delete + CSSClass.Col.colsize1);
      end;
    end;

    //Abrindo formulário popup
    with Popup('PopupCadCondPagtoAdd','Cadastro de Condições de Pagamento').Items.Add do
      Nested(FfrmCad_CondPagto_Add);
  end;

end;

procedure TfrmCad_CondPagto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ControleHoras.Cond_Pagto_ID := 0;
  ControleHoras.Cond_Pagto_Nome := '';
  if not FDMem_Registro.IsEmpty then
  begin
    ControleHoras.Cond_Pagto_ID := FDMem_RegistroID.AsInteger;
    ControleHoras.Cond_Pagto_Nome := FDMem_RegistroDESCRICAO.AsString;
  end;
  Action := CaFree;

end;

procedure TfrmCad_CondPagto.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmCad_CondPagto.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_CondPagto.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_CondPagto.Pesquisar;
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
          FDMem_RegistroDT_CADASTRO.AsDateTime := StrToDateDef(FBody.Get(x).GetValue<String>('dtCadastro',''),Date);
          FDMem_RegistroHR_CADASTRO.AsDateTime := StrToTimeDef(FBody.Get(x).GetValue<String>('hrCadastro',''),Time);
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

procedure TfrmCad_CondPagto.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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