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

unit D2Bridge.VCLObj.TButton;

interface

uses
  System.Classes,
  D2Bridge.Interfaces, D2Bridge.Item, D2Bridge.Item.VCLObj, D2Bridge.BaseClass;


type
 TVCLObjTButton = class(TInterfacedPersistent, ID2BridgeVCLObj, ID2BridgeItemVCLObjCore)
  private
   FD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
  public
   function VCLClass: TClass;
   Procedure VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
   function CSSClass: String;
   function GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
   constructor Create(AOwner: TD2BridgeItemVCLObj);
   function PropertyCopyList: TStringList;
   procedure ProcessPropertyClass(NewObj: TObject);
   procedure ProcessEventClass;
   function FrameworkItemClass: ID2BridgeFrameworkItem;
 end;

implementation

uses
{$IFDEF FMX}
  FMX.StdCtrls,
{$ELSE}
  Vcl.StdCtrls, Vcl.Buttons,
  {$IFDEF DEVEXPRESS_AVAILABLE}cxButtons,{$ENDIF}
{$ENDIF}
  D2Bridge.Util,
  Prism.Util, D2Bridge.Forms, Prism.Forms, System.UITypes;

{ TVCLObjTButton }

constructor TVCLObjTButton.Create(AOwner: TD2BridgeItemVCLObj);
begin
 FD2BridgeItemVCLObj:= AOwner;
end;

function TVCLObjTButton.CSSClass: String;
begin
 Result:= 'btn';
end;

function TVCLObjTButton.FrameworkItemClass: ID2BridgeFrameworkItem;
begin
 Result:= FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button;
end;

function TVCLObjTButton.GetD2BridgeItemVCLObj: TD2BridgeItemVCLObj;
begin
 result:= FD2BridgeItemVCLObj;
end;

procedure TVCLObjTButton.ProcessEventClass;
begin
 if Assigned(TButton(FD2BridgeItemVCLObj.Item).OnEnter) then
 FrameworkItemClass.OnEnter:=
    procedure(EventParams: TStrings)
    begin
     TButton(FD2BridgeItemVCLObj.Item).OnEnter(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TButton(FD2BridgeItemVCLObj.Item).OnExit) then
 FrameworkItemClass.OnExit:=
    procedure(EventParams: TStrings)
    begin
     TButton(FD2BridgeItemVCLObj.Item).OnExit(FD2BridgeItemVCLObj.Item);
    end;

 if Assigned(TButton(FD2BridgeItemVCLObj.Item).OnKeyDown) then
 FrameworkItemClass.OnKeyDown:=
    procedure(EventParams: TStrings)
    var
      KeyPress: word;
      KeyChar:  Char;
    begin
     KeyPress := ConvertHTMLKeyToVK(EventParams.values['key']);
{$IFNDEF FMX}
     TButton(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, []);
{$ELSE}
     KeyChar:= Char(KeyPress);
     TButton(FD2BridgeItemVCLObj.Item).OnKeyDown(FD2BridgeItemVCLObj.Item, KeyPress, KeyChar, []);
{$ENDIF}

    end;

{$IFNDEF FMX}
 if Assigned(TButton(FD2BridgeItemVCLObj.Item).OnKeyPress) then
 FrameworkItemClass.OnKeyPress:=
    procedure(EventParams: TStrings)
    var
      KeyPress: Char;
    begin
     KeyPress := Chr(ConvertHTMLKeyToVK(EventParams.values['key']));
     TButton(FD2BridgeItemVCLObj.Item).OnKeyPress(FD2BridgeItemVCLObj.Item, KeyPress);
    end;
{$ENDIF}
end;

procedure TVCLObjTButton.ProcessPropertyClass(NewObj: TObject);
var
 vD2BridgeForm: TD2BridgeForm;
 FModalResult: Integer;
begin
 if Assigned(TButton(FD2BridgeItemVCLObj.Item).OnClick) or
    (FD2BridgeItemVCLObj.Item is TButton)
    {$IFNDEF FMX}
     or (FD2BridgeItemVCLObj.Item is TBitBtn)
     {$IFDEF DEVEXPRESS_AVAILABLE}or (FD2BridgeItemVCLObj.Item is TcxButton){$ENDIF}
    {$ENDIF}
 then
 FrameworkItemClass.OnClick:=
    procedure(EventParams: TStrings)
    begin
     {$IFNDEF FMX}
      if NewObj is TPrismControl then
       if Assigned(TPrismControl(NewObj).Form) then
       begin
        vD2BridgeForm:= TPrismForm(TPrismControl(NewObj).Form).D2BridgeForm;
        if Assigned(vD2BridgeForm) then
        begin
         FModalResult:= -1;

         if (FD2BridgeItemVCLObj.Item is TButton) then
          FModalResult:= TButton(FD2BridgeItemVCLObj.Item).ModalResult;
         {$IFNDEF FMX}
          if (FD2BridgeItemVCLObj.Item is TBitBtn) then
           FModalResult:= TBitBtn(FD2BridgeItemVCLObj.Item).ModalResult;
          {$IFDEF DEVEXPRESS_AVAILABLE}
           if (FD2BridgeItemVCLObj.Item is TBitBtn) then
            FModalResult:= TcxButton(FD2BridgeItemVCLObj.Item).ModalResult;
          {$ENDIF}
         {$ENDIF}
         if vD2BridgeForm.ShowingModal and (FModalResult > 0) then
         begin
          {$IFDEF D2BRIDGE}
           vD2BridgeForm.ModalResult:= FModalResult;
          {$ENDIF}
         end;
        end;
       end;
     {$ENDIF}

     if Assigned(TButton(FD2BridgeItemVCLObj.Item).OnClick) then
      TButton(FD2BridgeItemVCLObj.Item).OnClick(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.Caption:= TButton(FD2BridgeItemVCLObj.Item).{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF};
{$IFNDEF FMX}
 {$IF CompilerVersion >= 34} // Delphi 10.4 Sydney or Upper
 if (FD2BridgeItemVCLObj.Item is TButton) then
 begin
    if (FD2BridgeItemVCLObj.Item as TButton).ImageName <> '' then
    begin
     if FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.Caption <> '' then
      FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.Caption := FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.Caption + ' ';

     FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.Caption:=
       '<i class="'+(FD2BridgeItemVCLObj.Item as TButton).ImageName+'"></i> '
       + FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.Caption;
    end;
 end;
 {$ENDIF}
{$ENDIF}

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.GetEnabled:=
    function: Variant
    begin
     Result:= GetEnabledRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.SetEnabled:=
    procedure(AValue: Variant)
    begin
     TButton(FD2BridgeItemVCLObj.Item).Enabled:= AValue;
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.GetVisible:=
    function: Variant
    begin
     Result:= GetVisibleRecursive(FD2BridgeItemVCLObj.Item);
    end;

 FD2BridgeItemVCLObj.BaseClass.FrameworkExportType.Button.SetVisible:=
    procedure(AValue: Variant)
    begin
     TButton(FD2BridgeItemVCLObj.Item).Visible:= AValue;
    end;
end;

function TVCLObjTButton.PropertyCopyList: TStringList;
begin
 Result:= FD2BridgeItemVCLObj.DefaultPropertyCopyList;
end;

function TVCLObjTButton.VCLClass: TClass;
begin
 Result:= TButton;
end;


procedure TVCLObjTButton.VCLStyle(const VCLObjStyle: ID2BridgeItemVCLObjStyle);
begin

end;

end.
