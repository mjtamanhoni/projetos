object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Formul'#225'rio Principal'
  ClientHeight = 304
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
    object Module11: TMenuItem
      Caption = 'Cadastros'
      OnClick = Module11Click
      object Gerais1: TMenuItem
        Caption = 'Gerais'
        object Projeto: TMenuItem
          Caption = 'Projeto'
          object Projeto1: TMenuItem
            Caption = 'Projetos'
            OnClick = Projeto1Click
          end
          object ipodeFormulrios1: TMenuItem
            Caption = 'Tipo de Formul'#225'rios'
            OnClick = ipodeFormulrios1Click
          end
          object Projeto2: TMenuItem
            Caption = 'Formul'#225'rios'
            OnClick = Projeto2Click
          end
        end
        object Usurios1: TMenuItem
          Caption = 'Usu'#225'rios'
          OnClick = Usurios1Click
        end
        object Empresa1: TMenuItem
          Caption = 'Empresas'
        end
        object CadastrosGeogrficos1: TMenuItem
          Caption = 'Geogr'#225'fico'
          object Regies1: TMenuItem
            Caption = 'Regi'#245'es'
          end
          object Regies2: TMenuItem
            Caption = 'Estados'
          end
          object MunicpiosCidades1: TMenuItem
            Caption = 'Cidades'
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
    object Movimentos1: TMenuItem
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
    object Dashboard1: TMenuItem
      Caption = 'Dashboard'
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object Arquivos1: TMenuItem
      Caption = 'Arquivos'
      object Configuraes1: TMenuItem
        Caption = 'Configura'#231#245'es'
      end
    end
    object Configuraes2: TMenuItem
      Caption = 'Configura'#231#245'es'
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
    end
  end
end
