unit uExemploValidacao;

{*******************************************************************************
  Unit de Exemplo - Validação de Documentos Brasileiros
  
  Esta unit contém exemplos de uso das funções de validação de documentos
  implementadas na unit uValidacaoDocumentos.
  
  Compatível com Delphi 7 e versões superiores
*******************************************************************************}

interface

uses
  SysUtils, Classes, uValidacaoDocumentos;

// Procedimentos de exemplo
procedure ExemploValidacaoCPF;
procedure ExemploValidacaoCNPJ;
procedure ExemploValidacaoTodosDocumentos;
procedure TestarDocumentosValidos;
procedure TestarDocumentosInvalidos;

// Função para exibir resultado da validação
procedure ExibirResultado(const TipoDoc, Documento: string; const Resultado: TResultadoValidacao);

implementation

{*******************************************************************************
  Função auxiliar para exibir resultados
*******************************************************************************}

procedure ExibirResultado(const TipoDoc, Documento: string; const Resultado: TResultadoValidacao);
begin
  {$IFDEF CONSOLE}
  WriteLn('=== VALIDAÇÃO DE ' + UpperCase(TipoDoc) + ' ===');
  WriteLn('Documento informado: ' + Documento);
  WriteLn('Status: ' + BoolToStr(Resultado.Valido, True));
  WriteLn('Mensagem: ' + Resultado.Mensagem);
  if Resultado.DocumentoFormatado <> '' then
    WriteLn('Formatado: ' + Resultado.DocumentoFormatado);
  WriteLn('----------------------------------------');
  WriteLn;
  {$ENDIF}
end;

{*******************************************************************************
  Exemplo de Validação de CPF
*******************************************************************************}

procedure ExemploValidacaoCPF;
var
  Resultado: TResultadoValidacao;
begin
  {$IFDEF CONSOLE}
  WriteLn('=== EXEMPLOS DE VALIDAÇÃO DE CPF ===');
  WriteLn;
  {$ENDIF}
  
  // CPF válido
  Resultado := ValidarCPF('11144477735');
  ExibirResultado('CPF', '11144477735', Resultado);
  
  // CPF válido com formatação
  Resultado := ValidarCPF('111.444.777-35');
  ExibirResultado('CPF', '111.444.777-35', Resultado);
  
  // CPF inválido - dígitos incorretos
  Resultado := ValidarCPF('11144477736');
  ExibirResultado('CPF', '11144477736', Resultado);
  
  // CPF inválido - sequência de números iguais
  Resultado := ValidarCPF('11111111111');
  ExibirResultado('CPF', '11111111111', Resultado);
  
  // CPF inválido - quantidade de dígitos incorreta
  Resultado := ValidarCPF('1114447773');
  ExibirResultado('CPF', '1114447773', Resultado);
end;

{*******************************************************************************
  Exemplo de Validação de CNPJ
*******************************************************************************}

procedure ExemploValidacaoCNPJ;
var
  Resultado: TResultadoValidacao;
begin
  {$IFDEF CONSOLE}
  WriteLn('=== EXEMPLOS DE VALIDAÇÃO DE CNPJ ===');
  WriteLn;
  {$ENDIF}
  
  // CNPJ válido
  Resultado := ValidarCNPJ('11222333000181');
  ExibirResultado('CNPJ', '11222333000181', Resultado);
  
  // CNPJ válido com formatação
  Resultado := ValidarCNPJ('11.222.333/0001-81');
  ExibirResultado('CNPJ', '11.222.333/0001-81', Resultado);
  
  // CNPJ inválido - dígitos incorretos
  Resultado := ValidarCNPJ('11222333000182');
  ExibirResultado('CNPJ', '11222333000182', Resultado);
  
  // CNPJ inválido - sequência de números iguais
  Resultado := ValidarCNPJ('11111111111111');
  ExibirResultado('CNPJ', '11111111111111', Resultado);
end;

{*******************************************************************************
  Exemplo de Validação de Todos os Documentos
*******************************************************************************}

procedure ExemploValidacaoTodosDocumentos;
var
  Resultado: TResultadoValidacao;
begin
  {$IFDEF CONSOLE}
  WriteLn('=== EXEMPLOS DE VALIDAÇÃO DE TODOS OS DOCUMENTOS ===');
  WriteLn;
  {$ENDIF}
  
  // CPF
  Resultado := ValidarDocumento('11144477735', tdCPF);
  ExibirResultado('CPF', '11144477735', Resultado);
  
  // CNPJ
  Resultado := ValidarDocumento('11222333000181', tdCNPJ);
  ExibirResultado('CNPJ', '11222333000181', Resultado);
  
  // RG
  Resultado := ValidarDocumento('123456789', tdRG);
  ExibirResultado('RG', '123456789', Resultado);
  
  // Título de Eleitor
  Resultado := ValidarDocumento('123456780175', tdTituloEleitor);
  ExibirResultado('Título de Eleitor', '123456780175', Resultado);
  
  // PIS/PASEP
  Resultado := ValidarDocumento('12345678911', tdPIS);
  ExibirResultado('PIS/PASEP', '12345678911', Resultado);
  
  // CNH
  Resultado := ValidarDocumento('12345678901', tdCNH);
  ExibirResultado('CNH', '12345678901', Resultado);
  
  // CEP
  Resultado := ValidarDocumento('01310100', tdCEP);
  ExibirResultado('CEP', '01310100', Resultado);
  
  // RENAVAM
  Resultado := ValidarDocumento('12345678901', tdRenavam);
  ExibirResultado('RENAVAM', '12345678901', Resultado);
  
  // Cartão SUS
  Resultado := ValidarDocumento('123456789012345', tdCartaoSUS);
  ExibirResultado('Cartão SUS', '123456789012345', Resultado);
end;

{*******************************************************************************
  Teste com Documentos Válidos
*******************************************************************************}

procedure TestarDocumentosValidos;
var
  Resultado: TResultadoValidacao;
begin
  {$IFDEF CONSOLE}
  WriteLn('=== TESTE COM DOCUMENTOS VÁLIDOS ===');
  WriteLn;
  {$ENDIF}
  
  // CPFs válidos conhecidos
  Resultado := ValidarCPF('11144477735');
  ExibirResultado('CPF', '11144477735', Resultado);
  
  Resultado := ValidarCPF('52998224725');
  ExibirResultado('CPF', '52998224725', Resultado);
  
  // CNPJs válidos conhecidos
  Resultado := ValidarCNPJ('11222333000181');
  ExibirResultado('CNPJ', '11222333000181', Resultado);
  
  Resultado := ValidarCNPJ('34028316000103');
  ExibirResultado('CNPJ', '34028316000103', Resultado);
  
  // CEPs válidos
  Resultado := ValidarCEP('01310-100');
  ExibirResultado('CEP', '01310-100', Resultado);
  
  Resultado := ValidarCEP('20040020');
  ExibirResultado('CEP', '20040020', Resultado);
  
  // Título de Eleitor válido
  Resultado := ValidarTituloEleitor('123456780175');
  ExibirResultado('Título de Eleitor', '123456780175', Resultado);
end;

{*******************************************************************************
  Teste com Documentos Inválidos
*******************************************************************************}

procedure TestarDocumentosInvalidos;
var
  Resultado: TResultadoValidacao;
begin
  {$IFDEF CONSOLE}
  WriteLn('=== TESTE COM DOCUMENTOS INVÁLIDOS ===');
  WriteLn;
  {$ENDIF}
  
  // CPFs inválidos
  Resultado := ValidarCPF('11144477736'); // Dígito incorreto
  ExibirResultado('CPF', '11144477736', Resultado);
  
  Resultado := ValidarCPF('11111111111'); // Sequência igual
  ExibirResultado('CPF', '11111111111', Resultado);
  
  Resultado := ValidarCPF('1234567890'); // Poucos dígitos
  ExibirResultado('CPF', '1234567890', Resultado);
  
  // CNPJs inválidos
  Resultado := ValidarCNPJ('11222333000182'); // Dígito incorreto
  ExibirResultado('CNPJ', '11222333000182', Resultado);
  
  Resultado := ValidarCNPJ('22222222222222'); // Sequência igual
  ExibirResultado('CNPJ', '22222222222222', Resultado);
  
  Resultado := ValidarCNPJ('123456789012'); // Poucos dígitos
  ExibirResultado('CNPJ', '123456789012', Resultado);
  
  // CEPs inválidos
  Resultado := ValidarCEP('00000000'); // CEP zerado
  ExibirResultado('CEP', '00000000', Resultado);
  
  Resultado := ValidarCEP('1234567'); // Poucos dígitos
  ExibirResultado('CEP', '1234567', Resultado);
  
  // PIS inválido
  Resultado := ValidarPIS('12345678912'); // Dígito incorreto
  ExibirResultado('PIS', '12345678912', Resultado);
end;

end.