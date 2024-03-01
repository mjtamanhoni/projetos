unit uConfig;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.IOUtils,

  {$Region '99 Coders'}
    uLoading,
    uFancyDialog,
  {$EndRegion '99 Coders'}

  IniFiles,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, FMX.TabControl, FMX.Layouts, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TfrmConfig = class(TForm)
    StyleBook_Principal: TStyleBook;
    lytDetail: TLayout;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    lbTitulo: TLabel;
    imgConfirmar: TImage;
    imgCancelar: TImage;
    lytHost: TLayout;
    lbHost: TLabel;
    Memo_Host: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgCancelarClick(Sender: TObject);
    procedure imgConfirmarClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    FIniFile :TIniFile;
    FEnder :String;
    procedure Cancelar(Sender: TOBject);
    procedure Confirmar(Sender: TOBject);
    procedure Ler_Config;
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.fmx}

procedure TfrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(FIniFile);
  {$ELSE}
    FMensagem.DisposeOf;
    FIniFile.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.CaFree;
  frmConfig := Nil;

end;

procedure TfrmConfig.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir + '\FINANCEIRO.ini';
  {$ELSE}
    FEnder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'FINANCEIRO.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(FEnder);

  FMensagem := TFancyDialog.Create(frmConfig);
end;

procedure TfrmConfig.imgCancelarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja cancelar as alterações?','Sim',Cancelar,'Não');
end;

procedure TfrmConfig.Cancelar(Sender:TOBject);
begin
  Close;
end;

procedure TfrmConfig.imgConfirmarClick(Sender: TObject);
begin
  FMensagem.Show(TIconDialog.Question,'Atenção','Deseja confirmar as alterações?','Sim',Confirmar,'Não');
end;

procedure TfrmConfig.Ler_Config;
begin
  Memo_Host.Text := FIniFile.ReadString('SERVER','BASE_URL','');
end;

procedure TfrmConfig.Confirmar(Sender:TOBject);
begin
  FIniFile.WriteString('SERVER','BASE_URL',Trim(Memo_Host.Text));
  Close;
end;

end.
