-- Transact-SQL
-- S�o comandos de Manipula��o de dados | Estruturados 

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

-- Exibi��o das var�aveis 
PRINT @MATRICULA;
PRINT @NOME;
PRINT @PERCENTUAL;
PRINT @DATA;
PRINT @FERIAS;
PRINT @BAIRRO;
