unit uJsonReader;

interface

uses
  Windows, SysUtils, Classes, Contnrs;

function LoadJsonText(const FileName: string): string;
procedure JsonGetValuesByKey(const JsonText, KeyName: string; Dest: TStrings);
// Retorna o primeiro valor encontrado para a chave (ou string vazia se não achar)
function JsonGetFirstValue(const JsonText, KeyName: string): string;

implementation

function LoadJsonText(const FileName: string): string;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    // Em Delphi 7, isso carregará como ANSI (uma linha ou várias são indiferentes)
    SL.LoadFromFile(FileName);
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

// Helpers de espaço em branco (Delphi 7)
function IsWhiteSpace(ch: Char): Boolean;
begin
  Result := (ch = ' ') or (ch = #9) or (ch = #10) or (ch = #13);
end;

procedure SkipWhite(const S: string; var I: Integer);
begin
  while (I <= Length(S)) and IsWhiteSpace(S[I]) do
    Inc(I);
end;

function ReadJsonString(const S: string; var I: Integer): string;
var
  sb: string;
  ch: Char;
begin
  sb := '';
  Inc(I); // assume S[I] = '"'
  while I <= Length(S) do
  begin
    ch := S[I];
    Inc(I);
    if ch = '"' then Break
    else if ch = '\' then
    begin
      if I > Length(S) then Break;
      ch := S[I];
      Inc(I);
      case ch of
        '"': sb := sb + '"';
        '\': sb := sb + '\';
        '/': sb := sb + '/';
        'b': sb := sb + #8;
        'f': sb := sb + #12;
        'n': sb := sb + #10;
        'r': sb := sb + #13;
        't': sb := sb + #9;
        'u':
          begin
            if I + 3 <= Length(S) then
              sb := sb + '\u' + Copy(S, I, 4);
            Inc(I, 4);
          end;
      else
        sb := sb + '\' + ch;
      end;
    end
    else
      sb := sb + ch;
  end;
  Result := sb;
end;

function ReadJsonNumber(const S: string; var I: Integer): string;
var
  Start: Integer;
begin
  Start := I;
  while (I <= Length(S)) and (S[I] in ['0'..'9', '-', '+', '.', 'e', 'E']) do
    Inc(I);
  Result := Copy(S, Start, I - Start);
end;

function ReadJsonLiteral(const S: string; var I: Integer): string;
begin
  if Copy(S, I, 4) = 'true' then begin Result := 'true'; Inc(I, 4); Exit; end;
  if Copy(S, I, 5) = 'false' then begin Result := 'false'; Inc(I, 5); Exit; end;
  if Copy(S, I, 4) = 'null' then begin Result := 'null'; Inc(I, 4); Exit; end;
  Result := '';
end;

procedure JsonGetValuesByKey(const JsonText, KeyName: string; Dest: TStrings);
var
  S: string;
  I: Integer;
  key, val: string;
begin
  Dest.Clear;
  S := JsonText;
  I := 1;

  while I <= Length(S) do
  begin
    SkipWhite(S, I);
    if I > Length(S) then Break;

    // Procura por "chave"
    if S[I] = '"' then
    begin
      key := ReadJsonString(S, I);
      SkipWhite(S, I);

      // Espera ':'
      if (I <= Length(S)) and (S[I] = ':') then
      begin
        Inc(I); // pula ':'
        SkipWhite(S, I);

        // Lê valor conforme o tipo
        if (I <= Length(S)) and (S[I] = '"') then
          val := ReadJsonString(S, I)
        else if (I <= Length(S)) and (S[I] in ['0'..'9', '-', '+']) then
          val := ReadJsonNumber(S, I)
        else
          val := ReadJsonLiteral(S, I);

        // Se a chave bate, armazena
        if SameText(key, KeyName) then
          Dest.Add(val);

        // Avança até próxima vírgula/fechamento (tolerante)
        while (I <= Length(S)) and not (S[I] in [',', '}', ']']) do
          Inc(I);
        if (I <= Length(S)) and (S[I] in [',', '}', ']']) then
          Inc(I);
      end
      else
      begin
        // Chave sem ':' — avança
        Inc(I);
      end;
    end
    else
      Inc(I);
  end;
end;

function JsonGetFirstValue(const JsonText, KeyName: string): string;
var
  L: TStringList;
begin
  L := TStringList.Create;
  try
    JsonGetValuesByKey(JsonText, KeyName, L);
    if L.Count > 0 then
      Result := L[0]
    else
      Result := '';
  finally
    L.Free;
  end;
end;

// Novo: parseia array de objetos em uma lista de TStringList (Nome=Valor)
procedure JsonParseArrayOfObjects(const JsonText: string; Objects: TObjectList);
// Novo: helpers de iteração
function JsonArrayCount(const Objects: TObjectList): Integer;
function JsonArrayGet(const Objects: TObjectList; Index: Integer; const FieldName: string): string;

procedure JsonParseArrayOfObjects(const JsonText: string; Objects: TObjectList);
var
  S: string;
  I: Integer;
  SL: TStringList;
begin
  Objects.Clear;
  S := JsonText;
  I := 1;
  SkipWhite(S, I);

  if (I <= Length(S)) and (S[I] = '[') then
  begin
    Inc(I); // pula '['
    while I <= Length(S) do
    begin
      SkipWhite(S, I);
      if (I <= Length(S)) and (S[I] = '{') then
      begin
        SL := TStringList.Create;
        ReadObjectFields(S, I, SL);
        Objects.Add(SL);
        SkipWhite(S, I);
        if (I <= Length(S)) and (S[I] = ',') then Inc(I);
      end
      else if (I <= Length(S)) and (S[I] = ']') then
      begin
        Inc(I);
        Break;
      end
      else
        Inc(I);
    end;
  end
  else if (I <= Length(S)) and (S[I] = '{') then
  begin
    // root = objeto único
    SL := TStringList.Create;
    ReadObjectFields(S, I, SL);
    Objects.Add(SL);
  end;
end;

function JsonArrayCount(const Objects: TObjectList): Integer;
begin
  if Objects = nil then Result := 0 else Result := Objects.Count;
end;

function JsonArrayGet(const Objects: TObjectList; Index: Integer; const FieldName: string): string;
var
  SL: TStringList;
begin
  Result := '';
  if (Objects = nil) or (Index < 0) or (Index >= Objects.Count) then Exit;
  SL := TStringList(Objects[Index]);
  Result := SL.Values[FieldName];
end;

// Atenção: estas helpers precisam estar declaradas antes: SkipWhite, ReadJsonString,
// ReadJsonNumber, ReadJsonLiteral.

// IMPLEMENTE ReadObjectFields ANTES de JsonParseArrayOfObjects
procedure ReadObjectFields(const S: string; var I: Integer; Obj: TStrings);
var
  key, val: string;
  startVal, depth: Integer;
  openCh, closeCh: Char;
begin
  if (I > Length(S)) or (S[I] <> '{') then Exit;
  Inc(I); // pula '{'
  Obj.Clear;

  while I <= Length(S) do
  begin
    // pular espaços
    while (I <= Length(S)) and ((S[I] = ' ') or (S[I] = #9) or (S[I] = #10) or (S[I] = #13)) do Inc(I);

    // fechamento do objeto
    if (I <= Length(S)) and (S[I] = '}') then begin Inc(I); Break; end;

    // chave deve ser string
    if (I <= Length(S)) and (S[I] = '"') then
      key := ReadJsonString(S, I)
    else
    begin
      // chave inválida — avança até vírgula/fechamento
      while (I <= Length(S)) and not (S[I] in [',', '}']) do Inc(I);
      if (I <= Length(S)) and (S[I] = ',') then Inc(I);
      Continue;
    end;

    // ':' após chave
    while (I <= Length(S)) and ((S[I] = ' ') or (S[I] = #9) or (S[I] = #10) or (S[I] = #13)) do Inc(I);
    if (I <= Length(S)) and (S[I] = ':') then Inc(I) else Continue;
    while (I <= Length(S)) and ((S[I] = ' ') or (S[I] = #9) or (S[I] = #10) or (S[I] = #13)) do Inc(I);

    // valor
    if (I <= Length(S)) and (S[I] = '"') then
      val := ReadJsonString(S, I)
    else if (I <= Length(S)) and (S[I] in ['0'..'9', '-', '+']) then
      val := ReadJsonNumber(S, I)
    else if (I <= Length(S)) and (S[I] in ['{', '[']) then
    begin
      // copia literal {…} ou […] balanceando
      openCh := S[I];
      if openCh = '{' then closeCh := '}' else closeCh := ']';
      depth := 0;
      startVal := I;
      while I <= Length(S) do
      begin
        if S[I] = openCh then Inc(depth)
        else if S[I] = closeCh then
        begin
          Dec(depth);
          if depth = 0 then begin Inc(I); Break; end;
        end;
        Inc(I);
      end;
      val := Copy(S, startVal, I - startVal);
    end
    else
      val := ReadJsonLiteral(S, I);

    // guarda par Nome=Valor
    Obj.Values[key] := val;

    // consome separadores
    while (I <= Length(S)) and ((S[I] = ' ') or (S[I] = #9) or (S[I] = #10) or (S[I] = #13)) do Inc(I);
    if (I <= Length(S)) and (S[I] = ',') then Inc(I);
  end;
end;

// Agora JsonParseArrayOfObjects pode chamar ReadObjectFields
procedure JsonParseArrayOfObjects(const JsonText: string; Objects: TObjectList);
var
  S: string;
  I: Integer;
  SL: TStringList;
begin
  Objects.Clear;
  S := JsonText;
  I := 1;
  SkipWhite(S, I);

  if (I <= Length(S)) and (S[I] = '[') then
  begin
    Inc(I); // pula '['
    while I <= Length(S) do
    begin
      SkipWhite(S, I);
      if (I <= Length(S)) and (S[I] = '{') then
      begin
        SL := TStringList.Create;
        ReadObjectFields(S, I, SL);
        Objects.Add(SL);
        SkipWhite(S, I);
        if (I <= Length(S)) and (S[I] = ',') then Inc(I);
      end
      else if (I <= Length(S)) and (S[I] = ']') then
      begin
        Inc(I);
        Break;
      end
      else
        Inc(I);
    end;
  end
  else if (I <= Length(S)) and (S[I] = '{') then
  begin
    SL := TStringList.Create;
    ReadObjectFields(S, I, SL);
    Objects.Add(SL);
  end;
end;

function JsonArrayCount(const Objects: TObjectList): Integer;
begin
  if Objects = nil then Result := 0 else Result := Objects.Count;
end;

function JsonArrayGet(const Objects: TObjectList; Index: Integer; const FieldName: string): string;
var
  SL: TStringList;
begin
  Result := '';
  if (Objects = nil) or (Index < 0) or (Index >= Objects.Count) then Exit;
  SL := TStringList(Objects[Index]);
  Result := SL.Values[FieldName];
end;

end.