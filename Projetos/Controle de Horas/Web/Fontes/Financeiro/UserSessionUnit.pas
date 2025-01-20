unit UserSessionUnit;

interface

uses
  System.SysUtils, System.Classes,
  Prism.SessionBase;

type
  TPrismUserSession = class(TPrismSessionBase)
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

  public
   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession


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


implementation

{$R *.dfm}


{ TPrismUserSession }

constructor TPrismUserSession.Create(APrismSession: TPrismSession);
begin
  inherited;

end;

destructor TPrismUserSession.Destroy;
begin

  inherited;
end;

end.

