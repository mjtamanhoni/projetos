object frmForm_Projeto: TfrmForm_Projeto
  Left = 0
  Top = 0
  Caption = 'Formul'#225'rios do Projeto'
  ClientHeight = 591
  ClientWidth = 1006
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
  object pnDetail: TPanel
    Left = 0
    Top = 41
    Width = 1006
    Height = 550
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object DBGrid_Registros: TDBGrid
      Left = 3
      Top = 3
      Width = 1000
      Height = 544
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
          FieldName = 'idProjeto'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'nomeForm'
          Title.Alignment = taCenter
          Title.Caption = 'Formul'#225'rio'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o'
          Width = 500
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'idTipoForm'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'status'
          Title.Alignment = taCenter
          Visible = False
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
          FieldName = 'statusDesc'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'tipoFormTipoDesc'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo do Formul'#225'rio'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'idTipoFormDesc'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o do Tipo do Formul'#225'rio'
          Width = 500
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'idProjetoDesc'
          Title.Alignment = taCenter
          Title.Caption = 'Projeto'
          Width = 250
          Visible = True
        end>
    end
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 1006
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
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
      Top = 10
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
      OnRightButtonClick = edPesquisarRightButtonClick
    end
    object btNovo: TButton
      Left = 790
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 2
      OnClick = btNovoClick
    end
    object btFechar: TButton
      Left = 871
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 3
      OnClick = btFecharClick
    end
    object cbTipo: TComboBox
      Left = 197
      Top = 10
      Width = 81
      Height = 23
      TabOrder = 4
      TextHint = 'Tipo da Pesquisa'
      Items.Strings = (
        'ID'
        'DESCRI'#199#195'O'
        'ID - PROJETO'
        'PROJETO')
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
  object dsRegistros: TDataSource
    DataSet = FDMem_Registro
    Left = 424
    Top = 296
  end
end
