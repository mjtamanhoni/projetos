unit D2BridgeFormTemplate;

interface

Uses
 System.Classes,
 D2Bridge.Prism.Form;


type
 TD2BridgeFormTemplate = class(TD2BridgePrismForm)
  private
   procedure ProcessHTML(Sender: TObject; var AHTMLText: string);
   procedure ProcessTagHTML(const TagString: string; var ReplaceTag: string);
   //function OpenMenuItem(EventParams: TStrings): String;

   function AbrirMenuConfig(EventParams: TStrings): String;
   function AbrirMenuUsuario(EventParams: TStrings): String;

  public
   constructor Create(AOwner: TComponent; D2BridgePrismFramework: TObject); override;

 end;


implementation

Uses
 FinanceiroWebWebApp, uConfiguracoes, uCad.Usuarios;


{ TD2BridgeFormTemplate }

function TD2BridgeFormTemplate.AbrirMenuConfig(EventParams: TStrings): String;
begin
  if frmConfiguracoes = Nil then
    TfrmConfiguracoes.CreateInstance;
  frmConfiguracoes.ShowModal;
  frmConfiguracoes.Free;
end;

function TD2BridgeFormTemplate.AbrirMenuUsuario(EventParams: TStrings): String;
begin
  if frmCad_Usuarios = Nil then
    TfrmCad_Usuarios.CreateInstance;
  frmCad_Usuarios.ShowModal;
  frmCad_Usuarios.Free;
  //
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
  CallBacks.Register('AbrirMenuConfig', AbrirMenuConfig);
  CallBacks.Register('AbrirMenuUsuario', AbrirMenuUsuario);

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
 if TagString = 'UserName' then
 begin
  ReplaceTag := 'Name of User';
 end;

end;

end.
