
create or replace PROCEDURE SOMA_VENDAS_CURSOR 
(p_VENDA_LIMITE IN produto_venda_exercicio.valor_total%type, p_ID_RETORNO OUT produto_venda_exercicio.id%type)
IS
   v_ID produto_venda_exercicio.id%type := 1;
   v_VALOR_TOTAL produto_venda_exercicio.valor_total%type;
   v_VENDA_TOTAL produto_venda_exercicio.valor_total%type := 0;
BEGIN
   FOR c IN (SELECT ID, VALOR_TOTAL FROM PRODUTO_VENDA_EXERCICIO) LOOP
        v_ID := C.ID;
        v_VALOR_TOTAL := C.VALOR_TOTAL;
      v_VENDA_TOTAL := v_VENDA_TOTAL + v_VALOR_TOTAL;
      IF v_VENDA_TOTAL >= p_VENDA_LIMITE THEN
         EXIT;
      END IF;
      v_ID := v_ID + 1;
   END LOOP;
   p_ID_RETORNO := v_ID;
END;

SELECT * FROM PRODUTO_VENDA_EXERCICIO;
SELECT 1 FROM PRODUTO_VENDA_EXERCICIO;
