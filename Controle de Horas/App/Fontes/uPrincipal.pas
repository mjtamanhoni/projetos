unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uFuncoes,

  {$Region '99 Coders'}
    //uFancyDialog,
    //uLoading,
  {$EndRegion '99 Coders'}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani, FMX.Edit, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Effects, FMX.Objects, FMX.TabControl, FMX.Layouts;

type
  TfrmPrincipal = class(TForm)
    StyleBook_Principal: TStyleBook;
    imgNVer: TImage;
    imgVer: TImage;
    lytPrincipal: TLayout;
    tcLogin: TTabControl;
    tiUserSenha: TTabItem;
    lytLog: TLayout;
    rctLog: TRectangle;
    ShadowEffect1: TShadowEffect;
    imgLog: TImage;
    lytFooter: TLayout;
    lbCadastrar: TLabel;
    lytLogin: TLayout;
    lytUser: TLayout;
    edEmail_User: TEdit;
    lbEmail_User: TLabel;
    faEmail: TFloatAnimation;
    lytSenha: TLayout;
    edSenha: TEdit;
    lbSenha: TLabel;
    faSenha: TFloatAnimation;
    imgVerSenha: TImage;
    lytUserSenha_Confir: TLayout;
    rctConfirmar: TRectangle;
    lbConfirmar: TLabel;
    rctCancelar: TRectangle;
    lbCancelar: TLabel;
    tiPIN: TTabItem;
    tiBio: TTabItem;
    procedure edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edEmail_UserTyping(Sender: TObject);
    procedure edSenhaTyping(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.edEmail_UserKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edSenha);
end;

procedure TfrmPrincipal.edEmail_UserTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edEmail_User,lbEmail_User,faEmail,10,-20);
end;

procedure TfrmPrincipal.edSenhaTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edSenha,lbSenha,faSenha,10,-20);
end;

end.
