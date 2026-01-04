unit ExcelWebViewer;

interface

uses
  System.SysUtils, System.NetEncoding,
  Vcl.Controls, Vcl.Edge;

type
  TExcelWebViewer = class
  public
    // Mostra o Excel via Office Online (URL público do arquivo .xlsx/.xls)
    class function Show(AParent: TWinControl; const PublicUrl: string): TEdgeBrowser;
  end;

implementation

class function TExcelWebViewer.Show(AParent: TWinControl; const PublicUrl: string): TEdgeBrowser;
var
  ViewerUrl: string;
begin
  Result := TEdgeBrowser.Create(AParent);
  Result.Parent := AParent;
  Result.Align := alClient;

  ViewerUrl := 'https://view.officeapps.live.com/op/view.aspx?src=' +
               TNetEncoding.URL.Encode(PublicUrl);
  Result.Navigate(ViewerUrl);
end;

end.