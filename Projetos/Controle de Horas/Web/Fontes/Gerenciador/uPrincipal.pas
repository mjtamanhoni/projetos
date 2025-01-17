unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  MidasLib,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Data.DB, Vcl.Grids, Vcl.DBGrids,
  ServerController, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    lbPorta: TLabel;
    Label_Version: TLabel;
    lbSecaoAtiva: TLabel;
    Label_Sessions: TLabel;
    lbServerName: TLabel;
    Button_Start: TButton;
    Edit_Port: TEdit;
    Button_Stop: TButton;
    DBGrid_Log: TDBGrid;
    Button_Options: TButton;
    Panel_Logo_D2Bridge: TPanel;
    Image_Logo_D2Bridge: TImage;
    Edit_ServerName: TEdit;
    PopupMenu_Options: TPopupMenu;
    CloseSession1: TMenuItem;
    SendPushMessage1: TMenuItem;
    N1: TMenuItem;
    CloseAllSessions1: TMenuItem;
    SendPushMessageAllSessions1: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

Uses
 D2Bridge.BaseClass;

{$R *.dfm}

end.
