unit ExemploUso;

interface

uses
  uPublicSchema, uCadSchema, uMovSchema, FireDAC.Comp.Client,
  System.Generics.Collections, System.Variants;

procedure ExemploDeUso;

implementation

procedure ExemploDeUso;
var
  Conexao: TFDConnection;
  TelasProjetos: TTelasProjetos;
  Clientes: TClientes;
  Vendas: TVendas;
  Campos: TDictionary<string, Variant>;
  Filtros: TDictionary<string, Variant>;
  Resultado: TFDQuery;
begin
  // Assumindo que a conexão já está configurada
  Conexao := TFDConnection.Create(nil);
  
  try
    // Exemplo com esquema PUBLIC
    TelasProjetos := TTelasProjetos.Create(Conexao);
    try
      // Criar tabela
      TelasProjetos.CreateTable;
      
      // Inserir registro
      Campos := TDictionary<string, Variant>.Create;
      try
        Campos.Add('nome', 'Tela Principal');
        Campos.Add('descricao', 'Tela principal do sistema');
        TelasProjetos.Insert(Campos);
      finally
        Campos.Free;
      end;
      
      // Consultar registros
      Filtros := TDictionary<string, Variant>.Create;
      try
        Filtros.Add('ativo', True);
        Resultado := TelasProjetos.Select(Filtros, 'nome');
        try
          // Processar resultado
        finally
          Resultado.Free;
        end;
      finally
        Filtros.Free;
      end;
      
    finally
      TelasProjetos.Free;
    end;
    
    // Exemplo similar para outros esquemas...
    
  finally
    Conexao.Free;
  end;
end;

end.