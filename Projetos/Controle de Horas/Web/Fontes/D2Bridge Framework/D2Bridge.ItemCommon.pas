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

unit D2Bridge.ItemCommon;

interface

uses
  System.Generics.Collections, System.Classes,
  D2Bridge.Interfaces, D2Bridge.ItemCommon.Add, D2Bridge.BaseClass;

//type
//  TD2BridgeItems = class(TList<TD2BridgeItem>)
//   private
//    FBaseClass: TObject;
//    FAddItem: TItemsAdd;
//   public
//    constructor Create(BaseClass: TObject);
//    destructor Destroy; override;
//
//    property New: TItemsAdd read FAddItem;
//    property BaseClass: TObject read FBaseClass;
//  end;

type
  TD2BridgeItems = class(TComponent, ID2BridgeAddItems)
   private
    FBaseClass: TD2BridgeClass;
    FAddItem: TItemAdd;
    FItemList: TList<ID2BridgeItem>;
   public
    constructor Create(BaseClass: TD2BridgeClass);
    destructor Destroy; override;

    function GetItems: TList<ID2BridgeItem>;
    function Add: IItemAdd; overload;
    function Count: Integer;
    function Item(AIndex: Integer):ID2BridgeItem;

    procedure Add(Item: ID2BridgeItem); overload;
    property Items: TList<ID2BridgeItem> read GetItems;
    property BaseClass: TD2BridgeClass read FBaseClass;
  end;


implementation

uses
  System.SysUtils,
  D2Bridge.Item;


{ TD2BridgeItems }



function TD2BridgeItems.Add: IItemAdd;
begin
 result:= FAddItem;
end;

procedure TD2BridgeItems.Add(Item: ID2BridgeItem);
begin
 FItemList.Add(Item);
 FBaseClass.ExportedControls.Add(Item.ItemID, Item);
end;

function TD2BridgeItems.Count: Integer;
begin
 Result:= FItemList.Count;
end;

constructor TD2BridgeItems.Create(BaseClass: TD2BridgeClass);
begin
 FBaseClass:= BaseClass;
 FAddItem:= TItemAdd.Create(self);
 FItemList:= TList<ID2BridgeItem>.Create;
end;

destructor TD2BridgeItems.Destroy;
var
 vItemObj: ID2BridgeItem;
begin
 for vItemObj in FItemList do
 begin
  try
   if Assigned(vItemObj) then
   begin
    //FItemList.Remove(vItemObj);
    (vItemObj as TD2BridgeItem).Destroy;
   end;
  except
  end;
 end;
 FItemList.Clear;
 FreeAndNil(FItemList);

 FreeAndNil(FAddItem);

 inherited;
end;

function TD2BridgeItems.GetItems: TList<ID2BridgeItem>;
begin
 Result:= FItemList;
end;

function TD2BridgeItems.Item(AIndex: Integer): ID2BridgeItem;
begin
 Result:= FItemList[AIndex];
end;

end.
