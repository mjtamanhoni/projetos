object frmForm_Projeto_Cad: TfrmForm_Projeto_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Formul'#225'rio do Projeto'
  ClientHeight = 429
  ClientWidth = 995
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
    TabOrder = 4
    OnClick = btCancelarClick
  end
  object btConfirmar: TButton
    Left = 821
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 5
    OnClick = btConfirmarClick
  end
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 995
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
      TabOrder = 2
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = ednome_formKeyPress
    end
    object cbstatus: TComboBox
      Left = 249
      Top = 10
      Width = 115
      Height = 23
      TabOrder = 1
      Text = 'Selecione'
      OnKeyPress = cbstatusKeyPress
      Items.Strings = (
        'INATIVO'
        'ATIVO')
    end
  end
  object pnRow004: TPanel
    Left = 0
    Top = 123
    Width = 995
    Height = 98
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
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
    Width = 995
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
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
      TabStop = False
      ReadOnly = True
      TabOrder = 1
      TextHint = 'Descri'#231#227'o do tipo do Formul'#225'rio'
    end
    object edid_tipo_form: TButtonedEdit
      Left = 98
      Top = 6
      Width = 89
      Height = 23
      RightButton.Visible = True
      TabOrder = 0
      TextHint = 'Tipo Form'
      OnKeyPress = edid_tipo_formKeyPress
      OnRightButtonClick = edid_tipo_formRightButtonClick
    end
  end
  object pnRow002: TPanel
    Left = 0
    Top = 41
    Width = 995
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
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
      TabStop = False
      ReadOnly = True
      TabOrder = 1
      TextHint = 'Descri'#231#227'o do Projeto'
    end
    object edid_projeto: TButtonedEdit
      Left = 98
      Top = 6
      Width = 89
      Height = 23
      RightButton.Visible = True
      TabOrder = 0
      TextHint = 'Projeto'
      OnKeyPress = edid_projetoKeyPress
      OnRightButtonClick = edid_projetoRightButtonClick
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
    object FDMem_RegistroidProjeto: TIntegerField
      FieldName = 'idProjeto'
    end
    object FDMem_RegistronomeForm: TStringField
      FieldName = 'nomeForm'
      Size = 255
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 500
    end
    object FDMem_RegistroidTipoForm: TIntegerField
      FieldName = 'idTipoForm'
    end
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistrostatusDesc: TStringField
      FieldName = 'statusDesc'
    end
    object FDMem_RegistrotipoFormTipoDesc: TStringField
      FieldName = 'tipoFormTipoDesc'
    end
    object FDMem_RegistroidTipoFormDesc: TStringField
      FieldName = 'idTipoFormDesc'
      Size = 500
    end
    object FDMem_RegistroidProjetoDesc: TStringField
      FieldName = 'idProjetoDesc'
      Size = 255
    end
  end
end
