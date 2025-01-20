unit D2Bridge.FMX.FakeForm;

interface

{$IFDEF FMX}

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Objects;

type
  TFMXFakeForm = class(TForm)
    Text1: TText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMXFakeForm: TFMXFakeForm;

implementation

{$R *.fmx}

{$ELSE}
implementation
{$ENDIF}

end.
