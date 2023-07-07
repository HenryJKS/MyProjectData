-- Transact-SQL
-- São comandos de Manipulação de dados | Estruturados 

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

-- Exibição das varíaveis 
PRINT @MATRICULA;
PRINT @NOME;
PRINT @PERCENTUAL;
PRINT @DATA;
PRINT @FERIAS;
PRINT @BAIRRO;
