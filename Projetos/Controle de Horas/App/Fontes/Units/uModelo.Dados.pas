unit uModelo.Dados;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  System.SysUtils, System.JSON

  ,IniFiles
  ,DataSet.Serialize;

type
  TTipo = (tfInteger,tfString,tfNumero,tfData,tfHora);

  TEstrutura = class
  private
    FConexao: TFDConnection;
    FEnder :String;

    function Tabela_Existe(const ATabela:String):Boolean;
    function Campo_Existe(const ATabela,ACampo:String):Boolean;

    procedure Criar_Campo(const ATabela,ACampo:String; ATipo:TTipo; ATamanho:Integer=0; ADecimal:Integer=0);

  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    procedure USUARIO;
    procedure EMPRESA;
    procedure CONTA;
    procedure FORMA_PAGAMENTO;
    procedure FORNECEDOR;
    procedure CONDICAO_PAGAMENTO;
    procedure PRESTADOR_SERVICO;
    procedure TABELA_PRECO;
    procedure FORMA_CONDICAO_PAGAMENTO;
    procedure CLIENTE;
    procedure CLIENTE_TABELA;
    procedure SERVICOS_PRESTADOS;
    procedure LANCAMENTOS;

  end;

  //Usuário
  TUsuario = class
  private
    FConexao: TFDConnection;
    FEnder :String;
  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    function Lista_Registros(AId: Integer=0; ANome:String=''; ALogin: String=''): TFDQuery;
  end;

  //Empresa
  TEmpresa = class
  private
    FConexao: TFDConnection;
    FEnder :String;
  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    function Lista_Registros(AId: Integer=0; ANome:String=''): TFDQuery;
  end;

  //Prestador de Serviço
  TPrestServicos = class
  private
    FConexao: TFDConnection;
    FEnder :String;
  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    function Lista_Registros(AId: Integer=0; ANome:String=''): TFDQuery;
  end;

  //Fornecedor
  TFornecedor = class
  private
    FConexao: TFDConnection;
    FEnder :String;
  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    function Lista_Registros(AId: Integer=0; ANome:String=''): TFDQuery;
  end;

  //Tabela de Preço
  TTab_Preco = class
  private
    FConexao: TFDConnection;
    FEnder :String;
  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    function Lista_Registros(AId: Integer=0; ANome:String=''): TFDQuery;
  end;

  //Conta
  TConta = class
  private
    FConexao: TFDConnection;
    FEnder :String;
  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    function Lista_Registros(AId: Integer=0; ANome:String=''): TFDQuery;
  end;

  //Forma/Condição de Pagamento
  TFormaCond_Pagto = class
  private
    FConexao: TFDConnection;
    FEnder :String;
  public
    constructor Create(AConnexao: TFDConnection;AEnder:String);

    function Lista_Registros(AId: Integer=0; ACondicao_ID :Integer=0; ANome:String=''): TFDQuery;
  end;

implementation

{ TEstrutura }

function TEstrutura.Campo_Existe(const ATabela, ACampo: String): Boolean;
var
  FDQ_Select :TFDQuery;
begin
  try
    try
      Result := False;

      FDQ_Select := TFDQuery.Create(Nil);
      FDQ_Select.Connection := FConexao;

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('SELECT ');
      FDQ_Select.Sql.Add('  COUNT(*) AS QTD ');
      FDQ_Select.Sql.Add('FROM pragma_table_info('+QuotedStr(ATabela)+') ');
      FDQ_Select.Sql.Add('WHERE name = ' + QuotedStr(ACampo));
      FDQ_Select.Active := True;

      Result := (FDQ_Select.FieldByName('QTD').AsInteger >= 1);
    except on E: Exception do
      raise Exception.Create('Campo Existe. ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TEstrutura.CLIENTE;
begin
  try
    try
      if not Campo_Existe('CLIENTE','ID_PRINCIPAL') then
        Criar_Campo('CLIENTE','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('CLIENTE','EXCLUIDO') then
        Criar_Campo('CLIENTE','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.CLIENTE_TABELA;
begin
  try
    try
      if not Campo_Existe('CLIENTE_TABELA','ID_PRINCIPAL') then
        Criar_Campo('CLIENTE_TABELA','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('CLIENTE_TABELA','EXCLUIDO') then
        Criar_Campo('CLIENTE_TABELA','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.CONDICAO_PAGAMENTO;
begin
  try
    try
      if not Campo_Existe('CONDICAO_PAGAMENTO','ID_PRINCIPAL') then
        Criar_Campo('CONDICAO_PAGAMENTO','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('CONDICAO_PAGAMENTO','EXCLUIDO') then
        Criar_Campo('CONDICAO_PAGAMENTO','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.CONTA;
begin
  try
    try
      if not Campo_Existe('CONTA','ID_PRINCIPAL') then
        Criar_Campo('CONTA','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('CONTA','EXCLUIDO') then
        Criar_Campo('CONTA','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

constructor TEstrutura.Create(AConnexao: TFDConnection;AEnder:String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;

end;

procedure TEstrutura.Criar_Campo(const ATabela,ACampo:String; ATipo:TTipo; ATamanho:Integer=0; ADecimal:Integer=0);
var
  FDQ_Select :TFDQuery;
begin
  try
    try

      FDQ_Select := TFDQuery.Create(Nil);
      FDQ_Select.Connection := FConexao;

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      case ATipo of
        tfInteger: FDQ_Select.Sql.Add('ALTER TABLE '+ATabela+' ADD '+ACampo+' INTEGER;');
        tfString: FDQ_Select.Sql.Add('ALTER TABLE '+ATabela+' ADD '+ACampo+' VARCHAR('+ATamanho.ToString+');');
        tfNumero: FDQ_Select.Sql.Add('ALTER TABLE '+ATabela+' ADD '+ACampo+' NUMERIC('+ATamanho.ToString + ','+ADecimal.ToString+');');
        tfData: FDQ_Select.Sql.Add('ALTER TABLE '+ATabela+' ADD '+ACampo+' DATE;');
        tfHora: FDQ_Select.Sql.Add('ALTER TABLE '+ATabela+' ADD '+ACampo+' TIME;');
      end;
      FDQ_Select.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TEstrutura.EMPRESA;
begin
  try
    try
      if not Campo_Existe('EMPRESA','ID_PRINCIPAL') then
        Criar_Campo('EMPRESA','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('EMPRESA','EXCLUIDO') then
        Criar_Campo('EMPRESA','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.FORMA_CONDICAO_PAGAMENTO;
begin
  try
    try
      if not Campo_Existe('FORMA_CONDICAO_PAGAMENTO','ID_PRINCIPAL') then
        Criar_Campo('FORMA_CONDICAO_PAGAMENTO','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('FORMA_CONDICAO_PAGAMENTO','EXCLUIDO') then
        Criar_Campo('FORMA_CONDICAO_PAGAMENTO','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.FORMA_PAGAMENTO;
begin
  try
    try
      if not Campo_Existe('FORMA_PAGAMENTO','ID_PRINCIPAL') then
        Criar_Campo('FORMA_PAGAMENTO','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('FORMA_PAGAMENTO','EXCLUIDO') then
        Criar_Campo('FORMA_PAGAMENTO','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.FORNECEDOR;
begin
  try
    try
      if not Campo_Existe('FORNECEDOR','ID_PRINCIPAL') then
        Criar_Campo('FORNECEDOR','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('FORNECEDOR','EXCLUIDO') then
        Criar_Campo('FORNECEDOR','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.LANCAMENTOS;
begin
  try
    try
      if not Campo_Existe('LANCAMENTOS','ID_PRINCIPAL') then
        Criar_Campo('LANCAMENTOS','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('LANCAMENTOS','EXCLUIDO') then
        Criar_Campo('LANCAMENTOS','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.PRESTADOR_SERVICO;
begin
  try
    try
      if not Campo_Existe('PRESTADOR_SERVICO','ID_PRINCIPAL') then
        Criar_Campo('PRESTADOR_SERVICO','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('PRESTADOR_SERVICO','EXCLUIDO') then
        Criar_Campo('PRESTADOR_SERVICO','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.SERVICOS_PRESTADOS;
begin
  try
    try
      if not Campo_Existe('SERVICOS_PRESTADOS','ID_PRINCIPAL') then
        Criar_Campo('SERVICOS_PRESTADOS','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('SERVICOS_PRESTADOS','EXCLUIDO') then
        Criar_Campo('SERVICOS_PRESTADOS','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

function TEstrutura.Tabela_Existe(const ATabela: String): Boolean;
var
  FDQ_Select :TFDQuery;
begin
  try
    try
      Result := False;

      FDQ_Select := TFDQuery.Create(Nil);
      FDQ_Select.Connection := FConexao;

      FDQ_Select.Active := False;
      FDQ_Select.Sql.Clear;
      FDQ_Select.Sql.Add('SELECT sql FROM SQLITE_MASTER WHERE TBL_NAME = ' + QuotedStr(ATabela) + ' AND TYPE = ''table''');
      FDQ_Select.Active := True;

      Result := (Not FDQ_Select.IsEmpty);
    except on E: Exception do
      raise Exception.Create('Tabela Existe. ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FDQ_Select);
    {$ELSE}
      FDQ_Select.DisposeOf;
    {$ENDIF}
  end;
end;

procedure TEstrutura.TABELA_PRECO;
begin
  try
    try
      if not Campo_Existe('TABELA_PRECO','ID_PRINCIPAL') then
        Criar_Campo('TABELA_PRECO','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('TABELA_PRECO','EXCLUIDO') then
        Criar_Campo('TABELA_PRECO','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

procedure TEstrutura.USUARIO;
begin
  try
    try
      if not Campo_Existe('USUARIO','ID_PRINCIPAL') then
        Criar_Campo('USUARIO','ID_PRINCIPAL',tfInteger);

      //EXCLUIDO = 0-NÃO, 1-SIM (Vai informar ao Servidor que esse registro tem que ser excluído)
      if not Campo_Existe('USUARIO','EXCLUIDO') then
        Criar_Campo('USUARIO','EXCLUIDO',tfInteger);

    except on E: Exception do
      raise Exception.Create('Atualiza estrutura. ' + E.Message);
    end;
  finally
  end;
end;

{ TUsuario }

constructor TUsuario.Create(AConnexao: TFDConnection; AEnder: String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;
end;

function TUsuario.Lista_Registros(AId: Integer=0; ANome:String=''; ALogin: String=''): TFDQuery;
var
  FQuery :TFDQuery;
begin
  try
    try
      FQuery := TFDQuery.Create(Nil);
      FQuery.Connection := FConexao;

      FQuery.Active := False;
      FQuery.Sql.Clear;
      FQuery.Sql.Add('SELECT U.* FROM USUARIO U');
      FQuery.Sql.Add('WHERE NOT U.ID IS NULL');
      if AId > 0 then
        FQuery.Sql.Add('  AND U.ID = ' + AId.ToString);
      if Trim(ANome) <> '' then
        FQuery.Sql.Add('  AND U.NOME LIKE ' + QuotedStr('%'+ANome+'%'));
      if Trim(ALogin) <> '' then
        FQuery.Sql.Add('  AND U.LOGIN = ' + QuotedStr(ALogin));
      FQuery.Active := True;
      Result := FQuery;
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FQuery);
    {$ELSE}
      FQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TEmpresa }

constructor TEmpresa.Create(AConnexao: TFDConnection; AEnder: String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;
end;

function TEmpresa.Lista_Registros(AId: Integer; ANome: String): TFDQuery;
begin
  try
    try
      Result := TFDQuery.Create(Nil);
      Result.Connection := FConexao;

      Result.Active := False;
      Result.Sql.Clear;
      Result.Sql.Add('SELECT E.* FROM EMPRESA E');
      Result.Sql.Add('WHERE NOT E.ID IS NULL');
      if AId > 0 then
        Result.Sql.Add('  AND E.ID = ' + AId.ToString);
      if Trim(ANome) <> '' then
        Result.Sql.Add('  AND E.NOME LIKE ' + QuotedStr('%'+ANome+'%'));
      Result.Active := True;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

{ TPrestServicos }

constructor TPrestServicos.Create(AConnexao: TFDConnection; AEnder: String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;
end;

function TPrestServicos.Lista_Registros(AId: Integer; ANome: String): TFDQuery;
begin
  try
    try
      Result := TFDQuery.Create(Nil);
      Result.Connection := FConexao;

      Result.Active := False;
      Result.Sql.Clear;
      Result.Sql.Add('SELECT A.* FROM PRESTADOR_SERVICO A');
      Result.Sql.Add('WHERE NOT A.ID IS NULL');
      if AId > 0 then
        Result.Sql.Add('  AND A.ID = ' + AId.ToString);
      if Trim(ANome) <> '' then
        Result.Sql.Add('  AND A.NOME LIKE ' + QuotedStr('%'+ANome+'%'));
      Result.Active := True;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

{ TFornecedor }

constructor TFornecedor.Create(AConnexao: TFDConnection; AEnder: String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;
end;

function TFornecedor.Lista_Registros(AId: Integer; ANome: String): TFDQuery;
begin
  try
    try
      Result := TFDQuery.Create(Nil);
      Result.Connection := FConexao;

      Result.Active := False;
      Result.Sql.Clear;
      Result.Sql.Add('SELECT A.* FROM FORNECEDOR A');
      Result.Sql.Add('WHERE NOT A.ID IS NULL');
      if AId > 0 then
        Result.Sql.Add('  AND A.ID = ' + AId.ToString);
      if Trim(ANome) <> '' then
        Result.Sql.Add('  AND A.NOME LIKE ' + QuotedStr('%'+ANome+'%'));
      Result.Active := True;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;

end;

{ TTab_Preco }

constructor TTab_Preco.Create(AConnexao: TFDConnection; AEnder: String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;
end;

function TTab_Preco.Lista_Registros(AId: Integer; ANome: String): TFDQuery;
begin
  try
    try
      Result := TFDQuery.Create(Nil);
      Result.Connection := FConexao;

      Result.Active := False;
      Result.Sql.Clear;
      Result.Sql.Add('SELECT A.* FROM TABELA_PRECO A');
      Result.Sql.Add('WHERE NOT A.ID IS NULL');
      if AId > 0 then
        Result.Sql.Add('  AND A.ID = ' + AId.ToString);
      if Trim(ANome) <> '' then
        Result.Sql.Add('  AND A.DESCRICAO LIKE ' + QuotedStr('%'+ANome+'%'));
      Result.Active := True;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

{ TConta }

constructor TConta.Create(AConnexao: TFDConnection; AEnder: String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;
end;

function TConta.Lista_Registros(AId: Integer; ANome: String): TFDQuery;
begin
  try
    try
      Result := TFDQuery.Create(Nil);
      Result.Connection := FConexao;

      Result.Active := False;
      Result.Sql.Clear;
      Result.Sql.Add('SELECT ');
      Result.Sql.Add('  A.* ');
      Result.Sql.Add('  ,CASE A.STATUS ');
      Result.Sql.Add('    WHEN 0 THEN ''INATIVO'' ');
      Result.Sql.Add('    WHEN 1 THEN ''ATIVO'' ');
      Result.Sql.Add('  END STATUS_DESC ');
      Result.Sql.Add('  ,CASE A.TIPO ');
      Result.Sql.Add('    WHEN 0 THEN ''CREDITO'' ');
      Result.Sql.Add('    WHEN 1 THEN ''DÉBITO'' ');
      Result.Sql.Add('  END TIPO_DESC ');
      Result.Sql.Add('FROM CONTA A ');
      Result.Sql.Add('WHERE NOT A.ID IS NULL');
      if AId > 0 then
        Result.Sql.Add('  AND A.ID = ' + AId.ToString);
      if Trim(ANome) <> '' then
        Result.Sql.Add('  AND A.DESCRICAO LIKE ' + QuotedStr('%'+ANome+'%'));
      Result.Active := True;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

{ TFormaCond_Pagto }

constructor TFormaCond_Pagto.Create(AConnexao: TFDConnection; AEnder: String);
begin
  FConexao := AConnexao;

  FEnder := '';
  FEnder := AEnder;
end;

function TFormaCond_Pagto.Lista_Registros(AId: Integer=0; ACondicao_ID :Integer=0; ANome:String=''): TFDQuery;
begin
  try
    try
      Result := TFDQuery.Create(Nil);
      Result.Connection := FConexao;

      Result.Active := False;
      Result.Sql.Clear;
      Result.Sql.Add('SELECT ');
      Result.Sql.Add('  T.* ');
      Result.Sql.Add('  ,COALESCE(FCP.ID_CONDICAO_PAGAMENTO,0) AS ID_CONDICAO_PAGAMENTO ');
      Result.Sql.Add('  ,COALESCE(CP.DESCRICAO,'''') AS COND_PAGAMENTO ');
      Result.Sql.Add('  ,COALESCE(FCP.ID,0) AS FORMA_COND_PAGTO_ID ');
      Result.Sql.Add('FROM FORMA_PAGAMENTO T ');
      Result.Sql.Add('  LEFT JOIN FORMA_CONDICAO_PAGAMENTO FCP ON FCP.ID_FORMA_PAGAMENTO = T.ID ');
      Result.Sql.Add('  LEFT JOIN CONDICAO_PAGAMENTO CP ON CP.ID = FCP.ID_CONDICAO_PAGAMENTO ');
      Result.SQL.Add('WHERE NOT T.ID IS NULL');
      if AId > 0 then
        Result.Sql.Add('  AND T.ID = ' + AId.ToString);
      if ACondicao_ID > 0 then
        Result.Sql.Add('  AND COALESCE(FCP.ID_CONDICAO_PAGAMENTO,0) = ' + ACondicao_ID.ToString);
      if Trim(ANome) <> '' then
        Result.Sql.Add('  AND T.DESCRICAO LIKE ' + QuotedStr('%'+ANome+'%'));
      Result.Active := True;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

end.
