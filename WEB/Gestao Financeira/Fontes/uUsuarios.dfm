object frmUsuarios: TfrmUsuarios
  Left = 0
  Top = 0
  Caption = 'Usu'#225'rios'
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
    object pnRegistros: TPanel
      Left = 3
      Top = 3
      Width = 938
      Height = 475
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 237
      object DBGrid_Registros: TDBGrid
        Left = 1
        Top = 1
        Width = 936
        Height = 473
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
  end
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 944
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
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
      TextHint = 'Pesquisar pelo Nome do Usu'#225'rio'
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
      Left = 866
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
    Left = 144
    Top = 88
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
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_RegistrotipoDesc: TStringField
      FieldName = 'tipoDesc'
      Size = 50
    end
    object FDMem_RegistrostatusDesc: TStringField
      FieldName = 'statusDesc'
      Size = 50
    end
  end
  object dsRegistros: TDataSource
    DataSet = FDMem_Registro
    Left = 144
    Top = 144
  end
  object PopupMenu: TPopupMenu
    Left = 656
    Top = 152
    object mnuPop_Filtro_ID: TMenuItem
      Caption = 'Id'
      OnClick = mnuFiltro_InativoClick
    end
    object mnuPop_Filtro_Nome: TMenuItem
      Tag = 1
      Caption = 'Nome'
      OnClick = mnuFiltro_InativoClick
    end
    object mnuFiltro_Login: TMenuItem
      Tag = 2
      Caption = 'Login'
      OnClick = mnuFiltro_InativoClick
    end
    object mnuFiltro_EMail: TMenuItem
      Tag = 3
      Caption = 'E-Mail'
      OnClick = mnuFiltro_InativoClick
    end
    object mnuFiltro_Inativo: TMenuItem
      Tag = 4
      Caption = 'Inativo'
      OnClick = mnuFiltro_InativoClick
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
  object FDMem_Permissoes: TFDMemTable
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
    Left = 240
    Top = 320
    object FDMem_Permissoesid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_PermissoesidUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object FDMem_PermissoesidProjeto: TIntegerField
      FieldName = 'idProjeto'
    end
    object FDMem_PermissoesidTelaProjeto: TIntegerField
      FieldName = 'idTelaProjeto'
    end
    object FDMem_Permissoesacesso: TIntegerField
      FieldName = 'acesso'
    end
    object FDMem_Permissoesincluir: TIntegerField
      FieldName = 'incluir'
    end
    object FDMem_Permissoesalterar: TIntegerField
      FieldName = 'alterar'
    end
    object FDMem_Permissoesexcluir: TIntegerField
      FieldName = 'excluir'
    end
    object FDMem_Permissoesimprimir: TIntegerField
      FieldName = 'imprimir'
    end
    object FDMem_Permissoesusuario: TStringField
      FieldName = 'usuario'
      Size = 255
    end
    object FDMem_Permissoesprojeto: TStringField
      FieldName = 'projeto'
      Size = 255
    end
    object FDMem_PermissoesnomeForm: TStringField
      FieldName = 'nomeForm'
      Size = 255
    end
    object FDMem_PermissoesdescricaoResumida: TStringField
      FieldName = 'descricaoResumida'
      Size = 255
    end
  end
  object dsPermissoes: TDataSource
    DataSet = FDMem_Permissoes
    Left = 240
    Top = 376
  end
  object FDMem_Empresa: TFDMemTable
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
    Left = 528
    Top = 328
    object FDMem_Empresaid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_EmpresaidUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object FDMem_EmpresaidEmpresa: TIntegerField
      FieldName = 'idEmpresa'
    end
    object FDMem_EmpresadtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_EmpresahrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_Empresausuario: TStringField
      FieldName = 'usuario'
      Size = 255
    end
    object FDMem_Empresaempresa: TStringField
      FieldName = 'empresa'
      Size = 255
    end
  end
  object dsEmpresa: TDataSource
    DataSet = FDMem_Empresa
    Left = 528
    Top = 384
  end
end
