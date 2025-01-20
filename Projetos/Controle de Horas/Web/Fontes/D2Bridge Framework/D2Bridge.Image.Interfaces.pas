unit D2Bridge.Image.Interfaces;

interface

Uses
 System.Classes,
 {$IFDEF FMX}
   FMX.Graphics, FMX.Objects
 {$ELSE}
   Vcl.Graphics, Vcl.ExtCtrls
 {$ENDIF}
 ;

type
 ID2BridgeImage = interface;

 ID2BridgeImage = interface
  ['{4FE0BCDC-39E1-474B-A1E4-30F72170AA26}']
  function getImageFromBase64: string;
  function getLocal: string;
  function GetPicture: {$IFNDEF FMX}TPicture{$ELSE}TBitmap{$ENDIF};
  function getURL: string;
  procedure setImageFromBase64(const Value: string);
  procedure SetImage(const Value: TImage);
  procedure setLocal(const Value: string);
  procedure SetPicture(const Value: {$IFNDEF FMX}TPicture{$ELSE}TBitmap{$ENDIF});
  procedure setURL(const Value: string);

  function IsEmpty: Boolean;
  function IsBase64: Boolean;
  function ImageToBase64: string;

  property Image: TImage write SetImage;
  property Picture: {$IFNDEF FMX}TPicture{$ELSE}TBitmap{$ENDIF} read GetPicture write SetPicture;
  property URL: string read getURL write setURL;
  property Local: string read getLocal write setLocal;
  property ImageFromBase64: string read getImageFromBase64 write setImageFromBase64;

 end;

implementation

end.
