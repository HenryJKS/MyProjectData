-- Substintuindo Having por Subquery
-- Para fazer isso pegamos a consulta e colocamos dentro de um "()" e damos um alias para ele.

-- Exemplo 1 --
SELECT SOMA_EMBALAGENS.EMBALAGEM, SOMA_EMBALAGENS.SOMA_PRECO FROM 
(
SELECT EMBALAGEM, SUM(PRECO_DE_LISTA) "SOMA_PRECO" FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM
) SOMA_EMBALAGENS
WHERE SOMA_EMBALAGENS.SOMA_PRECO >= 80;

-- Exemplo 2 --
SELECT SOMA.CODIGO_DO_PRODUTO, SOMA.NOME_DO_PRODUTO, SOMA.TOTAL FROM
(
SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO, SUM(INF.QUANTIDADE) "TOTAL" FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP 
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO
ORDER BY SUM(INF.QUANTIDADE) DESC
) SOMA
WHERE SOMA.TOTAL > 394000;