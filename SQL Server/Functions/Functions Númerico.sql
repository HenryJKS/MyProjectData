/* ROUND (Arrendodamento) */
SELECT ROUND(PRECO_DE_LISTA, 2) 'Arrendodado por 2 decimais' FROM TABELA_DE_PRODUTOS

/* SQRT (Retorna a raiz quadrada do valor inserido */
SELECT SQRT(144)

/* Uso da função Floor (Retorna o menor valor inserido) */
SELECT YEAR(B.DATA_VENDA), FLOOR(SUM(B.IMPOSTO * (A.QUANTIDADE * A.PRECO))) 'Imposto 2016'
FROM ITENS_NOTAS_FISCAIS A
INNER JOIN NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE YEAR(B.DATA_VENDA) = 2016
GROUP BY YEAR(B.DATA_VENDA);
