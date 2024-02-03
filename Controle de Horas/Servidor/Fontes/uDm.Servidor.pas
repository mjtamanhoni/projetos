unit uDm.Servidor;

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,

  IniFiles,
  
  DataSet.Serialize.Config, DataSet.Serialize ;

type
  TDM_Servidor = class(TDataModule)
    FDC_Servidor: TFDConnection;
    FDT_Servidor: TFDTransaction;
    FDP_Servidor: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQ_Select: TFDQuery;
    FDQ_Insert: TFDQuery;
    FDQ_Update: TFDQuery;
    FDQ_Delete: TFDQuery;
    FDQ_Sequencia: TFDQuery;
    FDScript1: TFDScript;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDC_ServidorBeforeConnect(Sender: TObject);
  private
    FEnder :String;
    lEnder_Ini :String;
    FIniFile :TIniFile;
    
    procedure CarregarConfigDB(Connection: TFDConnection);
  public
    procedure Listar_Tabelas(const AQuery:TFDQuery;const ATabela:String='');
    procedure Listar_Campos(const AQuery:TFDQuery;const ATabela:String='';const ACampo:String='');
    procedure Listar_Triggers(const AQuery:TFDQuery;const ATabela:String='';const ATrigger:String='');
    procedure Listar_Indices(const AQuery:TFDQuery;const ATabela:String='';const AIndice:String='');
    procedure Listar_Generator(const AQuery:TFDQuery;const ATabela:String='';const AGenerator:String='');
    procedure Listar_ForeingKey(const AQuery:TFDQuery;const ATabela:String='';const AForeingKey:String='');
    procedure Listar_PrimaryKey(const AQuery:TFDQuery;const ATabela:String='';const APrimaryKey:String='');
    procedure Listar_Filtros(const AQuery:TFDQuery;const ATabela:String='');
  end;

var
  DM_Servidor: TDM_Servidor;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM_Servidor.CarregarConfigDB(Connection: TFDConnection);
var
  lEnder_Ini :String;

  lDatabase :String;
  lUser_Name :String;
  lPassword :String;
  lProtocol :String;
  lPort :String;
  lServer :String;
  lDriverID :String;
  lBiblioteca :String;
  lVersao :Integer;

begin

  FDC_Servidor.Connected := False;

  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_HORAS_TRAB.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_HORAS_TRAB.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  try
    lDatabase := '';
    lUser_Name := '';
    lPassword := '';
    lProtocol := '';
    lPort := '';
    lServer := '';
    lDriverID := '';
    lBiblioteca := '';
    lVersao := -1;

    lDatabase := FIniFile.ReadString('FIREBIRD','BANCO','');
    lUser_Name := FIniFile.ReadString('FIREBIRD','USUARIO','');
    lPassword := FIniFile.ReadString('FIREBIRD','SENHA','');
    lServer := FIniFile.ReadString('FIREBIRD','SERVIDOR','');
    if lServer = 'LOCALHOST' then
      lProtocol := 'LOCAL'
    else
      lProtocol := 'TCPIP';
    lPort := FIniFile.ReadString('FIREBIRD','PORTA','');
    lDriverID := 'FB';
    lBiblioteca := FIniFile.ReadString('FIREBIRD','BIBLIOTECA','');
    lVersao := FIniFile.ReadInteger('FIREBIRD','VERSAO',-1); //0-2.1, 1-3.0

    Connection.LoginPrompt := False;
    Connection.Params.Clear;
    Connection.Params.Add('Database=' + lDatabase);
    Connection.Params.Add('User_Name=' + lUser_Name);
    Connection.Params.Add('Password=' + lPassword);
    Connection.Params.Add('Protocol=' + lProtocol);
    Connection.Params.Add('Port=' + lPort);
    Connection.Params.Add('Server=' + lServer);
    Connection.Params.Add('DriverID=' + lDriverID);

    if lVersao = 0 then
    begin
      FDP_Servidor.VendorLib := '';
      FDP_Servidor.VendorLib := lBiblioteca;
    end;
  except
    On Ex:Exception do
      raise Exception.Create(Ex.Message);
  end;
end;

procedure TDM_Servidor.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

  FDC_Servidor.Connected := True;
end;

procedure TDM_Servidor.FDC_ServidorBeforeConnect(Sender: TObject);
begin
  CarregarConfigDB(FDC_Servidor);
end;

procedure TDM_Servidor.Listar_Campos(const AQuery: TFDQuery; const ATabela, ACampo: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('	RF.* ');
      AQuery.Sql.Add('	,''COMMENT ON COLUMN '' || TRIM(RF.RDB$RELATION_NAME) || ''.'' || TRIM(RF.RDB$FIELD_NAME) || '' IS '' || '''''''' || TRIM(RF.RDB$DESCRIPTION) || '''''''' || '';'' AS DESCRICAO ');
      AQuery.Sql.Add('  ,F.RDB$FIELD_LENGTH ');
      AQuery.Sql.Add('  ,F.RDB$FIELD_SCALE ');
      AQuery.Sql.Add('  ,F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('  ,F.RDB$FIELD_SUB_TYPE ');
      AQuery.Sql.Add('  ,F.RDB$FIELD_PRECISION ');
      AQuery.Sql.Add('  ,CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('    WHEN 261 THEN ''String'' ');
      AQuery.Sql.Add('    WHEN 14 THEN ''String'' ');
      AQuery.Sql.Add('    WHEN 40 THEN ''String'' ');
      AQuery.Sql.Add('    WHEN 11 THEN ''Double'' ');
      AQuery.Sql.Add('    WHEN 27 THEN ''Double'' ');
      AQuery.Sql.Add('    WHEN 10 THEN ''Double'' ');
      AQuery.Sql.Add('    WHEN 16 THEN ''Double'' ');
      AQuery.Sql.Add('    WHEN 8 THEN ''Integer'' ');
      AQuery.Sql.Add('    WHEN 9 THEN ''Integer'' ');
      AQuery.Sql.Add('    WHEN 7 THEN ''Integer'' ');
      AQuery.Sql.Add('    WHEN 12 THEN ''TDate'' ');
      AQuery.Sql.Add('    WHEN 13 THEN ''TTime'' ');
      AQuery.Sql.Add('    WHEN 35 THEN ''TDateTime'' ');
      AQuery.Sql.Add('    WHEN 37 THEN ''String'' ');
      AQuery.Sql.Add('    ELSE ''String'' ');
      AQuery.Sql.Add('  END TIPO_CAMPO ');
      AQuery.Sql.Add('  ,CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('     WHEN 261 THEN '''''''''''' ');
      AQuery.Sql.Add('     WHEN  14 THEN '''''''''''' ');
      AQuery.Sql.Add('     WHEN  40 THEN '''''''''''' ');
      AQuery.Sql.Add('     WHEN  11 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  27 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  10 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  16 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN   8 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN   9 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN   7 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  12 THEN ''Date'' ');
      AQuery.Sql.Add('     WHEN  13 THEN ''Time'' ');
      AQuery.Sql.Add('     WHEN  35 THEN ''Now'' ');
      AQuery.Sql.Add('     WHEN  37 THEN '''''''''''' ');
      AQuery.Sql.Add('   END VAZIO ');
      AQuery.Sql.Add('  ,CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('    WHEN 261 THEN ''AsString'' ');
      AQuery.Sql.Add('    WHEN 14 THEN ''AsString'' ');
      AQuery.Sql.Add('    WHEN 40 THEN ''AsString'' ');
      AQuery.Sql.Add('    WHEN 11 THEN ''AsFloat'' ');
      AQuery.Sql.Add('    WHEN 27 THEN ''AsFloat'' ');
      AQuery.Sql.Add('    WHEN 10 THEN ''AsFloat'' ');
      AQuery.Sql.Add('    WHEN 16 THEN ''AsFloat'' ');
      AQuery.Sql.Add('    WHEN 8 THEN ''AsInteger'' ');
      AQuery.Sql.Add('    WHEN 9 THEN ''AsInteger'' ');
      AQuery.Sql.Add('    WHEN 7 THEN ''AsInteger'' ');
      AQuery.Sql.Add('    WHEN 12 THEN ''AsDateTime'' ');
      AQuery.Sql.Add('    WHEN 13 THEN ''AsDateTime'' ');
      AQuery.Sql.Add('    WHEN 35 THEN ''TDateTime'' ');
      AQuery.Sql.Add('    WHEN 37 THEN ''AsString'' ');
      AQuery.Sql.Add('    ELSE ''AsString'' ');
      AQuery.Sql.Add('  END TIPO_CAMPO_QUERY ');
      AQuery.Sql.Add('  ,CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('    WHEN 261 THEN ''BLOB SUB_TYPE 1 SEGMENT SIZE 4096'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN '' '' || TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  14 THEN ''CHAR('' || F.RDB$FIELD_LENGTH || '')'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN '' '' || TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  40 THEN ''CSTRING('' || F.RDB$FIELD_LENGTH || '')'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN '' '' || TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  11 THEN ''NUMERIC('' || F.RDB$FIELD_PRECISION || '','' || (F.RDB$FIELD_SCALE * -1) || '')'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN '' '' || TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  27 THEN ''NUMERIC('' || F.RDB$FIELD_PRECISION || '','' || (F.RDB$FIELD_SCALE * -1) || '')'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  10 THEN ''NUMERIC('' || F.RDB$FIELD_PRECISION || '','' || (F.RDB$FIELD_SCALE * -1) || '')'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  16 THEN ''NUMERIC('' || F.RDB$FIELD_PRECISION || '','' || (F.RDB$FIELD_SCALE * -1) || '')'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN   8 THEN ''INTEGER'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN   9 THEN ''QUAD'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN   7 THEN ''SMALLINT'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  12 THEN ''DATE'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  13 THEN ''TIME'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  35 THEN ''TIMESTAMP'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    WHEN  37 THEN ''VARCHAR('' || F.RDB$FIELD_LENGTH || '')'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('    ELSE ''VARCHAR(100)'' || ');
      AQuery.Sql.Add('      CASE COALESCE(RF.RDB$NULL_FLAG,0) WHEN 1 THEN '' NOT NULL'' ELSE '''' END || ');
      AQuery.Sql.Add('      CASE WHEN COALESCE(TRIM(RF.RDB$DEFAULT_SOURCE),'''') <> '''' THEN  '' '' ||TRIM(RF.RDB$DEFAULT_SOURCE) ELSE '''' END ');
      AQuery.Sql.Add('  END AS TIPO_BANCO ');
      AQuery.Sql.Add('  ,COALESCE(CP.CHAVE_PRIMARIA,0) AS CHAVE_PRIMARIA ');
      AQuery.Sql.Add('FROM RDB$RELATION_FIELDS RF ');
      AQuery.Sql.Add('  JOIN RDB$FIELDS F ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME ');
      AQuery.Sql.Add('  LEFT JOIN (SELECT ');
      AQuery.Sql.Add('              C.RDB$RELATION_NAME ');
      AQuery.Sql.Add('              ,S.RDB$FIELD_NAME ');
      AQuery.Sql.Add('              ,1 AS CHAVE_PRIMARIA ');
      AQuery.Sql.Add('            FROM RDB$RELATION_CONSTRAINTS C ');
      AQuery.Sql.Add('              JOIN RDB$INDEX_SEGMENTS S ON S.RDB$INDEX_NAME = C.RDB$INDEX_NAME ');
      AQuery.Sql.Add('            WHERE C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'') CP ON CP.RDB$FIELD_NAME = RF.RDB$FIELD_NAME ');
      AQuery.Sql.Add('                                                             AND CP.RDB$RELATION_NAME = RF.RDB$RELATION_NAME ');
      AQuery.Sql.Add('WHERE RF.RDB$SYSTEM_FLAG = 0 ');
      AQuery.Sql.Add('  AND RF.RDB$RELATION_NAME = ' + QuotedStr(ATabela));
      if Trim(ACampo) <> '' then
        AQuery.Sql.Add('  AND TRIM(RF.RDB$FIELD_NAME) = ' + Trim(ACampo));
      AQuery.Sql.Add('ORDER BY ');
      AQuery.Sql.Add('  RF.RDB$FIELD_POSITION; ');
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TDM_Servidor.Listar_Filtros(const AQuery: TFDQuery; const ATabela: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('  CASE WHEN TRIM(S.RDB$FIELD_POSITION) = 0 ');
      AQuery.Sql.Add('  THEN ''WHERE '' || TRIM(S.RDB$FIELD_NAME) || '' = :'' || TRIM(S.RDB$FIELD_NAME) ');
      AQuery.Sql.Add('  ELSE ''  AND '' || TRIM(S.RDB$FIELD_NAME) || '' = :'' || TRIM(S.RDB$FIELD_NAME) ');
      AQuery.Sql.Add('  END FILTRO ');
      AQuery.Sql.Add('  ,TRIM(S.RDB$FIELD_NAME) AS CAMPO ');
      AQuery.Sql.Add('  ,F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('  ,CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('     WHEN 261 THEN ''.AsString := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  14 THEN ''.AsString := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  40 THEN ''.AsString := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  11 THEN ''.AsFloat := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  27 THEN ''.AsFloat := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  10 THEN ''.AsFloat := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  16 THEN ''.AsFloat := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN   8 THEN ''.AsInteger := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN   9 THEN ''.AsInteger := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN   7 THEN ''.AsInteger := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  12 THEN ''.AsDateTime := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  13 THEN ''.AsDateTime := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  35 THEN ''.AsDateTime := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('     WHEN  37 THEN ''.AsString := F'' || TRIM(S.RDB$FIELD_NAME) || '';'' ');
      AQuery.Sql.Add('   END TIPO ');
      AQuery.Sql.Add('  ,CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('     WHEN 261 THEN TRIM(S.RDB$FIELD_NAME) || '' :String;'' ');
      AQuery.Sql.Add('     WHEN  14 THEN TRIM(S.RDB$FIELD_NAME) || '' :String;'' ');
      AQuery.Sql.Add('     WHEN  40 THEN TRIM(S.RDB$FIELD_NAME) || '' :String;'' ');
      AQuery.Sql.Add('     WHEN  11 THEN TRIM(S.RDB$FIELD_NAME) || '' :Double;'' ');
      AQuery.Sql.Add('     WHEN  27 THEN TRIM(S.RDB$FIELD_NAME) || '' :Double;'' ');
      AQuery.Sql.Add('     WHEN  10 THEN TRIM(S.RDB$FIELD_NAME) || '' :Double;'' ');
      AQuery.Sql.Add('     WHEN  16 THEN TRIM(S.RDB$FIELD_NAME) || '' :Double;'' ');
      AQuery.Sql.Add('     WHEN   8 THEN TRIM(S.RDB$FIELD_NAME) || '' :Integer;'' ');
      AQuery.Sql.Add('     WHEN   9 THEN TRIM(S.RDB$FIELD_NAME) || '' :Integer;'' ');
      AQuery.Sql.Add('     WHEN   7 THEN TRIM(S.RDB$FIELD_NAME) || '' :Integer;'' ');
      AQuery.Sql.Add('     WHEN  12 THEN TRIM(S.RDB$FIELD_NAME) || '' :TDate;'' ');
      AQuery.Sql.Add('     WHEN  13 THEN TRIM(S.RDB$FIELD_NAME) || '' :TTime;'' ');
      AQuery.Sql.Add('     WHEN  35 THEN TRIM(S.RDB$FIELD_NAME) || '' :TDateTime;'' ');
      AQuery.Sql.Add('     WHEN  37 THEN TRIM(S.RDB$FIELD_NAME) || '' :String;'' ');
      AQuery.Sql.Add('   END TIPO_VARIAVEL ');
      AQuery.Sql.Add('  ,CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('     WHEN 261 THEN '''' ');
      AQuery.Sql.Add('     WHEN  14 THEN '''' ');
      AQuery.Sql.Add('     WHEN  40 THEN '''' ');
      AQuery.Sql.Add('     WHEN  11 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  27 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  10 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  16 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN   8 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN   9 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN   7 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  12 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  13 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  35 THEN ''0'' ');
      AQuery.Sql.Add('     WHEN  37 THEN '''' ');
      AQuery.Sql.Add('   END VAZIO ');
      AQuery.Sql.Add('FROM RDB$RELATION_CONSTRAINTS C ');
      AQuery.Sql.Add('  JOIN RDB$INDEX_SEGMENTS S ON S.RDB$INDEX_NAME = C.RDB$INDEX_NAME ');
      AQuery.Sql.Add('  JOIN RDB$RELATION_FIELDS RF ON RF.RDB$FIELD_NAME = S.RDB$FIELD_NAME ');
      AQuery.Sql.Add('                             AND RF.RDB$RELATION_NAME = C.RDB$RELATION_NAME ');
      AQuery.Sql.Add('  JOIN RDB$FIELDS F ON F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE ');
      AQuery.Sql.Add('WHERE TRIM(C.RDB$RELATION_NAME) = ' + QuotedStr(Trim(ATabela)));
      AQuery.Sql.Add('  AND C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ');
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TDM_Servidor.Listar_ForeingKey(const AQuery: TFDQuery; const ATabela, AForeingKey: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('	RC.RDB$CONSTRAINT_NAME AS CONSTRAINT_NAME ');
      AQuery.Sql.Add('  ,LIST(DISTINCT TRIM(S.RDB$FIELD_NAME)) AS FIELD_NAME ');
      AQuery.Sql.Add('  ,REFC.RDB$UPDATE_RULE AS ON_UPDATE ');
      AQuery.Sql.Add('  ,REFC.RDB$DELETE_RULE AS ON_DELETE ');
      AQuery.Sql.Add('  ,I2.RDB$RELATION_NAME AS REFERENCES_TABLE ');
      AQuery.Sql.Add('  ,LIST(DISTINCT TRIM(S2.RDB$FIELD_NAME)) AS REFERENCES_FIELD ');
      AQuery.Sql.Add('  ,''ALTER TABLE '' || TRIM(I.RDB$RELATION_NAME) || ');
      AQuery.Sql.Add('   '' ADD CONSTRAINT '' || TRIM(RC.RDB$CONSTRAINT_NAME) || ');
      AQuery.Sql.Add('   '' FOREIGN KEY ('' || LIST(DISTINCT TRIM(S.RDB$FIELD_NAME)) || '')'' || ');
      AQuery.Sql.Add('   '' REFERENCES '' || TRIM(I2.RDB$RELATION_NAME) || ''('' || LIST(DISTINCT TRIM(S2.RDB$FIELD_NAME)) || '') '' || ');
      AQuery.Sql.Add('   TRIM(CASE WHEN REFC.RDB$UPDATE_RULE = ''CASCADE'' THEN '' ON UPDATE CASCADE'' ELSE '''' END) || ');
      AQuery.Sql.Add('   TRIM(CASE WHEN REFC.RDB$DELETE_RULE = ''CASCADE'' THEN '' ON DELETE CASCADE'' ELSE '''' END) || '';'' AS FK_DESCRICAO ');
      AQuery.Sql.Add('FROM RDB$INDEX_SEGMENTS S ');
      AQuery.Sql.Add('  JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME ');
      AQuery.Sql.Add('  JOIN RDB$RELATION_CONSTRAINTS RC ON RC.RDB$INDEX_NAME = S.RDB$INDEX_NAME ');
      AQuery.Sql.Add('  JOIN RDB$REF_CONSTRAINTS REFC ON RC.RDB$CONSTRAINT_NAME = REFC.RDB$CONSTRAINT_NAME ');
      AQuery.Sql.Add('  JOIN RDB$RELATION_CONSTRAINTS RC2 ON RC2.RDB$CONSTRAINT_NAME = REFC.RDB$CONST_NAME_UQ ');
      AQuery.Sql.Add('  JOIN RDB$INDICES I2 ON I2.RDB$INDEX_NAME = RC2.RDB$INDEX_NAME ');
      AQuery.Sql.Add('  JOIN RDB$INDEX_SEGMENTS S2 ON I2.RDB$INDEX_NAME = S2.RDB$INDEX_NAME ');
      AQuery.Sql.Add('WHERE RC.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'' ');
      AQuery.Sql.Add('  AND TRIM(I.RDB$RELATION_NAME) = ' + QuotedStr(Trim(ATabela)));
      AQuery.Sql.Add('GROUP BY ');
      AQuery.Sql.Add('  RC.RDB$CONSTRAINT_NAME ');
      AQuery.Sql.Add('  ,REFC.RDB$UPDATE_RULE ');
      AQuery.Sql.Add('  ,REFC.RDB$DELETE_RULE ');
      AQuery.Sql.Add('  ,I2.RDB$RELATION_NAME ');
      AQuery.Sql.Add('  ,I.RDB$RELATION_NAME; ');
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TDM_Servidor.Listar_Generator(const AQuery: TFDQuery; const ATabela, AGenerator: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('  G.* ');
      AQuery.Sql.Add('FROM RDB$GENERATORS G ');
      AQuery.Sql.Add('WHERE G.RDB$SYSTEM_FLAG = 0 ');
      AQuery.Sql.Add('  AND POSITION('+QuotedStr(ATabela)+' IN G.RDB$GENERATOR_NAME) > 0; ');
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TDM_Servidor.Listar_Indices(const AQuery: TFDQuery; const ATabela, AIndice: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('  RI.* ');
      AQuery.Sql.Add('  ,RS.* ');
      AQuery.Sql.Add('  ,RS.RDB$INDEX_NAME ');
      AQuery.Sql.Add('  ,''CREATE INDEX '' || TRIM(RS.RDB$INDEX_NAME) || '' ON '' || TRIM(RI.RDB$RELATION_NAME) || '' ('' || TRIM(RS.RDB$FIELD_NAME) || '');'' AS INDICE_DESC ');
      AQuery.Sql.Add('FROM RDB$INDEX_SEGMENTS RS ');
      AQuery.Sql.Add('   RIGHT OUTER JOIN RDB$INDICES RI ON (RS.RDB$INDEX_NAME = RI.RDB$INDEX_NAME) ');
      AQuery.Sql.Add('WHERE RI.RDB$SYSTEM_FLAG = 0 ');
      AQuery.Sql.Add('  AND RI.RDB$UNIQUE_FLAG = 0 ');
      AQuery.Sql.Add('  AND TRIM(RI.RDB$RELATION_NAME) = ' + QuotedStr(Trim(ATabela)));
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TDM_Servidor.Listar_PrimaryKey(const AQuery: TFDQuery; const ATabela, APrimaryKey: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('  C.RDB$CONSTRAINT_NAME AS NOME ');
      AQuery.Sql.Add('  ,LIST(TRIM(S.RDB$FIELD_NAME)) AS CAMPOS ');
      AQuery.Sql.Add('  ,LIST(CASE F.RDB$FIELD_TYPE ');
      AQuery.Sql.Add('          WHEN 261 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':String = '''''''''' ');
      AQuery.Sql.Add('          WHEN  14 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':String = '''''''''' ');
      AQuery.Sql.Add('          WHEN  40 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':String = '''''''''' ');
      AQuery.Sql.Add('          WHEN  11 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':Double = 0'' ');
      AQuery.Sql.Add('          WHEN  27 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':Double = 0'' ');
      AQuery.Sql.Add('          WHEN  10 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':Double = 0'' ');
      AQuery.Sql.Add('          WHEN  16 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':Double = 0'' ');
      AQuery.Sql.Add('          WHEN   8 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':Integer = 0'' ');
      AQuery.Sql.Add('          WHEN   9 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':Integer = 0'' ');
      AQuery.Sql.Add('          WHEN   7 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':Integer = 0'' ');
      AQuery.Sql.Add('          WHEN  12 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':TDate = 0'' ');
      AQuery.Sql.Add('          WHEN  13 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':TTime = 0'' ');
      AQuery.Sql.Add('          WHEN  35 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':TTimeStamp = 0'' ');
      AQuery.Sql.Add('          WHEN  37 THEN ''A'' || TRIM(S.RDB$FIELD_NAME) || '':String = '''''''''' ');
      AQuery.Sql.Add('        END,''; '') AS CAMPOS_FILTRO ');
      AQuery.Sql.Add('  ,LIST(''l'' || TRIM(S.RDB$FIELD_NAME)) AS CAMPOS_LISTAR ');
      AQuery.Sql.Add('FROM RDB$RELATION_CONSTRAINTS C ');
      AQuery.Sql.Add('  JOIN RDB$INDEX_SEGMENTS S ON S.RDB$INDEX_NAME = C.RDB$INDEX_NAME ');
      AQuery.Sql.Add('  JOIN RDB$RELATION_FIELDS RF ON RF.RDB$FIELD_NAME = S.RDB$FIELD_NAME ');
      AQuery.Sql.Add('                             AND RF.RDB$RELATION_NAME = C.RDB$RELATION_NAME ');
      AQuery.Sql.Add('  JOIN RDB$FIELDS F ON F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE ');
      AQuery.Sql.Add('WHERE TRIM(C.RDB$RELATION_NAME) = ' + QuotedStr(Trim(ATabela)));
      AQuery.Sql.Add('  AND C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ');
      AQuery.Sql.Add('GROUP BY ');
      AQuery.Sql.Add('  C.RDB$CONSTRAINT_NAME; ');
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TDM_Servidor.Listar_Tabelas(const AQuery: TFDQuery; const ATabela: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('  R.* ');
      AQuery.Sql.Add('FROM RDB$RELATIONS R ');
      AQuery.Sql.Add('WHERE R.RDB$SYSTEM_FLAG = 0 ');
      if Trim(ATabela) <> '' then
        AQuery.Sql.Add('  AND TRIM(R.RDB$RELATION_NAME) = ' + Trim(ATabela));
      AQuery.Sql.Add('ORDER BY ');
      AQuery.Sql.Add('  R.RDB$RELATION_NAME; ');
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TDM_Servidor.Listar_Triggers(const AQuery: TFDQuery; const ATabela, ATrigger: String);
begin
  try
    try
      AQuery.Connection := FDC_Servidor;
      AQuery.Active := False;
      AQuery.Sql.Clear;
      AQuery.Sql.Add('SELECT ');
      AQuery.Sql.Add('  RT.* ');
      AQuery.Sql.Add('  ,CASE RT.RDB$TRIGGER_INACTIVE ');
      AQuery.Sql.Add('     WHEN 0 THEN ''ACTIVE '' ');
      AQuery.Sql.Add('     ELSE ''INACTIVE '' ');
      AQuery.Sql.Add('   END || ');
      AQuery.Sql.Add('   CASE RT.RDB$TRIGGER_TYPE ');
      AQuery.Sql.Add('     WHEN    1 THEN ''BEFORE INSERT'' ');
      AQuery.Sql.Add('     WHEN    2 THEN ''AFTER INSERT'' ');
      AQuery.Sql.Add('     WHEN    3 THEN ''BEFORE UPDATE'' ');
      AQuery.Sql.Add('     WHEN    4 THEN ''AFTER UPDATE'' ');
      AQuery.Sql.Add('     WHEN    5 THEN ''BEFORE DELETE'' ');
      AQuery.Sql.Add('     WHEN    6 THEN ''AFTER DELETE'' ');
      AQuery.Sql.Add('     WHEN   17 THEN ''BEFORE INSERT OR UPDATE'' ');
      AQuery.Sql.Add('     WHEN   18 THEN ''AFTER INSERT OR UPDATE'' ');
      AQuery.Sql.Add('     WHEN   25 THEN ''BEFORE INSERT OR DELETE'' ');
      AQuery.Sql.Add('     WHEN   26 THEN ''AFTER INSERT OR DELETE'' ');
      AQuery.Sql.Add('     WHEN   27 THEN ''BEFORE UPDATE OR DELETE'' ');
      AQuery.Sql.Add('     WHEN   28 THEN ''AFTER UPDATE OR DELETE'' ');
      AQuery.Sql.Add('     WHEN  113 THEN ''BEFORE INSERT OR UPDATE OR DELETE'' ');
      AQuery.Sql.Add('     WHEN  114 THEN ''AFTER INSERT OR UPDATE OR DELETE'' ');
      AQuery.Sql.Add('     WHEN 8192 THEN ''ON CONNECT'' ');
      AQuery.Sql.Add('     WHEN 8193 THEN ''ON DISCONNECT'' ');
      AQuery.Sql.Add('     WHEN 8194 THEN ''ON TRANSACTION START'' ');
      AQuery.Sql.Add('     WHEN 8195 THEN ''ON TRANSACTION COMMIT'' ');
      AQuery.Sql.Add('     WHEN 8196 THEN ''ON TRANSACTION ROLLBACK'' ');
      AQuery.Sql.Add('   END || '' POSITION '' || RT.RDB$TRIGGER_SEQUENCE AS DESC_TITULO ');
      AQuery.Sql.Add('FROM RDB$TRIGGERS RT ');
      AQuery.Sql.Add('WHERE RT.RDB$SYSTEM_FLAG = 0 ');
      AQuery.Sql.Add('  AND TRIM(RT.RDB$RELATION_NAME) = ' + QuotedStr(Trim(ATabela)) );
      AQuery.Active := True;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

end.
