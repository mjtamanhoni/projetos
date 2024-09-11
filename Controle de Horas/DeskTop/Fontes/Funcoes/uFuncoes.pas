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
  end;

implementation

{ TFuncoes }

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

end.
