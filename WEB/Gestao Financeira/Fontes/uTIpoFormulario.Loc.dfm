object frmTipoFormulario_Loc: TfrmTipoFormulario_Loc
  Left = 0
  Top = 0
  Caption = 'Localiza Tipo de Formul'#225'rio'
  ClientHeight = 595
  ClientWidth = 992
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
    Width = 992
    Height = 554
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object DBGrid_Registros: TDBGrid
      Left = 3
      Top = 3
      Width = 986
      Height = 548
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
          FieldName = 'tipoDesc'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o'
          Width = 700
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status_desc'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'tipo'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'dt_cadastro'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'hr_cadastro'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'status'
          Title.Alignment = taCenter
          Visible = False
        end>
    end
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 992
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
      Left = 300
      Top = 13
      Width = 46
      Height = 15
      Caption = 'Pesquisa'
    end
    object lbTipo: TLabel
      Left = 165
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
      Left = 352
      Top = 10
      Width = 425
      Height = 23
      RightButton.Visible = True
      TabOrder = 1
      TextHint = 'DIgite um texto para selecionar'
      OnRightButtonClick = edPesquisarRightButtonClick
    end
    object cbTipo: TComboBox
      Left = 197
      Top = 10
      Width = 81
      Height = 23
      TabOrder = 2
      TextHint = 'Tipo da Pesquisa'
      Items.Strings = (
        'ID'
        'DESCRI'#199#195'O')
    end
    object btConfirmar: TButton
      Left = 790
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 3
      OnClick = btConfirmarClick
    end
    object btCancelar: TButton
      Left = 871
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 4
      OnClick = btCancelarClick
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
    object FDMem_Registrotipo: TStringField
      FieldName = 'tipo'
      Size = 255
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 500
    end
    object FDMem_Registrodt_cadastro: TDateField
      FieldName = 'dt_cadastro'
    end
    object FDMem_Registrohr_cadastro: TTimeField
      FieldName = 'hr_cadastro'
    end
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_Registrostatus_desc: TStringField
      FieldName = 'status_desc'
      Size = 10
    end
    object FDMem_RegistrotipoDesc: TStringField
      FieldName = 'tipoDesc'
      Size = 255
    end
  end
  object dsRegistros: TDataSource
    DataSet = FDMem_Registro
    Left = 424
    Top = 296
  end
end
