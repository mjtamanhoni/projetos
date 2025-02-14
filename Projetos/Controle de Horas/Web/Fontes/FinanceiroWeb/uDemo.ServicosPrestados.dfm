object frmDemo_ServicosPrestados: TfrmDemo_ServicosPrestados
  Left = 0
  Top = 0
  Caption = 'Demonstrativo de Servi'#231'os Prestados'
  ClientHeight = 546
  ClientWidth = 912
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnFiltro: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    ExplicitWidth = 908
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
    object edFiltro_DataI: TDateTimePicker
      Left = 471
      Top = 9
      Width = 106
      Height = 23
      Date = 45667.000000000000000000
      Time = 0.712431180552812300
      TabOrder = 0
    end
    object edFiltro_DataF: TDateTimePicker
      Left = 675
      Top = 13
      Width = 106
      Height = 23
      Date = 45667.000000000000000000
      Time = 0.712431180552812300
      TabOrder = 1
    end
    object btFiltro_Filtrar: TButton
      Left = 816
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Filtrar'
      TabOrder = 2
      OnClick = btFiltro_FiltrarClick
    end
    object edFiltro_Cliente_ID: TButtonedEdit
      Left = 51
      Top = 12
      Width = 286
      Height = 23
      Alignment = taRightJustify
      Images = ImageList
      RightButton.ImageIndex = 0
      RightButton.Visible = True
      TabOrder = 3
    end
    object btFiltro_LocCli: TButton
      Left = 343
      Top = 9
      Width = 51
      Height = 25
      Caption = 'Filtrar'
      TabOrder = 4
      OnClick = btFiltro_LocCliClick
    end
  end
  object pnCards: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 44
    Width = 906
    Height = 104
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 902
    object lbHr_Trab_Tit: TLabel
      Left = 16
      Top = 16
      Width = 97
      Height = 15
      Caption = 'Horas Trabalhadas'
    end
    object lbHr_Trab_Hr: TLabel
      Left = 16
      Top = 37
      Width = 50
      Height = 17
      Caption = '00:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHr_Trab_Vlr: TLabel
      Left = 16
      Top = 58
      Width = 44
      Height = 17
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHr_Acul_Tit: TLabel
      Left = 136
      Top = 16
      Width = 100
      Height = 15
      Caption = 'Horas Acumuladas'
    end
    object lbHr_Acul_Hr: TLabel
      Left = 136
      Top = 37
      Width = 50
      Height = 17
      Caption = '00:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHr_Acul_Vlr: TLabel
      Left = 136
      Top = 58
      Width = 44
      Height = 17
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHr_Tot_Tit: TLabel
      Left = 256
      Top = 16
      Width = 76
      Height = 15
      Caption = 'Total de Horas'
    end
    object lbHr_Tot_Hr: TLabel
      Left = 256
      Top = 37
      Width = 50
      Height = 17
      Caption = '00:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHr_Tot_Vlr: TLabel
      Left = 256
      Top = 58
      Width = 44
      Height = 17
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHr_Pagas_Tit: TLabel
      Left = 352
      Top = 16
      Width = 65
      Height = 15
      Caption = 'Horas Pagas'
    end
    object lbHr_Pagas_Vlr: TLabel
      Left = 352
      Top = 58
      Width = 44
      Height = 17
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbHr_Pagas_Hr: TLabel
      Left = 352
      Top = 35
      Width = 50
      Height = 17
      Caption = '00:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 151
    Width = 912
    Height = 395
    Align = alClient
    DataSource = dmRegistro
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'data'
        Title.Alignment = taCenter
        Title.Caption = 'Data'
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
        FieldName = 'descricao'
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
        FieldName = 'idConta'
        Title.Alignment = taCenter
        Title.Caption = 'Conta ID'
        Visible = True
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
    Left = 680
    Top = 240
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
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'seq'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 272
    Top = 224
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
    object FDMem_Registroacrescimo: TFloatField
      FieldName = 'acrescimo'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_Registrototal: TFloatField
      FieldName = 'total'
      DisplayFormat = 'R$ #,##0.00'
    end
    object FDMem_RegistroidConta: TIntegerField
      FieldName = 'idConta'
    end
    object FDMem_Registroconta: TStringField
      FieldName = 'conta'
      Size = 255
    end
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
    object FDMem_RegistrodescontoMotivo: TStringField
      FieldName = 'descontoMotivo'
      Size = 1000
    end
    object FDMem_RegistroacrescimoMotivo: TStringField
      FieldName = 'acrescimoMotivo'
      Size = 1000
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
