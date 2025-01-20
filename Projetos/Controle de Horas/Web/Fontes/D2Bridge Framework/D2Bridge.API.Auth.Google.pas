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

unit D2Bridge.API.Auth.Google;

interface

Uses
   System.Classes, System.SysUtils, System.UITypes, System.JSON,
   Rest.Utils, System.Net.HttpClient, System.Net.HttpClientComponent,
   D2Bridge.Interfaces, Prism.Interfaces, D2Bridge.API.Auth
  {$IFDEF FMX}

  {$ELSE}

  {$ENDIF}
  ;

type
  TD2BridgeAPIAuthGoogle = class(TInterfacedPersistent, ID2BridgeAPIAuthGoogle)
   private
    FConfig: ID2BridgeAPIAuthGoogleConfig;

   public
    constructor Create;
    destructor Destroy; override;

    function Config: ID2BridgeAPIAuthGoogleConfig;

    function Login: ID2BridgeAPIAuthGoogleResponse;
    procedure Logout;
  end;



const
 GoogleAuthScope = 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email';
 GoogleCallBackReturn = 'oauth2callback=google';
 APIAuthCallBackGoogle = APIAuthCallBack + '/google';


implementation

Uses
 D2Bridge.API.Auth.Google.Config, D2Bridge.API.Auth.Google.Response,
 D2Bridge.Instance, IdURI;

{ TD2BridgeAPIAuthGoogle }

function TD2BridgeAPIAuthGoogle.Config: ID2BridgeAPIAuthGoogleConfig;
begin
 result:= FConfig;
end;

constructor TD2BridgeAPIAuthGoogle.Create;
begin
 FConfig:= TD2BridgeAPIAuthGoogleConfig.Create;
end;

destructor TD2BridgeAPIAuthGoogle.Destroy;
begin
 (FConfig as TD2BridgeAPIAuthGoogleConfig).Destroy;

 inherited;
end;

function TD2BridgeAPIAuthGoogle.Login: ID2BridgeAPIAuthGoogleResponse;
var
 vGoogleResponse: TD2BridgeAPIAuthGoogleResponse;
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

  vRedirectURI:= vPrismSession.URI.URL + APIAuthCallBackGoogle;

  vURL := 'https://accounts.google.com/o/oauth2/auth';
  vURL := vURL + '?response_type=' + URIEncode('code');
  vURL := vURL + '&client_id='     + URIEncode(Config.ClientID);
  vURL := vURL + '&redirect_uri='  + vRedirectURI;
  vURL := vURL + '&scope='         + URIEncode(GoogleAuthScope);
  vURL := vURL + '&state='         + URIEncode(PrismSession.PushID);

  vPrismSession.Redirect(vURL, true);

  if vPrismSession.MessageDlg('Fazendo Login', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbCancel], 0, APIAuthLockName) = mrCancel then
  begin
   result:= TD2BridgeAPIAuthGoogleResponse.Create(false);
  end else
  begin
   if vPrismSession.URI.QueryParams.ValueFromKey('code') <> '' then
   begin
    vCode:= vPrismSession.URI.QueryParams.ValueFromKey('code');

    vHttp := TNetHTTPClient.Create(nil);
    vParams := Tstringlist.Create;
    vParams.Add('code=' + vCode);
    vParams.Add('client_id=' + Config.ClientID);
    vParams.Add('client_secret='+ Config.ClientSecret);
    vParams.Add('redirect_uri=' + vRedirectURI);
    vParams.Add('grant_type=authorization_code');

    vResponse := vhttp.Post('https://oauth2.googleapis.com/token', vParams);

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

     result:= TD2BridgeAPIAuthGoogleResponse.Create(false);

     exit;
    end;

    vparams.Clear;
    vparams.Add('access_token=' + vtoken);
    vResponse := vhttp.get ('https://www.googleapis.com/oauth2/v2/userinfo?'+'access_token=' + vtoken);
    if vResponse.StatusText='OK' then
    begin
     vResponseJSON := TJSONObject.ParseJSONValue(vResponse.ContentAsString) as TJSONObject;
     try
      result:= TD2BridgeAPIAuthGoogleResponse.Create(
       true,
       vResponseJSON.GetValue<string>('id'),
       vResponseJSON.GetValue<string>('name'),
       vResponseJSON.GetValue<string>('email'),
       vResponseJSON.GetValue<string>('picture')
      );
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

procedure TD2BridgeAPIAuthGoogle.Logout;
begin
 try
  PrismSession.Redirect('https://mail.google.com/mail/u/0/?logout&hl=ptBR',true);
 except
 end;
end;


end.

