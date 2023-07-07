-- Check
-- O Check é uma restrição que você pode fazer durante a criação da tabela
-- Posso usar condições como < > = AND OR entre outros

CREATE TABLE TAB_CHECK (
ID INT IDENTITY(1, 1),
NOME VARCHAR(50),
IDADE INT,
CIDADE VARCHAR(50),
CONSTRAINT CHK_IDADE CHECK ((IDADE >= 18 AND CIDADE = 'São Paulo') OR 
							(IDADE >= 16 AND CIDADE = 'Rio de Janeiro'))
);

