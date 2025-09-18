unit uNavegacaoEnter;

{
  Unit para navegação automática com Enter entre campos
  Compatível com Delphi 11 e superior
  
  Uso:
  1. Adicione esta unit ao uses do formulário
  2. Chame TNavegacaoEnter.AtivarNavegacao(Self) no OnCreate do form
  3. Opcionalmente configure exceções e comportamentos especiais
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, System.Generics.Collections,
  System.Generics.Defaults;

type
  // Configurações de navegação
  TNavegacaoConfig = record
    AtivarSom: Boolean;              // Tocar som ao navegar
    IgnorarReadOnly: Boolean;        // Pular campos ReadOnly
    IgnorarDisabled: Boolean;        // Pular campos Disabled
    NavegacaoCircular: Boolean;      // Voltar ao primeiro campo após o último
    TeclaNavegacao: Word;           // Tecla para navegação (VK_RETURN por padrão)
    class function Default: TNavegacaoConfig; static;
  end;

  // Classe principal para controle de navegação
  TNavegacaoEnter = class
  private
    class var FInstances: TDictionary<TForm, TNavegacaoEnter>;
    class var FGlobalConfig: TNavegacaoConfig;
  private
    FForm: TForm;
    FOriginalKeyPreview: Boolean;
    FOriginalOnKeyDown: TKeyEvent;
    FExcecoes: TList<TControl>;
    FConfig: TNavegacaoConfig;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function PodeReceberFoco(Control: TControl): Boolean;
    function ProximoControle(Atual: TControl): TControl;
    function PrimeiroControle: TControl;
    function UltimoControle: TControl;
    procedure NavegarPara(Control: TControl);
    function GetControlesNavegaveis: TArray<TControl>;
  public
    constructor Create(AForm: TForm);
    destructor Destroy; override;
    
    // Métodos principais
    class procedure AtivarNavegacao(AForm: TForm); overload;
    class procedure AtivarNavegacao(AForm: TForm; const AConfig: TNavegacaoConfig); overload;
    class procedure DesativarNavegacao(AForm: TForm);
    class procedure ConfigurarGlobal(const AConfig: TNavegacaoConfig);
    class function GetInstance(AForm: TForm): TNavegacaoEnter;
    
    // Gerenciamento de exceções
    procedure AdicionarExcecao(Control: TControl);
    procedure RemoverExcecao(Control: TControl);
    procedure LimparExcecoes;
    
    // Propriedades
    property Config: TNavegacaoConfig read FConfig write FConfig;
    property Excecoes: TList<TControl> read FExcecoes;
  end;

  // Helper para facilitar o uso
  TFormNavegacaoHelper = class helper for TForm
  public
    procedure AtivarNavegacaoEnter; overload;
    procedure AtivarNavegacaoEnter(const AConfig: TNavegacaoConfig); overload;
    procedure DesativarNavegacaoEnter;
    procedure AdicionarExcecaoNavegacao(Control: TControl);
  end;

implementation

{ TNavegacaoConfig }

class function TNavegacaoConfig.Default: TNavegacaoConfig;
begin
  Result.AtivarSom := False;
  Result.IgnorarReadOnly := True;
  Result.IgnorarDisabled := True;
  Result.NavegacaoCircular := True;
  Result.TeclaNavegacao := VK_RETURN;
end;

{ TNavegacaoEnter }

class procedure TNavegacaoEnter.AtivarNavegacao(AForm: TForm);
begin
  AtivarNavegacao(AForm, FGlobalConfig);
end;

class procedure TNavegacaoEnter.AtivarNavegacao(AForm: TForm; const AConfig: TNavegacaoConfig);
var
  Instance: TNavegacaoEnter;
begin
  if not Assigned(FInstances) then
    FInstances := TDictionary<TForm, TNavegacaoEnter>.Create;
    
  // Se já existe uma instância, remove primeiro
  if FInstances.ContainsKey(AForm) then
    DesativarNavegacao(AForm);
    
  Instance := TNavegacaoEnter.Create(AForm);
  Instance.FConfig := AConfig;
  FInstances.Add(AForm, Instance);
end;

class procedure TNavegacaoEnter.DesativarNavegacao(AForm: TForm);
var
  Instance: TNavegacaoEnter;
begin
  if Assigned(FInstances) and FInstances.TryGetValue(AForm, Instance) then
  begin
    FInstances.Remove(AForm);
    Instance.Free;
  end;
end;

class procedure TNavegacaoEnter.ConfigurarGlobal(const AConfig: TNavegacaoConfig);
begin
  FGlobalConfig := AConfig;
end;

constructor TNavegacaoEnter.Create(AForm: TForm);
begin
  inherited Create;
  FForm := AForm;
  FExcecoes := TList<TControl>.Create;
  FConfig := FGlobalConfig;
  
  // Salvar configurações originais
  FOriginalKeyPreview := FForm.KeyPreview;
  FOriginalOnKeyDown := FForm.OnKeyDown;
  
  // Configurar interceptação de teclas
  FForm.KeyPreview := True;
  FForm.OnKeyDown := FormKeyDown;
end;

destructor TNavegacaoEnter.Destroy;
begin
  // Restaurar configurações originais
  if Assigned(FForm) then
  begin
    FForm.KeyPreview := FOriginalKeyPreview;
    FForm.OnKeyDown := FOriginalOnKeyDown;
  end;
  
  FExcecoes.Free;
  inherited Destroy;
end;

procedure TNavegacaoEnter.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ProximoCtrl: TControl;
begin
  // Chamar evento original se existir
  if Assigned(FOriginalOnKeyDown) then
    FOriginalOnKeyDown(Sender, Key, Shift);
    
  // Verificar se é a tecla de navegação
  if (Key = FConfig.TeclaNavegacao) and (Shift = []) then
  begin
    // Verificar se o controle atual está nas exceções
    if FExcecoes.Contains(FForm.ActiveControl) then
      Exit;
      
    // Encontrar próximo controle
    ProximoCtrl := ProximoControle(FForm.ActiveControl);
    
    if Assigned(ProximoCtrl) then
    begin
      NavegarPara(ProximoCtrl);
      Key := 0; // Consumir a tecla
    end;
  end;
end;

function TNavegacaoEnter.PodeReceberFoco(Control: TControl): Boolean;
begin
  Result := False;
  
  if not Assigned(Control) then
    Exit;
    
  // Verificar se está nas exceções
  if FExcecoes.Contains(Control) then
    Exit;
    
  // Verificar se pode receber foco
  if not ((Control is TWinControl) and TWinControl(Control).CanFocus) then
    Exit;
    
  // Verificar se está visível e habilitado
  if not (Control.Visible and Control.Enabled) then
    Exit;
    
  // Verificar ReadOnly se configurado
  if FConfig.IgnorarReadOnly then
  begin
    if (Control is TCustomEdit) and TCustomEdit(Control).ReadOnly then
      Exit;
    if (Control is TCustomMemo) and TCustomMemo(Control).ReadOnly then
      Exit;
    if (Control is TDBEdit) and TDBEdit(Control).ReadOnly then
      Exit;
    if (Control is TDBMemo) and TDBMemo(Control).ReadOnly then
      Exit;
  end;
  
  // Verificar se é um controle navegável
  Result := (Control is TCustomEdit) or
            (Control is TCustomMemo) or
            (Control is TCustomComboBox) or
            (Control is TCustomListBox) or
            (Control is TDateTimePicker) or
            (Control is TCustomCheckBox) or
            (Control is TRadioButton) or
            (Control is TButton) or
            (Control is TBitBtn) or
            (Control is TSpeedButton) or
            (Control is TDBEdit) or
            (Control is TDBMemo) or
            (Control is TDBComboBox) or
            (Control is TDBCheckBox) or
            (Control is TDBRadioGroup) or
            (Control is TDBLookupComboBox);
end;

function TNavegacaoEnter.GetControlesNavegaveis: TArray<TControl>;
var
  Lista: TList<TControl>;
  
  procedure AdicionarControles(Container: TWinControl);
  var
    I: Integer;
    Control: TControl;
  begin
    for I := 0 to Container.ControlCount - 1 do
    begin
      Control := Container.Controls[I];
      
      if PodeReceberFoco(Control) then
        Lista.Add(Control);
        
      // Recursão para containers
      if (Control is TWinControl) and TWinControl(Control).Showing then
        AdicionarControles(TWinControl(Control));
    end;
  end;
  
begin
  Lista := TList<TControl>.Create;
  try
    AdicionarControles(FForm);
    
    // Ordenar por TabOrder
    Lista.Sort(TComparer<TControl>.Construct(
      function(const Left, Right: TControl): Integer
      begin
        if (Left is TWinControl) and (Right is TWinControl) then
          Result := TWinControl(Left).TabOrder - TWinControl(Right).TabOrder
        else if Left is TWinControl then
          Result := -1
        else if Right is TWinControl then
          Result := 1
        else
          Result := 0;
      end));
      
    Result := Lista.ToArray;
  finally
    Lista.Free;
  end;
end;

function TNavegacaoEnter.ProximoControle(Atual: TControl): TControl;
var
  Controles: TArray<TControl>;
  I, IndiceAtual: Integer;
begin
  Result := nil;
  Controles := GetControlesNavegaveis;
  
  if Length(Controles) = 0 then
    Exit;
    
  // Encontrar índice do controle atual
  IndiceAtual := -1;
  for I := 0 to High(Controles) do
  begin
    if Controles[I] = Atual then
    begin
      IndiceAtual := I;
      Break;
    end;
  end;
  
  // Se não encontrou o atual, vai para o primeiro
  if IndiceAtual = -1 then
  begin
    Result := Controles[0];
    Exit;
  end;
  
  // Próximo controle
  if IndiceAtual < High(Controles) then
    Result := Controles[IndiceAtual + 1]
  else if FConfig.NavegacaoCircular then
    Result := Controles[0];
end;

function TNavegacaoEnter.PrimeiroControle: TControl;
var
  Controles: TArray<TControl>;
begin
  Controles := GetControlesNavegaveis;
  if Length(Controles) > 0 then
    Result := Controles[0]
  else
    Result := nil;
end;

function TNavegacaoEnter.UltimoControle: TControl;
var
  Controles: TArray<TControl>;
begin
  Controles := GetControlesNavegaveis;
  if Length(Controles) > 0 then
    Result := Controles[High(Controles)]
  else
    Result := nil;
end;

procedure TNavegacaoEnter.NavegarPara(Control: TControl);
begin
  if Assigned(Control) and (Control is TWinControl) and TWinControl(Control).CanFocus then
  begin
    TWinControl(Control).SetFocus;
    
    // Tocar som se configurado
    if FConfig.AtivarSom then
      Beep;
      
    // Selecionar texto se for um edit
    if Control is TCustomEdit then
      TCustomEdit(Control).SelectAll
    else if Control is TCustomMemo then
      TCustomMemo(Control).SelectAll;
  end;
end;

procedure TNavegacaoEnter.AdicionarExcecao(Control: TControl);
begin
  if not FExcecoes.Contains(Control) then
    FExcecoes.Add(Control);
end;

procedure TNavegacaoEnter.RemoverExcecao(Control: TControl);
begin
  FExcecoes.Remove(Control);
end;

procedure TNavegacaoEnter.LimparExcecoes;
begin
  FExcecoes.Clear;
end;

{ TNavegacaoEnter - Método GetInstance }

class function TNavegacaoEnter.GetInstance(AForm: TForm): TNavegacaoEnter;
begin
  Result := nil;
  if Assigned(FInstances) then
    FInstances.TryGetValue(AForm, Result);
end;

{ TFormNavegacaoHelper }

procedure TFormNavegacaoHelper.AtivarNavegacaoEnter;
begin
  TNavegacaoEnter.AtivarNavegacao(Self);
end;

procedure TFormNavegacaoHelper.AtivarNavegacaoEnter(const AConfig: TNavegacaoConfig);
begin
  TNavegacaoEnter.AtivarNavegacao(Self, AConfig);
end;

procedure TFormNavegacaoHelper.DesativarNavegacaoEnter;
begin
  TNavegacaoEnter.DesativarNavegacao(Self);
end;

procedure TFormNavegacaoHelper.AdicionarExcecaoNavegacao(Control: TControl);
var
  Instance: TNavegacaoEnter;
begin
  Instance := TNavegacaoEnter.GetInstance(Self);
  if Assigned(Instance) then
    Instance.AdicionarExcecao(Control);
end;

initialization
  TNavegacaoEnter.FGlobalConfig := TNavegacaoConfig.Default;

finalization
  if Assigned(TNavegacaoEnter.FInstances) then
  begin
    TNavegacaoEnter.FInstances.Free;
    TNavegacaoEnter.FInstances := nil;
  end;

end.