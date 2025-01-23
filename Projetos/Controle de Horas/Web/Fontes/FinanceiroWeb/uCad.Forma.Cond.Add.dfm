object frmFormaCond_Add: TfrmFormaCond_Add
  Left = 0
  Top = 0
  Caption = 'Condi'#231#227'o de Pagamento da Forma'
  ClientHeight = 460
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object DBGrid: TDBGrid
    Left = 0
    Top = 57
    Width = 980
    Height = 347
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
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PARCELAS'
        Title.Alignment = taCenter
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_INTERVALO_DESC'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_INTERVALO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'INTEVALOR'
        Title.Alignment = taCenter
        Width = 65
        Visible = True
      end>
  end
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 980
    Height = 57
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -4
    ExplicitWidth = 988
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
    Top = 404
    Width = 980
    Height = 56
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 411
    ExplicitWidth = 984
    object btConfirmar: TButton
      Left = 346
      Top = 6
      Width = 111
      Height = 35
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btConfirmarClick
    end
    object btCancelar: TButton
      Left = 463
      Top = 6
      Width = 111
      Height = 35
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btCancelarClick
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
    object FDMem_RegistroPARCELAS: TIntegerField
      DisplayLabel = 'Parcelas'
      FieldName = 'PARCELAS'
    end
    object FDMem_RegistroTIPO_INTERVALO: TIntegerField
      DisplayLabel = 'Tipo Intervalo'
      FieldName = 'TIPO_INTERVALO'
    end
    object FDMem_RegistroINTEVALOR: TIntegerField
      DisplayLabel = 'Intervalo'
      FieldName = 'INTEVALOR'
    end
    object FDMem_RegistroTIPO_INTERVALO_DESC: TStringField
      DisplayLabel = 'Tipo Intervalo'
      FieldName = 'TIPO_INTERVALO_DESC'
      Size = 50
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 264
    Top = 216
  end
end
