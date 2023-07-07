-- Merge

-- Passando da tabela B os dados do preco de lista para tabela A
-- Exemplo 1
MERGE INTO PRODUTOS A
USING SUCOS_FRUTAS.DBO.TABELA_DE_PRODUTOS B
ON A.CODIGO = B.CODIGO_DO_PRODUTO
WHEN MATCHED THEN 
UPDATE SET A.PRECO_LISTA = B.PRECO_DE_LISTA;

-- Aumentado 30% o volume compra do cliente, somente os clientes que possuem vendedores no mesmo bairro
-- Exemplo 2
MERGE INTO CLIENTES B
USING VENDEDORES A
ON A.BAIRRO = B.BAIRRO
WHEN MATCHED THEN
UPDATE SET B.VOLUME_COMPRA = B.VOLUME_COMPRA * 1.30;