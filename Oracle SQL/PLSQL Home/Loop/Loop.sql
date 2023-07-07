-- Loop
-- Usamos Loop para poder incrementar um valor em uma variavel
SELECT * FROM CLIENTE ORDER BY 1;

DECLARE
    v_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 3;
    v_ID CLIENTE.ID%TYPE := 1;
BEGIN
    LOOP 
     ALTERA_SEGMERCADO(v_ID, v_SEGMERCADO);
     v_ID := v_ID + 1;
    EXIT WHEN v_ID > 9;
    END LOOP;
END;
    

