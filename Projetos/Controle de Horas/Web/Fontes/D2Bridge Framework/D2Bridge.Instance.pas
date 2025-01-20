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

unit D2Bridge.Instance;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
{$IFDEF FMX}
  FMX.Forms,
{$ELSE}
  Vcl.Forms,
{$ENDIF}
  D2Bridge, D2Bridge.Interfaces, D2Bridge.Types,
  Prism.Session, Prism.Interfaces;


type
{$IFDEF FMX}
  TFormClass = class of TForm;
{$ENDIF}
  TDataModuleClass = Class of TDataModule;

type
 TD2BridgeInstance = class(TInterfacedPersistent, ID2BridgeInstance)
  strict private
   function FixInstanceObjectName(AObject: TObject): string;
  private
   FObjectInstance: TDictionary<TClass, TObject>;
   FPrismSession: IPrismSession;
   FOwner: TComponent;
   procedure CreateInstanceComponent(AComponent: TComponent); overload;
   procedure CreateInstanceComponent(AObject: TObject); overload;
   procedure CreateInstance(AForm: TForm); overload;
  protected

  public
   constructor Create(AOwner: TComponent);
   destructor Destroy; override;

   function GetPrismSession: IPrismSession;

   function GetInstanceByObjectName(AName: String): TObject;

   procedure AddInstace(AObject: TObject);
   procedure RemoveInstance(AForm: TForm);

   function GetInstance(AForm: TFormClass): TForm; overload;
   function GetInstance(ADM: TDataModuleClass): TDataModule; overload;
   function GetInstance(AClass: TClass): TClass; overload;

   procedure CreateInstance(ADMClass: TDataModuleClass); overload;
   procedure CreateInstance(AClass: TClass); overload;
   procedure CreateInstance(ADM: TDataModule); overload;
   procedure CreateInstance(AFormClass: TFormClass); overload;
   procedure CreateInstance(AFormClass: TFormClass; AOwner: TComponent); overload;

   procedure DestroyInstance(AClass: TClass);
   procedure DestroyAllInstances;

   Function IsD2BridgeContext: Boolean;

   property Owner: TComponent read FOwner;
   property PrismSession: IPrismSession read GetPrismSession;
 end;


 {$IFDEF D2BRIDGE}
  function D2BridgeInstance: TD2BridgeInstance;
 {$ELSE}
  var
   D2BridgeInstance: TD2BridgeInstance;
 {$ENDIF}


 function IsD2BridgeContext: Boolean;
 function PrismSession: TPrismSession;


implementation

Uses
 D2Bridge.Forms
{$IFDEF D2BRIDGE}
  ,D2Bridge.BaseClass
  ,D2Bridge.Manager
  ,Prism.BaseClass
{$ELSE}

{$ENDIF}
;


{ TD2BridgeInstance }

{$IFDEF D2BRIDGE}
 function D2BridgeInstance: TD2BridgeInstance;
 begin
  Result:= TD2BridgeInstance(PrismBaseClass.Sessions.FromThreadID(TThread.CurrentThread.ThreadID).D2BridgeInstance);
 end;
{$ENDIF}

function PrismSession: TPrismSession;
begin
 Result:= D2BridgeInstance.PrismSession as TPrismSession;
end;


procedure TD2BridgeInstance.AddInstace(AObject: TObject);
begin
 CreateInstanceComponent(AObject);

 if AObject is TD2BridgeForm then
  TD2BridgeForm(AObject).UsedD2BridgeInstance:= true;
end;

constructor TD2BridgeInstance.Create(AOwner: TComponent);
begin
 FOwner:= AOwner;

 FObjectInstance:= TDictionary<TClass, TObject>.create;

 {$IFDEF D2BRIDGE}
  FPrismSession:= TPrismSession(AOwner);
 {$ELSE}
  D2BridgeInstance:= self;
  FPrismSession:= TPrismSession.Create(nil);
 {$ENDIF}

 //FD2Bridge:= nil;
end;

procedure TD2BridgeInstance.CreateInstance(AFormClass: TFormClass);
begin
 CreateInstance(AFormClass, FOwner);
end;

procedure TD2BridgeInstance.CreateInstance(AForm: TForm);
begin
// //Precisa checar se já existe;
// if FObjectInstance.ContainsKey(AForm.ClassType) then
// begin
//  //Ja existe
// end else
// if not FObjectInstance.TryAdd(AForm.ClassType, AForm) then
// begin
//  //Algum erro ao incluir
// end;

 CreateInstanceComponent(AForm);

 if AForm is TD2BridgeForm then
 TD2BridgeForm(AForm).UsedD2BridgeInstance:= true;
end;

procedure TD2BridgeInstance.CreateInstanceComponent(AObject: TObject);
begin
 //Precisa checar se já existe;
 if FObjectInstance.ContainsKey(AObject.ClassType) then
 begin
  //Ja existe
 end else
 begin
  FObjectInstance.Add(AObject.ClassType, AObject);
 end;
end;

procedure TD2BridgeInstance.CreateInstance(AClass: TClass);
begin
 CreateInstanceComponent(AClass.Create);
end;

procedure TD2BridgeInstance.CreateInstanceComponent(
  AComponent: TComponent);
begin
 //Precisa checar se já existe;
 if FObjectInstance.ContainsKey(AComponent.ClassType) then
 begin
  //Ja existe
 end else
 begin
  FObjectInstance.Add(AComponent.ClassType, AComponent);
 end;

end;

procedure TD2BridgeInstance.CreateInstance(ADM: TDataModule);
begin
 CreateInstanceComponent(ADM);
end;

procedure TD2BridgeInstance.CreateInstance(ADMClass: TDataModuleClass);
begin
 {$IFDEF D2BRIDGE}
  PrismSession.ExecThread(true,
   procedure
   begin
    CreateInstance(ADMClass.Create(FOwner));
   end
  );
 {$ELSE}
  CreateInstance(ADMClass.Create(FOwner));
 {$ENDIF}
end;

destructor TD2BridgeInstance.Destroy;
begin
 //DestroyAllInstances;

 {$IFNDEF D2BRIDGE}
  TPrismSession(FPrismSession).Destroy;
 {$ENDIF}

 FObjectInstance.Free;

 inherited;
end;

procedure TD2BridgeInstance.DestroyAllInstances;
var
 vEndLoop: Boolean;
begin
 if FObjectInstance.Count > 0 then
 repeat
 begin
  DestroyInstance(FObjectInstance.ToArray[Pred(FObjectInstance.Count)].Key);

  TThread.CurrentThread.Synchronize(TThread.CurrentThread,
   procedure
   begin
    if FObjectInstance.Count <= 0 then
    vEndLoop:= true;
   end
  );
 end until vEndLoop;
end;

procedure TD2BridgeInstance.DestroyInstance(AClass: TClass);
var
 ObjectDestroy: TObject;
begin
 if FObjectInstance.TryGetValue(AClass, ObjectDestroy) then
 begin
  try
   try
    if ObjectDestroy <> nil then
    begin
     try
      if ObjectDestroy is TD2BridgeForm then
      begin
       TD2BridgeForm(ObjectDestroy).UsedD2BridgeInstance:= false;
       TD2BridgeForm(ObjectDestroy).Destroy;
      end else
      if (ObjectDestroy is TForm) then
      begin
       TForm(ObjectDestroy).Release;
       TForm(ObjectDestroy).Free;
      end else
      if (ObjectDestroy is TDataModule) then
      begin
       TForm(ObjectDestroy).Release;
       TForm(ObjectDestroy).Free;
      end else
      begin
       ObjectDestroy.Destroy;
      end;
     except

     end;
     ObjectDestroy:= nil;
    end;
   except

   end;
  finally
   FObjectInstance.Remove(AClass);
  end;

 end;

end;

function TD2BridgeInstance.FixInstanceObjectName(AObject: TObject): string;
var
 vInstanceNumberStr: String;
 vInstanceNumber: Integer;
 vName, vNamebyClass, vPosName: String;
begin
 Result:= '';
 if AObject.InheritsFrom(TComponent) then
 begin
  vName:= TComponent(AObject).Name;
  Result:= vName;
  vNamebyClass:= Copy(TComponent(AObject).ClassName, 2);

  vPosName:= Copy(vName, Length(vNamebyClass)+1);
  vInstanceNumberStr:= Copy(vPosName, Length(vPosName));

  if (AnsiPos('_', vPosName) = 1) and (TryStrToInt(vInstanceNumberStr, vInstanceNumber)) then
  begin
   //TCOmponent(AObject).Name:= vNamebyClass;
   Result:= vNamebyClass;
  end;
 end;
end;

function TD2BridgeInstance.GetInstance(AClass: TClass): TClass;
begin
 if not FObjectInstance.TryGetValue(AClass, TObject(Result)) then
 begin
//   Result := AForm.Create(Application);
//   FObjectInstance.Add(AForm, Result);
  Result:= nil;
 end;

end;

function TD2BridgeInstance.GetInstanceByObjectName(AName: String): TObject;
var
 I: integer;
 vComponentName: string;
begin
 Result:= nil;

 for I := 0 to Pred(FObjectInstance.Count) do
 begin
  if FObjectInstance.ToArray[I].Value.InheritsFrom(TComponent) then
  begin
   vComponentName:= TComponent(FObjectInstance.ToArray[I].Value).Name;
   if SameText(AName, vComponentName) then
   begin
    Result:= FObjectInstance.ToArray[I].Value;
    Break;
   end;
  end;
 end;

 if Result = nil then
 for I := 0 to Pred(FObjectInstance.Count) do
 begin
  if FObjectInstance.ToArray[I].Value.InheritsFrom(TComponent) then
  begin
   vComponentName:= FixInstanceObjectName(TComponent(FObjectInstance.ToArray[I].Value));
   if SameText(AName, vComponentName) then
   begin
    Result:= FObjectInstance.ToArray[I].Value;
    Break;
   end;
  end;
 end;

end;

function TD2BridgeInstance.IsD2BridgeContext: Boolean;
begin
 {$IFDEF D2BRIDGE}
 Result := True;
 {$ELSE}
 Result := False;
 {$ENDIF}
end;

function TD2BridgeInstance.GetPrismSession: IPrismSession;
begin
 Result:= FPrismSession;
end;

procedure TD2BridgeInstance.RemoveInstance(AForm: TForm);
begin
 if FObjectInstance.ContainsKey(AForm.ClassType) then
 FObjectInstance.Remove(AForm.ClassType);
end;

function IsD2BridgeContext: Boolean;
begin
 {$IFDEF D2BRIDGE}
 Result := True;
 {$ELSE}
 Result := False;
 {$ENDIF}
end;

function TD2BridgeInstance.GetInstance(ADM: TDataModuleClass): TDataModule;
begin
 if not FObjectInstance.TryGetValue(ADM, TObject(Result)) then
 begin
//   Result := AForm.Create(Application);
//   FObjectInstance.Add(AForm, Result);
  Result:= nil;
 end;

end;

function TD2BridgeInstance.GetInstance(AForm: TFormClass): TForm;
begin
 if not FObjectInstance.TryGetValue(AForm, TObject(Result)) then
 begin
  Result:= nil;
 end;
end;


procedure TD2BridgeInstance.CreateInstance(AFormClass: TFormClass;
  AOwner: TComponent);
begin
 CreateInstance(AFormClass.Create(AOwner));
end;




{$IFDEF D2BRIDGE}

{$ELSE}
initialization
 D2BridgeInstance:= TD2BridgeInstance.Create(Application);
finalization
 D2BridgeInstance.Destroy;
{$ENDIF}

end.

