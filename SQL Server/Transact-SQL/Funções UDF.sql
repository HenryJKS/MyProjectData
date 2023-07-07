-- Fun��es UDF
-- � o nome dado as fun��es desenvolvidas pelo usu�rios do SQL Server

-- Fun��o para retornar o faturamento de uma nota

CREATE FUNCTION FaturamentoNota (@NUMNOTAS INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @FATURAMENTO FLOAT;

SELECT @FATURAMENTO = SUM(QUANTIDADE * PRE�O) 
FROM [ITENS NOTAS FISCAIS] 
WHERE NUMERO = @NUMNOTAS;

	RETURN @FATURAMENTO;
END;

-- Usando a fun��o

SELECT NUMERO, dbo.FaturamentoNota(NUMERO) 'Faturamento' FROM [NOTAS FISCAIS]