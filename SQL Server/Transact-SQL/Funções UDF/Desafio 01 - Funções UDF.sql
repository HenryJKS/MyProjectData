-- Desafio Function UDF 01
-- Faça uma função UDF que retorne o faturamento total de todas as notas fiscais de um bairro.
/* Exemplo: Se eu seleciono como parâmetro da função o bairro jardins, 
o retorno da função será o total de faturamento de todas as notas fiscais, 
para todos os períodos, para este bairro. */

SELECT SUM(C.QUANTIDADE * C.PREÇO)
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

SELECT @FATURAMENTO = SUM(C.QUANTIDADE * C.PREÇO)
FROM [TABELA DE CLIENTES] A
INNER JOIN [NOTAS FISCAIS] B
ON A.CPF = B.CPF
INNER JOIN [ITENS NOTAS FISCAIS] C
ON C.NUMERO = B.NUMERO
WHERE @Bairro = A.BAIRRO;

RETURN @FATURAMENTO;

END;


-- Comparando Valores
SELECT A.BAIRRO, SUM(C.QUANTIDADE * C.PREÇO), DBO.CalculaFaturamentoBairro(A.BAIRRO)
FROM [TABELA DE CLIENTES] A
INNER JOIN [NOTAS FISCAIS] B
ON A.CPF = B.CPF
INNER JOIN [ITENS NOTAS FISCAIS] C
ON C.NUMERO = B.NUMERO
GROUP BY A.BAIRRO;
