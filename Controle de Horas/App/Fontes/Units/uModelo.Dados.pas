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

end.
