object frmForm_Projeto_Cad: TfrmForm_Projeto_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Formul'#225'rio do Projeto'
  ClientHeight = 626
  ClientWidth = 997
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
    Top = 186
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btCancelarClick
  end
  object btConfirmar: TButton
    Left = 821
    Top = 186
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 4
    OnClick = btConfirmarClick
  end
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 997
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbid: TLabel
      Left = 82
      Top = 13
      Width = 10
      Height = 15
      Caption = 'Id'
    end
    object lbnome_form: TLabel
      Left = 370
      Top = 13
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lbStatus: TLabel
      Left = 211
      Top = 13
      Width = 32
      Height = 15
      Caption = 'Status'
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
    object ednome_form: TEdit
      Left = 409
      Top = 10
      Width = 568
      Height = 23
      TabOrder = 1
      TextHint = 'Informe a Descri'#231#227'o'
    end
    object cbstatus: TComboBox
      Left = 249
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
  object pnRow004: TPanel
    Left = 0
    Top = 123
    Width = 997
    Height = 98
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 82
    object lbdescricao: TLabel
      Left = 38
      Top = 6
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object eddescricao: TMemo
      Left = 98
      Top = 6
      Width = 879
      Height = 89
      CharCase = ecUpperCase
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object pnRow003: TPanel
    Left = 0
    Top = 82
    Width = 997
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 41
    object lbid_tipo_form: TLabel
      Left = 8
      Top = 6
      Width = 84
      Height = 15
      Caption = 'Tipo Formul'#225'rio'
    end
    object edid_tipo_form_Desc: TEdit
      Left = 193
      Top = 6
      Width = 784
      Height = 23
      ReadOnly = True
      TabOrder = 0
      TextHint = 'Descri'#231#227'o do tipo do Formul'#225'rio'
    end
    object edid_tipo_form: TButtonedEdit
      Left = 98
      Top = 6
      Width = 89
      Height = 23
      RightButton.Visible = True
      TabOrder = 1
      TextHint = 'Tipo Form'
    end
  end
  object pnRow002: TPanel
    Left = 0
    Top = 41
    Width = 997
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitTop = 34
    object lbid_projeto: TLabel
      Left = 54
      Top = 6
      Width = 38
      Height = 15
      Caption = 'Projeto'
    end
    object edid_projeto_Desc: TEdit
      Left = 193
      Top = 6
      Width = 784
      Height = 23
      ReadOnly = True
      TabOrder = 0
      TextHint = 'Descri'#231#227'o do Projeto'
    end
    object edid_projeto: TButtonedEdit
      Left = 98
      Top = 6
      Width = 89
      Height = 23
      RightButton.Visible = True
      TabOrder = 1
      TextHint = 'Projeto'
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
    Left = 424
    Top = 240
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_Registroid_projeto: TIntegerField
      FieldName = 'id_projeto'
    end
    object FDMem_Registronome_form: TStringField
      FieldName = 'nome_form'
      Size = 255
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 255
    end
    object FDMem_Registroid_tipo_form: TIntegerField
      FieldName = 'id_tipo_form'
    end
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_Registrostatus_desc: TStringField
      FieldName = 'status_desc'
      Size = 10
    end
    object FDMem_Registroid_tipo_form_desc: TStringField
      FieldName = 'id_tipo_form_desc'
      Size = 500
    end
    object FDMem_Registroid_projeto_desc: TStringField
      FieldName = 'id_projeto_desc'
      Size = 255
    end
    object FDMem_Registrohr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
    end
    object FDMem_Registrodt_cadastro: TDateField
      FieldName = 'dt_cadastro'
    end
  end
end
