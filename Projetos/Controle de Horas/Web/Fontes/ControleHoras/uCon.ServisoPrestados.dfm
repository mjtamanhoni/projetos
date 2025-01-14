object frmCon_ServicosPrestados: TfrmCon_ServicosPrestados
  Left = 0
  Top = 0
  Caption = 'Consulta de Servi'#231'os Prestados'
  ClientHeight = 744
  ClientWidth = 1043
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnFiltro: TPanel
    Left = 0
    Top = 0
    Width = 1043
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    ExplicitWidth = 1039
    object lbFiltro_Cliente: TLabel
      Left = 8
      Top = 13
      Width = 37
      Height = 15
      Caption = 'Cliente'
    end
    object lbFiltro_Data_I: TLabel
      Left = 416
      Top = 13
      Width = 49
      Height = 15
      Caption = 'Dt. Inicial'
    end
    object lbFiltro_Data_F: TLabel
      Left = 626
      Top = 13
      Width = 43
      Height = 15
      Caption = 'Dt. Final'
    end
    object edFiltro_Cliente_ID: TButtonedEdit
      Left = 51
      Top = 12
      Width = 106
      Height = 23
      Alignment = taRightJustify
      Images = ImageList
      RightButton.ImageIndex = 0
      RightButton.Visible = True
      TabOrder = 0
      OnRightButtonClick = edFiltro_Cliente_IDRightButtonClick
    end
    object edFiltro_Cliente: TEdit
      Left = 163
      Top = 12
      Width = 238
      Height = 23
      ReadOnly = True
      TabOrder = 1
      TextHint = 'Nome do Cliente'
    end
    object edFiltro_DataI: TDateTimePicker
      Left = 479
      Top = 10
      Width = 106
      Height = 23
      Date = 45667.000000000000000000
      Time = 0.712431180552812300
      TabOrder = 2
    end
    object edFiltro_DataF: TDateTimePicker
      Left = 675
      Top = 13
      Width = 106
      Height = 23
      Date = 45667.000000000000000000
      Time = 0.712431180552812300
      TabOrder = 3
    end
    object btFiltro_Filtrar: TButton
      Left = 864
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Filtrar'
      TabOrder = 4
      OnClick = btFiltro_FiltrarClick
    end
  end
  object pnCards: TPanel
    Left = 0
    Top = 41
    Width = 1043
    Height = 120
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    ExplicitWidth = 1039
    object pnCard_ValoresClienbte: TPanel
      Left = 8
      Top = 6
      Width = 241
      Height = 100
      BevelInner = bvLowered
      TabOrder = 0
      object lbVC_Titulo: TLabel
        Left = 43
        Top = 10
        Width = 135
        Height = 17
        Alignment = taCenter
        Caption = 'VALORES DO CLIENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbVC_HorasPrevistas: TLabel
        Left = 14
        Top = 33
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Horas:'
      end
      object lbVC_ValorHora: TLabel
        Left = 14
        Top = 54
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor:'
      end
      object lbVC_Totais: TLabel
        Left = 14
        Top = 75
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Totais:'
      end
      object lbVC_HorasPrevistas_T: TLabel
        Left = 103
        Top = 33
        Width = 122
        Height = 15
        AutoSize = False
        Caption = '00:00:00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbVC_ValorHora_T: TLabel
        Left = 103
        Top = 54
        Width = 122
        Height = 15
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbVC_Totais_T: TLabel
        Left = 103
        Top = 74
        Width = 122
        Height = 15
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnCard_MesAnterior: TPanel
      Left = 255
      Top = 6
      Width = 241
      Height = 100
      BevelInner = bvLowered
      TabOrder = 1
      object lbVA_Titulo: TLabel
        Left = 43
        Top = 10
        Width = 154
        Height = 17
        Alignment = taCenter
        Caption = 'VALORES M'#202'S ANTERIOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMA_HorasAcumuladas: TLabel
        Left = 14
        Top = 33
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Horas:'
      end
      object lbMA_Valor: TLabel
        Left = 14
        Top = 54
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor:'
      end
      object lbMA_HorasAcumuladas_T: TLabel
        Left = 103
        Top = 33
        Width = 122
        Height = 15
        AutoSize = False
        Caption = '00:00:00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMA_Valor_T: TLabel
        Left = 103
        Top = 54
        Width = 122
        Height = 15
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnCard_MesAtual: TPanel
      Left = 502
      Top = 6
      Width = 241
      Height = 100
      BevelInner = bvLowered
      TabOrder = 2
      object lbMAT_Tit: TLabel
        Left = 43
        Top = 10
        Width = 155
        Height = 17
        Alignment = taCenter
        Caption = 'VALORES DO M'#202'S ATUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMAT_Horas: TLabel
        Left = 14
        Top = 33
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Horas:'
      end
      object lbMAT_Valor: TLabel
        Left = 14
        Top = 54
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor:'
      end
      object lbMAT_Horas_T: TLabel
        Left = 103
        Top = 33
        Width = 122
        Height = 15
        AutoSize = False
        Caption = '00:00:00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMAT_Valor_T: TLabel
        Left = 103
        Top = 54
        Width = 122
        Height = 15
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnCard_Totais: TPanel
      Left = 749
      Top = 6
      Width = 241
      Height = 100
      BevelInner = bvLowered
      TabOrder = 3
      object lbT_Titulo: TLabel
        Left = 43
        Top = 10
        Width = 44
        Height = 17
        Alignment = taCenter
        Caption = 'TOTAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbT_Horas: TLabel
        Left = 14
        Top = 33
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Horas:'
      end
      object lbT_Valor: TLabel
        Left = 14
        Top = 54
        Width = 83
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor:'
      end
      object lbT_Horas_T: TLabel
        Left = 103
        Top = 33
        Width = 122
        Height = 15
        AutoSize = False
        Caption = '00:00:00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbT_Valor_T: TLabel
        Left = 103
        Top = 54
        Width = 122
        Height = 15
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 161
    Width = 1043
    Height = 583
    Align = alClient
    DataSource = dmRegistro
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'data'
        Title.Alignment = taCenter
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hrInicio'
        Title.Alignment = taCenter
        Title.Caption = 'Hr. In'#237'cio'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hrFim'
        Title.Alignment = taCenter
        Title.Caption = 'Hr. Fim'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hrTotal'
        Title.Alignment = taCenter
        Title.Caption = 'Hr. Total'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlrHora'
        Title.Alignment = taCenter
        Title.Caption = 'Vlr. Hora'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'subTotal'
        Title.Alignment = taCenter
        Title.Caption = 'Sub-Total'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'desconto'
        Title.Alignment = taCenter
        Title.Caption = 'Desconto'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'acrescimo'
        Title.Alignment = taCenter
        Title.Caption = 'Acr'#233'scimo'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'total'
        Title.Alignment = taCenter
        Title.Caption = 'Total'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'conta'
        Title.Alignment = taCenter
        Title.Caption = 'Conta'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'status'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'idEmpresa'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'idPrestadorServico'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'idCliente'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'idTabela'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'idConta'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'descontoMotivo'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'acrescimoMotivo'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'dtPago'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'vlrPago'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'dtCadastro'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hrCadastro'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'idUsuario'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'statusDesc'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'empresa'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'prestadorServico'
        Title.Alignment = taCenter
        Title.Caption = 'Prest. Servi'#231'o'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Title.Alignment = taCenter
        Title.Caption = 'Cliente'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tabelaPreco'
        Title.Alignment = taCenter
        Title.Caption = 'Tabela Pre'#231'o'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'tipoTabela'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'tipoTabelaDesc'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'tipoConta'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'tipoContaDesc'
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'observacao'
        Title.Alignment = taCenter
        Title.Caption = 'Observa'#231#227'o'
        Width = 1000
        Visible = True
      end>
  end
  object ImageList: TImageList
    Left = 792
    Top = 344
    Bitmap = {
      494C010103000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000848887D600000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF797D7CC4000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF797D7CC5000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002F31304C929796EE00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF929696ED000000000000
      00000000000000000000000000000000000000000000000000009DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF8B908FE20000000000000000000000009DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2A1FF9DA2
      A1FF9DA2A1FF9DA2A1FF8A8E8DE0000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF2E2F2F4A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF2D2F2E49000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009DA2A1FF9DA2A1FF919695EC000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003132324F949897F000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009DA2A1FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object FDMem_Registro: TFDMemTable
    IndexFieldNames = 'seq'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 272
    Top = 224
    object FDMem_Registroid: TIntegerField
      FieldName = 'id'
    end
    object FDMem_Registrodescricao: TStringField
      FieldName = 'descricao'
      Size = 255
    end
    object FDMem_Registrostatus: TIntegerField
      FieldName = 'status'
    end
    object FDMem_RegistroidEmpresa: TIntegerField
      FieldName = 'idEmpresa'
    end
    object FDMem_RegistroidPrestadorServico: TIntegerField
      FieldName = 'idPrestadorServico'
    end
    object FDMem_RegistroidCliente: TIntegerField
      FieldName = 'idCliente'
    end
    object FDMem_RegistroidTabela: TIntegerField
      FieldName = 'idTabela'
    end
    object FDMem_RegistroidConta: TIntegerField
      FieldName = 'idConta'
    end
    object FDMem_Registrodata: TDateField
      FieldName = 'data'
    end
    object FDMem_RegistrohrInicio: TStringField
      FieldName = 'hrInicio'
    end
    object FDMem_RegistrohrFim: TStringField
      FieldName = 'hrFim'
    end
    object FDMem_RegistrohrTotal: TStringField
      FieldName = 'hrTotal'
      Size = 12
    end
    object FDMem_RegistrovlrHora: TFloatField
      FieldName = 'vlrHora'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_RegistrosubTotal: TFloatField
      FieldName = 'subTotal'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_Registrodesconto: TFloatField
      FieldName = 'desconto'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_RegistrodescontoMotivo: TStringField
      FieldName = 'descontoMotivo'
      Size = 1000
    end
    object FDMem_Registroacrescimo: TFloatField
      FieldName = 'acrescimo'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_RegistroacrescimoMotivo: TStringField
      FieldName = 'acrescimoMotivo'
      Size = 1000
    end
    object FDMem_Registrototal: TFloatField
      FieldName = 'total'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_Registroobservacao: TStringField
      FieldName = 'observacao'
      Size = 1000
    end
    object FDMem_RegistrodtPago: TStringField
      FieldName = 'dtPago'
      Size = 10
    end
    object FDMem_RegistrovlrPago: TFloatField
      FieldName = 'vlrPago'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_RegistrodtCadastro: TDateField
      FieldName = 'dtCadastro'
    end
    object FDMem_RegistrohrCadastro: TDateField
      FieldName = 'hrCadastro'
    end
    object FDMem_RegistroidUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object FDMem_RegistrostatusDesc: TStringField
      FieldName = 'statusDesc'
      Size = 100
    end
    object FDMem_Registroempresa: TStringField
      FieldName = 'empresa'
      Size = 255
    end
    object FDMem_RegistroprestadorServico: TStringField
      FieldName = 'prestadorServico'
      Size = 255
    end
    object FDMem_Registrocliente: TStringField
      FieldName = 'cliente'
      Size = 255
    end
    object FDMem_RegistrotabelaPreco: TStringField
      FieldName = 'tabelaPreco'
      Size = 255
    end
    object FDMem_RegistrotipoTabela: TIntegerField
      FieldName = 'tipoTabela'
    end
    object FDMem_RegistrotipoTabelaDesc: TStringField
      FieldName = 'tipoTabelaDesc'
      Size = 255
    end
    object FDMem_Registroconta: TStringField
      FieldName = 'conta'
      Size = 255
    end
    object FDMem_RegistrotipoConta: TIntegerField
      FieldName = 'tipoConta'
    end
    object FDMem_RegistrotipoContaDesc: TStringField
      FieldName = 'tipoContaDesc'
      Size = 255
    end
    object FDMem_Registroseq: TIntegerField
      FieldName = 'seq'
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 272
    Top = 280
  end
end
