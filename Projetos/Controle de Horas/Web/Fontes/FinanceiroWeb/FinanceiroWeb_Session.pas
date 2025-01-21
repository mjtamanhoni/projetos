unit FinanceiroWeb_Session;

interface

uses
  System.SysUtils, System.Classes,
  Prism.SessionBase;

type
  TFinanceiroWebSession = class(TPrismSessionBase)
  private
    FUsuario_Nome: String;
    FUsuario_ID: Integer;
    FUsuario_Tipo: Integer;
    FUsuario_Token: String;
    FUsuario_ClienteID: Integer;
    FUsuario_Cliente: String;
    FUsuario_Form: String;

  public
   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession

   property Usuario_ID :Integer read FUsuario_ID write FUsuario_ID;
   property Usuario_Nome :String read FUsuario_Nome write FUsuario_Nome;
   property Usuario_Tipo :Integer read FUsuario_Tipo write FUsuario_Tipo;
   property Usuario_Token :String read FUsuario_Token write FUsuario_Token;
   property Usuario_Form :String read FUsuario_Form write FUsuario_Form;
   property Usuario_ClienteID :Integer read FUsuario_ClienteID write FUsuario_ClienteID;
   property Usuario_Cliente :String read FUsuario_Cliente write FUsuario_Cliente;

  end;


implementation

Uses
  D2Bridge.Instance,
  FinanceiroWebWebApp;

{$R *.dfm}

constructor TFinanceiroWebSession.Create(APrismSession: TPrismSession); //OnNewSession
begin
 inherited;

 //Your code

end;

destructor TFinanceiroWebSession.Destroy; //OnCloseSession
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

 inherited;
end;

end.

