unit uDeskTop.CadUF;

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
  TExecuteOnClose = procedure(AId:Integer; ASiglaUF:String; ANome:String) of Object;

  TfrmUnidadeFederativa = class(TForm)
    FDMem_Registros: TFDMemTable;
    FDMem_RegistrosID: TIntegerField;
    FDMem_RegistrosNOME: TStringField;
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
    edRegiao: TEdit;
    lbRegiao: TLabel;
    FloatAnimation_Regiao: TFloatAnimation;
    imgRegiao: TImage;
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
    edIbge: TEdit;
    lbIbge: TLabel;
    FloatAnimation_Ibge: TFloatAnimation;
    edSigla: TEdit;
    lbSigla: TLabel;
    FloatAnimation_Sigla: TFloatAnimation;
    FDMem_RegistrosIBGE: TIntegerField;
    FDMem_RegistrosSIGLA: TStringField;
    FDMem_RegistrosID_REGIAO: TIntegerField;
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure rctFecharClick(Sender: TObject);
    procedure edPesquisarTyping(Sender: TObject);
    procedure rctConfirmarClick(Sender: TObject);
    procedure rctEditarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure lvListaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvListaPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure edNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edIbgeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edSiglaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edNomeTyping(Sender: TObject);
    procedure edIbgeTyping(Sender: TObject);
    procedure edSiglaTyping(Sender: TObject);
    procedure edRegiaoTyping(Sender: TObject);
    procedure edRegiaoClick(Sender: TObject);
  private
    FProcessando: String;

    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    lEnder_Ini :String;
    FFechar_Sistema :Boolean;
    FId_Selecionado :Integer;
    FNome_Selecionado :String;
    FSigla_Selecionada :String;
    FStatusTable: TStatusTable;

    FIdRegiao :Integer;

    procedure Abortar_Fechamento(Sender: TOBject);
    procedure Confirmar_Fechamento(Sender :TObject);

    {$Region 'Listar dados'}
      procedure Listar_Dados(
        const APagina:Integer;
        const ABusca:String;
        const AInd_Clear:Boolean);
      procedure AddHeader(AId: Integer; ANome: String);
      procedure AddItens_LV(
        const ACodigo:Integer;
        const ANome:String;
        const AIBGE:String;
        const ASigla:String);
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
    procedure Seleciona_Paises(AId:Integer; ANome:String);

  public
    ExecuteOnClose :TExecuteOnClose;
    RetornaRegistro :Boolean;
  end;

var
  frmUnidadeFederativa: TfrmUnidadeFederativa;

implementation

{$R *.fmx}

uses uDeskTop.CadRegioes;

{ TfrmUnidadeFederativa }

procedure TfrmUnidadeFederativa.Abortar_Fechamento(Sender: TOBject);
begin
  Abort;
end;

procedure TfrmUnidadeFederativa.Cancelar_Alteracoes(Sender: TOBject);
begin
  Configura_Botoes(2);
end;

procedure TfrmUnidadeFederativa.Configura_Botoes(ABotao: Integer);
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

procedure TfrmUnidadeFederativa.Confirmar_Fechamento(Sender: TObject);
begin
  if RetornaRegistro then
    ExecuteOnClose(FId_Selecionado,FSigla_Selecionada,FNome_Selecionado);

  FFechar_Sistema := True;
  Close;
end;

procedure TfrmUnidadeFederativa.Deletar_Registro(Sender: TOBject);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Dm_DeskTop.UF_Excluir(FId_Selecionado);
    TThread.Synchronize(nil,
    procedure
    begin
      Configura_Botoes(3);
    end);
  end);

  t.OnTerminate := ThreadEnd_DeletarRegistro;
  t.Start;
end;

procedure TfrmUnidadeFederativa.edIbgeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edSigla);
end;

procedure TfrmUnidadeFederativa.edIbgeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edIbge,lbIbge,FloatAnimation_Ibge,10,-20);
end;

procedure TfrmUnidadeFederativa.EditandoRegistro(const AId: Integer);
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
      jsonArray := Dm_DeskTop.UF_Lista(
        0
        ,AId
        ,0
        ,'');

      TThread.Synchronize(nil,
      procedure
      begin
        edNome.Tag := jsonArray.Get(x).GetValue<Integer>('id',0);
        edNome.Text := jsonArray.Get(x).GetValue<String>('nome','');
        edIbge.Tag := jsonArray.Get(x).GetValue<Integer>('ibge',0);
        edIbge.Text := jsonArray.Get(x).GetValue<Integer>('ibge',0).ToString;
        edSigla.Text := jsonArray.Get(x).GetValue<String>('sigla','');
        edRegiao.Tag := jsonArray.Get(x).GetValue<Integer>('idRegiao',0);
        edRegiao.Text := jsonArray.Get(x).GetValue<Integer>('regiao',0).ToString;
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

procedure TfrmUnidadeFederativa.EditarRegistro(Sender: TOBject);
begin
  EditandoRegistro(FId_Selecionado);
end;

procedure TfrmUnidadeFederativa.edNomeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edIbge);
end;

procedure TfrmUnidadeFederativa.edNomeTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNome,lbNome,FloatAnimation_Nome,10,-20);
end;

procedure TfrmUnidadeFederativa.edPesquisarKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmUnidadeFederativa.edPesquisarTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edPesquisar,lbPesquisar,FloatAnimation_Pesq,10,-20);
end;

procedure TfrmUnidadeFederativa.edRegiaoClick(Sender: TObject);
begin
  if not Assigned(frmCad_Regioes) then
    Application.CreateForm(TfrmCad_Regioes,frmCad_Regioes);
  frmCad_Regioes.RetornaRegistro := True;
  frmCad_Regioes.ExecuteOnClose := Seleciona_Paises;
  frmCad_Regioes.Show;
end;

procedure TfrmUnidadeFederativa.edRegiaoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edRegiao,lbRegiao,FloatAnimation_Regiao,10,-20);
end;

procedure TfrmUnidadeFederativa.edSiglaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edRegiao);
end;

procedure TfrmUnidadeFederativa.edSiglaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edSigla,lbSigla,FloatAnimation_Sigla,10,-20);
end;

procedure TfrmUnidadeFederativa.Exibe_Labels;
begin
  TFuncoes.ExibeLabel(edNome,lbNome,FloatAnimation_Nome,10,-20);
  TFuncoes.ExibeLabel(edIbge,lbIbge,FloatAnimation_Ibge,10,-20);
  TFuncoes.ExibeLabel(edSigla,lbSigla,FloatAnimation_Sigla,10,-20);
  TFuncoes.ExibeLabel(edRegiao,lbRegiao,FloatAnimation_Regiao,10,-20);
end;

procedure TfrmUnidadeFederativa.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
  frmUnidadeFederativa := Nil;
  FId_Selecionado := 0;
end;

procedure TfrmUnidadeFederativa.FormCreate(Sender: TObject);
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

  FMensagem := TFancyDialog.Create(frmUnidadeFederativa);

  FStatusTable := TStatusTable.stList;

  FIdRegiao := 0;
  tcPrincipal.ActiveTab := tiFiltro;

end;

procedure TfrmUnidadeFederativa.Incia_Campos;
begin
  edNome.Tag := 0;
  edNome.Text := '';
  edIbge.Tag := 0;
  edIbge.Text := '';
  edSigla.Text := '';
  edRegiao.Tag := 0;
  edRegiao.Text := '';

  Exibe_Labels;
end;

procedure TfrmUnidadeFederativa.Listar_Dados(const APagina: Integer;
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
    lRegiao_Ant :String;
    lCount :Integer;
  begin
    if lvLista.Tag >= 0 then
      lvLista.Tag := (lvLista.Tag + 1);

      jsonArray := Dm_DeskTop.UF_Lista(
        lvLista.Tag
        ,lCodigo
        ,FIdRegiao
        ,lNome);

      lRegiao_Ant := '';
      lCount := 0;

      for x := 0 to jsonArray.Size -1 do
      begin
        if lRegiao_Ant <> jsonArray.Get(x).GetValue<String>('regiao') then
        begin
          if lRegiao_Ant <> '' then
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
              jsonArray.Get(x).GetValue<Integer>('idRegiao')
              ,jsonArray.Get(x).GetValue<String>('regiao'));
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
              ,jsonArray.Get(x).GetValue<String>('sigla')
            );
        end);

        lRegiao_Ant := jsonArray.Get(x).GetValue<String>('regiao');
      end;

      TThread.Synchronize(nil,
      procedure
      begin
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

procedure TfrmUnidadeFederativa.AddItens_LV(
        const ACodigo:Integer;
        const ANome:String;
        const AIBGE:String;
        const ASigla:String);
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

procedure TfrmUnidadeFederativa.AddFooter(AQtd:Integer);
var
  lItem: TListViewItem;
begin
  lItem := lvLista.Items.Add;
  lItem.Purpose := TListItemPurpose.Footer;
  lItem.Text := AQtd.ToString + ' Regiões';
end;

procedure TfrmUnidadeFederativa.AddHeader(AId:Integer;ANome:String);
var
  lItem: TListViewItem;
begin
  lItem := lvLista.Items.Add;
  lItem.Purpose := TListItemPurpose.Header;
  lItem.Tag := AId;
  lItem.Text := ANome;
end;

procedure TfrmUnidadeFederativa.lvListaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FId_Selecionado := Aitem.Tag;
  FNome_Selecionado := AItem.TagString;
end;

procedure TfrmUnidadeFederativa.lvListaPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (lvLista.Items.Count >= 0) and (lvLista.Tag >= 0) then
  begin
    if lvLista.GetItemRect(lvLista.Items.Count - 3).Bottom <= lvLista.Height then
      Listar_Dados(lvLista.Tag,edPesquisar.Text,False)
  end;
end;

procedure TfrmUnidadeFederativa.Novo_Registro(Sender: TOBject);
begin
  Configura_Botoes(0);
end;

procedure TfrmUnidadeFederativa.rctCancelarClick(Sender: TObject);
begin
  case rctCancelar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Excluir','Deseja excluir o registro?','SIM',Deletar_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Cancelar','Deseja cancelar as alterações?','SIM',Cancelar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmUnidadeFederativa.rctConfirmarClick(Sender: TObject);
begin
  case rctConfirmar.Tag of
    0:FMensagem.Show(TIconDialog.Question,'Novo','Deseja adicionar um novo registro?','SIM',Novo_Registro,'NÃO');
    1:FMensagem.Show(TIconDialog.Question,'Salvar','Deseja salvar as alterações?','SIM',Salvar_Alteracoes,'NÃO');
  end;
end;

procedure TfrmUnidadeFederativa.rctEditarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Editar','Deseja editar o registro selecionado?','SIM',EditarRegistro,'NÃO');
end;

procedure TfrmUnidadeFederativa.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja fechar as Configurações?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

procedure TfrmUnidadeFederativa.Salvar_Alteracoes(Sender: TOBject);
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
    if Trim(edSigla.Text) = '' then
      raise Exception.Create('Sigla obrigatória');
    if edRegiao.Tag = 0 then
      raise Exception.Create('Código da Região obrigtória');

    FDMem_Registros.Active := False;
    FDMem_Registros.Active := True;
    FDMem_Registros.Insert;
      if FStatusTable = stInsert then
        FDMem_RegistrosID.AsInteger := 0
      else if FStatusTable = stUpdate then
        FDMem_RegistrosID.AsInteger := edNome.Tag;

      FDMem_RegistrosNOME.AsString := edNome.Text;
      FDMem_RegistrosIBGE.AsInteger := edIbge.Tag;
      FDMem_RegistrosSIGLA.AsString := edSigla.Text;
      FDMem_RegistrosID_REGIAO.AsInteger := edRegiao.Tag;

      FDMem_RegistrosID_USUARIO.AsInteger := Dm_DeskTop.FDMem_UsuariosID.AsInteger;
      FDMem_RegistrosDT_CADASTRO.AsString := DateToStr(Date);
      FDMem_RegistrosHR_CADASTRO.AsString := TimeToStr(Time);
    FDMem_Registros.Post;

    if FStatusTable = stInsert then
    begin
      if not Dm_DeskTop.UF_Cadastro(FDMem_Registros.ToJSONArray,0) then
        raise Exception.Create('Erro ao salvar as alterações');
    end
    else if FStatusTable = stUpdate then
    begin
      if not Dm_DeskTop.Paises_Cadastro(FDMem_Registros.ToJSONArray,1) then
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

procedure TfrmUnidadeFederativa.Seleciona_Paises(AId: Integer; ANome: String);
begin
  edRegiao.Tag := AId;
  edRegiao.Text := ANome;
end;

procedure TfrmUnidadeFederativa.ThreadEnd_DeletarRegistro(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FProcessando := '';
    Listar_Dados(0,edPesquisar.Text,True);
  end;
end;

procedure TfrmUnidadeFederativa.ThreadEnd_Edit(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'','Erro editar um registro: ' + Exception(TThread(Sender).FatalException).Message)
  else
  begin
    Configura_Botoes(4);
    Exibe_Labels;
  end;
end;

procedure TfrmUnidadeFederativa.ThreadEnd_Lista(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    if Pos('401',Exception(TThread(Sender).FatalException).Message) = 0 then
      FMensagem.Show(TIconDialog.Error,'','Erro na carga das Unidades Federativas: ' + Exception(TThread(Sender).FatalException).Message);
  end;
end;

procedure TfrmUnidadeFederativa.ThreadEnd_SalvarRegistro(Sender: TOBject);
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
