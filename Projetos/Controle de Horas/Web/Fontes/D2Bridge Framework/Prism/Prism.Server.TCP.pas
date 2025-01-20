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

unit Prism.Server.TCP;

interface

uses
  System.SysUtils, System.Classes, System.Hash, System.DateUtils, System.Generics.Collections,
  System.JSON,
{$IFDEF MSWINDOWS}
  WinApi.Windows,
{$ENDIF}
  IdCustomTCPServer, IdCustomHTTPServer, IdContext, IdSSL, IdSSLOpenSSL, IdURI, IdCoderMIME,
  IdHashSHA, IdGlobal, IdIOHandler,
  Prism.WebSocketContext, Prism.Server.HTTP.Commom, Prism.Types, Prism.Util, Prism.Interfaces,
  Prism.Session.Thread.Proc;



type
 TIdContext = IdContext.TIdContext;
 TPrismHTTPRequest = Prism.Server.HTTP.Commom.TPrismHTTPRequest;
 TPrismHTTPResponse = Prism.Server.HTTP.Commom.TPrismHTTPResponse;
 TPrismWebSocketContext = Prism.WebSocketContext.TPrismWebSocketContext;
 TPrismWebSocketMessage = Prism.Server.HTTP.Commom.TPrismWebSocketMessage;

 TStreamFileStatus = (SFSNone, SFSWaitingFile, SFSCreateFile, SFSWriteFile, SFSEndFile);

 TOnGetHTML = procedure(APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var APrismWSContext: TPrismWebSocketContext) of object;
 TOnRESTData = procedure(APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var APrismWSContext: TPrismWebSocketContext) of object;
 TOnDownloadData = procedure(APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var APrismWSContext: TPrismWebSocketContext) of object;
 TOnFinishedGetHTML = procedure(APrismWSContext: TPrismWebSocketContext) of object;
 TOnGetFile = procedure(const APrismRequest: TPrismHTTPRequest; const AGetFileName: string; var AResponseFileName: string; var AResponseFileContent: string; var AResponseRedirect: string; var AMimeType: string) of object;
 TOnReceiveMessage = function(AMessage: TPrismWebSocketMessage; PrismWSContext: TPrismWebSocketContext): string of object;


type
  TPrismServerTCP = class(TIdCustomTCPServer)
  private
   FOnGetHTML: TOnGetHTML;
   FOnReceiveMessage: TOnReceiveMessage;
   FOnGetFile: TOnGetFile;
   FOnFinishedGetHTML: TOnFinishedGetHTML;
   FOnRESTData: TOnRESTData;
   FOnDownloadData: TOnDownloadData;
   IdServerIOHandlerSSLOpenSSL: TIdServerIOHandlerSSLOpenSSL;
   FRootDirectory: string;
   FMimesType: TPrismServerFileExtensions;
   FVirtualPath: string;
   function MimesType: TPrismServerFileExtensions;
   function ParseHeaders(AContext: TIdContext; const AHTMLHeader: string): TPrismHTTPHeader;
   procedure InterceptExecute(AContext: TIdContext);
   procedure DoGetHTML(AContext: TIdContext; APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var PrismWSContext: TPrismWebSocketContext); virtual;
   procedure DoDownloadData(AContext: TIdContext; APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var PrismWSContext: TPrismWebSocketContext); virtual;
   procedure DoRESTData(AContext: TIdContext; APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var PrismWSContext: TPrismWebSocketContext); virtual;
   procedure DoFinishedGetHTML(APrismWSContext: TPrismWebSocketContext);
   function DoReceiveMessage(AMessage: string; PrismWSContext: TPrismWebSocketContext): string; virtual;
   procedure DoUploadFile(AFiles: TStrings; PrismSession: IPrismSession; AFormUUID: string; Sender: TObject);
   function FormatReceivedMesssage(AMessage: string): TPrismWebSocketMessage;
   procedure ReadMultipartFormData(IOHandler: TIdIOHandler; Boundary: String; ContentLength: Integer; PrismWSContext: TPrismWebSocketContext);
   function ReadBodyStringFromData(IOHandler: TIdIOHandler; ContentLength: Integer): string;
   function ReadBodyStreamFromData(IOHandler: TIdIOHandler; ContentLength: Integer): TMemoryStream;
   procedure RemoveEscapeFromFileURL(var vFileName: string);
   procedure InsertEscapeToFileURL(var vFileName: string);
  protected
{$IFDEF D2BRIDGE}
   procedure DoConnect(AContext: TIdContext); override;
   procedure DoDisconnect(AContext: TIdContext); override;
   function DoExecute(AContext: TIdContext): Boolean; override;
{$ENDIF}
  public
   const
   FpathWebSocket = '/websocket';
   FpathRESTServer = '/rest';
   FpathDownload = '/d2bridge/download';
   FpathUpload = '/d2bridge/upload';
   Fhtmlconnectiontimeout = 64000;
   Fhtmlconnectionmax = 0;
   fServerName = 'PrismServer with D2Bridge Framework Server';
   constructor Create;
   destructor Destroy; override;

   procedure SendWebSocketMessage(AMessage: string; APrismSession: IPrismSession);
   procedure DisconnectWebSocketMessage(APrismSession: IPrismSession; NilPrismSession: Boolean = false);
   procedure CloseAllConnection;
   procedure InitSSL(AIdServerIOHandlerSSLOpenSSL: TIdServerIOHandlerSSLOpenSSL);

   function OpenSSL: TIdServerIOHandlerSSLOpenSSL;

   property OnGetHTML: TOnGetHTML read FOnGetHTML write FOnGetHTML;
   property OnGetFile: TOnGetFile read FOnGetFile write FOnGetFile;
   property OnFinishedGetHTML: TOnFinishedGetHTML read FOnFinishedGetHTML write FOnFinishedGetHTML;
   property OnReceiveMessage: TOnReceiveMessage read FOnReceiveMessage write FOnReceiveMessage;
   property OnRESTData: TOnRestData read FOnRestData write FOnRestData;
   property OnDownloadData: TOnDownloadData read FOnDownloadData write FOnDownloadData;
   property RootDirectory: string read FRootDirectory write FRootDirectory;
   property VirtualPath: string read FVirtualPath write FVirtualPath;
   //property OnCommandGet;
   //property OnExecute;
  end;


type
  TWebSocketIOHandlerHelper = class(TIdIOHandler)
  public
    function ReadBytes: TArray<byte>;
    function ReadString: string;

    procedure WriteBytes(RawData: TArray<byte>);
    procedure WriteString(const str: string);
  end;


const
 URLInternalAPI = '/d2bridge/api';
 URLAPIAuth = URLInternalAPI + '/auth';

var
  PrismServer: TPrismServerTCP;

implementation

uses
  Prism.BaseClass, Prism.Session, Prism.Session.Helper, Prism.Options.Security.Event,
  D2Bridge.Lang.Core, D2Bridge.API.Auth,
  System.Rtti, IdTCPConnection;


{ TPrismServerTCP }




procedure TPrismServerTCP.CloseAllConnection;
var
 Clients: TList;
 I: Integer;
begin
 if self <> nil then
 begin
  if (Contexts = nil) and (not Assigned(Contexts)) then
  exit;

  Clients := Contexts.LockList;

  try
    for i := 0 to Clients.Count - 1 do
       TIdContext(Clients[i]).Connection.Disconnect;
  finally
   Contexts.UnlockList;
  end;
 end;
end;

constructor TPrismServerTCP.Create;
begin
  inherited Create;

  FMimesType:= TPrismServerFileExtensions.Create;

  IdServerIOHandlerSSLOpenSSL := nil;

  FRootDirectory:= 'wwwroot\';
  FVirtualPath:= '/';


  OnExecute := InterceptExecute;

  //OnCommandGet:= CommandGetEvent;
end;

destructor TPrismServerTCP.Destroy;
begin
 FreeAndNil(FMimesType);

 inherited;
end;

procedure TPrismServerTCP.DisconnectWebSocketMessage(APrismSession: IPrismSession; NilPrismSession: Boolean = false);
var
 vContext: TIdContext;
begin

 try
  vContext:= (APrismSession as TPrismSession).WebSocketContext;

  if Assigned(vContext) then
   if Assigned(vContext.Connection) then
    if Assigned(vContext.Connection.IOHandler) then
     if vContext.Connection.Connected then
      if (vContext.Data is TPrismWebSocketContext) then
      begin
       (APrismSession as TPrismSession).WebSocketContext:= nil;
       vContext.Connection.Disconnect(true);
      end;
  except
  end;
end;

//procedure TPrismServerTCP.DoCommandGet(AContext: TIdContext;
//  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
//begin
// inherited;
//
//// if ARequestInfo.Document = '/' then
// var a:= '';
//
//end;

{$IFDEF D2BRIDGE}
procedure TPrismServerTCP.DoConnect(AContext: TIdContext);
var
 URLPath: string;
 URI: TIdURI;
 Params: TStrings;
begin
 if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then
 begin
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough := false;
 end;

// URLPath := AContext.Connection.IOHandler.ReadLn;
// URLPath:= Copy(URLPath, AnsiPos('/', URLPath));
// URLPath:= Copy(URLPath, 1, AnsiPos(' ', URLPath)-1);
//
//
// //'GET / HTTP/1.1'
//
// if URLPath = '/ws' then
// begin
//  URI := TIdURI.Create(URLPath);
//  Params:= TStringList.Create;
//  try
//   Params.LineBreak:= '&';
//   Params.Text := URI.Params;
//
// if not Assigned(AContext.Data) then
//  AContext.Data:= TPrismWebSocketContext.Create;
//    (
//      Params.Values['token'],
//      Params.Values['channelname'],
//      Params.Values['prismsession'],
//      Params.Values['formuuid']
//    );
//
//  finally
//   URI.Free;
//   Params.Free;
//  end;
// end;

 inherited;
end;


procedure TPrismServerTCP.DoDisconnect(AContext: TIdContext);
begin
 if Assigned(AContext.Data) and
    (AContext.Data is TPrismWebSocketContext) then
 begin
  TPrismWebSocketContext(AContext.Data).Established:= false;

  if Assigned(TPrismWebSocketContext(AContext.Data).PrismSession) then
  begin
   try
    if Assigned((TPrismWebSocketContext(AContext.Data).PrismSession as TPrismSession).WebSocketContext) then
    begin
     if (TPrismWebSocketContext(AContext.Data).PrismSession as TPrismSession).WebSocketContext = AContext then
     begin
      (TPrismWebSocketContext(AContext.Data).PrismSession as TPrismSession).WebSocketContext:= nil;
      PrismBaseClass.ServerController.DoSessionChange(scsLostConnectioSession, TPrismWebSocketContext(AContext.Data).PrismSession);
     end;
    end else
     PrismBaseClass.ServerController.DoSessionChange(scsLostConnectioSession, TPrismWebSocketContext(AContext.Data).PrismSession);
   except
   end;
  end;
 end;

 inherited;
end;


function TPrismServerTCP.DoExecute(AContext: TIdContext): Boolean;
var
  c: TIdIOHandler;
  PrismWSContext: TPrismWebSocketContext;
  SecWebSocketKey, Hash: string;
  vHeader: TPrismHTTPHeader;
  vPrismRequest: TPrismHTTPRequest;
  vPrismResponse: TPrismHTTPResponse;
  RequestLine, Headers, Line: string;
  vPrismSession: TPrismSession;
  vFileName: String;
  ContentLength: integer;
  vResponseFileName, vResponseFileContent, vResponseRedirect, vResponseContent, vMimeType: string;
  vCloseConnection: boolean;
  vProc: TPrismSessionThreadProc;
  vIsProc: Boolean;
  vJSON: TJSONObject;
  vPOSTStrContent: string;
  vPageError403BlackList: string;
  vContentLength: Integer;
begin
 result:= false;
 vIsProc:= false;

 try
  c := AContext.Connection.IOHandler;
 except
  Result:= false;
  exit;
 end;

 InterceptExecute(AContext);

 RequestLine := '';
 //c.CheckForDataOnSource(10);
 vCloseConnection:= true;

 if (c.Tag <> 99) and (AContext.Connection.Connected) then
 begin
  RequestLine := AContext.Connection.IOHandler.ReadLn;
 end;


 if RequestLine <> '' then
 begin
  // Read string and parse HTTP headers

  c.Tag:= 99;

  try
   Headers := RequestLine + sLineBreak;
   repeat
    Line := AContext.Connection.IOHandler.ReadLn;
    Headers := Headers + Line + sLineBreak;

      if AContext.Connection <> nil then
        if AContext.Connection.Connected then
         AContext.Connection.IOHandler.Connected

   until (Headers = sLineBreak) or (Line = '') or
         (AContext.Connection = nil) or
         (not AContext.Connection.Connected) or
         (not Assigned(AContext.Connection.IOHandler)) or
         (not AContext.Connection.IOHandler.Connected)
  except
  end;

  vHeader:= ParseHeaders(AContext, Headers);


  if (vHeader.IPListedInBlackList)  then  //BlackList
  begin
   if (vHeader.WebMethod = wmtPOST) and
      (PrismBaseClass.Options.Security.IP.IPv4BlackList.EnableSelfDelist) and
      (not vHeader.UserAgentBlocked) and
      (AnsiPos('/security/blacklist/delist', vHeader.Path) > 0) and
      (vHeader.ContentType = 'application/json') and
      (TryStrToInt(vHeader.ContentLength, vContentLength)) and
      (PrismBaseClass.Options.Security.IP.IPConnections.IsIPAllowed(vHeader.ClientIP)) then
   begin
    try
     vPOSTStrContent:= ReadBodyStringFromData(c, vContentLength);

     if (IsJSONValid(vPOSTStrContent)) then
      vJSON:= TJSONObject.ParseJSONValue(vPOSTStrContent) as TJSONObject;

     if Assigned(vJSON) and PrismBaseClass.Options.Security.IP.IPv4BlackList.IsValidTokenDelist(vHeader.ClientIP, vJSON, true) then
     begin
      EventDelistIPBlackList(vHeader.ClientIP, vHeader.UserAgent);

      PrismBaseClass.Options.Security.IP.IPv4WhiteList.Add(vHeader.ClientIP);

      vResponseContent:= '{"success" : true, "message" : "Delist Ok"}';
      c.WriteLn('HTTP/1.1 200 OK');
      c.WriteLn('Server: '+fServerName);
      c.WriteLn('Content-Type: application/json; charset=UTF-8');
      c.WriteLn('Content-Length: ' + IntToStr(Length(vResponseContent)));
      c.WriteLn('Connection: Close');
      c.WriteLn('');
      c.Write(vResponseContent, IndyTextEncoding_UTF8);
     end else
     begin
      EventNotDelistIPBlackList(vHeader.ClientIP, vHeader.UserAgent);

      vResponseContent:= '{success: false, message: "Invalid token or request not allowed"}';
      c.WriteLn('HTTP/1.1 403 Forbidden');
      c.WriteLn('Server: '+fServerName);
      c.WriteLn('Content-Type: application/json; charset=UTF-8');
      c.WriteLn('Content-Length: ' + IntToStr(Length(vResponseContent)));
      c.WriteLn('Connection: Close');
      c.WriteLn('');
      c.WriteLn(vResponseContent, IndyTextEncoding_UTF8);
     end;
    except
    end;
    vJSON.Free;
   end else
   if (vHeader.WebMethod = wmtGET) and
      (PrismBaseClass.Options.Security.IP.IPv4BlackList.EnableSelfDelist) and
      (not vHeader.UserAgentBlocked) and
      ((vHeader.Path = '/') or (vHeader.Path = '') or (Copy(vHeader.Path, 1,2) = '/?') or (vHeader.Path = VirtualPath)) and
      (PrismBaseClass.Options.Security.IP.IPConnections.IsIPAllowed(vHeader.ClientIP)) then
   begin
    EventBlockIPBlackList(vHeader.ClientIP, vHeader.UserAgent);

    vPageError403BlackList:= PrismBaseClass.PrismServerHTML.GetErrorBlackList(vHeader.AcceptLanguage);
    vPageError403BlackList:= StringReplace(vPageError403BlackList, '{{ip}}', vHeader.ClientIP, [rfReplaceAll]);
    vPageError403BlackList:= StringReplace(vPageError403BlackList, '{{token}}', PrismBaseClass.Options.Security.IP.IPv4BlackList.CreateTokenDelist(vHeader.ClientIP), [rfReplaceAll]);

    c.WriteLn('HTTP/1.1 403 Forbidden');
    c.WriteLn('Content-Type: text/html; charset=UTF-8');
    //c.WriteLn('Content-Length: ' + IntToStr(IndyLength(vPageError403BlackList)));
    c.WriteLn('');
    c.Write(vPageError403BlackList, IndyTextEncoding_UTF8);
   end else
   begin
    EventBlockIPBlackList(vHeader.ClientIP, vHeader.UserAgent);

    c.WriteLn('HTTP/1.1 403 Forbidden');
    c.WriteLn('Content-Type: text/plain');
    c.WriteLn('');
    c.WriteLn('D2Bridge Framework Application');
    c.WriteLn('Access Denied');
    c.Write('Your IP ' + vHeader.ClientIP + ' listed in BlackList');
   end;

   vHeader.Free;

   AContext.Connection.Disconnect;
  end else
  if (vHeader.UserAgentBlocked)  then
  begin
   EventBlockUserAgent(vHeader.ClientIP, vHeader.UserAgent);

   c.WriteLn('HTTP/1.1 451 Unavailable For Legal Reasons');
   c.WriteLn('Content-Type: text/plain');
   c.WriteLn('');
   c.WriteLn('Blocked by User-Agent Policy');

   vHeader.Free;

   AContext.Connection.Disconnect;
  end else
  if (vHeader.Purpose = 'prefetch')  then
  begin
   c.WriteLn('HTTP/1.1 204 Found');
   c.WriteLn('Connection: Close');
   c.WriteLn('');

   vHeader.Free;

   AContext.Connection.Disconnect;
  end else
  if (vHeader.WebMethod = wmtHEAD) and (AnsiPos('reconnect?token=', vHeader.Path) > 0)  then
  begin
   if PrismBaseClass.Sessions.Exist(vHeader.QueryParams.Values['prismsession'], vHeader.QueryParams.Values['token']) then
   begin
    c.WriteLn('HTTP/1.1 202 Accepted');
    c.WriteLn('Connection: Close');
    c.WriteLn('Server: '+fServerName);
    c.WriteLn('');
   end else
   begin
    c.WriteLn('HTTP/1.1 401 Unauthorized');
    c.WriteLn('Connection: Close');
    c.WriteLn('Server: '+fServerName);
    c.WriteLn('');
   end;

   AContext.Connection.Disconnect;
  end else
  if (AnsiPos(FpathUpload, vHeader.Path) > 0) or (vHeader.IsUploadFile) then
  begin
   if (vHeader.Boundary <> '') and TryStrToInt(vHeader.ContentLength, ContentLength) and (ContentLength > 0)  then
   begin
    PrismWSContext := TPrismWebSocketContext.Create;

    PrismWSContext.Token := vHeader.QueryParams.Values['token'];
    PrismWSContext.ChannelName := vHeader.QueryParams.Values['channelname'];
    PrismWSContext.PrismSessionUUID := vHeader.QueryParams.Values['prismsession'];
    PrismWSContext.FormUUID := vHeader.QueryParams.Values['formuuid'];

    if (PrismWSContext.PrismSessionUUID <> '') and
       (PrismWSContext.FormUUID <> '') and
       (PrismWSContext.Token <> '') then
    begin
     if PrismBaseClass.Sessions.Exist(PrismWSContext.PrismSessionUUID) then
     begin
      vPrismSession:= PrismBaseClass.Sessions.Item[PrismWSContext.PrismSessionUUID] as TPrismSession;

      if vPrismSession.Token = PrismWSContext.Token then
      begin
       PrismWSContext.PrismSession:= vPrismSession;

       ReadMultipartFormData(c, vHeader.Boundary, ContentLength, PrismWSContext);

       c.WriteLn('HTTP/1.1 200 OK');
       c.WriteLn('Connection: Close');
       c.WriteLn('Server: '+fServerName);
       c.WriteLn('');
      end;
     end;
    end;

    FreeAndNil(PrismWSContext);
   end;

   AContext.Connection.Disconnect;
  end else
  if (AnsiPos(FpathDownload+'?file=', vHeader.Path) > 0) then
  begin
   vPrismRequest:= TPrismHTTPRequest.Create;
   vPrismRequest.Header:= vHeader;
   vPrismResponse:= TPrismHTTPResponse.Create;

   if not Assigned(AContext.Data) then
    AContext.Data:= TPrismWebSocketContext.Create;
   PrismWSContext := TPrismWebSocketContext(AContext.Data);

   PrismWSContext.Token := vHeader.QueryParams.Values['token'];
   PrismWSContext.ChannelName := vHeader.QueryParams.Values['channelname'];
   PrismWSContext.PrismSessionUUID := vHeader.QueryParams.Values['prismsession'];
   PrismWSContext.FormUUID := vHeader.QueryParams.Values['FormUUID'];

   DoDownloadData(AContext, vPrismRequest, vPrismResponse, PrismWSContext);

   if vPrismResponse.FileName <> '' then
   begin
    vFileName:= ExtractFileName(vPrismResponse.FileName);

    c.WriteLn('HTTP/1.1 ' + vPrismResponse.StatusCode);
    c.WriteLn('Content-Type: '+MimesType.GetMimeType(vFileName)+'; charset='+vPrismResponse.charset);
    c.WriteLn('Content-Disposition: attachment; filename="'+ExtractFileName(vFileName)+'"');
    c.WriteLn('Connection: Close');
    c.WriteLn('Server: '+fServerName);
    c.WriteLn('');

    c.WriteFile(vPrismResponse.FileName);
   end;

   FreeAndNil(vPrismRequest);
   FreeAndNil(vPrismResponse);

   AContext.Connection.Disconnect;
  end else
  if (AnsiPos(FpathRESTServer+'/json/jqgrid/post', vHeader.Path) > 0) then
  begin
   vPrismRequest:= TPrismHTTPRequest.Create;
   vPrismRequest.Header:= vHeader;
   vPrismResponse:= TPrismHTTPResponse.Create;

   if not Assigned(AContext.Data) then
    AContext.Data:= TPrismWebSocketContext.Create;
   PrismWSContext := TPrismWebSocketContext(AContext.Data);

   PrismWSContext.Token := vHeader.QueryParams.Values['token'];
   PrismWSContext.ChannelName := vHeader.QueryParams.Values['channelname'];
   PrismWSContext.PrismSessionUUID := vHeader.QueryParams.Values['prismsession'];
   PrismWSContext.FormUUID := vHeader.QueryParams.Values['FormUUID'];

   DoRESTData(AContext, vPrismRequest, vPrismResponse, PrismWSContext);

   if (vPrismResponse.Content <> '') or
      ((AnsiPos(FpathRESTServer+'/json/jqgrid/post', vHeader.Path) > 0) and (not vPrismResponse.Error)) then
   begin
    c.WriteLn('HTTP/1.1 ' + vPrismResponse.StatusCode);
    c.WriteLn('Content-Type: '+vPrismResponse.ContentType+'; charset='+vPrismResponse.charset);
    c.WriteLn('Connection: Close');
    c.WriteLn('Server: '+fServerName);
    c.WriteLn('');

    if vPrismResponse.Content <> '' then
    C.Write(vPrismResponse.Content, IndyTextEncoding_UTF8);
   end;

   FreeAndNil(vPrismRequest);
   FreeAndNil(vPrismResponse);

   AContext.Connection.Disconnect;
  end else
  if (AnsiPos(URLAPIAuth, vHeader.Path) > 0) then  //Auth
  begin
   vProc:= TPrismSessionThreadProc.Create(nil,
    Procedure(AAContext, AHeader, var3, var4: TValue)
    var
     xIOHandle: TIdIOHandler;
     xContext: TIdContext;
     xHeader: TPrismHTTPHeader;
     xContentLength: integer;
    begin
     try
      xContext:= TIdContext(AAContext.AsObject);
      if xContext.Connection = nil then
       exit;
      xIOHandle:= xContext.Connection.IOHandler;
      xHeader:= TPrismHTTPHeader(AHeader.AsObject);

      //Process Auth
      if (AnsiPos(URLAPIAuth + '/google', xHeader.Path) > 0) then
      begin
       {$REGION 'Google'}
        if vHeader.QueryParams.Values['state'] <> '' then
        begin
         vPrismSession:= PrismBaseClass.Sessions.FromPushID(vHeader.QueryParams.Values['state']) as TPrismSession;

         if Assigned(vPrismSession) then
         begin
          vPrismSession.UnLock(APIAuthLockName);
          vPrismSession.URI.QueryParams.Update(vHeader.QueryParams);
         end;
        end;
       {$ENDREGION}
      end else
      if (AnsiPos(URLAPIAuth + '/apple', xHeader.Path) > 0) then
      begin
       {$REGION 'Apple'}

       //Checar se PrismSession é valido

        if vHeader.WebMethod = wmtPOST then
        begin
          if TryStrToInt(xHeader.ContentLength, xContentLength) then
          begin
           //var MyBodyResponse: string := ReadBodyStringFromData(xIOHandle, xContentLength);
          end;
        end;
       {$ENDREGION}
      end;
      if (AnsiPos(URLAPIAuth + '/microsoft', xHeader.Path) > 0) then
      begin
       {$REGION 'Azure'}
        if vHeader.QueryParams.Values['state'] <> '' then
        begin
         vPrismSession:= PrismBaseClass.Sessions.FromPushID(xHeader.QueryParams.Values['state']) as TPrismSession;

         if Assigned(vPrismSession) then
         begin
          vPrismSession.UnLock(APIAuthLockName);
          vPrismSession.URI.QueryParams.Update(xHeader.QueryParams);
         end;
        end;

       {$ENDREGION}
      end;


      {$REGION 'Close Web Navigator'}
       xIOHandle.WriteLn('HTTP/1.1 200 OK');
       xIOHandle.WriteLn('Content-Type: text/html; charset=UTF-8');
       xIOHandle.WriteLn('Connection: Close');
       xIOHandle.WriteLn('Server: ' + fServerName);
       xIOHandle.WriteLn('');

       xIOHandle.WriteLn('<html>');
       xIOHandle.WriteLn('<head>');
       xIOHandle.WriteLn('<title>D2Bridger Framework</title>');
       xIOHandle.WriteLn('</head>');
       xIOHandle.WriteLn('<body>');
       xIOHandle.WriteLn('<h1>Closing...</h1>');
       xIOHandle.WriteLn('<script type="text/javascript">');
       xIOHandle.WriteLn('  window.close();');
       xIOHandle.WriteLn('</script>');
       xIOHandle.WriteLn('</body>');
       xIOHandle.WriteLn('</html>');
      {$ENDREGION}

     except
     end;

     // Encerre a conexão
     try
      if xContext.Connection <> nil then
       if AContext.Connection <> nil then
        if xContext.Connection.Connected then
         xContext.Connection.IOHandler.CloseGracefully;
     except
     end;

     FreeAndNil(xHeader);
    end,
    AContext,
    vHeader,
    nil,
    nil
   );

   vIsProc:= true;

   vProc.ExecAnonymousThread;
  end else
  if vHeader.WebMethod in [wmtGET, wmtPOST, wmtHEAD] then
  begin
   if (vHeader.Upgrade = 'websocket') and (vHeader.SecWebSocketKey <> '') and
      ((AnsiPos(FpathWebSocket+'/connectionparams', vHeader.Path) > 0) or (AnsiPos(FpathWebSocket+'/connectionresponseparams', vHeader.Path) > 0)) and
      ((not Assigned(AContext.Data)) or (Assigned(AContext.Data) and (AContext.Data is TPrismWebSocketContext) and (not PrismWSContext.Established))) then
   begin
    {$REGION 'Handshaking WebSockets'}
    if not Assigned(AContext.Data) then
     AContext.Data:= TPrismWebSocketContext.Create;
    PrismWSContext := TPrismWebSocketContext(AContext.Data);

    if PrismWSContext.Token = '' then
    begin
     PrismWSContext.Token := vHeader.QueryParams.Values['token'];
     PrismWSContext.ChannelName := vHeader.QueryParams.Values['channelname'];
     PrismWSContext.PrismSessionUUID := vHeader.QueryParams.Values['prismsession'];
     PrismWSContext.FormUUID := vHeader.QueryParams.Values['FormUUID'];
     if not Assigned(PrismWSContext.PrismSession) then
      PrismWSContext.PrismSession:= PrismBaseClass.Sessions.Item[PrismWSContext.PrismSessionUUID];
     if (AnsiPos(FpathWebSocket+'/connectionparams', vHeader.Path) > 0) then
     PrismWSContext.ChannelName:= 'PrismSocketConnection'
     else
     if (AnsiPos(FpathWebSocket+'/connectionresponseparams', vHeader.Path) > 0) then
     PrismWSContext.ChannelName:= 'PrismSocketResponse';

     if Assigned(PrismWSContext.PrismSession) then
      (PrismWSContext.PrismSession as TPrismSession).WebSocketContext:= AContext;
    end;

    if (PrismWSContext.Token <> '') and (Assigned(PrismWSContext.PrismSession)) and (PrismWSContext.Token <> PrismWSContext.PrismSession.Token) then
    begin
     AContext.Connection.Disconnect;
     //AContext.Connection.IOHandler.CloseGracefully;

     exit;
    end else
    begin
     if (PrismWSContext.Token <> '') and (not Assigned(PrismWSContext.PrismSession)) then
     if PrismBaseClass.Sessions.Exist(PrismWSContext.PrismSessionUUID) and (PrismWSContext.Token = PrismBaseClass.Sessions.Item[PrismWSContext.PrismSessionUUID].Token) then
      PrismWSContext.PrismSession:= PrismBaseClass.Sessions.Item[PrismWSContext.PrismSessionUUID]
     else
     begin
      AContext.Connection.Disconnect;
      //AContext.Connection.IOHandler.CloseGracefully;

      exit;
     end;
    end;


    SecWebSocketKey := vHeader.SecWebSocketKey;

    // Send handshake response
    Hash := TIdEncoderMIME.EncodeBytes(
      TIdHashSHA1.Create.HashString(SecWebSocketKey + '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'));

    try
      c.Write('HTTP/1.1 101 Switching Protocols'#13#10
        + 'Upgrade: websocket'#13#10
        + 'Connection: Upgrade'#13#10
        + 'Sec-WebSocket-Accept: ' + Hash
        + #13#10#13#10, IndyTextEncoding_UTF8);
    except
    end;

    // Mark IOHandler as handshaked
    PrismWSContext.Established:= true;

    if Assigned(PrismWSContext.PrismSession) then
    begin
     PrismBaseClass.ServerController.DoSessionChange(scsStabilizedConnectioSession, TPrismWebSocketContext(AContext.Data).PrismSession);
    end;

    //result:= true;

    {$ENDREGION}
   end else
   begin
    if (vHeader.Path = '/') or (vHeader.Path = '') or (Copy(vHeader.Path, 1,2) = '/?') or (vHeader.Path = VirtualPath) then
    begin
     {$REGION 'Open Form'}
     vProc:= TPrismSessionThreadProc.Create(nil,
      Procedure(AAContext, AHeader, APrismWSContext, var4: TValue)
      var
       xPrismRequest: TPrismHTTPRequest;
       xPrismResponse: TPrismHTTPResponse;
       xHeader: TPrismHTTPHeader;
       xPrismWSContext: TPrismWebSocketContext;
       xIOHandle: TIdIOHandler;
       xContext: TIdContext;
       xFileName: string;
       xResponseFileName, xResponseFileContent, xResponseRedirect, xMimeType: string;
       xPage429: string;
      begin
       xContext:= TIdContext(AAContext.AsObject);
       if xContext.Connection = nil then
        exit;
       xIOHandle:= xContext.Connection.IOHandler;
       xHeader:= TPrismHTTPHeader(AHeader.AsObject);
       xPrismRequest:= TPrismHTTPRequest.Create;
       xPrismRequest.Header:= xHeader;
       xPrismResponse:= TPrismHTTPResponse.Create;
       xPrismWSContext:= TPrismWebSocketContext.Create;

       if (xHeader.Path = '/') or (xHeader.Path = '') or (Copy(xHeader.Path, 1,2) = '/?') or (xHeader.Path = VirtualPath) then
       begin
        try
         if xHeader.ReloadPage then
         begin
          xPrismWSContext.Token:= xHeader.Token;
          xPrismWSContext.PrismSessionUUID:= xHeader.PrismSession;
          xPrismWSContext.Reloading:= true;
         end;

         try
          DoGetHTML(xContext, xPrismRequest, xPrismResponse, xPrismWSContext);
         except
         end;

         if not xPrismRequest.Header.TooManyConnFromIP then
         begin
          xIOHandle.WriteLn('HTTP/1.1 ' + xPrismResponse.StatusCode);
          xIOHandle.WriteLn('Content-Type: '+xPrismResponse.ContentType+'; charset='+xPrismResponse.charset);
          xIOHandle.WriteLn('Connection: Close');
     //     xIOHandle.WriteLn('Connection: Keep-Alive');
     //     xIOHandle.WriteLn('Keep-Alive: timeout='+IntToStr(Fhtmlconnectiontimeout)+', max='+IntToStr(Fhtmlconnectionmax));
          xIOHandle.WriteLn('Server: '+fServerName);
          //xIOHandle.WriteLn('Link: </error500.html>; rel=prefetch');
          //if (AnsiPos('/reloadpage?token=', xHeader.Path) > 0) then
          if xHeader.ReloadPage then
          begin
           xIOHandle.WriteLn('Set-Cookie: D2Bridge_Token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path='+xHeader.PathWithoutParams);
           xIOHandle.WriteLn('Set-Cookie: D2Bridge_PrismSession=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path='+xHeader.PathWithoutParams);
           xIOHandle.WriteLn('Set-Cookie: D2Bridge_ReloadPage=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path='+xHeader.PathWithoutParams);
           //DisconnectWebSocketMessage(xPrismWSContext.Token, xPrismWSContext.PrismSessionUUID);
          end;
          xIOHandle.WriteLn('');

          if xPrismResponse.Content <> '' then
           if Assigned(xIOHandle) and (xContext.Connection <> nil) then
            xIOHandle.Write(xPrismResponse.Content, IndyTextEncoding_UTF8);

          try
           DoFinishedGetHTML(xPrismWSContext);
          except
          end;
         end else
         begin
          xPage429:= PrismBaseClass.PrismServerHTML.GetError429(xHeader.AcceptLanguage);
          xIOHandle.WriteLn('HTTP/1.1 429 Too Many Requests');
          xIOHandle.WriteLn('Retry-After: 60'); // Tempo em segundos até tentar novamente
          xIOHandle.WriteLn('Content-Type: text/html; charset=UTF-8');
          //xIOHandle.WriteLn('Content-Length: ' + IntToStr(Length(xPage429)));
          xIOHandle.WriteLn('');
          xIOHandle.Write(xPage429, IndyTextEncoding_UTF8);
         end;
        except
        end;
        //Result:= true;
       end;


       // Encerre a conexão
       try
        if xContext.Connection <> nil then
         if AContext.Connection <> nil then
          if xContext.Connection.Connected then
           xContext.Connection.IOHandler.CloseGracefully;
       except
       end;

       FreeAndNil(xPrismRequest);
       FreeAndNil(xPrismResponse);
       FreeAndNil(xPrismWSContext);
       FreeAndNil(xPrismRequest);
       FreeAndNil(xHeader);
      end,
      AContext,
      vHeader,
      PrismWSContext,
      nil
     );

     vIsProc:= true;

     vProc.ExecAnonymousThread;
     {$ENDREGION }
    end else
    begin
     {$REGION 'Open File'}
     try
      vPrismRequest:= TPrismHTTPRequest.Create;
      vPrismRequest.Header:= vHeader;
      vPrismResponse:= TPrismHTTPResponse.Create;
      if not Assigned(PrismWSContext) then
       PrismWSContext:= TPrismWebSocketContext.Create;


      vFileName:= StringReplace(RootDirectory + StringReplace(vHeader.Path,'/','\', [rfReplaceAll]), '\\', '\', [rfReplaceAll]);
      RemoveEscapeFromFileURL(vFileName);
      if AnsiPos('?', vFileName) > 0 then
      vFileName:= Copy(vFileName, 1, AnsiPos('?', vFileName) -1);

      if (not FileExists(vFileName)) or (vFileName = 'error500.html') then
      begin
       if Assigned(FOnGetFile) then
       begin
        FOnGetFile(vPrismRequest, vFileName, vResponseFileName, vResponseFileContent, vResponseRedirect, vMimeType);

        if (vResponseFileName <> '') and FileExists(vResponseFileName) then
        begin
         c.WriteLn('HTTP/1.1 ' + vPrismResponse.StatusCode);
         if MimesType.GetMimeType(vFileName) <> '' then
          c.WriteLn('Content-Type: '+vMimeType+'; charset='+vPrismResponse.charset);
         c.WriteLn('Connection: Close');
         c.WriteLn('Server: '+fServerName);
         c.WriteLn('');

         c.WriteFile(vResponseFileName);
        end else
        if (vResponseFileContent <> '') then
        begin
         c.WriteLn('HTTP/1.1 ' + vPrismResponse.StatusCode);
         if MimesType.GetMimeType(vFileName) <> '' then
          c.WriteLn('Content-Type: '+MimesType.GetMimeType(vFileName)+'; charset='+vPrismResponse.charset);
         c.WriteLn('Connection: Close');
         c.WriteLn('Server: '+fServerName);
         c.WriteLn('');

         c.Write(vResponseFileContent, IndyTextEncoding_UTF8);
        end else
        if (vResponseRedirect <> '') then
        begin
         c.WriteLn('HTTP/1.1 302 Found');
         c.WriteLn('Connection: Close');
         c.WriteLn('Location: '+vResponseRedirect);
         if MimesType.GetMimeType(vResponseRedirect) <> '' then
          c.WriteLn('Content-Type: '+MimesType.GetMimeType(vResponseRedirect)+'; charset='+vPrismResponse.charset);
         c.WriteLn('Server: '+fServerName);
         c.WriteLn('');
        end else
        begin
         c.WriteLn('HTTP/1.1 404 Not Found');
         c.WriteLn('Connection: Close');
         c.WriteLn('Server: '+fServerName);
         c.WriteLn('');

         //PrismBaseClass.Log('', 'PrismServerTCP', 'GetFile', 'DoExecute', 'File not Found: '+vFileName);
        end;
       end;
      end else
      begin
       c.WriteLn('HTTP/1.1 ' + vPrismResponse.StatusCode);
       if MimesType.GetMimeType(vFileName) <> '' then
        c.WriteLn('Content-Type: '+MimesType.GetMimeType(vFileName)+'; charset='+vPrismResponse.charset);
       c.WriteLn('Connection: Close');
       c.WriteLn('Server: '+fServerName);
       c.WriteLn('');

       c.WriteFile(vFileName);
      end;
     except
     end;

     try
      if AContext.Connection <> nil then
       if AContext.Connection <> nil then
        if AContext.Connection.Connected then
         AContext.Connection.Disconnect;
     except
     end;
     {$ENDREGION}
    end;
   end;
  end else
  begin
   //PUT, ...

   try
    if AContext.Connection <> nil then
     if AContext.Connection <> nil then
      if AContext.Connection.Connected then
       AContext.Connection.Disconnect;
   except
   end;
  end;


  //vHeader.DisposeOf;
 end;


 if vIsProc then
  Result := true
 else
  if AContext <> nil then
  begin
   if AContext.Connection <> nil then
   begin
    try
     Result := AContext.Connection.Connected;
    except
     Result := false;
    end;
   end;
  end;
end;
{$ENDIF}

procedure TPrismServerTCP.DoDownloadData(AContext: TIdContext;
  APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse;
  var PrismWSContext: TPrismWebSocketContext);
begin
 if Assigned(FOnDownloadData) then
  FOnDownloadData(APrismRequest, APrismReponse, PrismWSContext);
end;

procedure TPrismServerTCP.DoFinishedGetHTML(APrismWSContext: TPrismWebSocketContext);
begin
 if Assigned(FOnFinishedGetHTML) then
  FOnFinishedGetHTML(APrismWSContext);
end;

procedure TPrismServerTCP.DoGetHTML(AContext: TIdContext; APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse; var PrismWSContext: TPrismWebSocketContext);
begin
 if Assigned(FOnGetHTML) then
  FOnGetHTML(APrismRequest, APrismReponse, PrismWSContext);
end;

function TPrismServerTCP.DoReceiveMessage(AMessage: string; PrismWSContext: TPrismWebSocketContext): string;
var
 vPrismWSMessage: TPrismWebSocketMessage;
 vToken: string;
begin
 try
  if Assigned(PrismWSContext) and Assigned(PrismWSContext.PrismSession) then
  begin
   if Assigned(PrismWSContext.PrismSession) and
      (csDestroying in TPrismSession(PrismWSContext.PrismSession).ComponentState) then
   begin
    exit;
   end else
   begin
    vPrismWSMessage:= FormatReceivedMesssage(AMessage);

    try
     try
      if vPrismWSMessage.Parameters.TryGetValue('Token', vToken)
         and (PrismWSContext.PrismSession.Token = vToken) then
      begin
       if Assigned(FOnReceiveMessage) then
       Result:= FOnReceiveMessage(vPrismWSMessage, PrismWSContext);
      end else
      begin
       try
        if not PrismWSContext.PrismSession.Closing then
         PrismWSContext.PrismSession.Close;
       except
       end;
      end;
     except

     end;
    finally
     vPrismWSMessage.Free;
    end;

    //OutputDebugString(PWideChar(AMessage));
   end;
  end;
 except
 end;
end;

procedure TPrismServerTCP.DoRESTData(AContext: TIdContext;
  APrismRequest: TPrismHTTPRequest; var APrismReponse: TPrismHTTPResponse;
  var PrismWSContext: TPrismWebSocketContext);
begin
 if Assigned(FOnRESTData) then
  FOnRESTData(APrismRequest, APrismReponse, PrismWSContext);
end;

procedure TPrismServerTCP.DoUploadFile(AFiles: TStrings; PrismSession: IPrismSession; AFormUUID: string; Sender: TObject);
var
 vPrismForm: IPrismForm;
begin
 PrismSession.ThreadAddCurrent;

 try
  vPrismForm:= PrismSession.ActiveFormByFormUUID(AFormUUID);
  if Supports(vPrismForm, IPrismForm) then
   vPrismForm.DoUpload(AFiles, Sender)
  else
   PrismSession.ActiveForm.DoUpload(AFiles, Sender);
 finally
  PrismSession.ThreadRemoveCurrent;
 end;

end;


function TPrismServerTCP.FormatReceivedMesssage(AMessage: string): TPrismWebSocketMessage;
var
 MSGJSONObject: TJSONObject;
 MSGParameters: TJSONArray;
 I: Integer;
 vParamName, vParamValue: string;
begin
 Result:= TPrismWebSocketMessage.Create;

 try
  if IsJSONValid(AMessage) then
  begin
   Result.IsFormatted:= true;

   MSGJSONObject:= TJSONObject.ParseJSONValue(AMessage) as TJSONObject;

   Result.Name := MSGJSONObject.GetValue('name','');

   if SameText(MSGJSONObject.GetValue('type',''), 'CallBack') then
    Result.MessageType:= wsMsgCallBack
   else
    if SameText(MSGJSONObject.GetValue('type',''), 'Procedure') then
     Result.MessageType:= wsMsgProcedure
    else
    if SameText(MSGJSONObject.GetValue('type',''), 'Function') then
     Result.MessageType:= wsMsgFunction
    else
    if SameText(MSGJSONObject.GetValue('type',''), 'Text') then
     Result.MessageType:= wsMsgText
     else
      if SameText(MSGJSONObject.GetValue('type',''), 'Heartbeat') then
       Result.MessageType:= wsMsgHeartbeat
       else
        Result.MessageType:= wsNone;


   MSGParameters:= MSGJSONObject.GetValue('parameters') as TJSONArray;

   if Assigned(MSGParameters) then
   for I := 0 to Pred(MSGParameters.Count) do
   begin
    vParamName:= (MSGParameters.Items[I] as TJSONObject).Pairs[0].JsonString.Value;
    vParamValue:= (MSGParameters.Items[I] as TJSONObject).Pairs[0].JsonValue.Value;

    Result.Parameters.Add
     (
      vParamName,
      vParamValue
     );
   end;

   Result.Wait:= SameText(MSGJSONObject.GetValue('wait',''), 'true');

  end;

  Result.RawMessage:= AMessage;
 except
 end;
end;



procedure TPrismServerTCP.InitSSL(
  AIdServerIOHandlerSSLOpenSSL: TIdServerIOHandlerSSLOpenSSL);
var
  CurrentActive: boolean;
begin
  CurrentActive := Active;
  if CurrentActive then
    Active := false;

  IdServerIOHandlerSSLOpenSSL := AIdServerIOHandlerSSLOpenSSL;
  IOHandler := AIdServerIOHandlerSSLOpenSSL;

  if CurrentActive then
    Active := true;

end;

procedure TPrismServerTCP.InsertEscapeToFileURL(var vFileName: string);
const
  EscapeChars: array[0..32] of string = (
    '%20', '%21', '%22', '%23', '%24', '%25', '%26', '%27', '%28', '%29',
    '%2A', '%2B', '%2C', '%2D', '%2E', '%2F', '%3A', '%3B', '%3C', '%3D',
    '%3E', '%3F', '%40', '%5B', '%5C', '%5D', '%5E', '%5F', '%60', '%7B',
    '%7C', '%7D', '%7E'
  );
var
  i: Integer;
begin
  for i := 0 to High(EscapeChars) do
    vFileName := StringReplace(vFileName, Char(StrToInt('$' + Copy(EscapeChars[i], 2, 2))), EscapeChars[i], [rfReplaceAll]);

  // Reverter a substituição do espaço em branco para o sinal de mais
  vFileName := StringReplace(vFileName, ' ', '%2B', [rfReplaceAll]);
end;

procedure TPrismServerTCP.InterceptExecute(AContext: TIdContext);
var
 WebSocketData: TIdBytes;
 WebSocketString, RequestLine, Headers, Line: string;
 vResponse: string;
 msg: string;
begin
 //AContext.Connection.IOHandler.CheckForDataOnSource(90);
 //AContext.Connection.IOHandler.ReadBytes(WebSocketData, -1, False);

 try
  if (AContext.Connection.Connected) then
  begin
   if Assigned(AContext.Data) and
      (AContext.Data is TPrismWebSocketContext) and
      (TPrismWebSocketContext(AContext.Data).Established) then
   begin
    WebSocketString:= TWebSocketIOHandlerHelper(AContext.Connection.IOHandler).ReadString;

 //   if Assigned(TPrismWebSocketContext(AContext.Data).PrismSession) and
 //      (csDestroying in TPrismSession(TPrismWebSocketContext(AContext.Data)).ComponentState) then
 //   begin
 //    if Assigned(TPrismWebSocketContext(AContext.Data).PrismSession) then
 //     TPrismWebSocketContext(AContext.Data).PrismSession.RenewExpireDate;
 //   end;

    if WebSocketString <> '' then
    begin
     vResponse:= DoReceiveMessage(WebSocketString, TPrismWebSocketContext(AContext.Data));
     if (vResponse <> '') then
     TWebSocketIOHandlerHelper(AContext.Connection.IOHandler).WriteString(vResponse);

     AContext.Connection.IOHandler.Tag:= 99;
    end;
   end;
  end;
 except
 end;

// RequestLine := AContext.Connection.IOHandler.ReadLn;
//
// if RequestLine <> '' then
// begin
//  // Read string and parse HTTP headers
//  try
//   Headers := RequestLine + sLineBreak;
//   repeat
//    Line := AContext.Connection.IOHandler.ReadLn;
//    Headers := Headers + Line + sLineBreak;
//   until (Headers = sLineBreak) or (Line = '');
//  except
//  end;
// end;

//  io := TWebSocketIOHandlerHelper(AContext.Connection.IOHandler);
//  io.CheckForDataOnSource(10);
//  msg := io.ReadString;
//  if msg <> '' then
//  begin
//   //OutputDebugString(PWideChar('Intercept MSG: ' + msg));
//   //io.WriteString(msg);
//   if Assigned(AContext.Data) and (AContext.Data is TPrismWebSocketContext) then
//   DoReceiveMessage(msg, TPrismWebSocketContext(AContext.Data));
//  end;
end;

function TPrismServerTCP.MimesType: TPrismServerFileExtensions;
begin
 Result:= FMimesType;
end;

function TPrismServerTCP.OpenSSL: TIdServerIOHandlerSSLOpenSSL;
begin
 if not Assigned(IdServerIOHandlerSSLOpenSSL) then
 IdServerIOHandlerSSLOpenSSL:= TIdServerIOHandlerSSLOpenSSL.Create(self);

 result:= IdServerIOHandlerSSLOpenSSL;
end;

function TPrismServerTCP.ParseHeaders(AContext: TIdContext; const AHTMLHeader: string): TPrismHTTPHeader;
var
 lines: TArray<string>;
 line: string;
 SplittedLine: TArray<string>;
 vPortString: string;
 vPortInt: Integer;
 URI: TIdURI;
 vCookies, vCookieParts: TStrings;
 vCookiePair: string;
 vExistBoundary: boolean;
 I: integer;
 vContentLength: Integer;
begin
 result := TPrismHTTPHeader.Create;

 //GetRemoteIP
 if Assigned(AContext) then
  if AContext.Connection.Socket <> nil then
   if AContext.Connection.Socket <> nil then
   begin
    result.RemoteIP := AContext.Connection.Socket.Binding.PeerIP;
    result.RemotePort:= AContext.Connection.Socket.Binding.PeerPort;
   end;


 lines := AHTMLHeader.Split([#13#10]);
 for line in lines do
 begin
  result.RawHeaders.Add(line);

  SplittedLine := line.Split([': ']);
  if Length(SplittedLine) > 1 then
  begin
   if SameText(Trim(SplittedLine[0]), 'pragma') then result.Pragma:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'cache-control') then result.CacheControl:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'user-agent') then result.UserAgent:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'Origin') then result.Origin:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'connection') then result.Connection:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'upgrade') then result.Upgrade:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'Sec-WebSocket-Key') then result.SecWebSocketKey:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'Accept-Encoding') then result.AcceptEncoding:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'Accept-Language') then result.AcceptLanguage:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'Content-Length') then result.ContentLength:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'Purpose') then result.Purpose:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'x-real-ip') then result.ForwardedIP:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'x-forwarded-for') then result.ForwardedIP:= Trim(SplittedLine[1]);
   if SameText(Trim(SplittedLine[0]), 'referer') then
   begin
    result.Referer:= Trim(SplittedLine[1]);

    if AnsiPos(':', Trim(result.Referer)) > 0 then
    begin
     if AnsiPos('https://', Trim(result.Referer)) = 1 then
     begin
      result.Protocol:= 'https';

      if AnsiPos(':', Copy(Trim(result.Referer), 9)) > 0 then
      begin
       if TryStrToInt(Copy(Trim(Copy(Trim(result.Referer), 9)), AnsiPos(':', Trim(Copy(Trim(result.Referer), 9)))+1), vPortInt) then
       begin
        result.ServerPort:= vPortInt;
        vPortString:= IntToStr(vPortInt);
       end;
      end else
      begin
       result.ServerPort:= 443;
       vPortString:= '443';
      end;
     end else
     if AnsiPos('http://', Trim(result.Referer)) = 1 then
     begin

     end;
    end;


    URI := TIdURI.Create(Result.Referer);
    try
     Result.RefererQueryParams.LineBreak:= '&';
     Result.RefererQueryParams.Text := TIdURI.URLDecode(URI.Params);
    finally
     URI.Free;
    end;
   end else
   if SameText(Trim(SplittedLine[0]), 'X-Forwarded-Scheme') then
   begin
    if Pos(Trim(SplittedLine[1]),'https') > 0 then
    begin
      vPortString:= '443';
      Result.Protocol:= 'https';
    end
    else
    begin
      Result.Protocol:= 'http';
      vPortString:= '80';
    end;
    TryStrToInt(vPortString, Result.ServerPort);
   end else
   if SameText(Trim(SplittedLine[0]), 'host') then
   begin
    if AnsiPos(':', Trim(SplittedLine[1])) > 0 then
    begin
     vPortString:= Copy(Trim(SplittedLine[1]), AnsiPos(':', Trim(SplittedLine[1]))+1)
    end else
    begin
     if Result.Protocol = 'https' then
      vPortString:= '443'
     else
      vPortString:= '80';
    end;

    if (AnsiPos(':', Trim(SplittedLine[1])) > 0) and
       ((Result.Protocol = 'https') and (vPortString <> '443')) and
       ((Result.Protocol = 'http') and (vPortString <> '80')) then
     result.host:= Copy(Trim(SplittedLine[1]), 1, AnsiPos(':', Trim(SplittedLine[1]))-1)
    else
     result.host:= Trim(SplittedLine[1]);

    TryStrToInt(vPortString, Result.ServerPort);
   end else
   if SameText(Trim(SplittedLine[0]), 'Content-Type') then
   begin
    if AnsiPos(';', Trim(SplittedLine[1])) > 0 then
     result.ContentType:= Trim(Copy(Trim(SplittedLine[1]), 1, AnsiPos(';', Trim(SplittedLine[1]))-1))
    else
     result.ContentType:= Trim(SplittedLine[1]);

    if AnsiPos('boundary', Trim(SplittedLine[1])) > 0 then
    begin
     result.Boundary:= Trim(Copy(Trim(SplittedLine[1]), AnsiPos('boundary', Trim(SplittedLine[1]))));
     result.Boundary:= Trim(Copy(result.Boundary, AnsiPos('=', result.Boundary)+1));
    end;
   end else
   if SameText(Trim(SplittedLine[0]), 'Cookie') then
   begin
    try
     result.Cookies:= Trim(SplittedLine[1]);

     vCookies:= TStringList.Create;
     vCookieParts:= TStringList.Create;
     vCookies.LineBreak:= ';';
     vCookieParts.Delimiter:= '=';
     vCookies.Text:= Trim(SplittedLine[1]);

     for vCookiePair in vCookies do
     begin
      vCookieParts.DelimitedText := vCookiePair;
      if vCookieParts[0] = 'D2Bridge_Token' then
      result.Token:= vCookieParts[1]
      else
      if vCookieParts[0] = 'D2Bridge_PrismSession' then
      result.PrismSession:= vCookieParts[1]
      else
      if vCookieParts[0] = 'D2Bridge_ServerUUID' then
      result.ServerUUID:= vCookieParts[1]
      else
      if vCookieParts[0] = 'D2Bridge_ReloadPage' then
      result.ReloadPage:= SameText(vCookieParts[1], 'true');
     end;
    finally
     vCookies.Free;
     vCookieParts.Free;
    end;
   end else
   if (SameText(Trim(SplittedLine[0]), 'Content-Disposition')) and Result.IsUploadFile then
   begin
    result.FileName:= copy(Trim(SplittedLine[1]), AnsiPos('filename="', Trim(SplittedLine[1]))+10);
    result.FileName:= copy(result.FileName, 1, AnsiPos('"',result.FileName));
   end;

   //result.AddOrSetValue(Trim(SplittedLine[0]), Trim(SplittedLine[1]));
  end else
  begin
   if (AnsiPos('GET /', line) > 0) or (AnsiPos('POST /', line) > 0) or (AnsiPos('HEAD /', line) > 0) then
   begin
    if (AnsiPos('GET /', line) > 0) then
    result.WebMethod:= wmtGET
    else
    if (AnsiPos('POST /', line) > 0) then
    result.WebMethod:= wmtPOST
    else
    if (AnsiPos('HEAD /', line) > 0) then
    result.WebMethod:= wmtHEAD;

    Result.Path:= Copy(line, AnsiPos(' /', line) + 1, AnsiPos(' ', Copy(line, AnsiPos(' /', line) + 1)) -1);

    if AnsiPos('HTTP/', AnsiUpperCase(Copy(line, 6 + Length(Result.Path)))) > 0 then
    begin
     if PrismBaseClass.Options.SSL then
      Result.Protocol:= 'https'
     else
      Result.Protocol:= 'http'
    end else
    if AnsiPos('HTTPS/', AnsiUpperCase(Copy(line, 6 + Length(Result.Path)))) > 0 then
     Result.Protocol:= 'https';

    URI := TIdURI.Create(Result.Path);
    try
     Result.QueryParams.LineBreak:= '&';
     Result.QueryParams.Text := TIdURI.URLDecode(URI.Params);
    finally
     URI.Free;
    end;
   end;
  end;
 end;


 if PrismBaseClass.Options.Security.Enabled then
 begin
  {$REGION 'IP Blacklist check'}
   if PrismBaseClass.Options.Security.IP.IPv4BlackList.ExistIP(Result.ClientIP) then
    if not PrismBaseClass.Options.Security.IP.IPv4WhiteList.ExistIP(Result.ClientIP) then
     Result.IPListedInBlackList:= true;
  {$ENDREGION}

  {$REGION 'UserAgent Blocked'}
   if PrismBaseClass.Options.Security.UserAgent.UserAgentBlocked(Result.UserAgent) then
    Result.UserAgentBlocked:= true;
  {$ENDREGION}
 end;


 //Pos Process
 if (AnsiPos(FpathRESTServer+'/json/jqgrid/post', Result.Path) > 0) and
    TryStrToInt(Result.ContentLength, vContentLength) then
 begin
  Result.Content:= AContext.Connection.IOHandler.ReadString(vContentLength, IndyTextEncoding_UTF8);
 end;

end;

function TPrismServerTCP.ReadBodyStringFromData(IOHandler: TIdIOHandler; ContentLength: Integer): string;
var
 vBodyContent: TBytes;
begin
 result:= '';

 if ContentLength > 0 then
 begin
  IOHandler.ReadBytes(TIDBytes(vBodyContent), ContentLength);

  result:= TIdURI.URLDecode(TEncoding.Default.GetString(vBodyContent));
 end;
end;

function TPrismServerTCP.ReadBodyStreamFromData(IOHandler: TIdIOHandler;
  ContentLength: Integer): TMemoryStream;
var
 vBodyContent: TBytes;
 vArrayLines: TArray<string>;
 I: Integer;
begin
 result:= nil;

 if ContentLength > 0 then
 begin
  result:= TMemoryStream.Create;

  IOHandler.ReadBytes(TIDBytes(vBodyContent), ContentLength);

  result.WriteBuffer(vBodyContent[0], ContentLength);
  result.Position := 0;
 end;
end;

procedure TPrismServerTCP.ReadMultipartFormData(IOHandler: TIdIOHandler; Boundary: String; ContentLength: Integer; PrismWSContext: TPrismWebSocketContext);
var
 Line: String;
 lines: TArray<string>;
 Files: TStrings;
 FileStatus: TStreamFileStatus;
 Filename: String;
 FileMemoryStream: TMemoryStream;
 partContent: TBytes;
 I, Z: Integer;
begin
 if (ContentLength > 0) then
 begin
  FileStatus:= SFSNone;
  Files:= TStringList.Create;

  IOHandler.ReadBytes(TIDBytes(partContent), ContentLength);

  lines := TEncoding.Default.GetString(partContent).Split([#13#10]);

  I:= 0;
  repeat
   Line:= lines[I];

   if (FileStatus = SFSWaitingFile) and (Line = '') then
    FileStatus := SFSCreateFile;

   if (FileStatus = SFSCreateFile) and (Line <> '') then
   begin
    FileMemoryStream:= TMemoryStream.Create;
    FileStatus:= SFSWriteFile;
   end;

   if (FileStatus = SFSWriteFile) and ((Line = '--'+Boundary+'--') or (Line = '--'+Boundary)) then
   begin
    FileStatus:= SFSNone;

    Z:= 1;
    if FileExists(PrismWSContext.PrismSession.PathSession+FileName) then
    repeat
     FileName:= Format('%s%d%s', [ChangeFileExt(FileName, ''), Z, ExtractFileExt(FileName)]);
     Inc(Z);
    until not FileExists(PrismWSContext.PrismSession.PathSession+FileName);

    FileMemoryStream.SaveToFile(PrismWSContext.PrismSession.PathSession+FileName);
    Files.Add(PrismWSContext.PrismSession.PathSession+FileName);
    FileMemoryStream.Free;
    Filename:= '';
   end;

   if (FileStatus = SFSWriteFile) and (Line <> '') and (Line <> '--'+Boundary) then
    FileMemoryStream.Write(TEncoding.Default.GetBytes(Line + sLineBreak)[0], Length(Line + sLineBreak));

   if (FileStatus = SFSNone) and (AnsiPOS('Content-Disposition:', Line) > 0) then
   begin
    Filename:= copy(Line, AnsiPos('filename="', Line) + 10);
    FileName:= copy(FileName, 1, AnsiPos('"', FileName)-1);

    FileStatus:= SFSWaitingFile;
   end;

   Inc(I);
  until I >= Length(Lines);

  DoUploadFile(Files, PrismWSContext.PrismSession, PrismWSContext.FormUUID, nil);

  Files.Free;
 end;

 partContent:= nil;
 lines:= nil;
end;

procedure TPrismServerTCP.RemoveEscapeFromFileURL(var vFileName: string);
const
  EscapeChars: array[0..32] of string = (
    '%20', '%21', '%22', '%23', '%24', '%25', '%26', '%27', '%28', '%29',
    '%2A', '%2B', '%2C', '%2D', '%2E', '%2F', '%3A', '%3B', '%3C', '%3D',
    '%3E', '%3F', '%40', '%5B', '%5C', '%5D', '%5E', '%5F', '%60', '%7B',
    '%7C', '%7D', '%7E'
  );
var
  i: Integer;
begin
  for i := 0 to High(EscapeChars) do
    vFileName := StringReplace(vFileName, EscapeChars[i], Char(StrToInt('$' + Copy(EscapeChars[i], 2, 2))), [rfReplaceAll]);

  // Além disso, substituir o sinal de mais por espaço em branco
  vFileName := StringReplace(vFileName, '%2B', ' ', [rfReplaceAll]);
end;

procedure TPrismServerTCP.SendWebSocketMessage(AMessage: string; APrismSession: IPrismSession);
var
 vContext: TIdContext;
begin
 if AMessage <> '' then
 begin
  try
   vContext:= (APrismSession as TPrismSession).WebSocketContext;

   if Assigned(vContext) then
    if Assigned(vContext.Connection) then
     if Assigned(vContext.Connection.IOHandler) then
      if vContext.Connection.Connected then
       TWebSocketIOHandlerHelper(vContext.Connection.IOHandler).WriteString(AMessage);
  except
  end;
 end;
end;


{ TWebSocketIOHandlerHelper }


function TWebSocketIOHandlerHelper.ReadBytes: TArray<Byte>;
var
  l: Byte;
  b: array [0..7] of Byte;
  i, DecodedSize: Int64;
  Mask: array [0..3] of Byte;
begin
  try
    Result:= [];

    if ReadByte = $81 then
    begin
      l := ReadByte;
      case l of
        $FE:
          begin
            b[1] := ReadByte;
            b[0] := ReadByte;
            b[2] := 0;
            b[3] := 0;
            b[4] := 0;
            b[5] := 0;
            b[6] := 0;
            b[7] := 0;
            DecodedSize := PInt64(@b)^;
          end;
        $FF:
          begin
            b[7] := ReadByte;
            b[6] := ReadByte;
            b[5] := ReadByte;
            b[4] := ReadByte;
            b[3] := ReadByte;
            b[2] := ReadByte;
            b[1] := ReadByte;
            b[0] := ReadByte;
            DecodedSize := PInt64(@b)^;
          end;
        else
          DecodedSize := l - 128;
      end;
      Mask[0] := ReadByte;
      Mask[1] := ReadByte;
      Mask[2] := ReadByte;
      Mask[3] := ReadByte;

      if DecodedSize < 1 then
      begin
        Result := [];
        Exit;
      end;

      SetLength(Result, DecodedSize);
      inherited ReadBytes(TIdBytes(Result), DecodedSize, False);
      for i := 0 to DecodedSize - 1 do
        Result[i] := Result[i] xor Mask[i mod 4];
    end;
  except
    on E: Exception do
    begin
     Result:= [];

     //OutputDebugString(PWideChar(E.Message));
    end;
  end;
end;


//function TWebSocketIOHandlerHelper.ReadBytes: TArray<byte>;
//var
//  l: byte;
//  b: array [0..7] of byte;
//  i, DecodedSize: int64;
//  Mask: array [0..3] of byte;
//begin
//  // https://stackoverflow.com/questions/8125507/how-can-i-send-and-receive-websocket-messages-on-the-server-side
//
//  try
//    if ReadByte = $81 then
//    begin
//      l := ReadByte;
//      case l of
//        $FE:
//          begin
//            b[1] := ReadByte; b[0] := ReadByte;
//            b[2] := 0; b[3] := 0; b[4] := 0; b[5] := 0; b[6] := 0; b[7] := 0;
//            DecodedSize := Int64(b);
//          end;
//        $FF:
//          begin
//            b[7] := ReadByte; b[6] := ReadByte; b[5] := ReadByte; b[4] := ReadByte;
//            b[3] := ReadByte; b[2] := ReadByte; b[1] := ReadByte; b[0] := ReadByte;
//            DecodedSize := Int64(b);
//          end;
//        else
//          DecodedSize := l - 128;
//      end;
//      Mask[0] := ReadByte; Mask[1] := ReadByte; Mask[2] := ReadByte; Mask[3] := ReadByte;
//
//      if DecodedSize < 1 then
//      begin
//        result := [];
//        exit;
//      end;
//
//      SetLength(result, DecodedSize);
//      inherited ReadBytes(TIdBytes(result), DecodedSize, False);
//      for i := 0 to DecodedSize - 1 do
//        result[i] := result[i] xor Mask[i mod 4];
//    end;
//  except
//  end;
//end;

procedure TWebSocketIOHandlerHelper.WriteBytes(RawData: TArray<byte>);
var
  Msg: TArray<byte>;
begin
  // https://stackoverflow.com/questions/8125507/how-can-i-send-and-receive-websocket-messages-on-the-server-side

  Msg := [$81];

  if Length(RawData) <= 125 then
    Msg := Msg + [Length(RawData)]
  else if (Length(RawData) >= 126) and (Length(RawData) <= 65535) then
    Msg := Msg + [126, (Length(RawData) shr 8) and 255, Length(RawData) and 255]
  else
    Msg := Msg + [127, (int64(Length(RawData)) shr 56) and 255, (int64(Length(RawData)) shr 48) and 255,
      (int64(Length(RawData)) shr 40) and 255, (int64(Length(RawData)) shr 32) and 255,
      (Length(RawData) shr 24) and 255, (Length(RawData) shr 16) and 255, (Length(RawData) shr 8) and 255, Length(RawData) and 255];

  Msg := Msg + RawData;

  try
    Write(TIdBytes(Msg), Length(Msg));
  except
  end;
end;




function TWebSocketIOHandlerHelper.ReadString: string;
var
  Bytes: TBytes;
begin
 try
  Bytes := ReadBytes;

  if (Assigned(Bytes)) and (Length(Bytes) > 0) then
  begin
    Result := TEncoding.UTF8.GetString(Bytes);
  end
  else
  begin
    Result := '';
  end;
 except
  Result:= '';
 end;
end;



procedure TWebSocketIOHandlerHelper.WriteString(const str: string);
begin
  WriteBytes(TArray<byte>(IndyTextEncoding_UTF8.GetBytes(str)));
end;

end.

