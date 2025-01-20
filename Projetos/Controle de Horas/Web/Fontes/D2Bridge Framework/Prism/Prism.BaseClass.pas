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

unit Prism.BaseClass;

interface

uses
  System.Classes, System.SysUtils, System.IniFiles, System.IOUtils, System.Generics.Collections,
  System.SyncObjs, System.JSON, System.Threading, System.Rtti,
{$IFDEF MSWINDOWS}
  WinApi.ActiveX, WinApi.Windows, Winapi.ShellApi,
{$ENDIF}
{$IFDEF FMX}
  FMX.Forms,
{$ELSE}
  Vcl.Forms,
{$ENDIF}
  Web.HTTPApp, Web.WebReq,
  IdGlobal, IdSSLOpenSSL,
  Prism.Server.HTML.Headers, Prism.Session.Event, Prism.Types, Prism.Log, Prism.Server.TCP,
  {$IFDEF D2BRIDGE}Prism.Server.HTML,{$IFDEF FMX}D2Bridge.FMX.FakeForm,{$ENDIF}{$ENDIF} D2Bridge.Interfaces,
  Prism.Interfaces, Prism.DataWare.Mapped, Prism.BaseClass.Sessions,
  Prism.BaseClass.Timer, Prism.Options.Security.Event;


type
 TOnPrismException = procedure(Form: TObject; Sender: TObject; E: Exception; FormName: String; ComponentName: String; EventName: string; APrismSession: IPrismSession) of object;


type
 TPrismBaseClass = class(TComponent, IPrismBaseClass)
  strict private
   {$REGION 'TPrismOptions'}
   {$ENDREGION}

   {$REGION 'TPrismINIConfig'}
    type TPrismINIConfig = class(TInterfacedPersistent, IPrismINIConfig)
        private
         FFileINIConfig: TIniFile;
        public
         constructor Create;
         destructor Destroy; override;

         function ServerPort(ADefaultPort: Integer = 8888): Integer;
         function ServerName(ADefaultServerName: String = 'D2Bridge Server'): String;
         function ServerDescription(ADefaultServerDescription: String = 'D2Bridge Primary Server'): String;

         function FileINIConfig: TIniFile;
    end;
   {$ENDREGION}

  Private
   FPrismServerTCP: TPrismServerTCP;
   {$IFDEF D2BRIDGE}FPrismServerHTML: TPrismServerHTML;{$ENDIF}
   FPrismServerHTMLHeaders: TPrismServerHTMLHeaders;
   FOnNewSession: TOnNewSession;
   FOnCloseSession: TOnCloseSession;
   FOnPrismException: TOnPrismException;
   FOnDisconnectSession :TOnSessionEvent;
   FOnExpiredSession: TOnExpiredSession;
   FOnIdleSession: TOnIdleSession;
   FOnReconnectSession :TOnSessionEvent;
   FOnSecurity: TOnSecurityEvent;
   FINIConfig: TPrismINIConfig;
   FPrismOptions: IPrismOptions;
   FServerController: ID2BridgeServerControllerBase;
   FPrismLog: TPrismLog;
   FServerUUID: string;
   FSessions: TPrismSessions;
   FPrismTimer: TPrismTimer;
   function GetServerPort: Integer;
   procedure SetServerPort(APort: Integer);
   function GetOptions: IPrismOptions;
   procedure OnTimerObserver;
{$IFDEF D2BRIDGE}
    procedure SavePrismSupportFiles;
{$ENDIF}
  Public
   constructor Create(AOwner: TComponent); virtual;
   destructor Destroy; override;

   procedure InstancePrimaryForm(APrismSession: IPrismSession);

   procedure DoNewSession(const Request: TPrismHTTPRequest; const Response: TPrismHTTPResponse; const Session: IPrismSession); virtual;
   procedure DoCloseSession(const Session: IPrismSession); virtual;
   procedure DoReconnectSession(const Session: IPrismSession); virtual;
   procedure DoExpireSession(const Session: IPrismSession); virtual;
   procedure DoIdleSession(const Session: IPrismSession); virtual;
   procedure DoDisconnectSession(const Session: IPrismSession); virtual;
   procedure DoException(Sender: TObject; E: Exception; APrismSession: IPrismSession; EventName: string); virtual;
   procedure DoSecurity(const SecEventInfo: TSecuritEventInfo); virtual;
   procedure Log(const SessionIdenty, ErrorForm, ErrorObject, ErrorEvent, ErrorMsg: string);

   function Started: boolean;
   procedure StartServer;
   procedure StopServer;
   function SSLOptions: TIdSSLOptions;
   function INIConfig: IPrismINIConfig;
   function ServerUUID: string;

   function Sessions: IPrismSessions;

   property PrismServer: TPrismServerTCP read FPrismServerTCP;
   property ServerController: ID2BridgeServerControllerBase read FServerController write FServerController;
   property ServerPort: integer read GetServerPort write SetServerPort;
   //property Sessions: TDictionary<string, IPrismSession> read GetSessions;
   property PrismServerHTMLHeaders: TPrismServerHTMLHeaders read FPrismServerHTMLHeaders;
{$IFDEF D2BRIDGE}
   property PrismServerHTML: TPrismServerHTML read FPrismServerHTML;
{$ENDIF}
   property OnNewSession: TOnNewSession read FOnNewSession write FOnNewSession;
   property OnCloseSession: TOnCloseSession read FOnCloseSession write FOnCloseSession;
   property OnException: TOnPrismException read FOnPrismException write FOnPrismException;
   property OnDisconnectSession: TOnSessionEvent read FOnDisconnectSession write FOnDisconnectSession;
   property OnReconnectSession: TOnSessionEvent read FOnReconnectSession write FOnReconnectSession;
   property OnExpiredSession: TOnExpiredSession read FOnExpiredSession write FOnExpiredSession;
   property OnIdleSession: TOnIdleSession read FOnIdleSession write FOnIdleSession;
   property OnSecurity: TOnSecurityEvent read FOnSecurity write FOnSecurity;
   property Options: IPrismOptions read GetOptions;
 end;


function PrismBaseClass: TPrismBaseClass;

const
 SizeServerUUID = 10;


implementation

uses
  D2Bridge.Manager, D2Bridge.Forms, D2Bridge.Instance, Prism.Session, Prism.Session.Helper, Prism.Forms, Prism.Util,
  Prism.Options;


var PrismBaseClassInstance: TPrismBaseClass;

function PrismBaseClass: TPrismBaseClass;
begin
 Result:= PrismBaseClassInstance;
end;

function D2BridgeManager: TD2BridgeManager;
begin
 Result:= D2Bridge.Manager.D2BridgeManager;
end;



{ TPrismBaseClass }

constructor TPrismBaseClass.Create(AOwner: TComponent);
begin
 //FOwner:= AOwner;
 Inherited;

 FINIConfig:= TPrismINIConfig.Create;

 FPrismServerTCP:= TPrismServerTCP.Create;
 FPrismServerTCP.DefaultPort:= 8888;
 FPrismServerTCP.MaxConnections:= MaxInt;
 FPrismServerTCP.ListenQueue:= 0;

{$IFDEF D2BRIDGE}
  FPrismOptions:= TPrismOptions.Create;
  FPrismServerHTML:= TPrismServerHTML.Create(self);

  FPrismServerTCP.OnGetHTML:= FPrismServerHTML.GetHTML;
  FPrismServerTCP.OnReceiveMessage := FPrismServerHTML.ReceiveMessage;
  FPrismServerTCP.OnGetFile:= FPrismServerHTML.GetFile;
  FPrismServerTCP.OnFinishedGetHTML:= FPrismServerHTML.FinishedGetHTML;
  FPrismServerTCP.OnRESTData:= FPrismServerHTML.RESTData;
  FPrismServerTCP.OnDownloadData:= FPrismServerHTML.DownloadData;

  {$IFDEF FMX}
   FMXFakeForm:= TFMXFakeForm.Create(Application);
   FMXFakeForm.Hide;
  {$ENDIF}
{$ENDIF}

 FPrismServerHTMLHeaders:= TPrismServerHTMLHeaders.Create(Owner);

 FSessions:= TPrismSessions.Create;

 PrismBaseClassInstance:= self;

 FPrismTimer:= TPrismTimer.Create(Options.HeartBeatTime, OnTimerObserver);
end;


destructor TPrismBaseClass.Destroy;
begin
 {$IFDEF D2BRIDGE}
  {$IFDEF FMX}
   if Assigned(FMXFakeForm) then
   FreeAndNil(FMXFakeForm);
  {$ENDIF}

  Halt(0);
 {$ENDIF}
 FPrismServerTCP.Active:= false;
 FreeAndNil(FSessions);
 FreeAndNil(FPrismServerTCP);
 FreeAndNil(FPrismServerHTMLHeaders);
 {$IFDEF D2BRIDGE}
  (FPrismOptions as TPrismOptions).Destroy;
  FreeAndNil(FPrismServerHTML);
 {$ENDIF}
 FreeAndNil(FINIConfig);
 FreeAndNil(FPrismTimer);

 inherited;
end;

procedure TPrismBaseClass.DoCloseSession(const Session: IPrismSession);
var
 I: integer;
begin
 if Assigned(FServerController) then
 begin
{$IFDEF D2BRIDGE}
  Options.Security.IP.IPConnections.RemoveSession(Session);
{$ENDIF}

  Session.ExecThread(true,
   procedure
   begin
    try
     FServerController.DoSessionChange(scsCloseSession, Session);
    except
    end;
   end
  );
 end;

 if Assigned(FOnCloseSession) then
 begin
  Session.ExecThread(true,
   procedure
   begin
    try
     FOnCloseSession(Session as TPrismSession);
    except
    end;
   end
  );
 end;


// I:= Pred(FSessions.Count);
// repeat
//  if (FSessions.ToArray[I].Value.Closing) and (FSessions.ToArray[I].Value.ThreadIDs.Count <= 0) then
//  begin
//   CriticalSession.Enter;
//   try
//    TPrismSession(FSessions.ToArray[I].Value).Destroy;
//    FSessions.Remove(FSessions.ToArray[I].Value.UUID);
//   finally
//    CriticalSession.Leave;
//   end;
//  end;
//
//  Dec(I);
// until I < 0;




// for I:= 0 to Pred(FSessions.Count) do
// if (FSessions.ToArray[I].Value.Closing) and (FSessions.ToArray[I].Value.ThreadIDs.Count <= 0) then
// begin
//  CriticalSession.Enter;
//  try
//   TPrismSession(FSessions.ToArray[I].Value).Destroy;
//   FSessions.Remove(FSessions.ToArray[I].Value.UUID);
//   //break;
//  finally
//   CriticalSession.Leave;
//  end;
// end;
end;

procedure TPrismBaseClass.DoException(Sender: TObject; E: Exception; APrismSession: IPrismSession; EventName: string);
var
 vComponentName, vFormName: String;
 vForm: TObject;
begin
 try
  vComponentName:= '';
  vFormName:= '';
  vForm:= nil;

  if Assigned(Sender) then
   if Sender is TComponent then
    vComponentName:= TComponent(Sender).Name;

  if Assigned(APrismSession) then
   if Assigned(APrismSession.ActiveForm) then
   begin
    if TPrismForm(APrismSession.ActiveForm).D2BridgeForm <> nil then
    begin
     vForm:= TPrismForm(APrismSession.ActiveForm).D2BridgeForm;
     vFormName:= TPrismForm(vForm).Name;
    end;
   end;


  if Options.LogException then
  begin
   if Assigned(APrismSession) then
    FPrismLog.Log
     (
      APrismSession.InfoConnection.Identity,
      APrismSession.ActiveForm.Name,
      vComponentName,
      EventName,
      E.Message
     )
   else
    FPrismLog.Log
     (
      '',
      '',
      vComponentName,
      EventName,
      E.Message
     )

  end;

  if Assigned(FOnPrismException) then
   FOnPrismException(vForm, Sender, E, vFormName, vComponentName, EventName, APrismSession);
 except
 end;
end;

procedure TPrismBaseClass.DoExpireSession(const Session: IPrismSession);
begin

end;


procedure TPrismBaseClass.DoIdleSession(const Session: IPrismSession);
begin
 if Assigned(FServerController) then
 begin
  Session.ExecThread(false,
   procedure(ASession: TValue)
   var
    vSession: IPrismSession;
    vRenewTimeOut: Boolean;
   begin
    try
     vSession:= TPrismSession(ASession.AsObject);

     if Assigned(vSession) and (not vSession.Closing) then
      if (not vSession.Disconnected) and (not vSession.Idle) then
      begin
       TPrismSession(vSession).SetIdle(True);

       vRenewTimeOut:= false;

       repeat
        try
         if Assigned(FOnIdleSession) then
          FOnIdleSession(vSession as TPrismSession, vRenewTimeOut);

         if not vRenewTimeOut then
         begin
          TPrismSession(vSession).ShowMessageSessionIdle;
          break;
         end else
          Sleep(Options.SessionIdleTimeOut);
        except
        end;
       until (not vSession.Idle) or
             (vSession.Disconnected) or
             (vSession.Closing) or
             (not vRenewTimeOut);
      end;
    except
    end;
   end,
   TObject(Session)
  );
 end;
end;

procedure TPrismBaseClass.DoDisconnectSession(const Session: IPrismSession);
begin
 if Assigned(FServerController) then
 begin
  Session.ExecThread(false,
   procedure(ASession: TValue)
   var
    vSession: IPrismSession;
    vSecondsInDisconnect: Integer;
    vRenewTimeOut: Boolean;
   begin
    try
     vSession:= TPrismSession(ASession.AsObject);
     Sleep(TimeWaitDisconnectSession);

     if Assigned(vSession) and (not vSession.Closing) then
      if ((vSession.ConnectionStatus = scsLostConnectioSession) or (vSession.LastHeartBeatInSeconds > (Options.HeartBeatTime / 1000))) and
         (not vSession.Disconnected) then
      begin
       try
        TPrismSession(vSession).SetDisconnect(true);
       except
       end;

       if Assigned(FOnDisconnectSession) then
       begin
        try
         FOnDisconnectSession(vSession as TPrismSession);
        except
        end;
       end;


       {$REGION 'Session Expire'}
        vRenewTimeOut:= false;
        vSecondsInDisconnect:= vSession.DisconnectedInSeconds;

        repeat
         try
          Sleep(Options.SessionTimeOut * 1000);

          if Assigned(vSession) and (not vSession.Closing) then
           if ((vSession.ConnectionStatus = scsLostConnectioSession) or (vSession.LastHeartBeatInSeconds > (Options.HeartBeatTime / 1000))) and
              (vSession.Disconnected) then
           begin
            if Assigned(FOnExpiredSession) then
            begin
             try
              FOnExpiredSession(vSession as TPrismSession, vRenewTimeOut);
             except
             end;
            end;

           if not vRenewTimeOut then
           begin
            try
             vSession.Close(false);
            except
            end;
            break;
           end else
           try
            vSecondsInDisconnect:= vSession.DisconnectedInSeconds;
           except
           end;
          end;
         except
         end;

        until (not Assigned(vSession)) or (vSecondsInDisconnect > vSession.DisconnectedInSeconds) or
              (not vSession.Disconnected) or
              (vSession.Closing) or
              (not vRenewTimeOut);
       {$ENDREGION}
      end;
    except
    end;
   end,
   TObject(Session)
  );
 end;
end;

procedure TPrismBaseClass.DoNewSession(const Request: TPrismHTTPRequest; const Response: TPrismHTTPResponse; const Session: IPrismSession);
begin
 if Assigned(FServerController) then
 begin
{$IFDEF D2BRIDGE}
  Options.Security.IP.IPConnections.AddSession(Session);
{$ENDIF}

  Session.ExecThread(true,
   procedure
   begin
    try
     FServerController.DoSessionChange(scsNewSession, Session);
    except
    end;
   end
  );
 end;

 if Assigned(FOnNewSession) then
 begin
  Session.ExecThread(true,
   procedure
   begin
    try
//     if Options.CoInitialize then
//      CoInitializeEx(0, COINIT_MULTITHREADED);

     FOnNewSession(Request, Response, (Session as TPrismSession));
    except
    end;
   end
  );
 end;
end;

procedure TPrismBaseClass.DoReconnectSession(const Session: IPrismSession);
begin
 if Assigned(FServerController) then
 begin
  Session.ExecThread(false,
   procedure(ASession: TValue)
   var
    vSession: IPrismSession;
   begin
    try
     vSession:= TPrismSession(ASession.AsObject);
     //Sleep(5000);

     if Assigned(vSession) and (not vSession.Closing) then
      if (vSession.ConnectionStatus = scsActiveSession) and (vSession.Disconnected) then
      begin
       try
        TPrismSession(vSession).SetDisconnect(false);
       except
       end;

       try
        if Assigned(FOnReconnectSession) then
         FOnReconnectSession(vSession as TPrismSession);
       except
       end;
      end;
    except
    end;
   end,
   TObject(Session)
  );
 end;

end;

procedure TPrismBaseClass.DoSecurity(const SecEventInfo: TSecuritEventInfo);
var
 vSecEventInfo: TSecuritEventInfo;
begin
 if Assigned(FOnSecurity) then
 begin
  vSecEventInfo:= SecEventInfo;

  TThread.CreateAnonymousThread(
   procedure
   begin
    FOnSecurity(vSecEventInfo);
   end
  ).Start;
 end;
end;

function TPrismBaseClass.GetOptions: IPrismOptions;
begin
 Result:= FPrismOptions;
end;

function TPrismBaseClass.GetServerPort: Integer;
begin
 Result:= FPrismServerTCP.DefaultPort;
end;

function TPrismBaseClass.INIConfig: IPrismINIConfig;
begin
 Result:= FINIConfig;
end;

procedure TPrismBaseClass.InstancePrimaryForm(APrismSession: IPrismSession);
var
 vD2BridgeForm: TD2BridgeForm;
begin
 {$IFDEF D2BRIDGE}

 if D2BridgeManager.PrimaryFormClass <> nil then
 begin
  vD2BridgeForm:= TD2BridgeFormClass(D2BridgeManager.PrimaryFormClass).Create(TPrismSession(APrismSession), TPrismSession(APrismSession));
  TD2BridgeInstance(APrismSession.D2BridgeInstance).AddInstace(vD2BridgeForm);
  TPrismSession(APrismSession).SetPrimaryForm(vD2BridgeForm);
  vD2BridgeForm.DoShow;

  //vD2BridgeForm.show;// WindowAsync(vD2BridgeForm.Handle, SW_HIDE);
  //vD2BridgeForm.Show;
  //vD2BridgeForm.Show;


  //TD2BridgeFormClass(D2BridgeManager.PrimaryFormClass).CreateInstance(TPrismSession(APrismSession));
 end else
 raise Exception.Create('Error Instance Primary Form: Error 1001');
 {$ELSE}

 {$ENDIF}

end;

procedure TPrismBaseClass.Log(const SessionIdenty, ErrorForm, ErrorObject,
  ErrorEvent, ErrorMsg: string);
begin
 if Assigned(FPrismLog) then
  FPrismLog.Log(SessionIdenty, ErrorForm, ErrorObject, ErrorEvent, ErrorMsg);
end;

procedure TPrismBaseClass.OnTimerObserver;
var
 vSessions: TList<IPrismSession>;
 vSession: IPrismSession; 
begin
 FPrismTimer.Pause;

 try
  try
   vSessions:= Sessions.Items;

   for vSession in vSessions do
   begin
    try
     if Assigned(vSession) and
        (not vSession.Closing) then
     begin
      if (Options.SessionTimeOut > 0) and
         (vSession.LastHeartBeatInSeconds > (Options.HeartBeatTime / 1000)) and
         (not vSession.Disconnected) then
      begin
       DoDisconnectSession(vSession);
      end else
       if Options.SessionIdleTimeOut > 0 then
       begin
        if (vSession.LastActivityInSeconds > Options.SessionIdleTimeOut) and
           (not vSession.Disconnected) then
        begin
         DoIdleSession(vSession);
        end;
       end else
        if (vSession.LastActivityInSeconds <= Options.SessionIdleTimeOut) and
           (vSession.Idle) then
        begin
         TPrismSession(vSession).SetIdle(false);
        end;
      end;
    except
    end;
   end;
  except
  end;
 finally
  FreeAndNil(vSessions);
  FPrismTimer.Resume;
 end;
end;

{$IFDEF D2BRIDGE}
procedure TPrismBaseClass.SavePrismSupportFiles;
var
 ResInfo: HRSRC;
 ResStream: TResourceStream;
 vFileStream: TStringStream;
begin
 {$REGION 'prismserver.js'}
  ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_JS_PrismServer'), RT_RCDATA);
  if ResInfo <> 0 then
  begin
   try
    ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_JS_PrismServer', RT_RCDATA);
    ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathJS + '\prismserver.js');
   except
    ResStream.Free;
   end;
  end;
 {$ENDREGION}

 {$REGION 'd2bridgeloader.js'}
  ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_JS_D2BridgeLoader'), RT_RCDATA);
  if ResInfo <> 0 then
  begin
   try
    ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_JS_D2BridgeLoader', RT_RCDATA);
    vFileStream:= TStringStream.Create('', TEncoding.UTF8);
    ResStream.SaveToStream(vFileStream);
    FPrismServerHTML.FFileD2BridgeLoader:= vFileStream.DataString;
    //ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathJS + '\d2bridgeloader.js');
   except
    vFileStream.Free;
   end;
  end;
 {$ENDREGION}

 {$REGION 'jquery.jqgrid.min.js'}
  if PrismBaseClass.Options.IncludeJQGrid then
  begin
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_JS_JQGrid'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_JS_JQGrid', RT_RCDATA);
     ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathJS + '\jquery.jqgrid.min.js');
    except
     ResStream.Free;
    end;
   end;
  end;
 {$ENDREGION}

 {$REGION 'jquery.inputmask.js'}
  if PrismBaseClass.Options.IncludeInputMask then
  begin
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_JS_JQInputMask'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_JS_JQInputMask', RT_RCDATA);
     ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathJS + '\jquery.inputmask.js');
    except
     ResStream.Free;
    end;
   end;
  end;
 {$ENDREGION}

 {$REGION 'jquery-3.6.4.js'}
  if PrismBaseClass.Options.IncludeJQuery then
  begin
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_JS_JQuery_3_6_4'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_JS_JQuery_3_6_4', RT_RCDATA);
     ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathJS + '\jquery-3.6.4.js');
    except
     ResStream.Free;
    end;
   end;
  end;
 {$ENDREGION}

 {$REGION 'sweetalert2.js'}
  if PrismBaseClass.Options.IncludeSweetAlert2 then
  begin
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_JS_SweetAlert2'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_JS_SweetAlert2', RT_RCDATA);
     ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathJS + '\sweetalert2.js');
    except
     ResStream.Free;
    end;
   end;
  end;
 {$ENDREGION}

 {$REGION 'd2bridge.css'}
  ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_CSS_D2Bridge'), RT_RCDATA);
  if ResInfo <> 0 then
  begin
   try
    ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_CSS_D2Bridge', RT_RCDATA);
    ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathCSS + '\d2bridge.css');
   except
    ResStream.Free;
   end;
  end;
 {$ENDREGION}

 {$REGION 'ui.jqgrid-bootstrap5.css'}
  if PrismBaseClass.Options.IncludeJQGrid then
  begin
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_CSS_JQGrid'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_CSS_JQGrid', RT_RCDATA);
     ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathCSS + '\ui.jqgrid-bootstrap5.css');
    except
     ResStream.Free;
    end;
   end;
  end;
 {$ENDREGION}

 {$REGION 'sweetalert2.css'}
  if PrismBaseClass.Options.IncludeSweetAlert2 then
  begin
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Assets_CSS_SweetAlert2'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Assets_CSS_SweetAlert2', RT_RCDATA);
     ResStream.SaveToFile(Options.RootDirectory + PrismBaseClass.Options.PathCSS + '\sweetalert2.css');
    except
     ResStream.Free;
    end;
   end;
  end;
 {$ENDREGION}

 {$REGION 'error500.html'}
  ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_HTML_Error500'), RT_RCDATA);
  if ResInfo <> 0 then
  begin
   try
    ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_HTML_Error500', RT_RCDATA);
    vFileStream:= TStringStream.Create('', TEncoding.UTF8);
    ResStream.SaveToStream(vFileStream);
    FPrismServerHTML.FFileError500:= vFileStream.DataString;
    //ResStream.SaveToFile(Options.RootDirectory + '\error500.html');
   except
    FPrismServerHTML.Free;
   end;
  end;
 {$ENDREGION}

 {$REGION 'error429.html'}
  ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_HTML_Error429'), RT_RCDATA);
  if ResInfo <> 0 then
  begin
   try
    ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_HTML_Error429', RT_RCDATA);
    vFileStream:= TStringStream.Create('', TEncoding.UTF8);
    ResStream.SaveToStream(vFileStream);
    FPrismServerHTML.FFileError429:= vFileStream.DataString;
    //ResStream.SaveToFile(Options.RootDirectory + '\error500.html');
   except
    FPrismServerHTML.Free;
   end;
  end;
 {$ENDREGION}

 {$REGION 'error403blacklist.html'}
  ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_HTML_Error403blacklist'), RT_RCDATA);
  if ResInfo <> 0 then
  begin
   try
    ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_HTML_Error403blacklist', RT_RCDATA);
    vFileStream:= TStringStream.Create('', TEncoding.UTF8);
    ResStream.SaveToStream(vFileStream);
    FPrismServerHTML.FFileErrorBlacklist:= vFileStream.DataString;
    //ResStream.SaveToFile(Options.RootDirectory + '\error500.html');
   except
    FPrismServerHTML.Free;
   end;
  end;
 {$ENDREGION}

 {$REGION 'CORE'}
  {$REGION 'Core variable'}
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Core_Variables'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Core_Variables', RT_RCDATA);
     vFileStream:= TStringStream.Create('', TEncoding.UTF8);
     ResStream.SaveToStream(vFileStream);
     FPrismServerHTMLHeaders.FCoreVariable:= vFileStream.DataString;
    except
     vFileStream.Free;
     ResStream.Free;
    end;
   end;
  {$ENDREGION}

  {$REGION 'Core SetConnection'}
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Core_SetConnection'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Core_SetConnection', RT_RCDATA);
     vFileStream:= TStringStream.Create('', TEncoding.UTF8);
     ResStream.SaveToStream(vFileStream);
     FPrismServerHTMLHeaders.FCoreSetConnection:= vFileStream.DataString;
    except
     vFileStream.Free;
     ResStream.Free;
    end;
   end;
  {$ENDREGION}

  {$REGION 'Core PrismWS'}
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Core_PrismWS'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Core_PrismWS', RT_RCDATA);
     vFileStream:= TStringStream.Create('', TEncoding.UTF8);
     ResStream.SaveToStream(vFileStream);
     FPrismServerHTMLHeaders.FCorePrismWS:= vFileStream.DataString;
    except
     vFileStream.Free;
     ResStream.Free;
    end;
   end;
  {$ENDREGION}

  {$REGION 'Core PrismMethods'}
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Core_PrismMethods'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Core_PrismMethods', RT_RCDATA);
     vFileStream:= TStringStream.Create('', TEncoding.UTF8);
     ResStream.SaveToStream(vFileStream);
     FPrismServerHTMLHeaders.FCorePrismMethods := vFileStream.DataString;
    except
     vFileStream.Free;
     ResStream.Free;
    end;
   end;
  {$ENDREGION}

  {$REGION 'Core CallbackPrismMethods'}
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Core_CallbackPrismMethods'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Core_CallbackPrismMethods', RT_RCDATA);
     vFileStream:= TStringStream.Create('', TEncoding.UTF8);
     ResStream.SaveToStream(vFileStream);
     FPrismServerHTMLHeaders.FCoreCallBackPrismMethods := vFileStream.DataString;
    except
     vFileStream.Free;
     ResStream.Free;
    end;
   end;
  {$ENDREGION}

  {$REGION 'Core D2BridgeKanban'}
   ResInfo := FindResource(HInstance, PWideChar('PRISM_Support_Core_D2BridgeKanban'), RT_RCDATA);
   if ResInfo <> 0 then
   begin
    try
     ResStream := TResourceStream.Create(HInstance, 'PRISM_Support_Core_D2BridgeKanban', RT_RCDATA);
     vFileStream:= TStringStream.Create('', TEncoding.UTF8);
     ResStream.SaveToStream(vFileStream);
     FPrismServerHTMLHeaders.FCoreD2BridgeKanban := vFileStream.DataString;
    except
     vFileStream.Free;
     ResStream.Free;
    end;
   end;
  {$ENDREGION}

 {$ENDREGION}
end;
{$ENDIF}

function TPrismBaseClass.ServerUUID: string;
begin
 result:= FServerUUID;
end;


function TPrismBaseClass.Sessions: IPrismSessions;
begin
 Result:= FSessions;
end;


procedure TPrismBaseClass.SetServerPort(APort: Integer);
begin
 FPrismServerTCP.DefaultPort:= APort;
end;

function TPrismBaseClass.SSLOptions: TIdSSLOptions;
begin
 result:= FPrismServerTCP.OpenSSL.SSLOptions;
end;

function TPrismBaseClass.Started: boolean;
begin
 Result:= FPrismServerTCP.Active;
end;

procedure TPrismBaseClass.StartServer;
begin
 if not FPrismServerTCP.Active then
 begin
  FServerUUID:= GenerateRandomString(SizeServerUUID);

  {$REGION 'INI Config'}
  if Options.UseINIConfig then
  begin
   INIConfig.FileINIConfig.WriteInteger('D2Bridge Server Config', 'Server Port', ServerPort);
   INIConfig.FileINIConfig.WriteString('D2Bridge Server Config', 'Server Name', ServerController.ServerName);
   INIConfig.FileINIConfig.WriteString('D2Bridge Server Config', 'Server Description', ServerController.ServerName);
  end;
  {$ENDREGION}

  {$REGION 'SSL'}
  if Options.SSL then
  begin
   SSLOptions.Mode := sslmServer;
   SSLOptions.VerifyMode := [];
   SSLOptions.VerifyDepth  := 2;
   SSLOptions.SSLVersions := [sslvSSLv2, sslvTLSv1_1, sslvTLSv1_2, sslvSSLv23, sslvSSLv3];

   FPrismServerTCP.IOHandler := FPrismServerTCP.OpenSSL;
  end;
  {$ENDREGION}

  FPrismServerTCP.Bindings.Clear;
  FPrismServerTCP.DefaultPort := ServerPort;

  if FPrismOptions.LogException then
   FPrismLog:= TPrismLog.Create(FPrismOptions.LogFile);

  if not DirectoryExists(Options.RootDirectory) then
  MkDir(Options.RootDirectory);

  if not DirectoryExists(Options.RootDirectory + PrismBaseClass.Options.PathCSS) then
  MkDir(Options.RootDirectory + PrismBaseClass.Options.PathCSS);

  if not DirectoryExists(Options.RootDirectory + PrismBaseClass.Options.PathJS) then
  MkDir(Options.RootDirectory + PrismBaseClass.Options.PathJS);

  if not DirectoryExists(Options.RootDirectory + 'temp') then
  MkDir(Options.RootDirectory + 'temp');

  if DirectoryExists(Options.RootDirectory + 'temp\Sessions') then
  begin
   TDirectory.Delete(Options.RootDirectory + 'temp\Sessions', true);
  end;
  if not DirectoryExists(Options.RootDirectory + 'temp\Sessions') then
  MkDir(Options.RootDirectory + 'temp\Sessions');

  //Expand Files Support
{$IFDEF D2BRIDGE}
  SavePrismSupportFiles;
{$ENDIF}


  FPrismServerTCP.Active := True;

  FPrismTimer.Resume;
 end;
end;

procedure TPrismBaseClass.StopServer;
begin
 FPrismServerTCP.Active := False;
 FPrismServerTCP.CloseAllConnection;
 FPrismServerTCP.Bindings.Clear;

 if Assigned(FPrismLog) then
 FreeAndNil(FPrismLog);

 FPrismTimer.Pause;
end;

{ TPrismBaseClass.TPrismOptions }



{ TPrismBaseClass.TPrismINIConfig }

constructor TPrismBaseClass.TPrismINIConfig.Create;
begin
 FFileINIConfig:= TIniFile.Create(ExtractFilePath(GetModuleName(HInstance))+'Config.ini');;
end;

destructor TPrismBaseClass.TPrismINIConfig.Destroy;
begin
 FFileINIConfig.Free;

 inherited;
end;

function TPrismBaseClass.TPrismINIConfig.FileINIConfig: TIniFile;
begin
 Result:= FFileINIConfig;
end;

function TPrismBaseClass.TPrismINIConfig.ServerDescription(
  ADefaultServerDescription: String): String;
begin
 Result:= FFileINIConfig.ReadString('D2Bridge Server Config', 'Server Name', ADefaultServerDescription);
end;

function TPrismBaseClass.TPrismINIConfig.ServerName(
  ADefaultServerName: String): String;
begin
 Result:= FFileINIConfig.ReadString('D2Bridge Server Config', 'Server Name', ADefaultServerName);
end;

function TPrismBaseClass.TPrismINIConfig.ServerPort(
  ADefaultPort: Integer): Integer;
begin
 Result:= FFileINIConfig.ReadInteger('D2Bridge Server Config', 'Server Port', ADefaultPort);
end;

end.
