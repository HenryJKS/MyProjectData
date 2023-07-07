-- Operador Condicional
-- IF / Else

-- Verificando se a tabela existe
IF OBJECT_ID ('TABELATESTE','U') IS NOT NULL
	PRINT 'A Tabela existe'
ELSE
	PRINT 'TABELA NAO EXISTE'

----------------------------------------------------

-- Verificando se o dia é final de semana ou não
DECLARE
@DIA_SEMANA VARCHAR(20),
@NUMERO_DIAS INT;

SET @NUMERO_DIAS = 15;
SET @DIA_SEMANA = DATENAME(WEEKDAY, DATEADD(DAY, @NUMERO_DIAS, GETDATE()));

PRINT @DIA_SEMANA;

IF @DIA_SEMANA = 'Domingo' OR @DIA_SEMANA = 'Sábado'
	PRINT 'Este dia é fim de semana'
ELSE
	PRINT 'É dia da semana'

----------------------------------------------------

