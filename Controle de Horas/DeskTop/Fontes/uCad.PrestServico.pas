unit uCad.PrestServico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.StdCtrls,
  FMX.dxGrid, FMX.dxControlUtils, FMX.dxControls, FMX.dxCustomization, FMX.Edit, FMX.TabControl, FMX.Effects,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects,

  {$Region '99 Coders'}
    uFancyDialog,
    uFormat,
    uLoading,
  {$EndRegion '99 Coders'}

  IniFiles,
  uPrincipal,
  uDm.Global;

type
  TTab_Status = (dsInsert,dsEdit);
  TExecuteOnClose = procedure(Aid:Integer; ANome:String) of Object;

  TfrmCad_PrestServico = class(TForm)
    FDQRegistros: TFDQuery;
    DSRegistros: TDataSource;
    OpenDialog: TOpenDialog;
    imgEsconteSenha: TImage;
    imgExibeSenha: TImage;
    rctTampa: TRectangle;
    lytFormulario: TLayout;
    rctDetail: TRectangle;
    rctFooter: TRectangle;
    rctIncluir: TRectangle;
    imgIncluir: TImage;
    rctEditar: TRectangle;
    imgEditar: TImage;
    rctSalvar: TRectangle;
    imgSalvar: TImage;
    rctCancelar: TRectangle;
    imgCancelar: TImage;
    rctExcluir: TRectangle;
    imgExcluir: TImage;
    rctHeader: TRectangle;
    lbTitle: TLabel;
    ShadowEffect3: TShadowEffect;
    imgFechar: TImage;
    ShadowEffect4: TShadowEffect;
    tcPrincipal: TTabControl;
    tiLista: TTabItem;
    lytPesquisa: TLayout;
    edPesquisar: TEdit;
    imgPesquisar: TImage;
    Layout2: TLayout;
    dxfmGrid1: TdxfmGrid;
    dxfmGrid1RootLevel1: TdxfmGridRootLevel;
    tiCadastro: TTabItem;
    lytConfig: TLayout;
    lytBDF_Row001: TLayout;
    lbID: TLabel;
    edID: TEdit;
    lytBDF_Row002: TLayout;
    lbNOME: TLabel;
    edNOME: TEdit;
    lytBDF_Row004: TLayout;
    lbEMAIL: TLabel;
    edEMAIL: TEdit;
    lbCELULAR: TLabel;
    edCELULAR: TEdit;
    FDQRegistrosID: TIntegerField;
    FDQRegistrosNOME: TStringField;
    FDQRegistrosCELULAR: TStringField;
    FDQRegistrosEMAIL: TStringField;
    FDQRegistrosDT_CADASTRO: TDateField;
    FDQRegistrosHF_CADASTRO: TTimeField;
    dxfmGrid1RootLevel1ID: TdxfmGridColumn;
    dxfmGrid1RootLevel1NOME: TdxfmGridColumn;
    dxfmGrid1RootLevel1CELULAR: TdxfmGridColumn;
    dxfmGrid1RootLevel1EMAIL: TdxfmGridColumn;
    procedure edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edCELULARTyping(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
  private
    FFancyDialog :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    FDm_Global :TDM_Global;
    FTab_Status :TTab_Status;
    FPesquisa: Boolean;

    procedure Cancelar;
    procedure Editar;
    procedure Excluir(Sender:TObject);
    procedure Incluir;
    procedure Salvar;
    procedure Selecionar_Registros;
    procedure Configura_Botoes;
    procedure SetPesquisa(const Value: Boolean);
  public
    ExecuteOnClose :TExecuteOnClose;

    property Pesquisa:Boolean read FPesquisa write SetPesquisa;
  end;

var
  frmCad_PrestServico: TfrmCad_PrestServico;

implementation

{$R *.fmx}

procedure TfrmCad_PrestServico.Cancelar;
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

procedure TfrmCad_PrestServico.Configura_Botoes;
begin
  rctIncluir.Enabled := (tcPrincipal.ActiveTab = tiLista);
  rctSalvar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctCancelar.Enabled := (tcPrincipal.ActiveTab = tiCadastro);
  rctEditar.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  rctExcluir.Enabled := ((tcPrincipal.ActiveTab = tiLista) and (not FDQRegistros.IsEmpty));
  imgFechar.Enabled := (tcPrincipal.ActiveTab = tiLista);
end;

procedure TfrmCad_PrestServico.edCELULARTyping(Sender: TObject);
begin
  Formatar(edCELULAR,Celular);
end;

procedure TfrmCad_PrestServico.edEMAILKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edCELULAR.SetFocus;
end;

procedure TfrmCad_PrestServico.Editar;
begin
  try
    try
      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Editado');

      edID.Text := FDQRegistros.FieldByName('ID').AsInteger.ToString;
      edNOME.Text := FDQRegistros.FieldByName('NOME').AsString;
      edCELULAR.Text := FDQRegistros.FieldByName('CELULAR').AsString;
      edEMAIL.Text := FDQRegistros.FieldByName('EMAIL').AsString;

      FTab_Status := TTab_Status.dsEdit;

      tcPrincipal.GotoVisibleTab(1);
      if edNOME.CanFocus then
        edNOME.SetFocus;
    except on E: Exception do
      raise Exception.Create('Editar: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_PrestServico.edNOMEKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
    edEMAIL.SetFocus;
end;

procedure TfrmCad_PrestServico.Excluir(Sender: TObject);
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;

      if FDQRegistros.IsEmpty then
        raise Exception.Create('Não há registros para ser Excluído');

      FQuery.Active := False;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('DELETE FROM PRESTADOR_SERVICO WHERE ID = :ID');
      FQuery.ParamByName('ID').AsInteger := FDQRegistros.FieldByName('ID').AsInteger;
      FQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluir: ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmCad_PrestServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FFancyDialog);
  FreeAndNil(FIniFile);
  FreeAndNil(FDm_Global);

  Action := TCloseAction.caFree;
  frmCad_PrestServico := Nil;

end;

procedure TfrmCad_PrestServico.FormCreate(Sender: TObject);
begin
  FFancyDialog := TFancyDialog.Create(frmCad_PrestServico);
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

procedure TfrmCad_PrestServico.FormShow(Sender: TObject);
begin
  if edNOME.CanFocus then
    edNOME.SetFocus;
end;

procedure TfrmCad_PrestServico.imgFecharClick(Sender: TObject);
begin
  if FPesquisa then
  begin
    ExecuteOnClose(
      FDQRegistros.FieldByName('ID').AsInteger
      ,FDQRegistros.FieldByName('NOME').AsString);
  end;

  Close;
end;

procedure TfrmCad_PrestServico.Incluir;
begin
  try
    try
      FTab_Status := TTab_Status.dsInsert;

      tcPrincipal.GotoVisibleTab(1);
      if edNOME.CanFocus then
        edNOME.SetFocus;
    except on E: Exception do
      raise Exception.Create('Incluir: ' + E.Message);
    end;
  finally
  end;
end;

procedure TfrmCad_PrestServico.rctCancelarClick(Sender: TObject);
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

procedure TfrmCad_PrestServico.Salvar;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FDm_Global.FDC_Firebird;
      FQuery.Active := False;
      FQuery.Sql.Clear;

      case FTab_Status of
        dsInsert :begin
          FQuery.Sql.Add('INSERT INTO PRESTADOR_SERVICO( ');
          FQuery.Sql.Add('  NOME ');
          FQuery.Sql.Add('  ,CELULAR ');
          FQuery.Sql.Add('  ,EMAIL ');
          FQuery.Sql.Add('  ,DT_CADASTRO ');
          FQuery.Sql.Add('  ,HF_CADASTRO ');
          FQuery.Sql.Add(') VALUES( ');
          FQuery.Sql.Add('  :NOME ');
          FQuery.Sql.Add('  ,:CELULAR ');
          FQuery.Sql.Add('  ,:EMAIL ');
          FQuery.Sql.Add('  ,:DT_CADASTRO ');
          FQuery.Sql.Add('  ,:HF_CADASTRO ');
          FQuery.Sql.Add('); ');
          FQuery.ParamByName('DT_CADASTRO').AsDate := Date;
          FQuery.ParamByName('HF_CADASTRO').AsTime := Time;
        end;
        dsEdit :begin
          FQuery.Sql.Add('UPDATE PRESTADOR_SERVICO SET ');
          FQuery.Sql.Add('  NOME = :NOME ');
          FQuery.Sql.Add('  ,CELULAR = :CELULAR ');
          FQuery.Sql.Add('  ,EMAIL = :EMAIL ');
          FQuery.Sql.Add('WHERE ID = :ID; ');
          FQuery.ParamByName('ID').AsInteger := StrToIntDef(edID.Text,0);
        end;
      end;
      FQuery.ParamByName('NOME').AsString := edNOME.Text;
      FQuery.ParamByName('CELULAR').AsString := edCELULAR.Text;
      FQuery.ParamByName('EMAIL').AsString := edEMAIL.Text;
      FQuery.ExecSQL;
    except on E: Exception do
      raise Exception.Create('Salvar: ' + E.Message);
    end;
  finally
    FreeAndNil(FQuery);
    tcPrincipal.GotoVisibleTab(0);
    Selecionar_Registros;
  end;
end;

procedure TfrmCad_PrestServico.Selecionar_Registros;
begin
  try
    try
      FDQRegistros.Active := False;
      FDQRegistros.SQL.Clear;
      FDQRegistros.SQL.Add('SELECT ');
      FDQRegistros.SQL.Add('  PS.* ');
      FDQRegistros.SQL.Add('FROM PRESTADOR_SERVICO PS ');
      FDQRegistros.SQL.Add('ORDER BY ');
      FDQRegistros.SQL.Add('  PS.ID; ');
      FDQRegistros.Active := True;
    except on E: Exception do
      FFancyDialog.Show(TIconDialog.Error,'Erro','Selecionar. ' + E.Message,'Ok');
    end;
  finally
  end;

end;

procedure TfrmCad_PrestServico.SetPesquisa(const Value: Boolean);
begin
  FPesquisa := Value;
end;

end.
