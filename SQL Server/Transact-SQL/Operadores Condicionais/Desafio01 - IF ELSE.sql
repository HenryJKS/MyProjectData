 -- Desafio 01
   
   DECLARE @CPF VARCHAR(15);
   DECLARE @DATA_NASCIMENTO DATE;
   DECLARE @IDADE INT;
   DECLARE @RECEBEIDADE INT;

   SET @CPF = '1471156710';
   SELECT @DATA_NASCIMENTO = [DATA DE NASCIMENTO], @RECEBEIDADE = IDADE FROM [TABELA DE CLIENTES] 
   WHERE CPF = @CPF;
   SET @IDADE = DATEDIFF(YEAR, @DATA_NASCIMENTO, GETDATE());

	PRINT @IDADE;
	PRINT @RECEBEIDADE;
	
	
IF @RECEBEIDADE <> @IDADE
	BEGIN
    UPDATE [TABELA DE CLIENTES] SET IDADE = @IDADE WHERE CPF = @CPF;
	PRINT 'Idade atualizado'
	END
ELSE
	PRINT 'IDADE � IGUAL';
