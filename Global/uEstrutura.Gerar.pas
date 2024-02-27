unit uEstrutura.Gerar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uLoading,
  uFancyDialog,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.TabControl, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.ListBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  uFuncoes,
  uDm_Global;

type
  TfrmCriarEstrutura = class(TForm)
    lytPrincipal: TLayout;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytVoltar: TLayout;
    rctVoltar: TRectangle;
    imgVoltar: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    lytCancelar: TLayout;
    rctCancelar: TRectangle;
    imgCancelar: TImage;
    lytConfirmar: TLayout;
    rctConfirmar: TRectangle;
    imgConfirmar: TImage;
    lytDetail: TLayout;
    tcPrincipal: TTabControl;
    tiEstrutura: TTabItem;
    rctEstrutura: TRectangle;
    lytBD_Row_001: TLayout;
    lytNomeEstrutura: TLayout;
    lbPastaSalvar: TLabel;
    edNomeEstrutura: TEdit;
    imgBanco_Pesq: TImage;
    lytUnit: TLayout;
    Memo: TMemo;
    lytTabela: TLayout;
    lbTabela: TLabel;
    cbTabela: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rctConfirmarClick(Sender: TObject);
  private
    FEnder :String;
    FMensagem :TFancyDialog;
    FDm :TDM;

    procedure Cria_ModeloDados(const ANomeEstrutura, Tabela: String);
    procedure Cria_Rotas(const ANomeEstrutura, ATabela: String);
    procedure ThreadEnd_Criar_ModeloDados(Sender: TOBject);
    procedure ThreadEnd_Criar_Rotas(Sender: TOBject);
    procedure CriarEstrutura(Sender: TOBject);

  public
    { Public declarations }
  end;

var
  frmCriarEstrutura: TfrmCriarEstrutura;

implementation

{$R *.fmx}

procedure TfrmCriarEstrutura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FDm);
  {$ELSE}
    FMensagem.DisposeOf;
    FDm.DisposeOf;
  {$ENDIF}
  Action := TCloseAction.CaFree;
  frmCriarEstrutura := Nil;
end;

procedure TfrmCriarEstrutura.FormCreate(Sender: TObject);
begin
  FDm := TDM.Create(Nil);

  FMensagem := TFancyDialog.Create(frmCriarEstrutura);
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
  {$ELSE}
    FEnder_ModelDados := TPath.GetDocumentsPath;
  {$ENDIF}

  edNomeEstrutura.Text := FEnder;

end;

procedure TfrmCriarEstrutura.FormShow(Sender: TObject);
var
  lQuery :TFDQuery;
begin
  try
    try
      cbTabela.Items.Clear;

      lQuery := TFDQuery.Create(Nil);
      if not FDm.FDC_Servidor.InTransaction then
        lQuery.Connection := FDm.FDC_Servidor;

      FDm.Listar_Tabelas(lQuery,'');

      if not lQuery.IsEmpty then
      begin
        lQuery.First;
        while not lQuery.Eof do
        begin
          cbTabela.Items.Add(lQuery.FieldByName('RDB$RELATION_NAME').AsString);
          lQuery.Next;
        end;
      end;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally

  end;
end;

procedure TfrmCriarEstrutura.rctCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCriarEstrutura.rctConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja criar a estrutura da tabela','SIM',CriarEstrutura,'NÃO');
end;

procedure TfrmCriarEstrutura.CriarEstrutura(Sender :TOBject);
begin
  Cria_ModeloDados(edNomeEstrutura.Text,cbTabela.Items.Text);
end;

procedure TfrmCriarEstrutura.Cria_ModeloDados(const ANomeEstrutura,Tabela:String);
var
  t :TThread;
begin

  TLoading.Show(frmCriarEstrutura,'Criando modelo...');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lString :TStringList;
    lTrigger :TStringList;
    lPastaNome :String;
    lQuery_Objeto :TFDQuery;
    I :Integer;
    lFiltro_Chave :TStringList;
    lInc_Virgula :Integer;
    sFiltro :String;
    sFiltroSql :TStringList;
  begin
    lString := TStringList.Create;
    lTrigger := TStringList.Create;
    lFiltro_Chave := TStringList.Create;
    sFiltroSql := TStringList.Create;

    lQuery_Objeto := TFDQuery.Create(Nil);
    lQuery_Objeto.Connection := FDm.FDC_Servidor;

    lPastaNome := '';

    {$IFDEF MSWINDOWS}
      lPastaNome := ANomeEstrutura + '\Modelo de Dados\uModel.' + cbTabela.Items.Strings[cbTabela.ItemIndex] + '.pas';
    {$ELSE}
      lPastaNome := TPath.Combine(ANomeEstrutura + '\Modelo de Dados\uModel.', cbTabela.Items.Strings[cbTabela.ItemIndex] + '.pas');
    {$ENDIF}

    lString.Add('unit uModel.'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'; ');
    lString.Add(' ');
    lString.Add('interface ');
    lString.Add(' ');
    lString.Add('uses ');
    lString.Add('  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, ');
    lString.Add('  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, ');
    lString.Add('  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, ');
    lString.Add('  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, ');
    lString.Add('  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase, ');
    lString.Add('  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, ');
    lString.Add(' ');
    lString.Add('  DataSet.Serialize, DataSet.Serialize.Config, ');
    lString.Add(' ');
    lString.Add('  System.SysUtils, System.Classes,System.JSON; ');

    lString.Add(' ');

    {$Region 'Funções globais'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('Funções Globais.');
      end);
      lString.Add('  function Campo_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela, ACampos: String): Boolean; ');
      lString.Add('  function Tabela_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATabela: String): Boolean; ');
      lString.Add('  function Procedure_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AProcedure: String): Boolean; ');
      lString.Add('  function Trigger_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const ATrigger: String): Boolean; ');
      lString.Add('  function Generator_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AGenerator: String): Boolean; ');
      lString.Add('  function Indice_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AIndice: String): Boolean; ');
    {$EndRegion 'Funções globais'}
    lString.Add(' ');
    lString.Add('const');
    lString.Add('  C_Paginas = 30;');
    lString.Add(' ');

    lString.Add('type ');
    lString.Add('  T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' = class ');
    {$Region 'Seção privada'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Seção privada.');
      end);
      lString.Add('  private ');
      lString.Add('    FConexao: TFDConnection; ');
      lString.Add('    FPagina :Integer; ');
      lString.Add('    FPaginas :Integer; ');
      lString.Add('    ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex]);
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('    F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' :' +lQuery_Objeto.FieldByName('TIPO_CAMPO').AsString+';');
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('    procedure Set'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+'( const Value:' +lQuery_Objeto.FieldByName('TIPO_CAMPO').AsString+');');
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
    {$EndRegion 'Seção privada'}

    {$Region 'Seção publica'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Seção publica.');
      end);
      lString.Add('  public ');
      lString.Add('    constructor Create(AConnexao: TFDConnection); ');
      lString.Add('    destructor Destroy; override; ');
      lString.Add(' ');
      lString.Add('    procedure Criar_Estrutura(const AFDScript:TFDScript;AFDQuery:TFDQuery); ');
      lString.Add('    procedure Atualizar_Estrutura(const AFDQ_Query:TFDQuery); ');
      lString.Add('    procedure Inicia_Propriedades; ');
      lString.Add('    procedure Inserir(const AFDQ_Query:TFDQuery); ');

      FDm.Listar_PrimaryKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
        sFiltro := sFiltro + lQuery_Objeto.FieldByName('CAMPOS_FILTRO').AsString;
      sFiltro := sFiltro + '; APagina:Integer=0';

      if sFiltro <> '' then
      begin
        lString.Add('    function Listar(const AFDQ_Query:TFDQuery; '+sFiltro+'): TJSONArray; ');
        lString.Add('    procedure Atualizar(const AFDQ_Query:TFDQuery; '+sFiltro+'); ');
        lString.Add('    procedure Excluir(const AFDQ_Query:TFDQuery; '+sFiltro+'); ');
      end
      else
      begin
        lString.Add('    function Listar(const AFDQ_Query:TFDQuery): TJSONArray; ');
        lString.Add('    procedure Atualizar(const AFDQ_Query:TFDQuery); ');
        lString.Add('    procedure Excluir(const AFDQ_Query: TFDQuery); ');
      end;

      //lString.Add('    function Sequencial(const AFDQ_Query:TFDQuery):Integer; ');
      lString.Add(' ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('    property '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+
                      ':' +lQuery_Objeto.FieldByName('TIPO_CAMPO').AsString+
                      ' read F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+
                      ' write Set'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+';');
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      lString.Add('  end; ');
      lString.Add(' ');
    {$EndRegion 'Seção publica'}

    lString.Add('implementation ');
    lString.Add(' ');

    {$Region 'Function Campo_Existe'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Function Campo_Existe.');
      end);
      lString.Add('function Campo_Existe(const AConexao:TFDConnection; const AFDQ_Query:TFDQuery; const ATabela, ACampos: String): Boolean; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    AFDQ_Query.Connection := AConexao; ');
      lString.Add('    AFDQ_Query.Active := False; ');
      lString.Add('    AFDQ_Query.Sql.Clear; ');
      lString.Add('    AFDQ_Query.Sql.Add(''SELECT ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  RF.* ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''FROM RDB$RELATION_FIELDS RF ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''WHERE TRIM(RF.RDB$FIELD_NAME) = '' + QuotedStr(Trim(ACampos))); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  AND TRIM(RF.RDB$RELATION_NAME) = '' + QuotedStr(Trim(ATabela))); ');
      lString.Add('    AFDQ_Query.Active := True; ');
      lString.Add('    Result := (not AFDQ_Query.IsEmpty); ');
      lString.Add('  except ');
      lString.Add('    On Ex:Exception do ');
      lString.Add('    begin ');
      lString.Add('      Result := False; ');
      lString.Add('      raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Function Campo_Existe'}

    lString.Add(' ');

    {$Region 'Function Tabela_Existe'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Function Tabela_Existe.');
      end);
      lString.Add('function Tabela_Existe(const AConexao:TFDConnection; const AFDQ_Query:TFDQuery; const ATabela: String): Boolean; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    AFDQ_Query.Connection := AConexao; ');
      lString.Add('    AFDQ_Query.Active := False; ');
      lString.Add('    AFDQ_Query.Sql.Clear; ');
      lString.Add('    AFDQ_Query.Sql.Add(''SELECT ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  RR.* ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''FROM RDB$RELATIONS RR ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''WHERE TRIM(RR.RDB$RELATION_NAME) = '' + QuotedStr(Trim(ATabela))); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  AND RR.RDB$SYSTEM_FLAG = 0; ''); ');
      lString.Add('    AFDQ_Query.Active := True; ');
      lString.Add('    Result := (not AFDQ_Query.IsEmpty); ');
      lString.Add('  except ');
      lString.Add('    On Ex:Exception do ');
      lString.Add('    begin ');
      lString.Add('      Result := False; ');
      lString.Add('      raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Function Tabela_Existe'}

    lString.Add(' ');

    {$Region 'Function Procedure_Existe'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Function Procedure_Existe.');
      end);
      lString.Add('function Procedure_Existe(const AConexao:TFDConnection; const AFDQ_Query: TFDQuery; const AProcedure: String): Boolean; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    AFDQ_Query.Connection := AConexao; ');
      lString.Add('    AFDQ_Query.Active := False; ');
      lString.Add('    AFDQ_Query.Sql.Clear; ');
      lString.Add('    AFDQ_Query.Sql.Add(''SELECT ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  RP.* ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''FROM RDB$PROCEDURES RP ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''WHERE TRIM(RP.RDB$PROCEDURE_NAME) = '' + QuotedStr(Trim(AProcedure))); ');
      lString.Add('    AFDQ_Query.Active := True; ');
      lString.Add('    Result := (not AFDQ_Query.IsEmpty); ');
      lString.Add('  except ');
      lString.Add('    On Ex:Exception do ');
      lString.Add('    begin ');
      lString.Add('      Result := False; ');
      lString.Add('      raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Function Procedure_Existe'}

    lString.Add(' ');

    {$Region 'Function Trigger_Existe'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Function Trigger_Existe.');
      end);
      lString.Add('function Trigger_Existe(const AConexao:TFDConnection; const AFDQ_Query: TFDQuery; const ATrigger: String): Boolean; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    AFDQ_Query.Connection := AConexao; ');
      lString.Add('    AFDQ_Query.Active := False; ');
      lString.Add('    AFDQ_Query.Sql.Clear; ');
      lString.Add('    AFDQ_Query.Sql.Add(''SELECT ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  RT.* ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''FROM RDB$TRIGGERS RT ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''WHERE TRIM(RT.RDB$TRIGGER_NAME) = '' + QuotedStr(Trim(ATrigger))); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  AND RT.RDB$SYSTEM_FLAG = 0; ''); ');
      lString.Add('    AFDQ_Query.Active := True; ');
      lString.Add('    Result := (not AFDQ_Query.IsEmpty); ');
      lString.Add('  except ');
      lString.Add('    On Ex:Exception do ');
      lString.Add('    begin ');
      lString.Add('      Result := False; ');
      lString.Add('      raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Function Trigger_Existe'}

    lString.Add(' ');

    {$Region 'Function Generator_Existe'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Function Generator_Existe.');
      end);
      lString.Add('function Generator_Existe(const AConexao:TFDConnection; const AFDQ_Query: TFDQuery;  const AGenerator: String): Boolean; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    AFDQ_Query.Connection := AConexao; ');
      lString.Add('    AFDQ_Query.Active := False; ');
      lString.Add('    AFDQ_Query.Sql.Clear; ');
      lString.Add('    AFDQ_Query.Sql.Add(''SELECT ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  RD.* ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''FROM RDB$DEPENDENCIES RD ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''WHERE TRIM(RD.RDB$DEPENDED_ON_NAME) = '' + QuotedStr(Trim(AGenerator))); ');
      lString.Add('    AFDQ_Query.Active := True; ');
      lString.Add('    Result := (not AFDQ_Query.IsEmpty); ');
      lString.Add('  except ');
      lString.Add('    On Ex:Exception do ');
      lString.Add('    begin ');
      lString.Add('      Result := False; ');
      lString.Add('      raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Function Generator_Existe'}

    lString.Add(' ');

    {$Region 'Function Indice_Existe'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Function Indice_Existe.');
      end);
      lString.Add('function Indice_Existe(const AConexao:TFDConnection;const AFDQ_Query:TFDQuery; const AIndice: String): Boolean; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    AFDQ_Query.Connection := AConexao; ');
      lString.Add('    AFDQ_Query.Active := False; ');
      lString.Add('    AFDQ_Query.Sql.Clear; ');
      lString.Add('    AFDQ_Query.Sql.Add(''SELECT ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''  RI.* ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''FROM RDB$INDICES RI ''); ');
      lString.Add('    AFDQ_Query.Sql.Add(''WHERE TRIM(RI.RDB$INDEX_NAME) = '' + QuotedStr(Trim(AIndice))); ');
      lString.Add('    AFDQ_Query.Active := True; ');
      lString.Add('    Result := (not AFDQ_Query.IsEmpty); ');
      lString.Add('  except ');
      lString.Add('    On Ex:Exception do ');
      lString.Add('    begin ');
      lString.Add('      Result := False; ');
      lString.Add('      raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Function Indice_Existe'}

    lString.Add(' ');

    {$Region 'Constructor/Destructor'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Constructor/Destructor.');
      end);
      lString.Add('{ T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' }');
      lString.Add(' ');
      lString.Add('constructor T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Create(AConnexao: TFDConnection); ');
      lString.Add('begin ');
      lString.Add('  FPaginas := C_Paginas; ');
      lString.Add('  FConexao := AConnexao; ');
      lString.Add('end; ');
      lString.Add(' ');
      lString.Add('destructor T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Destroy; ');
      lString.Add('begin ');
      lString.Add(' ');
      lString.Add('  inherited; ');
      lString.Add('end; ');
    {$EndRegion 'Constructor/Destructor'}

    lString.Add(' ');

    {$Region 'Procedure Criar_Estrutura'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Procedure Criar_Estrutura.');
      end);
      lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Criar_Estrutura(const AFDScript: TFDScript; AFDQuery: TFDQuery); ');
      lString.Add('var ');
      lString.Add('  lScript: TStringList; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      AFDScript.Connection := FConexao; ');
      lString.Add('      AFDQuery.Connection := FConexao; ');
      lString.Add(' ');
      lString.Add('      lScript := TStringList.Create; ');
      lString.Add(' ');
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Relizando um DROP nos objetos da tabela.');
      end);
      lString.Add('       //Relizando um DROP nos objetos da tabela... ');
      lString.Add('       begin ');
      lString.Add('         with AFDScript do ');
      lString.Add('         begin ');
      lString.Add('           SQLScripts.Clear; ');
      lString.Add('           SQLScripts.Add; ');
      lString.Add('           with SQLScripts[0].SQL do ');
      lString.Add('           begin ');
      lString.Add('            //Excluindo objetos da tabela '+cbTabela.Items.Strings[cbTabela.ItemIndex]+'... ');
      FDm.Listar_Indices(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('            if Indice_Existe(FConexao,AFDQuery,'+ QuotedStr(lQuery_Objeto.FieldByName('RDB$INDEX_NAME').AsString)+') then ');
          lString.Add('              Add(''DROP INDEX '+lQuery_Objeto.FieldByName('RDB$INDEX_NAME').AsString+';''); ');
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      FDm.Listar_Triggers(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('            if Trigger_Existe(FConexao,AFDQuery,'+ QuotedStr(lQuery_Objeto.FieldByName('RDB$TRIGGER_NAME').AsString)+') then ');
          lString.Add('              Add(''DROP TRIGGER '+lQuery_Objeto.FieldByName('RDB$TRIGGER_NAME').AsString+';''); ');
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      FDm.Listar_Generator(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('            if Generator_Existe(FConexao,AFDQuery,'+ QuotedStr(lQuery_Objeto.FieldByName('RDB$GENERATOR_NAME').AsString)+') then ');
          lString.Add('              Add(''DROP GENERATOR '+lQuery_Objeto.FieldByName('RDB$GENERATOR_NAME').AsString+';''); ');
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      lString.Add('            if Tabela_Existe(FConexao,AFDQuery,'+QuotedStr(cbTabela.Items.Strings[cbTabela.ItemIndex])+') then ');
      lString.Add('              Add(''DROP TABLE '+cbTabela.Items.Strings[cbTabela.ItemIndex]+';''); ');
      lString.Add(' ');
      lString.Add('            if Count > 0 then ');
      lString.Add('            begin ');
      lString.Add('              ValidateAll; ');
      lString.Add('              ExecuteAll; ');
      lString.Add('            end; ');
      lString.Add('          end; ');
      lString.Add('        end; ');
      lString.Add('      end; ');
      lString.Add(' ');
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Criando tabelas...');
      end);
      lString.Add('     //Criando tabelas...');
      lString.Add('      lScript.Clear; ');
      lString.Add('      lScript.Add(''CREATE TABLE ' +cbTabela.Items.Strings[cbTabela.ItemIndex]+ ' ( ''); ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.RecNo = 1 then
            lString.Add('      lScript.Add(' + QuotedStr('  ' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ' ' + lQuery_Objeto.FieldByName('TIPO_BANCO').AsString) + ');')
          else
            lString.Add('      lScript.Add(' + QuotedStr('  ,' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ' ' + lQuery_Objeto.FieldByName('TIPO_BANCO').AsString) + ');');
          lQuery_Objeto.Next;
        end;
        lString.Add('      lScript.Add('');''); ');
        lString.Add('      AFDScript.ExecuteScript(lScript);');
      end;
      lString.Add(' ');
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Criando Chave primaria, estrangeira, generators e comentários...');
      end);
      lString.Add('      //Criando Chave primaria, estrangeira, generators e comentários... ');
      lString.Add('      with AFDScript do ');
      lString.Add('      begin ');
      lString.Add('        SQLScripts.Clear; ');
      lString.Add('        SQLScripts.Add; ');
      lString.Add('        with SQLScripts[0].SQL do ');
      lString.Add('        begin ');
      //Primary Key
      FDm.Listar_PrimaryKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
        lString.Add('          Add(''ALTER TABLE ' +cbTabela.Items.Strings[cbTabela.ItemIndex]+ ' ADD CONSTRAINT '+lQuery_Objeto.FieldByName('NOME').AsString+' PRIMARY KEY ('+lQuery_Objeto.FieldByName('CAMPOS').AsString+');'');');

      //Foreing key
      FDm.Listar_ForeingKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('          Add('+QuotedStr(lQuery_Objeto.FieldByName('FK_DESCRICAO').AsString)+');');
          lQuery_Objeto.Next;
        end;
      end;

      //Indices
      FDm.Listar_Indices(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('          Add('+QuotedStr(lQuery_Objeto.FieldByName('INDICE_DESC').AsString)+');');
          lQuery_Objeto.Next;
        end;
      end;

      //Comentários
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('          Add('+QuotedStr(lQuery_Objeto.FieldByName('DESCRICAO').AsString)+');');
          lQuery_Objeto.Next;
        end;
      end;

      //Generator
      FDm.Listar_Generator(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
        lString.Add('          Add('+QuotedStr('CREATE SEQUENCE ' + lQuery_Objeto.FieldByName('RDB$GENERATOR_NAME').AsString)+');');
      lString.Add('          ValidateAll; ');
      lString.Add('          ExecuteAll; ');
      lString.Add('        end; ');
      lString.Add('      end; ');

      //Triggers...
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Criando Triggers...');
      end);
      FDm.Listar_Triggers(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add(' ');
          lString.Add('      lScript.Clear; ');
          lString.Add('      lScript.Add(''SET TERM ^ ; ''); ');
          lString.Add('      lScript.Add(''CREATE OR ALTER TRIGGER '+lQuery_Objeto.FieldByName('RDB$TRIGGER_NAME').AsString+' FOR '+lQuery_Objeto.FieldByName('RDB$RELATION_NAME').AsString+ ' ''); ');
          lString.Add('      lScript.Add('+QuotedStr(lQuery_Objeto.FieldByName('DESC_TITULO').AsString)+');');
          lTrigger.Clear;
          lTrigger.Text := lQuery_Objeto.FieldByName('RDB$TRIGGER_SOURCE').AsString;
          for I := 0 to lTrigger.Count-1 do
          begin
            if I = lTrigger.Count-1 then
              lString.Add('      lScript.Add('+QuotedStr(lTrigger.Strings[I] + ' ^')+');')
            else
              lString.Add('      lScript.Add('+QuotedStr(lTrigger.Strings[I])+');');
          end;
          lQuery_Objeto.Next;
        end;
        lString.Add('      lScript.Add('' ''); ');
        lString.Add('      AFDScript.ExecuteScript(lScript); ');
      end;

        {
            //Criando Procedure...
            lScript.Clear;
            lScript.Add('SET TERM ^; ');
            lScript.Add('CREATE OR ALTER PROCEDURE SP_GEN_CLIENTE_ID ');
            lScript.Add('RETURNS (ID INTEGER) ');
            lScript.Add('AS ');
            lScript.Add('BEGIN ');
            lScript.Add('  ID = GEN_ID(GEN_CLIENTE_ID, 1); ');
            lScript.Add('  SUSPEND; ');
            lScript.Add('END ^ ');
            AFDScript.ExecuteScript(lScript);
        }
      lString.Add('    except ');
      lString.Add('      On Ex:Exception do ');
      lString.Add('        raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('    {$IFDEF MSWINDOWS} ');
      lString.Add('      FreeAndNil(lScript); ');
      lString.Add('    {$ELSE} ');
      lString.Add('      lScript.DisposeOf; ');
      lString.Add('    {$ENDIF} ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Procedure Criar_Estrutura'}

    lString.Add(' ');

    {$Region 'Procedure Atualizar_Estrutura'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Procedure Atualizar_Estrutura.');
      end);
      lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Atualizar_Estrutura(const AFDQ_Query: TFDQuery); ');
      lString.Add('begin ');
      lString.Add(' ');
      lString.Add('end; ');
    {$EndRegion 'Procedure Atualizar_Estrutura'}

    lString.Add(' ');

    {$Region 'Procedure Inicia_Propriedades'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Procedure Inicia_Propriedades.');
      end);

      lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Inicia_Propriedades; ');
      lString.Add('begin ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
            261: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := ''''; ');
             14: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := ''''; ');
             40: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := ''''; ');
             11: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := 0; ');
             27: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := 0; ');
             10: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := 0; ');
             16: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := 0; ');
              8: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := -1; ');
              9: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := -1; ');
              7: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := -1; ');
             12: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := Date; ');
             13: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := Time; ');
             35: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := Now; ');
             37: lString.Add('  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := ''''; ');
          end;

          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('end; ');
    {$EndRegion 'Procedure Inicia_Propriedades'}

    lString.Add(' ');

    {$Region 'Função Listar'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Função Listar.');
      end);
      FDm.Listar_PrimaryKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      //sFiltro := sFiltro + ' APagina:Integer=0; ';
      //if not lQuery_Objeto.IsEmpty then
      //  sFiltro := sFiltro + lQuery_Objeto.FieldByName('CAMPOS_FILTRO').AsString;

      if sFiltro <> '' then
        lString.Add('function  T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Listar(const AFDQ_Query:TFDQuery; '+sFiltro+'): TJSONArray; ')
      else
        lString.Add('function  T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Listar(const AFDQ_Query:TFDQuery): TJSONArray; ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      AFDQ_Query.Connection := FConexao; ');
      lString.Add(' ');
      lString.Add('      Inicia_Propriedades; ');
      lString.Add(' ');
      lString.Add('      AFDQ_Query.Active := False; ');
      lString.Add('      AFDQ_Query.Sql.Clear; ');
      lString.Add('      AFDQ_Query.Sql.Add(' + QuotedStr('SELECT * FROM '+cbTabela.Items.Strings[cbTabela.ItemIndex]) +') ;');
      lString.Add('      AFDQ_Query.Sql.Add('+QuotedStr('WHERE 1=1')+');');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.FieldByName('CHAVE_PRIMARIA').AsInteger <> 0 then
          begin
            lString.Add('      AFDQ_Query.Sql.Add(''  AND '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = :'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+''');');
            lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').' +lQuery_Objeto.FieldByName('TIPO_CAMPO_QUERY').AsString+ ' := A'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString);
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      if ((APagina > 0) and (FPaginas > 0))  then ');
      lString.Add('      begin ');
      lString.Add('        FPagina := (((APagina - 1) * FPaginas) + 1); ');
      lString.Add('        FPaginas := (APagina * FPaginas); ');
      lString.Add('        AFDQ_Query.Sql.Add(''ROWS '' + FPagina.ToString + '' TO '' + FPaginas.ToString); ');
      lString.Add('      end; ');
      lString.Add('      AFDQ_Query.Active := True; ');
      lString.Add('      Result := AFDQ_Query.ToJSONArray; ');
      lString.Add(' ');
      lString.Add('      if not AFDQ_Query.IsEmpty then ');
      lString.Add('      begin ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('        '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := AFDQ_Query.FieldByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').'+lQuery_Objeto.FieldByName('TIPO_CAMPO_QUERY').AsString+';');
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      end; ');
      lString.Add('    except ');
      lString.Add('      On Ex:Exception do ');
      lString.Add('        raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Função Listar'}

    lString.Add(' ');

    {$Region 'Procedure Inserir'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Procedure Inserir.');
      end);
      lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Inserir(const AFDQ_Query: TFDQuery); ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      AFDQ_Query.Connection := FConexao; ');
      lString.Add(' ');
      //Validando campos obrigatórios...
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.FieldByName('CHAVE_PRIMARIA').AsInteger = 0 then
          begin
            if ((not lQuery_Objeto.FieldByName('RDB$NULL_FLAG').IsNull) and (lQuery_Objeto.FieldByName('RDB$NULL_FLAG').AsInteger = 1)) then
            begin
              case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
                261:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = '''' then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                end;
                 14:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = '''' then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 40:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = '''' then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 11:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = 0 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 27:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = 0 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 10:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = 0 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 16:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = 0 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                  8:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = -1 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                  end;
                  9:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = -1 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                  end;
                  7:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = -1 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                  end;
                 12:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = 0 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 13:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = 0 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 35:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = 0 then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
                 37:begin
                      lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = '''' then ');
                      lString.Add('        raise Exception.Create('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ': ' + lQuery_Objeto.FieldByName('RDB$DESCRIPTION').AsString + ' não informado')+'); ');
                 end;
              end;
            end;
          end;
          lQuery_Objeto.Next;
        end;
      end;

      lString.Add(' ');
      lString.Add('      AFDQ_Query.Active := False; ');
      lString.Add('      AFDQ_Query.Sql.Clear; ');
      lString.Add('      AFDQ_Query.Sql.Add(' + QuotedStr('INSERT INTO ' +cbTabela.Items.Strings[cbTabela.ItemIndex]+ '( ') + ');');

      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.RecNo = 1 then
            lString.Add('      AFDQ_Query.Sql.Add('+QuotedStr('  ' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+');')
          else
            lString.Add('      AFDQ_Query.Sql.Add('+QuotedStr('  ,' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+');');

          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      AFDQ_Query.Sql.Add('+QuotedStr(') VALUES(') + ');');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.RecNo = 1 then
            lString.Add('      AFDQ_Query.Sql.Add('+QuotedStr('  :' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+');')
          else
            lString.Add('      AFDQ_Query.Sql.Add('+QuotedStr('  ,:' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+');');

          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      AFDQ_Query.Sql.Add('+QuotedStr(');')+');');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
            261: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsString := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             14: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsString := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             40: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsString := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             11: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsFloat := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             27: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsFloat := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             10: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsFloat := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             16: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsFloat := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
              8: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsInteger := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
              9: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsInteger := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
              7: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsInteger := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             12: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsDateTime := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             13: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsDateTime := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             35: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsDateTime := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
             37: lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').AsString := F' + lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString + ';');
          end;

          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      AFDQ_Query.ExecSQL; ');
      lString.Add('    except ');
      lString.Add('      On Ex:Exception do ');
      lString.Add('        raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Procedure Inserir'}

    lString.Add(' ');

    {$Region 'Procedure Atualizar'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Procedure Atualizar.');
      end);
      FDm.Listar_PrimaryKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
        sFiltro := lQuery_Objeto.FieldByName('CAMPOS_FILTRO').AsString;
      if sFiltro <> '' then
        lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Atualizar(const AFDQ_Query: TFDQuery; '+sFiltro+'); ')
      else
        lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Atualizar(const AFDQ_Query: TFDQuery); ');
      lString.Add('begin ');
      lString.Add('   try ');
      lString.Add('     try ');
      lString.Add('       AFDQ_Query.Connection := FConexao; ');
      lString.Add(' ');

      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.FieldByName('CHAVE_PRIMARIA').AsInteger <> 0 then
          begin
            if lFiltro_Chave.Count = 0 then
            begin
              lFiltro_Chave.Add('AFDQ_Query.Sql.Add(''WHERE 1=1'');');
            end;
            lFiltro_Chave.Add('AFDQ_Query.Sql.Add(''  AND '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = :'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+''');');
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      lInc_Virgula := 0;
      lString.Add('      AFDQ_Query.Sql.Add(''UPDATE '+cbTabela.Items.Strings[cbTabela.ItemIndex]+' SET '');');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.FieldByName('CHAVE_PRIMARIA').AsInteger = 0 then
          begin
            lInc_Virgula := (lInc_Virgula + 1);
            case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
              261:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
               14:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
               40:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
               11:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               27:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               10:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               16:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
                8:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
                9:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
                7:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               12:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > 0 then ');
               13:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > 0 then ');
               35:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > 0 then ');
               37:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
            end;
            if lInc_Virgula = 1 then
              lString.Add('        AFDQ_Query.Sql.Add(''  '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = :'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' '');')
            else
              lString.Add('        AFDQ_Query.Sql.Add(''  ,'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = :'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' '');');
          end;
          lQuery_Objeto.Next;
        end;
      end;
      if lFiltro_Chave.Count > 0 then
      begin
        for I := 0 to lFiltro_Chave.Count - 1 do
        begin
          lString.Add('      '+lFiltro_Chave.Strings[I]);
        end;
      end;

      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.FieldByName('CHAVE_PRIMARIA').AsInteger <> 0 then
          begin
            lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').' +lQuery_Objeto.FieldByName('TIPO_CAMPO_QUERY').AsString+ ' := F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+';');
          end
          else
          begin
            lInc_Virgula := (lInc_Virgula + 1);
            case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
              261:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
               14:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
               40:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
               11:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               27:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               10:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               16:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
                8:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
                9:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
                7:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > -1 then ');
               12:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > 0 then ');
               13:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > 0 then ');
               35:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' > 0 then ');
               37:lString.Add('      if F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' <> '''' then ');
            end;
            lString.Add('        AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').' +lQuery_Objeto.FieldByName('TIPO_CAMPO_QUERY').AsString+ ' := F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+';');
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      AFDQ_Query.ExecSQL; ');
      lString.Add('    except ');
      lString.Add('      On Ex:Exception do ');
      lString.Add('        raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('  end; ');
      lString.Add('end; ');


    {$EndRegion 'Procedure Atualizar'}

    lString.Add(' ');

    {$Region 'Procedure Excluir'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Procedure Excluir.');
      end);
      sFiltro := '';
      FDm.Listar_PrimaryKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
        sFiltro := lQuery_Objeto.FieldByName('CAMPOS_FILTRO').AsString;

      if sFiltro <> '' then
        lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Excluir(const AFDQ_Query:TFDQuery; '+sFiltro+'); ')
      else
        lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Excluir(const AFDQ_Query: TFDQuery); ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      AFDQ_Query.Connection := FConexao; ');
      lString.Add('      AFDQ_Query.Active := False; ');
      lString.Add('      AFDQ_Query.Sql.Clear; ');
      lString.Add('      AFDQ_Query.Sql.Add(''DELETE FROM '+cbTabela.Items.Strings[cbTabela.ItemIndex]+' ''); ');
      lString.Add('      AFDQ_Query.Sql.Add(''WHERE NOT ID IS NULL ''); ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          if lQuery_Objeto.FieldByName('CHAVE_PRIMARIA').AsInteger <> 0 then
          begin
            lString.Add('      AFDQ_Query.Sql.Add(''  AND '+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' = :'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+''');');
            lString.Add('      AFDQ_Query.ParamByName('+QuotedStr(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString)+').' +lQuery_Objeto.FieldByName('TIPO_CAMPO_QUERY').AsString+ ' := A'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+';');
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      AFDQ_Query.ExecSQL; ');
      lString.Add('    except ');
      lString.Add('      On Ex:Exception do ');
      lString.Add('        raise Exception.Create(Ex.Message); ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Procedure Excluir'}

    lString.Add(' ');

    {$Region 'Procedures das propriedades'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('M.Dados: Procedures das propriedades.');
      end);
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex]);
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('procedure T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Set'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+'( const Value:' +lQuery_Objeto.FieldByName('TIPO_CAMPO').AsString+');');
          lString.Add('begin ');
          lString.Add('  F'+lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := Value; ');
          lString.Add('end;');
          lString.Add(' ');
          lQuery_Objeto.Next;
        end;
      end;
    {$EndRegion 'Procedures das propriedades'}

    lString.Add(' ');
    lString.Add('end. ');

    lString.SaveToFile(lPastaNome);
    //Memo.Lines.LoadFromFile(lPastaNome);

    {$IFDEF MSWINDOWS}
      FreeAndNil(lString);
      FreeAndNil(lTrigger);
      FreeAndNil(lFiltro_Chave);
      FreeAndNil(lQuery_Objeto);
      FreeAndNil(sFiltroSql);
    {$ELSE}
      lString.DisposeOf;
      lTrigger.DisposeOf;
      lFiltro_Chave.DisposeOf;
      lQuery_Objeto.DisposeOf;
      sFiltroSql.DisposeOf;
    {$ENDIF}
  end);

  t.OnTerminate := ThreadEnd_Criar_ModeloDados;
  t.Start;

end;

procedure TfrmCriarEstrutura.ThreadEnd_Criar_ModeloDados(Sender:TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    Cria_Rotas(edNomeEstrutura.Text,cbTabela.Items.Text);
end;

procedure TfrmCriarEstrutura.Cria_Rotas(const ANomeEstrutura, ATabela:String);
var
  t :TThread;
begin

  TLoading.Show(frmCriarEstrutura,'Criando modelo...');

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lString :TStringList;
    lTrigger :TStringList;
    lPastaNome :String;
    lQuery_Objeto :TFDQuery;
    I :Integer;
    lFiltro_Chave :TStringList;
    lInc_Virgula :Integer;
    sFiltro :String;
  begin
    lString := TStringList.Create;
    lTrigger := TStringList.Create;
    lFiltro_Chave := TStringList.Create;

    lQuery_Objeto := TFDQuery.Create(Nil);
    lQuery_Objeto.Connection := FDm.FDC_Servidor;

    lPastaNome := '';

    {$IFDEF MSWINDOWS}
      lPastaNome := ANomeEstrutura + '\Rotas\uRota.' + cbTabela.Items.Strings[cbTabela.ItemIndex] + '.pas';
    {$ELSE}
      lPastaNome := TPath.Combine(ANomeEstrutura + '\Modelo de Dados\uModel.', cbTabela.Items.Strings[cbTabela.ItemIndex] + '.pas');
    {$ENDIF}

    lString.Add('unit uRota.'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'; ');
    lString.Add(' ');
    lString.Add('interface ');
    lString.Add(' ');
    lString.Add('uses ');
    lString.Add('  System.SysUtils, ');
    lString.Add('  System.JSON, ');
    lString.Add('  System.Net.HttpClient, ');
    lString.Add('  System.Classes, ');
    lString.Add(' ');
    lString.Add('  FMX.Dialogs, ');
    lString.Add(' ');
    lString.Add('  Horse, ');
    lString.Add('  Horse.Jhonson, ');
    lString.Add('  Horse.CORS, ');
    lString.Add('  Horse.JWT, ');
    lString.Add(' ');
    lString.Add('  uRota.Auth, ');
    lString.Add(' ');
    lString.Add('  uModel.'+cbTabela.Items.Strings[cbTabela.ItemIndex]+', ');
    lString.Add('  uFuncoes, ');
    lString.Add('  uFDm, ');
    lString.Add(' ');
    lString.Add('  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, ');
    lString.Add('  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, ');
    lString.Add('  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, ');
    lString.Add('  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, ');
    lString.Add('  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase, ');
    lString.Add('  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script; ');
    lString.Add(' ');
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      TLoading.ChangeText('M.Dados: Criando Procedures/Funções.');
    end);

    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      TLoading.ChangeText('Rotas: Criando procedures.');
    end);
    lString.Add('  procedure RegistrarRotas; ');
    lString.Add(' ');
    lString.Add('  procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
    lString.Add('  procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
    lString.Add('  procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
    lString.Add('  procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
    lString.Add(' ');
    lString.Add('implementation ');
    lString.Add(' ');

    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      TLoading.ChangeText('Rotas: Registrando rotas.');
    end);
    lString.Add('procedure RegistrarRotas; ');
    lString.Add('begin ');
    lString.Add('  {$Region '+QuotedStr(cbTabela.Items.Strings[cbTabela.ItemIndex])+'} ');
    lString.Add('    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get(' + QuotedStr('/' + TFuncoes.FieldDB_To_TagJson(LowerCase(cbTabela.Items.Strings[cbTabela.ItemIndex]))) +',Listar);');
    lString.Add('    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post(' + QuotedStr('/' + TFuncoes.FieldDB_To_TagJson(LowerCase(cbTabela.Items.Strings[cbTabela.ItemIndex]))) +',Cadastro);');
    lString.Add('    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put(' + QuotedStr('/' + TFuncoes.FieldDB_To_TagJson(LowerCase(cbTabela.Items.Strings[cbTabela.ItemIndex]))) +',Alterar);');
    lString.Add('    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete(' + QuotedStr('/' + TFuncoes.FieldDB_To_TagJson(LowerCase(cbTabela.Items.Strings[cbTabela.ItemIndex]))) +',Delete);');
    lString.Add('  {$EndRegion '+QuotedStr(cbTabela.Items.Strings[cbTabela.ItemIndex])+'} ');
    lString.Add('end; ');
    lString.Add(' ');

    {$Region 'Listar'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('Rotas-Procedure Listar.');
      end);
      lString.Add('procedure Listar(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
      lString.Add('var ');
      lString.Add('  lJson_Ret :TJSONArray; ');
      lString.Add(' ');
      lString.Add('  FDm :TFDm; ');
      lString.Add('  lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' :T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'; ');
      lString.Add('  lErro :String; ');
      lString.Add(' ');
      lString.Add('  lQuery :TFDQuery; ');
      lString.Add(' ');
      lString.Add('  I :Integer; ');
      lString.Add(' ');
      //Chave primaria
      FDm.Listar_Filtros(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex]);
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('  l'+lQuery_Objeto.FieldByName('TIPO_VARIAVEL').AsString);
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('  lPagina :Integer; ');
      lString.Add(' ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      FDm := TFDm.Create(Nil); ');
      lString.Add(' ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' := T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Create(FDm.FDC_Servidor); ');
      lString.Add('      lQuery := TFDQuery.Create(Nil); ');
      lString.Add('      lQuery.Connection := FDm.FDC_Servidor; ');
      lString.Add(' ');
      //Chave primária
      FDm.Listar_Filtros(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex]);
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
            261 :begin
              lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := ''''; ');
              lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
            end;
             14 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := ''''; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
             end;
             40 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := ''''; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
             end;
             11 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             end;
             27 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             end;
             10 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             end;
             16 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             end;
              8 :begin
                lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
                lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
              end;
              9 :begin
                lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
                lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
              end;
              7 :begin
                lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
                lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
              end;
             12 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToDateDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],Date); ');
             end;
             13 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToTimeDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],Time); ');
             end;
             35 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := 0; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToDateTimeDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],Now); ');
             end;
             37 :begin
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := ''''; ');
               lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
             end;
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('      lPagina := StrToIntDef(Req.Query[''pagina''],0); ');
      lString.Add(' ');
      FDm.Listar_PrimaryKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
        lString.Add('      lJson_Ret := lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Listar(lQuery,'+lQuery_Objeto.FieldByName('CAMPOS_LISTAR').AsString+',lPagina); ');
      lString.Add(' ');
      lString.Add('      if lJson_Ret.Size = 0  then ');
      lString.Add('      begin ');
      lString.Add('        Res.Send(' + QuotedStr(cbTabela.Items.Strings[cbTabela.ItemIndex] + ' não localizados')+').Status(401); ');
      lString.Add('        TFuncoes.Gravar_Hitorico(lQuery,'' - '+cbTabela.Items.Strings[cbTabela.ItemIndex]+' não localizado''); ');
      lString.Add('      end ');
      lString.Add('      else ');
      lString.Add('      begin ');
      lString.Add('        Res.Send(lJson_Ret).Status(200); ');
      lString.Add('        TFuncoes.Gravar_Hitorico(lQuery,'' - Listagem de '+cbTabela.Items.Strings[cbTabela.ItemIndex]+'''); ');
      lString.Add('      end; ');
      lString.Add('    except on E: Exception do ');
      lString.Add('      begin ');
      lString.Add('        Res.Send(E.Message).Status(500); ');
      lString.Add('        TFuncoes.Gravar_Hitorico(lQuery,'' - Erro ao Listar '+cbTabela.Items.Strings[cbTabela.ItemIndex]+': '' + E.Message); ');
      lString.Add('      end; ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('    {$IFDEF MSWINDOWS} ');
      lString.Add('      FreeAndNil(lQuery); ');
      lString.Add('      FreeAndNil(FDm); ');
      lString.Add('      FreeAndNil(lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'); ');
      lString.Add('    {$ELSE} ');
      lString.Add('      lQuery.DisposeOf; ');
      lString.Add('      FDm.DisposeOf; ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.DisposeOf; ');
      lString.Add('    {$ENDIF} ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Listar'}

    lString.Add(' ');

    {$Region 'Cadastrar'}

      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('Rotas-Procedure Cadastrar.');
      end);

      lString.Add('procedure Cadastro(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
      lString.Add('var ');
      lString.Add('  lBody :TJSONArray; ');
      lString.Add('  FDm :TFDm; ');
      lString.Add('  lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' :T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'; ');
      lString.Add('  lErro :String; ');
      lString.Add(' ');
      lString.Add('  lQuery :TFDQuery; ');
      lString.Add(' ');
      lString.Add('  I:Integer; ');
      lString.Add('begin ');
      lString.Add(' ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      FDm := TFDm.Create(Nil); ');
      lString.Add('      if not FDm.FDC_Servidor.InTransaction then ');
      lString.Add('        FDm.FDC_Servidor.StartTransaction; ');
      lString.Add(' ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' := T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Create(FDm.FDC_Servidor); ');
      lString.Add('      lQuery := TFDQuery.Create(Nil); ');
      lString.Add('      lQuery.Connection := FDm.FDC_Servidor; ');
      lString.Add(' ');
      lString.Add('      lBody := Req.Body<TJsonArray>; ');
      lString.Add('      if lBody = Nil then ');
      lString.Add('        raise Exception.Create(''Não há registros para ser cadastrado''); ');
      lString.Add(' ');
      lString.Add('      for I := 0 to (lBody.Size - 1) do ');
      lString.Add('      begin ');
      lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Inicia_Propriedades; ');
      lString.Add(' ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
            12:begin
              lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.'+
                                       lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('+
                                       QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString))+',DateToStr(Date)),lErro); ');
            end;
            13:begin
              lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.'+
                                       lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('+
                                       QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString))+',DateToStr(Date)),lErro); ');
            end;
            35:begin

            end;
          else
            lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.'+
                                     lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := lBody[I].GetValue<'+
                                     lQuery_Objeto.FieldByName('TIPO_CAMPO').AsString+'>('+
                                     QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString))+','+
                                     lQuery_Objeto.FieldByName('VAZIO').AsString+'); ');
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Inserir(lQuery); ');
      lString.Add('      end; ');
      lString.Add(' ');
      lString.Add('      FDm.FDC_Servidor.Commit; ');
      lString.Add(' ');
      lString.Add('      Res.Send('''+cbTabela.Items.Strings[cbTabela.ItemIndex]+' cadastrados com sucesso'').Status(200); ');
      lString.Add('      TFuncoes.Gravar_Hitorico(lQuery,'' - '+cbTabela.Items.Strings[cbTabela.ItemIndex]+' cadastrados com sucesso''); ');
      lString.Add(' ');
      lString.Add('    except on E: Exception do ');
      lString.Add('      begin ');
      lString.Add('        FDm.FDC_Servidor.Rollback; ');
      lString.Add('        Res.Send(E.Message).Status(500); ');
      lString.Add('        TFuncoes.Gravar_Hitorico(lQuery,'' - Erro ao Cadastrar '+cbTabela.Items.Strings[cbTabela.ItemIndex]+': '' + E.Message); ');
      lString.Add('      end; ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('    {$IFDEF MSWINDOWS} ');
      lString.Add('      FreeAndNil(lQuery); ');
      lString.Add('      FreeAndNil(lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'); ');
      lString.Add('    {$ELSE} ');
      lString.Add('      lQuery.DisposeOf; ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.DisposeOf; ');
      lString.Add('    {$ENDIF} ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Cadastrar'}

    lString.Add(' ');

    {$Region 'Alterar'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('Rotas-Procedure Alterar.');
      end);

      lString.Add('procedure Alterar(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
      lString.Add('var ');
      lString.Add('  lBody :TJSONArray; ');
      lString.Add('  FDm :TFDm; ');
      lString.Add('  lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' :T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'; ');
      lString.Add('  lErro :String; ');
      lString.Add(' ');
      lString.Add('  lQuery :TFDQuery; ');
      lString.Add(' ');
      lString.Add('  I:Integer; ');
      lString.Add('begin ');
      lString.Add(' ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      FDm := TFDm.Create(Nil); ');
      lString.Add('      if not FDm.FDC_Servidor.InTransaction then ');
      lString.Add('        FDm.FDC_Servidor.StartTransaction; ');
      lString.Add(' ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' := T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Create(FDm.FDC_Servidor); ');
      lString.Add('      lQuery := TFDQuery.Create(Nil); ');
      lString.Add('      lQuery.Connection := FDm.FDC_Servidor; ');
      lString.Add(' ');
      lString.Add('      lBody := Req.Body<TJsonArray>; ');
      lString.Add('      if lBody = Nil then ');
      lString.Add('        raise Exception.Create(''Não há registros para ser alterados''); ');
      lString.Add(' ');
      lString.Add('      for I := 0 to (lBody.Size - 1) do ');
      lString.Add('      begin ');
      lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Inicia_Propriedades; ');
      lString.Add(' ');
      FDm.Listar_Campos(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
            12:begin
              lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.'+
                                       lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := TFuncoes.Retorna_Data_Json(lBody[I].GetValue<String>('+
                                       QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString))+',DateToStr(Date)),lErro); ');
            end;
            13:begin
              lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.'+
                                       lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := TFuncoes.Retorna_Hora_Json(lBody[I].GetValue<String>('+
                                       QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString))+',DateToStr(Date)),lErro); ');
            end;
            35:begin

            end;
          else
            lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.'+
                                     lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString+' := lBody[I].GetValue<'+
                                     lQuery_Objeto.FieldByName('TIPO_CAMPO').AsString+'>('+
                                     QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('RDB$FIELD_NAME').AsString))+','+
                                     lQuery_Objeto.FieldByName('VAZIO').AsString+'); ');
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add('        lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Atualizar(lQuery); ');
      lString.Add('      end; ');
      lString.Add(' ');
      lString.Add('      FDm.FDC_Servidor.Commit; ');
      lString.Add(' ');
      lString.Add('      Res.Send('''+cbTabela.Items.Strings[cbTabela.ItemIndex]+' alterado com sucesso'').Status(200); ');
      lString.Add('      TFuncoes.Gravar_Hitorico(lQuery,'' - '+cbTabela.Items.Strings[cbTabela.ItemIndex]+' alterado com sucesso''); ');
      lString.Add(' ');
      lString.Add('    except on E: Exception do ');
      lString.Add('      begin ');
      lString.Add('        FDm.FDC_Servidor.Rollback; ');
      lString.Add('        Res.Send(E.Message).Status(500); ');
      lString.Add('      TFuncoes.Gravar_Hitorico(lQuery,'' - Erro ao Alterar '+cbTabela.Items.Strings[cbTabela.ItemIndex]+': '' + E.Message); ');
      lString.Add('      end; ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('    {$IFDEF MSWINDOWS} ');
      lString.Add('      FreeAndNil(lQuery); ');
      lString.Add('      FreeAndNil(lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'); ');
      lString.Add('    {$ELSE} ');
      lString.Add('      lQuery.DisposeOf; ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.DisposeOf; ');
      lString.Add('    {$ENDIF} ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Alterar'}

    lString.Add(' ');

    {$Region 'Excluir'}
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLoading.ChangeText('Rotas-Procedure Excluir.');
      end);

      lString.Add('procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); ');
      lString.Add('var ');
      lString.Add('  lJson_Ret :TJSONArray; ');
      lString.Add(' ');
      lString.Add('  FDm :TFDm; ');
      lString.Add('  lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' :T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'; ');
      lString.Add('  lErro :String; ');
      lString.Add(' ');
      lString.Add('  lQuery :TFDQuery; ');
      //Chave primaria
      FDm.Listar_Filtros(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex]);
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          lString.Add('  l'+lQuery_Objeto.FieldByName('TIPO_VARIAVEL').AsString);
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      lString.Add('begin ');
      lString.Add('  try ');
      lString.Add('    try ');
      lString.Add('      FDm := TFDm.Create(Nil); ');
      lString.Add(' ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+' := T'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Create(FDm.FDC_Servidor); ');
      lString.Add('      lQuery := TFDQuery.Create(Nil); ');
      lString.Add('      lQuery.Connection := FDm.FDC_Servidor; ');
      lString.Add(' ');
      //Chave primária
      FDm.Listar_Filtros(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex]);
      if not lQuery_Objeto.IsEmpty then
      begin
        lQuery_Objeto.First;
        while not lQuery_Objeto.Eof do
        begin
          case lQuery_Objeto.FieldByName('RDB$FIELD_TYPE').AsInteger of
            261 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
             14 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
             40 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
             11 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             27 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             10 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             16 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
              8 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
              9 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
              7 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToIntDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],0); ');
             12 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToDateDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],Date); ');
             13 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToTimeDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],Time); ');
             35 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := StrToDateTimeDef(Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+'],Now); ');
             37 :lString.Add('      l'+lQuery_Objeto.FieldByName('CAMPO').AsString+' := Req.Query['+QuotedStr(TFuncoes.FieldDB_To_TagJson(lQuery_Objeto.FieldByName('CAMPO').AsString))+']; ');
          end;
          lQuery_Objeto.Next;
        end;
      end;
      lString.Add(' ');
      FDm.Listar_PrimaryKey(lQuery_Objeto,cbTabela.Items.Strings[cbTabela.ItemIndex],'');
      if not lQuery_Objeto.IsEmpty then
        lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.Excluir(lQuery,'+lQuery_Objeto.FieldByName('CAMPOS_LISTAR').AsString+'); ');
      lString.Add(' ');
      lString.Add('      Res.Send('''+cbTabela.Items.Strings[cbTabela.ItemIndex]+' excluído'').Status(200); ');
      lString.Add('      TFuncoes.Gravar_Hitorico(lQuery,'' - '+cbTabela.Items.Strings[cbTabela.ItemIndex]+' excluído''); ');
      lString.Add('    except on E: Exception do ');
      lString.Add('      begin ');
      lString.Add('        Res.Send(E.Message).Status(500); ');
      lString.Add('      TFuncoes.Gravar_Hitorico(lQuery,'' - Erro ao excluir o '+cbTabela.Items.Strings[cbTabela.ItemIndex]+': '' + E.Message); ');
      lString.Add('      end; ');
      lString.Add('    end; ');
      lString.Add('  finally ');
      lString.Add('    {$IFDEF MSWINDOWS} ');
      lString.Add('      FreeAndNil(lQuery); ');
      lString.Add('      FreeAndNil(FDm); ');
      lString.Add('      FreeAndNil(lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'); ');
      lString.Add('    {$ELSE} ');
      lString.Add('      lQuery.DisposeOf; ');
      lString.Add('      FDm.DisposeOf; ');
      lString.Add('      lT'+cbTabela.Items.Strings[cbTabela.ItemIndex]+'.DisposeOf; ');
      lString.Add('    {$ENDIF} ');
      lString.Add('  end; ');
      lString.Add('end; ');
    {$EndRegion 'Excluir'}

    lString.Add(' ');
    lString.Add('end. ');

    lString.SaveToFile(lPastaNome);
    {$IFDEF MSWINDOWS}
      FreeAndNil(lString);
    {$ELSE}
      lString.DisposeOf;
    {$ENDIF}
  end);

  t.OnTerminate := ThreadEnd_Criar_Rotas;
  t.Start;

end;

procedure TfrmCriarEstrutura.ThreadEnd_Criar_Rotas(Sender :TOBject);
begin
  TLoading.Hide;
  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message);
end;

end.
