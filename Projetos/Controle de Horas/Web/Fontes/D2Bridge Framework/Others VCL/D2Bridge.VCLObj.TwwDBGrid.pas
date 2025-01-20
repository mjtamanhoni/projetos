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
  Thanks for contribution to this Unit to:
    Daniel Alisson Suart
    Email: contato@deuxsoftware.com.br
 +--------------------------------------------------------------------------+
}


{$I ..\D2Bridge.inc}

unit D2Bridge.VCLObj.TwwDBGrid;

interface

{$IFDEF INFOPOWER_AVAILABLE}

uses
  System.Classes,
  Vcl.DBGrids, Vcl.Grids, vcl.wwdbigrd, vcl.wwdbgrid,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;

type
  TVCLObjTwwDBGrid = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   function DBGridColumnByPrismColumnIndex(aCol: integer): TwwColumn;
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
   function GetFieldName(APos: integer): String;
   function GetTextFieldName(APos: Integer): String;
   function GetWidthFieldGrid(APos: Integer): Integer;
 end;

implementation

uses
  System.SysUtils, Data.DB,
  D2Bridge.Types, D2Bridge.Util,
  Prism.Util, Prism.Types;

{ TVCLObjTwwDBGrid }

constructor TVCLObjTwwDBGrid.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTwwDBGrid.CSSClass: String;
begin
 result:= 'table table-hover table-sm table-bordered ui-jqgrid-htable d2bridgedbgrid cursor-pointer';
end;

function TVCLObjTwwDBGrid.DBGridColumnByPrismColumnIndex(aCol: integer): TwwColumn;
var
 I, X: Integer;
 vPrismColumns: ID2BridgeFrameworkItemGridColumns;
begin
 vPrismColumns:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.Columns;

 if vPrismColumns.Items.Count >= aCol then
  for I := 0 to Pred(vPrismColumns.Items.Count) do
   if vPrismColumns.Items[I].DataField <> '' then
    for X := 0 to Pred(TwwDBGrid(FD2BridgeItemVCLObj.Item).Selected.Count) do
    begin
     if SameText(vPrismColumns.Items[I].DataField, GetFieldName(X) ) then
     begin
      result:= TwwDBGrid(FD2BridgeItemVCLObj.Item).ColumnByName(GetFieldName(X));
      break;
     end;
    end;
end;

function TVCLObjTwwDBGrid.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid;
end;

function TVCLObjTwwDBGrid.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

function TVCLObjTwwDBGrid.GetFieldName(APos: integer): String;
var i : integer;
    vSelectedField: String;
begin
   {Os campos da grid estão concatenados como = FieldName Width Title}
   vSelectedField := TwwDBGrid(FD2BridgeItemVCLObj.Item).Selected.KeyNames[APos];
   vSelectedField := Copy(vSelectedField,1,Pos(#9,vSelectedField)-1);
   Result         := vSelectedField;
end;

function TVCLObjTwwDBGrid.GetTextFieldName(APos: Integer): String;
var i : integer;
    vTextField: String;
begin
   {Os campos da grid estão concatenados como = FieldName Width Title}
   vTextField := TwwDBGrid(FD2BridgeItemVCLObj.Item).Selected.KeyNames[APos];
   delete(vTextField,1,Pos(#9,vTextField)); // delete fieldname
   delete(vTextField,1,Pos(#9,vTextField)); // delete width
   vTextField := Copy(vTextField,1,Pos(#9,vTextField)-1);
   Result         := vTextField;
end;

function TVCLObjTwwDBGrid.GetWidthFieldGrid(APos: Integer): Integer;
var i : integer;
    vWidthField: String;
begin
   {Os campos da grid estão concatenados como = FieldName Width Title}
   vWidthField := TwwDBGrid(FD2BridgeItemVCLObj.Item).Selected.KeyNames[APos];
   delete(vWidthField,1,Pos(#9,vWidthField)); // delete fieldname
   vWidthField := Copy(vWidthField,1,Pos(#9,vWidthField)-1);
   Result         := StrToIntDef(vWidthField,20);
end;

procedure TVCLObjTwwDBGrid.ProcessEventClass;
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnSelect :=
   procedure(EventParams: TStrings)
   begin

   end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnCheck :=
  procedure(EventParams: TStrings)
  begin
   if not TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected then
   begin
    TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected:= true;

    if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged) then
     TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged(nil)
    else
     if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
      TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TwwDBGrid(FD2BridgeItemVCLObj.Item))
     else
      if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnEnter) then
       TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TwwDBGrid(FD2BridgeItemVCLObj.Item));

    if not TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected then
     FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SelectedRowsID.Remove(TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.RecNo);
   end;
  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnUnCheck :=
  procedure(EventParams: TStrings)
  begin
   if TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected then
   begin
    TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected:= false;

    if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged) then
     TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged(nil)
    else
     if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
      TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TwwDBGrid(FD2BridgeItemVCLObj.Item))
     else
      if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnEnter) then
       TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TwwDBGrid(FD2BridgeItemVCLObj.Item));

    if TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected then
     FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SelectedRowsID.Add(TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.RecNo);
   end;
  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnClick :=
  procedure(EventParams: TStrings)
  var
   Col: Integer;
  begin
   if TryStrToInt(EventParams.Values['col'], col) then
   begin
    if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged) then
     TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged(DBGridColumnByPrismColumnIndex(col));
    if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
     TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(DBGridColumnByPrismColumnIndex(col));
   end;
  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnDblClick :=
  procedure(EventParams: TStrings)
  begin
   if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnDblClick) then
      TwwDBGrid(FD2BridgeItemVCLObj.Item).OnDblClick(FD2BridgeItemVCLObj.Item);
  end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnSelectAll :=
   procedure(EventParams: TStrings)
   begin
    TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.DisableControls;

    try
     try
      TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.First;
      repeat
       if not TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected then
       begin
        TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected:= true;

        if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged) then
         TwwDBGrid(FD2BridgeItemVCLObj.Item).OnCellChanged(nil)
        else
         if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter) then
          TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TwwDBGrid(FD2BridgeItemVCLObj.Item))
         else
          if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).OnEnter) then
           TwwDBGrid(FD2BridgeItemVCLObj.Item).OnColEnter(TwwDBGrid(FD2BridgeItemVCLObj.Item));
       end;

       if TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.CurrentRowSelected then
        FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SelectedRowsID.Add(TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.RecNo);

       TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.Next;
      until TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.Eof;
     except

     end;
    finally
     TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.EnableControls;
    end;
   end;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.OnUnSelectAll :=
   procedure(EventParams: TStrings)
   begin
    TwwDBGrid(FD2BridgeItemVCLObj.Item).SelectedList.Clear;
   end;
end;

procedure TVCLObjTwwDBGrid.ProcessPropertyClass(NewObj: TObject);
var
  I, J, K: Integer;
begin
 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.Dataware.DataSource:= TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource;


 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(TwwDBGrid(FD2BridgeItemVCLObj.Item));
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TwwDBGrid(TwwDBGrid(FD2BridgeItemVCLObj.Item)).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(TwwDBGrid(TwwDBGrid(FD2BridgeItemVCLObj.Item)));
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.SetVisible:=
    procedure(AValue: Variant)
    begin
     TwwDBGrid(TwwDBGrid(FD2BridgeItemVCLObj.Item)).Visible:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.GetEditable:=
    function: Variant
    begin
     Result:= (dgEditing in TwwDBGrid(FD2BridgeItemVCLObj.Item).Options);
    end;

 //Enable MultiSelect
 if (dgMultiSelect in TwwDBGrid(FD2BridgeItemVCLObj.Item).Options) then
  (FrameworkItemClass as ID2BridgeFrameworkItemDBGrid).MultiSelect:= true
 else
  (FrameworkItemClass as ID2BridgeFrameworkItemDBGrid).MultiSelect:= false;


 with FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.DBGrid.Columns do
 begin
  items.Clear;

  for I := 0 to TwwDBGrid(FD2BridgeItemVCLObj.Item).Selected.Count -1 do
  with Add do
  begin
   DataField:= GetFieldName(I);
   if DataField <> '' then
      if Assigned(TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.FieldList.Fields[I]) then
         DataFieldType:= PrismFieldType(TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.FieldList.Fields[I].DataType)
      else
         DataFieldType:= PrismFieldTypeAuto;
   Title:= GetTextFieldName(I);
   Visible:= TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.FieldList.Fields[I].Visible;
   Width:= WidthPPI(GetWidthFieldGrid(I));
   if not TwwDBGrid(FD2BridgeItemVCLObj.Item).DataSource.DataSet.FieldList.Fields[I].ReadOnly then
      Editable:= true;

   Alignment:= D2BridgeAlignColumnsLeft;
   //Load combobox Itens
//   if TwwDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Properties is TcxComboBoxProperties then
//     for J := 0 to Pred(TcxComboBoxProperties(TwwDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Properties).Items.Count) do
//     begin
//      if J = 0 then
//       SelectItems.AddPair('0', '--Selecione--');
//
//      SelectItems.AddPair(IntToStr(J+1), TcxComboBoxProperties(TwwDBGrid(FD2BridgeItemVCLObj.Item).Columns[I].Properties).Items[J]);
//     end;
  end;
 end;
end;

function TVCLObjTwwDBGrid.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTwwDBGrid.VCLClass: TClass;
begin
 Result:= TwwDBGrid;
end;

procedure TVCLObjTwwDBGrid.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;
{$ELSE}
implementation
{$ENDIF}

end.
