-- Check
-- O Check � uma restri��o que voc� pode fazer durante a cria��o da tabela
-- Posso usar condi��es como < > = AND OR entre outros

CREATE TABLE TAB_CHECK (
ID INT IDENTITY(1, 1),
NOME VARCHAR(50),
IDADE INT,
CIDADE VARCHAR(50),
CONSTRAINT CHK_IDADE CHECK ((IDADE >= 18 AND CIDADE = 'S�o Paulo') OR 
							(IDADE >= 16 AND CIDADE = 'Rio de Janeiro'))
);

