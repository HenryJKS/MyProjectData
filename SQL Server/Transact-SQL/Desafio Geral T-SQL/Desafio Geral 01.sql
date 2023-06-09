-- Desafio Geral 01
-- Montar um relat�rio mostrando o nome dos clientes, com seus respectivos CPFs e o valor total
-- Usando tabela temporaria

DECLARE 
@CPF VARCHAR(11),
@NOME VARCHAR(100),
@NUMCLIENTES INT,
@I INT,
@MES INT,
@ANO INT,
@TOTAL_VENDAS FLOAT;
-- TABELA TEMPORARIA
DECLARE @TABELAFINAL TABLE(CPF VARCHAR(11), NOME VARCHAR(100), MES INT, ANO INT, VALOR_TOTAL FLOAT);	

SELECT @NUMCLIENTES = COUNT(*) FROM [TABELA DE CLIENTES]
SET @MES = 2;
SET @ANO = 2015;
SET @I = 1;

WHILE @I <= @NUMCLIENTES
	BEGIN
		SELECT @CPF = A.CPF, @NOME = A.NOME
		FROM (
		SELECT Row_Number() Over (Order By CPF) as RowNum, *
		FROM [TABELA DE CLIENTES] ) A
		WHERE A.RowNum = @I;

		SELECT @TOTAL_VENDAS = SUM(C.QUANTIDADE * C.PRE�O) 
		FROM [ITENS NOTAS FISCAIS] C
		INNER JOIN [NOTAS FISCAIS] B
		ON B.NUMERO = C.NUMERO
		WHERE B.CPF = @CPF
		AND YEAR(B.DATA) = @ANO AND MONTH(B.DATA) = @MES;

		INSERT INTO @TABELAFINAL
		VALUES
		(@CPF, @NOME, @MES, @ANO, @TOTAL_VENDAS);

		PRINT 'Vendas para	' + @CPF + ' - ' + @NOME + ' NO M�S ' + 
			   CONVERT(VARCHAR(2), @MES) + ' E ANO ' + CONVERT(VARCHAR(4), @ANO) + ' FOI DE ' + 
			   TRIM(STR(@TOTAL_VENDAS, 15, 2));
		SET @I = @I + 1;
	END;

	SELECT * FROM @TABELAFINAL
