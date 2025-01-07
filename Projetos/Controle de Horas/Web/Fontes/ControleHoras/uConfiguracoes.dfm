object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 504
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 892
    Height = 504
    ActivePage = tsPlanoContasPadrao
    Align = alClient
    TabOrder = 0
    object tsBancoDeDados: TTabSheet
      Caption = 'Banco de Dados'
      object lbBD_Servidor: TLabel
        Left = 22
        Top = 16
        Width = 43
        Height = 15
        Caption = 'Servidor'
      end
      object lbBD_Porta: TLabel
        Left = 416
        Top = 21
        Width = 28
        Height = 15
        Caption = 'Porta'
      end
      object lbBD_Banco: TLabel
        Left = 32
        Top = 45
        Width = 33
        Height = 15
        Caption = 'Banco'
      end
      object lbBD_Usuario: TLabel
        Left = 22
        Top = 69
        Width = 40
        Height = 15
        Caption = 'Usu'#225'rio'
      end
      object lbBD_Senha: TLabel
        Left = 307
        Top = 74
        Width = 32
        Height = 15
        Caption = 'Senha'
      end
      object lbBD_Biblioteca: TLabel
        Left = 13
        Top = 108
        Width = 52
        Height = 15
        Caption = 'Biblioteca'
      end
      object edBD_Servidor: TEdit
        Left = 71
        Top = 13
        Width = 213
        Height = 23
        TabOrder = 0
      end
      object edBD_BancoDados: TButtonedEdit
        Left = 71
        Top = 42
        Width = 487
        Height = 23
        Images = ImageList
        RightButton.ImageIndex = 0
        RightButton.Visible = True
        TabOrder = 1
      end
      object edBD_Usuario: TEdit
        Left = 71
        Top = 71
        Width = 213
        Height = 23
        TabOrder = 2
      end
      object edBD_Senha: TEdit
        Left = 345
        Top = 71
        Width = 213
        Height = 23
        PasswordChar = '#'
        TabOrder = 3
      end
      object edBD_Biblioteca: TButtonedEdit
        Left = 71
        Top = 100
        Width = 487
        Height = 23
        Images = ImageList
        RightButton.ImageIndex = 0
        RightButton.Visible = True
        TabOrder = 4
      end
      object edBD_Porta: TButtonedEdit
        Left = 450
        Top = 18
        Width = 108
        Height = 23
        Alignment = taCenter
        Images = ImageList
        LeftButton.ImageIndex = 2
        LeftButton.Visible = True
        RightButton.ImageIndex = 1
        RightButton.Visible = True
        TabOrder = 5
        Text = '1'
      end
    end
    object tsPlanoContasPadrao: TTabSheet
      Caption = 'Contas Padr'#227'o'
      ImageIndex = 1
      object lbCP_ApontamentoHoras: TLabel
        Left = 3
        Top = 18
        Width = 122
        Height = 15
        Caption = 'Apontamento de horas'
      end
      object lbCP_Horas_Exc_Mes_Ant: TLabel
        Left = 3
        Top = 42
        Width = 155
        Height = 15
        Caption = 'Horas excedidas m'#234's anterior'
      end
      object lbCP_Horas_Pagas: TLabel
        Left = 3
        Top = 71
        Width = 65
        Height = 15
        Caption = 'Horas pagas'
      end
      object lbCP_Horas_Recebidas: TLabel
        Left = 3
        Top = 100
        Width = 84
        Height = 15
        Caption = 'Horas recebidas'
      end
      object edCP_ApontamentoHoras_ID: TButtonedEdit
        Left = 159
        Top = 10
        Width = 106
        Height = 23
        Alignment = taRightJustify
        Images = ImageList
        RightButton.ImageIndex = 0
        RightButton.Visible = True
        TabOrder = 0
      end
      object edCP_ApontamentoHoras: TEdit
        Left = 271
        Top = 10
        Width = 586
        Height = 23
        TabOrder = 1
      end
      object edCP_Horas_Exc_Mes_Ant_ID: TButtonedEdit
        Left = 159
        Top = 39
        Width = 106
        Height = 23
        Alignment = taRightJustify
        Images = ImageList
        RightButton.ImageIndex = 0
        RightButton.Visible = True
        TabOrder = 2
      end
      object edCP_Horas_Exc_Mes_Ant: TEdit
        Left = 271
        Top = 39
        Width = 586
        Height = 23
        TabOrder = 3
      end
      object edCP_Horas_Pagas_ID: TButtonedEdit
        Left = 159
        Top = 68
        Width = 106
        Height = 23
        Alignment = taRightJustify
        Images = ImageList
        RightButton.ImageIndex = 0
        RightButton.Visible = True
        TabOrder = 4
      end
      object edCP_Horas_Pagas: TEdit
        Left = 271
        Top = 68
        Width = 586
        Height = 23
        TabOrder = 5
      end
      object edCP_Horas_Recebidas_ID: TButtonedEdit
        Left = 159
        Top = 97
        Width = 106
        Height = 23
        Alignment = taRightJustify
        Images = ImageList
        RightButton.ImageIndex = 0
        RightButton.Visible = True
        TabOrder = 6
      end
      object edCP_Horas_Recebidas: TEdit
        Left = 271
        Top = 97
        Width = 586
        Height = 23
        TabOrder = 7
      end
    end
    object tsFinanceiro: TTabSheet
      Caption = 'Financeiro Padr'#227'o'
      ImageIndex = 2
      object lbFP_Horas: TLabel
        Left = 14
        Top = 11
        Width = 43
        Height = 15
        Caption = 'Servidor'
      end
      object edFP_Horas: TMaskEdit
        Left = 63
        Top = 8
        Width = 94
        Height = 23
        EditMask = '####:##:##;1; '
        MaxLength = 10
        TabOrder = 0
        Text = '    :  :  '
      end
    end
    object tsServidor: TTabSheet
      Caption = 'Servidor'
      ImageIndex = 3
      object lbS_Host: TLabel
        Left = 30
        Top = 16
        Width = 25
        Height = 15
        Caption = 'Host'
      end
      object lbS_Porta: TLabel
        Left = 456
        Top = 21
        Width = 28
        Height = 15
        Caption = 'Porta'
      end
      object edS_Host: TEdit
        Left = 79
        Top = 13
        Width = 213
        Height = 23
        TabOrder = 0
        Text = 'edBD_Servidor'
      end
      object edS_Porta: TSpinEdit
        Left = 490
        Top = 13
        Width = 76
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
  end
  object ImageList: TImageList
    Left = 440
    Top = 256
    Bitmap = {
      494C010103000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000848887D600000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF797D7CC4000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF797D7CC5000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002F31304C929796EE00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF929696ED000000000000
      00000000000000000000000000000000000000000000000000009DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF8B908FE20000000000000000000000009DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF8A8E8DE0000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF2E2F2F4A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF2D2F2E49000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF919695EC000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003132324F949897F000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
