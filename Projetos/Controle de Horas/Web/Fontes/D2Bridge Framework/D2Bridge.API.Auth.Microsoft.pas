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
  Thanks for contribution to this Unit to:
   João B. S. Junior
   Phone +55 69 99250-3445
   Email jr.playsoft@gmail.com
 +--------------------------------------------------------------------------+
}

{$I D2Bridge.inc}

unit D2Bridge.API.Auth.Microsoft;

interface

Uses
   System.Classes, System.SysUtils, System.UITypes, System.JSON,
   Rest.Utils, System.Net.HttpClient, System.Net.HttpClientComponent,System.Net.URLClient,System.NetEncoding,
   D2Bridge.Interfaces, Prism.Interfaces, D2Bridge.API.Auth
  {$IFDEF FMX}

  {$ELSE}

  {$ENDIF}
  ;

type
  TD2BridgeAPIAuthMicrosoft = class(TInterfacedPersistent, ID2BridgeAPIAuthMicrosoft)
   private
    FConfig: ID2BridgeAPIAuthMicrosoftConfig;
    function GetProfilePhotoAsBase64(const AccessToken: string): string;

   public
    constructor Create;
    destructor Destroy; override;

    function Config: ID2BridgeAPIAuthMicrosoftConfig;

    function Login: ID2BridgeAPIAuthMicrosoftResponse;
    procedure Logout;
  end;



const
 MicrosoftAuthScope = 'https://graph.microsoft.com/user.read';
 MicrosoftCallBackReturn = 'oauth2callback=microsoft';
 APIAuthCallBackMicrosoft = APIAuthCallBack + '/microsoft';


implementation

Uses
 D2Bridge.API.Auth.Microsoft.Config, D2Bridge.API.Auth.Microsoft.Response,
 D2Bridge.Instance, IdURI;

{ TD2BridgeAPIAuthMicrosoft }

function TD2BridgeAPIAuthMicrosoft.Config: ID2BridgeAPIAuthMicrosoftConfig;
begin
 result:= FConfig;
end;

constructor TD2BridgeAPIAuthMicrosoft.Create;
begin
 FConfig:= TD2BridgeAPIAuthMicrosoftConfig.Create;
end;

destructor TD2BridgeAPIAuthMicrosoft.Destroy;
begin
 (FConfig as TD2BridgeAPIAuthMicrosoftConfig).Destroy;

 inherited;
end;

function TD2BridgeAPIAuthMicrosoft.GetProfilePhotoAsBase64(const AccessToken: string): string;
var
  HTTPClient: TNetHTTPClient;
  Response: IHTTPResponse;
  PhotoStream: TMemoryStream;
  Base64Stream: TStringStream;
begin
  HTTPClient := TNetHTTPClient.Create(nil);
  PhotoStream := TMemoryStream.Create;
  Base64Stream := TStringStream.Create;
  try
    HTTPClient.CustomHeaders['Authorization'] := 'Bearer ' + AccessToken;

    Response := HTTPClient.Get('https://graph.microsoft.com/v1.0/me/photo/$value');

    if Response.StatusCode = 200 then
    begin
      PhotoStream.LoadFromStream(Response.ContentStream);
      PhotoStream.Position := 0; // Reseta a posição do stream para leitura

      TNetEncoding.Base64.Encode(PhotoStream, Base64Stream);

      Result := 'data:image/jpeg;base64,' + Base64Stream.DataString;
    end
    else
    begin
      Result:='';
    end;
  finally
    HTTPClient.Free;
    PhotoStream.Free;
    Base64Stream.Free;
  end;
end;

function TD2BridgeAPIAuthMicrosoft.Login: ID2BridgeAPIAuthMicrosoftResponse;
var
  vCode_challenge:string;

 vMicrosoftResponse: TD2BridgeAPIAuthMicrosoftResponse;
 vRedirectURI, vURL: string;
 vPrismSession: IPrismSession;
 vCode: string;
 vtoken : string;
 vHttp : TNetHTTPClient;
 vParams : Tstringlist;
 vResponse : IHTTPresponse;
 vResponseJSON: TJSONObject;
begin
 try
  vPrismSession:= PrismSession;

  Result:= nil;

  vRedirectURI:= vPrismSession.URI.URL + APIAuthCallBackMicrosoft;

  vCode_challenge:= 'E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM';
  vURL := 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
  vURL := vURL + '?response_type=' + URIEncode('code');
  vURL := vURL + '&client_id='     + URIEncode(Config.ClientID);
  vURL := vURL + '&redirect_uri='  + URIEncode(vRedirectURI);
  vURL := vURL + '&response_mode=' + URIEncode('query');
  vURL := vURL + '&scope='         + URIEncode(MicrosoftAuthScope);
  vURL := vURL + '&state='         + URIEncode(PrismSession.PushID);

  vPrismSession.Redirect(vURL, true);

  if vPrismSession.MessageDlg('Fazendo Login', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbCancel], 0, APIAuthLockName) = mrCancel then
  begin
   result:= TD2BridgeAPIAuthMicrosoftResponse.Create(false);
  end else
  begin
   if vPrismSession.URI.QueryParams.ValueFromKey('code') <> '' then
   begin
    vCode:= vPrismSession.URI.QueryParams.ValueFromKey('code');


    vhttp := TNetHTTPClient.Create(nil);
    vparams := Tstringlist.Create;
    vparams.Add('code='         + vCode);
    vparams.Add('client_id='    + Config.ClientID);
    vparams.Add('scope='        + MicrosoftAuthScope);
    vparams.Add('redirect_uri=' + vRedirectURI);
    vparams.Add('grant_type=authorization_code');

    vResponse := vhttp.Post('https://login.microsoftonline.com/common/oauth2/v2.0/token', vParams);
    if vResponse.StatusText='OK' then
    begin
     Try
      vResponseJSON := TJSONObject.ParseJSONValue(vResponse.ContentAsString) as TJSONObject;
      vtoken := vResponseJSON.GetValue<string>('access_token');
     finally
      vResponseJSON.Free;
     End;
    end else
    begin
     FreeAndNil(vHttp);
     FreeAndNil(vParams);

     result:= TD2BridgeAPIAuthMicrosoftResponse.Create(false);

     exit;
    end;

    vToken := stringreplace (vToken,'"','',[rfreplaceall]);
    vResponse := vHttp.get ('https://graph.microsoft.com/v1.0/me',nil,[TNetHeader.Create('Authorization','Bearer ' + VToken)]);

    if vResponse.StatusText='OK' then
    begin

     vResponseJSON := TJSONObject.ParseJSONValue(vResponse.ContentAsString) as TJSONObject;
     try
      result:= TD2BridgeAPIAuthMicrosoftResponse.Create(
       true,
       vResponseJSON.GetValue<string>('id'),
       vResponseJSON.GetValue<string>('displayName'),
       vResponseJSON.GetValue<string>('mail'),
       //'',//Microsoft não devolve foto em URL e sim em bytes vou tratar depois
       GetProfilePhotoAsBase64(VToken),
       vResponseJSON.GetValue<string>('givenName'),
       vResponseJSON.GetValue<string>('surname'),
       vResponseJSON.GetValue<string>('mobilePhone'),
       vResponseJSON.GetValue<string>('preferredLanguage'),
       vResponseJSON.GetValue<string>('jobTitle')
      );
      //'{"@odata.context":"https://graph.microsoft.com/v1.0/$metadata#users/$entity","userPrincipalName":"juniorcsa@hotmail.com","id":"0e25e97482beb893","displayName":"João B S Junior","surname":"B S Junior","givenName":"João","preferredLanguage":"pt-BR","mail":"juniorcsa@hotmail.com","mobilePhone":null,"jobTitle":null,"officeLocation":null,"businessPhones":[]}'
     finally
      vResponseJSON.Free;
     end;

    end;

    FreeAndNil(vHttp);
    FreeAndNil(vParams);
   end;
  end;
 except
 end;
end;

procedure TD2BridgeAPIAuthMicrosoft.Logout;
begin
 try
        PrismSession.Redirect('https://login.microsoftonline.com/common/oauth2/v2.0/logout',true);
 except

 end;
end;


end.

