object DM_Global_Wnd: TDM_Global_Wnd
  OnCreate = DataModuleCreate
  Height = 251
  Width = 527
  object FDConnectionF: TFDConnection
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
    Connection = FDConnectionP
    Left = 220
    Top = 24
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 88
    Top = 96
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 224
    Top = 88
  end
  object FDQ_SelectP: TFDQuery
    Connection = FDConnectionP
    SQL.Strings = (
      'SELECT * FROM PUBLIC.SERVICOS_PRESTADOS')
    Left = 224
    Top = 160
  end
  object FDConnectionP: TFDConnection
    Params.Strings = (
      'Database=financeiro'
      'User_Name=postgres'
      'Password=M74E25@Ta'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    UpdateTransaction = FDTransaction
    Left = 408
    Top = 24
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Programas\PostgreSql_9_32\bin\libpq.dll'
    Left = 408
    Top = 88
  end
end
