-- Loop2
-- Podemos criar um Loop com uma condição de COUNT, pois quando adicionaremos um cliente, 
-- ele contará até o ultimo cliente que existe na tabela

SELECT * FROM CLIENTE ORDER BY 1;

SELECT COUNT(*) FROM CLIENTE WHERE ID = 1;

EXECUTE INCLUIR_CLIENTE(12, 'FARMACIA POPULAR', '29477584921',2,100000);

SET SERVEROUTPUT ON;

DECLARE
    v_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 3;
    v_ID CLIENTE.ID%TYPE := 1;
    v_ID_EXISTS INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_ID_EXISTS FROM CLIENTE;
    LOOP
        ALTERA_SEGMERCADO(v_ID, v_SEGMERCADO);
        v_ID := v_ID + 1;
        EXIT WHEN v_ID > v_ID_EXISTS;
    END LOOP;
END;
    
