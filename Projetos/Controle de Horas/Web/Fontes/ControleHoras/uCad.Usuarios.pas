unit uCad.Usuarios;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.IOUtils,

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,

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
    btNovo: TButton;
    btEditar: TButton;
    btExcluir: TButton;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    FfrmUsuarios_Cad_Add :TfrmCad_Usuario_ADD;

    procedure Pesquisar;

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
  ControleHorasWebApp;

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

    FfrmUsuarios_Cad_Add.Status_Tabela := 1;

    ShowPopupModal('PopupCadClienteAdd')
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
  FHost :String;
  FResp :IResponse;

begin
  if MessageDlg('Deseja excluir o Usu�rio selecionado?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    FHost := '';
    FHost := 'http:\\localhost:3000';
    if Trim(FHost) = '' then
      raise Exception.Create('Host n�o informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usu�rio inv�lido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(ControleHoras.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('usuario')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmCad_Usuarios.btNovoClick(Sender: TObject);
begin
  if IsD2BridgeContext then
  begin
    FfrmUsuarios_Cad_Add.FDMem_Registro.Active := False;
    FfrmUsuarios_Cad_Add.FDMem_Registro.Active := True;
    FfrmUsuarios_Cad_Add.FDMem_Registro.Insert;
    FfrmUsuarios_Cad_Add.Status_Tabela := 0;
    ShowPopupModal('PopupCadClienteAdd')
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
  FHost :String;
  FResp :IResponse;
  FJson :TJSONObject;
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


    FHost := '';
    FHost := 'http:\\localhost:3000';
    if Trim(FHost) = '' then
      raise Exception.Create('Host n�o informado');

    if Trim(ControleHoras.Usuario_Token) = '' then
      raise Exception.Create('Token do Usu�rio inv�lido');

    if Trim(FTipoPesquisa) <> '' then
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .AddParam(FTipoPesquisa,edPesquisar.Text)
               .Resource('usuario')
               .Accept('application/json')
               .Get;
    end
    else
    begin
      FResp := TRequest.New.BaseURL(FHost)
               .TokenBearer(ControleHoras.Usuario_Token)
               .Resource('usuario')
               .Accept('application/json')
               .Get;
    end;

    if FResp.StatusCode = 200 then
    begin
      if FResp.Content = '' then
        raise Exception.Create('N�o houve retorno no login');

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

  Title:= 'Usu�rios';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Configura��es do Form Popup
  FfrmUsuarios_Cad_Add := TfrmCad_Usuario_ADD.Create(Self);
  D2Bridge.AddNested(FfrmUsuarios_Cad_Add);


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

    //Abrindo formul�rio popup
    with Popup('PopupCadClienteAdd','Cadastro de Cliente').Items.Add do
      Nested(FfrmUsuarios_Cad_Add);
  end;

end;

procedure TfrmCad_Usuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  //frmCad_Usuarios := Nil;
end;

procedure TfrmCad_Usuarios.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCad_Usuarios.InitControlsD2Bridge(const PrismControl: TPrismControl);
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