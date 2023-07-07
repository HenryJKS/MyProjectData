-- Alternao a Procedure para adicionar a fun��o RETORNA_IMPOSTO e calcular valor total

SELECT * FROM PRODUTO_VENDA_EXERCICIO;
SELECT * FROM PRODUTO_EXERCICIO;

EXECUTE INCLUINDO_DADOS_VENDAS(3, '33854', '02-01-2022', 100, 22);



CREATE OR REPLACE NONEDITIONABLE PROCEDURE INCLUINDO_DADOS_VENDAS
(p_ID PRODUTO_VENDA_EXERCICIO.ID%TYPE, p_CODPRODUTO PRODUTO_VENDA_EXERCICIO.COD_PRODUTO%TYPE,
 p_DATE PRODUTO_VENDA_EXERCICIO.DATA%TYPE, p_QUANTIDADE PRODUTO_VENDA_EXERCICIO.QUANTIDADE%TYPE, p_PRECO PRODUTO_VENDA_EXERCICIO.PRECO%TYPE)
IS
v_PERCENTUALIMPOSTO PRODUTO_VENDA_EXERCICIO.PERCENTUAL_IMPOSTO%TYPE;
V_VALORTOTAL PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE;
BEGIN
    v_PERCENTUALIMPOSTO := RETORNA_IMPOSTO(p_CODPRODUTO);
    v_VALORTOTAL := p_QUANTIDADE * p_PRECO;
    
    
    INSERT INTO PRODUTO_VENDA_EXERCICIO VALUES (p_ID, p_CODPRODUTO, p_DATE, p_QUANTIDADE, p_PRECO, v_VALORTOTAL, v_PERCENTUALIMPOSTO);
    COMMIT;
END;