-- Trigger
-- � um gatilho onde se poder fazer uma s�ries de manipula��es,
-- depois, durante e substituir em um comando DML (INSERT, UPDATE, DELETE)

--  Tabela para apoio do FATURAMENTO
CREATE TABLE TAB_FATURAMENTO (
DATA_VENDA DATE,
TOTAL_VENDA FLOAT
);

-------------------------

-- Pegando a data da venda e o faturamento (QUANTIDADE * PRECO)
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) 'TOTAL VENDA'
FROM TABELA_DE_VENDAS A
INNER JOIN TABELA_DE_ITENS_VENDIDOS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA

-------------------------

-- Inserindo dados na TAB_FATURAMENTO
INSERT INTO TAB_FATURAMENTO
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) 'TOTAL VENDA'
FROM TABELA_DE_VENDAS A
INNER JOIN TABELA_DE_ITENS_VENDIDOS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA

-------------------------

-- A ordem da Trigger
DELETE FROM TAB_FATURAMENTO;

INSERT INTO TAB_FATURAMENTO
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) 'TOTAL VENDA'
FROM TABELA_DE_VENDAS A
INNER JOIN TABELA_DE_ITENS_VENDIDOS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA

-------------------------

SELECT * FROM TAB_FATURAMENTO

-- Cria��o da Trigger
CREATE TRIGGER TG_ITENS_VENDIDOS
ON [dbo].[TABELA_DE_ITENS_VENDIDOS]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
DELETE FROM TAB_FATURAMENTO;

INSERT INTO TAB_FATURAMENTO
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) 'TOTAL VENDA'
FROM TABELA_DE_VENDAS A
INNER JOIN TABELA_DE_ITENS_VENDIDOS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA;

END

-------------------------

-- Update sendo manipulado
UPDATE TABELA_DE_ITENS_VENDIDOS SET QUANTIDADE = 200 WHERE NUMERO = '174'

-- Delete sendo manipulado
DELETE FROM TABELA_DE_ITENS_VENDIDOS WHERE NUMERO = '174'