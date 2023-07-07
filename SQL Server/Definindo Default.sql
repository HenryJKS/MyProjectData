-- Definindo Padrões
-- Podemos definir padrões na criação da tabela usando DEFAULT

CREATE TABLE PADRAO (
ID INTEGER IDENTITY(1, 1),
DESCRITOR VARCHAR(20),
ENDERECO VARCHAR(20),
CIDADE VARCHAR(20) DEFAULT 'Rio de Janeiro',
DATA_CRIACAO DATE DEFAULT GETDATE()
);

-- Anulando todas as colunas para usar o Default

INSERT INTO PADRAO (DESCRITOR)
VALUES
('CLIENTE Y');

SELECT * FROM PADRAO