unit uCad.FormaPagto;

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

  uCad.FormaPagto.Add, uCad.Forma.Cond.Add,

  FireDAC.Stan.StorageBin;

type
  TfrmCad_FormaPagto = class(TfrmPrincipal)
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
    FDMem_RegistroDESCRICAO: TStringField;
    FDMem_RegistroCLASSIFICACAO: TStringField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroID: TIntegerField;
    pnGrid_Forma: TPanel;
    pnGrid_Cond: TPanel;
    DBGrid_Cond: TDBGrid;
    pnCond: TPanel;
    btCond_Del: TButton;
    btCond_Add: TButton;
    pnGrid_Forma_Header: TPanel;
    lbGrid_Forma_Header: TLabel;
    pnGrid_Cond_Header: TPanel;
    lbGrid_Cond_Header: TLabel;
    FDMem_Condicao: TFDMemTable;
    DS_Condicao: TDataSource;
    FDMem_CondicaoID: TIntegerField;
    FDMem_CondicaoID_FORMA_PAGAMENTO: TIntegerField;
    FDMem_CondicaoID_CONDICAO_PAGAMENTO: TIntegerField;
    FDMem_CondicaoDT_CADASTRO: TDateField;
    FDMem_CondicaoHR_CADASTRO: TTimeField;
    FDMem_CondicaoCONDICAO: TStringField;
    FDMem_CondicaoFORMA: TStringField;
    FDMem_FormaCond_Pagto: TFDMemTable;
    FDMem_FormaCond_PagtoID: TIntegerField;
    FDMem_FormaCond_PagtoID_FORMA_PAGAMENTO: TIntegerField;
    FDMem_FormaCond_PagtoID_CONDICAO_PAGAMENTO: TIntegerField;
    FDMem_FormaCond_PagtoDT_CADASTRO: TDateField;
    FDMem_FormaCond_PagtoHR_CADASTRO: TTimeField;
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCond_AddClick(Sender: TObject);
    procedure btCond_DelClick(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
  private
    FfrmCad_FormaPagto_Add :TfrmCad_FormaPagto_Add;
    FfrmFormaCond_Add :TfrmFormaCond_Add;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;
    FListar_Condicoes :Boolean;

    procedure Pesquisar;
    procedure PesquisarCond(AFormaID:Integer);
    procedure Inserir_Condicao;
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmCad_FormaPagto:TfrmCad_FormaPagto;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_FormaPagto:TfrmCad_FormaPagto;
begin
  result:= TfrmCad_FormaPagto(TfrmCad_FormaPagto.GetInstance);
end;

procedure TfrmCad_FormaPagto.btCond_AddClick(Sender: TObject);
var
  FInserir :Boolean;
begin
  inherited;
  FInserir := True;

  if IsD2BridgeContext then
  begin
    ShowPopupModal('PopupCadFormaCondPagtoAdd');
  end
  else
  begin
    FfrmFormaCond_Add := TfrmFormaCond_Add.Create(Self);
    FfrmFormaCond_Add.ShowModal;
  end;

  {$Region 'Inserindo a Condição de pagamento'}
    if ControleHoras.Cond_Pagto_ID > 0 then
    begin
      if not FDMem_Condicao.IsEmpty then
      begin
        FDMem_Condicao.DisableControls;
        FDMem_Condicao.First;
        while not FDMem_Condicao.Eof do
        begin
          if ((FDMem_CondicaoID_FORMA_PAGAMENTO.AsInteger = FDMem_RegistroID.AsInteger) and
              (FDMem_CondicaoID_CONDICAO_PAGAMENTO.AsInteger = ControleHoras.Cond_Pagto_ID)) then
          begin
            FInserir := False;
          end;
        end;
      end;

      Inserir_Condicao;
    end;
  {$EndRegion 'Inserindo a Condição de pagamento'}

  Pesquisar;
end;

procedure TfrmCad_FormaPagto.Inserir_Condicao;
var
  FResp :IResponse;
  FBody :TJSONArray;
begin
  //Salvando o Fornecedor...
  try
    try

      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');
      if ControleHoras.Cond_Pagto_ID = 0 then
        raise Exception.Create('Não há condição selecionada para ser inserida');

     FDMem_FormaCond_Pagto.Active := False;
     FDMem_FormaCond_Pagto.Active := True;
     FDMem_FormaCond_Pagto.Insert;
      FDMem_FormaCond_PagtoID.AsInteger := 0;
      FDMem_FormaCond_PagtoID_FORMA_PAGAMENTO.AsInteger := FDMem_RegistroID.AsInteger;
      FDMem_FormaCond_PagtoID_CONDICAO_PAGAMENTO.AsInteger := ControleHoras.Cond_Pagto_ID;
      FDMem_FormaCond_PagtoDT_CADASTRO.AsDateTime := Date;
      FDMem_FormaCond_PagtoHR_CADASTRO.AsDateTime := Time;
     FDMem_FormaCond_Pagto.Post;

      FBody := FDMem_FormaCond_Pagto.ToJSONArray;
      FResp := TRequest.New.BaseURL(FHost)
               .Resource('formaCondPagto')
               .TokenBearer(ControleHoras.Usuario_Token)
               .AddBody(FBody)
               .Accept('application/json')
               .Post;

      if FResp.StatusCode <> 200 then
        raise Exception.Create(FResp.Content);

    except on E: Exception do
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    end;
  finally
  end;
end;

procedure TfrmCad_FormaPagto.btCond_DelClick(Sender: TObject);
var
  FResp :IResponse;
begin
  try
    if MessageDlg('Deseja excluir a Condição de Pagamento selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if Trim(ControleHoras.Usuario_Token) = '' then
        raise Exception.Create('Token do Usuário inválido');

      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .AddParam('idForma',FDMem_CondicaoID_FORMA_PAGAMENTO.AsString)
               .AddParam('idCond',FDMem_CondicaoID_CONDICAO_PAGAMENTO.AsString)
               .Resource('formaCondPagto')
               .Accept('application/json')
               .Delete;

      Pesquisar;
    end;
  except on E: Exception do
    MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
  end;
end;

procedure TfrmCad_FormaPagto.btEditarClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_FormaPagto_Add.edID.Text := FDMem_RegistroID.AsString;
    FfrmCad_FormaPagto_Add.edDESCRICAO.Text := FDMem_RegistroDESCRICAO.AsString;

    FfrmCad_FormaPagto_Add.rbDINHEIRO.Checked := False;
    FfrmCad_FormaPagto_Add.rbCREDIARIO.Checked := False;
    FfrmCad_FormaPagto_Add.rbBOLETO.Checked := False;
    FfrmCad_FormaPagto_Add.rbPIX.Checked := False;
    FfrmCad_FormaPagto_Add.rbCARTAO_DEBITO.Checked := False;
    FfrmCad_FormaPagto_Add.rbCARTAO_CREDITO.Checked := False;
    FfrmCad_FormaPagto_Add.rbCHEQUE_A_VISTA.Checked := False;
    FfrmCad_FormaPagto_Add.rbCHEQUE_A_PRAZO.Checked := False;

    if FDMem_RegistroCLASSIFICACAO.AsString = 'DINHEIRO' then
      FfrmCad_FormaPagto_Add.rbDINHEIRO.Checked := True
    else if FDMem_RegistroCLASSIFICACAO.AsString = 'CREDIARIO' then
      FfrmCad_FormaPagto_Add.rbCREDIARIO.Checked := True
    else if FDMem_RegistroCLASSIFICACAO.AsString = 'BOLETO' then
      FfrmCad_FormaPagto_Add.rbBOLETO.Checked := True
    else if FDMem_RegistroCLASSIFICACAO.AsString = 'PIX' then
      FfrmCad_FormaPagto_Add.rbPIX.Checked := True
    else if FDMem_RegistroCLASSIFICACAO.AsString = 'CARTAO DEBITO' then
      FfrmCad_FormaPagto_Add.rbCARTAO_DEBITO.Checked := True
    else if FDMem_RegistroCLASSIFICACAO.AsString = 'CARTAO CREDITO' then
      FfrmCad_FormaPagto_Add.rbCARTAO_CREDITO.Checked := True
    else if FDMem_RegistroCLASSIFICACAO.AsString = 'CHEQUE A VISTA' then
      FfrmCad_FormaPagto_Add.rbCHEQUE_A_VISTA.Checked := True
    else if FDMem_RegistroCLASSIFICACAO.AsString = 'CHEQUE A PRAZO' then
      FfrmCad_FormaPagto_Add.rbCHEQUE_A_PRAZO.Checked := True;

    FfrmCad_FormaPagto_Add.Status_Tabela := 1;

    ShowPopupModal('PopupCadFormaPagtoAdd');
  end
  else
  begin
    FfrmCad_FormaPagto_Add := TfrmCad_FormaPagto_Add.Create(Self);
    FfrmCad_FormaPagto_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_FormaPagto.btExcluirClick(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir a Forma de Pagamento selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(ControleHoras.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('formaPagto')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmCad_FormaPagto.btNovoClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmCad_FormaPagto_Add.FDMem_Registro.Active := False;
    FfrmCad_FormaPagto_Add.FDMem_Registro.Active := True;

    FfrmCad_FormaPagto_Add.edID.Text := '';
    FfrmCad_FormaPagto_Add.edDESCRICAO.Text := '';
    FfrmCad_FormaPagto_Add.rbDINHEIRO.Checked := False;
    FfrmCad_FormaPagto_Add.rbCREDIARIO.Checked := False;
    FfrmCad_FormaPagto_Add.rbBOLETO.Checked := False;
    FfrmCad_FormaPagto_Add.rbPIX.Checked := False;
    FfrmCad_FormaPagto_Add.rbCARTAO_DEBITO.Checked := False;
    FfrmCad_FormaPagto_Add.rbCARTAO_CREDITO.Checked := False;
    FfrmCad_FormaPagto_Add.rbCHEQUE_A_VISTA.Checked := False;
    FfrmCad_FormaPagto_Add.rbCHEQUE_A_PRAZO.Checked := False;

    FfrmCad_FormaPagto_Add.Status_Tabela := 0;

    ShowPopupModal('PopupCadFormaPagtoAdd')
  end
  else
  begin
    FfrmCad_FormaPagto_Add := TfrmCad_FormaPagto_Add.Create(Self);
    FfrmCad_FormaPagto_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_FormaPagto.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_FormaPagto.DBGridCellClick(Column: TColumn);
begin
  inherited;
  PesquisarCond(DBGrid.DataSource.Dataset.FieldByName('ID').AsInteger);
end;

procedure TfrmCad_FormaPagto.ExportD2Bridge;
begin
  inherited;

  Title:= 'Forma de Pagamento';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmCad_FormaPagto_Add := TfrmCad_FormaPagto_Add.Create(Self);
  D2Bridge.AddNested(FfrmCad_FormaPagto_Add);

  //Configurações do Form Popup
  FfrmFormaCond_Add := TfrmFormaCond_Add.Create(Self);
  D2Bridge.AddNested(FfrmFormaCond_Add);

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

    with Row.Items.Add do
    begin
     {$Region 'Grid Forma pagamento'}
      with Card do
       begin
        ColSize:= CSSClass.Col.colsize8;

        Header.Text:= lbGrid_Forma_Header.Caption;

        Title := '';
        Text:= '';
        SubTitle:= '';

        with Items.Add do
        begin
         VCLObj(DBGrid);
        end;

       end;
     {$ENDREGION 'Grid Forma pagamento'}

     {$Region 'Grid Condição pagamento'}
      with Card do
       begin
        ColSize:= CSSClass.Col.colsize4;

        Header.Text:= lbGrid_Cond_Header.Caption;

        Title := '';
        Text:= '';
        SubTitle:= '';

        with Items.Add do
        begin
         VCLObj(DBGrid_Cond);
        end;

        with Footer.Items.Add do
        begin
          VCLObj(btCond_Add,CSSClass.Button.add + CSSClass.Col.colsize1);
          VCLObj(btCond_Del,CSSClass.Button.delete + CSSClass.Col.colsize1);
        end;

       end;
     {$ENDREGION 'Grid Condição pagamento'}
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
    with Popup('PopupCadFormaPagtoAdd','Cadastro de Forma de Pagamento').Items.Add do
      Nested(FfrmCad_FormaPagto_Add);
    with Popup('PopupCadFormaCondPagtoAdd','Cadastro de Condições de Pagamento da Forma').Items.Add do
      Nested(FfrmFormaCond_Add);
  end;

end;

procedure TfrmCad_FormaPagto.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmCad_FormaPagto.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

  FListar_Condicoes := False;
end;

procedure TfrmCad_FormaPagto.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_FormaPagto.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_FormaPagto.Pesquisar;
var
  FResp :IResponse;
  FBody :TJSONArray;
  FTipoPesquisa:String;
  x:Integer;
begin
  try
    try
      FListar_Condicoes := False;

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
                 .Resource('formaPagto')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(ControleHoras.Usuario_Token)
                 .Resource('formaPagto')
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
            FDMem_RegistroCLASSIFICACAO.AsString := FBody.Get(x).GetValue<String>('classificacao','');
            FDMem_RegistroDT_CADASTRO.AsDateTime := StrToDateDef(FBody.Get(x).GetValue<String>('dtCadastro',''),Date);
            FDMem_RegistroHR_CADASTRO.AsDateTime := StrToTimeDef(FBody.Get(x).GetValue<String>('hrCadastro',''),Time);
          FDMem_Registro.Post;
        end;

      end;

    except on E: Exception do
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    end;
  finally
    FDMem_Registro.First;
    FDMem_Registro.EnableControls;
    FListar_Condicoes := True;
    PesquisarCond(FDMem_RegistroID.AsInteger);
  end;
end;

procedure TfrmCad_FormaPagto.PesquisarCond(AFormaID: Integer);
var
  FResp :IResponse;
  FBody :TJSONArray;
  x:Integer;
begin
  try
    try
      FDMem_Condicao.Active := False;
      FDMem_Condicao.Active := True;
      FDMem_Condicao.DisableControls;

      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if Trim(ControleHoras.Usuario_Token) = '' then
        raise Exception.Create('Token do Usuário inválido');

      if AFormaID > 0 then
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(ControleHoras.Usuario_Token)
                 .AddParam('condFormaId',AFormaID.ToString)
                 .Resource('formaCondPagto')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(ControleHoras.Usuario_Token)
                 .Resource('formaCondPagto')
                 .Accept('application/json')
                 .Get;
      end;

      if FResp.StatusCode = 200 then
      begin
        if FResp.Content = '' then
          raise Exception.Create('Condições de pagamento não localizados');

        FBody := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(FResp.Content),0) as TJSONArray;

        for x := 0 to FBody.Size - 1 do
        begin
          FDMem_Condicao.Insert;
            FDMem_CondicaoID.AsInteger := FBody.Get(x).GetValue<Integer>('id',0);
            FDMem_CondicaoID_FORMA_PAGAMENTO.AsInteger := FBody.Get(x).GetValue<Integer>('idFormaPagamento',0);
            FDMem_CondicaoID_CONDICAO_PAGAMENTO.AsInteger := FBody.Get(x).GetValue<Integer>('idCondicaoPagamento',0);
            FDMem_CondicaoCONDICAO.AsString := FBody.Get(x).GetValue<String>('condPagto','');
            FDMem_CondicaoFORMA.AsString := FBody.Get(x).GetValue<String>('formaPagto','');
            FDMem_CondicaoDT_CADASTRO.AsDateTime := StrToDateDef(FBody.Get(x).GetValue<String>('dtCadastro',''),Date);
            FDMem_CondicaoHR_CADASTRO.AsDateTime := StrToTimeDef(FBody.Get(x).GetValue<String>('hrCadastro',''),Time);
          FDMem_Condicao.Post;
        end;

      end;
    except on E: Exception do
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
    end;
  finally
    FDMem_Condicao.First;
    FDMem_Condicao.EnableControls;
  end;
end;

procedure TfrmCad_FormaPagto.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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