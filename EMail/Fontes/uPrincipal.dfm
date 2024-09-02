object frmPrincipal: TfrmPrincipal
  Left = 294
  Top = 202
  Caption = 'Exemplo ACBrMail'
  ClientHeight = 767
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 16
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 986
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 980
    object imgLogo: TImage
      Left = 1
      Top = 1
      Width = 96
      Height = 39
      Align = alLeft
      Center = True
    end
    object lblDescricao: TLabel
      Left = 103
      Top = 7
      Width = 243
      Height = 23
      Caption = 'Envio de E-Mail autom'#225'tico'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Times New Roman'
      Font.Style = [fsItalic]
      ParentFont = False
    end
  end
  object pcPrincipal: TPageControl
    Left = 0
    Top = 41
    Width = 986
    Height = 726
    ActivePage = tsMensagem
    Align = alClient
    TabOrder = 1
    object tsMensagem: TTabSheet
      Caption = 'E-Mail'
      object pnOpcoes: TPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 500
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 1
        ExplicitWidth = 972
        object Label4: TLabel
          Left = 2
          Top = 197
          Width = 974
          Height = 16
          Align = alTop
          Caption = 'Mensagem (Body modo HTML)'
          Color = clBtnFace
          ParentColor = False
          ExplicitWidth = 175
        end
        object mBody: TMemo
          Left = 2
          Top = 213
          Width = 974
          Height = 265
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
          ExplicitWidth = 968
        end
        object ProgressBar1: TProgressBar
          Left = 2
          Top = 478
          Width = 974
          Height = 20
          Align = alBottom
          Max = 11
          Step = 1
          TabOrder = 1
          ExplicitWidth = 968
        end
        object Panel1: TPanel
          Left = 2
          Top = 2
          Width = 974
          Height = 195
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          ExplicitWidth = 968
          object Label2: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 968
            Height = 16
            Align = alTop
            Caption = 'Assunto (Subject):'
            Color = clBtnFace
            ParentColor = False
            ExplicitLeft = 334
            ExplicitTop = -1
            ExplicitWidth = 107
          end
          object Label5: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 52
            Width = 968
            Height = 16
            Align = alTop
            Caption = 'LOG'
            Color = clBtnFace
            ParentColor = False
            ExplicitLeft = 343
            ExplicitTop = 47
            ExplicitWidth = 23
          end
          object edSubject: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 22
            Width = 968
            Height = 24
            Margins.Top = 0
            Align = alTop
            TabOrder = 0
            Text = '100 Giros gr'#225'tis'
            ExplicitLeft = 332
            ExplicitTop = 17
            ExplicitWidth = 636
          end
          object mLog: TMemo
            AlignWithMargins = True
            Left = 3
            Top = 71
            Width = 968
            Height = 121
            Margins.Top = 0
            Align = alClient
            ScrollBars = ssBoth
            TabOrder = 1
            ExplicitLeft = 332
            ExplicitTop = 66
            ExplicitWidth = 636
            ExplicitHeight = 111
          end
        end
      end
      object gbListaEmails: TGroupBox
        Left = 0
        Top = 500
        Width = 978
        Height = 195
        Align = alClient
        Caption = '[ Lista de E-Mails ]'
        TabOrder = 0
        ExplicitWidth = 972
        ExplicitHeight = 189
        object Memo_ListaEmails: TMemo
          AlignWithMargins = True
          Left = 5
          Top = 21
          Width = 968
          Height = 133
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          ExplicitWidth = 962
          ExplicitHeight = 127
        end
        object pnAcoesListaEmails: TPanel
          Left = 2
          Top = 157
          Width = 974
          Height = 36
          Align = alBottom
          BevelOuter = bvLowered
          TabOrder = 1
          ExplicitTop = 151
          ExplicitWidth = 968
          object lbPosicao: TLabel
            AlignWithMargins = True
            Left = 870
            Top = 4
            Width = 100
            Height = 28
            Align = alRight
            Alignment = taRightJustify
            AutoSize = False
            Caption = '1.000 de 1.000'
            Layout = tlCenter
            ExplicitLeft = 876
            ExplicitTop = 3
            ExplicitHeight = 34
          end
          object lbEmail: TLabel
            AlignWithMargins = True
            Left = 304
            Top = 4
            Width = 295
            Height = 28
            Align = alClient
            AutoSize = False
            Caption = 'mjtamanhoni@gmail.com'
            Layout = tlCenter
            ExplicitLeft = 887
            ExplicitTop = 1
            ExplicitWidth = 100
            ExplicitHeight = 34
          end
          object btGravarLista: TButton
            Left = 1
            Top = 1
            Width = 150
            Height = 34
            Align = alLeft
            Caption = 'Gravar Lista'
            TabOrder = 0
            Visible = False
          end
          object bEnviarLote: TButton
            Left = 151
            Top = 1
            Width = 150
            Height = 34
            Align = alLeft
            Caption = 'Enviar E-Mails da Lista'
            TabOrder = 1
            OnClick = bEnviarLoteClick
          end
          object ProgressBar: TProgressBar
            AlignWithMargins = True
            Left = 605
            Top = 4
            Width = 259
            Height = 28
            Align = alRight
            TabOrder = 2
            ExplicitLeft = 599
          end
        end
      end
    end
    object tsConfigConta: TTabSheet
      Caption = 'Configura'#231#227'o Conta'
      ImageIndex = 1
      object lblHost: TLabel
        Left = 3
        Top = 48
        Width = 30
        Height = 16
        Caption = 'Host:'
        Color = clBtnFace
        ParentColor = False
      end
      object lblFrom: TLabel
        Left = 3
        Top = 3
        Width = 74
        Height = 16
        Caption = 'From e-Mail:'
        Color = clBtnFace
        ParentColor = False
      end
      object lblFromName: TLabel
        Left = 292
        Top = 2
        Width = 72
        Height = 16
        Caption = 'From Name:'
        Color = clBtnFace
        ParentColor = False
      end
      object lblUser: TLabel
        Left = 3
        Top = 95
        Width = 68
        Height = 16
        Caption = 'User Name:'
        Color = clBtnFace
        ParentColor = False
      end
      object lblPassword: TLabel
        Left = 292
        Top = 95
        Width = 60
        Height = 16
        Caption = 'Password:'
        Color = clBtnFace
        ParentColor = False
      end
      object lblPort: TLabel
        Left = 292
        Top = 48
        Width = 28
        Height = 16
        Caption = 'Port:'
        Color = clBtnFace
        ParentColor = False
      end
      object lblTipoAutenticacao: TLabel
        Left = 364
        Top = 49
        Width = 107
        Height = 16
        Caption = 'Tipo Autentica'#231#227'o:'
        Color = clBtnFace
        ParentColor = False
      end
      object lblDefaultCharset: TLabel
        Left = 3
        Top = 140
        Width = 93
        Height = 16
        Caption = 'Default Charset:'
        Color = clBtnFace
        ParentColor = False
      end
      object lbl1: TLabel
        Left = 292
        Top = 140
        Width = 72
        Height = 16
        Caption = 'IDE Charset:'
        Color = clBtnFace
        ParentColor = False
      end
      object Label7: TLabel
        Left = 466
        Top = 49
        Width = 59
        Height = 16
        Caption = 'SSL Type:'
        Color = clBtnFace
        ParentColor = False
      end
      object Label1: TLabel
        Left = 3
        Top = 188
        Width = 93
        Height = 16
        Caption = 'Default Charset:'
        Color = clBtnFace
        ParentColor = False
      end
      object edtHost: TEdit
        Left = 3
        Top = 66
        Width = 283
        Height = 24
        TabOrder = 2
        Text = 'smtp.empresa.com.br'
      end
      object edtFrom: TEdit
        Left = 3
        Top = 21
        Width = 283
        Height = 24
        TabOrder = 0
        Text = 'fulano@empresa.com.br'
      end
      object edtFromName: TEdit
        Left = 292
        Top = 21
        Width = 283
        Height = 24
        TabOrder = 1
        Text = 'Fula do Tal'
      end
      object edtUser: TEdit
        Left = 3
        Top = 113
        Width = 283
        Height = 24
        TabOrder = 6
        Text = 'fulano@empresa.com.br'
      end
      object edtPassword: TEdit
        Left = 292
        Top = 113
        Width = 283
        Height = 24
        PasswordChar = '@'
        TabOrder = 7
        Text = 'fulano@empresa.com.br'
      end
      object chkMostraSenha: TCheckBox
        Left = 348
        Top = 94
        Width = 77
        Height = 17
        Caption = 'Mostrar?'
        TabOrder = 11
        OnClick = chkMostraSenhaClick
      end
      object edtPort: TEdit
        Left = 292
        Top = 66
        Width = 58
        Height = 24
        TabOrder = 3
        Text = '587'
      end
      object btnSalvar: TButton
        Left = 2
        Top = 256
        Width = 194
        Height = 33
        Caption = 'Salvar Configura'#231#227'o'
        TabOrder = 10
        OnClick = btnSalvarClick
      end
      object chkTLS: TCheckBox
        Left = 364
        Top = 68
        Width = 45
        Height = 17
        Caption = 'TLS'
        TabOrder = 4
        OnClick = chkMostraSenhaClick
      end
      object chkSSL: TCheckBox
        Left = 415
        Top = 68
        Width = 45
        Height = 17
        Caption = 'SSL'
        TabOrder = 5
        OnClick = chkMostraSenhaClick
      end
      object cbbDefaultCharset: TComboBox
        Left = 3
        Top = 159
        Width = 283
        Height = 24
        Style = csDropDownList
        TabOrder = 8
      end
      object cbbIdeCharSet: TComboBox
        Left = 292
        Top = 160
        Width = 283
        Height = 24
        Style = csDropDownList
        TabOrder = 9
      end
      object btLerConfig: TButton
        Left = 218
        Top = 256
        Width = 194
        Height = 33
        Caption = 'Ler Configura'#231#227'o'
        TabOrder = 12
        OnClick = btLerConfigClick
      end
      object cbxSSLTYPE: TComboBox
        Left = 466
        Top = 68
        Width = 109
        Height = 24
        Style = csDropDownList
        TabOrder = 13
      end
      object cbEstilo: TComboBox
        Left = 3
        Top = 207
        Width = 283
        Height = 24
        Style = csDropDownList
        TabOrder = 14
        OnClick = cbEstiloClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Log'
      ImageIndex = 2
      object Memo_Log: TMemo
        Left = 0
        Top = 0
        Width = 978
        Height = 695
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 400
        ExplicitTop = 304
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
    end
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    OnBeforeMailProcess = ACBrMail1BeforeMailProcess
    OnMailProcess = ACBrMail1MailProcess
    OnAfterMailProcess = ACBrMail1AfterMailProcess
    OnMailException = ACBrMail1MailException
    Left = 672
    Top = 62
  end
end
