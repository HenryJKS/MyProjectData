SELECT * FROM CLIENTE;
SELECT * FROM produto_venda_exercicio;

EXECUTE APP_INCLUIR_CLIENTE(32, 'CLIENTE INCLUINDO', '32323', 2, 100000);

SET SERVEROUTPUT ON;

EXEC DBMS_OUTPUT.PUT_LINE(CLIENTE_PAC.c_MEDIO_GRANDE);

EXECUTE APP_INCLUIR_VENDA(10, '32323', 100, 30);

CREATE OR REPLACE PROCEDURE APP_INCLUIR_VENDA
(p_ID PRODUTO_VENDA_EXERCICIO.ID%TYPE, 
 p_COD_PRODUTO PRODUTO_VENDA_EXERCICIO.COD_PRODUTO%TYPE, 
 p_QUANTIDADE PRODUTO_VENDA_EXERCICIO.QUANTIDADE%TYPE,
 p_PRECO PRODUTO_VENDA_EXERCICIO.PRECO%TYPE)
IS

BEGIN
    PRODUTO_EXERCICIO_PAC.INCLUINDO_DADOS_VENDA(p_ID, p_COD_PRODUTO, p_QUANTIDADE, p_PRECO);
END;
/
SELECT * FROM PRODUTO_EXERCICIO;
SELECT * FROM PRODUTO_VENDA_EXERCICIO;