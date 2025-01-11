unit uCad.Usuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit, FMX.TabControl,
  FMX.Effects, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.dxControlUtils, FMX.dxGrid,
  FMX.dxControls, FMX.dxCustomization,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global,

  System.Actions, FMX.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Fmx.Bind.Navigator, Data.Bind.Components,
  Data.Bind.DBScope, FMX.ListBox;

type
  TTab_Status = (dsInsert,dsEdit);

  TfrmCad_Usuario = class(TForm)
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiCadastro: TTabItem;
    lytConfig: TLayout;
    lytBDF_Row001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    edPIN: TEdit;
    OpenDialog: TOpenDialog;
    lbPIN: TLabel;
    lytBDF_Row002: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytBDF_Row003: TLayout;
    lbLOGIN: TLabel;
    edLOGIN: TEdit;
    lbSENHA: TLabel;
    edSENHA: TEdit;
    lytExibeSenha: TLayout;
    imgSenha: TImage;
    sbSenha: TSpeedButton;
    lytBDF_Row004: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    edPesquisar: TEdit;
    imgPesquisar: TImage;
    rctIncluir: TRectangle;
    rctEditar: TRectangle;
    rctSalvar: TRectangle;
    rctCancelar: TRectangle;
    rctExcluir: TRectangle;
    FDQRegistros: TFDQuery;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosNOME: TStringField;
    FDQRegistrosLOGIN: TStringField;
    FDQRegistrosSENHA: TStringField;
    FDQRegistrosPIN: TStringField;
    FDQRegistrosCELULAR: TStringField;
    FDQRegistrosEMAIL: TStringField;
    FDQRegistrosFOTO: TMemoField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHR_CADASTRO: TTimeField;
    FDQRegistrosSINCRONIZADO: TIntegerField;
    DSRegistros: TDataSource;
    imgIncluir: TImage;
    imgEditar: TImage;
    imgSalvar: TImage;
    imgCancelar: TImage;
    imgExcluir: TImage;
    Layout2: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    dxfmGrid1RootLevel1Column1: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column2: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column3: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column4: TdxfmGridColumn;
    dxfmGrid1RootLevel1Column5: TdxfmGridColumn;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    imgEsconteSenha: TImage;
    imgExibeSenha: TImage;
    lytBDF_Row005: TLayout;
    lbID_EMPRESA: TLabel;
    edID_EMPRESA_Desc: TEdit;
    edID_EMPRESA: TEdit;
    imgID_EMPRESA: TImage;
    lytBDF_Row006: TLayout;
    lbID_PRESTADOR_SERVICO: TLabel;
    edID_PRESTADOR_SERVICO_Desc: TEdit;
    edID_PRESTADOR_SERVICO: TEdit;
    imgID_PRESTADOR_SERVICO: TImage;
    FDQRegistrosID_EMPRESA: TIntegerField;
    FDQRegistrosID_PRESTADOR_SERVICO: TIntegerField;
    FDQRegistrosEMPRESA: TStringField;
    FDQRegistrosPRESTADOR_SERVICO: TStringField;
    lbTIPO: TLabel;
    edTIPO: TComboBox;
    lytBDF_Row007: TLayout;
    lbID_CLIENTE: TLabel;
    edID_CLIENTE_Desc: TEdit;
    edID_CLIENTE: TEdit;
    imgID_CLIENTE: TImage;
    lytBDF_Row008: TLayout;
    lbFORM_INICIAL: TLabel;
    edFORM_INICIAL: TEdit;
    FDQRegistrosTIPO: TIntegerField;
    FDQRegistrosID_CLIENTE: TIntegerField;
    FDQRegistrosFORM_INICIAL: TStringField;
    FDQRegistrosCLIENTE: TStringField;
    procedure imgFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctCancelarClick(Sender: TObject);
    procedure sbSenhaClick(Sender: TObject);
    procedure edPINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edLOGINKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edSENHAKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARTyping(Sender: TObject);
    procedure imgID_EMPRESAClick(Sender: TObject);
    procedure imgID_PRESTADOR_SERVICOClick(Sender: TObject);
    procedure edID_EMPRESAExit(Sender: TObject);
    procedure edID_PRESTADOR_SERVICOExit(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;

    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Selecionar_Registros;
    procedure Configura_Botoes;
    procedure Sel_Empresa(Aid: Integer; ANome: String);
    procedure Sel_PrestServicos(Aid: Integer; ANome: String);
  public
    { Public declarations }
  end;

var
  frmCad_Usuario: TfrmCad_Usuario;

implementation

{$R *.fmx}

uses
  uCad.Empresa
  ,uCad.PrestServico;

procedure TfrmCad_Usuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmCad_Usuario := Nil;
end;

procedure TfrmCad_Usuario.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCad_Usuario);
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS.ini';
  FIniFile := TIniFile.Create(FEnder);

  tcPrincipal.ActiveTab := tiLista;

  lytFormulario.Align := TAlignLayout.Center;

  FDm_Global := TDM_Global.Create(Nil);
  FDQRegistros.Connection := FDm_Global.FDC_Firebird;

  Selecionar_Registros;
  Configura_Botoes;
end;

procedure TfrmCad_Usuario.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  U.* ');
      FDQRegistros.SQL.Add('  ,E.NOME AS EMPRESA ');
      FDQRegistros.SQL.Add('  ,PS.NOME AS PRESTADOR_SERVICO ');
      FDQRegistros.SQL.Add('  ,C.NOME AS CLIENTE ');
      FDQRegistros.SQL.Add('FROM USUARIO U ');
      FDQRegistros.SQL.Add('  LEFT JOIN EMPRESA E ON E.ID = U.ID_EMPRESA ');
      FDQRegistros.SQL.Add('  LEFT JOIN PRESTADOR_SERVICO PS ON PS.ID = U.ID_PRESTADOR_SERVICO ');
      FDQRegistros.SQL.Add('  LEFT JOIN CLIENTE C ON C.ID = U.ID_CLIENTE ');
      FDQRegistros.SQL.Add('WHERE NOT U.ID IS NULL ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  U.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;
end;

procedure TfrmCad_Usuario.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

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

procedure TfrmCad_Usuario.edID_EMPRESAExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_Empresa(edID_EMPRESA.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_EMPRESA_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmCad_Usuario.edID_PRESTADOR_SERVICOExit(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.Listar_PrestadorServico(edID_PRESTADOR_SERVICO.Text.ToInteger,'',FQuery);

      if not FQuery.IsEmpty then
        edID_PRESTADOR_SERVICO_Desc.Text := FQuery.FieldByName('NOME').AsString;

    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message,'OK');
    end;
  finally
    FreeAndNil(FQuery);
  end;
end;

procedure TfrmCad_Usuario.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCad_Usuario.imgID_EMPRESAClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_Empresa) then
    Application.CreateForm(TfrmCad_Empresa, frmCad_Empresa);

  frmCad_Empresa.Pesquisa := True;
  frmCad_Empresa.ExecuteOnClose := Sel_Empresa;
  frmCad_Empresa.Height := frmPrincipal.Height;
  frmCad_Empresa.Width := frmPrincipal.Width;

  frmCad_Empresa.Show;
end;

procedure TfrmCad_Usuario.imgID_PRESTADOR_SERVICOClick(Sender: TObject);
begin
  if NOT Assigned(frmCad_PrestServico) then
    Application.CreateForm(TfrmCad_PrestServico, frmCad_PrestServico);

  frmCad_PrestServico.Pesquisa := True;
  frmCad_PrestServico.ExecuteOnClose := Sel_PrestServicos;
  frmCad_PrestServico.Height := frmPrincipal.Height;
  frmCad_PrestServico.Width := frmPrincipal.Width;

  frmCad_PrestServico.Show;
end;

procedure TfrmCad_Usuario.Sel_PrestServicos(Aid: Integer; ANome: String);
begin
  edID_PRESTADOR_SERVICO.Text := Aid.ToString;
  edID_PRESTADOR_SERVICO_Desc.Text := ANome;
end;

procedure TfrmCad_Usuario.Sel_Empresa(Aid: Integer; ANome: String);
begin
  edID_EMPRESA.Text := AId.ToString;
  edID_EMPRESA_Desc.Text := ANome;

  if edID_PRESTADOR_SERVICO.CanFocus then
    edID_PRESTADOR_SERVICO.SetFocus;
end;

procedure TfrmCad_Usuario.rctCancelarClick(Sender: TObject);
begin
  try
    try
      case TRectangle(Sender).Tag of
        0:Incluir;
        1:Editar;
        2:Salvar;
        3:Cancelar;
        4:FFancyDialog.Show(TIconDialog.Question,'Excluir','Deseja Excluir o registro selecionado?','Sim',Excluir,'Não') ;
      end;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro',E.Message);
    end;
  finally
    Configura_Botoes;
  end;
end;

procedure TfrmCad_Usuario.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;

      tcPrincipal.GotoVisibleTab(1);
      if edPIN.CanFocus then
        edPIN.SetFocus;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Usuario.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edNOME.Text := FDQRegistros.FieldByName('NOME').AsString;
      edLOGIN.Text := FDQRegistros.FieldByName('LOGIN').AsString;
      edSENHA.Text := FDQRegistros.FieldByName('SENHA').AsString;
      edPIN.Text := FDQRegistros.FieldByName('PIN').AsString;
      edCELULAR.Text := FDQRegistros.FieldByName('CELULAR').AsString;
      edEMAIL.Text := FDQRegistros.FieldByName('EMAIL').AsString;
      edID_EMPRESA.Text := FDQRegistros.FieldByName('ID_EMPRESA').AsString;
      edID_EMPRESA_Desc.Text := FDQRegistros.FieldByName('EMPRESA').AsString;
      edID_PRESTADOR_SERVICO.Text := FDQRegistros.FieldByName('ID_PRESTADOR_SERVICO').AsString;
      edID_PRESTADOR_SERVICO_Desc.Text := FDQRegistros.FieldByName('PRESTADOR_SERVICO').AsString;
      edTIPO.ItemIndex := FDQRegistrosTIPO.AsInteger;
      edID_CLIENTE.Text := FDQRegistros.FieldByName('ID_CLIENTE').AsString;
      edID_CLIENTE_Desc.Text := FDQRegistros.FieldByName('CLIENTE').AsString;
      edFORM_INICIAL.Text := FDQRegistros.FieldByName('FORM_INICIAL').AsString;

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edPIN.CanFocus then
        edPIN.SetFocus;
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
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

procedure TfrmCad_Usuario.Salvar;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      FQuery.Active := False;
      FQuery.Sql.Clear;

      case FTab_Status of
        dsInsert :begin
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
          FQuery.Sql.Add('  ,TIPO ');
          FQuery.Sql.Add('  ,ID_CLIENTE ');
          FQuery.Sql.Add('  ,FORM_INICIAL ');
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
          FQuery.Sql.Add('  ,:TIPO ');
          FQuery.Sql.Add('  ,:ID_CLIENTE ');
          FQuery.Sql.Add('  ,:FORM_INICIAL ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HR_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
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
          FQuery.Sql.Add('  ,SINCRONIZADO = :SINCRONIZADO ');
          FQuery.Sql.Add('  ,TIPO = :TIPO');
          FQuery.Sql.Add('  ,ID_CLIENTE = :ID_CLIENTE');
          FQuery.Sql.Add('  ,FORM_INICIAL = :FORM_INICIAL');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('NOME').AsString := edNOME.Text;
      FQuery.ParamByName('LOGIN').AsString := edLOGIN.Text;
      FQuery.ParamByName('SENHA').AsString := edSENHA.Text;
      FQuery.ParamByName('PIN').AsString := edPIN.Text;
      FQuery.ParamByName('CELULAR').AsString := edCELULAR.Text;
      FQuery.ParamByName('EMAIL').AsString := edEMAIL.Text;
      FQuery.ParamByName('ID_EMPRESA').AsInteger := StrToIntDef(edID_EMPRESA.Text,0);
      FQuery.ParamByName('ID_PRESTADOR_SERVICO').AsInteger := StrToIntDef(edID_PRESTADOR_SERVICO.Text,0);
      FQuery.ParamByName('FOTO').AsString := '';;
      FQuery.ParamByName('SINCRONIZADO').AsInteger := 0;
      FQuery.ParamByName('TIPO').AsInteger := edTIPO.ItemIndex;
      FQuery.ParamByName('ID_CLIENTE').AsInteger :=  StrToIntDef(edID_CLIENTE.Text,0);
      FQuery.ParamByName('FORM_INICIAL').AsString := edFORM_INICIAL.Text;
      FQuery.ExecSQL;

      FDm_Global.FDC_Firebird.Commit;
    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Salvar: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmCad_Usuario.sbSenhaClick(Sender: TObject);
begin
  case sbSenha.Tag of
    0:begin
      edSENHA.Password := False;
      imgSenha.Bitmap := imgEsconteSenha.Bitmap;
      sbSenha.Tag := 1;
    end;
    1:begin
      edSENHA.Password := True;
      imgSenha.Bitmap := imgExibeSenha.Bitmap;
      sbSenha.Tag := 0;
    end;
  end;
end;

procedure TfrmCad_Usuario.Cancelar;
begin
  try
    try
      tcPrincipal.GotoVisibleTab(0);
    except on E: Exception do
      raise Exception.Create('Cancelar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_Usuario.Excluir(Sender:TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FDm_Global.FDC_Firebird.StartTransaction;

      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Excluído');

      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM USUARIO WHERE ID = :ID');
      FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

      FDm_Global.FDC_Firebird.Commit;

    except on E: Exception do
      begin
        FDm_Global.FDC_Firebird.Rollback;
        raise Exception.Create('Excluir: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;


end.
