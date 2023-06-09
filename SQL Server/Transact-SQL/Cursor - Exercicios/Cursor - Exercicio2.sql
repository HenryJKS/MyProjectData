-- Cursor
-- Pegando um cliente aleat�rio
-- Usando uma fun��o que criamos para pegar um numero aleatorio

DECLARE
@CLIENTEALEATORIO VARCHAR(12),
@VALORINICIAL INT,
@VALORFINAL INT,
@ALEATORIO INT,
@CONTADOR INT;

SET @CONTADOR = 1;
SET @VALORINICIAL = 1;
SELECT @VALORFINAL = COUNT(*) FROM [TABELA DE CLIENTES];
SET @ALEATORIO = DBO.NumeroAleatorio(@VALORINICIAL, @VALORFINAL);

DECLARE CURSORALEATORIO CURSOR FOR
SELECT CPF FROM [TABELA DE CLIENTES]	

OPEN CURSORALEATORIO;

FETCH NEXT FROM CURSORALEATORIO INTO @CLIENTEALEATORIO

WHILE @CONTADOR < @ALEATORIO 
	BEGIN
	FETCH NEXT FROM CURSORALEATORIO INTO @CLIENTEALEATORIO
	SET @CONTADOR = @CONTADOR + 1;
	END;

CLOSE CURSORALEATORIO;

DEALLOCATE CURSORALEATORIO;

SELECT @CLIENTEALEATORIO, @ALEATORIO
SELECT * FROM [TABELA DE CLIENTES]