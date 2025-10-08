object frmEmpresa_Cad: TfrmEmpresa_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Empresa'
  ClientHeight = 579
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object btCancelar: TButton
    Left = 904
    Top = 209
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = btCancelarClick
  end
  object btConfirmar: TButton
    Left = 823
    Top = 209
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btConfirmarClick
  end
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lbid: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 87
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Id'
      Layout = tlCenter
    end
    object lbstatus: TLabel
      AlignWithMargins = True
      Left = 151
      Top = 3
      Width = 42
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Status'
      Layout = tlCenter
      ExplicitLeft = 174
    end
    object lbtipo: TLabel
      AlignWithMargins = True
      Left = 310
      Top = 3
      Width = 33
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Tipo'
      Layout = tlCenter
      ExplicitLeft = 324
      ExplicitTop = 0
    end
    object lbcnpj: TLabel
      AlignWithMargins = True
      Left = 612
      Top = 3
      Width = 27
      Height = 23
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CNPJ'
      Layout = tlCenter
      ExplicitLeft = 563
      ExplicitTop = 13
      ExplicitHeight = 15
    end
    object lbinscEstadual: TLabel
      AlignWithMargins = True
      Left = 783
      Top = 3
      Width = 81
      Height = 23
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Insc. Estadual'
      Layout = tlCenter
      ExplicitLeft = 754
    end
    object lbtipoPessoa: TLabel
      AlignWithMargins = True
      Left = 460
      Top = 3
      Width = 46
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pessoa'
      Layout = tlCenter
    end
    object edid: TEdit
      AlignWithMargins = True
      Left = 96
      Top = 3
      Width = 49
      Height = 23
      Align = alLeft
      Enabled = False
      TabOrder = 0
      TextHint = 'Id'
      OnKeyPress = edidKeyPress
    end
    object cbstatus: TComboBox
      AlignWithMargins = True
      Left = 199
      Top = 3
      Width = 105
      Height = 23
      Align = alLeft
      TabOrder = 1
      Text = 'Selecione'
      OnKeyPress = cbstatusKeyPress
      Items.Strings = (
        'INATIVO'
        'ATIVO')
      ExplicitLeft = 239
    end
    object cbtipo: TComboBox
      AlignWithMargins = True
      Left = 349
      Top = 3
      Width = 105
      Height = 23
      Align = alLeft
      TabOrder = 2
      Text = 'Selecione'
      OnKeyPress = cbtipoKeyPress
      Items.Strings = (
        'MATRIZ'
        'FILIAL')
      ExplicitLeft = 381
      ExplicitTop = 0
    end
    object edcnpj: TEdit
      AlignWithMargins = True
      Left = 645
      Top = 3
      Width = 132
      Height = 23
      Align = alRight
      TabOrder = 3
      TextHint = 'CNPJ'
      OnExit = edcnpjExit
      OnKeyPress = edcnpjKeyPress
      ExplicitLeft = 629
    end
    object edinscEstadual: TEdit
      AlignWithMargins = True
      Left = 870
      Top = 3
      Width = 109
      Height = 23
      Align = alRight
      TabOrder = 4
      TextHint = 'Inscri'#231#227'o Estadual'
      OnExit = edinscEstadualExit
      OnKeyPress = edinscEstadualKeyPress
      ExplicitLeft = 869
    end
    object cbtipoPessoa: TComboBox
      AlignWithMargins = True
      Left = 512
      Top = 3
      Width = 84
      Height = 23
      Align = alLeft
      TabOrder = 5
      Text = 'Selecione'
      OnKeyPress = cbtipoPessoaKeyPress
      Items.Strings = (
        'F'#205'SICA'
        'JUR'#205'DICA')
      ExplicitLeft = 499
    end
  end
  object pnRow002: TPanel
    Left = 0
    Top = 29
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lbrazaoSocial: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 87
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Raz'#227'o Social'
      Layout = tlCenter
    end
    object lbfantasia: TLabel
      AlignWithMargins = True
      Left = 504
      Top = 3
      Width = 79
      Height = 23
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Nome Fantasia'
      Layout = tlCenter
      ExplicitLeft = 548
    end
    object edrazaoSocial: TEdit
      AlignWithMargins = True
      Left = 96
      Top = 3
      Width = 390
      Height = 23
      Align = alLeft
      TabOrder = 0
      TextHint = 'Raz'#227'o Social'
      OnKeyPress = edrazaoSocialKeyPress
      ExplicitLeft = 79
    end
    object edfantasia: TEdit
      AlignWithMargins = True
      Left = 589
      Top = 3
      Width = 390
      Height = 23
      Align = alRight
      TabOrder = 1
      TextHint = 'Nome Fantasia'
      OnKeyPress = edfantasiaKeyPress
    end
  end
  object pnRow003: TPanel
    Left = 0
    Top = 58
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lbcontato: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 87
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Contato'
      Layout = tlCenter
    end
    object edcontato: TEdit
      AlignWithMargins = True
      Left = 96
      Top = 3
      Width = 883
      Height = 23
      Align = alClient
      TabOrder = 0
      TextHint = 'Contato'
      OnKeyPress = edcontatoKeyPress
      ExplicitLeft = 79
      ExplicitWidth = 900
    end
  end
  object pnRow004: TPanel
    Left = 0
    Top = 87
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object lbcep: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 87
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cep'
      Layout = tlCenter
    end
    object lbnumero: TLabel
      AlignWithMargins = True
      Left = 879
      Top = 3
      Width = 29
      Height = 23
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Nr.:'
      Layout = tlCenter
      ExplicitLeft = 806
    end
    object lbendereco: TLabel
      AlignWithMargins = True
      Left = 193
      Top = 3
      Width = 59
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Endere'#231'o'
      Layout = tlCenter
    end
    object edendereco: TEdit
      AlignWithMargins = True
      Left = 258
      Top = 3
      Width = 615
      Height = 23
      Align = alClient
      TabOrder = 0
      TextHint = 'Endere'#231'o'
      OnKeyPress = edenderecoKeyPress
      ExplicitLeft = 79
      ExplicitWidth = 768
    end
    object ednumero: TEdit
      AlignWithMargins = True
      Left = 914
      Top = 3
      Width = 65
      Height = 23
      Align = alRight
      TabOrder = 1
      TextHint = 'Inscri'#231#227'o Estadual'
      OnKeyPress = ednumeroKeyPress
      ExplicitLeft = 912
    end
    object edcep: TEdit
      AlignWithMargins = True
      Left = 96
      Top = 3
      Width = 91
      Height = 23
      Align = alLeft
      TabOrder = 2
      TextHint = 'CEP'
      OnExit = edcepExit
      OnKeyPress = edcepKeyPress
      ExplicitLeft = 888
    end
  end
  object pnRow005: TPanel
    Left = 0
    Top = 116
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    object lbcomplemento: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 87
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Complemento'
      Layout = tlCenter
    end
    object edcomplemento: TEdit
      AlignWithMargins = True
      Left = 96
      Top = 3
      Width = 883
      Height = 23
      Align = alClient
      TabOrder = 0
      TextHint = 'Complemento'
      OnKeyPress = edcomplementoKeyPress
      ExplicitLeft = 79
      ExplicitWidth = 768
    end
  end
  object pnRow006: TPanel
    Left = 0
    Top = 145
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 7
    ExplicitLeft = 3
    ExplicitTop = 148
    object lbbairro: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 87
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Bairro'
      Layout = tlCenter
    end
    object lbidCidade: TLabel
      AlignWithMargins = True
      Left = 420
      Top = 3
      Width = 47
      Height = 23
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cidade'
      Layout = tlCenter
      ExplicitLeft = 360
    end
    object lbsiglaUf: TLabel
      AlignWithMargins = True
      Left = 884
      Top = 3
      Width = 24
      Height = 23
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'UF'
      Layout = tlCenter
      ExplicitLeft = 885
    end
    object edbairro: TEdit
      AlignWithMargins = True
      Left = 96
      Top = 3
      Width = 318
      Height = 23
      Align = alClient
      TabOrder = 0
      TextHint = 'Bairro'
      OnKeyPress = edbairroKeyPress
      ExplicitLeft = 360
      ExplicitTop = 6
      ExplicitWidth = 258
    end
    object edidCidade: TButtonedEdit
      AlignWithMargins = True
      Left = 473
      Top = 3
      Width = 61
      Height = 23
      Align = alRight
      RightButton.Visible = True
      TabOrder = 1
      TextHint = 'Cidade'
      OnKeyPress = edidCidadeKeyPress
      OnRightButtonClick = edidCidadeRightButtonClick
      ExplicitLeft = 474
    end
    object edcidadeIbge: TEdit
      AlignWithMargins = True
      Left = 540
      Top = 3
      Width = 74
      Height = 23
      Align = alRight
      TabOrder = 2
      TextHint = 'IBGE'
      ExplicitLeft = 471
    end
    object edcidade: TEdit
      AlignWithMargins = True
      Left = 620
      Top = 3
      Width = 258
      Height = 23
      Align = alRight
      TabOrder = 3
      TextHint = 'Nome da Cidade'
      ExplicitLeft = 872
    end
    object edsiglaUf: TEdit
      AlignWithMargins = True
      Left = 914
      Top = 3
      Width = 65
      Height = 23
      Align = alRight
      TabOrder = 4
      TextHint = 'UF'
      ExplicitLeft = 905
    end
  end
  object pnRow007: TPanel
    Left = 0
    Top = 174
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 8
    ExplicitTop = 153
    object lbtelefone: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 87
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Telefone'
      Layout = tlCenter
    end
    object lbcelular: TLabel
      AlignWithMargins = True
      Left = 252
      Top = 3
      Width = 47
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Celular'
      Layout = tlCenter
      ExplicitLeft = 577
    end
    object lbemail: TLabel
      AlignWithMargins = True
      Left = 461
      Top = 3
      Width = 44
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'E-Mail'
      Layout = tlCenter
      ExplicitLeft = 874
    end
    object edtelefone: TEdit
      AlignWithMargins = True
      Left = 96
      Top = 3
      Width = 150
      Height = 23
      Align = alLeft
      TabOrder = 0
      TextHint = 'Telefonoe'
      OnKeyPress = edtelefoneKeyPress
    end
    object edcelular: TEdit
      AlignWithMargins = True
      Left = 305
      Top = 3
      Width = 150
      Height = 23
      Align = alLeft
      TabOrder = 1
      TextHint = 'Celular'
      OnKeyPress = edcelularKeyPress
    end
    object edemail: TEdit
      AlignWithMargins = True
      Left = 511
      Top = 3
      Width = 468
      Height = 23
      Align = alClient
      TabOrder = 2
      TextHint = 'E-Mail'
      ExplicitLeft = 914
      ExplicitWidth = 65
    end
  end
  object FDMem_Registro: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'id'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 432
    Top = 280
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_Registrotipo: TIntegerField
      FieldName = 'tipo'
    end
    object FDMem_RegistrorazaoSocial: TStringField
      FieldName = 'razaoSocial'
      Size = 255
    end
    object FDMem_Registrofantasia: TStringField
      FieldName = 'fantasia'
      Size = 255
    end
    object FDMem_Registrocnpj: TStringField
      FieldName = 'cnpj'
    end
    object FDMem_RegistroinscEstadual: TStringField
      FieldName = 'inscEstadual'
    end
    object FDMem_Registrocontato: TStringField
      FieldName = 'contato'
      Size = 255
    end
    object FDMem_Registroendereco: TStringField
      FieldName = 'endereco'
      Size = 255
    end
    object FDMem_Registronumero: TStringField
      FieldName = 'numero'
      Size = 50
    end
    object FDMem_Registrocomplemento: TStringField
      FieldName = 'complemento'
      Size = 255
    end
    object FDMem_Registrobairro: TStringField
      FieldName = 'bairro'
      Size = 100
    end
    object FDMem_RegistroidCidade: TIntegerField
      FieldName = 'idCidade'
    end
    object FDMem_RegistrocidadeIbge: TIntegerField
      FieldName = 'cidadeIbge'
    end
    object FDMem_Registrocidade: TStringField
      FieldName = 'cidade'
      Size = 100
    end
    object FDMem_RegistrosiglaUf: TStringField
      FieldName = 'siglaUf'
      Size = 2
    end
    object FDMem_Registrocep: TStringField
      FieldName = 'cep'
      Size = 15
    end
    object FDMem_Registrotelefone: TStringField
      FieldName = 'telefone'
    end
    object FDMem_Registrocelular: TStringField
      FieldName = 'celular'
    end
    object FDMem_Registroemail: TStringField
      FieldName = 'email'
      Size = 255
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistrotipoPessoa: TIntegerField
      FieldName = 'tipoPessoa'
    end
    object FDMem_RegistrostatusDesc: TStringField
      FieldName = 'statusDesc'
      Size = 50
    end
    object FDMem_RegistrotipoDesc: TStringField
      FieldName = 'tipoDesc'
      Size = 100
    end
    object FDMem_RegistrotipoPessoaDesc: TStringField
      FieldName = 'tipoPessoaDesc'
      Size = 100
    end
  end
end
