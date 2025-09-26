unit Gestao_Financeira_Session;

interface

uses
  SysUtils, Classes,
  Prism.SessionBase;

type
  TGestao_FinanceiraSession = class(TPrismSessionBase)
  private
    FUsuario_Token: String;
    FUsuario_Status_Tab: String;
    FId_Filial: Integer;
    FUsuario_Nome: String;
    FUsuario_Tipo: Integer;
    FUsuario_ID: Integer;
    FProjeto_ID: Integer;
    FProjeto_Status_Tab: String;
    FProjeto_Descricao: String;
    FProjeto_Status: Integer;
    FTipoFormulario_Status_Tab: String;
    FTipoFormulario_Tipo: String;
    FTipoFormulario_Descricao: String;
    FTipoFormulario_Id: Integer;
    FTipoFormulario_Status: Integer;
    FFormProjeto_Status_Tab: String;
    FFormProjeto_Id_Tipo_Form: Integer;
    FFormProjeto_Id_Projeto: Integer;
    FFormProjeto_Descricao: String;
    FFormProjeto_Id: Integer;
    FFormProjeto_Status: Integer;
    FFormProjeto_Nome_Form: String;
    FTipoFormulario_TipoDesc: String;
    FUsuario_Status: Integer;
    FUsuario_Login: String;
    FUsuario_Email: String;
    FRegiao_ID: Integer;
    FRegiao_Status_Tab: String;
    FRegiao_Nome: String;
    FRegiao_IBGE: Integer;
    FUF_IBGE: Integer;
    FUF_Descricao: String;
    FUF_Id: Integer;
    FUF_IdRegiao: Integer;
    FUF_Status_Tab: String;
    FUF_Sigla: String;
    FUF_Capital: String;

  public

    {$Region 'Usuario'}
      property Usuario_Status_Tab :String read FUsuario_Status_Tab write FUsuario_Status_Tab;
      property Usuario_ID :Integer read FUsuario_ID write FUsuario_ID;
      property Usuario_Nome :String read FUsuario_Nome write FUsuario_Nome;
      property Usuario_Tipo :Integer read FUsuario_Tipo write FUsuario_Tipo;
      property Usuario_Token :String read FUsuario_Token write FUsuario_Token;
      property Id_Filial :Integer read FId_Filial write FId_Filial;
      property Usuario_Status :Integer read FUsuario_Status write FUsuario_Status;
      property Usuario_Login :String read FUsuario_Login write FUsuario_Login;
      property Usuario_Email :String read FUsuario_Email write FUsuario_Email;
    {$EndRegion 'Usuario'}

    {$Region 'Projetos'}
      property Projeto_Status_Tab :String read FProjeto_Status_Tab write FProjeto_Status_Tab;
      property Projeto_ID :Integer read FProjeto_ID write FProjeto_ID;
      property Projeto_Descricao :String read FProjeto_Descricao write FProjeto_Descricao;
      property Projeto_Status :Integer read FProjeto_Status write FProjeto_Status;
    {$EndRegion 'Projetos'}

    {$Region 'Tipo de Formulário'}
      property TipoFormulario_Status_Tab :String read FTipoFormulario_Status_Tab write FTipoFormulario_Status_Tab;
      property TipoFormulario_Id :Integer read FTipoFormulario_Id write FTipoFormulario_Id;
      property TipoFormulario_Descricao :String read FTipoFormulario_Descricao write FTipoFormulario_Descricao;
      property TipoFormulario_Status :Integer read FTipoFormulario_Status write FTipoFormulario_Status;
      property TipoFormulario_Tipo :String read FTipoFormulario_Tipo write FTipoFormulario_Tipo;
      property TipoFormulario_TipoDesc :String read FTipoFormulario_TipoDesc write FTipoFormulario_TipoDesc;
    {$EndRegion 'Tipo de Formulário'}

    {$Region 'Formulário Projeto'}
      property FormProjeto_Status_Tab :String read FFormProjeto_Status_Tab write FFormProjeto_Status_Tab;
      property FormProjeto_Id :Integer read FFormProjeto_Id write FFormProjeto_Id;
      property FormProjeto_Id_Projeto :Integer read FFormProjeto_Id_Projeto write FFormProjeto_Id_Projeto;
      property FormProjeto_Nome_Form :String read FFormProjeto_Nome_Form write FFormProjeto_Nome_Form;
      property FormProjeto_Descricao :String read FFormProjeto_Descricao write FFormProjeto_Descricao;
      property FormProjeto_Id_Tipo_Form :Integer read FFormProjeto_Id_Tipo_Form write FFormProjeto_Id_Tipo_Form;
      property FormProjeto_Status :Integer read FFormProjeto_Status write FFormProjeto_Status;
    {$EndRegion 'Formulário Projeto'}

    {$Region 'Regiões do brasil'}
      property Regiao_Status_Tab :String read FRegiao_Status_Tab write FRegiao_Status_Tab;
      property Regiao_ID :Integer read FRegiao_ID write FRegiao_ID;
      property Regiao_IBGE :Integer read FRegiao_IBGE write FRegiao_IBGE;
      property Regiao_Nome :String read FRegiao_Nome write FRegiao_Nome;
    {$EndRegion 'Regiões do brasil'}

    {$Region 'Unidades Federativas'}
      property UF_Status_Tab :String read FUF_Status_Tab write FUF_Status_Tab;
      property UF_Id :Integer read FUF_Id write FUF_Id;
      property UF_IdRegiao :Integer read FUF_IdRegiao write FUF_IdRegiao;
      property UF_IBGE :Integer read FUF_IBGE write FUF_IBGE;
      property UF_Sigla :String read FUF_Sigla write FUF_Sigla;
      property UF_Descricao :String read FUF_Descricao write FUF_Descricao;
      property UF_Capital :String read FUF_Capital write FUF_Capital;
    {$EndRegion 'Unidades Federativas'}

   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession
  end;


implementation

Uses
  D2Bridge.Instance,
  Gestao_FinanceiraWebApp;

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF} 

constructor TGestao_FinanceiraSession.Create(APrismSession: TPrismSession); //OnNewSession
begin
 inherited;

 //Your code

end;

destructor TGestao_FinanceiraSession.Destroy; //OnCloseSession
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

 inherited;
end;

end.

