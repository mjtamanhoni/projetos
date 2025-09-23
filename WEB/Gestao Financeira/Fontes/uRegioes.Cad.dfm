object frmRegioes_Cad: TfrmRegioes_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Regi'#245'es'
  ClientHeight = 589
  ClientWidth = 990
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 990
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -97
    ExplicitWidth = 993
    object lbid: TLabel
      Left = 82
      Top = 13
      Width = 10
      Height = 15
      Caption = 'Id'
    end
    object lbnome: TLabel
      Left = 330
      Top = 11
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lbibge: TLabel
      Left = 202
      Top = 11
      Width = 24
      Height = 15
      Caption = 'IBGE'
    end
    object lbsigla: TLabel
      Left = 873
      Top = 11
      Width = 25
      Height = 15
      Caption = 'Sigla'
    end
    object edid: TEdit
      Left = 98
      Top = 12
      Width = 89
      Height = 23
      Enabled = False
      TabOrder = 0
      TextHint = 'Id'
      OnKeyPress = edidKeyPress
    end
    object ednome: TEdit
      Left = 369
      Top = 10
      Width = 440
      Height = 23
      TabOrder = 1
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = ednomeKeyPress
    end
    object edibge: TEdit
      Left = 232
      Top = 10
      Width = 81
      Height = 23
      NumbersOnly = True
      TabOrder = 2
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = edibgeKeyPress
    end
    object edsigla: TEdit
      Left = 912
      Top = 8
      Width = 65
      Height = 23
      TabOrder = 3
      TextHint = 'Informe a Descri'#231#227'o'
    end
  end
  object btConfirmar: TButton
    Left = 781
    Top = 212
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 862
    Top = 212
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btCancelarClick
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
    Left = 432
    Top = 240
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_Registroibge: TIntegerField
      FieldName = 'ibge'
    end
    object FDMem_Registronome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object FDMem_Registrosigla: TStringField
      FieldName = 'sigla'
      Size = 2
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
  end
end
