object frmCad_FormaPagto_Add: TfrmCad_FormaPagto_Add
  Left = 0
  Top = 0
  Caption = 'Cadastro de Formas de Pagamento'
  ClientHeight = 611
  ClientWidth = 984
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
  object lbCLASSIFICACAO: TLabel
    Left = 8
    Top = 58
    Width = 68
    Height = 15
    Caption = 'Classifica'#231#227'o'
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
  object btConfirmar: TButton
    Left = 319
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Confirmar'
    TabOrder = 2
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 471
    Top = 272
    Width = 100
    Height = 30
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btCancelarClick
  end
  object pnClassificacao: TPanel
    Left = 96
    Top = 45
    Width = 833
    Height = 52
    BevelInner = bvLowered
    TabOrder = 4
    object rbDINHEIRO: TRadioButton
      Left = 10
      Top = 16
      Width = 79
      Height = 17
      Caption = 'Dinheiro'
      TabOrder = 0
    end
    object rbCREDIARIO: TRadioButton
      Left = 95
      Top = 16
      Width = 87
      Height = 17
      Caption = 'Credi'#225'rio'
      TabOrder = 1
    end
    object rbBOLETO: TRadioButton
      Left = 175
      Top = 16
      Width = 87
      Height = 17
      Caption = 'Boleto'
      TabOrder = 2
    end
    object rbPIX: TRadioButton
      Left = 247
      Top = 16
      Width = 76
      Height = 17
      Caption = 'PIX'
      TabOrder = 3
    end
    object rbCARTAO_DEBITO: TRadioButton
      Left = 311
      Top = 16
      Width = 122
      Height = 17
      Caption = 'Cart'#227'o de D'#233'bito'
      TabOrder = 4
    end
    object rbCARTAO_CREDITO: TRadioButton
      Left = 439
      Top = 16
      Width = 122
      Height = 17
      Caption = 'Cart'#227'o de Cr'#233'dito'
      TabOrder = 5
    end
    object rbCHEQUE_A_VISTA: TRadioButton
      Left = 567
      Top = 16
      Width = 122
      Height = 17
      Caption = 'Cheque a Vista'
      TabOrder = 6
    end
    object rbCHEQUE_A_PRAZO: TRadioButton
      Left = 695
      Top = 16
      Width = 122
      Height = 17
      Caption = 'Cheque a Prazo'
      TabOrder = 7
    end
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
    object FDMem_RegistroCLASSIFICACAO: TStringField
      DisplayLabel = 'Classifica'#231#227'o'
      FieldName = 'CLASSIFICACAO'
      Size = 50
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
  end
end
