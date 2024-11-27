unit uCad.Usuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
    uActionSheet,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,
  uACBr,
  uModelo.Dados,
  uFrame.Usuario,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.TabControl,
  FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Edit, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox;

type
  TTab_Status = (dsInsert,dsEdit,dsLista);
  TExecuteOnClose = procedure(Aid:Integer; ANome,ALogin,AEMail:String) of Object;

  TfrmCad_Usuario = class(TForm)
    lytHeader: TLayout;
    lytDetail: TLayout;
    lytFooter: TLayout;
    rctHeader: TRectangle;
    rctFooter: TRectangle;
    imgVoltar: TImage;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    tiCampos: TTabItem;
    lytLista: TLayout;
    lytCampos: TLayout;
    imgAcao_01: TImage;
    imgNovo: TImage;
    imgExcluir: TImage;
    imgSalvar: TImage;
    imgCancelar: TImage;
    imgChecked: TImage;
    imgUnChecked: TImage;
    lytFiltro: TLayout;
    edFiltro: TEdit;
    imgLimpar: TImage;
    lytRow_001: TLayout;
    lytID: TLayout;
    lytPIN: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lbPIN: TLabel;
    edPIN: TEdit;
    lytRow_002: TLayout;
    lytNOME: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytRow_003: TLayout;
    lytLOGIN: TLayout;
    lbLOGIN: TLabel;
    edLOGIN: TEdit;
    lytRow_004: TLayout;
    lytSENHA: TLayout;
    lbSENHA: TLabel;
    edSENHA: TEdit;
    lytRow_006: TLayout;
    lytCELULAR: TLayout;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    lytRow_005: TLayout;
    lytEMAIL: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lytRow_008: TLayout;
    lytID_PRESTADOR_SERVICO: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO: TEdit;
    lytRow_007: TLayout;
    Layout9: TLayout;
    Label9: TLabel;
    edID_EMPRESA: TEdit;
    imgEditar: TImage;
    imgSenha: TImage;
    imgExibir: TImage;
    imgEsconder: TImage;
    Image1: TImage;
    Image2: TImage;
    lbRegistros: TListBox;
    procedure imgVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edPINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edLOGINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSENHAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARTyping(Sender: TObject);
    procedure imgAcao_01Click(Sender: TObject);
    procedure imgSenhaClick(Sender: TObject);
    procedure edID_EMPRESAClick(Sender: TObject);
    procedure edID_PRESTADOR_SERVICOClick(Sender: TObject);
    procedure imgLimparClick(Sender: TObject);
    procedure edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    FPesquisa: Boolean;
    FMenu_Frame :TActionSheet;
    FUsuario :TUsuario;
    FEmpresa :TEmpresa;
    FPrestServicos :TPrestServicos;

    FId :Integer;
    FNome :String;
    FLogin :String;
    FEmail :String;

    FACBr_Validador :TACBr_Validador;

    procedure Configura_Botoes;
    procedure Listar_Registros(APesquisa: String);
    procedure AddRegistros_LB(AId,ASincronizado,AExcluido:Integer; ANome,ALogin:String);
    procedure Abre_Menu_Registros(Sender :TOBject);
    procedure CriandoMenus;
    procedure Cancelar(Sender: TOBject);
    procedure LimparCampos;
    procedure Salvar;
    procedure Editar(Sender: TOBject);
    procedure Excluir(Sender: TObject);
    procedure Excluir_Registro(Sender: TObject);
    procedure TTHreadEnd_Salvar(Sender: TOBject);
    procedure Sel_Empresa(Aid:Integer; ANome:String);
    procedure Sel_PrestServico(Aid: Integer; ANome: String);
    procedure SetPesquisa(const Value: Boolean);
    procedure TThreadEnd_Listar_Registros(Sender: TObject);
    procedure TThreadEnd_Editar(Sender: TOBject);
    procedure TThreadEnd_ExcluirRegistro(Sender: TOBject);

  public
    ExecuteOnClose :TExecuteOnClose;
    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_Usuario: TfrmCad_Usuario;

implementation

{$R *.fmx}

uses
  uCad.Empresa
  ,uCad.PrestadorServicos;

procedure TfrmCad_Usuario.edCELULARTyping(Sender: TObject);
begin
  Formatar(edCELULAR,Celular);
end;

procedure TfrmCad_Usuario.edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCELULAR.SetFocus;

end;

procedure TfrmCad_Usuario.edFiltroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_Usuario.edID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa,frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Show;
end;

procedure TfrmCad_Usuario.edID_PRESTADOR_SERVICOClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_PrestadorServicos) then
    Application.CreateForm(TfrmCad_PrestadorServicos,frmCad_PrestadorServicos);

  frmCad_PrestadorServicos.Pesquisa := True;
  frmCad_PrestadorServicos.ExecuteOnClose := Sel_PrestServico;
  frmCad_PrestadorServicos.Show;
end;

procedure TfrmCad_Usuario.Editar(Sender: TOBject);
var
  t :TThread;
begin
  FMenu_Frame.HideMenu;
  TLoading.Show(frmCad_Usuario,'Editando o Registro');
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
    FQuery.Sql.Add('  E.*  ');
    FQuery.Sql.Add('FROM USUARIO E ');
    FQuery.Sql.Add('WHERE E.ID = :ID ');
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
        edPIN.Text := FQuery.FieldByName('PIN').AsString;
        edLOGIN.Text := FQuery.FieldByName('LOGIN').AsString;
        edSENHA.Text := FQuery.FieldByName('SENHA').AsString;
        edCELULAR.Text := FQuery.FieldByName('CELULAR').AsString;
        edEMAIL.Text := FQuery.FieldByName('EMAIL').AsString;
        edID_EMPRESA.Tag := FQuery.FieldByName('ID_EMPRESA').AsInteger;
        with FEmpresa.Lista_Registros(edID_EMPRESA.Tag) do
        begin
          if not IsEmpty then
          begin
            edID_EMPRESA.Text := FieldByName('NOME').AsString;
            {$IFDEF MSWINDOWS}
              Free;
            {$ELSE}
              DisposeOf;
            {$ENDIF}
          end;
        end;
        edID_PRESTADOR_SERVICO.Tag := FQuery.FieldByName('ID_PRESTADOR_SERVICO').AsInteger;
        with FPrestServicos.Lista_Registros(edID_PRESTADOR_SERVICO.Tag) do
        begin
          if not IsEmpty then
          begin
            edID_PRESTADOR_SERVICO.Text := FieldByName('NOME').AsString;
            {$IFDEF MSWINDOWS}
              Free;
            {$ELSE}
              DisposeOf;
            {$ENDIF}
          end;
        end;
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

procedure TfrmCad_Usuario.TThreadEnd_Editar(Sender :TOBject);
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

procedure TfrmCad_Usuario.Sel_Empresa(Aid:Integer; ANome:String);
begin
  edID_EMPRESA.Tag := Aid;
  edID_EMPRESA.Text := ANome;
end;

procedure TfrmCad_Usuario.Sel_PrestServico(Aid:Integer; ANome:String);
begin
  edID_PRESTADOR_SERVICO.Tag := Aid;
  edID_PRESTADOR_SERVICO.Text := ANome;
end;

procedure TfrmCad_Usuario.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

procedure TfrmCad_Usuario.edLOGINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edSENHA.SetFocus;

end;

procedure TfrmCad_Usuario.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edLOGIN.SetFocus;

end;

procedure TfrmCad_Usuario.edPINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    edNOME.SetFocus;
end;

procedure TfrmCad_Usuario.edSENHAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;

end;

procedure TfrmCad_Usuario.Excluir(Sender: TObject);
begin
  //FFancyDialog.Show(TIconDialog.Info,'Atenção',FId.ToString + ' - ' + FNome,'Ok');
  FMenu_Frame.HideMenu;
  FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja excluir o registro?','Sim',Excluir_Registro,'Não');
end;

procedure TfrmCad_Usuario.Excluir_Registro(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmCad_Usuario,'Excluindo registro');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    FQuery :TFDQuery;
  begin
    FQuery := TFDQuery.Create(Nil);
    FQuery.Connection := FDm_Global.FDC_SQLite;
    FQuery.Active := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Add('UPDATE USUARIO SET EXCLUIDO = 1 WHERE ID = :ID ');
    FQuery.ParamByName('ID').AsInteger := FId;
    FQuery.ExecSQL;;
  end);

  t.OnTerminate := TThreadEnd_ExcluirRegistro;
  t.Start;
end;

procedure TfrmCad_Usuario.TThreadEnd_ExcluirRegistro(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_Usuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FFancyDialog);
    FreeAndNil(FIniFile);
    FreeAndNil(FDm_Global);
    FreeAndNil(FMenu_Frame);
    FreeAndNil(FUsuario);
    FreeAndNil(FEmpresa);
    FreeAndNil(FPrestServicos);
  {$ELSE}
    FFancyDialog.DisposeOf;
    FIniFile.DisposeOf;
    FDm_Global.DisposeOf;
    FMenu_Frame.DisposeOf;
    FUsuario.DisposeOf;
    FEmpresa.DisposeOf;
    FPrestServicos.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmCad_Usuario := Nil;
end;

procedure TfrmCad_Usuario.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'CONTROLE_HORAS.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FFancyDialog := TFancyDialog.Create(frmCad_Usuario);

  tcPrincipal.ActiveTab := tiLista;

  FDm_Global := TDM_Global.Create(Nil);
  FUsuario := TUsuario.Create(FDm_Global.FDC_SQLite,FEnder);
  FEmpresa := TEmpresa.Create(FDm_Global.FDC_SQLite,FEnder);
  FPrestServicos := TPrestServicos.Create(FDm_Global.FDC_SQLite,FEnder);

  FTab_Status := dsLista;
  CriandoMenus;

  Listar_Registros(edFiltro.Text);
  Configura_Botoes;
end;

procedure TfrmCad_Usuario.Listar_Registros(APesquisa: String);
var
  t :TThread;
begin
  TLoading.Show(frmCad_Usuario,'Listando Registros');
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
    FQuery.Sql.Add('  E.*  ');
    FQuery.Sql.Add('FROM USUARIO E ');
    FQuery.Sql.Add('WHERE NOT E.ID IS NULL ');
    if Trim(APesquisa) <> '' then
    begin
      FQuery.Sql.Add('  AND E.NOME LIKE :NOME');
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
            ,FQuery.FieldByName('LOGIN').AsString
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

procedure TfrmCad_Usuario.TThreadEnd_Listar_Registros(Sender :TObject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FFancyDialog.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

procedure TfrmCad_Usuario.Configura_Botoes;
begin

end;

procedure TfrmCad_Usuario.CriandoMenus;
begin
  FMenu_Frame := TActionSheet.Create(frmCad_Usuario);

  FMenu_Frame.TitleFontSize := 12;
  FMenu_Frame.TitleMenuText := 'O que deseja fazer?';
  FMenu_Frame.TitleFontColor := $FFA3A3A3;

  FMenu_Frame.CancelMenuText := 'Cancelar';
  FMenu_Frame.CancelFontSize := 15;
  FMenu_Frame.CancelFontColor := $FF363428;

  FMenu_Frame.AddItem('','Editar Rebistro',Editar,$FF363428,16);
  FMenu_Frame.AddItem('','Excluir Registro',Excluir,$FF363428,16);
end;

procedure TfrmCad_Usuario.imgAcao_01Click(Sender: TObject);
begin
  case imgAcao_01.Tag of
    0:begin
      FTab_Status := dsInsert;
      LimparCampos;
      imgAcao_01.Tag := 1;
      imgAcao_01.Bitmap := imgSalvar.Bitmap;
      tcPrincipal.GotoVisibleTab(1);
      if edPIN.CanFocus then
        edPIN.SetFocus;
    end;
    1:Salvar;
  end;
end;

procedure TfrmCad_Usuario.imgLimparClick(Sender: TObject);
begin
  edFiltro.Text := '';
  Listar_Registros(edFiltro.Text);
end;

procedure TfrmCad_Usuario.imgSenhaClick(Sender: TObject);
begin
  case imgSenha.Tag of
    0:begin
      imgSenha.Tag := 1;
      imgSenha.Bitmap := imgEsconder.Bitmap;
      edSENHA.Password := False;
    end;
    1:begin
      imgSenha.Tag := 0;
      imgSenha.Bitmap := imgExibir.Bitmap;
      edSENHA.Password := True;
    end;
  end;
end;

procedure TfrmCad_Usuario.Salvar;
var
  t :TThread;
begin
  TLoading.Show(frmCad_Usuario,'Salvando alterações');

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
      FQuery.Sql.Add('INSERT INTO USUARIO( ');
      FQuery.Sql.Add('  NOME ');
      FQuery.Sql.Add('  ,LOGIN ');
      FQuery.Sql.Add('  ,SENHA ');
      FQuery.Sql.Add('  ,PIN ');
      FQuery.Sql.Add('  ,CELULAR ');
      FQuery.Sql.Add('  ,EMAIL ');
      FQuery.Sql.Add('  ,ID_EMPRESA ');
      FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,FOTO ');
      FQuery.Sql.Add('  ,DT_CADASTRO ');
      FQuery.Sql.Add('  ,HR_CADASTRO ');
      FQuery.Sql.Add('  ,SINCRONIZADO ');
      FQuery.Sql.Add('  ,ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,EXCLUIDO ');
      FQuery.Sql.Add(') VALUES( ');
      FQuery.Sql.Add('  :NOME ');
      FQuery.Sql.Add('  ,:LOGIN ');
      FQuery.Sql.Add('  ,:SENHA ');
      FQuery.Sql.Add('  ,:PIN ');
      FQuery.Sql.Add('  ,:CELULAR ');
      FQuery.Sql.Add('  ,:EMAIL ');
      FQuery.Sql.Add('  ,:ID_EMPRESA ');
      FQuery.Sql.Add('  ,:ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,:FOTO ');
      FQuery.Sql.Add('  ,:DT_CADASTRO ');
      FQuery.Sql.Add('  ,:HR_CADASTRO ');
      FQuery.Sql.Add('  ,:SINCRONIZADO ');
      FQuery.Sql.Add('  ,:ID_PRINCIPAL ');
      FQuery.Sql.Add('  ,:EXCLUIDO ');
      FQuery.Sql.Add('); ');
      FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
      FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
      FQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
      FQuery.ParamByName('ID_PRINCIPAL').AsInteger := 0;
      FQuery.ParamByName('EXCLUIDO').AsInteger := 0;
    end
    else if FTab_Status = dsEdit then
    begin
      FQuery.Sql.Add('UPDATE USUARIO SET ');
      FQuery.Sql.Add('  NOME = :NOME ');
      FQuery.Sql.Add('  ,LOGIN = :LOGIN ');
      FQuery.Sql.Add('  ,SENHA = :SENHA ');
      FQuery.Sql.Add('  ,PIN = :PIN ');
      FQuery.Sql.Add('  ,CELULAR = :CELULAR ');
      FQuery.Sql.Add('  ,EMAIL = :EMAIL ');
      FQuery.Sql.Add('  ,ID_EMPRESA = :ID_EMPRESA ');
      FQuery.Sql.Add('  ,ID_PRESTADOR_SERVICO = :ID_PRESTADOR_SERVICO ');
      FQuery.Sql.Add('  ,FOTO = :FOTO ');
      FQuery.Sql.Add('WHERE ID = :ID ');
      FQuery.ParamByName('ID').AsInteger := edID.Tag;
    end;
    FQuery.ParamByName('NOME').AsString := edNOME.Text;
    FQuery.ParamByName('LOGIN').AsString := edLOGIN.Text;
    FQuery.ParamByName('SENHA').AsString := edSENHA.Text;
    FQuery.ParamByName('PIN').AsString := edPIN.Text;
    FQuery.ParamByName('CELULAR').AsString := edCELULAR.Text;
    FQuery.ParamByName('EMAIL').AsString := edEMAIL.Text;
    FQuery.ParamByName('ID_EMPRESA').AsInteger := edID_EMPRESA.Tag;
    FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := edID_PRESTADOR_SERVICO.Tag;
    FQuery.ParamByName('FOTO').AsString := '';
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

procedure TfrmCad_Usuario.TTHreadEnd_Salvar(Sender :TOBject);
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

procedure TfrmCad_Usuario.imgVoltarClick(Sender: TObject);
begin
  case tcPrincipal.TabIndex of
    0:begin
      if FPesquisa then
        ExecuteOnClose(FId,FNome,FLogin,FEmail);
      Close;
    end;
    1:FFancyDialog.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações realizadas','Sim',Cancelar,'Não');
  end;
end;

procedure TfrmCad_Usuario.lbRegistrosItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FId := Item.Tag;
  FNome := Item.TagString;
  FLogin := '';
  FEmail := '';
end;

procedure TfrmCad_Usuario.Abre_Menu_Registros(Sender: TOBject);
var
  FFrame :TFrame_Usuario;
  FRctMenu :TRectangle;

begin
  FRctMenu := TRectangle(Sender);
  FFrame := FRctMenu.Parent as TFrame_Usuario;

  FId := FFrame.lbNome.Tag;
  FNome := FFrame.lbNome.Text;
  FLogin := FFrame.lbLogin.Text;

  FMenu_Frame.ShowMenu;
end;

procedure TfrmCad_Usuario.AddRegistros_LB(AId, ASincronizado, AExcluido: Integer; ANome, ALogin: String);
var
  FItem :TListBoxItem;
  FFrame :TFrame_Usuario;

begin
  try
    FItem := TListBoxItem.Create(Nil);
    FItem.Text := '';
    FItem.Height := 50;
    FItem.Tag := AId;
    FItem.TagString := ANome;
    FItem.Selectable := True;

    FFrame := TFrame_Usuario.Create(FItem);
    FFrame.Parent := FItem;
    FFrame.Align := TAlignLayout.Client;
    FFrame.lbNome.Text := ANome;
    FFrame.lbNome.Tag := AId;
    FFrame.lbLOGIN.Text := ALogin;
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

procedure TfrmCad_Usuario.Cancelar(Sender :TOBject);
begin
  FTab_Status := dsLista;
  LimparCampos;
  imgAcao_01.Tag := 0;
  imgAcao_01.Bitmap := imgNovo.Bitmap;
  tcPrincipal.GotoVisibleTab(0);
end;

procedure TfrmCad_Usuario.LimparCampos;
begin
  edID.Text := '';
  edID.Tag := 0;
  edPIN.Text := '';
  edNOME.Text := '';
  edLOGIN.Text := '';
  edSENHA.Text := '';
  edEMAIL.Text := '';
  edCELULAR.Text := '';
  edID_EMPRESA.Text := '';
  edID_EMPRESA.Tag := 0;
  edID_PRESTADOR_SERVICO.Text := '';
  edID_PRESTADOR_SERVICO.Tag := 0;
end;

end.
