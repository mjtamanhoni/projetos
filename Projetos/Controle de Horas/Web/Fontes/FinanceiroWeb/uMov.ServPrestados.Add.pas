unit uMov.ServPrestados.Add;


{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  DateUtils,

  System.Generics.Collections, D2Bridge,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, Vcl.ComCtrls, uPrincipal, SHDocVw, MSHTML, ActiveX, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls,
  uCon.Empresa, uCon.PrestServicos, uCon.Cliente, uCon.TabPreco, uCon.Contas; // Para manipulação COM;

type
  TStatusTable = (stInsert,stEdit);

  TfrmMov_ServPrestados_Add = class(TfrmPrincipal)
    lbid: TLabel;
    edid: TEdit;
    lbdescricao: TLabel;
    eddescricao: TEdit;
    lbstatus: TLabel;
    cbstatus: TComboBox;
    lbid_empresa: TLabel;
    lbid_prestador_servico: TLabel;
    lbid_cliente: TLabel;
    lbid_tabela: TLabel;
    edid_tabela_Vlr: TEdit;
    lbid_conta: TLabel;
    edid_conta_tipo: TEdit;
    eddt_registro: TDateTimePicker;
    lbdt_registro: TLabel;
    edhr_inicio: TDateTimePicker;
    lbhr_inicio: TLabel;
    lbhr_fim: TLabel;
    edhr_fim: TDateTimePicker;
    lbhr_total: TLabel;
    lbvlr_hora: TLabel;
    edvlr_hora: TEdit;
    lbsub_total: TLabel;
    edsub_total: TEdit;
    eddesconto: TEdit;
    lbdesconto: TLabel;
    edacrescimo: TEdit;
    lbacrescimo: TLabel;
    lbtotal: TLabel;
    edtotal: TEdit;
    lbobservacao: TLabel;
    edobservacao: TEdit;
    edhr_total: TEdit;
    Button1: TButton;
    btConfirmar: TButton;
    btCancelar: TButton;
    ImageList: TImageList;
    edid_empresa: TButtonedEdit;
    edid_prestador_servico: TButtonedEdit;
    edid_cliente: TButtonedEdit;
    edid_tabela: TButtonedEdit;
    edid_conta: TButtonedEdit;
    lbdtPago: TLabel;
    eddtPago: TDateTimePicker;
    lbvlrPago: TLabel;
    edvlrPago: TEdit;
    procedure btCancelarClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btid_empresaClick(Sender: TObject);
    procedure btid_prestador_servicoClick(Sender: TObject);
    procedure btid_clienteClick(Sender: TObject);
    procedure btid_tabelaClick(Sender: TObject);
    procedure btid_contaClick(Sender: TObject);
    procedure eddt_registroKeyPress(Sender: TObject; var Key: Char);
    procedure cbstatusKeyPress(Sender: TObject; var Key: Char);
    procedure eddescricaoKeyPress(Sender: TObject; var Key: Char);
    procedure edid_empresaKeyPress(Sender: TObject; var Key: Char);
    procedure edid_prestador_servicoKeyPress(Sender: TObject; var Key: Char);
    procedure edid_clienteKeyPress(Sender: TObject; var Key: Char);
    procedure edid_tabelaKeyPress(Sender: TObject; var Key: Char);
    procedure edid_contaKeyPress(Sender: TObject; var Key: Char);
    procedure edhr_inicioKeyPress(Sender: TObject; var Key: Char);
    procedure edhr_fimKeyPress(Sender: TObject; var Key: Char);
    procedure edsub_totalKeyPress(Sender: TObject; var Key: Char);
    procedure eddescontoKeyPress(Sender: TObject; var Key: Char);
    procedure edacrescimoKeyPress(Sender: TObject; var Key: Char);
    procedure edid_empresaRightButtonClick(Sender: TObject);
    procedure edid_prestador_servicoRightButtonClick(Sender: TObject);
    procedure edid_clienteRightButtonClick(Sender: TObject);
    procedure edid_tabelaRightButtonClick(Sender: TObject);
    procedure edid_contaRightButtonClick(Sender: TObject);
    procedure edsub_totalChange(Sender: TObject);
    procedure edhr_inicioChange(Sender: TObject);
  private
    FTabela_Valor :Double;
    FEmpresaTemp: string;
    FPrestadorTemp: string;
    FClienteTemp: string;
    FTable_Status: TStatusTable;

    FTab_Preco_Valor :Double;
    FTab_Preco_Tipo :Integer;
    FTab_Preco_Tipo_Desc :String;

    FConta_Tipo :Integer;
    FConta_Tipo_Desc :String;

    FfrmCon_Cliente :TfrmCon_Cliente;
    FfrmCon_PrestServicos :TfrmCon_PrestServicos;
    FfrmCon_Empresa :TfrmCon_Empresa;
    FfrmCon_Contas :TfrmCon_Contas;
    FfrmCon_TabPreco :TfrmCon_TabPreco;

    procedure SalvarValoresAntesConsulta;
    procedure RestaurarValoresAposConsulta(const CampoAtualizado: string);

    procedure AtualizarCampoEmpresa;

  public
    property Table_Status :TStatusTable read FTable_Status write FTable_Status;
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmMov_ServPrestados_Add:TfrmMov_ServPrestados_Add;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmMov_ServPrestados_Add:TfrmMov_ServPrestados_Add;
begin
  result:= TfrmMov_ServPrestados_Add(TfrmMov_ServPrestados_Add.GetInstance);
end;

procedure TfrmMov_ServPrestados_Add.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMov_ServPrestados_Add.btConfirmarClick(Sender: TObject);
begin
  try
    if Trim(edid_empresa.Text) = '' then
      raise Exception.Create('Obrigatório informar a Empresa');
    if Trim(edid_prestador_servico.Text) = '' then
      raise Exception.Create('Obrigatório informar o Prestador de Serviço');
    if Trim(edid_cliente.Text) = '' then
      raise Exception.Create('Obrigatório informar o Cliente');
    if Trim(edid_tabela.Text) = '' then
      raise Exception.Create('Obrigatório informar a Tabela de Preço');
    if Trim(edid_conta.Text) = '' then
      raise Exception.Create('Obrigatório informar a Conta');
    if StrToFloatDef(Trim(StringReplace(edtotal.Text,'R$','',[rfReplaceAll])),0) = 0 then
      raise Exception.Create('Não há valor para ser gravado');




    Close;
  except on E: Exception do
    ShowMessage(E.Message,True,True,10000);
  end;
end;

procedure TfrmMov_ServPrestados_Add.btid_clienteClick(Sender: TObject);
begin
  inherited;
  SalvarValoresAntesConsulta;

  if frmCon_Cliente = Nil then
    TfrmCon_Cliente.CreateInstance;
  frmCon_Cliente.ShowModal;

  if FinanceiroWeb.Cliente_ID > 0 then
  begin
    //edid_cliente.Tag := FinanceiroWeb.Cliente_ID;
    edid_cliente.Text := FinanceiroWeb.Cliente_Nome;
    //RestaurarValoresAposConsulta('edid_cliente');
  end;
end;

procedure TfrmMov_ServPrestados_Add.btid_contaClick(Sender: TObject);
begin
  inherited;
  if frmCon_Contas = Nil then
    TfrmCon_Contas.CreateInstance;
  frmCon_Contas.ShowModal;

  if FinanceiroWeb.Conta_ID > 0 then
  begin
    //edid_conta.Tag := FinanceiroWeb.Conta_ID;
    edid_conta.Text := FinanceiroWeb.Conta_Descricao;
    //edid_conta_tipo.Tag := FinanceiroWeb.Conta_Tipo;
    //edid_conta_tipo.Text := FinanceiroWeb.Conta_Tipo_Desc;
  end;
end;

procedure TfrmMov_ServPrestados_Add.btid_empresaClick(Sender: TObject);
begin
  inherited;
  SalvarValoresAntesConsulta;

  if frmCon_Empresa = Nil then
    TfrmCon_Empresa.CreateInstance;
  frmCon_Empresa.ShowModal;

  if FinanceiroWeb.Empresa_ID > 0 then
  begin
    //edid_empresa.Tag := FinanceiroWeb.Empresa_ID;
    edid_empresa.Text := FinanceiroWeb.Empresa_Nome;
    //RestaurarValoresAposConsulta('edid_empresa');
  end;
end;

procedure TfrmMov_ServPrestados_Add.btid_prestador_servicoClick(Sender: TObject);
begin
  inherited;
  SalvarValoresAntesConsulta;

  if frmCon_PrestServicos = Nil then
    TfrmCon_PrestServicos.CreateInstance;
  frmCon_PrestServicos.ShowModal;

  if FinanceiroWeb.Prest_Servico_ID > 0 then
  begin
    //edid_prestador_servico.Tag := FinanceiroWeb.Prest_Servico_ID;
    edid_prestador_servico.Text := FinanceiroWeb.Prest_Servico_Nome;
    //RestaurarValoresAposConsulta('edid_prestador_servico');
  end;
end;

procedure TfrmMov_ServPrestados_Add.btid_tabelaClick(Sender: TObject);
begin
  inherited;
  if frmCon_TabPreco = Nil then
    TfrmCon_TabPreco.CreateInstance;
  frmCon_TabPreco.ShowModal;

  if FinanceiroWeb.Tab_Preco_ID > 0 then
  begin
    //edid_tabela.Tag := FinanceiroWeb.Tab_Preco_ID;
    edid_tabela.Text := FinanceiroWeb.Tab_Preco_Nome;
    //edid_tabela_Vlr.Text := FormatFloat('R$ #,##0.00',FinanceiroWeb.Tab_Preco_Valor);
    //FTabela_Valor := 0;
    //FTabela_Valor := FinanceiroWeb.Tab_Preco_Valor;
  end;
end;

procedure TfrmMov_ServPrestados_Add.cbstatusKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    eddescricao.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edacrescimoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edobservacao.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.eddescontoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edacrescimo.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.eddescricaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edid_empresa.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.eddt_registroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    cbstatus.SetFocus;
end;

procedure TfrmMov_ServPrestados_Add.edhr_fimKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edsub_total.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edhr_inicioChange(Sender: TObject);
var
  FHora :TDateTime;
  FHora_Resultado :TTime;
  FTotal_Receber :Double;
  FValorHora :Double;
  FHor :String;
  FMin :String;
  FSeg :String;
begin
  inherited;

  try
    FTotal_Receber := 0;
    FHor := '';
    FMin := '';
    FSeg := '';

    FValorHora := 0;
    FValorHora := StrToFloatDef(Trim(StringReplace(edVLR_HORA.Text,'R$','',[rfReplaceAll])),0);


    FHora_Resultado := (edHR_FIM.Time - edHR_INICIO.Time);
    FHor := Format('%.3d',[HourOf(FHora_Resultado)]);
    if MinuteOf(FHora_Resultado) < 10 then
      FMin := Format('%.2d',[MinuteOf(FHora_Resultado)])
    else
      FMin := IntToStr(MinuteOf(FHora_Resultado));
    FSeg := '00';

    edHR_TOTAL.Text := FHor + ':' + FMin + ':' + FSeg;
    FTotal_Receber := ((FHora_Resultado * 24) * FValorHora);
    edSUB_TOTAL.Text := FormatFloat('R$ #,##0.00',FTotal_Receber);
    edSUB_TOTALChange(Sender);

  except on E: Exception do
    ShowMessage('Erro ao calcular os Totais de Horas e Valor. ' + E.Message,True,True,10000);
  end;
end;

procedure TfrmMov_ServPrestados_Add.edhr_inicioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edhr_fim.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edid_clienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edid_tabela.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edid_clienteRightButtonClick(Sender: TObject);
begin
  inherited;
  ShowPopupModal('Popup'+FfrmCon_Cliente.Name);

  if ((FinanceiroWeb.Cliente_ID > 0) and (Trim(FinanceiroWeb.Cliente_Nome) <> '')) then
  begin
    edid_cliente.Tag := FinanceiroWeb.Cliente_ID;
    edid_cliente.Text := FinanceiroWeb.Cliente_Nome;
  end;

end;

procedure TfrmMov_ServPrestados_Add.edid_contaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edhr_inicio.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edid_contaRightButtonClick(Sender: TObject);
begin
  inherited;
  ShowPopupModal('Popup'+FfrmCon_Contas.Name);

  if ((FinanceiroWeb.Conta_ID > 0) and (Trim(FinanceiroWeb.Conta_Descricao) <> '')) then
  begin
    edid_conta.Tag := FinanceiroWeb.Conta_ID;
    edid_conta.Text := FinanceiroWeb.Conta_Descricao;
    edid_conta_tipo.Tag := FinanceiroWeb.Conta_Tipo;
    edid_conta_tipo.Text := FinanceiroWeb.Conta_Tipo_Desc;
  end;

end;

procedure TfrmMov_ServPrestados_Add.edid_empresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edid_prestador_servico.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edid_empresaRightButtonClick(Sender: TObject);
begin
  inherited;
  ShowPopupModal('Popup'+FfrmCon_Empresa.Name);

  if ((FinanceiroWeb.Empresa_ID > 0) and (Trim(FinanceiroWeb.Empresa_Nome) <> '')) then
  begin
    edid_empresa.Tag := FinanceiroWeb.Empresa_ID;
    edid_empresa.Text := FinanceiroWeb.Empresa_Nome;
  end;

end;

procedure TfrmMov_ServPrestados_Add.edid_prestador_servicoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edid_cliente.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edid_prestador_servicoRightButtonClick(Sender: TObject);
begin
  inherited;
  ShowPopupModal('Popup'+FfrmCon_PrestServicos.Name);

  if ((FinanceiroWeb.Prest_Servico_ID > 0) and (Trim(FinanceiroWeb.Prest_Servico_Nome) <> '')) then
  begin
    edid_prestador_servico.Tag := FinanceiroWeb.Prest_Servico_ID;
    edid_prestador_servico.Text := FinanceiroWeb.Prest_Servico_Nome;
  end;

end;

procedure TfrmMov_ServPrestados_Add.edid_tabelaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edid_conta.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.edid_tabelaRightButtonClick(Sender: TObject);
begin
  inherited;
  ShowPopupModal('Popup'+FfrmCon_TabPreco.Name);

  if ((FinanceiroWeb.Tab_Preco_ID > 0) and (Trim(FinanceiroWeb.Tab_Preco_Nome) <> '')) then
  begin
    edid_tabela.Tag := FinanceiroWeb.Tab_Preco_ID;
    edid_tabela.Text := FinanceiroWeb.Tab_Preco_Nome;
    edid_tabela_Vlr.Text := FormatFloat('R$ #,##0.00',FinanceiroWeb.Tab_Preco_Valor);
    edvlr_hora.Text := FormatFloat('R$ #,##0.00',FinanceiroWeb.Tab_Preco_Valor);
    FTab_Preco_Valor := FinanceiroWeb.Tab_Preco_Valor;
    FTab_Preco_Tipo := FinanceiroWeb.Tab_Preco_Tipo;
    FTab_Preco_Tipo_Desc := FinanceiroWeb.Tab_Preco_Tipo_Desc;
  end;

end;

procedure TfrmMov_ServPrestados_Add.edsub_totalChange(Sender: TObject);
var
  FSub_Total :Double;
  FDesconto :Double;
  FAcrescimo :Double;
  FTotal :Double;
begin
  inherited;
  try
    FSub_Total := 0;
    FDesconto := 0;
    FAcrescimo := 0;
    FTotal := 0;

    FDesconto := StrToFloatDef(Trim(StringReplace(edDESCONTO.Text,'R$','',[rfReplaceAll])),0);
    FAcrescimo := StrToFloatDef(Trim(StringReplace(edACRESCIMO.Text,'R$','',[rfReplaceAll])),0);

    FSub_Total := StrToFloatDef(Trim(StringReplace(edSUB_TOTAL.Text,'R$','',[rfReplaceAll])),0);
    FTotal := ((FSub_Total + FAcrescimo) - FDesconto);
    edTOTAL.Text := FormatFloat('R$ #,##0.00',FTotal);

  except on E: Exception do
    ShowMessage('Erro ao calcular o valor total. ' + E.Message,True,True,10000);
  end;
end;

procedure TfrmMov_ServPrestados_Add.edsub_totalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    eddesconto.SetFocus;

end;

procedure TfrmMov_ServPrestados_Add.ExportD2Bridge;
begin
  inherited;

  Title:= 'Lançamentos dos Serviços Prestados';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= 'forms-servicosPrestados.html';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'forms-cadastro-serprestados.html';

  if FfrmCon_Cliente = Nil then
    FfrmCon_Cliente := TfrmCon_Cliente.Create(Self);
  D2Bridge.AddNested(FfrmCon_Cliente);

  if FfrmCon_PrestServicos = Nil then
    FfrmCon_PrestServicos := TfrmCon_PrestServicos.Create(Self);
  D2Bridge.AddNested(FfrmCon_PrestServicos);

  if FfrmCon_Empresa = Nil then
    FfrmCon_Empresa := TfrmCon_Empresa.Create(Self);
  D2Bridge.AddNested(FfrmCon_Empresa);

  if FfrmCon_Contas = Nil then
    FfrmCon_Contas := TfrmCon_Contas.Create(Self);
  D2Bridge.AddNested(FfrmCon_Contas);

  if FfrmCon_TabPreco = Nil then
    FfrmCon_TabPreco := TfrmCon_TabPreco.Create(Self);
  D2Bridge.AddNested(FfrmCon_TabPreco);


  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      FormGroup(lbid.Caption,CSSClass.Col.colsize2).AddVCLObj(edid);
      FormGroup(lbdt_registro.Caption,CSSClass.Col.colsize3).AddVCLObj(eddt_registro);
      FormGroup(lbstatus.Caption,CSSClass.Col.colsize3).AddVCLObj(cbstatus);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbdescricao.Caption,CSSClass.Col.colsize12).AddVCLObj(eddescricao);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbid_empresa.Caption,CSSClass.Col.colsize12).AddVCLObj(edid_empresa);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbid_prestador_servico.Caption,CSSClass.Col.colsize12).AddVCLObj(edid_prestador_servico);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbid_cliente.Caption,CSSClass.Col.colsize12).AddVCLObj(edid_cliente);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbid_tabela.Caption,CSSClass.Col.colsize9).AddVCLObj(edid_tabela);
      FormGroup('',CSSClass.Col.colsize3).AddVCLObj(edid_tabela_Vlr);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbid_conta.Caption,CSSClass.Col.colsize9).AddVCLObj(edid_conta);
      FormGroup('',CSSClass.Col.colsize3).AddVCLObj(edid_conta_tipo);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbhr_inicio.Caption,CSSClass.Col.colsize3).AddVCLObj(edhr_inicio);
      FormGroup(lbhr_fim.Caption,CSSClass.Col.colsize3).AddVCLObj(edhr_fim);
      FormGroup(lbhr_total.Caption,CSSClass.Col.colsize3).AddVCLObj(edhr_total);
      FormGroup(lbvlr_hora.Caption,CSSClass.Col.colsize3).AddVCLObj(edvlr_hora);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbsub_total.Caption,CSSClass.Col.colsize3).AddVCLObj(edsub_total);
      FormGroup(lbdesconto.Caption,CSSClass.Col.colsize3).AddVCLObj(eddesconto);
      FormGroup(lbacrescimo.Caption,CSSClass.Col.colsize3).AddVCLObj(edacrescimo);
      FormGroup(lbtotal.Caption,CSSClass.Col.colsize3).AddVCLObj(edtotal);
    end;

    with Row.Items.Add do
    begin
      FormGroup(lbobservacao.Caption,CSSClass.Col.colsize12).AddVCLObj(edobservacao);
    end;

    if FinanceiroWeb.Stauts_Tab_SP = 'EDIT' then
    begin
      with PanelGroup('Dados do Pagamento','',False,CSSClass.Col.colsize12).Items.Add do
      begin
        with Row.Items.Add do
        begin
          FormGroup(lbdtPago.Caption,CSSClass.Col.colsize3).AddVCLObj(eddtPago);
          FormGroup(lbvlrPago.Caption,CSSClass.Col.colsize3).AddVCLObj(edvlrPago);
        end;
      end;
    end;

    with Card.Items.Add do
    begin
      with Row(CSSClass.DivHtml.Align_Right).Items.Add do
      begin
        VCLObj(btConfirmar, CSSClass.Button.save + CSSClass.Col.colsize3);
        VCLObj(btCancelar, CSSClass.Button.cancel + CSSClass.Col.colsize3);
      end;
    end;

    Popup('Popup'+FfrmCon_Cliente.Name,'Clientes',True,CSSClass.Popup.ExtraLarge).Items.Add.Nested(FfrmCon_Cliente.Name);
    Popup('Popup'+FfrmCon_PrestServicos.Name,'Prestadores de Serviços',True,CSSClass.Popup.Large).Items.Add.Nested(FfrmCon_PrestServicos.Name);
    Popup('Popup'+FfrmCon_Empresa.Name,'Empresas',True,CSSClass.Popup.Large).Items.Add.Nested(FfrmCon_Empresa.Name);
    Popup('Popup'+FfrmCon_Contas.Name,'Contas',True,CSSClass.Popup.Large).Items.Add.Nested(FfrmCon_Contas.Name);
    Popup('Popup'+FfrmCon_TabPreco.Name,'Tabelas de Preços',True,CSSClass.Popup.Large).Items.Add.Nested(FfrmCon_TabPreco.Name);

  end;

end;

procedure TfrmMov_ServPrestados_Add.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if FTable_Status = stInsert then
  begin
    eddt_registro.Date := Date;
  end;

  if FinanceiroWeb.Stauts_Tab_SP = 'INSERT' then
  begin
    eddt_registro.Date := Date;
  end;

  if PrismControl.VCLComponent = edsub_total then
    PrismControl.AsEdit.TextMask := TPrismTextMask.Currency('R$');
  if PrismControl.VCLComponent = eddesconto then
    PrismControl.AsEdit.TextMask := TPrismTextMask.Currency('R$');
  if PrismControl.VCLComponent = edacrescimo then
    PrismControl.AsEdit.TextMask := TPrismTextMask.Currency('R$');
  if PrismControl.VCLComponent = edtotal then
    PrismControl.AsEdit.TextMask := TPrismTextMask.Currency('R$');
  if PrismControl.VCLComponent = edhr_total then
    PrismControl.AsEdit.TextMask:= '''mask'' : ''999:99:99'''


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

procedure TfrmMov_ServPrestados_Add.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmMov_ServPrestados_Add.RestaurarValoresAposConsulta(const CampoAtualizado: string);
begin
  {
  if CampoAtualizado <> 'edid_empresa' then
    edid_empresa.Text := FEmpresaTemp;

  if CampoAtualizado <> 'edid_prestador_servico' then
    edid_prestador_servico.Text := FPrestadorTemp;

  if CampoAtualizado <> 'edid_cliente' then
    edid_cliente.Text := FClienteTemp;
  }
end;

procedure TfrmMov_ServPrestados_Add.SalvarValoresAntesConsulta;
begin
  {
  FEmpresaTemp := edid_empresa.Text;
  FPrestadorTemp := edid_prestador_servico.Text;
  FClienteTemp := edid_cliente.Text;
  }
end;

// No formulário principal
procedure TfrmMov_ServPrestados_Add.AtualizarCampoEmpresa;
begin
    {
  if FinanceiroWeb.Empresa_ID > 0 then
  begin
    WebBrowser.ExecScript(Format('document.getElementById("edid_empresa").value = "%s"',
      [FinanceiroWeb.Empresa_Nome]));
  end;
    }
end;

end.

