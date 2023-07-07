/* Criação de um Database em um diretório especifico e configurações da Database personalizada */
CREATE DATABASE SUCOS02
on (NAME = 'SUCOS02.DAT',
	FILENAME = 'E:\Diretorio SQL Server\SUCOS02.MDF', /* Localização do Database */
	SIZE = 10MB, /* Tamanho do Database */
	MAXSIZE = 50MB, /* Tamanho Máximo do Database */
	FILEGROWTH = 5MB) /* Tamanho que ficará disponivel quando atingir o limite do Size padrão */
	LOG ON
	(NAME = 'SUCOS02.LOG',
	FILENAME = 'E:\Diretorio SQL Server\SUCOS02.LOG',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB);