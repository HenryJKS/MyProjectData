-- Funções UDF
-- É o nome dado as funções desenvolvidas pelo usuários do SQL Server

-- Função para retornar o faturamento de uma nota

CREATE FUNCTION FaturamentoNota (@NUMNOTAS INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @FATURAMENTO FLOAT;

SELECT @FATURAMENTO = SUM(QUANTIDADE * PREÇO) 
FROM [ITENS NOTAS FISCAIS] 
WHERE NUMERO = @NUMNOTAS;

	RETURN @FATURAMENTO;
END;

-- Usando a função

SELECT NUMERO, dbo.FaturamentoNota(NUMERO) 'Faturamento' FROM [NOTAS FISCAIS]