unit Unit_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, D2Bridge.Forms, Vcl.Imaging.pngimage, Vcl.ExtCtrls; //Declare D2Bridge.Forms always in the last unit

type
  TForm_Login = class(TD2BridgeForm)
    Panel1: TPanel;
    Image_Logo: TImage;
    Label_Login: TLabel;
    Edit_UserName: TEdit;
    Edit_Password: TEdit;
    Button_Login: TButton;
    Image_BackGround: TImage;
    procedure Button_LoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FEnder :String;
    FIniFiles :TIniFile;
    FHost :String;
    FPorta :String;

  public

  protected
   procedure ExportD2Bridge; override;
   procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
   procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

Function Form_Login: TForm_Login;

implementation

Uses
   FinanceiroWebWebApp, uPrincipal, uDemo.ServicosPrestados;

Function Form_Login: TForm_Login;
begin
 Result:= TForm_Login(TForm_Login.GetInstance);
end;

{$R *.dfm}

{ TForm_Login }

procedure TForm_Login.Button_LoginClick(Sender: TObject);
var
  FResp :IResponse;
  FJson :TJSONObject;
  FBody :TJSONValue;
  FTexto :String;
begin
 //Your Code

 //***EXAMPLE***
 try
    if Trim(Edit_UserName.Text) = '' then
      raise Exception.Create('Favor informar o Nome do Usuário.');

    if Trim(Edit_Password.Text) = '' then
      raise Exception.Create('Favor informar o Senha do Usuário.');

    if Trim(FHost) = '' then
      raise Exception.Create('Favor informar o Host de conexão com o servidor.');

    FinanceiroWeb.Usuario_ID := 1;
    FinanceiroWeb.Usuario_Nome := Edit_UserName.Text;

    FJson := TJSONObject.Create;
    FJson.AddPair('usuario',Edit_UserName.Text);
    FJson.AddPair('senha',Edit_Password.Text);
    FJson.AddPair('pin','');

    FResp := TRequest.New.BaseURL(FHost)
             .Resource('usuario/login')
             .AddBody(FJson.ToJSON)
             .Accept('application/json')
             .Post;

    if FResp.StatusCode = 200 then
    begin
      if FResp.Content = '' then
        raise Exception.Create('Não houve retorno no login');

      FBody := TJSONObject.ParseJSONValue(FResp.Content);
      FinanceiroWeb.Usuario_ID := FBody.GetValue<Integer>('id',0);
      FinanceiroWeb.Usuario_Nome := FBody.GetValue<String>('nome','');
      FinanceiroWeb.Usuario_Tipo := FBody.GetValue<Integer>('tipo',0);
      FinanceiroWeb.Usuario_Token := FBody.GetValue<String>('token','');
      FinanceiroWeb.Usuario_Form := FBody.GetValue<String>('formInicial','');
      FinanceiroWeb.Usuario_ClienteID := FBody.GetValue<Integer>('idCliente',0);
      FinanceiroWeb.Usuario_Cliente := FBody.GetValue<String>('cliente','');
      FinanceiroWeb.Usuario_ID_Prestador := FBody.GetValue<Integer>('idPrestadorServico',0);
      FinanceiroWeb.Usuario_Prestador := FBody.GetValue<String>('prestador','');
      FinanceiroWeb.Usuario_ID_Empresa := FBody.GetValue<Integer>('idEmpresa',0);
      FinanceiroWeb.Usuario_Empresa := FBody.GetValue<String>('empresa','');

      Edit_UserName.Text := '';
      Edit_Password.Text := '';

      if FinanceiroWeb.Usuario_Tipo = 2 then
      begin
        if frmPrincipal = nil then
         TfrmPrincipal.CreateInstance;

        //frmPrincipal.menuCadastro.Enabled := False;
        //frmPrincipal.menuMovimento.Enabled := False;
        //frmPrincipal.menuConsultas.Enabled := False;

        if frmDemo_ServicosPrestados = nil then
         TfrmDemo_ServicosPrestados.CreateInstance;

        {
        frmDemo_ServicosPrestados.menuCadastro.Enabled := False;
        frmDemo_ServicosPrestados.menuMovimento.Enabled := False;
        frmDemo_ServicosPrestados.menuConsultas.Enabled := False;


        frmDemo_ServicosPrestados.edFiltro_Cliente_ID.Text := FinanceiroWeb.Usuario_ClienteID.ToString;
        frmDemo_ServicosPrestados.edFiltro_Cliente_ID.Text := FinanceiroWeb.Usuario_Cliente;
        frmDemo_ServicosPrestados.edFiltro_Cliente_ID.Enabled := False;
        frmDemo_ServicosPrestados.edFiltro_Cliente_ID.RightButton.Visible := False;
        frmDemo_ServicosPrestados.edFiltro_Cliente_ID.Enabled := False;
        frmDemo_ServicosPrestados.Pesquisar;
        }

        frmDemo_ServicosPrestados.ShowModal;

      end
      else
      begin
        if frmPrincipal = nil then
         TfrmPrincipal.CreateInstance;
        frmPrincipal.Show;
      end;

    end
    else
      raise Exception.Create(FResp.Content);
 except on E: Exception do
  ShowMessage(E.Message,True,True,5000);
 end;

end;

procedure TForm_Login.ExportD2Bridge;
begin
 inherited;

 //Title:= 'Login';
 //SubTitle:= 'Efetua o login para acessar o sistema';

 //Background color
 //D2Bridge.HTML.Render.BodyStyle:= 'background-color: #f0f0f0;';

 //TemplateClassForm:= TD2BridgeFormTemplate;
 D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= 'pages-login.html';
 //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

 //Export yours Controls
 with D2Bridge.Items.add do
 begin
  //Image Backgroup Full Size *Use also ImageFromURL...
  ImageFromTImage(Image_BackGround, CSSClass.Image.Image_BG20_FullSize);

  with Card do
  begin
   CSSClasses:= CSSClass.Card.Card_Center;

   ImageICOFromTImage(Image_Logo, CSSClass.Col.ColSize4);

   with BodyItems.Add do
   begin
    with Row.Items.Add do
     VCLObj(Label_Login);
    with Row.Items.Add do
     VCLObj(Edit_UserName, 'ValidationLogin', true);
    with Row.Items.Add do
     VCLObj(Edit_Password, 'ValidationLogin', true);
    with Row.Items.Add do
     VCLObj(Button_Login, 'ValidationLogin', false);
   end;
  end;
 end;
end;

procedure TForm_Login.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\CONTROLE_HORAS_WEB.ini';
  FIniFiles := TIniFile.Create(FEnder);

  FHost := '';
  FHost := FIniFiles.ReadString('SERVIDOR.PADRAO','HOST','') + ':' + FIniFiles.ReadString('SERVIDOR.PADRAO','PORTA','');

end;

procedure TForm_Login.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
 inherited;

end;

procedure TForm_Login.RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string);
begin
 inherited;

 //Intercept HTML
 {
  if PrismControl.VCLComponent = Edit1 then
  begin
   HTMLControl:= '</>';
  end;
 }
end;

end.
