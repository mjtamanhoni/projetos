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

{$I ..\D2Bridge.inc}

unit Prism.Server.HTML;

interface

uses
  System.SysUtils, System.Classes, System.Threading, System.JSON, System.Rtti,
{$IFDEF FMX}
  FMX.Forms, FMX.Dialogs,
{$ELSE}
  Vcl.Forms, Vcl.Dialogs,
{$ENDIF}
  Prism.Server.TCP, Prism.Server.Functions, Prism.Types;

type
  TPrismServerHTML = class(TDataModule)
  private
   FPrismServerFunctions: TPrismServerFunctions;
  public
   FFileD2BridgeLoader: string;
   FFileError500: string;
   FFileError429: string;
   FFileErrorBlackList: string;
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   function GetError500(ALanguage: string): string;
   function GetError429(ALanguage: string): string;
   function GetErrorBlackList(ALanguage: string): string;
   procedure GetFile(const APrismRequest: TPrismHTTPRequest; const AGetFileName: string; var AResponseFileName: string; var AResponseFileContent: string; var AResponseRedirect: string; var AMimeType: string);
   procedure GetHTML(APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var APrismWSContext: TPrismWebSocketContext);
   procedure RESTData(APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var APrismWSContext: TPrismWebSocketContext);
   procedure DownloadData(APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var APrismWSContext: TPrismWebSocketContext);
   function ReceiveMessage(AMessage: TPrismWebSocketMessage; PrismWSContext: TPrismWebSocketContext): string;
   procedure FinishedGetHTML(APrismWSContext: TPrismWebSocketContext);
  end;


implementation

uses
  Prism.Session, Prism.BaseClass, Prism.Util, Prism.URI, Prism.Cookie,
  D2Bridge.Forms, D2Bridge.BaseClass, Prism.Forms, Prism.Events, D2Bridge.Lang.Core, D2Bridge.Lang.Term,
  D2Bridge.Util,
  Prism.Interfaces, Prism.Session.Helper, Prism.Options.Security.Event,
  Winapi.ActiveX;

{$IFNDEF FMX}
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$ELSE}
{%CLASSGROUP 'FMX.Controls.TControl'}
{$ENDIF}

{$R *.dfm}

{ TPrismServerHTML }

constructor TPrismServerHTML.Create(AOwner: TComponent);
begin
 inherited;

 FPrismServerFunctions:= TPrismServerFunctions.Create(self);
end;

destructor TPrismServerHTML.Destroy;
begin
 FreeAndNil(FPrismServerFunctions);

 inherited;
end;

procedure TPrismServerHTML.DownloadData(APrismRequest: TPrismHTTPRequest;
  var APrismReponse: TPrismHTTPResponse;
  var APrismWSContext: TPrismWebSocketContext);
var
 vPrismSession: TPrismSession;
 vFileName: String;
begin
 if Assigned(APrismWSContext) and (APrismWSContext.Token <> '') and
    (APrismRequest.Header.QueryParams.Values['file'] <> '') and
    (APrismWSContext.PrismSessionUUID <> '') and PrismBaseClass.Sessions.Exist(APrismWSContext.PrismSessionUUID) then
 begin
  vPrismSession:= PrismBaseClass.Sessions.Item[APrismWSContext.PrismSessionUUID] as TPrismSession;

  if vPrismSession.FileDownloads.ContainsKey(APrismRequest.Header.QueryParams.Values['file']) then
  begin
   vFileName:= vPrismSession.FileDownloads[APrismRequest.Header.QueryParams.Values['file']];
   if FileExists(vFileName) then
   APrismReponse.FileName:= vFileName;
  end;

 end;
end;

procedure TPrismServerHTML.FinishedGetHTML(APrismWSContext: TPrismWebSocketContext);
var
 vPrismSession: IPrismSession;
begin
 if Assigned(APrismWSContext) and (APrismWSContext.Token <> '') then
 begin
  if APrismWSContext.Reloading then
  begin
   vPrismSession:= PrismBaseClass.Sessions.Item[APrismWSContext.PrismSessionUUID];
   if Assigned(vPrismSession) then
    TPrismSession(vPrismSession).SetReloading(false);
  end;
 end;
end;

function TPrismServerHTML.GetErrorBlackList(ALanguage: string): string;
var
 vTitle, vSubTitle1, vSubTitle2, vYourIP, vDelistIP, vMsgTimeOut, vMsgWrongIP,
 vMsgDelistSuccess, vMsgDelistFailed, vMsgDelistError, vMsgInvalidIp,
 vButtonOK: string;
begin
 vTitle:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.Title;
 vSubTitle1:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.SubTitle1;
 vSubTitle2:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.SubTitle2;
 vYourIP:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.YourIP;
 vDelistIP:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.DelistIP;
 vMsgTimeOut:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.MsgTimeOut;
 vMsgWrongIP:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.MsgWrongIP;
 vMsgDelistSuccess:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.MsgDelistSuccess;
 vMsgDelistFailed:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.MsgDelistFailed;
 vMsgDelistError:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.MsgDelistError;
 vMsgInvalidIp:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).ErrorBlackList.MsgInvalidIp;
 vButtonOK:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).MessageButton.ButtonOk;

 Result:= FFileErrorBlackList;

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,Title_}}',
   vTitle,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,SubTitle1_}}',
   vSubTitle1,
    [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,SubTitle2_}}',
   vSubTitle2,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,YourIP_}}',
   vYourIP,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,DelistIP_}}',
   vDelistIP,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,MsgTimeOut_}}',
   vMsgTimeOut,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,MsgWrongIP_}}',
   vMsgWrongIP,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,MsgDelistSuccess_}}',
   vMsgDelistSuccess,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,MsgDelistFailed_}}',
   vMsgDelistFailed,
   [rfReplaceAll, rfIgnoreCase]
  );


 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,MsgDelistError_}}',
   vMsgDelistError,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!ErrorBlacklist,MsgInvalidIp_}}',
   vMsgInvalidIp,
   [rfReplaceAll, rfIgnoreCase]
  );

 Result:=
  StringReplace(
   Result,
   '{{_d!MessageButton,ButtonOk_}}',
   vButtonOK,
   [rfReplaceAll, rfIgnoreCase]
  );


 if TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Language.IsRTL then
 begin
  Result:=
   StringReplace(
    Result,
    '{{RTL}}',
    'dir="rtl"',
    []);
 end else
 begin
  Result:=
   StringReplace(
    Result,
    '{{RTL}}',
    '',
    []);
 end;
end;

function TPrismServerHTML.GetError429(ALanguage: string): string;
var
 vError429Title, vError429Text1, vError429Text2: string;
begin
 vError429Title:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Error429.Title;
 vError429Text1:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Error429.Text1;
 vError429Text2:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Error429.Text2;

 Result:= FFileError429;

 Result:=
  StringReplace(
   Result,
   '{{_d!Error429,Title_}}',
   vError429Title,
   []);

 Result:=
  StringReplace(
   Result,
   '{{_d!Error429,Text1_}}',
   vError429Text1,
   []);

 Result:=
  StringReplace(
   Result,
   '{{_d!Error429,Text2_}}',
   vError429Text2,
   []);

 if TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Language.IsRTL then
 begin
  Result:=
   StringReplace(
    Result,
    '{{RTL}}',
    'dir="rtl"',
    []);
 end else
 begin
  Result:=
   StringReplace(
    Result,
    '{{RTL}}',
    '',
    []);
 end;
end;

function TPrismServerHTML.GetError500(ALanguage: string): string;
var
 vError500Title, vError500Text: string;
begin
 vError500Title:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Error500.Title;
 vError500Text:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Error500.Text;

 Result:= FFileError500;

 Result:=
  StringReplace(
   Result,
   '{{_d!Error500,Title_}}',
   vError500Title,
   []);

 Result:=
  StringReplace(
   Result,
   '{{_d!Error500,Text_}}',
   vError500Text,
   []);

 if TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(ALanguage)).Language.IsRTL then
 begin
  Result:=
   StringReplace(
    Result,
    '{{RTL}}',
    'dir="rtl"',
    []);
 end else
 begin
  Result:=
   StringReplace(
    Result,
    '{{RTL}}',
    '',
    []);
 end;
end;

procedure TPrismServerHTML.GetFile(const APrismRequest: TPrismHTTPRequest; const AGetFileName: string; var AResponseFileName: string; var AResponseFileContent: string; var AResponseRedirect: string; var AMimeType: string);
var
 vLoadingWaitText: string;
begin
 if SameText(ExtractFileName(AGetFileName), 'd2bridgeloader.js') then
 begin
  vLoadingWaitText:= TD2BridgeTerm(D2BridgeLangCore.LangByBrowser(APrismRequest.Header.AcceptLanguage)).Loader.WaitText;

  AMimeType:= 'application/javascript';
  AResponseFileContent:= FFileD2BridgeLoader;

  AResponseFileContent:=
   StringReplace(
    AResponseFileContent,
    '{{_d!Loader,WaitText_}}',
    vLoadingWaitText,
    []);
 end;

 if SameText(ExtractFileName(AGetFileName), 'error500.html') then
 begin
  AMimeType:= 'text/html';
  AResponseFileContent:= GetError500(APrismRequest.Header.AcceptLanguage);
 end;

// if SameText(ExtractFileName(AGetFileName), 'font-awesome.min.css') then
// begin
//  AMimeType:= 'text/css';
//  AResponseFileContent:= font_awesome_css.HTMLDoc.Text;
// end;

// if SameText(ExtractFileName(AGetFileName), 'fontawesome.min.css') then
// begin
//  AMimeType:= 'text/css';
//  AResponseRedirect:= 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/fontawesome.min.css';
// end;

// if SameText(ExtractFileName(AGetFileName), 'fontawesome.min.js') then
// begin
//  AMimeType:= 'application/javascript';
//  AResponseRedirect:= 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/fontawesome.min.js';
// end;

 if SameText(ExtractFileName(AGetFileName), 'favicon.ico') then
 begin
  AMimeType:= 'image/x-icon';
  AResponseRedirect:= 'https://d2bridge.com.br/favicon.ico';
 end;

 if SameText(ExtractFileName(AGetFileName), 'bootstrap.bundle.min.js') then
 begin
  AResponseRedirect:= 'https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js';
 end;

  if SameText(ExtractFileName(AGetFileName), 'bootstrap.min.css') then
 begin
  AResponseRedirect:= 'https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css';
 end;

end;

procedure TPrismServerHTML.GetHTML(APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var APrismWSContext: TPrismWebSocketContext);
var
 vPrismSession: TPrismSession;
 _SessionID: String;
 I: integer;
 vBlockIPLimitConn, vBlockIPLimitSession: boolean;
begin
 vPrismSession:= nil;

 try
  if not Assigned(APrismWSContext) or
     (Assigned(APrismWSContext) and (APrismWSContext.Token = '')) or
     (Assigned(APrismWSContext) and ((not PrismBaseClass.Sessions.Exist(APrismWSContext.PrismSessionUUID)) or (PrismBaseClass.Sessions.Item[APrismWSContext.PrismSessionUUID].Token <> APrismWSContext.Token))) or
     (Assigned(APrismWSContext) and Assigned(APrismWSContext.PrismSession)) then
  begin
   if PrismBaseClass.Options.Security.Enabled then
   begin
    APrismRequest.Header.TooManyConnFromIP:= not PrismBaseClass.Options.Security.IP.IPConnections.IsIPAllowed(APrismRequest.Header.ClientIP, vBlockIPLimitConn, vBlockIPLimitSession);

    if vBlockIPLimitConn then
     EventBlockIPLimitConn(APrismRequest.Header.ClientIP, APrismRequest.Header.UserAgent);
    if vBlockIPLimitSession then
     EventBlockIPLimitSession(APrismRequest.Header.ClientIP, APrismRequest.Header.UserAgent);
   end;

   if not APrismRequest.Header.TooManyConnFromIP then
   begin
    vPrismSession:= TPrismSession.Create(PrismBaseClass);

    vPrismSession.URI.Raw:= APrismRequest.Header.FullURL;
    vPrismSession.URI.URL:= APrismRequest.Header.URL;
    vPrismSession.URI.Host:= APrismRequest.Header.Host;
    vPrismSession.URI.ServerPort:= APrismRequest.Header.ServerPort;
    //vPrismSession.URI.Protocol:= APrismRequest.Header.

    //CooKies
    TPrismCookies(vPrismSession.Cookies).SetRawCookies(APrismRequest.Header.Cookies);
    TPrismCookies(vPrismSession.Cookies).Refresh;

    vPrismSession.URI.QueryParams.Update(APrismRequest.Header.QueryParams);
  //  for I := 0 to Pred(APrismRequest.Header.QueryParams.Count) do
  //  with vPrismSession.URI.QueryParams.Add do
  //  begin
  //   Key:= APrismRequest.Header.QueryParams.Names[I];
  //   Value:= APrismRequest.Header.QueryParams.ValueFromIndex[I];
  //  end;

    PrismBaseClass.Sessions.Add(vPrismSession);
    vPrismSession.InfoConnection.IP:= APrismRequest.Header.ClientIP;
    vPrismSession.InfoConnection.UserAgent:= APrismRequest.Header.UserAgent;

    if Assigned(APrismWSContext) then
    begin
     APrismWSContext.Token:= vPrismSession.Token;
     APrismWSContext.PrismSessionUUID:= vPrismSession.UUID;
     APrismWSContext.PrismSession:= vPrismSession;
    end;

    vPrismSession.FormatSettings:= TFormatSettings.Create(FirstLangByBrowser(APrismRequest.Header.AcceptLanguage));
    vPrismSession.LanguageNav:= D2BridgeLangCore.LangByBrowser(APrismRequest.Header.AcceptLanguage).Language.D2BridgeLang;

    //PrismBaseClass.InstancePrimaryForm(vPrismSession);

    try
     vPrismSession.ExecThread(true,
      procedure(Arg1, Arg2, Arg3: TValue)
      var
       vAPrismRequest: TPrismHTTPRequest;
       vAPrismReponse: TPrismHTTPResponse;
       vAPrismSession: TPrismSession;
      begin
       vAPrismRequest:= (Arg1.AsObject as TPrismHTTPRequest);
       vAPrismReponse:= (Arg2.AsObject as TPrismHTTPResponse);
       vAPrismSession:= (Arg3.AsObject as TPrismSession);

       if PrismBaseClass.Options.CoInitialize then
        CoInitializeEx(0, COINIT_MULTITHREADED);

       try
        TPrismBaseClass(PrismBaseClass).DoNewSession(vAPrismRequest, vAPrismReponse, vAPrismSession);
       except
        on E: Exception do
        begin
         try
          vAPrismSession.DoException(self as TObject, E, 'OnNewSession');
         except
         end;
        end;
       end;

       try
        PrismBaseClass.InstancePrimaryForm(vAPrismSession);
       except
        on E: Exception do
        begin
         try
          vAPrismSession.DoException(self as TObject, E, 'InstancePrimaryForm');
          vAPrismSession.Close;
         except
         end;
         abort;
        end;
       end;
      end,
      TValue.From<TPrismHTTPRequest>(APrismRequest),
      TValue.From<TPrismHTTPResponse>(APrismReponse),
      TValue.From<TPrismSession>(vPrismSession)
    );
    except
     abort;
    end;
   end else
   begin
    exit;
   end;
  end;

  if not Assigned(vPrismSession) then
   vPrismSession:= (PrismBaseClass.Sessions.Item[APrismWSContext.PrismSessionUUID] as TPrismSession);

  if Assigned(vPrismSession) and (not vPrismSession.Closing) then
  begin
   //Set Raw CooKies (not Update)
   TPrismCookies(vPrismSession.Cookies).SetRawCookies(APrismRequest.Header.Cookies);

 // vPrismSession.ExecThread(true,
 //   procedure
 //   begin
     TD2BridgeForm(TD2BridgeClass(vPrismSession.D2BridgeBaseClassActive).FormAOwner).Clear;
     TD2BridgeForm(TD2BridgeClass(vPrismSession.D2BridgeBaseClassActive).FormAOwner).Render;
 //   end
 // );


   TPrismBaseClass(PrismBaseClass).PrismServerHTMLHeaders.LoadPageHTMLFromSession(APrismRequest, APrismReponse, vPrismSession);
  end;
 except
 end;

end;

function TPrismServerHTML.ReceiveMessage(AMessage: TPrismWebSocketMessage; PrismWSContext: TPrismWebSocketContext): string;
var
 vIdleInSecounds: Integer;
begin
 if AMessage.IsFormatted then
 begin
  if AMessage.MessageType = wsMsgHeartbeat then
  begin
   if Assigned(PrismWSContext.PrismSession) and
      (not PrismWSContext.PrismSession.Closing) then
   begin
    TPrismSession(PrismWSContext.PrismSession).DoHeartBeat;
    if TryStrToInt(AMessage.Parameters['IdleInSeconds'], vIdleInSecounds) then
     TPrismSession(PrismWSContext.PrismSession).SetIdleSeconds(vIdleInSecounds);
   end;
  end else
  if AMessage.MessageType = wsMsgProcedure then
  begin
   {$REGION 'ExecEvent'}
    if SameText(AMessage.Name, 'ExecEvent') then
    begin
     FPrismServerFunctions.ExecEvent
      (
        AMessage.Parameters['UUID'],
        AMessage.Parameters['Token'],
        AMessage.Parameters['FormUUID'],
        AMessage.Parameters['ID'],
        AMessage.Parameters['EventID'],
        AMessage.Parameters['Parameters'],
        SameText(AMessage.Parameters['LockClient'],'true')
      );
    end;
   {$ENDREGION}
  end else
  if AMessage.MessageType = wsMsgFunction then
  begin
   {$REGION 'CallBack'}
    if SameText(AMessage.Name, 'CallBack') then
    begin
     FPrismServerFunctions.CallBack
      (
        AMessage.Parameters['UUID'],
        AMessage.Parameters['Token'],
        AMessage.Parameters['FormUUID'],
        AMessage.Parameters['CallBackID'],
        AMessage.Parameters['Parameters'],
        SameText(AMessage.Parameters['LockClient'],'true')
      );
    end;
   {$ENDREGION}

   {$REGION 'GetFromEvent'}
    if SameText(AMessage.Name, 'GetFromEvent') then
    begin
     Result:=
     FPrismServerFunctions.GetFromEvent
      (
        AMessage.Parameters['UUID'],
        AMessage.Parameters['Token'],
        AMessage.Parameters['FormUUID'],
        AMessage.Parameters['ID'],
        AMessage.Parameters['EventID'],
        AMessage.Parameters['Parameters'],
        SameText(AMessage.Parameters['LockClient'],'true')
      );
    end;
   {$ENDREGION}

  end;
 end;
end;

procedure TPrismServerHTML.RESTData(APrismRequest: TPrismHTTPRequest;
  var APrismReponse: TPrismHTTPResponse;
  var APrismWSContext: TPrismWebSocketContext);
var
 vPrismSession: TPrismSession;
 PrismForm: TPrismForm;
 FEvent: TPrismControlEvent;
 EventID, ResulThread: string;
 ParametersString: TStrings;
 ARowID, AErrorMessage: String;
 ResultErrorJSON: TJSONObject;
 I, Z: integer;
begin
 if Assigned(APrismWSContext) and (APrismWSContext.Token <> '') and
    (APrismWSContext.FormUUID <> '') and (APrismRequest.Header.QueryParams.Values['eventid'] <> '') and
    (APrismWSContext.PrismSessionUUID <> '') and PrismBaseClass.Sessions.Exist(APrismWSContext.PrismSessionUUID) then
 begin
  vPrismSession:= PrismBaseClass.Sessions.Item[APrismWSContext.PrismSessionUUID] as TPrismSession;
  PrismForm:= TPrismForm(vPrismSession.ActiveFormByFormUUID(APrismWSContext.FormUUID));
  EventID:= APrismRequest.Header.QueryParams.Values['eventid'];
  ParametersString:= TStringList.Create;
  ParametersString.Text:= APrismRequest.Header.QueryParams.Text;

  if vPrismSession.Token = APrismWSContext.Token then
  begin
   for I := 0 to PrismForm.Controls.Count - 1 do
   begin
    for Z := 0 to PrismForm.Controls[I].Events.Count-1 do
    begin
     if PrismForm.Controls[I].Events.Item(Z).EventID = EventID then
     begin
      FEvent:= (PrismForm.Controls[I].Events.Item(Z) as TPrismControlEvent);
      Break;
     end;
     if FEvent <> nil then
     Break;
    end;
   end;

   if Assigned(FEvent) then
   begin
    if Supports(FEvent.PrismControl, IPrismGrid) then
    begin
     if (FEvent.EventType = EventOnLoadJSON) then
     begin
      ResulThread:= FEvent.CallEventResponse(ParametersString);

      APrismReponse.Content:= ResulThread;
      APrismReponse.ContentType:= 'application/json';
     end else
     if (FEvent.EventType = EventOnCellPost) then
     begin
      if (APrismRequest.Header.Content <> '') and (IsJSONValid(APrismRequest.Header.Content)) then
      begin
{$IFNDEF FMX}
       if FEvent.PrismControl.IsDBGrid then
        FEvent.PrismControl.AsDBGrid.CellPostbyJSON(APrismRequest.Header.Content, ARowID, AErrorMessage)
       else
{$ENDIF}
        FEvent.PrismControl.AsStringGrid.CellPostbyJSON(APrismRequest.Header.Content, ARowID, AErrorMessage);

       ResultErrorJSON:= TJSONObject.Create;

       if AErrorMessage <> '' then
       begin
        APrismReponse.Error:= true;
        APrismReponse.ErrorMessage:= AErrorMessage;
        APrismReponse.StatusCode:= '404';

//       APrismReponse.Content:= '{ result : "OK" }';
//       APrismReponse.ContentType:= 'application/json';

        ResultErrorJSON.AddPair('status', 'error');
        ResultErrorJSON.AddPair('errormessage', AErrorMessage);
        ResultErrorJSON.AddPair('rowid', ARowID);
       end else
       begin
        ResultErrorJSON.AddPair('status', 'ok');
        ResultErrorJSON.AddPair('errormessage', '');
        ResultErrorJSON.AddPair('rowid', ARowID);
       end;

       APrismReponse.Content:= ResultErrorJSON.ToJSON;

       ResultErrorJSON.Free;
      end;

     end;
    end;
   end;
  end;

  ParametersString.Free;
 end;
end;

end.
