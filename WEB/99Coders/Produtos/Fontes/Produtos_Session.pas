unit Produtos_Session;

interface

uses
  SysUtils, Classes,
  Prism.SessionBase;

type
  TProdutosSession = class(TPrismSessionBase)
  private

  public
   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession
  end;


implementation

Uses
  D2Bridge.Instance,
  ProdutosWebApp;

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF} 

constructor TProdutosSession.Create(APrismSession: TPrismSession); //OnNewSession
begin
 inherited;

 //Your code

end;

destructor TProdutosSession.Destroy; //OnCloseSession
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

 inherited;
end;

end.

