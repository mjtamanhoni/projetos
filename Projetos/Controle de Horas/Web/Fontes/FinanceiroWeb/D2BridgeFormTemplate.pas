unit D2BridgeFormTemplate;

interface

Uses
 System.Classes,
 System.SysUtils,
 D2Bridge.Prism.Form;


type
 TD2BridgeFormTemplate = class(TD2BridgePrismForm)
  private
   procedure ProcessHTML(Sender: TObject; var AHTMLText: string);
   procedure ProcessTagHTML(const TagString: string; var ReplaceTag: string);
   //function OpenMenuItem(EventParams: TStrings): String;

   procedure Callback(const CallBackName:String; EventParams:TStrings); override;

   //function AbrirMenuConfig(EventParams: TStrings): String;
   function AbrirMenuUsuario(EventParams: TStrings): String;
   function AbrirMenuEmpresa(EventParams: TStrings): String;
   function AbreMenuPrestServ(EventParams: TStrings): String;
   function AbreMenuCliente(EventParams: TStrings): String;
   function AbreMenuFornecedor(EventParams: TStrings): String;
   function AbreMenuTabPreco(EventParams: TStrings): String;
   function AbreMenuConta(EventParams: TStrings): String;
   function AbreMenuCondPagto(EventParams: TStrings): String;
   function AbreMenuFormaPagto(EventParams: TStrings): String;


  public
   constructor Create(AOwner: TComponent; D2BridgePrismFramework: TObject); override;

 end;


implementation

Uses
 FinanceiroWebWebApp, uConfiguracoes, uCad.Usuarios, uCad.Empresa, uCad.PrestServico, uCad.Cliente, uCad.Fornecedor,
  uCad.TabPreco, uCad.Conta, uCad.CondPagto, uCad.FormaPagto, uDemo.ServicosPrestados;


{ TD2BridgeFormTemplate }

function TD2BridgeFormTemplate.AbreMenuCliente(EventParams: TStrings): String;
begin
  if frmCad_Cliente = Nil then
    TfrmCad_Cliente.CreateInstance;
  frmCad_Cliente.ShowModal;
  //frmCad_Cliente.Free;
end;

function TD2BridgeFormTemplate.AbreMenuCondPagto(EventParams: TStrings): String;
begin
  if frmCad_CondPagto = Nil then
    TfrmCad_CondPagto.CreateInstance;
  frmCad_CondPagto.ShowModal;
  //frmCad_CondPagto.Free;
end;

function TD2BridgeFormTemplate.AbreMenuConta(EventParams: TStrings): String;
begin
  if frmCad_Conta = Nil then
    TfrmCad_Conta.CreateInstance;
  frmCad_Conta.ShowModal;
  //frmCad_Conta.Free;
end;

function TD2BridgeFormTemplate.AbreMenuFormaPagto(EventParams: TStrings): String;
begin
  if frmCad_FormaPagto = Nil then
    TfrmCad_FormaPagto.CreateInstance;
  frmCad_FormaPagto.ShowModal;
  //frmCad_FormaPagto.Free;
end;

function TD2BridgeFormTemplate.AbreMenuFornecedor(EventParams: TStrings): String;
begin
  if frmCad_Fornecedor = Nil then
    TfrmCad_Fornecedor.CreateInstance;
  frmCad_Fornecedor.ShowModal;
  //frmCad_Fornecedor.Free;
end;

function TD2BridgeFormTemplate.AbreMenuPrestServ(EventParams: TStrings): String;
begin
  if frmCad_PrestServico = Nil then
    TfrmCad_PrestServico.CreateInstance;
  frmCad_PrestServico.ShowModal;
  //frmCad_PrestServico.Free;
end;

function TD2BridgeFormTemplate.AbreMenuTabPreco(EventParams: TStrings): String;
begin
  if frmCad_TabPreco = Nil then
    TfrmCad_TabPreco.CreateInstance;
  frmCad_TabPreco.ShowModal;
  //frmCad_TabPreco.Free;
end;

{
function TD2BridgeFormTemplate.AbrirMenuConfig(EventParams: TStrings): String;
begin
  if frmConfiguracoes = Nil then
    TfrmConfiguracoes.CreateInstance;
  frmConfiguracoes.ShowModal;
  //frmConfiguracoes.Free;
end;
}

function TD2BridgeFormTemplate.AbrirMenuEmpresa(EventParams: TStrings): String;
begin
  if frmCad_Empresa = Nil then
    TfrmCad_Empresa.CreateInstance;
  frmCad_Empresa.ShowModal;
  //frmCad_Empresa.Free;
end;

function TD2BridgeFormTemplate.AbrirMenuUsuario(EventParams: TStrings): String;
begin
  if frmCad_Usuarios = Nil then
    TfrmCad_Usuarios.CreateInstance;
  frmCad_Usuarios.ShowModal;
  //frmCad_Usuarios.Free;
end;

procedure TD2BridgeFormTemplate.Callback(const CallBackName: String; EventParams: TStrings);
begin
  inherited;

  if SameText(CallBackName,'AbrirMenuConfig') then
  begin
    if frmConfiguracoes = Nil then
      TfrmConfiguracoes.CreateInstance;
    frmConfiguracoes.ShowModal;
  end;

  if SameText(CallBackName,'DemoServPrest') then
  begin
    if frmDemo_ServicosPrestados = Nil then
      TfrmDemo_ServicosPrestados.CreateInstance;
    frmDemo_ServicosPrestados.ShowModal;
  end;



end;

constructor TD2BridgeFormTemplate.Create(AOwner: TComponent;
  D2BridgePrismFramework: TObject);
begin
 inherited;

 //Events
 OnProcessHTML:= ProcessHTML;
 OnTagHTML:= ProcessTagHTML;


 //Yours CallBacks Ex:
 //Session.CallBacks.Register('OpenMenuItem', OpenMenuItem);
  //CallBacks.Register('AbrirMenuConfig', AbrirMenuConfig);
  CallBacks.Register('AbrirMenuUsuario', AbrirMenuUsuario);
  CallBacks.Register('AbrirMenuEmpresa',AbrirMenuEmpresa);
  CallBacks.Register('AbreMenuPrestServ',AbreMenuPrestServ);
  CallBacks.Register('AbreMenuCliente',AbreMenuCliente);
  CallBacks.Register('AbreMenuFornecedor',AbreMenuFornecedor);
  CallBacks.Register('AbreMenuTabPreco',AbreMenuTabPreco);
  CallBacks.Register('AbreMenuConta',AbreMenuConta);
  CallBacks.Register('AbreMenuCondPagto',AbreMenuCondPagto);
  CallBacks.Register('AbreMenuFormaPagto',AbreMenuFormaPagto);

 //Other Example CallBack embed
 {
 Session.CallBacks.Register('OpenMenuItem',
   function(EventParams: TStrings): string
   begin
    if MyForm = nil then
     TMyForm.CreateInstance;
    MyForm.Show;
   end);
  }
end;

procedure TD2BridgeFormTemplate.ProcessHTML(Sender: TObject;
  var AHTMLText: string);
begin
 //Intercep HTML Code

end;

procedure TD2BridgeFormTemplate.ProcessTagHTML(const TagString: string;
  var ReplaceTag: string);
begin
 //Process TAGs HTML {{TAGNAME}}
 if TagString = 'usuario' then
 begin
  ReplaceTag := FinanceiroWeb.Usuario_Nome;
 end;

end;

end.
