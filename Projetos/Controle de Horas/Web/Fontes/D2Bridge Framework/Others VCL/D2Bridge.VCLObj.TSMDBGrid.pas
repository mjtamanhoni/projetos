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

{$I ..\D2Bridge.inc}


unit D2Bridge.VCLObj.TSMDBGrid;

interface

{$IFDEF SMCOMPONENTS_AVAILABLE}

uses
  System.Classes,
  Vcl.DBGrids,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass, SMDBGrid;


type
  TVCLObjTSMDBGrid = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function DBGridColumnByPrismColumnIndex(aCol: integer): TColumn;
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

{ TVCLObjTSMDBGrid }

constructor TVCLObjTSMDBGrid.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTSMDBGrid.CSSClass: String;
begin
 result:= 'table table-hover table-sm table-bordered ui-jqgrid-htable d2bridgedbgrid cursor-pointer';
end;

function TVCLObjTSMDBGrid.DBGridColumnByPrismColumnIndex(aCol: integer): TColumn;
var
 I, X: Integer;
 vPrismColumns: ID2BridgeFrameworkItemGridColumns;
begin
 vPrismColumns:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.Columns;

 if vPrismColumns.Items.Count >= aCol then
  for I := 0 to Pred(vPrismColumns.Items.Count) do
   if vPrismColumns.Items[I].DataField <> '' then
    for X := 0 to Pred(TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns.Count) do
     if SameText(vPrismColumns.Items[I].DataField, TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[X].FieldName) then
     begin
      result:= TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[X];
      break;
     end;
end;

function TVCLObjTSMDBGrid.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid;
end;

function TVCLObjTSMDBGrid.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTSMDBGrid.ProcessEventClass;
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnSelect :=
   procedure(EventParams: TStrings)
   begin

   end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnCheck :=
  procedure(EventParams: TStrings)
  begin
   if not TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected then
   begin
    TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected:= true;

    if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick) then
     TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick(nil)
    else
     if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
      TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TSMDBGrid(FD2BridgeItemVCLObj.Item))
     else
      if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnEnter) then
       TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TSMDBGrid(FD2BridgeItemVCLObj.Item));

    if not TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected then
     FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SelectedRowsID.Remove(TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.RecNo);
   end;
  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnUnCheck :=
  procedure(EventParams: TStrings)
  begin
   if TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected then
   begin
    TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected:= false;

    if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick) then
     TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick(nil)
    else
     if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
      TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TSMDBGrid(FD2BridgeItemVCLObj.Item))
     else
      if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnEnter) then
       TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TSMDBGrid(FD2BridgeItemVCLObj.Item));

    if TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected then
     FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SelectedRowsID.Add(TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.RecNo);
   end;
  end;


// FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnClick :=
//  procedure(EventParams: TStrings)
//  var
//   Col: Integer;
//  begin
//   if TryStrToInt(EventParams.Values['col'], col) then
//   begin
//    if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick) then
//     TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick(DBGridColumnByPrismColumnIndex(col));
//    if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
//     TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(DBGridColumnByPrismColumnIndex(col));
//   end;
//  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnDblClick :=
  procedure(EventParams: TStrings)
  begin
   if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnDblClick) then
      TSMDBGrid(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnSelectAll :=
   procedure(EventParams: TStrings)
   begin
    TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.DisableControls;

    try
     try
      TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.First;
      repeat
       if not TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected then
       begin
        TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected:= true;

        if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick) then
         TSMDBGrid(FD2BridgeItemVCLObj.Item).OnCellClick(nil)
        else
         if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
          TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TSMDBGrid(FD2BridgeItemVCLObj.Item))
         else
          if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).OnEnter) then
           TSMDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TSMDBGrid(FD2BridgeItemVCLObj.Item));
       end;

       if TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.CurrentRowSelected then
        FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SelectedRowsID.Add(TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.RecNo);

       TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.Next;
      until TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.Eof;
     except

     end;
    finally
     TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.EnableControls;
    end;
   end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnUnSelectAll :=
   procedure(EventParams: TStrings)
   begin
    TSMDBGrid(FD2BridgeItemVCLObj.Item).SelectedRows.Clear;
   end;
end;

procedure TVCLObjTSMDBGrid.ProcessPropertyClass(NewObj: TObject);
var
  I, J, K: Integer;
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.Dataware.DataSource:= TSMDBGrid(FD2BridgeItemVCLObj.Item).DataSource;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TSMDBGrid(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SetVisible:=
    procedure(AValue: Variant)
    begin
     TSMDBGrid(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.GetEditable:=
    function: Variant
    begin
     Result:= (dgEditing in TSMDBGrid(FD2BridgeItemVCLObj.Item).Options);
    end;

 //Enable MultiSelect
 if (dgMultiSelect in TSMDBGrid(FD2BridgeItemVCLObj.Item).Options) then
  (FrameworkItemClass as ID2BridgeFrameworkItemDBGrid).MultiSelect:= true
 else
  (FrameworkItemClass as ID2BridgeFrameworkItemDBGrid).MultiSelect:= false;


 with FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.Columns do
 begin
  items.Clear;

  for I := 0 to TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns.Count -1 do
  with Add do
  begin
   DataField:= TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].FieldName;
   if DataField <> '' then
   if Assigned(TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Field) then
   DataFieldType:= PrismFieldType(TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Field.DataType)
   else
   DataFieldType:= PrismFieldTypeAuto;
   Title:= TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Title.Caption;
   Visible:= TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Visible;
   Width:= WidthPPI(TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Width);
   if (not TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].ReadOnly) then
   Editable:= true;
   case TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Alignment of
    taLeftJustify : Alignment:= D2BridgeAlignColumnsLeft;
    taRightJustify : Alignment:= D2BridgeAlignColumnsRight;
    taCenter : Alignment:= D2BridgeAlignColumnsCenter;
   end;
   //Load combobox Itens
   for J := 0 to Pred(TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].PickList.Count) do
   begin
    if J = 0 then
     SelectItems.AddPair('0', '--Selecione--');

    SelectItems.AddPair(IntToStr(J+1), TSMDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].PickList[J]);
   end;
  end;
 end;
end;

function TVCLObjTSMDBGrid.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTSMDBGrid.VCLClass: TClass;
begin
 Result:= TSMDBGrid;
end;

procedure TVCLObjTSMDBGrid.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;

initialization
 RegisterClass(TVCLObjTSMDBGrid);

{$ELSE}
implementation
{$ENDIF}

end.


