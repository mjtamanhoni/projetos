object frmCad_PrestServico_Add: TfrmCad_PrestServico_Add
  Left = 0
  Top = 0
  Caption = 'Cadastro de Prestador de Servi'#231'o'
  ClientHeight = 281
  ClientWidth = 952
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
  object lbNOME: TLabel
    Left = 168
    Top = 24
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object lbCELULAR: TLabel
    Left = 17
    Top = 48
    Width = 37
    Height = 15
    Caption = 'Celular'
  end
  object lbEMAIL: TLabel
    Left = 17
    Top = 77
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
  object edCELULAR: TEdit
    Left = 67
    Top = 45
    Width = 182
    Height = 23
    TabOrder = 2
  end
  object edEMAIL: TEdit
    Left = 67
    Top = 74
    Width = 862
    Height = 23
    CharCase = ecLowerCase
    TabOrder = 3
  end
  object btConfirmar: TButton
    Left = 311
    Top = 144
    Width = 100
    Height = 30
    Caption = 'Confirmar'
    TabOrder = 4
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 463
    Top = 144
    Width = 100
    Height = 30
    Caption = 'Cancelar'
    TabOrder = 5
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
    Left = 664
    Top = 101
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object FDMem_RegistroCELULAR: TStringField
      FieldName = 'CELULAR'
    end
    object FDMem_RegistroEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHF_CADASTRO: TTimeField
      FieldName = 'HF_CADASTRO'
    end
  end
end
