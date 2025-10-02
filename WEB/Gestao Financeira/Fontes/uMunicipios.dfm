object frmMunicipios: TfrmMunicipios
  Left = 0
  Top = 0
  Caption = 'Munic'#237'pios'
  ClientHeight = 565
  ClientWidth = 975
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
    Width = 975
    Height = 535
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    ExplicitTop = 41
    ExplicitHeight = 524
    object DBGrid_Registros: TDBGrid
      Left = 3
      Top = 3
      Width = 969
      Height = 529
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
          FieldName = 'idUf'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'siglaUf'
          Title.Alignment = taCenter
          Title.Caption = 'UF'
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ibge'
          Title.Alignment = taCenter
          Title.Caption = 'IBGE'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cepPadrao'
          Title.Alignment = taCenter
          Title.Caption = 'CEP Padr'#227'o'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Alignment = taCenter
          Title.Caption = 'Nome'
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
          FieldName = 'unidadeFederativa'
          Title.Alignment = taCenter
          Title.Caption = 'Unidade Federativa'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'regiao'
          Title.Alignment = taCenter
          Title.Caption = 'Regi'#227'o'
          Width = 200
          Visible = True
        end>
    end
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 975
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 944
    object btNovo: TButton
      AlignWithMargins = True
      Left = 816
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btNovoClick
      ExplicitLeft = 678
      ExplicitTop = 10
      ExplicitHeight = 25
    end
    object btFiltros: TButton
      AlignWithMargins = True
      Left = 659
      Top = 3
      Width = 75
      Height = 24
      Align = alLeft
      Caption = 'Filtros'
      TabOrder = 1
      ExplicitLeft = 295
      ExplicitTop = 10
      ExplicitHeight = 25
    end
    object btPrint: TButton
      AlignWithMargins = True
      Left = 897
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Impress'#227'o'
      TabOrder = 2
      OnClick = btPrintClick
      ExplicitLeft = 840
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
      TabOrder = 3
      TextHint = 'Pesquisar pelo Nome do Munic'#237'pio'
      OnKeyPress = edPesquisarKeyPress
      ExplicitHeight = 35
    end
  end
  object FDMem_Registro: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'idUf'
        DataType = ftInteger
      end
      item
        Name = 'siglaUf'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ibge'
        DataType = ftInteger
      end
      item
        Name = 'cepPadrao'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'dtCadastro'
        DataType = ftDate
      end
      item
        Name = 'hrCadastro'
        DataType = ftTime
      end
      item
        Name = 'unidadeFederativa'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'regiao'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    IndexFieldNames = 'regiao;siglaUf'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 424
    Top = 232
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_RegistroidUf: TIntegerField
      FieldName = 'idUf'
    end
    object FDMem_RegistrosiglaUf: TStringField
      FieldName = 'siglaUf'
      Size = 2
    end
    object FDMem_Registroibge: TIntegerField
      FieldName = 'ibge'
    end
    object FDMem_RegistrocepPadrao: TStringField
      FieldName = 'cepPadrao'
      Size = 15
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistrounidadeFederativa: TStringField
      FieldName = 'unidadeFederativa'
      Size = 100
    end
    object FDMem_Registroregiao: TStringField
      FieldName = 'regiao'
      Size = 100
    end
  end
  object dsRegistros: TDataSource
    DataSet = FDMem_Registro
    Left = 432
    Top = 296
  end
  object PopupMenu: TPopupMenu
    Left = 624
    Top = 192
    object mnuPop_Filtro_ID: TMenuItem
      Caption = 'Id'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuPop_Filtro_Nome: TMenuItem
      Tag = 1
      Caption = 'Nome'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuPop_Filtro_IBGE: TMenuItem
      Tag = 2
      Caption = 'IBGE'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuPop_Filtro_Regiao: TMenuItem
      Tag = 3
      Caption = 'Regi'#227'o'
      OnClick = mnuPop_Filtro_SiglaUFClick
    end
    object mnuPop_Filtro_SiglaUF: TMenuItem
      Tag = 4
      Caption = 'Sigla UF'
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
    ReportOptions.LastChange = 45931.723184502310000000
    ScriptLanguage = 'PascalScript'
    ShowProgress = False
    StoreInDFM = False
    Left = 624
    Top = 256
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
    Left = 624
    Top = 312
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSet = FDMem_Registro
    BCDToCurrency = False
    DataSetOptions = []
    Left = 624
    Top = 368
  end
end
