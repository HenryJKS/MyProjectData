SELECT a.id_fabrica, a.id_vendedor, a.id_cliente, a.id_produto, b.numero_ano, sum(a.faturamento) AS FATURAMENTO,
1 AS CONTADORLINHA 
FROM fato_presidencia a 
INNER JOIN
dim_tempo b
ON a.id_tempo = b.id_tempo
GROUP BY a.id_fabrica, a.id_vendedor, a.id_cliente, a.id_produto, b.numero_ano, 1