object DM_Email: TDM_Email
  Height = 480
  Width = 640
  object FDC_Firebird: TFDConnection
    Params.Strings = (
      'Database=C:\Developer\Envio de Email\DataBase\ENVIOEMAIL.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Port=3050'
      'Server=nb00035-ar'
      'DriverID=FB')
    LoginPrompt = False
    Left = 64
    Top = 16
  end
  object FDT_Firebird: TFDTransaction
    Connection = FDC_Firebird
    Left = 64
    Top = 72
  end
  object FDP_Firebired: TFDPhysFBDriverLink
    VendorLib = 'FBCLIENT'
    Left = 64
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 192
  end
  object FDQ_Select: TFDQuery
    Connection = FDC_Firebird
    Left = 168
    Top = 16
  end
  object FDQ_Insert: TFDQuery
    Connection = FDC_Firebird
    Left = 168
    Top = 72
  end
  object FDQ_Update: TFDQuery
    Connection = FDC_Firebird
    Left = 168
    Top = 136
  end
  object FDQ_Delete: TFDQuery
    Connection = FDC_Firebird
    Left = 168
    Top = 192
  end
  object FDQ_Sequencia: TFDQuery
    Connection = FDC_Firebird
    Left = 168
    Top = 248
  end
  object FDMT_BancoDados: TFDMemTable
    IndexFieldNames = 'id'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 313
    Top = 19
    object FDMT_BancoDadosid: TIntegerField
      FieldName = 'id'
    end
    object FDMT_BancoDadosversao: TIntegerField
      FieldName = 'versao'
    end
    object FDMT_BancoDadosservidor: TStringField
      FieldName = 'servidor'
      Size = 100
    end
    object FDMT_BancoDadosporta: TIntegerField
      FieldName = 'porta'
    end
    object FDMT_BancoDadosbanco: TStringField
      FieldName = 'banco'
      Size = 255
    end
    object FDMT_BancoDadosusuario: TStringField
      FieldName = 'usuario'
      Size = 100
    end
    object FDMT_BancoDadossenha: TStringField
      FieldName = 'senha'
      Size = 100
    end
    object FDMT_BancoDadosbiblioteca: TStringField
      FieldName = 'biblioteca'
      Size = 255
    end
  end
end
