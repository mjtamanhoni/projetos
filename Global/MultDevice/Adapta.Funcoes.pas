unit Adapta.Funcoes;

interface

Uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IniFiles,
  System.DateUtils,
  System.Math,
  System.NetEncoding,
  System.Net.HttpClient,
  System.JSON,
  System.IOUtils,

  {$IFDEF ANDROID}
    Androidapi.Jni.PowerManager,
    NetworkState,
  {$ENDIF}

  FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Storage,
  FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.DApt,

  DataSet.Serialize,
  RESTRequest4D,

  Soap.EncdDecd,
  FMX.Controls,
  FMX.Graphics,
  FMX.Platform,
  FMX.VirtualKeyboard,
  FMX.ListView.Types,
  FMX.TextLayout, System.Types;

const
  C_NUMEROS = '0123456789';
  C_LETRAS='ABCDEFGHIJKLMNOPQRSTUVWXYZÇ';

  {$Region 'Push Notification'}
    C_URL_GOOGLE = 'https://fcm.googleapis.com/fcm/send';
    C_API_FIREBASE_COMANDA = 'AAAAJ7le7mI:APA91bHPKrVEwWTJflFxqBpw5HhSZ6SpjRPlSmQxU2yc-GRpiqtYT0zP8Pfpe_kn1biHQ8UDcHSNzsFf-SWYbm9ztUUq6HF1Bn6mz2LYkfXZvV9Q9yiyAAAnpEcuvtfFRzQ6G1qpeUBR';
  {$EndRegion 'Push Notification'}

type
  TTipoRetorno  = (trSim,trNao,trConfirmar,trCancelar);

type
  TTecladoVirtual = (tvMostrar,tvOcultar);

type
  TFuncoes = class(TObject)
  private
    class function Cripytografia(const ATipo,ATexto:String):String;

    class function CriptoLetraNumero(sLetra:String):String;
    class function CriptoNumeroLetra(sNumero:String):String;
    class procedure ThreadEnd_Thread_GravaLog(Sender: TOBject);
  public
    class function Crip_Chave(const AChave:String):String;
    class function Descrip_Chave(const AChave:String):Boolean;
    class function ApenasNumero(const ATexto:String):String;
    class function PreencheVariavel(sTexto,sPreencher,sPosicao:String;iQtd:Integer):String;
    class function Define_Decimais(const ATruncar:Boolean;AValor:Double;ADecimais:Integer=2):Double;
    class function Truncar_Valor(const AValor:Double;ADecimais:Integer=2):Double;
    class function Arrend(const AValor:Double;ADecimais:Integer=2):Double;
    class function RetornaValor(const ADecimal:Int64):Int64;
    class function RetornaInteiro(const AValor:Double):Int64;
    class function Crip_Adapta(const ATexto:String):String;
    class function DesCrip_Adapta(const ATexto:String):String;
    class function ValidaEmail(const AEmail:String):Boolean;
    class function ConverteValor(AValor: String): Double;
    class function RemoveAcento(const ATexto:String):String;
    class function Possui_Letras(const ATexto:String):Boolean;
    class function BitmapFromBase64(const base64: string): TBitmap;
    class function Base64FromBitmap(Bitmap: TBitmap): string;
    class function TestaConexao(out Conexao:String):Boolean;

    class function Converte_Data(const AData:String):TDate;
    class function Converte_Hora(const AHora:String):TTime;
    class function Converte_Data_Hora(const ADataHora:String):TDateTime;
    class function Retorna_Data_Json(const AData:String; out AErro:String):TDate;
    class function Retorna_Hora_Json(const AHora:String; out AErro:String):TTime;

    class function GetTextHeight(
      const D:TListItemText;
      const Width:Single;
      const Text:String):Integer;

    class procedure Manter_Tela_Ligada(const AManter:Boolean);
    class procedure MostarOcultar_Teclado(AComponentControl: TControl; ATecladoVirtual:TTecladoVirtual);
    class procedure Grava_Log(
      AFormulario:String;
      ARotina:String;
      AData:String;
      AHora:String;
      APosicao:String;
      ALog:String);
  end;

implementation

{ TFuncoes }

class function TFuncoes.ApenasNumero(const ATexto: String): String;
var
  I:Integer;
begin
  Result := EmptyStr;
  for I := 1 to Length(ATexto) do
  begin
    if Pos(Copy(ATexto,I,1),C_NUMEROS) > 0 then
      Result := Result + Copy(ATexto,I,1);
  end;
end;

class function TFuncoes.Arrend(const AValor: Double;
  ADecimais: Integer): Double;
var
  lFactor   :Double;
  lFraction :Double;
  lValor    :Double;
begin
  lFactor   := 0;
  lFraction := 0;
  lValor    := 0;

  lFactor   := IntPower(10,ADecimais);
  lValor    := StrToFloat(FloatToStr(AValor * lFactor));
  Result    := Int(lValor);
  lFraction := Frac(lValor);
  if lFraction >= 0.5 then
    Result := Result + 1
  else if lFraction <= -0.5 then
    Result := Result - 1;

  if lFactor > 0 then
    Result := Result / lFactor
  else
    Result := 0;
end;

class function TFuncoes.Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
begin
  Input := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);

    try
      Soap.EncdDecd.EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;

  finally
    Input.Free;
  end;
end;

class function TFuncoes.BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
  Encoding: TBase64Encoding;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      Encoding := TBase64Encoding.Create(0);
      Encoding.Decode(Input, Output);

      Output.Position := 0;
      Result := TBitmap.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Encoding.DisposeOf;
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

class function TFuncoes.ConverteValor(AValor: String): Double;
begin
  try
    AValor := StringReplace(AValor,'R$','',[rfReplaceAll]);
    AValor := AValor.Replace(',', '').Replace('.', '');
    Result := AValor.ToDouble / 100;
  except
      Result := 0;
  end;
end;

class function TFuncoes.Converte_Data(const AData: String): TDate;
var
  lDia,lMes,lAno:String;
  lDiaI,lMesI,lAnoI :Integer;
begin
  try
    try
      Result := Date;

      lDia := Copy(AData,9,2);
      lMes := Copy(AData,6,2);
      lAno := Copy(AData,1,4);

      lDiaI := lDia.ToInteger;
      lMesI := lMes.ToInteger;
      lAnoI := lAno.ToInteger;

      //Result := StrToDateDef(lDia + '/' + lMes + '/' + lAno,Date);
      Result := EncodeDate(lAnoI,lMesI,lDiaI);
    Except
      Result := Date;
    end;
  finally
  end;
end;

class function TFuncoes.Converte_Data_Hora(const ADataHora: String): TDateTime;
var
  lDia,lMes,lAno,lHora:String;
begin
  try
    try
      Result := Date;

      lDia  := Copy(ADataHora,9,2);
      lMes  := Copy(ADataHora,6,2);
      lAno  := Copy(ADataHora,1,4);
      lHora := Copy(ADataHora,12,8);

      Result := StrToDateTimeDef(lDia + '/' + lMes + '/' + lAno + ' ' + lHora,Now);
    Except
      Result := Date;
    end;
  finally
  end;
end;

class function TFuncoes.Converte_Hora(const AHora: String): TTime;
var
  lHora:String;
  lHor,lMin,lSeg,lMil :Integer;

begin
  try
    try
      Result := Time;
      //1899-12-30T06:53:59.000Z
      //06:58:16.343
      lHor := 0;
      lMin := 0;
      lSeg := 0;
      lMil := 0;

      if Length(AHora) = 24 then
      begin
        lHora := Copy(AHora,12,8);
        lHor := StrToIntDef(Copy(AHora,12,2),0);
        lMin := StrToIntDef(Copy(AHora,15,2),0);
        lSeg := StrToIntDef(Copy(AHora,18,2),0);
        lMil := StrToIntDef(Copy(AHora,21,3),0);
      end
      else if Length(AHora) = 12 then
      begin
        lHora := Copy(AHora,1,8);
        lHor := StrToIntDef(Copy(AHora,1,2),0);
        lMin := StrToIntDef(Copy(AHora,4,2),0);
        lSeg := StrToIntDef(Copy(AHora,7,2),0);
        lMil := StrToIntDef(Copy(AHora,10,3),0);
      end;

      //Result := StrToTimeDef(lHora,Time);
      Result := EncodeTime(lHor,lMin,lSeg,lMil);
    Except
      Result := Time;
    end;
  finally
  end;
end;

class function TFuncoes.CriptoLetraNumero(sLetra: String): String;
begin
  try
    Result := '';
    if sLetra = '!'  then Result := '01';
    if sLetra = '"'  then Result := '11';
    if sLetra = '#'  then Result := '21';
    if sLetra = '$'  then Result := '31';
    if sLetra = '%'  then Result := '41';
    if sLetra = '&'  then Result := '51';
    if sLetra = '''' then Result := '61';
    if sLetra = '('  then Result := '71';
    if sLetra = ')'  then Result := '81';
    if sLetra = '*'  then Result := '91';
    if sLetra = '+'  then Result := '02';
    if sLetra = ','  then Result := '12';
    if sLetra = '-'  then Result := '22';
    if sLetra = '.'  then Result := '32';
    if sLetra = '/'  then Result := '42';
    if sLetra = '0'  then Result := '52';
    if sLetra = '1'  then Result := '62';
    if sLetra = '2'  then Result := '72';
    if sLetra = '3'  then Result := '82';
    if sLetra = '4'  then Result := '92';
    if sLetra = '5'  then Result := '03';
    if sLetra = '6'  then Result := '13';
    if sLetra = '7'  then Result := '23';
    if sLetra = '8'  then Result := '33';
    if sLetra = '9'  then Result := '43';
    if sLetra = ':'  then Result := '53';
    if sLetra = ';'  then Result := '63';
    if sLetra = '<'  then Result := '73';
    if sLetra = '='  then Result := '83';
    if sLetra = '>'  then Result := '93';
    if sLetra = '?'  then Result := '04';
    if sLetra = '@'  then Result := '14';
    if sLetra = 'A'  then Result := '24';
    if sLetra = 'B'  then Result := '34';
    if sLetra = 'C'  then Result := '44';
    if sLetra = 'D'  then Result := '54';
    if sLetra = 'E'  then Result := '64';
    if sLetra = 'F'  then Result := '74';
    if sLetra = 'G'  then Result := '84';
    if sLetra = 'H'  then Result := '94';
    if sLetra = 'I'  then Result := '05';
    if sLetra = 'J'  then Result := '15';
    if sLetra = 'K'  then Result := '25';
    if sLetra = 'L'  then Result := '35';
    if sLetra = 'M'  then Result := '45';
    if sLetra = 'N'  then Result := '55';
    if sLetra = 'O'  then Result := '65';
    if sLetra = 'P'  then Result := '75';
    if sLetra = 'Q'  then Result := '85';
    if sLetra = 'R'  then Result := '95';
    if sLetra = 'S'  then Result := '06';
    if sLetra = 'T'  then Result := '16';
    if sLetra = 'U'  then Result := '26';
    if sLetra = 'V'  then Result := '36';
    if sLetra = 'W'  then Result := '46';
    if sLetra = 'X'  then Result := '56';
    if sLetra = 'Y'  then Result := '66';
    if sLetra = 'Z'  then Result := '76';
    if sLetra = '['  then Result := '86';
    if sLetra = ']'  then Result := '96';
    if sLetra = 'a'  then Result := '07';
    if sLetra = 'b'  then Result := '17';
    if sLetra = 'c'  then Result := '27';
    if sLetra = 'd'  then Result := '37';
    if sLetra = 'e'  then Result := '47';
    if sLetra = 'f'  then Result := '57';
    if sLetra = 'g'  then Result := '67';
    if sLetra = 'h'  then Result := '77';
    if sLetra = 'i'  then Result := '87';
    if sLetra = 'j'  then Result := '97';
    if sLetra = 'k'  then Result := '08';
    if sLetra = 'l'  then Result := '18';
    if sLetra = 'm'  then Result := '28';
    if sLetra = 'n'  then Result := '38';
    if sLetra = 'o'  then Result := '48';
    if sLetra = 'p'  then Result := '58';
    if sLetra = 'q'  then Result := '68';
    if sLetra = 'r'  then Result := '78';
    if sLetra = 's'  then Result := '88';
    if sLetra = 't'  then Result := '98';
    if sLetra = 'u'  then Result := '09';
    if sLetra = 'v'  then Result := '19';
    if sLetra = 'w'  then Result := '29';
    if sLetra = 'x'  then Result := '39';
    if sLetra = 'y'  then Result := '49';
    if sLetra = 'z'  then Result := '59';
    if sLetra = '{'  then Result := '69';
    if sLetra = '|'  then Result := '79';
    if sLetra = '}'  then Result := '89';
    if sLetra = ' '  then Result := '99';
  except
    Result := sLetra;
  end;
end;

class function TFuncoes.CriptoNumeroLetra(sNumero: String): String;
begin
  try
    Result := '';
    if sNumero = '01' then Result := '!';
    if sNumero = '11' then Result := '"';
    if sNumero = '21' then Result := '#';
    if sNumero = '31' then Result := '$';
    if sNumero = '41' then Result := '%';
    if sNumero = '51' then Result := '&';
    if sNumero = '61' then Result := '''';
    if sNumero = '71' then Result := '(';
    if sNumero = '81' then Result := ')';
    if sNumero = '91' then Result := '*';
    if sNumero = '02' then Result := '+';
    if sNumero = '12' then Result := ',';
    if sNumero = '22' then Result := '-';
    if sNumero = '32' then Result := '.';
    if sNumero = '42' then Result := '/';
    if sNumero = '52' then Result := '0';
    if sNumero = '62' then Result := '1';
    if sNumero = '72' then Result := '2';
    if sNumero = '82' then Result := '3';
    if sNumero = '92' then Result := '4';
    if sNumero = '03' then Result := '5';
    if sNumero = '13' then Result := '6';
    if sNumero = '23' then Result := '7';
    if sNumero = '33' then Result := '8';
    if sNumero = '43' then Result := '9';
    if sNumero = '53' then Result := ':';
    if sNumero = '63' then Result := ';';
    if sNumero = '73' then Result := '<';
    if sNumero = '83' then Result := '=';
    if sNumero = '93' then Result := '>';
    if sNumero = '04' then Result := '?';
    if sNumero = '14' then Result := '@';
    if sNumero = '24' then Result := 'A';
    if sNumero = '34' then Result := 'B';
    if sNumero = '44' then Result := 'C';
    if sNumero = '54' then Result := 'D';
    if sNumero = '64' then Result := 'E';
    if sNumero = '74' then Result := 'F';
    if sNumero = '84' then Result := 'G';
    if sNumero = '94' then Result := 'H';
    if sNumero = '05' then Result := 'I';
    if sNumero = '15' then Result := 'J';
    if sNumero = '25' then Result := 'K';
    if sNumero = '35' then Result := 'L';
    if sNumero = '45' then Result := 'M';
    if sNumero = '55' then Result := 'N';
    if sNumero = '65' then Result := 'O';
    if sNumero = '75' then Result := 'P';
    if sNumero = '85' then Result := 'Q';
    if sNumero = '95' then Result := 'R';
    if sNumero = '06' then Result := 'S';
    if sNumero = '16' then Result := 'T';
    if sNumero = '26' then Result := 'U';
    if sNumero = '36' then Result := 'V';
    if sNumero = '46' then Result := 'W';
    if sNumero = '56' then Result := 'X';
    if sNumero = '66' then Result := 'Y';
    if sNumero = '76' then Result := 'Z';
    if sNumero = '86' then Result := '[';
    if sNumero = '96' then Result := ']';
    if sNumero = '07' then Result := 'a';
    if sNumero = '17' then Result := 'b';
    if sNumero = '27' then Result := 'c';
    if sNumero = '37' then Result := 'd';
    if sNumero = '47' then Result := 'e';
    if sNumero = '57' then Result := 'f';
    if sNumero = '67' then Result := 'g';
    if sNumero = '77' then Result := 'h';
    if sNumero = '87' then Result := 'i';
    if sNumero = '97' then Result := 'j';
    if sNumero = '08' then Result := 'k';
    if sNumero = '18' then Result := 'l';
    if sNumero = '28' then Result := 'm';
    if sNumero = '38' then Result := 'n';
    if sNumero = '48' then Result := 'o';
    if sNumero = '58' then Result := 'p';
    if sNumero = '68' then Result := 'q';
    if sNumero = '78' then Result := 'r';
    if sNumero = '88' then Result := 's';
    if sNumero = '98' then Result := 't';
    if sNumero = '09' then Result := 'u';
    if sNumero = '19' then Result := 'v';
    if sNumero = '29' then Result := 'w';
    if sNumero = '39' then Result := 'x';
    if sNumero = '49' then Result := 'y';
    if sNumero = '59' then Result := 'z';
    if sNumero = '69' then Result := '{';
    if sNumero = '79' then Result := '|';
    if sNumero = '89' then Result := '}';
    if sNumero = '99' then Result := ' ';
  except
    Result := '';
  end;
end;

class function TFuncoes.Cripytografia(const ATipo, ATexto: String): String;
begin
  if ATipo = 'C' then
  begin
    case StrToIntDef(ATexto,-1) of
      0: Result := '3V';
      1: Result := '9U';
      2: Result := 'V3';
      3: Result := 'Y9';
      4: Result := '2B';
      5: Result := 'A2';
      6: Result := 'C2';
      7: Result := 'BB';
      8: Result := 'J0';
      9: Result := '0J';
    end;
  end
  else if ATipo = 'D' then
  begin
    if ATexto = '3V' then
      Result := '0'
    else if ATexto = '9U' then
      Result := '1'
    else if ATexto = 'V3' then
      Result := '2'
    else if ATexto = 'Y9' then
      Result := '3'
    else if ATexto = '2B' then
      Result := '4'
    else if ATexto = 'A2' then
      Result := '5'
    else if ATexto = 'C2' then
      Result := '6'
    else if ATexto = 'BB' then
      Result := '1'
    else if ATexto = 'J0' then
      Result := '8'
    else if ATexto = '0J' then
      Result := '9';
  end;
end;

class function TFuncoes.Crip_Adapta(const ATexto:String): String;
var
  i             :Integer;
  sTextoRetorno :String;
begin
  try
    sTextoRetorno := '';
    for i := 1 to (Length(ATexto)) do
      sTextoRetorno := sTextoRetorno + CriptoLetraNumero(Copy(ATexto,i,1));

    Result := sTextoRetorno;
  except
    Result := ATexto;
  end;
end;

class function TFuncoes.DesCrip_Adapta(const ATexto: String): String;
var
  i             :Integer;
  iPosCopiar    :Integer;
  sTextoRetorno :String;
begin
  try
    sTextoRetorno := '';
    iPosCopiar    := 0;
    for i := 1 to (Length(ATexto)) do
    begin
      if iPosCopiar = 0 then
        iPosCopiar := i
      else
        iPosCopiar := (iPosCopiar + 2);
      sTextoRetorno := sTextoRetorno + CriptoNumeroLetra(Copy(ATexto,iPosCopiar,2));
    end;
    Result := sTextoRetorno;
  except
    Result := ATexto;
  end;
end;

class function TFuncoes.Crip_Chave(const AChave: String): String;
var
  I :Integer;
begin
  try
    try
      Result := '';
      for I := 1 to Length(AChave) do
      begin
        Result := Result + Cripytografia('C',Copy(AChave,I,1));
      end;
    except
      ON E:Exception do
      begin
        Result := 'Erro: ' + E.Message;
      end;
    end;
  finally
  end;
end;

class function TFuncoes.Define_Decimais(const ATruncar: Boolean; AValor: Double;
  ADecimais: Integer): Double;
begin
 if ATruncar then
   Result := Truncar_Valor(AValor,ADecimais)
 else
   Result := Arrend(AValor,ADecimais);
end;

class function TFuncoes.Descrip_Chave(const AChave: String): Boolean;
begin

end;

class function TFuncoes.GetTextHeight(
      const D:TListItemText;
      const Width:Single;
      const Text:String): Integer;
var
  Layout :TTextLayout;
begin
  Layout := TTextLayoutManager.DefaultTextLayout.Create;

  try
    Layout.BeginUpdate;
    try
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width,TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;
    Result := Round(Layout.Height);
    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(Layout);
    {$ELSE}
      Layout.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TFuncoes.Grava_Log(
      AFormulario:String;
      ARotina:String;
      AData:String;
      AHora:String;
      APosicao:String;
      ALog:String);
var
  t :TThread;
begin

  t := TThread.CreateAnonymousThread(
  procedure
  var
    lArq :TStringList;
    lEnder :String;
    FDMemJson: TFDMemTable;
  begin
    lArq := TStringList.Create;
    FDMemJson := TFDMemTable.Create(Nil);
    FDMemJson.FieldDefs.Add('furmulario',ftString,255,False);
    FDMemJson.FieldDefs.Add('rotina',ftString,255,False);
    FDMemJson.FieldDefs.Add('data',ftString,10,True);
    FDMemJson.FieldDefs.Add('hora',ftString,8,True);
    FDMemJson.FieldDefs.Add('posicao',ftString,3,False);
    FDMemJson.FieldDefs.Add('log',ftString,1000,True);
    FDMemJson.CreateDataSet;

    lEnder  := '';
    {$IFDEF MSWINDOWS}
      lEnder := System.SysUtils.GetCurrentDir + '\LOG.JSON';
    {$ELSE}
      lEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'LOG.JSON');
    {$ENDIF}
    TThread.Synchronize(nil, procedure
    begin
      if FileExists(lEnder) then
      begin
        FDMemJson.LoadFromFile(lEnder,sfJSON);
        lArq.LoadFromFile(lEnder);
      end
      else
      begin
        FDMemJson.Active := True;
        lArq.Add('[');
        lArq.Add(']');
      end;

      //FDMemJson.Insert;
      FDMemJson.AppendRecord([AFormulario,ARotina,AData,AHora,APosicao,ALog]);
      FDMemJson.SaveToFile(lEnder,sfJSON);

      if FileExists(lEnder) then
        lArq.Insert((lArq.Count-1),'  ,{')
      else
        lArq.Insert((lArq.Count-1),'  {');
      lArq.Insert((lArq.Count-1),'    "furmulario":"'+AFormulario+'",');
      lArq.Insert((lArq.Count-1),'    "rotina":"'+ARotina+'",');
      lArq.Insert((lArq.Count-1),'    "data":"'+AData+'",');
      lArq.Insert((lArq.Count-1),'    "hora":"'+AHora+'",');
      lArq.Insert((lArq.Count-1),'    "posicao":"'+APosicao+'",');
      lArq.Insert((lArq.Count-1),'    "log":"'+ALog+'",');
      lArq.Insert((lArq.Count-1),'  }');

      //lArq.SaveToFile(lEnder);
      {$IFDEF MSWINDOWS}
        FreeAndNil(lArq);
        FreeAndNil(FDMemJson);
      {$ELSE}
        lArq.DisposeOf;
        FDMemJson.DisposeOf;
      {$ENDIF}
    end);

  end);

  t.OnTerminate := ThreadEnd_Thread_GravaLog;
  t.Start;

end;

class procedure TFuncoes.ThreadEnd_Thread_GravaLog(Sender :TOBject);
var
  lErro :String;
begin
  if Assigned(TThread(Sender).FatalException) then
    lErro :=  Exception(TThread(Sender).FatalException).Message;
end;

class procedure TFuncoes.Manter_Tela_Ligada(const AManter: Boolean);
begin
  {$IFDEF ANDROID}
    if AManter then
      Androidapi.Jni.PowerManager.AcquireWakeLock
    else
      Androidapi.Jni.PowerManager.ReleaseWakeLock;
  {$ENDIF}
end;

class procedure TFuncoes.MostarOcultar_Teclado(AComponentControl: TControl; ATecladoVirtual:TTecladoVirtual);
var
  FService :IFMXVirtualKeyboardService;
begin
  case ATecladoVirtual of
    tvMostrar :begin
      TPlatformServices.Current.SupportsPlatformService(
        IFMXVirtualKeyboardService
        ,IInterface(FService));

      if FService <> Nil then
      begin
        FService.ShowVirtualKeyboard(AComponentControl);
        if (AComponentControl <> NIl) and (AComponentControl.CanFocus) then
          AComponentControl.SetFocus;
      end;
    end;
    tvOcultar :begin
      TPlatformServices.Current.SupportsPlatformService(
        IFMXVirtualKeyboardService
        ,IInterface(FService));

      if FService <> Nil then
        FService.HideVirtualKeyboard;
    end;
  end;
end;

class function TFuncoes.Possui_Letras(const ATexto: String): Boolean;
var
  I:Integer;
begin
  Result := False;
  for I := 1 to Length(ATexto) do
  begin
    if Pos(Copy(ATexto,I,1),RemoveAcento(C_LETRAS)) > 0 then
    begin
      Result := True;
      Break;
    end;
  end;
end;

class function TFuncoes.PreencheVariavel(sTexto, sPreencher, sPosicao: String; iQtd: Integer): String;
var
  i:Integer;
begin
  Result := '';
  Result := sTexto;
  if (iQtd - Length(sTexto)) < 1 then
    Exit;

  for i := 1 to (iQtd - Length(sTexto)) do
  begin
    if sPosicao = 'D' then //Direita
      Result := Result + sPreencher
    else if sPosicao = 'E' then //Esquerda
      Result := sPreencher + Result
    else if sPosicao = 'C' then //Centro
    begin
      if (i MOD 2) = 0 then
        Result := sPreencher + Result
      else
        Result := Result + sPreencher;
    end;
  end;
end;

class function TFuncoes.RemoveAcento(const ATexto: String): String;
begin
  Result := ATexto;
  Result := StringReplace(Result,'á','a',[rfReplaceAll]);
  Result := StringReplace(Result,'é','e',[rfReplaceAll]);
  Result := StringReplace(Result,'í','i',[rfReplaceAll]);
  Result := StringReplace(Result,'ó','o',[rfReplaceAll]);
  Result := StringReplace(Result,'ú','u',[rfReplaceAll]);
  Result := StringReplace(Result,'Á','A',[rfReplaceAll]);
  Result := StringReplace(Result,'É','E',[rfReplaceAll]);
  Result := StringReplace(Result,'Í','I',[rfReplaceAll]);
  Result := StringReplace(Result,'Ó','O',[rfReplaceAll]);
  Result := StringReplace(Result,'Ú','U',[rfReplaceAll]);

  Result := StringReplace(Result,'ã','a',[rfReplaceAll]);
  Result := StringReplace(Result,'õ','o',[rfReplaceAll]);
  Result := StringReplace(Result,'Ã','A',[rfReplaceAll]);
  Result := StringReplace(Result,'Õ','O',[rfReplaceAll]);

  Result := StringReplace(Result,'â','a',[rfReplaceAll]);
  Result := StringReplace(Result,'ê','e',[rfReplaceAll]);
  Result := StringReplace(Result,'î','i',[rfReplaceAll]);
  Result := StringReplace(Result,'ô','o',[rfReplaceAll]);
  Result := StringReplace(Result,'û','u',[rfReplaceAll]);
  Result := StringReplace(Result,'Â','A',[rfReplaceAll]);
  Result := StringReplace(Result,'Ê','E',[rfReplaceAll]);
  Result := StringReplace(Result,'Î','I',[rfReplaceAll]);
  Result := StringReplace(Result,'Ô','O',[rfReplaceAll]);
  Result := StringReplace(Result,'Û','U',[rfReplaceAll]);

  Result := StringReplace(Result,'à','a',[rfReplaceAll]);
  Result := StringReplace(Result,'è','e',[rfReplaceAll]);
  Result := StringReplace(Result,'ì','i',[rfReplaceAll]);
  Result := StringReplace(Result,'ò','o',[rfReplaceAll]);
  Result := StringReplace(Result,'ù','u',[rfReplaceAll]);
  Result := StringReplace(Result,'À','A',[rfReplaceAll]);
  Result := StringReplace(Result,'È','E',[rfReplaceAll]);
  Result := StringReplace(Result,'Ì','I',[rfReplaceAll]);
  Result := StringReplace(Result,'Ò','O',[rfReplaceAll]);
  Result := StringReplace(Result,'Ù','U',[rfReplaceAll]);

  Result := StringReplace(Result,'ç','c',[rfReplaceAll]);
  Result := StringReplace(Result,'Ç','C',[rfReplaceAll]);

end;

class function TFuncoes.RetornaInteiro(const AValor: Double): Int64;
var
  lStrValor :String;
begin
  lStrValor := FormatFloat('0.00',AValor);
  Result    := StrToInt64Def(Copy(lStrValor,1,Pos(',',lStrValor)-1),0);
end;

class function TFuncoes.RetornaValor(const ADecimal: Int64): Int64;
var
  I :Integer;
  lString :String;
begin
  lString := '';
  for I := 1 to ADecimal do
  begin
    lString := lString + '0';
  end;

  Result := StrToInt64Def('1'+lString,1);
end;

class function TFuncoes.Retorna_Data_Json(const AData:String; out AErro:String): TDate;
var
  lDia,lMes,lAno :Integer;
begin
  try
    AErro := '';
    //09/08/2022
    lDia := StrToInt(Copy(AData,1,2));
    lMes := StrToInt(Copy(AData,4,2));
    lAno := StrToInt(Copy(AData,7,4));
    Result := EncodeDate(lAno,lMes,lDia);
  except
    On Ex:Exception do
    begin
      Result := Date;
      AErro  := 'Valida data: ' + Ex.Message;
    end;
  end;
end;

class function TFuncoes.Retorna_Hora_Json(const AHora:String; out AErro:String): TTime;
var
  lHor,lMin,lSec,lMil :Integer;
begin
  try
    AErro := '';
    lHor := StrToInt(Copy(AHora,1,2));
    lMin := StrToInt(Copy(AHora,4,2));
    lSec := StrToInt(Copy(AHora,7,2));
    lMil := StrToInt(Copy(AHora,10,4));

    Result := EncodeTime(lHor,lMin,lSec,lMil);
  except
    On Ex:Exception do
    begin
      Result := Time;
      AErro  := 'Valida hora: ' + Ex.Message;
    end;
  end;
end;

class function TFuncoes.TestaConexao(out Conexao: String): Boolean;
var
  {$IFDEF MSWINDOWS}
    lHttp :THTTPClient;
  {$ELSE}
    NS: TNetworkState;
  {$ENDIF}
begin
  try
    try
      Conexao := '';
      Result := False;
      {$IFDEF MSWINDOWS}
        lHttp := THTTPClient.Create;
        try
          Result := lHttp.Head('https://google.com').StatusCode < 400;
        except
        end;
      {$ELSE}
        NS := TNetworkState.Create;
        if not NS.IsConnected then
            Conexao := ''
        else
        if NS.IsWifiConnected then
        begin
            Conexao := 'WIFI';
            Result := True;
        end
        else
        if NS.IsMobileConnected then
        begin
            Conexao := 'MOBILE';
            Result := True;
        end;
      {$ENDIF}
    except
      On Ex:Exception do
      begin
        Result := False;
        Conexao := Ex.Message;
      end;
    end;

  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lHttp);
    {$ELSE}
      NS.DisposeOf;
    {$ENDIF}
  end;
end;

class function TFuncoes.Truncar_Valor(const AValor: Double;
  ADecimais: Integer): Double;
var
  lDecimal  :Int64;
  lTruncado :Int64;
  lValor    :Double;

begin
  lDecimal  := 0;
  lTruncado := 0;
  lValor    := 0;

  lDecimal  := RetornaValor(ADecimais);
  lValor    := (AValor * lDecimal);
  lTruncado := RetornaInteiro(lValor);
  if lDecimal > 0 then
    Result := (lTruncado / lDecimal)
  else
    Result := 0;
end;

class function TFuncoes.ValidaEmail(const AEmail: String): Boolean;
var
  lEmail :String;
begin

 lEmail := Trim(UpperCase(AEmail));

 if Pos('@', lEmail) > 1 then
 begin
   Delete(lEmail, 1, pos('@', lEmail));
   Result := (Length(lEmail) > 0) and (Pos('.', lEmail) > 2);
 end
 else
   Result := False;end;

end.

(*
function LerConfig(iChave,iTag,iDef:String; iSalvar: boolean = false):String;
var
  ServerIni:TIniFile;
begin
  ServerIni := TIniFile.Create(DmModulo.mDirAplicacao + '\IntegradorAdapta.ini');

  if (not ServerIni.ValueExists(iChave,iTag)) or iSalvar then
  begin
    ServerIni.WriteString(iChave,iTag,iDef);
    ServerIni.UpdateFile;
  end;

  Result := ServerIni.ReadString(iChave,iTag,iDef);
  FreeAndNil(ServerIni);
end;
*)
