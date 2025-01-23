unit uCad.Usuarios;

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

  uCad.Usuarios.Add;

type
  TfrmCad_Usuarios = class(TfrmPrincipal)
    pnHeader: TPanel;
    lbTipo: TLabel;
    cbTipo: TComboBox;
    lbPesquisar: TLabel;
    edPesquisar: TEdit;
    btPesquisar: TButton;
    DBGrid: TDBGrid;
    FDMem_Registro: TFDMemTable;
    dmRegistro: TDataSource;
    FDMem_RegistroID: TIntegerField;
    FDMem_RegistroNOME: TStringField;
    FDMem_RegistroLOGIN: TStringField;
    FDMem_RegistroSENHA: TStringField;
    FDMem_RegistroPIN: TStringField;
    FDMem_RegistroCELULAR: TStringField;
    FDMem_RegistroEMAIL: TStringField;
    FDMem_RegistroID_EMPRESA: TIntegerField;
    FDMem_RegistroID_PRESTADOR_SERVICO: TIntegerField;
    FDMem_RegistroFOTO: TStringField;
    FDMem_RegistroDT_CADASTRO: TDateField;
    FDMem_RegistroHR_CADASTRO: TTimeField;
    FDMem_RegistroSINCRONIZADO: TIntegerField;
    FDMem_RegistroEMPRESA: TStringField;
    FDMem_RegistroPRESTADOR_SERVICO: TStringField;
    pnFooter: TPanel;
    btExcluir: TButton;
    btEditar: TButton;
    btNovo: TButton;
    FDMem_RegistroTIPO: TIntegerField;
    FDMem_RegistroID_CLIENTE: TIntegerField;
    FDMem_RegistroFORM_INICIAL: TStringField;
    FDMem_RegistroCLIENTE: TStringField;
    FDMem_RegistroTIPO_DESC: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FfrmUsuarios_Cad_Add :TfrmCad_Usuario_ADD;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    procedure Pesquisar;
    procedure Limpar_Campos;

  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmCad_Usuarios:TfrmCad_Usuarios;

implementation

Uses
  FinanceiroWebWebApp;

{$R *.dfm}

function frmCad_Usuarios:TfrmCad_Usuarios;
begin
  result:= TfrmCad_Usuarios(TfrmCad_Usuarios.GetInstance);
end;

procedure TfrmCad_Usuarios.btEditarClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmUsuarios_Cad_Add.FDMem_Registro.Active := False;
    FfrmUsuarios_Cad_Add.FDMem_Registro.Active := True;
    FfrmUsuarios_Cad_Add.FDMem_Registro.Edit;

    FfrmUsuarios_Cad_Add.FDMem_RegistroID.AsInteger := FDMem_RegistroID.AsInteger;
    FfrmUsuarios_Cad_Add.FDMem_RegistroNOME.AsString := FDMem_RegistroNOME.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroLOGIN.AsString := FDMem_RegistroLOGIN.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroSENHA.AsString := FDMem_RegistroSENHA.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroPIN.AsString := FDMem_RegistroPIN.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroCELULAR.AsString := FDMem_RegistroCELULAR.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroEMAIL.AsString := FDMem_RegistroEMAIL.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroID_EMPRESA.AsInteger := FDMem_RegistroID_EMPRESA.AsInteger;
    FfrmUsuarios_Cad_Add.FDMem_RegistroID_PRESTADOR_SERVICO.AsInteger := FDMem_RegistroID_PRESTADOR_SERVICO.AsInteger;
    FfrmUsuarios_Cad_Add.FDMem_RegistroFOTO.AsString := FDMem_RegistroFOTO.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroEMPRESA.AsString := FDMem_RegistroEMPRESA.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroPRESTADOR_SERVICO.AsString := FDMem_RegistroPRESTADOR_SERVICO.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroID_CLIENTE.AsInteger := FDMem_RegistroID_CLIENTE.AsInteger;
    FfrmUsuarios_Cad_Add.FDMem_RegistroCLIENTE.AsString := FDMem_RegistroCLIENTE.AsString;
    FfrmUsuarios_Cad_Add.FDMem_RegistroTIPO.AsInteger := FDMem_RegistroTIPO.AsInteger;
    FfrmUsuarios_Cad_Add.FDMem_RegistroFORM_INICIAL.AsString := FDMem_RegistroFORM_INICIAL.AsString;


    FfrmUsuarios_Cad_Add.Status_Tabela := 1;

    ShowPopupModal('PopupCadUsuarioAdd');
  end
  else
  begin
    FfrmUsuarios_Cad_Add := TfrmCad_Usuario_ADD.Create(Self);
    FfrmUsuarios_Cad_Add.ShowModal;
  end;
  Pesquisar;
end;

procedure TfrmCad_Usuarios.btExcluirClick(Sender: TObject);
var
  FResp :IResponse;

begin
  if MessageDlg('Deseja excluir o Usuário selecionado?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(FinanceiroWeb.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(FinanceiroWeb.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('usuario')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmCad_Usuarios.Limpar_Campos;
begin

end;

procedure TfrmCad_Usuarios.btNovoClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmUsuarios_Cad_Add.FDMem_Registro.Active := False;
    FfrmUsuarios_Cad_Add.FDMem_Registro.Active := True;
    FfrmUsuarios_Cad_Add.FDMem_Registro.Insert;
    FfrmUsuarios_Cad_Add.Status_Tabela := 0;
    Limpar_Campos;
    ShowPopupModal('PopupCadUsuarioAdd')
  end
  else
  begin
    FfrmUsuarios_Cad_Add := TfrmCad_Usuario_ADD.Create(Self);
    FfrmUsuarios_Cad_Add.ShowModal;
  end;
  Pesquisar;

end;

procedure TfrmCad_Usuarios.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_Usuarios.Pesquisar;
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

    case cbTipo.ItemIndex of
      0:FTipoPesquisa := 'id';
      1:FTipoPesquisa := 'nome';
      2:FTipoPesquisa := 'login';
      3:FTipoPesquisa := 'email';
    else
      FTipoPesquisa := '';
    end;


    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(FinanceiroWeb.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    if Trim(FTipoPesquisa) <> '' then
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .AddParam(FTipoPesquisa,edPesquisar.Text)
               .Resource('usuario')
               .Accept('application/json')
               .Get;
    end
    else
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(FinanceiroWeb.Usuario_Token)
               .Resource('usuario')
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
          FDMem_RegistroLOGIN.AsString := FBody.Get(x).GetValue<String>('login','');
          FDMem_RegistroSENHA.AsString := FBody.Get(x).GetValue<String>('senha','');
          FDMem_RegistroPIN.AsString := FBody.Get(x).GetValue<String>('pin','');
          FDMem_RegistroCELULAR.AsString := FBody.Get(x).GetValue<String>('celular','');
          FDMem_RegistroEMAIL.AsString := FBody.Get(x).GetValue<String>('email','');
          FDMem_RegistroID_EMPRESA.AsInteger := FBody.Get(x).GetValue<Integer>('idEmpresa',0);
          FDMem_RegistroID_PRESTADOR_SERVICO.AsInteger := FBody.Get(x).GetValue<Integer>('idPrestadorServico',0);
          FDMem_RegistroFOTO.AsString := FBody.Get(x).GetValue<String>('foto','');
          FDMem_RegistroDT_CADASTRO.AsDateTime := Date;//FBody.Get(x).GetValue<String>('foto','');
          FDMem_RegistroHR_CADASTRO.AsDateTime := Time;//FBody.Get(x).GetValue<String>('foto','');
          FDMem_RegistroSINCRONIZADO.AsInteger := FBody.Get(x).GetValue<Integer>('sincronizado',0);
          FDMem_RegistroEMPRESA.AsString := FBody.Get(x).GetValue<String>('empresa','');
          FDMem_RegistroPRESTADOR_SERVICO.AsString := FBody.Get(x).GetValue<String>('prestador','');
          FDMem_RegistroTIPO.AsInteger := FBody.Get(x).GetValue<Integer>('tipo',0);
          FDMem_RegistroID_CLIENTE.AsInteger := FBody.Get(x).GetValue<Integer>('idCliente',0);
          FDMem_RegistroFORM_INICIAL.AsString := FBody.Get(x).GetValue<String>('formInicial','');
          FDMem_RegistroCLIENTE.AsString := FBody.Get(x).GetValue<String>('cliente','');
          FDMem_RegistroTIPO_DESC.AsString := FBody.Get(x).GetValue<String>('tipoDesc','');
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

procedure TfrmCad_Usuarios.ExportD2Bridge;
begin
  inherited;

  Title:= 'Usuários';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configurações do Form Popup
  FfrmUsuarios_Cad_Add := TfrmCad_Usuario_ADD.Create(Self);
  D2Bridge.AddNested(FfrmUsuarios_Cad_Add);


  with D2Bridge.Items.add do
  begin
    with Card.Items.Add do
    begin
      with Row.Items.Add do
      begin
        FormGroup(lbTipo.Caption,CSSClass.Col.colsize2).AddVCLObj(cbTipo);
        FormGroup(lbPesquisar.Caption,CSSClass.Col.colsize6).AddVCLObj(edPesquisar);

        FormGroup('',CSSClass.Col.colsize2).AddVCLObj(btPesquisar,CSSClass.Button.search+CSSClass.Button.Width.large);
        FormGroup('',CSSClass.Col.colsize2).AddVCLObj(btNovo,CSSClass.Button.add+CSSClass.Button.Width.large)
      end;
    end;

    with Card.Items.Add do
    begin
      with Row.Items.Add do
        VCLObj(DBGrid);
    end;

    //Abrindo formulário popup
    with Popup('PopupCadUsuarioAdd','Cadastro de Usuários').Items.Add do
      Nested(FfrmUsuarios_Cad_Add);
  end;

end;

procedure TfrmCad_Usuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  //frmCad_Usuarios := Nil;
end;

procedure TfrmCad_Usuarios.FormCreate(Sender: TObject);
begin
  inherited;
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmCad_Usuarios.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_Usuarios.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.IsDBGrid then
  begin
   PrismControl.AsDBGrid.RecordsPerPage := 10;
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

procedure TfrmCad_Usuarios.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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