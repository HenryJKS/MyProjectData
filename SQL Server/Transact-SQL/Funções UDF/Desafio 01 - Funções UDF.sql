-- Desafio Function UDF 01
-- Fa�a uma fun��o UDF que retorne o faturamento total de todas as notas fiscais de um bairro.
/* Exemplo: Se eu seleciono como par�metro da fun��o o bairro jardins, 
o retorno da fun��o ser� o total de faturamento de todas as notas fiscais, 
para todos os per�odos, para este bairro. */

SELECT SUM(C.QUANTIDADE * C.PRE�O)
FROM [TABELA DE CLIENTES] A
INNER JOIN [NOTAS FISCAIS] B
ON A.CPF = B.CPF
INNER JOIN [ITENS NOTAS FISCAIS] C
ON C.NUMERO = B.NUMERO
WHERE A.BAIRRO = 'Jardins';

CREATE FUNCTION CalculaFaturamentoBairro (@Bairro VARCHAR(20))
RETURNS FLOAT
AS
BEGIN
DECLARE @FATURAMENTO FLOAT;

SELECT @FATURAMENTO = SUM(C.QUANTIDADE * C.PRE�O)
FROM [TABELA DE CLIENTES] A
INNER JOIN [NOTAS FISCAIS] B
ON A.CPF = B.CPF
INNER JOIN [ITENS NOTAS FISCAIS] C
ON C.NUMERO = B.NUMERO
WHERE @Bairro = A.BAIRRO;

RETURN @FATURAMENTO;

END;


-- Comparando Valores
SELECT A.BAIRRO, SUM(C.QUANTIDADE * C.PRE�O), DBO.CalculaFaturamentoBairro(A.BAIRRO)
FROM [TABELA DE CLIENTES] A
INNER JOIN [NOTAS FISCAIS] B
ON A.CPF = B.CPF
INNER JOIN [ITENS NOTAS FISCAIS] C
ON C.NUMERO = B.NUMERO
GROUP BY A.BAIRRO;
