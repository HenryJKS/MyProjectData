from pyspark import SparkContext

sc = SparkContext()
data = [1, 2, 3, 4, 5]
rdd = sc.parallelize(data)
print(rdd)

#Operação de Ação

#Collect, recupera todos os elementos de um RDD para o nó do driver
print(rdd.collect())

#Reduce, reduz elemento de uma RDD, podemos passa função do reduce
print(rdd.reduce(lambda x, y: x + y))

#Contar os elementos
print(rdd.count())

##########################################################################

#Operação de Transformação

#Map, usada para aplicar um transformação para cada elemento do RDD
rddMAP = rdd.map(lambda x: x + 10)
print(rddMAP.collect())

#Filtro
rddFill = rdd.filter(lambda x: x%2 == 0)
print(rddFill.collect())

SparkContext.stop()
