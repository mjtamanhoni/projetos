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
  TextHeight = 15
  object btCancelar: TButton
    Left = 743
    Top = 460
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
  end
  object btConfirmar: TButton
    Left = 646
    Top = 460
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
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
      Width = 70
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Id'
      Layout = tlCenter
    end
    object lbstatus: TLabel
      AlignWithMargins = True
      Left = 174
      Top = 3
      Width = 42
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Status'
      Layout = tlCenter
    end
    object lbtipo: TLabel
      AlignWithMargins = True
      Left = 343
      Top = 3
      Width = 33
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Tipo'
      Layout = tlCenter
      ExplicitLeft = 333
    end
    object lbcnpj: TLabel
      AlignWithMargins = True
      Left = 557
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
      Left = 744
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
    object edid: TEdit
      AlignWithMargins = True
      Left = 79
      Top = 3
      Width = 89
      Height = 23
      Align = alLeft
      Enabled = False
      TabOrder = 0
      TextHint = 'Id'
      ExplicitLeft = 98
      ExplicitTop = 10
    end
    object cbstatus: TComboBox
      AlignWithMargins = True
      Left = 222
      Top = 3
      Width = 115
      Height = 23
      Align = alLeft
      TabOrder = 1
      Text = 'Selecione'
      Items.Strings = (
        'INATIVO'
        'ATIVO')
      ExplicitLeft = 249
      ExplicitTop = 12
    end
    object cbtipo: TComboBox
      AlignWithMargins = True
      Left = 382
      Top = 3
      Width = 115
      Height = 23
      Align = alLeft
      TabOrder = 2
      Text = 'Selecione'
      Items.Strings = (
        'MATRIZ'
        'FILIAL')
      ExplicitLeft = 425
      ExplicitTop = 12
    end
    object edcnpj: TEdit
      AlignWithMargins = True
      Left = 590
      Top = 3
      Width = 148
      Height = 23
      Align = alRight
      TabOrder = 3
      TextHint = 'CNPJ'
      ExplicitLeft = 601
    end
    object edinscEstadual: TEdit
      AlignWithMargins = True
      Left = 831
      Top = 3
      Width = 148
      Height = 23
      Align = alRight
      TabOrder = 4
      TextHint = 'Inscri'#231#227'o Estadual'
      ExplicitLeft = 832
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
    ExplicitTop = 26
    object lbrazaoSocial: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 70
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
      Left = 79
      Top = 3
      Width = 390
      Height = 23
      Align = alLeft
      TabOrder = 0
      TextHint = 'Raz'#227'o Social'
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
      ExplicitLeft = 599
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
      Width = 70
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Contato'
      Layout = tlCenter
    end
    object edemail: TEdit
      AlignWithMargins = True
      Left = 79
      Top = 3
      Width = 900
      Height = 23
      Align = alClient
      TabOrder = 0
      TextHint = 'E-Mail do Usu'#225'rio'
      ExplicitLeft = 98
      ExplicitTop = 0
      ExplicitWidth = 568
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
    ExplicitTop = 66
    object lbendereco: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 32
      Width = 70
      Height = -6
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Endere'#231'o'
      Layout = tlCenter
      ExplicitTop = 3
      ExplicitHeight = 23
    end
    object lbnumero: TLabel
      AlignWithMargins = True
      Left = 853
      Top = 32
      Width = 29
      Height = -6
      Align = alRight
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Nr.:'
      Layout = tlCenter
      ExplicitLeft = 806
      ExplicitTop = 3
      ExplicitHeight = 23
    end
    object edendereco: TEdit
      AlignWithMargins = True
      Left = 79
      Top = 32
      Width = 768
      Height = 0
      Align = alClient
      TabOrder = 0
      TextHint = 'Endere'#231'o'
      ExplicitTop = 3
      ExplicitWidth = 900
      ExplicitHeight = 23
    end
    object ednumero: TEdit
      AlignWithMargins = True
      Left = 888
      Top = 32
      Width = 91
      Height = 0
      Align = alRight
      TabOrder = 1
      TextHint = 'Inscri'#231#227'o Estadual'
      ExplicitTop = 3
      ExplicitHeight = 23
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 116
    Width = 982
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    ExplicitTop = 95
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 70
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Endere'#231'o'
      Layout = tlCenter
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 853
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
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 79
      Top = 3
      Width = 768
      Height = 23
      Align = alClient
      TabOrder = 0
      TextHint = 'Endere'#231'o'
    end
    object Edit2: TEdit
      AlignWithMargins = True
      Left = 888
      Top = 3
      Width = 91
      Height = 23
      Align = alRight
      TabOrder = 1
      TextHint = 'Inscri'#231#227'o Estadual'
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
