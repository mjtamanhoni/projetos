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
        object DBGrid_Permissoes: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 36
          Width = 963
          Height = 275
          Align = alClient
          DataSource = dsPermissoes
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'projeto'
              Title.Alignment = taCenter
              Title.Caption = 'Projeto'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'descricaoResumida'
              Title.Alignment = taCenter
              Title.Caption = 'Funcionalidade'
              Width = 400
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'acesso'
              Title.Alignment = taCenter
              Title.Caption = 'Acesso'
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'incluir'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'alterar'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'excluir'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'imprimir'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'id'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'idUsuario'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'idProjeto'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'idTelaProjeto'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'usuario'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'nomeForm'
              Title.Alignment = taCenter
              Visible = False
            end>
        end
        object pnPermissao_Header: TPanel
          Left = 0
          Top = 0
          Width = 969
          Height = 33
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object btPermissao_ADD: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 75
            Height = 27
            Align = alLeft
            Caption = 'Novo'
            TabOrder = 0
            OnClick = btConfirmarClick
          end
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
        object DBGrid_Empresa: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 36
          Width = 963
          Height = 275
          Align = alClient
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
        object pnEmpresa_ADD: TPanel
          Left = 0
          Top = 0
          Width = 969
          Height = 33
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object btEmpresa_ADD: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 75
            Height = 27
            Align = alLeft
            Caption = 'Novo'
            TabOrder = 0
            OnClick = btConfirmarClick
          end
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
    Left = 416
    Top = 200
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
    Left = 408
    Top = 264
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
      Size = 500
    end
  end
  object dsPermissoes: TDataSource
    DataSet = FDMem_Permissoes
    Left = 408
    Top = 320
  end
  object FDMem_Empresas: TFDMemTable
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
    Left = 568
    Top = 272
    object FDMem_Empresasid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_EmpresasidUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object FDMem_EmpresasidEmpresa: TIntegerField
      FieldName = 'idEmpresa'
    end
    object FDMem_EmpresasdtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_EmpresashrCadastro: TTimeField
      FieldName = 'hrCadastro'
    end
    object FDMem_Empresasusuario: TStringField
      FieldName = 'usuario'
      Size = 255
    end
    object FDMem_Empresasempresa: TStringField
      FieldName = 'empresa'
      Size = 255
    end
  end
  object dsEmpresas: TDataSource
    DataSet = FDMem_Empresas
    Left = 568
    Top = 328
  end
end
