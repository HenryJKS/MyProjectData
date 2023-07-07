-- Definir valores Default
-- Podemos definir na hora de criação da tabela

CREATE TABLE X (
ID NUMBER DEFAULT 1,
NOME VARCHAR(50) DEFAULT 'TESTE',
DATAC DATE DEFAULT SYSDATE
);

INSERT INTO X (ID) VALUES (2);

SELECT * FROM X;

DROP TABLE X;
