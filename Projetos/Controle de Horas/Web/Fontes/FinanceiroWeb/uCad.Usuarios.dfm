object frmCad_Usuarios: TfrmCad_Usuarios
  Left = 0
  Top = 0
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 611
  ClientWidth = 1014
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
  object pnHeader: TPanel
    Left = 0
    Top = 0
    Width = 1014
    Height = 49
    Align = alTop
    TabOrder = 0
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
      ItemIndex = 1
      TabOrder = 0
      Text = 'NOME'
      Items.Strings = (
        'ID'
        'NOME'
        'LOGIN'
        'E-MAIL')
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
  object DBGrid: TDBGrid
    Left = 0
    Top = 49
    Width = 1014
    Height = 522
    Align = alClient
    DataSource = dmRegistro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
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
        FieldName = 'TIPO_DESC'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGIN'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SENHA'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'PIN'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CELULAR'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_EMPRESA'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_PRESTADOR_SERVICO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ID_CLIENTE'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FORM_INICIAL'
        Title.Alignment = taCenter
        Title.Caption = 'Form. Inicial'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOTO'
        Title.Alignment = taCenter
        Visible = False
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
      end
      item
        Expanded = False
        FieldName = 'SINCRONIZADO'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'EMPRESA'
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRESTADOR_SERVICO'
        Title.Alignment = taCenter
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Alignment = taCenter
        Title.Caption = 'Cliente'
        Width = 300
        Visible = True
      end>
  end
  object pnFooter: TPanel
    Left = 0
    Top = 571
    Width = 1014
    Height = 40
    Align = alBottom
    TabOrder = 2
    object btExcluir: TButton
      Left = 714
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 0
      OnClick = btExcluirClick
    end
    object btEditar: TButton
      Left = 633
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btEditarClick
    end
    object btNovo: TButton
      Left = 552
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 2
      OnClick = btNovoClick
    end
  end
  object FDMem_Registro: TFDMemTable
    IndexFieldNames = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 472
    Top = 256
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroTIPO: TIntegerField
      FieldName = 'TIPO'
    end
    object FDMem_RegistroNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 100
    end
    object FDMem_RegistroLOGIN: TStringField
      DisplayLabel = 'Login'
      FieldName = 'LOGIN'
      Size = 50
    end
    object FDMem_RegistroSENHA: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      Size = 50
    end
    object FDMem_RegistroPIN: TStringField
      FieldName = 'PIN'
      Size = 4
    end
    object FDMem_RegistroCELULAR: TStringField
      DisplayLabel = 'Celular'
      FieldName = 'CELULAR'
      EditMask = '(##)#####-####'
      Size = 15
    end
    object FDMem_RegistroEMAIL: TStringField
      DisplayLabel = 'E-Mail'
      FieldName = 'EMAIL'
      Size = 255
    end
    object FDMem_RegistroID_EMPRESA: TIntegerField
      DisplayLabel = 'Id Empresa'
      FieldName = 'ID_EMPRESA'
    end
    object FDMem_RegistroID_PRESTADOR_SERVICO: TIntegerField
      DisplayLabel = 'Id Prestador de Servi'#231'o'
      FieldName = 'ID_PRESTADOR_SERVICO'
    end
    object FDMem_RegistroID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object FDMem_RegistroFOTO: TStringField
      DisplayLabel = 'Foto'
      FieldName = 'FOTO'
      Size = 255
    end
    object FDMem_RegistroFORM_INICIAL: TStringField
      FieldName = 'FORM_INICIAL'
      Size = 255
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      DisplayLabel = 'Dt. Cadastro'
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      DisplayLabel = 'Hr. Cadastro'
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroSINCRONIZADO: TIntegerField
      DisplayLabel = 'Sincronizado'
      FieldName = 'SINCRONIZADO'
    end
    object FDMem_RegistroEMPRESA: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMPRESA'
      Size = 255
    end
    object FDMem_RegistroPRESTADOR_SERVICO: TStringField
      DisplayLabel = 'Prestador de Servi'#231'o'
      FieldName = 'PRESTADOR_SERVICO'
      Size = 100
    end
    object FDMem_RegistroCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 255
    end
    object FDMem_RegistroTIPO_DESC: TStringField
      FieldName = 'TIPO_DESC'
      Size = 100
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 472
    Top = 312
  end
end
