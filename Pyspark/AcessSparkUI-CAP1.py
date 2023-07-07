# Configuração do SparkSession
from pyspark.sql import SparkSession
from pyspark.sql.types import DoubleType, StringType
from pyspark.sql import functions as f
from pyspark.sql.functions import col, desc, asc
import gc
import pandas as pd
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

collected = gc.collect()
print('Garbage collector: collected %d objects' % collected)

spark = SparkSession.builder \
    .master("local[*]") \
    .appName("Word Count") \
    .config("spark.driver.bindAddress", "localhost") \
    .config("spark.ui.port", "4050") \
    .getOrCreate()

#####################################################################################################################
#####################################################################################################################

#Criando o caminho para os arquivos
path = '\\Datas\\empresas'
path2 = '\\Datas\\estabelecimentos'
path3 = '\\Datas\\socios'

#Extraindo os dados do arquivo CSV
empresas = spark.read.csv(path, sep=';', inferSchema=True)
estabelecimentos = spark.read.csv(path2, sep=';', inferSchema=True)
socios = spark.read.csv(path3, sep=';', inferSchema=True)

print(empresas.count())
print(estabelecimentos.count())
print(socios.count())

#####################################################################################################################
#####################################################################################################################

#Operações Básica com DataFrame do Spark
#print(empresas.limit(5).toPandas())

#Iterando e enumerando cada valor da lista para renomar o dataframe
empresasColNames = ['cnpj_basico', 'razao_social_nome_empresarial', 'natureza_juridica', 'qualificacao_do_responsavel', 'capital_social_da_empresa', 'porte_da_empresa', 'ente_federativo_responsavel']
estabsColNames = ['cnpj_basico', 'cnpj_ordem', 'cnpj_dv', 'identificador_matriz_filial', 'nome_fantasia', 'situacao_cadastral', 'data_situacao_cadastral', 'motivo_situacao_cadastral', 'nome_da_cidade_no_exterior', 'pais', 'data_de_inicio_atividade', 'cnae_fiscal_principal', 'cnae_fiscal_secundaria', 'tipo_de_logradouro', 'logradouro', 'numero', 'complemento', 'bairro', 'cep', 'uf', 'municipio', 'ddd_1', 'telefone_1', 'ddd_2', 'telefone_2', 'ddd_do_fax', 'fax', 'correio_eletronico', 'situacao_especial', 'data_da_situacao_especial']
sociosColNames = ['cnpj_basico', 'identificador_de_socio', 'nome_do_socio_ou_razao_social', 'cnpj_ou_cpf_do_socio', 'qualificacao_do_socio', 'data_de_entrada_sociedade', 'pais', 'representante_legal', 'nome_do_representante', 'qualificacao_do_representante_legal', 'faixa_etaria']

#Renomeando os Dataframes
for index, colName in enumerate(empresasColNames):
    empresas = empresas.withColumnRenamed(f"_c{index}", colName)
print(empresas.columns)

for index, colName in enumerate(estabsColNames):
    estabelecimentos = estabelecimentos.withColumnRenamed(f"_c{index}", colName)

print(estabelecimentos.columns)

for index, colName in enumerate(sociosColNames):
    socios = socios.withColumnRenamed(f"_c{index}", colName)

print(socios.columns)

#####################################################################################################################
#####################################################################################################################

#Analisando Dados

#Ver o tipo de cada coluna
#print(empresas.printSchema())
#print(estabelecimentos.printSchema())
#print(socios.printSchema())



#Convertendo String para Double
print(empresas.limit(5).toPandas())

#withColumn, manipulamos somente uma coluna que queremos, usamos o regex para trocar a ',' por '.'
empresas = empresas.withColumn('capital_social_da_empresa', f.regexp_replace('capital_social_da_empresa', r'(\d),(\d)',r'1.\2'))

#Filtrar somente aqueles contem o ','
empresas.filter(col("capital_social_da_empresa").contains(",")).show()

#o cast é para alterar o tipo do valor
empresas = empresas.withColumn('capital_social_da_empresa', empresas['capital_social_da_empresa'].cast(DoubleType()))
print(empresas.printSchema())

#Convertendo String para Date Estabelecimentos
#print(estabelecimentos.limit(5).toPandas())
estabelecimentos = estabelecimentos\
    .withColumn('data_situacao_cadastral',
                f.to_date(estabelecimentos['data_situacao_cadastral'].cast(StringType()), 'yyyyMMdd')
                )\
    .withColumn('data_de_inicio_atividade',
                f.to_date(estabelecimentos['data_de_inicio_atividade'].cast(StringType()), 'yyyyMMdd')
                )\
    .withColumn('data_da_situacao_especial',
                f.to_date(estabelecimentos['data_da_situacao_especial'].cast(StringType()), 'yyyyMMdd')
                )

#Convertendo String para Date Socios
socios = socios.withColumn('data_de_entrada_sociedade',
                           f.to_date(socios['data_de_entrada_sociedade'].cast(StringType()), 'yyyyMMdd')
                           )

print(socios.limit(5).toPandas())
#####################################################################################################################
#####################################################################################################################

#Seleção e Consulta

#Registrando o DataFrame como uma tabela temporária
empresas.createOrReplaceTempView("empresas")
socios.createOrReplaceTempView("socios")
estabelecimentos.createOrReplaceTempView("estabelecimentos")

query = spark.sql("SELECT * FROM empresas")
query.show(5)

query2 = spark.sql("SELECT nome_do_socio_ou_razao_social, faixa_etaria, EXTRACT(YEAR FROM data_de_entrada_sociedade) as ano from socios")
query2.show(5, False)

query3 = spark.sql("SELECT nome_fantasia, municipio, EXTRACT(YEAR FROM data_de_inicio_atividade) as Ano_Inicio, "
                   "EXTRACT(MONTH FROM data_de_inicio_atividade) as Mes_Inicio FROM estabelecimentos")
query3.show(5, False)

query4 = spark.sql("SELECT EXTRACT(YEAR FROM data_de_inicio_atividade) || '/' || EXTRACT(MONTH FROM data_de_inicio_atividade) AS ANO_MES "
                   "FROM estabelecimentos")
query4.show(5)
#####################################################################################################################
#####################################################################################################################

#Identificando valores NULL e NaN
print(socios.limit(5).toPandas())
socios.show(5)

#Contagem da valores nulos
socios.select([f.count(f.when(f.isnull(c), 1)).alias(c) for c in socios.columns]).show()

#Substituir Valores NULL para outro valor
#Nesse caso estamos substituindo o NULL pelo 0 em colunas que são Integer
print(socios.fillna(0).limit(5).toPandas())

#Substituindo para colunas tipos String
print(socios.fillna('0').limit(5).toPandas())

#Podemos fazer em um so linha
print(socios.fillna(0).fillna('0').limit(5).toPandas())
#####################################################################################################################
#####################################################################################################################

#Ordenando Dados
socios.select('nome_do_socio_ou_razao_social', 'faixa_etaria', f.year('data_de_entrada_sociedade').alias('ano'))\
      .orderBy([desc('ano'), desc('faixa_etaria')]).show(10, False)

query5 = spark.sql("SELECT nome_do_socio_ou_razao_social, faixa_etaria, EXTRACT(YEAR FROM data_de_entrada_sociedade) as ano"
                   " FROM socios ORDER BY 3, 2 desc ")

query5.show(10)

######################################################z###############################################################
#####################################################################################################################

#Filtrando Dados
empresas.where("capital_social_da_empresa == 1.2").show(10)

#Startswith | Endswith, esses filtro serve para filtrar o começo e o final de um valor da coluna
print(socios.select("nome_do_socio_ou_razao_social").filter(socios.nome_do_socio_ou_razao_social.startswith("RODRIGO"))\
      .filter(socios.nome_do_socio_ou_razao_social.endswith("DIAS")).limit(5).toPandas())

#Operador LIKE
empresas.where(f.upper(empresas.razao_social_nome_empresarial).like('%LOJA%')).show(5, False)
######################################################z###############################################################
#####################################################################################################################

#Dataframe Spark para CSV
empresas.write.option('header', True).csv('C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\empresas.csv')
estabelecimentos.write.option('header', True).csv('C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\estabelecimentos.csv')
socios.write.option('header', True).csv('C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\socios.csv')
print('Convertido com sucesso!')

######################################################z###############################################################
#####################################################################################################################

# Inicie o servidor SparkUI
print("Servidor SparkUI iniciado em: " + spark.sparkContext.uiWebUrl)

# Aguarde a entrada do usuário antes de encerrar
input("Pressione Enter para sair\n")
spark.stop()
