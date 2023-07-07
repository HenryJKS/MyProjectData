-- Transact-SQL
-- São comandos de Manipulação de dados | Estruturados 
-- Inserindo dados na tabela com as variáveis

-- Declaração de varíavel
DECLARE 
@MATRICULA VARCHAR(5), 
@NOME VARCHAR(100), 
@PERCENTUAL FLOAT,
@DATA DATE, 
@FERIAS BIT, 
@BAIRRO VARCHAR(50),
@TESTE VARCHAR(10);

-- Declarando valor para varíaveis
SET @MATRICULA = '00240';
SET @NOME = 'Cláudia Rodrigues';
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