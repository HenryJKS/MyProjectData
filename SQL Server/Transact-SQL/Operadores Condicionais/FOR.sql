-- Operador FOR
--  FOR temos uma vari�vel variando de um n�mero a outro com um comando de repeti��o previamente fixo

DECLARE
@I INT;

SET @I = 1;

WHILE @I <= 100
BEGIN
	PRINT @I;
	SET @I = @I + 1;
END;

----------------------

-- De forma decrescente

SET @I = 10;

WHILE @I >= 1
	BEGIN
	PRINT @I;
	SET @I = @I - 1;
	END;