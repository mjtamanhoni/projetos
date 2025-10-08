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

  uUsuarios.Cad, frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF, Vcl.Menus;

type
  TfrmUsuarios = class(TfrmPrincipal)
    FDMem_Registro: TFDMemTable;
    dsRegistros: TDataSource;
    pnDetail: TPanel;
    DBGrid_Registros: TDBGrid;
    pnHeader: TPanel;
    btNovo: TButton;
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
    edPesquisar: TEdit;
    btFiltros: TButton;
    btPrint: TButton;
    PopupMenu: TPopupMenu;
    mnuPop_Filtro_ID: TMenuItem;
    mnuPop_Filtro_Nome: TMenuItem;
    mnuFiltro_Login: TMenuItem;
    frxReport: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBDataset: TfrxDBDataset;
    mnuFiltro_EMail: TMenuItem;
    mnuFiltro_Inativo: TMenuItem;
    FDMem_Permissoes: TFDMemTable;
    dsPermissoes: TDataSource;
    FDMem_Permissoesid: TIntegerField;
    FDMem_PermissoesidUsuario: TIntegerField;
    FDMem_PermissoesidProjeto: TIntegerField;
    FDMem_PermissoesidTelaProjeto: TIntegerField;
    FDMem_Permissoesacesso: TIntegerField;
    FDMem_Permissoesincluir: TIntegerField;
    FDMem_Permissoesalterar: TIntegerField;
    FDMem_Permissoesexcluir: TIntegerField;
    FDMem_Permissoesimprimir: TIntegerField;
    FDMem_Permissoesusuario: TStringField;
    FDMem_Permissoesprojeto: TStringField;
    FDMem_PermissoesnomeForm: TStringField;
    FDMem_PermissoesdescricaoResumida: TStringField;
    pnRegistros: TPanel;
    FDMem_Empresa: TFDMemTable;
    dsEmpresa: TDataSource;
    FDMem_Empresaid: TIntegerField;
    FDMem_EmpresaidUsuario: TIntegerField;
    FDMem_EmpresaidEmpresa: TIntegerField;
    FDMem_EmpresadtCadastro: TDateField;
    FDMem_EmpresahrCadastro: TTimeField;
    FDMem_Empresausuario: TStringField;
    FDMem_Empresaempresa: TStringField;
    procedure btFecharClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure edPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure mnuFiltro_InativoClick(Sender: TObject);
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

procedure TfrmUsuarios.btPrintClick(Sender: TObject);
begin
  inherited;
  try
    if FDMem_Registro.IsEmpty then
      raise Exception.Create('Não há registros a serem impressos');

    frxPDFExport.FileName := PrismSession.PathSession + 'Rel_Usuarios.pdf';

    // Config. do rel e exportacao do pdf...
    frxReport.LoadFromFile(RootDirectory + '/Reports/Rel_Usuarios.fr3');
    frxReport.PrepareReport;
    frxReport.Export(frxPDFExport);

    if FileExists(PrismSession.PathSession + 'Rel_Usuarios.pdf') then
      D2Bridge.PrismSession.SendFile(PrismSession.PathSession + 'Rel_Usuarios.pdf')
    else
      raise Exception.Create('Erro ao gerar o PDF');

  except on E: Exception do
    MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
  end;

end;

procedure TfrmUsuarios.ClosePopup(const AName: String; var CanClose: Boolean);
begin

end;

procedure TfrmUsuarios.edPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
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
      with HTMLDIV(CSSClass.Col.colsize10).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3).Items.Add do
        begin
          With FormGroup('',CSSClass.Col.col).Items.Add do
          begin
            VCLObj(edPesquisar);
            VCLObj(btFiltros, PopupMenu, CSSClass.Button.search);
          end;
        end;
      end;

      with HTMLDIV(CSSClass.Col.col).Items.Add do
      begin
        with Row(CSSClass.Space.margim_bottom3 + ' ' + CSSClass.Space.margim_top1).Items.Add do
        begin
          with HTMLDIV(CSSClass.Text.Align.right).Items.Add do
          begin
            VCLObj(btNovo, CSSClass.Button.add);
            VCLObj(btPrint, CSSClass.Button.print);
          end;
        end;
      end;
    end;

    with Row.Items.Add do
    begin
      with HTMLDIV(CSSClass.Col.colsize12).Items.Add do
      begin
        with Row.Items.Add do
        begin
          with PanelGroup('Listagem','',False,CSSClass.Col.colsize12).Items.Add do
            VCLObj(DBGrid_Registros);
        end;
      end;
    end;

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

procedure TfrmUsuarios.mnuFiltro_InativoClick(Sender: TObject);
begin
  inherited;
  edPesquisar.Tag := TMenuItem(Sender).Tag;
  case TMenuItem(Sender).Tag of
    0:edPesquisar.TextHint := 'Pesquisar pelo ID do Usuário';
    1:edPesquisar.TextHint := 'Pesquisar pelo Nome do Usuário';
    2:edPesquisar.TextHint := 'Pesquisar pelo Login do Usuário';
    3:edPesquisar.TextHint := 'Pesquisar pelo E-Mail do Usuário';
  end;
  Pesquisar;

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
  x, I:Integer;
  FStatus :Integer;

  FPermissoes :TJSONArray;
  FEmpresas :TJSONArray;

begin
  try
    try
      //Registros...
      FDMem_Registro.Active := False;
      FDMem_Registro.Active := True;
      FDMem_Registro.EmptyDataSet;

      //Permissões...
      FDMem_Permissoes.Active := False;
      FDMem_Permissoes.Active := True;
      FDMem_Permissoes.EmptyDataSet;

      //Empresa...
      FDMem_Empresa.Active := False;
      FDMem_Empresa.Active := True;
      FDMem_Empresa.EmptyDataSet;

      FStatus := 1;

      FDMem_Registro.DisableControls;

      FTipoPesquisa := '';
      case edPesquisar.Tag of
        0:begin
          if TFuncoes.ContemNaoNumerico(edPesquisar.Text) then
            raise Exception.Create('Para pesquisar o ID não pode haver letras no texto da pesquisa');
          FTipoPesquisa := 'id';
        end;
        1:FTipoPesquisa := 'nome';
        2:FTipoPesquisa := 'login';
        3:FTipoPesquisa := 'email';
        4:FStatus := 0;
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
                 .AddParam('status',FStatus.ToString)
                 .Resource('usuario')
                 .Accept('application/json')
                 .Get;
      end
      else
      begin
        FResp := TRequest.New.BaseURL(FHost)
                 .TokenBearer(Gestao_Financeira.Usuario_Token)
                 .AddParam('status',FStatus.ToString)
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
          //Permissões...
          FPermissoes := FBody[x].GetValue<TJSONArray>('permissoes',Nil);

          //Empresas...
          FEmpresas := FBody[x].GetValue<TJSONArray>('empresas',Nil);

          //Inserindo os registros dos usuários...
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

          //Permissões...
          if FPermissoes.Size > 0 then
          begin
            for I := 0 to Pred(FPermissoes.Size) do
            begin
              FDMem_Permissoes.Insert;
                FDMem_Permissoesid.AsInteger := FPermissoes[I].GetValue<Integer>('id',0);
                FDMem_PermissoesidUsuario.AsInteger := FPermissoes[I].GetValue<Integer>('idUsuario',0);
                FDMem_PermissoesidProjeto.AsInteger := FPermissoes[I].GetValue<Integer>('idProjeto',0);
                FDMem_PermissoesidTelaProjeto.AsInteger := FPermissoes[I].GetValue<Integer>('idTelaProjeto',0);
                FDMem_Permissoesacesso.AsInteger := FPermissoes[I].GetValue<Integer>('acesso',0);
                FDMem_Permissoesincluir.AsInteger := FPermissoes[I].GetValue<Integer>('incluir',0);
                FDMem_Permissoesalterar.AsInteger := FPermissoes[I].GetValue<Integer>('alterar',0);
                FDMem_Permissoesexcluir.AsInteger := FPermissoes[I].GetValue<Integer>('excluir',0);
                FDMem_Permissoesimprimir.AsInteger := FPermissoes[I].GetValue<Integer>('imprimir',0);
                FDMem_Permissoesusuario.AsString := FPermissoes[I].GetValue<String>('usuario','');
                FDMem_Permissoesprojeto.AsString := FPermissoes[I].GetValue<String>('projeto','');
                FDMem_PermissoesnomeForm.AsString := FPermissoes[I].GetValue<String>('nomeForm','');
                FDMem_PermissoesdescricaoResumida.AsString := FPermissoes[I].GetValue<String>('descricaoResumida','');
              FDMem_Permissoes.Post;
            end;
          end;

          //Empresas...
          if FEmpresas.Size > 0 then
          begin
            for I := 0 to Pred(FEmpresas.Size) do
            begin
              FDMem_Empresa.Insert;
                FDMem_Empresaid.AsInteger := FEmpresas[I].GetValue<Integer>('id',0);
                FDMem_EmpresaidUsuario.AsInteger := FEmpresas[I].GetValue<Integer>('idUsuario',0);
                FDMem_EmpresaidEmpresa.AsInteger := FEmpresas[I].GetValue<Integer>('idEmpresa',0);
                FDMem_EmpresadtCadastro.AsDateTime := TFuncoes.StringParaData(FBody.Get(x).GetValue<String>('dtCadastro',''));
                FDMem_EmpresahrCadastro.AsDateTime := TFuncoes.StringParaHora(FBody.Get(x).GetValue<String>('hrCadastro',''));
                FDMem_Empresausuario.AsString := FEmpresas[I].GetValue<String>('usuario','');
                FDMem_Empresaempresa.AsString := FEmpresas[I].GetValue<String>('empresa','');
              FDMem_Empresa.Post;
            end;
          end;

        end;
      end
      else
      begin
        if FResp.StatusCode = 204 then
          raise Exception.Create('Registro não localizado')
        else
          raise Exception.Create(FResp.StatusCode.ToString + ': ' + FResp.Content);
      end;

    except on E: Exception do
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
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
