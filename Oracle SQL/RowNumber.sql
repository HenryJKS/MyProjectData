-- Rownumber, seria uma contagem de linhas, voc� pode especificar quais linhas voc� quer que apare�a --

SELECT DISTINCT EMBALAGEM FROM TABELA_DE_PRODUTOS
WHERE ROWNUM = 1;

SELECT ROWNUM, A.* FROM tabela_de_produtos A
WHERE ROWNUM <= 5;
