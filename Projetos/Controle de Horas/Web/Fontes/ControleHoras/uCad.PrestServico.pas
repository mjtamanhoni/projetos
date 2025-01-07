unit uCad.PrestServico;

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

  uCad.PrestServico.Add;

type
  TfrmCad_PrestServico = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    FDMem_RegistroID: TIntegerField;
    dmRegistro: TDataSource;
    DBGrid: TDBGrid;
    pnHeader: TPanel;
    lbTipo: TLabel;
    lbPesquisar: TLabel;
    cbTipo: TComboBox;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    btNovo: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    FDMem_RegistroNOME: TStringField;
    FDMem_RegistroCELULAR: TStringField;
    FDMem_RegistroEMAIL: TStringField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHF_CADASTRO: TTimeField;
    procedure btPesquisarClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmCad_PrestServico_Add :TfrmCad_PrestServico_Add;

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

function frmCad_PrestServico:TfrmCad_PrestServico;

implementation

Uses
  ControleHorasWebApp;

{$R *.dfm}

function frmCad_PrestServico:TfrmCad_PrestServico;
begin
  result:= TfrmCad_PrestServico(TfrmCad_PrestServico.GetInstance);
end;

procedure TfrmCad_PrestServico.btEditarClick(Sender: TObject);
begin

  if IsD2BridgeContext then
  begin
    FfrmCad_PrestServico_Add.edID.Text := FDMem_RegistroID.AsString;
    FfrmCad_PrestServico_Add.edNome.Text := FDMem_RegistroNOME.AsString;
    FfrmCad_PrestServico_Add.edCELULAR.Text := FDMem_RegistroCELULAR.AsString;
    FfrmCad_PrestServico_Add.edEMAIL.Text := FDMem_RegistroEMAIL.AsString;
    FfrmCad_PrestServico_Add.Status_Tabela := 1;

    ShowPopupModal('PopupCadPrestServAdd');
  end
  else
  begin
    FfrmCad_PrestServico_Add := TfrmCad_PrestServico_Add.Create(Self);
    FfrmCad_PrestServico_Add.ShowModal;
  end;
  Pesquisar;

end;

procedure TfrmCad_PrestServico.btExcluirClick(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir o Prestador de Serviço selecionada?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(ControleHoras.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('prestadorServico')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;

end;

procedure TfrmCad_PrestServico.btNovoClick(Sender: TObject);
begin

  if IsD2BridgeContext then
  begin
    FfrmCad_PrestServico_Add.FDMem_Registro.Active := False;
    FfrmCad_PrestServico_Add.FDMem_Registro.Active := True;

    FfrmCad_PrestServico_Add.edID.Text := '';
    FfrmCad_PrestServico_Add.edNome.Text := '';
    FfrmCad_PrestServico_Add.edCELULAR.Text := '';
    FfrmCad_PrestServico_Add.edEMAIL.Text := '';
    FfrmCad_PrestServico_Add.Status_Tabela := 0;

    ShowPopupModal('PopupCadPrestServAdd')
  end
  else
  begin
    FfrmCad_PrestServico_Add := TfrmCad_PrestServico_Add.Create(Self);
    FfrmCad_PrestServico_Add.ShowModal;
  end;
  Pesquisar;

end;

procedure TfrmCad_PrestServico.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_PrestServico.ExportD2Bridge;
begin
  inherited;

  Title:= 'Prestadores de Serviços';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmCad_PrestServico_Add := TfrmCad_PrestServico_Add.Create(Self);
  D2Bridge.AddNested(FfrmCad_PrestServico_Add);

  with D2Bridge.Items.add do
  begin
    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbTipo.Caption,CSSClass.Col.colsize1).AddVCLObj(cbTipo);
        FormGroup(lbPesquisar.Caption,CSSClass.Col.colsize6).AddVCLObj(edPesquisar);

        FormGroup('',CSSClass.Col.colsize2).AddVCLObj(btPesquisar,CSSClass.Button.search);
        FormGroup('',CSSClass.Col.colsize1).AddVCLObj(btNovo,CSSClass.Button.add);
        FormGroup('',CSSClass.Col.colsize1).AddVCLObj(btEditar,CSSClass.Button.edit);
        FormGroup('',CSSClass.Col.colsize1).AddVCLObj(btExcluir,CSSClass.Button.delete);
      end;
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    //Abrindo formulário popup
    with Popup('PopupCadPrestServAdd','Cadastro de Prestador de Serviço').Items.Add do
      Nested(FfrmCad_PrestServico_Add);
  end;

end;

procedure TfrmCad_PrestServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmCad_PrestServico.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmCad_PrestServico.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_PrestServico.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TfrmCad_PrestServico.Pesquisar;
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
      1:FTipoPesquisa := 'nome';
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
               .Resource('prestadorServico')
               .Accept('application/json')
               .Get;
    end
    else
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .Resource('prestadorServico')
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
          FDMem_RegistroNOME.AsString := FBody.Get(x).GetValue<String>('nome','');
          FDMem_RegistroCELULAR.AsString := FBody.Get(x).GetValue<String>('celular','');
          FDMem_RegistroEMAIL.AsString := FBody.Get(x).GetValue<String>('email','');
          FDMem_RegistroDT_CADASTRO.AsDateTime := StrToDateDef(FBody.Get(x).GetValue<String>('dtCadastro',''),Date);
          FDMem_RegistroHF_CADASTRO.AsDateTime := StrToTimeDef(FBody.Get(x).GetValue<String>('hfCadastro',''),Time);
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

procedure TfrmCad_PrestServico.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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