program DeskTop;

uses
  System.StartUpCopy,
  FMX.Forms,
  uDeskTop.Principal in 'uDeskTop.Principal.pas' {frmPrincipal},
  uFancyDialog in '..\..\..\Classes\99 Coders\Versao 11\uFancyDialog.pas',
  uLoading in '..\..\..\Classes\99 Coders\Versao 11\uLoading.pas',
  uDeskTop.Login in 'uDeskTop.Login.pas' {frmLogin},
  uDeskTop.Config in 'uDeskTop.Config.pas' {frmConfig},
  uDeskTop.CadUsuario in 'uDeskTop.CadUsuario.pas' {frmCadUsuario},
  uFuncoes in '..\..\Servidor\Fontes\Units\uFuncoes.pas',
  uFormat in '..\..\..\Classes\99 Coders\Versao 11\uFormat.pas',
  uDm_DeskTop in 'uDm_DeskTop.pas' {Dm_DeskTop: TDataModule},
  uDeskTop.CadPaises in 'uDeskTop.CadPaises.pas' {frmCadPaises},
  uDeskTop.CadRegioes in 'uDeskTop.CadRegioes.pas' {frmCad_Regioes},
  uDeskTop.CadUF in 'uDeskTop.CadUF.pas' {frmUnidadeFederativa},
  uDeskTop.CadMunicipios in 'uDeskTop.CadMunicipios.pas' {frmMunicipios},
  uDeskTop.CadEmpresa in 'uDeskTop.CadEmpresa.pas' {frmEmpresa},
  uDeskTop.CadFornecedor in 'uDeskTop.CadFornecedor.pas' {frmFornecedor},
  uDeskTop.CadCliente in 'uDeskTop.CadCliente.pas' {frmCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDm_DeskTop, Dm_DeskTop);
  Application.Run;
end.
