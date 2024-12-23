unit uACBr;

interface

uses
  System.SysUtils,
  ACBrBase, ACBrValidador;

type
  //Validador
  TTipoDocto = (docCPF,docCNPJ,docUF,docInscEst);

  TACBr_Validador = class(TOBject)
  private
    FEnder :String;
  public
    constructor Create(AEnder:String);

    function Validar(
      ATipoDocto:TTipoDocto;
      ADocumento:String='';
      AIgnorar:String='./-';
      AComplemento:String=''):Boolean;
  end;

implementation

{ TACBr_Validador }

constructor TACBr_Validador.Create(AEnder: String);
begin
  FEnder := '';
  FEnder := AEnder;
end;

function TACBr_Validador.Validar(
  ATipoDocto:TTipoDocto;
  ADocumento:String='';
  AIgnorar:String='./-';
  AComplemento:String=''): Boolean;
var
  FACBrValidador :TACBrValidador;
begin
  try
    try
      Result := False;

      FACBrValidador := TACBrValidador.Create(Nil);

      case ATipoDocto of
        docCPF :FACBrValidador.TipoDocto := TACBrValTipoDocto(0);
        docCNPJ :FACBrValidador.TipoDocto := TACBrValTipoDocto(1);
        docUF :FACBrValidador.TipoDocto := TACBrValTipoDocto(2);
        docInscEst :FACBrValidador.TipoDocto := TACBrValTipoDocto(3);
      end;

      FACBrValidador.Documento   := ADocumento;
      FACBrValidador.Complemento := AComplemento;
      FACBrValidador.IgnorarChar := AIgnorar;

      if FACBrValidador.Validar then
      begin
         Result := True;
      end
      else
      begin
        Result := False;
        raise Exception.Create(FACBrValidador.MsgErro);
      end;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(FACBrValidador);
    {$ELSE}
      FACBrValidador.DisposeOf;
    {$ENDIF}
  end;
end;

end.
