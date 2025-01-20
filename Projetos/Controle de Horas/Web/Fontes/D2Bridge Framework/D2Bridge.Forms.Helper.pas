unit D2Bridge.Forms.Helper;

interface

Uses
 System.Classes, RTTI, System.Generics.Collections, System.SysUtils,
 D2Bridge.Interfaces, Prism.interfaces;

type
 TD2BridgeFormComponentHelperItems = class;
 TD2BridgeFormComponentHelperProp = class;

 TD2BridgeFormComponentHelper = class(TObject)
  private
   FComponent: TObject;
   FComponentHelperProps: TDictionary<string, TD2BridgeFormComponentHelperProp>;
   FD2BridgeFormComponentHelperItems: TD2BridgeFormComponentHelperItems;
   FOnDestroy: TProc;
   procedure SetValue(APropertyName: string; APropertyValue: TValue);
   function GetValue(APropertyName: string): TValue;
  public
   constructor Create(AComponentHelperItems: TD2BridgeFormComponentHelperItems; AComponent: TObject);
   destructor Destroy; override;

   function Prop(APropertyName: string): TD2BridgeFormComponentHelperProp;

   property Component: TObject read FComponent;
   property Value[APropertyName: string]: TValue read GetValue write SetValue;
   property OnDestroy: TProc read FOnDestroy write FOnDestroy;
 end;


 TD2BridgeFormComponentHelperProp = class(TObject)
  private
   FPropertyName: string;
   FPropertyValue: TValue;
   FComponentHelper: TD2BridgeFormComponentHelper;
  public
   constructor Create(AComponentHelper: TD2BridgeFormComponentHelper; APropertyName: String);

   property PropertyName: string read FPropertyName;
   property PropertyValue: TValue read FPropertyValue write FPropertyValue;
 end;


 TD2BridgeFormComponentHelperItems = class(TObject)
  private
   FD2BridgeForm: TObject;
   FSession: IPrismSession;
   FFormComponentHelpers: TDictionary<TObject, TD2BridgeFormComponentHelper>;
   procedure SetValue(AComponent: TOBject; APropertyName: string; APropertyValue: TValue);
   function GetValue(AComponent: TOBject; APropertyName: string): TValue;
  public
   constructor Create(AD2BridgeForm: TObject);
   destructor Destroy; override;

   function PropValues(AComponent: TOBject): TD2BridgeFormComponentHelper;

   property Value[AComponent: TOBject; APropertyName: string]: TValue read GetValue write SetValue;
   property D2BridgeForm: TObject read FD2BridgeForm;
   property Session: IPrismSession read FSession;
 end;

function TagIsD2BridgeFormComponentHelper(ATag: NativeInt): Boolean;

implementation

Uses
 D2Bridge.Forms;


{ TD2BridgeFormComponentHelperItems }

constructor TD2BridgeFormComponentHelperItems.Create(AD2BridgeForm: TObject);
begin
 FD2BridgeForm:= AD2BridgeForm;
 FSession:= TD2BridgeForm(AD2BridgeForm).PrismSession;

 FFormComponentHelpers:= TDictionary<TObject, TD2BridgeFormComponentHelper>.Create;
end;

destructor TD2BridgeFormComponentHelperItems.Destroy;
begin
 FreeAndNil(FFormComponentHelpers);

 inherited;
end;

function TD2BridgeFormComponentHelperItems.GetValue(AComponent: TOBject; APropertyName: string): TValue;
begin
 result:= PropValues(AComponent).Value[APropertyName];
end;

function TD2BridgeFormComponentHelperItems.PropValues(AComponent: TOBject): TD2BridgeFormComponentHelper;
var
 vComponentHelper: TD2BridgeFormComponentHelper;
begin
 if not FFormComponentHelpers.TryGetValue(AComponent, vComponentHelper) then
 begin
  vComponentHelper:= TD2BridgeFormComponentHelper.Create(self, AComponent);
  FFormComponentHelpers.Add(AComponent, vComponentHelper);
 end;

 Result:= vComponentHelper;
end;

procedure TD2BridgeFormComponentHelperItems.SetValue(AComponent: TOBject; APropertyName: string; APropertyValue: TValue);
begin
 PropValues(AComponent).Value[APropertyName]:= APropertyValue;
end;

{ TD2BridgeFormComponentHelper }

constructor TD2BridgeFormComponentHelper.Create(AComponentHelperItems: TD2BridgeFormComponentHelperItems; AComponent: TObject);
begin
 FD2BridgeFormComponentHelperItems:= AComponentHelperItems;
 FComponent:= AComponent;

 FComponentHelperProps:= TDictionary<string, TD2BridgeFormComponentHelperProp>.Create;
end;

destructor TD2BridgeFormComponentHelper.Destroy;
begin
 if Assigned(FOnDestroy) then
  FOnDestroy;

 FreeAndNil(FComponentHelperProps);

 inherited;
end;

function TD2BridgeFormComponentHelper.GetValue(APropertyName: string): TValue;
begin
 result:= Prop(APropertyName).PropertyValue;
end;

function TD2BridgeFormComponentHelper.Prop(APropertyName: string): TD2BridgeFormComponentHelperProp;
var
 vComponentHelperProp: TD2BridgeFormComponentHelperProp;
begin
 if not FComponentHelperProps.TryGetValue(APropertyName, vComponentHelperProp) then
 begin
  vComponentHelperProp:= TD2BridgeFormComponentHelperProp.Create(self, APropertyName);
  FComponentHelperProps.Add(APropertyName, vComponentHelperProp);
 end;

 Result:= vComponentHelperProp;
end;

procedure TD2BridgeFormComponentHelper.SetValue(APropertyName: string; APropertyValue: TValue);
begin
 Prop(APropertyName).PropertyValue:= APropertyValue;
end;

{ TD2BridgeFormComponentHelperProp }

constructor TD2BridgeFormComponentHelperProp.Create(AComponentHelper: TD2BridgeFormComponentHelper; APropertyName: String);
begin
 FComponentHelper:= AComponentHelper;
 FPropertyName:= APropertyName;
end;

function TagIsD2BridgeFormComponentHelper(ATag: NativeInt): Boolean;
begin
 Result:= TObject(ATag) is TD2BridgeFormComponentHelper;
end;

end.
