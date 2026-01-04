object frmUsuarios_Empresa: TfrmUsuarios_Empresa
  Left = 0
  Top = 0
  Caption = 'Adiciona Empresa ao Usu'#225'rio'
  ClientHeight = 380
  ClientWidth = 981
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnRow001: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 975
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbEmpresa: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 107
      Height = 25
      Align = alLeft
      Caption = 'Selecione a empresa'
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object edidEmpresa: TButtonedEdit
      AlignWithMargins = True
      Left = 116
      Top = 3
      Width = 89
      Height = 25
      Align = alLeft
      Alignment = taRightJustify
      RightButton.Visible = True
      TabOrder = 0
      TextHint = 'Id'
      OnRightButtonClick = edidEmpresaRightButtonClick
      ExplicitHeight = 23
    end
    object edidEmpresa_Desc: TEdit
      AlignWithMargins = True
      Left = 211
      Top = 3
      Width = 761
      Height = 25
      TabStop = False
      Align = alClient
      ReadOnly = True
      TabOrder = 1
      TextHint = 'Descri'#231#227'o'
      ExplicitHeight = 23
    end
  end
  object pnFooter: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 40
    Width = 975
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 8
    object btCancelar: TButton
      AlignWithMargins = True
      Left = 897
      Top = 3
      Width = 75
      Height = 27
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 0
      OnClick = btCancelarClick
    end
    object btConfirmar: TButton
      AlignWithMargins = True
      Left = 816
      Top = 3
      Width = 75
      Height = 27
      Align = alRight
      Caption = 'Corfirmar'
      TabOrder = 1
      OnClick = btConfirmarClick
    end
  end
end
