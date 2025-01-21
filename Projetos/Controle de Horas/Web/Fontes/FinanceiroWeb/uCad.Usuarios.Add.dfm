object frmCad_Usuario_ADD: TfrmCad_Usuario_ADD
  Left = 0
  Top = 0
  Caption = 'Cadastro de Usu'#225'rios'
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
    Left = 67
    Top = 16
    Width = 11
    Height = 15
    Caption = 'ID'
    FocusControl = edID
  end
  object lbNOME: TLabel
    Left = 45
    Top = 45
    Width = 33
    Height = 15
    Caption = 'Nome'
    FocusControl = edNOME
  end
  object lbLOGIN: TLabel
    Left = 48
    Top = 74
    Width = 30
    Height = 15
    Caption = 'Login'
    FocusControl = edLOGIN
  end
  object lbSENHA: TLabel
    Left = 370
    Top = 74
    Width = 32
    Height = 15
    Caption = 'Senha'
    FocusControl = edSENHA
  end
  object lbPIN: TLabel
    Left = 713
    Top = 74
    Width = 19
    Height = 15
    Caption = 'PIN'
    FocusControl = edPIN
  end
  object lbCELULAR: TLabel
    Left = 41
    Top = 103
    Width = 37
    Height = 15
    Caption = 'Celular'
    FocusControl = edCELULAR
  end
  object lbEMAIL: TLabel
    Left = 256
    Top = 103
    Width = 34
    Height = 15
    Caption = 'E-Mail'
    FocusControl = edEMAIL
  end
  object lbID_EMPRESA: TLabel
    Left = 20
    Top = 127
    Width = 58
    Height = 15
    Caption = 'Id Empresa'
    FocusControl = edID_EMPRESA
  end
  object lbID_PRESTADOR_SERVICO: TLabel
    Left = 9
    Top = 153
    Width = 66
    Height = 15
    Caption = 'Id. Prestador'
    FocusControl = edID_PRESTADOR_SERVICO
  end
  object lbFOTO: TLabel
    Left = 55
    Top = 243
    Width = 24
    Height = 15
    Caption = 'Foto'
    FocusControl = edFOTO
  end
  object lbEMPRESA: TLabel
    Left = 196
    Top = 127
    Width = 45
    Height = 15
    Caption = 'Empresa'
    FocusControl = edEMPRESA
  end
  object lbPRESTADOR_SERVICO: TLabel
    Left = 196
    Top = 156
    Width = 50
    Height = 15
    Caption = 'Prestador'
    FocusControl = edPRESTADOR_SERVICO
  end
  object lbTIPO: TLabel
    Left = 643
    Top = 8
    Width = 23
    Height = 15
    Caption = 'Tipo'
    FocusControl = edID
  end
  object lbID_CLIENTE: TLabel
    Left = 9
    Top = 182
    Width = 53
    Height = 15
    Caption = 'Id. Cliente'
    FocusControl = edID_CLIENTE
  end
  object lbCLIENTE: TLabel
    Left = 196
    Top = 185
    Width = 37
    Height = 15
    Caption = 'Cliente'
    FocusControl = edCLIENTE
  end
  object lbFORM_INICIAL: TLabel
    Left = 8
    Top = 214
    Width = 92
    Height = 15
    Caption = 'Formul'#225'rio inicial'
    FocusControl = edFORM_INICIAL
  end
  object edID: TDBEdit
    Left = 84
    Top = 8
    Width = 65
    Height = 23
    DataField = 'ID'
    DataSource = dmRegistro
    ReadOnly = True
    TabOrder = 0
  end
  object edNOME: TDBEdit
    Left = 84
    Top = 37
    Width = 718
    Height = 23
    CharCase = ecUpperCase
    DataField = 'NOME'
    DataSource = dmRegistro
    TabOrder = 1
  end
  object edLOGIN: TDBEdit
    Left = 84
    Top = 66
    Width = 269
    Height = 23
    DataField = 'LOGIN'
    DataSource = dmRegistro
    TabOrder = 2
  end
  object edSENHA: TDBEdit
    Left = 408
    Top = 66
    Width = 274
    Height = 23
    DataField = 'SENHA'
    DataSource = dmRegistro
    PasswordChar = '#'
    TabOrder = 3
  end
  object edPIN: TDBEdit
    Left = 738
    Top = 66
    Width = 64
    Height = 23
    DataField = 'PIN'
    DataSource = dmRegistro
    PasswordChar = '#'
    TabOrder = 4
  end
  object edCELULAR: TDBEdit
    Left = 84
    Top = 95
    Width = 157
    Height = 23
    DataField = 'CELULAR'
    DataSource = dmRegistro
    TabOrder = 5
  end
  object edEMAIL: TDBEdit
    Left = 296
    Top = 95
    Width = 506
    Height = 23
    CharCase = ecLowerCase
    DataField = 'EMAIL'
    DataSource = dmRegistro
    TabOrder = 6
  end
  object edID_EMPRESA: TDBEdit
    Left = 84
    Top = 124
    Width = 101
    Height = 23
    DataField = 'ID_EMPRESA'
    DataSource = dmRegistro
    TabOrder = 7
  end
  object edID_PRESTADOR_SERVICO: TDBEdit
    Left = 84
    Top = 153
    Width = 101
    Height = 23
    DataField = 'ID_PRESTADOR_SERVICO'
    DataSource = dmRegistro
    TabOrder = 8
  end
  object edFOTO: TDBEdit
    Left = 85
    Top = 240
    Width = 717
    Height = 23
    DataField = 'FOTO'
    DataSource = dmRegistro
    TabOrder = 9
  end
  object edEMPRESA: TDBEdit
    Left = 256
    Top = 124
    Width = 546
    Height = 23
    DataField = 'EMPRESA'
    DataSource = dmRegistro
    ReadOnly = True
    TabOrder = 10
  end
  object edPRESTADOR_SERVICO: TDBEdit
    Left = 256
    Top = 153
    Width = 546
    Height = 23
    DataField = 'PRESTADOR_SERVICO'
    DataSource = dmRegistro
    ReadOnly = True
    TabOrder = 11
  end
  object btConfirmar: TButton
    Left = 312
    Top = 368
    Width = 100
    Height = 30
    Caption = 'Confirmar'
    TabOrder = 12
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 439
    Top = 368
    Width = 100
    Height = 30
    Caption = 'Cancelar'
    TabOrder = 13
    OnClick = btCancelarClick
  end
  object cbTIPO: TDBComboBox
    Left = 673
    Top = 8
    Width = 129
    Height = 23
    DataField = 'TIPO'
    DataSource = dmRegistro
    Items.Strings = (
      'ADMINISTRADOR'
      'NORMAL'
      'CLIENTE')
    TabOrder = 14
  end
  object edID_CLIENTE: TDBEdit
    Left = 84
    Top = 182
    Width = 101
    Height = 23
    DataField = 'ID_CLIENTE'
    DataSource = dmRegistro
    TabOrder = 15
  end
  object edCLIENTE: TDBEdit
    Left = 256
    Top = 182
    Width = 546
    Height = 23
    DataField = 'CLIENTE'
    DataSource = dmRegistro
    ReadOnly = True
    TabOrder = 16
  end
  object edFORM_INICIAL: TDBEdit
    Left = 106
    Top = 211
    Width = 696
    Height = 23
    DataField = 'FORM_INICIAL'
    DataSource = dmRegistro
    TabOrder = 17
  end
  object FDMem_Registro: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 904
    Top = 96
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 100
    end
    object FDMem_RegistroLOGIN: TStringField
      DisplayLabel = 'Login'
      FieldName = 'LOGIN'
      Size = 50
    end
    object FDMem_RegistroSENHA: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      Size = 50
    end
    object FDMem_RegistroPIN: TStringField
      FieldName = 'PIN'
      Size = 4
    end
    object FDMem_RegistroCELULAR: TStringField
      DisplayLabel = 'Celular'
      FieldName = 'CELULAR'
      EditMask = '!\(99\)00000-0000;1; '
      Size = 15
    end
    object FDMem_RegistroEMAIL: TStringField
      DisplayLabel = 'E-Mail'
      FieldName = 'EMAIL'
      Size = 255
    end
    object FDMem_RegistroID_EMPRESA: TIntegerField
      DisplayLabel = 'Id Empresa'
      FieldName = 'ID_EMPRESA'
    end
    object FDMem_RegistroID_PRESTADOR_SERVICO: TIntegerField
      DisplayLabel = 'Id Prestador de Servi'#231'o'
      FieldName = 'ID_PRESTADOR_SERVICO'
    end
    object FDMem_RegistroFOTO: TStringField
      DisplayLabel = 'Foto'
      FieldName = 'FOTO'
      Size = 255
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      DisplayLabel = 'Dt. Cadastro'
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      DisplayLabel = 'Hr. Cadastro'
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroSINCRONIZADO: TIntegerField
      DisplayLabel = 'Sincronizado'
      FieldName = 'SINCRONIZADO'
    end
    object FDMem_RegistroEMPRESA: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMPRESA'
      Size = 255
    end
    object FDMem_RegistroPRESTADOR_SERVICO: TStringField
      DisplayLabel = 'Prestador de Servi'#231'o'
      FieldName = 'PRESTADOR_SERVICO'
      Size = 100
    end
    object FDMem_RegistroTIPO: TIntegerField
      FieldName = 'TIPO'
    end
    object FDMem_RegistroID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object FDMem_RegistroFORM_INICIAL: TStringField
      FieldName = 'FORM_INICIAL'
      Size = 255
    end
    object FDMem_RegistroCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 255
    end
    object FDMem_RegistroTIPO_DESC: TStringField
      FieldName = 'TIPO_DESC'
      Size = 255
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 904
    Top = 40
  end
end
