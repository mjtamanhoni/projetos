unit uTab_RegTributario;

interface

uses windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, ExtCtrls, RzStatus, StdCtrls, DB, IBC, IBCScript, modulo, ShellApi,
     StrUtils, IniFiles,
     uWaitDialog;

type
  TEstrutura_Tab_RegTributario = class(TOBject)
  private
    FTotal :Integer;
    FPos :Integer;

    procedure Progresso_Rotina(AObjeto:String);
    procedure InternalUpdateProgress(const AObjeto: String);

    function FieldExists(iTabela,iField:String):Boolean;
    procedure ExecutaScript(iScript:WideString;sTabela:WideString='';sFiltro:WideString='');
    function ExecutaRecurso(iNome: String; iVersao: Integer): Boolean;
    function Trigger_Existe(const ATrigger:String):Boolean;
    function Tabela_Existe(const ATabela:String):Boolean;
    function Indice_Existe(const AIndice:String):Boolean;
    function Generator_Existe(const AGenerator:String):Boolean;
    procedure InsereRegistro(lSqlTxt,sTabela,sFiltro:String);

    //Scripts....
    procedure ALIQ_IBCCBS;
    procedure Cst_IBSCBS;
    procedure INTEGRACAO_FISCAL;
    procedure TIPO_OPERACAO;
    procedure PRODUTO_REGRA_FISCAL;
    procedure Alteracoes_Adapta;
    procedure UF_ICMS;
    procedure CCLASSTRIB_CBSIBS;
    procedure ANEXO_REDUCAO;
    procedure CST_CBSIBS;
    procedure Credito_Presumido;
    procedure NBS_CODIGO_SERVICO;
    procedure CORRELACAO_NFS_NBS_IBS_CBS;
    procedure NCM_CAP_SH_IBSCBS;
    procedure NCM_POS_SH4_IBSCBS;
    procedure NCM_SUBPOS_SH6_IBSCBS;
    procedure NCM_IBSCBS;
    procedure TIPO_OPERACAO_CFOP;


    //Cria arquivo .INI para baixar tabelas do governo...
    procedure Baixa_Tabelas;
    function LiberarDownload(AArq :String):Boolean;

    procedure Inserir_Registros;
    procedure Inserir_CST000;
    procedure Inserir_CST010;
    procedure Inserir_CST011;
    procedure Inserir_CST200;
    procedure Inserir_CST210;
    procedure Inserir_CST220;
    procedure Inserir_CST221;
    procedure Inserir_CST400;
    procedure Inserir_CST410;
    procedure Inserir_CST510;
    procedure Inserir_CST550;
    procedure Inserir_CST620;
    procedure Inserir_CST800;
    procedure Inserir_CST810;
    procedure Inserir_CST820;

    //UF_ICMS
    procedure UF_ICMS_AC;//ShowMessage('Acre');
    procedure UF_ICMS_AL;//ShowMessage('Alagoas');
    procedure UF_ICMS_AP;//ShowMessage('Amapá');
    procedure UF_ICMS_AM;//ShowMessage('Amazonas');
    procedure UF_ICMS_BA;//ShowMessage('Bahia');
    procedure UF_ICMS_CE;//ShowMessage('Ceará');
    procedure UF_ICMS_DF;//ShowMessage('Distrito Federal');
    procedure UF_ICMS_ES;//ShowMessage('Espírito Santo');
    procedure UF_ICMS_GO;//ShowMessage('Goiás');
    procedure UF_ICMS_MA;//ShowMessage('Maranhão');
    procedure UF_ICMS_MT;// ShowMessage('Mato Grosso');
    procedure UF_ICMS_MS;// ShowMessage('Mato Grosso do Sul');
    procedure UF_ICMS_MG;// ShowMessage('Minas Gerais');
    procedure UF_ICMS_PA;// ShowMessage('Pará');
    procedure UF_ICMS_PB;// ShowMessage('Paraíba');
    procedure UF_ICMS_PR;// ShowMessage('Paraná');
    procedure UF_ICMS_PE;// ShowMessage('Pernambuco');
    procedure UF_ICMS_PI;// ShowMessage('Piauí');
    procedure UF_ICMS_RJ;// ShowMessage('Rio de Janeiro');
    procedure UF_ICMS_RN;// ShowMessage('Rio Grande do Norte');
    procedure UF_ICMS_RS;// ShowMessage('Rio Grande do Sul');
    procedure UF_ICMS_RO;// ShowMessage('Rondônia');
    procedure UF_ICMS_RR;// ShowMessage('Roraima');
    procedure UF_ICMS_SC;// ShowMessage('Santa Catarina');
    procedure UF_ICMS_SP;// ShowMessage('São Paulo');
    procedure UF_ICMS_SE;// ShowMessage('Sergipe');
    procedure UF_ICMS_TO;// ShowMessage('Tocantins');

    procedure CClassTrib_CBSIBS_0;
    procedure CClassTrib_CBSIBS_2;
    procedure CClassTrib_CBSIBS_4;
    procedure CClassTrib_CBSIBS_5;
    procedure CClassTrib_CBSIBS_6;
    procedure CClassTrib_CBSIBS_8;
    procedure CClassTrib_CBSIBS_2_Update1;

    procedure Atualiza_Versao_QrCode;


  public
    procedure Executar;

    procedure Atualiza_UF_ICMS(AUF_Destino:String);
    procedure Baixa_Tabelas_Async;
    procedure Cancelar_Baixa_Tabelas;
  end;

implementation

uses Funcoes;

{ TEstrutura_Tab_RegTributario }

type
  TBaixaTabelasThread = class(TThread)
  private
    FEstrutura: TEstrutura_Tab_RegTributario;
    FObj: string;
    procedure DoSyncProgress;
  protected
    procedure Execute; override;
  public
    constructor Create(AEstrutura: TEstrutura_Tab_RegTributario);
    procedure SyncProgress(const AObjeto: string);
  end;

var
  GActiveBaixa: TBaixaTabelasThread;
  GBackgroundDownload: Boolean = False;

procedure TEstrutura_Tab_RegTributario.InternalUpdateProgress(const AObjeto: String);
begin
  FPos := (FPos + 1);
  WaitUpdateStatus(AObjeto);
  WaitUpdateProgress(FPos);
  WaitUpdateCount(FPos, FTotal);
  Application.ProcessMessages;
end;

procedure TEstrutura_Tab_RegTributario.Progresso_Rotina(AObjeto: String);
begin
  if Assigned(GActiveBaixa) then
    Exit
  else
    InternalUpdateProgress(AObjeto);
end;

procedure TEstrutura_Tab_RegTributario.Executar;
begin

  FTotal := 0;
  FPos := 0;
  FTotal := 27;

  WaitBegin('Atualizando banco de dados.',FTotal,False);

  ALIQ_IBCCBS;//1
  Cst_IBSCBS;//2
  INTEGRACAO_FISCAL;//3
  TIPO_OPERACAO;//4
  PRODUTO_REGRA_FISCAL;//5
  UF_ICMS;//6
  CCLASSTRIB_CBSIBS;//7
  ANEXO_REDUCAO;//8
  CST_CBSIBS;//9
  Credito_Presumido;//10
  NBS_CODIGO_SERVICO;//11
  CORRELACAO_NFS_NBS_IBS_CBS;//12
  NCM_CAP_SH_IBSCBS;//13
  NCM_POS_SH4_IBSCBS;//14
  NCM_SUBPOS_SH6_IBSCBS;//15
  NCM_IBSCBS;//16
  Inserir_Registros;//17
  Atualiza_Versao_QrCode;//18
  TIPO_OPERACAO_CFOP;//19

  Alteracoes_Adapta;//20
  //Baixar tabelas reforma tributária...
  // encerra o formulário de espera e inicia em segundo plano
  WaitEnd;
  Baixa_Tabelas_Async;
  Exit;

end;

constructor TBaixaTabelasThread.Create(AEstrutura: TEstrutura_Tab_RegTributario);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FEstrutura := TEstrutura_Tab_RegTributario.Create;
  Resume;
end;

procedure TBaixaTabelasThread.DoSyncProgress;
begin
  FEstrutura.InternalUpdateProgress(FObj);
end;

procedure TBaixaTabelasThread.SyncProgress(const AObjeto: string);
begin
  FObj := AObjeto;
  Synchronize(DoSyncProgress);
end;

procedure TBaixaTabelasThread.Execute;
begin
  GBackgroundDownload := True;
  try
    FEstrutura.Baixa_Tabelas;
  finally
    GBackgroundDownload := False;
    FEstrutura.Free;
    GActiveBaixa := nil;
  end;
end;

procedure TEstrutura_Tab_RegTributario.Baixa_Tabelas_Async;
begin
  if Assigned(GActiveBaixa) then Exit;
  GActiveBaixa := TBaixaTabelasThread.Create(Self);
end;

procedure TEstrutura_Tab_RegTributario.Cancelar_Baixa_Tabelas;
begin
  if Assigned(GActiveBaixa) then
    GActiveBaixa.Terminate;
end;

function TEstrutura_Tab_RegTributario.ExecutaRecurso(iNome: String; iVersao: Integer): Boolean;
var
  lQry:TIBCQuery;
  lSqlTxt : String;
begin
  if GBackgroundDownload then
  begin
    Result := True;
    Exit;
  end;
  try
    lQry:=TIBCQuery.Create(Application);
    try
      lQry.Connection := frmmodulo.conexao;
      lQry.SQL.Text   := 'Select VERSAO from ADM999 where Upper(NOME) =:NOME';
      lQry.ParamByName('NOME').AsString := UpperCase(iNome);
      lQry.Open;

      Result := lQry.FieldByName('VERSAO').AsInteger < iVersao;

      lSqlTxt := 'update or insert into ADM999 (NOME,VERSAO,DATA) values ('+QuotedStr(UpperCase(iNome))+','+IntToStr(iVersao)+','+QuotedStr(FormatDateTime('dd.mm.yyyy',Date))+');';
      if Result then
        ExecutaScript(lSqlTxt);

    finally
      FreeAndNil(lQry);
    end;
  except
    Result := false;
  end;
end;

procedure TEstrutura_Tab_RegTributario.ExecutaScript(iScript, sTabela, sFiltro: WideString);
var
  lQry     :TIBCScript;
  qrFiltro :TIBCQuery;
  sErro    :TStringList;
  lPasta_sistema:String;
begin
  try
    lQry     := TIBCScript.Create(Application);
    qrFiltro := TIBCQuery.Create(Application);
    try
      lQry.Connection     := frmmodulo.conexao;

      //Verifica se possui um filtro, caso possua esse será um scritp de inclusão de registro no banco.
      //Caso possua filtro, será realizado um filtro no banco para ver se o registro já foi inserido, caso já tenha sido inserido a rotina será finalizada.
      qrFiltro.Connection := frmmodulo.conexao;
      if ((sTabela <> '') and (sFiltro <> '')) then
      begin
        qrFiltro.Close;
        qrFiltro.SQL.Clear;
        qrFiltro.SQL.Add(' SELECT * FROM ' + sTabela + ' WHERE ' + sFiltro);
        qrFiltro.Open;
        if not qrFiltro.IsEmpty then
          Exit;
      end;

      lQry.SQL.Text   := iScript;
      lQry.SQL.SaveToFile(ExtractFilePath(Application.ExeName) + 'Executa_Script.sql');
      lQry.Execute;
      lQry.Transaction.CommitRetaining;
    except
      on E : Exception do
      begin
        lPasta_sistema := ExtractFilePath(Application.ExeName);
        sErro := TStringList.Create;
        try
          ShowMessage(e.Message);
          sErro.Clear;
          sErro.Add('Erro ao executar Script');
          sErro.Add(' ');
          sErro.Add(' ');
          sErro.Add('Script: ');
          sErro.Add(iScript);
          sErro.Add(' ');
          sErro.Add(' ');
          sErro.Add('Erro original: ' + e.Message);
          sErro.SaveToFile(lPasta_sistema + '\Erro_Criar_SB_'+FormatDateTime('DDMMYYYYHHMMSS',Now)+'.txt');
        finally
          FreeAndNil(sErro);
          FreeAndNil(qrFiltro);
        end;
        lQry.Transaction.RollbackRetaining;
      end;
    end;
  finally
    FreeAndNil(lQry);
    FreeAndNil(qrFiltro);
  end;
end;

function TEstrutura_Tab_RegTributario.FieldExists(iTabela,iField: String): Boolean;
var
  lQry:TIBCQuery;
begin
  try
    Result := False;
    lQry:=TIBCQuery.Create(Application);
    try
      lQry.Connection := frmmodulo.conexao;

      begin
        lQry.Close;
        lQry.Sql.Clear;
        lQry.Sql.Add(' SELECT RDB$FIELD_NAME FROM RDB$RELATION_FIELDS');
        lQry.Sql.Add(' WHERE UPPER(RDB$FIELD_NAME) = ' + QuotedStr(UpperCase(iField)));
        lQry.Sql.Add('   AND UPPER(RDB$RELATION_NAME) = ' + QuotedStr(UpperCase(iTabela)));
        lQry.Open;
        if not lQry.IsEmpty then
          Result := True;
      end;

      //lQry.SQL.Text   := 'Select '+iField+' from '+iTabela;
      //lQry.Open;
      //Result := true;

    finally
      lQry.Transaction.CommitRetaining;
      lQry.Close;
      FreeAndNil(lQry);
    end;
  except
    Result := false;
  end;
end;

function TEstrutura_Tab_RegTributario.Indice_Existe( const AIndice: String): Boolean;
var
  lQry:TIBCQuery;
begin
  Result := False;
  try
    lQry:=TIBCQuery.Create(Application);
    lQry.Connection := frmmodulo.conexao;

    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add('SELECT * FROM RDB$INDICES WHERE RDB$INDEX_NAME = ' + QuotedStr(AIndice));
    lQry.Open;
    Result := (not lQry.IsEmpty);
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TEstrutura_Tab_RegTributario.InsereRegistro(lSqlTxt, sTabela, sFiltro: String);
var
  qrInserir :TIBCQuery;
  Inserir   :Boolean;
begin
  try
    Inserir := False;
    qrInserir := TIBCQuery.Create(Application);
    try
      with qrInserir do
      begin
        Connection := frmmodulo.conexao;
        Close;
        Sql.Clear;
        Sql.Add('SELECT * FROM ' + sTabela + ' ' + sFiltro);
        Open;
        Inserir := (IsEmpty);
        if Inserir then
        begin
          Close;
          Sql.Clear;
          Sql.Add(lSqlTxt);
          ExecSQL;
        end;
      end;
    finally
      FreeAndNil(qrInserir);
    end;
  except
    on E : Exception do
    begin
      //
    end;
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST000;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Inserindo Registros: Inserir_CST000');//2
  sSqlTxt := TStringList.Create;

  //Descontinuado...
  Exit;

  try
    try
      //sSqlTxt.Clear;
      //sSqlTxt.Add('');
      //ExecutaScript(sSqlTxt.Text);

      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''000'',''Tributação integral'',''000001'',''Situações tributadas integralmente pelo IBS e CBS.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''000'',''Tributação integral'',''000002'',''Exploração de via, observado o art. 11 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''000'',''Tributação integral'',''000003'',''Regime automotivo - projetos incentivados, observado o art. 311 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''000'',''Tributação integral'',''000004'',''Regime automotivo - projetos incentivados, observado o art. 312 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);

    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;

end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST010;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''010'',''Tributação com alíquotas uniformes - operações do FGTS'',''010001'',''Operações do FGTS não realizadas pela Caixa Econômica Federal, observado o art. 212 da');
      sSqlTxt.Add('  Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST011;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''011'',''Tributação com alíquotas uniformes reduzidas em 60%'',''011001'',''Planos de assistência funerária, observado o art. 236 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''011'',''Tributação com alíquotas uniformes reduzidas em 60%'',''011002'',''Planos de assistência à saúde, observado o art. 237 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''011'',''Tributação com alíquotas uniformes reduzidas em 60%'',''011003'',''Intermediação de planos de assistência à saúde, observado o art. 240 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''011'',''Tributação com alíquotas uniformes'',''011004'',''Concursos e prognósticos, observado o art. 246 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''011'',''Tributação com alíquotas uniformes reduzidas em 30%'',''011005'',''Planos de assistência à saúde de animais domésticos, observado o art. 243 da Lei Complementar nº 214,');
      sSqlTxt.Add('  de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST200;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200001'',''Aquisições de máquinas, de aparelhos, de instrumentos, de equipamentos, de matérias-primas, de produtos intermediários e de materiais');
      sSqlTxt.Add('  de embalagem realizadas entre empresas autorizadas a operar em zonas de processamento de exportação, observado o art. 103 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200002'',''Fornecimento ou importação de tratores, máquinas e implementos agrícolas, destinados a produtor rural não contribuinte, e de veículos de transporte');
      sSqlTxt.Add('  de carga destinados a transportador autônomo de carga pessoa física não contribuinte, observado o art. 110 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200003'',''Vendas de produtos destinados à alimentação humana relacionados no Anexo I da Lei Complementar nº 214, de 2025, com a especificação das');
      sSqlTxt.Add('  respectivas classificações da NCM/SH, que compõem a Cesta Básica Nacional de Alimentos, criada nos termos do art. 8º da Emenda Constitucional nº 132, de 20 de dezembro de 2023, observado');
      sSqlTxt.Add('  o art. 125 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200004'',''Venda de dispositivos médicos com a especificação das respectivas classificações da NCM/SH previstas no Anexo XII da Lei Complementar nº 214, de');
      sSqlTxt.Add('  2025, observado o art. 144 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200005'',''Venda de dispositivos médicos com a especificação das respectivas classificações da NCM/SH previstas no Anexo IV da Lei Complementar nº 214, de');
      sSqlTxt.Add('  2025, quando adquiridos por órgãos da administração pública direta, autarquias e fundações públicas, observado o art. 144 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200006'',''Situação de emergência de saúde pública reconhecida pelo Poder Legislativo federal, estadual, distrital ou municipal competente,');
      sSqlTxt.Add('  ato conjunto do Ministro da Fazenda e do Comitê Gestor do IBS poderá ser editado, a qualquer momento, para incluir dispositivos não listados no Anexo XIII da Lei Complementar nº 214,');
      sSqlTxt.Add('  de 2025, limitada a vigência do benefício ao período e à localidade da emergência de saúde pública, observado o art. 144 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200007'',''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência relacionados no Anexo XIV da Lei Complementar nº 214,');
      sSqlTxt.Add('  de 2025, com a especificação das respectivas classificações da NCM/SH, observado o art. 145 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200008'',''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência relacionados no Anexo V da Lei Complementar nº 214, de');
      sSqlTxt.Add('  2025, com a especificação das respectivas classificações da NCM/SH, quando adquiridos por órgãos da administração pública direta, autarquias, fundações públicas e entidades imunes,');
      sSqlTxt.Add('  observado o art. 145 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200009'',''Fornecimento dos medicamentos relacionados no Anexo XIV da Lei Complementar nº 214, de 2025, com a especificação das respectivas');
      sSqlTxt.Add('  classificações da NCM/SH, observado o art. 146 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200010'',''Fornecimento dos medicamentos registrados na Anvisa, quando adquiridos por órgãos da administração pública direta, autarquias, fundações');
      sSqlTxt.Add('  públicas e entidades imunes, observado o art. 146 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200011'',''Fornecimento das composições para nutrição enteral e parenteral, composições especiais e fórmulas nutricionais destinadas às pessoas');
      sSqlTxt.Add('  com erros inatos do metabolismo relacionadas no Anexo VI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NCM/SH, quando adquiridas por órgãos');
      sSqlTxt.Add('  da administração pública direta, autarquias e fundações públicas, observado o art. 146 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200012'',''Situação de emergência de saúde pública reconhecida pelo Poder Legislativo federal, estadual, distrital ou municipal competente,');
      sSqlTxt.Add('  ato conjunto do Ministro da Fazenda e do Comitê Gestor do IBS poderá ser editado, a qualquer momento, para incluir dispositivos não listados no Anexo XIV da Lei Complementar nº 214, de');
      sSqlTxt.Add('  2025, limitada a vigência do benefício ao período e à localidade da emergência de saúde pública, observado o art. 146 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200013'',''Fornecimento de tampões higiênicos, absorventes higiênicos internos ou externos, descartáveis ou reutilizáveis, calcinhas absorventes e');
      sSqlTxt.Add('  coletores menstruais, observado o art. 147 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200014'',''Fornecimento dos produtos hortícolas, frutas e ovos, relacionados no Anexo XV da Lei Complementar nº 214 , de 2025, com a especificação');
      sSqlTxt.Add('  das respectivas classificações da NCM/SH e desde que não cozidos, observado o art. 148 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200015'',''Venda de automóveis de passageiros de fabricação nacional de, no mínimo, 4 (quatro) portas, inclusive a de acesso ao bagageiro, quando adquiridos');
      sSqlTxt.Add('  por motoristas profissionais que exerçam, comprovadamente, em automóvel de sua propriedade, atividade de condutor autônomo de passageiros, na condição de titular de autorização, permissão');
      sSqlTxt.Add('  ou concessão do poder público, e que destinem o automóvel à utilização na categoria de aluguel (táxi), ou por pessoas com deficiência física, visual, auditiva, deficiência mental severa ou');
      sSqlTxt.Add('  profunda, transtorno do espectro autista, com prejuízos na comunicação social e em padrões restritos ou repetitivos de comportamento de nível moderado ou grave, nos termos da legislação');
      sSqlTxt.Add('  relativa à matéria, observado o disposto no art. 149 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200016'',''Prestação de serviços de pesquisa e desenvolvimento por Instituição Científica, Tecnológica e de Inovação (ICT) sem fins lucrativos para a administração');
      sSqlTxt.Add('  pública direta, autarquias e fundações públicas ou para o contribuinte sujeito ao regime regular do IBS e da CBS, observado o disposto no art. 156  da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200017'',''Operações relacionadas ao FGTS, considerando aquelas necessárias à aplicação da Lei nº 8.036, de 1990, realizadas pelo Conselho Curador ou');
      sSqlTxt.Add('  Secretaria Executiva do FGTS, observado o art. 212 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200018'',''Operações de resseguro e retrocessão ficam sujeitas à incidência à alíquota zero, inclusive quando os prêmios de resseguro e retrocessão');
      sSqlTxt.Add('  forem cedidos ao exterior, observado o art. 223 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200019'',''Importador dos serviços financeiros seja contribuinte que realize as operações de que tratam os incisos I a V do caput do art. 182, será');
      sSqlTxt.Add('  aplicada alíquota zero na importação, sem prejuízo da manutenção do direito de dedução dessas despesas da base de cálculo do IBS e da CBS, segundo, observado o art. 231 da Lei Complementar');
      sSqlTxt.Add('  nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200020'',''Operação praticada por sociedades cooperativas optantes por regime específico do IBS e CBS, quando o associado destinar bem ou serviço à cooperativa');
      sSqlTxt.Add('  de que participa, e a cooperativa fornecer bem ou serviço ao associado sujeito ao regime regular do IBS e da CBS, observado o art. 271 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200021'',''Serviços de transporte público coletivo de passageiros ferroviário e hidroviário urbanos, semiurbanos e metropolitanos, observado o art.');
      sSqlTxt.Add('  285 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200022'',''Operação originada fora da Zona Franca de Manaus que destine bem material industrializado de origem nacional a contribuinte estabelecido');
      sSqlTxt.Add('  na Zona Franca de Manaus que seja habilitado nos termos do art. 442 da Lei Complementar nº 214, de 2025, e sujeito ao regime regular do IBS e da CBS ou optante pelo regime do Simples Nacional');
      sSqlTxt.Add('  de que trata o art. 12 da Lei Complementar nº 123, de 2006, observado o art. 445 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200023'',''Operação realizada por indústria incentivada que destine bem material intermediário para outra indústria incentivada na Zona Franca de Manaus,');
      sSqlTxt.Add('  desde que a entrega ou disponibilização dos bens ocorra dentro da referida área, observado o art. 448 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero'',''200024'',''Operação originada fora das Áreas de Livre Comércio que destine bem material industrializado de origem nacional a contribuinte estabelecido nas Áreas');
      sSqlTxt.Add('  de Livre Comércio que seja habilitado nos termos do art. 456 da Lei Complementar nº 214, de 2025, e sujeito ao regime regular do IBS e da CBS ou optante pelo regime do Simples Nacional de que trata');
      sSqlTxt.Add('  o art. 12 da Lei Complementar nº 123, de 2006, observado o art. 463 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota zero apenas CBS e reduzida em 60% para IBS'',''200025'',''Fornecimento dos serviços de educação relacionados ao Programa Universidade para Todos (Prouni), instituído pela');
      sSqlTxt.Add('  Lei nº 11.096, de 13 de janeiro de 2005, observado o art. 308 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 80%'',''200026'',''Locação de imóveis localizados nas zonas reabilitadas, pelo prazo de 5 (cinco) anos, contado da data de expedição do habite-se, e relacionados');
      sSqlTxt.Add('  a projetos de reabilitação urbana de zonas históricas e de áreas críticas de recuperação e reconversão urbanística dos Municípios ou do Distrito Federal, a serem delimitadas por lei municipal ou');
      sSqlTxt.Add('  distrital, observado o art. 158 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 70%'',''200027'',''Operações de locação, cessão onerosa e arrendamento de bens imóveis, observado o art. 261 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200028'',''Fornecimento dos serviços de educação relacionados no Anexo II da Lei Complementar nº 214, de 2025, com a especificação das respectivas');
      sSqlTxt.Add('  classificações da Nomenclatura Brasileira de Serviços, Intangíveis e Outras Operações que Produzam Variações no Patrimônio (NBS), observado o art. 129 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200029'',''Fornecimento dos serviços de saúde humana relacionados no Anexo III da Lei Complementar nº 214, de 2025, com a especificação das respectivas');
      sSqlTxt.Add('  classificações da NBS, observado o art. 130 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200030'',''Venda dos dispositivos médicos relacionados no Anexo IV da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações');
      sSqlTxt.Add('  da NCM/SH, observado o art. 131 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200031'',''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência relacionados no Anexo V da Lei Complementar nº 214,');
      sSqlTxt.Add('  de 2025, com a especificação das respectivas classificações da NCM/SH, observado o art. 132 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200032'',''Fornecimento dos medicamentos registrados na Anvisa ou produzidos por farmácias de manipulação, ressalvados os medicamentos sujeitos à alíquota');
      sSqlTxt.Add('  zero de que trata o art. 141 da Lei Complementar nº 214, de 2025, observado o art. 133 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200033'',''Fornecimento das composições para nutrição enteral e parenteral, composições especiais e fórmulas nutricionais destinadas às pessoas com');
      sSqlTxt.Add('  erros inatos do metabolismo relacionadas no Anexo VI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NCM/SH, observado o art. 133 da Lei Complementar nº');
      sSqlTxt.Add('  214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200034'',''Fornecimento dos alimentos destinados ao consumo humano relacionados no Anexo VII da Lei Complementar nº 214, de 2025, com a especificação');
      sSqlTxt.Add('  das respectivas classificações da NCM/SH, observado o art. 135 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200035'',''Fornecimento dos produtos de higiene pessoal e limpeza relacionados no Anexo VIII da Lei Complementar nº 214, de 2025, com a especificação');
      sSqlTxt.Add('  das respectivas classificações da NCM/SH, observado o art. 136 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200036'',''Fornecimento de produtos agropecuários, aquícolas, pesqueiros, florestais e extrativistas vegetais in natura, observado o art. 137 da Lei');
      sSqlTxt.Add('  Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200037'',''Fornecimento de serviços ambientais de conservação ou recuperação da vegetação nativa, mesmo que fornecidos sob a forma de manejo sustentável');
      sSqlTxt.Add('  de sistemas agrícolas, agroflorestais e agrossilvopastoris, em conformidade com as definições e requisitos da legislação específica, observado o art. 137 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200038'',''Fornecimento dos insumos agropecuários e aquícolas relacionados no Anexo IX da Lei Complementar nº 214, de 2025, com a especificação das');
      sSqlTxt.Add('  respectivas classificações da NCM/SH e da NBS, observado o art. 138 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200039'',''Fornecimento dos serviços e o licenciamento ou cessão dos direitos relacionados no Anexo X da Lei Complementar nº 214, de 2025, com a');
      sSqlTxt.Add('  especificação das respectivas classificações da NBS, quando destinados às seguintes produções nacionais artísticas, culturais, de eventos, jornalísticas e audiovisuais: espetáculos teatrais, circenses');
      sSqlTxt.Add('  e de dança, shows musicais, desfiles carnavalescos ou folclóricos, eventos acadêmicos e científicos, como congressos, conferências e simpósios, feiras de negócios, exposições, feiras e mostras culturais,');
      sSqlTxt.Add('  artísticas e literárias; programas de auditório ou jornalísticos, filmes, documentários, séries, novelas, entrevistas e clipes musicais, observado o art. 139 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200040'',''Fornecimento dos seguintes serviços de comunicação institucional à administração pública direta, autarquias e fundações públicas: serviços');
      sSqlTxt.Add('  direcionados ao planejamento, criação, programação e manutenção de páginas eletrônicas da administração pública, ao monitoramento e gestão de suas redes sociais e à otimização de páginas e canais');
      sSqlTxt.Add('  digitais para mecanismos de buscas e produção de mensagens, infográficos, painéis interativos e conteúdo institucional, serviços de relações com a imprensa, que reúnem estratégias organizacionais');
      sSqlTxt.Add('  para promover e reforçar a comunicação dos órgãos e das entidades contratantes com seus públicos de interesse, por meio da interação com profissionais da imprensa, e serviços de relações públicas,');
      sSqlTxt.Add('  que compreendem o esforço de comunicação planejado, coeso e contínuo que tem por objetivo estabelecer adequada percepção da atuação e dos objetivos institucionais, a partir do estímulo à compreensão');
      sSqlTxt.Add('  mútua e da manutenção de padrões de relacionamento e fluxos de informação entre os órgãos e as entidades contratantes e seus públicos de interesse, no País e no exterior, observado o art. 140 da');
      sSqlTxt.Add('  Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200041'',''Operações relacionadas às seguintes atividades desportivas: fornecimento de serviço de educação desportiva, classificado no código 1.2205.12.00');
      sSqlTxt.Add('  da NBS, e gestão e exploração do desporto por associações e clubes esportivos filiados ao órgão estadual ou federal responsável pela coordenação dos desportos, inclusive por meio de venda de ingressos');
      sSqlTxt.Add('  para eventos desportivos, fornecimento oneroso ou não de bens e serviços, inclusive ingressos, por meio de programas de sócio-torcedor, cessão dos direitos desportivos dos atletas e transferência de');
      sSqlTxt.Add('  atletas para outra entidade desportiva ou seu retorno à atividade em outra entidade desportiva, observado o art. 141 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200042'',''Operações relacionadas ao fornecimento de serviço de educação desportiva, classificado no código 1.2205.12.00 da NBS, observado o art. 141 da');
      sSqlTxt.Add('  Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200043'',''Fornecimento à administração pública direta, autarquias e fundações púbicas dos serviços e dos bens relativos à soberania e à segurança nacional,');
      sSqlTxt.Add('  à segurança da informação e à segurança cibernética relacionados no Anexo XI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NBS e da NCM/SH, observado o art.');
      sSqlTxt.Add('  142 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200044'',''Operações e prestações de serviços de segurança da informação e segurança cibernética desenvolvidos por sociedade que tenha sócio brasileiro');
      sSqlTxt.Add('  com o mínimo de 20% (vinte por cento) do seu capital social, relacionados no Anexo XI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NBS e da NCM/SH, observado');
      sSqlTxt.Add('  o art. 142 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 60%'',''200045'',''Operações relacionadas a projetos de reabilitação urbana de zonas históricas e de áreas críticas de recuperação e reconversão urbanística dos');
      sSqlTxt.Add('  Municípios ou do Distrito Federal, a serem delimitadas por lei municipal ou distrital, observado o art. 158 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 50%'',''200046'',''Operações com bens imóveis, observado o art. 261 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 40%'',''200047'',''Bares e Restaurantes, observado o art. 275 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 40%'',''200048'',''Hotelaria, Parques de Diversão e Parques Temáticos, observado o art. 281 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 40%'',''200049'',''Transporte coletivo de passageiros rodoviário, ferroviário e hidroviário intermunicipais e interestaduais, observado o art. 286 da Lei Complementar');
      sSqlTxt.Add('  nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 40%'',''200450'',''Serviços de transporte aéreo regional coletivo de passageiros ou de carga, observado o art. 287 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 40%'',''200051'',''Agências de Turismo, observado o art. 289 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''200'',''Alíquota reduzida em 30%'',''200052'',''Prestação de serviços das seguintes profissões intelectuais de natureza científica, literária ou artística, submetidas à fiscalização por');
      sSqlTxt.Add('  conselho profissional: administradores, advogados, arquitetos e urbanistas, assistentes sociais, bibliotecários, biólogos, contabilistas, economistas, economistas domésticos, profissionais de educação');
      sSqlTxt.Add('  física, engenheiros e agrônomos, estatísticos, médicos veterinários e zootecnistas, museólogos, químicos, profissionais de relações públicas, técnicos industriais e técnicos agrícolas, observado o');
      sSqlTxt.Add('  art. 127 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST210;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''210'',''Alíquota reduzida em 50% com redutor de base de cálculo'',''210001'',''Redutor social aplicado uma única vez na alienação de bem imóvel residencial novo, observado o art. 259 da Lei');
      sSqlTxt.Add('  Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''210'',''Alíquota reduzida em 50% com redutor de base de cálculo'',''210002'',''Redutor social aplicado uma única vez na alienação de lote residencial, observado o art. 259 da Lei Complementar');
      sSqlTxt.Add('  nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''210'',''Alíquota reduzida em 70% com redutor de base de cálculo'',''210003'',''Redutor social em operações de locação, cessão onerosa e arrendamento de bens imóveis de uso residencial,');
      sSqlTxt.Add('  observado o art. 260 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST220;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''220'',''Alíquota fixa'',''220001'',''Incorporação imobiliária submetida ao regime especial de tributação, observado o art. 485 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''220'',''Alíquota fixa'',''220002'',''Incorporação imobiliária submetida ao regime especial de tributação, observado o art. 485 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''220'',''Alíquota fixa'',''220003'',''Alienação de imóvel decorrente de parcelamento do solo, observado o art. 486 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST221;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''221'',''Alíquota fixa proporcional'',''221001'',''Locação, cessão onerosa ou arrendamento de bem imóvel com alíquota sobre a receita bruta, observado o art. 487 da Lei Complementar nº 214,');
      sSqlTxt.Add('  de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST400;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''400'',''Isenção'',''400001'',''Fornecimento de serviços de transporte público coletivo de passageiros rodoviário e metroviário de caráter urbano, semiurbano e metropolitano, sob regime');
      sSqlTxt.Add('  de autorização, permissão ou concessão pública, observado o art. 157 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST410;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410001'',''Fornecimento de bonificações quando constem do respectivo documento fiscal e que não dependam de evento posterior, observado o art. 5º');
      sSqlTxt.Add('  da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410002'',''Transferências entre estabelecimentos pertencentes ao mesmo contribuinte, observado o art. 6º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410003'',''Doações, observado o art. 6º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410004'',''Exportações de bens e serviços, observado o art. 8º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410005'',''Fornecimentos realizados pela União, pelos Estados, pelo Distrito Federal e pelos Municípios, observado o art. 9º da Lei Complementar');
      sSqlTxt.Add('  nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410006'',''Fornecimentos realizados por entidades religiosas e templos de qualquer culto, inclusive suas organizações assistenciais e beneficentes,');
      sSqlTxt.Add('  observado o art. 9º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410007'',''Fornecimentos realizados por partidos políticos, inclusive suas fundações, entidades sindicais dos trabalhadores e instituições de educação e');
      sSqlTxt.Add('  de assistência social, sem fins lucrativos, observado o art. 9º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410008'',''Fornecimentos de livros, jornais, periódicos e do papel destinado a sua impressão, observado o art. 9º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410009'',''Fornecimentos de fonogramas e videofonogramas musicais produzidos no Brasil contendo obras musicais ou literomusicais de autores brasileiros');
      sSqlTxt.Add('  e/ou obras em geral interpretadas por artistas brasileiros, bem como os suportes materiais ou arquivos digitais que os contenham, salvo na etapa de replicação industrial de mídias ópticas de leitura a');
      sSqlTxt.Add('  laser, observado o art. 9º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410010'',''Fornecimentos de serviço de comunicação nas modalidades de radiodifusão sonora e de sons e imagens de recepção livre e  gratuita, observado o');
      sSqlTxt.Add('  art. 9º da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410011'',''Fornecimentos de ouro, quando definido em lei como ativo financeiro ou instrumento cambial, observado o art. 9º da Lei Complementar nº 214,');
      sSqlTxt.Add('  de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410012'',''Fornecimento de condomínio edilício não optante pelo regime regular, observado o art. 26 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410013'',''Exportações de combustíveis, observado o art. 98 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410014'',''Fornecimento de produtor rural não contribuinte, observado o art. 164 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410015'',''Fornecimento por transportador autônomo não contribuinte, observado o art. 169 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410016'',''Fornecimento ou aquisição de resíduos sólidos, observado o art. 170 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410017'',''Aquisição de bem móvel com crédito presumido sob condição de revenda realizada, observado o art. 171 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410018'',''Operações relacionadas aos fundos garantidores e executores de políticas públicas, inclusive de habitação, previstos em lei, assim entendidas os');
      sSqlTxt.Add('  serviços prestados ao fundo pelo seu agente operador e por entidade encarregada da sua administração, observado o art. 213 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410019'',''Exclusão da gorjeta na base de cálculo no fornecimento de alimentação, observado o art. 274 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''410'',''Imunidade e não incidência'',''410020'',''Exclusão do valor de intermediação na base de cálculo no fornecimento de alimentação, observado o art. 274 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST510;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''510'',''Diferimento'',''510001'',''Operações, sujeitas a diferimento, com energia elétrica ou com direitos a ela relacionados, relativas à geração, comercialização, distribuição e transmissão,');
      sSqlTxt.Add('  observado o art. 28 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''510'',''Diferimento'',''510002'',''Operações, sujeitas a diferimento, com insumos agropecuários e aquícolas destinados a produtor rural contribuinte, observado o art. 138 da Lei Complementar nº 214,');
      sSqlTxt.Add('  de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST550;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550001'',''Exportações de bens materiais, observado o art. 82 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550002'',''Regime de Trânsito, observado o art. 84 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550003'',''Regimes de Depósito, observado o art. 85 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550004'',''Regimes de Depósito, observado o art. 87 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550005'',''Regimes de Depósito, observado o art. 87 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550006'',''Regimes de Permanência Temporária, observado o art. 88 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550007'',''Regimes de Aperfeiçoamento, observado o art. 90 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550008'',''Importação de bens para o Regime de Repetro-Temporário, de que tratam o inciso I do art. 93 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550009'',''GNL-Temporário, de que trata o inciso II do art. 93 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550010'',''Repetro-Permanente, de que trata o inciso III do art. 93 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550011'',''Repetro-Industrialização, de que trata o inciso IV do art. 93 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550012'',''Repetro-Nacional, de que trata o inciso V do art. 93 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550013'',''Repetro-Entreposto, de que trata o inciso VI do art. 93 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550014'',''Zona de Processamento de Exportação, observado os arts. 99, 100 e 102 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550015'',''Regime Tributário para Incentivo à Modernização e à Ampliação da Estrutura Portuária - Reporto, observado o art. 105 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550016'',''Regime Especial de Incentivos para o Desenvolvimento da Infraestrutura - Reidi, observado o art. 106 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550017'',''Regime Tributário para Incentivo à Atividade Econômica Naval – Renaval, observado o art. 107 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550018'',''Desoneração da aquisição de bens de capital, , observado o art. 109 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550019'',''Importação de bem material por indústria incentivada para utilização na Zona Franca de Manaus, observado o art. 443 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''550'',''Suspensão'',''550020'',''Áreas de livre comércio, observado o art. 461 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST620;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''620'',''Tributação monofásica'',''620001'',''Tributação monofásica sobre combustíveis, observados os art. 172 e   art. 179 I da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''620'',''Tributação monofásica'',''620002'',''Tributação monofásica com responsabilidade pela retenção sobre combustíveis, observado o art. 178 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''620'',''Tributação monofásica'',''620003'',''Tributação monofásica com tributos retidos por responsabilidade sobre combustíveis, observado o art. 178 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''620'',''Tributação monofásica'',''620004'',''Tributação monofásica sobre mistura de EAC com gasolina A em percentual superior ou inferior ao obrigatório, observado o art. 179 da Lei Complementar');
      sSqlTxt.Add('  nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''620'',''Tributação monofásica'',''620005'',''Tributação monofásica sobre combustíveis cobrada anteriormente, observador o art. 180 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST800;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''800'',''Transferência de crédito'',''800001'',''Fusão, cisão ou incorporação, observado o art. 55 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''800'',''Transferência de crédito'',''800002'',''Transferência de crédito do associado, inclusive as cooperativas singulares, para cooperativa de que participa das operações antecedentes às operações');
      sSqlTxt.Add('  em que fornece bens e serviços e os créditos presumidos, observado o art. 272 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST810;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''810'',''Ajustes'',''810001'',''Crédito presumido sobre o valor apurado nos fornecimentos a partir da Zona Franca de Manaus, observado o art. 450 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Inserir_CST820;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    try
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''820'',''Tributação em declaração de regime específico'',''820001'',''Documento com informações de fornecimento de serviços de planos de assinstência à saúde, mas com tributação realizada por');
      sSqlTxt.Add('  outro meio, observado o art. 235 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''820'',''Tributação em declaração de regime específico'',''820002'',''Documento com informações de fornecimento de serviços de planos de assinstência funerária, mas com tributação realizada por');
      sSqlTxt.Add('  outro meio, observado o art. 236 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''820'',''Tributação em declaração de regime específico'',''820003'',''Documento com informações de fornecimento de serviços de planos de assinstência à saúde de animais domésticos, mas com');
      sSqlTxt.Add('  tributação realizada por outro meio, observado o art. 243 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''820'',''Tributação em declaração de regime específico'',''820004'',''Documento com informações de prestação de serviços de consursos de prognósticos, mas com tributação realizada por outro meio,');
      sSqlTxt.Add('  observado o art. 248 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
      sSqlTxt.Clear;
      sSqlTxt.Add('INSERT INTO Cst_IBSCBS (CODIGO, STATUS, CST, CST_DESC, C_CLASS_TRIB, C_CLASS_TRIB_DESC, EC, USUARIO_CAD) VALUES (');
      sSqlTxt.Add('  NULL, 1, ''820'',''Tributação em declaração de regime específico'',''820005'',''Documento com informações de alienação de bens imóveis, mas com tributação realizada por outro meio,, observado o art.');
      sSqlTxt.Add('  254 da Lei Complementar nº 214, de 2025.'',NULL,1);');
      ExecutaScript(sSqlTxt.Text);
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(sSqlTxt);
  end;
end;

procedure TEstrutura_Tab_RegTributario.ALIQ_IBCCBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: ALIQ_IBCCBS');//1

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('REFTRIB_001','CODIGO') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE REFTRIB_001 ( ');
      sSqlTxt.Add('    CODIGO        INTEGER NOT NULL, ');
      sSqlTxt.Add('    STATUS        INTEGER DEFAULT 1 NOT NULL, ');
      sSqlTxt.Add('    DT_INICIO     DATE NOT NULL, ');
      sSqlTxt.Add('    ALIQ_TETO     NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQ_CBS      NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQ_IBS      NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    USUARIO_CAD   INTEGER NOT NULL, ');
      sSqlTxt.Add('    DT_CADASTRO   DATE DEFAULT CURRENT_DATE NOT NULL, ');
      sSqlTxt.Add('    HR_CADASTRO   TIME DEFAULT CURRENT_TIME NOT NULL, ');
      sSqlTxt.Add('    USUARIO_ALT   INTEGER, ');
      sSqlTxt.Add('    DT_ALTERACAO  DATE, ');
      sSqlTxt.Add('    HR_ALTERACAO  TIME ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_REFTRIB_001_ID; ');

      ExecutaScript('ALTER TABLE REFTRIB_001 ADD CONSTRAINT PK_REFTRIB_001 PRIMARY KEY (CODIGO); ');
      ExecutaScript('COMMENT ON TABLE REFTRIB_001 IS ''REFORMA TRIBUTARIA - PERCENTUAIS DE CBS E IBS''; ');

      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.CODIGO IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.STATUS IS ''0-INATIVO; 1-ATIVO.''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.DT_INICIO IS ''DATA DO INICIO DA VIGENCIA DOS PERCENTUAIS''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.ALIQ_TETO IS ''TETO DAS ALIQUOTAS SOMADAS DE IBS + CBS''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.ALIQ_CBS IS ''ALIQUOTA DE CBS''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.ALIQ_IBS IS ''ALIQUOTA IBS''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.USUARIO_CAD IS ''CODIGO DO USUARIO QUE CADASTROU A ALIQUOTA''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.DT_CADASTRO IS ''DATA DO CADASTRO''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.HR_CADASTRO IS ''HORA DO CADASTRO''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.USUARIO_ALT IS ''USUARIO QUE REALIZOU A ALTERACAO''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.DT_ALTERACAO IS ''DATA DA ULTIMA ALTERACAO''; ');
      ExecutaScript('COMMENT ON COLUMN REFTRIB_001.HR_ALTERACAO IS ''HORA DA ULTIMA ALTERACAO''; ');

    end;

    if ExecutaRecurso('REFTRIB_001',3) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER REFTRIB_001_BI FOR REFTRIB_001 ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.CODIGO IS NULL) THEN ');
      sSqlTxt.Add('    NEW.CODIGO = GEN_ID(GEN_REFTRIB_001_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura REFTRIB_001 ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Cst_IBSCBS;
var
  sSqlTxt : TStringList;
begin
  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('Cst_IBSCBS','CODIGO') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE Cst_IBSCBS ( ');
      sSqlTxt.Add('    CODIGO             INTEGER NOT NULL, ');
      sSqlTxt.Add('    STATUS             INTEGER DEFAULT 1 NOT NULL, ');
      sSqlTxt.Add('    CST                VARCHAR(3) NOT NULL, ');
      sSqlTxt.Add('    CST_DESC           VARCHAR(1000), ');
      sSqlTxt.Add('    C_CLASS_TRIB       VARCHAR(10) NOT NULL, ');
      sSqlTxt.Add('    C_CLASS_TRIB_DESC  VARCHAR(5000), ');
      sSqlTxt.Add('    EC                 VARCHAR(1000), ');
      sSqlTxt.Add('    LC_REDACAO         VARCHAR(5000), ');
      sSqlTxt.Add('    USUARIO_CAD        INTEGER, ');
      sSqlTxt.Add('    DT_CADASTRO        DATE DEFAULT CURRENT_DATE, ');
      sSqlTxt.Add('    HR_CADASTRO        TIME DEFAULT CURRENT_TIME ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_Cst_IBSCBS_ID; ');

      ExecutaScript('ALTER TABLE Cst_IBSCBS ADD CONSTRAINT PK_Cst_IBSCBS PRIMARY KEY (CODIGO); ');
      ExecutaScript('COMMENT ON TABLE Cst_IBSCBS IS ''REFORMA TRIBUTARIA - TABELA DE CST E CCLASSTRIB'';');

      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.CODIGO IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.STATUS IS ''0-INATIVO; 1-ATIVO''; ');
      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.CST IS ''CST - IBS/CBS''; ');
      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.CST_DESC IS ''DESCRICAO DO CST''; ');
      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.C_CLASS_TRIB IS ''CODIGO C-CLASS-TRIB''; ');
      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.C_CLASS_TRIB_DESC IS ''DESCRICAO C-CLASS-TRIB''; ');
      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.EC IS ''ARTIGO LEI''; ');
      ExecutaScript('COMMENT ON COLUMN Cst_IBSCBS.LC_REDACAO IS ''LC REDACAO''; ');

    end;

    if ExecutaRecurso('Cst_IBSCBS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER Cst_IBSCBS_BI FOR Cst_IBSCBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.CODIGO IS NULL) THEN ');
      sSqlTxt.Add('    NEW.CODIGO = GEN_ID(GEN_Cst_IBSCBS_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

    {
    if ExecutaRecurso('Cst_IBSCBS_INSERT',4) then
    begin
      Inserir_CST000;
      Inserir_CST010;
      Inserir_CST011;
      Inserir_CST200;
      Inserir_CST210;
      Inserir_CST220;
      Inserir_CST221;
      Inserir_CST400;
      Inserir_CST410;
      Inserir_CST510;
      Inserir_CST550;
      Inserir_CST620;
      Inserir_CST800;
      Inserir_CST810;
      Inserir_CST820;
    end;
    }
  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura Cst_IBSCBS ' + #13#10 + e.Message);
  end;

end;

function TEstrutura_Tab_RegTributario.Tabela_Existe(const ATabela: String): Boolean;
var
  lQry:TIBCQuery;
begin
  Result := False;
  try
    lQry:=TIBCQuery.Create(Application);
    lQry.Connection := frmmodulo.conexao;

    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add('SELECT * FROM RDB$RELATIONS RR WHERE RR.RDB$RELATION_NAME = ' + QuotedStr(ATabela));
    lQry.Open;
    Result := (not lQry.IsEmpty);
  finally
    FreeAndNil(lQry);
  end;
end;

function TEstrutura_Tab_RegTributario.Trigger_Existe( const ATrigger: String): Boolean;
var
  lQry:TIBCQuery;
begin
  Result := False;
  try
    lQry:=TIBCQuery.Create(Application);
    lQry.Connection := frmmodulo.conexao;

    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add('SELECT * FROM RDB$TRIGGERS WHERE RDB$TRIGGER_NAME = ' + QuotedStr(ATrigger));
    lQry.Open;
    Result := (not lQry.IsEmpty);
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TEstrutura_Tab_RegTributario.INTEGRACAO_FISCAL;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: INTEGRACAO_FISCAL');//3

  sSqlTxt := TStringList.Create;
  try
    if FieldExists('INTEGRACAO_FISCAL','CODIGO') then
    begin
      if ExecutaRecurso('DEL_ALIQ_EDUCACAO_BASE_ICMS',1) then
      begin
        ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL DROP ALIQ_EDUCACAO_BASE_ICMS');
        ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL DROP ALIQ_EDUCACAO_BASE_ST');
      end;
    end;


    if not FieldExists('INTEGRACAO_FISCAL','CODIGO') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE INTEGRACAO_FISCAL ( ');
      sSqlTxt.Add('    CODIGO                   INTEGER NOT NULL, ');
      sSqlTxt.Add('    CST_IBSCBS_ID            INTEGER NOT NULL, ');
      sSqlTxt.Add('    CFOP_ID                  INTEGER NOT NULL, ');
      sSqlTxt.Add('    CST_ICMS_ID              INTEGER NOT NULL, ');
      sSqlTxt.Add('    CST_PIS_ID               INTEGER NOT NULL, ');
      sSqlTxt.Add('    CST_COFINS_ID            INTEGER NOT NULL, ');
      sSqlTxt.Add('    CST_IPI_ID               INTEGER NOT NULL, ');
      sSqlTxt.Add('    DESCRICAO                VARCHAR(255) NOT NULL, ');
      sSqlTxt.Add('    ICMS_IPI                 INTEGER, ');
      sSqlTxt.Add('    ALIQ_ESPECIFICA_ICMS     NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQ_ESPECIFICA_ICMS_ST  NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQ_DIF_ICMS            NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    CST_IBSCBS               VARCHAR(3) NOT NULL, ');
      sSqlTxt.Add('    CLASSTRIB_IBSCBS         VARCHAR(10) NOT NULL, ');
      sSqlTxt.Add('    ALIQ_CBS                 NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQ_IBSUF               NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQ_IBSMUN              NUMERIC(15,2) DEFAULT 0 NOT NULL ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_INTEGRACAO_FISCAL_ID; ');

      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD CONSTRAINT PK_INTEGRACAO_FISCAL PRIMARY KEY (CODIGO); ');
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD CONSTRAINT FK_INTEGRACAO_FISCAL_1 FOREIGN KEY (CST_IBSCBS_ID) REFERENCES CST_IBSCBS (CODIGO); ');
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD CONSTRAINT FK_INTEGRACAO_FISCAL_2 FOREIGN KEY (CFOP_ID) REFERENCES FIS003 (CODIGO); ');
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD CONSTRAINT FK_INTEGRACAO_FISCAL_3 FOREIGN KEY (CST_ICMS_ID) REFERENCES FIS002 (CODIGO); ');
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD CONSTRAINT FK_INTEGRACAO_FISCAL_4 FOREIGN KEY (CST_PIS_ID) REFERENCES FIS024 (CODIGO); ');
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD CONSTRAINT FK_INTEGRACAO_FISCAL_5 FOREIGN KEY (CST_COFINS_ID) REFERENCES FIS024 (CODIGO); ');
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD CONSTRAINT FK_INTEGRACAO_FISCAL_6 FOREIGN KEY (CST_IPI_ID) REFERENCES FIS028 (CODIGO); ');

      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CODIGO IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CST_IBSCBS_ID IS ''CODIGO DO CST E C-CLASS-TRIB''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CFOP_ID IS ''CODIGO DO CFOP''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CST_ICMS_ID IS ''CODIGO DO CST ICMS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CST_PIS_ID IS ''CODIGO DO CST DO PIS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CST_COFINS_ID IS ''CODIGO DO CST DO COFINS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CST_IPI_ID IS ''CODIGO DO CST DO IPI''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.DESCRICAO IS ''DESCRICAO''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ICMS_IPI IS ''ICMS IPI''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQ_ESPECIFICA_ICMS IS ''ALIQUOTA ESPECIFICA DO ICMS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQ_ESPECIFICA_ICMS_ST IS ''ALIQUOTA ESPECIFICA DO ICMS ST''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQ_DIF_ICMS IS ''ALIQUOTA DIFERENCIAL ICMS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CST_IBSCBS IS ''CST IBS-CBS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.CLASSTRIB_IBSCBS IS ''C-CLASS-TRIB IBS-CBS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQ_CBS IS ''ALIQUOTA CBS''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQ_IBSUF IS ''ALIQUOTA IBS ESTADUAL''; ');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQ_IBSMUN IS ''ALIQUOTA IBS MUNICIPAL''; ');
    end;

    if ExecutaRecurso('INTEGRACAO_FISCAL_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER INTEGRACAO_FISCAL_BI FOR INTEGRACAO_FISCAL ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.CODIGO IS NULL) THEN ');
      sSqlTxt.Add('    NEW.CODIGO = GEN_ID(GEN_INTEGRACAO_FISCAL_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

    if not FieldExists('INTEGRACAO_FISCAL','ALIQUOTA_REDUCAO_BASE_ICMS') then
    begin
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD ALIQUOTA_REDUCAO_BASE_ICMS NUMERIC(15,2)');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQUOTA_REDUCAO_BASE_ICMS IS ''ALIQUOTA DE REDUCAO DA BASE DO ICMS'';');
    end;

    if not FieldExists('INTEGRACAO_FISCAL','ALIQUOTA_REDUCAO_BASE_ST') then
    begin
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD ALIQUOTA_REDUCAO_BASE_ST NUMERIC(15,2)');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ALIQUOTA_REDUCAO_BASE_ST IS ''ALIQUOTA DE REDUCAO DA BASE DO ICMS ST'';');
    end;

    if not FieldExists('INTEGRACAO_FISCAL','TP_NF_DEB_CRED') then
    begin
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD TP_NF_DEB_CRED VARCHAR(1)');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.TP_NF_DEB_CRED IS ''TIPO DE NOTA DEBITO/CREDITO: '+
                    'D-DEBITO; '+sLineBreak+
                    'C-CREDITO'';');
    end;

    if not FieldExists('INTEGRACAO_FISCAL','VL_NF_DEB_CRED') then
    begin
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD VL_NF_DEB_CRED VARCHAR(2)');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.VL_NF_DEB_CRED IS ''ENUM DO TIPO DE NOTA DE DEBITO/CREDITO: '+sLineBreak+
                    'D-DEBITO: '+sLineBreak+
                    ' 01-Transferencia de credditos para cooperaticas;'+sLineBreak+
                    ' 02-Anulacao de credito por saidas imunes/isentas;'+sLineBreak+
                    ' 03-Debitos de notas fiscais nao processadas na apuracao;'+sLineBreak+
                    ' 04-Multas e Juros;'+sLineBreak+
                    ' 05-Transferencias de creditos de sucessao;'+sLineBreak+
                    ' 06-Pagamento antecipado'+sLineBreak+
                    ' 07-Perda em estoque'+sLineBreak+
                    'C-CREDITO: '+sLineBreak+
                    ' 01-Multas e Juros;'+sLineBreak+
                    ' 02-Apropriacao de credito presumido de IBS sobre o saldo devedor na ZFM (art 450, $1ª, LC 214/25;'+sLineBreak+
                    ' 03-Retorno'';');
    end;

    if not FieldExists('INTEGRACAO_FISCAL','ICMS_IBS_CBS') then
    begin
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD ICMS_IBS_CBS VARCHAR(1)');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.ICMS_IBS_CBS IS ''Possui ICMS IBS CBS: '+sLineBreak+
                    'S-SIM; '+sLineBreak+
                    'N-NAO'';');
    end;

    if not FieldExists('INTEGRACAO_FISCAL','TP_OPER_GOB') then
    begin
      ExecutaScript('ALTER TABLE INTEGRACAO_FISCAL ADD TP_OPER_GOB INTEGER');
      ExecutaScript('COMMENT ON COLUMN INTEGRACAO_FISCAL.TP_OPER_GOB IS ''Tipo de Operacao do Governo:'+sLineBreak+
                    '1-Fornecimento; '+sLineBreak+
                    '2-Recebimento do pagamento, conforme fato gerador do IBS/CBS definido no Art. 10 $ 2º'';');
    end;


  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura Integração Fiscal ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.TIPO_OPERACAO;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: TIPO_OPERACAO');//4

  sSqlTxt := TStringList.Create;
  try

    if not FieldExists('TIPO_OPERACAO','CODIGO') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE TIPO_OPERACAO ( ');
      sSqlTxt.Add('    CODIGO            INTEGER NOT NULL, ');
      sSqlTxt.Add('    DESCRICAO         VARCHAR(255), ');
      sSqlTxt.Add('    CST_CBSIBS        VARCHAR(3), ');
      sSqlTxt.Add('    CLASSTRIB_CBSIBS  VARCHAR(10) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_TIPO_OPERACAO_ID; ');

      ExecutaScript('ALTER TABLE TIPO_OPERACAO ADD CONSTRAINT PK_TIPO_OPERACAO PRIMARY KEY (CODIGO); ');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO.CODIGO IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO.DESCRICAO IS ''DESCRICAO''; ');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO.CST_CBSIBS IS ''CST DO IBS E CBS''; ');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO.CLASSTRIB_CBSIBS IS ''C-CLASS-TRIB DO CST CBS-IBS''; ');

    end;

    if not Generator_Existe('GEN_TIPO_OPERACAO_ID') then
      ExecutaScript('CREATE GENERATOR GEN_TIPO_OPERACAO_ID; ');

    if ExecutaRecurso('TIPO_OPERACAO_BI',5) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER TIPO_OPERACAO_BI FOR TIPO_OPERACAO ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.CODIGO IS NULL) THEN ');
      sSqlTxt.Add('    NEW.CODIGO = GEN_ID(GEN_TIPO_OPERACAO_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

    if not FieldExists('TIPO_OPERACAO','CBS_IBS_ID') then
    begin
      ExecutaScript('ALTER TABLE TIPO_OPERACAO ADD CBS_IBS_ID INTEGER');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO.CBS_IBS_ID IS ''CODIGO ASSOCIADO AO CBS-IBS'';');
    end;

    if ExecutaRecurso('DROP_NULL',1) then
    begin
      ExecutaScript('ALTER TABLE TIPO_OPERACAO ALTER COLUMN DESCRICAO DROP NOT NULL;');
      ExecutaScript('ALTER TABLE TIPO_OPERACAO ALTER COLUMN CST_CBSIBS DROP NOT NULL;');
      ExecutaScript('ALTER TABLE TIPO_OPERACAO ALTER COLUMN CLASSTRIB_CBSIBS DROP NOT NULL;');
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura Tipo de Operação Fiscal ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.PRODUTO_REGRA_FISCAL;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: PRODUTO_REGRA_FISCAL');//5

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('PRODUTO_REGRA_FISCAL','CODIGO') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE PRODUTO_REGRA_FISCAL ( ');
      sSqlTxt.Add('    CODIGO                INTEGER NOT NULL, ');
      sSqlTxt.Add('    PRODUTO_ID            INTEGER NOT NULL, ');
      sSqlTxt.Add('    INTEGRACAO_FISCAL_ID  INTEGER NOT NULL, ');
      sSqlTxt.Add('    TIPO_OPERACAO_ID      INTEGER NOT NULL ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_PRODUTO_REGRA_FISCAL_ID; ');

      ExecutaScript('ALTER TABLE PRODUTO_REGRA_FISCAL ADD CONSTRAINT PK_PRODUTO_REGRA_FISCAL PRIMARY KEY (CODIGO); ');
      ExecutaScript('ALTER TABLE PRODUTO_REGRA_FISCAL ADD CONSTRAINT FK_PRODUTO_REGRA_FISCAL_1 FOREIGN KEY (PRODUTO_ID) REFERENCES EST003 (CODIGO); ');
      ExecutaScript('ALTER TABLE PRODUTO_REGRA_FISCAL ADD CONSTRAINT FK_PRODUTO_REGRA_FISCAL_2 FOREIGN KEY (INTEGRACAO_FISCAL_ID) REFERENCES INTEGRACAO_FISCAL (CODIGO); ');
      ExecutaScript('ALTER TABLE PRODUTO_REGRA_FISCAL ADD CONSTRAINT FK_PRODUTO_REGRA_FISCAL_3 FOREIGN KEY (TIPO_OPERACAO_ID) REFERENCES TIPO_OPERACAO (CODIGO); ');
      ExecutaScript('COMMENT ON COLUMN PRODUTO_REGRA_FISCAL.CODIGO IS ''CODIGO SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN PRODUTO_REGRA_FISCAL.PRODUTO_ID IS ''CODIGO DO PRODUTO''; ');
      ExecutaScript('COMMENT ON COLUMN PRODUTO_REGRA_FISCAL.INTEGRACAO_FISCAL_ID IS ''CODIGO DA INTEGRACAO FISCAL''; ');
      ExecutaScript('COMMENT ON COLUMN PRODUTO_REGRA_FISCAL.TIPO_OPERACAO_ID IS ''CODIGO DO TIPO DA OPERACAO''; ');

    end;

    if ExecutaRecurso('PRODUTO_REGRA_FISCAL_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER PRODUTO_REGRA_FISCAL_BI FOR PRODUTO_REGRA_FISCAL ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.CODIGO IS NULL) THEN ');
      sSqlTxt.Add('    NEW.CODIGO = GEN_ID(GEN_PRODUTO_REGRA_FISCAL_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

    if ExecutaRecurso('PRODUTO_REGRA_FISCAL_IDX1',1) then
      ExecutaScript('CREATE UNIQUE INDEX PRODUTO_REGRA_FISCAL_IDX1 ON PRODUTO_REGRA_FISCAL (PRODUTO_ID,INTEGRACAO_FISCAL_ID,TIPO_OPERACAO_ID)');

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura Regras Fiscais dos Produtos ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Alteracoes_Adapta;
var
  lSqlTxt :TStringList;
begin
  Progresso_Rotina('Tabela: NCM_IBSCBS');//17

  try
    lSqlTxt := TStringList.Create;
    try
      //Produtos...
      if not FieldExists('EST003','INTEGRACAO_FISCAL_ID') then
      begin
        ExecutaScript('ALTER TABLE EST003 ADD INTEGRACAO_FISCAL_ID INTEGER');
        ExecutaScript('COMMENT ON COLUMN EST003.INTEGRACAO_FISCAL_ID IS ''CODIGO DA INTEGRACAO FISCAL PARA NFE'';');

        ExecutaScript('ALTER TABLE EST003 ADD INTEGRACAO_FISCAL_ID_PDV INTEGER');
        ExecutaScript('COMMENT ON COLUMN EST003.INTEGRACAO_FISCAL_ID_PDV IS ''CODIGO DA INTEGRACAO FISCAL PARA NFCe'';');
      end;

      if not FieldExists('EST006','ALIQUOTA_IBS_UF') then
      begin
        ExecutaScript('ALTER TABLE EST006 ADD ALIQUOTA_IBS_UF NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST006.ALIQUOTA_IBS_UF IS ''ALIQUOTA DA IBS DA UNIDADE FEDERATIVA'';');
      end;

      if not FieldExists('EST006','ALIQUOTA_IBS_MUN') then
      begin
        ExecutaScript('ALTER TABLE EST006 ADD ALIQUOTA_IBS_MUN NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST006.ALIQUOTA_IBS_MUN IS ''ALIQUOTA DA IBS DO MUNICÍPIO'';');
      end;

      if not FieldExists('EST006','ALIQUOTA_CBS') then
      begin
        ExecutaScript('ALTER TABLE EST006 ADD ALIQUOTA_CBS NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST006.ALIQUOTA_CBS IS ''ALIQUOTA CBS'';');
      end;

      if not FieldExists('EST006','CST_IBSCBS') then
      begin
        ExecutaScript('ALTER TABLE EST006 ADD CST_IBSCBS VARCHAR(3)');
        ExecutaScript('COMMENT ON COLUMN EST006.CST_IBSCBS IS ''CST IBS - CBS'';');
      end;

      if not FieldExists('EST006','CCLASSTRIB_IBSCBS') then
      begin
        ExecutaScript('ALTER TABLE EST006 ADD CCLASSTRIB_IBSCBS VARCHAR(6)');
        ExecutaScript('COMMENT ON COLUMN EST006.CCLASSTRIB_IBSCBS IS ''C-CLASS TRIB IBS - CBS'';');
      end;

      if not FieldExists('EST006','PRED_ALIQIBSCBS') then
      begin
        ExecutaScript('ALTER TABLE EST006 ADD PRED_ALIQIBSCBS NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST006.PRED_ALIQIBSCBS IS ''PERCENTUAL DE REDUCAO IBS - CBS'';');
      end;

      if not FieldExists('EST006','IND_BEM_MOVEL_USADO') then
      begin
        ExecutaScript('ALTER TABLE EST006 ADD IND_BEM_MOVEL_USADO INTEGER');
        ExecutaScript('COMMENT ON COLUMN EST006.IND_BEM_MOVEL_USADO IS ''INDICADOR DE BEM MOVEL USADO: ' + sLineBreak +
                      '1 - BEM MOVEL USADO'';');
      end;

      //Clientes...
      if not FieldExists('CAD001','INTEGRACAO_FISCAL_ID') then
      begin
        ExecutaScript('ALTER TABLE CAD001 ADD INTEGRACAO_FISCAL_ID INTEGER');
        ExecutaScript('COMMENT ON COLUMN CAD001.INTEGRACAO_FISCAL_ID IS ''CODIGO DA INTEGRACAO FISCAL PARA NFE'';');
      end;

      if not FieldExists('CAD001','TP_ENTE_GOV') then
      begin
        ExecutaScript('ALTER TABLE CAD001 ADD TP_ENTE_GOV INTEGER DEFAULT 0');
        ExecutaScript('COMMENT ON COLUMN CAD001.TP_ENTE_GOV IS ''SE O TIPO DO CLIENTE E GOVERNO '+ sLineBreak+
                      '0-Nenhum - Nao e goverto; ' + sLineBreak+
                      '1-Fornecimento; '+sLineBreak+
                      '2-Recebimento do pagamento, conforme fato gerador do IBS/CBS definido no Art. 10 $ 2º '';');
      end;

      if not FieldExists('CAD001','RT_TIPO_ENTIDADE') then
      begin
        ExecutaScript('ALTER TABLE CAD001 ADD RT_TIPO_ENTIDADE INTEGER');
        ExecutaScript('COMMENT ON COLUMN CAD001.RT_TIPO_ENTIDADE IS ''ENTIDADE GOVERNAMENTAL.'+
                      ' 0 - NENHUM;'+
                      ' 1 - UNIAO;'+
                      ' 2 - ESTADOS;'+
                      ' 3 - DISTRITO FEDERAL;'+
                      ' 4 - MUNICIPIOS.'';');
        ExecutaScript('UPDATE CAD001 SET RT_TIPO_ENTIDADE = 0;');
      end;

      if not FieldExists('CAD001','RT_ENT_PERC_REDUCAO') then
      begin
        ExecutaScript('ALTER TABLE CAD001 ADD RT_ENT_PERC_REDUCAO NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN CAD001.RT_ENT_PERC_REDUCAO IS ''ENTIDADE GOVERNAMENTAL.'';');
        ExecutaScript('UPDATE CAD001 SET RT_ENT_PERC_REDUCAO = 0;');
      end;

      if not FieldExists('CAD002','CRT') then
      begin
        ExecutaScript('ALTER TABLE CAD002 ADD CRT INTEGER');
        ExecutaScript('COMMENT ON COLUMN CAD002.CRT IS ''CODIGO DO REGIME TRIBUTARIO '+ sLineBreak+
                      '  1: SIMPLES NACIONAL (Empresas optantes pelo Simples Nacional, exceto MEI.); ' + sLineBreak+
                      '  2: SIMPLES NACIONAL – EXCESSO DE SUBLIMITE (Empresas do Simples que ultrapassaram o sublimite de receita bruta.); '+sLineBreak+
                      '  3: REGIME NORMAL (Empresas que não estão no Simples Nacional (Lucro Real ou Lucro Presumido).); '+sLineBreak+
                      '  4: MEI - MICROEMPREENDEDOR INDIVIDUAL (**Novo código exclusivo para MEIs**, obrigatório a partir de abril de 2025.) '';');

        //Atualizando dados...
        lSqlTxt.Clear;
        lSqlTxt.Add('MERGE INTO CAD002 ');
        lSqlTxt.Add('USING ');
        lSqlTxt.Add('  (SELECT ');
        lSqlTxt.Add('    CAD002.COD_EMPRESA ');
        lSqlTxt.Add('    ,CAD002.EMP_OPTANTE_SIMPLES ');
        lSqlTxt.Add('    ,CAD002.EMP_OPTANTE_SUPER_SIMPLES ');
        lSqlTxt.Add('    ,CASE WHEN (CAD002.EMP_OPTANTE_SUPER_SIMPLES = ''SIM'' AND CAD002.EMP_OPTANTE_SIMPLES  = ''NAO'') THEN 1 ELSE ');
        lSqlTxt.Add('       CASE WHEN (CAD002.EMP_OPTANTE_SUPER_SIMPLES = ''SIM'' AND CAD002.EMP_OPTANTE_SIMPLES  = ''SIM'') THEN 2 ELSE 3 ');
        lSqlTxt.Add('    END END CRT ');
        lSqlTxt.Add('  FROM CAD002) A ON A.COD_EMPRESA = CAD002.COD_EMPRESA ');
        lSqlTxt.Add('WHEN MATCHED THEN ');
        lSqlTxt.Add('  UPDATE SET CRT = A.CRT; ');
        ExecutaScript(lSqlTxt.Text);
      end;

      //Tributação do produto - EST011
      if not FieldExists('EST011','IBSCBS_CST') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBSCBS_CST VARCHAR(10)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBSCBS_CST IS ''CST DO IBS CBS.'';');
      end;
      if not FieldExists('EST011','IBSCBS_CCLASS_TRIB') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBSCBS_CCLASS_TRIB VARCHAR(10)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBSCBS_CCLASS_TRIB IS ''CLASSIFICAÇÃO DA CST DA TRIBUTAÇÃO DO IBS CBS.'';');
      end;
      if not FieldExists('EST011','IBSCBS_BASE') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBSCBS_BASE NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBSCBS_BASE IS ''BASE DO IBS CBS.'';');
      end;
      if not FieldExists('EST011','IBSCBS_REDUCAO') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBSCBS_REDUCAO NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBSCBS_REDUCAO IS ''REDUÇÃO DA BASE DO IBS CBS.'';');
      end;
      if not FieldExists('EST011','IBSCBS_BASE_LIQUIDA') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBSCBS_BASE_LIQUIDA NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBSCBS_BASE_LIQUIDA IS ''BASE LIQUIDA DO IBS CBS.'';');
      end;
      if not FieldExists('EST011','IBS_UF_ALIQ') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBS_UF_ALIQ NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBS_UF_ALIQ IS ''ALIQUOTA DO IBS ESTADUAL.'';');
      end;
      if not FieldExists('EST011','IBS_UF_VALOR') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBS_UF_VALOR NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBS_UF_VALOR IS ''VALOR DO IBS ESTADUAL.'';');
      end;
      if not FieldExists('EST011','IBS_MUN_ALIQ') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBS_MUN_ALIQ NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBS_MUN_ALIQ IS ''ALIQUOTA DO IBS MUNICIPAL.'';');
      end;
      if not FieldExists('EST011','IBS_MUN_VALOR') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBS_MUN_VALOR NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBS_MUN_VALOR IS ''VALOR DO IBS MUNICIPAL.'';');
      end;
      if not FieldExists('EST011','CBS_ALIQ') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD CBS_ALIQ NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.CBS_ALIQ IS ''ALIQUOTA DO CBS.'';');
      end;
      if not FieldExists('EST011','CBS_VALOR') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD CBS_VALOR NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.CBS_VALOR IS ''VALOR DO CBS.'';');
      end;
      if not FieldExists('EST011','IBS_REDUCAO') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBS_REDUCAO NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBS_REDUCAO IS ''REDUÇÃO DA BASE DO IBS.'';');
      end;
      if not FieldExists('EST011','CBS_REDUCAO') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD CBS_REDUCAO NUMERIC(15,2)');
        ExecutaScript('COMMENT ON COLUMN EST011.CBS_REDUCAO IS ''REDUÇÃO DA BASE DO CBS.'';');
      end;
      if not FieldExists('EST011','IBS_UF_ALIQ_LIQUIDA') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBS_UF_ALIQ_LIQUIDA NUMERIC(15,7)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBS_UF_ALIQ_LIQUIDA IS ''ALIQUOTA DEDUZIDA A REDUÇÃO - IBS UF.'';');
      end;
      if not FieldExists('EST011','IBS_MUN_ALIQ_LIQUIDA') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD IBS_MUN_ALIQ_LIQUIDA NUMERIC(15,7)');
        ExecutaScript('COMMENT ON COLUMN EST011.IBS_MUN_ALIQ_LIQUIDA IS ''ALIQUOTA DEDUZIDA A REDUÇÃO - IBS MUN.'';');
      end;
      if not FieldExists('EST011','CBS_ALIQ_LIQUIDA') then
      begin
        ExecutaScript('ALTER TABLE EST011 ADD CBS_ALIQ_LIQUIDA NUMERIC(15,7)');
        ExecutaScript('COMMENT ON COLUMN EST011.CBS_ALIQ_LIQUIDA IS ''ALIQUOTA DEDUZIDA A REDUÇÃO - CBS.'';');
      end;


    finally
      FreeAndNil(lSqlTxt);
    end;
  except
  end;

end;

procedure TEstrutura_Tab_RegTributario.Inserir_Registros;
begin
  try
    Progresso_Rotina('Tabela: Inserindo registros tabela CST_IBSCBS_INSERT');//18

    if ExecutaRecurso('Cst_IBSCBS_INSERT',1) then
    begin
      Inserir_CST000;
      Inserir_CST010;
      Inserir_CST011;
      Inserir_CST200;
      Inserir_CST210;
      Inserir_CST220;
      Inserir_CST221;
      Inserir_CST400;
      Inserir_CST410;
      Inserir_CST510;
      Inserir_CST550;
      Inserir_CST620;
      Inserir_CST800;
      Inserir_CST810;
      Inserir_CST820;
    end;
  except
    on E : Exception do
    begin
      raise Exception.Create('Erro ao inserir registros CBS e IBS ' + #13#10 + e.Message);
    end;
  end;
end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: UF_ICMS');//6

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('UF_ICMS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE UF_ICMS ( ');
      sSqlTxt.Add('    ID              INTEGER NOT NULL, ');
      sSqlTxt.Add('    SIGLA           VARCHAR(2) NOT NULL, ');
      sSqlTxt.Add('    ICMS_PROPRIO    NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ICMS_ST         NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQUOTA_FCP    NUMERIC(15,2) DEFAULT 0 NOT NULL, ');
      sSqlTxt.Add('    ALIQUOTA_IBSUF  NUMERIC(15,2) DEFAULT 0 NOT NULL ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_UF_ICMS_ID; ');

      ExecutaScript('ALTER TABLE UF_ICMS ADD CONSTRAINT PK_UF_ICMS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON COLUMN UF_ICMS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN UF_ICMS.SIGLA IS ''SIGLA UF - UNIDADE FEDERATIVA''; ');
      ExecutaScript('COMMENT ON COLUMN UF_ICMS.ICMS_PROPRIO IS ''ICMS PROPPRIO - ALIQUOTA INTERESTADUAL''; ');
      ExecutaScript('COMMENT ON COLUMN UF_ICMS.ICMS_ST IS ''ICMS ST - ALIQUOTA INTERNA UF DESTINO''; ');
      ExecutaScript('COMMENT ON COLUMN UF_ICMS.ALIQUOTA_FCP IS ''ALIQUOTA FCP - FUNDO DE COMBATE A POBREZA''; ');
      ExecutaScript('COMMENT ON COLUMN UF_ICMS.ALIQUOTA_IBSUF IS ''ALIQUOTA IBSUF''; ');
    end;

    if ExecutaRecurso('UF_ICMS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER UF_ICMS_BI FOR UF_ICMS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.ID IS NULL) THEN ');
      sSqlTxt.Add('    NEW.ID = GEN_ID(GEN_UF_ICMS_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela UF_ICMS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Atualiza_UF_ICMS(AUF_Destino: String);
begin
  case AnsiIndexStr(AUF_Destino, [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO',
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI',
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ]) of
    0: UF_ICMS_AC;//ShowMessage('Acre');
    1: UF_ICMS_AL;//ShowMessage('Alagoas');
    2: UF_ICMS_AP;//ShowMessage('Amapá');
    3: UF_ICMS_AM;//ShowMessage('Amazonas');
    4: UF_ICMS_BA;//ShowMessage('Bahia');
    5: UF_ICMS_CE;//ShowMessage('Ceará');
    6: UF_ICMS_DF;//ShowMessage('Distrito Federal');
    7: UF_ICMS_ES;//ShowMessage('Espírito Santo');
    8: UF_ICMS_GO;//ShowMessage('Goiás');
    9: UF_ICMS_MA;//ShowMessage('Maranhão');
    10:UF_ICMS_MT;// ShowMessage('Mato Grosso');
    11:UF_ICMS_MS;// ShowMessage('Mato Grosso do Sul');
    12:UF_ICMS_MG;// ShowMessage('Minas Gerais');
    13:UF_ICMS_PA;// ShowMessage('Pará');
    14:UF_ICMS_PB;// ShowMessage('Paraíba');
    15:UF_ICMS_PR;// ShowMessage('Paraná');
    16:UF_ICMS_PE;// ShowMessage('Pernambuco');
    17:UF_ICMS_PI;// ShowMessage('Piauí');
    18:UF_ICMS_RJ;// ShowMessage('Rio de Janeiro');
    19:UF_ICMS_RN;// ShowMessage('Rio Grande do Norte');
    20:UF_ICMS_RS;// ShowMessage('Rio Grande do Sul');
    21:UF_ICMS_RO;// ShowMessage('Rondônia');
    22:UF_ICMS_RR;// ShowMessage('Roraima');
    23:UF_ICMS_SC;// ShowMessage('Santa Catarina');
    24:UF_ICMS_SP;// ShowMessage('São Paulo');
    25:UF_ICMS_SE;// ShowMessage('Sergipe');
    26:UF_ICMS_TO;// ShowMessage('Tocantins');
  else
    ShowMessage('UF não reconhecida');
  end;

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_AC;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_AL;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_AM;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_AP;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_BA;
begin
  try
    try
      if ExecutaRecurso('UF_ICMS_BA',1) then
      begin
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AC'', 12, 19, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AL'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AM'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AP'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''BA'', 21, 21, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''CE'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''DF'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''ES'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''GO'', 12, 19, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MA'', 12, 23, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MT'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MS'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MG'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PA'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PB'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PR'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PE'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PI'', 12, 23, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RN'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RS'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RJ'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RO'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RR'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SC'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SP'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SE'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''TO'', 12, 20, 2, 1); ');
      end;
    except
      on E : Exception do
      begin
        raise Exception.Create('UF ICMS ES: <br>' + E.Message);
      end;
    end;
  finally
  end;
end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_CE;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_DF;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_ES;
begin
  try
    try
      if ExecutaRecurso('UF_ICMS_ES',1) then
      begin
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AC'', 12, 19, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AL'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AM'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AP'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''BA'', 12, 21, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''CE'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''DF'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''ES'', 17, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''GO'', 12, 19, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MA'', 12, 23, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MT'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MS'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MG'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PA'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PB'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PR'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PE'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PI'', 12, 23, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RN'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RS'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RJ'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RO'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RR'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SC'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SP'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SE'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''TO'', 12, 20, 2, 1); ');
      end;
    except
      on E : Exception do
      begin
        raise Exception.Create('UF ICMS ES: <br>' + E.Message);
      end;
    end;
  finally
  end;
end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_GO;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_MA;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_MG;
begin
  try
    try
      if ExecutaRecurso('UF_ICMS_MG',1) then
      begin
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AC'', 7, 19, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AL'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AM'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''AP'', 7, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''BA'', 7, 21, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''CE'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''DF'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''ES'', 7, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''GO'', 7, 19, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MA'', 7, 23, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MT'', 7, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MS'', 7, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''MG'', 18, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PA'', 7, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PB'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PR'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PE'', 7, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''PI'', 7, 23, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RN'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RS'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RJ'', 12, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RO'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''RR'', 7, 20, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SC'', 12, 17, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SP'', 12, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''SE'', 7, 18, 2, 1); ');
        Executa_Script_Banco('INSERT INTO UF_ICMS(SIGLA, ICMS_PROPRIO, ICMS_ST, ALIQUOTA_FCP, ALIQUOTA_IBSUF) VALUES(''TO'', 7, 20, 2, 1); ');
      end;
    except
      on E : Exception do
      begin
        raise Exception.Create('UF ICMS ES: <br>' + E.Message);
      end;
    end;
  finally
  end;
end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_MS;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_MT;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_PA;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_PB;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_PE;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_PI;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_PR;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_RJ;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_RN;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_RO;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_RR;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_RS;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_SC;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_SE;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_SP;
begin

end;

procedure TEstrutura_Tab_RegTributario.UF_ICMS_TO;
begin

end;

procedure TEstrutura_Tab_RegTributario.CCLASSTRIB_CBSIBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: CCLASSTRIB_CBSIBS');//7

  sSqlTxt := TStringList.Create;
  try
    if ExecutaRecurso('DROP_CCLASSTRIB_CBSIBS_BI',12) then
    begin
      if Tabela_Existe('CCLASSTRIB_CBSIBS') then
        ExecutaScript('DROP TABLE CCLASSTRIB_CBSIBS; ');

      if Generator_Existe('GEN_CCLASSTRIB_CBSIBS_ID') then
        ExecutaScript('DROP SEQUENCE GEN_CCLASSTRIB_CBSIBS_ID; ');
    end;

    if not FieldExists('CCLASSTRIB_CBSIBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE CCLASSTRIB_CBSIBS ( ');
      sSqlTxt.Add('  ID                     INTEGER NOT NULL, ');
      sSqlTxt.Add('  CST_IBS_CBS            VARCHAR(10), ');
      sSqlTxt.Add('  INDCTEOS               INTEGER, ');
      sSqlTxt.Add('  DESCRICAO_CST_IBS_CBS  VARCHAR(5000), ');
      sSqlTxt.Add('  INDBPE                 INTEGER, ');
      sSqlTxt.Add('  CCLASSTRIB             VARCHAR(20), ');
      sSqlTxt.Add('  INDBPETA               INTEGER, ');
      sSqlTxt.Add('  NOME_CCLASSTRIB        VARCHAR(5000), ');
      sSqlTxt.Add('  INDBPETM               INTEGER, ');
      sSqlTxt.Add('  DESCRICAO_CCLASSTRIB   VARCHAR(10000), ');
      sSqlTxt.Add('  INDNF3E                INTEGER, ');
      sSqlTxt.Add('  LC_REDACAO             VARCHAR(10000), ');
      sSqlTxt.Add('  INDNFSE                INTEGER, ');
      sSqlTxt.Add('  LC_214_25              VARCHAR(10000), ');
      sSqlTxt.Add('  INDNFSE_VIA            INTEGER, ');
      sSqlTxt.Add('  TIPO_DE_ALIQUOTA       VARCHAR(50), ');
      sSqlTxt.Add('  INDNFCOM               INTEGER, ');
      sSqlTxt.Add('  PREDIBS                NUMERIC(15,2), ');
      sSqlTxt.Add('  INDNFAG                INTEGER, ');
      sSqlTxt.Add('  PREDCBS                NUMERIC(15,2), ');
      sSqlTxt.Add('  INDNFGAS               INTEGER, ');
      sSqlTxt.Add('  IND_REDUTORBC          INTEGER, ');
      sSqlTxt.Add('  INDDERE                INTEGER, ');
      sSqlTxt.Add('  IND_GTRIBREGULAR       INTEGER, ');
      sSqlTxt.Add('  ANEXO                  VARCHAR(10), ');
      sSqlTxt.Add('  IND_GCREDPRESOPER      INTEGER, ');
      sSqlTxt.Add('  LINK                   VARCHAR(5000), ');
      sSqlTxt.Add('  IND_GMONOPADRAO        INTEGER, ');
      sSqlTxt.Add('  IND_GMONORETEN         INTEGER, ');
      sSqlTxt.Add('  IND_GMONORET           INTEGER, ');
      sSqlTxt.Add('  IND_GMONODIF           INTEGER, ');
      sSqlTxt.Add('  IND_GESTORNOCRED       INTEGER, ');
      sSqlTxt.Add('  CREDITO_PARA           VARCHAR(1000), ');
      sSqlTxt.Add('  DINIVIG                DATE, ');
      sSqlTxt.Add('  DFIMVIG                DATE, ');
      sSqlTxt.Add('  DATAATUALIZACAO        DATE, ');
      sSqlTxt.Add('  INDNFEABI              INTEGER, ');
      sSqlTxt.Add('  INDNFE                 INTEGER, ');
      sSqlTxt.Add('  INDNFCE                INTEGER, ');
      sSqlTxt.Add('  INDCTE                 INTEGER ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_CCLASSTRIB_CBSIBS_ID; ');
      ExecutaScript('ALTER TABLE CCLASSTRIB_CBSIBS ADD CONSTRAINT PK_CCLASSTRIB_CBSIBS PRIMARY KEY (ID); ');
      ExecutaScript('COMMENT ON TABLE CCLASSTRIB_CBSIBS IS ''Tabela de códigos de classificação tributária e indicadores de CST do IBS e CBS (cClassTrib)''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.ID IS ''Sequencial''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.CST_IBS_CBS IS ''Código de Situação Tributária do IBS/CBS''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDCTEOS IS ''Indicador de aplicabilidade ao CT-e OS''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.DESCRICAO_CST_IBS_CBS IS ''Descrição da CST''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDBPE IS ''Indicador de aplicabilidade ao BPe''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.CCLASSTRIB IS ''Código da Classificação Tributária''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDBPETA IS ''Indicador de aplicabilidade ao BPe Transporte Aéreo''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.NOME_CCLASSTRIB IS ''Nome da Classificação Tributária''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDBPETM IS ''Indicador de aplicabilidade ao BPe Transporte Multimodal''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.DESCRICAO_CCLASSTRIB IS ''Descrição detalhada da Classificação Tributária''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNF3E IS ''Indicador de aplicabilidade à NF3e''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.LC_REDACAO IS ''Redação legal associada''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFSE IS ''Indicador de aplicabilidade à NFSe''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.LC_214_25 IS ''Referência à Lei Complementar 214/2025''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFSE_VIA IS ''Indicador de aplicabilidade à NFSe via intermediário''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.TIPO_DE_ALIQUOTA IS ''Tipo de alíquota (padrão, uniforme, reduzida)''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFCOM IS ''Indicador de aplicabilidade à NFCom''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.PREDIBS IS ''Percentual de redução do IBS''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFAG IS ''Indicador de aplicabilidade à NFAg''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.PREDCBS IS ''Percentual de redução do CBS''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFGAS IS ''Indicador de aplicabilidade à NFGas''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_REDUTORBC IS ''Indicador de redutor de base de cálculo''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDDERE IS ''Indicador de regime específico''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_GTRIBREGULAR IS ''Indicador de tributação regular''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.ANEXO IS ''Referência a anexo legal''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_GCREDPRESOPER IS ''Indicador de crédito presumido na operação''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.LINK IS ''Link para legislação aplicável''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_GMONOPADRAO IS ''Indicador de monofásico padrão''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_GMONORETEN IS ''Indicador de monofásico com retenção''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_GMONORET IS ''Indicador de monofásico retido''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_GMONODIF IS ''Indicador de monofásico diferido''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.IND_GESTORNOCRED IS ''Indicador de estorno de crédito''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.CREDITO_PARA IS ''Destinatário do crédito (fornecedor/adquirente)''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.DINIVIG IS ''Data de início de vigência''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.DFIMVIG IS ''Data de fim de vigência''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.DATAATUALIZACAO IS ''Data de atualização do registro''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFEABI IS ''Indicador de aplicabilidade à NFe ABI''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFE IS ''Indicador de aplicabilidade à NFe''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDNFCE IS ''Indicador de aplicabilidade à NFC-e''; ');
      ExecutaScript('COMMENT ON COLUMN CCLASSTRIB_CBSIBS.INDCTE IS ''Indicador de aplicabilidade ao CT-e''; ');
    end;

    if ExecutaRecurso('CCLASSTRIB_CBSIBS_BI',21) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER CCLASSTRIB_CBSIBS_BI FOR CCLASSTRIB_CBSIBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.ID IS NULL) THEN ');
      sSqlTxt.Add('    NEW.ID = GEN_ID(GEN_CCLASSTRIB_CBSIBS_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

    if ExecutaRecurso('ALTER_COLUM_CREDITO_PARA',10) then
      ExecutaScript('ALTER TABLE CCLASSTRIB_CBSIBS ALTER COLUMN CREDITO_PARA TYPE VARCHAR(1000);');


    {Descontinuado....
    if ExecutaRecurso('CCLASSTRIB_CBSIBS_INSERT',3) then
    begin
      CClassTrib_CBSIBS_0;
      CClassTrib_CBSIBS_2;
      CClassTrib_CBSIBS_4;
      CClassTrib_CBSIBS_5;
      CClassTrib_CBSIBS_6;
      CClassTrib_CBSIBS_8;
    end;
    }
  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela UF_ICMS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.CClassTrib_CBSIBS_0;
begin
  try
    try
      //Inserindo dados...
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''000'',''Tributação integral'',''000001'',''Situações tributadas integralmente pelo IBS e CBS.'','''',''Padrão'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''000'',''Tributação integral'',''000002'',''Exploração de via'',''Art. 11,VIII'',''Padrão'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''000'',''Tributação integral'',''000003'',''Regime automotivo - projetos incentivados (art. 311)'',''Art. 311'',''Padrão'',0,0,0,0,1,0,0,0,0,''Fornecedor''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''000'',''Tributação integral'',''000004'',''Regime automotivo - projetos incentivados (art. 312)'',''Art. 312'',''Padrão'',0,0,0,0,1,0,0,0,0,''Fornecedor''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''010'',''Tributação com alíquotas uniformes - operações do FGTS'',''010001'',''Operações do FGTS não realizadas pela Caixa Econômica Federal'',''Art. 212'',''Uniforme setorial'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''010'',''Tributação com alíquotas uniformes - operações setor financeiro'',''010002'',''Operações do serviço financeiro'',''Art. 233'',''Uniforme setorial'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''011'',''Tributação com alíquotas uniformes reduzidas em 60%'',''011001'',''Planos de assistência funerária.'',''Art. 236'',''Uniforme nacional (referência)'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''011'',''Tributação com alíquotas uniformes reduzidas em 60%'',''011002'',''Planos de assistência à saúde'',''Art. 237'',''Uniforme nacional (referência)'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''011'',''Tributação com alíquotas uniformes reduzidas em 60%'',''011003'',''Intermediação de planos de assistência à saúde'',''Art. 240'',''Uniforme nacional (referência)'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''011'',''Tributação com alíquotas uniformes'',''011004'',''Concursos e prognósticos'',''Art. 246'',''Uniforme nacional (referência)'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''011'',''Tributação com alíquotas uniformes reduzidas em 30%'',''011005'',''Planos de assistência à saúde de animais domésticos'',''Art. 243'',''Uniforme nacional (referência)'',30,30,0,0,0,0,0,0,0,''''); ');

      //Atualizando dados...
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Situações tributadas integralmente pelo IBS e CBS.'' WHERE CST = ''000'' AND CCLASSTRIB = ''000001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Exploração de via, observado o art. 11 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''000'' AND CCLASSTRIB = ''000002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regime automotivo - projetos incentivados, observado o art. 311 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''000'' AND CCLASSTRIB = ''000003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regime automotivo - projetos incentivados, observado o art. 312 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''000'' AND CCLASSTRIB = ''000004''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações do FGTS não realizadas pela Caixa Econômica Federal, observado o art. 212 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''010'' AND CCLASSTRIB = ''010001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações do serviço financeiro'' WHERE CST = ''010'' AND CCLASSTRIB = ''010002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Planos de assistência funerária, observado o art. 236 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''011'' AND CCLASSTRIB = ''011001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Planos de assistência à saúde, observado o art. 237 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''011'' AND CCLASSTRIB = ''011002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Intermediação de planos de assistência à saúde, observado o art. 240 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''011'' AND CCLASSTRIB = ''011003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Concursos e prognósticos, observado o art. 246 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''011'' AND CCLASSTRIB = ''011004''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Planos de assistência à saúde de animais domésticos, observado o art. 243 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''011'' AND CCLASSTRIB = ''011005''; ');

    except
      on E : Exception do
      begin
        raise Exception.Create('Erro ao inserir os dados na CClassTrib_CBSIBS 0 ' + #13#10 + e.Message);
      end;
    end;
  finally

  end;
end;

procedure TEstrutura_Tab_RegTributario.CClassTrib_CBSIBS_2;
begin
  try
    try
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200001'',''Aquisições realizadas entre empresas autorizadas a operar em zonas de processamento de exportação'',''Art. 103'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200002'',''Fornecimento ou importação para produtor rural não contribuinte ou TAC'',''Art. 110'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200003'',''Vendas de produtos destinados à alimentação humana (Anexo I)'',''Art. 125'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200004'',''Venda de dispositivos médicos (Anexo XII)'',''Art. 144,I'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200005'',''Venda de dispositivos médicos adquiridos por órgãos da administração pública (Anexo IV)'',''Art. 144,II'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200006'',''Situação de emergência de saúde pública reconhecida pelo Poder público (Anexo XII)'',''Art. 144,§ 3º'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200007'',''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência (Anexo XIII)'',''Art. 145,I'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200008'',''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência adquiridos por órgãos da administração pública (Anexo V)'',''Art. 145,II'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200009'',''Fornecimento de medicamentos (Anexo XIV)'',''Art. 146'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200010'',''Fornecimento dos medicamentos registrados na Anvisa,adquiridos por órgãos da administração pública'',''Art. 146,§ 1º'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200011'',''Fornecimento das composições para nutrição enteral e parenteral quando adquiridas por órgãos da administração pública (Anexo VI)'',''Art. 146,§ 2º'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200012'',''Situação de emergência de saúde pública reconhecida pelo Poder público (Anexo XIV)'',''Art. 146,§ 4º'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200013'',''Fornecimento de tampões higiênicos,absorventes higiênicos internos ou externos'',''Art. 147'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200014'',''Fornecimento dos produtos hortícolas,frutas e ovos (Anexo XV) '',''Art. 148'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200015'',''Venda de automóveis de passageiros de fabricação nacional adquiridos por motoristas profissionais ou pessoas com deficiência'',''Art. 149'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200016'',''Prestação de serviços de pesquisa e desenvolvimento por Instituição Científica,Tecnológica e de Inovação (ICT)'',''Art. 156'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200017'',''Operações relacionadas ao FGTS'',''Art. 212,§ 3º,I'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200018'',''Operações de resseguro e retrocessão'',''Art. 223,§ 4º'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200019'',''Importador dos serviços financeiros contribuinte'',''Art. 231,§ 1º,II'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200020'',''Operação praticada por sociedades cooperativas optantes por regime específico do IBS e CBS'',''Art. 271'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200021'',''Serviços de transporte público coletivo de passageiros ferroviário e hidroviário'',''Art. 285,I'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200022'',''Operação originada fora da ZFM que destine bem material industrializado a contribuinte estabelecido na ZFM'',''Art. 445'',''Padrão'',100,100,0,1,1,0,0,0,0,''Adquirente. Crédito Presumido de IBS	Art. 447. '+
      ' Fica concedido ao contribuinte sujeito ao regime regular do IBS e habilitado nos termos do art. 442 desta Lei Complementar crédito presumido de IBS relativo à aquisição de bem material industrializado de origem nacional contemplado pela redução'+
      ' a zero da alíquota do IBS nos termos do art. 445 desta Lei Complementar. ''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200023'',''Operação realizada por indústria incentivada que destine bem material intermediário para outra indústria incentivada na ZFM'',''Art. 448'',''Padrão'',100,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero'',''200024'',''Operação originada fora das Áreas de Livre Comércio destinadas a contribuinte estabelecido nas Áreas de Livre Comércio'',''Art. 463'',''Padrão'',100,100,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota zero apenas CBS e reduzida em 60% para IBS'',''200025'',''Fornecimento dos serviços de educação relacionados ao Programa Universidade para Todos (Prouni)'',''Art. 308'',''Padrão'',60,100,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 80%'',''200026'',''Locação de imóveis localizados nas zonas reabilitadas'',''Art. 158,parágrafo único'',''Padrão'',80,80,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 70%'',''200027'',''Operações de locação,cessão onerosa e arrendamento de bens imóveis'',''Art. 261,parágrafo único'',''Padrão'',70,70,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200028'',''Fornecimento dos serviços de educação (Anexo II)'',''Art. 129'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200029'',''Fornecimento dos serviços de saúde humana (Anexo III)'',''Art. 130'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200030'',''Venda dos dispositivos médicos  (Anexo IV)'',''Art. 131'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200031'',''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência (Anexo V) '',''Art. 132'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200032'',''Fornecimento dos medicamentos registrados na Anvisa ou produzidos por farmácias de manipulação,ressalvados os medicamentos sujeitos à alíquota zero'',''Art. 133'',''Padrão'',60,60,0,0,0,0,0,0,'+
      '0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200033'',''Fornecimento das composições para nutrição enteral e parenteral (Anexo VI)'',''Art. 133,§ 1º'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200034'',''Fornecimento dos alimentos destinados ao consumo humano (Anexo VII)'',''Art. 135'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200035'',''Fornecimento dos produtos de higiene pessoal e limpeza (Anexo VIII)'',''Art. 136'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200036'',''Fornecimento de produtos agropecuários,aquícolas,pesqueiros,florestais e extrativistas vegetais in natura'',''Art. 137'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200037'',''Fornecimento de serviços ambientais de conservação ou recuperação da vegetação nativa'',''Art. 137,§ 3º'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200038'',''Fornecimento dos insumos agropecuários e aquícolas (Anexo IX)'',''Art. 138'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200039'',''Fornecimento dos serviços e o licenciamento ou cessão dos direitos destinados às produções nacionais artísticas (Anexo X)'',''Art. 139'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200040'',''Fornecimento de serviços de comunicação institucional à administração pública'',''Art. 140'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200041'',''Fornecimento de serviço de educação desportiva (art. 141. I)'',''Art. 141,I'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200042'',''Fornecimento de serviço de educação desportiva (art. 141. II)'',''Art. 141,II'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200043'',''Fornecimento à administração pública dos serviços e dos bens relativos à soberania (Anexo XI)'',''Art. 142,I'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200044'',''Operações e prestações de serviços de segurança da informação e segurança cibernética desenvolvidos por sociedade que tenha sócio brasileiro (Anexo XI)'',''Art. 142,II'',''Padrão'',60,60,0,0,0,0'+
      ',0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 60%'',''200045'',''Operações relacionadas a projetos de reabilitação urbana de zonas históricas e de áreas críticas de recuperação e reconversão urbanística'',''Art. 158'',''Padrão'',60,60,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 50%'',''200046'',''Operações com bens imóveis'',''Art. 261'',''Padrão'',50,50,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 40%'',''200047'',''Bares e Restaurantes'',''Art. 275'',''Padrão'',40,40,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 40%'',''200048'',''Hotelaria,Parques de Diversão e Parques Temáticos'',''Art. 281'',''Padrão'',40,40,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 40%'',''200049'',''Transporte coletivo de passageiros rodoviário,ferroviário e hidroviário'',''Art. 286'',''Padrão'',40,40,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 40%'',''200450'',''Serviços de transporte aéreo regional coletivo de passageiros ou de carga'',''Art. 287'',''Padrão'',40,40,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 40%'',''200051'',''Agências de Turismo'',''Art. 289,II'',''Padrão'',40,40,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''200'',''Alíquota reduzida em 30%'',''200052'',''Prestação de serviços de profissões intelectuais'',''Art. 127,I a XVIII'',''Padrão'',30,30,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''210'',''Alíquota reduzida em 50% com redutor de base de cálculo'',''210001'',''Redutor social aplicado uma única vez na alienação de bem imóvel residencial novo'',''Arts. 259 e 261'',''Padrão'',50,50,1,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''210'',''Alíquota reduzida em 50% com redutor de base de cálculo'',''210002'',''Redutor social aplicado uma única vez na alienação de lote residencial'',''Arts. 259 e 261'',''Padrão'',50,50,1,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''210'',''Alíquota reduzida em 70% com redutor de base de cálculo'',''210003'',''Redutor social em operações de locação,cessão onerosa e arrendamento de bens imóveis de uso residencial'',''Art. 260'',''Padrão'',70,70,1,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''220'',''Alíquota fixa'',''220001'',''Incorporação imobiliária submetida ao regime especial de tributação'',''Art. 485,I'',''Fixa'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''220'',''Alíquota fixa'',''220002'',''Incorporação imobiliária submetida ao regime especial de tributação'',''Art. 485,II'',''Fixa'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''220'',''Alíquota fixa'',''220003'',''Alienação de imóvel decorrente de parcelamento do solo'',''Art. 486'',''Fixa'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''221'',''Alíquota fixa proporcional'',''221001'',''Locação,cessão onerosa ou arrendamento de bem imóvel com alíquota sobre a receita bruta'',''Art. 487,§ 2º'',''Fixa'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''222'',''Redução de Base de Cálculo'',''222001'',''Transporte internacional de passageiros,caso os trechos de ida e volta sejam vendidos em conjunto'',''Art. 12 § 8º'',''Padrão'',0,0,1,0,0,0,0,0,0,''''); ');

      //Atualizando dados...
      CClassTrib_CBSIBS_2_Update1;  //Descrição...

    except
      on E : Exception do
      begin
        raise Exception.Create('Erro ao inserir os dados na CClassTrib_CBSIBS 2 ' + #13#10 + e.Message);
      end;
    end;
  finally

  end;
end;

procedure TEstrutura_Tab_RegTributario.CClassTrib_CBSIBS_2_Update1;
begin
  try
    try
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Aquisições de máquinas, de aparelhos, de instrumentos, de equipamentos, de matérias-primas, de produtos intermediários e de materiais de embalagem realizadas entre '+
      'empresas autorizadas a operar em zonas de processamento de exportação, observado o art. 103 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento ou importação de tratores, máquinas e implementos agrícolas, destinados a produtor rural não contribuinte, e de veículos de transporte de carga '+
      'destinados a transportador autônomo de carga pessoa física não contribuinte, observado o art. 110 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Vendas de produtos destinados à alimentação humana relacionados no Anexo I da Lei Complementar nº 214, de 2025, com a especificação das respectivas '+
      'classificações da NCM/SH, que compõem a Cesta Básica Nacional de Alimentos, criada nos termos do art. 8º da Emenda Constitucional nº 132, de 20 de dezembro de 2023, observado o art. 125 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''200'' AND CCLASSTRIB = ''200003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Venda de dispositivos médicos com a especificação das respectivas classificações da NCM/SH previstas no Anexo XII da Lei Complementar nº 214, de 2025, observado o art. '+
      '144 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200004''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Venda de dispositivos médicos com a especificação das respectivas classificações da NCM/SH previstas no Anexo IV da Lei Complementar nº 214, de 2025, quando adquiridos '+
      'por órgãos da administração pública direta, autarquias e fundações públicas, observado o art. 144 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200005''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Situação de emergência de saúde pública reconhecida pelo Poder Legislativo federal, estadual, distrital ou municipal competente, ato conjunto do Ministro da Fazenda e '+
      'do Comitê Gestor do IBS poderá ser editado, a qualquer momento, para incluir dispositivos não listados no Anexo XII da Lei Complementar nº 214, de 2025, limitada a vigência do benefício ao período e à localidade da emergência '+
      'de saúde pública, observado o art. 144 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200006''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência relacionados no Anexo XIII da Lei Complementar nº 214, de 2025, '+
      'com a especificação das respectivas classificações da NCM/SH, observado o art. 145 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200007''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência relacionados no '+
      'Anexo V da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NCM/SH, quando adquiridos por órgãos da administração pública direta, autarquias, fundações públicas e entidades imunes, '+
      'observado o art. 145 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200008''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos medicamentos relacionados no Anexo XIV da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NCM/SH,'+
      ' observado o art. 146 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200009''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos medicamentos registrados na Anvisa, quando adquiridos por órgãos da administração pública direta, autarquias, fundações públicas e entidades '+
      'imunes, observado o art. 146 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200010''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento das composições para nutrição enteral e parenteral, composições especiais e fórmulas nutricionais destinadas às pessoas com erros inatos do '+
      'metabolismo relacionadas no Anexo VI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NCM/SH, quando adquiridas por órgãos da administração pública direta, autarquias e fundações '+
      'públicas, observado o art. 146 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200011''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Situação de emergência de saúde pública reconhecida pelo Poder Legislativo federal, estadual, distrital ou municipal competente, ato conjunto do Ministro '+
      'da Fazenda e do Comitê Gestor do IBS poderá ser editado, a qualquer momento, para incluir dispositivos não listados no Anexo XIV da Lei Complementar nº 214, de 2025, limitada a vigência do benefício ao período e à localidade'+
      ' da emergência de saúde pública, observado o art. 146 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200012''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento de tampões higiênicos, absorventes higiênicos internos ou externos, descartáveis ou reutilizáveis, calcinhas absorventes e coletores menstruais, '+
      'observado o art. 147 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200013''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos produtos hortícolas, frutas e ovos, relacionados no Anexo XV da Lei Complementar nº 214 , de 2025, com a especificação das respectivas '+
      'classificações da NCM/SH e desde que não cozidos, observado o art. 148 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200014''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Venda de automóveis de passageiros de fabricação nacional de, no mínimo, 4 (quatro) portas, inclusive a de acesso ao bagageiro, quando adquiridos por '+
      'motoristas profissionais que exerçam, comprovadamente, em automóvel de sua propriedade, atividade de condutor autônomo de passageiros, na condição de titular de autorização, permissão ou concessão do poder público, e que '+
      'destinem o automóvel à utilização na categoria de aluguel (táxi), ou por pessoas com deficiência física, visual, auditiva, deficiência mental severa ou profunda, transtorno do espectro autista, com prejuízos na comunicação '+
      'social e em padrões restritos ou repetitivos de comportamento de nível moderado ou grave, nos termos da legislação relativa à matéria, observado o disposto no art. 149 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''200'' AND CCLASSTRIB = ''200015''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Prestação de serviços de pesquisa e desenvolvimento por Instituição Científica, Tecnológica e de Inovação (ICT) sem fins lucrativos para a administração pública '+
      'direta, autarquias e fundações públicas ou para o contribuinte sujeito ao regime regular do IBS e da CBS, observado o disposto no art. 156  da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200016''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações relacionadas ao FGTS, considerando aquelas necessárias à aplicação da Lei nº 8.036, de 1990, realizadas pelo Conselho Curador ou Secretaria Executiva do '+
      'FGTS, observado o art. 212 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200017''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações de resseguro e retrocessão ficam sujeitas à incidência à alíquota zero, inclusive quando os prêmios de resseguro e retrocessão forem cedidos ao '+
      'exterior, observado o art. 223 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200018''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Importador dos serviços financeiros seja contribuinte que realize as operações de que tratam os incisos I a V do caput do art. 182, será aplicada alíquota '+
      'zero na importação, sem prejuízo da manutenção do direito de dedução dessas despesas da base de cálculo do IBS e da CBS, segundo, observado o art. 231 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' '+
      'AND CCLASSTRIB = ''200019''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operação praticada por sociedades cooperativas optantes por regime específico do IBS e CBS, quando o associado destinar bem ou serviço à cooperativa '+
      'de que participa, e a cooperativa fornecer bem ou serviço ao associado sujeito ao regime regular do IBS e da CBS, observado o art. 271 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' '+
      'AND CCLASSTRIB = ''200020''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Serviços de transporte público coletivo de passageiros ferroviário e hidroviário urbanos, semiurbanos e metropolitanos, observado o art. 285 da Lei Complementar '+
      'nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200021''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operação originada fora da Zona Franca de Manaus que destine bem material industrializado de origem nacional a contribuinte estabelecido na Zona Franca de Manaus '+
      'que seja habilitado nos termos do art. 442 da Lei Complementar nº 214, de 2025, e sujeito ao regime regular do IBS e da CBS ou optante pelo regime do Simples Nacional de que trata o art. 12 da Lei Complementar nº 123, de 2006, '+
      'observado o art. 445 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200022''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operação realizada por indústria incentivada que destine bem material intermediário para outra indústria incentivada na Zona Franca de Manaus, desde que a entrega '+
      'ou disponibilização dos bens ocorra dentro da referida área, observado o art. 448 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200023''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operação originada fora das Áreas de Livre Comércio que destine bem material industrializado de origem nacional a contribuinte estabelecido nas Áreas de Livre '+
      'Comércio que seja habilitado nos termos do art. 456 da Lei Complementar nº 214, de 2025, e sujeito ao regime regular do IBS e da CBS ou optante pelo regime do Simples Nacional de que trata o art. 12 da Lei Complementar nº 123, '+
      'de 2006, observado o art. 463 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200024''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos serviços de educação relacionados ao Programa Universidade para Todos (Prouni), instituído pela Lei nº 11.096, de 13 de janeiro de 2005, '+
      'observado o art. 308 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200025''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Locação de imóveis localizados nas zonas reabilitadas, pelo prazo de 5 (cinco) anos, contado da data de expedição do habite-se, e relacionados a projetos de '+
      'reabilitação urbana de zonas históricas e de áreas críticas de recuperação e reconversão urbanística dos Municípios ou do Distrito Federal, a serem delimitadas por lei municipal ou distrital, observado o art. 158 da Lei '+
      'Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200026''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações de locação, cessão onerosa e arrendamento de bens imóveis, observado o art. 261 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND '+
      'CCLASSTRIB = ''200027''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos serviços de educação relacionados no Anexo II da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da '+
      'Nomenclatura Brasileira de Serviços, Intangíveis e Outras Operações que Produzam Variações no Patrimônio (NBS), observado o art. 129 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200028''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos serviços de saúde humana relacionados no Anexo III da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações '+
      'da NBS, observado o art. 130 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200029''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Venda dos dispositivos médicos relacionados no Anexo IV da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NCM/SH, '+
      'observado o art. 131 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200030''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos dispositivos de acessibilidade próprios para pessoas com deficiência relacionados no Anexo V da Lei Complementar nº 214, de 2025, com a especificação'+
      ' das respectivas classificações da NCM/SH, observado o art. 132 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200031''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos medicamentos registrados na Anvisa ou produzidos por farmácias de manipulação, ressalvados os medicamentos sujeitos à alíquota zero de que trata o '+
      'art. 141 da Lei Complementar nº 214, de 2025, observado o art. 133 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200032''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento das composições para nutrição enteral e parenteral, composições especiais e fórmulas nutricionais destinadas às pessoas com erros inatos do metabolismo '+
      'relacionadas no Anexo VI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NCM/SH, observado o art. 133 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200033''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos alimentos destinados ao consumo humano relacionados no Anexo VII da Lei Complementar nº 214, de 2025, com a especificação das respectivas '+
      'classificações da NCM/SH, observado o art. 135 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200034''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos produtos de higiene pessoal e limpeza relacionados no Anexo VIII da Lei Complementar nº 214, de 2025, com a especificação das respectivas '+
      'classificações da NCM/SH, observado o art. 136 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200035''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento de produtos agropecuários, aquícolas, pesqueiros, florestais e extrativistas vegetais in natura, observado o art. 137 da Lei Complementar nº '+
      '214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200036''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento de serviços ambientais de conservação ou recuperação da vegetação nativa, mesmo que fornecidos sob a forma de manejo sustentável de sistemas '+
      'agrícolas, agroflorestais e agrossilvopastoris, em conformidade com as definições e requisitos da legislação específica, observado o art. 137 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200037''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos insumos agropecuários e aquícolas relacionados no Anexo IX da Lei Complementar nº 214, de 2025, com a especificação das respectivas '+
      'classificações da NCM/SH e da NBS, observado o art. 138 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200038''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos serviços e o licenciamento ou cessão dos direitos relacionados no Anexo X da Lei Complementar nº 214, de 2025, com a especificação das '+
      'respectivas classificações da NBS, quando destinados às seguintes produções nacionais artísticas, culturais, de eventos, jornalísticas e audiovisuais: espetáculos teatrais, circenses e de dança, shows musicais, desfiles '+
      'carnavalescos ou folclóricos, eventos acadêmicos e científicos, como congressos, conferências e simpósios, feiras de negócios, exposições, feiras e mostras culturais, artísticas e literárias; programas de auditório ou '+
      'jornalísticos, filmes, documentários, séries, novelas, entrevistas e clipes musicais, observado o art. 139 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200039''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento dos seguintes serviços de comunicação institucional à administração pública direta, autarquias e fundações públicas: serviços direcionados ao'+
      'planejamento, criação, programação e manutenção de páginas eletrônicas da administração pública, ao monitoramento e gestão de suas redes sociais e à otimização de páginas e canais digitais para mecanismos de buscas e '+
      'produção de mensagens, infográficos, painéis interativos e conteúdo institucional, serviços de relações com a imprensa, que reúnem estratégias organizacionais para promover e reforçar a comunicação dos órgãos e das '+
      'entidades contratantes com seus públicos de interesse, por meio da interação com profissionais da imprensa, e serviços de relações públicas, que compreendem o esforço de comunicação planejado, coeso e contínuo que tem '+
      'por objetivo estabelecer adequada percepção da atuação e dos objetivos institucionais, a partir do estímulo à compreensão mútua e da manutenção de padrões de relacionamento e fluxos de informação entre os órgãos e as '+
      'entidades contratantes e seus públicos de interesse, no País e no exterior, observado o art. 140 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200040''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações relacionadas às seguintes atividades desportivas: fornecimento de serviço de educação desportiva, classificado no código 1.2205.12.00 da NBS, '+
      'e gestão e exploração do desporto por associações e clubes esportivos filiados ao órgão estadual ou federal responsável pela coordenação dos desportos, inclusive por meio de venda de ingressos para eventos desportivos, '+
      'fornecimento oneroso ou não de bens e serviços, inclusive ingressos, por meio de programas de sócio-torcedor, cessão dos direitos desportivos dos atletas e transferência de atletas para outra entidade desportiva ou seu retorno '+
      'à atividade em outra entidade desportiva, observado o art. 141 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200041''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações relacionadas ao fornecimento de serviço de educação desportiva, classificado no código 1.2205.12.00 da NBS, observado o art. 141 da Lei Complementar '+
      'nº 214, de 2025. Operações relacionadas às seguintes atividades desportivas: operações e prestações de serviços de segurança da informação e segurança cibernética, observado o art. 141 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''200'' AND CCLASSTRIB = ''200042''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento à administração pública direta, autarquias e fundações púbicas dos serviços e dos bens relativos à soberania e à segurança nacional, à segurança '+
      'da informação e à segurança cibernética relacionados no Anexo XI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NBS e da NCM/SH, observado o art. 142 da Lei Complementar nº 214, de '+
      '2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200043''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações e prestações de serviços de segurança da informação e segurança cibernética desenvolvidos por sociedade que tenha sócio brasileiro com o mínimo de 20% '+
      '(vinte por cento) do seu capital social, relacionados no Anexo XI da Lei Complementar nº 214, de 2025, com a especificação das respectivas classificações da NBS e da NCM/SH, observado o art. 142 da Lei Complementar nº 214, de '+
      '2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200044''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações relacionadas a projetos de reabilitação urbana de zonas históricas e de áreas críticas de recuperação e reconversão urbanística dos Municípios ou do '+
      'Distrito Federal, a serem delimitadas por lei municipal ou distrital, observado o art. 158 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200045''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações com bens imóveis, observado o art. 261 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200046''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Bares e Restaurantes, observado o art. 275 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200047''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Hotelaria, Parques de Diversão e Parques Temáticos, observado o art. 281 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200048''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Transporte coletivo de passageiros rodoviário, ferroviário e hidroviário intermunicipais e interestaduais, observado o art. 286 da Lei Complementar nº 214, de '+
      '2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200049''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Serviços de transporte aéreo regional coletivo de passageiros ou de carga, observado o art. 287 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND '+
      'CCLASSTRIB = ''200450''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Agências de Turismo, observado o art. 289 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' AND CCLASSTRIB = ''200051''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Prestação de serviços das seguintes profissões intelectuais de natureza científica, literária ou artística, submetidas à fiscalização por conselho profissional: '+
      'administradores, advogados, arquitetos e urbanistas, assistentes sociais, bibliotecários, biólogos, contabilistas, economistas, economistas domésticos, profissionais de educação física, engenheiros e agrônomos, estatísticos, '+
      'médicos veterinários e zootecnistas, museólogos, químicos, profissionais de relações públicas, técnicos industriais e técnicos agrícolas, observado o art. 127 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''200'' '+
      'AND CCLASSTRIB = ''200052''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Redutor social aplicado uma única vez na alienação de bem imóvel residencial novo, observado o art. 259 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''210'' AND CCLASSTRIB = ''210001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Redutor social aplicado uma única vez na alienação de lote residencial, observado o art. 259 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''210'' AND '+
      'CCLASSTRIB = ''210002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Redutor social em operações de locação, cessão onerosa e arrendamento de bens imóveis de uso residencial, observado o art. 260 da Lei Complementar nº 214, de '+
      '2025.'' WHERE CST = ''210'' AND CCLASSTRIB = ''210003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Incorporação imobiliária submetida ao regime especial de tributação, observado o art. 485 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''220'' AND '+
      'CCLASSTRIB = ''220001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Incorporação imobiliária submetida ao regime especial de tributação, observado o art. 485 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''220'' AND '+
      'CCLASSTRIB = ''220002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Alienação de imóvel decorrente de parcelamento do solo, observado o art. 486 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''220'' AND CCLASSTRIB = ''220003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Locação, cessão onerosa ou arrendamento de bem imóvel com alíquota sobre a receita bruta, observado o art. 487 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''221'' '+
      'AND CCLASSTRIB = ''221001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Transporte internacional de passageiros, caso os trechos de ida e volta sejam vendidos em conjunto, a base de cálculo será a metade do valor cobrado, observado o Art. '+
      '12 § 8º da Lei Complementar nº 214, de 2025.'' WHERE CST = ''222'' AND CCLASSTRIB = ''222001''; ');

    except
      on E : Exception do
      begin
        raise Exception.Create('Erro ao atualizar os dados na CClassTrib_CBSIBS 2 ' + #13#10 + e.Message);
      end;
    end;
  finally

  end;
end;

procedure TEstrutura_Tab_RegTributario.CClassTrib_CBSIBS_4;
begin
  try
    try
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''400'',''Isenção'',''400001'',''Fornecimento de serviços de transporte público coletivo de passageiros rodoviário e metroviário'',''Art. 157'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410001'',''Fornecimento de bonificações quando constem no documento fiscal e que não dependam de evento posterior'',''Art. 5º,§ 1º,I'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410002'',''Transferências entre estabelecimentos pertencentes ao mesmo contribuinte'',''Art. 6º,II'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410003'',''Doações sem contraprestação em benefício do doador'',''Art. 6º,VIII'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410004'',''Exportações de bens e serviços'',''Art. 8º'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410005'',''Fornecimentos realizados pela União,pelos Estados,pelo Distrito Federal e pelos Municípios'',''Art. 9º,I e § 1º'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410006'',''Fornecimentos realizados por entidades religiosas e templos de qualquer culto'',''Art. 9º,II'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410007'',''Fornecimentos realizados por partidos políticos'',''Art. 9º,III'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410008'',''Fornecimentos de livros,jornais,periódicos e do papel destinado a sua impressão'',''Art. 9º,IV'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410009'',''Fornecimentos de fonogramas e videofonogramas musicais produzidos no Brasil'',''Art. 9º,V'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410010'',''Fornecimentos de serviço de comunicação nas modalidades de radiodifusão sonora e de sons e imagens de recepção livre e gratuita'',''Art. 9º,VI'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410011'',''Fornecimentos de ouro,quando definido em lei como ativo financeiro ou instrumento cambial'',''Art. 9º,VII'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410012'',''Fornecimento de condomínio edilício não optante pelo regime regular'',''Art. 26,§ 2º,II'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410013'',''Exportações de combustíveis'',''Art. 98'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410014'',''Fornecimento de produtor rural não contribuinte'',''Art. 164'',''Sem alíquota'',0,0,0,0,1,0,0,0,0,''Adquirente. Art. 168. Alíquota fixa por produto''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410015'',''Fornecimento por transportador autônomo não contribuinte'',''Art. 169'',''Sem alíquota'',0,0,0,0,1,0,0,0,0,''Adquirente. Art. 168. Alíquota fixa por produto''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410016'',''Fornecimento ou aquisição de resíduos sólidos'',''Art. 170'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410017'',''Aquisição de bem móvel com crédito presumido sob condição de revenda realizada'',''Art. 171'',''Sem alíquota'',0,0,0,0,1,0,0,0,0,''Adquirente. UTILIZADO SOMENTE NA VENDA,É O ÚNICO CASO. 	Art.'+
      ' 171. Fase de transição e após da transição''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410018'',''Operações relacionadas aos fundos garantidores e executores de políticas públicas'',''Art. 213'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410019'',''Exclusão da gorjeta na base de cálculo no fornecimento de alimentação'',''Art. 274,I'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410020'',''Exclusão do valor de intermediação na base de cálculo no fornecimento de alimentação'',''Art. 274,II'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410021'',''Contribuição de que trata o art. 149-A da Constituição Federal'',''Art. 12 § 2º'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''410'',''Imunidade e não incidência'',''410999'',''Operações não onerosas sem previsão de tributação,não especificadas anteriormente'',''Art. 4º,§ 1º'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');


      //Atualizando dados...
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento de serviços de transporte público coletivo de passageiros rodoviário e metroviário de caráter urbano, semiurbano e metropolitano, sob regime de autorização, '+
      'permissão ou concessão pública, observado o art. 157 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''400'' AND CCLASSTRIB = ''400001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento de bonificações quando constem do respectivo documento fiscal e que não dependam de evento posterior, observado o art. 5º da Lei Complementar nº 214, de '+
      '2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Transferências entre estabelecimentos pertencentes ao mesmo contribuinte, observado o art. 6º da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND '+
      'CCLASSTRIB = ''410002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Doações, observado o art. 6º da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Exportações de bens e serviços, observado o art. 8º da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410004''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimentos realizados pela União, pelos Estados, pelo Distrito Federal e pelos Municípios, observado o art. 9º da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''410'' AND CCLASSTRIB = ''410005''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimentos realizados por entidades religiosas e templos de qualquer culto, inclusive suas organizações assistenciais e beneficentes, observado o art. '+
      '9º da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410006''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimentos realizados por partidos políticos, inclusive suas fundações, entidades sindicais dos trabalhadores e instituições de educação e de assistência'+
      ' social, sem fins lucrativos, observado o art. 9º da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410007''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimentos de livros, jornais, periódicos e do papel destinado a sua impressão, observado o art. 9º da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' '+
      'AND CCLASSTRIB = ''410008''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimentos de fonogramas e videofonogramas musicais produzidos no Brasil contendo obras musicais ou literomusicais de autores brasileiros e/ou obras em geral '+
      'interpretadas por artistas brasileiros, bem como os suportes materiais ou arquivos digitais que os contenham, salvo na etapa de replicação industrial de mídias ópticas de leitura a laser, observado o art. 9º da Lei Complementar nº '+
      '214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410009''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimentos de serviço de comunicação nas modalidades de radiodifusão sonora e de sons e imagens de recepção livre e gratuita, observado o art. 9º da Lei '+
      'Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410010''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimentos de ouro, quando definido em lei como ativo financeiro ou instrumento cambial, observado o art. 9º da Lei Complementar nº 214, de 2025.'' WHERE '+
      'CST = ''410'' AND CCLASSTRIB = ''410011''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento de condomínio edilício não optante pelo regime regular, observado o art. 26 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND '+
      'CCLASSTRIB = ''410012''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Exportações de combustíveis, observado o art. 98 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410013''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento de produtor rural não contribuinte, observado o art. 164 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410014''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento por transportador autônomo não contribuinte, observado o art. 169 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410015''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fornecimento ou aquisição de resíduos sólidos, observado o art. 170 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410016''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Aquisição de bem móvel com crédito presumido sob condição de revenda realizada, observado o art. 171 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' '+
      'AND CCLASSTRIB = ''410017''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações relacionadas aos fundos garantidores e executores de políticas públicas, inclusive de habitação, previstos em lei, assim entendidas os serviços '+
      'prestados ao fundo pelo seu agente operador e por entidade encarregada da sua administração, observado o art. 213 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' AND CCLASSTRIB = ''410018''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Exclusão da gorjeta na base de cálculo no fornecimento de alimentação, observado o art. 274 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' '+
      'AND CCLASSTRIB = ''410019''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Exclusão do valor de intermediação na base de cálculo no fornecimento de alimentação, observado o art. 274 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''410'' AND CCLASSTRIB = ''410020''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Contribuição de que trata o art. 149-A da Constituição Federal, observado o art. 12 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''410'' '+
      'AND CCLASSTRIB = ''410021''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações não onerosas sem previsão de tributação, não especificadas anteriormente, observado o art. 4º da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''410'' AND CCLASSTRIB = ''410999''; ');
    except
      on E : Exception do
      begin
        raise Exception.Create('Erro ao inserir os dados na CClassTrib_CBSIBS 4 ' + #13#10 + e.Message);
      end;
    end;
  finally

  end;
end;

procedure TEstrutura_Tab_RegTributario.CClassTrib_CBSIBS_5;
begin
  try
    try
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''510'',''Diferimento'',''510001'',''Operações,sujeitas a diferimento,com energia elétrica,relativas à geração,comercialização,distribuição e transmissão'',''Art. 28,§ 1º'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''510'',''Diferimento'',''510002'',''Operações,sujeitas a diferimento,com insumos agropecuários e aquícolas destinados a produtor rural contribuinte (Anexo IX)'',''Art. 138,§ 2º'',''Sem alíquota'',0,0,0,0,1,0,0,0,0,''Adquirente. Art. 168. 	'+
      'cCredPres 1''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550001'',''Exportações de bens materiais'',''Art. 82'',''Sem alíquota'',0,0,0,1,1,0,0,0,0,''Fornecedor: Única situação: Regime automotivo - projetos incentivados,observado o art. 312 da Lei Complementar nº 214,de 2025. '+
      'cCredPress 5''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550002'',''Regime de Trânsito'',''Art. 84'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550003'',''Regimes de Depósito  (art. 85)'',''Art. 85'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550004'',''Regimes de Depósito (art. 87)'',''Art. 87'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550005'',''Regimes de Depósito (art. 87,Parágrafo único)'',''Art. 87,parágrafo único'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550006'',''Regimes de Permanência Temporária'',''Art. 88'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550007'',''Regimes de Aperfeiçoamento'',''Art. 90'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550008'',''Importação de bens para o Regime de Repetro-Temporário'',''Art. 93,I'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550009'',''GNL-Temporário'',''Art. 93,II'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550010'',''Repetro-Permanente'',''Art. 93,III'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550011'',''Repetro-Industrialização'',''Art. 93,IV'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550012'',''Repetro-Nacional'',''Art. 93,V'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550013'',''Repetro-Entreposto'',''Art. 93,VI'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550014'',''Zona de Processamento de Exportação'',''Arts. 99,100 e 102'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550015'',''Regime Tributário para Incentivo à Modernização e à Ampliação da Estrutura Portuária'',''Art. 105'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550016'',''Regime Especial de Incentivos para o Desenvolvimento da Infraestrutura'',''Art. 106'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550017'',''Regime Tributário para Incentivo à Atividade Econômica Naval'',''Art. 107'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550018'',''Desoneração da aquisição de bens de capital'',''Art. 109'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550019'',''Importação de bem material por indústria incentivada para utilização na ZFM'',''Art. 443'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''550'',''Suspensão'',''550020'',''Áreas de livre comércio'',''Art. 461'',''Sem alíquota'',0,0,0,1,0,0,0,0,0,''''); ');

      //Atualizando...
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações, sujeitas a diferimento, com energia elétrica ou com direitos a ela relacionados, relativas à geração, comercialização, distribuição e transmissão, observado o art. '+
      '28 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''510'' AND CCLASSTRIB = ''510001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Operações, sujeitas a diferimento, com insumos agropecuários e aquícolas destinados a produtor rural contribuinte, observado o art. 138 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''510'' AND CCLASSTRIB = ''510002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Exportações de bens materiais, observado o art. 82 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regime de Trânsito, observado o art. 84 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regimes de Depósito, observado o art. 85 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regimes de Depósito, observado o art. 87 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550004''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regimes de Depósito, observado o art. 87 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550005''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regimes de Permanência Temporária, observado o art. 88 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550006''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regimes de Aperfeiçoamento, observado o art. 90 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550007''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Importação de bens para o Regime de Repetro-Temporário, de que tratam o inciso I do art. 93 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' '+
      'AND CCLASSTRIB = ''550008''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''GNL-Temporário, de que trata o inciso II do art. 93 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550009''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Repetro-Permanente, de que trata o inciso III do art. 93 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550010''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Repetro-Industrialização, de que trata o inciso IV do art. 93 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550011''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Repetro-Nacional, de que trata o inciso V do art. 93 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550012''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Repetro-Entreposto, de que trata o inciso VI do art. 93 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550013''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Zona de Processamento de Exportação, observado os arts. 99, 100 e 102 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550014''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regime Tributário para Incentivo à Modernização e à Ampliação da Estrutura Portuária - Reporto, observado o art. 105 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''550'' AND CCLASSTRIB = ''550015''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regime Especial de Incentivos para o Desenvolvimento da Infraestrutura - Reidi, observado o art. 106 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' '+
      'AND CCLASSTRIB = ''550016''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Regime Tributário para Incentivo à Atividade Econômica Naval – Renaval, observado o art. 107 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' '+
      'AND CCLASSTRIB = ''550017''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Desoneração da aquisição de bens de capital, observado o art. 109 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550018''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Importação de bem material por indústria incentivada para utilização na Zona Franca de Manaus, observado o art. 443 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''550'' AND CCLASSTRIB = ''550019''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Áreas de livre comércio, observado o art. 461 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''550'' AND CCLASSTRIB = ''550020''; ');

    except
      on E : Exception do
      begin
        raise Exception.Create('Erro ao inserir os dados na CClassTrib_CBSIBS 5 ' + #13#10 + e.Message);
      end;
    end;
  finally

  end;
end;

procedure TEstrutura_Tab_RegTributario.CClassTrib_CBSIBS_6;
begin
  try
    try
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''620'',''Tributação monofásica'',''620001'',''Tributação monofásica sobre combustíveis'',''Art. 172,179 I'',''Uniforme setorial'',0,0,0,0,0,1,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''620'',''Tributação monofásica'',''620002'',''Tributação monofásica com responsabilidade pela retenção sobre combustíveis'',''Art. 178'',''Uniforme setorial'',0,0,0,0,0,1,1,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''620'',''Tributação monofásica'',''620003'',''Tributação monofásica com tributos retidos por responsabilidade sobre combustíveis'',''Art. 178'',''Uniforme setorial'',0,0,0,0,0,0,0,0,1,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''620'',''Tributação monofásica'',''620004'',''Tributação monofásica sobre mistura de EAC com gasolina A em percentual superior ao obrigatório'',''Art. 179,II,a'',''Uniforme setorial'',0,0,0,0,0,1,0,1,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''620'',''Tributação monofásica'',''620005'',''Tributação monofásica sobre mistura de EAC com gasolina A em percentual inferior ao obrigatório'',''Art. 179,II,b'',''Uniforme setorial'',0,0,0,0,0,0,0,1,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''620'',''Tributação monofásica'',''620006'',''Tributação monofásica sobre combustíveis cobrada anteriormente'',''Art. 180'',''Uniforme setorial'',0,0,0,0,0,0,0,1,0,''''); ');


      //Atualizando....
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Tributação monofásica sobre combustíveis, observados os art. 172 e   art. 179 I da Lei Complementar nº 214, de 2025.'' WHERE CST = ''620'' AND CCLASSTRIB = ''620001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Tributação monofásica com responsabilidade pela retenção sobre combustíveis, observado o art. 178 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''620'' '+
      'AND CCLASSTRIB = ''620002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Tributação monofásica com tributos retidos por responsabilidade sobre combustíveis, observado o art. 178 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''620'' '+
      'AND CCLASSTRIB = ''620003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Tributação monofásica sobre mistura de EAC com gasolina A em percentual superior ou inferior ao obrigatório, observado o art. 179 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''620'' AND CCLASSTRIB = ''620004''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Tributação monofásica sobre mistura de EAC com gasolina A em percentual superior ou inferior ao obrigatório, observado o art. 179 da Lei Complementar nº 214, de 2025.'' '+
      'WHERE CST = ''620'' AND CCLASSTRIB = ''620005''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Tributação monofásica sobre combustíveis cobrada anteriormente, observador o art. 180 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''620'' AND CCLASSTRIB = ''620006''; ');


    except
      on E : Exception do
      begin
        raise Exception.Create('Erro ao inserir os dados na CClassTrib_CBSIBS 6 ' + #13#10 + e.Message);
      end;
    end;
  finally

  end;
end;

procedure TEstrutura_Tab_RegTributario.CClassTrib_CBSIBS_8;
begin
  try
    try
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''800'',''Transferência de crédito'',''800001'',''Fusão,cisão ou incorporação'',''Art. 55'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''800'',''Transferência de crédito'',''800002'',''Transferência de crédito do associado,inclusive as cooperativas singulares'',''Art. 272'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''810'',''Ajustes'',''810001'',''Crédito presumido sobre o valor apurado nos fornecimentos a partir da ZFM'',''Art. 450'',''Sem alíquota'',0,0,0,0,1,0,0,0,0,''Fornecedor''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''820'',''Tributação em declaração de regime específico'',''820001'',''Documento com informações de fornecimento de serviços de planos de assistência à saúde'',''Art. 235'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''820'',''Tributação em declaração de regime específico'',''820002'',''Documento com informações de fornecimento de serviços de planos de assistência funerária'',''Art. 236'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''820'',''Tributação em declaração de regime específico'',''820003'',''Documento com informações de fornecimento de serviços de planos de assistência à saúde de animais domésticos'',''Art. 243'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''820'',''Tributação em declaração de regime específico'',''820004'',''Documento com informações de prestação de serviços de consursos de prognósticos'',''Art. 248'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''820'',''Tributação em declaração de regime específico'',''820005'',''Documento com informações de alienação de bens imóveis'',''Art. 254,§ 1º'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''820'',''Tributação em declaração de regime específico'',''820006'',''Documento com informações de fornecimento de serviços de exploração de via'',''Art. 11,VIII'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');
      ExecutaScript('INSERT INTO CCLASSTRIB_CBSIBS(CST,DESCRICAO_CST,CCLASSTRIB,NOME_CCLASSTRIB,ARTIGO_LC,TIPO_ALIQUOTA,P_RED_IBS,P_RED_CBS,IND_RED_BC,IND_TRIB_REGUAR,IND_CRED_PRES,IND_MONO,IND_MONO_RETEN,IND_MONO_RET,IND_MONO_DIF,CREDITO_PARA) VALUES('+
      ' ''830'',''Exclusão de base de cálculo'',''830001'',''Documento com exclusão da BC da CBS e do IBS de energia elétrica fornecida pela distribuidora à UC'',''Art 28, parágrafos 3° e 4°'',''Sem alíquota'',0,0,0,0,0,0,0,0,0,''''); ');

      //Atualização...
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Fusão, cisão ou incorporação, observado o art. 55 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''800'' AND CCLASSTRIB = ''800001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Transferência de crédito do associado, inclusive as cooperativas singulares, para cooperativa de que participa das operações antecedentes às operações em que fornece bens e '+
      'serviços e os créditos presumidos, observado o art. 272 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''800'' AND CCLASSTRIB = ''800002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Crédito presumido sobre o valor apurado nos fornecimentos a partir da Zona Franca de Manaus, observado o art. 450 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''810'' '+
      'AND CCLASSTRIB = ''810001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Documento com informações de fornecimento de serviços de planos de assinstência à saúde, mas com tributação realizada por outro meio, observado o art. 235 da Lei Complementar '+
      'nº 214, de 2025.'' WHERE CST = ''820'' AND CCLASSTRIB = ''820001''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Documento com informações de fornecimento de serviços de planos de assinstência funerária, mas com tributação realizada por outro meio, observado o art. 236 da Lei Complementar '+
      'nº 214, de 2025.'' WHERE CST = ''820'' AND CCLASSTRIB = ''820002''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Documento com informações de fornecimento de serviços de planos de assinstência à saúde de animais domésticos, mas com tributação realizada por outro meio, observado o art. '+
      '243 da Lei Complementar nº 214, de 2025.'' WHERE CST = ''820'' AND CCLASSTRIB = ''820003''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Documento com informações de prestação de serviços de consursos de prognósticos, mas com tributação realizada por outro meio, observado o art. 248 da Lei Complementar nº '+
      '214, de 2025.'' WHERE CST = ''820'' AND CCLASSTRIB = ''820004''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Documento com informações de alienação de bens imóveis, mas com tributação realizada por outro meio,, observado o art. 254 da Lei Complementar nº 214, de 2025.'' WHERE '+
      'CST = ''820'' AND CCLASSTRIB = ''820005''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Documento com informações de fornecimento de serviços de exploração de via, mas com tributação realizada por outro meio, observado o art. 11 da Lei Complementar nº 214, '+
      'de 2025.'' WHERE CST = ''820'' AND CCLASSTRIB = ''820006''; ');
      ExecutaScript('UPDATE CCLASSTRIB_CBSIBS SET DESCRICAO_CCLASSTRIB = ''Documento com  exclusão da base de cálculo da CBS e do IBS refrente à energia elétrica fornecida pela distribuidora à unidade consumidora, conforme  Art 28, parágrafos 3° '+
      'e 4°.'' WHERE CST = ''830'' AND CCLASSTRIB = ''830001''; ');

    except
      on E : Exception do
      begin
        raise Exception.Create('Erro ao inserir os dados na CClassTrib_CBSIBS 8 ' + #13#10 + e.Message);
      end;
    end;
  finally

  end;
end;


procedure TEstrutura_Tab_RegTributario.ANEXO_REDUCAO;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: ANEXO_REDUCAO');//8

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('ANEXO_REDUCAO','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE ANEXO_REDUCAO ( ');
      sSqlTxt.Add('    ID     INTEGER NOT NULL, ');
      sSqlTxt.Add('    ANEXO  VARCHAR(3), ');
      sSqlTxt.Add('    NCM    VARCHAR(8), ');
      sSqlTxt.Add('    NBS    VARCHAR(8), ');
      sSqlTxt.Add('    P_RED  NUMERIC(15,2) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_ANEXO_REDUCAO_ID; ');

      ExecutaScript('ALTER TABLE ANEXO_REDUCAO ADD CONSTRAINT PK_ANEXO_REDUCAO PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE ANEXO_REDUCAO IS ''TABELA DE ANEXO PARA REDUCAO''; ');
      ExecutaScript('COMMENT ON COLUMN ANEXO_REDUCAO.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN ANEXO_REDUCAO.ANEXO IS ''CODIGO DO ANEXO''; ');
      ExecutaScript('COMMENT ON COLUMN ANEXO_REDUCAO.NCM IS ''NOMENCLARURA COMUM DO MERCOSUL''; ');
      ExecutaScript('COMMENT ON COLUMN ANEXO_REDUCAO.NBS IS ''NBS''; ');
      ExecutaScript('COMMENT ON COLUMN ANEXO_REDUCAO.P_RED IS ''PERCENTUAL DE REDUCAO''; ');
    end;

    if ExecutaRecurso('ANEXO_REDUCAO_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER ANEXO_REDUCAO_BI FOR ANEXO_REDUCAO ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.ID IS NULL) THEN ');
      sSqlTxt.Add('    NEW.ID = GEN_ID(GEN_ANEXO_REDUCAO_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela CCLASSTRIB_CBSIBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.CST_CBSIBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: CST_CBSIBS');//9

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('CST_CBSIBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE CST_CBSIBS ( ');
      sSqlTxt.Add('    ID             INTEGER NOT NULL, ');
      sSqlTxt.Add('    CST            VARCHAR(3), ');
      sSqlTxt.Add('    DESCRICAO      VARCHAR(100), ');
      sSqlTxt.Add('    G_IBSCBS       INTEGER, ');
      sSqlTxt.Add('    G_IBSCBS_MONO  INTEGER, ');
      sSqlTxt.Add('    G_RED          INTEGER, ');
      sSqlTxt.Add('    G_DIF          INTEGER, ');
      sSqlTxt.Add('    G_TRANSCRED    INTEGER, ');
      sSqlTxt.Add('    IND_NFE        INTEGER, ');
      sSqlTxt.Add('    IND_NFCE       INTEGER, ');
      sSqlTxt.Add('    IND_CTE        INTEGER, ');
      sSqlTxt.Add('    IND_CTEOS      INTEGER, ');
      sSqlTxt.Add('    IND_BPE        INTEGER, ');
      sSqlTxt.Add('    IND_BPETM      INTEGER, ');
      sSqlTxt.Add('    IND_NF3E       INTEGER, ');
      sSqlTxt.Add('    IND_NFCOM      INTEGER, ');
      sSqlTxt.Add('    IND_NFSE       INTEGER ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_CST_CBSIBS_ID; ');

      ExecutaScript('ALTER TABLE CST_CBSIBS ADD CONSTRAINT PK_CST_CBSIBS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE CST_CBSIBS IS ''CST do CBS e IBS (Contribuicao sobre Bens e Sercicos, Imposto sobre Bens e Sercicos)''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.CST IS ''CODIGO DE SITUACAO TRIBUTARIA''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.DESCRICAO IS ''DESCRICAO''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.G_IBSCBS IS ''GERA IBS E CBS: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.G_IBSCBS_MONO IS ''GERA IBS E CBS MONO: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.G_RED IS ''GERA REDUCAO: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.G_DIF IS ''GERA DIFERENCIAL: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.G_TRANSCRED IS ''GERA TRANSFERENCIA DE CREDITO: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_NFE IS ''INDICADOR DE NFE: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_NFCE IS ''INDICADOR DE NFCE: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_CTE IS ''INDICADOR DE CTE: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_CTEOS IS ''INDICADOR DE CTE OS: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_BPE IS ''INDICADOR DE BPE: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_BPETM IS ''INDICADOR DE BPE TM: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_NF3E IS ''INDICADOR DE NF3E: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_NFCOM IS ''INDICADOR DE NFCOM: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.IND_NFSE IS ''INDICADOR DE NFSE: ' + sLineBreak +
        '0-NAO ' + sLineBreak +
        '1-SIM''; ');
    end;

    if ExecutaRecurso('CST_CBSIBS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER CST_CBSIBS_BI FOR CST_CBSIBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.ID IS NULL) THEN ');
      sSqlTxt.Add('    NEW.ID = GEN_ID(GEN_CST_CBSIBS_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

    if not FieldExists('CST_CBSIBS','IND_GCREDPRESIBSZFM') then
    begin
      ExecutaScript('ALTER TABLE CST_CBSIBS ADD ind_gCredPresIBSZFM INTEGER DEFAULT 0;');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.ind_gCredPresIBSZFM IS ''Indicador de preenchimento do grupo de Credito Presumido – Zona Franca de Manaus (ZFM) '+sLineBreak+
      ' 0-Nao' +sLineBreak+
      ' 1-Sim'';');
    end;

    if not FieldExists('CST_CBSIBS','IND_GAJUSTECOMPET') then
    begin
      ExecutaScript('ALTER TABLE CST_CBSIBS ADD ind_gAjusteCompet INTEGER DEFAULT 0;');
      ExecutaScript('COMMENT ON COLUMN CST_CBSIBS.ind_gAjusteCompet IS ''Indicador de preenchimento do grupo de Ajuste de Competência '+sLineBreak+
      ' 0-Nao' +sLineBreak+
      ' 1-Sim'';');
    end;


    {Descontinuado... Será baixado e atualziado por um serviuço
    if ExecutaRecurso('CST_CBSIBS_REGISTROS',1) then
    begin
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''000'',''Tributação integral'',1,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''010'',''Tributação com alíquotas uniformes'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''011'',''Tributação com alíquotas uniformes reduzidas'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''200'',''Alíquota reduzida'',1,0,1,0,0,1,1,1,1,1,1,1,1,1,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''220'',''Alíquota fixa'',1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''222'',''Redução de base de cálculo'',1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''221'',''Alíquota fixa proporcional'',0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''400'',''Isenção'',0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''410'',''Imunidade e 0 incidência'',0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''510'',''Diferimento'',1,0,0,1,0,1,1,0,0,0,0,1,0,1,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''550'',''Suspensão'',1,0,0,0,0,1,0,0,0,0,0,1,0,1,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''620'',''Tributação monofásica'',0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''800'',''Transferência de crédito'',0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''810'',''Ajustes'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''820'',''Tributação em declaração de regime específico'',0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''830'',''Exclusão de base de cálculo'',1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0); ');
    end;

    if ExecutaRecurso('CST_CBSIBS_REGISTROS_1',7) then
    begin
      ExecutaScript('DELETE FROM CST_CBSIBS WHERE CST = ''210'';');

      ExecutaScript('UPDATE CST_CBSIBS SET IND_GCREDPRESIBSZFM = 0, IND_GAJUSTECOMPET = 0');

      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, IND_GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''515'',''DIFERIMENTO COM REDUÇÃO DE ALÍQUOTA'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, IND_GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''810'',''AJUSTE DE IBS NA ZFM'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0); ');
      ExecutaScript('INSERT INTO CST_CBSIBS(CST, DESCRICAO, G_IBSCBS, G_IBSCBS_MONO, G_RED, G_DIF, G_TRANSCRED, IND_NFE, IND_NFCE, IND_CTE, IND_CTEOS, IND_BPE, IND_BPETM, IND_NF3E, IND_NFCOM, IND_NFSE, IND_GCREDPRESIBSZFM, IND_GAJUSTECOMPET) VALUES('+
                    ' ''811'',''AJUSTE'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1); ');
    end;
    }
  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela CCLASSTRIB_CBSIBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Atualiza_Versao_QrCode;
var
  FIniFile :TIniFile;
  FArq :String;
begin
  Progresso_Rotina('Tabela: Atualizar versão QrCode');//19

  try
    FArq := '';
    FArq := Dir_Sistema+'\cfg\nfe_'+zerar(inttostr(codigo_empresa),6)+'.ini';
    FIniFile := TIniFile.Create(FArq);
    
    if ExecutaRecurso('ATUALIZA_VERSAO_QRCODE',3) then
      FIniFile.WriteString('Geral','VersaoQRCode','3');
  finally
    FreeAndNil(FIniFile);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Credito_Presumido;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: Credito_Presumido');//10

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('CREDITO_PRESUMIDO_IBSCBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE CREDITO_PRESUMIDO_IBSCBS ( ');
      sSqlTxt.Add('    ID                        INTEGER NOT NULL, ');
      sSqlTxt.Add('    CCREDPRES                 INTEGER NOT NULL, ');
      sSqlTxt.Add('    DESCRICAO                 BLOB SUB_TYPE 1 SEGMENT SIZE 4096, ');
      sSqlTxt.Add('    LC_214_2025               BLOB SUB_TYPE 1 SEGMENT SIZE 4096, ');
      sSqlTxt.Add('    APROPRIA_VIA_NF           INTEGER, ');
      sSqlTxt.Add('    APROPRIA_VIA_EVENTO       INTEGER, ');
      sSqlTxt.Add('    IND_DEDUZCREDPRES         INTEGER, ');
      sSqlTxt.Add('    IND_GCBSCREDPRES          INTEGER, ');
      sSqlTxt.Add('    IND_GIBSCREDPRES          INTEGER, ');
      sSqlTxt.Add('    ALIQUOTA_CBS              VARCHAR(255), ');
      sSqlTxt.Add('    ALIQUOTA_IBS              VARCHAR(255), ');
      sSqlTxt.Add('    PALIQCREDPRESCBS          VARCHAR(500), ');
      sSqlTxt.Add('    CCLASS_NOTA_REFERENCIADA  VARCHAR(255), ');
      sSqlTxt.Add('    DINIVIG                   DATE, ');
      sSqlTxt.Add('    DFIMVIG                   DATE ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_CREDITO_PRESUMIDO_IBSCBS_ID; ');

      ExecutaScript('ALTER TABLE CREDITO_PRESUMIDO_IBSCBS ADD CONSTRAINT PK_CREDITO_PRESUMIDO_IBSCBS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE CREDITO_PRESUMIDO_IBSCBS IS ''Tabela de Cr?dito Presumido (IBS/CBS)''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.CCREDPRES IS ''Codigo identificador do tipo de credito presumido. Neste caso, 1 representa credito presumido para aquisicoes de produtor rural nao contribuinte.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.DESCRICAO IS ''Texto explicativo sobre o tipo de credito presumido. Refere-se à aquisicao de bens e servicos de produtor rural ou produtor rural integrado'+
      ' nao contribuinte, conforme o art. 168 da LC n? 214/2025.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.LC_214_2025 IS ''Transcricao do artigo legal que fundamenta o credito presumido. O art. 168 permite a apropriacao de creditos presumidos de IBS e CBS para'+
      ' aquisicoes de produtores rurais nao contribuintes.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.APROPRIA_VIA_NF IS ''Indicador se o credito pode ser apropriado via Nota Fiscal. Valor 1 significa que sim.'+sLineBreak+
      '0-Nao'+sLineBreak+
      '1-Sim''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.APROPRIA_VIA_EVENTO IS ''Indicador se o credito pode ser apropriado via evento especifico (fora da NF). Valor 1 significa que sim.' +sLineBreak+
      '0-Nao'+sLineBreak+
      '1-Sim''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.IND_DEDUZCREDPRES IS ''Indicador se o credito presumido deve ser deduzido de outro credito. Campo vazio indica que nao ha deducao obrigatoria.'+sLineBreak+
      '0-Nao'+sLineBreak+
      '1-Sim''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.IND_GCBSCREDPRES IS ''Indicador se o credito presumido e gerador de credito para a CBS. Valor 1 significa que sim.'+sLineBreak+
      '0-Nao'+sLineBreak+
      '1-Sim''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.IND_GIBSCREDPRES IS ''Indicador se o credito presumido e gerador de credito para o IBS. Valor 1 significa que sim.'+sLineBreak+
      '0-Nao'+sLineBreak+
      '1-Sim''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.ALIQUOTA_CBS IS ''Informacao sobre a aliquota aplicavel a CBS. Neste caso, e calculada e divulgada anualmente pela Receita Federal.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.ALIQUOTA_IBS IS ''Informacao sobre a aliquota aplicavel ao IBS. Tambem calculada e divulgada anualmente.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.PALIQCREDPRESCBS IS ''Percentual da aliquota presumida aplicavel a CBS. Representado como um identificador ou formula (pAliqCalculadaCBS) que sera definido '+
      'conforme regras da Receita.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.CCLASS_NOTA_REFERENCIADA IS ''Codigo de classificacao da nota fiscal referenciada. Pode ser usado para vincular o credito presumido a uma nota especifica ou categoria tributaria.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.DINIVIG IS ''Data de inicio da vigencia da regra de credito presumido. Neste caso, 23/06/2025.''; ');
      ExecutaScript('COMMENT ON COLUMN CREDITO_PRESUMIDO_IBSCBS.DFIMVIG IS ''Data de fim da vigencia. Campo vazio indica que a regra esta vigente indefinidamente ou ate nova atualizacao.''; ');

    end;

    if ExecutaRecurso('CREDITO_PRESUMIDO_IBSCBS_BI',2) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER CREDITO_PRESUMIDO_IBSCBS_BI FOR CREDITO_PRESUMIDO_IBSCBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('as ');
      sSqlTxt.Add('begin ');
      sSqlTxt.Add('  if (new.id is null) then ');
      sSqlTxt.Add('    new.id = gen_id(gen_credito_presumido_ibscbs_id,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela CCLASSTRIB_CBSIBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.NBS_CODIGO_SERVICO;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: NBS_CODIGO_SERVICO');//11

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('NBS_CODIGO_SERVICO','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE NBS_CODIGO_SERVICO ( ');
      sSqlTxt.Add('    ID             INTEGER NOT NULL, ');
      sSqlTxt.Add('    NBS            VARCHAR(50), ');
      sSqlTxt.Add('    DESCRICAO_NBS  VARCHAR(5000) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_NBS_CODIGO_SERVICO_ID; ');
      ExecutaScript('ALTER TABLE NBS_CODIGO_SERVICO ADD CONSTRAINT PK_NBS_CODIGO_SERVICO PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE NBS_CODIGO_SERVICO IS ''Tabela de correlacao entre codigos NBS (Nomenclatura Brasileira de Servicos) e suas respectivas descri??es, utilizada para classificar os '+
      'servicos prestados na emissao de Nota Fiscal de Servico eletronica (NFS-e), conforme exigencias da Reforma Tributaria e da legislacao vigente.''; ');
      ExecutaScript('COMMENT ON COLUMN NBS_CODIGO_SERVICO.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN NBS_CODIGO_SERVICO.NBS IS ''Codigo da Nomenclatura Brasileira de Servicos (NBS), utilizado para identificar e classificar o tipo de servico prestado conforme padrao nacional.''; ');
      ExecutaScript('COMMENT ON COLUMN NBS_CODIGO_SERVICO.DESCRICAO_NBS IS ''Descricao textual do servico correspondente ao codigo NBS, conforme definido pela tabela oficial da NBS e utilizado na emissao da Nota Fiscal'+
      ' de Servico.''; ');

    end;

    if ExecutaRecurso('NBS_CODIGO_SERVICO_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER NBS_CODIGO_SERVICO_BI FOR NBS_CODIGO_SERVICO ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('as ');
      sSqlTxt.Add('begin ');
      sSqlTxt.Add('  if (new.id is null) then ');
      sSqlTxt.Add('    new.id = gen_id(gen_nbs_codigo_servico_id,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela NBS_CODIGO_SERVICO ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.CORRELACAO_NFS_NBS_IBS_CBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: CORRELACAO_NFS_NBS_IBS_CBS');//12

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('CORRELACAO_NFS_NBS_IBS_CBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE CORRELACAO_NFS_NBS_IBS_CBS ( ');
      sSqlTxt.Add('    ID                    INTEGER NOT NULL, ');
      sSqlTxt.Add('    ITEM_LC_116           VARCHAR(50), ');
      sSqlTxt.Add('    DESCRICAO_ITEM        VARCHAR(5000), ');
      sSqlTxt.Add('    NBS                   VARCHAR(50), ');
      sSqlTxt.Add('    DESCRICAO_NBS         VARCHAR(5000), ');
      sSqlTxt.Add('    PS_ONEROSA_S_N        INTEGER, ');
      sSqlTxt.Add('    ADQ_EXTERIOR_S_N      INTEGER, ');
      sSqlTxt.Add('    INDOP                 VARCHAR(50), ');
      sSqlTxt.Add('    LOCAL_INCIDENCIA_IBS  VARCHAR(5000), ');
      sSqlTxt.Add('    CCLASSTRIB            VARCHAR(50), ');
      sSqlTxt.Add('    NOME_CCLASSTRIB       VARCHAR(5000) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_CORRELACAO_NFS_NBS_IBS_CBS_; ');
      ExecutaScript('ALTER TABLE CORRELACAO_NFS_NBS_IBS_CBS ADD CONSTRAINT PK_CORRELACAO_NFS_NBS_IBS_CBS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE CORRELACAO_NFS_NBS_IBS_CBS IS ''Tabela de correlacao entre os itens de servico da Lei Complementar nr 116/2003, os codigos NBS (Nomenclatura Brasileira de Servicos), e as '+
      'classificacoes tributarias aplicaveis ao IBS e a CBS. Utilizada para determinar o tratamento fiscal adequado na emissao de Nota Fiscal de Servico eletronica (NFS-e) conforme os criterios da Reforma Tributaria.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.ITEM_LC_116 IS ''Codigo do item de servico conforme a Lei Complementar nr 116/2003, utilizado para identificar o tipo de servico prestado na NFS-e.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.DESCRICAO_ITEM IS ''Descricao textual do servico conforme o item da LC 116, representando a atividade econrmica prestada.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.NBS IS ''Codigo da Nomenclatura Brasileira de Servicos (NBS), que detalha o servico em nivel mais especifico para fins de classificacao tributaria.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.DESCRICAO_NBS IS ''Descricao do servico conforme o codigo NBS, com maior detalhamento tecnico e funcional.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.PS_ONEROSA_S_N IS ''Indicador se a prestacao de servico e onerosa (Sim ou Nao). -1- indica que ha contraprestacao financeira; -0- indica gratuidade ou ausencia de cobranra.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.ADQ_EXTERIOR_S_N IS ''Indicador se o servico foi adquirido do exterior (Sim ou Nao). -1- significa que o servico foi contratado de fornecedor estrangeiro.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.INDOP IS ''Codigo do Indicador de Operacao de Consumo, utilizado para determinar a regra de incidencia do IBS conforme o local de consumo ou prestacao.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.LOCAL_INCIDENCIA_IBS IS ''Descricao do local onde ocorre a incidencia do IBS, como -Domicilio principal do adquirente-, -Local da prestacao-, etc.''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.CCLASSTRIB IS ''Codigo da Classificacao Tributaria, que define o tratamento fiscal do servico perante o IBS e CBS (tributado, isento, sujeito a regime especifico, etc.).''; ');
      ExecutaScript('COMMENT ON COLUMN CORRELACAO_NFS_NBS_IBS_CBS.NOME_CCLASSTRIB IS ''Descricao da Classificacao Tributaria, explicando o enquadramento do servico, como -Situacoes tributadas integralmente pelo IBS e '+
      'CBS- ou conforme anexos legais.''; ');

    end;

    if ExecutaRecurso('CORRELACAO_NFS_NBS_IBS_CBS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER CORRELACAO_NFS_NBS_IBS_CBS_BI FOR CORRELACAO_NFS_NBS_IBS_CBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('as ');
      sSqlTxt.Add('begin ');
      sSqlTxt.Add('  if (new.id is null) then ');
      sSqlTxt.Add('    new.id = gen_id(gen_correlacao_nfs_nbs_ibs_cbs_,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela CORRELACAO_NFS_NBS_IBS_CBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.NCM_CAP_SH_IBSCBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: NCM_CAP_SH_IBSCBS');//13

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('NCM_CAP_SH_IBSCBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE NCM_CAP_SH_IBSCBS ( ');
      sSqlTxt.Add('    ID                     INTEGER NOT NULL, ');
      sSqlTxt.Add('    SECAO_SIS_HARMONIZADO  VARCHAR(10), ');
      sSqlTxt.Add('    SH2                    VARCHAR(10), ');
      sSqlTxt.Add('    NO_SH2_POR             VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH2_ING             VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH2_ESP             VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH2_FRA             VARCHAR(5000) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_NCM_CAP_SH_IBSCBS_ID; ');
      ExecutaScript('ALTER TABLE NCM_CAP_SH_IBSCBS ADD CONSTRAINT PK_NCM_CAP_SH_IBSCBS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE NCM_CAP_SH_IBSCBS IS ''Tabela de capitulos do Sistema Harmonizado (SH), representados pelos dois primeiros digitos do codigo NCM. '+
      'Utilizada para agrupar e identificar categorias gerais de mercadorias conforme a estrutura de classificacao fiscal internacional.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_CAP_SH_IBSCBS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_CAP_SH_IBSCBS.SECAO_SIS_HARMONIZADO IS ''Identificador da secao do Sistema Harmonizado a qual o capitulo pertence. Representado por uma letra (ex.: "I"), '+
      'agrupa capitulos por grandes categorias de mercadorias.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_CAP_SH_IBSCBS.SH2 IS ''Codigo do capitulo SH, composto pelos dois primeiros digitos do NCM. Define a categoria principal da mercadoria segundo a Tarifa Externa Comum (TEC).''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_CAP_SH_IBSCBS.NO_SH2_POR IS ''Descricao oficial do capitulo SH em portugues, conforme nomenclatura da Receita Federal e da TEC.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_CAP_SH_IBSCBS.NO_SH2_ING IS ''Descricao do capitulo SH em ingles, usada em operacoes internacionais e documentacao aduaneira.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_CAP_SH_IBSCBS.NO_SH2_ESP IS ''Descricao do capitulo SH em espanhol, utilizada em transacoes com paises do Mercosul e America Latina.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_CAP_SH_IBSCBS.NO_SH2_FRA IS ''Descricao do capitulo SH em frances, usada em documentacao tecnica e internacional, especialmente em tratados multilingues.''; ');
    end;

    if ExecutaRecurso('NCM_CAP_SH_IBSCBS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER NCM_CAP_SH_IBSCBS_BI FOR NCM_CAP_SH_IBSCBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('as ');
      sSqlTxt.Add('begin ');
      sSqlTxt.Add('  if (new.id is null) then ');
      sSqlTxt.Add('    new.id = gen_id(gen_ncm_cap_sh_ibscbs_id,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela NCM_CAP_SH_IBSCBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.NCM_POS_SH4_IBSCBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: NCM_POS_SH4_IBSCBS');//14

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('NCM_POS_SH4_IBSCBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE NCM_POS_SH4_IBSCBS ( ');
      sSqlTxt.Add('    ID          INTEGER NOT NULL, ');
      sSqlTxt.Add('    CO_SH4      VARCHAR(10), ');
      sSqlTxt.Add('    NO_SH4_POR  VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH4_ING  VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH4_ESP  VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH4_FRA  VARCHAR(5000) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_NCM_POS_SH4_IBSCBS_ID; ');
      ExecutaScript('ALTER TABLE NCM_POS_SH4_IBSCBS ADD CONSTRAINT PK_NCM_POS_SH4_IBSCBS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE NCM_POS_SH4_IBSCBS IS ''Tabela de posicoes do Sistema Harmonizado (SH), representadas pelos quatro primeiros digitos do codigo NCM. Utilizada para classificar mercadorias '+
      'em grupos intermediarios dentro da estrutura fiscal internacional, conforme a Tarifa Externa Comum (TEC) e a Nomenclatura Comum do Mercosul (NCM).''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_POS_SH4_IBSCBS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_POS_SH4_IBSCBS.CO_SH4 IS ''Codigo da posicao do Sistema Harmonizado (SH4), composto pelos quatro primeiros digitos do NCM. Identifica um grupo especifico de mercadorias.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_POS_SH4_IBSCBS.NO_SH4_POR IS ''Descricao oficial da posicao SH4 em portugues, conforme nomenclatura da Tarifa Externa Comum (TEC) e da Receita Federal.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_POS_SH4_IBSCBS.NO_SH4_ING IS ''Descricao da posicao SH4 em ingles, utilizada em operacoes internacionais, documentos aduaneiros e tratados multilingues.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_POS_SH4_IBSCBS.NO_SH4_ESP IS ''Descricao da posicao SH4 em espanhol, usada em transacoes com paises do Mercosul e America Latina.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_POS_SH4_IBSCBS.NO_SH4_FRA IS ''Descricao da posicao SH4 em frances, usada em documentacao tecnica internacional e acordos comerciais multilingues.''; ');
    end;

    if ExecutaRecurso('NCM_POS_SH4_IBSCBS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER NCM_POS_SH4_IBSCBS_BI FOR NCM_POS_SH4_IBSCBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('as ');
      sSqlTxt.Add('begin ');
      sSqlTxt.Add('  if (new.id is null) then ');
      sSqlTxt.Add('    new.id = gen_id(gen_ncm_pos_sh4_ibscbs_id,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela NCM_POS_SH4_IBSCBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.NCM_SUBPOS_SH6_IBSCBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: NCM_SUBPOS_SH6_IBSCBS');//15

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('NCM_SUBPOS_SH6_IBSCBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE NCM_SUBPOS_SH6_IBSCBS ( ');
      sSqlTxt.Add('    ID          INTEGER NOT NULL, ');
      sSqlTxt.Add('    CO_SH6      VARCHAR(10), ');
      sSqlTxt.Add('    NO_SH6_POR  VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH6_ING  VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH6_ESP  VARCHAR(5000), ');
      sSqlTxt.Add('    NO_SH6_FRA  VARCHAR(5000) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_NCM_SUBPOS_SH6_IBSCBS_ID; ');
      ExecutaScript('ALTER TABLE NCM_SUBPOS_SH6_IBSCBS ADD CONSTRAINT PK_NCM_SUBPOS_SH6_IBSCBS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE NCM_SUBPOS_SH6_IBSCBS IS ''Tabela de subposicoes do Sistema Harmonizado (SH), representadas pelos seis primeiros digitos do codigo NCM. Utilizada para detalhar '+
      'mercadorias com maior precisao dentro da estrutura de classificacao fiscal internacional, conforme a Tarifa Externa Comum (TEC) e a Nomenclatura Comum do Mercosul (NCM).''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_SUBPOS_SH6_IBSCBS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_SUBPOS_SH6_IBSCBS.CO_SH6 IS ''Codigo da subposicao do Sistema Harmonizado (SH6), composto pelos seis primeiros digitos do NCM. Identifica mercadorias com maior especificidade '+
      'dentro da estrutura fiscal.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_SUBPOS_SH6_IBSCBS.NO_SH6_POR IS ''Descricao oficial da subposicao SH6 em portugues, conforme a Tarifa Externa Comum (TEC) e a nomenclatura da Receita Federal.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_SUBPOS_SH6_IBSCBS.NO_SH6_ING IS ''Descricao da subposicao SH6 em ingles, utilizada em operacoes internacionais, documentos aduaneiros e tratados multilingues.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_SUBPOS_SH6_IBSCBS.NO_SH6_ESP IS ''Descricao da subposicao SH6 em espanhol, usada em transacoes com paises do Mercosul e America Latina.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_SUBPOS_SH6_IBSCBS.NO_SH6_FRA IS ''Descricao da subposicao SH6 em frances, utilizada em documentacao tecnica internacional e acordos comerciais multilingues.''; ');
    end;

    if ExecutaRecurso('NCM_SUBPOS_SH6_IBSCBS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER NCM_SUBPOS_SH6_IBSCBS_BI FOR NCM_SUBPOS_SH6_IBSCBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('as ');
      sSqlTxt.Add('begin ');
      sSqlTxt.Add('  if (new.id is null) then ');
      sSqlTxt.Add('    new.id = gen_id(gen_ncm_subpos_sh6_ibscbs_id,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela NCM_SUBPOS_SH6_IBSCBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.NCM_IBSCBS;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: NCM_IBSCBS');//16

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('NCM_IBSCBS','ID') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE NCM_IBSCBS ( ');
      sSqlTxt.Add('    ID                 INTEGER NOT NULL, ');
      sSqlTxt.Add('    VIGENTE            INTEGER, ');
      sSqlTxt.Add('    CAP_SH2            VARCHAR(10), ');
      sSqlTxt.Add('    POS_SH4            VARCHAR(10), ');
      sSqlTxt.Add('    SUB_SH6            VARCHAR(10), ');
      sSqlTxt.Add('    CO_NCM             VARCHAR(10), ');
      sSqlTxt.Add('    NO_UNID_USO_NA_NF  VARCHAR(10), ');
      sSqlTxt.Add('    NO_NCM_POR         VARCHAR(5000), ');
      sSqlTxt.Add('    NO_NCM_ING         VARCHAR(5000), ');
      sSqlTxt.Add('    NO_NCM_ESP         VARCHAR(5000), ');
      sSqlTxt.Add('    NO_NCM_FRA         VARCHAR(5000), ');
      sSqlTxt.Add('    INCLUSAO           VARCHAR(10), ');
      sSqlTxt.Add('    NORMA_INCLUSAO     VARCHAR(255), ');
      sSqlTxt.Add('    EXCLUSAO           VARCHAR(10), ');
      sSqlTxt.Add('    NORMA_EXCLUSAO     VARCHAR(255), ');
      sSqlTxt.Add('    CO_UNID            VARCHAR(10), ');
      sSqlTxt.Add('    NO_UNID            VARCHAR(100), ');
      sSqlTxt.Add('    ALTERACAO          VARCHAR(10), ');
      sSqlTxt.Add('    NORMA_ALTERACAO    VARCHAR(255), ');
      sSqlTxt.Add('    OBS                VARCHAR(5000) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_NCM_IBSCBS_ID; ');
      ExecutaScript('ALTER TABLE NCM_IBSCBS ADD CONSTRAINT PK_NCM_IBSCBS PRIMARY KEY (ID); ');

      ExecutaScript('COMMENT ON TABLE NCM_IBSCBS IS ''Tabela de codigos da Nomenclatura Comum do Mercosul (NCM), utilizada para classificar mercadorias conforme a Tarifa Externa Comum (TEC) e o Sistema '+
      'Harmonizado (SH). Serve como referencia para tributacao, controle aduaneiro, emissao de notas fiscais eletronicas (NF-e) e obrigacoes acessorias.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.ID IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.VIGENTE IS ''Indica se o codigo NCM esta atualmente valido. Valor "S" para vigente e "N" para nao vigente (excluido ou substituido).''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.CAP_SH2 IS ''Capitulo do Sistema Harmonizado (SH), representado pelos 2 primeiros digitos do NCM. Agrupa mercadorias por grandes categorias.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.POS_SH4 IS ''Posicao do SH, representada pelos 4 primeiros digitos do NCM. Refina a classificacao dentro do capitulo.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.SUB_SH6 IS ''Subposicao do SH, representada pelos 6 primeiros digitos do NCM. Detalha ainda mais o tipo de mercadoria.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.CO_NCM IS ''Codigo completo NCM com 8 digitos, que identifica a mercadoria segundo a classificacao fiscal do Mercosul.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NO_UNID_USO_NA_NF IS ''Codigo da unidade de medida comercial utilizada na Nota Fiscal eletronica (NF-e), conforme tabela da Receita Federal.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NO_NCM_POR IS ''Descricao oficial da mercadoria em portugues, conforme nomenclatura da Tarifa Externa Comum (TEC).''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NO_NCM_ING IS ''Descricao da mercadoria em ingles, usada em operacoes internacionais e documentos aduaneiros.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NO_NCM_ESP IS ''Descricao da mercadoria em espanhol, utilizada em transacoes com paises do Mercosul e America Latina.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NO_NCM_FRA IS ''Descricao da mercadoria em frances, usada em documentacao tecnica internacional e acordos multilingues.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.INCLUSAO IS ''Data de inclusao do codigo NCM na tabela oficial, geralmente no formato AAAA_MM.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NORMA_INCLUSAO IS ''Referencia normativa (ex.: resolucao, portaria) que autorizou a inclusao do codigo NCM.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.EXCLUSAO IS ''Data de exclusao do codigo NCM, se aplicavel, no formato AAAA_MM.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NORMA_EXCLUSAO IS ''Referencia normativa que autorizou a exclusao do codigo NCM.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.CO_UNID IS ''Codigo da unidade de medida comercial associada ao NCM, conforme tabela de unidades da Receita Federal.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NO_UNID IS ''Nome da unidade de medida comercial (ex.: "NUMERO (UNIDADE)", "KG", "LITRO"), usada para controle de quantidades na NF-e.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.ALTERACAO IS ''Data da ultima alteracao no registro do NCM (descricao, unidade, etc.), se houver.''	; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.NORMA_ALTERACAO IS ''Referencia normativa que autorizou ou determinou a alteracao do NCM.''; ');
      ExecutaScript('COMMENT ON COLUMN NCM_IBSCBS.OBS IS ''Observacoes adicionais sobre o codigo NCM, como restricoes, excecoes tarifarias, notas explicativas ou historico de mudancas.''; ');
    end;

    if ExecutaRecurso('NCM_IBSCBS_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER NCM_IBSCBS_BI FOR NCM_IBSCBS ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('as ');
      sSqlTxt.Add('begin ');
      sSqlTxt.Add('  if (new.id is null) then ');
      sSqlTxt.Add('    new.id = gen_id(gen_ncm_ibscbs_id,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura da tabela NCM_IBSCBS ' + #13#10 + e.Message);
  end;
end;

procedure TEstrutura_Tab_RegTributario.Baixa_Tabelas;
var
  FIniFiles :TIniFile;
  FArq :String;
  FArq_Salvar :String;
  FArq_Log :String;
begin
  try
    try
      FArq := '';
      FArq := 'C:\cone\Adapta\cfg\Download.ini';//ExtractFilePath(Application.ExeName) + 'cfg\Dowload.ini';
      FArq_Log := '';
      FArq_Log := 'C:\cone\Adapta\ARQ\Log_Download.txt';//ExtractFilePath(Application.ExeName) + 'ARQ\Log_Download.txt';

      if FileExists(FArq) then
        DeleteFile(FArq);

      Progresso_Rotina('Download: Tabela de Capítulos do NCM');//20
      if ExecutaRecurso('DOWNLOAD_NCMCap',5) then
      begin
        FArq_Salvar := '';
        FArq_Salvar := 'C:\cone\Adapta\ARQ\NCMCap.json';//ExtractFilePath(Application.ExeName) + 'ARQ\NCMCap.json';
        FIniFiles := TIniFile.Create(FArq);
        FIniFiles.WriteString('Download','URL','https://www.mediafire.com/file/xri3q1tvvvubhvg/NCMCap.json/file');
        FIniFiles.WriteString('Download','Destino',FArq_Salvar);
        FIniFiles.WriteString('Download','PathLog',FArq_Log);
      end;

      Progresso_Rotina('Download: Tabela de Posição do NCM');//21
      if ExecutaRecurso('DOWNLOAD_NCMPos',5) then
      begin
        if LiberarDownload(FArq) then
        begin
          FArq_Salvar := '';
          FArq_Salvar := 'C:\cone\Adapta\ARQ\NCMPos.json';//ExtractFilePath(Application.ExeName) + 'ARQ\NCMPos.json';
          FIniFiles := TIniFile.Create(FArq);
          FIniFiles.WriteString('Download','URL','https://www.mediafire.com/file/c4thnq4uoawoas0/NCMPos.json/file');
          FIniFiles.WriteString('Download','Destino',FArq_Salvar);
          FIniFiles.WriteString('Download','PathLog',FArq_Log);
        end;
      end;

      Progresso_Rotina('Download: Tabela de Sub-Posição do NCM');//22
      if ExecutaRecurso('DOWNLOAD_NCMSubPos',3) then
      begin
        if LiberarDownload(FArq) then
        begin
          FArq_Salvar := '';
          FArq_Salvar := 'C:\cone\Adapta\ARQ\NCMSubPos.json';//ExtractFilePath(Application.ExeName) + 'ARQ\NCMSubPos.json';
          FIniFiles := TIniFile.Create(FArq);
          FIniFiles.WriteString('Download','URL','https://www.mediafire.com/file/rfpfvtjj0vgacoj/NCMSubPos.json/file');
          FIniFiles.WriteString('Download','Destino',FArq_Salvar);
          FIniFiles.WriteString('Download','PathLog',FArq_Log);
        end;
      end;

      Progresso_Rotina('Download: Tabela de NCM');//23
      if ExecutaRecurso('DOWNLOAD_NCM',3) then
      begin
        if LiberarDownload(FArq) then
        begin
          FArq_Salvar := '';
          FArq_Salvar := 'C:\cone\Adapta\ARQ\NCM.json';//ExtractFilePath(Application.ExeName) + 'ARQ\NCM.json';
          FIniFiles := TIniFile.Create(FArq);
          FIniFiles.WriteString('Download','URL','https://www.mediafire.com/file/npu69fs9fgqpqa4/NCM.json/file');
          FIniFiles.WriteString('Download','Destino',FArq_Salvar);
          FIniFiles.WriteString('Download','PathLog',FArq_Log);
        end;
      end;

      Progresso_Rotina('Download: Tabela de CClassTrib');//24
      if ExecutaRecurso('DOWNLOAD_CST_cClassTrib',3) then
      begin
        if LiberarDownload(FArq) then
        begin
          FArq_Salvar := '';
          FArq_Salvar := 'C:\cone\Adapta\ARQ\CST_cClassTrib.json';//ExtractFilePath(Application.ExeName) + 'ARQ\CST_cClassTrib.json';
          FIniFiles := TIniFile.Create(FArq);
          FIniFiles.WriteString('Download','URL','https://www.mediafire.com/file/u12aff4eminfcsk/CST_cClassTrib_2025-10-03_Public_verde.json/file');
          FIniFiles.WriteString('Download','Destino',FArq_Salvar);
          FIniFiles.WriteString('Download','PathLog',FArq_Log);
        end;
      end;

      Progresso_Rotina('Download: Tabela do CST - IBSCBS');//25
      if ExecutaRecurso('DOWNLOAD_CST_IBSCBS',3) then
      begin
        if LiberarDownload(FArq) then
        begin
          FArq_Salvar := '';
          FArq_Salvar := 'C:\cone\Adapta\ARQ\CST_IBSCBS.json';//ExtractFilePath(Application.ExeName) + 'ARQ\CST_cClassTrib.json';
          FIniFiles := TIniFile.Create(FArq);
          FIniFiles.WriteString('Download','URL','https://www.mediafire.com/file/56tgqstkfogo00x/CST_cClassTrib_2025-10-03_Public_verdeCST.json/file');
          FIniFiles.WriteString('Download','Destino',FArq_Salvar);
          FIniFiles.WriteString('Download','PathLog',FArq_Log);
        end;
      end;

      Progresso_Rotina('Download: Tabela de Crédito Presumido');//26
      if ExecutaRecurso('DOWNLOAD_Cred_Presumido',3) then
      begin
        if LiberarDownload(FArq) then
        begin
          FArq_Salvar := '';
          FArq_Salvar := 'C:\cone\Adapta\ARQ\Cred_Presumido.json';//ExtractFilePath(Application.ExeName) + 'ARQ\Cred_Presumido.json';
          FIniFiles := TIniFile.Create(FArq);
          FIniFiles.WriteString('Download','URL','https://www.mediafire.com/file/jr1vjnb8v57ga08/cCredPres_2025-10-06_Public_verde.json/file');
          FIniFiles.WriteString('Download','Destino',FArq_Salvar);
          FIniFiles.WriteString('Download','PathLog',FArq_Log);
        end;
      end;
    except
      on E : Exception do
      begin
        Msg('</i></b>Ocorreu um erro ao realizar o Download dos arquivos.<br>'+'Mensagem do Erro: <b>'+e.Message+'</b>','Erro', btx_ok,img_erro,0);
      end;
    end;
  finally

  end;
end;


function TEstrutura_Tab_RegTributario.LiberarDownload(AArq :String): Boolean;
begin
  Result := True;

  while FileExists(AArq) do
  begin
    Application.ProcessMessages; // Mantém a interface responsiva
    Sleep(1000); // Aguarda 5 segundos antes de verificar novamente
  end;

end;

function TEstrutura_Tab_RegTributario.Generator_Existe(const AGenerator: String): Boolean;
var
  lQry:TIBCQuery;
begin
  Result := False;
  try
    lQry:=TIBCQuery.Create(Application);
    lQry.Connection := frmmodulo.conexao;

    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add('SELECT * FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = ' + QuotedStr(AGenerator));
    lQry.Open;
    Result := (not lQry.IsEmpty);
  finally
    FreeAndNil(lQry);
  end;
end;

procedure TEstrutura_Tab_RegTributario.TIPO_OPERACAO_CFOP;
var
  sSqlTxt : TStringList;
begin
  Progresso_Rotina('Tabela: ASSOCIAÇÃO ENTRE TIPO_OPERACAO E CFOP');//27

  sSqlTxt := TStringList.Create;
  try
    if not FieldExists('TIPO_OPERACAO_CFOP_CFOP','CODIGO') then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('CREATE TABLE TIPO_OPERACAO_CFOP ( ');
      sSqlTxt.Add('    CODIGO INTEGER NOT NULL, ');
      sSqlTxt.Add('    TIPO_OPERACAO_ID INTEGER, ');
      sSqlTxt.Add('    CFOP VARCHAR(10) ');
      sSqlTxt.Add('); ');
      ExecutaScript(sSqlTxt.Text);

      ExecutaScript('CREATE GENERATOR GEN_TIPO_OPERACAO_CFOP_ID; ');

      ExecutaScript('ALTER TABLE TIPO_OPERACAO_CFOP ADD CONSTRAINT PK_TIPO_OPERACAO_CFOP PRIMARY KEY (CODIGO); ');

      ExecutaScript('COMMENT ON TABLE TIPO_OPERACAO_CFOP IS ''Tabela que associa Tipos de Operação ao CFOP.''; ');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO_CFOP.CODIGO IS ''SEQUENCIAL''; ');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO_CFOP.TIPO_OPERACAO_ID IS ''CODIGO DO TIPO DA OPERACAO''; ');
      ExecutaScript('COMMENT ON COLUMN TIPO_OPERACAO_CFOP.CFOP IS ''NUMERO DO CFOP''; ');
    end;

    if not Generator_Existe('GEN_TIPO_OPERACAO_CFOP_ID') then
      ExecutaScript('CREATE GENERATOR GEN_TIPO_OPERACAO_CFOP_ID; ');

    if ExecutaRecurso('TIPO_OPERACAO_CFOP_BI',1) then
    begin
      sSqlTxt.Clear;
      sSqlTxt.Add('SET TERM ^ ; ');
      sSqlTxt.Add('CREATE OR ALTER TRIGGER TIPO_OPERACAO_CFOP_BI FOR TIPO_OPERACAO_CFOP ');
      sSqlTxt.Add('ACTIVE BEFORE INSERT POSITION 0 ');
      sSqlTxt.Add('AS ');
      sSqlTxt.Add('BEGIN ');
      sSqlTxt.Add('  IF (NEW.CODIGO IS NULL) THEN ');
      sSqlTxt.Add('    NEW.CODIGO = GEN_ID(GEN_TIPO_OPERACAO_CFOP_ID,1); ');
      sSqlTxt.Add('END^ ');
      ExecutaScript(sSqlTxt.Text);
    end;

  except on E : Exception do
    raise Exception.Create('Erro ao criar a estrutura entre a associação do CFOP e do Tipo de Operação Fiscal ' + #13#10 + e.Message);
  end;
end;

end.
