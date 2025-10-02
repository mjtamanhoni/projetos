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
    Top = 30
    Width = 1006
    Height = 561
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object DBGrid_Registros: TDBGrid
      Left = 3
      Top = 3
      Width = 1000
      Height = 555
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
          FieldName = 'tipoFormTipoDesc'
          Title.Alignment = taCenter
          Title.Caption = 'Tipo do Formul'#225'rio'
          Width = 150
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
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btNovo: TButton
      AlignWithMargins = True
      Left = 847
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btNovoClick
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
      TextHint = 'Pesquisar pela Descri'#231#227'o do Tipo de Formul'#225'rio'
      OnKeyPress = edPesquisarKeyPress
      ExplicitHeight = 23
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
      Left = 928
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Impress'#227'o'
      TabOrder = 3
      OnClick = btPrintClick
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
  object PopupMenu: TPopupMenu
    Left = 656
    Top = 152
    object mnuPop_Filtro_ID: TMenuItem
      Caption = 'Id'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuPop_Filtro_Nome: TMenuItem
      Tag = 1
      Caption = 'Descri'#231#227'o'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuFiltro_TipoForm: TMenuItem
      Tag = 2
      Caption = 'Tipo do Formul'#225'rio'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuFiltro_Projeot: TMenuItem
      Tag = 3
      Caption = 'Projeto'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuPop_Filtro_SiglaUF: TMenuItem
      Tag = 4
      Caption = 'Inativos'
      OnClick = mnuPop_Filtro_SiglaUFClick
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
    ReportOptions.LastChange = 45932.270286539350000000
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
