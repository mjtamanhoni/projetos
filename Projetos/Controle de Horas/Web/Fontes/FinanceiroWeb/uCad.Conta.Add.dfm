object frmCad_Conta_Add: TfrmCad_Conta_Add
  Left = 0
  Top = 0
  Caption = 'Cadastro de Contas'
  ClientHeight = 460
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
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
    Left = 374
    Top = 48
    Width = 23
    Height = 15
    Caption = 'Tipo'
  end
  object lbSTATUS: TLabel
    Left = 22
    Top = 48
    Width = 32
    Height = 15
    Caption = 'Status'
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
  object cbTIPO: TComboBox
    Left = 419
    Top = 45
    Width = 126
    Height = 23
    TabOrder = 2
    Items.Strings = (
      'CR'#201'DITO'
      'D'#201'BITO')
  end
  object btConfirmar: TButton
    Left = 319
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Confirmar'
    TabOrder = 3
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 471
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btCancelarClick
  end
  object cbSTATUS: TComboBox
    Left = 67
    Top = 45
    Width = 126
    Height = 23
    TabOrder = 5
    Items.Strings = (
      'INATIVO'
      'ATIVO')
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
    Left = 664
    Top = 120
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroSTATUS: TIntegerField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
    end
    object FDMem_RegistroDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 255
    end
    object FDMem_RegistroTIPO: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroSTATUS_DESC: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS_DESC'
      Size = 100
    end
    object FDMem_RegistroTIPO_DESC: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_DESC'
      Size = 100
    end
  end
end
