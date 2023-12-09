unit uDeskTop.CadMunicipios;

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

  TfrmMunicipios = class(TForm)
    FDMem_Registros: TFDMemTable;
    FDMem_RegistrosID: TIntegerField;
    FDMem_RegistrosID_USUARIO: TIntegerField;
    FDMem_RegistrosDT_CADASTRO: TDateField;
    FDMem_RegistrosHR_CADASTRO: TTimeField;
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
    edNome: TEdit;
    lbNome: TLabel;
    FloatAnimation_Nome: TFloatAnimation;
    lytRow_002: TLayout;
    edUF: TEdit;
    lbUF: TLabel;
    FloatAnimation_UF: TFloatAnimation;
    imgUF: TImage;
    edIbge: TEdit;
    lbIbge: TLabel;
    FloatAnimation_Ibge: TFloatAnimation;
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
    FDMem_RegistrosIBGE: TStringField;
    FDMem_RegistrosNOME: TStringField;
    FDMem_RegistrosSIGLA_UF: TStringField;
    FDMem_RegistrosUF: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPesquisarTyping(Sender: TObject);
    procedure lvListaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvListaPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure rctConfirmarClick(Sender: TObject);
    procedure rctEditarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edNomeTyping(Sender: TObject);
    procedure edIbgeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edIbgeTyping(Sender: TObject);
    procedure edSiglaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edUFClick(Sender: TObject);
    procedure edUFTyping(Sender: TObject);
    procedure rctFecharClick(Sender: TObject);
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

    lUF_Ant :String;
    lCount :Integer;

    FIdUF :Integer;

    procedure Abortar_Fechamento(Sender: TOBject);
    procedure Confirmar_Fechamento(Sender :TObject);

    {$Region 'Listar dados'}
      procedure Listar_Dados(
        const APagina: Integer;
        const ABusca: String;
        const AInd_Clear: Boolean);
      procedure AddHeader(ASiglaUF: String; ANome: String);
      procedure AddItens_LV(
        const ACodigo:Integer;
        const ANome:String;
        const AIBGE:String;
        const ASigla:String;
        const AUF:String);
      procedure AddFooter(AQtd: Integer);
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
    procedure Seleciona_UF(AId:Integer; ASiglaUF:String; ANome:String);

  public
    ExecuteOnClose :TExecuteOnClose;
    RetornaRegistro :Boolean;
  end;

var
  frmMunicipios: TfrmMunicipios;

implementation

{$R *.fmx}

uses uDeskTop.CadUF;

{ TfrmMunicipios }

procedure TfrmMunicipios.Abortar_Fechamento(Sender: TOBject);
begin
  Abort;
end;

procedure TfrmMunicipios.AddFooter(AQtd: Integer);
var
  lItem: TListViewItem;
begin
  lItem := lvLista.Items.Add;
  lItem.Purpose := TListItemPurpose.Footer;
  lItem.Text := AQtd.ToString + ' Municípios';
end;

procedure TfrmMunicipios.AddHeader(ASiglaUF: String; ANome: String);
var
  lItem: TListViewItem;
begin
  lItem := lvLista.Items.Add;
  lItem.Purpose := TListItemPurpose.Header;
  lItem.TagString := ASiglaUF;
  lItem.Text := ANome;
end;

procedure TfrmMunicipios.AddItens_LV(
        const ACodigo:Integer;
        const ANome:String;
        const AIBGE:String;
        const ASigla:String;
        const AUF:String);
begin
  with lvLista.Items.Add do
  begin
    Tag := ACodigo;
    TagString := ANome;
    TListItemText(Objects.FindDrawable('edNome')).TagString := ACodigo.ToString;
    TListItemText(Objects.FindDrawable('edNome')).Text := ANome;
    TListItemText(Objects.FindDrawable('edIBGE')).Text := AIBGE;
    TListItemText(Objects.FindDrawable('edSigla')).Text := ASigla;
    TListItemText(Objects.FindDrawable('edIBGE_Tit')).Text := 'IBGE';
    TListItemText(Objects.FindDrawable('edSigla_Tit')).Text := 'Sigla';
  end;
end;

procedure TfrmMunicipios.Cancelar_Alteracoes(Sender: TOBject);
begin
  Configura_Botoes(2);
end;

procedure TfrmMunicipios.Configura_Botoes(ABotao: Integer);
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

procedure TfrmMunicipios.Confirmar_Fechamento(Sender: TObject);
begin
  if RetornaRegistro then
    ExecuteOnClose(FId_Selecionado,FNome_Selecionado);

  FFechar_Sistema := True;
  Close;
end;

procedure TfrmMunicipios.Deletar_Registro(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.Municipios_Excluir(FId_Selecionado);
    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(3);
    end);
  end);

  t.OnTerminate := ThreadEnd_DeletarRegistro;
  t.Start;
end;

procedure TfrmMunicipios.edIbgeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edUF);
end;

procedure TfrmMunicipios.edIbgeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edIbge,lbIbge,FloatAnimation_Ibge,10,-20);
end;

procedure TfrmMunicipios.EditandoRegistro(const AId: Integer);
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
      jsonArray := Dm_DeskTop.Municipios_Lista(
        0
        ,AId
        ,''
        ,''
        ,'');

      TThread.Synchronize(nil,
      procedure
      begin
        edNome.Tag := jsonArray.Get(x).GetValue<Integer>('id',0);
        edNome.Text := jsonArray.Get(x).GetValue<String>('nome','');
        edIbge.Tag := jsonArray.Get(x).GetValue<Integer>('ibge',0);
        edIbge.Text := jsonArray.Get(x).GetValue<Integer>('ibge',0).ToString;
        edUF.Text := jsonArray.Get(x).GetValue<String>('unidadeFederativa','');
        edUF.TagString := jsonArray.Get(x).GetValue<String>('siglaUf','');
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

procedure TfrmMunicipios.EditarRegistro(Sender: TOBject);
begin
  EditandoRegistro(FId_Selecionado);
end;

procedure TfrmMunicipios.edNomeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edIbge);
end;

procedure TfrmMunicipios.edNomeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNome,lbNome,FloatAnimation_Nome,10,-20);
end;

procedure TfrmMunicipios.edPesquisarKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmMunicipios.edPesquisarTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPesquisar,lbPesquisar,FloatAnimation_Pesq,10,-20);
end;

procedure TfrmMunicipios.edSiglaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edUF);
end;

procedure TfrmMunicipios.edUFClick(Sender: TObject);
begin
  if not Assigned(frmUnidadeFederativa) then
    Application.CreateForm(TfrmUnidadeFederativa,frmUnidadeFederativa);
  frmUnidadeFederativa.RetornaRegistro := True;
  frmUnidadeFederativa.ExecuteOnClose := Seleciona_UF;
  frmUnidadeFederativa.Show;
end;

procedure TfrmMunicipios.edUFTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edUF,lbUF,FloatAnimation_UF,10,-20);
end;

procedure TfrmMunicipios.Exibe_Labels;
begin
  TFuncoes.ExibeLabel(edNome,lbNome,FloatAnimation_Nome,10,-20);
  TFuncoes.ExibeLabel(edIbge,lbIbge,FloatAnimation_Ibge,10,-20);
  TFuncoes.ExibeLabel(edUF,lbUF,FloatAnimation_UF,10,-20);
end;

procedure TfrmMunicipios.FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmMunicipios := Nil;
  FId_Selecionado := 0;
  FNome_Selecionado := '';
end;

procedure TfrmMunicipios.FormCreate(Sender: TObject);
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

  FMensagem := TFancyDialog.Create(frmMunicipios);

  FStatusTable := TStatusTable.stList;

  FIdUF := 0;
end;

procedure TfrmMunicipios.Incia_Campos;
begin
  edNome.Tag := 0;
  edNome.Text := '';
  edIbge.Tag := 0;
  edIbge.Text := '';
  edUF.Text := '';
  edUF.TagString := '';

  Exibe_Labels;
end;

procedure TfrmMunicipios.Listar_Dados(const APagina: Integer;
  const ABusca: String; const AInd_Clear: Boolean);
var
  t :TThread;
  lNome :String;
  lCodigo :Integer;

begin
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

  lvLista.BeginUpdate;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lErro :String;
    x : integer;
    jsonArray: TJSONArray;
  begin
    if lvLista.Tag >= 0 then
      lvLista.Tag := (lvLista.Tag + 1);

      jsonArray := Dm_DeskTop.Municipios_Lista(
        lvLista.Tag
        ,lCodigo
        ,''
        ,''
        ,lNome);

      //if AInd_Clear then
      //begin
      //  lUF_Ant := '';
      //  lCount := 0;
      //end;

      for x := 0 to jsonArray.Size -1 do
      begin
        if lUF_Ant <> jsonArray.Get(x).GetValue<String>('siglaUf') then
        begin
          if lUF_Ant <> '' then
          begin
            TThread.Synchronize(nil,
            procedure
            begin
              AddFooter(lCount);
              lCount := 0;
            end);
          end;

          TThread.Synchronize(nil,
          procedure
          begin
            AddHeader(
              jsonArray.Get(x).GetValue<String>('siglaUf')
              ,jsonArray.Get(x).GetValue<String>('unidadeFederativa'));
          end);
        end;

        Inc(lCount);

        TThread.Synchronize(nil,
        procedure
        begin
            AddItens_LV(
              jsonArray.Get(x).GetValue<Integer>('id')
              ,jsonArray.Get(x).GetValue<String>('nome')
              ,jsonArray.Get(x).GetValue<String>('ibge')
              ,jsonArray.Get(x).GetValue<String>('siglaUf')
              ,jsonArray.Get(x).GetValue<String>('unidadeFederativa')
            );
        end);

        lUF_Ant := jsonArray.Get(x).GetValue<String>('siglaUf');
      end;

      TThread.Synchronize(nil,
      procedure
      begin
        if lvLista.GetItemRect(lvLista.Items.Count - 3).Bottom <= lvLista.Height then
          AddFooter(lCount);
      end);

      if jsonArray.Size = 0 then
        lvLista.Tag := -1;

      {$IFDEF MSWINDOWS}
        FreeAndNil(jsonArray);
      {$ELSE}
        jsonArray.DisposeOf;
      {$ENDIF}


      TThread.Synchronize(nil, procedure
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

procedure TfrmMunicipios.lvListaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FId_Selecionado := Aitem.Tag;
  FNome_Selecionado := AItem.TagString;
end;

procedure TfrmMunicipios.lvListaPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvLista.Items.Count >= 0) and (lvLista.Tag >= 0) then
  begin
    if lvLista.GetItemRect(lvLista.Items.Count - 3).Bottom <= lvLista.Height then
      Listar_Dados(lvLista.Tag,edPesquisar.Text,False)
  end;
end;

procedure TfrmMunicipios.Novo_Registro(Sender: TOBject);
begin
  Configura_Botoes(0);
end;

procedure TfrmMunicipios.rctCancelarClick(Sender: TObject);
begin
  case rctCancelar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Excluir','Deseja excluir o registro?','SIM',Deletar_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Cancelar','Deseja cancelar as alterações?','SIM',Cancelar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmMunicipios.rctConfirmarClick(Sender: TObject);
begin
  case rctConfirmar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Novo','Deseja adicionar um novo registro?','SIM',Novo_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Salvar','Deseja salvar as alterações?','SIM',Salvar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmMunicipios.rctEditarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o registro selecionado?','SIM',EditarRegistro,'NÃO');
end;

procedure TfrmMunicipios.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja fechar as Configurações?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

procedure TfrmMunicipios.Salvar_Alteracoes(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    if Trim(edNome.Text) = '' then
      raise Exception.Create('Nome obrigatório');
    if edIbge.Tag = 0 then
      raise Exception.Create('Código IBGE obrigtório');
    if Trim(edUF.Text) = '' then
      raise Exception.Create('Unidade Federativa obrigatória');

    FDMem_Registros.Active := False;
    FDMem_Registros.Active := True;
    FDMem_Registros.Insert;
      if FStatusTable = stInsert then
        FDMem_RegistrosID.AsInteger := 0
      else if FStatusTable = stUpdate then
        FDMem_RegistrosID.AsInteger := edNome.Tag;

      FDMem_RegistrosNOME.AsString := edNome.Text;
      FDMem_RegistrosIBGE.AsString := edIbge.Text;
      FDMem_RegistrosUF.AsString := edUF.Text;
      FDMem_RegistrosSIGLA_UF.AsString := edUF.TagString;
      FDMem_RegistrosID_USUARIO.AsInteger := Dm_DeskTop.FDMem_UsuariosID.AsInteger;
      FDMem_RegistrosDT_CADASTRO.AsString := DateToStr(Date);
      FDMem_RegistrosHR_CADASTRO.AsString := TimeToStr(Time);
    FDMem_Registros.Post;

    if FStatusTable = stInsert then
    begin
      if not Dm_DeskTop.Municipios_Cadastro(FDMem_Registros.ToJSONArray,0) then
        raise Exception.Create('Erro ao salvar as alterações');
    end
    else if FStatusTable = stUpdate then
    begin
      if not Dm_DeskTop.Municipios_Cadastro(FDMem_Registros.ToJSONArray,1) then
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

procedure TfrmMunicipios.Seleciona_UF(AId:Integer; ASiglaUF:String; ANome:String);
begin
  edUF.TagString := ASiglaUF;
  edUF.Text := ANome;
end;

procedure TfrmMunicipios.ThreadEnd_DeletarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmMunicipios.ThreadEnd_Edit(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'','Erro editar um registro: ' + Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Configura_Botoes(4);
    Exibe_Labels;
  end;
end;

procedure TfrmMunicipios.ThreadEnd_Lista(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga dos Municípios: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmMunicipios.ThreadEnd_SalvarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

end.
