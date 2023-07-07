-- Rownumber, seria uma contagem de linhas, você pode especificar quais linhas você quer que apareça --

SELECT DISTINCT EMBALAGEM FROM TABELA_DE_PRODUTOS
WHERE ROWNUM = 1;

SELECT ROWNUM, A.* FROM tabela_de_produtos A
WHERE ROWNUM <= 5;
