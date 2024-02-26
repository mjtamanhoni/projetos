object DM: TDM
  Height = 369
  Width = 269
  object FDC_Servidor: TFDConnection
    Params.Strings = (
      'Database=C:\Developer\Lanchonete\DataBases\LANCHONETE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'DriverID=FB')
    TxOptions.Isolation = xiReadCommitted
    TxOptions.DisconnectAction = xdRollback
    LoginPrompt = False
    Left = 64
    Top = 16
  end
  object FDT_Servidor: TFDTransaction
    Connection = FDC_Servidor
    Left = 64
    Top = 72
  end
  object FDP_Servidor: TFDPhysFBDriverLink
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
    Connection = FDC_Servidor
    Left = 168
    Top = 16
  end
  object FDQ_Insert: TFDQuery
    Connection = FDC_Servidor
    Left = 168
    Top = 72
  end
  object FDQ_Update: TFDQuery
    Connection = FDC_Servidor
    Left = 168
    Top = 136
  end
  object FDQ_Delete: TFDQuery
    Connection = FDC_Servidor
    Left = 168
    Top = 192
  end
  object FDQ_Sequencia: TFDQuery
    Connection = FDC_Servidor
    Left = 168
    Top = 256
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = FDC_Servidor
    Params = <>
    Macros = <>
    Left = 64
    Top = 256
  end
end
