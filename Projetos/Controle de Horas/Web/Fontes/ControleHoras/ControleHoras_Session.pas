unit ControleHoras_Session;

interface

uses
  System.SysUtils, System.Classes,
  Prism.SessionBase;

type
  TControleHorasSession = class(TPrismSessionBase)
  private
    FUsuario_Nome: String;
    FUsuario_ID: Integer;
    FUsuario_Token: String;

  public
   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession

   property Usuario_ID :Integer read FUsuario_ID write FUsuario_ID;
   property Usuario_Nome :String read FUsuario_Nome write FUsuario_Nome;
   property Usuario_Token :String read FUsuario_Token write FUsuario_Token;
  end;


implementation

Uses
  D2Bridge.Instance,
  ControleHorasWebApp;

{$R *.dfm}

constructor TControleHorasSession.Create(APrismSession: TPrismSession); //OnNewSession
begin
 inherited;

 //Your code

end;

destructor TControleHorasSession.Destroy; //OnCloseSession
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

 inherited;
end;

end.

