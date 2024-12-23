unit uRegistros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Math,
  uDm,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.Memo.Types, FMX.Ani,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TRegistro_Geral = class
  private
  public
    class procedure Excluir_Reg0000(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0100(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0110(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0140(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0150(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0190(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0200(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0400(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0500(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg0990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegA001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegA010(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegA990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC010(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC100(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC170(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC175(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC500(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC501(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC505(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegC990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegD001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegD010(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegD990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegF001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegF010(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegF100(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegF990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegI001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegI990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM100(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM105(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM110(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM200(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM205(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM210(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM400(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM410(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM500(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM505(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM510(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM600(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM605(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM610(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM800(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM810(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegM990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegP001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_RegP990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg1001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg1100(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg1500(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg1990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg9001(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg9900(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg9990(ADm: TdmSpedContribuicoes);
    class procedure Excluir_Reg9999(ADm: TdmSpedContribuicoes);
  end;

  TRegistro_0000 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0100 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0110 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0140 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0150 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0190 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0200 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0400 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0500 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_0990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_A001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_A010 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_A990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C010 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C100 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C170 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C175 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C500 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C501 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C505 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_C990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_D001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_D010 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_D990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_F001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_F010 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_F100 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_F990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_I001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_I990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M100 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M105 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M110 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M200 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M205 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M210 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M400 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M410 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M500 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M505 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M510 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M600 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M605 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M610 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M800 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M810 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_M990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_P001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_P990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_1001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_1100 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_1500 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_1990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_9001 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_9900 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_9990 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

  TRegistro_9999 = class
  private
  public
    class procedure Insert(ADm :TdmSpedContribuicoes; const ALine: String; const AId: Integer; AId_Pai: Integer=0);
  end;

implementation

{ TRegistro_0000 }

class procedure TRegistro_0000.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0000( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,COD_VER ');
      lQuery.SQL.Add('  ,TIPO_ESCRIT ');
      lQuery.SQL.Add('  ,IND_SIT_ESP ');
      lQuery.SQL.Add('  ,NUM_REC_ANTERIOR ');
      lQuery.SQL.Add('  ,DT_INI ');
      lQuery.SQL.Add('  ,DT_FIN ');
      lQuery.SQL.Add('  ,NOME ');
      lQuery.SQL.Add('  ,CNPJ ');
      lQuery.SQL.Add('  ,UF ');
      lQuery.SQL.Add('  ,COD_MUN ');
      lQuery.SQL.Add('  ,SUFRAMA ');
      lQuery.SQL.Add('  ,IND_NAT_PJ ');
      lQuery.SQL.Add('  ,IND_ATIV ');
      lQuery.SQL.Add(') VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:COD_VER ');
      lQuery.SQL.Add('  ,:TIPO_ESCRIT ');
      lQuery.SQL.Add('  ,:IND_SIT_ESP ');
      lQuery.SQL.Add('  ,:NUM_REC_ANTERIOR ');
      lQuery.SQL.Add('  ,:DT_INI ');
      lQuery.SQL.Add('  ,:DT_FIN ');
      lQuery.SQL.Add('  ,:NOME ');
      lQuery.SQL.Add('  ,:CNPJ ');
      lQuery.SQL.Add('  ,:UF ');
      lQuery.SQL.Add('  ,:COD_MUN ');
      lQuery.SQL.Add('  ,:SUFRAMA ');
      lQuery.SQL.Add('  ,:IND_NAT_PJ ');
      lQuery.SQL.Add('  ,:IND_ATIV ');
      lQuery.SQL.Add('); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_VER').AsString := lConteudo;
           2:lQuery.ParamByName('TIPO_ESCRIT').AsString := lConteudo;
           3:lQuery.ParamByName('IND_SIT_ESP').AsString := lConteudo;
           4:lQuery.ParamByName('NUM_REC_ANTERIOR').AsString := lConteudo;
           5:lQuery.ParamByName('DT_INI').AsString := lConteudo;
           6:lQuery.ParamByName('DT_FIN').AsString := lConteudo;
           7:lQuery.ParamByName('NOME').AsString := lConteudo;
           8:lQuery.ParamByName('CNPJ').AsString := lConteudo;
           9:lQuery.ParamByName('UF').AsString := lConteudo;
          10:lQuery.ParamByName('COD_MUN').AsString := lConteudo;
          11:lQuery.ParamByName('SUFRAMA').AsString := lConteudo;
          12:lQuery.ParamByName('IND_NAT_PJ').AsString := lConteudo;
          13:lQuery.ParamByName('IND_ATIV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0000 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0001 }

class procedure TRegistro_0001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0001( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,IND_MOV ');
      lQuery.SQL.Add(') VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:IND_MOV); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_Geral }

class procedure TRegistro_Geral.Excluir_Reg0000(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0000');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0000 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0100(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0100');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0110(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0110');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0110 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0140(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0140');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0140 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0150(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0150');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0150 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0190(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0190');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0190 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0200(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0200');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0200 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0400(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0400');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0400 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0500(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0500');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg0990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_0990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 0990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg1001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_1001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 1001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg1100(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_1100');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 1100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg1500(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_1500');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 1500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg1990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_1990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 1990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg9001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_9001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 9001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg9900(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_9900');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 9900 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg9990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_9990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 9990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_Reg9999(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_9999');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro 9999 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegA001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_A001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro A001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegA010(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_A010');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro A010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegA990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_A990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro A990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC010(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C010');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC100(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C100');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC170(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C170');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C170 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC175(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C175');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C175 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC500(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C500');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC501(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C501');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C501 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC505(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C505');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C505 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegC990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_C990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro C990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegD001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_D001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro D001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegD010(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_D010');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro D010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegD990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_D990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro D990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegF001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_F001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro F001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegF010(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_F010');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro F010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegF100(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_F100');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro F100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegF990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_F990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro F990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegI001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_I001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro I001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegI990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_I990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro I990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM100(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M100');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM105(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M105');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M105 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM110(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M110');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M110 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM200(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M200');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M200 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM205(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M205');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M205 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM210(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M210');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M210 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM400(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M400');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M400 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM410(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M410');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M410 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM500(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M500');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM505(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M505');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M505 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM510(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M510');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M510 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM600(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M600');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M600 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM605(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M605');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M605 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM610(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M610');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M610 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM800(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M800');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M800 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM810(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M810');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M810 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegM990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_M990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro M990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegP001(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_P001');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro P001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

class procedure TRegistro_Geral.Excluir_RegP990(ADm: TdmSpedContribuicoes);
var
  lQuery :TFDQuery;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('DELETE FROM REGISTRO_P990');
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('Excluindo Registro P990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0100 }

class procedure TRegistro_0100.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0100( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,NOME ');
      lQuery.SQL.Add('  ,CPF ');
      lQuery.SQL.Add('  ,CRC ');
      lQuery.SQL.Add('  ,CNPJ ');
      lQuery.SQL.Add('  ,CEP ');
      lQuery.SQL.Add('  ,"END" ');
      lQuery.SQL.Add('  ,NUM ');
      lQuery.SQL.Add('  ,COMPL ');
      lQuery.SQL.Add('  ,BAIRRO ');
      lQuery.SQL.Add('  ,FONE ');
      lQuery.SQL.Add('  ,FAX ');
      lQuery.SQL.Add('  ,EMAIL ');
      lQuery.SQL.Add('  ,COD_MUN ');
      lQuery.SQL.Add(') VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:NOME ');
      lQuery.SQL.Add('  ,:CPF ');
      lQuery.SQL.Add('  ,:CRC ');
      lQuery.SQL.Add('  ,:CNPJ ');
      lQuery.SQL.Add('  ,:CEP ');
      lQuery.SQL.Add('  ,:END ');
      lQuery.SQL.Add('  ,:NUM ');
      lQuery.SQL.Add('  ,:COMPL ');
      lQuery.SQL.Add('  ,:BAIRRO ');
      lQuery.SQL.Add('  ,:FONE ');
      lQuery.SQL.Add('  ,:FAX ');
      lQuery.SQL.Add('  ,:EMAIL ');
      lQuery.SQL.Add('  ,:COD_MUN ');
      lQuery.SQL.Add('); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NOME').AsString := lConteudo;
           2:lQuery.ParamByName('CPF').AsString := lConteudo;
           3:lQuery.ParamByName('CRC').AsString := lConteudo;
           4:lQuery.ParamByName('CNPJ').AsString := lConteudo;
           5:lQuery.ParamByName('CEP').AsString := lConteudo;
           6:lQuery.ParamByName('END').AsString := lConteudo;
           7:lQuery.ParamByName('NUM').AsString := lConteudo;
           8:lQuery.ParamByName('COMPL').AsString := lConteudo;
           9:lQuery.ParamByName('BAIRRO').AsString := lConteudo;
          10:lQuery.ParamByName('FONE').AsString := lConteudo;
          11:lQuery.ParamByName('FAX').AsString := lConteudo;
          12:lQuery.ParamByName('EMAIL').AsString := lConteudo;
          13:lQuery.ParamByName('COD_MUN').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0110 }

class procedure TRegistro_0110.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0110(  ');
      lQuery.SQL.Add('  ID  ');
      lQuery.SQL.Add('  ,REG  ');
      lQuery.SQL.Add('  ,COD_INC_TRIB  ');
      lQuery.SQL.Add('  ,IND_APRO_CRED  ');
      lQuery.SQL.Add('  ,COD_TIPO_CONT  ');
      lQuery.SQL.Add('  ,IND_REG_CUM  ');
      lQuery.SQL.Add(') VALUES(  ');
      lQuery.SQL.Add('  :ID  ');
      lQuery.SQL.Add('  ,:REG  ');
      lQuery.SQL.Add('  ,:COD_INC_TRIB  ');
      lQuery.SQL.Add('  ,:IND_APRO_CRED  ');
      lQuery.SQL.Add('  ,:COD_TIPO_CONT  ');
      lQuery.SQL.Add('  ,:IND_REG_CUM  ');
      lQuery.SQL.Add(');  ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_INC_TRIB').AsString := lConteudo;
           2:lQuery.ParamByName('IND_APRO_CRED').AsString := lConteudo;
           3:lQuery.ParamByName('COD_TIPO_CONT').AsString := lConteudo;
           4:lQuery.ParamByName('IND_REG_CUM').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0110 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0140 }

class procedure TRegistro_0140.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0140( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,COD_EST ');
      lQuery.SQL.Add('  ,NOME ');
      lQuery.SQL.Add('  ,CNPJ ');
      lQuery.SQL.Add('  ,UF ');
      lQuery.SQL.Add('  ,IE ');
      lQuery.SQL.Add('  ,COD_MUN ');
      lQuery.SQL.Add('  ,IM ');
      lQuery.SQL.Add('  ,SUFRAMA ');
      lQuery.SQL.Add(') VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:COD_EST ');
      lQuery.SQL.Add('  ,:NOME ');
      lQuery.SQL.Add('  ,:CNPJ ');
      lQuery.SQL.Add('  ,:UF ');
      lQuery.SQL.Add('  ,:IE ');
      lQuery.SQL.Add('  ,:COD_MUN ');
      lQuery.SQL.Add('  ,:IM ');
      lQuery.SQL.Add('  ,:SUFRAMA ');
      lQuery.SQL.Add('); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_EST').AsString := lConteudo;
           2:lQuery.ParamByName('NOME').AsString := lConteudo;
           3:lQuery.ParamByName('CNPJ').AsString := lConteudo;
           4:lQuery.ParamByName('UF').AsString := lConteudo;
           5:lQuery.ParamByName('IE').AsString := lConteudo;
           6:lQuery.ParamByName('COD_MUN').AsString := lConteudo;
           7:lQuery.ParamByName('IM').AsString := lConteudo;
           8:lQuery.ParamByName('SUFRAMA').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0140 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0150 }

class procedure TRegistro_0150.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0150( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,COD_PART ');
      lQuery.SQL.Add('  ,NOME ');
      lQuery.SQL.Add('  ,COD_PAIS ');
      lQuery.SQL.Add('  ,CNPJ ');
      lQuery.SQL.Add('  ,CPF ');
      lQuery.SQL.Add('  ,IE ');
      lQuery.SQL.Add('  ,COD_MUN ');
      lQuery.SQL.Add('  ,SUFRAMA ');
      lQuery.SQL.Add('  ,"END" ');
      lQuery.SQL.Add('  ,NUM ');
      lQuery.SQL.Add('  ,COMPL ');
      lQuery.SQL.Add('  ,BAIRRO ');
      lQuery.SQL.Add(') VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:COD_PART ');
      lQuery.SQL.Add('  ,:NOME ');
      lQuery.SQL.Add('  ,:COD_PAIS ');
      lQuery.SQL.Add('  ,:CNPJ ');
      lQuery.SQL.Add('  ,:CPF ');
      lQuery.SQL.Add('  ,:IE ');
      lQuery.SQL.Add('  ,:COD_MUN ');
      lQuery.SQL.Add('  ,:SUFRAMA ');
      lQuery.SQL.Add('  ,:END ');
      lQuery.SQL.Add('  ,:NUM ');
      lQuery.SQL.Add('  ,:COMPL ');
      lQuery.SQL.Add('  ,:BAIRRO ');
      lQuery.SQL.Add('); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_PART').AsString := lConteudo;
           2:lQuery.ParamByName('NOME').AsString := lConteudo;
           3:lQuery.ParamByName('COD_PAIS').AsString := lConteudo;
           4:lQuery.ParamByName('CNPJ').AsString := lConteudo;
           5:lQuery.ParamByName('CPF').AsString := lConteudo;
           6:lQuery.ParamByName('IE').AsString := lConteudo;
           7:lQuery.ParamByName('COD_MUN').AsString := lConteudo;
           8:lQuery.ParamByName('SUFRAMA').AsString := lConteudo;
           9:lQuery.ParamByName('END').AsString := lConteudo;
          10:lQuery.ParamByName('NUM').AsString := lConteudo;
          11:lQuery.ParamByName('COMPL').AsString := lConteudo;
          12:lQuery.ParamByName('BAIRRO').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0150 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0190 }

class procedure TRegistro_0190.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0190( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,UNID ');
      lQuery.SQL.Add('  ,DESCR ');
      lQuery.SQL.Add(') ');
      lQuery.SQL.Add('VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:UNID ');
      lQuery.SQL.Add('  ,:DESCR ');
      lQuery.SQL.Add('); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('UNID').AsString := lConteudo;
           2:lQuery.ParamByName('DESCR').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0190 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0200 }

class procedure TRegistro_0200.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0200( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,COD_ITEM ');
      lQuery.SQL.Add('  ,DESCR_ITEM ');
      lQuery.SQL.Add('  ,COD_BARRA ');
      lQuery.SQL.Add('  ,COD_ANT_ITEM ');
      lQuery.SQL.Add('  ,UNID_INV ');
      lQuery.SQL.Add('  ,TIPO_ITEM ');
      lQuery.SQL.Add('  ,COD_NCM ');
      lQuery.SQL.Add('  ,EX_IPI ');
      lQuery.SQL.Add('  ,COD_GEN ');
      lQuery.SQL.Add('  ,COD_LST ');
      lQuery.SQL.Add('  ,ALIQ_ICMS ');
      lQuery.SQL.Add(') ');
      lQuery.SQL.Add('VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:COD_ITEM ');
      lQuery.SQL.Add('  ,:DESCR_ITEM ');
      lQuery.SQL.Add('  ,:COD_BARRA ');
      lQuery.SQL.Add('  ,:COD_ANT_ITEM ');
      lQuery.SQL.Add('  ,:UNID_INV ');
      lQuery.SQL.Add('  ,:TIPO_ITEM ');
      lQuery.SQL.Add('  ,:COD_NCM ');
      lQuery.SQL.Add('  ,:EX_IPI ');
      lQuery.SQL.Add('  ,:COD_GEN ');
      lQuery.SQL.Add('  ,:COD_LST ');
      lQuery.SQL.Add('  ,:ALIQ_ICMS ');
      lQuery.SQL.Add('); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_ITEM').AsString := lConteudo;
           2:lQuery.ParamByName('DESCR_ITEM').AsString := lConteudo;
           3:lQuery.ParamByName('COD_BARRA').AsString := lConteudo;
           4:lQuery.ParamByName('COD_ANT_ITEM').AsString := lConteudo;
           5:lQuery.ParamByName('UNID_INV').AsString := lConteudo;
           6:lQuery.ParamByName('TIPO_ITEM').AsString := lConteudo;
           7:lQuery.ParamByName('COD_NCM').AsString := lConteudo;
           8:lQuery.ParamByName('EX_IPI').AsString := lConteudo;
           9:lQuery.ParamByName('COD_GEN').AsString := lConteudo;
          10:lQuery.ParamByName('COD_LST').AsString := lConteudo;
          11:lQuery.ParamByName('ALIQ_ICMS').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0200 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0400 }

class procedure TRegistro_0400.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0400( ');
      lQuery.SQL.Add('  ID ');
      lQuery.SQL.Add('  ,REG ');
      lQuery.SQL.Add('  ,COD_NAT ');
      lQuery.SQL.Add('  ,DESCR_NAT ');
      lQuery.SQL.Add(') VALUES( ');
      lQuery.SQL.Add('  :ID ');
      lQuery.SQL.Add('  ,:REG ');
      lQuery.SQL.Add('  ,:COD_NAT ');
      lQuery.SQL.Add('  ,:DESCR_NAT ');
      lQuery.SQL.Add('); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_NAT').AsString := lConteudo;
           2:lQuery.ParamByName('DESCR_NAT').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0400 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0500 }

class procedure TRegistro_0500.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0500(ID, REG, DT_ALT, COD_NAT_CC, IND_CTA, NIVEL, COD_CTA, NOME_CTA, COD_CTA_REF, CNPJ_EST)  ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :DT_ALT, :COD_NAT_CC, :IND_CTA, :NIVEL, :COD_CTA, :NOME_CTA, :COD_CTA_REF, :CNPJ_EST)  ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('DT_ALT').AsString := lConteudo;
           2:lQuery.ParamByName('COD_NAT_CC').AsString := lConteudo;
           3:lQuery.ParamByName('IND_CTA').AsString := lConteudo;
           4:lQuery.ParamByName('NIVEL').AsString := lConteudo;
           5:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
           6:lQuery.ParamByName('NOME_CTA').AsString := lConteudo;
           7:lQuery.ParamByName('COD_CTA_REF').AsString := lConteudo;
           8:lQuery.ParamByName('CNPJ_EST').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_0990 }

class procedure TRegistro_0990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_0990(ID, REG, QTD_LIN_0) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_0) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_0').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('0990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_A001 }

class procedure TRegistro_A001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_A001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('A001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_A010 }

class procedure TRegistro_A010.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_A010(ID, REG, CNPJ) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CNPJ); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CNPJ').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('A010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_A990 }

class procedure TRegistro_A990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_A990(ID, REG, QTD_LIN_A) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_A); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_A').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('A990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C001 }

class procedure TRegistro_C001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C010 }

class procedure TRegistro_C010.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C010(ID, REG, CNPJ, IND_ESCRI) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CNPJ, :IND_ESCRI) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CNPJ').AsString := lConteudo;
           2:lQuery.ParamByName('IND_ESCRI').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C100 }

class procedure TRegistro_C100.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C100(ID, REG, IND_OPER, IND_EMIT, COD_PART, COD_MOD, COD_SIT, SER, NUM_DOC, CHV_NFE, DT_DOC, ');
      lQuery.SQL.Add('  DT_E_S, VL_DOC, IND_PGTO, VL_DESC, VL_ABAT_NT, VL_MERC, IND_FRT, VL_FRT, VL_SEG, VL_OUT_DA, VL_BC_ICMS, VL_ICMS, ');
      lQuery.SQL.Add('  VL_BC_ICMS_ST, VL_ICMS_ST, VL_IPI, VL_PIS, VL_COFINS, VL_PIS_ST, VL_COFINS_ST) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_OPER, :IND_EMIT, :COD_PART, :COD_MOD, :COD_SIT, :SER, :NUM_DOC, :CHV_NFE, :DT_DOC, ');
      lQuery.SQL.Add('  :DT_E_S, :VL_DOC, :IND_PGTO, :VL_DESC, :VL_ABAT_NT, :VL_MERC, :IND_FRT, :VL_FRT, :VL_SEG, :VL_OUT_DA, :VL_BC_ICMS, :VL_ICMS, ');
      lQuery.SQL.Add('  :VL_BC_ICMS_ST, :VL_ICMS_ST, :VL_IPI, :VL_PIS, :VL_COFINS, :VL_PIS_ST, :VL_COFINS_ST); ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_OPER').AsString := lConteudo;
           2:lQuery.ParamByName('IND_EMIT').AsString := lConteudo;
           3:lQuery.ParamByName('COD_PART').AsString := lConteudo;
           4:lQuery.ParamByName('COD_MOD').AsString := lConteudo;
           5:lQuery.ParamByName('COD_SIT').AsString := lConteudo;
           6:lQuery.ParamByName('SER').AsString := lConteudo;
           7:lQuery.ParamByName('NUM_DOC').AsString := lConteudo;
           8:lQuery.ParamByName('CHV_NFE').AsString := lConteudo;
           9:lQuery.ParamByName('DT_DOC').AsString := lConteudo;
          10:lQuery.ParamByName('DT_E_S').AsString := lConteudo;
          11:lQuery.ParamByName('VL_DOC').AsString := lConteudo;
          12:lQuery.ParamByName('IND_PGTO').AsString := lConteudo;
          13:lQuery.ParamByName('VL_DESC').AsString := lConteudo;
          14:lQuery.ParamByName('VL_ABAT_NT').AsString := lConteudo;
          15:lQuery.ParamByName('VL_MERC').AsString := lConteudo;
          16:lQuery.ParamByName('IND_FRT').AsString := lConteudo;
          17:lQuery.ParamByName('VL_FRT').AsString := lConteudo;
          18:lQuery.ParamByName('VL_SEG').AsString := lConteudo;
          19:lQuery.ParamByName('VL_OUT_DA').AsString := lConteudo;
          20:lQuery.ParamByName('VL_BC_ICMS').AsString := lConteudo;
          21:lQuery.ParamByName('VL_ICMS').AsString := lConteudo;
          22:lQuery.ParamByName('VL_BC_ICMS_ST').AsString := lConteudo;
          23:lQuery.ParamByName('VL_ICMS_ST').AsString := lConteudo;
          24:lQuery.ParamByName('VL_IPI').AsString := lConteudo;
          25:lQuery.ParamByName('VL_PIS').AsString := lConteudo;
          26:lQuery.ParamByName('VL_COFINS').AsString := lConteudo;
          27:lQuery.ParamByName('VL_PIS_ST').AsString := lConteudo;
          28:lQuery.ParamByName('VL_COFINS_ST').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C170 }

class procedure TRegistro_C170.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C170(ID, ID_C100, REG, NUM_ITEM, COD_ITEM, DESCR_COMPL, QTD, UNID, VL_ITEM, VL_DESC, IND_MOV, ');
      lQuery.SQL.Add('  CST_ICMS, CFOP, COD_NAT, VL_BC_ICMS, ALIQ_ICMS, VL_ICMS, VL_BC_ICMS_ST, ALIQ_ST, VL_ICMS_ST, IND_APUR, CST_IPI, ');
      lQuery.SQL.Add('  COD_ENQ, VL_BC_IPI, ALIQ_IPI, VL_IPI, CST_PIS, VL_BC_PIS, ALIQ_PIS, QUANT_BC_PIS, ALIQ_PIS_QUANT, VL_PIS, CST_COFINS, ');
      lQuery.SQL.Add('  VL_BC_COFINS, ALIQ_COFINS, QUANT_BC_COFINS, ALIQ_COFINS_QUANT, VL_COFINS, COD_CTA) ');
      lQuery.SQL.Add('VALUES(:ID, :ID_C100, :REG, :NUM_ITEM, :COD_ITEM, :DESCR_COMPL, :QTD, :UNID, :VL_ITEM, :VL_DESC, :IND_MOV, ');
      lQuery.SQL.Add('  :CST_ICMS, :CFOP, :COD_NAT, :VL_BC_ICMS, :ALIQ_ICMS, :VL_ICMS, :VL_BC_ICMS_ST, :ALIQ_ST, :VL_ICMS_ST, :IND_APUR, :CST_IPI, ');
      lQuery.SQL.Add('  :COD_ENQ, :VL_BC_IPI, :ALIQ_IPI, :VL_IPI, :CST_PIS, :VL_BC_PIS, :ALIQ_PIS, :QUANT_BC_PIS, :ALIQ_PIS_QUANT, :VL_PIS, :CST_COFINS, ');
      lQuery.SQL.Add('  :VL_BC_COFINS, :ALIQ_COFINS, :QUANT_BC_COFINS, :ALIQ_COFINS_QUANT, :VL_COFINS, :COD_CTA); ');
      lQuery.ParamByName('ID').AsInteger := AId;
      lQuery.ParamByName('ID_C100').AsInteger := AId_Pai;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NUM_ITEM').AsString := lConteudo;
           2:lQuery.ParamByName('COD_ITEM').AsString := lConteudo;
           3:lQuery.ParamByName('DESCR_COMPL').AsString := lConteudo;
           4:lQuery.ParamByName('QTD').AsString := lConteudo;
           5:lQuery.ParamByName('UNID').AsString := lConteudo;
           6:lQuery.ParamByName('VL_ITEM').AsString := lConteudo;
           7:lQuery.ParamByName('VL_DESC').AsString := lConteudo;
           8:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
           9:lQuery.ParamByName('CST_ICMS').AsString := lConteudo;
          10:lQuery.ParamByName('CFOP').AsString := lConteudo;
          11:lQuery.ParamByName('COD_NAT').AsString := lConteudo;
          12:lQuery.ParamByName('VL_BC_ICMS').AsString := lConteudo;
          13:lQuery.ParamByName('ALIQ_ICMS').AsString := lConteudo;
          14:lQuery.ParamByName('VL_ICMS').AsString := lConteudo;
          15:lQuery.ParamByName('VL_BC_ICMS_ST').AsString := lConteudo;
          16:lQuery.ParamByName('ALIQ_ST').AsString := lConteudo;
          17:lQuery.ParamByName('VL_ICMS_ST').AsString := lConteudo;
          18:lQuery.ParamByName('IND_APUR').AsString := lConteudo;
          19:lQuery.ParamByName('CST_IPI').AsString := lConteudo;
          20:lQuery.ParamByName('COD_ENQ').AsString := lConteudo;
          21:lQuery.ParamByName('VL_BC_IPI').AsString := lConteudo;
          22:lQuery.ParamByName('ALIQ_IPI').AsString := lConteudo;
          23:lQuery.ParamByName('VL_IPI').AsString := lConteudo;
          24:lQuery.ParamByName('CST_PIS').AsString := lConteudo;
          25:lQuery.ParamByName('VL_BC_PIS').AsString := lConteudo;
          26:lQuery.ParamByName('ALIQ_PIS').AsString := lConteudo;
          27:lQuery.ParamByName('QUANT_BC_PIS').AsString := lConteudo;
          28:lQuery.ParamByName('ALIQ_PIS_QUANT').AsString := lConteudo;
          29:lQuery.ParamByName('VL_PIS').AsString := lConteudo;
          30:lQuery.ParamByName('CST_COFINS').AsString := lConteudo;
          31:lQuery.ParamByName('VL_BC_COFINS').AsString := lConteudo;
          32:lQuery.ParamByName('ALIQ_COFINS').AsString := lConteudo;
          33:lQuery.ParamByName('QUANT_BC_COFINS').AsString := lConteudo;
          34:lQuery.ParamByName('ALIQ_COFINS_QUANT').AsString := lConteudo;
          35:lQuery.ParamByName('VL_COFINS').AsString := lConteudo;
          36:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C170 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C175 }

class procedure TRegistro_C175.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C175(ID, ID_C100, REG, CFOP, VL_OPR, VL_DESC, CST_PIS, VL_BC_PIS, ALIQ_PIS, QUANT_BC_PIS, ALIQ_PIS_QUANT, ');
      lQuery.SQL.Add('  VL_PIS, CST_COFINS, VL_BC_COFINS, ALIQ_COFINS, QUANT_BC_COFINS, ALIQ_COFINS_QUANT, VL_COFINS, COD_CTA, INFO_COMPL) ');
      lQuery.SQL.Add('VALUES(:ID, :ID_C100, :REG, :CFOP, :VL_OPR, :VL_DESC, :CST_PIS, :VL_BC_PIS, :ALIQ_PIS, :QUANT_BC_PIS, :ALIQ_PIS_QUANT, ');
      lQuery.SQL.Add('  :VL_PIS, :CST_COFINS, :VL_BC_COFINS, :ALIQ_COFINS, :QUANT_BC_COFINS, :ALIQ_COFINS_QUANT, :VL_COFINS, :COD_CTA, :INFO_COMPL) ');
      lQuery.ParamByName('ID').AsInteger := AId;
      lQuery.ParamByName('ID_C100').AsInteger := AId_Pai;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CFOP').AsString := lConteudo;
           2:lQuery.ParamByName('VL_OPR').AsString := lConteudo;
           3:lQuery.ParamByName('VL_DESC').AsString := lConteudo;
           4:lQuery.ParamByName('CST_PIS').AsString := lConteudo;
           5:lQuery.ParamByName('VL_BC_PIS').AsString := lConteudo;
           6:lQuery.ParamByName('ALIQ_PIS').AsString := lConteudo;
           7:lQuery.ParamByName('QUANT_BC_PIS').AsString := lConteudo;
           8:lQuery.ParamByName('ALIQ_PIS_QUANT').AsString := lConteudo;
           9:lQuery.ParamByName('VL_PIS').AsString := lConteudo;
          10:lQuery.ParamByName('CST_COFINS').AsString := lConteudo;
          11:lQuery.ParamByName('VL_BC_COFINS').AsString := lConteudo;
          12:lQuery.ParamByName('ALIQ_COFINS').AsString := lConteudo;
          13:lQuery.ParamByName('QUANT_BC_COFINS').AsString := lConteudo;
          14:lQuery.ParamByName('ALIQ_COFINS_QUANT').AsString := lConteudo;
          15:lQuery.ParamByName('VL_COFINS').AsString := lConteudo;
          16:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
          17:lQuery.ParamByName('INFO_COMPL').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C175 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C500 }

class procedure TRegistro_C500.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C500(ID, REG, COD_PART, COD_MOD, COD_SIT, SER, SUB, NUM_DOC, DT_DOC, DT_ENT, VL_DOC, VL_ICMS, COD_INF, VL_PIS, VL_COFINS, CHV_DOCE) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :COD_PART, :COD_MOD, :COD_SIT, :SER, :SUB, :NUM_DOC, :DT_DOC, :DT_ENT, :VL_DOC, :VL_ICMS, :COD_INF, :VL_PIS, :VL_COFINS, :CHV_DOCE) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_PART').AsString := lConteudo;
           2:lQuery.ParamByName('COD_MOD').AsString := lConteudo;
           3:lQuery.ParamByName('COD_SIT').AsString := lConteudo;
           4:lQuery.ParamByName('SER').AsString := lConteudo;
           5:lQuery.ParamByName('SUB').AsString := lConteudo;
           6:lQuery.ParamByName('NUM_DOC').AsString := lConteudo;
           7:lQuery.ParamByName('DT_DOC').AsString := lConteudo;
           8:lQuery.ParamByName('DT_ENT').AsString := lConteudo;
           9:lQuery.ParamByName('VL_DOC').AsString := lConteudo;
          10:lQuery.ParamByName('VL_ICMS').AsString := lConteudo;
          11:lQuery.ParamByName('COD_INF').AsString := lConteudo;
          12:lQuery.ParamByName('VL_PIS').AsString := lConteudo;
          13:lQuery.ParamByName('VL_COFINS').AsString := lConteudo;
          14:lQuery.ParamByName('CHV_DOCE').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C501 }

class procedure TRegistro_C501.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C501(ID, REG, CST_PIS, VL_ITEM, NAT_BC_CRED, VL_BC_PIS, ALIQ_PIS, VL_PIS, COD_CTA) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CST_PIS, :VL_ITEM, :NAT_BC_CRED, :VL_BC_PIS, :ALIQ_PIS, :VL_PIS, :COD_CTA) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CST_PIS').AsString := lConteudo;
           2:lQuery.ParamByName('VL_ITEM').AsString := lConteudo;
           3:lQuery.ParamByName('NAT_BC_CRED').AsString := lConteudo;
           4:lQuery.ParamByName('VL_BC_PIS').AsString := lConteudo;
           5:lQuery.ParamByName('ALIQ_PIS').AsString := lConteudo;
           6:lQuery.ParamByName('VL_PIS').AsString := lConteudo;
           7:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C501 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C505 }

class procedure TRegistro_C505.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C505(ID, REG, CST_COFINS, VL_ITEM, NAT_BC_CRED, VL_BC_COFINS, ALIQ_COFINS, VL_COFINS, COD_CTA) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CST_COFINS, :VL_ITEM, :NAT_BC_CRED, :VL_BC_COFINS, :ALIQ_COFINS, :VL_COFINS, :COD_CTA) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CST_COFINS').AsString := lConteudo;
           2:lQuery.ParamByName('VL_ITEM').AsString := lConteudo;
           3:lQuery.ParamByName('NAT_BC_CRED').AsString := lConteudo;
           4:lQuery.ParamByName('VL_BC_COFINS').AsString := lConteudo;
           5:lQuery.ParamByName('ALIQ_COFINS').AsString := lConteudo;
           6:lQuery.ParamByName('VL_COFINS').AsString := lConteudo;
           7:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C505 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_C990 }

class procedure TRegistro_C990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_C990(ID, REG, QTD_LIN_C) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_C) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_C').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('C990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_D001 }

class procedure TRegistro_D001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_D001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('D001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_D010 }

class procedure TRegistro_D010.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_D010(ID, REG, CNPJ) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CNPJ) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CNPJ').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('D010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_D990 }

class procedure TRegistro_D990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_D990(ID, REG, QTD_LIN_D) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_D) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_D').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('D990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_F001 }

class procedure TRegistro_F001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_F001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('F001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_F010 }

class procedure TRegistro_F010.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_F010(ID, REG, CNPJ) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CNPJ) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CNPJ').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('F010 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_F100 }

class procedure TRegistro_F100.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_F100(ID, REG, IND_OPER, COD_PART, COD_ITEM, DT_OPER, VL_OPER, CST_PIS, VL_BC_PIS, ALIQ_PIS, ');
      lQuery.SQL.Add('  VL_PIS, CST_COFINS, VL_BC_COFINS, ALIQ_COFINS, VL_COFINS, NAT_BC_CRED, IND_ORIG_CRED, COD_CTA, COD_CCUS, DESC_DOC_OPER) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_OPER, :COD_PART, :COD_ITEM, :DT_OPER, :VL_OPER, :CST_PIS, :VL_BC_PIS, :ALIQ_PIS, ');
      lQuery.SQL.Add('  :VL_PIS, :CST_COFINS, :VL_BC_COFINS, :ALIQ_COFINS, :VL_COFINS, :NAT_BC_CRED, :IND_ORIG_CRED, :COD_CTA, :COD_CCUS, :DESC_DOC_OPER) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_OPER').AsString := lConteudo;
           2:lQuery.ParamByName('COD_PART').AsString := lConteudo;
           3:lQuery.ParamByName('COD_ITEM').AsString := lConteudo;
           4:lQuery.ParamByName('DT_OPER').AsString := lConteudo;
           5:lQuery.ParamByName('VL_OPER').AsString := lConteudo;
           6:lQuery.ParamByName('CST_PIS').AsString := lConteudo;
           7:lQuery.ParamByName('VL_BC_PIS').AsString := lConteudo;
           8:lQuery.ParamByName('ALIQ_PIS').AsString := lConteudo;
           9:lQuery.ParamByName('VL_PIS').AsString := lConteudo;
          10:lQuery.ParamByName('CST_COFINS').AsString := lConteudo;
          11:lQuery.ParamByName('VL_BC_COFINS').AsString := lConteudo;
          12:lQuery.ParamByName('ALIQ_COFINS').AsString := lConteudo;
          13:lQuery.ParamByName('VL_COFINS').AsString := lConteudo;
          14:lQuery.ParamByName('NAT_BC_CRED').AsString := lConteudo;
          15:lQuery.ParamByName('IND_ORIG_CRED').AsString := lConteudo;
          16:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
          17:lQuery.ParamByName('COD_CCUS').AsString := lConteudo;
          18:lQuery.ParamByName('DESC_DOC_OPER').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('F100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_F990 }

class procedure TRegistro_F990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_F990(ID, REG, QTD_LIN_F) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_F) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_F').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('F900 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_I001 }

class procedure TRegistro_I001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_I001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('I001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_I990 }

class procedure TRegistro_I990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_I990(ID, REG, QTD_LIN_I) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_I) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_I').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('I990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M001 }

class procedure TRegistro_M001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M100 }

class procedure TRegistro_M100.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M100(ID, REG, COD_CRED, IND_CRED_ORI, VL_BC_PIS, ALIQ_PIS, QUANT_BC_PIS, ALIQ_PIS_QUANT, ');
      lQuery.SQL.Add('  VL_CRED, VL_AJUS_ACRES, VL_AJUS_REDUC, VL_CRED_DIF, VL_CRED_DISP, IND_DESC_CRED, VL_CRED_DESC, SLD_CRED) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :COD_CRED, :IND_CRED_ORI, :VL_BC_PIS, :ALIQ_PIS, :QUANT_BC_PIS, :ALIQ_PIS_QUANT, ');
      lQuery.SQL.Add('  :VL_CRED, :VL_AJUS_ACRES, :VL_AJUS_REDUC, :VL_CRED_DIF, :VL_CRED_DISP, :IND_DESC_CRED, :VL_CRED_DESC, :SLD_CRED) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_CRED').AsString := lConteudo;
           2:lQuery.ParamByName('IND_CRED_ORI').AsString := lConteudo;
           3:lQuery.ParamByName('VL_BC_PIS').AsString := lConteudo;
           4:lQuery.ParamByName('ALIQ_PIS').AsString := lConteudo;
           5:lQuery.ParamByName('QUANT_BC_PIS').AsString := lConteudo;
           6:lQuery.ParamByName('ALIQ_PIS_QUANT').AsString := lConteudo;
           7:lQuery.ParamByName('VL_CRED').AsString := lConteudo;
           8:lQuery.ParamByName('VL_AJUS_ACRES').AsString := lConteudo;
           9:lQuery.ParamByName('VL_AJUS_REDUC').AsString := lConteudo;
          10:lQuery.ParamByName('VL_CRED_DIF').AsString := lConteudo;
          11:lQuery.ParamByName('VL_CRED_DISP').AsString := lConteudo;
          12:lQuery.ParamByName('IND_DESC_CRED').AsString := lConteudo;
          13:lQuery.ParamByName('VL_CRED_DESC').AsString := lConteudo;
          14:lQuery.ParamByName('SLD_CRED').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M105 }

class procedure TRegistro_M105.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M105(ID, REG, NAT_BC_CRED, CST_PIS, VL_BC_PIS_TOT, VL_BC_PIS_CUM, VL_BC_PIS_NC, VL_BC_PIS, QUANT_BC_PIS_TOT, QUANT_BC_PIS, DESC_CRED) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :NAT_BC_CRED, :CST_PIS, :VL_BC_PIS_TOT, :VL_BC_PIS_CUM, :VL_BC_PIS_NC, :VL_BC_PIS, :QUANT_BC_PIS_TOT, :QUANT_BC_PIS, :DESC_CRED) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NAT_BC_CRED').AsString := lConteudo;
           2:lQuery.ParamByName('CST_PIS').AsString := lConteudo;
           3:lQuery.ParamByName('VL_BC_PIS_TOT').AsString := lConteudo;
           4:lQuery.ParamByName('VL_BC_PIS_CUM').AsString := lConteudo;
           5:lQuery.ParamByName('VL_BC_PIS_NC').AsString := lConteudo;
           6:lQuery.ParamByName('VL_BC_PIS').AsString := lConteudo;
           7:lQuery.ParamByName('QUANT_BC_PIS_TOT').AsString := lConteudo;
           8:lQuery.ParamByName('QUANT_BC_PIS').AsString := lConteudo;
           9:lQuery.ParamByName('DESC_CRED').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M105 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M110 }

class procedure TRegistro_M110.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M110(ID, REG, IND_AJ, VL_AJ, COD_AJ, NUM_DOC, DESCR_AJ, DT_REF) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_AJ, :VL_AJ, :COD_AJ, :NUM_DOC, :DESCR_AJ, :DT_REF) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_AJ').AsString := lConteudo;
           2:lQuery.ParamByName('VL_AJ').AsString := lConteudo;
           3:lQuery.ParamByName('COD_AJ').AsString := lConteudo;
           4:lQuery.ParamByName('NUM_DOC').AsString := lConteudo;
           5:lQuery.ParamByName('DESCR_AJ').AsString := lConteudo;
           6:lQuery.ParamByName('DT_REF').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M110 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M200 }

class procedure TRegistro_M200.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M200(ID, REG, VL_TOT_CONT_NC_PER, VL_TOT_CRED_DESC, VL_TOT_CRED_DESC_ANT, VL_TOT_CONT_NC_DEV, ');
      lQuery.SQL.Add('  VL_RET_NC, VL_OUT_DED_NC, VL_CONT_NC_REC, VL_TOT_CONT_CUM_PER, VL_RET_CUM, VL_OUT_DED_CUM, VL_CONT_CUM_REC, VL_TOT_CONT_REC) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :VL_TOT_CONT_NC_PER, :VL_TOT_CRED_DESC, :VL_TOT_CRED_DESC_ANT, :VL_TOT_CONT_NC_DEV, ');
      lQuery.SQL.Add('  :VL_RET_NC, :VL_OUT_DED_NC, :VL_CONT_NC_REC, :VL_TOT_CONT_CUM_PER, :VL_RET_CUM, :VL_OUT_DED_CUM, :VL_CONT_CUM_REC, :VL_TOT_CONT_REC) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('VL_TOT_CONT_NC_PER').AsString := lConteudo;
           2:lQuery.ParamByName('VL_TOT_CRED_DESC').AsString := lConteudo;
           3:lQuery.ParamByName('VL_TOT_CRED_DESC_ANT').AsString := lConteudo;
           4:lQuery.ParamByName('VL_TOT_CONT_NC_DEV').AsString := lConteudo;
           5:lQuery.ParamByName('VL_RET_NC').AsString := lConteudo;
           6:lQuery.ParamByName('VL_OUT_DED_NC').AsString := lConteudo;
           7:lQuery.ParamByName('VL_CONT_NC_REC').AsString := lConteudo;
           8:lQuery.ParamByName('VL_TOT_CONT_CUM_PER').AsString := lConteudo;
           9:lQuery.ParamByName('VL_RET_CUM').AsString := lConteudo;
          10:lQuery.ParamByName('VL_OUT_DED_CUM').AsString := lConteudo;
          11:lQuery.ParamByName('VL_CONT_CUM_REC').AsString := lConteudo;
          12:lQuery.ParamByName('VL_TOT_CONT_REC').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M200 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M205 }

class procedure TRegistro_M205.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M205(ID, REG, NUM_CAMPO, COD_REC, VL_DEBITO) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :NUM_CAMPO, :COD_REC, :VL_DEBITO) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NUM_CAMPO').AsString := lConteudo;
           2:lQuery.ParamByName('COD_REC').AsString := lConteudo;
           3:lQuery.ParamByName('VL_DEBITO').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M205 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M210 }

class procedure TRegistro_M210.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M210(ID, REG, COD_CONT, VL_REC_BRT, VL_BC_CONT, VL_AJUS_ACRES_BC_PIS, VL_AJUS_REDUC_BC_PIS, ');
      lQuery.SQL.Add('  VL_BC_CONT_AJUS, ALIQ_PIS, QUANT_BC_PIS, ALIQ_PIS_QUANT, VL_CONT_APUR, VL_AJUS_ACRES, VL_AJUS_REDUC, ');
      lQuery.SQL.Add('  VL_CONT_DIFER, VL_CONT_DIFER_ANT, VL_CONT_PER) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :COD_CONT, :VL_REC_BRT, :VL_BC_CONT, :VL_AJUS_ACRES_BC_PIS, :VL_AJUS_REDUC_BC_PIS, ');
      lQuery.SQL.Add('  :VL_BC_CONT_AJUS, :ALIQ_PIS, :QUANT_BC_PIS, :ALIQ_PIS_QUANT, :VL_CONT_APUR, :VL_AJUS_ACRES, :VL_AJUS_REDUC, ');
      lQuery.SQL.Add('  :VL_CONT_DIFER, :VL_CONT_DIFER_ANT, :VL_CONT_PER) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_CONT').AsString := lConteudo;
           2:lQuery.ParamByName('VL_REC_BRT').AsString := lConteudo;
           3:lQuery.ParamByName('VL_BC_CONT').AsString := lConteudo;
           4:lQuery.ParamByName('VL_AJUS_ACRES_BC_PIS').AsString := lConteudo;
           5:lQuery.ParamByName('VL_AJUS_REDUC_BC_PIS').AsString := lConteudo;
           6:lQuery.ParamByName('VL_BC_CONT_AJUS').AsString := lConteudo;
           7:lQuery.ParamByName('ALIQ_PIS').AsString := lConteudo;
           8:lQuery.ParamByName('QUANT_BC_PIS').AsString := lConteudo;
           9:lQuery.ParamByName('ALIQ_PIS_QUANT').AsString := lConteudo;
          10:lQuery.ParamByName('VL_CONT_APUR').AsString := lConteudo;
          11:lQuery.ParamByName('VL_AJUS_ACRES').AsString := lConteudo;
          12:lQuery.ParamByName('VL_AJUS_REDUC').AsString := lConteudo;
          13:lQuery.ParamByName('VL_CONT_DIFER').AsString := lConteudo;
          14:lQuery.ParamByName('VL_CONT_DIFER_ANT').AsString := lConteudo;
          15:lQuery.ParamByName('VL_CONT_PER').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M210 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M400 }

class procedure TRegistro_M400.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M400(ID, REG, CST_PIS, VL_TOT_REC, COD_CTA, DESC_COMPL) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CST_PIS, :VL_TOT_REC, :COD_CTA, :DESC_COMPL) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CST_PIS').AsString := lConteudo;
           2:lQuery.ParamByName('VL_TOT_REC').AsString := lConteudo;
           3:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
           4:lQuery.ParamByName('DESC_COMPL').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M400 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M410 }

class procedure TRegistro_M410.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M410(ID, ID_M400, REG, NAT_REC, VL_REC, COD_CTA, DESC_COMPL) ');
      lQuery.SQL.Add('VALUES(:ID, :ID_M400, :REG, :NAT_REC, :VL_REC, :COD_CTA, :DESC_COMPL) ');
      lQuery.ParamByName('ID').AsInteger := AId;
      lQuery.ParamByName('ID_M400').AsInteger := AId_Pai;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NAT_REC').AsString := lConteudo;
           2:lQuery.ParamByName('VL_REC').AsString := lConteudo;
           3:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
           4:lQuery.ParamByName('DESC_COMPL').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M410 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M500 }

class procedure TRegistro_M500.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M500(ID, REG, COD_CRED, IND_CRED_ORI, VL_BC_COFINS, ALIQ_COFINS, QUANT_BC_COFINS, ALIQ_COFINS_QUANT, ');
      lQuery.SQL.Add('  VL_CRED, VL_AJUS_ACRES, VL_AJUS_REDUC, VL_CRED_DIFER, VL_CRED_DISP, IND_DESC_CRED, VL_CRED_DESC, SLD_CRED) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :COD_CRED, :IND_CRED_ORI, :VL_BC_COFINS, :ALIQ_COFINS, :QUANT_BC_COFINS, :ALIQ_COFINS_QUANT, ');
      lQuery.SQL.Add('  :VL_CRED, :VL_AJUS_ACRES, :VL_AJUS_REDUC, :VL_CRED_DIFER, :VL_CRED_DISP, :IND_DESC_CRED, :VL_CRED_DESC, :SLD_CRED) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_CRED').AsString := lConteudo;
           2:lQuery.ParamByName('IND_CRED_ORI').AsString := lConteudo;
           3:lQuery.ParamByName('VL_BC_COFINS').AsString := lConteudo;
           4:lQuery.ParamByName('ALIQ_COFINS').AsString := lConteudo;
           5:lQuery.ParamByName('QUANT_BC_COFINS').AsString := lConteudo;
           6:lQuery.ParamByName('ALIQ_COFINS_QUANT').AsString := lConteudo;
           7:lQuery.ParamByName('VL_CRED').AsString := lConteudo;
           8:lQuery.ParamByName('VL_AJUS_ACRES').AsString := lConteudo;
           9:lQuery.ParamByName('VL_AJUS_REDUC').AsString := lConteudo;
          10:lQuery.ParamByName('VL_CRED_DIFER').AsString := lConteudo;
          11:lQuery.ParamByName('VL_CRED_DISP').AsString := lConteudo;
          12:lQuery.ParamByName('IND_DESC_CRED').AsString := lConteudo;
          13:lQuery.ParamByName('VL_CRED_DESC').AsString := lConteudo;
          14:lQuery.ParamByName('SLD_CRED').AsString := lConteudo;
          15:lQuery.ParamByName('ALIQ_COFINS').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M505 }

class procedure TRegistro_M505.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M505(ID, REG, NAT_BC_CRED, CST_COFINS, VL_BC_COFINS_TOT, VL_BC_COFINS_CUM, VL_BC_COFINS_NC, VL_BC_COFINS, ');
      lQuery.SQL.Add('  QUANT_BC_COFINS_TOT, QUANT_BC_COFINS, DESC_CRED) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :NAT_BC_CRED, :CST_COFINS, :VL_BC_COFINS_TOT, :VL_BC_COFINS_CUM, :VL_BC_COFINS_NC, :VL_BC_COFINS, ');
      lQuery.SQL.Add('  :QUANT_BC_COFINS_TOT, :QUANT_BC_COFINS, :DESC_CRED) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NAT_BC_CRED').AsString := lConteudo;
           2:lQuery.ParamByName('CST_COFINS').AsString := lConteudo;
           3:lQuery.ParamByName('VL_BC_COFINS_TOT').AsString := lConteudo;
           4:lQuery.ParamByName('VL_BC_COFINS_CUM').AsString := lConteudo;
           5:lQuery.ParamByName('VL_BC_COFINS_NC').AsString := lConteudo;
           6:lQuery.ParamByName('VL_BC_COFINS').AsString := lConteudo;
           7:lQuery.ParamByName('QUANT_BC_COFINS_TOT').AsString := lConteudo;
           8:lQuery.ParamByName('QUANT_BC_COFINS').AsString := lConteudo;
           9:lQuery.ParamByName('DESC_CRED').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M505 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M510 }

class procedure TRegistro_M510.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M510(ID, REG, IND_AJ, VL_AJ, COD_AJ, NUM_DOC, DESCR_AJ, DT_REF) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_AJ, :VL_AJ, :COD_AJ, :NUM_DOC, :DESCR_AJ, :DT_REF) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_AJ').AsString := lConteudo;
           2:lQuery.ParamByName('VL_AJ').AsString := lConteudo;
           3:lQuery.ParamByName('COD_AJ').AsString := lConteudo;
           4:lQuery.ParamByName('NUM_DOC').AsString := lConteudo;
           5:lQuery.ParamByName('DESCR_AJ').AsString := lConteudo;
           6:lQuery.ParamByName('DT_REF').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M510 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M600 }

class procedure TRegistro_M600.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M600(ID, REG, VL_TOT_CONT_NC_PER, VL_TOT_CRED_DESC, VL_TOT_CRED_DESC_ANT, VL_TOT_CONT_NC_DEV, VL_RET_NC, ');
      lQuery.SQL.Add('  VL_OUT_DED_NC, VL_CONT_NC_REC, VL_TOT_CONT_CUM_PER, VL_RET_CUM, VL_OUT_DED_CUM, VL_CONT_CUM_REC, VL_TOT_CONT_REC) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :VL_TOT_CONT_NC_PER, :VL_TOT_CRED_DESC, :VL_TOT_CRED_DESC_ANT, :VL_TOT_CONT_NC_DEV, :VL_RET_NC, ');
      lQuery.SQL.Add('  :VL_OUT_DED_NC, :VL_CONT_NC_REC, :VL_TOT_CONT_CUM_PER, :VL_RET_CUM, :VL_OUT_DED_CUM, :VL_CONT_CUM_REC, :VL_TOT_CONT_REC) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('VL_TOT_CONT_NC_PER').AsString := lConteudo;
           2:lQuery.ParamByName('VL_TOT_CRED_DESC').AsString := lConteudo;
           3:lQuery.ParamByName('VL_TOT_CRED_DESC_ANT').AsString := lConteudo;
           4:lQuery.ParamByName('VL_TOT_CONT_NC_DEV').AsString := lConteudo;
           5:lQuery.ParamByName('VL_RET_NC').AsString := lConteudo;
           6:lQuery.ParamByName('VL_OUT_DED_NC').AsString := lConteudo;
           7:lQuery.ParamByName('VL_CONT_NC_REC').AsString := lConteudo;
           8:lQuery.ParamByName('VL_TOT_CONT_CUM_PER').AsString := lConteudo;
           9:lQuery.ParamByName('VL_RET_CUM').AsString := lConteudo;
          10:lQuery.ParamByName('VL_OUT_DED_CUM').AsString := lConteudo;
          11:lQuery.ParamByName('VL_CONT_CUM_REC').AsString := lConteudo;
          12:lQuery.ParamByName('VL_TOT_CONT_REC').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M600 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M605 }

class procedure TRegistro_M605.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M605(ID, REG, NUM_CAMPO, COD_REC, VL_DEBITO) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :NUM_CAMPO, :COD_REC, :VL_DEBITO) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NUM_CAMPO').AsString := lConteudo;
           2:lQuery.ParamByName('COD_REC').AsString := lConteudo;
           3:lQuery.ParamByName('VL_DEBITO').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M605 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M610 }

class procedure TRegistro_M610.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M610(ID, REG, COD_CONT, VL_REC_BRT, VL_BC_CONT, VL_AJUS_ACRES_BC_COFINS, VL_AJUS_REDUC_BC_COFINS, VL_BC_CONT_AJUS, ');
      lQuery.SQL.Add('  ALIQ_COFINS, QUANT_BC_COFINS, ALIQ_COFINS_QUANT, VL_CONT_APUR, VL_AJUS_ACRES, VL_AJUS_REDUC, VL_CONT_DIFER, VL_CONT_DIFER_ANT, VL_CONT_PER) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :COD_CONT, :VL_REC_BRT, :VL_BC_CONT, :VL_AJUS_ACRES_BC_COFINS, :VL_AJUS_REDUC_BC_COFINS, :VL_BC_CONT_AJUS, ');
      lQuery.SQL.Add('  :ALIQ_COFINS, :QUANT_BC_COFINS, :ALIQ_COFINS_QUANT, :VL_CONT_APUR, :VL_AJUS_ACRES, :VL_AJUS_REDUC, :VL_CONT_DIFER, :VL_CONT_DIFER_ANT, :VL_CONT_PER) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('COD_CONT').AsString := lConteudo;
           2:lQuery.ParamByName('VL_REC_BRT').AsString := lConteudo;
           3:lQuery.ParamByName('VL_BC_CONT').AsString := lConteudo;
           4:lQuery.ParamByName('VL_AJUS_ACRES_BC_COFINS').AsString := lConteudo;
           5:lQuery.ParamByName('VL_AJUS_REDUC_BC_COFINS').AsString := lConteudo;
           6:lQuery.ParamByName('VL_BC_CONT_AJUS').AsString := lConteudo;
           7:lQuery.ParamByName('ALIQ_COFINS').AsString := lConteudo;
           8:lQuery.ParamByName('QUANT_BC_COFINS').AsString := lConteudo;
           9:lQuery.ParamByName('ALIQ_COFINS_QUANT').AsString := lConteudo;
          10:lQuery.ParamByName('VL_CONT_APUR').AsString := lConteudo;
          11:lQuery.ParamByName('VL_AJUS_ACRES').AsString := lConteudo;
          12:lQuery.ParamByName('VL_AJUS_REDUC').AsString := lConteudo;
          13:lQuery.ParamByName('VL_CONT_DIFER').AsString := lConteudo;
          14:lQuery.ParamByName('VL_CONT_DIFER_ANT').AsString := lConteudo;
          15:lQuery.ParamByName('VL_CONT_PER').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M610 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M800 }

class procedure TRegistro_M800.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M800(ID, REG, CST_COFINS, VL_TOT_REC, COD_CTA, DESC_COMPL) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :CST_COFINS, :VL_TOT_REC, :COD_CTA, :DESC_COMPL) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('CST_COFINS').AsString := lConteudo;
           2:lQuery.ParamByName('VL_TOT_REC').AsString := lConteudo;
           3:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
           4:lQuery.ParamByName('DESC_COMPL').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M800 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M810 }

class procedure TRegistro_M810.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M810(ID, ID_M800, REG, NAT_REC, VL_REC, COD_CTA, DESC_COMPL) ');
      lQuery.SQL.Add('VALUES(:ID, :ID_M800, :REG, :NAT_REC, :VL_REC, :COD_CTA, :DESC_COMPL) ');
      lQuery.ParamByName('ID').AsInteger := AId;
      lQuery.ParamByName('ID_M800').AsInteger := AId_Pai;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('NAT_REC').AsString := lConteudo;
           2:lQuery.ParamByName('VL_REC').AsString := lConteudo;
           3:lQuery.ParamByName('COD_CTA').AsString := lConteudo;
           4:lQuery.ParamByName('DESC_COMPL').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M810 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_M990 }

class procedure TRegistro_M990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_M990(ID, REG, QTD_LIN_M) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_M) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_M').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('M990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_P001 }

class procedure TRegistro_P001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_P001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('P001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_P990 }

class procedure TRegistro_P990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_P990(ID, REG, QTD_LIN_P) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_P) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_P').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('P990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_1001 }

class procedure TRegistro_1001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_1001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('1001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_1100 }

class procedure TRegistro_1100.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_1100(ID, REG, PER_APU_CRED, ORIG_CRED, CNPJ_SUC, COD_CRED, VL_CRED_APU, VL_CRED_EXT_APU, VL_TOT_CRED_APU, ');
      lQuery.SQL.Add('  VL_CRED_DESC_PA_ANT, VL_CRED_PER_PA_ANT, VL_CRED_DCOMP_PA_ANT, SD_CRED_DISP_EFD, VL_CRED_DESC_EFD, VL_CRED_PER_EFD, ');
      lQuery.SQL.Add('  VL_CRED_DCOMP_EFD, VL_CRED_TRANS, VL_CRED_OUT, SLD_CRED_FIM) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :PER_APU_CRED, :ORIG_CRED, :CNPJ_SUC, :COD_CRED, :VL_CRED_APU, :VL_CRED_EXT_APU, :VL_TOT_CRED_APU, ');
      lQuery.SQL.Add('  :VL_CRED_DESC_PA_ANT, :VL_CRED_PER_PA_ANT, :VL_CRED_DCOMP_PA_ANT, :SD_CRED_DISP_EFD, :VL_CRED_DESC_EFD, :VL_CRED_PER_EFD, ');
      lQuery.SQL.Add('  :VL_CRED_DCOMP_EFD, :VL_CRED_TRANS, :VL_CRED_OUT, :SLD_CRED_FIM) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('PER_APU_CRED').AsString := lConteudo;
           2:lQuery.ParamByName('ORIG_CRED').AsString := lConteudo;
           3:lQuery.ParamByName('CNPJ_SUC').AsString := lConteudo;
           4:lQuery.ParamByName('COD_CRED').AsString := lConteudo;
           5:lQuery.ParamByName('VL_CRED_APU').AsString := lConteudo;
           6:lQuery.ParamByName('VL_CRED_EXT_APU').AsString := lConteudo;
           7:lQuery.ParamByName('VL_TOT_CRED_APU').AsString := lConteudo;
           8:lQuery.ParamByName('VL_CRED_DESC_PA_ANT').AsString := lConteudo;
           9:lQuery.ParamByName('VL_CRED_PER_PA_ANT').AsString := lConteudo;
          10:lQuery.ParamByName('VL_CRED_DCOMP_PA_ANT').AsString := lConteudo;
          11:lQuery.ParamByName('SD_CRED_DISP_EFD').AsString := lConteudo;
          12:lQuery.ParamByName('VL_CRED_DESC_EFD').AsString := lConteudo;
          13:lQuery.ParamByName('VL_CRED_PER_EFD').AsString := lConteudo;
          14:lQuery.ParamByName('VL_CRED_DCOMP_EFD').AsString := lConteudo;
          15:lQuery.ParamByName('VL_CRED_TRANS').AsString := lConteudo;
          16:lQuery.ParamByName('VL_CRED_OUT').AsString := lConteudo;
          17:lQuery.ParamByName('SLD_CRED_FIM').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('1100 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_1500 }

class procedure TRegistro_1500.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_1500(ID, REG, PER_APU_CRED, ORIG_CRED, CNPJ_SUC, COD_CRED, VL_CRED_APU, VL_CRED_EXT_APU, VL_TOT_CRED_APU, ');
      lQuery.SQL.Add('  VL_CRED_DESC_PA_ANT, VL_CRED_PER_PA_ANT, VL_CRED_DCOMP_PA_ANT, SD_CRED_DISP_EFD, VL_CRED_DESC_EFD, VL_CRED_PER_EFD, VL_CRED_DCOMP_EFD, ');
      lQuery.SQL.Add('  VL_CRED_TRANS, VL_CRED_OUT, SLD_CRED_FIM) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :PER_APU_CRED, :ORIG_CRED, :CNPJ_SUC, :COD_CRED, :VL_CRED_APU, :VL_CRED_EXT_APU, :VL_TOT_CRED_APU, ');
      lQuery.SQL.Add('  :VL_CRED_DESC_PA_ANT, :VL_CRED_PER_PA_ANT, :VL_CRED_DCOMP_PA_ANT, :SD_CRED_DISP_EFD, :VL_CRED_DESC_EFD, :VL_CRED_PER_EFD, :VL_CRED_DCOMP_EFD, ');
      lQuery.SQL.Add('  :VL_CRED_TRANS, :VL_CRED_OUT, :SLD_CRED_FIM) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('PER_APU_CRED').AsString := lConteudo;
           2:lQuery.ParamByName('ORIG_CRED').AsString := lConteudo;
           3:lQuery.ParamByName('CNPJ_SUC').AsString := lConteudo;
           4:lQuery.ParamByName('COD_CRED').AsString := lConteudo;
           5:lQuery.ParamByName('VL_CRED_APU').AsString := lConteudo;
           6:lQuery.ParamByName('VL_CRED_EXT_APU').AsString := lConteudo;
           7:lQuery.ParamByName('VL_TOT_CRED_APU').AsString := lConteudo;
           8:lQuery.ParamByName('VL_CRED_DESC_PA_ANT').AsString := lConteudo;
           9:lQuery.ParamByName('VL_CRED_PER_PA_ANT').AsString := lConteudo;
          10:lQuery.ParamByName('VL_CRED_DCOMP_PA_ANT').AsString := lConteudo;
          11:lQuery.ParamByName('SD_CRED_DISP_EFD').AsString := lConteudo;
          12:lQuery.ParamByName('VL_CRED_DESC_EFD').AsString := lConteudo;
          13:lQuery.ParamByName('VL_CRED_PER_EFD').AsString := lConteudo;
          14:lQuery.ParamByName('VL_CRED_DCOMP_EFD').AsString := lConteudo;
          15:lQuery.ParamByName('VL_CRED_TRANS').AsString := lConteudo;
          16:lQuery.ParamByName('VL_CRED_OUT').AsString := lConteudo;
          17:lQuery.ParamByName('SLD_CRED_FIM').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('1500 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_1990 }

class procedure TRegistro_1990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_1990(ID, REG, QTD_LIN_1) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_1) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_1').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('1990 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_9001 }

class procedure TRegistro_9001.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_9001(ID, REG, IND_MOV) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :IND_MOV) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('IND_MOV').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create('9001 ' + E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_9900 }

class procedure TRegistro_9900.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_9900(ID, REG, REG_BLC, QTD_REG_BLC) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :REG_BLC, :QTD_REG_BLC) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('REG_BLC').AsString := lConteudo;
           2:lQuery.ParamByName('QTD_REG_BLC').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_9990 }

class procedure TRegistro_9990.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_9990(ID, REG, QTD_LIN_9) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN_9) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN_9').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

{ TRegistro_9999 }

class procedure TRegistro_9999.Insert(ADm: TdmSpedContribuicoes; const ALine: String; const AId: Integer;
  AId_Pai: Integer);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := ADm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('INSERT INTO REGISTRO_9999(ID, REG, QTD_LIN) ');
      lQuery.SQL.Add('VALUES(:ID, :REG, :QTD_LIN) ');
      lQuery.ParamByName('ID').AsInteger := AId;

      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        case lPos of
           0:lQuery.ParamByName('REG').AsString := lConteudo;
           1:lQuery.ParamByName('QTD_LIN').AsString := lConteudo;
        end;
        lPos := (lPos + 1);
        lLine := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;
      lQuery.ExecSQL;

    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
    {$IFDEF MSWINDOWS}
      FreeAndNIl(lQuery);
    {$ELSE}
      lQuery.DisposeOf;
    {$ENDIF}
  end;
end;

end.
