/* Uso de Fun��es Tipo String */

/* CONCAT */
SELECT YEAR(DATA_VENDA),
CONCAT('O CPF: ', CPF,' Teve uma venda no ano de: ', YEAR(DATA_VENDA)) FROM NOTAS_FISCAIS
ORDER BY YEAR(DATA_VENDA)


/* YEAR/MONTH/DAY (Pega somente a data que deseja) */
SELECT CONCAT('DIA: ',DAY(DATA_VENDA),' ', 'M�S: ', MONTH(DATA_VENDA),' ', 'ANO: ', YEAR(DATA_VENDA))
FROM NOTAS_FISCAIS


/* REPLICATE (Repetir x vezes um valor de cadeia de String) */
SELECT REPLICATE('TESTE ', 5)


/* REPLACE (Substituir um valor de caracter por outro valor) */
SELECT REPLACE('N�O SIM N�O SIM N�O', 'SIM', '-')


/* LEN (Conta n�mero de caracteres) */
SELECT LEN('TESTE')

/* Jun��o de 2 Functions SUBSTRING/CHARINDEX */
SELECT NOME, SUBSTRING(NOME, 1, CHARINDEX(' ', NOME, 1)) FROM TABELA_DE_CLIENTES
