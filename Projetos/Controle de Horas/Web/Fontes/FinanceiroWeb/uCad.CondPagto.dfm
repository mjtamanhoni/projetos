object frmCad_CondPagto: TfrmCad_CondPagto
  Left = 0
  Top = 0
  Caption = 'Condi'#231#227'o de Pagamento'
  ClientHeight = 610
  ClientWidth = 1010
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
    Top = 49
    Width = 1010
    Height = 521
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
        FieldName = 'TIPO_INTERVALO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TIPO_INTERVALO_DESC'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INTEVALOR'
        Title.Alignment = taCenter
        Width = 65
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
      end>
  end
  object pnFooter: TPanel
    Left = 0
    Top = 570
    Width = 1010
    Height = 40
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 569
    ExplicitWidth = 1006
    object btNovo: TButton
      Left = 502
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btNovoClick
    end
    object btEditar: TButton
      Left = 583
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btEditarClick
    end
    object btExcluir: TButton
      Left = 664
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btExcluirClick
    end
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 1010
    Height = 49
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 1006
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
        'DESCRI'#199#195'O')
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
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroTIPO_INTERVALO_DESC: TStringField
      DisplayLabel = 'Tipo Intervalo'
      FieldName = 'TIPO_INTERVALO_DESC'
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
