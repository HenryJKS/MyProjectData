-- Introdu��o

SET SERVEROUTPUT ON;

-- FORMATO DA ESTRUTURA PL/SQL
DECLARE
    v_ID NUMBER(5) := 5;
BEGIN

    -- Exibir o conte�do
    DBMS_OUTPUT.put_line(v_ID);
    
    -- Mudando valor da var�avel
    v_ID := 1;
    DBMS_OUTPUT.put_line(v_ID);
END;
