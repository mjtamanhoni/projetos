object frmCad_TabPreco_Add: TfrmCad_TabPreco_Add
  Left = 0
  Top = 0
  Caption = 'Cadastro de Tabela de Pagamento'
  ClientHeight = 461
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lbID: TLabel
    Left = 48
    Top = 24
    Width = 10
    Height = 15
    Caption = 'Id'
  end
  object lbDESCRICAO: TLabel
    Left = 168
    Top = 24
    Width = 51
    Height = 15
    Caption = 'Descri'#231#227'o'
  end
  object lbTIPO: TLabel
    Left = 22
    Top = 48
    Width = 23
    Height = 15
    Caption = 'Tipo'
  end
  object lbVALOR: TLabel
    Left = 222
    Top = 48
    Width = 26
    Height = 15
    Caption = 'Valor'
  end
  object lbTOTAL_HORAS_PREVISTA: TLabel
    Left = 486
    Top = 48
    Width = 78
    Height = 15
    Caption = 'Total de Horas:'
  end
  object edID: TEdit
    Left = 67
    Top = 16
    Width = 78
    Height = 23
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 0
  end
  object edDESCRICAO: TEdit
    Left = 225
    Top = 16
    Width = 704
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object edVALOR: TEdit
    Left = 254
    Top = 45
    Width = 174
    Height = 23
    TabOrder = 2
  end
  object cbTIPO: TComboBox
    Left = 67
    Top = 45
    Width = 126
    Height = 23
    TabOrder = 3
    Items.Strings = (
      'HORAS'
      'FIXO')
  end
  object btConfirmar: TButton
    Left = 319
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Confirmar'
    TabOrder = 4
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 471
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btCancelarClick
  end
  object edTOTAL_HORAS_PREVISTA: TEdit
    Left = 570
    Top = 45
    Width = 174
    Height = 23
    TabOrder = 6
  end
  object FDMem_Registro: TFDMemTable
    IndexFieldNames = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 264
    Top = 160
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object FDMem_RegistroTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Size = 100
    end
    object FDMem_RegistroVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroTIPO_DESC: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_DESC'
      Size = 100
    end
    object FDMem_RegistroTOTAL_HORAS_PREVISTA: TStringField
      DisplayLabel = 'Total de Horas'
      FieldName = 'TOTAL_HORAS_PREVISTA'
      Size = 10
    end
  end
end
