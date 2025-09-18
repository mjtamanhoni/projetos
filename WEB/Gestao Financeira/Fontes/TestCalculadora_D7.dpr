program TestCalculadora_D7;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uCalculadoraExpressao_D7 in 'uCalculadoraExpressao_D7.pas',
  uExemploCalculadora_D7 in 'uExemploCalculadora_D7.pas';

var
  Calculadora: TCalculadoraExpressao;
  Expressao: string;
  Resultado: Double;
  ResultadoDIFAL: Double;

begin
  try
    WriteLn('=== TESTE DA CALCULADORA DE EXPRESSÕES - DELPHI 7 ===');
    WriteLn;
    
    // Teste 1: Usando a classe diretamente
    WriteLn('Teste 1: Usando TCalculadoraExpressao');
    Calculadora := TCalculadoraExpressao.Create;
    try
      // Define a expressão fornecida pelo usuário
      Expressao := '((#PV# / (1 - ((#AIUD# + #FEM# + #FCP#) / 100))) * (#AI# / 100))';
      
      // Adiciona as variáveis com os valores fornecidos
      Calculadora.AdicionarVariavel('PV', 100.00);    // Valor: 100,00
      Calculadora.AdicionarVariavel('AIUD', 0.18);    // Valor: 0,18
      Calculadora.AdicionarVariavel('AI', 0.12);      // Valor: 0,12
      Calculadora.AdicionarVariavel('FEM', 0);        // Valor: 0
      Calculadora.AdicionarVariavel('FCP', 0.02);     // Valor: 0,02
      
      // Calcula o resultado
      Resultado := Calculadora.CalcularExpressao(Expressao);
      
      WriteLn('Expressão original: ' + Expressao);
      WriteLn('Valores das variáveis:');
      WriteLn('  #PV# = 100,00');
      WriteLn('  #AIUD# = 0,18');
      WriteLn('  #AI# = 0,12');
      WriteLn('  #FEM# = 0');
      WriteLn('  #FCP# = 0,02');
      WriteLn;
      WriteLn('Resultado: ' + FormatFloat('#,##0.0000', Resultado));
      
    finally
      Calculadora.Free;
    end;
    
    WriteLn;
    WriteLn('===========================================');
    WriteLn;
    
    // Teste 2: Usando a função específica para DIFAL
    WriteLn('Teste 2: Usando função CalcularDIFAL');
    ResultadoDIFAL := CalcularDIFAL(100.00, 0.18, 0.12, 0, 0.02);
    WriteLn('Resultado DIFAL: ' + FormatFloat('#,##0.0000', ResultadoDIFAL));
    
    WriteLn;
    WriteLn('===========================================');
    WriteLn;
    
    // Teste 3: Expressão mais simples para validação
    WriteLn('Teste 3: Expressão simples para validação');
    Calculadora := TCalculadoraExpressao.Create;
    try
      Calculadora.AdicionarVariavel('A', 10);
      Calculadora.AdicionarVariavel('B', 5);
      
      Resultado := Calculadora.CalcularExpressao('#A# + #B# * 2');
      WriteLn('Expressão: #A# + #B# * 2 (A=10, B=5)');
      WriteLn('Resultado: ' + FormatFloat('#,##0.0000', Resultado)); // Deve ser 20
      
    finally
      Calculadora.Free;
    end;
    
    WriteLn;
    WriteLn('Pressione ENTER para sair...');
    ReadLn;
    
  except
    on E: Exception do
    begin
      WriteLn('Erro: ' + E.Message);
      WriteLn('Pressione ENTER para sair...');
      ReadLn;
    end;
  end;
end.