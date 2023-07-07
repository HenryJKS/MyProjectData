/* Construa uma procedure em PL/SQL que, dado um valor de N, 
temos o valor da sequência de Fibonacci nessa posição, usando obrigatoriamente LOOP ... END LOOP.*/

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE NUMEROS_FIBONACCI (p_INTERACOES IN FLOAT, p_NUMEROFIBO OUT FLOAT)
IS
   v_FIBO1 FLOAT := 0;
   v_FIBO2 FLOAT := 1;
   v_FIBO_ATUAL FLOAT := 0;
   v_CONTADOR FLOAT := 1;
   v_INTERACOES FLOAT := 1;
BEGIN
   IF p_INTERACOES > 1 THEN
      LOOP
         v_FIBO_ATUAL := v_FIBO1 + v_FIBO2;
         v_FIBO1 := v_FIBO2;
         v_FIBO2 := v_FIBO_ATUAL;
         v_CONTADOR := v_CONTADOR + 1;
      EXIT WHEN v_CONTADOR >= p_INTERACOES;
      END LOOP;
   END IF;
   p_NUMEROFIBO := v_FIBO_ATUAL;
END;

SET SERVEROUTPUT ON;
DECLARE
   v_FIBO INTEGER;
BEGIN
   NUMEROS_FIBONACCI(45, v_FIBO);
   dbms_output.put_line(v_FIBO);
END;