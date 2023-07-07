-- Modifique-o para usar FOR e chame a procedure de SOMA_VENDAS_CURSOR_FOR.


create or replace PROCEDURE SOMA_VENDAS_CURSOR_FOR
(p_VENDA_LIMITE IN produto_venda_exercicio.valor_total%type, p_ID_RETORNO OUT produto_venda_exercicio.id%type)
IS
   v_ID produto_venda_exercicio.id%type := 1;
   v_VALOR_TOTAL produto_venda_exercicio.valor_total%type;
   v_VENDA_TOTAL produto_venda_exercicio.valor_total%type := 0;
BEGIN
   FOR C IN (SELECT ID FROM PRODUTO_VENDA_EXERCICIO) LOOP
      v_ID := C.ID;
      
      SELECT VALOR_TOTAL INTO v_VALOR_TOTAL FROM PRODUTO_VENDA_EXERCICIO WHERE ID = v_ID;
      v_VENDA_TOTAL := v_VENDA_TOTAL + v_VALOR_TOTAL;
      
      IF v_VENDA_TOTAL >= p_VENDA_LIMITE THEN
         EXIT;
      END IF ; 
      
   END LOOP;
   p_ID_RETORNO := v_ID;
END;

SET SERVEROUTPUT ON;
DECLARE
    v_RESULTADO produto_venda_exercicio.id%type;
BEGIN
    SOMA_VENDAS_CURSOR_FOR(20000, v_RESULTADO);
    DBMS_OUTPUT.PUT_LINE(v_RESULTADO);
END;