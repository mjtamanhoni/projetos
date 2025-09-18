program TestValidacao;

{$APPTYPE CONSOLE}
{$DEFINE CONSOLE}

uses
  SysUtils,
  uValidacaoDocumentos in 'uValidacaoDocumentos.pas',
  uExemploValidacao in 'uExemploValidacao.pas';

var
  Opcao: string;
  Documento: string;
  Resultado: TResultadoValidacao;
  Continuar: Boolean;

function BoolToStr(Value: Boolean; UseBoolStrs: Boolean = False): string;
begin
  if UseBoolStrs then
  begin
    if Value then
      Result := 'VÁLIDO'
    else
      Result := 'INVÁLIDO';
  end
  else
  begin
    if Value then
      Result := 'True'
    else
      Result := 'False';
  end;
end;

procedure ExibirMenu;
begin
  WriteLn('===============================================');
  WriteLn('    SISTEMA DE VALIDAÇÃO DE DOCUMENTOS');
  WriteLn('===============================================');
  WriteLn('1 - Validar CPF');
  WriteLn('2 - Validar CNPJ');
  WriteLn('3 - Validar RG');
  WriteLn('4 - Validar Título de Eleitor');
  WriteLn('5 - Validar PIS/PASEP');
  WriteLn('6 - Validar CNH');
  WriteLn('7 - Validar CEP');
  WriteLn('8 - Validar RENAVAM');
  WriteLn('9 - Validar Cartão SUS');
  WriteLn('10 - Executar Exemplos de CPF');
  WriteLn('11 - Executar Exemplos de CNPJ');
  WriteLn('12 - Executar Todos os Exemplos');
  WriteLn('13 - Testar Documentos Válidos');
  WriteLn('14 - Testar Documentos Inválidos');
  WriteLn('0 - Sair');
  WriteLn('===============================================');
  Write('Escolha uma opção: ');
end;

procedure ValidarDocumentoInterativo(TipoDoc: TTipoDocumento; const NomeDoc: string);
begin
  WriteLn;
  WriteLn('=== VALIDAÇÃO DE ' + UpperCase(NomeDoc) + ' ===');
  Write('Digite o ' + NomeDoc + ': ');
  ReadLn(Documento);
  
  Resultado := ValidarDocumento(Documento, TipoDoc);
  
  WriteLn;
  WriteLn('Documento informado: ' + Documento);
  WriteLn('Status: ' + BoolToStr(Resultado.Valido, True));
  WriteLn('Mensagem: ' + Resultado.Mensagem);
  if Resultado.DocumentoFormatado <> '' then
    WriteLn('Formatado: ' + Resultado.DocumentoFormatado);
  WriteLn;
end;

begin
  try
    Continuar := True;
    
    WriteLn('=== SISTEMA DE VALIDAÇÃO DE DOCUMENTOS BRASILEIROS ===');
    WriteLn('Compatível com Delphi 7');
    WriteLn;
    
    while Continuar do
    begin
      ExibirMenu;
      ReadLn(Opcao);
      
      WriteLn;
      
      case StrToIntDef(Opcao, -1) of
        1: ValidarDocumentoInterativo(tdCPF, 'CPF');
        2: ValidarDocumentoInterativo(tdCNPJ, 'CNPJ');
        3: ValidarDocumentoInterativo(tdRG, 'RG');
        4: ValidarDocumentoInterativo(tdTituloEleitor, 'Título de Eleitor');
        5: ValidarDocumentoInterativo(tdPIS, 'PIS/PASEP');
        6: ValidarDocumentoInterativo(tdCNH, 'CNH');
        7: ValidarDocumentoInterativo(tdCEP, 'CEP');
        8: ValidarDocumentoInterativo(tdRenavam, 'RENAVAM');
        9: ValidarDocumentoInterativo(tdCartaoSUS, 'Cartão SUS');
        10: ExemploValidacaoCPF;
        11: ExemploValidacaoCNPJ;
        12: ExemploValidacaoTodosDocumentos;
        13: TestarDocumentosValidos;
        14: TestarDocumentosInvalidos;
        0: 
        begin
          WriteLn('Encerrando o programa...');
          Continuar := False;
        end;
      else
        WriteLn('Opção inválida! Tente novamente.');
      end;
      
      if Continuar then
      begin
        WriteLn;
        Write('Pressione ENTER para continuar...');
        ReadLn;
        WriteLn;
      end;
    end;
    
  except
    on E: Exception do
    begin
      WriteLn('Erro: ' + E.Message);
      WriteLn('Pressione ENTER para sair...');
      ReadLn;
    end;
  end;
end.