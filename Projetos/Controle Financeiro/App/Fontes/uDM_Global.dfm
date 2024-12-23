object DM: TDM
  OnCreate = DataModuleCreate
  Height = 446
  Width = 442
  object FDC_Conexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Developer\Controle Financeiro\DataBase\FINANCEIRO.S3' +
        'DB'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 64
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 64
    Top = 88
  end
  object FDQ_Select: TFDQuery
    Connection = FDC_Conexao
    SQL.Strings = (
      '')
    Left = 64
    Top = 152
  end
  object FDQ_Insert: TFDQuery
    Connection = FDC_Conexao
    Left = 64
    Top = 208
  end
  object FDQ_Delete: TFDQuery
    Connection = FDC_Conexao
    Left = 64
    Top = 320
  end
  object FDQ_Update: TFDQuery
    Connection = FDC_Conexao
    Left = 64
    Top = 264
  end
  object FDQ_Usuario: TFDQuery
    Connection = FDC_Conexao
    Left = 176
    Top = 48
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 167
    Top = 168
  end
end
