unit uFuncoes;

interface

uses
  System.SysUtils,

  FMX.Edit, FMX.StdCtrls,FMX.Ani;

type
  TFuncoes = class(TObject)
  private
  public
    class procedure PularCampo(AEdit_Destino: TObject);
    class procedure ExibeLabel(
      AEdit: TEdit;
      ALabel: TLabel;
      AAnimation: TFloatAnimation;
      AStartValue:Integer=10;
      AStopValue:Integer=-25);
  end;

implementation

{ TFuncoes }

class procedure TFuncoes.ExibeLabel(AEdit: TEdit; ALabel: TLabel; AAnimation: TFloatAnimation; AStartValue,
  AStopValue: Integer);
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

class procedure TFuncoes.PularCampo(AEdit_Destino: TObject);
begin
  if AEdit_Destino is TEdit then
  begin
    if TEdit(AEdit_Destino).CanFocus then
      TEdit(AEdit_Destino).SetFocus;
  end;
end;

end.
