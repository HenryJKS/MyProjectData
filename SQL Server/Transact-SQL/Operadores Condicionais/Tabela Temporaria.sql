-- Tabela tempor�ria
-- S�o tabelas existentes somente durante determinado tempo e que somem ap�s este per�odo.
-- Tabela com #, s�o tabelas que valem somente para uma conex�o em uso.
-- Tabela com ##, s�o tabelas que valem para todas conex�es abertas.
-- Tabela com @, s�o tabelas que  s�o tabelas existentes somente durante determinado tempo 
-- e que somem ap�s este per�odo.

CREATE TABLE #TABELA01(
ID VARCHAR(10),
NOME VARCHAR(30)
);

INSERT INTO #TABELA01
VALUES
(1, 'JOAO');

SELECT * FROM #TABELA01
