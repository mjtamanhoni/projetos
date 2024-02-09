object DM_ConrHoras: TDM_ConrHoras
  Height = 422
  Width = 294
  object FDC_Conexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Developer\Controle de Horas\DataBase\CONTROLE_HORAS.' +
        'S3DB'
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
    Top = 96
  end
  object FDQ_Select: TFDQuery
    Connection = FDC_Conexao
    SQL.Strings = (
      'SELECT * FROM ITENS_PEDIDO')
    Left = 200
    Top = 32
  end
  object FDQ_Insert: TFDQuery
    Connection = FDC_Conexao
    Left = 192
    Top = 96
  end
  object FDQ_Update: TFDQuery
    Connection = FDC_Conexao
    Left = 192
    Top = 168
  end
  object FDQ_Delete: TFDQuery
    Connection = FDC_Conexao
    Left = 192
    Top = 232
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 64
    Top = 168
  end
  object FDQ_Usuario: TFDQuery
    Connection = FDC_Conexao
    Left = 192
    Top = 312
  end
end
