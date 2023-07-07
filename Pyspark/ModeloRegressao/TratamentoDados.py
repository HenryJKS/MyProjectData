from pyspark.sql import SparkSession
import pandas as pd
from pyspark.sql.functions import col
from pyspark.sql import functions as f
from pyspark.sql.types import DoubleType, DateType, IntegerType, StringType

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

spark = SparkSession.builder\
    .master('local[*]')\
    .appName('Regressão com Spark')\
    .config("spark.driver.bindAddress", "localhost") \
    .config("spark.ui.port", "4050") \
    .getOrCreate()

#Leitura de um arquivo JSON
dados = spark.read.json('C:\\Users\\Henry\\PycharmProjects\\sparkProject\\DatasJSON\\imoveis.json')

dados.printSchema()

#Consulta em JSON
dados.select('ident.customerID', 'listing.*').show(3, False)

dados.select('ident.customerID', 'listing.types.*', 'listing.features.*',
             'listing.address.*', 'listing.prices.price', 'listing.prices.tax.*')\
    .show(3, False)

#####################################################################################################################
#####################################################################################################################

#Seleção de Features, precisamos selecionar somente dados que são importantes
#Usamos drop para colunas que não precisamos
dataset = dados.select('ident.customerID', 'listing.types.*', 'listing.features.*', 'listing.address.*',
                       'listing.prices.price', 'listing.prices.tax.*')\
          .drop('city', 'location', 'totalArea')

dataset.show(3, False)

#Convertendo tipos
dataset = dataset.withColumn('price', col('price').cast(DoubleType()))
#Outro jeito
dataset = dataset.withColumn('usableAreas', dataset['usableAreas'].cast(DoubleType()))
dataset = dataset.withColumn('condo', dataset['condo'].cast(DoubleType()))
dataset = dataset.withColumn('iptu', dataset['iptu'].cast(DoubleType()))

dataset.printSchema()

dataset.show(5, False)

#####################################################################################################################
#####################################################################################################################

#Criando view
dataset.createOrReplaceTempView('datasetVIEW')

#Agrupando por Usage
spark.sql('SELECT COUNT(USAGE), USAGE FROM datasetVIEW '
          'GROUP BY 2').show()

#SPARK SQL
dataset.select(dataset.usage)\
    .groupby(dataset.usage)\
    .count().show()

#Filtrando apenas Residencial
dataset = spark.sql('SELECT * FROM datasetVIEW WHERE USAGE = "Residencial" ')

#Agrupando por outros colunas
spark.sql('SELECT UNIT, COUNT(UNIT) FROM datasetVIEW GROUP BY 1').show()
spark.sql('SELECT ZONE, COUNT(ZONE) FROM DATASETVIEW GROUP BY 1').show()

#####################################################################################################################
#####################################################################################################################

#Tratando Dados NULOS/NAN/EMPTY

dataset\
    .select([f.count(f.when(f.isnan(c) | f.isnull(c), True)).alias(c) for c in dataset.columns])\
    .show()

dataset = dataset.fillna(0).fillna('0')

dataset.show(10)

dataset.createOrReplaceTempView('datasetVIEW')

dataset.show(10)

spark.sql("SELECT COUNT(ZONE), ZONE FROM DATASETVIEW GROUP BY 2").show()

dataset = spark.sql("SELECT * FROM DATASETVIEW WHERE ZONE != '' ")

#Exportando Dados
dataset.write.parquet(
    'C:\\Users\\Henry\\PycharmProjects\\sparkProject\\ModeloRegressao\\DataImoveis\\dataset',
    mode='overwrite'
)

#####################################################################################################################
#####################################################################################################################
input('Enter para sair\n')