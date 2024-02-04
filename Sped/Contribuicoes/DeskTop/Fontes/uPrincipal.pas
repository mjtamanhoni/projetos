unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  {$Region '99 Coders'}
    uLoading,
    uFancyDialog,
  {$EndRegion '99 Coders}

  uDm,
  uRegistros,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.Memo.Types, FMX.Ani,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPrincipal = class(TForm)
    lytHeader: TLayout;
    lytDetail: TLayout;
    lytFooter: TLayout;
    rctHeader: TRectangle;
    rctFooter: TRectangle;
    StyleBook_Principal: TStyleBook;
    memoRegistros: TMemo;
    lytArquivos: TLayout;
    lytAcoes: TLayout;
    lytArquivo: TLayout;
    edArquivo: TEdit;
    lbArquivo: TLabel;
    faArquivo: TFloatAnimation;
    lytNomeSalvar: TLayout;
    lytFiltrar: TLayout;
    edNovoArquivo: TEdit;
    lbNovoArquivo: TLabel;
    faNovoArquivo: TFloatAnimation;
    rctSelecionar: TRectangle;
    lbSelecionar: TLabel;
    lytPreparar: TLayout;
    rctPreparar: TRectangle;
    lbPreparar: TLabel;
    procedure rctSelecionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctPrepararClick(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    lDm :TdmSpedContribuicoes;

    procedure ThreadEnd_Seleciona(Sender: TObject);
    procedure PrepararArquivo;
    procedure ThreadEnd_Prepara(Sender: TObject);
    procedure Insere_Registro(const ALine,ARegistro: String; const AId: Integer; AId_Pai: Integer=0);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MSWINDOWS}
    FreeAndNil(FMensagem);
    FreeAndNil(lDm);
  {$ELSE}
    FMensagem.DisposeOf;
    lDm.DisposeOf;
  {$ENDIF}

  Action := TCloseAction.caFree;
  frmPrincipal := Nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  lDm := TdmSpedContribuicoes.Create(Nil);
  FMensagem := TFancyDialog.Create(frmPrincipal);
end;

procedure TfrmPrincipal.rctPrepararClick(Sender: TObject);
begin
  PrepararArquivo;
end;

procedure TfrmPrincipal.PrepararArquivo;
var
  t :TThread;
begin
  TLoading.Show(frmPrincipal, 'Preparando registros');
  t := TThread.CreateAnonymousThread(
  procedure
  var
    I :Integer;
    lCount :Integer;
    lId_C100 :Integer;
    lId_M400 :Integer;
  begin
    TThread.Synchronize(nil, procedure
    begin
      TLoading.ChangeText('Preparando Tabelas');
    end);
    TRegistro_Geral.Excluir_Reg0000(lDm);
    TRegistro_Geral.Excluir_Reg0001(lDm);
    TRegistro_Geral.Excluir_Reg0100(lDm);
    TRegistro_Geral.Excluir_Reg0110(lDm);
    TRegistro_Geral.Excluir_Reg0140(lDm);
    TRegistro_Geral.Excluir_Reg0150(lDm);
    TRegistro_Geral.Excluir_Reg0190(lDm);
    TRegistro_Geral.Excluir_Reg0200(lDm);
    TRegistro_Geral.Excluir_Reg0400(lDm);
    TRegistro_Geral.Excluir_Reg0500(lDm);
    TRegistro_Geral.Excluir_Reg0990(lDm);
    TRegistro_Geral.Excluir_RegA001(lDm);
    TRegistro_Geral.Excluir_RegA010(lDm);
    TRegistro_Geral.Excluir_RegA990(lDm);
    TRegistro_Geral.Excluir_RegC001(lDm);
    TRegistro_Geral.Excluir_RegC010(lDm);
    TRegistro_Geral.Excluir_RegC100(lDm);
    TRegistro_Geral.Excluir_RegC170(lDm);
    TRegistro_Geral.Excluir_RegC175(lDm);
    TRegistro_Geral.Excluir_RegC500(lDm);
    TRegistro_Geral.Excluir_RegC501(lDm);
    TRegistro_Geral.Excluir_RegC505(lDm);
    TRegistro_Geral.Excluir_RegC990(lDm);
    TRegistro_Geral.Excluir_RegD001(lDm);
    TRegistro_Geral.Excluir_RegD010(lDm);
    TRegistro_Geral.Excluir_RegD990(lDm);
    TRegistro_Geral.Excluir_RegF001(lDm);
    TRegistro_Geral.Excluir_RegF010(lDm);
    TRegistro_Geral.Excluir_RegF100(lDm);
    TRegistro_Geral.Excluir_RegF990(lDm);
    TRegistro_Geral.Excluir_RegI001(lDm);
    TRegistro_Geral.Excluir_RegI990(lDm);
    TRegistro_Geral.Excluir_RegM001(lDm);
    TRegistro_Geral.Excluir_RegM100(lDm);
    TRegistro_Geral.Excluir_RegM105(lDm);
    TRegistro_Geral.Excluir_RegM110(lDm);
    TRegistro_Geral.Excluir_RegM200(lDm);
    TRegistro_Geral.Excluir_RegM205(lDm);
    TRegistro_Geral.Excluir_RegM210(lDm);
    TRegistro_Geral.Excluir_RegM400(lDm);
    TRegistro_Geral.Excluir_RegM410(lDm);
    TRegistro_Geral.Excluir_RegM500(lDm);
    TRegistro_Geral.Excluir_RegM505(lDm);
    TRegistro_Geral.Excluir_RegM510(lDm);
    TRegistro_Geral.Excluir_RegM600(lDm);

    lCount := 0;
    lCount := (memoRegistros.Lines.Count - 1);
    lId_C100 := 0;
    lId_M400 := 0;
    for I := 0 to (memoRegistros.Lines.Count - 1) do
    begin
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0000|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0000] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0000.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0100|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0100] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0100.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0110|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0110] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0110.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0140|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0140] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0140.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0150|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0150] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0150.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0190|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0190] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0190.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0200|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0200] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0200.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0400|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0400] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0400.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0500|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0500] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0500.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|0990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [0990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_0990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|A001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [A001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_A001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|A010|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [A010] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_A010.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|A990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [A990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_A990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C010|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C010] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C010.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C100|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C100] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C100.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
        lId_C100 := I;
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C170|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C170] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C170.Insert(lDm,memoRegistros.Lines.Strings[I],I,lId_C100);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C175|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C175] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C175.Insert(lDm,memoRegistros.Lines.Strings[I],I,lId_C100);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C500|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C500] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C500.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C501|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C501] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C501.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C505|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C505] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C505.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|C990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [C990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_C990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|D001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [D001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_D001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|D010|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [D010] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_D010.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|D990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [D990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_D990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|F001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [F001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_F001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|F010|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [F010] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_F010.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|F100|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [F100] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_F100.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|F990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [F990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_F990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|I001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [I001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_I001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|I990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [I990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_I990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M100|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M100] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M100.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M105|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M105] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M105.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M110|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M110] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M110.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M200|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M200] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M200.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M205|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M205] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M205.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M210|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M210] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M210.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M400|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M400] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M400.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
        lId_M400 := I;
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M410|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M410] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M410.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M500|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M500] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M500.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M505|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M505] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M505.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M510|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M510] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M510.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M600|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M600] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M600.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
    end;
  end);

  t.OnTerminate := ThreadEnd_Prepara;
  t.Start;
end;

procedure TfrmPrincipal.Insere_Registro(const ALine,ARegistro:String; const AId:Integer; AId_Pai:Integer=0);
var
  lQuery :TFDQuery;
  lConteudo :String;
  lLine :String;
  lPos :Integer;
begin
  try
    try
      lQuery := TFDQuery.Create(Nil);
      lQuery.Connection := lDm.FDC_Sped;

      lLine := '';
      lLine := Copy(ALine,2,Length(ALine));
      lPos := 0;
      lQuery.Active := False;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('SELECT * FROM ' + ARegistro);
      //lQuery.Active := True;
      lQuery.Insert;
      lQuery.Fields[1].AsInteger := AId;
      while Length(lLine) > 0 do
      begin
        lConteudo := '';
        lConteudo := Copy(lLine,1,(Pos('|',lLine)-1));
        lPos      := (lPos + 1);
        lQuery.Fields[lPos+1].AsString := lConteudo;
        lLine     := Copy(lLine,(Pos('|',lLine)+1),Length(lLine));
      end;

      if AId_Pai > 0 then
        lQuery.Fields[lQuery.Fields.Count-1].AsInteger := AId_Pai;

      lQuery.Post;

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

procedure TfrmPrincipal.ThreadEnd_Prepara(Sender :TObject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)

end;

procedure TfrmPrincipal.rctSelecionarClick(Sender: TObject);
var
  t :TThread;
begin
  TLoading.Show(frmPrincipal, 'Listando registros');
  t := TThread.CreateAnonymousThread(
  procedure
  begin
    TLoading.ChangeText('Listando registros');
    TThread.Synchronize(nil, procedure
    begin
      memoRegistros.Lines.LoadFromFile(edArquivo.Text);
    end);
  end);

  t.OnTerminate := ThreadEnd_Seleciona;
  t.Start;
end;

procedure TfrmPrincipal.ThreadEnd_Seleciona(Sender :TObject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
end;

end.
