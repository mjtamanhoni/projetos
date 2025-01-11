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
      Top = 10
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
        Caption = '182:22:15'
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
        Caption = 'R$ 32,90'
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
        Caption = 'R$ 6.000,00'
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
        Caption = '182:22:15'
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
        Caption = 'R$ 32,90'
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
        Caption = '182:22:15'
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
        Caption = 'R$ 32,90'
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
        Caption = '182:22:15'
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
        Caption = 'R$ 32,90'
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
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
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
    IndexFieldNames = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 264
    Top = 160
    object FDMem_RegistroID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_RegistroNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 255
    end
    object FDMem_RegistroPESSOA: TIntegerField
      DisplayLabel = 'Pessoa'
      FieldName = 'PESSOA'
    end
    object FDMem_RegistroDOCUMENTO: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'DOCUMENTO'
    end
    object FDMem_RegistroINSC_EST: TStringField
      DisplayLabel = 'Insc. Estadual'
      FieldName = 'INSC_EST'
    end
    object FDMem_RegistroCEP: TStringField
      DisplayLabel = 'Cep'
      FieldName = 'CEP'
      Size = 10
    end
    object FDMem_RegistroENDERECO: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      Size = 255
    end
    object FDMem_RegistroCOMPLEMENTO: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMPLEMENTO'
      Size = 255
    end
    object FDMem_RegistroNUMERO: TStringField
      DisplayLabel = 'Nr'
      FieldName = 'NUMERO'
      Size = 255
    end
    object FDMem_RegistroBAIRRO: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'BAIRRO'
      Size = 100
    end
    object FDMem_RegistroCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 100
    end
    object FDMem_RegistroUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object FDMem_RegistroTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
    end
    object FDMem_RegistroCELULAR: TStringField
      DisplayLabel = 'Celular'
      FieldName = 'CELULAR'
    end
    object FDMem_RegistroEMAIL: TStringField
      DisplayLabel = 'E-Mail'
      FieldName = 'EMAIL'
      Size = 255
    end
    object FDMem_RegistroDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_RegistroHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
    object FDMem_RegistroPESSOA_DESC: TStringField
      DisplayLabel = 'Pessoa'
      FieldName = 'PESSOA_DESC'
    end
    object FDMem_RegistroID_FORNECEDOR: TIntegerField
      FieldName = 'ID_FORNECEDOR'
    end
    object FDMem_RegistroID_TAB_PRECO: TIntegerField
      FieldName = 'ID_TAB_PRECO'
    end
    object FDMem_RegistroFONECEDOR: TStringField
      FieldName = 'FONECEDOR'
      Size = 255
    end
    object FDMem_RegistroTAB_PRECO: TStringField
      FieldName = 'TAB_PRECO'
      Size = 100
    end
    object FDMem_RegistroTIPO_TAB_PRECO: TIntegerField
      FieldName = 'TIPO_TAB_PRECO'
    end
    object FDMem_RegistroTIPO_TAB_PRECO_DESC: TStringField
      FieldName = 'TIPO_TAB_PRECO_DESC'
      Size = 50
    end
    object FDMem_RegistroVALOR: TFloatField
      FieldName = 'VALOR'
      DisplayFormat = 'R$ #,##0.00'
    end
  end
  object dmRegistro: TDataSource
    AutoEdit = False
    DataSet = FDMem_Registro
    Left = 264
    Top = 216
  end
end
