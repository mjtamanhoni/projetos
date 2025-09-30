object frmUnidadeFederativa_Cad: TfrmUnidadeFederativa_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Unidades Federativas'
  ClientHeight = 567
  ClientWidth = 1013
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
    Left = 902
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = btCancelarClick
  end
  object btConfirmar: TButton
    Left = 821
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btConfirmarClick
  end
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 1013
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lbid: TLabel
      Left = 82
      Top = 13
      Width = 10
      Height = 15
      Caption = 'Id'
    end
    object lbibge: TLabel
      Left = 493
      Top = 13
      Width = 24
      Height = 15
      Caption = 'IBGE'
    end
    object lbsigla: TLabel
      Left = 873
      Top = 11
      Width = 25
      Height = 15
      Caption = 'Sigla'
    end
    object edid: TEdit
      Left = 98
      Top = 12
      Width = 89
      Height = 23
      Enabled = False
      TabOrder = 0
      TextHint = 'Id'
      OnKeyPress = edidKeyPress
    end
    object edibge: TEdit
      Left = 523
      Top = 12
      Width = 81
      Height = 23
      NumbersOnly = True
      TabOrder = 1
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = edibgeKeyPress
    end
    object edsigla: TEdit
      Left = 912
      Top = 8
      Width = 65
      Height = 23
      TabOrder = 2
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = edsiglaKeyPress
    end
  end
  object pnRow002: TPanel
    Left = 0
    Top = 82
    Width = 1013
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lbidRegiao: TLabel
      Left = 54
      Top = 6
      Width = 36
      Height = 15
      Caption = 'Regi'#227'o'
    end
    object edidRegiao_Desc: TEdit
      Left = 193
      Top = 6
      Width = 784
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 1
      TextHint = 'Regi'#227'o brasileira'
    end
    object edidRegiao: TButtonedEdit
      Left = 98
      Top = 6
      Width = 89
      Height = 23
      RightButton.Visible = True
      TabOrder = 0
      TextHint = 'Regi'#227'o'
      OnRightButtonClick = edidRegiaoRightButtonClick
    end
  end
  object pnRow003: TPanel
    Left = 0
    Top = 41
    Width = 1013
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lbcapital: TLabel
      Left = 581
      Top = 6
      Width = 37
      Height = 15
      Caption = 'Capital'
    end
    object lbdescricao: TLabel
      Left = 41
      Top = 7
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object edcapital: TEdit
      Left = 624
      Top = 6
      Width = 353
      Height = 23
      TabOrder = 0
      TextHint = 'Informe a Capital'
      OnKeyPress = edcapitalKeyPress
    end
    object eddescricao: TEdit
      Left = 98
      Top = 6
      Width = 432
      Height = 23
      TabOrder = 1
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = eddescricaoKeyPress
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
    object FDMem_RegistroidRegiao: TIntegerField
      FieldName = 'idRegiao'
    end
    object FDMem_Registroibge: TIntegerField
      FieldName = 'ibge'
    end
    object FDMem_Registrosigla: TStringField
      FieldName = 'sigla'
      Size = 2
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
    object FDMem_Registrocapital: TStringField
      FieldName = 'capital'
      Size = 100
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistronomeRegiao: TStringField
      FieldName = 'nomeRegiao'
      Size = 100
    end
  end
end
