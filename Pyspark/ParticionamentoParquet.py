from pyspark.sql import SparkSession
from pyspark.sql import functions as f
from pyspark.sql.functions import *
import pandas as pd

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

spark = SparkSession.builder \
    .master("local[*]") \
    .appName("Word Count") \
    .config("spark.driver.bindAddress", "localhost") \
    .config("spark.ui.port", "4050") \
    .getOrCreate() \
 \
    # Leitura de Arquivos Parquet
empresas = spark.read.parquet("C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\empresasParquet")
empresas2 = spark.read.csv("C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasAtt\\empresas",
                           header= True, inferSchema= True)
# View
empresas.createOrReplaceTempView("empresasVIEW")
# estabelecimentos.createOrReplaceTempView("estabelecimentosVIEW")
# socios.createOrReplaceTempView("sociosVIEW")

# Particionamento de Dados

# Parquet
# Com parquet podemos particionar por coluna, semelhante ao um group by.

empresas.write.parquet(
    'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DataUnico',
    mode='overwrite',
    partitionBy='porte_da_empresa'
)

#CSV
empresas.coalesce(1).write.csv(
    'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DataUnico',
    mode='overwrite',
    sep=';',
    header=True
)

input('ENTER para sair\n')

spark.stop()
