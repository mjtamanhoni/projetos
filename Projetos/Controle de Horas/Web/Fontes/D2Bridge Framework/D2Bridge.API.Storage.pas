{
 +--------------------------------------------------------------------------+
  D2Bridge Framework Content

  Storageor: Talis Jonatas Gomes
  Email: talisjonatas@me.com

  This source code is provided 'as-is', without any express or implied
  warranty. In no event will the Storageor be held liable for any damages
  arising from the use of this code.

  However, it is granted that this code may be used for any purpose,
  including commercial applications, but it may not be modified,
  distributed, or sublicensed without express written Storageorization from
  the Storageor (Talis Jonatas Gomes). This includes creating derivative works
  or distributing the source code through any means.

  If you use this software in a product, an acknowledgment in the product
  documentation would be appreciated but is not required.

  God bless you
 +--------------------------------------------------------------------------+
  Thanks for contribution to this Unit to:
   João B. S. Junior
   Phone +55 69 99250-3445
   Email jr.playsoft@gmail.com
 +--------------------------------------------------------------------------+
}

{$I D2Bridge.inc}

unit D2Bridge.API.Storage;

interface

Uses
   System.Classes, System.SysUtils,
   D2Bridge.Interfaces
  {$IFDEF FMX}

  {$ELSE}

  {$ENDIF}
  ;

type
  TD2BridgeAPIStorage = class(TInterfacedPersistent, ID2BridgeAPIStorage)
   private
      FAmazonS3: ID2BridgeAPIStorageAmazonS3;
   public
    constructor Create;
    destructor Destroy; override;

    function AmazonS3: ID2BridgeAPIStorageAmazonS3;

  end;

implementation

Uses
 D2Bridge.API.Storage.AmazonS3;

{ TD2BridgeAPIStorage }

constructor TD2BridgeAPIStorage.Create;
begin
 inherited;

 FAmazonS3:= TD2BridgeAPIStorageAmazonS3.Create;
end;

destructor TD2BridgeAPIStorage.Destroy;
begin
 (FAmazonS3 as TD2BridgeAPIStorageAmazonS3).Destroy;
 FAmazonS3:= nil;

 inherited;
end;

function TD2BridgeAPIStorage.AmazonS3: ID2BridgeAPIStorageAmazonS3;
begin
 result:= FAmazonS3;
end;

end.
