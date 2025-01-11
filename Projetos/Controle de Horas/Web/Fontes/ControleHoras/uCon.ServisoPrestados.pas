unit uCon.ServisoPrestados;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  DateUtils,
  uCon.Cliente,

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,

  uPrincipal, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCon_ServicosPrestados = class(TfrmPrincipal)
    pnFiltro: TPanel;
    lbFiltro_Cliente: TLabel;
    ImageList: TImageList;
    edFiltro_Cliente_ID: TButtonedEdit;
    edFiltro_Cliente: TEdit;
    lbFiltro_Data_I: TLabel;
    edFiltro_DataI: TDateTimePicker;
    lbFiltro_Data_F: TLabel;
    edFiltro_DataF: TDateTimePicker;
    btFiltro_Filtrar: TButton;
    pnCards: TPanel;
    pnCard_ValoresClienbte: TPanel;
    lbVC_Titulo: TLabel;
    pnCard_MesAnterior: TPanel;
    lbVA_Titulo: TLabel;
    lbMA_HorasAcumuladas: TLabel;
    lbMA_Valor: TLabel;
    pnCard_MesAtual: TPanel;
    lbMAT_Tit: TLabel;
    lbMAT_Horas: TLabel;
    lbMAT_Valor: TLabel;
    pnCard_Totais: TPanel;
    lbT_Titulo: TLabel;
    lbT_Horas: TLabel;
    lbT_Valor: TLabel;
    lbVC_HorasPrevistas: TLabel;
    lbVC_ValorHora: TLabel;
    lbVC_Totais: TLabel;
    lbVC_HorasPrevistas_T: TLabel;
    lbVC_ValorHora_T: TLabel;
    lbVC_Totais_T: TLabel;
    lbMA_HorasAcumuladas_T: TLabel;
    lbMA_Valor_T: TLabel;
    lbMAT_Horas_T: TLabel;
    lbMAT_Valor_T: TLabel;
    lbT_Horas_T: TLabel;
    lbT_Valor_T: TLabel;
    DBGrid: TDBGrid;
    FDMem_Registro: TFDMemTable;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroNOME: TStringField;
    FDMem_RegistroPESSOA: TIntegerField;
    FDMem_RegistroDOCUMENTO: TStringField;
    FDMem_RegistroINSC_EST: TStringField;
    FDMem_RegistroCEP: TStringField;
    FDMem_RegistroENDERECO: TStringField;
    FDMem_RegistroCOMPLEMENTO: TStringField;
    FDMem_RegistroNUMERO: TStringField;
    FDMem_RegistroBAIRRO: TStringField;
    FDMem_RegistroCIDADE: TStringField;
    FDMem_RegistroUF: TStringField;
    FDMem_RegistroTELEFONE: TStringField;
    FDMem_RegistroCELULAR: TStringField;
    FDMem_RegistroEMAIL: TStringField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroPESSOA_DESC: TStringField;
    FDMem_RegistroID_FORNECEDOR: TIntegerField;
    FDMem_RegistroID_TAB_PRECO: TIntegerField;
    FDMem_RegistroFONECEDOR: TStringField;
    FDMem_RegistroTAB_PRECO: TStringField;
    FDMem_RegistroTIPO_TAB_PRECO: TIntegerField;
    FDMem_RegistroTIPO_TAB_PRECO_DESC: TStringField;
    FDMem_RegistroVALOR: TFloatField;
    dmRegistro: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure edFiltro_Cliente_IDRightButtonClick(Sender: TObject);
    procedure btFiltro_FiltrarClick(Sender: TObject);
  private
    FfrmCon_Cliente :TfrmCon_Cliente;

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

function frmCon_ServicosPrestados:TfrmCon_ServicosPrestados;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCon_ServicosPrestados:TfrmCon_ServicosPrestados;
begin
  result:= TfrmCon_ServicosPrestados(TfrmCon_ServicosPrestados.GetInstance);
end;

procedure TfrmCon_ServicosPrestados.btFiltro_FiltrarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmCon_ServicosPrestados.Pesquisar;
var
  FResp :IResponse;
  FBody :TJSONArray;
  x:Integer;
begin
  try
    try

    FDMem_Registro.Active := False;
    FDMem_Registro.Active := True;
    FDMem_Registro.DisableControls;


    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(ControleHoras.Usuario_Token)
             .AddParam('',edFiltro_Cliente_ID.Text)
             .Resource('cliente')
             .Accept('application/json')
             .Get;

    if FResp.StatusCode = 200 then
    begin
      if FResp.Content = '' then
        raise Exception.Create('Registros não localizados');

      FBody := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(FResp.Content),0) as TJSONArray;

      for x := 0 to FBody.Size - 1 do
      begin
        FDMem_Registro.Insert;
          FDMem_RegistroID.AsInteger := FBody.Get(x).GetValue<Integer>('id',0);
          FDMem_RegistroNOME.AsString := FBody.Get(x).GetValue<String>('nome','');
          FDMem_RegistroPESSOA.AsInteger := FBody.Get(x).GetValue<Integer>('pessoa',0);
          FDMem_RegistroDOCUMENTO.AsString := FBody.Get(x).GetValue<String>('documento','');
          FDMem_RegistroINSC_EST.AsString := FBody.Get(x).GetValue<String>('inscEst','');
          FDMem_RegistroCEP.AsString := FBody.Get(x).GetValue<String>('cep','');
          FDMem_RegistroENDERECO.AsString := FBody.Get(x).GetValue<String>('endereco','');
          FDMem_RegistroCOMPLEMENTO.AsString := FBody.Get(x).GetValue<String>('complemento','');
          FDMem_RegistroNUMERO.AsString := FBody.Get(x).GetValue<String>('numero','');
          FDMem_RegistroBAIRRO.AsString := FBody.Get(x).GetValue<String>('bairro','');
          FDMem_RegistroCIDADE.AsString := FBody.Get(x).GetValue<String>('cidade','');
          FDMem_RegistroUF.AsString := FBody.Get(x).GetValue<String>('uf','');
          FDMem_RegistroTELEFONE.AsString := FBody.Get(x).GetValue<String>('telefone','');
          FDMem_RegistroCELULAR.AsString := FBody.Get(x).GetValue<String>('celular','');
          FDMem_RegistroEMAIL.AsString := FBody.Get(x).GetValue<String>('email','');
          FDMem_RegistroDT_CADASTRO.AsDateTime := StrToDateDef(FBody.Get(x).GetValue<String>('dtCadastro',''),Date);
          FDMem_RegistroHR_CADASTRO.AsDateTime := StrToTimeDef(FBody.Get(x).GetValue<String>('hrCadastro',''),Time);
          FDMem_RegistroPESSOA_DESC.AsString := FBody.Get(x).GetValue<String>('pessoaDesc','');
          FDMem_RegistroID_FORNECEDOR.AsInteger := FBody.Get(x).GetValue<Integer>('idFornecedor',0);
          FDMem_RegistroID_TAB_PRECO.AsInteger := FBody.Get(x).GetValue<Integer>('idTabPreco',0);
          FDMem_RegistroFONECEDOR.AsString := FBody.Get(x).GetValue<String>('fornecedor','');
          FDMem_RegistroTAB_PRECO.AsString := FBody.Get(x).GetValue<String>('tabPreco','');
          FDMem_RegistroTIPO_TAB_PRECO.AsInteger := FBody.Get(x).GetValue<Integer>('tipoTabPreco',0);
          FDMem_RegistroTIPO_TAB_PRECO_DESC.AsString := FBody.Get(x).GetValue<String>('tipoTabPrecoDesc','');
          FDMem_RegistroVALOR.AsFloat := FBody.Get(x).GetValue<Double>('valor',0);
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

procedure TfrmCon_ServicosPrestados.edFiltro_Cliente_IDRightButtonClick(Sender: TObject);
begin
  inherited;
  ShowPopupModal('PopupConCliente');
  if ControleHoras.Cliente_ID > 0 then
  begin
    edFiltro_Cliente_ID.Text := IntToStr(ControleHoras.Cliente_ID);
    edFiltro_Cliente.Text := ControleHoras.Cliente_Nome;
  end;
end;

procedure TfrmCon_ServicosPrestados.ExportD2Bridge;
begin
  inherited;

  Title:= 'Serviços Prestados';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmCon_Cliente := TfrmCon_Cliente.Create(Self);
  D2Bridge.AddNested(FfrmCon_Cliente);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with card.Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup(lbFiltro_Cliente.Caption,CSSClass.Col.colsize2).AddVCLObj(edFiltro_Cliente_ID);
          FormGroup('',CSSClass.Col.colsize5).AddVCLObj(edFiltro_Cliente);
          FormGroup(lbFiltro_Data_I.Caption,CSSClass.Col.colsize2).AddVCLObj(edFiltro_DataI);
          FormGroup(lbFiltro_Data_F.Caption,CSSClass.Col.colsize2).AddVCLObj(edFiltro_DataF);
          FormGroup('',CSSClass.Col.colsize1).AddVCLObj(btFiltro_Filtrar);
        end;
      end;
    end;

    with Row.Items.Add do
    begin
      with CardGroup do
      begin

        {$Region 'Card 1 - Valores do Cliente'}
         with AddCard do
         begin
            Header(lbVC_Titulo.Caption,CSSClass.Color.warning);
            with Items.Add do
            begin
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbVC_HorasPrevistas);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbVC_HorasPrevistas_T);
              end;
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbVC_ValorHora);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbVC_ValorHora_T);
              end;
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbVC_Totais);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbVC_Totais_T);
              end;
            end;
         end;
        {$EndRegion 'Card 1 - Valores do Cliente'}

        {$Region 'Card 2 - Valores do Mês Anterior'}
         with AddCard do
         begin
            Header(lbVA_Titulo.Caption,CSSClass.Color.secondary);
            with Items.Add do
            begin
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbMA_HorasAcumuladas);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbMA_HorasAcumuladas_T);
              end;
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbMA_Valor);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbMA_Valor_T);
              end;
            end;
         end;
        {$EndRegion 'Card  - Valores do Mês Anterior'}

        {$Region 'Card 3 - Valores do Mês Atual'}
         with AddCard do
         begin
            Header(lbMAT_Tit.Caption,CSSClass.Color.success);
            with Items.Add do
            begin
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbMAT_Horas);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbMAT_Horas_T);
              end;
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbMAT_Valor);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbMAT_Valor_T);
              end;
            end;
         end;
        {$EndRegion 'Card 3 - Valores do Mês atual'}

        {$Region 'Card 4 - Totais'}
         with AddCard do
         begin
            Header(lbT_Titulo.Caption,CSSClass.Color.info);
            with Items.Add do
            begin
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbT_Horas);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbT_Horas_T);
              end;
              with Row(CSSClass.Space.gutter2).Items.add do
              begin
                ColAuto(CSSClass.Col.colsize3).Add.VCLObj(lbT_Valor);
                ColAuto(CSSClass.Col.colsize9).Add.VCLObj(lbT_Valor_T);
              end;
            end;
         end;
        {$EndRegion 'Card 4 - Totais'}
      end;

    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    //Popup
    with Popup('PopupConCliente','Cadastro de Cliente').Items.Add do
      Nested(FfrmCon_Cliente);

  end;
end;

procedure TfrmCon_ServicosPrestados.FormCreate(Sender: TObject);
begin
  inherited;
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

  edFiltro_DataI.Date := StartOfTheMonth(Now);
  edFiltro_DataF.Date := EndOfTheMonth(Now);


  lbVA_Titulo.Font.Color := clWhite;
end;

procedure TfrmCon_ServicosPrestados.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

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

procedure TfrmCon_ServicosPrestados.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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