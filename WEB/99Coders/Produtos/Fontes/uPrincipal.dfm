object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  TextHeight = 14
  object MainMenu1: TMainMenu
    Left = 176
    Top = 152
    object Module11: TMenuItem
      Caption = 'Inicio'
      OnClick = Module11Click
    end
    object AppModule21: TMenuItem
      Caption = 'Produtos'
    end
    object CoreModules1: TMenuItem
      Caption = 'Relat'#243'rios'
      object CoreModule11: TMenuItem
        Caption = 'Produtos'
      end
    end
    object Modules1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object Module12: TMenuItem
        Caption = 'Tipo de Produtos'
      end
      object Module21: TMenuItem
        Caption = 'Usu'#225'rios'
      end
    end
  end
end
