unit Prism.Cookie;

interface

Uses
 System.Classes, System.SysUtils, System.Generics.Collections, DateUtils,
 Prism.Interfaces;



type
 TPrismCookies = class;


 TPrismCookie = class(TInterfacedPersistent, IPrismCookie)
  private
   FName: string;
   FValue: string;
   FExpire: TDateTime;
   FPath: string;
   FPrismCookies: TPrismCookies;
   function GetName: string;
   procedure SetValue(Value: string);
   function GetValue: string;
  public
   constructor Create(AName: string; AValue: string; AExpire: TDateTime; APath: string);
   destructor Destroy; override;

   function Expire: TDateTime;
   function Path: string;

   procedure Delete;

   property Name: string read GetName;
   property Value: string read GetValue write SetValue;
 end;



 TPrismCookies = class(TInterfacedPersistent, IPrismCookies)
  private
   FItems: TList<IPrismCookie>;
   FPrismSession: IPrismSession;
   FRawCookies: string;
   FFormatSettingsCoookie: TFormatSettings;
   function GetItems: TList<IPrismCookie>;

   function GetCookie(const AName: String): IPrismCookie;
   function GetCookieValue(const AName: String): String;
   procedure SetCookieValue(const AName: String; Value: string);
  protected

  public
   constructor Create(APrismSession: IPrismSession);
   destructor Destroy; override;

   procedure SetRawCookies(Value: string);
   function RawCookies: string;

   function Exist(AName: string): Boolean;

   Procedure Refresh;
   Procedure Clear;

   procedure Add(APrismCookie: IPrismCookie); overload;
   procedure Add(AName, AValue: string; ADay: integer = 0; AMinute: integer = 0; APath: string = '/'); overload;
   procedure Add(AName, AValue: string; AExpire: TDateTime; APath: string); overload;

   function Delete(AName: string): boolean;

   property Item[const AName: string]: IPrismCookie read GetCookie;
   property Value[const AName: string]: string read GetCookieValue write SetCookieValue; default;

   property Items: TList<IPrismCookie> read GetItems;
 end;


implementation


{ TPrismCookie }

constructor TPrismCookie.Create(AName, AValue: string; AExpire: TDateTime; APath: string);
begin
 FName:= AName;
 FValue:= AValue;
 FExpire:= AExpire;
 FPath:= APath;
end;

procedure TPrismCookie.Delete;
begin
 if Assigned(FPrismCookies) then
  FPrismCookies.FPrismSession.ExecJS(
   'document.cookie = "' + FName + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC;"',
   true
 );

 FPrismCookies.Items.Remove(self);

 self.Destroy;
end;

destructor TPrismCookie.Destroy;
begin

 inherited;
end;

function TPrismCookie.Expire: TDateTime;
begin
 Result:= FExpire;
end;

function TPrismCookie.GetName: string;
begin
 Result:= FName;
end;

function TPrismCookie.GetValue: string;
begin
 Result:= FValue;
end;

function TPrismCookie.Path: string;
begin
 result:= FPath;
end;

procedure TPrismCookie.SetValue(Value: string);
var
 vExpirationCookieStr: string;
begin
 FValue:= Value;

 if Assigned(FPrismCookies) then
 begin
  vExpirationCookieStr:= '';

  if FExpire <> 0 then
   vExpirationCookieStr:= FormatDateTime('ddd, dd mmm yyyy hh:nn:ss "GMT"', TTimeZone.Local.ToUniversalTime(FExpire));;

   FPrismCookies.FPrismSession.ExecJS(
    'document.cookie = "' +FName + '='+ FValue +'; expires=' + vExpirationCookieStr + '; path=/"',
    true
   );
 end;
end;

{ TPrismCookies }

procedure TPrismCookies.Add(AName, AValue: string; ADay, AMinute: integer; APath: string);
var
 vDateTime: TDateTime;
begin
 vDateTime:= 0;

 if (ADay > 0) or (AMinute > 0) then
  vDateTime:= IncMinute(IncDay(TTimeZone.Local.ToUniversalTime(Now), ADay), AMinute);

 Add(AName, AValue, vDateTime, APath);
end;

procedure TPrismCookies.Add(APrismCookie: IPrismCookie);
begin
 Add(APrismCookie.Name, APrismCookie.Value, APrismCookie.Expire, APrismCookie.Path);

 TPrismCookie(APrismCookie).Destroy;
end;

procedure TPrismCookies.Add(AName, AValue: string; AExpire: TDateTime; APath: string);
var
 vPrismCookie: TPrismCookie;
 vExpirationCookieStr: string;
begin
 vExpirationCookieStr:= '';
 vPrismCookie:= GetCookie(AName) as TPrismCookie;

 if Assigned(vPrismCookie) then
 begin
  vPrismCookie.Value:= AValue;
  vPrismCookie.FExpire:= AExpire;
 end else
 begin
  vPrismCookie:= TPrismCookie.Create(AName, AValue, AExpire, APath);
  FItems.Add(vPrismCookie);
  vPrismCookie.FPrismCookies:= self;
 end;

 if AExpire <> 0 then
  vExpirationCookieStr:= FormatDateTime('ddd, dd mmm yyyy hh:nn:ss "GMT"', TTimeZone.Local.ToUniversalTime(AExpire));;

  FPrismSession.ExecJS(
   'document.cookie = "' +AName + '='+ AValue +'; expires=' + vExpirationCookieStr + '; path=' + APath + '"',
   true
  );
end;

procedure TPrismCookies.Clear;
var
 vCookieList: TStrings;
 vPrismCookie: IPrismCookie;
begin
 vCookieList:= TStringList.Create;

 try
  try
   for vPrismCookie in FItems do
    vCookieList.Add('document.cookie = "' +vPrismCookie.Name + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC;"');

   if vCookieList.Count > 0 then
    FPrismSession.ExecJS(vCookieList.Text);
  except
  end;
 finally
  vCookieList.Free;
 end;

 FItems.Clear;

 { TODO -cCookie : Fazer no Browser }

end;

constructor TPrismCookies.Create(APrismSession: IPrismSession);
begin
 FPrismSession:= APrismSession;

 FItems:= TList<IPrismCookie>.Create;

 FFormatSettingsCoookie := TFormatSettings.Create;
 FFormatSettingsCoookie.DateSeparator := ' ';
 FFormatSettingsCoookie.TimeSeparator := ':';
 FFormatSettingsCoookie.ShortDateFormat := 'ddd, dd mmm yyyy';
 FFormatSettingsCoookie.ShortTimeFormat := 'hh:nn:ss';
end;

function TPrismCookies.Delete(AName: string): boolean;
var
 vPrismCookie: TPrismCookie;
begin
 vPrismCookie:= GetCookie(AName) as TPrismCookie;

 if Assigned(vPrismCookie) then
 begin
  vPrismCookie.Delete;
  result:= true;
 end else
  result:= false;

end;

destructor TPrismCookies.Destroy;
var
 vPrismCookie: IPrismCookie;
begin
 for vPrismCookie in FItems do
  if Assigned(vPrismCookie) then
   TPrismCookie(vPrismCookie).Destroy;
 FItems.Clear;
 FreeAndNil(FItems);

 inherited;
end;

function TPrismCookies.Exist(AName: string): Boolean;
begin
 result:= Assigned(GetCookie(AName));
end;

function TPrismCookies.GetCookie(const AName: String): IPrismCookie;
var
 vPrismCookie: IPrismCookie;
begin
 for vPrismCookie in FItems do
 begin
  if SameText(AName, vPrismCookie.Name) then
  begin
   Result:= vPrismCookie;
   break;
  end;
 end;

end;

function TPrismCookies.GetCookieValue(const AName: String): String;
var
 vPrismCookie: TPrismCookie;
begin
 vPrismCookie:= GetCookie(AName) as TPrismCookie;

 if Assigned(vPrismCookie) then
  Result:= vPrismCookie.Value;
end;

function TPrismCookies.GetItems: TList<IPrismCookie>;
begin
 result:= FItems;
end;

function TPrismCookies.RawCookies: string;
begin
 result:= FRawCookies;
end;

procedure TPrismCookies.Refresh;
var
 vCookies: TStrings;
 vCookiePair: string;
 vCookieName: string;
 vCookieValue: string;
 vCookiePath: string;
 vCookieExpireStr: string;
 vCookieExpire: TDateTime;
 vPrismCookie: TPrismCookie;
 vEqualPos: Integer;
begin
 FItems.Clear;

 try
   try
   vCookies := TStringList.Create;
   vCookies.LineBreak := ';';
   vCookies.Text := Trim(FRawCookies);

   for vCookiePair in vCookies do
   begin
    vEqualPos := Pos('=', vCookiePair);
    if vEqualPos > 0 then
    begin
     vCookieName := Trim(Copy(vCookiePair, 1, vEqualPos - 1));
     vCookieValue := Trim(Copy(vCookiePair, vEqualPos + 1, Length(vCookiePair) - vEqualPos));

     if (vCookieName <> 'D2Bridge_Token') and
        (vCookieName <> 'D2Bridge_PrismSession') and
        (vCookieName <> 'D2Bridge_ServerUUID') and
        (vCookieName <> 'D2Bridge_ReloadPage') then
     begin
      vCookiePath := '';
      vCookieExpireStr := '';
      vCookieExpire := 0;

      // Separar partes adicionais do cookie
      if Pos('path=', vCookiePair) > 0 then
      begin
       vCookiePath := Trim(Copy(vCookiePair, Pos('path=', vCookiePair) + 5, Length(vCookiePair) - Pos('path=', vCookiePair) - 4));
       if Pos(';', vCookiePath) > 0 then
         vCookiePath := Copy(vCookiePath, 1, Pos(';', vCookiePath) - 1);
      end;

      if Pos('expires=', vCookiePair) > 0 then
      begin
       vCookieExpireStr := Trim(Copy(vCookiePair, Pos('expires=', vCookiePair) + 8, Length(vCookiePair) - Pos('expires=', vCookiePair) - 7));
       if Pos(';', vCookieExpireStr) > 0 then
        vCookieExpireStr := Copy(vCookieExpireStr, 1, Pos(';', vCookieExpireStr) - 1);
       if vCookieExpireStr <> '' then
        if TryStrToDateTime(Copy(vCookieExpireStr, 1, Length(vCookieExpireStr) - 4), vCookieExpire, FFormatSettingsCoookie) then
         vCookieExpire := TTimeZone.Local.ToLocalTime(vCookieExpire);
      end;

      if not Exist(vCookieName) then
      begin
       vPrismCookie := TPrismCookie.Create(vCookieName, vCookieValue, vCookieExpire, vCookiePath);
       FItems.Add(vPrismCookie);
       vPrismCookie.FPrismCookies := self;
      end else
      begin
       vPrismCookie :=nil;
       vPrismCookie.FPrismCookies := nil;
       vPrismCookie.Value := vCookieValue;
       vPrismCookie.FExpire := vCookieExpire;
       vPrismCookie.FPrismCookies := self;
      end;
     end;
    end;
   end;
  except
  end;
 finally
  vCookies.Free;
 end;

end;

procedure TPrismCookies.SetCookieValue(const AName: String; Value: string);
var
 vPrismCookie: TPrismCookie;
begin
 vPrismCookie:= GetCookie(AName) as TPrismCookie;

 if Assigned(vPrismCookie) then
  vPrismCookie.Value:= Value
 else
  Add(AName, Value);
end;

procedure TPrismCookies.SetRawCookies(Value: string);
begin
 FRawCookies:= Value;
end;

end.
