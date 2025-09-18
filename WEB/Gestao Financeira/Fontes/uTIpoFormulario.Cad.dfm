object frmTipoFormulario_Cad: TfrmTipoFormulario_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Tipo de Formul'#225'rio'
  ClientHeight = 526
  ClientWidth = 987
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
    Top = 207
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = btCancelarClick
  end
  object btConfirmar: TButton
    Left = 823
    Top = 207
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btConfirmarClick
  end
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 987
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 929
    object lbid: TLabel
      Left = 8
      Top = 13
      Width = 10
      Height = 15
      Caption = 'Id'
    end
    object lbStatus: TLabel
      Left = 144
      Top = 15
      Width = 32
      Height = 15
      Caption = 'Status'
    end
    object lbtipo: TLabel
      Left = 358
      Top = 15
      Width = 23
      Height = 15
      Caption = 'Tipo'
    end
    object edid: TEdit
      Left = 24
      Top = 10
      Width = 89
      Height = 23
      Enabled = False
      TabOrder = 0
      TextHint = 'Id'
    end
    object cbstatus: TComboBox
      Left = 182
      Top = 12
      Width = 115
      Height = 23
      TabOrder = 1
      Text = 'Selecione'
      Items.Strings = (
        'INATIVO'
        'ATIVO')
    end
    object cbtipo: TComboBox
      Left = 387
      Top = 12
      Width = 126
      Height = 23
      TabOrder = 2
      Text = 'Selecione'
      Items.Strings = (
        'LOGIN'
        'CONFIG'
        'PRINCIPAL'
        'CADASTRO'
        'MOVIMENTO'
        'RELATORIO'
        'CONSULTA'
        'DASHBOARD')
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 987
    Height = 128
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lbdescricao: TLabel
      Left = 8
      Top = 6
      Width = 54
      Height = 15
      Caption = 'Descri'#231#227'o:'
    end
    object edDescricao: TMemo
      Left = 68
      Top = 6
      Width = 909
      Height = 89
      CharCase = ecUpperCase
      ScrollBars = ssVertical
      TabOrder = 0
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
    Left = 312
    Top = 192
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_Registrotipo: TStringField
      FieldName = 'tipo'
      Size = 255
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 500
    end
    object FDMem_Registrodt_cadastro: TDateField
      FieldName = 'dt_cadastro'
    end
    object FDMem_Registrohr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
    end
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_Registrostatus_desc: TStringField
      FieldName = 'status_desc'
      Size = 10
    end
    object FDMem_Registrotipo_desc: TStringField
      FieldName = 'tipo_desc'
      Size = 50
    end
  end
end
