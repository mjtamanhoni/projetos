object frmTelasProjetosLoc: TfrmTelasProjetosLoc
  Left = 0
  Top = 0
  Caption = 'Localizar - Telas de Projetos'
  ClientHeight = 450
  ClientWidth = 700
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
    Width = 700
    Height = 80
    Align = alTop
    TabOrder = 0
    object lblFiltro: TLabel
      Left = 20
      Top = 20
      Width = 26
      Height = 13
      Caption = 'Filtro'
    end
    object edtFiltro: TEdit
      Left = 20
      Top = 40
      Width = 400
      Height = 21
      TabOrder = 0
      OnKeyPress = edtFiltroKeyPress
    end
    object btnPesquisar: TButton
      Left = 430
      Top = 38
      Width = 75
      Height = 25
      Caption = '&Pesquisar'
      Default = True
      TabOrder = 1
      OnClick = btnPesquisarClick
    end
    object btnLimpar: TButton
      Left = 510
      Top = 38
      Width = 75
      Height = 25
      Caption = '&Limpar'
      TabOrder = 2
      OnClick = btnLimparClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 400
    Width = 700
    Height = 50
    Align = alBottom
    TabOrder = 1
    object btnSelecionar: TButton
      Left = 535
      Top = 10
      Width = 75
      Height = 30
      Caption = '&Selecionar'
      Default = True
      TabOrder = 0
      OnClick = btnSelecionarClick
    end
    object btnCancelar: TButton
      Left = 615
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
    Top = 80
    Width = 700
    Height = 320
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object dbgResultados: TDBGrid
      Left = 0
      Top = 0
      Width = 700
      Height = 320
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end