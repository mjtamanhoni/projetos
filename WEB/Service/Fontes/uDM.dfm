object DM: TDM
  OnCreate = DataModuleCreate
  Height = 404
  Width = 395
  object FDTransaction: TFDTransaction
    Connection = FDConnectionP
    Left = 44
    Top = 24
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 48
    Top = 88
  end
  object FDQ_SelectP: TFDQuery
    Connection = FDConnectionP
    SQL.Strings = (
      'SELECT * FROM PUBLIC.SERVICOS_PRESTADOS')
    Left = 48
    Top = 160
  end
  object FDConnectionP: TFDConnection
    Params.Strings = (
      'Database=controle'
      'User_Name=postgres'
      'Password=Cs@#1519'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    UpdateTransaction = FDTransaction
    Left = 168
    Top = 24
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 168
    Top = 88
  end
  object FDQuery1: TFDQuery
    Connection = FDConnectionP
    SQL.Strings = (
      'select'
      'u.*'
      'from public.usuario u'
      'where 1=1'
      'and u.pin = '#39'MTUxOQ=='#39)
    Left = 168
    Top = 160
  end
end
