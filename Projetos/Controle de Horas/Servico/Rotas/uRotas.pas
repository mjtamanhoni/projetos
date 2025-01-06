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

  uFuncoes.Wnd,
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

{$Region 'PRESTADOR_SERVICO'}
  procedure PrestadorServico_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure PrestadorServico_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure PrestadorServico_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure PrestadorServico_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'PRESTADOR_SERVICO'}

{$Region 'TABELA_PRECO'}
  procedure TabelaPreco_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TabelaPreco_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TabelaPreco_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure TabelaPreco_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'TABELA_PRECO'}

{$Region 'USUARIO'}
  procedure Login_Token(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Usuario_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'USUARIO'}

{$Region 'LANCAMENTOS'}
  procedure Lancamentos_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Lancamentos_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Lancamentos_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Lancamentos_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'LANCAMENTOS'}

{$Region 'SERVICOS_PRESTADOS'}
  procedure ServicosPrestados_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ServicosPrestados_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ServicosPrestados_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ServicosPrestados_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
{$EndRegion 'SERVICOS_PRESTADOS'}

implementation

procedure RegistrarRotas;
begin

  {$Region 'USUARIO'}
    THorse.Post('/usuario/login',Login_Token);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/usuario',Usuario_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/usuario',Usuario_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/usuario',Usuario_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/usuario',Usuario_Delete);
  {$EndRegion 'USUARIO'}

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
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Get('/condicaoPagto',Condicao_Pagto_Select);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Post('/condicaoPagto',Condicao_Pagto_Insert);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Put('/condicaoPagto',Condicao_Pagto_Update);
    THorse.AddCallback(HorseJWT(uRota.Auth.SECRET,THorseJWTConfig.New.SessionClass(TMyClaims))).Delete('/condicaoPagto',Condicao_Pagto_Delete);
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

end;

{$Region 'CLIENTE'}
procedure Cliente_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCliente;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCliente.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FNome := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FNome);

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
    FreeAndNil(FModeloDados);
  end;
end;

procedure Cliente_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCliente;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCliente.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Clientes cadastrados com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar os clientes.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Cliente_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCliente;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCliente.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Clientes alterados com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar os clientes.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Cliente_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCliente;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCliente.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Clientes excluídos com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir os clientes.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
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
var
  FId :Integer;
  FDescricao :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCondicaoPagto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCondicaoPagto.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FDescricao := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FDescricao := Req.Query['descricao'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FDescricao);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Condições de Pagamento.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure Condicao_Pagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCondicaoPagto;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCondicaoPagto.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Condições de Pagamentos cadastradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar as Condições de Pagamento.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Condicao_Pagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCondicaoPagto;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCondicaoPagto.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Condições de Pagamentos alteradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar as Condições de Pagamento.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Condicao_Pagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TCondicaoPagto;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TCondicaoPagto.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Condições de Pagamentos excluídas com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as Condições de Pagamento.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'CONDICAO_PAGAMENTO'}

{$Region 'CONTA'}
procedure Conta_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDescricao :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TConta;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TConta.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FDescricao := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FDescricao := Req.Query['descricao'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FDescricao);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Contas.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure Conta_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TConta;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TConta.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Contas cadastradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar as Contas.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Conta_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TConta;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TConta.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Contas alteradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar as Contas.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Conta_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TConta;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TConta.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Contas excluídas com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as Contas.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'CONDICAO_PAGAMENTO'}

{$Region 'EMPRESA'}
procedure Empresa_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TEmpresa;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FNome := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FNome);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Empresas.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure Empresa_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TEmpresa;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Empresas cadastradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar as empresas.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Empresa_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TEmpresa;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Empresas alteradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar as empresas.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Empresa_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TEmpresa;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TEmpresa.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Empresas excluídas com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as empresas.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'EMPRESA'}

{$Region 'FORMA_CONDICAO_PAGAMENTO'}
procedure FormaCondPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FFormaPagto :String;
  FCondPagto :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaCondPagto;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaCondPagto.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FFormaPagto := '';
      FCondPagto := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FFormaPagto := Req.Query['formaPagto'];
      FCondPagto := Req.Query['condPagto'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FFormaPagto,FCondPagto);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Formas/Condições de Pagamento.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure FormaCondPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaCondPagto;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaCondPagto.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Formas/Condições de Pagamentos cadastradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar as formas/condições de pagamentos.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure FormaCondPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaCondPagto;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaCondPagto.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Formas/Condições de Pagamentos alteradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar as Formas/Condições de Pagamentos.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure FormaCondPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaCondPagto;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaCondPagto.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Formas/Condições de Pagamentos excluídas com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as formas/condições de pagamentos.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'FORMA_CONDICAO_PAGAMENTO'}

{$Region 'FORMA_PAGAMENTO'}
procedure FormaPagto_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDescricao :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaPagamento;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaPagamento.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FDescricao := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FDescricao := Req.Query['descricao'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FDescricao);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Formas de Pagamento.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure FormaPagto_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaPagamento;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaPagamento.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Formas de Pagamentos cadastradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar as formas de pagamentos.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure FormaPagto_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaPagamento;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaPagamento.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Formas de Pagamentos alteradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar as Formas de Pagamentos.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure FormaPagto_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFormaPagamento;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFormaPagamento.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Formas de Pagamentos excluídas com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as formas de pagamentos.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'FORMA_PAGAMENTO'}

{$Region 'FORNECEDOR'}
procedure Fornecedor_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFornecedor;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFornecedor.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FNome := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FNome);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Fornecedores.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure Fornecedor_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFornecedor;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFornecedor.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Fornecedores cadastrados com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar os fornecedores.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Fornecedor_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFornecedor;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFornecedor.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Fornecedores alterados com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar os fornecedores.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Fornecedor_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TFornecedor;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TFornecedor.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Fornecedores excluídos com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as fornecedores.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'FORNECEDOR'}

{$Region 'LANCAMENTOS'}
procedure Lancamentos_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FEmpresa_ID :Integer;
  FPessoa_ID :Integer;
  FConta_ID :Integer;
  FFormaPagto_ID :Integer;
  FCondPagto_ID :Integer;
  FDT_Emissao_I :TDate;
  FDT_Emissao_F :TDate;
  FDT_Vencimento_I :TDate;
  FDT_Vencimento_F :TDate;
  FStatus :Integer;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TLancto_Financeiro;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TLancto_Financeiro.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FEmpresa_ID := 0;
      FPessoa_ID := 0;
      FConta_ID := 0;
      FDT_Emissao_I := 0;
      FDT_Emissao_F := 0;
      FDT_Vencimento_I := 0;
      FDT_Vencimento_F := 0;
      FStatus := 0;
      FFormaPagto_ID := 0;
      FCondPagto_ID := 0;
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FEmpresa_ID := StrToIntDef(Req.Query['empresa'],0);
      FFormaPagto_ID := StrToIntDef(Req.Query['formaPagto'],0);
      FCondPagto_ID := StrToIntDef(Req.Query['condPagto'],0);
      FPessoa_ID := StrToIntDef(Req.Query['pessoa'],0);
      FConta_ID := StrToIntDef(Req.Query['conta'],0);
      FStatus := StrToIntDef(Req.Query['status'],-1);
      FDT_Emissao_I := StrToDateDef(Req.Query['dataEmissaoI'],0);
      FDT_Emissao_F := StrToDateDef(Req.Query['dataEmissaoF'],0);
      FDT_Vencimento_I := StrToDateDef(Req.Query['dataVencimentoI'],0);
      FDT_Vencimento_F := StrToDateDef(Req.Query['dataVencimentoF'],0);

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(
        FPagina
        ,FPaginas
        ,FId
        ,FEmpresa_ID
        ,FPessoa_ID
        ,FConta_ID
        ,FFormaPagto_ID
        ,FCondPagto_ID
        ,FStatus
        ,FDT_Emissao_I
        ,FDT_Emissao_F
        ,FDT_Vencimento_I
        ,FDT_Vencimento_F);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar os lançamentos Financeiros.').Status(401);
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
    FreeAndNil(FModeloDados);
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
var
  FId :Integer;
  FNome :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TPrestador_Servico;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TPrestador_Servico.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FNome := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FNome);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Prestadores de Serviços.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure PrestadorServico_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TPrestador_Servico;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TPrestador_Servico.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Prestadores de Serviços cadastrados com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar os prestadores de serviços.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure PrestadorServico_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TPrestador_Servico;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TPrestador_Servico.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Prestadores de Serviços alterados com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar os prestadores de serviços.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure PrestadorServico_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TPrestador_Servico;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TPrestador_Servico.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Prestadores de Serciços excluídos com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as prestadores de serviços.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'PRESTADOR_SERVICO'}

{$Region 'SERVICOS_PRESTADOS'}
procedure ServicosPrestados_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FEmpresa_ID :Integer;
  FPrestador_ID :Integer;
  FCliente_ID :Integer;
  FConta_ID :Integer;
  FData_I :TDate;
  FData_F :TDate;
  FStatus :Integer;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TServicos_Prestados;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TServicos_Prestados.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FEmpresa_ID := 0;
      FPrestador_ID := 0;
      FCliente_ID := 0;
      FConta_ID := 0;
      FData_I := 0;
      FData_F := 0;
      FStatus := 0;
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FEmpresa_ID := StrToIntDef(Req.Query['empresa'],0);
      FPrestador_ID := StrToIntDef(Req.Query['prestador'],0);
      FCliente_ID := StrToIntDef(Req.Query['cliente'],0);
      FConta_ID := StrToIntDef(Req.Query['conta'],0);
      FStatus := StrToIntDef(Req.Query['status'],-1);
      FData_I := StrToDateDef(Req.Query['dataI'],0);
      FData_F := StrToDateDef(Req.Query['dataF'],0);

      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(
        FPagina
        ,FPaginas
        ,FId
        ,FEmpresa_ID
        ,FPrestador_ID
        ,FCliente_ID
        ,FConta_ID
        ,FStatus
        ,FData_I
        ,FData_F);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar os Serviços Prestados.').Status(401);
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
    FreeAndNil(FModeloDados);
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
var
  FId :Integer;
  FDescricao :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TTabela_Preco;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TTabela_Preco.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FDescricao := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FDescricao := Req.Query['descricao'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FDescricao);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar as Tabelas de Preços.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure TabelaPreco_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TTabela_Preco;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TTabela_Preco.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Tabelas de Preços cadastradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar as tabelas de preços.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure TabelaPreco_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TTabela_Preco;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TTabela_Preco.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Tabelas de Preços alteradas com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar as tabelas de preços.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure TabelaPreco_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TTabela_Preco;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TTabela_Preco.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Tabelas de Preços excluídas com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir as tabelas de preços.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'TABELA_PRECO'}

{$Region 'USUARIO'}
procedure Login_Token(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONObject;
  FJson :TJSONObject;

  FUsuario :String;
  FSenha :String;
  FPIN :String;

  FUsuarioID :Integer;
  FUsuarioNome :String;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FTUsuario :TUsuario;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FTUsuario := TUsuario.Create(FDM_Global_Wnd.FDConnection);

      FUsuario := '';
      FSenha := '';
      FPIN := '';

      FBody := Req.Body<TJSONObject>;
      FUsuario := FBody.GetValue<string>('usuario','');
      FSenha := FBody.GetValue<string>('senha','');
      FPin := FBody.GetValue<string>('pin','');

      FJson := FTUsuario.Login(FPin,FUsuario,FSenha);
      if FJson.Size = 0 then
      begin
        Res.Send('Usuário ou senha inválida.').Status(401);
      end
      else
      begin
        FUsuarioID := 0;
        FUsuarioID := FJson.GetValue<integer>('id',0);
        if FUsuarioID = 0 then
          Res.Send('Usuário ou senha inválida.').Status(401)
        else
        begin
          FJson.AddPair('token',Criar_Token(FUsuarioID));
          Res.Send<TJSONObject>(FJson).Status(200);
        end;
      end;
    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
  end;
end;

procedure Usuario_Select(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FNome :String;
  FPagina :Integer;
  FPaginas :Integer;

  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TUsuario;

  FJSon_Retorno :TJSONArray;

begin
  try
    try
      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TUsuario.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FNome := '';
      FPagina := 0;
      FPaginas := 0;

      FId := StrToIntDef(Req.Query['id'],0);
      FNome := Req.Query['nome'];
      FPagina := StrToIntDef(Req.Query['pagina'],0);
      FPaginas := StrToIntDef(Req.Query['paginas'],0);

      FJSon_Retorno := FModeloDados.JSon_Listagem(FPagina,FPaginas,FId,FNome);

      if FJSon_Retorno.Size = 0 then
      begin
        Res.Send('Não foi possível localizar os Usuários.').Status(401);
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
    FreeAndNil(FModeloDados);
  end;
end;

procedure Usuario_Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TUsuario;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TUsuario.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Insert(FBody) then
        Res.Send('Usuários cadastrados com sucesso').Status(200)
      else
        Res.Send('Não foi possível cadatrar os usuários.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Usuario_Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FBody :TJSONArray;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TUsuario;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TUsuario.Create(FDM_Global_Wnd.FDConnection);

      FBody := Req.Body<TJSONArray>;

      if FModeloDados.Json_Update(FBody) then
        Res.Send('Usuários alterados com sucesso').Status(200)
      else
        Res.Send('Não foi possível alterar os usuários.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;

procedure Usuario_Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  FId :Integer;
  FDM_Global_Wnd :TDM_Global_Wnd;
  FModeloDados :TUsuario;
  FFuncoes_Wnd :TFuncoes_Wnd;
begin
  try
    try
      FFuncoes_Wnd := TFuncoes_Wnd.Create;

      FDM_Global_Wnd := TDM_Global_Wnd.Create(Nil);
      FModeloDados := TUsuario.Create(FDM_Global_Wnd.FDConnection);

      FId := 0;
      FId := StrToIntDef(Req.Query['id'],0);

      if FModeloDados.Json_Delete(FId) then
        Res.Send('Usuários excluídos com sucesso').Status(200)
      else
        Res.Send('Não foi possível excluir os usuários.').Status(401);

    except on E: Exception do
      Res.Send(E.Message).Status(500);
    end;
  finally
    FreeAndNil(FFuncoes_Wnd);
  end;
end;
{$EndRegion 'TABELA_PRECO'}

end.
