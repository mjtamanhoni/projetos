unit uRotas;

interface

uses
  System.SysUtils,
  System.JSON,
  FMX.Dialogs,
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.JWT,

  uRota.Auth,
  uModelo.Dados.Wnd,
  uDm.Global.Wnd;

procedure RegistrarRotas;

{$Region 'CLIENTE'}
  procedure Cliente_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Cliente_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Cliente_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Cliente_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'CLIENTE'}

{$Region 'CLIENTE_TABELA'}
  procedure Cliente_Tabela_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Cliente_Tabela_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Cliente_Tabela_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Cliente_Tabela_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'CLIENTE_TABELA'}

{$Region 'CONDICAO_PAGAMENTO'}
  procedure Condicao_Pagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Condicao_Pagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Condicao_Pagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Condicao_Pagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'CONDICAO_PAGAMENTO'}

{$Region 'CONTA'}
  procedure Conta_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Conta_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Conta_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Conta_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'CONTA'}

{$Region 'EMPRESA'}
  procedure Empresa_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Empresa_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Empresa_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Empresa_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'EMPRESA'}

{$Region 'FORMA_CONDICAO_PAGAMENTO'}
  procedure FormaCondPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaCondPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaCondPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaCondPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'FORMA_CONDICAO_PAGAMENTO'}

{$Region 'FORMA_PAGAMENTO'}
  procedure FormaPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure FormaPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'FORMA_PAGAMENTO'}

{$Region 'FORNECEDOR'}
  procedure Fornecedor_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Fornecedor_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Fornecedor_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Fornecedor_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'FORNECEDOR'}

{$Region 'LANCAMENTOS'}
  procedure Lancamentos_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Lancamentos_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Lancamentos_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Lancamentos_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'LANCAMENTOS'}

{$Region 'PRESTADOR_SERVICO'}
  procedure PrestadorServico_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure PrestadorServico_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure PrestadorServico_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure PrestadorServico_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'PRESTADOR_SERVICO'}

{$Region 'SERVICOS_PRESTADOS'}
  procedure ServicosPrestados_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ServicosPrestados_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ServicosPrestados_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ServicosPrestados_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'SERVICOS_PRESTADOS'}

{$Region 'TABELA_PRECO'}
  procedure TabelaPreco_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TabelaPreco_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TabelaPreco_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TabelaPreco_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'TABELA_PRECO'}

{$Region 'USUARIO'}
  procedure Usuario_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'USUARIO'}

implementation

procedure RegistrarRotas;
begin

  {$Region 'CLIENTE'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/cliente',Cliente_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/cliente',Cliente_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/cliente',Cliente_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/cliente',Cliente_Delete);
  {$EndRegion 'CLIENTE'}

  {$Region 'CLIENTE_TABELA'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/clienteTabela',Cliente_Tabela_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/clienteTabela',Cliente_Tabela_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/clienteTabela',Cliente_Tabela_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/clienteTabela',Cliente_Tabela_Delete);
  {$EndRegion 'CLIENTE_TABELA'}

  {$Region 'CONDICAO_PAGAMENTO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/condicaPagto',Condicao_Pagto_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/condicaPagto',Condicao_Pagto_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/condicaPagto',Condicao_Pagto_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/condicaPagto',Condicao_Pagto_Delete);
  {$EndRegion 'CONDICAO_PAGAMENTO'}

  {$Region 'CONTA'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/conta',Conta_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/conta',Conta_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/conta',Conta_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/conta',Conta_Delete);
  {$EndRegion 'CONTA'}

  {$Region 'EMPRESA'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/empresa',Empresa_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/empresa',Empresa_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/empresa',Empresa_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/empresa',Empresa_Delete);
  {$EndRegion 'EMPRESA'}

  {$Region 'FORMA_CONDICAO_PAGAMENTO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/formaCondPagto',FormaCondPagto_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/formaCondPagto',FormaCondPagto_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/formaCondPagto',FormaCondPagto_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/formaCondPagto',FormaCondPagto_Delete);
  {$EndRegion 'FORMA_CONDICAO_PAGAMENTO'}

  {$Region 'FORMA_PAGAMENTO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/formaPagto',FormaPagto_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/formaPagto',FormaPagto_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/formaPagto',FormaPagto_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/formaPagto',FormaPagto_Delete);
  {$EndRegion 'FORMA_PAGAMENTO'}

  {$Region 'FORNECEDOR'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/fornecedor',Fornecedor_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/fornecedor',Fornecedor_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/fornecedor',Fornecedor_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/fornecedor',Fornecedor_Delete);
  {$EndRegion 'FORNECEDOR'}

  {$Region 'LANCAMENTOS'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/lancamentos',Lancamentos_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/lancamentos',Lancamentos_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/lancamentos',Lancamentos_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/lancamentos',Lancamentos_Delete);
  {$EndRegion 'LANCAMENTOS'}

  {$Region 'PRESTADOR_SERVICO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/prestadorServico',PrestadorServico_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/prestadorServico',PrestadorServico_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/prestadorServico',PrestadorServico_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/prestadorServico',PrestadorServico_Delete);
  {$EndRegion 'PRESTADOR_SERVICO'}

  {$Region 'SERVICOS_PRESTADOS'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/servicosPrestados',ServicosPrestados_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/servicosPrestados',ServicosPrestados_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/servicosPrestados',ServicosPrestados_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/servicosPrestados',ServicosPrestados_Delete);
  {$EndRegion 'SERVICOS_PRESTADOS'}

  {$Region 'TABELA_PRECO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/tabelaPreco',TabelaPreco_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/tabelaPreco',TabelaPreco_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/tabelaPreco',TabelaPreco_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/tabelaPreco',TabelaPreco_Delete);
  {$EndRegion 'TABELA_PRECO'}

  {$Region 'USUARIO'}
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/usuario',Usuario_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/usuario',Usuario_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/usuario',Usuario_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/usuario',Usuario_Delete);
  {$EndRegion 'USUARIO'}

end;

{$Region 'CLIENTE'}
procedure Cliente_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FCliente :TCliente;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FCliente := TCliente.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FNome := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FCliente.JSon_Listagem(FPagina,FPaginas,FId,FNome);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar os Clientes.').Status(401);
        //Gravar um log no computador para controlar os retornos
      end
      else
      begin
        Res.Send<TJSONArray>(FJSon_Retorno).Status(200);
        //Gravar um log no computador para controla os retornos
      end;

    except on E: Exception do
      begin
        Res.Send(E.Message).Status(500);
        //Gravar um log no computador para controlar os retornos
      end;
    end;
  finally
    FreeAndNil(FDM_Global_Wnd);
    FreeAndNil(FCliente);
  end;
end;

procedure Cliente_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Cliente_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Cliente_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'CLIENTE'}

{$Region 'CLIENTE_TABELA'}
procedure Cliente_Tabela_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Cliente_Tabela_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Cliente_Tabela_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Cliente_Tabela_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'CLIENTE_TABELA'}

{$Region 'CONDICAO_PAGAMENTO'}
procedure Condicao_Pagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Condicao_Pagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Condicao_Pagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Condicao_Pagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'CONDICAO_PAGAMENTO'}

{$Region 'CONTA'}
procedure Conta_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Conta_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Conta_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Conta_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'CONDICAO_PAGAMENTO'}

{$Region 'EMPRESA'}
procedure Empresa_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Empresa_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Empresa_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Empresa_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'EMPRESA'}

{$Region 'FORMA_CONDICAO_PAGAMENTO'}
procedure FormaCondPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure FormaCondPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure FormaCondPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure FormaCondPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'FORMA_CONDICAO_PAGAMENTO'}

{$Region 'FORMA_PAGAMENTO'}
procedure FormaPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure FormaPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure FormaPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure FormaPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'FORMA_PAGAMENTO'}

{$Region 'FORNECEDOR'}
procedure Fornecedor_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Fornecedor_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Fornecedor_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Fornecedor_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'FORNECEDOR'}

{$Region 'LANCAMENTOS'}
procedure Lancamentos_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Lancamentos_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Lancamentos_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Lancamentos_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'FORNCEDOR'}

{$Region 'PRESTADOR_SERVICO'}
procedure PrestadorServico_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure PrestadorServico_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure PrestadorServico_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure PrestadorServico_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'PRESTADOR_SERVICO'}

{$Region 'SERVICOS_PRESTADOS'}
procedure ServicosPrestados_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure ServicosPrestados_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure ServicosPrestados_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure ServicosPrestados_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'SERVICOS_PRESTADOS'}

{$Region 'TABELA_PRECO'}
procedure TabelaPreco_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TabelaPreco_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TabelaPreco_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TabelaPreco_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'TABELA_PRECO'}

{$Region 'USUARIO'}
procedure Usuario_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Usuario_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Usuario_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure Usuario_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    try

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;
{$EndRegion 'TABELA_PRECO'}

end.
