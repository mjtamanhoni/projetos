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
  Thank for contribution to this Unit to:
    Edvanio Jancy
    edvanio@ideiasistemas.com.br
 +--------------------------------------------------------------------------+
}

{$I D2Bridge.inc}

unit D2Bridge.Prism.Memo;

interface

uses
  System.Classes,
{$IFDEF FMX}
{$ELSE}
  Vcl.StdCtrls, Vcl.Controls, Vcl.Graphics,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Prism, D2Bridge.Prism.Item;



type
 PrismMemo = class(TD2BridgePrismItem, ID2BridgeFrameworkItemMemo)
  private
   FLines: TStrings;
   FRows: Integer;
  public
   constructor Create(AD2BridgePrismFramework: TD2BridgePrismFramework); override;

   procedure Clear; override;
   function FrameworkClass: TClass; override;
   procedure ProcessPropertyClass(VCLObj, NewObj: TObject); override;
   procedure ProcessEventClass(VCLObj, NewObj: TObject); override;
   procedure ProcessPropertyByName(VCLObj, NewObj: TObject; PropertyName: string; PropertyValue: Variant); override;

   procedure SetLines(ALines: TStrings);
   function GetLines: TStrings;

   procedure SetRows(ARows: Integer);
   function GetRows: Integer;

   property Lines: TStrings read FLines write FLines;
   property Rows: Integer read GetRows write SetRows;
  end;

implementation

uses
  System.SysUtils, Prism.Memo;

{ PrismMemo }

procedure PrismMemo.Clear;
begin
  inherited;
  FLines := nil;
  FRows  := 3;
end;

constructor PrismMemo.Create(AD2BridgePrismFramework: TD2BridgePrismFramework);
begin
 inherited;
end;

function PrismMemo.FrameworkClass: TClass;
begin
  Result := TPrismMemo;
end;

function PrismMemo.GetLines: TStrings;
begin
  Result := FLines;
end;

function PrismMemo.GetRows: Integer;
begin
  Result := FRows;
end;

procedure PrismMemo.ProcessEventClass(VCLObj, NewObj: TObject);
begin
  inherited;

end;

procedure PrismMemo.ProcessPropertyByName(VCLObj, NewObj: TObject;
  PropertyName: string; PropertyValue: Variant);
begin
  inherited;
end;

procedure PrismMemo.ProcessPropertyClass(VCLObj, NewObj: TObject);
begin
  inherited;
  TPrismMemo(NewObj).Lines := Lines;
end;

procedure PrismMemo.SetLines(ALines: TStrings);
begin
  FLines := ALines;
end;

procedure PrismMemo.SetRows(ARows: Integer);
begin
   FRows := ARows;
end;

end.
