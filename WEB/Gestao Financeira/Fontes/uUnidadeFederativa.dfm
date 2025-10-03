object frmUnidadeFederativa: TfrmUnidadeFederativa
  Left = 0
  Top = 0
  Caption = 'Unidades Federativas'
  ClientHeight = 511
  ClientWidth = 944
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
    Top = 30
    Width = 944
    Height = 481
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    ExplicitTop = 41
    ExplicitWidth = 941
    ExplicitHeight = 530
    object DBGrid_Registros: TDBGrid
      Left = 3
      Top = 3
      Width = 938
      Height = 475
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
    Width = 944
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 941
    object btNovo: TButton
      AlignWithMargins = True
      Left = 785
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btNovoClick
      ExplicitLeft = 790
      ExplicitTop = 10
      ExplicitHeight = 25
    end
    object edPesquisar: TEdit
      Tag = 1
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 650
      Height = 24
      Align = alLeft
      TabOrder = 1
      TextHint = 'Pesquisar pelo Nome da Regi'#227'o'
      OnKeyPress = edPesquisarKeyPress
      ExplicitLeft = 11
      ExplicitTop = 6
      ExplicitHeight = 35
    end
    object btFiltros: TButton
      AlignWithMargins = True
      Left = 659
      Top = 3
      Width = 75
      Height = 24
      Align = alLeft
      Caption = 'Filtros'
      TabOrder = 2
    end
    object btPrint: TButton
      AlignWithMargins = True
      Left = 866
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Impress'#227'o'
      TabOrder = 3
      OnClick = btPrintClick
      ExplicitLeft = 887
    end
  end
  object FDMem_Registro: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'nomeRegiao;descricao'
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
  object PopupMenu: TPopupMenu
    Left = 656
    Top = 152
    object mnuPop_Filtro_ID: TMenuItem
      Caption = 'Id'
      OnClick = mnuFiltro_SiglaClick
    end
    object mnuFiltro_Descricao: TMenuItem
      Tag = 1
      Caption = 'Descri'#231#227'o'
      OnClick = mnuFiltro_SiglaClick
    end
    object mnuFiltro_TipoForm: TMenuItem
      Tag = 2
      Caption = 'IBGE'
      OnClick = mnuFiltro_SiglaClick
    end
    object mnuFiltro_Regiao: TMenuItem
      Tag = 3
      Caption = 'Regi'#227'o'
      OnClick = mnuFiltro_SiglaClick
    end
    object mnuFiltro_Sigla: TMenuItem
      Tag = 4
      Caption = 'Sigla - UF'
      OnClick = mnuFiltro_SiglaClick
    end
  end
  object frxReport: TfrxReport
    Version = '2023.1.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45931.597265277800000000
    ReportOptions.LastChange = 45932.349737928240000000
    ScriptLanguage = 'PascalScript'
    ShowProgress = False
    StoreInDFM = False
    Left = 656
    Top = 216
  end
  object frxPDFExport: TfrxPDFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = False
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 656
    Top = 272
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSet = FDMem_Registro
    BCDToCurrency = False
    DataSetOptions = []
    Left = 656
    Top = 328
  end
end
