object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Formul'#225'rio Principal'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  TextHeight = 14
  object MainMenu1: TMainMenu
    Left = 272
    Top = 48
    object mnuCadastro: TMenuItem
      Caption = 'Cadastros'
      OnClick = mnuCadastroClick
      object mnuGerais: TMenuItem
        Caption = 'Gerais'
        object mnuProjeto: TMenuItem
          Caption = 'Projeto'
          object mnuProjetos: TMenuItem
            Caption = 'Projetos'
            OnClick = mnuProjetosClick
          end
          object mnuTipoForm: TMenuItem
            Caption = 'Tipo de Formul'#225'rios'
            OnClick = mnuTipoFormClick
          end
          object mnuForms: TMenuItem
            Caption = 'Formul'#225'rios'
            OnClick = mnuFormsClick
          end
        end
        object Usurios1: TMenuItem
          Caption = 'Usu'#225'rios'
          OnClick = Usurios1Click
        end
        object Empresa1: TMenuItem
          Caption = 'Empresas'
        end
        object mnuGeografico: TMenuItem
          Caption = 'Geogr'#225'fico'
          object mnuRegiao: TMenuItem
            Caption = 'Regi'#245'es'
            OnClick = mnuRegiaoClick
          end
          object mnuEstados: TMenuItem
            Caption = 'Estados'
            OnClick = mnuEstadosClick
          end
          object mnuCidades: TMenuItem
            Caption = 'Cidades'
            OnClick = mnuCidadesClick
          end
        end
        object Pagamengos1: TMenuItem
          Caption = 'Pagamento'
          object CondiesdePagamentos1: TMenuItem
            Caption = 'Condi'#231#245'es'
          end
          object FormasdePagamentos1: TMenuItem
            Caption = 'Formas'
          end
        end
        object UnidadesdeMedidas1: TMenuItem
          Caption = 'UN de Medidas'
        end
        object PlanodeContasGerencial1: TMenuItem
          Caption = 'Plano de Contas Gerencial'
        end
      end
      object UnidadesdeMedidas2: TMenuItem
        Caption = 'Pessoas'
        object Pessoa1: TMenuItem
          Caption = 'Pessoas'
        end
        object N1: TMenuItem
          Caption = '-'
        end
        object Funcionrios1: TMenuItem
          Caption = 'Funcion'#225'rios'
        end
        object Fornecedores1: TMenuItem
          Caption = 'Fornecedores'
        end
        object Clientes1: TMenuItem
          Caption = 'Clientes'
        end
        object Fabricante1: TMenuItem
          Caption = 'Fabricantes'
        end
      end
      object Pessoas1: TMenuItem
        Caption = 'Produtos'
        object Produto1: TMenuItem
          Caption = 'Produtos'
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object Famlia1: TMenuItem
          Caption = 'Fam'#237'lias'
        end
        object Localizao1: TMenuItem
          Caption = 'Localiza'#231#245'es'
        end
        object Segmento1: TMenuItem
          Caption = 'Segmentos'
        end
        object Grupo1: TMenuItem
          Caption = 'Grupos'
          object Grupo2: TMenuItem
            Caption = 'Grupos'
          end
          object SubGrupo1: TMenuItem
            Caption = 'Sub-Grupos'
          end
        end
      end
      object abeladePreo1: TMenuItem
        Caption = 'Tabelas de Pre'#231'os'
      end
      object Fiscal1: TMenuItem
        Caption = 'Fiscal'
        object CFOP1: TMenuItem
          Caption = 'CFOPs'
        end
        object abeladePreo2: TMenuItem
          Caption = 'Tipos do Movimento'
        end
      end
      object Financeiro1: TMenuItem
        Caption = 'Financeiros'
        object Banco1: TMenuItem
          Caption = 'Bancos'
        end
        object ContasBancrias1: TMenuItem
          Caption = 'Contas Banc'#225'rias'
        end
      end
    end
    object mnuMovimento: TMenuItem
      Caption = 'Movimentos'
      object Financeiro2: TMenuItem
        Caption = 'Financeiro'
        object ContaPagar1: TMenuItem
          Caption = 'Conta Pagar'
        end
        object ContasaReceber1: TMenuItem
          Caption = 'Contas a Receber'
        end
      end
    end
    object mnuDashboard: TMenuItem
      Caption = 'Dashboard'
    end
    object mnuRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object mnuArquivos: TMenuItem
      Caption = 'Arquivos'
      object Configuraes1: TMenuItem
        Caption = 'Configura'#231#245'es'
      end
    end
    object mnuConfig: TMenuItem
      Caption = 'Configura'#231#245'es'
    end
    object mnuDesconectar: TMenuItem
      Caption = 'Desconectar'
      OnClick = mnuDesconectarClick
    end
  end
end
