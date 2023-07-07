-- For com Cursor
-- Quando utilizamos o For não precisamos declarar explicitamente o CURSOR

DECLARE
    v_SEGMERCADO CLIENTE.SEGMERCADO_ID%type := 1;
    v_ID CLIENTE.ID%type;
BEGIN
   FOR C IN (SELECT ID FROM CLIENTE) LOOP -- O Cursor será o "C", porém foi declarado implicitamente
   v_ID := C.ID;
    ALTERA_SEGMERCADO(v_ID, v_SEGMERCADO);
   END LOOP;
END;

SELECT * FROM CLIENTE ORDER BY 1;

SET SERVEROUTPUT ON;
DECLARE
v_ID CLIENTE.ID%TYPE;
v_RAZAO CLIENTE.RAZAO_SOCIAL%TYPE;
BEGIN
    FOR C IN (SELECT ID, RAZAO_SOCIAL FROM CLIENTE ORDER BY 1) LOOP
        v_ID := C.ID;
        v_RAZAO := C.RAZAO_SOCIAL;
        DBMS_OUTPUT.PUT_LINE(v_ID || ' ' || v_RAZAO);
    END LOOP;
END;