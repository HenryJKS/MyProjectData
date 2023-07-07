/*
Temos 9 vendas realizadas no ano de 2022. Com quantas vendas no ano o valor total atingiu 20.000?
Se olharmos no "olho", veremos que após a venda 6, o valor somado das vendas, desde a venda 1, 
atingiu mais de 20.000,00. A resposta para a pergunta acima seria então a partir da venda 6.
Faça uma procedure que retorne este valor (nome: SOMA_VENDAS), que use um FOR e que execute o EXIT no meio do LOOP.
*/

SELECT SUM(VALOR_TOTAL) FROM PRODUTO_VENDA_EXERCICIO
WHERE EXTRACT(YEAR FROM DATA) = 2023;

SELECT VALOR_TOTAL FROM PRODUTO_VENDA_EXERCICIO;

CREATE OR REPLACE PROCEDURE SOMA_VENDAS
(p_VALOR PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE, p_RESULTADO OUT PRODUTO_VENDA_EXERCICIO.ID%TYPE)
IS
v_VENDA_TOTAL PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE := 0;
v_VALOR_TOTAL PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE;
v_ID PRODUTO_VENDA_EXERCICIO.ID%TYPE := 1;
BEGIN   
    LOOP
        SELECT VALOR_TOTAL INTO v_VALOR_TOTAL FROM PRODUTO_VENDA_EXERCICIO WHERE ID = v_ID;
        v_VENDA_TOTAL := v_VENDA_TOTAL + v_VALOR_TOTAL;
        IF v_VENDA_TOTAL >= p_VALOR THEN
            EXIT;
        END IF;
    v_ID := v_ID + 1;
    END LOOP;
    p_RESULTADO := v_ID;
END;


SET SERVEROUTPUT ON;

DECLARE
    p_RESULTADO INTEGER;
BEGIN
    SOMA_VENDAS(25000, p_RESULTADO);
    
    DBMS_OUTPUT.PUT_LINE(p_RESULTADO);
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('Valor Passou do Limite');

END;
