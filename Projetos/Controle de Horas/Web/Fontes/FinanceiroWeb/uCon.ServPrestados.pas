unit uCon.ServPrestados;

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
  WebView2, Vcl.Edge,

  //D2BridgeFormTemplate,
  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,
  uFuncoes.Wnd,

  uPrincipal,
  uCon.Cliente,
  uCon.PrestServicos;

type
  TfrmCon_ServPrestados = class(TfrmPrincipal)
    ImageList: TImageList;
    pnHeader: TPanel;
    lbFiltro_Tit: TLabel;
    lbCliente: TLabel;
    edData_I: TDateTimePicker;
    edData_F: TDateTimePicker;
    edCliente: TButtonedEdit;
    btPesquisa: TButton;
    Memo_HTML: TMemo;
    lbHrAcum_Hr: TLabel;
    lbHrAcum_Vlr: TLabel;
    gbHorasAcumuladas: TGroupBox;
    gbHorasTrabalhadas: TGroupBox;
    lbHr_Trab_Vlr: TLabel;
    lbHr_Trab_Hr: TLabel;
    gbHorasPagas: TGroupBox;
    lbHr_Pagas_Vlr: TLabel;
    lbHr_Pagas_Hr: TLabel;
    gbHorasTotal: TGroupBox;
    lbHr_Total_Vlr: TLabel;
    lbHr_Total_Hr: TLabel;
    gbHrTrab_Grupo: TGroupBox;
    lbHr_Trab_VlrG: TLabel;
    lbHr_Trab_HrG: TLabel;
    gbHr_Acum_Grupo: TGroupBox;
    lbHrAcum_VlrG: TLabel;
    lbHrAcum_HrG: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    gbHorasTotal_F: TGroupBox;
    lbHr_Total_Vlr_F: TLabel;
    lbHr_Total_Hr_F: TLabel;
    procedure btPesquisaClick(Sender: TObject);
    procedure edClienteRightButtonClick(Sender: TObject);
    procedure WebViewExecuteScript(Sender: TCustomEdgeBrowser; AResult: string);
    procedure FormCreate(Sender: TObject);
  private
    WebView: TEdgeBrowser;

    FFuncoes_Wnd :TFuncoes_Wnd;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    function BuildDataTable: string;

    function GetClienteID: Integer;
    function GetClienteNome: string;
    function GetDataFinal: string;
    function GetDataInicial: string;

    procedure SetClienteID(const Value: Integer);
    procedure SetClienteNome(const Value: string);
    procedure SetDataFinal(const Value: string);
    procedure SetDataInicial(const Value: string);
  public
    procedure BuscarCliente;
    function Pesquisar:TJSONObject;

    // Propriedades para acessar os campos
    property ClienteID: Integer read GetClienteID write SetClienteID;
    property ClienteNome: string read GetClienteNome write SetClienteNome;
    property DataInicial: string read GetDataInicial write SetDataInicial;
    property DataFinal: string read GetDataFinal write SetDataFinal;

  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmCon_ServPrestados:TfrmCon_ServPrestados;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmCon_ServPrestados:TfrmCon_ServPrestados;
begin
  result:= TfrmCon_ServPrestados(TfrmCon_ServPrestados.GetInstance);
end;

procedure TfrmCon_ServPrestados.btPesquisaClick(Sender: TObject);
var
  FBody :TJSONObject;
  FBody_VlrMesAnterior :TJSONObject;
  FBody_VlrCliente :TJSONObject;
  FBody_VlrMesAtual :TJSONObject;
  FBody_VlrPagas :TJSONObject;
  FBodFBody_VlrMesAtualy_VlrTotal :TJSONObject;
  FBody_Lancamentos :TJSONArray;

begin
  //Close;
  //BuildDataTable;

  FBody := Pesquisar;

  if FBody = Nil then
    Exit;

  lbHrAcum_Hr.Caption := '';
  lbHrAcum_Vlr.Caption := '';
  lbHrAcum_HrG.Caption := '';
  lbHrAcum_VlrG.Caption := '';

  lbHr_Trab_Hr.Caption := '';
  lbHr_Trab_Vlr.Caption := '';
  lbHr_Trab_HrG.Caption := '';
  lbHr_Trab_VlrG.Caption := '';

  lbHr_Pagas_Hr.Caption := '';
  lbHr_Pagas_Vlr.Caption := '';

  lbHr_Total_Hr.Caption := '';
  lbHr_Total_Vlr.Caption := '';

  FBody_VlrMesAnterior := FBody.GetValue<TJSONObject>('valoresMesAnterior',Nil);
  lbHrAcum_Hr.Caption := FBody_VlrMesAnterior.GetValue<String>('horas','00:00:00');
  lbHrAcum_Vlr.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAnterior.GetValue<Double>('valor',0));
  lbHrAcum_HrG.Caption := FBody_VlrMesAnterior.GetValue<String>('horas','00:00:00') + ' hrs';
  lbHrAcum_VlrG.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAnterior.GetValue<Double>('valor',0));

  FBody_VlrMesAtual := FBody.GetValue<TJSONObject>('valoresMesAtual',Nil);
  lbHr_Trab_Hr.Caption := FBody_VlrMesAtual.GetValue<String>('horas','00:00:00');
  lbHr_Trab_Vlr.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAtual.GetValue<Double>('valor',0));
  lbHr_Trab_HrG.Caption := FBody_VlrMesAtual.GetValue<String>('horas','00:00:00') + ' hrs';
  lbHr_Trab_VlrG.Caption := FormatFloat('R$ #,##0.00',FBody_VlrMesAtual.GetValue<Double>('valor',0));

  {
  FBody_VlrPagas := FBody.GetValue<TJSONObject>('valoresMesAtual',Nil);
  lbHr_Pagas_Hr.Caption := FBody_VlrMesAnterior.GetValue<String>('horas','00:00:00');
  lbHr_Pagas_Vlr.Caption := FormatFloat('R$ 0,00',FBody_VlrMesAnterior.GetValue<Double>('valor',0));
  }

  FBody_VlrPagas := FBody.GetValue<TJSONObject>('totais',Nil);
  lbHr_Total_Hr.Caption := FBody_VlrPagas.GetValue<String>('horas','00:00:00');
  lbHr_Total_Vlr.Caption := FormatFloat('R$ #,##0.00',FBody_VlrPagas.GetValue<Double>('valor',0));
  lbHr_Total_Hr_F.Caption := 'Total Horas: ' + FBody_VlrPagas.GetValue<String>('horas','00:00:00') + ' hrs';
  lbHr_Total_Vlr_F.Caption := 'Total Geral: ' + FormatFloat('R$ #,##0.00',FBody_VlrPagas.GetValue<Double>('valor',0));

end;

function TfrmCon_ServPrestados.BuildDataTable: string;
var
  vDataTables: TStrings;

  FBody :TJSONObject;
  FBody_VlrCliente :TJSONObject;
  FBody_VlrMesAnterior :TJSONObject;
  FBody_VlrMesAtual :TJSONObject;
  FBody_VlrPagas :TJSONObject;
  FBodFBody_VlrMesAtualy_VlrTotal :TJSONObject;
  FBody_Lancamentos :TJSONArray;

  FHr_Acul_Hr :String;
  FHr_Acul_Vlr :String;

begin
  vDataTables:= TStringList.Create;
  Result := '';

  FBody := Pesquisar;

  if FBody = Nil then
    Exit;


  {$Region 'Valores do Mês Anterior'}
    FHr_Acul_Hr := '000:00:00';
    FHr_Acul_Vlr := 'R$ 0,00';
    FBody_VlrMesAnterior := FBody.GetValue<TJSONObject>('valoresMesAnterior',Nil);
    FHr_Acul_Hr := FBody_VlrMesAnterior.GetValue<String>('horas','00:00:00');
    FHr_Acul_Vlr := FormatFloat('R$ #,##0.00',FBody_VlrMesAnterior.GetValue<Double>('valor',0));
  {$EndRegion 'Valores do Mês Anterior'}

  Memo_HTML.Lines.Clear;

 //HTMLElement
  //with vDataTables do
  with Memo_HTML.Lines do
  begin
    add('<!DOCTYPE html>');
    add('<html>');
    add('<head>');
    add('    <meta charset="UTF-8">');
    add('    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">');
    add('    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">');
    add('    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>');
    add('    <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>');
    add('    <script src="https://cdn.jsdelivr.net/npm/nodemailer@6.9.9/lib/client.js"></script>');
    add('    <script src="config.js"></script>');
    add('    <style>');
    add('        .group-header {');
    add('            background-color: #f0f4ff;');
    add('            padding: 10px 20px;');
    add('            display: flex;');
    add('            align-items: center;');
    add('            cursor: pointer;');
    add('            gap: 15px;');
    add('        }');
    add('');
    add('        .header-left {');
    add('            display: flex;');
    add('            align-items: center;');
    add('            gap: 10px;');
    add('            flex: 1;');
    add('        }');
    add('');
    add('        .group-title {');
    add('            color: #0d6efd;');
    add('            font-weight: 600;');
    add('        }');
    add('');
    add('        .group-totals {');
    add('            display: flex;');
    add('            align-items: center;');
    add('            gap: 20px;');
    add('            margin-left: auto;');
    add('            min-width: 300px;');
    add('            justify-content: flex-end;');
    add('        }');
    add('');
    add('        .total-hours,');
    add('        .total-value {');
    add('            min-width: 120px;');
    add('            text-align: right;');
    add('            font-weight: 600;');
    add('        }');
    add('');
    add('        .group-totals .total-hours,');
    add('        .group-totals .total-value {');
    add('            color: #0d6efd;');
    add('        }');
    add('');
    add('        .group-container.horas-pagas .total-hours,');
    add('        .group-container.horas-pagas .total-value {');
    add('            color: #dc3545;');
    add('        }');
    add('');
    add('        .group-header i {');
    add('            color: #0d6efd;');
    add('            transition: transform 0.3s;');
    add('        }');
    add('');
    add('        .group-header.collapsed i {');
    add('            transform: rotate(-90deg);');
    add('        }');
    add('');
    add('        .group-content {');
    add('            background: white;');
    add('            transition: all 0.3s ease;');
    add('        }');
    add('');
    add('        .group-content.collapsed {');
    add('            display: none;');
    add('        }');
    add('');
    add('        .table-row {');
    add('            display: grid;');
    add('            grid-template-columns: 120px 100px 80px 80px 100px 100px 120px 1fr;');
    add('            gap: 10px;');
    add('            padding: 8px 15px;');
    add('            border-bottom: 1px solid #eee;');
    add('            align-items: center;');
    add('            min-height: 32px;');
    add('        }');
    add('');
    add('        .table-header {');
    add('            font-weight: 600;');
    add('            color: #333;');
    add('            min-height: 32px !important;');
    add('            align-items: center !important;');
    add('        }');
    add('');
    add('        .table-cell {');
    add('            overflow: hidden;');
    add('            padding: 4px 0;');
    add('        }');
    add('');
    add('        .table-cell:not(:last-child) {');
    add('            white-space: nowrap;');
    add('        }');
    add('');
    add('        .table-cell:last-child {');
    add('            white-space: normal;');
    add('            word-wrap: break-word;');
    add('            min-width: 200px;');
    add('            line-height: 1.4;');
    add('        }');
    add('');
    add('        .text-right {');
    add('            text-align: right;');
    add('        }');
    add('');
    add('        .badge {');
    add('            font-size: 0.85em;');
    add('            padding: 5px 10px;');
    add('        }');
    add('');
    add('        .total-geral {');
    add('            text-align: right;');
    add('            font-weight: 600;');
    add('            padding: 15px;');
    add('            font-size: 1.1em;');
    add('        }');
    add('');
    add('        .total-geral.positive {');
    add('            color: #0d6efd; /* Azul do Bootstrap */');
    add('        }');
    add('');
    add('        .total-geral.negative {');
    add('            color: #dc3545; /* Vermelho do Bootstrap */');
    add('        }');
    add('');
    add('        .table-row.has-long-obs {');
    add('            align-items: start;');
    add('            min-height: 40px;');
    add('        }');
    add('');
    add('        /* Estilo específico para o grupo de horas pagas */');
    add('        .group-container.horas-pagas .table-row:not(.table-header) .table-cell {');
    add('            color: #dc3545; /* Vermelho apenas para os registros */');
    add('        }');
    add('');
    add('        .group-container.horas-pagas .group-header {');
    add('            color: #dc3545;');
    add('            background-color: #fff5f5;');
    add('        }');
    add('');
    add('        .group-container.horas-pagas .group-header .badge {');
    add('            background-color: #dc3545 !important;');
    add('        }');
    add('');
    add('        .group-container.horas-pagas .total-value {');
    add('            color: #dc3545;');
    add('        }');
    add('');
    add('        /* Garante que o cabeçalho fique preto */');
    add('        .group-container.horas-pagas .table-header .table-cell {');
    add('            color: #333 !important;');
    add('        }');
    add('');
    add('        .total-hours {');
    add('            font-weight: 600;');
    add('            color: #198754; /* Verde do Bootstrap */');
    add('        }');
    add('');
    add('        /* Para o grupo de horas pagas */');
    add('        .group-container.horas-pagas .total-hours {');
    add('            color: #dc3545;');
    add('        }');
    add('');
    add('        /* Total Geral */');
    add('        .total-geral {');
    add('            display: flex;');
    add('            justify-content: flex-end;');
    add('            align-items: center;');
    add('            gap: 20px;');
    add('            padding: 15px;');
    add('        }');
    add('');
    add('        .total-geral-hours {');
    add('            font-size: 1.1em;');
    add('            font-weight: 600;');
    add('            color: #198754;');
    add('        }');
    add('');
    add('        .total-geral-value {');
    add('            font-size: 1.1em;');
    add('            font-weight: 600;');
    add('        }');
    add('');
    add('        .total-geral-value.positive {');
    add('            color: #0d6efd;');
    add('        }');
    add('');
    add('        .total-geral-value.negative {');
    add('            color: #dc3545;');
    add('        }');
    add('');
    add('        .cards-container {');
    add('            display: grid;');
    add('            grid-template-columns: repeat(4, 1fr);');
    add('            gap: 20px;');
    add('            margin-bottom: 15px;');
    add('        }');
    add('');
    add('        .summary-card {');
    add('            background: white;');
    add('            border-radius: 10px;');
    add('            padding: 0; /* Removido padding geral */');
    add('            box-shadow: 0 2px 4px rgba(0,0,0,0.05);');
    add('            display: flex;');
    add('            flex-direction: column;');
    add('            border: 1px solid #e6e6e6;');
    add('        }');
    add('');
    add('        .card-title {');
    add('            background-color: transparent;');
    add('            border-bottom: none;');
    add('            color: #2d3748;');
    add('            font-size: 0.9em;');
    add('            font-weight: 600;');
    add('            padding: 12px 20px;');
    add('            border-radius: 10px 10px 0 0;');
    add('        }');
    add('');
    add('        .card-content {');
    add('            padding: 20px;');
    add('            display: flex;');
    add('            align-items: center;');
    add('            gap: 15px;');
    add('        }');
    add('');
    add('        .card-icon {');
    add('            width: 40px;');
    add('            height: 40px;');
    add('            border-radius: 50%;');
    add('            display: flex;');
    add('            align-items: center;');
    add('            justify-content: center;');
    add('            font-size: 1.2em;');
    add('            flex-shrink: 0;');
    add('        }');
    add('');
    add('        .card-values {');
    add('            display: flex;');
    add('            flex-direction: column;');
    add('            gap: 5px;');
    add('            flex-grow: 1;');
    add('        }');
    add('');
    add('        .hours {');
    add('            font-size: 1.5em;');
    add('            font-weight: 600;');
    add('            font-family: monospace;');
    add('            line-height: 1;');
    add('        }');
    add('');
    add('        .amount {');
    add('            font-size: 1.2em;');
    add('            font-weight: 600;');
    add('            color: #0d6efd;');
    add('            line-height: 1;');
    add('        }');
    add('');
    add('        .summary-card:nth-child(3) .amount {');
    add('            color: #dc3545;');
    add('        }');
    add('');
    add('        /* Card 1 - Horas Trabalhadas (Azul) */');
    add('        .summary-card:nth-child(1) .card-title {');
    add('            background-color: #e8f0ff;');
    add('            border-bottom: 1px solid #cce0ff;');
    add('        }');
    add('');
    add('        /* Card 2 - Horas Acumuladas (Verde) */');
    add('        .summary-card:nth-child(2) .card-title {');
    add('            background-color: #e8fff0;');
    add('            border-bottom: 1px solid #ccf5e0;');
    add('        }');
    add('');
    add('        /* Card 3 - Horas Pagas (Vermelho) */');
    add('        .summary-card:nth-child(3) .card-title {');
    add('            background-color: #ffe8e8;');
    add('            border-bottom: 1px solid #ffcccc;');
    add('        }');
    add('');
    add('        /* Card 4 - Horas Total (Amarelo) */');
    add('        .summary-card:nth-child(4) .card-title {');
    add('            background-color: #fff8e8;');
    add('            border-bottom: 1px solid #fff2cc;');
    add('        }');
    add('');
    add('        .page-header {');
    add('            padding-bottom: 15px;');
    add('            border-bottom: 1px solid #e6e6e6;');
    add('        }');
    add('');
    add('        .page-title {');
    add('            color: #2d3748;');
    add('            font-size: 1.8evm;');
    add('            font-weight: 600;');
    add('            margin: 0;');
    add('        }v');
    add('');
    add('        .print-button {');
    add('            display: flex;');
    add('            align-items: center;');
    add('            gap: 8px;');
    add('            padding: 8px 16px;');
    add('        }');
    add('');
    add('        .print-button i {');
    add('            font-size: 1.1em;');
    add('        }');
    add('');
    add('        @media print {');
    add('            .print-button {');
    add('                display: none;');
    add('            }');
    add('        }');
    add('');
    add('        /* Estilo específico para modo PDF */');
    add('        .pdf-mode {');
    add('            width: 100% !important;');
    add('            max-width: none !important;');
    add('            margin: 0 !important;');
    add('            padding: 20px !important;');
    add('            background: white;');
    add('        }');
    add('');
    add('        .pdf-mode .cards-container {');
    add('            display: grid;');
    add('            grid-template-columns: repeat(4, 1fr);');
    add('            gap: 15px;');
    add('            margin-bottom: 15px;');
    add('            page-break-inside: avoid;');
    add('        }');
    add('');
    add('        .pdf-mode .group-container {');
    add('            page-break-inside: avoid;');
    add('            margin-top: 15px;');
    add('        }');
    add('');
    add('        .pdf-mode .group-container:first-of-type {');
    add('            margin-top: 0;');
    add('        }');
    add('');
    add('        .pdf-mode .table-row {');
    add('            page-break-inside: avoid;');
    add('        }');
    add('');
    add('        @page {');
    add('            size: landscape;');
    add('            margin: 1cm;');
    add('        }');
    add('');
    add('        @media print {');
    add('            .container {');
    add('                width: 100% !important;');
    add('                max-width: none !important;');
    add('                margin: 0 !important;');
    add('                padding: 20px !important;');
    add('            }');
    add('        }');
    add('');
    add('        .group-container {');
    add('            margin-top: 15px;');
    add('        }');
    add('');
    add('        /* Ajuste específico para o primeiro grupo */');
    add('        .group-container:first-of-type {');
    add('            margin-top: 0;');
    add('        }');
    add('');
    add('        /* Estilos específicos para o PDF */');
    add('        .pdf-mode .cards-container {');
    add('            margin-bottom: 10px !important; /* Força um espaçamento menor no PDF */');
    add('        }');
    add('');
    add('        .pdf-mode .group-container {');
    add('            margin-top: 10px !important; /* Reduz o espaço entre grupos no PDF */');
    add('        }');
    add('');
    add('        .pdf-mode .page-header {');
    add('            margin-bottom: 10px !important; /* Reduz o espaço após o título */');
    add('        }');
    add('    </style>');
    add('</head>');
    add('<body>');
    add('    <div class="container mt-4">');
    add('        <!-- Título da página -->');
    add('        <div class="page-header mb-4">');
    add('            <div class="d-flex justify-content-between align-items-center">');
    add('                <h1 class="page-title">Movimento de Serviços Prestados</h1>');
    add('                <div class="d-flex gap-2">');
    add('                    <button class="btn btn-outline-primary print-button" onclick="generatePDF()" title="Imprimir">');
    add('                        <i class="bi bi-printer"></i>');
    add('                    </button>');
    add('                    <button class="btn btn-outline-secondary" onclick="fecharJanela()" title="Fechar">');
    add('                        <i class="bi bi-x-lg"></i>');
    add('                        Fechar');
    add('                    </button>');
    add('                </div>');
    add('            </div>');
    add('        </div>');
    add('');
    {
    add('        <!-- Área de Filtros -->');
    add('        <div class="card mt-3 mb-4">');
    add('            <div class="card-body">');
    add('                <div class="row g-3 align-items-center">');
    add('                    <div class="col-md-2">');
    add('                        <div class="form-floating">');
    add('                            <input type="date" class="form-control datepicker" id="edData_I" name="edData_I">');
    add('                            <label for="edData_I">Data Inicial</label>');
    add('                        </div>');
    add('                    </div>');
    add('                    <div class="col-md-2">');
    add('                        <div class="form-floating">');
    add('                            <input type="date" class="form-control datepicker" id="edData_F" name="edData_F">');
    add('                            <label for="edData_F">Data Final</label>');
    add('                        </div>');
    add('                    </div>');
    add('                    <div class="col-md-6">');
    add('                        <div class="input-group">');
    add('                            <div class="form-floating flex-grow-1">');
    add('                                <input type="hidden" id="edCliente_ID" name="edCliente_ID">');
    add('                                <input type="text" class="form-control" id="edCliente" name="edCliente" placeholder="Cliente" readonly>');
    add('                                <label for="edCliente">Cliente</label>');
    add('                            </div>');
    add('                            <button class="btn btn-outline-secondary" type="button" id="btLocCliente" onclick="if(window.external) window.external.BuscarCliente()">');
    add('                                <i class="bi bi-search"></i>');
    add('                            </button>');
    add('                        </div>');
    add('                    </div>');
    add('                    <div class="col-md-2">');
    add('                        <button class="btn btn-primary w-100" type="button" id="btPesquisa" onclick="if(window.external) window.external.Pesquisar()">');
    add('                            <i class="bi bi-filter"></i>');
    add('                            Pesquisar');
    add('                        </button>');
    add('                    </div>');
    add('                </div>');
    add('            </div>');
    add('        </div>');
    }
    add('');
    add('        <!-- Cards container -->');
    add('        <div class="cards-container mb-4">');
    add('            <!-- Card 1 - Horas Trabalhadas -->');
    add('            <div class="summary-card">');
    add('                <div class="card-title">Horas Trabalhadas</div>');
    add('                <div class="card-content">');
    add('                    <div class="card-icon" style="background-color: #e8f0ff;">');
    add('                        <i class="bi bi-clock text-primary"></i>');
    add('                    </div>');
    add('                    <div class="card-values">');
    add('                        <div class="hours">046:00:00</div>');
    add('                        <div class="amount">R$ 1.513,40</div>');
    add('                    </div>');
    add('                </div>');
    add('            </div>');
    add('');
    add('            <!-- Card 2 - Horas Acumuladas -->');
    add('            <div class="summary-card">');
    add('                <div class="card-title">Horas Acumuladas</div>');
    add('                <div class="card-content">');
    add('                    <div class="card-icon" style="background-color: #e8fff0;">');
    add('                        <i class="bi bi-hourglass text-success"></i>');
    add('                    </div>');
    add('                    <div class="card-values">');
    add('                        <div class="hours">{%lbHrAcumuladas_Hr%}</div>');
    add('                        <div class="amount">'+FHr_Acul_Vlr+'</div>');
    add('                    </div>');
    add('                </div>');
    add('            </div>');
    add('');
    add('            <!-- Card 3 - Horas Pagas -->');
    add('            <div class="summary-card">');
    add('                <div class="card-title">Horas Pagas</div>');
    add('                <div class="card-content">');
    add('                    <div class="card-icon" style="background-color: #ffe8e8;">');
    add('                        <i class="bi bi-cash text-danger"></i>');
    add('                    </div>');
    add('                    <div class="card-values">');
    add('                        <div class="hours">000:00:00</div>');
    add('                        <div class="amount">R$ 0,00</div>');
    add('                    </div>');
    add('                </div>');
    add('            </div>');
    add('');
    add('            <!-- Card 4 - Total -->');
    add('            <div class="summary-card">');
    add('                <div class="card-title">Horas Total</div>');
    add('                <div class="card-content">');
    add('                    <div class="card-icon" style="background-color: #fff8e8;">');
    add('                        <i class="bi bi-clock-history text-warning"></i>');
    add('                    </div>');
    add('                    <div class="card-values">');
    add('                        <div class="hours">132:53:09</div>');
    add('                        <div class="amount">R$ 4.339,04</div>');
    add('                    </div>');
    add('                </div>');
    add('            </div>');
    add('        </div>');
    add('');
    add('        <!-- Grupo HORAS TRABALHADAS MÊS -->');
    add('        <div class="group-container">');
    add('            <div class="group-header" onclick="toggleGroup(this)">');
    add('                <i class="bi bi-chevron-down"></i>');
    add('                <span class="group-title">HORAS TRABALHADAS MÊS</span>');
    add('                <div class="group-totals">');
    add('                    <span class="total-hours">40:00 hrs</span>');
    add('                    <span class="total-value">R$ 1.316,00</span>');
    add('                </div>');
    add('            </div>');
    add('');
    add('            <div class="group-content">');
    add('                <div class="table-row table-header">');
    add('                    <div class="table-cell">Data</div>');
    add('                    <div class="table-cell">Dia</div>');
    add('                    <div class="table-cell text-right">Início</div>');
    add('                    <div class="table-cell text-right">Fim</div>');
    add('                    <div class="table-cell text-right">Total Hrs</div>');
    add('                    <div class="table-cell text-right">Vlr. Hora</div>');
    add('                    <div class="table-cell text-right">Total</div>');
    add('                    <div class="table-cell">Observação</div>');
    add('                </div>');
    add('');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">15/03/2025</div>');
    add('                    <div class="table-cell">Sábado</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">10:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 329,00</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">28/02/2025</div>');
    add('                    <div class="table-cell">Sexta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">10:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 329,00</div>');
    add('                    <div class="table-cell">Desenvolvimento do módulo de relatórios com implementação de novos recursos solicitados pelo cliente. Realização de testes e ajustes conforme feedback da equipe.</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">15/02/2025</div>');
    add('                    <div class="table-cell">Quinta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">8:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 263,20</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">10/02/2025</div>');
    add('                    <div class="table-cell">Quinta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">8:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 263,20</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">03/02/2025</div>');
    add('                    <div class="table-cell">Quinta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">4:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 131,60</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('            </div>');
    add('        </div>');
    add('');
    add('        <!-- Grupo HORAS EXCEDIDAS MÊS ANTERIOR -->');
    add('        <div class="group-container">');
    add('            <div class="group-header" onclick="toggleGroup(this)">');
    add('                <i class="bi bi-chevron-down"></i>');
    add('                <span class="group-title">HORAS EXCEDIDAS MÊS ANTERIOR</span>');
    add('                <div class="group-totals">');
    add('                    <span class="total-hours">12:00 hrs</span>');
    add('                    <span class="total-value">R$ 789,60</span>');
    add('                </div>');
    add('            </div>');
    add('');
    add('            <div class="group-content">');
    add('                <div class="table-row table-header">');
    add('                    <div class="table-cell">Data</div>');
    add('                    <div class="table-cell">Dia</div>');
    add('                    <div class="table-cell text-right">Início</div>');
    add('                    <div class="table-cell text-right">Fim</div>');
    add('                    <div class="table-cell text-right">Total Hrs</div>');
    add('                    <div class="table-cell text-right">Vlr. Hora</div>');
    add('                    <div class="table-cell text-right">Total</div>');
    add('                    <div class="table-cell">Observação</div>');
    add('                </div>');
    add('');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">28/02/2024</div>');
    add('                    <div class="table-cell">Sexta</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">22:00</div>');
    add('                    <div class="table-cell text-right">4:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 131,60</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">27/02/2024</div>');
    add('                    <div class="table-cell">Quinta</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">22:00</div>');
    add('                    <div class="table-cell text-right">4:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 131,60</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">26/02/2024</div>');
    add('                    <div class="table-cell">Quarta</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">22:00</div>');
    add('                    <div class="table-cell text-right">4:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 131,60</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('            </div>');
    add('        </div>');
    add('');
    add('        <!-- Grupo HORAS PAGAS -->');
    add('        <div class="group-container horas-pagas">');
    add('            <div class="group-header" onclick="toggleGroup(this)">');
    add('                <i class="bi bi-chevron-down"></i>');
    add('                <span class="group-title">HORAS PAGAS</span>');
    add('                <div class="group-totals">');
    add('                    <span class="total-hours">32:00 hrs</span>');
    add('                    <span class="total-value">R$ 1.052,80</span>');
    add('                </div>');
    add('            </div>');
    add('');
    add('            <div class="group-content">');
    add('                <div class="table-row table-header">');
    add('                    <div class="table-cell">Data</div>');
    add('                    <div class="table-cell">Dia</div>');
    add('                    <div class="table-cell text-right">Início</div>');
    add('                    <div class="table-cell text-right">Fim</div>');
    add('                    <div class="table-cell text-right">Total Hrs</div>');
    add('                    <div class="table-cell text-right">Vlr. Hora</div>');
    add('                    <div class="table-cell text-right">Total</div>');
    add('                    <div class="table-cell">Observação</div>');
    add('                </div>');
    add('');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">15/02/2024</div>');
    add('                    <div class="table-cell">Quinta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">10:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 329,00</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">14/02/2024</div>');
    add('                    <div class="table-cell">Quarta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">8:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 263,20</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">13/02/2024</div>');
    add('                    <div class="table-cell">Quarta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">7:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 230,30</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('                <div class="table-row">');
    add('                    <div class="table-cell">12/02/2024</div>');
    add('                    <div class="table-cell">Quarta</div>');
    add('                    <div class="table-cell text-right">08:00</div>');
    add('                    <div class="table-cell text-right">18:00</div>');
    add('                    <div class="table-cell text-right">7:00</div>');
    add('                    <div class="table-cell text-right">R$ 32,90</div>');
    add('                    <div class="table-cell text-right">R$ 230,30</div>');
    add('                    <div class="table-cell">Reunião com cliente</div>');
    add('                </div>');
    add('            </div>');
    add('        </div>');
    add('');
    add('        <!-- Total Geral (Horas Trabalhadas + Horas Excedidas - Horas Pagas) -->');
    add('        <div class="total-geral">');
    add('            <span class="total-geral-hours">Total Horas: 20:00 hrs</span>');
    add('            <span class="total-geral-value" id="totalGeral">Total Geral: R$ 1.052,80</span>');
    add('        </div>');
    add('    </div>');
    add('');
    add('    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>');
    add('    <script>');
    add('        function toggleGroup(header) {');
    add('            header.classList.toggle(''collapsed'');');
    add('            const content = header.nextElementSibling;');
    add('            content.classList.toggle(''collapsed'');');
    add('        }');
    add('');
    add('        document.addEventListener(''DOMContentLoaded'', function() {');
    add('            const rows = document.querySelectorAll(''.table-row'');');
    add('            rows.forEach(row => {');
    add('                const obsCell = row.querySelector(''.table-cell:last-child'');');
    add('                if (obsCell && obsCell.scrollHeight > 32) {');
    add('                    row.classList.add(''has-long-obs'');');
    add('                }');
    add('            });');
    add('');
    add('            updateTotalGeralColor();');
    add('        });');
    add('');
    add('        // Função para atualizar a cor do total geral');
    add('        function updateTotalGeralColor() {');
    add('            const totalGeralElement = document.getElementById(''totalGeral'');');
    add('            const valorText = totalGeralElement.textContent;');
    add('            const valor = parseFloat(valorText.replace(''Total Geral: R$ '', '''').replace(''.'', '''').replace('','', ''.''));');
    add('');
    add('            totalGeralElement.classList.remove(''positive'', ''negative'');');
    add('            totalGeralElement.classList.add(valor >= 0 ? ''positive'' : ''negative'');');
    add('        }');
    add('');
    add('        async function generatePDF() {');
    add('            const printButton = document.querySelector(''.print-button'');');
    add('            printButton.disabled = true;');
    add('            printButton.innerHTML = ''<i class="bi bi-hourglass"></i> Gerando PDF...'';');
    add('');
    add('            try {');
    add('                const element = document.querySelector(''.container'');');
    add('');
    add('                // Expande todos os grupos antes de gerar o PDF');
    add('                const groups = document.querySelectorAll(''.group-header'');');
    add('                groups.forEach(header => {');
    add('                    const content = header.nextElementSibling;');
    add('                    if (content.classList.contains(''collapsed'')) {');
    add('                        content.classList.remove(''collapsed'');');
    add('                    }');
    add('                });');
    add('');
    add('                // Adiciona classe para ajustes específicos do PDF');
    add('                element.classList.add(''pdf-mode'');');
    add('');
    add('                const opt = {');
    add('                    margin: [0.5, 1, 1, 1], // Reduzidas as margens');
    add('                    filename: ''servicos-prestados.pdf'',');
    add('                    image: { type: ''jpeg'', quality: 0.98 },');
    add('                    html2canvas: {');
    add('                        scale: 2,');
    add('                        useCORS: true,');
    add('                        logging: true');
    add('                    },');
    add('                    jsPDF: {');
    add('                        unit: ''cm'',');
    add('                        format: ''a4'',');
    add('                        orientation: ''landscape''');
    add('                    }');
    add('                };');
    add('');
    add('                await html2pdf().set(opt).from(element).save();');
    add('');
    add('                // Recarrega a página após gerar o PDF');
    add('                setTimeout(() => {');
    add('                    window.location.reload();');
    add('                }, 1000); // Aguarda 1 segundo para garantir que o PDF foi salvo');
    add('');
    add('            } catch (error) {');
    add('                console.error(''Erro:'', error);');
    add('                alert(''Erro ao gerar PDF. Por favor, tente novamente.'');');
    add('                // Restaura o botão em caso de erro');
    add('                printButton.disabled = false;');
    add('                printButton.innerHTML = ''<i class="bi bi-printer"></i>'';');
    add('            }');
    add('        }');
    add('');
    add('        function fecharJanela() {');
    add('            try {');
    add('                // Tenta primeiro o método do Delphi');
    add('                if (window.external && window.external.Close) {');
    add('                    window.external.Close();');
    add('                    return;');
    add('                }');
    add('');
    add('                // Tenta voltar para a página anterior');
    add('                if (window.history.length > 1) {');
    add('                    window.history.back();');
    add('                    return;');
    add('                }');
    add('');
    add('                // Se não conseguir voltar, tenta fechar a janela');
    add('                if (window.opener) {');
    add('                    window.close();');
    add('                    return;');
    add('                }');
    add('');
    add('                // Se nada funcionar, redireciona para a página inicial');
    add('                window.location.href = ''/'';');
    add('');
    add('            } catch (error) {');
    add('                console.error(''Erro ao fechar:'', error);');
    add('                // Última tentativa: simplesmente fecha a janela');
    add('                window.close();');
    add('            }');
    add('        }');
    add('');
    add('        // Inicializa as datas quando o documento carregar');
    add('        document.addEventListener(''DOMContentLoaded'', (event) => {');
    add('            const dateInputStart = document.getElementById(''edData_I'');');
    add('            const dateInputEnd = document.getElementById(''edData_F'');');
    add('');
    add('            const today = new Date();');
    add('            const firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);');
    add('            const lastDayOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);');
    add('');
    add('            const formattedFirstDay = firstDayOfMonth.toISOString().split(''T'')[0];');
    add('            const formattedLastDay = lastDayOfMonth.toISOString().split(''T'')[0];');
    add('');
    add('            dateInputStart.value = formattedFirstDay;');
    add('            dateInputEnd.value = formattedLastDay;');
    add('        });');
    add('    </script>');
    add('</body>');
    add('</html>');


  end;

  //Result := vDataTables.Text;
  Result := Memo_HTML.Lines.Text;

end;

procedure TfrmCon_ServPrestados.BuscarCliente;
begin

end;

procedure TfrmCon_ServPrestados.edClienteRightButtonClick(Sender: TObject);
begin
  BuildDataTable;
  //PrismSession.Reloading;
end;

procedure TfrmCon_ServPrestados.ExportD2Bridge;
begin
  inherited;

  Title:= '';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'Tabela.html';

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

      with PanelGroup(lbCliente.Caption,'',False,CSSClass.Col.colsize8).Items.Add do
      begin
        FormGroup('',CSSClass.Col.colsize12).AddVCLObj(edCliente);
      end;
    end;

    VCLObj(lbHrAcum_Hr);
    VCLObj(lbHrAcum_Vlr);
    VCLObj(lbHrAcum_HrG);
    VCLObj(lbHrAcum_VlrG);

    VCLObj(lbHr_Trab_Hr);
    VCLObj(lbHr_Trab_Vlr);
    VCLObj(lbHr_Trab_HrG);
    VCLObj(lbHr_Trab_VlrG);

    VCLObj(lbHr_Pagas_Hr);
    VCLObj(lbHr_Pagas_Vlr);

    VCLObj(lbHr_Total_Hr);
    VCLObj(lbHr_Total_Vlr);
    VCLObj(lbHr_Total_Hr_F);
    VCLObj(lbHr_Total_Vlr_F);

    VCLObj(btPesquisa);



    //with Row.Items.Add do
    //  HTMLElement(BuildDataTable);

    //VCLObj(Memo_HTML);

  end;

end;

procedure TfrmCon_ServPrestados.FormCreate(Sender: TObject);
begin
  inherited;
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

  FFuncoes_Wnd := TFuncoes_Wnd.Create;

end;

function TfrmCon_ServPrestados.GetClienteID: Integer;
begin

end;

function TfrmCon_ServPrestados.GetClienteNome: string;
begin

end;

function TfrmCon_ServPrestados.GetDataFinal: string;
begin

end;

function TfrmCon_ServPrestados.GetDataInicial: string;
begin
end;

procedure TfrmCon_ServPrestados.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

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

function TfrmCon_ServPrestados.Pesquisar: TJSONObject;
var
  FResp :IResponse;
  FBody :TJSONObject;

  FData_I :String;
  FData_F :String;

  x:Integer;
begin
  try
    try

      FData_I := '';
      FData_F := '';

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
        Result := FBody;

      end
      else
      begin
        ShowMessage(FResp.StatusCode.ToString + ' - ' + FResp.Content,True,True,10000);
      end;

    except on E: Exception do
      ShowMessage(E.Message,True,True,10000);
    end;
  finally
  end;
end;

procedure TfrmCon_ServPrestados.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmCon_ServPrestados.SetClienteID(const Value: Integer);
begin

end;

procedure TfrmCon_ServPrestados.SetClienteNome(const Value: string);
begin

end;

procedure TfrmCon_ServPrestados.SetDataFinal(const Value: string);
begin

end;

procedure TfrmCon_ServPrestados.SetDataInicial(const Value: string);
begin

end;

procedure TfrmCon_ServPrestados.WebViewExecuteScript(Sender: TCustomEdgeBrowser; AResult: string);
begin
  //
end;

end.
