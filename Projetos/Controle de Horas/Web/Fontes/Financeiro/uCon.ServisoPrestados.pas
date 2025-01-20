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
  uFuncoes.Wnd,

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
    dmRegistro: TDataSource;
    FDMem_Registroid: TIntegerField;
    FDMem_Registrodescricao: TStringField;
    FDMem_Registrostatus: TIntegerField;
    FDMem_RegistroidEmpresa: TIntegerField;
    FDMem_RegistroidPrestadorServico: TIntegerField;
    FDMem_RegistroidCliente: TIntegerField;
    FDMem_RegistroidTabela: TIntegerField;
    FDMem_RegistroidConta: TIntegerField;
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
    FDMem_Registrodata: TDateField;
    FDMem_RegistrohrInicio: TStringField;
    FDMem_RegistrohrFim: TStringField;
    FDMem_Registroseq: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure edFiltro_Cliente_IDRightButtonClick(Sender: TObject);
    procedure btFiltro_FiltrarClick(Sender: TObject);
  private
    FfrmCon_Cliente :TfrmCon_Cliente;

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
  FFuncoes_Wnd :TFuncoes_Wnd;

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

      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FData_I := '';
      FData_F := '';

      FDMem_Registro.Active := False;
      FDMem_Registro.Active := True;
      FDMem_Registro.DisableControls;


      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if Trim(ControleHoras.Usuario_Token) = '' then
        raise Exception.Create('Token do Usuário inválido');

      FData_I := FormatDateTime('DD-MM-YYYY',edFiltro_DataI.Date);
      FData_F := FormatDateTime('DD-MM-YYYY',edFiltro_DataF.Date);

      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .AddParam('cliente',edFiltro_Cliente_ID.Text)
               .AddParam('dataI',FData_I)
               .AddParam('dataF',FData_F)
               .Resource('servicosPrestados/apresentacao')
               .Accept('application/json')
               .Get;


      {
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .AddParam('cliente',edFiltro_Cliente_ID.Text)
               .AddParam('dataI',DateToStr(edFiltro_DataI.Date))
               .AddParam('dataF',DateToStr(edFiltro_DataF.Date))
               .Resource('servicosPrestados/apresentacao')
               .Accept('application/json')
               .Get;
      }




      if FResp.StatusCode = 200 then
      begin
        if FResp.Content = '' then
          raise Exception.Create('Registros não localizados');

        FBody := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(FResp.Content),0) as TJSONObject;

        {$Region 'Valores do Cliente'}
          FBody_VlrCliente := FBody.GetValue<TJSONObject>('valoresClientes',Nil);
          lbVC_HorasPrevistas_T.Caption := FBody_VlrCliente.GetValue<String>('totalHorasPrevista','00:00:00');
          lbVC_ValorHora_T.Caption := FormatFloat('R$ #,##0.00',FBody_VlrCliente.GetValue<Double>('valor',0));
          lbVC_Totais_T.Caption := FormatFloat('R$ #,##0.00',FBody_VlrCliente.GetValue<Double>('valorTotal',0));
        {$EndRegion 'Valores do Cliente'}

        {$Region 'Valores do Mês Anterior'}
          FBody_VlrMesAnterior := FBody.GetValue<TJSONObject>('valoresMesAnterior',Nil);
          lbMA_HorasAcumuladas_T.Caption := FBody_VlrMesAnterior.GetValue<String>('hora','00:00:00');
          lbMA_Valor_T.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAnterior.GetValue<Double>('valor',0));
        {$EndRegion 'Valores do Mês Anterior'}

        {$Region 'Valores do Mês Atual'}
          FBody_VlrMesAtual := FBody.GetValue<TJSONObject>('valoresMesAtual',Nil);
          lbMAT_Horas_T.Caption := FBody_VlrMesAtual.GetValue<String>('horas','00:00:00');
          lbMAT_Valor_T.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAtual.GetValue<Double>('valor',0));
        {$EndRegion 'Valores do Mês Atual'}

        {$Region 'Total'}
          FBody_VlrMesAtual := FBody.GetValue<TJSONObject>('totais',Nil);
          lbT_Horas_T.Caption := FBody_VlrMesAtual.GetValue<String>('horas','00:00:00');
          lbT_Valor_T.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAtual.GetValue<Double>('valor',0));
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
              FDMem_Registrodata.AsDateTime := FBody_Lancamentos.Get(x).GetValue<TDate>('data',0);
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
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    end;
  finally
    FDMem_Registro.EnableControls;
    FreeAndNil(FFuncoes_Wnd);
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

function TfrmCon_ServicosPrestados.HoraStrToTime(AHora: String): TTime;
begin
  try
    if Length(AHora) = 12 then
      Result := StrToTimeDef(Copy(AHora,1,2) + ':' + Copy(AHora,4,2) + Copy(AHora,7,2),0);

  except on E: Exception do
    raise Exception.Create('Erro ao converter Texto em Hora');
  end;
end;

procedure TfrmCon_ServicosPrestados.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;


  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage := 8;
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