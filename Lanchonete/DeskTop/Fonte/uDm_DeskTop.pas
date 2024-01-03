unit uDm_DeskTop;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, System.JSON,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  IniFiles,
  uFuncoes,

  DataSet.Serialize,
  RESTRequest4D;

const
  C_URL_VIA_CEP = 'http://viacep.com.br/ws/';

type
  TStatusTable = (stList,stInsert,stUpdate,stDelete);

  TDm_DeskTop = class(TDataModule)
    FDMem_Usuarios: TFDMemTable;
    FDMem_UsuariosID: TIntegerField;
    FDMem_UsuariosNOME: TStringField;
    FDMem_UsuariosSTATUS: TIntegerField;
    FDMem_UsuariosTIPO: TIntegerField;
    FDMem_UsuariosLOGIN: TStringField;
    FDMem_UsuariosSENHA: TStringField;
    FDMem_UsuariosPIN: TIntegerField;
    FDMem_UsuariosTOKEN: TStringField;
    FDMem_UsuariosEMAIL: TStringField;
    FDMem_UsuariosCELULAR: TStringField;
    FDMem_UsuariosCLASSIFICACAO: TIntegerField;
    FDMem_UsuariosLOGRADOURO: TStringField;
    FDMem_UsuariosNUMERO: TIntegerField;
    FDMem_UsuariosCOMPLEMENTO: TStringField;
    FDMem_UsuariosBAIRRO: TStringField;
    FDMem_UsuariosIBGE: TIntegerField;
    FDMem_UsuariosMUNICIPIO: TStringField;
    FDMem_UsuariosUF_SIGLA: TStringField;
    FDMem_UsuariosUF: TStringField;
    FDMem_UsuariosFOTO: TBlobField;
    FDMem_UsuariosID_FUNCIONARIO: TIntegerField;
    FDMem_UsuariosPUSH_NOTIFICATION: TStringField;
    FDMem_UsuariosORIGEM_TIPO: TIntegerField;
    FDMem_UsuariosORIGEM_DESCRICAO: TStringField;
    FDMem_UsuariosORIGEM_CODIGO: TIntegerField;
    FDMem_UsuariosDT_CADASTRO: TDateField;
    FDMem_UsuariosHR_CADASTRO: TTimeField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIniFile :TIniFile;
    FEnder :String;
    lEnder_Ini :String;
    FConexao :String;

  public

    {$Region 'Servidor'}
      {$Region 'Usuários'}
        function LoginWeb(
          const APin:String='';
          const AUsuario:String='';
          const ASenha:String=''):Boolean;

        function Usuario_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ANome:String='';
          const APIN:String='';
          const AEmail:String=''): TJSONArray;

        function Usuario_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Usuario_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'Usuários'}

      {$Region 'Paises'}
        function Paises_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ANome:String=''): TJSONArray;

        function Paises_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Paises_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'Paises'}

      {$Region 'Regiões'}
        function Regiao_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ANome:String=''): TJSONArray;

        function Regiao_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Regiao_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'Regiões'}

      {$Region 'UF'}
        function UF_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ARegiao:Integer=0;
          const ANome:String=''): TJSONArray;

        function UF_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function UF_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'UF'}

      {$Region 'Municípios'}
        function Municipios_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const AUF_Sigla:String='';
          const AIbge:String='';
          const ANome:String=''): TJSONArray;

        function Municipios_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Municipios_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'Municípios'}

      {$Region 'Empresa'}
        //Empresa...
        function Empresa_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ADocumento:String='';
          const ANome:String=''): TJSONArray;
        function Empresa_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Empresa_Excluir(const ACodigo:Integer=0):Boolean;

        //Endereço...
        function EmpresaEnd_Lista(
          const APagina:Integer=0;
          const ACodEmpresa:Integer=0;
          const AEndereco:Integer=0): TJSONArray;
        function EmpresaEnd_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function EmpresaEnd_Excluir(
          const ACodEmpresa :Integer=0;
          const ACodigo :Integer=0):Boolean;

        //Telefone...
        function EmpresaTel_Lista(
          const APagina:Integer=0;
          const ACodEmpresa:Integer=0;
          const ATelefone:Integer=0): TJSONArray;
        function EmpresaTel_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function EmpresaTEl_Excluir(
          const ACodEmpresa :Integer=0;
          const ACodigo :Integer=0):Boolean;

        //Email...
        function EmpresaEmail_Lista(
          const APagina:Integer=0;
          const ACodEmpresa:Integer=0;
          const AId:Integer=0;
          const ACodSetor:Integer=0;
          const ACodResponsavel:String='';
          const AEmail:String=''): TJSONArray;
        function EmpresaEmail_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function EmpresaEmail_Excluir(
          const ACodEmpresa :Integer=0;
          const ACodigo :Integer=0):Boolean;

      {$EndRegion 'Empresa'}

      {$Region 'Fornecedor'}
        function Fornecedor_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ADocumento:String='';
          const ANome:String=''): TJSONArray;

        function Fornecedor_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Fornecedor_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'Fornecedor'}

      {$Region 'Cliente'}
        function Cliente_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ADocumento:String='';
          const ANome:String=''): TJSONArray;

        function Cliente_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Cliente_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'Cliente'}

      {$Region 'Setor'}
        function Setor_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ANome:String=''): TJSONArray;

        function Setor_Cadastro(const AJson :TJSONArray;StatusTable:Integer):Boolean;
        function Setor_Excluir(const ACodigo:Integer=0):Boolean;
      {$EndRegion 'Setor'}


    {$EndRegion}

    {$Region 'Busca Cep'}
      function BuscaCep_Cep(
        const ACep:String): TJSONObject;
      function BuscaCep_Logradouro(
        const AUf :String;
        const AMunicipio :String;
        const ALogradouro :String): TJSONArray;
    {$EndRegion 'Busca Cep'}
  end;

var
  Dm_DeskTop: TDm_DeskTop;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDm_DeskTop }

function TDm_DeskTop.BuscaCep_Cep(
        const ACep:String): TJSONObject;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := C_URL_VIA_CEP + ACep + '/json';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizado o endereço do CEP informado...');

      Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONObject;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.BuscaCep_Logradouro(
        const AUf :String;
        const AMunicipio :String;
        const ALogradouro :String): TJSONArray;
begin

end;

function TDm_DeskTop.Cliente_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('cliente')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('cliente')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o Cliente...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um Cliente. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Cliente_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('cliente')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Cliente não localizada');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Cliente_Lista(const APagina, ACodigo: Integer;
  const ADocumento, ANome: String): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('cliente')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('documento',ADocumento)
             .AddParam('razaoSocial',ANome)
             .AddParam('nomeFantasia',ANome)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizadas os Clientes...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

procedure TDm_DeskTop.DataModuleCreate(Sender: TObject);
begin
  FEnder  := '';
  {$IFDEF MSWINDOWS}
    FEnder := System.SysUtils.GetCurrentDir;
    lEnder_Ini := FEnder + '\CONFIG_DESKTOP.ini';
  {$ELSE}
    FEnder := TPath.GetDocumentsPath;
    lEnder_Ini := TPath.Combine(FEnder,'CONFIG_DESKTOP.ini');
  {$ENDIF}
  FIniFile := TIniFile.Create(lEnder_Ini);
end;

function TDm_DeskTop.EmpresaEmail_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
      begin
        case StatusTable of
          0 :raise Exception.Create('Não há dados para ser cadastrado');
          1 :raise Exception.Create('Não há dados para ser alterado');
        end;
      end;

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa/email')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa/email')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o E-mail da Empresa...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um E-mail para Empresa. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaEmail_Excluir(const ACodEmpresa,
  ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa/email')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('empresaId',ACodEmpresa.ToString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('E-mail da Empresa não excluído');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaEmail_Lista(
  const APagina:Integer=0;
  const ACodEmpresa:Integer=0;
  const AId:Integer=0;
  const ACodSetor:Integer=0;
  const ACodResponsavel:String='';
  const AEmail:String=''): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa/email')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('idEmpresa',ACodEmpresa.ToString)
             .AddParam('id',AId.ToString)
             .AddParam('idSetor',ACodSetor.ToString)
             .AddParam('responsavel',ACodResponsavel)
             .AddParam('email',AEmail)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizado os E-mail da Empresa...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaEnd_Cadastro(const AJson :TJSONArray;StatusTable:Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa/endereco')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa/endereco')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o endereço da Empresa...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um endereço da Empresa. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaEnd_Excluir(
          const ACodEmpresa :Integer=0;
          const ACodigo :Integer=0): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa/endereco')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('empresaId',ACodEmpresa.ToString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Endereço da Empresa não excluído');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaEnd_Lista(
          const APagina:Integer=0;
          const ACodEmpresa:Integer=0;
          const AEndereco:Integer=0): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa/endereco')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('idEmpresa',ACodEmpresa.ToString)
             .AddParam('id',AEndereco.ToString)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizado os endereços das Empresas...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaTel_Cadastro(
  const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
      begin
        case StatusTable of
          0 :raise Exception.Create('Não há dados para ser cadastrados');
          1 :raise Exception.Create('Não há dados para ser alterado');
        end;
      end;

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa/telefones')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa/telefones')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o telefone/celular da Empresa...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um telefone/celular da Empresa. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaTEl_Excluir(const ACodEmpresa,
  ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa/telefones')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('empresaId',ACodEmpresa.ToString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Telefone/Celular da Empresa não excluído');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.EmpresaTel_Lista(
  const APagina, ACodEmpresa, ATelefone: Integer): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa/telefones')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('idEmpresa',ACodEmpresa.ToString)
             .AddParam('id',ATelefone.ToString)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizado os telefones da Empresa...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Empresa_Cadastro(const AJson: TJSONArray; StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('empresa')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o Empresa...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um Empresa. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Empresa_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Empresa não localizada');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Empresa_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const ADocumento:String='';
          const ANome:String=''): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('empresa')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('documento',ADocumento)
             .AddParam('nome',ANome)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizadas as Empresas...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Fornecedor_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('fornecedor')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('fornecedor')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o Fornecedor...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um Fornecedor. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Fornecedor_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('fornecedor')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Fornecedor não localizada');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Fornecedor_Lista(const APagina, ACodigo: Integer;
  const ADocumento, ANome: String): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('fornecedor')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('documento',ADocumento)
             .AddParam('razaoSocial',ANome)
             .AddParam('nomeFantasia',ANome)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizadas os Fornecedores...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.LoginWeb(
        const APin:String='';
        const AUsuario:String='';
        const ASenha:String=''): Boolean;
var
  lHost :String;
  lResp :IResponse;
  lJson :TJSONObject;
  lBody :TJSONValue;
  lTexto :String;

begin
  try
    Result := True;

    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    if APin = '' then
    begin
      if AUsuario = '' then
        raise Exception.Create('Necessário informar o nome ou o email do usuário...');
      if ASenha = '' then
        raise Exception.Create('Necessário informar senha do usuário...');
    end;

    lJson := TJSONObject.Create;
    lJson.AddPair('usuario',AUsuario);
    lJson.AddPair('senha',ASenha);
    lJson.AddPair('pin',APin);

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('usuario/login')
             .AddBody(lJson.ToJSON)
             .Accept('application/json')
             .Post;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não houve retorno no login');

      lBody := TJSONObject.ParseJSONValue(lResp.Content);
      FDMem_Usuarios.Active := False;
      FDMem_Usuarios.Active := True;
      FDMem_Usuarios.Insert;
        FDMem_UsuariosID.AsInteger := lBody.GetValue<Integer>('id',0);
        FDMem_UsuariosNOME.AsString := lBody.GetValue<string>('nome','');
        FDMem_UsuariosSTATUS.AsInteger := lBody.GetValue<Integer>('status',0);
        FDMem_UsuariosTIPO.AsInteger := lBody.GetValue<Integer>('tipo',2);
        FDMem_UsuariosLOGIN.AsString := lBody.GetValue<string>('login','');
        FDMem_UsuariosSENHA.AsString := lBody.GetValue<string>('senha','');
        FDMem_UsuariosPIN.AsString := lBody.GetValue<String>('pin','');
        FDMem_UsuariosTOKEN.AsString := lBody.GetValue<string>('tokenAuth','');
        FDMem_UsuariosEMAIL.AsString := lBody.GetValue<string>('email','');
        FDMem_UsuariosCELULAR.AsString := lBody.GetValue<string>('celular','');
        FDMem_UsuariosCLASSIFICACAO.AsInteger := lBody.GetValue<Integer>('classificacao',5);
        FDMem_UsuariosLOGRADOURO.AsString := lBody.GetValue<string>('logradouro','');
        FDMem_UsuariosNUMERO.AsInteger := lBody.GetValue<Integer>('numero',0);
        FDMem_UsuariosCOMPLEMENTO.AsString := lBody.GetValue<string>('complemento','');
        FDMem_UsuariosBAIRRO.AsString := lBody.GetValue<string>('bairro','');
        FDMem_UsuariosIBGE.AsInteger := lBody.GetValue<Integer>('ibge',0);
        FDMem_UsuariosMUNICIPIO.AsString := lBody.GetValue<string>('municipio','');
        FDMem_UsuariosUF_SIGLA.AsString := lBody.GetValue<string>('uf_sigla','');
        FDMem_UsuariosUF.AsString := lBody.GetValue<string>('uf','');
        FDMem_UsuariosFOTO.AsString := lBody.GetValue<string>('foto','');
        FDMem_UsuariosID_FUNCIONARIO.AsInteger := lBody.GetValue<Integer>('id_funcionario',0);
        FDMem_UsuariosPUSH_NOTIFICATION.AsString := lBody.GetValue<string>('push_notification','');
        FDMem_UsuariosORIGEM_TIPO.AsInteger := lBody.GetValue<Integer>('origem_tipo',0);
        FDMem_UsuariosORIGEM_DESCRICAO.AsString := lBody.GetValue<string>('origem_descricao','');
        FDMem_UsuariosORIGEM_CODIGO.AsInteger := lBody.GetValue<Integer>('origem_codigo',0);
        FDMem_UsuariosDT_CADASTRO.AsDateTime := Date;
        FDMem_UsuariosHR_CADASTRO.AsDateTime := Time;
      FDMem_Usuarios.Post;
      Result := True;
    end
    else if lResp.StatusCode = 204 then
    begin
      //Não há usuários cadastrados no banco de dados...
      Result := False;
    end
    else
    begin
      raise Exception.Create(lResp.Content);
    end;

  finally
    {$IFDEF MSWINDOWS}
      FreeAndNil(lJson);
    {$ELSE}
      lJson.DisposeOf;
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Municipios_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('municipios')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('municipios')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o Município...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um Município. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Municipios_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('municipios')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Município não localizada');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Municipios_Lista(
          const APagina:Integer=0;
          const ACodigo:Integer=0;
          const AUF_Sigla:String='';
          const AIbge:String='';
          const ANome:String=''): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('municipios')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('ufSigla',AUF_Sigla)
             .AddParam('nome',ANome)
             .AddParam('ibge',AIbge)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizados os Municípios...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Paises_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('paises')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('paises')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o país...');
        Result := True;
        //Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um País. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Paises_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('paises')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('País não localizado');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Paises_Lista(const APagina, ACodigo: Integer;
  const ANome: String): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('paises')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('nome',ANome)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizados os paises...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Regiao_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('regioes')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('regioes')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar a região...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir um região. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Regiao_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('regioes')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Regiao não localizada');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Regiao_Lista(const APagina, ACodigo: Integer;
  const ANome: String): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('regioes')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('nome',ANome)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizados os paises...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Setor_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('setor')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('setor')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o setor...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao cadastrar um Setor. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Setor_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('setor')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Não foi possível excluir o setor');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Setor_Lista(const APagina, ACodigo: Integer;
  const ANome: String): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('setor')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('nome',ANome)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizados os setores...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.UF_Cadastro(const AJson: TJSONArray;
  StatusTable: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('unidadeFederativa')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('unidadeFederativa')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar a Unidade Federativa...');
        Result := True;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir uma Unidade Federativa. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.UF_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('unidadeFederativa')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Unidade Federativa não localizada');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.UF_Lista(
  const APagina:Integer=0;
  const ACodigo:Integer=0;
  const ARegiao:Integer=0;
  const ANome:String=''): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('unidadeFederativa')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('idRegiao',ARegiao.ToString)
             .AddParam('sigla',ANome)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizados as Unidades Federativas...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Usuario_Cadastro(const AJson :TJSONArray;StatusTable:Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    try
      if not TFuncoes.TestaConexao(FConexao) then
        raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

      if AJson.Size = 0 then
        raise Exception.Create('Não há dados para ser cadastrados');

      lHost := FIniFile.ReadString('SERVER','HOST','');
      if lHost = '' then
        lHost := 'http://localhost:3000';

      if lHost = '' then
        raise Exception.Create('Necessário informar o Host...');

      case StatusTable of
        0:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('usuario')
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Post;
        end;
        1:begin
          lResp := TRequest.New.BaseURL(lHost)
                   .Resource('usuario')
                   .TokenBearer(FDMem_UsuariosTOKEN.AsString)
                   .AddBody(AJson)
                   .Accept('application/json')
                   .Put;
        end;
      end;

      if lResp.StatusCode = 200 then
      begin
        if lResp.Content = '' then
          raise Exception.Create('Não foi possível cadastrar o usuários...');
        Result := True;
        //Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
      end
      else
      begin
        raise Exception.Create(lResp.Content);
      end;
    except
      On Ex:Exception do
      begin
        Result := False;
        raise Exception.Create('Erro ao inserir Usuário. (' + Ex.Message + ')');
      end;
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Usuario_Excluir(const ACodigo: Integer): Boolean;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('usuario')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .Accept('application/json')
             .Delete;

    if lResp.StatusCode = 200 then
    begin
      Result := False;
      if lResp.Content = '' then
        raise Exception.Create('Usuário não localizado');

      Result := True;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

function TDm_DeskTop.Usuario_Lista(
        const APagina:Integer=0;
        const ACodigo:Integer=0;
        const ANome:String='';
        const APIN:String='';
        const AEmail:String=''): TJSONArray;
var
  lHost :String;
  lResp :IResponse;
begin
  try
    if not TFuncoes.TestaConexao(FConexao) then
      raise Exception.Create('Sem conexão com a Internet. Tente mais tarde');

    lHost := FIniFile.ReadString('SERVER','HOST','');
    if lHost = '' then
      lHost := 'http://localhost:3000';

    if lHost = '' then
      raise Exception.Create('Necessário informar o Host...');

    lResp := TRequest.New.BaseURL(lHost)
             .Resource('usuario')
             .TokenBearer(FDMem_UsuariosTOKEN.AsString)
             .AddParam('id',ACodigo.ToString)
             .AddParam('nome',ANome)
             .AddParam('email',AEmail)
             .AddParam('pin',APIN)
             .AddParam('pagina',APagina.ToString)
             .Accept('application/json')
             .Get;

    if lResp.StatusCode = 200 then
    begin
      if lResp.Content = '' then
        raise Exception.Create('Não foram localizados os usuários...');

      Result := TJSONArray.ParseJSONValue(TEncoding.UTF8.GetBytes(lResp.Content),0) as TJSONArray;
    end
    else
    begin
      raise Exception.Create(lResp.StatusCode.ToString + ' - ' +  lResp.Content);
    end;
  finally
    {$IFDEF MSWINDOWS}
    {$ELSE}
    {$ENDIF}
  end;
end;

end.
