-- Procedure
-- Atualizar a idade de todos os clientes

-- Criação da Procedure
CREATE PROCEDURE CalculaIdade
AS
	BEGIN
		UPDATE [TABELA DE CLIENTES] SET IDADE = DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
	END;

-- Chamar a Procedure
EXEC CalculaIdade;

-- Verificar todas idades
SELECT CPF, NOME, [DATA DE NASCIMENTO], IDADE, DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE())
FROM [TABELA DE CLIENTES]