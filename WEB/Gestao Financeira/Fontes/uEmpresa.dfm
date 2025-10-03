object frmEmpresa: TfrmEmpresa
  Left = 0
  Top = 0
  Caption = 'Empresa'
  ClientHeight = 511
  ClientWidth = 944
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
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
    ExplicitWidth = 964
    ExplicitHeight = 553
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
    Width = 944
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 964
    object btNovo: TButton
      AlignWithMargins = True
      Left = 785
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Novo'
      TabOrder = 0
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
      TextHint = 'Pesquisar pela Raz'#227'o Social da Empresa'
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
      Left = 866
      Top = 3
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'Impress'#227'o'
      TabOrder = 3
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
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_Registrotipo: TIntegerField
      FieldName = 'tipo'
    end
    object FDMem_RegistrorazaoSocial: TStringField
      FieldName = 'razaoSocial'
      Size = 255
    end
    object FDMem_Registrofantasia: TStringField
      FieldName = 'fantasia'
      Size = 255
    end
    object FDMem_Registrocnpj: TStringField
      FieldName = 'cnpj'
    end
    object FDMem_RegistroinscEstadual: TStringField
      FieldName = 'inscEstadual'
    end
    object FDMem_Registrocontato: TStringField
      FieldName = 'contato'
      Size = 255
    end
    object FDMem_Registroendereco: TStringField
      FieldName = 'endereco'
      Size = 255
    end
    object FDMem_Registronumero: TStringField
      FieldName = 'numero'
      Size = 50
    end
    object FDMem_Registrocomplemento: TStringField
      FieldName = 'complemento'
      Size = 255
    end
    object FDMem_Registrobairro: TStringField
      FieldName = 'bairro'
      Size = 100
    end
    object FDMem_RegistroidCidade: TIntegerField
      FieldName = 'idCidade'
    end
    object FDMem_RegistrocidadeIbge: TIntegerField
      FieldName = 'cidadeIbge'
    end
    object FDMem_Registrocidade: TStringField
      FieldName = 'cidade'
      Size = 100
    end
    object FDMem_RegistrosiglaUf: TStringField
      FieldName = 'siglaUf'
      Size = 2
    end
    object FDMem_Registrocep: TStringField
      FieldName = 'cep'
      Size = 15
    end
    object FDMem_Registrotelefone: TStringField
      FieldName = 'telefone'
    end
    object FDMem_Registrocelular: TStringField
      FieldName = 'celular'
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
    object FDMem_RegistrotipoPessoa: TIntegerField
      FieldName = 'tipoPessoa'
    end
    object FDMem_RegistrostatusDesc: TStringField
      FieldName = 'statusDesc'
      Size = 50
    end
    object FDMem_RegistrotipoDesc: TStringField
      FieldName = 'tipoDesc'
      Size = 100
    end
    object FDMem_RegistrotipoPessoaDesc: TStringField
      FieldName = 'tipoPessoaDesc'
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
    end
    object mnuFiltro_RazaoSocial: TMenuItem
      Tag = 1
      Caption = 'Raz'#227'o Social'
    end
    object mnuFiltro_NomeFantasia: TMenuItem
      Tag = 2
      Caption = 'Nome Fantasia'
    end
    object mnuFiltro_CNPJ: TMenuItem
      Tag = 3
      Caption = 'CNPJ'
    end
    object mnuFiltro_Inativo: TMenuItem
      Tag = 4
      Caption = 'Inativo'
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
    ReportOptions.LastChange = 45932.382649490740000000
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
