object DM_Lanchonete: TDM_Lanchonete
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 361
  Width = 334
  object FDC_Lanchonete: TFDConnection
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
  object FDT_Lanchonete: TFDTransaction
    Connection = FDC_Lanchonete
    Left = 64
    Top = 72
  end
  object FDP_Lanchonete: TFDPhysFBDriverLink
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
    Connection = FDC_Lanchonete
    Left = 168
    Top = 16
  end
  object FDQ_Insert: TFDQuery
    Connection = FDC_Lanchonete
    Left = 168
    Top = 72
  end
  object FDQ_Update: TFDQuery
    Connection = FDC_Lanchonete
    Left = 168
    Top = 136
  end
  object FDQ_Delete: TFDQuery
    Connection = FDC_Lanchonete
    Left = 168
    Top = 192
  end
  object FDQ_Sequencia: TFDQuery
    Connection = FDC_Lanchonete
    Left = 168
    Top = 248
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = FDC_Lanchonete
    Params = <>
    Macros = <>
    Left = 264
    Top = 176
  end
end
