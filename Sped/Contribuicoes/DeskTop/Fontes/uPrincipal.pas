unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils, System.Math,

  {$Region '99 Coders'}
    uLoading,
    uFancyDialog,
  {$EndRegion '99 Coders}

  uDm,
  uRegistros,
  uFuncoes,

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
    lytAbatePisCofins: TLayout;
    rctAbatePisCofins: TRectangle;
    lbAbatePisCofins: TLabel;
    lytGerar: TLayout;
    rctGerar: TRectangle;
    lbGerar: TLabel;
    memoNovo: TMemo;
    lbTitulo: TLabel;
    lytFechar: TLayout;
    imgFechar: TImage;
    lytMenu: TLayout;
    imgMenu: TImage;
    lytVersao: TLayout;
    rctVersao: TRectangle;
    lbVersao: TLabel;
    imgSelArquivo: TImage;
    OpenDialog: TOpenDialog;
    procedure rctSelecionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rctPrepararClick(Sender: TObject);
    procedure rctAbatePisCofinsClick(Sender: TObject);
    procedure rctGerarClick(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure imgSelArquivoClick(Sender: TObject);
    procedure edArquivoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
    procedure edArquivoTyping(Sender: TObject);
    procedure edNovoArquivoTyping(Sender: TObject);
  private
    FMensagem :TFancyDialog;
    lDm :TdmSpedContribuicoes;

    procedure ThreadEnd_Seleciona(Sender: TObject);
    procedure PrepararArquivo;
    procedure ThreadEnd_Prepara(Sender: TObject);
    procedure Insere_Registro(const ALine,ARegistro: String; const AId: Integer; AId_Pai: Integer=0);
    procedure Abate_ICMS_Base_PIS_COFINS;
    procedure ThreadEnd_AbatePisCofins(Sender: TOBject);
    function AlterarRegistro(const ARegistro:String):Boolean;
    procedure ThreadEnd_Gerar(Sender: TObject);
    procedure Montar_Linha(AQuery: TFDQuery);
    procedure Montar_Linha_1(AQuery: TFDQuery);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.Abate_ICMS_Base_PIS_COFINS;
var
  t :TThread;
begin
  TLoading.Show(frmPrincipal, 'Abante ICMS PIS e COFINS');
  t := TThread.CreateAnonymousThread(
  procedure
  var
    lQuery_100 :TFDQuery;
    lQuery_170 :TFDQuery;
    lQuery_175 :TFDQuery;
    lUpdate :TFDQuery;
    lPis :Double;
    lCofins :Double;
    lIcms :Double;
    lBase :Double;
    lValor :Double;
    lAliq :Double;
    lId100 :Integer;

  begin
    lQuery_100 := TFDQuery.Create(Nil);
    lQuery_100.Connection := lDm.FDC_Sped;

    lQuery_170 := TFDQuery.Create(Nil);
    lQuery_170.Connection := lDm.FDC_Sped;

    lQuery_175 := TFDQuery.Create(Nil);
    lQuery_175.Connection := lDm.FDC_Sped;

    lUpdate := TFDQuery.Create(Nil);
    lUpdate.Connection := lDm.FDC_Sped;

    lQuery_100.Active := False;
    lQuery_100.Sql.Clear;
    lQuery_100.Sql.Add('SELECT * FROM REGISTRO_C100 ORDER BY ID');
    lQuery_100.Active := True;
    if not lQuery_100.ISEmpty then
    begin
      lQuery_100.First;

      while not lQuery_100.Eof do
      begin
        lPis := 0;
        lCofins := 0;
        lId100 := 0;
        lId100 := lQuery_100.FieldByName('ID').AsInteger;

        if lQuery_100.FieldByName('IND_EMIT').AsString <> '1' then
        begin
          lQuery_170.Active := False;
          lQuery_170.SQL.Clear;
          lQuery_170.SQL.Add('SELECT * FROM REGISTRO_C170 WHERE ID_C100 = ' + IntToStr(lQuery_100.FieldByName('ID').AsInteger));
          lQuery_170.Active := True;
          if not lQuery_170.IsEmpty then
          begin
            lQuery_170.First;
            while not lQuery_170.Eof do
            begin
              TThread.Synchronize(nil, procedure
              begin
                TLoading.ChangeText('C100 ' + lQuery_100.FieldByName('ID').AsString + ', C170 ' + lQuery_170.FieldByName('ID').AsString );
              end);
              if ((lQuery_170.FieldByName('CFOP').AsString <> '5202') and (lQuery_170.FieldByName('CFOP').AsString <> '6202')) then
              begin
                lICMS  := 0;
                lBase  := 0;
                lValor := 0;
                lAliq  := 0;

                {PIS}
                lICMS  := StrToFloatDef(lQuery_100.FieldByName('VL_ICMS').AsString,0);
                lBase  := StrToFloatDef(lQuery_170.FieldByName('VL_BC_PIS').AsString,0);
                if lBase > 0 then
                begin
                  if lBase > lICMS then
                  begin
                    lBase  := RoundTo((lBase - lICMS),-2);
                    lAliq  := StrToFloatDef(lQuery_170.FieldByName('ALIQ_PIS').AsString,0);
                    lValor := RoundTo(((lBase * lAliq) / 100),-2);
                    lUpdate.Active := False;
                    lUpdate.SQL.Clear;
                    lUpdate.SQL.Add('UPDATE REGISTRO_C170 SET');
                    lUpdate.SQL.Add('  VL_BC_PIS = :VL_BC_PIS');
                    lUpdate.SQL.Add('  ,VL_PIS = :VL_PIS');
                    lUpdate.SQL.Add('WHERE ID = :ID');
                    lUpdate.SQL.Add('  AND ID_C100 = :ID_C100');
                    lUpdate.ParamByName('ID').AsInteger := lQuery_170.FieldByName('ID').AsInteger;
                    lUpdate.ParamByName('ID_C100').AsInteger := lQuery_170.FieldByName('ID_C100').AsInteger;
                    lUpdate.ParamByName('VL_BC_PIS').AsString := FloatToStr(lBase);
                    lUpdate.ParamByName('VL_PIS').AsString := FloatToStr(lValor);
                    lUpdate.ExecSQL;
                    lPis := (lPis + lValor);
                  end;
                end;

                {COFINS}
                lICMS  := 0;
                lBase  := 0;
                lValor := 0;
                lAliq  := 0;

                lICMS  := StrToFloatDef(lQuery_100.FieldByName('VL_ICMS').AsString,0);
                lBase  := StrToFloatDef(lQuery_170.FieldByName('VL_BC_COFINS').AsString,0);
                if lBase > 0 then
                begin
                  if lBase > lICMS then
                  begin
                    lBase  := RoundTo((lBase - lICMS),-2);
                    lAliq  := StrToFloatDef(lQuery_170.FieldByName('ALIQ_COFINS').AsString,0);
                    lValor := RoundTo(((lBase * lAliq) / 100),-2);

                    lUpdate.Active := False;
                    lUpdate.SQL.Clear;
                    lUpdate.SQL.Add('UPDATE REGISTRO_C170 SET');
                    lUpdate.SQL.Add('  VL_BC_COFINS = :VL_BC_COFINS');
                    lUpdate.SQL.Add('  ,VL_COFINS = :VL_COFINS');
                    lUpdate.SQL.Add('WHERE ID = :ID');
                    lUpdate.SQL.Add('  AND ID_C100 = :ID_C100');
                    lUpdate.ParamByName('ID').AsInteger := lQuery_170.FieldByName('ID').AsInteger;
                    lUpdate.ParamByName('ID_C100').AsInteger := lQuery_170.FieldByName('ID_C100').AsInteger;
                    lUpdate.ParamByName('VL_BC_COFINS').AsString := FloatToStr(lBase);
                    lUpdate.ParamByName('VL_COFINS').AsString := FloatToStr(lValor);
                    lUpdate.ExecSQL;
                    lCofins := (lCofins + lValor);
                  end;
                end;
              end;
              lQuery_170.Next;
            end;
          end;

          lQuery_175.Active := False;
          lQuery_175.SQL.Clear;
          lQuery_175.SQL.Add('SELECT * FROM REGISTRO_C175 WHERE ID_C100 = ' + IntToStr(lQuery_100.FieldByName('ID').AsInteger));
          lQuery_175.Active := True;
          if not lQuery_175.IsEmpty then
          begin
            lQuery_175.First;
            while not lQuery_175.Eof do
            begin
              TThread.Synchronize(nil, procedure
              begin
                TLoading.ChangeText('C100 ' + lQuery_100.FieldByName('ID').AsString + ', C175 ' + lQuery_175.FieldByName('ID').AsString );
              end);
              if ((lQuery_175.FieldByName('CFOP').AsString <> '5202') and (lQuery_175.FieldByName('CFOP').AsString <> '6202')) then
              begin
                lICMS     := 0;
                lBase     := 0;
                lValor    := 0;
                lAliq     := 0;
                {PIS}
                lICMS  := StrToFloatDef(lQuery_100.FieldByName('VL_ICMS').AsString,0);
                lBase  := StrToFloatDef(lQuery_175.FieldByName('VL_BC_PIS').AsString,0);
                if lBase > 0 then
                begin
                  if lBase > lICMS then
                  begin
                    lBase  := RoundTo((lBase - lICMS),-2);
                    lAliq  := StrToFloatDef(lQuery_175.FieldByName('ALIQ_PIS').AsString,0);
                    lValor := RoundTo(((lBase * lAliq) / 100),-2);

                    lUpdate.Active := False;
                    lUpdate.SQL.Clear;
                    lUpdate.SQL.Add('UPDATE REGISTRO_C175 SET');
                    lUpdate.SQL.Add('  VL_BC_PIS = :VL_BC_PIS');
                    lUpdate.SQL.Add('  ,VL_PIS = :VL_PIS');
                    lUpdate.SQL.Add('WHERE ID = :ID');
                    lUpdate.SQL.Add('  AND ID_C100 = :ID_C100');
                    lUpdate.ParamByName('ID').AsInteger := lQuery_175.FieldByName('ID').AsInteger;
                    lUpdate.ParamByName('ID_C100').AsInteger := lQuery_175.FieldByName('ID_C100').AsInteger;
                    lUpdate.ParamByName('VL_BC_PIS').AsString := FloatToStr(lBase);
                    lUpdate.ParamByName('VL_PIS').AsString := FloatToStr(lValor);
                    lUpdate.ExecSQL;

                    lPis := (lPis + lValor);
                  end;
                end;

                {COFINS}
                lICMS  := 0;
                lBase  := 0;
                lValor := 0;
                lAliq  := 0;

                lICMS  := StrToFloatDef(lQuery_100.FieldByName('VL_ICMS').AsString,0);
                lBase  := StrToFloatDef(lQuery_175.FieldByName('VL_BC_COFINS').AsString,0);
                if lBase > 0 then
                begin
                  if lBase > lICMS then
                  begin
                    lBase  := RoundTo((lBase - lICMS),-2);
                    lAliq  := StrToFloatDef(lQuery_175.FieldByName('ALIQ_COFINS').AsString,0);
                    lValor := RoundTo(((lBase * lAliq) / 100),-2);

                    lUpdate.Active := False;
                    lUpdate.SQL.Clear;
                    lUpdate.SQL.Add('UPDATE REGISTRO_C175 SET');
                    lUpdate.SQL.Add('  VL_BC_COFINS = :VL_BC_COFINS');
                    lUpdate.SQL.Add('  ,VL_COFINS = :VL_COFINS');
                    lUpdate.SQL.Add('WHERE ID = :ID');
                    lUpdate.SQL.Add('  AND ID_C100 = :ID_C100');
                    lUpdate.ParamByName('ID').AsInteger := lQuery_175.FieldByName('ID').AsInteger;
                    lUpdate.ParamByName('ID_C100').AsInteger := lQuery_175.FieldByName('ID_C100').AsInteger;
                    lUpdate.ParamByName('VL_BC_COFINS').AsString := FloatToStr(lBase);
                    lUpdate.ParamByName('VL_COFINS').AsString := FloatToStr(lValor);
                    lUpdate.ExecSQL;

                    lCofins := (lCofins + lValor);
                  end;
                end;
              end;
              lQuery_175.Next;
            end;
          end;

          if ((lQuery_100.FieldByName('COD_SIT').AsString = '02') or (lQuery_100.FieldByName('COD_SIT').AsString = '05')) then
          begin
            lUpdate.Active := False;
            lUpdate.SQL.Clear;
            lUpdate.SQL.Add('UPDATE REGISTRO_C100 SET');
            lUpdate.SQL.Add('  VL_PIS = :VL_PIS');
            lUpdate.SQL.Add('  ,VL_COFINS = :VL_COFINS');
            lUpdate.SQL.Add('WHERE ID = :ID');
            lUpdate.ParamByName('ID').AsInteger := lQuery_100.FieldByName('ID').AsInteger;
            lUpdate.ParamByName('VL_PIS').AsString := '';
            lUpdate.ParamByName('VL_COFINS').AsString := '';
            lUpdate.ExecSQL;
          end
          else
          begin
            lPis := RoundTo(lPis,-2);
            lCofins := RoundTo(lCofins,-2);
            lUpdate.Active := False;
            lUpdate.SQL.Clear;
            lUpdate.SQL.Add('UPDATE REGISTRO_C100 SET');
            lUpdate.SQL.Add('  VL_PIS = :VL_PIS');
            lUpdate.SQL.Add('  ,VL_COFINS = :VL_COFINS');
            lUpdate.SQL.Add('WHERE ID = :ID');
            lUpdate.ParamByName('ID').AsInteger := lQuery_100.FieldByName('ID').AsInteger;
            lUpdate.ParamByName('VL_PIS').AsString := FloatToStr(lPis);
            lUpdate.ParamByName('VL_COFINS').AsString := FloatToStr(lCofins);
            lUpdate.ExecSQL;
          end;
        end;

        lQuery_100.Next;
      end;
    end;

    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery_100);
      FreeAndNil(lQuery_170);
      FreeAndNil(lQuery_175);
      FreeAndNil(lUpdate);
    {$ELSE}
      lQuery_100.DisposeOf;
      lQuery_170.DisposeOf;
      lQuery_175.DisposeOf;
      lUpdate.DisposeOf;
    {$ENDIF}

  end);

  t.OnTerminate := ThreadEnd_AbatePisCofins;
  t.Start;

end;

procedure TfrmPrincipal.ThreadEnd_AbatePisCofins(Sender :TOBject);
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
    FMensagem.Show(TIconDialog.Success,'Atenção','Valores abatidos','Ok');
end;

function TfrmPrincipal.AlterarRegistro(const ARegistro: String): Boolean;
begin
end;

procedure TfrmPrincipal.edArquivoKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
  if Key = vkReturn then
    TFuncoes.PularCampo(edNovoArquivo);
end;

procedure TfrmPrincipal.edArquivoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edArquivo,lbArquivo,faArquivo,10,-20);
end;

procedure TfrmPrincipal.edNovoArquivoTyping(Sender: TObject);
begin
  TFuncoes.ExibeLabel(edNovoArquivo,lbNovoArquivo,faNovoArquivo,10,-20);
end;

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

procedure TfrmPrincipal.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.imgSelArquivoClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    OpenDialog.InitialDir := System.SysUtils.GetCurrentDir;
  {$ELSE}
    OpenDialog.InitialDir := TPath.GetDocumentsPath;
  {$ENDIF}

  OpenDialog.Filter := 'Arquivos do Sped|*.txt';
  if OpenDialog.Execute then
  begin
    if FileExists(OpenDialog.FileName) then
    begin
      edArquivo.Text := OpenDialog.FileName;
      TFuncoes.ExibeLabel(edArquivo,lbArquivo,faArquivo,10,-20);
    end
    else
      TFuncoes.ExibeLabel(edArquivo,lbArquivo,faArquivo,10,-20);
  end;    
end;

procedure TfrmPrincipal.rctAbatePisCofinsClick(Sender: TObject);
begin
  Abate_ICMS_Base_PIS_COFINS;
end;

procedure TfrmPrincipal.rctGerarClick(Sender: TObject);
var
  t :TThread;
begin
  memoNovo.Lines.Clear;
  TLoading.Show(frmPrincipal, 'Gerando novo arquivo texto');
  t := TThread.CreateAnonymousThread(
  procedure
  var
    I :Integer;
    lId_C100 :Integer;
    lId_M400 :Integer;
    lId_M800 :Integer;
    lQuery_01 :TFDQuery;
    lQuery_02 :TFDQuery;
    lLinha :String;
  begin
    lQuery_01 := TFDQuery.Create(Nil);
    lQuery_01.Connection := lDm.FDC_Sped;
    lQuery_02 := TFDQuery.Create(Nil);
    lQuery_02.Connection := lDm.FDC_Sped;

    lLinha := '';
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0000 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin      
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0000] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0100 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0100] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0110 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0110] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0140 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0140] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0150 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0150] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0190 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0190] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0200 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0200] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0400 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0400] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0500 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0500] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_0990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [0990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_A001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [A001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_A010 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [A010] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_A990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [A990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_C001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [C001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_C010 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [C010] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_C100 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [C100] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        
        //listando C170
        lQuery_02.Active := False;
        lQuery_02.Sql.Clear;
        lQuery_02.Sql.Add('SELECT * FROM REGISTRO_C170 WHERE ID_C100 = '+lQuery_01.FieldByName('ID').AsString+' ORDER BY ID');
        lQuery_02.Active := True;
        if not lQuery_02.IsEmpty then
        begin
          lQuery_02.First;
          while not lQuery_02.Eof do
          begin
            TThread.Synchronize(nil, procedure
            begin
              TLoading.ChangeText('Gerando Registro [C170] - ' + lQuery_01.RecNo.ToString);
            end);
            Montar_Linha_1(lQuery_02);
            lQuery_02.Next;
          end;
        end;
        
        //listando C175
        lQuery_02.Active := False;
        lQuery_02.Sql.Clear;
        lQuery_02.Sql.Add('SELECT * FROM REGISTRO_C175 WHERE ID_C100 = '+lQuery_01.FieldByName('ID').AsString+' ORDER BY ID');
        lQuery_02.Active := True;
        if not lQuery_02.IsEmpty then
        begin
          lQuery_02.First;
          while not lQuery_02.Eof do
          begin
            TThread.Synchronize(nil, procedure
            begin
              TLoading.ChangeText('Gerando Registro [C175] - ' + lQuery_01.RecNo.ToString);
            end);
            Montar_Linha_1(lQuery_02);
            lQuery_02.Next;
          end;
        end;        
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_C500 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [C500] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_C501 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [C501] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_C505 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [C505] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_C990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [C990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_D001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [D001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_D010 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [D010] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_D990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [D990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_F001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [F001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_F010 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [F010] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_F100 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [F100] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_F990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [F990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_I001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [I001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_I990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [I990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M100 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M100] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M105 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M105] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M110 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M110] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M200 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M200] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M205 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M205] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M210 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M210] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M400 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M400] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        
        //listando M410
        lQuery_02.Active := False;
        lQuery_02.Sql.Clear;
        lQuery_02.Sql.Add('SELECT * FROM REGISTRO_M410 WHERE ID_M400 = '+lQuery_01.FieldByName('ID').AsString+' ORDER BY ID');
        lQuery_02.Active := True;
        if not lQuery_02.IsEmpty then
        begin
          lQuery_02.First;
          while not lQuery_02.Eof do
          begin
            TThread.Synchronize(nil, procedure
            begin
              TLoading.ChangeText('Gerando Registro [M400] - ' + lQuery_01.RecNo.ToString);
            end);
            Montar_Linha_1(lQuery_02);
            lQuery_02.Next;
          end;
        end;
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M500 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M500] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M505 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M505] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M510 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M510] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M600 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M600] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M605 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M605] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M610 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M610] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M800 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M800] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        
        //listando M410
        lQuery_02.Active := False;
        lQuery_02.Sql.Clear;
        lQuery_02.Sql.Add('SELECT * FROM REGISTRO_M810 WHERE ID_M800 = '+lQuery_01.FieldByName('ID').AsString+' ORDER BY ID');
        lQuery_02.Active := True;
        if not lQuery_02.IsEmpty then
        begin
          lQuery_02.First;
          while not lQuery_02.Eof do
          begin
            TThread.Synchronize(nil, procedure
            begin
              TLoading.ChangeText('Gerando Registro [M400] - ' + lQuery_01.RecNo.ToString);
            end);
            Montar_Linha_1(lQuery_02);
            lQuery_02.Next;
          end;
        end;
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_M990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [M990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_P001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [P001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_P990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [P990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_1001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [1001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_1100 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [1100] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_1500 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [1500] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_1990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [1990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_9001 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [9001] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_9900 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [9900] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_9990 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [9990] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    lQuery_01.Active := False;
    lQuery_01.Sql.Clear;
    lQuery_01.Sql.Add('SELECT * FROM REGISTRO_9999 ORDER BY ID');
    lQuery_01.Active := True;
    if not lQuery_01.IsEmpty then
    begin
      lQuery_01.First;
      while not lQuery_01.Eof do
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Gerando Registro [9999] - ' + lQuery_01.RecNo.ToString);
        end);
        Montar_Linha(lQuery_01);
        lQuery_01.Next;
      end;
    end;
    

    {$IFDEF MSWINDOWS}
      FreeAndNil(lQuery_01);
      FreeAndNil(lQuery_02);
    {$ELSE}
      lQuery_01.DisposeOf;
      lQuery_02.DisposeOf;
    {$ENDIF}

  end);

  t.OnTerminate := ThreadEnd_Gerar;
  t.Start;

end;

procedure TfrmPrincipal.ThreadEnd_Gerar(Sender :TObject);
var
  FEnder :String;
begin
  TLoading.Hide;

  if Assigned(TThread(Sender).FatalException) then
    FMensagem.Show(TIconDialog.Error,'Erro',Exception(TThread(Sender).FatalException).Message)
  else
  begin
    FEnder  := '';
    {$IFDEF MSWINDOWS}
      FEnder := System.SysUtils.GetCurrentDir + '\Arquivo\' + edNovoArquivo.Text;
    {$ELSE}
      FEnder := TPath.GetDocumentsPath;
    {$ENDIF}
    memoNovo.Lines.Add('');
    memoNovo.Lines.SaveToFile(FEnder);
    FMensagem.Show(TIconDialog.Success,'Atenção','Arquivo gerado','Ok');    
  end;
end;

procedure TfrmPrincipal.Montar_Linha(AQuery :TFDQuery);
var
  lLinha :String;
  I :Integer;
begin
  try
    try
      for I := 1 to (AQuery.Fields.Count-1) do
      begin
        if ((AQuery.Fields[I].IsNull) or (Trim(AQuery.Fields[I].AsString) = '')) then
          lLinha := lLinha + '|' + ''
        else
          lLinha := lLinha + '|' + Trim(AQuery.Fields[I].AsString);
      end;
      lLinha := lLinha + '|';
      memoNovo.Lines.Add(lLinha);
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
end;

procedure TfrmPrincipal.Montar_Linha_1(AQuery :TFDQuery);
var
  lLinha :String;
  I :Integer;
begin
  try
    try
      for I := 2 to (AQuery.Fields.Count-1) do
      begin
        if ((AQuery.Fields[I].IsNull) or (Trim(AQuery.Fields[I].AsString) = '')) then
          lLinha := lLinha + '|' + ''
        else
          lLinha := lLinha + '|' + Trim(AQuery.Fields[I].AsString);
      end;
      lLinha := lLinha + '|';
      memoNovo.Lines.Add(lLinha);
    except on E: Exception do
      raise Exception.Create(E.Message);
    end;
  finally
  end;
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
    lId_M800 :Integer;
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
    TRegistro_Geral.Excluir_RegM605(lDm);
    TRegistro_Geral.Excluir_RegM610(lDm);
    TRegistro_Geral.Excluir_RegM800(lDm);
    TRegistro_Geral.Excluir_RegM810(lDm);
    TRegistro_Geral.Excluir_RegM990(lDm);
    TRegistro_Geral.Excluir_RegP001(lDm);
    TRegistro_Geral.Excluir_RegP990(lDm);
    TRegistro_Geral.Excluir_Reg1001(lDm);
    TRegistro_Geral.Excluir_Reg1100(lDm);
    TRegistro_Geral.Excluir_Reg1500(lDm);
    TRegistro_Geral.Excluir_Reg1990(lDm);
    TRegistro_Geral.Excluir_Reg9001(lDm);
    TRegistro_Geral.Excluir_Reg9900(lDm);
    TRegistro_Geral.Excluir_Reg9990(lDm);
    TRegistro_Geral.Excluir_Reg9999(lDm);

    lCount := 0;
    lCount := (memoRegistros.Lines.Count - 1);
    lId_C100 := 0;
    lId_M400 := 0;
    lId_M800 := 0;
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
        TRegistro_M410.Insert(lDm,memoRegistros.Lines.Strings[I],I,lId_M400);
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
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M605|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M605] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M605.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M610|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M610] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M610.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M800|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M800] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M800.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
        lId_M800 := I;
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M810|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M810] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M810.Insert(lDm,memoRegistros.Lines.Strings[I],I,lId_M800);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|M990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [M990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_M990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|P001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [P001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_P001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|P990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [P990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_P990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|1001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [1001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_1001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|1100|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [1100] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_1100.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|1500|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [1500] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_1500.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|1990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [1990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_1990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|9001|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [9001] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_9001.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|9900|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [9900] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_9900.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|9990|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [9990] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_9990.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
      end;
      if Copy(memoRegistros.Lines.Strings[I],1,6) = '|9999|' then
      begin
        TThread.Synchronize(nil, procedure
        begin
          TLoading.ChangeText('Registro [9999] + ' + I.ToString + ' de ' + lCount.ToString);
        end);
        TRegistro_9999.Insert(lDm,memoRegistros.Lines.Strings[I],I,0);
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
  else
    FMensagem.Show(TIconDialog.Success,'Atenção','Arquivo preparado','Ok');

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
