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

unit D2Bridge.Prism.DBGrid;

interface

{$IFNDEF FMX}
uses
  System.SysUtils, System.Generics.Collections,
  D2Bridge.Interfaces, D2Bridge.FrameworkItem.DataWare, D2Bridge.FrameworkItem.GridColumns,
  D2Bridge.Prism.Item, D2Bridge.Prism;


type
 PrismDBGrid = class(TD2BridgePrismItem, ID2BridgeFrameworkItemDBGrid)
  private
   FProcSetSelectedRow: TOnSetValue;
   FProcGetSelectedRow: TOnGetValue;
   FProcGetEditable: TOnGetValue;
   FColumns: TD2BridgeFrameworkItemGridColumns;
   FDataware: TD2BridgeDatawareOnlyDataSource;
   FMultiSelect: Boolean;
   FSelectedRowsID: TList<Integer>;
   function GetMultiSelect: Boolean;
   Procedure SetMultiSelect(AMultiSelect: Boolean);
   procedure SetOnGetSelectedRow(AOnGetSelectedRow: TOnGetValue);
   function GetOnGetSelectedRow: TOnGetValue;
   procedure SetOnSetSelectedRow(AOnSetSelectedRow: TOnSetValue);
   function GetOnSetSelectedRow: TOnSetValue;
   function GetProcEditable: TOnGetValue;
   procedure SetProcEditable(const Value: TOnGetValue);
  public
   constructor Create(AD2BridgePrismFramework: TD2BridgePrismFramework); override;
   destructor Destroy; override;

   procedure Clear; override;
   function FrameworkClass: TClass; override;
   procedure ProcessPropertyClass(VCLObj, NewObj: TObject); override;
   procedure ProcessEventClass(VCLObj, NewObj: TObject); override;
   procedure ProcessPropertyByName(VCLObj, NewObj: TObject; PropertyName: string; PropertyValue: Variant); override;

   function Columns: ID2BridgeFrameworkItemGridColumns;
   function Dataware : ID2BridgeDatawareOnlyDataSource;

   function SelectedRowsID: TList<Integer>;

   property MultiSelect: Boolean read GetMultiSelect write SetMultiSelect;
   property OnGetSelectedRow: TOnGetValue read GetOnGetSelectedRow write SetOnGetSelectedRow;
   property OnSetSelectedRow: TOnSetValue read GetOnSetSelectedRow write SetOnSetSelectedRow;
   property GetEditable: TOnGetValue read GetProcEditable write SetProcEditable;
 end;


implementation

{ PrismDBGrid }

uses
  System.Classes,
  Vcl.DBGrids,
  Prism.DBGrid, Prism.Grid.Columns, Prism.Types, D2Bridge.Types;

procedure PrismDBGrid.Clear;
begin
 inherited;

 FProcSetSelectedRow:= nil;
 FProcGetSelectedRow:= nil;
 FProcGetEditable:= nil;
 FMultiSelect:= False;
 Columns.Clear;
 Dataware.Clear;
end;

function PrismDBGrid.Columns: ID2BridgeFrameworkItemGridColumns;
begin
 Result:= FColumns;
end;

constructor PrismDBGrid.Create(AD2BridgePrismFramework: TD2BridgePrismFramework);
begin
 FColumns:= TD2BridgeFrameworkItemGridColumns.Create;
 FDataware := TD2BridgeDatawareOnlyDataSource.Create;
 FSelectedRowsID:= TList<Integer>.Create;
 FMultiSelect:= False;
end;

function PrismDBGrid.Dataware: ID2BridgeDatawareOnlyDataSource;
begin
 Result:= FDataware;
end;

destructor PrismDBGrid.Destroy;
begin
 FreeAndNil(FColumns);
 FreeAndNil(FDataware);
 FreeAndNil(FSelectedRowsID);

 inherited;
end;

function PrismDBGrid.FrameworkClass: TClass;
begin
 inherited;

 Result:= TPrismDBGrid;
end;

function PrismDBGrid.GetMultiSelect: Boolean;
begin
 Result:= FMultiSelect;
end;

function PrismDBGrid.GetOnGetSelectedRow: TOnGetValue;
begin
 Result:= FProcGetSelectedRow;
end;

function PrismDBGrid.GetOnSetSelectedRow: TOnSetValue;
begin
 Result:= FProcSetSelectedRow;
end;

function PrismDBGrid.GetProcEditable: TOnGetValue;
begin
 Result:= FProcGetEditable;
end;

procedure PrismDBGrid.ProcessEventClass(VCLObj, NewObj: TObject);
begin
 inherited;

// TPrismDBGrid(NewObj).Events.Add(EventOnClick,
//  procedure(EventParams: TStrings)
//  begin
//   if Assigned(TPrismDBGrid(NewObj).Events.Item(EventOnCellClick)) then
//    TPrismDBGrid(NewObj).Events.Item(EventOnCellClick).CallEvent(EventParams);
//  end);

// TPrismDBGrid(NewObj).Events.Add(EventOnSelect,
//  procedure(EventParams: TStrings)
//  var
//   Col: Integer;
//  begin
//   if TryStrToInt(EventParams.Values['col'], col) then
//   begin
//    if Assigned(TPrismDBGrid(NewObj).Events.Item(EventOnCellClick)) then
//     TPrismDBGrid(NewObj).Events.Item(EventOnCellClick).CallEvent(EventParams);
//   end;
//  end);


// TPrismDBGrid(NewObj).Events.Add(EventOnUncheck,
//  procedure(EventParams: TStrings)
//  begin
//
//  end);

// TPrismDBGrid(NewObj).Events.Add(EventOnSelectAll,
//  procedure(EventParams: TStrings)
//  begin
//
//  end);

// TPrismDBGrid(NewObj).Events.Add(EventOnUnselectAll,
//  procedure(EventParams: TStrings)
//  begin
//
//  end);


end;

procedure PrismDBGrid.ProcessPropertyByName(VCLObj, NewObj: TObject;
  PropertyName: string; PropertyValue: Variant);
begin
 inherited;

end;

procedure PrismDBGrid.ProcessPropertyClass(VCLObj, NewObj: TObject);
var
 I: Integer;
begin
 inherited;

 if Assigned(Dataware.DataSource) then
 TPrismDBGrid(NewObj).DataSource:= Dataware.DataSource;

 TPrismDBGrid(NewObj).Columns.Clear;

 for I := 0 to Columns.Items.Count -1 do
 with TPrismGridColumn(TPrismDBGrid(NewObj).Columns.Add) do
 begin
  DataField:= Columns.Items[I].DataField;
  Title:= Columns.Items[I].Title;
  Visible:= Columns.Items[I].Visible;
  Width:= Columns.Items[I].Width;
  Editable:= Columns.Items[I].Editable;
  DataFieldType:= Columns.Items[I].DataFieldType;
  SelectItems := Columns.Items[I].SelectItems;
  case Columns.Items[I].Alignment of
    D2BridgeAlignColumnsLeft: Alignment:= PrismAlignLeft;
    D2BridgeAlignColumnsRight: Alignment:= PrismAlignRight;
    D2BridgeAlignColumnsCenter: Alignment:= PrismAlignCenter;
  end;
 end;

 TPrismDBGrid(NewObj).MultiSelect:= FMultiSelect;

 TPrismDBGrid(NewObj).SelectedRowsID:= FSelectedRowsID;

 if Assigned(FProcSetSelectedRow) then
 TPrismDBGrid(NewObj).ProcSetSelectedRow:= FProcSetSelectedRow;

 if Assigned(FProcGetSelectedRow) then
 TPrismDBGrid(NewObj).ProcGetSelectedRow:= FProcGetSelectedRow;

 if Assigned(FProcGetEditable) then
 TPrismDBGrid(NewObj).ProcGetEditable:= FProcGetEditable;
end;

function PrismDBGrid.SelectedRowsID: TList<Integer>;
begin
 Result:= FSelectedRowsID;
end;

procedure PrismDBGrid.SetMultiSelect(AMultiSelect: Boolean);
begin
 FMultiSelect:= AMultiSelect;
end;

procedure PrismDBGrid.SetOnGetSelectedRow(AOnGetSelectedRow: TOnGetValue);
begin
 FProcGetSelectedRow:= AOnGetSelectedRow;
end;

procedure PrismDBGrid.SetOnSetSelectedRow(AOnSetSelectedRow: TOnSetValue);
begin
 FProcSetSelectedRow:= AOnSetSelectedRow;
end;

procedure PrismDBGrid.SetProcEditable(const Value: TOnGetValue);
begin
 FProcGetEditable:= Value;
end;
{$ELSE}
implementation
{$ENDIF}

end.
