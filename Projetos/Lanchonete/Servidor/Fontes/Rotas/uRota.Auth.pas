unit uRota.Auth;

interface

uses
  Horse,
  Horse.JWT,
  JOSE.Core.JWT,
  JOSE.Types.JSON,
  JOSE.Core.Builder,
  System.JSON,
  System.SysUtils;

const
  SECRET = 'G11N18@Ta';

type
  TMyClaims = class(TJWTClaims)
  private
    function GetCocUsuario: Integer;
    procedure SetCodUsuario(const Value: Integer);
  public
    property COD_USUARIO :Integer read GetCocUsuario write SetCodUsuario;
  end;

function Criar_Token(ACod_Usuario :Integer):String;
function Get_Usuario_Request(AReq :THorseRequest):Integer;


implementation

function Criar_Token(ACod_Usuario :Integer):String;
var
  Jwt :TJWT;
  Claims :TMyClaims;
begin
  try
    Jwt    := TJWT.Create;
    Claims := TMyClaims(Jwt.Claims);

    try
      Claims.COD_USUARIO := ACod_Usuario;
      Result := TJOSE.SHA256CompactToken(SECRET,Jwt);
    except
      Result := '';
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(Jwt);
    {$ELSE}
      Jwt.DisposeOf;
    {$ENDIF}
  end;
end;

function Get_Usuario_Request(AReq :THorseRequest):Integer;
var
  Claims :TMyClaims;
begin
  Claims := AReq.Session<TMyClaims>;
  Result := Claims.COD_USUARIO;
end;

function TMyClaims.GetCocUsuario: Integer;
begin
  Result := FJSON.GetValue<Integer>('id',0);
end;

procedure TMyClaims.SetCodUsuario(const Value: Integer);
begin
  TJSONUtils.SetJSONValueFrom<Integer>('id',Value,FJSON);
end;

end.
