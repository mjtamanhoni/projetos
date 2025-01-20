{$I D2Bridge.inc}

unit D2Bridge.Lang.Term.BaseClass;

interface

uses
  System.Classes, System.Generics.Collections,
  D2Bridge.Lang.Interfaces;


type
 ID2BridgeLang = D2Bridge.Lang.Interfaces.ID2BridgeLang;


type
 TD2BridgeTermClass = class of TD2BridgeTermBaseClass;


 TD2BridgeTermBaseClass = class(TInterfacedPersistent, ID2BridgeTerm)
  private
   FItems: TList<TObject>;
   FD2BridgeLang: ID2BridgeLang;
  public
   constructor Create(AID2BridgeLang: ID2BridgeLang); virtual;
   destructor Destroy; override;

   function Context: string; virtual;

   function Language: ID2BridgeLang; virtual;
 end;



 TD2BridgeTermItem = class(TInterfacedPersistent, ID2BridgeTermItem)
  private
   FD2BridgeTerm: ID2BridgeTerm;
   FContext: String;
   FD2BridgeLang: ID2BridgeLang;
  public
   constructor Create(AD2BridgeTerm: ID2BridgeTerm; AContext: String);

  published
   function D2BridgeTerm: ID2BridgeTerm;
   function Language: ID2BridgeLang;
   function Context: string;
 end;



implementation

{ TD2BridgeTermBaseClass }

function TD2BridgeTermBaseClass.Context: string;
begin
 result:= '';
end;

constructor TD2BridgeTermBaseClass.Create(AID2BridgeLang: ID2BridgeLang);
begin
 FD2BridgeLang:= AID2BridgeLang;
 FItems:= TList<TObject>.Create;
end;

destructor TD2BridgeTermBaseClass.Destroy;
var
 I: integer;
begin
 try
  for I := 0 to Pred(FItems.Count) do
   FItems[I].Destroy;

  FItems.Destroy;
 except

 end;

 inherited;
end;


function TD2BridgeTermBaseClass.Language: ID2BridgeLang;
begin
 Result:= FD2BridgeLang;
end;

{ TD2BridgeTermItem }

function TD2BridgeTermItem.Context: string;
begin
 Result:= FContext;
end;

constructor TD2BridgeTermItem.Create(AD2BridgeTerm: ID2BridgeTerm; AContext: String);
begin
 FContext:= AContext;
 FD2BridgeTerm:= AD2BridgeTerm;
 TD2BridgeTermBaseClass(FD2BridgeTerm).FItems.Add(self);
 FD2BridgeLang:= FD2BridgeTerm.Language;
end;

function TD2BridgeTermItem.D2BridgeTerm: ID2BridgeTerm;
begin
 Result:= FD2BridgeTerm;
end;

function TD2BridgeTermItem.Language: ID2BridgeLang;
begin
 Result:= FD2BridgeLang;
end;

end.
