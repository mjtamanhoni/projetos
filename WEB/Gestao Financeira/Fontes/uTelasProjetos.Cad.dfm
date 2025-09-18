object frmTelasProjetosCad: TfrmTelasProjetosCad
  Left = 0
  Top = 0
  Caption = 'Cadastro - Telas de Projetos'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 40
    Align = alTop
    Caption = 'Cadastro de Telas de Projetos'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 350
    Width = 600
    Height = 50
    Align = alBottom
    TabOrder = 1
    object btnSalvar: TButton
      Left = 435
      Top = 10
      Width = 75
      Height = 30
      Caption = '&Salvar'
      Default = True
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 515
      Top = 10
      Width = 75
      Height = 30
      Cancel = True
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object pnlCenter: TPanel
    Left = 0
    Top = 40
    Width = 600
    Height = 310
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lblId: TLabel
      Left = 20
      Top = 20
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object lblNome: TLabel
      Left = 20
      Top = 60
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object lblDescricao: TLabel
      Left = 20
      Top = 100
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object edtId: TEdit
      Left = 80
      Top = 17
      Width = 100
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 80
      Top = 57
      Width = 400
      Height = 21
      TabOrder = 1
    end
    object memoDescricao: TMemo
      Left = 80
      Top = 97
      Width = 400
      Height = 150
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
end