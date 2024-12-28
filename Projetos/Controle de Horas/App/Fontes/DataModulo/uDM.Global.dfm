object DM_Global: TDM_Global
  OnCreate = DataModuleCreate
  Height = 362
  Width = 347
  object FDC_SQLite: TFDConnection
    Params.Strings = (
      
        'Database=C:\Developer\projetos\Controle de Horas\App\DataBase\Co' +
        'ntroleHoras.s3db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 64
    Top = 32
  end
  object FDP_SQLite: TFDPhysSQLiteDriverLink
    Left = 64
    Top = 144
  end
  object FDQ_Select: TFDQuery
    Connection = FDC_SQLite
    SQL.Strings = (
      'SELECT * FROM ITENS_PEDIDO')
    Left = 160
    Top = 32
  end
  object FDQ_Insert: TFDQuery
    Connection = FDC_SQLite
    Left = 160
    Top = 88
  end
  object FDQ_Delete: TFDQuery
    Connection = FDC_SQLite
    Left = 160
    Top = 200
  end
  object FDQ_Update: TFDQuery
    Connection = FDC_SQLite
    Left = 160
    Top = 144
  end
  object FDQ_Estrutura: TFDQuery
    Connection = FDC_SQLite
    Left = 160
    Top = 264
  end
  object FDQ_Usuario: TFDQuery
    Connection = FDC_SQLite
    Left = 264
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 64
    Top = 200
  end
  object FDQConfig: TFDQuery
    Connection = FDC_SQLite
    Left = 264
    Top = 112
  end
  object FDT_SQLite: TFDTransaction
    Connection = FDC_SQLite
    Left = 64
    Top = 88
  end
end
