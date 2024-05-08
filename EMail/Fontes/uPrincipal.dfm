object frmPrincipal: TfrmPrincipal
  Left = 294
  Top = 202
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Exemplo ACBrMail'
  ClientHeight = 843
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
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
    ExplicitWidth = 742
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
    Height = 802
    ActivePage = tsMensagem
    Align = alClient
    TabOrder = 1
    ExplicitTop = 46
    ExplicitWidth = 748
    object tsMensagem: TTabSheet
      Caption = 'E-Mail'
      object pnOpcoes: TPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 377
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 2
        ExplicitWidth = 740
        object Label2: TLabel
          Left = 337
          Top = 2
          Width = 107
          Height = 16
          Caption = 'Assunto (Subject):'
          Color = clBtnFace
          ParentColor = False
        end
        object Label4: TLabel
          Left = 10
          Top = 195
          Width = 175
          Height = 16
          Caption = 'Mensagem (Body modo HTML)'
          Color = clBtnFace
          ParentColor = False
        end
        object Label5: TLabel
          Left = 337
          Top = 50
          Width = 23
          Height = 16
          Caption = 'LOG'
          Color = clBtnFace
          ParentColor = False
        end
        object grpOpcoes: TGroupBox
          Left = 3
          Top = 5
          Width = 318
          Height = 171
          Caption = '[ Op'#231#245'es ]'
          TabOrder = 0
          object cbUsarTXT: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 308
            Height = 19
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Enviar Mensagem em TXT'
            TabOrder = 0
            ExplicitLeft = 16
            ExplicitTop = 17
            ExplicitWidth = 158
          end
          object cbUsarHTML: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 37
            Width = 308
            Height = 19
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Enviar Mensagem em HTML'
            Checked = True
            State = cbChecked
            TabOrder = 1
            ExplicitLeft = 16
            ExplicitWidth = 170
          end
          object cbAddImgHTML: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 56
            Width = 308
            Height = 19
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Incluir Imagem em HTML'
            TabOrder = 2
            ExplicitLeft = 2
            ExplicitWidth = 314
          end
          object cbAddImgAtt: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 75
            Width = 308
            Height = 19
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Incluir Imagem em Anexo'
            Checked = True
            State = cbChecked
            TabOrder = 3
            ExplicitLeft = 16
            ExplicitTop = 76
            ExplicitWidth = 156
          end
          object cbAddPDF: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 94
            Width = 308
            Height = 19
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Incluir Anexo de PDF'
            TabOrder = 4
            ExplicitLeft = 16
            ExplicitTop = 96
            ExplicitWidth = 129
          end
          object cbAddXML: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 113
            Width = 308
            Height = 19
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Incluir XML por Stream'
            TabOrder = 5
            ExplicitLeft = 16
            ExplicitTop = 117
            ExplicitWidth = 141
          end
          object cbUsarThread: TCheckBox
            AlignWithMargins = True
            Left = 5
            Top = 132
            Width = 308
            Height = 19
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Usar thread'
            TabOrder = 6
            ExplicitLeft = 16
            ExplicitTop = 137
            ExplicitWidth = 80
          end
        end
        object edSubject: TEdit
          Left = 337
          Top = 20
          Width = 636
          Height = 24
          TabOrder = 1
          Text = 'IPTV Master'
        end
        object mLog: TMemo
          Left = 335
          Top = 69
          Width = 636
          Height = 140
          TabOrder = 2
        end
        object mBody: TMemo
          Left = 8
          Top = 214
          Width = 963
          Height = 128
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Lines.Strings = (
            '<h1><strong>IPTV MASTER</strong></h1>'
            
              '<p><strong>Link para acesso a IPTV em Smartv, Computador, Celula' +
              'r.</strong></p>'
            
              '<p><strong>Poder&aacute; ser feito a desist&ecirc;ncia at&eacute' +
              '; 7 dias</strong></p>'
            '<p><strong>Link Abaixo:</strong></p>'
            '<p></p>'
            
              '<p><strong><a href="http://conesoftdobrasi.com.br">http://coneso' +
              'ftdobrasi.com.br</a></strong></p>')
          ParentFont = False
          TabOrder = 3
          WordWrap = False
        end
        object ProgressBar1: TProgressBar
          Left = 10
          Top = 348
          Width = 961
          Height = 20
          Max = 11
          Step = 1
          TabOrder = 4
        end
      end
      object gbListaEmails: TGroupBox
        Left = 0
        Top = 377
        Width = 978
        Height = 358
        Align = alClient
        Caption = '[ Lista de E-Mails ]'
        TabOrder = 0
        ExplicitLeft = 3
        ExplicitTop = 374
        ExplicitWidth = 729
        ExplicitHeight = 355
        object Memo_ListaEmails: TMemo
          AlignWithMargins = True
          Left = 5
          Top = 21
          Width = 968
          Height = 332
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Lines.Strings = (
            'mjtamanhoni@gmail.com'
            'sltamanhoni@gmail.com'
            'gctamanhoni@gmail.com'
            'nltamanhoni@gmail.com')
          ParentFont = False
          TabOrder = 0
          ExplicitTop = 18
          ExplicitWidth = 719
          ExplicitHeight = 343
        end
      end
      object pnAcoesListaEmails: TPanel
        Left = 0
        Top = 735
        Width = 978
        Height = 36
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
        ExplicitLeft = 3
        ExplicitTop = 734
        ExplicitWidth = 724
        object btGravarLista: TButton
          Left = 1
          Top = 1
          Width = 150
          Height = 34
          Align = alLeft
          Caption = 'Gravar Lista'
          TabOrder = 0
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
          ExplicitLeft = 301
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
