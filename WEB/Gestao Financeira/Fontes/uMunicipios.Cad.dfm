object frmMunicipios_Cad: TfrmMunicipios_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Munic'#237'pios'
  ClientHeight = 441
  ClientWidth = 1001
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object btCancelar: TButton
    Left = 902
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
  end
  object btConfirmar: TButton
    Left = 821
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
  end
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 1001
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 624
    object lbid: TLabel
      Left = 82
      Top = 20
      Width = 10
      Height = 15
      Caption = 'Id'
    end
    object lbibge: TLabel
      Left = 594
      Top = 13
      Width = 24
      Height = 15
      Caption = 'IBGE'
    end
    object lbidUf: TLabel
      Left = 230
      Top = 20
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object lbcepPadrao: TLabel
      Left = 829
      Top = 13
      Width = 61
      Height = 15
      Caption = 'CEP Padr'#227'o'
    end
    object edid: TEdit
      Left = 98
      Top = 12
      Width = 89
      Height = 23
      Enabled = False
      TabOrder = 0
      TextHint = 'Id'
    end
    object edibge: TEdit
      Left = 624
      Top = 12
      Width = 81
      Height = 23
      NumbersOnly = True
      TabOrder = 1
      TextHint = 'IBGE'
    end
    object edidUf: TButtonedEdit
      Left = 250
      Top = 12
      Width = 47
      Height = 23
      RightButton.Visible = True
      TabOrder = 2
      TextHint = 'UF'
    end
    object edsiglaUf: TEdit
      Left = 303
      Top = 12
      Width = 50
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 3
      TextHint = 'UF'
    end
    object edidUf_Desc: TEdit
      Left = 359
      Top = 12
      Width = 171
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 4
      TextHint = 'Unidade Federativa'
    end
    object edcepPadrao: TEdit
      Left = 896
      Top = 12
      Width = 81
      Height = 23
      NumbersOnly = True
      TabOrder = 5
      TextHint = 'Cep Padr'#227'o'
    end
  end
  object pnRow003: TPanel
    Left = 0
    Top = 41
    Width = 1001
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 624
    object lbdescricao: TLabel
      Left = 41
      Top = 7
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object eddescricao: TEdit
      Left = 98
      Top = 6
      Width = 879
      Height = 23
      TabOrder = 0
      TextHint = 'Informe a Descri'#231#227'o'
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
    Top = 240
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_RegistroidUf: TIntegerField
      FieldName = 'idUf'
    end
    object FDMem_RegistrosiglaUf: TStringField
      FieldName = 'siglaUf'
      Size = 2
    end
    object FDMem_Registroibge: TIntegerField
      FieldName = 'ibge'
    end
    object FDMem_RegistrocepPadrao: TStringField
      FieldName = 'cepPadrao'
      Size = 15
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistrounidadeFederativa: TStringField
      FieldName = 'unidadeFederativa'
      Size = 100
    end
    object FDMem_Registroregiao: TStringField
      FieldName = 'regiao'
      Size = 100
    end
  end
end
