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

unit Prism.Server.Functions;

interface

uses
  System.SysUtils, System.Classes, System.Json,
  Prism.Interfaces;


type
  TPrismServerFunctions = class(TDataModule)
   private
    function ProcessParameters(AParameters: string): TStringList;
    function ProcessEvent(UUID, Token, FormUUID, ID, EventID, Parameters: String; LockClient: Boolean): string;
    procedure UnLockClient(Session: IPrismSession);
   public
    procedure ExecEvent(UUID, Token, FormUUID, ID, EventID, Parameters: String; LockClient: Boolean);
    function GetFromEvent(UUID, Token, FormUUID, ID, EventID, Parameters: String; LockClient: Boolean): string;
    function CallBack(UUID, Token, FormUUID, CallBackID, Parameters: String; LockClient: Boolean): string;
  end;

implementation

{$R *.dfm}

uses
{$IFDEF FMX}
  FMX.Forms,
{$ELSE}
  Vcl.Forms,
{$ENDIF}
  Prism.BaseClass, Prism.Session, Prism.Forms, Prism.Events, Prism.CallBack,
  Prism.Types, D2Bridge.BaseClass, D2Bridge.Forms, D2Bridge.Util,
  Prism.ButtonedEdit,
  System.Rtti;

{ TPrismServerFunctions }

function TPrismServerFunctions.CallBack(UUID, Token, FormUUID, CallBackID, Parameters: String; LockClient: Boolean): string;
var
 PrismSession: TPrismSession;
 PrismForm: TPrismForm;
 ParamStrings: TStrings;
 vPrismCallBack: TPrismCallBack;
 I: Integer;
 ResulThread: string;
begin
 Result:= 'ERROR';
 if (UUID <> '') and (Token <> '') and (FormUUID <> '') and (CallBackID <> '') then
 begin
  if PrismBaseClass.Sessions.Exist(UUID) then
  begin
   ParamStrings:= ProcessParameters(Parameters);

   PrismSession:= (PrismBaseClass.Sessions.Item[UUID] as TPrismSession);
   //PrismForm:= (PrismSession.ActiveForm as TPrismForm);
   PrismForm:= TPrismForm(PrismSession.ActiveFormByFormUUID(FormUUID));

   if (PrismForm = nil) or (csDestroying in PrismSession.ComponentState) then
   begin
    ParamStrings.Free;
    abort;
   end;

   if (UUID = PrismSession.UUID) and (Token = PrismSession.Token) and (FormUUID = PrismForm.FormUUID) then
   begin
    for I := 0 to PrismSession.CallBacks.Items.Count -1 do
    if PrismSession.CallBacks.Items.ToArray[I].Value.ID = CallBackID then
    begin
     vPrismCallBack:= (PrismSession.CallBacks.Items.ToArray[I].Value as TPrismCallBack);
     break;
    end;

    if Assigned(vPrismCallBack) then
    begin
     PrismSession.ExecThread(false,
      procedure(AParamStringValue: TValue)
      var
       vParamStrings: TStrings;
      begin
       vParamStrings:= TStringlist.Create;
       vParamStrings.Text:= AParamStringValue.AsString;
       try
        ResulThread:= vPrismCallBack.Execute(vParamStrings);
       finally
        if LockClient then
        UnLockClient(PrismSession);
        vParamStrings.Free;
       end;
      end,
      ParamStrings.Text
     );
    end;

    Result:= ResulThread;
   end;

   ParamStrings.Free;
  end;
 end;

end;

procedure TPrismServerFunctions.ExecEvent(UUID, Token, FormUUID, ID, EventID, Parameters: String; LockClient: Boolean);
begin
 ProcessEvent(UUID, Token, FormUUID, ID, EventID, Parameters, LockClient);
end;

function TPrismServerFunctions.GetFromEvent(UUID, Token, FormUUID, ID, EventID, Parameters: String; LockClient: Boolean): string;
begin
 Result:= ProcessEvent(UUID, Token, FormUUID, ID, EventID, Parameters, LockClient);
end;

function TPrismServerFunctions.ProcessEvent(UUID, Token, FormUUID, ID, EventID, Parameters: String; LockClient: Boolean): string;
var
 PrismSession: TPrismSession;
 PrismForm: TPrismForm;
 FEvent: TPrismControlEvent;
 ParamStrings: TStrings;
 vComponentID, PrismComponentsStatusStr: String;
 PrismComponentsJSONArray: TJSONArray;
 I, J, Z, X: Integer;
 //vFocusedPrismControl: IPrismControl;
 ResulThread: string;
 vComponentDisableIgnore: boolean;
begin
 Result:= '';
 vComponentDisableIgnore:= false;
 FEvent:= nil;
 PrismForm:= nil;
 ParamStrings:= nil;
 PrismComponentsJSONArray:= nil;

 if (UUID <> '') and (Token <> '') and (FormUUID <> '') and (ID <> '') and (EventID <> '') then
 begin
  if PrismBaseClass.Sessions.Exist(UUID) then
  begin
   ParamStrings:= ProcessParameters(Parameters);

   PrismSession:= (PrismBaseClass.Sessions.Item[UUID] as TPrismSession);
   //PrismForm:= (PrismSession.ActiveForm as TPrismForm);
   PrismForm:= TPrismForm(PrismSession.ActiveFormByFormUUID(FormUUID));

   if (PrismForm = nil) or (csDestroying in PrismSession.ComponentState) then
   begin
    ParamStrings.Free;
    abort;
   end;


   //Checa se é o form atual
   if (FormUUID = PrismForm.FormUUID) then
   begin
    //Processa ComponentsState
    if (ParamStrings.Text <> '') then
    begin
     PrismComponentsStatusStr:= ParamStrings.Values['PrismComponentsStatus'];
     if PrismComponentsStatusStr <> '' then
     begin
      PrismForm.onComponentsUpdating;
      PrismComponentsJSONArray:= TJSONArray.Create;
      PrismComponentsJSONArray:= TJSONObject.ParseJSONValue(PrismComponentsStatusStr) as TJSONArray;
      if PrismComponentsJSONArray <> nil then
      for J := 0 to PrismComponentsJSONArray.Count - 1 do
      for I := 0 to PrismForm.Controls.Count - 1 do
      if AnsiUpperCase(PrismForm.Controls[I].NamePrefix) = AnsiUpperCase(TJSONObject(PrismComponentsJSONArray.Items[J]).GetValue('id').Value) then
      begin
       if ((PrismForm.Controls[I].Form as TPrismForm) = PrismForm) or
          ((PrismForm.Controls[I].Form as TPrismForm).D2BridgeForm.Showing) then //Nested
        if PrismForm.Controls[I].Enabled and PrismForm.Controls[I].Visible and not PrismForm.Controls[I].ReadOnly then
        begin
         try
          PrismForm.Controls[I].ProcessComponentState(TJSONObject(PrismComponentsJSONArray.Items[J]));
         except
          on E: Exception do
          PrismSession.DoException(PrismForm.Controls[I] as TPrismControl, E, 'ProcessComponentState');
         end;

         try
          PrismForm.D2BridgeForm.DoUpdateD2BridgeControls(PrismForm.Controls[I] as TPrismControl);
         except
          on E: Exception do
          PrismSession.DoException(PrismForm.Controls[I] as TPrismControl, E, 'UpdateD2BridgeControls');
         end;
        end;
       break;
      end;
      PrismComponentsJSONArray.Free;
      PrismForm.onComponentsUpdated;
     end;
    end;

    //Eventos do Form
    if (ID = PrismForm.FormUUID) and (FormUUID = PrismForm.FormUUID) then
    begin
     if EventID = 'UpdateD2BridgeControls' then
     begin

     end;

     if EventID = 'AfterPageLoad' then
     begin
      PrismSession.ExecThread(false,
        procedure(APrismForm: TValue)
        var
         I: Integer;
         vPrismForm: TPrismForm;
        begin
         try
          vPrismForm:= TPrismForm(APrismForm.AsObject);
          vPrismForm.OnAfterPageLoad;

//          for I:= 0 to vPrismForm.D2BridgeForm.D2Bridge.NestedCount -1 do
//          begin
//           try
//            TPrismForm(vPrismForm.D2BridgeForm.D2Bridge.Nested(I).FrameworkForm).OnAfterPageLoad;
//           except
//            on E: Exception do
//             vPrismForm.Session.DoException(TPrismForm(vPrismForm.D2BridgeForm.D2Bridge.Nested(I).FrameworkForm), E, 'OnAfterPageLoad');
//           end;
//
//           try
//            TPrismForm(vPrismForm.D2BridgeForm.D2Bridge.Nested(I).FrameworkForm).UpdateControls;
//           except
//            on E: Exception do
//             vPrismForm.Session.DoException(TPrismForm(vPrismForm.D2BridgeForm.D2Bridge.Nested(I).FrameworkForm), E, 'UpdateControls');
//           end;
//          end;
         finally
          if LockClient then
          UnLockClient(PrismSession);
         end;
        end,
        PrismForm
      );
     end;

     if EventID = 'OnShowPopup' then
     begin
      PrismSession.ExecThread(false,
        procedure(APrismForm, ANamePopup: TValue)
        var
         vPrismForm: TPrismForm;
         vNamePopup: string;
        begin
         vPrismForm:= TPrismForm(APrismForm.AsObject);
         vNamePopup:= ANamePopup.AsString;

         try
          try
           if Assigned(vPrismForm.OnShowPopup) then
            vPrismForm.OnShowPopup(vNamePopup);
          except
           on E: Exception do
           vPrismForm.Session.DoException(vPrismForm.D2BridgeForm.ActiveControl, E, 'ShowPopup');
          end;

          try
           vPrismForm.D2BridgeForm.DoPopupOpened(vNamePopup);
          except
           on E: Exception do
           vPrismForm.Session.DoException(vPrismForm.D2BridgeForm.ActiveControl, E, 'ShowedPopup');
          end;
         finally
          if LockClient then
          UnLockClient(vPrismForm.Session);
         end;
        end,
        PrismForm,
        ParamStrings.Values['popupname']
      );
     end;

     if EventID = 'OnClosePopup' then
     begin
      PrismSession.ExecThread(false,
        procedure(APrismForm, ANamePopup: TValue)
        var
         vPrismForm: TPrismForm;
        begin
         vPrismForm:= TPrismForm(APrismForm.AsObject);

         try
          try
           if Assigned(vPrismForm.OnClosePopup) then
            vPrismForm.OnClosePopup(ANamePopup.AsString);
          except
           on E: Exception do
           vPrismForm.Session.DoException(vPrismForm.D2BridgeForm.ActiveControl, E, 'ClosePopup');
          end;

          try
           vPrismForm.D2BridgeForm.DoPopupClosed(ANamePopup.AsString);
          except
           on E: Exception do
           vPrismForm.Session.DoException(vPrismForm.D2BridgeForm.ActiveControl, E, 'ClosedPopup');
          end;

//          try
//           TD2BridgeForm(TD2BridgeClass(vPrismForm.Session.D2BridgeBaseClassActive).FormAOwner).DoPopupClosed(vNamePopup);
//          except
//           on E: Exception do
//           vPrismForm.Session.DoException(TD2BridgeForm(TD2BridgeClass(vPrismForm.Session.D2BridgeBaseClassActive).FormAOwner).ActiveControl, E, 'ClosedPopup');
//          end;

         finally
          if LockClient then
          UnLockClient(vPrismForm.Session);
         end;
        end,
        PrismForm,
        ParamStrings.Values['popupname']
      );
     end;

     if EventID = 'ComponentFocused' then
     begin
      vComponentID := ParamStrings.Values['FocusedID'];
      for I := 0 to PrismForm.Controls.Count - 1 do
      if SameText(PrismForm.Controls[I].NamePrefix, vComponentID) then
      begin
       if PrismForm.Controls[I].Updatable and PrismForm.Controls[I].Enabled and PrismForm.Controls[I].Visible and not PrismForm.Controls[I].ReadOnly then
       begin
        PrismSession.ExecThread(false,
          procedure(APrismForm, AFocusedPrismControl: TValue)
          var
           vPrismForm: TPrismForm;
           vPrismControl: TPrismControl;
          begin
           vPrismForm:= TPrismForm(APrismForm.AsObject);
           vPrismControl:= TPrismControl(AFocusedPrismControl.AsObject);

           try
            vPrismForm.FocusedControl:= vPrismControl;
           except
            on E: Exception do
            vPrismForm.Session.DoException(vPrismControl as TObject, E, 'FocusControl');
           end;
          end,
          PrismForm,
          (PrismForm.Controls[I] as TPrismControl)
        );
       end else
        vComponentDisableIgnore:= true;
      end;
     end;
    end else
    begin
     for I := 0 to PrismForm.Controls.Count - 1 do
     begin
      for Z := 0 to PrismForm.Controls[I].Events.Count-1 do
      begin
       if PrismForm.Controls[I].Events.Item(Z).EventID = EventID then
       begin
        if
         {$IFNDEF FMX}
            (((PrismForm.Controls[I] is TPrismButtonedEdit) and (PrismForm.Controls[I].Updatable)) and
            ((PrismForm.Controls[I].Events.Item(Z).EventType = EventOnLeftClick) and
              ((PrismForm.Controls[I] as TPrismButtonedEdit).ButtonLeftVisible) and ((PrismForm.Controls[I] as TPrismButtonedEdit).ButtonLeftEnabled)) or
            ((PrismForm.Controls[I].Events.Item(Z).EventType = EventOnRightClick) and
              ((PrismForm.Controls[I] as TPrismButtonedEdit).ButtonRightVisible) and ((PrismForm.Controls[I] as TPrismButtonedEdit).ButtonRightEnabled))) or
         {$ENDIF}
           (PrismForm.Controls[I].Updatable and PrismForm.Controls[I].Enabled and PrismForm.Controls[I].Visible and not PrismForm.Controls[I].ReadOnly) then
        begin
         //NeedCheckValidation
         if PrismForm.Controls[I].NeedCheckValidation and (PrismForm.Controls[I].ValidationGroup <> '') then
         begin
          for X := 0 to PrismForm.Controls.Count - 1 do
           if PrismForm.Controls[X] <> PrismForm.Controls[I] then
            if PrismForm.Controls[X].ValidationGroup = PrismForm.Controls[I].ValidationGroup then
             if not PrismForm.Controls[X].ValidationGroupPassed then
             begin
              vComponentDisableIgnore:= true;
              PrismSession.ExecJS('insertValidationFeedback("'+ AnsiUpperCase(PrismForm.Controls[X].NamePrefix) +'", ' + BoolToStr(false, True).ToLower + ', "*")');
              break;
             end;
         end;

         if not vComponentDisableIgnore then
          FEvent:= (PrismForm.Controls[I].Events.Item(Z) as TPrismControlEvent)
        end else
         vComponentDisableIgnore:= true;
        Break;
       end;
       if FEvent <> nil then
       Break;
      end;
     end;

     if vComponentDisableIgnore  then
     begin
      if LockClient then
       UnLockClient(PrismSession);
     end else
     if FEvent <> nil then
     begin
//      PrismSession.ExecThread(true,
//        procedure
//        begin
         try
          FEvent.PrismControl.ProcessEventParameters(FEvent, ParamStrings);
         except
          on E: Exception do
          PrismSession.DoException(FEvent.PrismControl as TObject, E, 'ProcessEvent');
         end;
//        end
//      );


      if Supports(FEvent.PrismControl, IPrismGrid) and (FEvent.EventType = EventOnLoadJSON) then
      begin
//         PrismSession.ExecThreadSynchronize(
//           procedure
//           begin
            try
             try
              if FEvent.PrismControl.Enabled and FEvent.PrismControl.Visible and not FEvent.PrismControl.ReadOnly then
               ResulThread:= FEvent.CallEventResponse(ParamStrings);
             except
              on E: Exception do
              PrismSession.DoException(FEvent.PrismControl as TObject, E, FEvent.EventTypeName);
             end;
            finally
             if LockClient then
             UnLockClient(PrismSession);
            end;
//           end
//         );

       Result:= ResulThread;
      end else
      begin
        if
         {$IFNDEF FMX}
           (((FEvent.PrismControl is TPrismButtonedEdit) and (FEvent.PrismControl.Updatable)) and
            ((FEvent.EventType = EventOnLeftClick) and
              ((FEvent.PrismControl as TPrismButtonedEdit).ButtonLeftVisible) and ((FEvent.PrismControl as TPrismButtonedEdit).ButtonLeftEnabled)) or
            ((FEvent.EventType = EventOnRightClick) and
              ((FEvent.PrismControl as TPrismButtonedEdit).ButtonRightVisible) and ((FEvent.PrismControl as TPrismButtonedEdit).ButtonRightEnabled))) or
         {$ENDIF}
           (FEvent.PrismControl.Updatable and FEvent.PrismControl.Enabled and FEvent.PrismControl.Visible and not FEvent.PrismControl.ReadOnly) then
         PrismSession.ExecThread(false,
           procedure(APrismSession, APrismControlEvent, AParamStringsValue: TValue)
           var
            vParamStrings: TStrings;
            vPrismSession: TPrismSession;
            vPrismControlEvent: TPrismControlEvent;
           begin
            vParamStrings:= TStringList.Create;
            vPrismSession:= TPrismSession(APrismSession.AsObject);
            vParamStrings.Text:= AParamStringsValue.AsString;
            vPrismControlEvent:= TPrismControlEvent(APrismControlEvent.AsObject);
            try
             try
              vPrismControlEvent.CallEvent(vParamStrings);
             except
              on E: Exception do
              PrismSession.DoException(vPrismControlEvent.PrismControl as TObject, E, vPrismControlEvent.EventTypeName);
             end;
            finally
             if LockClient then
              UnLockClient(vPrismSession);

             vParamStrings.Free;
            end;
           end,
           PrismSession,
           FEvent,
           ParamStrings.Text
         );
      end;
     end;
    end;
   end;


   //PrismSession.ActiveForm
   ParamStrings.Free;
  end;
 end;


end;

function TPrismServerFunctions.ProcessParameters(AParameters: string): TStringList;
begin
 Result:= TStringList.Create;
 Result.LineBreak:= '&';
 if AParameters <> '' then
 if ((Copy(AParameters, 1, 1) = '''') or (Copy(AParameters, 1, 1) = '"')) and ((Copy(AParameters, 2, 1) <> '''') and (Copy(AParameters, 2, 1) <> '"')) then
 Result.Text:= Copy(AParameters, 2, Length(AParameters) - 1)
 else
 if ((Copy(AParameters, 1, 1) = '''') or (Copy(AParameters, 1, 1) = '"')) and ((Copy(AParameters, 2, 1) = '''') or (Copy(AParameters, 2, 1) = '"')) then
 Result.Text:= Copy(AParameters, 3, Length(AParameters) - 2)
 else
 Result.Text:= AParameters;

 Result.LineBreak:= sLineBreak;

 Result.Text:= StringReplace(Result.Text, '|^e^|', '&', [rfReplaceAll]);
end;



procedure TPrismServerFunctions.UnLockClient(Session: IPrismSession);
begin
 if Assigned(Session) then
 if not (csDestroying in TPrismSession(Session).ComponentState) then
 if not Session.Closing then
 Session.ExecJS('UnLockThreadClient();')
end;

end.
