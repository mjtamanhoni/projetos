procedure TesteLerJson;
var
  json: string;
  valores: TStringList;
begin
  json := LoadJsonText('c:\Developer\Projetos\Projetos\Serviços\Download\CClassTrib.json');

  valores := TStringList.Create;
  try
    // Pega todos os "Nome_cClassTrib" do arquivo (array de objetos)
    JsonGetValuesByKey(json, 'Nome_cClassTrib', valores);
    // Exemplo: mostra o primeiro
    if valores.Count > 0 then
      ShowMessage('Primeiro Nome_cClassTrib: ' + valores[0]);

    // Pega um valor específico (primeira ocorrência)
    ShowMessage('Primeira Descricao_cClassTrib: ' + JsonGetFirstValue(json, 'Descricao_cClassTrib'));
  finally
    valores.Free;
  end;
end;

procedure TesteLoopJson;
var
  json: string;
  objs: TObjectList;
  I: Integer;
  vCST, vDesc: string;
begin
  json := LoadJsonText('c:\Developer\Projetos\Projetos\Serviços\Download\CClassTrib.json');

  objs := TObjectList.Create(True); // OwnsObjects
  try
    JsonParseArrayOfObjects(json, objs);

    for I := 0 to JsonArrayCount(objs) - 1 do
    begin
      vCST  := JsonArrayGet(objs, I, 'CST_IBS_CBS');
      vDesc := JsonArrayGet(objs, I, 'Descricao_CST_IBS_CBS');
      // use vCST/vDesc aqui
    end;
  finally
    objs.Free;
  end;
end;