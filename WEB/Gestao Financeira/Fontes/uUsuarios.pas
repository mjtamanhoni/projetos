unit uUsuarios;

{ Copyright 2025 / 2026 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,
  uFuncoes.Gerais,
  uPrincipal,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  D2Bridge.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,

  uUsuarios.Cad;

type
  TfrmUsuarios = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    dsRegistros: TDataSource;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    pnHeader: TPanel;
    lbStatus: TLabel;
    lbPesquisa: TLabel;
    lbTipo: TLabel;
    cbStatus: TComboBox;
    edPesquisar: TButtonedEdit;
    btNovo: TButton;
    btFechar: TButton;
    cbTipo: TComboBox;
    FDMem_Registroid: TIntegerField;
    FDMem_Registronome: TStringField;
    FDMem_Registrologin: TStringField;
    FDMem_Registrosenha: TStringField;
    FDMem_Registropin: TStringField;
    FDMem_Registroemail: TStringField;
    FDMem_RegistrodtCadastro: TDateField;
    FDMem_RegistrohrCadastro: TTimeField;
    FDMem_RegistrosenhaHash: TStringField;
    FDMem_Registrotipo: TIntegerField;
    FDMem_RegistrotipoDesc: TStringField;
    FDMem_RegistrostatusDesc: TStringField;
    FDMem_Registrostatus: TIntegerField;
    procedure btFecharClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure edPesquisarRightButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfrmUsuarios_Cad :TfrmUsuarios_Cad;

    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

    procedure OnEdit(Sender :TObject);
    procedure OnExcluir(Sender :TObject);

    procedure Pesquisar;

    procedure ShowPopup(const AName:String; var CanShow:Boolean);
    procedure PopupOpened(AName:String); override;

    procedure ClosePopup(const AName:String; var CanClose:Boolean);
    procedure PopupClosed(const AName:String); override;


  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

function frmUsuarios:TfrmUsuarios;

implementation

Uses
  Gestao_FinanceiraWebApp;

{$R *.dfm}

function frmUsuarios:TfrmUsuarios;
begin
  result:= TfrmUsuarios(TfrmUsuarios.GetInstance);
end;

procedure TfrmUsuarios.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarios.btNovoClick(Sender: TObject);
begin
  Gestao_Financeira.Usuario_Status_Tab := '';
  Gestao_Financeira.Usuario_Status_Tab := 'Insert';

  ShowPopupModal('Popup' + FfrmUsuarios_Cad.Name);

end;

procedure TfrmUsuarios.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmUsuarios.edPesquisarRightButtonClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmUsuarios.ExportD2Bridge;
begin
  inherited;

  Title:= 'Usuários do Sistema';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  FfrmUsuarios_Cad := TfrmUsuarios_Cad.Create(Self);
  D2Bridge.AddNested(FfrmUsuarios_Cad);

  with D2Bridge.Items.add do
  begin
    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize10 + ' ' + CSSClass.ColorName.beige).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3).Items.Add do
        begin
          With FormGroup(lbStatus.Caption,CSSClass.Col.colsize2).Items.Add do
            VCLObj(cbStatus);
          With FormGroup(lbPesquisa.Caption,CSSClass.Col.col).Items.Add do
          begin
            with Row.Items.Add do
            begin
              FormGroup('',CSSClass.col.colsize2).Items.Add.VCLObj(cbTipo);
              FormGroup('',CSSClass.col.col).Items.Add.VCLObj(edPesquisar);
            end;
          end;
        end;
      end;

      with HTMLDIV(CSSClass.Col.colsize2).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3 + ' ' + CSSClass.Space.margim_top4).Items.Add do
        begin
          with HTMLDIV(CSSClass.Text.Align.right).Items.Add do
          begin
            VCLObj(btNovo, CSSClass.Button.add);
            VCLObj(btFechar, CSSClass.Button.close);
          end;
        end;
      end;
    end;

    with Row.Items.Add do
      VCLObj(DBGrid_Registros);

    //Popup('Popup'+frmProjetos_Cad.Name, 'Cadastro de Projetos',True,CSSClass.Popup.ExtraLarge).Items.Add.Nested(FfrmProjetos_Cad.Name);

    with Popup('Popup' + FfrmUsuarios_Cad.Name,'Cadastro de Usuários do Sistema',True,CSSClass.Popup.ExtraLarge).Items.Add do
      Nested(FfrmUsuarios_Cad);
  end;

end;

procedure TfrmUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caNone;
end;

procedure TfrmUsuarios.FormCreate(Sender: TObject);
begin
  cbStatus.ItemIndex := 1;

  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmUsuarios.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

  if PrismControl.VCLComponent = edPesquisar then
  begin
    with PrismControl.AsButtonedEdit do
      ButtonRightCSS:= CSSClass.Button.search;
  end;

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
         //Height := 50;
         With Buttons.Add do
         begin
          ButtonModel := TButtonModel.edit;
          Caption:='';
          Onclick:=OnEdit;
         end;
         With Buttons.Add do
         begin
          ButtonModel := TButtonModel.Delete;
          Caption:='';
          Onclick:=OnExcluir;
         end;
      end;

      with Columns.Add do
      begin
        Title:= 'Status';
        Width:= 60;
        HTML:= '<span class="badge ${data.status == 0 ? '+QuotedStr('bg-danger')+' : '+QuotedStr('bg-success')+'} rounded-pill p-2" style="width: 7em;">  ${data.statusDesc}</span>';
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

procedure TfrmUsuarios.OnEdit(Sender: TObject);
begin
  Gestao_Financeira.Usuario_Status_Tab := '';
  Gestao_Financeira.Usuario_Status_Tab := 'Edit';
  ShowPopupModal('Popup' + FfrmUsuarios_Cad.Name);

end;

procedure TfrmUsuarios.OnExcluir(Sender: TObject);
var
  FResp :IResponse;
begin
  if MessageDlg('Deseja excluir o Usuário selecionado?',TMsgDlgType.mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

    if Trim(Gestao_Financeira.Usuario_Token) = '' then
      raise Exception.Create('Token do Usuário inválido');

    FResp := TRequest.New.BaseURL(FHost)
             .TokenBearer(Gestao_Financeira.Usuario_Token)
             .AddParam('id',FDMem_RegistroID.AsString)
             .Resource('usuario')
             .Accept('application/json')
             .Delete;

    Pesquisar;
  end;
end;

procedure TfrmUsuarios.Pesquisar;
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
      FDMem_Registro.EmptyDataSet;

      FDMem_Registro.DisableControls;

      FTipoPesquisa := '';
      case cbTipo.ItemIndex of
        0:FTipoPesquisa := 'id';
        1:FTipoPesquisa := 'nome';
        2:FTipoPesquisa := 'login';
        3:FTipoPesquisa := 'email';
      end;

      if Trim(FHost) = '' then
        raise Exception.Create('Host não informado');

      if Trim(Gestao_Financeira.Usuario_Token) = '' then
        raise Exception.Create('Token do Usuário inválido');

      if Trim(FTipoPesquisa) <> '' then
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam(FTipoPesquisa,edPesquisar.Text)
                 .AddParam('status',cbStatus.ItemIndex.ToString)
                 .Resource('usuario')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam('status',cbStatus.ItemIndex.ToString)
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
            FDMem_Registroid.AsInteger := FBody.Get(x).GetValue<Integer>('id',0);
            FDMem_Registronome.AsString := FBody.Get(x).GetValue<String>('nome','');
            FDMem_Registrologin.AsString := FBody.Get(x).GetValue<String>('login','');
            FDMem_Registrosenha.AsString := '';//FBody.Get(x).GetValue<String>('senha','');
            FDMem_Registropin.AsString := '';//FBody.Get(x).GetValue<String>('pin','');
            FDMem_Registroemail.AsString := FBody.Get(x).GetValue<String>('email','');
            FDMem_RegistrodtCadastro.AsDateTime := TFuncoes.StringParaData(FBody.Get(x).GetValue<String>('dtCadastro',''));
            FDMem_RegistrohrCadastro.AsDateTime := TFuncoes.StringParaHora(FBody.Get(x).GetValue<String>('hrCadastro',''));
            FDMem_RegistrosenhaHash.AsString := '';//FBody.Get(x).GetValue<String>('senhaHash','');
            FDMem_Registrotipo.AsInteger := FBody.Get(x).GetValue<Integer>('tipo',-1);
            FDMem_RegistrotipoDesc.AsString := FBody.Get(x).GetValue<String>('tipoDesc','');
            FDMem_Registrostatus.AsInteger := FBody.Get(x).GetValue<Integer>('status',-1);
            FDMem_RegistrostatusDesc.AsString := FBody.Get(x).GetValue<String>('statusDesc','');
          FDMem_Registro.Post;
        end;
      end
      else
      begin
        raise Exception.Create(FResp.StatusCode.ToString + ': ' + FResp.Content);
      end;

    except on E: Exception do
      ShowMessage(E.Message,True,True,10000);
    end;
  finally
    FDMem_Registro.EnableControls;
  end;
end;

procedure TfrmUsuarios.PopupClosed(const AName: String);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmUsuarios.PopupOpened(AName: String);
begin
  inherited;
  if Gestao_Financeira.Usuario_Status_Tab = 'Insert' then
    FfrmUsuarios_Cad.cbstatus.ItemIndex := 1
  else if Gestao_Financeira.FormProjeto_Status_Tab = 'Edit' then
  begin
    FfrmUsuarios_Cad.edid.Text := FDMem_Registro.FieldByName('id').AsString;
    FfrmUsuarios_Cad.cbstatus.ItemIndex := FDMem_Registro.FieldByName('status').AsInteger;
    FfrmUsuarios_Cad.ednome.Text := FDMem_Registro.FieldByName('nome').AsString;
    FfrmUsuarios_Cad.cbtipo.ItemIndex := FDMem_Registro.FieldByName('tipo').AsInteger;
    FfrmUsuarios_Cad.edlogin.Text := FDMem_Registro.FieldByName('login').AsString;
    FfrmUsuarios_Cad.edsenha.Text := ''; //A senha não pode ser descriptografada
    FfrmUsuarios_Cad.edpin.Text := ''; //O PIN não pode ser descriptografado
  end;

end;

procedure TfrmUsuarios.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
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

procedure TfrmUsuarios.ShowPopup(const AName: String; var CanShow: Boolean);
begin

end;

end.
