-- Operador Condicional
-- IF / Else

-- Verificando se a tabela existe
IF OBJECT_ID ('TABELATESTE','U') IS NOT NULL
	PRINT 'A Tabela existe'
ELSE
	PRINT 'TABELA NAO EXISTE'

----------------------------------------------------

-- Verificando se o dia � final de semana ou n�o
DECLARE
@DIA_SEMANA VARCHAR(20),
@NUMERO_DIAS INT;

SET @NUMERO_DIAS = 15;
SET @DIA_SEMANA = DATENAME(WEEKDAY, DATEADD(DAY, @NUMERO_DIAS, GETDATE()));

PRINT @DIA_SEMANA;

IF @DIA_SEMANA = 'Domingo' OR @DIA_SEMANA = 'S�bado'
	PRINT 'Este dia � fim de semana'
ELSE
	PRINT '� dia da semana'

----------------------------------------------------

