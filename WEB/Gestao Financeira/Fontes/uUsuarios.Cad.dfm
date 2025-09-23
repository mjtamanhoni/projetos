object frmUsuarios_Cad: TfrmUsuarios_Cad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 525
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object btCancelar: TButton
    Left = 910
    Top = 492
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = btCancelarClick
  end
  object btConfirmar: TButton
    Left = 829
    Top = 492
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btConfirmarClick
  end
  object pnRow001: TPanel
    Left = 0
    Top = 0
    Width = 993
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = -108
    ExplicitWidth = 1067
    object lbid: TLabel
      Left = 82
      Top = 13
      Width = 10
      Height = 15
      Caption = 'Id'
    end
    object lbnome: TLabel
      Left = 370
      Top = 13
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lbStatus: TLabel
      Left = 211
      Top = 13
      Width = 32
      Height = 15
      Caption = 'Status'
    end
    object edid: TEdit
      Left = 98
      Top = 12
      Width = 89
      Height = 23
      Enabled = False
      TabOrder = 0
      TextHint = 'Id'
      OnKeyPress = edidKeyPress
    end
    object ednome: TEdit
      Left = 409
      Top = 12
      Width = 568
      Height = 23
      TabOrder = 2
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = ednomeKeyPress
    end
    object cbstatus: TComboBox
      Left = 249
      Top = 12
      Width = 115
      Height = 23
      TabOrder = 1
      Text = 'Selecione'
      OnKeyPress = cbstatusKeyPress
      Items.Strings = (
        'INATIVO'
        'ATIVO')
    end
  end
  object pnRow002: TPanel
    Left = 0
    Top = 41
    Width = 993
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitLeft = -8
    object lbtipo: TLabel
      Left = 54
      Top = 6
      Width = 23
      Height = 15
      Caption = 'Tipo'
    end
    object lblogin: TLabel
      Left = 226
      Top = 3
      Width = 30
      Height = 15
      Caption = 'Login'
    end
    object lbsenha: TLabel
      Left = 490
      Top = 1
      Width = 32
      Height = 15
      Caption = 'Senha'
    end
    object lbpin: TLabel
      Left = 859
      Top = 6
      Width = 19
      Height = 15
      Caption = 'PIN'
    end
    object cbtipo: TComboBox
      Left = 98
      Top = 0
      Width = 115
      Height = 23
      TabOrder = 0
      Text = 'Selecione'
      OnKeyPress = cbtipoKeyPress
      Items.Strings = (
        'ADMINISTRADOR'
        'GERENTE'
        'NORMAL')
    end
    object edlogin: TEdit
      Left = 268
      Top = 0
      Width = 216
      Height = 23
      TabOrder = 1
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = edloginKeyPress
    end
    object edsenha: TEdit
      Left = 529
      Top = 0
      Width = 192
      Height = 23
      PasswordChar = '*'
      TabOrder = 2
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = edsenhaKeyPress
    end
    object edpin: TEdit
      Left = 884
      Top = 0
      Width = 93
      Height = 23
      NumbersOnly = True
      PasswordChar = '*'
      TabOrder = 3
      TextHint = 'Informe a Descri'#231#227'o'
      OnKeyPress = edpinKeyPress
    end
  end
  object pnRow003: TPanel
    Left = 0
    Top = 82
    Width = 993
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 88
    object lbemail: TLabel
      Left = 60
      Top = 6
      Width = 34
      Height = 15
      Caption = 'E-Mail'
    end
    object edemail: TEdit
      Left = 98
      Top = 0
      Width = 568
      Height = 23
      TabOrder = 0
      TextHint = 'E-Mail do Usu'#225'rio'
    end
  end
  object pcPrincipal: TPageControl
    Left = 8
    Top = 129
    Width = 977
    Height = 344
    ActivePage = tsPermissoes
    TabOrder = 5
    object tsPermissoes: TTabSheet
      Caption = 'Permiss'#245'es'
      object pnPermissoes: TPanel
        Left = 0
        Top = 0
        Width = 969
        Height = 314
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 392
        ExplicitTop = 136
        ExplicitWidth = 185
        ExplicitHeight = 41
        object DBGrid_Permissoes: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 963
          Height = 308
          Align = alClient
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
    end
    object tsEmpresas: TTabSheet
      Caption = 'Empresas'
      ImageIndex = 1
      object pnEmpresa: TPanel
        Left = 0
        Top = 0
        Width = 969
        Height = 314
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 392
        ExplicitTop = 136
        ExplicitWidth = 185
        ExplicitHeight = 41
        object DBGrid_Empresa: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 963
          Height = 308
          Align = alClient
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
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
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_RegistrostatusDesc: TStringField
      FieldName = 'statusDesc'
      Size = 50
    end
  end
end
