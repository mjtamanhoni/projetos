object frmCad_PrestServico: TfrmCad_PrestServico
  Left = 0
  Top = 0
  Caption = 'Prestador de Servi'#231'o'
  ClientHeight = 572
  ClientWidth = 1000
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
    Width = 1000
    Height = 523
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
        Title.Caption = 'Nome'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CELULAR'
        Title.Alignment = taCenter
        Title.Caption = 'Celular'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Title.Alignment = taCenter
        Title.Caption = 'E-Mail'
        Width = 300
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
        FieldName = 'HF_CADASTRO'
        Title.Alignment = taCenter
        Visible = False
      end>
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 49
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -4
    ExplicitWidth = 962
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
    object btNovo: TButton
      Left = 552
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 3
      OnClick = btNovoClick
    end
    object btEditar: TButton
      Left = 633
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Editar'
      TabOrder = 4
      OnClick = btEditarClick
    end
    object btExcluir: TButton
      Left = 714
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 5
      OnClick = btExcluirClick
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
    Left = 472
    Top = 256
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object FDMem_RegistroCELULAR: TStringField
      FieldName = 'CELULAR'
    end
    object FDMem_RegistroEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHF_CADASTRO: TTimeField
      FieldName = 'HF_CADASTRO'
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 472
    Top = 312
  end
end
