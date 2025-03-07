object frmCad_Fornecedor_Add: TfrmCad_Fornecedor_Add
  Left = 0
  Top = 0
  Caption = 'Cadastro de Fornecedor'
  ClientHeight = 461
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object lbID: TLabel
    Left = 48
    Top = 24
    Width = 10
    Height = 15
    Caption = 'Id'
  end
  object lbNOME: TLabel
    Left = 168
    Top = 24
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object lbPESSOA: TLabel
    Left = 22
    Top = 48
    Width = 36
    Height = 15
    Caption = 'Pessoa'
  end
  object lbDOCUMENTO: TLabel
    Left = 222
    Top = 48
    Width = 63
    Height = 15
    Caption = 'Documento'
  end
  object lbINSC_EST: TLabel
    Left = 478
    Top = 48
    Width = 71
    Height = 15
    Caption = 'Insc. Estadual'
  end
  object lbCEP: TLabel
    Left = 40
    Top = 74
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object lbENDERECO: TLabel
    Left = 236
    Top = 77
    Width = 49
    Height = 15
    Caption = 'Endere'#231'o'
  end
  object lbCOMPLEMENTO: TLabel
    Left = 208
    Top = 103
    Width = 77
    Height = 15
    Caption = 'Complemento'
  end
  object lbNUMERO: TLabel
    Left = 17
    Top = 106
    Width = 44
    Height = 15
    Caption = 'N'#250'mero'
  end
  object lbBAIRRO: TLabel
    Left = 30
    Top = 135
    Width = 31
    Height = 15
    Caption = 'Bairro'
  end
  object lbCIDADE: TLabel
    Left = 280
    Top = 135
    Width = 37
    Height = 15
    Caption = 'Cidade'
  end
  object lbUF: TLabel
    Left = 628
    Top = 135
    Width = 14
    Height = 15
    Caption = 'UF'
  end
  object lbTELEFONE: TLabel
    Left = 17
    Top = 164
    Width = 44
    Height = 15
    Caption = 'Telefone'
  end
  object lbCELULAR: TLabel
    Left = 273
    Top = 164
    Width = 37
    Height = 15
    Caption = 'Celular'
  end
  object lbEMAIL: TLabel
    Left = 17
    Top = 193
    Width = 34
    Height = 15
    Caption = 'E-Mail'
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
  object edNome: TEdit
    Left = 210
    Top = 16
    Width = 719
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object edDOCUMENTO: TEdit
    Left = 291
    Top = 45
    Width = 174
    Height = 23
    TabOrder = 2
    OnExit = edDOCUMENTOExit
  end
  object cbPESSOA: TComboBox
    Left = 67
    Top = 45
    Width = 126
    Height = 23
    TabOrder = 3
    Items.Strings = (
      'F'#205'SICA'
      'JUR'#205'DICA')
  end
  object edINSC_EST: TEdit
    Left = 555
    Top = 45
    Width = 374
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 4
  end
  object edCEP: TEdit
    Left = 67
    Top = 74
    Width = 126
    Height = 23
    TabOrder = 5
  end
  object edENDERECO: TEdit
    Left = 291
    Top = 74
    Width = 638
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object edCOMPLEMENTO: TEdit
    Left = 291
    Top = 103
    Width = 638
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 7
  end
  object edNUMERO: TEdit
    Left = 67
    Top = 103
    Width = 126
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 8
  end
  object edBAIRRO: TEdit
    Left = 67
    Top = 132
    Width = 182
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 9
  end
  object edCIDADE: TEdit
    Left = 323
    Top = 132
    Width = 262
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 10
  end
  object cbUF: TComboBox
    Left = 848
    Top = 132
    Width = 81
    Height = 23
    TabOrder = 11
    Items.Strings = (
      'AC'
      'AL'
      'AP'
      'AM'
      'BA'
      'CE'
      'DF'
      'ES'
      'GO'
      'MA'
      'MT'
      'MS'
      'MG'
      'PA'
      'PB'
      'PR'
      'PE'
      'PI'
      'RJ'
      'RN'
      'RS'
      'RO'
      'RR'
      'SC'
      'SP'
      'SE'
      'TO')
  end
  object edTELEFONE: TEdit
    Left = 67
    Top = 161
    Width = 182
    Height = 23
    TabOrder = 12
  end
  object edCELULAR: TEdit
    Left = 323
    Top = 161
    Width = 182
    Height = 23
    TabOrder = 13
  end
  object edEMAIL: TEdit
    Left = 67
    Top = 190
    Width = 862
    Height = 23
    CharCase = ecLowerCase
    TabOrder = 14
  end
  object btConfirmar: TButton
    Left = 319
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Confirmar'
    TabOrder = 15
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 471
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Cancelar'
    TabOrder = 16
    OnClick = btCancelarClick
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
    Left = 688
    Top = 248
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 255
    end
    object FDMem_RegistroPESSOA: TIntegerField
      DisplayLabel = 'Pessoa'
      FieldName = 'PESSOA'
    end
    object FDMem_RegistroDOCUMENTO: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'DOCUMENTO'
    end
    object FDMem_RegistroINSC_EST: TStringField
      DisplayLabel = 'Insc. Estadual'
      FieldName = 'INSC_EST'
    end
    object FDMem_RegistroCEP: TStringField
      DisplayLabel = 'Cep'
      FieldName = 'CEP'
      Size = 10
    end
    object FDMem_RegistroENDERECO: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      Size = 255
    end
    object FDMem_RegistroCOMPLEMENTO: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMPLEMENTO'
      Size = 255
    end
    object FDMem_RegistroNUMERO: TStringField
      DisplayLabel = 'Nr'
      FieldName = 'NUMERO'
      Size = 255
    end
    object FDMem_RegistroBAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 100
    end
    object FDMem_RegistroCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 100
    end
    object FDMem_RegistroUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object FDMem_RegistroTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
    end
    object FDMem_RegistroCELULAR: TStringField
      DisplayLabel = 'Celular'
      FieldName = 'CELULAR'
    end
    object FDMem_RegistroEMAIL: TStringField
      DisplayLabel = 'E-Mail'
      FieldName = 'EMAIL'
      Size = 255
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroPESSOA_DESC: TStringField
      DisplayLabel = 'Pessoa'
      FieldName = 'PESSOA_DESC'
    end
  end
end
