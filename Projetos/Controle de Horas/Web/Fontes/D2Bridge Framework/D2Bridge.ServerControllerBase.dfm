object D2BridgeServerControllerBase: TD2BridgeServerControllerBase
  Height = 588
  Width = 666
  object CDSLog: TClientDataSet
    PersistDataPacket.Data = {
      560100009619E0BD01000000180000000B000000000003000000560107417574
      6F436F64040001000200010007535542545950450200490008004175746F696E
      6300084964656E74696679010049000000010005574944544802000200960004
      5573657201004900000001000557494454480200020096000249500100490000
      00010005574944544802000200180009557365724167656E7401004900000001
      0005574944544802000200780006537461747573010049000000010005574944
      54480200020032000E44617465436F6E6E656374696F6E08000800000000000A
      4461746555706461746508000800000000000645787069726501004900000001
      00055749445448020002001E0004555549440100490000000100055749445448
      020002001E0008466F726D4E616D650100490000000100055749445448020002
      00640001000C4155544F494E4356414C55450400010001000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'AutoCod'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'Identify'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'User'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'IP'
        DataType = ftString
        Size = 24
      end
      item
        Name = 'UserAgent'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'Status'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DateConnection'
        DataType = ftDateTime
      end
      item
        Name = 'DateUpdate'
        DataType = ftDateTime
      end
      item
        Name = 'Expire'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'UUID'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'FormName'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 40
    object CDSLogAutoCod: TAutoIncField
      FieldName = 'AutoCod'
    end
    object CDSLogIdentify: TStringField
      FieldName = 'Identify'
      Size = 150
    end
    object CDSLogUser: TStringField
      FieldName = 'User'
      Size = 150
    end
    object CDSLogIP: TStringField
      FieldName = 'IP'
      Size = 24
    end
    object CDSLogUserAgent: TStringField
      FieldName = 'UserAgent'
      Size = 120
    end
    object CDSLogStatus: TStringField
      FieldName = 'Status'
      Size = 50
    end
    object CDSLogDateConnection: TDateTimeField
      FieldName = 'DateConnection'
      DisplayFormat = 'DD/MM/YY HH:MM'
    end
    object CDSLogDateUpdate: TDateTimeField
      FieldName = 'DateUpdate'
      DisplayFormat = 'DD/MM/YY HH:MM'
    end
    object CDSLogExpire: TStringField
      FieldName = 'Expire'
      Size = 30
    end
    object CDSLogUUID: TStringField
      FieldName = 'UUID'
      Size = 30
    end
    object CDSLogFormName: TStringField
      FieldName = 'FormName'
      Size = 100
    end
  end
  object DataSourceLog: TDataSource
    DataSet = CDSLog
    Left = 344
    Top = 40
  end
end
