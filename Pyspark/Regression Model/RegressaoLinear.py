
from pyspark.sql import SparkSession
import pandas as pd
from pyspark.sql.functions import col
from pyspark.sql import functions as f
from pyspark.sql.types import DoubleType, DateType, IntegerType, StringType
from pyspark.ml.feature import VectorAssembler

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

spark = SparkSession.builder\
    .master('local[*]')\
    .appName('Regressão com Spark')\
    .config("spark.driver.bindAddress", "localhost") \
    .config("spark.ui.port", "4050") \
    .config("spark.driver.memory", "4g") \
    .config("spark.driver.host", "localhost") \
    .config("spark.driver.bindAddress", "127.0.0.1") \
    .getOrCreate()

###################################################################################
###################################################################################

#Leitura do dataset
dataset = spark.read.parquet('C:\\Users\\Henry\\PycharmProjects\\sparkProject\\ModeloRegressao\\DataImoveis\\dataset')
dataset.printSchema()

#Fazendo Pivoteamento com Unit
unit = dataset.groupby(dataset.customerID).pivot('unit')\
            .agg(f.lit(1)).na.fill(0)

zone = dataset.groupby(dataset.customerID).pivot('zone')\
        .agg(f.lit(1)).na.fill(0)

#Unindo as 2 tabelas
dataset.createOrReplaceTempView('datasetVIEW')
unit.createOrReplaceTempView('unitVIEW')
zone.createOrReplaceTempView('zoneVIEW')

dataset = dataset\
    .join(unit, 'customerID', how='inner')\
    .join(zone, 'customerID', how='inner')

dataset.show(5, False)

###################################################################################
###################################################################################

#Vetorização dos Dados, vamos as colunas de um Dataset e transformar em um vetor

dataset = dataset.withColumnRenamed('price', 'label')

X = [
    'bathrooms',
    'bedrooms',
    'floors',
    'parkingSpaces',
    'suites',
    'unitFloor',
    'unitsOnTheFloor',
    'usableAreas',
    'condo',
    'iptu',
    'Apartamento',
    'Casa',
    'Outros',
    'Zona Central',
    'Zona Norte',
    'Zona Oeste',
    'Zona Sul'
]

assembler = VectorAssembler(inputCols= X, outputCol='features')

dataset.show(5)

dataset_prep = assembler.transform(dataset).select('features', 'label')

dataset_prep.show(10, False)

###################################################################################
###################################################################################

#Exploração dos Dados
#sparse e DENSE, a principal difereça é que em uma matriz sparse onde possui um espaço vazio é preenchido por um na matriz DENSE
from pyspark.ml.stat import Correlation

correlacao = Correlation.corr(dataset_prep, 'features').collect()

print(correlacao)

#Coletando somente a linha "pearson"
correlacao = Correlation.corr(dataset_prep, 'features').collect()[0][0]

#print(correlacao)

#Criando um Array para facilitar o trabalho com a matriz
correlacao.toArray()

#Criando um DATAFRAME para criar uma matriz de correlação
dataframe_correlacao = pd.DataFrame(correlacao.toArray(), columns=X, index=X)

#print(dataframe_correlacao)

###################################################################################
###################################################################################

#Vamos criar um mapa de calor, para representação visual
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(12, 10))
paleta = sns.color_palette("light:salmon", as_cmap=True)
sns.heatmap(dataframe_correlacao.round(1), annot=True, cmap=paleta)
#plt.show()

###################################################################################
###################################################################################
# MODELO 1:
# Regressão Linear
# Ajuste e Previsões
from pyspark.ml.regression import LinearRegression

treino, teste = dataset_prep.randomSplit([0.7, 0.3], seed=101)

print(treino.count())
print(teste.count())

lr = LinearRegression()

modelo_lr = lr.fit(treino)

previsoes_lr_treino = modelo_lr.transform(treino)

previsoes_lr_treino.show()

#Criando Metricas (R2, RMSE)
resumo_treino = modelo_lr.summary

print(resumo_treino.r2)
print(resumo_treino.rootMeanSquaredError)

resumo_teste = modelo_lr.evaluate(teste)

print(resumo_teste.r2)
print(resumo_teste.rootMeanSquaredError)

#Criando a tabela de resumo Regressão Linear
print('Linear Regression')
print('='*30)
print('Dados de Treino')
print('='*30)
print("R²: %f" % resumo_treino.r2)
print("RMSE: %f" % resumo_treino.rootMeanSquaredError)
print("")
print("="*30)
print("Dados de Teste")
print("="*30)
print("R²: %f" % resumo_teste.r2)
print("RMSE: %f" % resumo_teste.rootMeanSquaredError)

###################################################################################
###################################################################################

#   MODELO 2:
# Arvore de Decisão

#Uma árvore de decisão é um mapa dos possíveis resultados de uma série de escolhas relacionadas.
# Ela permite que um indivíduo ou organização compare possíveis ações com base em seus custos,
# probabilidades e benefícios 1.
# É um algoritmo de aprendizado de máquina supervisionado que é utilizado para classificação e para regressão

from pyspark.ml.regression import DecisionTreeRegressor

dtr = DecisionTreeRegressor(seed=101, maxDepth=7)

modelo_dtr = dtr.fit(treino)

previsoes_dtr_treino = modelo_dtr.transform(treino)

print('previsoes_dtr_treino:\n')
previsoes_dtr_treino.show()

#Criando Métricas
from pyspark.ml.evaluation import RegressionEvaluator
evaluator = RegressionEvaluator()

print(evaluator.evaluate(previsoes_dtr_treino, {evaluator.metricName: 'r2'}))
print(evaluator.evaluate(previsoes_dtr_treino, {evaluator.metricName: 'rmse'}))

previsoes_dtr_teste = modelo_dtr.transform(teste)

previsoes_dtr_teste.show()

print('Decision Tree Regression')
print("="*30)
print("Dados de Treino")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_dtr_treino, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_dtr_treino, {evaluator.metricName: "rmse"}))
print("")
print("="*30)
print("Dados de Teste")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_dtr_teste, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_dtr_teste, {evaluator.metricName: "rmse"}))

###################################################################################
###################################################################################

# MODELO 3
# Random Forest (aprendizado de ensemble)
#Trabalhamos com varios Arvores de decisão, e no final temos varios resultados,
# e assim no final podemos fazer a média desses resultados

from pyspark.ml.regression import RandomForestRegressor

rfr = RandomForestRegressor(seed=101, maxDepth=7, numTrees=10)

modelo_rfr = rfr.fit(treino)

previsoes_rfr_treino = modelo_rfr.transform(treino)

previsoes_rfr_treino.show()

#Criando Metricas (R2, RMSE)
print(evaluator.evaluate(previsoes_rfr_treino, {evaluator.metricName: 'r2'}))
print(evaluator.evaluate(previsoes_rfr_treino, {evaluator.metricName: 'rmse'}))

previsoes_rfr_teste = modelo_rfr.transform(teste)

previsoes_rfr_teste.show()

print('Random Forest Regression')
print("="*30)
print("Dados de Treino")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_rfr_treino, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_rfr_treino, {evaluator.metricName: "rmse"}))
print("")
print("="*30)
print("Dados de Teste")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_rfr_teste, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_rfr_teste, {evaluator.metricName: "rmse"}))

###################################################################################
###################################################################################

# Ténicas de Otimização

#Arvores de Decisão com Cross Validation
from pyspark.ml.regression import DecisionTreeRegressor
from pyspark.ml.tuning import CrossValidator, ParamGridBuilder
from pyspark.ml.evaluation import RegressionEvaluator

dtr = DecisionTreeRegressor()

grid = ParamGridBuilder()\
    .addGrid(dtr.maxDepth, [2, 5, 10])\
    .addGrid(dtr.maxBins, [10, 32, 45])\
    .build()

evaluator = RegressionEvaluator()

dtr_cv = CrossValidator(
    estimator=dtr,
    estimatorParamMaps=grid,
    evaluator=evaluator,
    numFolds=3,
    seed=101
)

modelo_dtr_cv = dtr_cv.fit(treino)

previsoes_dtr_cv_teste = modelo_dtr_cv.transform(teste)

print('\n')
print("="*30)
print('Decision Tree Regression')
print("="*30)
print("Sem Cross Validation")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_dtr_teste, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_dtr_teste, {evaluator.metricName: "rmse"}))
print("")
print("="*30)
print("Com Cross Validation")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_dtr_cv_teste, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_dtr_cv_teste, {evaluator.metricName: "rmse"}))

#Random Forest com Cross Validation
from pyspark.ml.regression import RandomForestRegressor

rfr = RandomForestRegressor()

grid = ParamGridBuilder()\
    .addGrid(rfr.numTrees, [10, 20, 30])\
    .addGrid(rfr.maxDepth, [5, 10])\
    .addGrid(rfr.maxBins, [10, 32, 45])\
    .build()

evaluator = RegressionEvaluator()

rfr_cv = CrossValidator(
    estimator=rfr,
    estimatorParamMaps=grid,
    evaluator=evaluator,
    numFolds=3
)

modelo_rfr_cv = rfr_cv.fit(treino)

previsoes_rfr_cv_teste = modelo_rfr_cv.transform(teste)

print('\n')
print("="*30)
print('Random Forest Regression')
print("="*30)
print("Sem Cross Validation")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_rfr_teste, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_rfr_teste, {evaluator.metricName: "rmse"}))
print("")
print("="*30)
print("Com Cross Validation")
print("="*30)
print("R²: %f" % evaluator.evaluate(previsoes_rfr_cv_teste, {evaluator.metricName: "r2"}))
print("RMSE: %f" % evaluator.evaluate(previsoes_rfr_cv_teste, {evaluator.metricName: "rmse"}))

###################################################################################
###################################################################################
#Prevendo Resultados
dataset.show(15)

print(X)

#Imovel de preferencia para prever o valor
#Criando um dicionario do meu imovel
novo_imovel = [{
    'bathrooms': 2,
    'bedrooms': 2,
    'floors': 2,
    'parkingSpaces': 1,
    'suites': 1,
    'unitFloor': 0,
    'unitsOnTheFloor': 0,
    'usableAreas': 200,
    'condo': 200,
    'iptu': 0,
    'Apartamento': 0,
    'Casa': 1,
    'Outros': 0,
    'Zona Central': 0,
    'Zona Norte': 0,
    'Zona Oeste': 0,
    'Zona Sul': 1,
    'label': 0}]

#Criando dataframe baseado no dicionario
meu_imovel = spark.createDataFrame(novo_imovel)

#Vetorização do imovel
assembler = VectorAssembler(inputCols= X, outputCol='features')

meu_lar_vetorizado = assembler.transform(meu_imovel).select('features', 'label')

meu_lar_vetorizado.show()

#Após vetorizar escolhemos o melhor modelo, que nesse momento é Random Forest com cross validator
modelo_rfr_cv.transform(meu_lar_vetorizado).show()

input('Clique em ENTER para sair\n')
spark.stop()