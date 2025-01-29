object frmMov_ServPrestados_Add: TfrmMov_ServPrestados_Add
  Left = 0
  Top = 0
  Caption = 'Movimento de Servi'#231'os Prestados'
  ClientHeight = 659
  ClientWidth = 998
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lbid: TLabel
    Left = 65
    Top = 24
    Width = 13
    Height = 15
    Caption = 'Id:'
  end
  object lbdescricao: TLabel
    Left = 24
    Top = 53
    Width = 54
    Height = 15
    Caption = 'Descri'#231#227'o:'
  end
  object lbstatus: TLabel
    Left = 441
    Top = 24
    Width = 35
    Height = 15
    Caption = 'Status:'
  end
  object lbid_empresa: TLabel
    Left = 30
    Top = 82
    Width = 48
    Height = 15
    Caption = 'Empresa:'
  end
  object lbid_prestador_servico: TLabel
    Left = 8
    Top = 114
    Width = 70
    Height = 15
    Caption = 'Prest. Servi'#231'o'
  end
  object lbid_cliente: TLabel
    Left = 8
    Top = 145
    Width = 37
    Height = 15
    Caption = 'Cliente'
  end
  object lbid_tabela: TLabel
    Left = 8
    Top = 176
    Width = 54
    Height = 15
    Caption = 'Tab. Pre'#231'o'
  end
  object lbid_conta: TLabel
    Left = 8
    Top = 205
    Width = 54
    Height = 15
    Caption = 'Tab. Pre'#231'o'
  end
  object lbdt_registro: TLabel
    Left = 216
    Top = 24
    Width = 70
    Height = 15
    Caption = 'Data Registro'
  end
  object lbhr_inicio: TLabel
    Left = 45
    Top = 241
    Width = 29
    Height = 15
    Caption = 'In'#237'cio'
  end
  object lbhr_fim: TLabel
    Left = 190
    Top = 238
    Width = 20
    Height = 15
    Caption = 'Fim'
  end
  object lbhr_total: TLabel
    Left = 472
    Top = 238
    Width = 25
    Height = 15
    Caption = 'Total'
  end
  object lbvlr_hora: TLabel
    Left = 23
    Top = 262
    Width = 55
    Height = 15
    Caption = 'Valor Hora'
  end
  object lbsub_total: TLabel
    Left = 201
    Top = 262
    Width = 50
    Height = 15
    Caption = 'Sub-Total'
  end
  object lbdesconto: TLabel
    Left = 378
    Top = 264
    Width = 50
    Height = 15
    Caption = 'Desconto'
  end
  object lbacrescimo: TLabel
    Left = 546
    Top = 267
    Width = 56
    Height = 15
    Caption = 'Acr'#233'scimo'
  end
  object lbtotal: TLabel
    Left = 722
    Top = 267
    Width = 25
    Height = 15
    Caption = 'Total'
  end
  object lbobservacao: TLabel
    Left = 8
    Top = 292
    Width = 62
    Height = 15
    Caption = 'Observa'#231#227'o'
  end
  object lbdt_pago: TLabel
    Left = 8
    Top = 325
    Width = 64
    Height = 15
    Caption = 'Pagamento:'
  end
  object lbvlr_pago: TLabel
    Left = 215
    Top = 320
    Width = 27
    Height = 15
    Caption = 'Pago'
  end
  object edid: TEdit
    Left = 84
    Top = 21
    Width = 107
    Height = 23
    TabOrder = 0
  end
  object eddescricao: TEdit
    Left = 84
    Top = 50
    Width = 508
    Height = 23
    TabOrder = 1
  end
  object cbstatus: TComboBox
    Left = 482
    Top = 21
    Width = 110
    Height = 23
    ItemIndex = 0
    TabOrder = 2
    Text = 'ABERTO'
    Items.Strings = (
      'ABERTO'
      'PAGO')
  end
  object edid_empresa: TEdit
    Left = 84
    Top = 79
    Width = 457
    Height = 23
    TabOrder = 3
  end
  object btid_empresa: TButton
    Left = 547
    Top = 79
    Width = 45
    Height = 25
    Caption = 'Loc'
    TabOrder = 4
  end
  object edid_prestador_servico: TEdit
    Left = 84
    Top = 110
    Width = 457
    Height = 23
    TabOrder = 5
  end
  object btid_prestador_servico: TButton
    Left = 547
    Top = 110
    Width = 45
    Height = 25
    Caption = 'Loc'
    TabOrder = 6
  end
  object edid_cliente: TEdit
    Left = 84
    Top = 141
    Width = 457
    Height = 23
    TabOrder = 7
  end
  object btid_cliente: TButton
    Left = 547
    Top = 141
    Width = 45
    Height = 25
    Caption = 'Loc'
    TabOrder = 8
  end
  object edid_tabela: TEdit
    Left = 84
    Top = 172
    Width = 338
    Height = 23
    TabOrder = 9
  end
  object btid_tabela: TButton
    Left = 547
    Top = 172
    Width = 45
    Height = 25
    Caption = 'Loc'
    TabOrder = 10
  end
  object edid_tabela_Vlr: TEdit
    Left = 428
    Top = 170
    Width = 113
    Height = 23
    TabOrder = 11
  end
  object edid_conta: TEdit
    Left = 84
    Top = 201
    Width = 338
    Height = 23
    TabOrder = 12
  end
  object btid_conta: TButton
    Left = 547
    Top = 201
    Width = 45
    Height = 25
    Caption = 'Loc'
    TabOrder = 13
  end
  object edid_conta_tipo: TEdit
    Left = 428
    Top = 199
    Width = 113
    Height = 23
    TabOrder = 14
  end
  object eddt_registro: TDateTimePicker
    Left = 292
    Top = 16
    Width = 113
    Height = 23
    Date = 45685.000000000000000000
    Time = 0.380987650460156100
    TabOrder = 15
  end
  object edhr_inicio: TDateTimePicker
    Left = 80
    Top = 230
    Width = 89
    Height = 23
    Date = 45685.000000000000000000
    Time = 0.381801678238844000
    DateFormat = dfLong
    Kind = dtkTime
    TabOrder = 16
  end
  object edhr_fim: TDateTimePicker
    Left = 216
    Top = 230
    Width = 89
    Height = 23
    Date = 45685.000000000000000000
    Time = 0.381801678238844000
    DateFormat = dfLong
    Kind = dtkTime
    TabOrder = 17
  end
  object edvlr_hora: TEdit
    Left = 84
    Top = 259
    Width = 107
    Height = 23
    TabOrder = 18
  end
  object edsub_total: TEdit
    Left = 257
    Top = 259
    Width = 107
    Height = 23
    TabOrder = 19
  end
  object eddesconto: TEdit
    Left = 434
    Top = 261
    Width = 107
    Height = 23
    TabOrder = 20
  end
  object edacrescimo: TEdit
    Left = 608
    Top = 259
    Width = 107
    Height = 23
    TabOrder = 21
  end
  object edtotal: TEdit
    Left = 753
    Top = 278
    Width = 107
    Height = 23
    TabOrder = 22
  end
  object edobservacao: TEdit
    Left = 84
    Top = 288
    Width = 776
    Height = 23
    TabOrder = 23
  end
  object eddt_pago: TDateTimePicker
    Left = 84
    Top = 317
    Width = 113
    Height = 23
    Date = 45685.000000000000000000
    Time = 0.380987650460156100
    TabOrder = 24
  end
  object edhr_total: TEdit
    Left = 503
    Top = 228
    Width = 113
    Height = 23
    TabOrder = 25
  end
  object edvlr_pago: TEdit
    Left = 271
    Top = 317
    Width = 107
    Height = 23
    TabOrder = 26
  end
  object Button1: TButton
    Left = 1000
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 27
  end
  object btConfirmar: TButton
    Left = 257
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 28
    OnClick = btConfirmarClick
  end
  object btCancelar: TButton
    Left = 338
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 29
    OnClick = btCancelarClick
  end
end
