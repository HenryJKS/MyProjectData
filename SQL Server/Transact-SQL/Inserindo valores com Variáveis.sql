-- Transact-SQL
-- S�o comandos de Manipula��o de dados | Estruturados 
-- Inserindo dados na tabela com as vari�veis

-- Declara��o de var�avel
DECLARE 
@MATRICULA VARCHAR(5), 
@NOME VARCHAR(100), 
@PERCENTUAL FLOAT,
@DATA DATE, 
@FERIAS BIT, 
@BAIRRO VARCHAR(50),
@TESTE VARCHAR(10);

-- Declarando valor para var�aveis
SET @MATRICULA = '00240';
SET @NOME = 'Cl�udia Rodrigues';
SET @PERCENTUAL = 0.10;
SET @DATA = '2012-03-12';
SET @FERIAS = 1;
SET @BAIRRO = 'Jardins';

-- Inserindo valores na tabela
INSERT INTO [TABELA DE VENDEDORES]
VALUES
(@MATRICULA, @NOME, @PERCENTUAL, @DATA, @FERIAS, @BAIRRO);

PRINT 'UM VENDEDOR INCLUINDO';

SELECT * FROM [TABELA DE VENDEDORES];