unit uStart.Stop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  MidasLib,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Data.DB, Vcl.Grids, Vcl.DBGrids,
  ServerController, Vcl.Menus;

type
  TfrmStart_Stop = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label_Version: TLabel;
    Label4: TLabel;
    Label_Sessions: TLabel;
    Label5: TLabel;
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
    procedure Button_OptionsClick(Sender: TObject);
    procedure Button_StartClick(Sender: TObject);
    procedure Button_StopClick(Sender: TObject);
    procedure CloseAllSessions1Click(Sender: TObject);
    procedure CloseSession1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SendPushMessage1Click(Sender: TObject);
    procedure SendPushMessageAllSessions1Click(Sender: TObject);
    procedure Status_Buttons;
  private
    FUsuario_Token: String;
    FCond_Pagto_ID: Integer;
    FEmpresa_Nome: String;
    FFornecedor_Nome: String;
    FForma_Pagto_Nome: String;
    FUsuario_ClienteID: Integer;
    FUsuario_Nome: String;
    FUsuario_Tipo: Integer;
    FCliente_ID: Integer;
    FCond_Pagto_Nome: String;
    FTab_Preco_ID: Integer;
    FPrest_Servico_ID: Integer;
    FEmpresa_ID: Integer;
    FFornecedor_ID: Integer;
    FCliente_Nome: String;
    FUsuario_Cliente: String;
    FTab_Preco_Nome: String;
    FUsuario_Form: String;
    FPrest_Servico_Nome: String;
    FForma_Pagto_ID: Integer;
    FUsuario_ID: Integer;

    procedure SessionChange(AChangeType: TSessionChangeType; APrismSession: IPrismSession);
  public

   {$Region 'Uusários'}
      property Usuario_ID :Integer read FUsuario_ID write FUsuario_ID;
      property Usuario_Nome :String read FUsuario_Nome write FUsuario_Nome;
      property Usuario_Token :String read FUsuario_Token write FUsuario_Token;
      property Usuario_Tipo :Integer read FUsuario_Tipo write FUsuario_Tipo;
      property Usuario_Form :String read FUsuario_Form write FUsuario_Form;
      property Usuario_ClienteID :Integer read FUsuario_ClienteID write FUsuario_ClienteID;
      property Usuario_Cliente :String read FUsuario_Cliente write FUsuario_Cliente;
   {$EndRegion}

   {$Region 'Empresa'}
      property Empresa_ID :Integer read FEmpresa_ID write FEmpresa_ID;
      property Empresa_Nome :String read FEmpresa_Nome write FEmpresa_Nome;
   {$EndRegion 'Cliente'}

   {$Region 'Cliente'}
      property Cliente_ID :Integer read FCliente_ID write FCliente_ID;
      property Cliente_Nome :String read FCliente_Nome write FCliente_Nome;
   {$EndRegion 'Cliente'}

   {$Region 'Fornecedor'}
      property Fornecedor_ID :Integer read FFornecedor_ID write FFornecedor_ID;
      property Fornecedor_Nome :String read FFornecedor_Nome write FFornecedor_Nome;
   {$EndRegion 'Cliente'}

   {$Region 'Prestador de Serviço'}
      property Prest_Servico_ID :Integer read FPrest_Servico_ID write FPrest_Servico_ID;
      property Prest_Servico_Nome :String read FPrest_Servico_Nome write FPrest_Servico_Nome;
   {$EndRegion 'Cliente'}

   {$Region 'Tabela de Preços'}
      property Tab_Preco_ID :Integer read FTab_Preco_ID write FTab_Preco_ID;
      property Tab_Preco_Nome :String read FTab_Preco_Nome write FTab_Preco_Nome;
   {$EndRegion 'Tabela de Preços'}

   {$Region 'Condições de Pagamento'}
      property Cond_Pagto_ID :Integer read FCond_Pagto_ID write FCond_Pagto_ID;
      property Cond_Pagto_Nome :String read FCond_Pagto_Nome write FCond_Pagto_Nome;
   {$EndRegion 'Condições de Pagamento'}

   {$Region 'Formas de Pagamento'}
      property Forma_Pagto_ID :Integer read FForma_Pagto_ID write FForma_Pagto_ID;
      property Forma_Pagto_Nome :String read FForma_Pagto_Nome write FForma_Pagto_Nome;
   {$EndRegion 'Formas de Pagamento'}
  end;

var
  frmStart_Stop: TfrmStart_Stop;

implementation

{$R *.dfm}

uses
  Unit_Login
  ,D2Bridge.BaseClass;

procedure TfrmStart_Stop.Button_OptionsClick(Sender: TObject);
begin
 with Button_Options.ClientToScreen(point(0, 1 + Button_Options.Height)) do
  PopupMenu_Options.Popup(x, Y)

end;

procedure TfrmStart_Stop.Button_StartClick(Sender: TObject);
begin
 D2BridgeServerController.PrimaryFormClass:= TForm_Login;

 D2BridgeServerController.Prism.Options.IncludeJQuery:= true;

 D2BridgeServerController.Prism.Options.DataSetLog:= true;

 //Uncomment to Dual Mode force http just in Debug Mode
 //if IsDebuggerPresent then
 // D2BridgeServerController.Prism.Options.SSL:= false
 //else
 //D2BridgeServerController.Prism.Options.SSL:= true;

 D2BridgeServerController.Languages:= [TD2BridgeLang.Portuguese];

 if D2BridgeServerController.Prism.Options.SSL then
 begin
  //Cert File
  D2BridgeServerController.Prism.SSLOptions.CertFile:= '';
  //Cert Key Domain File
  D2BridgeServerController.Prism.SSLOptions.KeyFile:= '';
  //Cert Intermediate (case Let�s Encrypt)
  D2BridgeServerController.Prism.SSLOptions.RootCertFile:= '';
 end;

 D2BridgeServerController.Prism.Options.PathJS:= 'js';
 D2BridgeServerController.Prism.Options.PathCSS:= 'css';

 D2BridgeServerController.Port:= StrToInt(Edit_Port.Text);
 D2BridgeServerController.ServerName:= Edit_ServerName.Text;
 D2BridgeServerController.ServerDescription:= 'Complete D2Bridge Server';
 D2BridgeServerController.StartServer;

 Status_Buttons;
end;

procedure TfrmStart_Stop.Button_StopClick(Sender: TObject);
begin
 D2BridgeServerController.StopServer;

 Status_Buttons;

end;

procedure TfrmStart_Stop.CloseAllSessions1Click(Sender: TObject);
begin
  D2BridgeServerController.CloseAllSessions;
end;

procedure TfrmStart_Stop.CloseSession1Click(Sender: TObject);
begin
  D2BridgeServerController.CloseSession(DBGrid_Log.DataSource.DataSet.FieldByName('UUID').AsString);
end;

procedure TfrmStart_Stop.FormCreate(Sender: TObject);
begin
 D2BridgeServerController:= TD2BridgeServerController.Create(Application);
 D2BridgeServerController.OnSessionChange:= SessionChange;
 DBGrid_Log.DataSource:= D2BridgeServerController.DataSourceLog;

 Edit_Port.Text:= IntToStr(D2BridgeServerController.Prism.INIConfig.ServerPort(StrToInt(Edit_Port.Text)));
 Edit_ServerName.Text:= D2BridgeServerController.Prism.INIConfig.ServerName(Edit_ServerName.Text);

 Label_Version.Caption:= 'D2Bridge Version: '+D2BridgeServerController.D2BridgeManager.Version;

end;

procedure TfrmStart_Stop.FormShow(Sender: TObject);
begin
 Button_Start.Click;
 Status_Buttons;

end;

procedure TfrmStart_Stop.SendPushMessage1Click(Sender: TObject);
var
 vResp: String;
begin
 vResp:= InputBox('PUSH', 'Message', '');

 D2BridgeServerController.SendMessageToSession(DBGrid_Log.DataSource.DataSet.FieldByName('UUID').AsString,vResp);
end;

procedure TfrmStart_Stop.SendPushMessageAllSessions1Click(Sender: TObject);
var
 vResp: String;
begin
 vResp:= InputBox('PUSH', 'Message', '');

 D2BridgeServerController.SendMessageToAllSession(vResp);
end;

procedure TfrmStart_Stop.SessionChange(AChangeType: TSessionChangeType; APrismSession: IPrismSession);
begin
  Label_Sessions.Caption:= IntToStr(D2BridgeServerController.Prism.Sessions.Count);
end;

procedure TfrmStart_Stop.Status_Buttons;
begin
  Button_Start.Enabled:= not D2BridgeServerController.Started;
  Button_Stop.Enabled:= D2BridgeServerController.Started;
  Edit_Port.Enabled:= not D2BridgeServerController.Started;
  Edit_ServerName.Enabled:= not D2BridgeServerController.Started;
end;

end.
