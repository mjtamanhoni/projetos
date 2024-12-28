object DM_Global_Wnd: TDM_Global_Wnd
  OnCreate = DataModuleCreate
  Height = 353
  Width = 211
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Developer\projetos\Controle de Horas\DataBase\CONTRO' +
        'LE_HORAS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction
    UpdateTransaction = FDTransaction
    Left = 88
    Top = 24
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 88
    Top = 80
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 88
    Top = 136
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 88
    Top = 192
  end
end
