{$I D2Bridge.inc}

unit D2Bridge.Lang.Core.JSON;

interface

uses
  System.Classes, System.SysUtils, System.JSON, System.RTTI, System.TypInfo,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  D2Bridge.Lang.Interfaces;

 procedure GenerateJSON(Translate: TObject; var JSONObject : TJSONObject);
 procedure GenerateSubJSON(const Instance: IInterface; JsonObject: TJSONObject);


implementation

{ GenerateJSON }

procedure GenerateJSON(Translate: TObject; var JSONObject : TJSONObject);
var
  Ctx: TRttiContext;
  Typ: TRttiType;
  Meth: TRttiMethod;
  Field: TRttiField;
  SubJson: TJSONObject;
  ReturnValue: TValue;
begin
  JSONObject := TJSONObject.Create;

  try
    Ctx := TRttiContext.Create;

    try
      Typ := Ctx.GetType(TObject(Translate).ClassType);

      for Field in Typ.GetDeclaredFields do
      begin
        if Field.Visibility = mvPublic then
        begin
         if Field.FieldType.TypeKind in [tkUString, tkWString, tkLString] then
         begin
          JSONObject.AddPair(Field.Name, '');
         end else
         if Supports(Field.FieldType.AsInstance.MetaclassType, ID2BridgeTermItem) then
         begin
          ReturnValue:= Field.GetValue(TObject(Translate));
          SubJson := TJSONObject.Create;
          JSONObject.AddPair(Field.Name, SubJson);
          GenerateSubJSON(ReturnValue.AsInterface, SubJson);
         end;
        end;
      end;

      for Meth in Typ.GetDeclaredMethods do
      begin
        if Meth.Visibility = mvPublic then
        begin
          if Meth.MethodKind = mkFunction then
          begin
           if not (Meth.ReturnType is TRttiInterfaceType) then
           begin
            if Meth.ReturnType.TypeKind <> tkInterface then
            begin
             if Meth.ReturnType.TypeKind in [tkUString, tkWString, tkLString] then
             begin
              JSONObject.AddPair(Meth.Name, '');
             end else
             begin
              ReturnValue := Meth.Invoke(TObject(Translate), []);
              //if ReturnValue.IsObjectInstance then
              if Supports(ReturnValue.AsInterface, ID2BridgeTermItem) then
              begin
               SubJson := TJSONObject.Create;
               JSONObject.AddPair(Meth.Name, SubJson);
               GenerateSubJSON(ReturnValue.AsInterface, SubJson);
              end;
             end;
            end;
           end;
          end;
        end;
      end;
    finally
      Ctx.Free;
    end;
  finally

  end;
end;

procedure GenerateSubJSON(const Instance: IInterface; JsonObject: TJSONObject);
var
  Ctx: TRttiContext;
  Typ: TRttiType;
  Meth: TRttiMethod;
  Field: TRttiField;
  ReturnValue: TValue;
begin
  Ctx := TRttiContext.Create;

  try
    Typ := Ctx.GetType((Instance as TObject).ClassType);

    for Field in Typ.GetDeclaredFields do
    begin
      if Field.Visibility = mvPublic then
      begin
       if Field.FieldType.TypeKind in [tkUString, tkWString, tkLString] then
       begin
        JSONObject.AddPair(Field.Name, '');
       end;
      end;
    end;

    for Meth in Typ.GetDeclaredMethods  do
    begin
      if Meth.Visibility = mvPublic then
      begin
        if Meth.MethodKind = mkFunction then
        begin
          JsonObject.AddPair(Meth.Name, '');

          if Meth.ReturnType is TRttiInterfaceType then
          begin
           ReturnValue := Meth.Invoke(Typ.ClassType, []);

           if Meth.ReturnType.TypeKind = tkInterface then
           begin
            GenerateSubJSON(ReturnValue.AsInterface, JsonObject.GetValue(Meth.Name) as TJSONObject);
           end;
          end;
        end;
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

end.
