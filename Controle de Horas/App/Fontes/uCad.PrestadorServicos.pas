unit uCad.PrestadorServicos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region 'Frame'}
    uFrame.PrestServico,
  {$EndRegion 'Frame'}

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uCombobox,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uACBr,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Effects, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.ListBox, FMX.TabControl, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;
  TTab_Status = (dsInsert,dsEdit,dsLista);

  TfrmCad_PrestadorServicos = class(TForm)
    imgCancelar: TImage;
    imgChecked: TImage;
    imgEditar: TImage;
    imgEsconder: TImage;
    imgExcluir: TImage;
    imgExibir: TImage;
    imgNovo: TImage;
    imgSalvar: TImage;
    imgUnChecked: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytLista: TLayout;
    lbRegistros: TListBox;
    lytFiltro: TLayout;
    edFiltro: TEdit;
    imgLimpar: TImage;
    tiCampos: TTabItem;
    lytCampos: TLayout;
    lytCampos_001: TLayout;
    lytRow_001: TLayout;
    lytID: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytRow_002: TLayout;
    lytNOME: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytRow_003: TLayout;
    lytCELULAR: TLayout;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    lytRow_004: TLayout;
    lytEMAIL: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    imgAcao_01: TImage;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgVoltar: TImage;
    procedure imgVoltarClick(Sender: TObject);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure edCELULARTyping(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure imgLimparClick(Sender: TObject);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    FPesquisa: Boolean;
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    cComboPessoa :TCustomCombo;
    cComboUF :TCustomCombo;
    FMenu_Frame :TActionSheet;

    FId :Integer;
    FNome :String;

    FACBr_Validador :TACBr_Validador;


    procedure SetPesquisa(const Value: Boolean);

    procedure LimparCampos;
    procedure Salvar;
    procedure TTHreadEnd_Salvar(Sender: TOBject);
    procedure Cancelar(Sender: TOBject);
    procedure Listar_Registros(APesquisa:String);
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure AddRegistros_LB(AId,ASincronizado,AExcluido:Integer; ANome:String);
    procedure Abre_Menu_Registros(Sender :TOBject);
    procedure CriandoMenus;
    procedure Editar(Sender: TOBject);
    procedure Excluir(Sender: TObject);
    procedure TThreadEnd_Editar(Sender: TOBject);
    procedure Excluir_Registro(Sender: TObject);
    procedure TThreadEnd_ExcluirRegistro(Sender: TOBject);

  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_PrestadorServicos: TfrmCad_PrestadorServicos;

implementation

{$R *.fmx}

uses uCad.Empresa;

{ TfrmCad_PrestadorServicos }

procedure TfrmCad_PrestadorServicos.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_PrestServico;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_PrestServico;

  FId := FFrame.lbNome.Tag;
  FNome := FFrame.lbNome.Text;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmCad_PrestadorServicos.AddRegistros_LB(AId,ASincronizado,AExcluido:Integer; ANome:String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_PrestServico;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 50;
    FItem.Tag := AId;
    FItem.TagString := ANome;
    FItem.Selectable := True;

    FFrame := TFrame_PrestServico.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbNome.Text := ANome;
    FFrame.lbNome.Tag := AId;
    case ASincronizado of
      0:FFrame.imgSincronizado.Opacity := 0.3;
      1:FFrame.imgSincronizado.Opacity := 1;
    end;
    case AExcluido of
      0:FFrame.imgExcluído.Opacity := 0.3;
      1:FFrame.imgExcluído.Opacity := 1;
    end;
    FFrame.rctMenu.OnClick := Abre_Menu_Registros;

    lbRegistros.AddObject(FItem);

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

procedure TfrmCad_PrestadorServicos.Cancelar(Sender: TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmCad_PrestadorServicos.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmCad_PrestadorServicos);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);

end;

procedure TfrmCad_PrestadorServicos.edCELULARKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;

end;

procedure TfrmCad_PrestadorServicos.edCELULARTyping(Sender: TObject);
begin
  Formatar(edCELULAR,Celular);
end;

procedure TfrmCad_PrestadorServicos.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);

end;

procedure TfrmCad_PrestadorServicos.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmCad_PrestadorServicos,'Editando o Registro');
  LimparCampos;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('SELECT  ');
    FQuery.Sql.Add('  PS.*  ');
    FQuery.Sql.Add('FROM PRESTADOR_SERVICO PS ');
    FQuery.Sql.Add('WHERE PS.ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.Active := True;
    if not FQuery.IsEmpty then
    begin
      FQuery.First;
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        edID.Tag := FQuery.FieldByName('ID').AsInteger;
        edID.Text := FQuery.FieldByName('ID').AsString;
        edNOME.Text := FQuery.FieldByName('NOME').AsString;
        edCELULAR.Text := FQuery.FieldByName('CELULAR').AsString;
        edEMAIL.Text := FQuery.FieldByName('EMAIL').AsString;
      end);
    end;

    {$IFDEF MSWINDWOS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}

  end);

  t.OnTerminate := TThreadEnd_Editar;
  t.Start;
end;

procedure TfrmCad_PrestadorServicos.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCELULAR.SetFocus;
end;

procedure TfrmCad_PrestadorServicos.Excluir(Sender: TObject);
begin
  //FFancyDialog.Show(TIconDialog.Info,'Atenção',FId.ToString + ' - ' + FNome,'Ok');
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmCad_PrestadorServicos.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_PrestadorServicos,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE PRESTADOR_SERVICO SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmCad_PrestadorServicos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(FACBr_Validador);
    FreeAndNil(FMenu_Frame);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    FACBr_Validador.DisposeOf;
    FMenu_Frame.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmCad_PrestadorServicos := Nil;

end;

procedure TfrmCad_PrestadorServicos.FormCreate(Sender: TObject);
begin

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FACBr_Validador := TACBr_Validador.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_PrestadorServicos);
  CriandoMenus;

  tcPrincipal.ActiveTab := tiLista;
  FDm_Global := TDM_Global.Create(Nil);
  FTab_Status := dsLista;
  Pesquisa := False;
end;

procedure TfrmCad_PrestadorServicos.FormShow(Sender: TObject);
begin
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_PrestadorServicos.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      FTab_Status := dsInsert;
      LimparCampos;
      imgAcao_01.Tag := 1;
      imgAcao_01.Bitmap := imgSalvar.Bitmap;
      tcPrincipal.GotoVisibleTab(1);
      if edNOME.CanFocus then
        edNOME.SetFocus;
    end;
    1:Salvar;
  end;

end;

procedure TfrmCad_PrestadorServicos.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_PrestadorServicos.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FNome);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

procedure TfrmCad_PrestadorServicos.lbRegistrosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FNome := Item.TagString;
end;

procedure TfrmCad_PrestadorServicos.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edNOME.Text := '';
  edCELULAR.Text := '';
  edEMAIL.Text := '';
end;

procedure TfrmCad_PrestadorServicos.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmCad_PrestadorServicos,'Listando Registros');
  lbRegistros.Clear;
  lbRegistros.BeginUpdate;

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('SELECT  ');
    FQuery.Sql.Add('  PS.*  ');
    FQuery.Sql.Add('FROM PRESTADOR_SERVICO PS ');
    FQuery.Sql.Add('WHERE NOT PS.ID IS NULL ');
    if Trim(APesquisa) <> '' then
    begin
      FQuery.Sql.Add('  AND PS.NOME LIKE :NOME');
      FQuery.ParamByName('NOME').AsString := '%' + APesquisa + '%';
    end;
    FQuery.Active := True;
    if not FQuery.IsEmpty then
    begin
      FQuery.First;
      while not FQuery.Eof do
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          AddRegistros_LB(
            FQuery.FieldByName('ID').AsInteger
            ,FQuery.FieldByName('SINCRONIZADO').AsInteger
            ,FQuery.FieldByName('EXCLUIDO').AsInteger
            ,FQuery.FieldByName('NOME').AsString
          );
        end);

        FQuery.Next;
      end;
    end;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbRegistros.EndUpdate;
    end);

    if Assigned(FQuery) then
      FreeAndNil(FQuery);

  end);

  t.OnTerminate := TThreadEnd_Listar_Registros;
  t.Start;

end;

procedure TfrmCad_PrestadorServicos.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_PrestadorServicos,'Salvando alterações');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;

    if FTab_Status = dsInsert then
    begin
      FQuery.Sql.Add('INSERT INTO PRESTADOR_SERVICO( ');
      FQuery.Sql.Add('  NOME ');
      FQuery.Sql.Add('  ,CELULAR ');
      FQuery.Sql.Add('  ,EMAIL ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HF_CADASTRO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :NOME ');
      FQuery.Sql.Add('  ,:CELULAR ');
      FQuery.Sql.Add('  ,:EMAIL ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HF_CADASTRO ');
      FQuery.Sql.Add('  ,:SINCRONIZADO ');
      FQuery.Sql.Add('  ,:ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,:EXCLUIDO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HF_CADASTRO').AsTime := Time;
      FQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
      FQuery.ParamByName('ID_PRINCIPAL').AsInteger := 0;
      FQuery.ParamByName('EXCLUIDO').AsInteger := 0;
    end
    else if FTab_Status = dsEdit then
    begin
      FQuery.Sql.Add('UPDATE PRESTADOR_SERVICO SET ');
      FQuery.Sql.Add('  NOME = :NOME ');
      FQuery.Sql.Add('  ,CELULAR = :CELULAR ');
      FQuery.Sql.Add('  ,EMAIL = :EMAIL ');
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('NOME').AsString := edNOME.Text;
    FQuery.ParamByName('CELULAR').AsString := edCELULAR.Text;
    FQuery.ParamByName('EMAIL').AsString := edEMAIL.Text;
    FQuery.ExecSQL;

    {$IFDEF MSWINDOWS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}

  end);

  t.OnTerminate := TTHreadEnd_Salvar;
  t.Start;
end;

procedure TfrmCad_PrestadorServicos.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_PrestadorServicos.TThreadEnd_Editar(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FTab_Status := dsEdit;
    imgAcao_01.Tag := 1;
    imgAcao_01.Bitmap := imgSalvar.Bitmap;
    tcPrincipal.GotoVisibleTab(1);
  end;
end;

procedure TfrmCad_PrestadorServicos.TThreadEnd_ExcluirRegistro(Sender: TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_PrestadorServicos.TThreadEnd_Listar_Registros(Sender: TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmCad_PrestadorServicos.TTHreadEnd_Salvar(Sender: TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Salvar',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FTab_Status := dsLista;
    imgAcao_01.Tag := 0;
    imgAcao_01.Bitmap := imgNovo.Bitmap;
    tcPrincipal.GotoVisibleTab(0);
    Listar_Registros(edFiltro.Text);
  end;
end;

end.
