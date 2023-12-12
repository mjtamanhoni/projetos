unit uDeskTop.CadEmpresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.JSON,

  {$Region '99 Coders'}
    uFancyDialog,
    uLoading,
    uFormat,
  {$EndRegion '99 Coders'}

  {$Region 'Horse'}
    Horse,
    Horse.Jhonson,
    Horse.BasicAuthentication,
    Horse.CORS,
    DataSet.Serialize.Config,
  {$EndRegion 'Horse'}

  IniFiles,
  uFuncoes,

  uDm_DeskTop,
  DataSet.Serialize,
  RESTRequest4D,

  uDeskTop.Principal,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.ListView, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, FMX.TabControl, FMX.Layouts, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TStatusTable = (stList,stInsert,stUpdate,stDelete);
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;

  TfrmEmpresa = class(TForm)
    imgCancel: TImage;
    imgDelete: TImage;
    imgExpandir: TImage;
    imgNovo: TImage;
    imgNVer: TImage;
    imgRetrair: TImage;
    imgSalvar: TImage;
    imgVer: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiFiltro: TTabItem;
    lytLista: TLayout;
    rctFiltro: TRectangle;
    lytPesq_Filtro: TLayout;
    edPesquisar: TEdit;
    lbPesquisar: TLabel;
    FloatAnimation_Pesq: TFloatAnimation;
    imgPesquisar: TImage;
    rctLista: TRectangle;
    lvLista: TListView;
    tiCadastro: TTabItem;
    rctCadastro: TRectangle;
    lytDetail_Espacos: TLayout;
    lytRow_001: TLayout;
    edRazaoSocial: TEdit;
    lbRazaoSocial: TLabel;
    FloatAnimation_RazaoSocial: TFloatAnimation;
    edStatus: TEdit;
    lbStatus: TLabel;
    FloatAnimation_Status: TFloatAnimation;
    imgStatus: TImage;
    edTipo: TEdit;
    lbTipo: TLabel;
    FloatAnimation_Tipo: TFloatAnimation;
    imgTipo: TImage;
    lytRow_002: TLayout;
    edNomeFantasia: TEdit;
    lbNomeFantasia: TLabel;
    FloatAnimation_NomeFantasia: TFloatAnimation;
    lytRow_003: TLayout;
    edDocumento: TEdit;
    lbDocumento: TLabel;
    FloatAnimation_Documento: TFloatAnimation;
    edInscEstadual: TEdit;
    lbInscEstadual: TLabel;
    FloatAnimation_InscEstadual: TFloatAnimation;
    rctStatus: TRectangle;
    rctStatus_Ativo: TRectangle;
    lbStatus_Ativo: TLabel;
    rctStatus_Inativo: TRectangle;
    lbStatus_Inativo: TLabel;
    FloatAnimation_SelStatus: TFloatAnimation;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    rctConfirmar: TRectangle;
    Circle_Novo: TCircle;
    imgConfirmar: TImage;
    rctCancelar: TRectangle;
    Circle_Cancelar: TCircle;
    imgCancelar: TImage;
    rctEditar: TRectangle;
    Circle_Editar: TCircle;
    imgEditar: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytMenu: TLayout;
    rctMenu_Principal: TRectangle;
    imgMenu: TImage;
    lytFechar: TLayout;
    rctFechar: TRectangle;
    imgFechar: TImage;
    rctTipo: TRectangle;
    rctTipo_Juridico: TRectangle;
    lbTipo_Juridico: TLabel;
    rctTipo_Fisico: TRectangle;
    lbTipo_Fisico: TLabel;
    FloatAnimation_SelTipo: TFloatAnimation;
    edInsMunicipal: TEdit;
    lbInscMunicipal: TLabel;
    FloatAnimation_InscMunicipal: TFloatAnimation;
    FDMem_Registros: TFDMemTable;
    FDMem_RegistrosID: TIntegerField;
    FDMem_RegistrosID_USUARIO: TIntegerField;
    FDMem_RegistrosDT_CADASTRO: TDateField;
    FDMem_RegistrosHR_CADASTRO: TTimeField;
    FDMem_RegistrosRAZAO_SOCIAL: TStringField;
    FDMem_RegistrosNOME_FANTASIA: TStringField;
    FDMem_RegistrosSTATUS: TIntegerField;
    FDMem_RegistrosTIPO_PESSOA: TStringField;
    FDMem_RegistrosDOCUMENTO: TStringField;
    FDMem_RegistrosINSCRICAO_ESTADUAL: TStringField;
    FDMem_RegistrosINSCRICAO_MUNICIPAL: TStringField;
    lytRow_000: TLayout;
    lbId_Titulo: TLabel;
    lbId: TLabel;
    tcAdicionais: TTabControl;
    tiEndereco: TTabItem;
    tiTelefone: TTabItem;
    tiEmail: TTabItem;
    lytEndereco: TLayout;
    lytEmail: TLayout;
    lytTelefone: TLayout;
    rctEndereco: TRectangle;
    rctEmail: TRectangle;
    rctTelefone: TRectangle;
    lytNavegarPages: TLayout;
    lytNavegarPages_Buttons: TLayout;
    imgEndereco: TImage;
    imgTelefone: TImage;
    imgEmail: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPesquisarTyping(Sender: TObject);
    procedure lvListaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvListaPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctFecharClick(Sender: TObject);
    procedure rctConfirmarClick(Sender: TObject);
    procedure rctEditarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edRazaoSocialKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edStatusKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edTipoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edNomeFantasiaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edDocumentoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edInscEstadualKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edRazaoSocialTyping(Sender: TObject);
    procedure edStatusTyping(Sender: TObject);
    procedure edTipoTyping(Sender: TObject);
    procedure edNomeFantasiaTyping(Sender: TObject);
    procedure edStatusClick(Sender: TObject);
    procedure edStatusChange(Sender: TObject);
    procedure edTipoChange(Sender: TObject);
    procedure edTipoClick(Sender: TObject);
    procedure rctStatus_AtivoClick(Sender: TObject);
    procedure rctStatus_InativoClick(Sender: TObject);
    procedure rctTipo_JuridicoClick(Sender: TObject);
    procedure rctTipo_FisicoClick(Sender: TObject);
    procedure edDocumentoTyping(Sender: TObject);
    procedure edInscEstadualTyping(Sender: TObject);
    procedure edInsMunicipalTyping(Sender: TObject);
    procedure imgEnderecoClick(Sender: TObject);
  private
    FProcessando: String;

    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    lEnder_Ini :String;
    FFechar_Sistema :Boolean;
    FId_Selecionado :Integer;
    FNome_Selecionado :String;
    FStatusTable: TStatusTable;

    procedure Abortar_Fechamento(Sender: TOBject);
    procedure Confirmar_Fechamento(Sender :TObject);

    procedure SelStatus;
    procedure ThreadEnd_Status(Sender: TOBject);

    procedure SelTipo;
    procedure ThreadEnd_Tipo(Sender: TOBject);
    procedure SelecionaTipo(Sender:TObject; AEdit:TEdit;ALabel:TLabel);

    {$Region 'Listar dados'}
      procedure Listar_Dados(
        const APagina: Integer;
        const ABusca: String;
        const AInd_Clear: Boolean);
      procedure AddItens_LV(
        const ACodigo:Integer;
        const ANome:String);
      procedure ThreadEnd_Lista(Sender: TOBject);
    {$EndRegion 'Listar dados'}

    procedure Salvar_Alteracoes(Sender :TOBject);
    procedure Cancelar_Alteracoes(Sender :TOBject);
    procedure Novo_Registro(Sender: TOBject);
    procedure Deletar_Registro(Sender: TOBject);
    procedure EditandoRegistro(const AId: Integer);
    procedure ThreadEnd_Edit(Sender: TOBject);
    procedure Configura_Botoes(ABotao: Integer);
    procedure EditarRegistro(Sender: TOBject);
    procedure Incia_Campos;
    procedure Exibe_Labels;
    procedure ThreadEnd_SalvarRegistro(Sender: TOBject);
    procedure ThreadEnd_DeletarRegistro(Sender: TOBject);

  public
    ExecuteOnClose :TExecuteOnClose;
    RetornaRegistro :Boolean;
  end;

var
  frmEmpresa: TfrmEmpresa;

implementation

{$R *.fmx}

procedure TfrmEmpresa.Abortar_Fechamento(Sender: TOBject);
begin
  Abort;
end;

procedure TfrmEmpresa.AddItens_LV(
        const ACodigo:Integer;
        const ANome:String);
begin
  with lvLista.Items.Add do
  begin
    Tag := ACodigo;
    TagString := ANome;
    TListItemText(Objects.FindDrawable('edNome')).TagString := ACodigo.ToString;
    TListItemText(Objects.FindDrawable('edNome')).Text := ANome;
  end;
end;

procedure TfrmEmpresa.Cancelar_Alteracoes(Sender: TOBject);
begin
  Configura_Botoes(2);
end;

procedure TfrmEmpresa.Configura_Botoes(ABotao: Integer);
begin
  case ABotao of
    0:begin
      //Novo...
      Incia_Campos;
      rctConfirmar.Tag := 1;
      rctCancelar.Tag := 1;
      rctEditar.Enabled := False;
      imgCancelar.Bitmap := imgCancel.Bitmap;
      imgConfirmar.Bitmap := imgSalvar.Bitmap;
      FStatusTable := TStatusTable.stInsert;
      tcPrincipal.GotoVisibleTab(1);
    end;
    1:begin
      //Salvar...
      rctConfirmar.Tag := 0;
      rctCancelar.Tag := 0;
      rctEditar.Enabled := True;
      imgCancelar.Bitmap := imgDelete.Bitmap;
      imgConfirmar.Bitmap := imgNovo.Bitmap;
      FStatusTable := TStatusTable.stList;
      Incia_Campos;
      tcPrincipal.GotoVisibleTab(0);
    end;
    2:begin
      //Cancelar...
      rctConfirmar.Tag := 0;
      rctCancelar.Tag := 0;
      rctEditar.Enabled := True;
      imgCancelar.Bitmap := imgDelete.Bitmap;
      imgConfirmar.Bitmap := imgNovo.Bitmap;
      FStatusTable := TStatusTable.stList;
      Incia_Campos;
      tcPrincipal.GotoVisibleTab(0);
    end;
    3:begin
      //Excluir...
      rctConfirmar.Tag := 0;
      rctCancelar.Tag := 0;
      tcPrincipal.GotoVisibleTab(0);
      rctEditar.Enabled := True;
      imgCancelar.Bitmap := imgDelete.Bitmap;
      imgConfirmar.Bitmap := imgNovo.Bitmap;
      Listar_Dados(0,edPesquisar.Text,True);
      FStatusTable := TStatusTable.stList;
    end;
    4:begin
      //Editar...
      rctConfirmar.Tag := 1;
      rctCancelar.Tag := 1;
      rctEditar.Enabled := False;
      imgCancelar.Bitmap := imgCancel.Bitmap;
      imgConfirmar.Bitmap := imgSalvar.Bitmap;
      FStatusTable := TStatusTable.stUpdate;
      tcPrincipal.GotoVisibleTab(1);
    end;
  end;
end;

procedure TfrmEmpresa.Confirmar_Fechamento(Sender: TObject);
begin
  if RetornaRegistro then
    ExecuteOnClose(FId_Selecionado,FNome_Selecionado);

  FFechar_Sistema := True;
  Close;
end;

procedure TfrmEmpresa.Deletar_Registro(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.Empresa_Excluir(FId_Selecionado);
    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(3);
    end);
  end);

  t.OnTerminate := ThreadEnd_DeletarRegistro;
  t.Start;
end;

procedure TfrmEmpresa.edDocumentoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edInscEstadual);
end;

procedure TfrmEmpresa.edDocumentoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edDocumento,lbDocumento,FloatAnimation_Documento,10,-20);
  if edTipo.TagString = 'F' then
    Formatar(edDocumento, TFormato.CPF)
  else
    Formatar(edDocumento, TFormato.CNPJ);
end;

procedure TfrmEmpresa.edInscEstadualKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edInsMunicipal);
end;

procedure TfrmEmpresa.edInscEstadualTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edInscEstadual,lbInscEstadual,FloatAnimation_InscEstadual,10,-20);
  Formatar(edInscEstadual, TFormato.InscricaoEstadual,'ES');
end;

procedure TfrmEmpresa.edInsMunicipalTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edInsMunicipal,lbInscMunicipal,FloatAnimation_InscMunicipal,10,-20);
end;

procedure TfrmEmpresa.EditandoRegistro(const AId: Integer);
var
  t :TThread;
begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
    lDt_Cadastro :TDate;
    lHr_Cadastro :TTime;
  begin
      jsonArray := Dm_DeskTop.Empresa_Lista(
        0
        ,AId
        ,''
        ,'');

      TThread.Synchronize(nil,
      procedure
      begin
        edRazaoSocial.Tag := jsonArray.Get(x).GetValue<Integer>('id',0);
        edRazaoSocial.Text := jsonArray.Get(x).GetValue<String>('razaoSocial','');
        lbId.Text := FormatFloat('#,##0',edRazaoSocial.Tag);
        edNomeFantasia.Text := jsonArray.Get(x).GetValue<String>('nomeFantasia','');
        edStatus.Tag := jsonArray.Get(x).GetValue<Integer>('status',0);
        case edStatus.Tag of
          0:edStatus.Text := 'INATIVO';
          1:edStatus.Text := 'ATIVO';
        end;
        edTipo.TagString := jsonArray.Get(x).GetValue<String>('tipoPessoa','J');
        if edTipo.TagString = 'J' then
        begin
          edTipo.Text := 'JURÍDICO';
          edTipo.Tag := 0;
        end
        else
        begin
          edTipo.Text := 'FÍSICO';
          edTipo.Tag := 1;
        end;
        edDocumento.Text := jsonArray.Get(x).GetValue<String>('documento','');
        edInscEstadual.Text := jsonArray.Get(x).GetValue<String>('inscricaoEstadual','');
        edInsMunicipal.Text := jsonArray.Get(x).GetValue<String>('inscricaoMunicipal','');
        lDt_Cadastro := StrToDate(jsonArray.Get(x).GetValue<String>('dt_cadastro',DateToStr(Date)));
        lHr_Cadastro := StrToTime(jsonArray.Get(x).GetValue<String>('hr_cadastro',TimeToStr(Time)));
      end);

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}

  end);

  t.OnTerminate := ThreadEnd_Edit;
  t.Start;
end;

procedure TfrmEmpresa.EditarRegistro(Sender: TOBject);
begin
  EditandoRegistro(FId_Selecionado);
end;

procedure TfrmEmpresa.edNomeFantasiaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edDocumento);
end;

procedure TfrmEmpresa.edNomeFantasiaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNomeFantasia,lbNomeFantasia,FloatAnimation_NomeFantasia,10,-20);
end;

procedure TfrmEmpresa.edPesquisarKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmEmpresa.edPesquisarTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPesquisar,lbPesquisar,FloatAnimation_Pesq,10,-20);
end;

procedure TfrmEmpresa.edRazaoSocialKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edStatus);
end;

procedure TfrmEmpresa.edRazaoSocialTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edRazaoSocial,lbRazaoSocial,FloatAnimation_RazaoSocial,10,-20);
end;

procedure TfrmEmpresa.edStatusChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmEmpresa.edStatusClick(Sender: TObject);
begin
  SelStatus;
end;

procedure TfrmEmpresa.edStatusKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edTipo);
end;

procedure TfrmEmpresa.edStatusTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
end;

procedure TfrmEmpresa.edTipoChange(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
end;

procedure TfrmEmpresa.edTipoClick(Sender: TObject);
begin
  SelTipo;
end;

procedure TfrmEmpresa.edTipoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edNomeFantasia);
end;

procedure TfrmEmpresa.edTipoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
end;

procedure TfrmEmpresa.Exibe_Labels;
begin
  TFuncoes.ExibeLabel(edRazaoSocial,lbRazaoSocial,FloatAnimation_RazaoSocial,10,-20);
  TFuncoes.ExibeLabel(edNomeFantasia,lbNomeFantasia,FloatAnimation_NomeFantasia,10,-20);
  TFuncoes.ExibeLabel(edStatus,lbStatus,FloatAnimation_Status,10,-20);
  TFuncoes.ExibeLabel(edTipo,lbTipo,FloatAnimation_Tipo,10,-20);
  TFuncoes.ExibeLabel(edDocumento,lbDocumento,FloatAnimation_Documento,10,-20);
  TFuncoes.ExibeLabel(edInscEstadual,lbInscEstadual,FloatAnimation_InscEstadual,10,-20);
  TFuncoes.ExibeLabel(edInsMunicipal,lbInscMunicipal,FloatAnimation_InscMunicipal,10,-20);
end;

procedure TfrmEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FFechar_Sistema then
    Abortar_Fechamento(Sender);

  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FIniFile);
  {$ELSE}
    FMensagem.DisposeOf;
    FIniFile.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.CaFree;
  frmEmpresa := Nil;
  FId_Selecionado := 0;
  FNome_Selecionado := '';

  tcPrincipal.ActiveTab := tiFiltro;

end;

procedure TfrmEmpresa.FormCreate(Sender: TObject);
begin
  FFechar_Sistema := False;
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_DESKTOP.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_DESKTOP.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  FMensagem := TFancyDialog.Create(frmEmpresa);

  FStatusTable := TStatusTable.stList;

  FId_Selecionado := 0;
  FNome_Selecionado := '';

end;

procedure TfrmEmpresa.imgEnderecoClick(Sender: TObject);
begin
  imgEndereco.Opacity := 0.5;
  imgTelefone.Opacity := 0.5;
  imgEmail.Opacity := 0.5;
  case TImage(Sender).Tag of
    0:begin
      //Endereço...
      TImage(Sender).Opacity := 1;
    end;
    1:begin
      //Telefone
      TImage(Sender).Opacity := 1;
    end;
    2:begin
      //Email...
      TImage(Sender).Opacity := 1;
    end;
  end;

  tcAdicionais.GotoVisibleTab(TImage(Sender).Tag);
end;

procedure TfrmEmpresa.Incia_Campos;
begin
  edRazaoSocial.Tag := 0;
  edRazaoSocial.Text := '';
  edNomeFantasia.Text := '';
  edStatus.Tag := 0;
  edStatus.Text := '';
  edTipo.Tag := 0;
  edTipo.Text := '';
  edDocumento.Text := '';
  edInscEstadual.Text := '';
  edInsMunicipal.Text := '';
  lbId.Tag := 0;
  lbId.Text := '0';

  Exibe_Labels;
end;

procedure TfrmEmpresa.Listar_Dados(const APagina: Integer; const ABusca: String;
  const AInd_Clear: Boolean);
var
  t :TThread;
  lNome :String;
  lCodigo :Integer;

begin

  //TLoading.Show(frmEmpresa,'Listando dados');

  if FProcessando = 'processando' then
      exit;
  FProcessando := 'processando';

  if AInd_Clear then
  begin
    lvLista.ScrollTo(0);
    lvLista.Tag := 0;
    lvLista.Items.Clear;
  end;

  lNome := '';
  lCodigo := 0;
  if edPesquisar.Text <> '' then
  begin
    if TFuncoes.Possui_Letras(ABusca) then
      lNome := UpperCase(ABusca)
    else
      lCodigo := StrToIntDef(ABusca,0);
  end;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
  begin

    lvLista.BeginUpdate;

    if lvLista.Tag >= 0 then
      lvLista.Tag := (lvLista.Tag + 1);

      jsonArray := Dm_DeskTop.Empresa_Lista(
        lvLista.Tag
        ,lCodigo
        ,''
        ,lNome);

      for x := 0 to jsonArray.Size -1 do
      begin
        TThread.Synchronize(nil,
        procedure
        begin
            AddItens_LV(
              jsonArray.Get(x).GetValue<Integer>('id')
              ,jsonArray.Get(x).GetValue<String>('razaoSocial')
            );
        end);
      end;

      if jsonArray.Size = 0 then
        lvLista.Tag := -1;

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}

      TThread.Synchronize(nil,
      procedure
      begin
        lvLista.EndUpdate;
      end);

      //lvLista.TagString := '';
      FProcessando := '';

      //Força a chamada do evento onUpdateObjects da listview...
      lvLista.Margins.Bottom := 6;
      lvLista.Margins.Bottom := 5;
      //---------------------------------------------
  end);

  t.OnTerminate := ThreadEnd_Lista;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_Lista(Sender: TOBject);
begin
  //TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga das Empresas: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmEmpresa.lvListaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FId_Selecionado := Aitem.Tag;
  FNome_Selecionado := AItem.TagString;
end;

procedure TfrmEmpresa.lvListaPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvLista.Items.Count >= 0) and (lvLista.Tag >= 0) then
  begin
    if lvLista.GetItemRect(lvLista.Items.Count - 3).Bottom <= lvLista.Height then
      Listar_Dados(lvLista.Tag,edPesquisar.Text,False)
  end;
end;

procedure TfrmEmpresa.Novo_Registro(Sender: TOBject);
begin
  Configura_Botoes(0);
end;

procedure TfrmEmpresa.rctCancelarClick(Sender: TObject);
begin
  case rctCancelar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Excluir','Deseja excluir o registro?','SIM',Deletar_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Cancelar','Deseja cancelar as alterações?','SIM',Cancelar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmEmpresa.rctConfirmarClick(Sender: TObject);
begin
  case rctConfirmar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Novo','Deseja adicionar um novo registro?','SIM',Novo_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Salvar','Deseja salvar as alterações?','SIM',Salvar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmEmpresa.rctEditarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o registro selecionado?','SIM',EditarRegistro,'NÃO');
end;

procedure TfrmEmpresa.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja fechar as Configurações?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

procedure TfrmEmpresa.rctStatus_AtivoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Ativo.Tag;
  edStatus.Text := lbStatus_Ativo.Text;
  SelStatus;
end;

procedure TfrmEmpresa.rctStatus_InativoClick(Sender: TObject);
begin
  edStatus.Tag := rctStatus_Ativo.Tag;
  edStatus.Text := lbStatus_Ativo.Text;
  SelStatus;
end;

procedure TfrmEmpresa.rctTipo_FisicoClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Fisico);
end;

procedure TfrmEmpresa.rctTipo_JuridicoClick(Sender: TObject);
begin
  SelecionaTipo(Sender,edTipo,lbTipo_Juridico);
end;

procedure TfrmEmpresa.Salvar_Alteracoes(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    if Trim(edRazaoSocial.Text) = '' then
      raise Exception.Create('Razão Social obrigatória');
    if edStatus.Tag = -1 then
      raise Exception.Create('Status obrigtório');
    if edTipo.TagString = '' then
      raise Exception.Create('Tipo obrigtório');

    FDMem_Registros.Active := False;
    FDMem_Registros.Active := True;
    FDMem_Registros.Insert;
      if FStatusTable = stInsert then
        FDMem_RegistrosID.AsInteger := 0
      else if FStatusTable = stUpdate then
        FDMem_RegistrosID.AsInteger := edRazaoSocial.Tag;

      FDMem_RegistrosRAZAO_SOCIAL.AsString := edRazaoSocial.Text;
      FDMem_RegistrosNOME_FANTASIA.AsString := edNomeFantasia.Text;
      FDMem_RegistrosSTATUS.AsInteger := edStatus.Tag;
      FDMem_RegistrosTIPO_PESSOA.AsString := edTipo.TagString;
      FDMem_RegistrosDOCUMENTO.AsString := edDocumento.Text;
      FDMem_RegistrosINSCRICAO_ESTADUAL.AsString := edInscEstadual.Text;
      FDMem_RegistrosINSCRICAO_MUNICIPAL.AsString := edInsMunicipal.Text;
      FDMem_RegistrosID_USUARIO.AsInteger := Dm_DeskTop.FDMem_UsuariosID.AsInteger;
      FDMem_RegistrosDT_CADASTRO.AsString := DateToStr(Date);
      FDMem_RegistrosHR_CADASTRO.AsString := TimeToStr(Time);
    FDMem_Registros.Post;

    if FStatusTable = stInsert then
    begin
      if not Dm_DeskTop.Empresa_Cadastro(FDMem_Registros.ToJSONArray,0) then
        raise Exception.Create('Erro ao salvar as alterações');
    end
    else if FStatusTable = stUpdate then
    begin
      if not Dm_DeskTop.Empresa_Cadastro(FDMem_Registros.ToJSONArray,1) then
        raise Exception.Create('Erro ao salvar as alterações');
    end;

    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(1);
    end);
  end);

  t.OnTerminate := ThreadEnd_SalvarRegistro;
  t.Start;
end;

procedure TfrmEmpresa.SelecionaTipo(Sender: TObject; AEdit: TEdit;
  ALabel: TLabel);
begin
  AEdit.Tag := TRectangle(Sender).Tag;
  case AEdit.Tag of
    0:AEdit.TagString := 'J';
    1:AEdit.TagString := 'F';
  end;
  AEdit.Text := ALabel.Text;
  SelTipo;
end;

procedure TfrmEmpresa.SelStatus;
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    rctStatus.Position.X := edStatus.Position.X;
    rctStatus.Position.Y := (lytRow_001.Position.Y + lytRow_001.Height);
    rctStatus.Width := edStatus.Width;
    rctStatus.Height := 60;
    if not rctStatus.Visible then
    begin
      FloatAnimation_SelStatus.StartValue := 0;
      FloatAnimation_SelStatus.StopValue := 60;
      imgStatus.Bitmap := imgRetrair.Bitmap;
    end
    else
    begin
      FloatAnimation_SelStatus.StartValue := 60;
      FloatAnimation_SelStatus.StopValue := 0;
      imgStatus.Bitmap := imgExpandir.Bitmap;
    end;
    TThread.Synchronize(nil, procedure
    begin
      if not rctStatus.Visible then
      begin
        rctStatus.Visible := (not rctStatus.Visible);
        FloatAnimation_SelStatus.Start;
      end
      else
      begin
        FloatAnimation_SelStatus.Start;
        rctStatus.Visible := (not rctStatus.Visible);
      end;
    end);
  end);

  t.OnTerminate := ThreadEnd_Status;
  t.Start;
end;

procedure TfrmEmpresa.SelTipo;
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    rctTipo.Position.X := edTipo.Position.X;
    rctTipo.Position.Y := (lytRow_001.Position.Y + lytRow_001.Height);
    rctTipo.Width := edTipo.Width;
    rctTipo.Height := 60;
    if not rctTipo.Visible then
    begin
      FloatAnimation_SelTipo.StartValue := 0;
      FloatAnimation_SelTipo.StopValue := 60;
      imgTipo.Bitmap := imgRetrair.Bitmap;
    end
    else
    begin
      FloatAnimation_SelTipo.StartValue := 60;
      FloatAnimation_SelTipo.StopValue := 0;
      imgTipo.Bitmap := imgExpandir.Bitmap;
    end;
    TThread.Synchronize(nil, procedure
    begin
      if not rctTipo.Visible then
      begin
        rctTipo.Visible := (not rctTipo.Visible);
        FloatAnimation_SelTipo.Start;
      end
      else
      begin
        FloatAnimation_SelTipo.Start;
        rctTipo.Visible := (not rctTipo.Visible);
      end;
    end);
  end);

  t.OnTerminate := ThreadEnd_Tipo;
  t.Start;
end;

procedure TfrmEmpresa.ThreadEnd_DeletarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmEmpresa.ThreadEnd_Edit(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'','Erro editar um registro: ' + Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Configura_Botoes(4);
    Exibe_Labels;
  end;
end;

procedure TfrmEmpresa.ThreadEnd_SalvarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmEmpresa.ThreadEnd_Status(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmEmpresa.ThreadEnd_Tipo(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

end.
