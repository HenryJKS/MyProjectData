-- Uso do Update 

USE VENDAS_SUCOS;

-- Aumentando o pre�o lista para 5 onde o codigo � igual a 1040107
UPDATE PRODUTOS SET PRECO_LISTA = 5 WHERE CODIGO = '1040107'

-- Aumentando o preco lista em 10% onde o sabor � Manga
UPDATE PRODUTOS SET PRECO_LISTA = PRECO_LISTA * 1.10 WHERE SABOR = 'Manga';

-- Mudando descritor com replace de 350 ML para 550 ML
UPDATE PRODUTOS SET DESCRITOR = REPLACE(DESCRITOR, '350 ml', '550 ml'), 
					TAMANHO = '550 ml'
WHERE TAMANHO = '350 ML';

-- Uso de Update com FROM

-- Alterando preco lista da tabela A com os valores da tabela B
UPDATE B SET B.PRECO_LISTA = A.PRECO_DE_LISTA
FROM SUCOS_FRUTAS.dbo.TABELA_DE_PRODUTOS A
INNER JOIN PRODUTOS B
ON A.CODIGO_DO_PRODUTO = B.CODIGO

-- Outro exemplo � aumentar em 30% o volume de compra dos clientes que possuem, 
-- em seus endere�os, bairros onde os vendedores possuam escrit�rios.

UPDATE B SET B.VOLUME_COMPRA = B.VOLUME_COMPRA * 1.30
FROM VENDEDORES A
INNER JOIN CLIENTES B
ON A.BAIRRO = B.BAIRRO
