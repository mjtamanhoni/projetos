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

unit Prism.Session;

interface

uses
  System.Classes, System.Generics.Collections, System.SysUtils, System.IOUtils, System.SyncObjs,
  System.DateUtils, System.JSON, System.Threading, System.UITypes, System.Rtti, IdContext,
{$IFDEF MSWINDOWS}
  WinApi.Windows,
{$ENDIF}
{$IFDEF FMX}
  FMX.Forms, FMX.Dialogs,
{$ELSE}
  Vcl.Forms, Vcl.Dialogs,
{$ENDIF}
  Prism.Interfaces, Prism.Session.Thread, Prism.Session.Thread.Proc, Prism.Types,
  D2Bridge.Interfaces, D2Bridge.Types, D2Bridge.Lang.Interfaces, D2Bridge.Lang.Term,
  D2Bridge.Lang.APP.Term;


type
 TPrismSession = class(TComponent, IPrismSession)
  private
   FToken: String;
   FUUID: String;
   FCallBackID: String;
   FPushID: string;
   FCreateDate: TDateTime;
   FD2BridgeInstance: TObject;
   FPrismBaseClass: IPrismBaseClass;
   FD2BridgeBaseClass: TObject;
   FD2BridgeForms: TList<TObject>;
   FIPrismCallBacks: IPrismCallBacks;
   FData: TObject;
   FThreads: TList<TPrismSessionThread>;
   FLockName: TList<string>;
   FThreadIDs: TList<integer>;
   FFileDownloads: TDictionary<string, string>;
   FClosing: Boolean;
   FCriticalThreadSession: TCriticalSection;
   FInfoConnection: IPrismSessionInfo;
   FURI: IPrismURI;
   FClipboard: IPrismClipboard;
   FLanguageNav: TD2BridgeLang;
   FLanguage: TD2BridgeLang;
   FScriptJSSafeMode: TStrings;
   FFormatSettings: TFormatSettings;
   FActive: boolean;
   FRecovering: boolean;
   FCookies: IPrismCookies;
   FConnectionStatus: TSessionConnectionStatus;
   FDisconnect: Boolean;
   FDisconnectStartTime: TDateTime;
   FWebSocketContext: TIdContext;
   function GetD2BridgeBaseClass: TObject;
   procedure SetD2BridgeBaseClass(AD2BridgeBaseClass: TObject);
   Function GetD2BridgeInstance: TObject;
   function GetToken: string;
   function GetUUID: string;
   function GetCallBackID: string;
   function GetPushID: string;
   Function GetActiveForm: IPrismForm;
   function GetD2BridgeForms: TList<TObject>;
   function GetCallBacks: IPrismCallBacks;
   procedure SetData(AValue: TObject);
   function GetData: TObject;
   function GetD2BridgeManager: TObject;
   function GetThreadIDs: TList<integer>;
   function GetFileDownloads: TDictionary<string, string>;
   function GetLanguageNav: TD2BridgeLang;
   procedure SetLanguageNav(const Value: TD2BridgeLang);
   function GetFormatSettings: TFormatSettings;
   function GetWebSocketContext: TIdContext;
   procedure SetFormatSettings(const Value: TFormatSettings);
   procedure SetWebSocketContext(const Value: TIdContext);
  protected
   FD2BridgeFormPrimary: TObject;
   FReloading: boolean;
   FIdle: Boolean;
   FLastHeartBeat: TDateTime;
   FLastActivity: TDateTime;
   Procedure SetActive(Value: Boolean);
   procedure SetRecovering(Value: boolean);
   procedure RenewUUID;
   procedure DoConnectionStatus(AConnectionStatus: TSessionConnectionStatus);
   procedure BeginDisconnect;
   procedure EndDisconnect;
  public
   constructor Create(AOwner: IPrismBaseClass); reintroduce; virtual;
   destructor Destroy; override;

   function Lang: TD2BridgeTerm;
   function LangNav: TD2BridgeTerm;
   function LangAPPIsPresent: Boolean;
   function LangAPP: TD2BridgeAPPTerm;
   function Language: TD2BridgeLang;
   function LangName: string;
   function LangCode: string;

   function URI: IPrismURI;
   function Clipboard: IPrismClipboard;
   function Cookies: IPrismCookies;

   function CreateDate: TDateTime;
   function PathSession: String;
   Function ActiveFormByFormUUID(AFormUUID: String): IPrismForm;
   function PrimaryForm: TObject;

   procedure DoFormPageLoad(APrismForm: IPrismForm);
   procedure ExecJS(ScriptJS: String; SafeMode: Boolean = false);
   function ExecJSResponse(ScriptJS: String; ATimeout: integer = 60; SafeMode: Boolean = false): string;
   procedure Redirect(AURL: string; ANewPage:Boolean = false);
   procedure SendFile(FullFilePath: String; OpenOnFinishDownload: Boolean = false; WebFileName: String = '');
   function SendFileLink(FullFilePath: String): string;

   procedure UnLock(AWaitName: String);
   procedure UnLockAll;
   procedure Lock(const AWaitName: String; const ATimeOut: integer = 0);
   function LockExists(AWaitName: String): boolean;

   procedure ShowMessageError(const Msg: string; ASyncMode : Boolean = true; useToast: boolean = false; TimerInterval: integer = 4000; ToastPosition: TToastPosition = ToastTopRight); overload;
   procedure ShowMessage(const Msg: string; useToast: boolean; TimerInterval: integer = 4000; DlgType: TMsgDlgType = TMsgDlgType.mtInformation; ToastPosition: TToastPosition = ToastTopRight); overload;
   procedure ShowMessage(const Msg: string; useToast: boolean; ASyncMode : Boolean; TimerInterval: integer = 4000; DlgType: TMsgDlgType = TMsgDlgType.mtInformation; ToastPosition: TToastPosition = ToastTopRight); overload;
   procedure ShowMessage(const Msg: string); overload;
   function MessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
   function MessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; ACallBackName: string): Integer; overload;
   {$IFNDEF FMX}function MessageBox(const Text, Caption: PChar; Flags: Longint): Integer;{$ENDIF}

   procedure Close(ACreateNewSession: Boolean = false);
   function Closing: boolean;
   function Recovering: boolean;
   function Reloading: boolean;

   function Active: boolean;
   function Disconnected: Boolean;
   function DisconnectedInSeconds: integer;
   function ConnectionStatus: TSessionConnectionStatus;
   function LastHeartBeat: TDateTime;
   function LastHeartBeatInSeconds: integer;
   function LastActivity: TDateTime;
   function LastActivityInSeconds: integer;
   function Idle: Boolean;
   function IdleInSeconds: integer;

   function InfoConnection: IPrismSessionInfo;

   procedure ExecThreadSynchronize(AProc: TProc);
   procedure ExecThread(AProc: TProc); overload;
   procedure ExecThread(AWait: Boolean; AProc: TProc); overload;
   procedure ExecThread(AWait: Boolean; AProc: TProc<TValue>; var1: TValue); overload;
   procedure ExecThread(AWait: Boolean; AProc: TProc<TValue, TValue>; var1, var2: TValue); overload;
   procedure ExecThread(AWait: Boolean; AProc: TProc<TValue, TValue, TValue>; var1, var2, var3: TValue); overload;
   procedure ExecThread(AWait: Boolean; AProc: TProc<TValue,TValue,TValue,TValue>; var1, var2, var3, var4: TValue); overload;
   //procedure ExecThread<T>(AWait: Boolean; AProc: TProc<T>; var1: T); overload;

   procedure ThreadAddCurrent;
   procedure ThreadRemoveCurrent;

   procedure DoException(Sender: TObject; E: Exception; EventName: string);

   property Token: string read GetToken;
   property UUID: string read GetUUID;
   property CallBackID: string read GetCallBackID;
   property PushID: string read GetPushID;
   property ActiveForm: IPrismForm read GetActiveForm;
   property D2BridgeForms: TList<TObject> read GetD2BridgeForms;
   property D2BridgeInstance: TObject read GetD2BridgeInstance;
   property D2BridgeBaseClassActive: TObject read GetD2BridgeBaseClass write SetD2BridgeBaseClass;
   property D2BridgeManager: TObject read GetD2BridgeManager;
   property LanguageNav: TD2BridgeLang read GetLanguageNav write SetLanguageNav;
   property CallBacks: IPrismCallBacks read GetCallBacks;
   property Data: TObject read GetData write SetData;
   property ThreadIDs: TList<integer> read GetThreadIDs;
   property FileDownloads: TDictionary<string, string> read GetFileDownloads;
   property FormatSettings: TFormatSettings read GetFormatSettings write SetFormatSettings;
   property WebSocketContext: TIdContext read GetWebSocketContext write SetWebSocketContext;
 end;

const
 SizeToken = 24;
 SizeUUID = 12;
 SizeCallBackID = 9;
 SizePushID = 16;

implementation

uses
  Prism.Util, Prism.Forms, Prism.CallBack, Prism.BaseClass, Prism.Session.Info, Prism.URI,
  Prism.Clipboard, Prism.Cookie,
  D2Bridge.Instance, D2Bridge.Manager, D2Bridge.BaseClass, D2Bridge.Forms, D2Bridge.Lang.Core,
  D2Bridge.Lang.Util, D2Bridge.ServerControllerBase, D2Bridge.Lang.APP.Core, D2Bridge.Util;


{ TPrismSession }

function TPrismSession.Active: boolean;
begin
 Result:= FActive;
end;

function TPrismSession.ActiveFormByFormUUID(AFormUUID: String): IPrismForm;
var
 I, J, K, L: Integer;
 D2BridgeClass, vNestedBridgeClass, vNestedBridgeClass2, vNestedBridgeClass3, vNestedBridgeClass4: TD2BridgeClass;
 vBreakAll: boolean;
begin
 if Assigned(TD2BridgeClass(D2BridgeBaseClassActive).Form) then
 begin
  vBreakAll:= false;
  D2BridgeClass:= TD2BridgeClass(D2BridgeBaseClassActive);
  if (D2BridgeClass.Form as TPrismForm).FormUUID = AFormUUID then
  Result:= (D2BridgeClass.Form as TPrismForm)
  else
  begin
   for I := 0 to D2BridgeClass.NestedCount-1 do
   begin
    vNestedBridgeClass:= D2BridgeClass.Nested(I);
    if TPrismForm(vNestedBridgeClass.Form).FormUUID = AFormUUID then
    begin
     Result:= TPrismForm(vNestedBridgeClass.Form);
     Break;
    end;

    for J := 0 to Pred(vNestedBridgeClass.NestedCount) do
    begin
     vNestedBridgeClass2:= vNestedBridgeClass.Nested(J);
     if TPrismForm(vNestedBridgeClass2.Form).FormUUID = AFormUUID then
     begin
      Result:= TPrismForm(vNestedBridgeClass2.Form);
      vBreakAll:= true;
      break;
     end;

     for k := 0 to Pred(vNestedBridgeClass2.NestedCount) do
     begin
      vNestedBridgeClass3:= vNestedBridgeClass2.Nested(k);
      if TPrismForm(vNestedBridgeClass3.Form).FormUUID = AFormUUID then
      begin
       Result:= TPrismForm(vNestedBridgeClass3.Form);
       vBreakAll:= true;
       break;
      end;

      for L := 0 to Pred(vNestedBridgeClass3.NestedCount) do
      begin
       vNestedBridgeClass4:= vNestedBridgeClass3.Nested(k);
       if TPrismForm(vNestedBridgeClass4.Form).FormUUID = AFormUUID then
       begin
        Result:= TPrismForm(vNestedBridgeClass4.Form);
        vBreakAll:= true;
        break;
       end;
      end;

      if vBreakAll then
       break;
     end;

     if vBreakAll then
      break;
    end;

    if vBreakAll then
     break;

   end;
  end;
 end;

end;

procedure TPrismSession.BeginDisconnect;
begin
 FDisconnectStartTime:= now;
 FDisconnect:= true;
end;

function TPrismSession.Closing: boolean;
begin
 result:= FClosing;
end;

function TPrismSession.ConnectionStatus: TSessionConnectionStatus;
begin
 Result:= FConnectionStatus;
end;

function TPrismSession.Cookies: IPrismCookies;
begin
 Result:= FCookies;
end;

constructor TPrismSession.Create(AOwner: IPrismBaseClass);
begin
 {$IFDEF D2BRIDGE}
 //PrismBaseClass.CriticalSession.Enter;
 FScriptJSSafeMode:= TStringList.Create;
 FCookies:= TPrismCookies.Create(self);
 {$ENDIF}

 try
  try
   //Inherited Create(TComponent(AOwner));
   Inherited Create(nil);

   FActive:= true;
   FRecovering:= false;
   FClosing:= false;
   FPrismBaseClass:= AOwner;

   FToken:= GenerateRandomString(SizeToken);
   FUUID:= GenerateRandomString(SizeUUID);
   FCallBackID:= GenerateRandomNumber(SizeCallBackID);
   FPushID:= GenerateRandomString(SizePushID);
   FCreateDate:= now;
   FD2BridgeForms:= TList<TObject>.Create;
   FIPrismCallBacks:= TPrismCallBacks.Create(self);

   {$IFDEF D2BRIDGE}
    FD2BridgeInstance:= TD2BridgeInstance.Create(self);
   {$ELSE}
    FD2BridgeInstance:= D2Bridge.Instance.D2BridgeInstance;
   {$ENDIF}

   {$IFDEF D2BRIDGE}
   if not DirectoryExists(PathSession) then
    TDirectory.CreateDirectory(TPath.GetDirectoryName(PathSession));
   {$ENDIF}

   FLockName:= TList<string>.Create;
   FThreadIDS:= TList<integer>.Create;
   FFileDownloads:= TDictionary<string, string>.Create;

   FThreads:= TList<TPrismSessionThread>.Create;

   FCriticalThreadSession:= TCriticalSection.Create;

   FInfoConnection:= TPrismSessionInfo.Create(self);

   FURI:= TPrismURI.Create;
   FClipboard:= TPrismClipboard.Create(Self);

   FReloading:= false;
   FConnectionStatus:= scsNone;
   FDisconnect:= false;

   FLastActivity:= now;
   FLastHeartBeat:= now;
  except
  end;
 finally
  {$IFDEF D2BRIDGE}
  //PrismBaseClass.CriticalSession.Leave;
  {$ENDIF}
 end;
end;

function TPrismSession.CreateDate: TDateTime;
begin
 Result:= FCreateDate;
end;

function TPrismSession.Clipboard: IPrismClipboard;
begin
 Result:= FClipboard;
end;

procedure TPrismSession.Close(ACreateNewSession: Boolean = false);
var
 I: Integer;
begin
 if not ACreateNewSession then
 begin
  try
   ExecJS(
    'prismws = null;' + sLineBreak +
    'window.location.href = ''about:blank'';'
   );
  except
  end;

  try
   PrismBaseClass.PrismServer.DisconnectWebSocketMessage(Self, true);
  except
  end;
 end;

 FClosing:= true;

 UnLockAll;

 if Assigned(PrismBaseClass.ServerController) then
  PrismBaseClass.ServerController.DoSessionChange(scsClosingSession, self);

 try
  PrismBaseClass.DoCloseSession(self);
 except
 end;

 try
  Destroy;
 except
 end;
end;

destructor TPrismSession.Destroy;
var
 I: integer;
 vExistD2BridgeForm: Boolean;
 vD2BridgeForm: TComponent;
begin
 try
  {$IFDEF D2BRIDGE}
  try
   if Assigned(FWebSocketContext) then
   begin
    ExecJS(
     'prismws = null;' + sLineBreak +
     'window.location.href = ''about:blank'';'
    );

    PrismBaseClass.PrismServer.DisconnectWebSocketMessage(self, true);
   end;
  except
  end;
  {$ENDIF}

  {$IFDEF D2BRIDGE}
   if Assigned(PrismBaseClass.ServerController) then
    PrismBaseClass.ServerController.DoSessionChange(scsDestroySession, self);
  {$ENDIF}

  {$IFDEF D2BRIDGE}
  vExistD2BridgeForm:= false;
  repeat
   vExistD2BridgeForm:= false;

   for I := Pred(ComponentCount) downto 0 do
    if (Components[I] is TD2BridgeForm) and (Components[I] <> nil) then
    begin
     vExistD2BridgeForm:= true;

     try
      vD2BridgeForm:= Components[I];
      Self.RemoveComponent(Components[I]);
      vD2BridgeForm.Destroy;
      vD2BridgeForm:= nil;
     except
     end;

     break;
    end;

  until vExistD2BridgeForm = false;;
  {$ENDIF}

  {$IFDEF D2BRIDGE}
   TPrismCookies(FCookies).Destroy;
   FCookies:= nil;
  {$ENDIF}

// for I := Pred(FThreads.Count) downto 0 do
// begin
//  FThreads[I].Resume;
//  FThreads[I].Stop;
//  FThreads[I].Destroy;
// end;
// FThreads.Clear;
// FThreadIDs.Clear;

  {$IFDEF D2BRIDGE}
  try
   PrismBaseClass.Sessions.Delete(UUID);
  except
  end;
  {$ENDIF}

  if Assigned(FURI) then
  begin
   TPrismURI(FURI).Destroy;
   FURI:= nil;
  end;

  if Assigned(FClipboard) then
  begin
   TPrismClipboard(FClipboard).Destroy;
   FClipboard:= nil;
  end;

  TPrismCallBacks(FIPrismCallBacks).Destroy;

  if Assigned(FData) then
  begin
   FreeAndNil(FData);
  end;

  FreeAndNil(FLockName);
  {$IFDEF D2BRIDGE}
  if Assigned(FScriptJSSafeMode) then
   FScriptJSSafeMode.Free;
  if Assigned(FD2BridgeInstance) then
   FreeAndNil(FD2BridgeInstance);
  {$ENDIF}

  if Assigned(FFileDownloads) then
   FreeAndNIl(FFileDownloads);

  if Assigned(FInfoConnection) then
  begin
   TPrismSessionInfo(FInfoConnection).Destroy;
   FInfoConnection:= nil;
  end;

  if Assigned(FThreads) then
  begin
   for I := Pred(FThreads.Count) downto 0 do
   begin
    try
     FThreads[I].Stop;
     FThreads[I].Destroy;
    except
    end;
   end;
   FThreads.Clear;
   FreeAndNil(FThreads);
  end;

  if Assigned(FThreadIDS) then
   FreeAndNil(FThreadIDS);

  if Assigned(FCriticalThreadSession) then
   FreeAndNil(FCriticalThreadSession);
 finally
//  try
//   {$IFDEF D2BRIDGE}
//   if PrismBaseClass.Sessions.Count = 0 then
//    FreeMem;
//   {$ENDIF}
//  except
//  end;

 {$IFDEF D2BRIDGE}
  try
  inherited;
  except
  end;
 {$ENDIF}
 end;

end;

procedure TPrismSession.DoConnectionStatus(AConnectionStatus: TSessionConnectionStatus);
begin
 FConnectionStatus:= AConnectionStatus;

 if (FConnectionStatus = scsLostConnectioSession) and (not FReloading) then
 begin
  PrismBaseClass.DoDisconnectSession(self);
 end else
 if (FConnectionStatus = scsReconnectedSession) and (FReloading) then
 begin
  PrismBaseClass.DoReconnectSession(self);
 end;
end;

procedure TPrismSession.DoException(Sender: TObject; E: Exception; EventName: string);
var
 vPrismControl: IPrismControl;
 vVCLControl: TObject;
begin
  if Assigned(Sender) and (Supports(Sender, IPrismControl)) then
  begin
   if Supports(Sender, IPrismControl, vPrismControl) and (Assigned(vPrismControl.VCLComponent)) then
    vVCLControl:= vPrismControl.VCLComponent
   else
    vVCLControl:= Sender;
  end else
   vVCLControl:= Sender;

 PrismBaseClass.DoException(vVCLControl, E, self, EventName);
end;

procedure TPrismSession.DoFormPageLoad(APrismForm: IPrismForm);
begin
 if FScriptJSSafeMode.Text <> '' then
 if ActiveForm = APrismForm then
 begin
  ExecJS(FScriptJSSafeMode.Text);

  FScriptJSSafeMode.Clear;
 end;
end;

procedure TPrismSession.EndDisconnect;
begin
 FDisconnect:= false;
 FDisconnectStartTime:= 0;
end;

procedure TPrismSession.ExecJS(ScriptJS: String; SafeMode: Boolean = false);
var
 Json: TJSONObject;
 JSonArray: TJSONArray;
begin
 if (not Closing) and Assigned(FWebSocketContext) then
 begin
  if (SafeMode and (not Assigned(FD2BridgeFormPrimary))) or
     (SafeMode and (ActiveForm.FormPageState <> PageStateLoaded)) then
  begin
   FScriptJSSafeMode.Add(ScriptJS);
  end else
  begin
   Json:= TJSONObject.Create;
   JSonArray:= TJSONArray.Create;

   JSonArray.Add(ScriptJS);

   Json.AddPair('ExecJS', JSonArray);

   if Assigned(FPrismBaseClass) then
    TPrismBaseClass(FPrismBaseClass).PrismServer.SendWebSocketMessage(Json.ToJSON, self);

   Json.Free;
  end;
 end;
end;

function TPrismSession.ExecJSResponse(ScriptJS: String; ATimeout: integer;
  SafeMode: Boolean): string;
var
 vCallbackRespose: string;
 vCallBackName: string;
 vActiveForm: IPrismForm;
begin
 if not Closing then
 begin
  if (SafeMode and (not Assigned(FD2BridgeFormPrimary))) or
     (SafeMode and (ActiveForm.FormPageState <> PageStateLoaded)) then
  begin
   FScriptJSSafeMode.Add(ScriptJS);
  end else
  begin
   vActiveForm:= ActiveForm;
   vCallbackRespose:= '';
   vCallBackName:= 'ExecJSRespose_'+vActiveForm.FormUUID;


   vActiveForm.CallBacks.Register(vCallBackName,
    function(EventParams: TStrings): string
    begin
     vCallbackRespose:= EventParams.Text;
     UnLock(vCallBackName);
    end
   );


   ExecJS(
          '{                                                                   '+
          'function ExecJSResponse(script) {                                   '+
          '  try {                                                             '+
          '    const _response = eval(script);                                 '+
          '    return Promise.resolve(_response);                              '+
          '  } catch (error) {                                                 '+
          '    return Promise.reject(''Error exec script: '' + error.message); '+
          '  }                                                                 '+
          '}                                                                   '+
          '                                                                    '+
          'ExecJSResponse(' + QuotedStr(ScriptJS) + ').then(result => {        '+
          '		if (typeof result !== ''string'') {                              '+
          '			result = JSON.stringify(result);                               '+
          '		}                                                                '+
          '    ' + CallBacks.CallBackJS(vCallBackName, false, vActiveForm.FormUUID, 'result') + ' '+
          '});                                                                 '+
          '}                                                                   '
   );

   Lock(vCallBackName, ATimeout);

   vActiveForm.CallBacks.Unregister(vCallBackName);

   Result:= vCallbackRespose;
  end;
 end;
end;

procedure TPrismSession.ExecThread(AWait: Boolean; AProc: TProc);
var
 vProc4: TProc<TValue,TValue,TValue,TValue>;
begin
 vProc4:=
  Procedure(var1, var2, var3, var4: TValue)
  begin
   AProc;
  end;

 ExecThread(AWait, vProc4, nil, nil, nil, nil);
end;

procedure TPrismSession.ExecThread(AWait: Boolean; AProc: TProc<TValue>; var1: TValue);
var
 vProc4: TProc<TValue,TValue,TValue,TValue>;
begin
 vProc4:=
  Procedure(var1, var2, var3, var4: TValue)
  begin
   AProc(var1);
  end;

 ExecThread(AWait, vProc4, var1, nil, nil, nil);

end;

procedure TPrismSession.ExecThread(AWait: Boolean;
  AProc: TProc<TValue, TValue, TValue, TValue>; var1, var2, var3, var4: TValue);
var
 FPrismSessionThreadProc: TPrismSessionThreadProc;
 I: Integer;
 vThreadNotRunning: Integer;
begin
 if (not Assigned(FCriticalThreadSession)) or (not Assigned(FThreads)) then
  Exit;

 ThreadAddCurrent;

 FCriticalThreadSession.Enter;

 try
  FPrismSessionThreadProc:= TPrismSessionThreadProc.Create(self, AProc, var1, var2, var3, var4, AWait);

  vThreadNotRunning:= -1;
  for I := 0 to Pred(FThreads.Count) do
   if not FThreads[I].Running then
   begin
    vThreadNotRunning:= I;
    Break;
   end;

  if vThreadNotRunning < 0 then
  begin
   FThreads.Add(TPrismSessionThread.Create(self,FThreads.Count+1));
   vThreadNotRunning:= FThreads.Count-1;
  end;

 finally
  FCriticalThreadSession.Leave;
 end;

 FThreads[vThreadNotRunning].Exec(FPrismSessionThreadProc);



// if vThreadLevel = 1 then
//  FProcs.Add(FPrismSessionThreadProc)
// else
// if vThreadLevel = 2 then
//  FProcs2.Add(FPrismSessionThreadProc);
//
// if AWait then
// begin
//  ITaskLock:=
//   TTask.Run(
//    procedure
//    begin
//     repeat
//      sleep(1);
//     until
//      ((vThreadLevel = 1) and not FProcs.Contains(FPrismSessionThreadProc)) or
//      ((vThreadLevel = 2) and not FProcs2.Contains(FPrismSessionThreadProc));
//    end
//   );
//  ITaskLock.Wait(INFINITE);
//  ITaskLock:= nil;
// end;



 //FreeAndNil(FPrismSessionThreadProc);

// if AWait then
// TPrismSessionThread.Create(self, AProc).WaitFor
// else
// TPrismSessionThread.Create(self, AProc);
end;


procedure TPrismSession.ExecThread(AWait: Boolean;
  AProc: TProc<TValue, TValue, TValue>; var1, var2, var3: TValue);
var
 vProc4: TProc<TValue,TValue,TValue,TValue>;
begin
 vProc4:=
  Procedure(var1, var2, var3, var4: TValue)
  begin
   AProc(var1, var2, var3);
  end;

 ExecThread(AWait, vProc4, var1, var2, var3, nil);

end;

procedure TPrismSession.ExecThread(AWait: Boolean; AProc: TProc<TValue, TValue>; var1, var2: TValue);
var
 vProc4: TProc<TValue,TValue,TValue,TValue>;
begin
 vProc4:=
  Procedure(var1, var2, var3, var4: TValue)
  begin
   AProc(var1, var2);
  end;

 ExecThread(AWait, vProc4, var1, var2, nil, nil);

end;

procedure TPrismSession.ExecThreadSynchronize(AProc: TProc);
var
 ITaskLock: ITask;
 FPrismSessionThreadProc: TPrismSessionThreadProc;
 FThreadID: Integer;
begin
// FThreadID:= TThread.CurrentThread.ThreadID;
// if (FThreadID <> MainThreadID) then
// begin
//  if not ThreadIDs.Contains(FThreadID) then
//  ThreadIDs.Add(FThreadID);
// end;
//
// FPrismSessionThreadProc:= TPrismSessionThreadProc.Create(AProc, true, true);
//
// FProcs.Add(FPrismSessionThreadProc);
//
// ITaskLock:=
//  TTask.Run(
//   procedure
//   begin
//    repeat
//     sleep(1);
//    until not FProcs.Contains(FPrismSessionThreadProc);
//   end
//  );
// ITaskLock.Wait(INFINITE);
// ITaskLock:= nil;

 //FreeAndNil(FPrismSessionThreadProc);



// TPrismSessionThread.Create(self,
//  procedure
//  begin
//   TThread.Synchronize(TThread.CurrentThread,
//     procedure
//     begin
//      AProc;
//     end
//   );
//  end
// ).WaitFor;

end;

procedure TPrismSession.ExecThread(AProc: TProc);
begin
 ExecThread(false, AProc);
end;

function TPrismSession.GetActiveForm: IPrismForm;
begin
 Result:= nil;

 if Assigned(TD2BridgeClass(D2BridgeBaseClassActive).Form) then
  Result:= (TD2BridgeClass(D2BridgeBaseClassActive).Form as TPrismForm);
end;

function TPrismSession.GetLanguageNav: TD2BridgeLang;
begin
 Result:= FLanguageNav;
end;

function TPrismSession.GetPushID: string;
begin
 result:= FPushID;
end;

function TPrismSession.GetCallBackID: string;
begin
 Result:= FCallBackID;
end;

function TPrismSession.GetCallBacks: IPrismCallBacks;
begin
 Result:= FIPrismCallBacks;
end;

function TPrismSession.GetD2BridgeBaseClass: TObject;
begin
 Result:= FD2BridgeBaseClass;
end;

function TPrismSession.GetD2BridgeInstance: TObject;
begin
 Result:= FD2BridgeInstance;
end;

function TPrismSession.GetD2BridgeManager: TObject;
begin
 Result:= D2Bridge.Manager.D2BridgeManager;
end;

function TPrismSession.GetData: TObject;
begin
 Result:= FData;
end;

function TPrismSession.GetFileDownloads: TDictionary<string, string>;
begin
 Result:= FFileDownloads;
end;

function TPrismSession.GetFormatSettings: TFormatSettings;
begin
 result:= FFormatSettings;
end;

function TPrismSession.Language: TD2BridgeLang;
begin
 Result:= FLanguage;
end;

function TPrismSession.LastActivity: TDateTime;
begin
 result:= FLastActivity;
end;

function TPrismSession.LastActivityInSeconds: integer;
begin
 result:= SecondsBetween(FLastActivity, Now);
end;

function TPrismSession.LastHeartBeat: TDateTime;
begin
 result:= FLastHeartBeat;
end;

function TPrismSession.LastHeartBeatInSeconds: integer;
begin
 result:= SecondsBetween(FLastHeartBeat, Now);
end;

function TPrismSession.GetD2BridgeForms: TList<TObject>;
begin
 Result:= FD2BridgeForms;
end;

function TPrismSession.GetThreadIDs: TList<integer>;
begin
 Result:= FThreadIDS;
end;

function TPrismSession.GetToken: string;
begin
 Result:= FToken;
end;

function TPrismSession.GetUUID: string;
begin
 Result:= FUUID;
end;

function TPrismSession.Disconnected: Boolean;
begin
 Result:= FDisconnect;
end;

function TPrismSession.DisconnectedInSeconds: integer;
begin
 if Disconnected then
  Result:= SecondsBetween(Now, FDisconnectStartTime)
 else
  Result:= 0;
end;

function TPrismSession.GetWebSocketContext: TIdContext;
begin
 Result := FWebSocketContext;
end;

function TPrismSession.Idle: Boolean;
begin
 result:= FIdle;
end;

function TPrismSession.IdleInSeconds: integer;
begin
 if FIdle then
  result:= SecondsBetween(FLastActivity, Now)
 else
  result:= 0;
end;

function TPrismSession.InfoConnection: IPrismSessionInfo;
begin
 Result:= FInfoConnection;
end;

function TPrismSession.Lang: TD2BridgeTerm;
begin
 Result:= TD2BridgeTerm(D2BridgeLangCore.LangByTD2BridgeLang(Language));
end;

function TPrismSession.LangAPP: TD2BridgeAPPTerm;
begin
 if LangAPPIsPresent then
 begin
  {$IFDEF D2BRIDGE}
   Result:= TD2BridgeAPPTerm(D2BridgeLangAPPCore.LangByTD2BridgeLang(Language));
  {$ELSE}
   Result:= TD2BridgeAPPTerm(D2BridgeLangAPPCore.LangByTD2BridgeLang(English));
  {$ENDIF}
 end;
end;

function TPrismSession.LangAPPIsPresent: Boolean;
begin
 Result:= Assigned(D2BridgeLangAPPCore);
end;

function TPrismSession.LangCode: string;
begin
 Result:= LanguageCode(FLanguage);
end;

function TPrismSession.LangName: string;
begin
 Result:= LanguageName(FLanguage);
end;

function TPrismSession.LangNav: TD2BridgeTerm;
begin
 Result:= TD2BridgeTerm(D2BridgeLangCore.LangByTD2BridgeLang(LanguageNav));
end;

procedure TPrismSession.Lock(const AWaitName: String; const ATimeOut: integer = 0);
const
 vSleepTime = 100;
var
// ITaskLock: ITask;
 vWaitName: string;
 vTaskCompleted: TEvent;
begin
 vWaitName:= AWaitName;

 if not FLockName.Contains(vWaitName) then
 begin
  FLockName.Add(vWaitName);

  vTaskCompleted := TEvent.Create(nil, True, False, '');


  TTask.Run(
   procedure
   var
    xTimeOut: integer;
   begin
    xTimeOut:= ATimeOut;
    repeat
     sleep(vSleepTime);

     if xTimeOut <> 0 then
      xTimeOut:= Round((xTimeOut * 1000) - vSleepTime);
    until (Closing) or (not (FLockName.Contains(vWaitName))) or (xTimeOut < 0);

    vTaskCompleted.SetEvent;
   end
  );

  //ITaskLock.Wait(INFINITE);

  while vTaskCompleted.WaitFor(100) = wrTimeout do
  begin
   Application.ProcessMessages;
  end;

//  ITaskLock:= nil;
  vTaskCompleted.Free;
 end;
end;

function TPrismSession.LockExists(AWaitName: String): boolean;
begin
 result:= FLockName.Contains(AWaitName);
end;

{$IFNDEF FMX}
function TPrismSession.MessageBox(const Text, Caption: PChar; Flags: Longint): Integer;
var
 vD2Bridge: TD2BridgeClass;
 vD2BridgeForm: TD2BridgeForm;
 vButtons: TMsgDlgButtons;
 vMod10: integer;
begin
 {$IFDEF D2BRIDGE}
  vMod10:= ExtractHexValue(Flags) mod 10;
  vD2Bridge:= TD2BridgeClass(D2BridgeBaseClassActive);
  vD2BridgeForm:= TD2BridgeForm(TD2BridgeClass(D2BridgeBaseClassActive).FormAOwner);

  //Process vMod10
  if vMod10 = MB_OK then
   vButtons:= [TMsgDlgBtn.mbOK]
  else
  if vMod10 = MB_OKCANCEL then
   vButtons:= [TMsgDlgBtn.MBOk, TMsgDlgBtn.MBCancel]
  else
  if vMod10 = MB_ABORTRETRYIGNORE then
   vButtons:= [TMsgDlgBtn.MBAbort, TMsgDlgBtn.MBRetry, TMsgDlgBtn.MBIgnore]
  else
  if vMod10 = MB_YESNOCANCEL then
   vButtons:= [TMsgDlgBtn.MBYes, TMsgDlgBtn.MBNo, TMsgDlgBtn.MBCancel]
  else
  if vMod10 = MB_YESNO then
   vButtons:= [TMsgDlgBtn.MBYes, TMsgDlgBtn.MBNo]
  else
  if vMod10 = MB_RETRYCANCEL then
   vButtons:= [TMsgDlgBtn.MBRetry, TMsgDlgBtn.MBCancel]
  else
   vButtons:= [TMsgDlgBtn.MBOk];

  Result:= vD2BridgeForm.MessageDlg(Text, TMsgDlgType.mtInformation, vButtons, 0);
 {$ELSE}
   Result:= VCL.Forms.Application.MessageBox(Text, Caption, Flags);
 {$ENDIF}
end;
{$ENDIF}

function TPrismSession.MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint;
  ACallBackName: string): Integer;
begin
 {$IFDEF D2BRIDGE}
 if Assigned(ActiveForm) then
  if TPrismForm(ActiveForm).D2BridgeForm <> nil then
   Result:= TPrismForm(ActiveForm).D2BridgeForm.MessageDlg(Msg, DlgType, Buttons, HelpCtx, ACallBackName);
 {$ELSE}
  Result:= {$IFDEF FMX}FMX.Dialogs{$ELSE}VCL.Dialogs{$ENDIF}.MessageDlg(Msg, DlgType, Buttons, HelpCtx);
 {$ENDIF}
end;


function TPrismSession.MessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
 result:= MessageDlg(Msg, DlgType, Buttons, HelpCtx, '');
end;

function TPrismSession.PathSession: String;
begin
 Result:= FPrismBaseClass.Options.RootDirectory + 'temp\Sessions\'+UUID+'\';
end;

function TPrismSession.PrimaryForm: TObject;
begin
 result:= FD2BridgeFormPrimary;
end;

function TPrismSession.Recovering: boolean;
begin
 result:= FRecovering;
end;

procedure TPrismSession.Redirect(AURL: string; ANewPage: Boolean);
begin
 if ANewPage then
  ExecJS('window.open('+QuotedStr(AURL)+','+QuotedStr('_blank')+');')
 else
  ExecJS('window.location.assign('+QuotedStr(AURL)+');');
end;

function TPrismSession.Reloading: boolean;
begin
 result:= FReloading;
end;

procedure TPrismSession.RenewUUID;
var
 vOLDUUID: string;
begin
 vOLDUUID:= FUUID;
 FUUID:= GenerateRandomString(SizeUUID);
 PrismBaseClass.Sessions.Add(self);
 PrismBaseClass.Sessions.Delete(vOLDUUID);
end;

procedure TPrismSession.SendFile(FullFilePath: String; OpenOnFinishDownload: Boolean = false; WebFileName: String = '');
var
 //vWebPathDownload: String;
 vDownloadCode, vDownloadFullURL: String;
 vScriptJS: TStrings;
begin
 if FileExists(FullFilePath) then
 begin
  vScriptJS:= TStringList.Create;
  //vWebPathDownload:= SubtractPaths(FPrismBaseClass.Options.RootDirectory, FullFilePath);

  vDownloadCode:= GenerateRandomJustString(17);
  FFileDownloads.Add(vDownloadCode, FullFilePath);
  vDownloadFullURL:= PrismBaseClass.PrismServer.FpathDownload+'?file='+vDownloadCode+'&token='+Token+'&prismsession='+UUID;

  if WebFileName = '' then
  WebFileName:= ExtractFileName(FullFilePath);

  //vWebPathDownload := StringReplace(vWebPathDownload, '\', '/', [rfReplaceAll]);

  with vScriptJS do
  begin
   Add('var fileUrl = "' + vDownloadFullURL + '";');
   if OpenOnFinishDownload then
    Add('var openAfterDownload = true;')
   else
    Add('var openAfterDownload = false;');
   Add('var downloadLink = document.createElement(''a'');');
   Add('downloadLink.href = fileUrl;');
   Add('downloadLink.download = "' + WebFileName + '";');
   Add('downloadLink.click();');
   Add('if (openAfterDownload) {');
   Add('  window.open(fileUrl, ''_blank'');');
   Add('}');
  end;

  ExecJS(vScriptJS.Text);

  vScriptJS.Free;
 end;
end;

function TPrismSession.SendFileLink(FullFilePath: String): string;
var
 vDownloadCode, vDownloadFullURL: String;
 vURI: string;
 LastDelimiterBarPos: Integer;
begin
 Result:= '';
 if FileExists(FullFilePath) then
 begin
  vURI:= URI.URL;

  LastDelimiterBarPos := LastDelimiter('/', vURI);

  if LastDelimiterBarPos = Length(vURI) then
    Delete(vURI, LastDelimiterBarPos, 1);

  vDownloadCode:= GenerateRandomJustString(17);
  FFileDownloads.Add(vDownloadCode, FullFilePath);
  result:= vURI + PrismBaseClass.PrismServer.FpathDownload+'?file='+vDownloadCode+'&token='+Token+'&prismsession='+UUID;
 end;
end;


procedure TPrismSession.SetLanguageNav(const Value: TD2BridgeLang);
var
  vLang: TD2BridgeLang;
begin
 FLanguageNav:= Value;

 //Language of Session
 if FLanguageNav in TD2BridgeManager(D2BridgeManager).Languages then
 begin
  FLanguage:= FLanguageNav;
 end else
 if TD2BridgeLang.English in TD2BridgeManager(D2BridgeManager).Languages then
 begin
  FLanguage:= TD2BridgeLang.English;
 end else
 for vLang := Low(TD2BridgeLang) to High(TD2BridgeLang) do
  if vLang in TD2BridgeManager(D2BridgeManager).Languages then
   FLanguage:= vLang;
end;


procedure TPrismSession.SetRecovering(Value: boolean);
begin
 FRecovering:= Value;
end;

procedure TPrismSession.ShowMessage(const Msg: string; useToast: boolean; TimerInterval: integer; DlgType: TMsgDlgType; ToastPosition: TToastPosition);
begin
 {$IFDEF D2BRIDGE}
 if Assigned(ActiveForm) then
  if TPrismForm(ActiveForm).D2BridgeForm <> nil then
   TPrismForm(ActiveForm).D2BridgeForm.ShowMessage(Msg, useToast, TimerInterval, DlgType, ToastPosition);
 {$ELSE}
  {$IFDEF FMX}FMX.Dialogs{$ELSE}VCL.Dialogs{$ENDIF}.MessageDlg(Msg, DlgType, [TMsgDlgBtn.MBOk], 0);
 {$ENDIF}
end;

procedure TPrismSession.ShowMessage(const Msg: string; useToast, ASyncMode: Boolean; TimerInterval: integer; DlgType: TMsgDlgType; ToastPosition: TToastPosition);
begin
 {$IFDEF D2BRIDGE}
 if Assigned(ActiveForm) then
  if TPrismForm(ActiveForm).D2BridgeForm <> nil then
   TPrismForm(ActiveForm).D2BridgeForm.ShowMessage(Msg, useToast, ASyncMode, TimerInterval, DlgType, ToastPosition);
 {$ELSE}
  {$IFDEF FMX}FMX.Dialogs{$ELSE}VCL.Dialogs{$ENDIF}.MessageDlg(Msg, DlgType, [TMsgDlgBtn.MBOk], 0);
 {$ENDIF}
end;

procedure TPrismSession.ShowMessage(const Msg: string);
begin
 {$IFDEF D2BRIDGE}
 if Assigned(ActiveForm) then
  if TPrismForm(ActiveForm).D2BridgeForm <> nil then
   TPrismForm(ActiveForm).D2BridgeForm.ShowMessage(Msg);
 {$ELSE}
  {$IFDEF FMX}FMX.Dialogs{$ELSE}VCL.Dialogs{$ENDIF}.ShowMessage(Msg);
 {$ENDIF}
end;

procedure TPrismSession.ShowMessageError(const Msg: string; ASyncMode, useToast: boolean; TimerInterval: integer; ToastPosition: TToastPosition);
begin
 ShowMessage(Msg, useToast, ASyncMode, TimerInterval, TMsgDlgType.mtError, ToastPosition);
end;

procedure TPrismSession.SetActive(Value: Boolean);
begin
 if Value <> FActive then
 begin
  FActive:= Value;
 end;
end;

procedure TPrismSession.SetD2BridgeBaseClass(AD2BridgeBaseClass: TObject);
var I: Integer;
    vPriorD2BridgeForm: TD2BridgeForm;
begin
 vPriorD2BridgeForm:= nil;

 if Assigned(FD2BridgeBaseClass) then
 begin
  if Assigned(ActiveForm) then
  begin
   ActiveForm.onFormUnload;

   for I:= 0 to TD2BridgeClass(FD2BridgeBaseClass).NestedCount -1 do
    TPrismForm(TD2BridgeClass(FD2BridgeBaseClass).Nested(I).FrameworkForm).onFormUnload;
  end;

  if (Assigned(TD2BridgeClass(FD2BridgeBaseClass).FormAOwner)) and
     (TD2BridgeClass(FD2BridgeBaseClass).FormAOwner is TD2BridgeForm) and
     (not (csDestroying in TD2BridgeForm(TD2BridgeClass(FD2BridgeBaseClass).FormAOwner).ComponentState)) then
  vPriorD2BridgeForm:= TD2BridgeForm(TD2BridgeClass(FD2BridgeBaseClass).FormAOwner);
 end;

 FD2BridgeBaseClass:= AD2BridgeBaseClass;

 if (TD2BridgeClass(AD2BridgeBaseClass).D2BridgeOwner = nil) then
 begin
  FD2BridgeForms.Remove(AD2BridgeBaseClass);
  FD2BridgeForms.Add(AD2BridgeBaseClass);

  TD2BridgeForm(TD2BridgeClass(FD2BridgeBaseClass).FormAOwner).PriorD2Bridge:= nil;
  if Assigned(vPriorD2BridgeForm) then
  begin
   if vPriorD2BridgeForm <> TD2BridgeForm(TD2BridgeClass(FD2BridgeBaseClass).FormAOwner) then
   TD2BridgeForm(TD2BridgeClass(FD2BridgeBaseClass).FormAOwner).PriorD2Bridge:= vPriorD2BridgeForm;
  end;
 end;
end;

procedure TPrismSession.SetData(AValue: TObject);
begin
 FData:= AValue;
end;

procedure TPrismSession.SetFormatSettings(const Value: TFormatSettings);
begin
 FFormatSettings:= Value;
end;

procedure TPrismSession.SetWebSocketContext(const Value: TIdContext);
begin
 FWebSocketContext := Value;
end;

procedure TPrismSession.ThreadAddCurrent;
var
 FThreadID: Integer;
begin
 if (not Assigned(FCriticalThreadSession)) or (not Assigned(FThreads)) then
  Exit;

 FCriticalThreadSession.Enter;

 try
  try
   FThreadID:= TThread.CurrentThread.ThreadID;
   if (FThreadID <> MainThreadID) then
   begin
    if not ThreadIDs.Contains(FThreadID) then
    ThreadIDs.Add(FThreadID);
   end;
  except
  end;
 finally
  FCriticalThreadSession.Leave;
 end;
end;

procedure TPrismSession.ThreadRemoveCurrent;
var
 FThreadID: Integer;
begin
 if (not Assigned(FCriticalThreadSession)) or (not Assigned(FThreads)) then
  Exit;

 FCriticalThreadSession.Enter;

 try
  try
   FThreadID:= TThread.CurrentThread.ThreadID;
   if (FThreadID <> MainThreadID) then
   begin
    if ThreadIDs.Contains(FThreadID) then
    ThreadIDs.Remove(FThreadID);
   end;
  except
  end;
 finally
  FCriticalThreadSession.Leave;
 end;
end;

procedure TPrismSession.UnLock(AWaitName: String);
begin
 if FLockName.Contains(AWaitName) then
 begin
  FLockName.Remove(AWaitName);
 end;
end;

procedure TPrismSession.UnLockAll;
begin
 FLockName.Clear;
end;

function TPrismSession.URI: IPrismURI;
begin
 Result:= FURI;
end;


end.
