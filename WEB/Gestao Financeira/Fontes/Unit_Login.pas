unit Unit_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,

  System.JSON,
  DataSet.Serialize,
  RESTRequest4D,
  IniFiles,
  uFuncoes.Gerais,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, D2Bridge.Forms, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Imaging.jpeg; //Declare D2Bridge.Forms always in the last unit

type
  TForm_Login = class(TD2BridgeForm)
    Panel1: TPanel;
    Image_Logo: TImage;
    Label_Login: TLabel;
    Edit_UserName: TEdit;
    Edit_Password: TEdit;
    Button_Login: TButton;
    Image_BackGround: TImage;
    Button_ShowPass: TButton;
    procedure Button_LoginClick(Sender: TObject);
    procedure Button_ShowPassClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
   Gestao_FinanceiraWebApp, uPrincipal;

Function Form_Login: TForm_Login;
begin
 Result:= TForm_Login(TForm_Login.GetInstance);
end;

{$R *.dfm}

{ TForm_Login }

procedure TForm_Login.Button_LoginClick(Sender: TObject);
var
  FJSon :TJSonObject;
  FResp :IResponse;
  FBody :TJSONValue;
  FTexto :String;
  PasswordRehashNeeded :Boolean;

begin
  try
    try
      if Trim(Edit_UserName.Text) = '' then
        raise Exception.Create('Favor informar o Nome do Usuário.');

      if Trim(Edit_Password.Text) = '' then
        raise Exception.Create('Favor informar o Senha do Usuário.');

      //Criando o JSon...
      FJSon := TJSonObject.Create;
      FJSon.AddPair('pin','');
      FJSon.AddPair('usuario',Edit_UserName.Text);
      FJSon.AddPair('senha',TFuncoes.CriptografarSenha(Edit_Password.Text));

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

        //Validando a senha...
        if not TFUncoes.VerificarSenha(Edit_Password.Text, FBody.GetValue<String>('senhaHash',''),PasswordRehashNeeded) then
          raise Exception.Create('Senha não confere');

        Gestao_Financeira.Usuario_ID := FBody.GetValue<Integer>('id',0);
        Gestao_Financeira.Usuario_Nome := FBody.GetValue<String>('nome','');
        Gestao_Financeira.Usuario_Token := FBody.GetValue<String>('token','');
        //Gestao_Financeira.Id_Filial := StrToInt(edId_Filial.Text);

        Edit_UserName.Text := '';
        Edit_Password.Text := '';


        if frmPrincipal = nil then
          TfrmPrincipal.CreateInstance;
        frmPrincipal.Show;

        //Close;
      end
      else
      begin
        if IsD2BridgeContext then
        begin
         D2Bridge.Validation(Edit_UserName, false);
         D2Bridge.Validation(Edit_Password, false, 'Usuário ou senha inválidos');
        end
        else
          raise Exception.Create('Usuário ou senha inválidos');
      end;

    except on E: Exception do
      MessageDlg(E.Message, TMsgDlgType.mtError, [mbok], 0);
    end;
  finally
    FreeAndNil(FJSon);
  end;

end;

procedure TForm_Login.Button_ShowPassClick(Sender: TObject);
begin
 if Edit_Password.PasswordChar = '*' then
 begin
  Edit_Password.PasswordChar:= #0;

  if IsD2BridgeContext then
   D2Bridge.PrismControlFromVCLObj(Edit_Password).AsEdit.DataType:= TPrismFieldType.PrismFieldTypeString;
 end else
 begin
  Edit_Password.PasswordChar:= '*';

  if IsD2BridgeContext then
   D2Bridge.PrismControlFromVCLObj(Edit_Password).AsEdit.DataType:= TPrismFieldType.PrismFieldTypePassword;
 end;
end;

procedure TForm_Login.ExportD2Bridge;
begin
 inherited;

 Title:= 'Gestão Financeira';
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
     Col.Add.VCLObj(Label_Login);

    with Row.Items.Add do
     Col.Add.VCLObj(Edit_UserName, 'ValidationLogin', true);

    with Row.Items.Add do
     with Col.Items.add do //Example Edit + Button same row and col
     begin
      VCLObj(Edit_Password, 'ValidationLogin', true);
      VCLObj(Button_ShowPass, CSSClass.Button.view);
     end;

    with Row.Items.Add do
     Col.Add.VCLObj(Button_Login, 'ValidationLogin', false, CSSClass.Col.colsize12);
   end;

  end;
 end;
end;

procedure TForm_Login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caNone;
end;

procedure TForm_Login.FormCreate(Sender: TObject);
begin
  FEnder  := '';
  FEnder := System.SysUtils.GetCurrentDir + '\Config.ini';
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
