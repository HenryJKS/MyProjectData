-- Procedure
-- Essa procedure busca a nota do cliente pelo CPF, DataInicial, DataFinal

CREATE PROCEDURE BuscaNotaCliente (
@CPF VARCHAR(12) = '19290992743',
@DATA_INICIAL DATETIME = '20160101',
@DATA_FINAL DATETIME = '20161231'
)
AS

BEGIN
	SELECT * FROM [NOTAS FISCAIS]
	WHERE CPF = @CPF
	AND DATA >= @DATA_INICIAL AND DATA <= @DATA_FINAL;
END;

-- Quando chamamos podemos declarar outros valores para buscar outros dados 
EXEC BuscaNotaCliente @CPF = '19290992743', @DATA_INICIAL='20160501', @DATA_FINAL='20160615';

-- Podemos chamar também pelo valor DEFAULT, que colocamos dentro da Procedure
EXEC BuscaNotaCliente @CPF = DEFAULT, @DATA_INICIAL = DEFAULT, @DATA_FINAL = DEFAULT;
