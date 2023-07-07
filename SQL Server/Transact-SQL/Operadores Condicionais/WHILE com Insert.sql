-- WHILE COM INSERT

IF OBJECT_ID('[TABELA DE NUMEROS]', 'U') IS NOT NULL DROP TABLE [TABELA DE NUMEROS];
CREATE TABLE [TABELA DE NUMEROS] (
NUMERO INT,
SITUA��O VARCHAR(20)
);

DECLARE
@NUMERO_INICIAL_SEQUENCIA INT,
@NUMERO_FINAL_SEQUENCIA INT,
@TESTE_NOTA_FISCAL INT;

SET @NUMERO_INICIAL_SEQUENCIA = 1;
SET @NUMERO_FINAL_SEQUENCIA = 200;
-- N�o mostrar as mensagens de "linha afetada"
SET NOCOUNT ON;

WHILE @NUMERO_INICIAL_SEQUENCIA < @NUMERO_FINAL_SEQUENCIA
	BEGIN
		SELECT @TESTE_NOTA_FISCAL = COUNT(*) FROM [NOTAS FISCAIS] WHERE NUMERO = @NUMERO_INICIAL_SEQUENCIA;
		IF @TESTE_NOTA_FISCAL = 1
			INSERT INTO [TABELA DE NUMEROS] (NUMERO, SITUA��O) 
			VALUES (@NUMERO_INICIAL_SEQUENCIA, '� Nota Fiscal');
		ELSE
			INSERT INTO [TABELA DE NUMEROS] (NUMERO, SITUA��O) 
			VALUES (@NUMERO_INICIAL_SEQUENCIA, 'N�o � Nota Fiscal');
		SET @NUMERO_INICIAL_SEQUENCIA = @NUMERO_INICIAL_SEQUENCIA + 1;
END;

SELECT * FROM [TABELA DE NUMEROS]