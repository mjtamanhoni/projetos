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
}

{$I D2Bridge.inc}

unit D2Bridge.Prism.Button;

interface

uses
  System.Classes,
{$IFDEF FMX}
{$ELSE}
  Vcl.StdCtrls, Vcl.Controls,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Prism, D2Bridge.Prism.Item;



type
 PrismButton = class(TD2BridgePrismItem, ID2BridgeFrameworkItemButton)
  private
   FCaption: String;
  public
   procedure Clear; override;
   function FrameworkClass: TClass; override;
   procedure ProcessPropertyClass(VCLObj, NewObj: TObject); override;
   procedure ProcessEventClass(VCLObj, NewObj: TObject); override;
   procedure ProcessPropertyByName(VCLObj, NewObj: TObject; PropertyName: string; PropertyValue: Variant); override;

   procedure SetCaption(ACaption: String);
   function GetCaption: String;

   property Caption: String read GetCaption write SetCaption;
  end;


implementation

uses
  System.SysUtils, Prism.Button;

{ PrismButton }

procedure PrismButton.Clear;
begin
 inherited;

 FCaption:= '';
end;

function PrismButton.FrameworkClass: TClass;
begin
 inherited;

 Result:= TPrismButton;
end;

function PrismButton.GetCaption: String;
begin
 Result:= FCaption;

end;

procedure PrismButton.ProcessEventClass(VCLObj, NewObj: TObject);
begin
 inherited;

end;

procedure PrismButton.ProcessPropertyByName(VCLObj, NewObj: TObject;
  PropertyName: string; PropertyValue: Variant);
begin
 inherited;
end;

procedure PrismButton.ProcessPropertyClass(VCLObj, NewObj: TObject);
begin
 inherited;

 TPrismButton(NewObj).Caption:= Caption;

end;

procedure PrismButton.SetCaption(ACaption: String);
begin
 FCaption:= ACaption;

end;

{ TD2BridgeProxyButton }



end.
