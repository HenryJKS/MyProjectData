-- Delete

-- Inserindo Linhas
INSERT INTO PRODUTOS 
    (CODIGO,DESCRITOR,SABOR,TAMANHO,EMBALAGEM,PRECO_LISTA)
VALUES 
    ('1001001','Sabor dos Alpes 700 ml - Manga','Manga','700 ml','Garrafa',7.50),
    ('1001000','Sabor dos Alpes 700 ml - Melão','Melão','700 ml','Garrafa',7.50),
    ('1001002','Sabor dos Alpes 700 ml - Graviola','Graviola','700 ml','Garrafa',7.50),
    ('1001003','Sabor dos Alpes 700 ml - Tangerina','Tangerina','700 ml','Garrafa',7.50),
    ('1001004','Sabor dos Alpes 700 ml - Abacate','Abacate','700 ml','Garrafa',7.50),
    ('1001005','Sabor dos Alpes 700 ml - Açai','Açai','700 ml','Garrafa',7.50),
    ('1001006','Sabor dos Alpes 1 Litro - Manga','Manga','1 Litro','Garrafa',7.50),
    ('1001007','Sabor dos Alpes 1 Litro - Melão','Melão','1 Litro','Garrafa',7.50),
    ('1001008','Sabor dos Alpes 1 Litro - Graviola','Graviola','1 Litro','Garrafa',7.50),
    ('1001009','Sabor dos Alpes 1 Litro - Tangerina','Tangerina','1 Litro','Garrafa',7.50),
    ('1001010','Sabor dos Alpes 1 Litro - Abacate','Abacate','1 Litro','Garrafa',7.50),
    ('1001011','Sabor dos Alpes 1 Litro - Açai','Açai','1 Litro','Garrafa',7.50);

-- Deletando produtos onde o codigo está entre 10011000 e 10001011 onde o tamanho é 1 Litro
DELETE FROM PRODUTOS WHERE CODIGO BETWEEN '1001000' AND '1001011' AND TAMANHO = '1 Litro';

-- Deletando produtos na tabela principal onde não possui na tabela secundária
DELETE FROM PRODUTOS 
WHERE CODIGO NOT IN (SELECT CODIGO_DO_PRODUTO FROM SUCOS_FRUTAS.dbo.TABELA_DE_PRODUTOS)

-- Deletando as notas fiscais onde o cliente tem menos de 18 anos
DELETE A FROM TABELA_DE_VENDAS A
INNER JOIN CLIENTES B
ON A.CPF = B.CPF
WHERE B.IDADE < 18
