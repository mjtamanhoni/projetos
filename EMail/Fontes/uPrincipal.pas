{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{																			   }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatuí - SP - 18270-170         }
{******************************************************************************}

unit uPrincipal;

interface

uses
  Classes, 
  SysUtils, 
  Forms, 
  Controls, 
  Graphics, 
  Dialogs, 
  StdCtrls, 
  ComCtrls, 
  ACBrMail, 
  types, 
  ACBrBase, 
  ExtCtrls,
  blcksock, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Themes;

type

  { TForm1 }

  TfrmPrincipal = class(TForm)
    ACBrMail1: TACBrMail;
    pnlTopo: TPanel;
    imgLogo: TImage;
    lblDescricao: TLabel;
    pcPrincipal: TPageControl;
    tsMensagem: TTabSheet;
    tsConfigConta: TTabSheet;
    Label4: TLabel;
    mBody: TMemo;
    ProgressBar1: TProgressBar;
    bEnviarLote: TButton;
    edtHost: TEdit;
    lblHost: TLabel;
    lblFrom: TLabel;
    edtFrom: TEdit;
    edtFromName: TEdit;
    lblFromName: TLabel;
    lblUser: TLabel;
    edtUser: TEdit;
    lblPassword: TLabel;
    edtPassword: TEdit;
    chkMostraSenha: TCheckBox;
    edtPort: TEdit;
    lblPort: TLabel;
    btnSalvar: TButton;
    chkTLS: TCheckBox;
    chkSSL: TCheckBox;
    lblTipoAutenticacao: TLabel;
    lblDefaultCharset: TLabel;
    cbbDefaultCharset: TComboBox;
    cbbIdeCharSet: TComboBox;
    lbl1: TLabel;
    btLerConfig: TButton;
    Label7: TLabel;
    cbxSSLTYPE: TComboBox;
    gbListaEmails: TGroupBox;
    Memo_ListaEmails: TMemo;
    pnAcoesListaEmails: TPanel;
    btGravarLista: TButton;
    cbEstilo: TComboBox;
    Label1: TLabel;
    pnOpcoes: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    edSubject: TEdit;
    Label5: TLabel;
    mLog: TMemo;
    lbPosicao: TLabel;
    lbEmail: TLabel;
    ProgressBar: TProgressBar;
    TabSheet1: TTabSheet;
    Memo_Log: TMemo;
    procedure ACBrMail1AfterMailProcess(Sender: TObject);
    procedure ACBrMail1BeforeMailProcess(Sender: TObject);
    procedure ACBrMail1MailException(const AMail: TACBrMail; const E: Exception; var ThrowIt: Boolean);
    procedure ACBrMail1MailProcess(const AMail: TACBrMail; const aStatus: TMailStatus);
    procedure bEnviarLoteClick(Sender: TObject);
    procedure chkMostraSenhaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btLerConfigClick(Sender: TObject);
    procedure cbEstiloClick(Sender: TObject);
  private
    procedure AjustaParametrosDeEnvio(AEnderDest,ANomeDest:String);
    procedure LerConfiguracao;
    procedure GravarConfiguracao;
    procedure EnviarEmail(AEnderDest,ANomeDest:String);
    procedure Mensagem_Padrao;
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  mimemess, IniFiles, TypInfo;

{$R *.dfm}

{ TForm1 }
procedure TfrmPrincipal.GravarConfiguracao;
var
  IniFile: string;
  Ini: TIniFile;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');
  Ini := TIniFile.Create(IniFile);
  try
    Ini.WriteString('Email', 'From', edtFrom.text);
    Ini.WriteString('Email', 'FromName', edtFromName.text);
    Ini.WriteString('Email', 'Host', edtHost.text);
    Ini.WriteString('Email', 'Port', edtPort.text);
    Ini.WriteString('Email', 'User', edtUser.text);
    Ini.WriteString('Email', 'Pass', edtPassword.text);
    Ini.WriteBool('Email', 'TLS', chkTLS.Checked);
    Ini.WriteBool('Email', 'SSL', chkSSL.Checked);
    Ini.WriteInteger('Email', 'SSLType', cbxSSLTYPE.ItemIndex);
    Ini.WriteInteger('Email', 'DefaultCharset', cbbDefaultCharset.ItemIndex);
    Ini.WriteInteger('Email', 'IdeCharset', cbbIdeCharSet.ItemIndex);
    Ini.WriteInteger('Estilo', 'Nome', cbEstilo.ItemIndex);
  finally
    Ini.Free;
  end;

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  m: TMailCharset;
  LTLS : TSSLType;
  Style :String;

begin

  for Style in TStyleManager.StyleNames do
    cbEstilo.Items.Add(Style);

  cbbDefaultCharset.Items.Clear;
  for m := Low(TMailCharset) to High(TMailCharset) do
    cbbDefaultCharset.Items.Add(GetEnumName(TypeInfo(TMailCharset), integer(m)));
  cbbDefaultCharset.ItemIndex := 0;
  cbbIdeCharSet.Items.Assign(cbbDefaultCharset.Items);
  cbbIdeCharSet.ItemIndex := 0;

  for LTLS := Low(TSSLType) to High(TSSLType) do
    cbxSSLTYPE.Items.Add(GetEnumName(TypeInfo(TSSLType), integer(LTLS)));

  LerConfiguracao;

  pcPrincipal.ActivePage := tsMensagem;

  Mensagem_Padrao;

end;

procedure TfrmPrincipal.Mensagem_Padrao;
begin
  mBody.Lines.Clear;
  mBody.Lines.Add('');
  mBody.Lines.Add('<h2><span style="background-color:#000000"><img alt="" src="https://bet7k.com/casino/category/all" /></span></h2>');
  mBody.Lines.Add('<p style="text-align:center"><img alt="" height="460" src="https://imagedelivery.net/BgH9d8bzsn4n0yijn4h7IQ/c34a7cd0-aeaa-449b-18a2-f7b28ddb0600/w=1817" width="1240" /></p>');
  mBody.Lines.Add('<h1 style="text-align: center;"><span style="font-size:48px">A hora &eacute; agora!</span></h1>');
  mBody.Lines.Add('<p><span style="font-size:24px">Ganhe at&eacute; 100 rodadas gr&aacute;tis em saldo real.</span></p>');
  mBody.Lines.Add('<p><span style="font-size:24px">Realizando um dep&oacute;sito no valor exato de:</span></p>');
  mBody.Lines.Add('<table border="0" cellpadding="1" cellspacing="1" style="width:500px">');
  mBody.Lines.Add('  <tbody>');
  mBody.Lines.Add('    <tr>');
  mBody.Lines.Add('      <td><span style="font-size:24px">R$ 5,00</span></td>');
  mBody.Lines.Add('      <td><span style="font-size:24px">5 rodadas gr&aacute;tis</span></td>');
  mBody.Lines.Add('    </tr>');
  mBody.Lines.Add('    <tr>');
  mBody.Lines.Add('      <td><span style="font-size:24px">R$ 10,00</span></td>');
  mBody.Lines.Add('      <td><span style="font-size:24px">10 rodadas gr&aacute;tis</span></td>');
  mBody.Lines.Add('    </tr>');
  mBody.Lines.Add('    <tr>');
  mBody.Lines.Add('      <td><span style="font-size:24px">R$ 20,00</span></td>');
  mBody.Lines.Add('      <td><span style="font-size:24px">20 rodadas gr&aacute;tis</span></td>');
  mBody.Lines.Add('    </tr>');
  mBody.Lines.Add('    <tr>');
  mBody.Lines.Add('      <td><span style="font-size:24px">R$ 30,00</span></td>');
  mBody.Lines.Add('      <td><span style="font-size:24px">30 rodadas gr&aacute;tis</span></td>');
  mBody.Lines.Add('    </tr>');
  mBody.Lines.Add('    <tr>');
  mBody.Lines.Add('      <td><span style="font-size:24px">R$ 40,00</span></td>');
  mBody.Lines.Add('      <td><span style="font-size:24px">40 rodadas gr&aacute;tis</span></td>');
  mBody.Lines.Add('    </tr>');
  mBody.Lines.Add('    <tr>');
  mBody.Lines.Add('      <td><span style="font-size:24px">R$ 50,00</span></td>');
  mBody.Lines.Add('      <td><span style="font-size:24px">50 rodadas gr&aacute;tis</span></td>');
  mBody.Lines.Add('    </tr>');
  mBody.Lines.Add('    <tr>');
  mBody.Lines.Add('      <td><span style="font-size:24px">R$ 100,00</span></td>');
  mBody.Lines.Add('      <td><span style="font-size:24px">100 rodadas gr&aacute;tis</span></td>');
  mBody.Lines.Add('    </tr>');
  mBody.Lines.Add('  </tbody>');
  mBody.Lines.Add('</table>');
  mBody.Lines.Add('<p>&nbsp;</p>');
  mBody.Lines.Add('<p><span style="font-size:24px">AP&Oacute;S REALIZAR O SEU DEP&Oacute;SITO, APROVEITE SUAS RODADAS GR&Aacute;TIS.</span></p>');
  mBody.Lines.Add('<p><span style="font-size:24px">LEMBRE-SE: V&aacute;lido apenas para novos cadastros.</span></p>');
  mBody.Lines.Add('<p>&nbsp;</p>');
  mBody.Lines.Add('<p style="text-align: center;"><span style="color:#008000"><span style="font-size:24px">ACESSE O LINK E PARTICIPE AGORA MESMO.</span></span></p>');
  mBody.Lines.Add('<p style="text-align: center;"><span style="font-size:28px"><a href="https://bit.ly/4bSpZlY">https://bit.ly/4bSpZlY</a></span></p>');
  mBody.Lines.Add('<p style="text-align: center;"><span style="color:#008000"><span style="font-size:24px">Pormo&ccedil;&atilde;o v&aacute;lida at&eacute; 23:59:59 hs do dia '+DateToStr(Date)+'</span></span></p>');
  mBody.Lines.Add('<p style="text-align: center;"><span style="font-size:28px"><a href="https://bit.ly/4bSpZlY">https://bit.ly/4bSpZlY</a></span></p>');
  mBody.Lines.Add('<p>&nbsp;</p>');
  mBody.Lines.Add('');

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  //LerConfiguracao;
end;

procedure TfrmPrincipal.LerConfiguracao;
var
  IniFile: string;
  Ini: TIniFile;
begin
  IniFile := ChangeFileExt(Application.ExeName, '.ini');
  Ini := TIniFile.Create(IniFile);
  try
    edtFrom.text := Ini.readString('Email', 'From', 'fulano@empresa.com.br');
    edtFromName.text := Ini.readString('Email', 'FromName', 'Fulano de Tal');
    edtHost.text := Ini.readString('Email', 'Host', 'smtp.empresa.com.br');
    edtPort.text := Ini.readString('Email', 'Port', '587');
    edtUser.text := Ini.readString('Email', 'User', 'fulano@empresa.com.br');
    edtPassword.text := Ini.readString('Email', 'Pass', 'Sua_Senha_123');
    chkTLS.Checked := Ini.ReadBool('Email', 'TLS', False);
    chkSSL.Checked := Ini.ReadBool('Email', 'SSL', False);
    cbxSSLTYPE.ItemIndex := Ini.ReadInteger('Email', 'SSLType', 0);
    cbbDefaultCharset.ItemIndex := Ini.ReadInteger('Email', 'DefaultCharset', 27);
    cbbIdeCharSet.ItemIndex := Ini.ReadInteger('Email', 'IdeCharset', 15);

    cbEstilo.ItemIndex := Ini.ReadInteger('Estilo', 'Nome',0);
    if cbEstilo.ItemIndex > 0 then
      TStyleManager.TrySetStyle(cbEstilo.Text);
  finally
    Ini.Free;
  end;
end;

procedure TfrmPrincipal.EnviarEmail(AEnderDest,ANomeDest:String);
var
  Dir, ArqXML: string;
  MS: TMemoryStream;
  P, N: Integer;
begin
  mLog.Lines.Clear;
  ProgressBar1.Position := 1;

  Dir := ExtractFilePath(ParamStr(0));

  P := pos(' - ', edSubject.Text);
  if P > 0 then
  begin
    N := StrToIntDef(copy(edSubject.Text, P + 3, 5), 0) + 1;
    edSubject.Text := copy(edSubject.Text, 1, P + 2) + IntToStr(N);
  end;

  ACBrMail1.Clear;
  ACBrMail1.IsHTML := True;
  ACBrMail1.Subject := edSubject.Text;

  AjustaParametrosDeEnvio(AEnderDest,ANomeDest);
  ACBrMail1.AddAddress(AEnderDest, ANomeDest);
  ACBrMail1.Body.Assign(mBody.Lines);

  try
    ACBrMail1.Send(True);
  except on E: Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TfrmPrincipal.ACBrMail1BeforeMailProcess(Sender: TObject);
begin
  //mLog.Lines.Add('Antes de Enviar o email: ' + TACBrMail(Sender).Subject);
end;

procedure TfrmPrincipal.ACBrMail1MailException(const AMail: TACBrMail; const E: Exception; var ThrowIt: Boolean);
begin
  ThrowIt := False;
  mLog.Lines.Add('*** Erro ao Enviar o email: ' + AMail.Subject);
end;

procedure TfrmPrincipal.ACBrMail1MailProcess(const AMail: TACBrMail; const aStatus: TMailStatus);
begin
{
  ProgressBar1.Position := Integer(aStatus);

  case aStatus of
    //pmsStartProcess: mLog.Lines.Add('Iniciando processo de envio.');
    //pmsConfigHeaders: mLog.Lines.Add('Configurando o cabeçalho do e-mail.');
    //pmsLoginSMTP: mLog.Lines.Add('Logando no servidor de e-mail.');
    //pmsStartSends: mLog.Lines.Add('Iniciando os envios.');
    //pmsSendTo: mLog.Lines.Add('Processando lista de destinatários.');
    //pmsSendCC: mLog.Lines.Add('Processando lista CC.');
    //pmsSendBCC: mLog.Lines.Add('Processando lista BCC.');
    //pmsSendReplyTo: mLog.Lines.Add('Processando lista ReplyTo.');
    pmsSendData: mLog.Lines.Add('Enviando dados.');
    //pmsLogoutSMTP: mLog.Lines.Add('Fazendo Logout no servidor de e-mail.');
    //pmsDone:
    //  begin
    //    mLog.Lines.Add('Terminando e limpando.');
    //    ProgressBar1.Position := ProgressBar1.Max;
    //  end;
  end;

  lbEmail.Caption := '';

  mLog.Lines.Add('   ' + AMail.Subject);

  Application.ProcessMessages;
  }
end;

procedure TfrmPrincipal.ACBrMail1AfterMailProcess(Sender: TObject);
begin
  //mLog.Lines.Add('Depois de Enviar o email: ' + TACBrMail(Sender).Subject);
end;

procedure TfrmPrincipal.bEnviarLoteClick(Sender: TObject);
var
  A: Integer;
begin
  frmPrincipal.Enabled := False;

  mLog.Lines.Add('***** Iniciando envio de '+IntToStr(Memo_ListaEmails.Lines.Count - 1)+' emails por Thread *****');

  ProgressBar.Min := 0;
  ProgressBar.Max := Memo_ListaEmails.Lines.Count - 1;
  ProgressBar.Position := 0;

  for A := 0 to Memo_ListaEmails.Lines.Count - 1 do
  begin
    lbPosicao.Caption := IntToStr(A) + ' de ' + IntToStr(ProgressBar.Max);
    lbEmail.Caption := Memo_ListaEmails.Lines.Strings[A];
    ProgressBar.Position := A;
    Application.ProcessMessages;

    mLog.Lines.Add('***** Enviando email: ' + IntToStr(A));
    edSubject.Text := edSubject.Text;
    EnviarEmail(Memo_ListaEmails.Lines.Strings[A],Memo_ListaEmails.Lines.Strings[A]);
  end;

  mLog.Lines.Add('***** ' + A.ToString + ' emails enviados ***** ');
  frmPrincipal.Enabled := True;
  ProgressBar1.Position := 0;
  lbEmail.Caption := '';
  lbPosicao.Caption := '0 de 0';

end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
begin
  GravarConfiguracao;
end;

procedure TfrmPrincipal.cbEstiloClick(Sender: TObject);
begin
  TStyleManager.TrySetStyle(cbEstilo.Text,False);
end;

procedure TfrmPrincipal.chkMostraSenhaClick(Sender: TObject);
begin
  if chkMostraSenha.Checked then
    edtPassword.PasswordChar := #0
  else
    edtPassword.PasswordChar := '@';
end;

procedure TfrmPrincipal.AjustaParametrosDeEnvio(AEnderDest,ANomeDest:String);
var
  I :Integer;
begin
  ACBrMail1.From := edtFrom.text;
  ACBrMail1.FromName := edtFromName.text;
  ACBrMail1.Host := edtHost.text; // troque pelo seu servidor smtp
  ACBrMail1.Username := edtUser.text;
  ACBrMail1.Password := edtPassword.text;
  ACBrMail1.Port := edtPort.text; // troque pela porta do seu servidor smtp
  ACBrMail1.SetTLS := chkTLS.Checked;
  ACBrMail1.SetSSL := chkSSL.Checked;  // Verifique se o seu servidor necessita SSL
  ACBrMail1.DefaultCharset := TMailCharset(cbbDefaultCharset.ItemIndex);
  ACBrMail1.IDECharset := TMailCharset(cbbIdeCharSet.ItemIndex);
  //ACBrMail1.AddAddress(AEnderDest, ANomeDest);
  ACBrMail1.SSLType := TSSLType(cbxSSLTYPE.ItemIndex);
  //ACBrMail1.AddCC('outro_email@gmail.com'); // opcional
  //ACBrMail1.AddReplyTo('um_email'); // opcional
  //ACBrMail1.AddBCC('um_email'); // opcional
  //ACBrMail1.Priority := MP_high;
  //ACBrMail1.ReadingConfirmation := True; // solicita confirmação de leitura
end;

procedure TfrmPrincipal.btLerConfigClick(Sender: TObject);
begin
  LerConfiguracao;
end;

end.




