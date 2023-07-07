-- Modifique-o para usar WHILE. Chame a procedure de SOMA_VENDAS_CURSOR_WHILE.

create or replace PROCEDURE SOMA_VENDAS_CURSOR_WHILE
(p_VENDA_LIMITE IN produto_venda_exercicio.valor_total%type, p_ID_RETORNO OUT produto_venda_exercicio.id%type)
IS
   v_ID produto_venda_exercicio.id%type := 1;
   v_VALOR_TOTAL produto_venda_exercicio.valor_total%type;
   v_VENDA_TOTAL produto_venda_exercicio.valor_total%type := 0;
   CURSOR cur_VENDA IS SELECT ID FROM PRODUTO_VENDA_EXERCICIO;
BEGIN
   OPEN cur_VENDA;
   FETCH cur_VENDA INTO v_ID;
   WHILE cur_VENDA%FOUND LOOP
   
      SELECT VALOR_TOTAL INTO v_VALOR_TOTAL FROM PRODUTO_VENDA_EXERCICIO WHERE ID = v_ID;
      v_VENDA_TOTAL := v_VENDA_TOTAL + v_VALOR_TOTAL;
      
      IF v_VENDA_TOTAL >= p_VENDA_LIMITE THEN
         EXIT;
      END IF;
      
   FETCH cur_VENDA INTO v_ID;
   END LOOP;
   CLOSE cur_VENDA;
   p_ID_RETORNO := v_ID;
END;


-- Código para modificar
create or replace PROCEDURE SOMA_VENDAS_CURSOR 
(p_VENDA_LIMITE IN produto_venda_exercicio.valor_total%type, p_ID_RETORNO OUT produto_venda_exercicio.id%type)
IS
   v_ID produto_venda_exercicio.id%type := 1;
   v_VALOR_TOTAL produto_venda_exercicio.valor_total%type;
   v_VENDA_TOTAL produto_venda_exercicio.valor_total%type := 0;
   CURSOR cur_VENDA IS SELECT ID FROM PRODUTO_VENDA_EXERCICIO;
BEGIN
   OPEN cur_VENDA;
   LOOP
      FETCH cur_VENDA INTO v_ID;
      SELECT VALOR_TOTAL INTO v_VALOR_TOTAL FROM PRODUTO_VENDA_EXERCICIO WHERE ID = v_ID;
      v_VENDA_TOTAL := v_VENDA_TOTAL + v_VALOR_TOTAL;
      IF v_VENDA_TOTAL >= p_VENDA_LIMITE THEN
         EXIT;
      END IF;
   EXIT WHEN cur_VENDA%NOTFOUND;
   END LOOP;
   CLOSE cur_VENDA;
   p_ID_RETORNO := v_ID;
END;