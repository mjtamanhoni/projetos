unit uServicosPrestadosWeb;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, 
  Vcl.WebBrowser, Data.DB, System.JSON;

type
  TFormServicosPrestadosWeb = class(TForm)
    WebBrowser: TWebBrowser;
    DataSource: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
  private
    procedure AtualizarGrid;
    function DataSetParaJSON: string;
  public
    procedure EditarRegistro(const ID: Integer);
    procedure ExcluirRegistro(const ID: Integer);
  end;

implementation

{$R *.dfm}

procedure TFormServicosPrestadosWeb.FormCreate(Sender: TObject);
var
  HTMLPath: string;
begin
  HTMLPath := ExtractFilePath(Application.ExeName) + 'templates\servicosPrestados.html';
  WebBrowser.Navigate('file://' + HTMLPath);
end;

procedure TFormServicosPrestadosWeb.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  AtualizarGrid;
end;

procedure TFormServicosPrestadosWeb.AtualizarGrid;
var
  JsonData: string;
begin
  JsonData := DataSetParaJSON;
  WebBrowser.ExecScript('atualizarGrid(' + JsonData + ')');
end;

function TFormServicosPrestadosWeb.DataSetParaJSON: string;
var
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
begin
  JsonArray := TJSONArray.Create;
  try
    DataSource.DataSet.First;
    while not DataSource.DataSet.Eof do
    begin
      JsonObj := TJSONObject.Create;
      // Adapte os campos conforme sua tabela
      JsonObj.AddPair('id', DataSource.DataSet.FieldByName('ID').AsString);
      JsonObj.AddPair('descricao', DataSource.DataSet.FieldByName('DESCRICAO').AsString);
      JsonObj.AddPair('data', DataSource.DataSet.FieldByName('DATA').AsString);
      JsonObj.AddPair('valor', DataSource.DataSet.FieldByName('VALOR').AsString);
      
      JsonArray.AddElement(JsonObj);
      DataSource.DataSet.Next;
    end;
    Result := JsonArray.ToString;
  finally
    JsonArray.Free;
  end;
end;

procedure TFormServicosPrestadosWeb.EditarRegistro(const ID: Integer);
begin
  // Chame aqui sua função original de edição
end;

procedure TFormServicosPrestadosWeb.ExcluirRegistro(const ID: Integer);
begin
  // Chame aqui sua função original de exclusão
end;

end. 