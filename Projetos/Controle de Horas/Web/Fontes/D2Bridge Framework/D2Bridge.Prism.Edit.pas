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

unit D2Bridge.Prism.Edit;

interface

uses
  System.Classes, System.UITypes,
  D2Bridge.Interfaces, D2Bridge.Prism, D2Bridge.Prism.Item,
  Prism.Types;


type
 TPrismFieldType = Prism.Types.TPrismFieldType;


type
 PrismEdit = class(TD2BridgePrismItem, ID2BridgeFrameworkItemEdit)
  private
   FProcSetText: TOnSetValue;
   FProcGetText: TOnGetValue;
   FDataType: TPrismFieldType;
   FCharCase: TEditCharCase;
   FMaxLength: integer;
   procedure SetOnGetText(AProc: TOnGetValue);
   function GetOnGetText: TOnGetValue;
   procedure SetOnSetText(AProc: TOnSetValue);
   function GetOnSetText: TOnSetValue;
   procedure SetEditDataType(AEditType: TPrismFieldType);
   function GetEditDataType: TPrismFieldType;
   function GetCharCase: TEditCharCase;
   procedure SetCharCase(ACharCase: TEditCharCase);
   function GetMaxLength: integer;
   procedure SetMaxLength(const Value: integer);
  public
   procedure Clear; override;
   function FrameworkClass: TClass; override;
   procedure ProcessPropertyClass(VCLObj, NewObj: TObject); override;
   procedure ProcessEventClass(VCLObj, NewObj: TObject); override;
   procedure ProcessPropertyByName(VCLObj, NewObj: TObject; PropertyName: string; PropertyValue: Variant); override;

   property MaxLength: integer read GetMaxLength write SetMaxLength;

   property DataType: TPrismFieldType read GetEditDataType write SetEditDataType;
   property CharCase: TEditCharCase read GetCharCase write SetCharCase;
   property OnGetText: TOnGetValue read GetOnGetText write SetOnGetText;
   property OnSetText: TOnSetValue read GetOnSetText write SetOnSetText;
  end;



implementation

uses
  Prism.Edit;


{ PrismEdit }


procedure PrismEdit.Clear;
begin
 inherited;

 FMaxLength:= 0;
 FDataType:= PrismFieldTypeAuto;
 FCharCase:= TEditCharCase.ecNormal;
 FProcSetText:= nil;
 FProcGetText:= nil;
end;

function PrismEdit.FrameworkClass: TClass;
begin
 inherited;

 Result:= TPrismEdit;
end;

function PrismEdit.GetCharCase: TEditCharCase;
begin
 Result:= FCharCase;
end;

function PrismEdit.GetEditDataType: TPrismFieldType;
begin
 Result:= FDataType;
end;

function PrismEdit.GetMaxLength: integer;
begin
 Result:= FMaxLength;
end;

function PrismEdit.GetOnGetText: TOnGetValue;
begin
 Result:= FProcGetText;
end;

function PrismEdit.GetOnSetText: TOnSetValue;
begin
 Result:= FProcSetText;
end;


procedure PrismEdit.ProcessEventClass(VCLObj, NewObj: TObject);
begin
 inherited;

end;

procedure PrismEdit.ProcessPropertyByName(VCLObj, NewObj: TObject;
  PropertyName: string; PropertyValue: Variant);
begin
 inherited;

end;

procedure PrismEdit.ProcessPropertyClass(VCLObj, NewObj: TObject);
begin
 inherited;

 TPrismEdit(NewObj).DataType:= DataType;

 TPrismEdit(NewObj).CharCase:= CharCase;

 TPrismEdit(NewObj).MaxLength:= FMaxLength;

 if Assigned(FProcSetText) then
 TPrismEdit(NewObj).ProcSetText:= FProcSetText;

 if Assigned(FProcGetText) then
 TPrismEdit(NewObj).ProcGetText:= FProcGetText;
end;


procedure PrismEdit.SetCharCase(ACharCase: TEditCharCase);
begin
 FCharCase:= ACharCase;
end;

procedure PrismEdit.SetEditDataType(AEditType: TPrismFieldType);
begin
 FDataType:= AEditType;
end;

procedure PrismEdit.SetMaxLength(const Value: integer);
begin
 FMaxLength:= Value;
end;

procedure PrismEdit.SetOnGetText(AProc: TOnGetValue);
begin
 FProcGetText:= AProc;
end;

procedure PrismEdit.SetOnSetText(AProc: TOnSetValue);
begin
 FProcSetText := AProc;
end;

end.
