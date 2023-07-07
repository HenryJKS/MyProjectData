-- Tabela temporária
-- São tabelas existentes somente durante determinado tempo e que somem após este período.
-- Tabela com #, são tabelas que valem somente para uma conexão em uso.
-- Tabela com ##, são tabelas que valem para todas conexões abertas.
-- Tabela com @, são tabelas que  são tabelas existentes somente durante determinado tempo 
-- e que somem após este período.

CREATE TABLE #TABELA01(
ID VARCHAR(10),
NOME VARCHAR(30)
);

INSERT INTO #TABELA01
VALUES
(1, 'JOAO');

SELECT * FROM #TABELA01
