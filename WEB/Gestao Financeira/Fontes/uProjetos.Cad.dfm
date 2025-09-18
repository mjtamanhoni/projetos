object frmProjetos_Cad: TfrmProjetos_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Projetos'
  ClientHeight = 527
  ClientWidth = 929
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 929
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbid: TLabel
      Left = 8
      Top = 13
      Width = 10
      Height = 15
      Caption = 'Id'
    end
    object lbdescricao: TLabel
      Left = 136
      Top = 13
      Width = 54
      Height = 15
      Caption = 'Descri'#231#227'o:'
    end
    object lbStatus: TLabel
      Left = 760
      Top = 13
      Width = 32
      Height = 15
      Caption = 'Status'
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
    object eddescricao: TEdit
      Left = 196
      Top = 10
      Width = 541
      Height = 23
      TabOrder = 1
      TextHint = 'Informe a Descri'#231#227'o'
    end
    object cbstatus: TComboBox
      Left = 798
      Top = 10
      Width = 115
      Height = 23
      TabOrder = 2
      Text = 'Selecione'
      Items.Strings = (
        'INATIVO'
        'ATIVO')
    end
  end
  object btConfirmar: TButton
    Left = 749
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 830
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btCancelarClick
  end
  object FDMem_Registro: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 424
    Top = 240
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 255
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
  end
end
