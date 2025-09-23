object frmUnidadeFederativa: TfrmUnidadeFederativa
  Left = 0
  Top = 0
  Caption = 'Unidades Federativas'
  ClientHeight = 571
  ClientWidth = 941
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnDetail: TPanel
    Left = 0
    Top = 41
    Width = 941
    Height = 530
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    ExplicitLeft = -19
    ExplicitTop = 29
    ExplicitWidth = 960
    ExplicitHeight = 542
    object DBGrid_Registros: TDBGrid
      Left = 3
      Top = 3
      Width = 935
      Height = 524
      Align = alClient
      DataSource = dsRegistros
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
          FieldName = 'id'
          Title.Alignment = taCenter
          Title.Caption = 'Id'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'idRegiao'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ibge'
          Title.Alignment = taCenter
          Title.Caption = 'IBGE'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sigla'
          Title.Alignment = taCenter
          Title.Caption = 'Sigla'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'capital'
          Title.Alignment = taCenter
          Title.Caption = 'Capital'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dtCadastro'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'hrCadastro'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'nomeRegiao'
          Title.Alignment = taCenter
          Title.Caption = 'Regi'#227'o'
          Width = 250
          Visible = True
        end>
    end
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 941
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -19
    ExplicitWidth = 960
    object lbStatus: TLabel
      Left = 8
      Top = 13
      Width = 32
      Height = 15
      Caption = 'Status'
      Layout = tlCenter
    end
    object lbPesquisa: TLabel
      Left = 284
      Top = 13
      Width = 46
      Height = 15
      Caption = 'Pesquisa'
    end
    object lbTipo: TLabel
      Left = 157
      Top = 13
      Width = 26
      Height = 15
      Caption = 'Tipo:'
    end
    object cbStatus: TComboBox
      Left = 46
      Top = 12
      Width = 99
      Height = 23
      TabOrder = 0
      TextHint = 'Selecine'
      Items.Strings = (
        'INATIVO'
        'ATIVO'
        'AMBOS')
    end
    object edPesquisar: TButtonedEdit
      Left = 336
      Top = 12
      Width = 441
      Height = 23
      RightButton.Visible = True
      TabOrder = 1
      TextHint = 'DIgite um texto para selecionar'
    end
    object btNovo: TButton
      Left = 790
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 2
    end
    object btFechar: TButton
      Left = 871
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 3
    end
    object cbTipo: TComboBox
      Left = 197
      Top = 12
      Width = 81
      Height = 23
      TabOrder = 4
      TextHint = 'Tipo da Pesquisa'
      Items.Strings = (
        'ID'
        'NOME'
        'IBGE')
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
    Left = 432
    Top = 240
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_RegistroidRegiao: TIntegerField
      FieldName = 'idRegiao'
    end
    object FDMem_Registroibge: TIntegerField
      FieldName = 'ibge'
    end
    object FDMem_Registrosigla: TStringField
      FieldName = 'sigla'
      Size = 2
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
    object FDMem_Registrocapital: TStringField
      FieldName = 'capital'
      Size = 100
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistronomeRegiao: TStringField
      FieldName = 'nomeRegiao'
      Size = 100
    end
  end
  object dsRegistros: TDataSource
    DataSet = FDMem_Registro
    Left = 432
    Top = 296
  end
end
