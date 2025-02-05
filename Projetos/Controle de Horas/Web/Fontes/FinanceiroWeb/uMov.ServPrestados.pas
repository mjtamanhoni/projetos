unit uMov.ServPrestados;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.ImageList, Vcl.ImgList,
  DateUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin,

  //D2BridgeFormTemplate,
  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,
  uFuncoes.Wnd,

  uPrincipal,
  uCon.Cliente,
  uCon.PrestServicos,
  uMov.ServPrestados.Add;

type
  TfrmMov_ServPrestados = class(TfrmPrincipal)
    pnHeader: TPanel;
    pnDetail: TPanel;
    pnFooter: TPanel;
    lbFiltro_Tit: TLabel;
    edData_I: TDateTimePicker;
    edData_F: TDateTimePicker;
    lbCliente: TLabel;
    lbHr_Trab_Tit: TLabel;
    lbHr_Trab_Hr: TLabel;
    lbHr_Trab_Vlr: TLabel;
    lbHr_Acul_Tit: TLabel;
    lbHr_Acul_Hr: TLabel;
    lbHr_Acul_Vlr: TLabel;
    lbHr_Tot_Tit: TLabel;
    lbHr_Tot_Hr: TLabel;
    lbHr_Tot_Vlr: TLabel;
    btExcluir: TButton;
    btEditar: TButton;
    btNovo: TButton;
    btFechar: TButton;
    FDMem_Registro: TFDMemTable;
    FDMem_Registrodata: TDateField;
    FDMem_RegistrohrInicio: TStringField;
    FDMem_RegistrohrFim: TStringField;
    FDMem_RegistrohrTotal: TStringField;
    FDMem_RegistrovlrHora: TFloatField;
    FDMem_RegistrosubTotal: TFloatField;
    FDMem_Registrodesconto: TFloatField;
    FDMem_Registroacrescimo: TFloatField;
    FDMem_Registrototal: TFloatField;
    FDMem_RegistroidConta: TIntegerField;
    FDMem_Registroconta: TStringField;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_RegistroidEmpresa: TIntegerField;
    FDMem_RegistroidPrestadorServico: TIntegerField;
    FDMem_RegistroidCliente: TIntegerField;
    FDMem_RegistroidTabela: TIntegerField;
    FDMem_RegistrodescontoMotivo: TStringField;
    FDMem_RegistroacrescimoMotivo: TStringField;
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
    FDMem_RegistrotipoConta: TIntegerField;
    FDMem_RegistrotipoContaDesc: TStringField;
    FDMem_Registroseq: TIntegerField;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    lbHr_Pagas_Tit: TLabel;
    lbHr_Pagas_Hr: TLabel;
    lbHr_Pagas_Vlr: TLabel;
    ImageList: TImageList;
    edPrestador: TButtonedEdit;
    lbPrestador: TLabel;
    edCliente: TButtonedEdit;
    procedure btFecharClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edData_IChange(Sender: TObject);
    procedure edData_FChange(Sender: TObject);
    procedure edClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edPrestadorKeyPress(Sender: TObject; var Key: Char);
    procedure edPrestadorRightButtonClick(Sender: TObject);
    procedure edClienteRightButtonClick(Sender: TObject);
  private
    FfrmCon_Cliente :TfrmCon_Cliente;
    FfrmCon_PrestServicos :TfrmCon_PrestServicos;
    FfrmMov_ServPrestados_Add :TfrmMov_ServPrestados_Add;
    FFuncoes_Wnd :TFuncoes_Wnd;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    function HoraStrToTime(AHora:String):TTime;

  public
    procedure Pesquisar;
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmMov_ServPrestados:TfrmMov_ServPrestados;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmMov_ServPrestados:TfrmMov_ServPrestados;
begin
  result:= TfrmMov_ServPrestados(TfrmMov_ServPrestados.GetInstance);
end;

procedure TfrmMov_ServPrestados.btEditarClick(Sender: TObject);
begin
  inherited;
  FinanceiroWeb.SP_id := FDMem_Registroid.AsInteger;
  FinanceiroWeb.SP_descricao := FDMem_Registrodescricao.AsString;
  FinanceiroWeb.SP_status := FDMem_Registrostatus.AsInteger;
  FinanceiroWeb.SP_idEmpresa := FDMem_RegistroidEmpresa.AsInteger;
  FinanceiroWeb.SP_idPrestadorServico := FDMem_RegistroidPrestadorServico.AsInteger;
  FinanceiroWeb.SP_idCliente := FDMem_RegistroidCliente.AsInteger;
  FinanceiroWeb.SP_idTabela := FDMem_RegistroidTabela.AsInteger;
  FinanceiroWeb.SP_idConta := FDMem_RegistroidConta.AsInteger;
  FinanceiroWeb.SP_dtRegistro := FDMem_Registrodata.AsDateTime;
  FinanceiroWeb.SP_hrInicio := FFuncoes_Wnd.HoraStrToTime(FDMem_RegistrohrInicio.AsString);
  FinanceiroWeb.SP_hrFim := FFuncoes_Wnd.HoraStrToTime(FDMem_RegistrohrFim.AsString);
  FinanceiroWeb.SP_hrTotal := FDMem_RegistrohrTotal.AsString;
  FinanceiroWeb.SP_vlrHora := FDMem_RegistrovlrHora.AsFloat;
  FinanceiroWeb.SP_subTotal := FDMem_RegistrosubTotal.AsFloat;
  FinanceiroWeb.SP_desconto := FDMem_RegistrosubTotal.AsFloat;
  FinanceiroWeb.SP_descontoMotivo := FDMem_RegistrodescontoMotivo.AsString;
  FinanceiroWeb.SP_acrescimo := FDMem_Registroacrescimo.AsFloat;
  FinanceiroWeb.SP_acrescimoMotivo := FDMem_RegistroacrescimoMotivo.AsString;
  FinanceiroWeb.SP_total := FDMem_Registrototal.AsFloat;
  FinanceiroWeb.SP_observacao := FDMem_RegistrodescontoMotivo.AsString;
  FinanceiroWeb.SP_dtPago := FDMem_RegistrodtPago.AsDateTime;
  FinanceiroWeb.SP_vlrPago := FDMem_RegistrovlrPago.AsFloat;
  FinanceiroWeb.SP_empresa := FDMem_Registroempresa.AsString;
  FinanceiroWeb.SP_prestadorServico := FDMem_RegistroprestadorServico.AsString;
  FinanceiroWeb.SP_cliente := FDMem_Registrocliente.AsString;
  FinanceiroWeb.SP_tabelaPreco := FDMem_RegistrotabelaPreco.AsString;
  FinanceiroWeb.SP_tipoTabela := FDMem_RegistrotipoTabela.AsInteger;
  FinanceiroWeb.SP_tipoTabelaDesc := FDMem_RegistrotipoTabelaDesc.AsString;
  FinanceiroWeb.SP_conta := FDMem_RegistrotipoConta.AsString;
  FinanceiroWeb.SP_tipoConta := FDMem_RegistrotipoConta.AsInteger;
  FinanceiroWeb.SP_tipoContaDesc := FDMem_RegistrotipoContaDesc.AsString;

  FinanceiroWeb.Stauts_Tab_SP := 'EDIT';
  ShowPopupModal('Popup'+FfrmMov_ServPrestados_Add.Name);
  Pesquisar;

end;

procedure TfrmMov_ServPrestados.btExcluirClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Excluindo lançamento',True,True,10000);
end;

procedure TfrmMov_ServPrestados.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMov_ServPrestados.btNovoClick(Sender: TObject);
begin
  inherited;

  FinanceiroWeb.Stauts_Tab_SP := 'INSERT';
  ShowPopupModal('Popup'+FfrmMov_ServPrestados_Add.Name);
  Pesquisar;

end;

procedure TfrmMov_ServPrestados.edClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    Pesquisar;
end;

procedure TfrmMov_ServPrestados.edClienteRightButtonClick(Sender: TObject);
begin
  inherited;
  FinanceiroWeb.Cliente_ID := 0;
  FinanceiroWeb.Cliente_Nome := '';

  ShowPopupModal('Popup'+FfrmCon_Cliente.Name);
  if ((FinanceiroWeb.Cliente_ID > 0) and (Trim(FinanceiroWeb.Cliente_Nome) <> '')) then
  begin
    edCliente.Tag := FinanceiroWeb.Cliente_ID;
    edCliente.Text := FinanceiroWeb.Cliente_Nome;
    Pesquisar;
  end;
end;

procedure TfrmMov_ServPrestados.edData_FChange(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmMov_ServPrestados.edData_IChange(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmMov_ServPrestados.edPrestadorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    Pesquisar;

end;

procedure TfrmMov_ServPrestados.edPrestadorRightButtonClick(Sender: TObject);
begin
  inherited;
  FinanceiroWeb.Prest_Servico_ID := 0;
  FinanceiroWeb.Prest_Servico_Nome := '';

  ShowPopupModal('Popup'+FfrmCon_PrestServicos.Name);
  if ((FinanceiroWeb.Prest_Servico_ID > 0) and (Trim(FinanceiroWeb.Prest_Servico_Nome) <> '')) then
  begin
    edPrestador.Tag := FinanceiroWeb.Prest_Servico_ID;
    edPrestador.Text := FinanceiroWeb.Prest_Servico_Nome;
    Pesquisar;
  end;
end;

procedure TfrmMov_ServPrestados.ExportD2Bridge;
begin
  inherited;

  Title:= 'Serviços Prestados';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'forms-servicosPrestados.html';

  if FfrmMov_ServPrestados_Add = Nil then
    FfrmMov_ServPrestados_Add := TfrmMov_ServPrestados_Add.Create(Self);
  D2Bridge.AddNested(FfrmMov_ServPrestados_Add);

  if FfrmCon_PrestServicos = Nil then
    FfrmCon_PrestServicos := TfrmCon_PrestServicos.Create(Self);
  D2Bridge.AddNested(FfrmCon_PrestServicos);

  if FfrmCon_Cliente = Nil then
    FfrmCon_Cliente := TfrmCon_Cliente.Create(Self);
  D2Bridge.AddNested(FfrmCon_Cliente);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with PanelGroup(lbFiltro_Tit.Caption,'',False,CSSClass.Col.colsize4).Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(edData_I);
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(edData_F);
        end;
      end;

      with PanelGroup(lbPrestador.Caption,'',False,CSSClass.Col.colsize4).Items.Add do
      begin
        FormGroup('',CSSClass.Col.colsize12).AddVCLObj(edPrestador);
      end;

      with PanelGroup(lbCliente.Caption,'',False,CSSClass.Col.colsize4).Items.Add do
      begin
        FormGroup('',CSSClass.Col.colsize12).AddVCLObj(edCliente);
      end;
    end;

    with Row.Items.Add do
      VCLObj(DBGrid);

    with Row.Items.Add do
    begin
      with PanelGroup(lbHr_Trab_Tit.Caption,'',False,CSSClass.Col.colsize3).Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Trab_Hr);
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Trab_Vlr);
        end;
      end;
      with PanelGroup(lbHr_Acul_Tit.Caption,'',False,CSSClass.Col.colsize3).Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Acul_Hr);
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Acul_Vlr);
        end;
      end;
      with PanelGroup(lbHr_Tot_Tit.Caption,'',False,CSSClass.Col.colsize3).Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Tot_Hr);
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Tot_Vlr);
        end;
      end;
      with PanelGroup(lbHr_Pagas_Tit.Caption,'',False,CSSClass.Col.colsize3).Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Pagas_Hr);
          FormGroup('',CSSClass.Col.colsize6).AddVCLObj(lbHr_Pagas_Vlr);
        end;
      end;
    end;

    with Row.Items.Add do
    begin
      with Row(CSSClass.DivHtml.Align_Right).Items.Add do
      begin
        VCLObj(btNovo, CSSClass.Button.add + CSSClass.Col.colsize2);
        VCLObj(btFechar, CSSClass.Button.close + CSSClass.Col.colsize2);
      end;
    end;

    Popup('Popup'+FfrmCon_PrestServicos.Name,'Prestadores de Serviços',True,CSSClass.Popup.ExtraLarge).Items.Add.Nested(FfrmCon_PrestServicos.Name);
    Popup('Popup'+FfrmCon_Cliente.Name,'Clientes',True,CSSClass.Popup.Large).Items.Add.Nested(FfrmCon_Cliente.Name);
    Popup('Popup'+FfrmMov_ServPrestados_Add.Name,'Cadastro Serviços Prestados',True,CSSClass.Popup.Large).Items.Add.Nested(FfrmMov_ServPrestados_Add.Name);
  end;

end;

procedure TfrmMov_ServPrestados.FormCreate(Sender: TObject);
begin
  inherited;
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

  FFuncoes_Wnd := TFuncoes_Wnd.Create;

  //edPrestador.Tag := FinanceiroWeb.Usuario_ID_Prestador;
  //edPrestador.Text := FinanceiroWeb.Usuario_Prestador;

end;

procedure TfrmMov_ServPrestados.FormShow(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

function TfrmMov_ServPrestados.HoraStrToTime(AHora: String): TTime;
begin
  try
    if Length(AHora) = 12 then
      Result := StrToTimeDef(Copy(AHora,1,2) + ':' + Copy(AHora,4,2) + Copy(AHora,7,2),0);

  except on E: Exception do
    raise Exception.Create('Erro ao converter Texto em Hora');
  end;
end;

procedure TfrmMov_ServPrestados.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage := 7;
   //PrismControl.AsDBGrid.MaxRecords:= 2000;
    with PrismControl.AsDBGrid do
    begin
      with Columns.Add do
      begin
         Title:= 'Ações';
         ColumnIndex :=0;
         Width := 65;
         With Buttons.Add do
           begin
            ButtonModel := TButtonModel.edit;
            Caption:='';
            Onclick:=btEditarClick;
           end;
         With Buttons.Add do
           begin
            ButtonModel := TButtonModel.Delete;
            Caption:='';
            Onclick:=btExcluirClick;
           end;
      end;
    end;
  end;

  edPrestador.Tag := FinanceiroWeb.Usuario_ID_Prestador;
  edPrestador.Text := FinanceiroWeb.Usuario_Prestador;
  edData_I.Date := StartOfTheMonth(Now);
  edData_F.Date := EndOfTheMonth(Now);

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

procedure TfrmMov_ServPrestados.Pesquisar;
var
  FResp :IResponse;
  FBody :TJSONObject;
  FBody_VlrCliente :TJSONObject;
  FBody_VlrMesAnterior :TJSONObject;
  FBody_VlrMesAtual :TJSONObject;
  FBody_VlrPagas :TJSONObject;
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

      FData_I := FormatDateTime('DD-MM-YYYY',edData_I.Date);
      FData_F := FormatDateTime('DD-MM-YYYY',edData_F.Date);

      if Trim(FData_I) = '' then
        raise Exception.Create('Data inicial é obrigatória');
      if Trim(FData_F) = '' then
        raise Exception.Create('Data final é obrigatória');

      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .AddParam('empresa',FinanceiroWeb.Usuario_ID_Empresa.ToString)
               .AddParam('prestador',edPrestador.Tag.ToString)
               .AddParam('cliente',edCliente.Tag.ToString)
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
          lbHr_Acul_Hr.Caption := FBody_VlrMesAnterior.GetValue<String>('horas','00:00:00');
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

        {$Region 'Valores pagos'}
          FBody_VlrPagas := FBody.GetValue<TJSONObject>('horasPagas',Nil);
          lbHr_Pagas_Hr.Caption := FBody_VlrPagas.GetValue<String>('horas','00:00:00');
          lbHr_Pagas_Vlr.Caption := FormatFloat('R$ #,##0.00',FBody_VlrPagas.GetValue<Double>('valor',0));
        {$EndRegion 'Valores pagos'}

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
    //GetDBGridDataAsJSON;
  end;
end;

procedure TfrmMov_ServPrestados.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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