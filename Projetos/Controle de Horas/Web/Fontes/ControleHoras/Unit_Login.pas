unit Unit_Login;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.IOUtils,
  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,

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
  private

  public

  protected
   procedure ExportD2Bridge; override;
   procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
   procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
  end;

Function Form_Login: TForm_Login;

implementation

Uses
   ControleHorasWebApp
   ,uPrincipal
   ,uCon.ServisoPrestados;

Function Form_Login: TForm_Login;
begin
 Result:= TForm_Login(TForm_Login.GetInstance);
end;

{$R *.dfm}

{ TForm_Login }

procedure TForm_Login.Button_LoginClick(Sender: TObject);
var
  FHost :String;
  FResp :IResponse;
  FJson :TJSONObject;
  FBody :TJSONValue;
  FTexto :String;

begin
 //Your Code
  try
    if Trim(Edit_UserName.Text) = '' then
      raise Exception.Create('Login não informado');
    if Trim(Edit_Password.Text) = '' then
      raise Exception.Create('Senha não informada');

    FHost := '';
    FHost := 'http:\\localhost:3000';

    if Trim(FHost) = '' then
      raise Exception.Create('Host não informado');

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
      ControleHoras.Usuario_ID := FBody.GetValue<Integer>('id',0);
      ControleHoras.Usuario_Nome := FBody.GetValue<String>('nome','');
      ControleHoras.Usuario_Token := FBody.GetValue<String>('token','');
      ControleHoras.Usuario_Tipo := FBody.GetValue<Integer>('tipo',0);
      ControleHoras.Usuario_Form := FBody.GetValue<String>('formInicial','');
      ControleHoras.Usuario_ClienteID := FBody.GetValue<Integer>('idCliente',0);
      ControleHoras.Usuario_Cliente := FBody.GetValue<String>('cliente','');

      Edit_UserName.Text := '';
      Edit_Password.Text := '';

      if ControleHoras.Usuario_Tipo = 2 then
      begin
        if frmPrincipal = nil then
         TfrmPrincipal.CreateInstance;

        frmPrincipal.menuCadastro.Enabled := False;
        frmPrincipal.menuMovimento.Enabled := False;
        frmPrincipal.menuConsultas.Enabled := False;

        if frmCon_ServicosPrestados = nil then
         TfrmCon_ServicosPrestados.CreateInstance;

        frmCon_ServicosPrestados.menuCadastro.Enabled := False;
        frmCon_ServicosPrestados.menuMovimento.Enabled := False;
        frmCon_ServicosPrestados.menuConsultas.Enabled := False;

        frmCon_ServicosPrestados.edFiltro_Cliente_ID.Text := ControleHoras.Usuario_ClienteID.ToString;
        frmCon_ServicosPrestados.edFiltro_Cliente.Text := ControleHoras.Usuario_Cliente;
        frmCon_ServicosPrestados.edFiltro_Cliente_ID.Enabled := False;
        frmCon_ServicosPrestados.edFiltro_Cliente_ID.RightButton.Visible := False;
        frmCon_ServicosPrestados.edFiltro_Cliente.Enabled := False;
        frmCon_ServicosPrestados.Pesquisar;

        frmCon_ServicosPrestados.Show;
      end
      else
      begin
        if frmPrincipal = nil then
         TfrmPrincipal.CreateInstance;

        frmPrincipal.menuCadastro.Enabled := True;
        frmPrincipal.menuMovimento.Enabled := True;
        frmPrincipal.menuConsultas.Enabled := True;

        frmPrincipal.Show;
      end;

    end
    else
      raise Exception.Create(FResp.Content);

  except on E: Exception do
    MessageDlg('Erro ao logar: ' + E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
  end;

 //***EXAMPLE***
 (*
 if (Edit_UserName.Text = 'admin') and (Edit_Password.Text = 'admin') then
 begin
  ControleHoras.Usuario_ID := 1;
  ControleHoras.Usuario_Nome := Edit_UserName.Text;

  if frmPrincipal = nil then
   TfrmPrincipal.CreateInstance;
  frmPrincipal.Show;

 end
 else
 begin
  D2Bridge.Validation(Edit_UserName, false);
  D2Bridge.Validation(Edit_Password, false, 'Usuário ou senha inválido');
  Exit;
 end;
*)
end;

procedure TForm_Login.ExportD2Bridge;
begin
 inherited;

 Title:= 'Control de Horas';
 SubTitle:= 'Login';

 //Background color
 D2Bridge.HTML.Render.BodyStyle:= 'background-color: #f0f0f0;';

 //TemplateClassForm:= TD2BridgeFormTemplate;
 D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
 D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

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
