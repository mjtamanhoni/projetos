unit uWaitDialog;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ComCtrls, ExtCtrls, Graphics;

procedure WaitBegin(const Titulo: string = 'Processando...'; const Total: Integer = 0; const AllowCancel: Boolean = True);
procedure WaitUpdateStatus(const Msg: string);
procedure WaitUpdateProgress(const Posicao: Integer);
procedure WaitUpdateCount(const Atual, Total: Integer);
function WaitCancelled: Boolean;
procedure WaitEnd;

implementation

var
  GForm: TForm;
  GLblTitulo: TLabel;
  GLblStatus: TLabel;
  GLblCount: TLabel;
  GLblCancelHint: TLabel;
  GLblTime: TLabel;
  GProgress: TProgressBar;
  GMainEnabledTarget: HWND;
  GTotal: Integer;
  GCancelled: Boolean;
  GAllowCancel: Boolean;
  GStartTick: DWORD;
  GCurrent: Integer;
  GTimer: TTimer;
  GLastItemTick: DWORD;
  GDur1: DWORD;
  GDur2: DWORD;

type
  TWaitHandler = class(TComponent)
  public
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerTick(Sender: TObject);
  end;

var
  GHandler: TWaitHandler;

procedure CreateWaitForm(const Titulo: string; Total: Integer; AllowCancel: Boolean);
begin
  GForm := TForm.Create(nil);
  GForm.BorderStyle := bsDialog;
  GForm.BorderIcons := [];
  GForm.Position := poScreenCenter;
  GForm.FormStyle := fsStayOnTop;
  GForm.Caption := Titulo;
  GForm.ClientWidth := 420;
  GForm.ClientHeight := 140;

  GLblTitulo := TLabel.Create(GForm);
  GLblTitulo.Parent := GForm;
  GLblTitulo.Left := 16;
  GLblTitulo.Top := 16;
  GLblTitulo.Caption := Titulo;
  GLblTitulo.ParentFont := False;
  GLblTitulo.Font.Size := GLblTitulo.Font.Size + 2;
  GLblTitulo.Font.Style := GLblTitulo.Font.Style + [fsBold];

  GLblStatus := TLabel.Create(GForm);
  GLblStatus.Parent := GForm;
  GLblStatus.Left := 16;
  GLblStatus.Top := 48;
  GLblStatus.Caption := '';

  GProgress := TProgressBar.Create(GForm);
  GProgress.Parent := GForm;
  GProgress.Left := 16;
  GProgress.Top := 76;
  GProgress.Width := GForm.ClientWidth - 32;
  GProgress.Min := 0;
  GProgress.Max := Total;
  GProgress.Position := 0;

  GLblCount := TLabel.Create(GForm);
  GLblCount.Parent := GForm;
  GLblCount.Left := 16;
  GLblCount.Top := 108;
  GLblCount.Caption := '';

  GLblTime := TLabel.Create(GForm);
  GLblTime.Parent := GForm;
  GLblTime.Width := 200;
  GLblTime.Left := GForm.ClientWidth - 16 - GLblTime.Width;
  GLblTime.Top := GLblCount.Top;
  GLblTime.Alignment := taRightJustify;
  GLblTime.Caption := 'Decorrido: 00:00:00 - Restante: 00:00:00';

  GAllowCancel := AllowCancel;
  if GAllowCancel then
  begin
    GLblCancelHint := TLabel.Create(GForm);
    GLblCancelHint.Parent := GForm;
    GLblCancelHint.Left := 16;
    GLblCancelHint.Top := 124;
    GLblCancelHint.Caption := 'Pressione CTRL+C para cancelar';
  end;

  GTotal := Total;
  if Assigned(Application.MainForm) then
    GMainEnabledTarget := Application.MainForm.Handle
  else
    GMainEnabledTarget := Application.Handle;
  EnableWindow(GMainEnabledTarget, False);
  if not Assigned(GHandler) then
    GHandler := TWaitHandler.Create(nil);
  if GAllowCancel then
  begin
    GForm.KeyPreview := True;
    GForm.OnKeyDown := GHandler.FormKeyDown;
  end;
  GCancelled := False;
  GStartTick := GetTickCount;
  GCurrent := 0;
  GLastItemTick := GStartTick;
  GDur1 := 0;
  GDur2 := 0;
  GTimer := TTimer.Create(nil);
  GTimer.Interval := 1000;
  GTimer.OnTimer := GHandler.TimerTick;
  GTimer.Enabled := True;
  GForm.Show;
  GForm.Update;
  GForm.SetFocus;
end;

procedure WaitBegin(const Titulo: string; const Total: Integer; const AllowCancel: Boolean);
begin
  if Assigned(GForm) then
    WaitEnd;
  CreateWaitForm(Titulo, Total, AllowCancel);
end;

procedure WaitUpdateStatus(const Msg: string);
begin
  if Assigned(GLblStatus) then
  begin
    GLblStatus.Caption := Msg;
    GForm.Update;
    Application.ProcessMessages;
  end;
end;

function WaitCancelled: Boolean;
begin
  Result := GAllowCancel and GCancelled;
end;

procedure TWaitHandler.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = Ord('C')) then
    GCancelled := True;
end;

procedure WaitUpdateProgress(const Posicao: Integer);
begin
  if Assigned(GProgress) then
  begin
    if GProgress.Max = 0 then
      GProgress.Max := Posicao;
    GProgress.Position := Posicao;
    GForm.Update;
    Application.ProcessMessages;
  end;
end;

procedure TWaitHandler.TimerTick(Sender: TObject);
begin
  WaitUpdateCount(GCurrent, GTotal);
end;

procedure WaitUpdateCount(const Atual, Total: Integer);
var
  ElapsedMs: DWORD;
  H, M, S: Integer;
  ElapsedStr: string;
  RemainingMs: Int64;
  RemainingStr: string;
  AvgMsPerItem: Double;
  NowTick: DWORD;
  CurrItemElapsed: DWORD;
begin
  if Assigned(GLblCount) then
  begin
    if Total > 0 then
    begin
      GTotal := Total;
      if Assigned(GProgress) then
        GProgress.Max := Total;
    end;
    NowTick := GetTickCount;
    if (Atual > 0) and (Atual > GCurrent) then
    begin
      if GCurrent > 0 then
      begin
        CurrItemElapsed := NowTick - GLastItemTick;
        GDur2 := GDur1;
        GDur1 := CurrItemElapsed;
      end;
      GCurrent := Atual;
      GLastItemTick := NowTick;
    end
    else if (Atual > 0) and (Atual <> GCurrent) then
      GCurrent := Atual;
    ElapsedMs := NowTick - GStartTick;
    S := ElapsedMs div 1000;
    H := S div 3600;
    S := S mod 3600;
    M := S div 60;
    S := S mod 60;
    ElapsedStr := Format('%d:%2.2d:%2.2d', [H, M, S]);
    RemainingStr := '00:00:00';
    if (GTotal > 0) and (GCurrent > 0) and (GCurrent <= GTotal) then
    begin
      if (GDur1 > 0) and (GDur2 > 0) then
        AvgMsPerItem := (GDur1 + GDur2) / 2.0
      else if (GDur1 > 0) then
        AvgMsPerItem := GDur1
      else
        AvgMsPerItem := ElapsedMs / GCurrent;
      CurrItemElapsed := NowTick - GLastItemTick;
      if CurrItemElapsed > AvgMsPerItem then
        AvgMsPerItem := CurrItemElapsed;
      RemainingMs := Round(AvgMsPerItem * (GTotal - GCurrent));
      S := RemainingMs div 1000;
      H := S div 3600;
      S := S mod 3600;
      M := S div 60;
      S := S mod 60;
      RemainingStr := Format('%d:%2.2d:%2.2d', [H, M, S]);
    end;
    GLblCount.Caption := IntToStr(GCurrent) + ' / ' + IntToStr(GTotal);
    if Assigned(GLblTime) then
      GLblTime.Caption := 'Decorrido: ' + ElapsedStr + ' - Restante: ' + RemainingStr;
    if Assigned(GProgress) then
      GProgress.Position := GCurrent;
    GForm.Update;
    Application.ProcessMessages;
  end;
end;

procedure WaitEnd;
begin
  if GMainEnabledTarget <> 0 then
    EnableWindow(GMainEnabledTarget, True);
  if Assigned(GTimer) then
  begin
    GTimer.Enabled := False;
    GTimer.OnTimer := nil;
    FreeAndNil(GTimer);
  end;
  FreeAndNil(GLblTitulo);
  FreeAndNil(GLblStatus);
  FreeAndNil(GLblCount);
  FreeAndNil(GLblTime);
  FreeAndNil(GLblCancelHint);
  FreeAndNil(GProgress);
  FreeAndNil(GForm);
  FreeAndNil(GHandler);
  GMainEnabledTarget := 0;
  GTotal := 0;
  GCancelled := False;
  GAllowCancel := False;
  GCurrent := 0;
  GDur1 := 0;
  GDur2 := 0;
end;

end.
