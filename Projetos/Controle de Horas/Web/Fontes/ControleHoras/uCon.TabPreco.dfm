object frmCon_TabPreco: TfrmCon_TabPreco
  Left = 0
  Top = 0
  Caption = 'Consulta de Tabela de Pre'#231'o'
  ClientHeight = 462
  ClientWidth = 988
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object DBGrid: TDBGrid
    Left = 0
    Top = 57
    Width = 988
    Height = 349
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
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
        FieldName = 'TIPO_DESC'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end>
  end
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 988
    Height = 57
    Align = alTop
    TabOrder = 1
    ExplicitTop = -6
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
        'DESCRICAO')
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
    Top = 406
    Width = 988
    Height = 56
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 405
    ExplicitWidth = 984
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
    object FDMem_RegistroDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object FDMem_RegistroTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Size = 100
    end
    object FDMem_RegistroVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroTIPO_DESC: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_DESC'
      Size = 100
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 264
    Top = 216
  end
end
