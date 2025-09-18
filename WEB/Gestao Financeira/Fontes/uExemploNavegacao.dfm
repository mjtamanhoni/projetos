object FormExemploNavegacao: TFormExemploNavegacao
  Left = 0
  Top = 0
  Caption = 'Exemplo de Navega'#231#227'o com Enter - Delphi 11+'
  ClientHeight = 760
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 0
      Top = 0
      Width = 784
      Height = 41
      Align = alClient
      Alignment = taCenter
      Caption = 'Demonstra'#231#227'o de Navega'#231#227'o Autom'#225'tica com ENTER'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 433
      ExplicitHeight = 19
    end
  end
  object gbDadosPessoais: TGroupBox
    Left = 8
    Top = 47
    Width = 369
    Height = 193
    Caption = ' Dados Pessoais '
    TabOrder = 1
    object lblNome: TLabel
      Left = 16
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object lblEmail: TLabel
      Left = 16
      Top = 67
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object lblTelefone: TLabel
      Left = 16
      Top = 110
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object lblDataNascimento: TLabel
      Left = 16
      Top = 153
      Width = 81
      Height = 13
      Caption = 'Data Nascimento'
    end
    object edtNome: TEdit
      Left = 16
      Top = 40
      Width = 337
      Height = 21
      TabOrder = 0
    end
    object edtEmail: TEdit
      Left = 16
      Top = 83
      Width = 337
      Height = 21
      TabOrder = 1
    end
    object edtTelefone: TMaskEdit
      Left = 16
      Top = 126
      Width = 150
      Height = 21
      EditMask = '(99) 99999-9999;1;_'
      MaxLength = 15
      TabOrder = 2
      Text = '(  )      -    '
    end
    object dtpDataNascimento: TDateTimePicker
      Left = 16
      Top = 169
      Width = 150
      Height = 21
      Date = 45292.000000000000000000
      Time = 0.708333333335758700
      TabOrder = 3
    end
  end
  object gbEndereco: TGroupBox
    Left = 8
    Top = 246
    Width = 369
    Height = 251
    Caption = ' Endere'#231'o '
    TabOrder = 2
    object lblCEP: TLabel
      Left = 16
      Top = 24
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object lblLogradouro: TLabel
      Left = 16
      Top = 67
      Width = 55
      Height = 13
      Caption = 'Logradouro'
    end
    object lblNumero: TLabel
      Left = 280
      Top = 67
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object lblComplemento: TLabel
      Left = 16
      Top = 110
      Width = 65
      Height = 13
      Caption = 'Complemento'
    end
    object lblBairro: TLabel
      Left = 16
      Top = 153
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object lblCidade: TLabel
      Left = 16
      Top = 196
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object lblUF: TLabel
      Left = 280
      Top = 196
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object edtCEP: TMaskEdit
      Left = 16
      Top = 40
      Width = 100
      Height = 21
      EditMask = '99999-999;1;_'
      MaxLength = 9
      TabOrder = 0
      Text = '     -   '
      OnExit = edtCEPExit
    end
    object edtLogradouro: TEdit
      Left = 16
      Top = 83
      Width = 250
      Height = 21
      TabOrder = 1
    end
    object edtNumero: TEdit
      Left = 280
      Top = 83
      Width = 73
      Height = 21
      TabOrder = 2
    end
    object edtComplemento: TEdit
      Left = 16
      Top = 126
      Width = 337
      Height = 21
      TabOrder = 3
    end
    object edtBairro: TEdit
      Left = 16
      Top = 169
      Width = 337
      Height = 21
      TabOrder = 4
    end
    object edtCidade: TEdit
      Left = 16
      Top = 212
      Width = 250
      Height = 21
      TabOrder = 5
    end
    object cmbUF: TComboBox
      Left = 280
      Top = 212
      Width = 73
      Height = 21
      Style = csDropDownList
      TabOrder = 6
    end
  end
  object gbPreferencias: TGroupBox
    Left = 16
    Top = 557
    Width = 369
    Height = 145
    Caption = ' Prefer'#234'ncias '
    TabOrder = 3
    object lblObservacoes: TLabel
      Left = 200
      Top = 24
      Width = 63
      Height = 13
      Caption = 'Observa'#231#245'es'
    end
    object chkReceberEmails: TCheckBox
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Receber Emails'
      TabOrder = 0
    end
    object chkReceberSMS: TCheckBox
      Left = 16
      Top = 47
      Width = 97
      Height = 17
      Caption = 'Receber SMS'
      TabOrder = 1
    end
    object rgTipoContato: TRadioGroup
      Left = 16
      Top = 70
      Width = 169
      Height = 65
      Caption = 'Tipo de Contato Preferido'
      Items.Strings = (
        'Email'
        'Telefone'
        'WhatsApp')
      TabOrder = 2
    end
    object memoObservacoes: TMemo
      Left = 200
      Top = 40
      Width = 153
      Height = 95
      ScrollBars = ssVertical
      TabOrder = 3
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 719
    Width = 784
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 620
    object btnSalvar: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 89
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnLimpar: TButton
      Left = 170
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Limpar'
      TabOrder = 2
      OnClick = btnLimparClick
    end
  end
  object pnlConfiguracoes: TPanel
    Left = 391
    Top = 41
    Width = 393
    Height = 678
    Align = alRight
    BevelOuter = bvLowered
    TabOrder = 5
    ExplicitTop = 47
    object lblExcecoes: TLabel
      Left = 24
      Top = 159
      Width = 45
      Height = 13
      Caption = 'Exce'#231#245'es'
    end
    object lblInstrucoes: TLabel
      Left = 24
      Top = 375
      Width = 345
      Height = 180
      AutoSize = False
      Caption = 'Instru'#231#245'es...'
      WordWrap = True
    end
    object gbConfiguracoes: TGroupBox
      Left = 8
      Top = 8
      Width = 377
      Height = 137
      Caption = ' Configura'#231#245'es de Navega'#231#227'o '
      TabOrder = 0
      object chkNavegacaoCircular: TCheckBox
        Left = 16
        Top = 24
        Width = 129
        Height = 17
        Caption = 'Navega'#231#227'o Circular'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkIgnorarReadOnly: TCheckBox
        Left = 16
        Top = 47
        Width = 129
        Height = 17
        Caption = 'Ignorar ReadOnly'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object chkAtivarSom: TCheckBox
        Left = 16
        Top = 70
        Width = 97
        Height = 17
        Caption = 'Ativar Som'
        TabOrder = 2
      end
      object btnAplicarConfig: TButton
        Left = 16
        Top = 96
        Width = 100
        Height = 25
        Caption = 'Aplicar Config'
        TabOrder = 3
        OnClick = btnAplicarConfigClick
      end
      object btnResetConfig: TButton
        Left = 122
        Top = 96
        Width = 100
        Height = 25
        Caption = 'Reset Config'
        TabOrder = 4
        OnClick = btnResetConfigClick
      end
    end
    object lbExcecoes: TListBox
      Left = 24
      Top = 178
      Width = 345
      Height = 150
      ItemHeight = 13
      TabOrder = 1
    end
    object btnAdicionarExcecao: TButton
      Left = 24
      Top = 334
      Width = 120
      Height = 25
      Caption = 'Adicionar Exce'#231#227'o'
      TabOrder = 2
      OnClick = btnAdicionarExcecaoClick
    end
    object btnRemoverExcecao: TButton
      Left = 150
      Top = 334
      Width = 120
      Height = 25
      Caption = 'Remover Exce'#231#227'o'
      TabOrder = 3
      OnClick = btnRemoverExcecaoClick
    end
  end
end
