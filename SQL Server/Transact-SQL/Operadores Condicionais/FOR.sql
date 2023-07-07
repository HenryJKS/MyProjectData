-- Operador FOR
--  FOR temos uma variável variando de um número a outro com um comando de repetição previamente fixo

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