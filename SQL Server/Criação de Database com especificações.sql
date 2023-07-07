/* Cria��o de um Database em um diret�rio especifico e configura��es da Database personalizada */
CREATE DATABASE SUCOS02
on (NAME = 'SUCOS02.DAT',
	FILENAME = 'E:\Diretorio SQL Server\SUCOS02.MDF', /* Localiza��o do Database */
	SIZE = 10MB, /* Tamanho do Database */
	MAXSIZE = 50MB, /* Tamanho M�ximo do Database */
	FILEGROWTH = 5MB) /* Tamanho que ficar� disponivel quando atingir o limite do Size padr�o */
	LOG ON
	(NAME = 'SUCOS02.LOG',
	FILENAME = 'E:\Diretorio SQL Server\SUCOS02.LOG',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB);