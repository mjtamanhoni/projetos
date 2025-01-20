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

unit D2Bridge.VCLObj.TStringGrid;

interface

uses
  System.Classes,
{$IFDEF FMX}
  FMX.Grid, FMX.Types,
{$ELSE}
  Vcl.Grids,
{$ENDIF}
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
  TVCLObjTStringGrid = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function CSSClass: String;
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;

implementation

uses
  System.SysUtils, Data.DB,
  D2Bridge.Types, D2Bridge.Util,
  Prism.Util, Prism.Types;

{ TVCLObjTStringGrid }

constructor TVCLObjTStringGrid.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTStringGrid.CSSClass: String;
begin
 result:= 'table table-hover table-sm table-bordered ui-jqgrid-htable d2bridgedbgrid cursor-pointer';
end;

function TVCLObjTStringGrid.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid;
end;

function TVCLObjTStringGrid.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTStringGrid.ProcessEventClass;
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.OnSelect :=
  procedure(EventParams: TStrings)
  begin

  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.OnCheck :=
  procedure(EventParams: TStrings)
  begin

  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.OnUnCheck :=
  procedure(EventParams: TStrings)
  begin

  end;


// FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.OnClick :=
//  procedure(EventParams: TStrings)
//  begin
//
//  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.OnDblClick :=
  procedure(EventParams: TStrings)
  begin
   if Assigned(TStringGrid(FD2BridgeItemVCLObj.Item).OnDblClick) then
      TStringGrid(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.OnSelectAll :=
   procedure(EventParams: TStrings)
   begin
    try
     try

     except

     end;
    finally

    end;
   end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.OnUnSelectAll :=
   procedure(EventParams: TStrings)
   begin

   end;
end;

procedure TVCLObjTStringGrid.ProcessPropertyClass(NewObj: TObject);
var
  I, J, K: Integer;
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.Dataware.StringGrid:= TStringGrid(FD2BridgeItemVCLObj.Item);

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TStringGrid(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.SetVisible:=
    procedure(AValue: Variant)
    begin
     TStringGrid(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.GetEditable:=
    function: Variant
    begin
     Result:= ({$IFNDEF FMX}goEditing{$ELSE}TGridOption.Editing{$ENDIF} in TStringGrid(FD2BridgeItemVCLObj.Item).Options);
    end;

 //Enable MultiSelect
// if (goRangeSelect in TStringGrid(FD2BridgeItemVCLObj.Item).Options) then
//  (FrameworkItemClass as ID2BridgeFrameworkItemStringGrid).MultiSelect:= true
// else
  (FrameworkItemClass as ID2BridgeFrameworkItemStringGrid).MultiSelect:= false;


 with FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.StringGrid.Columns do
 begin
  items.Clear;

  for I := 0 to TStringGrid(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}ColCount{$ELSE}ColumnCount{$ENDIF} -1 do
  with Add do
  begin
   DataField:= TStringGrid(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Cells[I, 0]{$ELSE}Columns[I].Header{$ENDIF};
//   if DataField <> '' then
//   if Assigned(TStringGrid(FD2BridgeItemVCLObj.Item).Columns[I].Field) then
//   DataFieldType:= PrismFieldType(TStringGrid(FD2BridgeItemVCLObj.Item).Columns[I].Field.DataType)
//   else
   DataFieldType:= PrismFieldTypeString;
   Title:= TStringGrid(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Cells[I, 0]{$ELSE}Columns[I].Header{$ENDIF};
   Visible:= {$IFNDEF FMX}True{$ELSE}TStringGrid(FD2BridgeItemVCLObj.Item).Columns[I].Visible{$ENDIF};
   Width:= WidthPPI(TStringGrid(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}ColWidths[I]{$ELSE}Columns[I].Width{$ENDIF});
   Editable:= {$IFNDEF FMX}True{$ELSE}TStringGrid(FD2BridgeItemVCLObj.Item).Columns[I].ReadOnly = False{$ENDIF};

{$IF CompilerVersion >= 34} // Delphi 10.4 Sydney or Upper
  {$IFNDEF FMX}
   case TStringGrid(FD2BridgeItemVCLObj.Item).ColAlignments[I] of
    taLeftJustify : Alignment:= D2BridgeAlignColumnsLeft;
    taRightJustify : Alignment:= D2BridgeAlignColumnsRight;
    taCenter : Alignment:= D2BridgeAlignColumnsCenter;
   end;
  {$ELSE}
   case TStringGrid(FD2BridgeItemVCLObj.Item).Columns[I].HorzAlign of
    TTextAlign.Leading : Alignment:= D2BridgeAlignColumnsLeft;
    TTextAlign.Trailing : Alignment:= D2BridgeAlignColumnsRight;
    TTextAlign.Center : Alignment:= D2BridgeAlignColumnsCenter;
   end;
  {$ENDIF}
{$ELSE}
   Alignment:= D2BridgeAlignColumnsLeft;
{$ENDIF}
//   //Load combobox Itens
//   for J := 0 to Pred(TStringGrid(FD2BridgeItemVCLObj.Item).Objects[I, 0].Count) do
//   begin
//    if J = 0 then
//     SelectItems.AddPair('0', '--Selecione--');
//
//    SelectItems.AddPair(IntToStr(J+1), TStringGrid(FD2BridgeItemVCLObj.Item).Objects[I, 0].PickList[J]);
//   end;
  end;
 end;
end;

function TVCLObjTStringGrid.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTStringGrid.VCLClass: TClass;
begin
 Result:= TStringGrid;
end;

procedure TVCLObjTStringGrid.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;

end.

