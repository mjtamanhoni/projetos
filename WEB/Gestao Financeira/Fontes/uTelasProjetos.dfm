object frmTelasProjetos: TfrmTelasProjetos
  Left = 0
  Top = 0
  Caption = 'Telas de Projetos'
  ClientHeight = 450
  ClientWidth = 800
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
    Width = 800
    Height = 50
    Align = alTop
    TabOrder = 0
    object btnNovo: TButton
      Left = 10
      Top = 10
      Width = 75
      Height = 30
      Caption = '&Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 90
      Top = 10
      Width = 75
      Height = 30
      Caption = '&Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnExcluir: TButton
      Left = 170
      Top = 10
      Width = 75
      Height = 30
      Caption = 'E&xcluir'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnLocalizar: TButton
      Left = 250
      Top = 10
      Width = 75
      Height = 30
      Caption = '&Localizar'
      TabOrder = 3
      OnClick = btnLocalizarClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 400
    Width = 800
    Height = 50
    Align = alBottom
    TabOrder = 1
    object btnSair: TButton
      Left = 715
      Top = 10
      Width = 75
      Height = 30
      Caption = '&Sair'
      TabOrder = 0
      OnClick = btnSairClick
    end
  end
  object dbgTelasProjetos: TDBGrid
    Left = 0
    Top = 50
    Width = 800
    Height = 350
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end