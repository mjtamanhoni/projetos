object frmUsuarios_Loc: TfrmUsuarios_Loc
  Left = 0
  Top = 0
  Caption = 'Localiza Usu'#225'rios'
  ClientHeight = 569
  ClientWidth = 970
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnDetail: TPanel
    Left = 0
    Top = 41
    Width = 970
    Height = 528
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object DBGrid_Registros: TDBGrid
      Left = 3
      Top = 3
      Width = 964
      Height = 522
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
          FieldName = 'nome'
          Title.Alignment = taCenter
          Title.Caption = 'Nome'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'login'
          Title.Alignment = taCenter
          Title.Caption = 'Login'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'senha'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'pin'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'email'
          Title.Alignment = taCenter
          Title.Caption = 'E-Mail'
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
          FieldName = 'senhaHash'
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
          FieldName = 'tipoDesc'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'statusDesc'
          Title.Alignment = taCenter
          Title.Caption = 'Status'
          Width = 200
          Visible = True
        end>
    end
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 970
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
      OnRightButtonClick = edPesquisarRightButtonClick
    end
    object cbTipo: TComboBox
      Left = 197
      Top = 12
      Width = 81
      Height = 23
      TabOrder = 2
      TextHint = 'Tipo da Pesquisa'
      Items.Strings = (
        'ID'
        'NOME'
        'LOGIN'
        'E-MAIL')
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
    object FDMem_Registronome: TStringField
      FieldName = 'nome'
      Size = 255
    end
    object FDMem_Registrologin: TStringField
      FieldName = 'login'
      Size = 255
    end
    object FDMem_Registrosenha: TStringField
      FieldName = 'senha'
      Size = 255
    end
    object FDMem_Registropin: TStringField
      FieldName = 'pin'
      Size = 255
    end
    object FDMem_Registroemail: TStringField
      FieldName = 'email'
      Size = 255
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistrosenhaHash: TStringField
      FieldName = 'senhaHash'
      Size = 255
    end
    object FDMem_Registrotipo: TIntegerField
      FieldName = 'tipo'
    end
    object FDMem_RegistrotipoDesc: TStringField
      FieldName = 'tipoDesc'
      Size = 50
    end
    object FDMem_RegistrostatusDesc: TStringField
      FieldName = 'statusDesc'
      Size = 50
    end
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
  end
  object dsRegistros: TDataSource
    DataSet = FDMem_Registro
    Left = 424
    Top = 296
  end
end
