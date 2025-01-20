{
 +--------------------------------------------------------------------------+
  D2Bridge Framework Content

  Author: Talis Jonatas Gomes
  Email: talisjonatas@me.com

  This source code is provided 'as-is', without any express or implied
  warranty. In no event will the author be held liable for any damages
  arising from the use of this code.

  However, it is granted that this code may be used for any purpose,
  including commercial applications, but it may not be modified,
  distributed, or sublicensed without express written authorization from
  the author (Talis Jonatas Gomes). This includes creating derivative works
  or distributing the source code through any means.

  If you use this software in a product, an acknowledgment in the product
  documentation would be appreciated but is not required.

  God bless you
 +--------------------------------------------------------------------------+
}

{$I D2Bridge.inc}

unit D2Bridge.API.Mail;

interface

Uses
   System.Classes, System.Generics.Collections, System.Threading, System.SysUtils,
   IdSMTP, IdSSLOpenSSL, IdMessage, IdExplicitTLSClientServerBase, IdAttachmentFile, idText,
   D2Bridge.Interfaces, Prism.Server.HTTP.Commom
  {$IFDEF FMX}

  {$ELSE}

  {$ENDIF}
  ;


type
 TD2BridgeAPIMail = class(TInterfacedPersistent, ID2BridgeAPIMail)
  private
   FSubject: string;
   FAdresses: ID2BridgeAPIMailAdresses;
   FFrom: ID2BridgeAPIMailAddress;
   FBodyText: TStrings;
   FBodyHTML: TStrings;
   FAttachment: TStrings;
   FConfig: ID2BridgeAPIMailConfig;
   FMimesType: TPrismServerFileExtensions;
   function getConfig: ID2BridgeAPIMailConfig;
   procedure SetConfig(const Value: ID2BridgeAPIMailConfig);
   function getSubject: string;
   procedure SetSubject(const Value: string);
  public
   constructor Create;
   destructor Destroy; override;

   class function IsValidMailAddress(aMailAddress: string): boolean;

   procedure Clear;

   function Adresses: ID2BridgeAPIMailAdresses;
   function From: ID2BridgeAPIMailAddress;
   function BodyText: TStrings;
   function BodyHTML: TStrings;
   function Attachment: TStrings;

   function SendMail: boolean;

   property Subject: string read getSubject write SetSubject;
   property Config: ID2BridgeAPIMailConfig read GetConfig write SetConfig;
 end;



implementation

Uses
 D2Bridge.API.Mail.Adresses, D2Bridge.API.Mail.Config,
  System.RegularExpressions;

{ TD2BridgeAPIMail }

function TD2BridgeAPIMail.Adresses: ID2BridgeAPIMailAdresses;
begin
 Result:= FAdresses;
end;

function TD2BridgeAPIMail.Attachment: TStrings;
begin
 Result:= FAttachment;
end;

function TD2BridgeAPIMail.BodyHTML: TStrings;
begin
 Result:= FBodyHTML;
end;

function TD2BridgeAPIMail.BodyText: TStrings;
begin
 Result:= FBodyText;
end;

procedure TD2BridgeAPIMail.Clear;
begin
 FAdresses.Clear;
 FBodyText.Clear;
 FBodyHTML.Clear;
 FAttachment.Clear;
end;

constructor TD2BridgeAPIMail.Create;
begin
 inherited;

 FConfig:= TD2BridgeAPIMailConfig.Create;
 FAdresses:= TD2BridgeAPIMailAdresses.Create;
 FFrom:= TD2BridgeAPIMailAddress.Create;;
 FBodyText:= TStringList.Create;
 FBodyHTML:= TStringList.Create;
 FBodyHTML.DefaultEncoding:= TEncoding.UTF8;
 FAttachment:= TStringList.Create;
 FMimesType:= TPrismServerFileExtensions.Create;
end;

destructor TD2BridgeAPIMail.Destroy;
begin
 TD2BridgeAPIMailConfig(FConfig).Destroy;
 TD2BridgeAPIMailAdresses(FAdresses).Destroy;
 TD2BridgeAPIMailAddress(FFrom).Destroy;
 FreeAndNil(FBodyText);
 FreeAndNil(FBodyHTML);
 FreeAndNil(FAttachment);
 FreeAndNil(FMimesType);

 inherited;
end;

function TD2BridgeAPIMail.From: ID2BridgeAPIMailAddress;
begin
 Result:= FFrom;
end;

function TD2BridgeAPIMail.getConfig: ID2BridgeAPIMailConfig;
begin
 Result:= FConfig;
end;

function TD2BridgeAPIMail.getSubject: string;
begin
 Result:= FSubject;
end;

class function TD2BridgeAPIMail.IsValidMailAddress(aMailAddress: string): boolean;
const
  EmailRegex = '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}(?:\.[A-Za-z]{2,})?$';
var
  RegEx: TRegEx;
begin
  RegEx := TRegEx.Create(EmailRegex);
  Result := RegEx.IsMatch(aMailAddress);
end;

function TD2BridgeAPIMail.SendMail: boolean;
var
 vThreadMail: TThread;
 vSucess: boolean;
begin
 if Config.UseThread then
 begin
  vThreadMail:=
   TThread.CreateAnonymousThread(
    procedure
    var
     I: integer;
     vSMTP: TIdSMTP;
     vSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
     vEmail: TIdMessage;
     vAddress: ID2BridgeAPIMailAddress;
     vPartHTML, vPartText: TIdText;
     vAttachment: TIdAttachmentFile;
    begin
     vSMTP := TIdSMTP.Create(nil);
     vSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
     vEmail := TIdMessage.Create(nil);

     try
       // Config Mail
       vSMTP.Host := Config.Host;
       vSMTP.Port := Config.Port;
       vSMTP.Username := Config.UserName;
       vSMTP.Password := Config.Password;

       // SSL
       if Config.UseSSL then
       begin
        vSSLHandler.SSLOptions.Method := sslvSSLv23;
        vSSLHandler.SSLOptions.Mode := sslmClient;
        vSSLHandler.SSLOptions.SSLVersions:= [sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
       end;
       // TLS
       if Config.UseTLS then
       begin
        vSSLHandler.SSLOptions.Method := sslvTLSv1_2;
        vSSLHandler.SSLOptions.Mode := sslmClient;
        vSSLHandler.SSLOptions.SSLVersions:= [sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
       end;
       vSMTP.IOHandler := vSSLHandler;

       //Auth
       if Config.UseSSL then
       begin
        vSMTP.UseTLS := utUseImplicitTLS;
       end else
       if Config.UseTLS then
       begin
        vSMTP.UseTLS := utUseRequireTLS;
       end;

       vSMTP.AuthType := satDefault;

       // FROM
       vEmail.From.Text := FFrom.Name;
       vEmail.From.Address:= FFrom.MailAddress;

       for vAddress in FAdresses.Items do
       begin
        with vEmail.Recipients.Add do
        begin
         if vAddress.Name <> '' then
          Name:= vAddress.Name
         else
          Name:= vAddress.MailAddress;
         Address:= vAddress.MailAddress;
        end;
       end;
       vEmail.Subject := FSubject;

       vEmail.Encoding := meMIME;
       vEmail.CharSet:= 'UTF-8';
       // BODY Text
       if BodyText.Text <> '' then
       begin
        vPartText := TIdText.Create(vEmail.MessageParts);
        vPartText.ContentType:= 'text/plain; charset=iso-8859-1';
        vPartText.Body.Text:= BodyText.Text;
       end;
       // BODY HTML
       if BodyHTML.Text <> '' then
       begin
        vPartHTML := TIdText.Create(vEmail.MessageParts);
        vPartHTML.ContentType:= 'text/html; charset=UTF-8';
        vPartHTML.Body.Text:= BodyHTML.Text;
       end;


       //Attachments
       for I := 0 to Pred(Attachment.Count) do
       begin
        if FileExists(Attachment[I]) then
        begin
         vAttachment:= TIdAttachmentFile.Create(vEmail.MessageParts, Attachment[I]);;
         vAttachment.FileName := ExtractFileName(Attachment[I]);
         vAttachment.ContentDisposition := 'attachment';
         vAttachment.ContentType := FMimesType.GetMimeType(vAttachment.FileName);
         vAttachment.LoadFromFile(Attachment[I]);
        end;
       end;


       // Envia o e-mail
       try
        vSMTP.Connect;
        vSMTP.Authenticate;
        try
          if vSMTP.Connected then
           vSMTP.Send(vEmail);
        finally
          if vSMTP.Connected then
          begin
           vSMTP.Disconnect;
           vSucess:= true;
          end else
          vSucess:= false;
        end;
       except
        vSucess:= false;
       end;
     finally
       if Assigned(vPartText) then
        vPartText.Free;
       if Assigned(vPartHTML) then
        vPartHTML.Free;
       vSMTP.Free;
       vSSLHandler.Free;
       vEmail.Free;
     end;
    end
   );

   vThreadMail.FreeOnTerminate:= false;
   vThreadMail.Start;
   vThreadMail.WaitFor;
   Result:= vSucess;
   FreeAndNil(vThreadMail);
   Clear;
 end;

end;

procedure TD2BridgeAPIMail.SetConfig(const Value: ID2BridgeAPIMailConfig);
begin
 FConfig:= Value;
end;

procedure TD2BridgeAPIMail.SetSubject(const Value: string);
begin
 FSubject:= Value;
end;

end.
