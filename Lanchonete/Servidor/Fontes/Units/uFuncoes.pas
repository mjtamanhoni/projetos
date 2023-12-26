unit uFuncoes;

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
  System.Types,

  FMX.Controls,
  FMX.Graphics,
  FMX.Platform,
  FMX.VirtualKeyboard,
  FMX.ListView.Types,
  FMX.TextLayout,
  FMX.Objects,
  FMX.Edit,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Layouts,

  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,

  {$IFDEF ANDROID}
    Androidapi.Jni.PowerManager,
    NetworkState,
  {$ENDIF}

  Soap.EncdDecd;

const
  C_NUMEROS = '0123456789';
  C_LETRAS='ABCDEFGHIJKLMNOPQRSTUVWXYZ�';
  C_VIA_CEP='http://viacep.com.br/ws/';

  {$Region 'Push Notification'}
    C_URL_GOOGLE = 'https://fcm.googleapis.com/fcm/send';
    C_API_FIREBASE_COMANDA = 'AAAAJ7le7mI:APA91bHPKrVEwWTJflFxqBpw5HhSZ6SpjRPlSmQxU2yc-GRpiqtYT0zP8Pfpe_kn1biHQ8UDcHSNzsFf-SWYbm9ztUUq6HF1Bn6mz2LYkfXZvV9Q9yiyAAAnpEcuvtfFRzQ6G1qpeUBR';
  {$EndRegion 'Push Notification'}

type
  TTipoRetorno  = (trSim,trNao,trConfirmar,trCancelar);
  TTecladoVirtual = (tvMostrar,tvOcultar);

  TCep = Record
    Cep :String;
    Logradouro :String;
    Complemento :String;
    Bairro :String;
    Municipio :String;
    Uf :String;
    Ibge :String;
    Gia :String;
    Ddd :String;
    Siafi :String;
  end;

  TFuncoes = class(TObject)
  private
    class procedure ThreadEnd_Sel_Combo_Desktop(Sender :TOBject);

  public
    class function BitmapFromBase64(const base64: string): TBitmap;
    class function Base64FromBitmap(Bitmap: TBitmap): string;
    class function TestaConexao(out Conexao:String):Boolean;

    class function Converte_Data(const AData:String):TDate;
    class function Converte_Hora(const AHora:String):TTime;
    class function Converte_Data_Hora(const ADataHora:String):TDateTime;
    class function Retorna_Data_Json(const AData:String; out AErro:String):TDate;
    class function Retorna_Hora_Json(const AHora:String; out AErro:String):TTime;
    class function Pasta_Sistema:String;
    class function PreencheVariavel(sTexto,sPreencher,sPosicao:String;iQtd:Integer):String;

    class function GetTextHeight(
      const D:TListItemText;
      const Width:Single;
      const Text:String):Integer;

    class function FieldDB_To_TagJson(const AField:String):String;
    class function Possui_Letras(const ATexto:String):Boolean;
    class function RemoveAcento(const ATexto:String):String;

    class procedure Manter_Tela_Ligada(const AManter:Boolean);
    class procedure MostarOcultar_Teclado(AComponentControl: TControl; ATecladoVirtual:TTecladoVirtual);
    class procedure Salvar_Arquivo(
      const AEndArq:String;
      const ANomeArq:String;
      const AConteudo:String);

    class procedure Gravar_Hitorico(
      AQuery:TFDQuery;
      ADescricao:String);

    class procedure ExibeLabel(
      AEdit: TEdit;
      ALabel: TLabel;
      AAnimation: TFloatAnimation;
      AStartValue:Integer=10;
      AStopValue:Integer=-25);

    class procedure Seliciona_Combo_Desktop(
      Rectangle :TRectangle;
      Animation :TFloatAnimation;
      Image, ImageRetrair, ImageExpandir :TImage;
      Edit :TEdit;
      Layout :TLayout);

    class procedure PularCampo(AEdit_Destino: TObject);
    class function SomenteNumero(ATexto:String):String;
    class function Unidade_Federativa(const ASigla:String):String;

    class function BuscaCep(const ACep:String):TCep;



  end;


implementation

{ TFuncoes }

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

class function TFuncoes.BuscaCep(const ACep: String): TCep;
var
  lUrl :String;
begin
  try
    try
      Result.Cep := '';
      Result.Logradouro := '';
      Result.Complemento := '';
      Result.Bairro := '';
      Result.Municipio := '';
      Result.Uf := '';
      Result.Ibge := '';
      Result.Gia := '';
      Result.Ddd := '';
      Result.Siafi := '';

      lUrl := '';
      lUrl := C_VIA_CEP + ACep + '/json';

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
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

class procedure TFuncoes.ExibeLabel(
      AEdit: TEdit;
      ALabel: TLabel;
      AAnimation: TFloatAnimation;
      AStartValue:Integer=10;
      AStopValue:Integer=-25);
begin
  if (Trim(AEdit.Text) <> '') and (not ALabel.Visible) then
  begin
    ALabel.Visible := True;
    AAnimation.StartValue := AStartValue;
    AAnimation.StopValue := AStopValue;
    AAnimation.Start;
  end
  else if (Trim(AEdit.Text) = '') then
  begin
    AAnimation.StartValue := AStopValue;
    AAnimation.StopValue := AStartValue;
    AAnimation.Start;
    ALabel.Visible := False;
  end;
end;

class function TFuncoes.FieldDB_To_TagJson(const AField: String): String;
var
  I :Integer;
  lField :String;
  lTexto :String;
  lMaiusculo :Boolean;
begin
  Result := '';
  Result := LowerCase(AField);
  lField := '';
  lMaiusculo := False;

  for I := 1 to Length(AField) do
  begin
    if Copy(AField,I,1) = '_' then
    begin
      lMaiusculo := True;
      Continue
    end
    else
    begin
      if lMaiusculo then
      begin
        lField := lField + UpperCase(Copy(AField,I,1));
        lMaiusculo := False;
      end
      else
        lField := lField + LowerCase(Copy(AField,I,1));
    end;
  end;

  Result := '';
  Result := lField;

end;

class function TFuncoes.GetTextHeight(const D: TListItemText;
  const Width: Single; const Text: String): Integer;
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

class procedure TFuncoes.Gravar_Hitorico(AQuery: TFDQuery; ADescricao: String);
begin
  try
    AQuery.Active := False;
    AQuery.SQL.Clear;
    AQuery.SQL.Add('INSERT INTO HISTORICO( ');
    AQuery.SQL.Add('  DT_HISTORICO ');
    AQuery.SQL.Add('  ,HR_HISTORICO ');
    AQuery.SQL.Add('  ,DESCRICAO ');
    AQuery.SQL.Add(') VALUES( ');
    AQuery.SQL.Add('  :DT_HISTORICO ');
    AQuery.SQL.Add('  ,:HR_HISTORICO ');
    AQuery.SQL.Add('  ,:DESCRICAO ');
    AQuery.SQL.Add('); ');
    AQuery.ParamByName('DT_HISTORICO').AsDate := Date;
    AQuery.ParamByName('HR_HISTORICO').AsTime := Time;
    AQuery.ParamByName('DESCRICAO').AsString := ADescricao;
    AQuery.ExecSQL;
  except on E: Exception do
    //
  end;
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

class procedure TFuncoes.MostarOcultar_Teclado(AComponentControl: TControl;
  ATecladoVirtual: TTecladoVirtual);
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

class function TFuncoes.Pasta_Sistema: String;
begin
  Result  := '';
  {$IFDEF MSWINDOWS}
    Result := System.SysUtils.GetCurrentDir;
  {$ELSE}
    Result := TPath.GetDocumentsPath;
  {$ENDIF}
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

class function TFuncoes.PreencheVariavel(sTexto, sPreencher, sPosicao: String;  iQtd: Integer): String;
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

class procedure TFuncoes.PularCampo(AEdit_Destino: TObject);
begin
  if AEdit_Destino is TEdit then
  begin
    if TEdit(AEdit_Destino).CanFocus then
      TEdit(AEdit_Destino).SetFocus;
  end;
end;

class function TFuncoes.RemoveAcento(const ATexto: String): String;
begin
  Result := ATexto;
  Result := StringReplace(Result,'�','a',[rfReplaceAll]);
  Result := StringReplace(Result,'�','e',[rfReplaceAll]);
  Result := StringReplace(Result,'�','i',[rfReplaceAll]);
  Result := StringReplace(Result,'�','o',[rfReplaceAll]);
  Result := StringReplace(Result,'�','u',[rfReplaceAll]);
  Result := StringReplace(Result,'�','A',[rfReplaceAll]);
  Result := StringReplace(Result,'�','E',[rfReplaceAll]);
  Result := StringReplace(Result,'�','I',[rfReplaceAll]);
  Result := StringReplace(Result,'�','O',[rfReplaceAll]);
  Result := StringReplace(Result,'�','U',[rfReplaceAll]);

  Result := StringReplace(Result,'�','a',[rfReplaceAll]);
  Result := StringReplace(Result,'�','o',[rfReplaceAll]);
  Result := StringReplace(Result,'�','A',[rfReplaceAll]);
  Result := StringReplace(Result,'�','O',[rfReplaceAll]);

  Result := StringReplace(Result,'�','a',[rfReplaceAll]);
  Result := StringReplace(Result,'�','e',[rfReplaceAll]);
  Result := StringReplace(Result,'�','i',[rfReplaceAll]);
  Result := StringReplace(Result,'�','o',[rfReplaceAll]);
  Result := StringReplace(Result,'�','u',[rfReplaceAll]);
  Result := StringReplace(Result,'�','A',[rfReplaceAll]);
  Result := StringReplace(Result,'�','E',[rfReplaceAll]);
  Result := StringReplace(Result,'�','I',[rfReplaceAll]);
  Result := StringReplace(Result,'�','O',[rfReplaceAll]);
  Result := StringReplace(Result,'�','U',[rfReplaceAll]);

  Result := StringReplace(Result,'�','a',[rfReplaceAll]);
  Result := StringReplace(Result,'�','e',[rfReplaceAll]);
  Result := StringReplace(Result,'�','i',[rfReplaceAll]);
  Result := StringReplace(Result,'�','o',[rfReplaceAll]);
  Result := StringReplace(Result,'�','u',[rfReplaceAll]);
  Result := StringReplace(Result,'�','A',[rfReplaceAll]);
  Result := StringReplace(Result,'�','E',[rfReplaceAll]);
  Result := StringReplace(Result,'�','I',[rfReplaceAll]);
  Result := StringReplace(Result,'�','O',[rfReplaceAll]);
  Result := StringReplace(Result,'�','U',[rfReplaceAll]);

  Result := StringReplace(Result,'�','c',[rfReplaceAll]);
  Result := StringReplace(Result,'�','C',[rfReplaceAll]);
end;

class function TFuncoes.Retorna_Data_Json(const AData: String;  out AErro: String): TDate;
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

class function TFuncoes.Retorna_Hora_Json(const AHora: String;
  out AErro: String): TTime;
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

class procedure TFuncoes.Salvar_Arquivo(
      const AEndArq:String;
      const ANomeArq:String;
      const AConteudo:String);
var
  lTexto :TStringList;
  lArq :String;
begin
  try
    try
      lTexto := TStringList.Create;

      if Trim(AEndArq) = '' then
        raise Exception.Create('Endere�o do arquivo n�o informado');
      if Trim(ANomeArq) = '' then
        raise Exception.Create('Nome do arquivo n�o informado');
      if Trim(AConteudo) = '' then
        raise Exception.Create('Conte�do do arquivo n�o informado');

      lArq := '';
      {$IFDEF MSWINDOWS}
        lArq := AEndArq + '/' + ANomeArq;
      {$ELSE}
        lArq := TPath.Combine(AEndArq,ANomeArq);
      {$ENDIF}

      if FileExists(lArq) then
        lTexto.LoadFromFile(lArq);

      //lTexto.Add(AConteudo);
      lTexto.Insert(0,AConteudo);

      lTexto.SaveToFile(lArq);

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lTexto);
    {$ELSE}
      lTexto.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TFuncoes.Seliciona_Combo_Desktop(
      Rectangle :TRectangle;
      Animation :TFloatAnimation;
      Image, ImageRetrair, ImageExpandir :TImage;
      Edit :TEdit;
      Layout :TLayout);
var
  t :TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    Rectangle.Position.X := Edit.Position.X;
    Rectangle.Position.Y := (Layout.Position.Y + Layout.Height);
    Rectangle.Width := Edit.Width;
    if not Rectangle.Visible then
    begin
      Animation.StartValue := 0;
      Animation.StopValue := Rectangle.Height;
      Image.Bitmap := ImageRetrair.Bitmap;
    end
    else
    begin
      Animation.StartValue := Rectangle.Height;
      Animation.StopValue := 0;
      Image.Bitmap := ImageExpandir.Bitmap;
    end;
    TThread.Synchronize(nil, procedure
    begin
      if not Rectangle.Visible then
      begin
        Rectangle.Visible := (not Rectangle.Visible);
        Animation.Start;
      end
      else
      begin
        Animation.Start;
        Rectangle.Visible := (not Rectangle.Visible);
      end;
    end);
  end);

  t.OnTerminate := ThreadEnd_Sel_Combo_Desktop;
  t.Start;
end;

class procedure TFuncoes.ThreadEnd_Sel_Combo_Desktop(Sender: TOBject);
begin
  if Assigned(TThread(Sender).FatalException) then
    raise Exception.Create(Exception(TThread(Sender).FatalException).Message);
end;

class function TFuncoes.SomenteNumero(ATexto: String): String;
var
    x : integer;
begin
    Result := '';
    for x := 0 to Length(ATexto) - 1 do
        if (ATexto.Chars[x] In ['0'..'9']) then
            Result := Result + ATexto.Chars[x];
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

class function TFuncoes.Unidade_Federativa(const ASigla: String): String;
begin
  try
    Result := '';
    if ASigla = 'AC' then
      Result := 'ACRE'
    else if ASigla = 'AL' then
      Result := 'ALAGOAS'
    else if ASigla = 'AP' then
      Result := 'AMAP�'
    else if ASigla = 'AM' then
      Result := 'AMAZONAS'
    else if ASigla = 'BA' then
      Result := 'BAHIA'
    else if ASigla = 'CE' then
      Result := 'CEAR�'
    else if ASigla = 'DF' then
      Result := 'DISTRITO FEDERAL'
    else if ASigla = 'ES' then
      Result := 'ESP�RITO SANTO'
    else if ASigla = 'GO' then
      Result := 'GOI�S'
    else if ASigla = 'MA' then
      Result := 'MARANH�O'
    else if ASigla = 'MT' then
      Result := 'MATO GROSSO'
    else if ASigla = 'MS' then
      Result := 'MATO GROSSO DO SUL'
    else if ASigla = 'MG' then
      Result := 'MINAS GERAIS'
    else if ASigla = 'PA' then
      Result := 'PAR�'
    else if ASigla = 'PB' then
      Result := 'PARA�BA'
    else if ASigla = 'PR' then
      Result := 'PARAN�'
    else if ASigla = 'PE' then
      Result := 'PERNAMBUCO'
    else if ASigla = 'PI' then
      Result := 'PIAU�'
    else if ASigla = 'RJ' then
      Result := 'RIO DE JANEIRO'
    else if ASigla = 'RN' then
      Result := 'RIO GRANDE DO NORTE'
    else if ASigla = 'RS' then
      Result := 'RIO GRANDE DO SUL'
    else if ASigla = 'RO' then
      Result := 'ROND�NIA'
    else if ASigla = 'RR' then
      Result := 'RORAIMA'
    else if ASigla = 'SC' then
      Result := 'SANTA CATARINA'
    else if ASigla = 'SP' then
      Result := 'S�O PAULO'
    else if ASigla = 'SE' then
      Result := 'SERGIPE'
    else if ASigla = 'TO' then
      Result := 'TOCANTINS';
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

end.
