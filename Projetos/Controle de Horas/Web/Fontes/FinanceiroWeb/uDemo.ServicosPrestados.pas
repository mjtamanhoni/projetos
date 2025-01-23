unit uDemo.ServicosPrestados;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms,
  DateUtils,
  uCon.Cliente,

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,
  uPrincipal,

  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin;

type
  TfrmDemo_ServicosPrestados = class(TfrmPrincipal)
    pnFiltro: TPanel;
    lbFiltro_Cliente: TLabel;
    lbFiltro_Data_I: TLabel;
    lbFiltro_Data_F: TLabel;
    edFiltro_DataI: TDateTimePicker;
    edFiltro_DataF: TDateTimePicker;
    btFiltro_Filtrar: TButton;
    ImageList: TImageList;
    edFiltro_Cliente_ID: TButtonedEdit;
    btFiltro_LocCli: TButton;
    pnCards: TPanel;
    lbHr_Trab_Tit: TLabel;
    lbHr_Trab_Hr: TLabel;
    lbHr_Trab_Vlr: TLabel;
    lbHr_Acul_Tit: TLabel;
    lbHr_Acul_Hr: TLabel;
    lbHr_Acul_Vlr: TLabel;
    lbHr_Tot_Tit: TLabel;
    lbHr_Tot_Hr: TLabel;
    lbHr_Tot_Vlr: TLabel;
    lbHr_Pagas_Tit: TLabel;
    lbHr_Pagas_Vlr: TLabel;
    lbHr_Pagas_Hr: TLabel;
    FDMem_Registro: TFDMemTable;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_RegistroidEmpresa: TIntegerField;
    FDMem_RegistroidPrestadorServico: TIntegerField;
    FDMem_RegistroidCliente: TIntegerField;
    FDMem_RegistroidTabela: TIntegerField;
    FDMem_RegistroidConta: TIntegerField;
    FDMem_Registrodata: TDateField;
    FDMem_RegistrohrInicio: TStringField;
    FDMem_RegistrohrFim: TStringField;
    FDMem_RegistrohrTotal: TStringField;
    FDMem_RegistrovlrHora: TFloatField;
    FDMem_RegistrosubTotal: TFloatField;
    FDMem_Registrodesconto: TFloatField;
    FDMem_RegistrodescontoMotivo: TStringField;
    FDMem_Registroacrescimo: TFloatField;
    FDMem_RegistroacrescimoMotivo: TStringField;
    FDMem_Registrototal: TFloatField;
    FDMem_Registroobservacao: TStringField;
    FDMem_RegistrodtPago: TStringField;
    FDMem_RegistrovlrPago: TFloatField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TDateField;
    FDMem_RegistroidUsuario: TIntegerField;
    FDMem_RegistrostatusDesc: TStringField;
    FDMem_Registroempresa: TStringField;
    FDMem_RegistroprestadorServico: TStringField;
    FDMem_Registrocliente: TStringField;
    FDMem_RegistrotabelaPreco: TStringField;
    FDMem_RegistrotipoTabela: TIntegerField;
    FDMem_RegistrotipoTabelaDesc: TStringField;
    FDMem_Registroconta: TStringField;
    FDMem_RegistrotipoConta: TIntegerField;
    FDMem_RegistrotipoContaDesc: TStringField;
    FDMem_Registroseq: TIntegerField;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    procedure btFiltro_FiltrarClick(Sender: TObject);
    procedure btFiltro_LocCliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FfrmCon_Cliente :TfrmCon_Cliente;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    function HoraStrToTime(AHora:String):TTime;
    procedure AbreFormConCliente;

  public
    procedure Pesquisar;
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmDemo_ServicosPrestados:TfrmDemo_ServicosPrestados;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmDemo_ServicosPrestados:TfrmDemo_ServicosPrestados;
begin
  result:= TfrmDemo_ServicosPrestados(TfrmDemo_ServicosPrestados.GetInstance);
end;

procedure TfrmDemo_ServicosPrestados.btFiltro_FiltrarClick(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmDemo_ServicosPrestados.btFiltro_LocCliClick(Sender: TObject);
begin
  inherited;
  AbreFormConCliente;
end;

procedure TfrmDemo_ServicosPrestados.ExportD2Bridge;
begin
  inherited;

  Title:= 'Demonstrativo dos Serviços Prestados';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= 'dashboard.html';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'dashboard.html';

  //Configurações do Form Popup
  FfrmCon_Cliente := TfrmCon_Cliente.Create(Self);
  D2Bridge.AddNested(FfrmCon_Cliente);

  with D2Bridge.Items.add do
  begin
    VCLObj(edFiltro_Cliente_ID);
    VCLObj(edFiltro_DataI);
    VCLObj(edFiltro_DataF);
    VCLObj(btFiltro_Filtrar);

    VCLObj(lbHr_Trab_Hr);
    VCLObj(lbHr_Trab_Vlr);
    VCLObj(lbHr_Acul_Hr);
    VCLObj(lbHr_Acul_Vlr);
    VCLObj(lbHr_Tot_Hr);
    VCLObj(lbHr_Tot_Vlr);
    VCLObj(lbHr_Pagas_Hr);
    VCLObj(lbHr_Pagas_Vlr);

    VCLObj(DBGrid);

    //Popup
    with Popup('PopupConCliente','Cadastro de Cliente',False,CSSClass.Popup.Large).Items.Add do
      Nested(FfrmCon_Cliente);

  end;

end;

procedure TfrmDemo_ServicosPrestados.FormCreate(Sender: TObject);
begin
  inherited;
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

  edFiltro_DataI.Date := StartOfTheMonth(Now);
  edFiltro_DataF.Date := EndOfTheMonth(Now);

end;

function TfrmDemo_ServicosPrestados.HoraStrToTime(AHora: String): TTime;
begin
  try
    if Length(AHora) = 12 then
      Result := StrToTimeDef(Copy(AHora,1,2) + ':' + Copy(AHora,4,2) + Copy(AHora,7,2),0);

  except on E: Exception do
    raise Exception.Create('Erro ao converter Texto em Hora');
  end;

end;

procedure TfrmDemo_ServicosPrestados.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage := 8;
   //PrismControl.AsDBGrid.MaxRecords:= 2000;
  end;

  edFiltro_DataI.Date := StartOfTheMonth(Now);
  edFiltro_DataF.Date := EndOfTheMonth(Now);

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

procedure TfrmDemo_ServicosPrestados.Pesquisar;
var
  FResp :IResponse;
  FBody :TJSONObject;
  FBody_VlrCliente :TJSONObject;
  FBody_VlrMesAnterior :TJSONObject;
  FBody_VlrMesAtual :TJSONObject;
  FBodFBody_VlrMesAtualy_VlrTotal :TJSONObject;
  FBody_Lancamentos :TJSONArray;

  FData_I :String;
  FData_F :String;

  x:Integer;
begin
  try
    try

      FData_I := '';
      FData_F := '';

      FDMem_Registro.Active := False;
      FDMem_Registro.Active := True;
      FDMem_Registro.DisableControls;


      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if Trim(FinanceiroWeb.Usuario_Token) = '' then
        raise Exception.Create('Token do Usuário inválido');

      FData_I := FormatDateTime('DD-MM-YYYY',edFiltro_DataI.Date);
      FData_F := FormatDateTime('DD-MM-YYYY',edFiltro_DataF.Date);

      if Trim(FData_I) = '' then
        raise Exception.Create('Data inicial é obrigatória');
      if Trim(FData_F) = '' then
        raise Exception.Create('Data final é obrigatória');
      if edFiltro_Cliente_ID.Tag = 0 then
        raise Exception.Create('Cliente é  obrigatório');

      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .AddParam('cliente',edFiltro_Cliente_ID.Tag.ToString)
               .AddParam('dataI',FData_I)
               .AddParam('dataF',FData_F)
               .Resource('servicosPrestados/apresentacao')
               .Accept('application/json')
               .Get;

      if FResp.StatusCode = 200 then
      begin
        if FResp.Content = '' then
          raise Exception.Create('Registros não localizados');

        FBody := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(FResp.Content),0) as TJSONObject;

        {$Region 'Valores do Mês Anterior'}
          FBody_VlrMesAnterior := FBody.GetValue<TJSONObject>('valoresMesAnterior',Nil);
          lbHr_Acul_Hr.Caption := FBody_VlrMesAnterior.GetValue<String>('hora','00:00:00');
          lbHr_Acul_Vlr.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAnterior.GetValue<Double>('valor',0));
        {$EndRegion 'Valores do Mês Anterior'}

        {$Region 'Valores do Mês Atual'}
          FBody_VlrMesAtual := FBody.GetValue<TJSONObject>('valoresMesAtual',Nil);
          lbHr_Trab_Hr.Caption := FBody_VlrMesAtual.GetValue<String>('horas','00:00:00');
          lbHr_Trab_Vlr.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAtual.GetValue<Double>('valor',0));
        {$EndRegion 'Valores do Mês Atual'}

        {$Region 'Total'}
          FBody_VlrMesAtual := FBody.GetValue<TJSONObject>('totais',Nil);
          lbHr_Tot_Hr.Caption := FBody_VlrMesAtual.GetValue<String>('horas','00:00:00');
          lbHr_Tot_Vlr.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAtual.GetValue<Double>('valor',0));
        {$EndRegion 'Total'}

        {$Region 'Lançamentos'}
          FBody_Lancamentos := FBody.GetValue<TJSONArray>('lancamentos',Nil);
          for x := 0 to FBody_Lancamentos.Size - 1 do
          begin
            FDMem_Registro.Insert;
              FDMem_Registroseq.AsInteger := x;
              FDMem_Registroid.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('id',0);
              FDMem_Registrodescricao.AsString := FBody_Lancamentos.Get(x).GetValue<String>('descricao','');
              FDMem_Registrostatus.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('status',1);
              FDMem_RegistroidEmpresa.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('idEmpresa',0);
              FDMem_RegistroidPrestadorServico.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('idPrestadorServico',0);
              FDMem_RegistroidCliente.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('idCliente',0);
              FDMem_RegistroidTabela.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('idTabela',0);
              FDMem_RegistroidConta.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('idConta',0);
              FDMem_Registrodata.AsDateTime := FBody_Lancamentos.Get(x).GetValue<TDate>('dtRegistro',0);
              FDMem_RegistrohrInicio.AsString := Copy(FBody_Lancamentos.Get(x).GetValue<String>('hrInicio',''),1,8);
              FDMem_RegistrohrFim.AsString := Copy(FBody_Lancamentos.Get(x).GetValue<String>('hrFim',''),1,8);
              FDMem_RegistrohrTotal.AsString := FBody_Lancamentos.Get(x).GetValue<String>('hrTotal','');
              FDMem_RegistrovlrHora.AsFloat := FBody_Lancamentos.Get(x).GetValue<Double>('vlrHora',0);
              FDMem_RegistrosubTotal.AsFloat := FBody_Lancamentos.Get(x).GetValue<Double>('subTotal',0);
              FDMem_Registrodesconto.AsFloat := FBody_Lancamentos.Get(x).GetValue<Double>('desconto',0);
              FDMem_RegistrodescontoMotivo.AsString := FBody_Lancamentos.Get(x).GetValue<String>('descontoMotivo','');
              FDMem_Registroacrescimo.AsFloat := FBody_Lancamentos.Get(x).GetValue<Double>('acrescimo',0);
              FDMem_RegistroacrescimoMotivo.AsString := FBody_Lancamentos.Get(x).GetValue<String>('acrescimoMotivo','');
              FDMem_Registrototal.AsFloat := FBody_Lancamentos.Get(x).GetValue<Double>('total',0);
              FDMem_Registroobservacao.AsString := FBody_Lancamentos.Get(x).GetValue<String>('observacao','');
              FDMem_RegistrodtPago.AsDateTime := FBody_Lancamentos.Get(x).GetValue<TDate>('dtPago',0);
              FDMem_RegistrovlrPago.AsFloat := FBody_Lancamentos.Get(x).GetValue<Double>('vlrPago',0);
              FDMem_RegistrodtCadastro.AsDateTime := FBody_Lancamentos.Get(x).GetValue<TDate>('dtCadastro',0);
              FDMem_RegistrohrCadastro.AsDateTime := HoraStrToTime(FBody_Lancamentos.Get(x).GetValue<String>('hrCadastro',''));
              FDMem_RegistroidUsuario.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('idUsuario',0);
              FDMem_RegistrostatusDesc.AsString := FBody_Lancamentos.Get(x).GetValue<String>('statusDesc','');
              FDMem_Registroempresa.AsString := FBody_Lancamentos.Get(x).GetValue<String>('empresa','');
              FDMem_RegistroprestadorServico.AsString := FBody_Lancamentos.Get(x).GetValue<String>('prestadorServico','');
              FDMem_Registrocliente.AsString := FBody_Lancamentos.Get(x).GetValue<String>('cliente','');
              FDMem_RegistrotabelaPreco.AsString := FBody_Lancamentos.Get(x).GetValue<String>('tabelaPreco','');
              FDMem_RegistrotipoTabela.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('tipoTabela',0);
              FDMem_RegistrotipoTabelaDesc.AsString := FBody_Lancamentos.Get(x).GetValue<String>('tipoTabelaDesc','');
              FDMem_Registroconta.AsString := FBody_Lancamentos.Get(x).GetValue<String>('conta','');
              FDMem_RegistrotipoConta.AsInteger := FBody_Lancamentos.Get(x).GetValue<Integer>('tipoConta',0);
              FDMem_RegistrotipoContaDesc.AsString := FBody_Lancamentos.Get(x).GetValue<String>('tipoContaDesc','');
            FDMem_Registro.Post;
          end;
      {$EndRegion 'Lançamentos'}
      end
      else
      begin
        ShowMessage(FResp.StatusCode.ToString + ' - ' + FResp.Content,True,True,10000);
      end;

    except on E: Exception do
      ShowMessage(E.Message,True,True,10000);
    end;
  finally
    FDMem_Registro.EnableControls;
  end;
end;

procedure TfrmDemo_ServicosPrestados.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmDemo_ServicosPrestados.AbreFormConCliente;
begin
  ShowPopupModal('PopupConCliente');
  if FinanceiroWeb.Cliente_ID > 0 then
  begin
    edFiltro_Cliente_ID.Tag := FinanceiroWeb.Cliente_ID;
    edFiltro_Cliente_ID.Text := FinanceiroWeb.Cliente_Nome;
  end;
end;

end.