object frmCad_CondPagto_Add: TfrmCad_CondPagto_Add
  Left = 0
  Top = 0
  Caption = 'Cadastro de Condi'#231#245'es de Pagamento'
  ClientHeight = 460
  ClientWidth = 980
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
  object lbTIPO_INTERVALO: TLabel
    Left = 206
    Top = 53
    Width = 72
    Height = 15
    Caption = 'Tipo Intervalo'
  end
  object lbPARCELAS: TLabel
    Left = 32
    Top = 45
    Width = 43
    Height = 15
    Caption = 'Parcelas'
  end
  object lbINTEVALOR: TLabel
    Left = 456
    Top = 50
    Width = 46
    Height = 15
    Caption = 'Intervalo'
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
  object edPARCELAS: TEdit
    Left = 81
    Top = 45
    Width = 78
    Height = 23
    TabOrder = 2
  end
  object cbTIPO_INTERVALO: TComboBox
    Left = 293
    Top = 45
    Width = 126
    Height = 23
    TabOrder = 3
    Items.Strings = (
      'DIAS'
      'MESES')
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
  object edINTEVALOR: TEdit
    Left = 508
    Top = 45
    Width = 78
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
      Size = 255
    end
    object FDMem_RegistroPARCELAS: TIntegerField
      DisplayLabel = 'Parcelas'
      FieldName = 'PARCELAS'
    end
    object FDMem_RegistroTIPO_INTERVALO: TIntegerField
      DisplayLabel = 'Tipo Intervalo'
      FieldName = 'TIPO_INTERVALO'
    end
    object FDMem_RegistroINTEVALOR: TIntegerField
      DisplayLabel = 'Intervalo'
      FieldName = 'INTEVALOR'
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroTIPO_INTERVALO_DESC: TStringField
      DisplayLabel = 'Tipo Intervalo'
      FieldName = 'TIPO_INTERVALO_DESC'
      Size = 100
    end
  end
end
