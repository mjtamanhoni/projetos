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
    object Module11: TMenuItem
      Caption = 'Cadastro'
      OnClick = Module11Click
      object Configuraes1: TMenuItem
        Caption = 'Configura'#231#245'es'
        OnClick = Configuraes1Click
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
      end
      object Pessoas1: TMenuItem
        Caption = 'Pessoas'
        object PrestadordeServio1: TMenuItem
          Caption = 'Prestador de Servi'#231'o'
        end
        object Cliente1: TMenuItem
          Caption = 'Cliente'
        end
        object Fornecedor1: TMenuItem
          Caption = 'Fornecedor'
        end
      end
      object abeladePreo1: TMenuItem
        Caption = 'Tabela de Pre'#231'o'
      end
      object Contas1: TMenuItem
        Caption = 'Contas'
      end
      object Pagamento1: TMenuItem
        Caption = 'Pagamento'
        object Forma1: TMenuItem
          Caption = 'Forma'
        end
        object Condio1: TMenuItem
          Caption = 'Condi'#231#227'o'
        end
      end
    end
    object AppModule21: TMenuItem
      Caption = 'Movimento'
      object ServiosPrestados1: TMenuItem
        Caption = 'Servi'#231'os Prestados'
      end
      object LanamentosFinanceiros1: TMenuItem
        Caption = 'Lan'#231'amentos Financeiros'
      end
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
end
