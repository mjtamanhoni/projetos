object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 176
    Top = 152
    object menuCadastro: TMenuItem
      Caption = 'Cadastro'
      OnClick = menuCadastroClick
      object menuCad_Config: TMenuItem
        Caption = 'Configura'#231#245'es'
        OnClick = menuCad_ConfigClick
      end
      object Configuraes2: TMenuItem
        Caption = '-'
      end
      object Usurios1: TMenuItem
        Caption = 'Usu'#225'rio'
        OnClick = Usurios1Click
      end
      object Empresas1: TMenuItem
        Caption = 'Empresa'
        OnClick = Empresas1Click
      end
      object Pessoas1: TMenuItem
        Caption = 'Pessoas'
        object PrestadordeServio1: TMenuItem
          Caption = 'Prestador de Servi'#231'o'
          OnClick = PrestadordeServio1Click
        end
        object Cliente1: TMenuItem
          Caption = 'Cliente'
          OnClick = Cliente1Click
        end
        object Fornecedor1: TMenuItem
          Caption = 'Fornecedor'
          OnClick = Fornecedor1Click
        end
      end
      object abeladePreo1: TMenuItem
        Caption = 'Tabela de Pre'#231'o'
        OnClick = abeladePreo1Click
      end
      object Contas1: TMenuItem
        Caption = 'Contas'
        OnClick = Contas1Click
      end
      object Pagamento1: TMenuItem
        Caption = 'Pagamento'
        object Condio1: TMenuItem
          Caption = 'Condi'#231#227'o'
          OnClick = Condio1Click
        end
        object Forma1: TMenuItem
          Caption = 'Forma'
          OnClick = Forma1Click
        end
      end
    end
    object menuMovimento: TMenuItem
      Caption = 'Movimento'
      object ServiosPrestados1: TMenuItem
        Caption = 'Servi'#231'os Prestados'
        OnClick = ServiosPrestados1Click
      end
      object LanamentosFinanceiros1: TMenuItem
        Caption = 'Lan'#231'amentos Financeiros'
      end
    end
    object menuConsultas: TMenuItem
      Caption = 'Consultas'
      object ServiosPrestados2: TMenuItem
        Caption = 'Servi'#231'os Prestados'
        OnClick = ServiosPrestados2Click
      end
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
end
