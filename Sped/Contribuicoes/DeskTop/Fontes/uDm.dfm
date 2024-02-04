object dmSpedContribuicoes: TdmSpedContribuicoes
  OnCreate = DataModuleCreate
  Height = 356
  Width = 461
  object FDC_Sped: TFDConnection
    Params.Strings = (
      'Database=C:\Developer\Lanchonete\DataBases\LANCHONETE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'DriverID=FB')
    TxOptions.Isolation = xiReadCommitted
    TxOptions.DisconnectAction = xdRollback
    LoginPrompt = False
    BeforeConnect = FDC_SpedBeforeConnect
    Left = 64
    Top = 16
  end
  object FDT_Sped: TFDTransaction
    Connection = FDC_Sped
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
    Connection = FDC_Sped
    Left = 168
    Top = 16
  end
  object FDQ_Insert: TFDQuery
    Connection = FDC_Sped
    Left = 168
    Top = 72
  end
  object FDQ_Update: TFDQuery
    Connection = FDC_Sped
    Left = 168
    Top = 136
  end
  object FDQ_Delete: TFDQuery
    Connection = FDC_Sped
    Left = 168
    Top = 192
  end
  object FDQ_Sequencia: TFDQuery
    Connection = FDC_Sped
    Left = 168
    Top = 256
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = FDC_Sped
    Params = <>
    Macros = <>
    Left = 64
    Top = 256
  end
end
