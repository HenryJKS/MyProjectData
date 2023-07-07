-- Cursor
-- Usamos Cursor para fazermos uma s�rie de manipula��es em determinadas linhas de uma tabela

-- Declarando uma var�avel
DECLARE @NOME VARCHAR(200);

-- Criando um Cursor
DECLARE CURSOR1 CURSOR FOR
SELECT TOP 4 NOME FROM [TABELA DE CLIENTES];

-- Inicializando o Cursor
OPEN CURSOR1;

-- Fetch Next, o ponteiro come�ar a apontar a primeira linha
FETCH NEXT FROM CURSOR1 INTO @NOME

-- Fazer o ponteiro, percorrer todas linhas da sele��o
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @NOME;
		-- Outro Fetch Next para percorrer a proxima linha
		FETCH NEXT FROM CURSOR1 INTO @NOME
	END;

-- Fechar o CURSOR
CLOSE CURSOR1;

-- Zerar o CURSOR
DEALLOCATE CURSOR1;
