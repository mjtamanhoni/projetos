object Dm_DeskTop: TDm_DeskTop
  OnCreate = DataModuleCreate
  Height = 504
  Width = 393
  object FDMem_Usuarios: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 32
    object FDMem_UsuariosID: TIntegerField
      FieldName = 'ID'
    end
    object FDMem_UsuariosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object FDMem_UsuariosSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object FDMem_UsuariosTIPO: TIntegerField
      FieldName = 'TIPO'
    end
    object FDMem_UsuariosLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 100
    end
    object FDMem_UsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Size = 100
    end
    object FDMem_UsuariosPIN: TIntegerField
      FieldName = 'PIN'
    end
    object FDMem_UsuariosTOKEN: TStringField
      FieldName = 'TOKEN'
      Size = 255
    end
    object FDMem_UsuariosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
    object FDMem_UsuariosCELULAR: TStringField
      FieldName = 'CELULAR'
    end
    object FDMem_UsuariosCLASSIFICACAO: TIntegerField
      FieldName = 'CLASSIFICACAO'
    end
    object FDMem_UsuariosLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 100
    end
    object FDMem_UsuariosNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object FDMem_UsuariosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 255
    end
    object FDMem_UsuariosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object FDMem_UsuariosIBGE: TIntegerField
      FieldName = 'IBGE'
    end
    object FDMem_UsuariosMUNICIPIO: TStringField
      FieldName = 'MUNICIPIO'
      Size = 100
    end
    object FDMem_UsuariosUF_SIGLA: TStringField
      FieldName = 'UF_SIGLA'
      Size = 2
    end
    object FDMem_UsuariosUF: TStringField
      FieldName = 'UF'
      Size = 100
    end
    object FDMem_UsuariosFOTO: TBlobField
      FieldName = 'FOTO'
    end
    object FDMem_UsuariosID_FUNCIONARIO: TIntegerField
      FieldName = 'ID_FUNCIONARIO'
    end
    object FDMem_UsuariosPUSH_NOTIFICATION: TStringField
      FieldName = 'PUSH_NOTIFICATION'
      Size = 255
    end
    object FDMem_UsuariosORIGEM_TIPO: TIntegerField
      FieldName = 'ORIGEM_TIPO'
    end
    object FDMem_UsuariosORIGEM_DESCRICAO: TStringField
      FieldName = 'ORIGEM_DESCRICAO'
      Size = 100
    end
    object FDMem_UsuariosORIGEM_CODIGO: TIntegerField
      FieldName = 'ORIGEM_CODIGO'
    end
    object FDMem_UsuariosDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
    end
    object FDMem_UsuariosHR_CADASTRO: TTimeField
      FieldName = 'HR_CADASTRO'
    end
  end
end
