-- Consultas Avan�adas SQL Server

------------- Exercicio 1
-- 1 Passo Criar a primeira consulta
SELECT A.CPF, CONVERT(VARCHAR(7), A.DATA_VENDA, 120) 'M�s_Ano', SUM(B.QUANTIDADE) 'Quantidade Total'
FROM NOTAS_FISCAIS A
INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
GROUP BY A.CPF, CONVERT(VARCHAR(7), A.DATA_VENDA, 120)

-- 2 Passo Criar a segunda consulta para usar como subquery a primeira consulta
SELECT CPF, NOME, VOLUME_DE_COMPRA FROM TABELA_DE_CLIENTES

-- 3 Passo Fazendo a subquery
SELECT C.CPF, C.NOME, C.VOLUME_DE_COMPRA , PV.M�s_Ano, PV.[Quantidade Total] FROM TABELA_DE_CLIENTES C
INNER JOIN
			(SELECT A.CPF, CONVERT(VARCHAR(7), A.DATA_VENDA, 120) 'M�s_Ano', SUM(B.QUANTIDADE) 'Quantidade Total'
			FROM NOTAS_FISCAIS A
			INNER JOIN ITENS_NOTAS_FISCAIS B
			ON A.NUMERO = B.NUMERO
			GROUP BY A.CPF, CONVERT(VARCHAR(7), A.DATA_VENDA, 120)
			) PV
ON C.CPF = PV.CPF

-- Ultimo Passo Adicionando mais uma coluna de Percentual e dando mais um condi��o para ver somente as Vendas Inv�lidas
SELECT C.CPF, C.NOME, C.VOLUME_DE_COMPRA , PV.M�s_Ano, PV.[Quantidade Total], 
	   CONCAT(ROUND((1 - (C.VOLUME_DE_COMPRA/PV.[Quantidade Total]))* 100,2), '%') 'Percentual',
(CASE
	WHEN C.VOLUME_DE_COMPRA >= PV.[Quantidade Total] THEN 'Vendas V�lida'
	ELSE 'Vendas Inv�lida'
	END) 'Classifica��o'
FROM TABELA_DE_CLIENTES C
INNER JOIN
			(SELECT A.CPF, CONVERT(VARCHAR(7), A.DATA_VENDA, 120) 'M�s_Ano', SUM(B.QUANTIDADE) 'Quantidade Total'
			FROM NOTAS_FISCAIS A
			INNER JOIN ITENS_NOTAS_FISCAIS B
			ON A.NUMERO = B.NUMERO
			GROUP BY A.CPF, CONVERT(VARCHAR(7), A.DATA_VENDA, 120)
			) PV
ON C.CPF = PV.CPF
WHERE PV.M�s_Ano = '2015-01' AND (C.VOLUME_DE_COMPRA < PV.[Quantidade Total]);
------------- Exercicio 1