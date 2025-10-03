object frmEmpresa_Loc: TfrmEmpresa_Loc
  Left = 0
  Top = 0
  Caption = 'Localiza Empresa'
  ClientHeight = 583
  ClientWidth = 941
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
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
