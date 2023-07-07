from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()

# Criando Dataframe com tuplas
data = [('Zeca', 35), ('Eva', '29')]
colNames = ['Nome', 'Idade']

df = spark.createDataFrame(data, colNames)

#Visualizar o Dataframe
df.show()

#Visualizar com Pandas
print(df.toPandas())
