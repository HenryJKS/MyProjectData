-- View
-- Podemos Criar View de uma consulta para melhorar nossa consulta
-- IMPORTANTE: Quando se cria VIEW � obrigat�rio ter os campos de fun��o com ALIAS

-- Consulta para transformar VIEW:
SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO, SUM(INF.QUANTIDADE) FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP 
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO HAVING SUM(INF.QUANTIDADE) > 394000 
ORDER BY SUM(INF.QUANTIDADE) DESC;

-- Cria��o da VIEW:
CREATE VIEW VIEW1 AS
SELECT INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO, SUM(INF.QUANTIDADE) "QUANTIDADE" FROM ITENS_NOTAS_FISCAIS INF
INNER JOIN TABELA_DE_PRODUTOS TP 
ON INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
GROUP BY INF.CODIGO_DO_PRODUTO, TP.NOME_DO_PRODUTO;

-- Fa�a a consulta que a QUANTIDADE seja maior que 394000 e ordenando de forma decrescente
SELECT * FROM VIEW1
WHERE QUANTIDADE > 394000
ORDER BY QUANTIDADE DESC;


