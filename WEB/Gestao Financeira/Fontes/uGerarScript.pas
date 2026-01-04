function TfrmGerarScript.QuebrarTexto(const Texto: string; TamanhoLinha: Integer; TextoNaQuebra: String = ''): string;
var
  Palavras: TArray<string>;
  LinhaAtual, Resultado: string;
  i: Integer;
begin
  Palavras := Texto.Split([' ']); // divide em palavras
  LinhaAtual := '';
  Resultado := '';
  
  for i := 0 to High(Palavras) do
  begin
    if Length(LinhaAtual + ' ' + Palavras[i]) <= TamanhoLinha then
    begin
      if LinhaAtual = '' then
        LinhaAtual := Palavras[i]
      else
        LinhaAtual := LinhaAtual + ' ' + Palavras[i];
    end
    else
    begin
      // Adiciona a linha atual com aspa simples e sinal de +
      if Resultado = '' then
        Resultado := LinhaAtual + ''' +' + sLineBreak + ''''
      else
        Resultado := Resultado + LinhaAtual + ''' +' + sLineBreak + ''''; 
      
      LinhaAtual := Palavras[i]; // começa nova linha
    end;
  end;
  
  // adiciona última linha
  if LinhaAtual <> '' then
  begin
    if Resultado = '' then
      Resultado := LinhaAtual // se não houve quebras, retorna o texto original
    else
      Resultado := Resultado + LinhaAtual; // adiciona a última parte
  end;
  
  Result := Resultado;
end;