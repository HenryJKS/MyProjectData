-- Triggers
-- Temos 2 Tabelas que possui rela��o de 1:N
-- Vamos criar uma tabela de faturamento para cada venda que tiver inserir o faturamento e a data da venda

CREATE TABLE NOTAS (
NUMERO NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
DATA_VENDA DATE,
CPF VARCHAR(11),
MATRICULA INTEGER,
IMPOSTO FLOAT
);

CREATE TABLE ITENS_NOTAS (
NUMERO NUMBER PRIMARY KEY,
CODIGO VARCHAR(20),
QUANTIDADE INT,
PRECO FLOAT,
FOREIGN KEY (NUMERO) REFERENCES NOTAS(NUMERO)
);

INSERT INTO NOTAS (DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES (TO_DATE('2019-01-04','YYYY-MM-DD'), '1471156710', '235', 0.1);
INSERT INTO ITENS_NOTAS (NUMERO, CODIGO, QUANTIDADE, PRECO)
VALUES (12, '1000889', 40, 10);

SELECT * FROM ITENS_NOTAS;
SELECT * FROM NOTAS;

-- Consulta para agrupar o faturamento por dia
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) "FATURAMENTO" FROM NOTAS A
INNER JOIN
ITENS_NOTAS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA;

CREATE TABLE TAB_FATURAMENTO (DATA_VENDA DATE NULL, FATURAMENTO FLOAT);

-- Inserindo o faturamento 
INSERT INTO TAB_FATURAMENTO (DATA_VENDA, FATURAMENTO)
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) "FATURAMENTO" FROM NOTAS A
INNER JOIN
ITENS_NOTAS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA;

SELECT * FROM TAB_FATURAMENTO;

-- Precisamos fazer nessa ordem:
DELETE FROM TAB_FATURAMENTO;

INSERT INTO TAB_FATURAMENTO (DATA_VENDA, FATURAMENTO)
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) "FATURAMENTO" FROM NOTAS A
INNER JOIN
ITENS_NOTAS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA;

-- Criando a Trigger
CREATE TRIGGER TG_TAB_FATURAMENTO 
AFTER INSERT OR UPDATE OR DELETE ON ITENS_NOTAS
BEGIN

DELETE FROM TAB_FATURAMENTO;

INSERT INTO TAB_FATURAMENTO (DATA_VENDA, FATURAMENTO)
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) "FATURAMENTO" FROM NOTAS A
INNER JOIN
ITENS_NOTAS B
ON A.NUMERO = B.NUMERO
GROUP BY A.DATA_VENDA;

END;

