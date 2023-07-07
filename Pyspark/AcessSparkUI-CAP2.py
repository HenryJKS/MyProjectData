# Configuração do SparkSession
from pyspark.sql import SparkSession
from pyspark import SparkConf, SparkContext
from pyspark.sql.types import DoubleType, StringType
from pyspark.sql import functions as f
from pyspark.sql.functions import *
import gc
import pandas as pd

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

coletado = gc.collect()
print(f'Coletado: {coletado}')

#Aumento a memoria do Spark

spark = SparkSession.builder \
    .master("local[*]") \
    .appName("Word Count") \
    .config("spark.driver.bindAddress", "localhost") \
    .config("spark.ui.port", "4050") \
    .getOrCreate()\
#####################################################################################################################
#####################################################################################################################

# Criando o caminho para os arquivos
path = 'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\empresas'
path2 = 'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\estabelecimentos'
path3 = 'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\socios'

# Extraindo os dados do arquivo CSV
empresas = spark.read.option('header', True).csv(path, sep=',', inferSchema=True)
estabelecimentos = spark.read.option('header', True).csv(path2, sep=',', inferSchema=True)
socios = spark.read.option('header', True).csv(path3, sep=',', inferSchema=True)

# Alterando NULL por 0
empresas = empresas.fillna(0).fillna('0')
estabelecimentos = estabelecimentos.fillna(0).fillna('0')
socios = socios.fillna(0).fillna('0')

empresas.show(1)
estabelecimentos.show(1, False)
socios.show(1)
#####################################################################################################################
#####################################################################################################################

# Registrando o DataFrame como uma tabela temporária
empresas.createOrReplaceTempView("empresas")
socios.createOrReplaceTempView("socios")
estabelecimentos.createOrReplaceTempView("estabelecimentos")

# Funções de Agrupamento

# Count
# Spark SQL
socios.select(f.year('data_de_entrada_sociedade').alias('ano_de_entrada')) \
    .where('ano_de_entrada >= 2010') \
    .groupby('ano_de_entrada') \
    .count() \
    .orderBy(desc('ano_de_entrada')) \

# Oracle SQL Dialect
query = spark.sql(" SELECT EXTRACT(YEAR FROM data_de_entrada_sociedade) as ano_de_entrada, COUNT(*) FROM socios"
                  " WHERE EXTRACT(YEAR FROM data_de_entrada_sociedade) >= 2010"
                  " GROUP BY 1"
                  " ORDER BY 1 DESC")

# Spark SQL
# Usamos agg quando usamos mais um de tipo de agregação
empresas \
    .select('cnpj_basico', 'porte_da_empresa', 'capital_social_da_empresa') \
    .groupBy('porte_da_empresa') \
    .agg(
        f.avg('capital_social_da_empresa').alias('capital_social_medio'),
        f.count('cnpj_basico').alias('frequencia')
    ) \
    .orderBy(asc('porte_da_empresa')) \
    .show(5)

#Oracle SQL Dialect
query2 = spark.sql("SELECT PORTE_DA_EMPRESA, AVG(CAPITAL_SOCIAL_DA_EMPRESA) AS CAPITAL_SOCIAL_MEDIO, COUNT(CNPJ_BASICO) AS FRQUENCIA "
                   "FROM EMPRESAS "
                   "GROUP BY 1 "
                   "ORDER BY 1 ASC")
query2.show()

#Summary, ele retorna varios tipos de agregador
empresas.select('capital_social_da_empresa').summary().show()

#When e Otherwize
socios.withColumn('status', f.when(f.col('identificador_de_socio') == 1, "É 1").otherwise('Não é 1')).show(10)
#####################################################################################################################
#####################################################################################################################

#Join e Union

#Join
empresas.join(estabelecimentos, 'cnpj_basico', how='inner').show(5)

spark.sql("SELECT NVL(TO_CHAR(EXTRACT(YEAR FROM data_de_entrada_sociedade), '0000'),'Total')  AS DATA_INICIO, COUNT(CNPJ_BASICO) AS COUNT "
          "FROM socios WHERE EXTRACT(YEAR FROM data_de_entrada_sociedade) >= 2010 "
          "GROUP BY ROLLUP(EXTRACT(YEAR FROM data_de_entrada_sociedade)) "
          "ORDER BY 1").show()

spark.sql("SELECT SUM(COUNT) FROM "
          "(SELECT EXTRACT(YEAR FROM data_de_entrada_sociedade) AS DATA_INICIO, COUNT(CNPJ_BASICO) AS COUNT "
          "FROM socios WHERE EXTRACT(YEAR FROM data_de_entrada_sociedade) >= 2010 "
          "GROUP BY 1 "
          "ORDER BY 1)").show()

#Union

#####################################################################################################################
#####################################################################################################################
#Extração de Arquivos

#CSV
# empresas.write.csv(
#     path='C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\empresasATT',
#     mode='overwrite',
#     sep=';',
#     header=True,
# )

# estabelecimentos.write.csv(
#     'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\estabelecimentosATT',
#     mode='overwrite',
#     sep=';',
#     header= True,
# )

# socios.write.csv(
#     'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\sociosATT',
#     mode='overwrite',
#     sep=';',
#     header=True,
# )

#Parquet
spark.conf.set('spark.sql.parquet.datetimeRebaseModeInWrite', 'LEGACY')

# empresas.write.parquet(
#     'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\empresasParquet',
#     mode='overwrite'
# )

# estabelecimentos.write.parquet(
#     'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\estabelecimentosParquet',
#     mode='overwrite'
# )

# socios.write.parquet(
#     'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\sociosParquet',
#     mode='overwrite'
# )

print('Exportado com sucesso !')

#####################################################################################################################
#####################################################################################################################

# Inicie o servidor SparkUI
print("Servidor SparkUI iniciado em: " + spark.sparkContext.uiWebUrl)

# Aguarde a entrada do usuário antes de encerrar
input("Pressione Enter para sair\n")
spark.stop()
