/* Uso de Fun��es tipo Date */

/* Pegar a data atual do seu computador */
SELECT GETDATE()

/* Pegar o Ano/M�s/Dia */
SELECT YEAR(GETDATE()) 'ANO' , MONTH(GETDATE())'MES', DAY(GETDATE()) 'DIA'


/* Diferen�a de 2 datas */
SELECT DATEDIFF(MONTH, '2023-01-01', GETDATE()) 'Data Atual - Inicio 2023'

/* Pega um Date especifico */
SELECT DATEPART(MINUTE, GETDATE())

/* Verifica se a data � valido */
SELECT ISDATE(GETDATE())

/* Pega o nome da data */

SELECT DATENAME(DAY, DATA_DE_NASCIMENTO) FROM TABELA_DE_CLIENTES
SELECT DATENAME(WEEKDAY, DATA_DE_NASCIMENTO) FROM TABELA_DE_CLIENTES
SELECT DATENAME(MONTH, DATA_DE_NASCIMENTO) FROM TABELA_DE_CLIENTES
SELECT DATENAME(YEAR, DATA_DE_NASCIMENTO) FROM TABELA_DE_CLIENTES

SELECT CONCAT('Nome Cliente: ', Nome, ' - ', 'Dia: ', DATENAME(DAY, DATA_DE_NASCIMENTO), ' - ', 'Dia da semana: ', 
				DATENAME(WEEKDAY, DATA_DE_NASCIMENTO), ' - ', 'M�s: ', DATENAME(MONTH , DATA_DE_NASCIMENTO), ' - ',
				'Ano: ', DATENAME(YEAR, DATA_DE_NASCIMENTO)) from TABELA_DE_CLIENTES
