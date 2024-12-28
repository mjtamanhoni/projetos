unit uFuncoes;

interface

uses
  System.SysUtils, System.DateUtils;

type
  TDatas = record
    Dia :Integer;
    Mes :Integer;
    Ano :Integer;
    UltimoDia :TDate;
    PrimeiroDia :TDate;
    Data_Add_Dia :TDate;
    Data_Add_Mes :TDate;
    Data_Add_Ano :TDate;
    Diferenca :Integer;
  end;

type
  TFuncoes = class(TObject)
  private

  public
    class function Datas(AData_1:TDate; AData_2:TDate=0; ADias:Integer=0; AMes:Integer=0; AAno:Integer=0): TDatas;
    class function ApenasNumeros(const Texto: string): string;
    class function PreencheVariavel(sTexto,sPreencher,sPosicao:String;iQtd:Integer):String;
    class function RetornaValor_TextMoney(ATexto: String; ADecimal:Integer=2): Double;
  end;

implementation

{ TFuncoes }

class function TFuncoes.ApenasNumeros(const Texto: string): string;
var
  i: Integer;
  Resultado: string;
begin
  try
    try
      Resultado := '';
      for i := 1 to Length(Texto) do
      begin
        if Texto[i] in ['0'..'9'] then
          Resultado := Resultado + Texto[i];
      end;
      Result := Resultado;
    except on E: Exception do
      raise Exception.Create('Erro ao retornar apenas números');
    end;
  finally
  end;
end;

class function TFuncoes.Datas(AData_1:TDate; AData_2:TDate=0; ADias:Integer=0; AMes:Integer=0; AAno:Integer=0): TDatas;
var
  FDia, FMes, FAno :Word;
begin
  try
    try
      Result.Dia := 0;
      Result.Mes := 0;
      Result.Ano := 0;
      Result.UltimoDia := Date;
      Result.PrimeiroDia := Date;
      Result.Data_Add_Dia := Date;
      Result.Data_Add_Mes := Date;
      Result.Data_Add_Ano := Date;
      Result.Diferenca := 0;

      DecodeDate(AData_1,FAno,FMes,FDia);

      Result.Dia := FDia;
      Result.Mes := FMes;
      Result.Ano := FAno;
      Result.UltimoDia := EndOfTheMonth(AData_1);
      Result.PrimeiroDia := StartOfTheMonth(AData_1);

      if AData_2 > 0 then
        Result.Diferenca := DaysBetween(AData_1, AData_2);

      if ADias > 0 then
        Result.Data_Add_Dia := IncDay(AData_1, ADias);

      if AMes > 0 then
        Result.Data_Add_Dia := IncMonth(AData_1, AMes);

      if AAno > 0 then
        Result.Data_Add_Dia := IncYear(AData_1, AAno);

    except on E: Exception do
      raise Exception.Create('Retorno Datas: ' + E.Message);
    end;
  finally

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

class function TFuncoes.RetornaValor_TextMoney(ATexto: String; ADecimal:Integer=2): Double;
var
  FValorT :String;
  FValorD :Double;
begin
  try
    if Trim(ATexto) = '' then
      raise Exception.Create('Não foi informado o valor para conversão entre Texto para Moeda');

    FValorT := '';
    FValorD := 0;

    FValorT := StringReplace(StringReplace(StringReplace(StringReplace(ATexto,'R','',[rfReplaceAll]),'.','',[rfReplaceAll]),',','',[rfReplaceAll]),'$','',[rfReplaceAll]);
    FValorD := StrToFloat(FValorT);

    case ADecimal of
      1 :Result := (FValorD /10);
      2 :Result := (FValorD /100);
      3 :Result := (FValorD /1000);
      4 :Result := (FValorD /10000);
    end;

  except on E: Exception do
    raise Exception.Create(E.Message);
  end;



end;

end.
