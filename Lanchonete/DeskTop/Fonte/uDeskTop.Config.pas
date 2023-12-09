unit uDeskTop.Config;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uFancyDialog,
  {$EndRegion}

  IniFiles,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  uDeskTop.Principal, FMX.Layouts, FMX.Ani, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TfrmConfig = class(TForm)
    lytPrincipal: TLayout;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    lytMenu: TLayout;
    rctMenu_Principal: TRectangle;
    imgMenu: TImage;
    lytFechar: TLayout;
    rctFechar: TRectangle;
    imgFechar: TImage;
    lytFooter: TLayout;
    rctFooter: TRectangle;
    lytDetail: TLayout;
    lytDetail_Espacos: TLayout;
    edHost: TEdit;
    lbHost: TLabel;
    FloatAnimation_Host: TFloatAnimation;
    rctConfirmar: TRectangle;
    rctCancelar: TRectangle;
    imgConfirmar: TImage;
    imgCancelar: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctFecharClick(Sender: TObject);
    procedure edHostTyping(Sender: TObject);
    procedure rctConfirmarClick(Sender: TObject);
    procedure rctCancelarClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    lEnder_Ini :String;
    FFechar_Sistema :Boolean;

    procedure Abortar_Fechamento(Sender: TOBject);
    procedure Confirmar_Fechamento(Sender :TObject);
    procedure ExibeLabel(
      AEdit: TEdit;
      ALabel: TLabel;
      AAnimation: TFloatAnimation;
      AStartValue:Integer=10;
      AStopValue:Integer=-25);
    procedure Confirmar(Sender: TOBject);
    procedure Cancelar(Sender: TOBject);
    procedure LerConfig;
    procedure GravarConfig;

  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.fmx}

procedure TfrmConfig.Abortar_Fechamento(Sender: TOBject);
begin
  Abort;
end;

procedure TfrmConfig.Confirmar_Fechamento(Sender: TObject);
begin
  FFechar_Sistema := True;
  Close;
end;

procedure TfrmConfig.edHostTyping(Sender: TObject);
begin
  ExibeLabel(edHost,lbHost,FloatAnimation_Host);
end;

procedure TfrmConfig.ExibeLabel(
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

procedure TfrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FFechar_Sistema then
    Abortar_Fechamento(Sender);

  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FIniFile);
  {$ELSE}
    FMensagem.DisposeOf;
    FIniFile.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmConfig := Nil;
end;

procedure TfrmConfig.FormCreate(Sender: TObject);
begin

  FFechar_Sistema := False;
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_DESKTOP.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_DESKTOP.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);

  LerConfig;

  FMensagem := TFancyDialog.Create(frmConfig);
end;

procedure TfrmConfig.LerConfig;
begin
  edHost.Text := FIniFile.ReadString('SERVER','HOST','');
end;

procedure TfrmConfig.rctCancelarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Cancela as alterações realizadas?','SIM',Cancelar,'NÃO');
end;

procedure TfrmConfig.Cancelar(Sender :TOBject);
begin
  LerConfig;
end;

procedure TfrmConfig.rctConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Confirma as alterações realizadas?','SIM',Confirmar,'NÃO');
end;

procedure TfrmConfig.Confirmar(Sender: TOBject);
begin
  GravarConfig;
end;

procedure TfrmConfig.GravarConfig;
begin
  FIniFile.WriteString('SERVER','HOST',edHost.Text);
end;

procedure TfrmConfig.rctFecharClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja fechar as Configurações?','SIM',Confirmar_Fechamento,'NÃO',Abortar_Fechamento);
end;

end.
