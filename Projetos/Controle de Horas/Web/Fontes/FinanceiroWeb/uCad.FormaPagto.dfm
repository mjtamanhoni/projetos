object frmCad_FormaPagto: TfrmCad_FormaPagto
  Left = 0
  Top = 0
  Caption = 'Formas de Pagamento'
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
  object pnFooter: TPanel
    Left = 0
    Top = 570
    Width = 1010
    Height = 40
    Align = alBottom
    TabOrder = 0
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
    TabOrder = 1
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
  object pnGrid_Forma: TPanel
    Left = 0
    Top = 49
    Width = 732
    Height = 521
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 728
    ExplicitHeight = 520
    object DBGrid: TDBGrid
      Left = 1
      Top = 31
      Width = 730
      Height = 489
      Align = alClient
      DataSource = dmRegistro
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = DBGridCellClick
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
          FieldName = 'CLASSIFICACAO'
          Title.Alignment = taCenter
          Width = 200
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
    object pnGrid_Forma_Header: TPanel
      Left = 1
      Top = 1
      Width = 730
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 726
      object lbGrid_Forma_Header: TLabel
        Left = 14
        Top = 8
        Width = 119
        Height = 15
        Caption = 'Formas de Pagamento'
      end
    end
  end
  object pnGrid_Cond: TPanel
    Left = 732
    Top = 49
    Width = 278
    Height = 521
    Align = alRight
    TabOrder = 3
    ExplicitLeft = 728
    ExplicitHeight = 520
    object DBGrid_Cond: TDBGrid
      Left = 1
      Top = 31
      Width = 276
      Height = 448
      Align = alClient
      DataSource = DS_Condicao
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
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ID_FORMA_PAGAMENTO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ID_CONDICAO_PAGAMENTO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DT_CADASTRO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'HR_CADASTRO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CONDICAO'
          Title.Alignment = taCenter
          Width = 230
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FORMA'
          Visible = False
        end>
    end
    object pnCond: TPanel
      Left = 1
      Top = 479
      Width = 276
      Height = 41
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 478
      object btCond_Del: TButton
        Left = 96
        Top = 11
        Width = 75
        Height = 25
        TabOrder = 0
        OnClick = btCond_DelClick
      end
      object btCond_Add: TButton
        Left = 5
        Top = 11
        Width = 75
        Height = 25
        TabOrder = 1
        OnClick = btCond_AddClick
      end
    end
    object pnGrid_Cond_Header: TPanel
      Left = 1
      Top = 1
      Width = 276
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object lbGrid_Cond_Header: TLabel
        Left = 14
        Top = 8
        Width = 136
        Height = 15
        Caption = 'Condi'#231#245'es de Pagamento'
      end
    end
  end
  object FDMem_Registro: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ID'
    DetailFields = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
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
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 264
    Top = 216
  end
  object FDMem_Condicao: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ID_FORMA_PAGAMENTO'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 432
    Top = 152
    object FDMem_CondicaoID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_CondicaoID_FORMA_PAGAMENTO: TIntegerField
      FieldName = 'ID_FORMA_PAGAMENTO'
    end
    object FDMem_CondicaoID_CONDICAO_PAGAMENTO: TIntegerField
      FieldName = 'ID_CONDICAO_PAGAMENTO'
    end
    object FDMem_CondicaoDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_CondicaoHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_CondicaoCONDICAO: TStringField
      DisplayLabel = 'Condi'#231#227'o'
      FieldName = 'CONDICAO'
      Size = 255
    end
    object FDMem_CondicaoFORMA: TStringField
      FieldName = 'FORMA'
      Size = 255
    end
  end
  object DS_Condicao: TDataSource
    AutoEdit = False
    DataSet = FDMem_Condicao
    Left = 432
    Top = 208
  end
  object FDMem_FormaCond_Pagto: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ID_FORMA_PAGAMENTO'
    MasterSource = dmRegistro
    MasterFields = 'ID'
    DetailFields = 'ID_FORMA_PAGAMENTO'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 424
    Top = 296
    object FDMem_FormaCond_PagtoID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_FormaCond_PagtoID_FORMA_PAGAMENTO: TIntegerField
      FieldName = 'ID_FORMA_PAGAMENTO'
    end
    object FDMem_FormaCond_PagtoID_CONDICAO_PAGAMENTO: TIntegerField
      FieldName = 'ID_CONDICAO_PAGAMENTO'
    end
    object FDMem_FormaCond_PagtoDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_FormaCond_PagtoHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
  end
end
