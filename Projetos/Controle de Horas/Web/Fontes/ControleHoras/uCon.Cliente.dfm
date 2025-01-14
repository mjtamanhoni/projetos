object frmCon_Cliente: TfrmCon_Cliente
  Left = 0
  Top = 0
  Caption = 'Consulta de Clientes'
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
  OnShow = FormShow
  TextHeight = 15
  object DBGrid: TDBGrid
    Left = 0
    Top = 57
    Width = 984
    Height = 348
    Align = alClient
    DataSource = dmRegistro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PESSOA_DESC'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOCUMENTO'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INSC_EST'
        Title.Alignment = taCenter
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Title.Alignment = taCenter
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENDERECO'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPLEMENTO'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Alignment = taCenter
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BAIRRO'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CIDADE'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Title.Alignment = taCenter
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CELULAR'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PESSOA'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DT_CADASTRO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'HR_CADASTRO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_FORNECEDOR'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_TAB_PRECO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FONECEDOR'
        Title.Alignment = taCenter
        Title.Caption = 'Fornecedor'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAB_PRECO'
        Title.Alignment = taCenter
        Title.Caption = 'Tab. Pre'#231'o'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_TAB_PRECO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TIPO_TAB_PRECO_DESC'
        Title.Alignment = taCenter
        Title.Caption = 'Tp. Tab. Pre'#231'o'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Width = 110
        Visible = True
      end>
  end
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 57
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 980
    object lbTipo: TLabel
      Left = 16
      Top = 17
      Width = 26
      Height = 15
      Caption = 'Tipo:'
    end
    object lbPesquisar: TLabel
      Left = 135
      Top = 17
      Width = 53
      Height = 15
      Caption = 'Pesquisar:'
    end
    object cbTipo: TComboBox
      Left = 48
      Top = 14
      Width = 81
      Height = 23
      TabOrder = 0
      Items.Strings = (
        'ID'
        'NOME')
    end
    object edPesquisar: TEdit
      Left = 194
      Top = 14
      Width = 279
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 1
      TextHint = 'Digite o texto da Pesquisa'
    end
    object btPesquisar: TButton
      Left = 448
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = btPesquisarClick
    end
  end
  object pnFooter: TPanel
    Left = 0
    Top = 405
    Width = 984
    Height = 56
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 404
    ExplicitWidth = 980
    object btConfirmar: TButton
      Left = 346
      Top = 6
      Width = 225
      Height = 43
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btConfirmarClick
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
      DisplayFormat = '###:##:##'
    end
    object FDMem_RegistroPESSOA_DESC: TStringField
      DisplayLabel = 'Pessoa'
      FieldName = 'PESSOA_DESC'
    end
    object FDMem_RegistroID_FORNECEDOR: TIntegerField
      FieldName = 'ID_FORNECEDOR'
    end
    object FDMem_RegistroID_TAB_PRECO: TIntegerField
      FieldName = 'ID_TAB_PRECO'
    end
    object FDMem_RegistroFONECEDOR: TStringField
      FieldName = 'FONECEDOR'
      Size = 255
    end
    object FDMem_RegistroTAB_PRECO: TStringField
      FieldName = 'TAB_PRECO'
      Size = 100
    end
    object FDMem_RegistroTIPO_TAB_PRECO: TIntegerField
      FieldName = 'TIPO_TAB_PRECO'
    end
    object FDMem_RegistroTIPO_TAB_PRECO_DESC: TStringField
      FieldName = 'TIPO_TAB_PRECO_DESC'
      Size = 50
    end
    object FDMem_RegistroVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = 'R$ #,##0.00'
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 264
    Top = 216
  end
end
