object DM_Global: TDM_Global
  Height = 383
  Width = 297
  object FDC_Firebird: TFDConnection
    Params.Strings = (
      
        'Database=C:\Developer\Controle de Horas\DataBase\CONTROLE_HORAS.' +
        'FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
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
end
