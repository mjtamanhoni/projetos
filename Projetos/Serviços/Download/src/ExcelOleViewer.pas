unit ExcelOleViewer;

interface

uses
  System.SysUtils, System.Classes, System.Win.ComObj,
  Vcl.OleCtnrs, Vcl.Controls,
  System.Variants;

type
  TExcelOleViewer = class
  public
    // Verifica se o Excel está instalado tentando criar o COM e encerrando em seguida
    class function IsExcelInstalled: Boolean;
    // Mostra o arquivo do Excel dentro do controle container
    class function Show(AParent: TWinControl; const FileName: string; AllowEdit: Boolean = True): TOleContainer;
    // Fecha e libera o container
    class procedure Close(var Container: TOleContainer);
  end;

implementation

uses
  Vcl.Forms;

class function TExcelOleViewer.IsExcelInstalled: Boolean;
var
  Excel: OleVariant;
begin
  try
    Excel := CreateOleObject('Excel.Application');
    try
      Excel.Quit;
    except
    end;
    VarClear(Excel); // libera o Variant COM com segurança
    Result := True;
  except
    Result := False;
  end;
end;

class function TExcelOleViewer.Show(AParent: TWinControl; const FileName: string; AllowEdit: Boolean): TOleContainer;
begin
  if not FileExists(FileName) then
    raise Exception.Create('Arquivo não encontrado: ' + FileName);

  Result := TOleContainer.Create(AParent);
  Result.Parent := AParent;
  Result.Align := alClient;
  Result.AllowInPlace := AllowEdit;
  Result.BorderStyle := bsSingle;

  // carrega e apresenta o workbook
  Result.CreateObjectFromFile(FileName, False);
  Result.DoVerb(ovShow);
end;

class procedure TExcelOleViewer.Close(var Container: TOleContainer);
begin
  if Assigned(Container) then
  begin
    try
      Container.DestroyObject;
    except
      // ignora qualquer erro ao destruir o objeto OLE
    end;
    Container.Free;
    Container := nil;
  end;
end;

end.